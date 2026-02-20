import numpy as np
import torch
import torch.nn as nn
import torchvision.transforms as transforms
from PIL import Image
import matplotlib.pyplot as plt
from IPython.display import display

# Step 1: Load and preprocess the image
image = Image.open("chest1.png").convert("L").resize((256, 256))
tensor_image = transforms.ToTensor()(image).unsqueeze(0)  # Shape: [1, 1, 256, 256]

# Step 2: Define CNN (KeyNet) for generating the confusion map
class KeyNet(nn.Module):
    def __init__(self):
        super(KeyNet, self).__init__()
        self.model = nn.Sequential(
            nn.Conv2d(1, 8, kernel_size=3, padding=1),
            nn.ReLU(),
            nn.Conv2d(8, 1, kernel_size=3, padding=1),
            nn.Sigmoid()
        )

    def forward(self, x):
        return self.model(x)

net = KeyNet()
with torch.no_grad():
    confusion_map = net(tensor_image).squeeze().numpy()  # Shape: [256, 256]

# Step 3: Permute pixels using confusion map
image_array = np.array(image)
flat_image = image_array.flatten()
flat_confusion = confusion_map.flatten()
permutation_indices = np.argsort(flat_confusion)
inverse_permutation = np.argsort(permutation_indices)
scrambled_confused = flat_image[permutation_indices].reshape(256, 256)

# Step 4: King's move scrambling with reversible shuffling
def king_moves(x, y, size):
    directions = [(-1, -1), (-1, 0), (-1, 1),
                  (0, -1),          (0, 1),
                  (1, -1), (1, 0),  (1, 1)]
    for dx, dy in directions:
        nx, ny = x + dx, y + dy
        if 0 <= nx < size and 0 <= ny < size:
            yield nx, ny

def king_path(size):
    visited = np.zeros((size, size), dtype=bool)
    path = []
    x, y = 0, 0
    path.append((x, y))
    visited[x, y] = True
    for _ in range(size * size - 1):
        for nx, ny in king_moves(x, y, size):
            if not visited[nx, ny]:
                path.append((nx, ny))
                visited[nx, ny] = True
                x, y = nx, ny
                break
    return path

path = king_path(256)

def apply_king_scramble(image, path):
    scrambled = image.copy()
    values = image.copy()[tuple(zip(*path))]
    shuffled_indices = np.random.permutation(len(values))
    shuffled_values = values[shuffled_indices]
    for i, (x, y) in enumerate(path):
        scrambled[x, y] = shuffled_values[i]
    return scrambled, shuffled_indices

scrambled_king, shuffled_indices = apply_king_scramble(scrambled_confused, path)

# Step 5: XOR diffusion using logistic chaotic map
def logistic_map(x, r=3.99, size=65536):
    seq = []
    for _ in range(size):
        x = r * x * (1 - x)
        seq.append(int(x * 256) % 256)
    return np.array(seq, dtype=np.uint8)

chaos_seq = logistic_map(0.5, size=256*256).reshape(256, 256)
diffused = np.bitwise_xor(scrambled_king, chaos_seq)

# Step 6: Final XOR diffusion using Piecewise Linear Chaotic Map (PWLCM)
def pwlcm_map(x0, p=0.4, size=65536):
    x = x0
    seq = []
    for _ in range(size):
        if x < p:
            x = x / p
        else:
            x = (1 - x) / (1 - p)
        seq.append(int(x * 256) % 256)
    return np.array(seq, dtype=np.uint8)

final_chaos_seq = pwlcm_map(0.37, p=0.4, size=256*256).reshape(256, 256)
final_cipher = np.bitwise_xor(diffused, final_chaos_seq)

# Save encrypted image
encrypted_img = Image.fromarray(final_cipher)
encrypted_img.save("encrypted_image.png")

# --------------------------- DECRYPTION ---------------------------

# Step 1: Undo final XOR (PWLCM)
undo_final_xor = np.bitwise_xor(final_cipher, final_chaos_seq)

# Step 2: Undo logistic XOR
xor_decrypted = np.bitwise_xor(undo_final_xor, chaos_seq)

# Step 3: Undo King's scrambling
def undo_king_scramble(image, path, shuffled_indices):
    unscrambled = image.copy()
    scrambled_values = image[tuple(zip(*path))]
    original_values = np.empty_like(scrambled_values)
    original_values[shuffled_indices] = scrambled_values
    for i, (x, y) in enumerate(path):
        unscrambled[x, y] = original_values[i]
    return unscrambled

king_unscrambled = undo_king_scramble(xor_decrypted, path, shuffled_indices)

# Step 4: Undo permutation
flat_scrambled = king_unscrambled.flatten()
recovered_image = flat_scrambled[inverse_permutation].reshape(256, 256)

# Save decrypted image
decrypted_img = Image.fromarray(recovered_image.astype(np.uint8))
decrypted_img.save("decrypted_image.png")

# Optional: Display results in Google Colab
print("Encrypted Image:")
display(encrypted_img)
print("Decrypted Image:")
display(decrypted_img)
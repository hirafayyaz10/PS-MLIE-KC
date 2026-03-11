# PS-MLIE-KC: A Plaintext-Sensitive Multi-Layered Image Encryption Framework for Medical Images Using King’s Random Walk, Deep Learning, and Chaotic Maps

This repository contains the official implementation of **PS-MLIE-KC**, a robust encryption framework designed for medical imagery. The system integrates deep learning-based confusion, King’s Random Walk spatial scrambling, and dual chaotic maps to ensure high sensitivity to plaintext and resistance against cryptographic attacks.

## 📖 Description
Ensuring the confidentiality of medical images (MRI, CT, X-rays) is a critical challenge in modern healthcare. **PS-MLIE-KC** addresses this using a multi-layered approach:
* **Plaintext Sensitivity:** Uses average intensity to ensure even a 1-pixel change in the original image results in a completely different ciphertext.
* **KeyNet (CNN):** A custom deep learning model that generates a content-adaptive confusion map for pixel-level permutation.
* **King’s Random Walk:** A novel spatial scrambling technique inspired by chess piece movements.
* **Chaotic Diffusion:** Employs Logistic and Piecewise Linear Chaotic Maps (PWLCM) for XOR-based diffusion.

## 📁 Dataset Information
The repository includes sample medical images used for research validation:
* **Categories:** Brain, Chest, Heart, and Kidney scans.
* **Format:** Square images (e.g., 256x256) used for diagnostic testing.
  
The images utilized for experimentation were obtained from multiple publicly available datasets available on Kaggle.
[Dataset 1](https://www.kaggle.com/code/kmader/training-u-net-on-tb-images-to-segment-lungs/input)
[Dataset 2](https://www.kaggle.com/code/atifaliak/kidneyvision/input)
[Dataset 3](https://www.kaggle.com/datasets/nikhilroxtomar/ct-heart-segmentation/data)
[Dataset 4](https://www.kaggle.com/datasets/saeedehkamjoo/standard-test-images)

## 💻 Code Information
The framework is a hybrid implementation:
* **Python (`.py`):** Core encryption/decryption pipeline and the KeyNet architecture.
* **MATLAB (`.m`):** Comprehensive security and statistical analysis (NPCR, UACI, Correlation, Histogram, PSNR, MAE).

## 🛠 Requirements
### Python
* Python 3.8+
* TensorFlow/Keras, NumPy, OpenCV (`cv2`), Matplotlib
### MATLAB
* MATLAB R2021a+ with Image Processing Toolbox

## 🚀 Usage Instructions

### 1. Encryption & Decryption (Python)
* To encrypt an image:

`python encryptionDecryption.py --input path/to/image.png --output encrypted.png`

* To decrypt the image:
  
`python encryptionDecryption.py --input encrypted.png --output decrypted.png`

## 2. Security Analysis (MATLAB)
* Open the Analysis folder in MATLAB.
* Run the analysis script:

`MATLAB
run NPCR.m`

* Run all the files to view the generated NPCR, UACI, and correlation graphs in the output window.

## 🔬 Methodology
* Preprocessing: Intensity-based seed generation.

* Confusion: KeyNet-driven pixel permutation.

* Scrambling: King's piece randomized traversal.

* Diffusion: Dual-layer XOR with chaotic maps.

## 📜 Citations
If you use this work, please cite:
PS-MLIE-KC: A Plaintext-Sensitive Multi-Layered Image Encryption Framework for Medical Images Using King’s Random Walk, Deep Learning, and Chaotic Maps.

## ⚖️ License
This project is licensed under the MIT License.

## Contribution Guidelines

Contributions to improve the efficiency of KeyNet or add new chaotic maps are welcome. Please follow these steps:

* Fork the repository.

* Create a new branch (`git checkout -b feature-improvement`).

* Commit your changes.

* Push to the branch and open a Pull Request.

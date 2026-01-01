# Fuzzy and TSK Systems for Control, Regression, and Classification

[![MATLAB](https://img.shields.io/badge/MATLAB-Fuzzy%20Logic-orange)]()
[![Fuzzy](https://img.shields.io/badge/Fuzzy-Mamdani%20%26%20TSK-blue)]()
[![Control](https://img.shields.io/badge/Control-Systems-green)]()
[![ML](https://img.shields.io/badge/Machine%20Learning-Regression%20%26%20Classification-purple)]()
[![License](https://img.shields.io/badge/License-Academic-lightgrey)]()

This repository contains a **collection of fuzzy logic and Takagi–Sugeno–Kang (TSK) modeling projects**, developed in **MATLAB / Simulink** as part of academic coursework in **control systems, fuzzy systems, regression, and classification**.

The repository is organized as **four independent projects**, each fully self-contained, reproducible, and documented.

---

## Repository Structure

```

/
├── data/
│ ├── airfoil_self_noise.dat
│ ├── epileptic_seizure_data.csv
│ ├── haberman.data
│ └── superconduct.csv
│
├── project1_dc_motor/
│ ├── src/
│ ├── figures/
│ └── README.md
│
├── project2_car_control/
│ ├── src/
│ ├── figures/
│ └── README.md
│
├── project3_regression/
│ ├── src/
│ ├── figures/
│ ├── final_figures/
│ ├── docs/
│ └── README.md
│
├── project4_classification/
│ ├── src/
│ ├── figures/
│ ├── docs/
│ └── README.md
│
└── README.md
```

---

## Projects Overview

### **Project 1 – Fuzzy PI Control of a DC Motor**
**Folder:** `project1_dc_motor/`

- Mamdani-type **Fuzzy PI Controller**
- DC motor **speed control**
- MATLAB & Simulink implementation
- Time-domain and frequency-domain analysis
- Bode diagrams and step responses

**Key topics:**
- Fuzzy control
- PI-equivalent fuzzy controllers
- Closed-loop stability and robustness

---

### **Project 2 – Fuzzy Logic Car Control with Obstacle Avoidance**
**Folder:** `project2_car_control/`

- Mamdani **Fuzzy Logic Controller (FLC)**
- 2D vehicle navigation
- Obstacle avoidance with constant speed
- Steering control via heading correction

**Key topics:**
- Rule-based fuzzy control
- Multi-input decision making
- Autonomous navigation logic

---

### **Project 3 – TSK Fuzzy Regression Models**
**Folder:** `project3_regression/`

- **Takagi–Sugeno–Kang (TSK)** fuzzy regression
- Multiple real-world datasets
- Comparison of:
  - Linear regression
  - ANFIS
  - TSK models with different rule counts
- Quantitative evaluation using:
  - MSE
  - RMSE
  - R²

**Key topics:**
- Data-driven fuzzy modeling
- Nonlinear regression
- Model comparison and validation

---

### **Project 4 – Fuzzy & Neuro-Fuzzy Classification**
**Folder:** `project4_classification/`

- Fuzzy and **ANFIS-based classifiers**
- Binary and multi-class classification problems
- Evaluation on benchmark datasets
- Performance metrics:
  - Accuracy
  - Confusion matrices
  - Error rates

**Key topics:**
- Fuzzy classification
- Neuro-fuzzy systems
- Supervised learning with fuzzy models

---

## Shared Datasets

All datasets used by **Projects 3 and 4** are stored centrally in:

data/

This avoids duplication and ensures consistency across experiments.

---

## How to Use

1. Clone the repository:
   ```bash
   git clone https://github.com/<your-username>/fuzzy-tsk-modeling.git

2. Open MATLAB.

3. Navigate to the desired project folder:

`cd projectX_...`

4. Follow the instructions in the project-specific README.md.

Each project can be executed independently.

## Requirements

- MATLAB
- Fuzzy Logic Toolbox
- Control System Toolbox
- Simulink (for control projects)
- Statistics and Machine Learning Toolbox (for regression/classification)

## Notes

- Each figures/ directory is documentation-only
- Only files under src/ are required to reproduce simulations
- All experiments are deterministic and fully reproducible
- No proprietary or hidden dependencies are used

## Author

Ilias Korompilis

## License

Academic and educational use only.

# Fuzzy TSK Modeling – Project 4: Classification
## Haberman & Epileptic Seizure Datasets

[![MATLAB](https://img.shields.io/badge/MATLAB-R2020a-blue.svg)]()
[![Fuzzy Logic](https://img.shields.io/badge/Fuzzy--TSK-Modeling-orange.svg)]()
[![ANFIS](https://img.shields.io/badge/ANFIS-Training-red.svg)]()
[![Dataset](https://img.shields.io/badge/Dataset-Haberman%20%2B%20Epileptic-success.svg)]()

This repository contains **Project 4** of a fuzzy TSK modeling series, focused on **classification** using MATLAB and ANFIS.

Two datasets are used:

- **Haberman Cancer Survival Dataset** (binary classification)
- **Epileptic Seizure Recognition Dataset (subset)** (multi-class, highly imbalanced)

The project includes:

- TSK fuzzy classifiers
- Grid search over clustering radii and feature subsets
- Membership function comparison
- Training curve evaluation
- Final model selection

---

## Project Structure

```
/
│── docs/
│ └── gridsearch/
│ ├── gridsearch_iter1_results.png
│ ├── gridsearch_iter2_results.png
│ └── gridsearch_iter3_results.png
│
│── figures/
│ ├── final/
│ ├── model1/
│ ├── model2/
│ ├── model3/
│ └── model4/
│
│── src/
│ ├── ClassificationA.m
│ ├── ClassificationB.m
│ ├── finalemod.m
│ ├── fisaki.m
│ ├── fisakia.m
│ └── split_scale.m
│
└── README.md
```


---

## Problem Description

The goal is to design **Takagi–Sugeno–Kang (TSK)** fuzzy models for **classification** using MATLAB’s ANFIS framework.

### Task A – Haberman Dataset

- Train four TSK models (Model 1–4)
- Different feature subsets and clustering radii
- Evaluate using:
  - Overall Accuracy (OA)
  - Producer Accuracy (PA)
  - User Accuracy (UA)
  - Cohen’s Kappa

### Task B – Epileptic Seizure Dataset

- Perform iterative grid search over clustering radius
- Compare three grid-search iterations
- Train and evaluate the final selected model

---

## Mathematical Background

### TSK Fuzzy Rule (First Order)

$$
\text{Rule}_i:\;
\text{IF } x_1 \text{ is } A_{i1}, \ldots, x_n \text{ is } A_{in}
\;\text{THEN }\;
y_i = p_{i0} + \sum_{j=1}^{n} p_{ij} x_j
$$

### Gaussian Membership Function

$$
\mu(x) = \exp\left(-\frac{(x - c)^2}{2\sigma^2}\right)
$$

### Triangular Membership Function

$$
\mu(x) =
\begin{cases}
0, & x \le a \\
\dfrac{x - a}{b - a}, & a < x \le b \\
\dfrac{c - x}{c - b}, & b < x < c \\
0, & x \ge c
\end{cases}
$$

### Classification Metrics

**Overall Accuracy**

$$
OA = \frac{\sum_i TP_i}{N}
$$

**Producer Accuracy**

$$
PA_i = \frac{TP_i}{TP_i + FN_i}
$$

**User Accuracy**

$$
UA_i = \frac{TP_i}{TP_i + FP_i}
$$

**Cohen’s Kappa**

$$
\kappa = \frac{p_o - p_e}{1 - p_e}
$$

---

## Model Evaluation – Haberman Dataset

| Model | OA | PA | UA | Kappa |
|------|----|----|----|--------|
| Model 1 | 0.735 | 0.71 | 0.72 | 0.41 |
| Model 2 | 0.748 | 0.73 | 0.74 | 0.45 |
| Model 3 | 0.762 | 0.75 | 0.77 | 0.49 |
| **Model 4** | **0.781** | **0.79** | **0.80** | **0.52** |

Model 4 achieves the best overall performance.

---

## Epileptic Dataset – Grid Search Results

| Iteration | Best Radius | Best OA | Best Kappa |
|----------|-------------|---------|------------|
| Iteration 1 | 0.15 | 0.745 | 0.52 |
| Iteration 2 | 0.85 | 0.772 | 0.58 |
| **Iteration 3** | **0.65** | **0.789** | **0.61** |

The final model is selected from **Iteration 3**.

---

## Final Epileptic Seizure Model – Metrics

| Metric | Value |
|-------|-------|
| Overall Accuracy | 0.789 |
| Producer Accuracy | 0.81 |
| User Accuracy | 0.79 |
| Kappa | 0.61 |

---

## How to Run

```matlab
% Task A – Haberman
ClassificationA;

% Task B – Grid Search
ClassificationB;

% Final model training and evaluation
finalemod;

### Reproducibility Notes

- Membership function plots are stored under figures/modelX/

- Final model visualizations are stored under figures/final/

- Grid search results are stored under docs/gridsearch/

- Requires MATLAB with Fuzzy Logic Toolbox only

## License

This project was developed as part of academic coursework.

Code may be reused for educational purposes with proper attribution.


© 2025 Ilias Korompilis

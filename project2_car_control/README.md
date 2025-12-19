# Fuzzy Logic Car Control with Obstacle Avoidance
## Project 2 – Mamdani Fuzzy Controller

[![MATLAB](https://img.shields.io/badge/MATLAB-Fuzzy%20Logic-orange)]()
[![Fuzzy](https://img.shields.io/badge/Fuzzy-Mamdani-blue)]()
[![Control](https://img.shields.io/badge/Control-Obstacle%20Avoidance-green)]()
[![License](https://img.shields.io/badge/License-Academic-lightgrey)]()

This project implements a **Mamdani Fuzzy Logic Controller (FLC)** for vehicle motion control in a 2D environment with **obstacle avoidance**.

The vehicle moves with **constant speed** and dynamically adjusts its heading in order to:

- Avoid obstacles  
- Track a desired target position  
- Minimize vertical-axis deviation  

---

## System Overview

The fuzzy controller is designed with **three inputs** and **one output**.

### Inputs

- **dH**: Horizontal distance from obstacles, normalized to \([0,1]\)  
- **dV**: Vertical distance from obstacles, normalized to \([0,1]\)  
- **θ**: Vehicle heading angle in degrees, \([-180^\circ, 180^\circ]\)  

### Output

- **Δθ**: Change in heading angle (steering command)

---

## Fuzzy Inference System

- **FIS Type**: Mamdani  
- **Inference Method**: Min–Max  
- **Defuzzification**: Center of Area (COA)  
- **Membership Functions**: Triangular (`trimf`)  

---

## Membership Functions

All fuzzy sets are **triangular**.

### Linguistic Labels

#### For dH, dV

- VS (Very Small)  
- S  (Small)  
- M  (Medium)  
- L  (Large)  
- VL (Very Large)  

#### For θ, Δθ

- NL (Negative Large)  
- NS (Negative Small)  
- ZE (Zero)  
- PS (Positive Small)  
- PL (Positive Large)  

Membership function plots are stored under:

figures/membership_functions/

---

## Rule Base

The rule base consists of **5 × 5 × 5 rules**, combining:

- Horizontal distance (**dH**)  
- Vertical distance (**dV**)  
- Heading angle (**θ**)  

### General Rule Form

$$
\text{IF } d_H \in A \;\land\; d_V \in B \;\land\; \theta \in C
\;\Rightarrow\;
\Delta\theta \in Q
$$

Separate rule matrices are defined for each heading region:

- θ = NL  
- θ = NS  
- θ = ZE  
- θ = PS  
- θ = PL  

Rule tables are stored under:

`figures/rules/`

---

## Vehicle Motion Model

The vehicle moves with constant speed \( u \).

### Position Update

$$
x_{t+1} = x_t + u \cdot \cos(\theta_t)
$$

$$
y_{t+1} = y_t + u \cdot \sin(\theta_t)
$$

### Heading Update

The fuzzy controller computes the heading correction:

$$
\Delta \theta_t = \text{evalfis}([d_H, d_V, \theta_t], \text{FLC})
$$

$$
\theta_{t+1} = \theta_t + \Delta \theta_t
$$

### Angle Saturation

$$
\theta \in [-180^\circ, 180^\circ]
$$

---

## Simulation Scenarios

Three simulations are performed using different initial headings:

- \(0^\circ\)  
- \(-45^\circ\)  
- \(-90^\circ\)  

Each simulation produces:

- Vehicle trajectory  
- Obstacle boundaries  
- Final tracking error  

Results are stored under:

`figures/system/`

---

## Project Structure

```
src/
│ ├── main.m % Simulation loop
│ ├── FLC.m % Fuzzy Logic Controller
│ ├── oxima.m % Vehicle class
│ └── thesi.m % Position class
│
├── figures/
│ ├── membership_functions/
│ ├── rules/
│ └── system/
│
└── README.md
```

---

## How to Run

1. Open MATLAB  
2. Navigate to the `src/` directory  
3. Run:

```matlab
main

All figures are generated and saved automatically.

## Notes

- The controller supports baseline and enhanced tuning via internal parameters

- Sensor saturation is applied for numerical stability

- The control strategy prioritizes smooth obstacle avoidance over aggressive steering

## Author


Ilias Korompilis

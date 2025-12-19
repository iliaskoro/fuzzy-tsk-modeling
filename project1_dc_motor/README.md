# Fuzzy PI Control of a DC Motor (Mamdani FLC)

This repository contains the complete implementation, simulation, and analysis of a **Fuzzy PI Controller** for **DC motor speed control**, developed in **MATLAB/Simulink** using a **Mamdani-type Fuzzy Logic Controller (FLC)**.

The project was implemented in the context of an academic control-systems assignment and includes:
- FIS design (membership functions & rule base)
- Simulink implementation of the closed-loop system
- Time-domain and frequency-domain analysis
- Fully reproducible MATLAB scripts

---

## Project Structure

```
/
├── src/
│ ├── dc.fis
│ ├── flc.mdl
│ ├── flc1.m
│ └── plots.m
│
├── figures/
│ ├── bode_diagrams/
│ │ ├── Bode(HVc).png
│ │ └── Bode(HTc).png
│ │
│ ├── bode_editor/
│ ├── membership_functions/
│ │ ├── e.png
│ │ ├── de.png
│ │ └── du.png
│ │
│ ├── rules/
│ │ └── rules.png
│ │
│ ├── step_responses/
│ │ ├── step_original.png
│ │ └── step_fuzzy.png
│ │
│ └── system/
│ └── scheme.png
│
└── README.md
```

---

## Control System Overview

- **Plant**: DC motor (linear transfer function)
- **Controller**: Fuzzy PI Controller
- **FIS type**: Mamdani
- **Inputs**:
  - `e`  : normalized speed error
  - `de` : normalized derivative of error
- **Output**:
  - `du` : incremental control action
- **Defuzzification**: Centroid
- **Inference**:
  - AND: min  
  - OR: max  
  - Implication: min  
  - Aggregation: max  

---

## Fuzzy Logic Controller Design

### Membership Functions

- Inputs `e` and `de`: **9 triangular membership functions**
  - `NV, NL, NM, NS, ZR, PS, PM, PL, PV`
- Output `du`: **7 triangular membership functions**
  - `NL, NM, NS, ZR, PS, PM, PL`

All membership functions are defined in the normalized range **[-1, 1]**.

---

### Rule Base

- **81 fuzzy rules** (9×9)
- Symmetric and monotonic structure
- Designed to emulate a **PI-like control behavior**
- Full rule base is stored in:
  - `dc.fis`
  - `flc1.m` (programmatic generation)

Example rule form:

IF e is NM AND de is PS
THEN du is ZR

---

## Simulink Implementation

- The Fuzzy PI Controller is implemented as a **subsystem**
- Includes:
  - Input normalization
  - Error derivative computation
  - Fuzzy inference (`dc.fis`)
  - Denormalization
  - Discrete integration (PI behavior)
- Sampling handled via **Zero-Order Hold**
- Step input used for reference tracking

Main model file:

`src/flc.mdl`

---

## MATLAB Scripts

### `flc1.m`

- Builds the fuzzy system **from scratch**
- Defines:
  - Inputs / outputs
  - Membership functions
  - Full rule base
- Exports final FIS to `dc.fis`

### `plots.m`

Generates:
- Step response of the closed-loop system
- Rise time, overshoot, peak value
- Bode diagrams:
  - Closed-loop transfer `HVc`
  - Disturbance transfer `HTc`
- Membership function plots for:
  - `e`
  - `de`
  - `du`

---

## Results Summary

- **Zero overshoot**
- **Fast rise time**
- **Smooth steady-state response**
- Robust frequency-domain behavior
- Clear improvement over baseline system

Key plots are available under:

`figures/step_responses/`

`figures/bode_diagrams/`

---

## Requirements

- MATLAB
- Simulink
- Fuzzy Logic Toolbox
- Control System Toolbox

---

## Author

**Ilias Korompilis** 

---

## Notes

- The `figures/` directory is **documentation-only** (used for reports & README)
- Only files in `src/` are required to reproduce simulations
- All parameters are explicitly defined — no hidden dependencies

---

## License

Academic / Educational use only.




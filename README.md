# Informing Combinatorial Exploration of Compositionally Complex Alloys

This repository documents an integrated workflow that combines computational thermodynamics, solid-solution strengthening (SSS), and multitask machine learning to explore compositionally complex alloys (CCAs). The codebase is organized into submodules that cover precomputed alloy-property data and the downstream ML workflow.

- CALPHAD phase-stability and solid-solution-strengthening (SSS) calculations
- multitask ML for hardness and corrosion prediction

<img src="Fig_1_workflow.png" width="1000">

## Repository Layout

- `./v6_A-B-C-D-E_Sputtering`: [CALPHAD and SSS workflow](https://github.com/YXWU2014/combinatorial_mixing.git) submodule for permutative combinatorial mixed compositions
- `./CCA_representation_ML`: [ML workflow](https://github.com/YXWU2014/CCA_representation_ML.git) submodule for hardness and corrosion model training, evaluation, prediction, and explainability
- `./v6_A-B-C-D-E_Sputtering_ML`: precomputed CALPHAD/SSS structure-property results for 55 alloy families and 455,400 alloy compositions
- `v6_A_B_C_D_E_Gmin_FullEquil_SputterCompo_master.m`: root entrypoint for phase-stability generation
- `v6_A_B_C_D_E_SSS_SputterCompo_master.m`: root entrypoint for SSS generation
- `SputteringCompoMapNormalised.dat`: composition-grid input used by the MATLAB stages

## Getting Started

### Tested Dependencies and Pip Installation

- Python 3.9.16
- Key libraries listed in `requirements.txt`
- For customized classes and functions, see `./CCA_representation_ML/utils`
- Install dependencies using pip with a Python 3.9.16 environment:

```bash
python -m pip install --upgrade pip setuptools wheel
pip install -r requirements.txt
```


### How to use the repo

Clone the repository:

```bash
git clone https://github.com/YXWU2014/CCA_CALPHAD_SSS_ML.git
cd CCA_CALPHAD_SSS_ML
```

Initialize and fetch the submodules:

```bash
git submodule update --init --recursive
git checkout main
```

### MATLAB / Thermo-Calc requirements for the CALPHAD stage

The MATLAB entry scripts invoke Thermo-Calc toolbox functions, so a full CALPHAD rerun requires MATLAB, a working Thermo-Calc setup with the `tc_*` MATLAB interface enabled, access to the `TCHEA4` database, and the local helper library expected by the scripts. If those dependencies are unavailable, the ML stage can still be run against the precomputed data already stored in `v6_A-B-C-D-E_Sputtering_ML/`.

## Run This Repo

### Stage 1: CALPHAD phase stability

This stage is handled in the [`v6_A-B-C-D-E_Sputtering`](https://github.com/YXWU2014/combinatorial_mixing.git) submodule. Run `v6_A_B_C_D_E_Gmin_FullEquil_SputterCompo_master.m` from the repository root in MATLAB. This stage uses `SputteringCompoMapNormalised.dat` to enumerate five-element permutations, compute minimum-G and full-equilibrium phase information, and generate phase-stability figures and summary outputs.

### Stage 2: solid-solution strengthening

This stage is also handled in the [`v6_A-B-C-D-E_Sputtering`](https://github.com/YXWU2014/combinatorial_mixing.git) submodule. Run `v6_A_B_C_D_E_SSS_SputterCompo_master.m` from the repository root in MATLAB. This stage reuses the same sputtering composition grid, computes effective elastic and misfit quantities for FCC compositions, and exports strengthening tables and plots for each permutation.

### Stage 3: computed-data handoff to ML

The ML workflow consumes the computed permutation-composition results generated upstream from the [`v6_A-B-C-D-E_Sputtering`](https://github.com/YXWU2014/combinatorial_mixing.git) submodule and assembled under `v6_A-B-C-D-E_Sputtering_ML/v6_A-B-C-D-E_Sputtering_ML_All_Calc/`, together with the associated CALPHAD and SSS outputs.

### Stage 4: ML training, evaluation, and prediction

This stage is handled in the [`CCA_representation_ML`](https://github.com/YXWU2014/CCA_representation_ML.git) submodule. It is the point where the workflow interfaces with experimental data, combining cleaned hardness and corrosion datasets with CALPHAD/SSS-derived composition inputs in a multitask neural-network pipeline. The workflow reads curated datasets from `01_Dataset_Cleaned/`, uses the main notebooks in `03_Model_Train_Evaluate_Predict/`, and writes trained-model and prediction outputs under `04_Model_Saved/`. For more detail on the ML workflow, notebook structure, and execution steps, see the submodule documentation directly.

## Submodule Guides

- CALPHAD / SSS details: `v6_A-B-C-D-E_Sputtering/README.md`
- ML workflow details: `CCA_representation_ML/README.md`

## Acknowledgments

The authors gratefully acknowledge the support of the European Union's Horizon 2020 research and innovation programme under [Grant Agreement No. 958457](https://doi.org/10.3030/958457). The content of this publication does not reflect the official opinion of the European Union. Responsibility for the information and views expressed herein lies entirely with the authors.

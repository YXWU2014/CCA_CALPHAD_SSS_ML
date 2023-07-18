# CCA_CALPHAD_SSS_ML

need some description about this repository

the purpose of this repository are:

- Batch calculation for quinary alloys A-B-C-D-E via computational thermodynamics

  - model the phase stability under full equilibrium and minimum Gibbs energy conditions
  - model the solid solution strengthening

- Evaluate hardness and corrosion pitting potential via the multitask neural network model (as a submodule `CCA_representation_ML`)

- the composition sampling takes the represnetation of combintorial physical vapour depostion ``

## Directory structure

```bash
|-- CCA_CALPHAD_SSS_ML
    |-- CCA_representation_ML
    |-- ...

|-- v6_Fe_Cr_Ni_Al_Si_Sputtering
|-- v6_Fe_Cr_Ni_Al_Ta_Sputtering
|-- ...

```

`CCA_representation_ML`: the machine learning submodule maintained in a different repository

## Pull the repositories `CCA_CALPHAD_SSS_ML` and its submodule `CCA_representation_ML`

```bash
|-- CCA_CALPHAD_SSS_ML
    |-- CCA_representation_ML
    |-- ...
```

**Pull the repository to the local folder**

```bash
git clone https://github.com/YXWU2014/CCA_CALPHAD_SSS_ML.git
cd CCA_CALPHAD_SSS_ML
```

**Add the submodule**

```bash
git submodule add https://github.com/YXWU2014/CCA_representation_ML.git
```

**Initialise and fetch the submodule**

```bash 
git submodule update --init --recursive
git checkout main
```

<!-- **Commit and push local changes to GitHub**

```bash
cd CCA_CALPHAD_SSS_ML
cd CCA_representation_ML
git add -A
git commit -m "update"
git push origin main
```

```bash
cd ..
git add  -A
git commit -m "Updated submodule"
git push origin main
```

**Pull the latest repository to the local folder (point to `main` branch)**

```bash
cd CCA_CALPHAD_SSS_ML
```

```bash
git pull origin main

cd CCA_representation_ML
git checkout main
git pull origin main
cd ..
``` -->

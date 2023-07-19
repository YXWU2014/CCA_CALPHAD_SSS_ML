# CCA_CALPHAD_SSS_ML

the purpose of this repository are:

- Batch calculation for quinary alloys A-B-C-D-E via computational thermodynamics

  - model the phase stability under full equilibrium and minimum Gibbs energy conditions
  - model the solid solution strengthening

- Evaluate hardness and corrosion pitting potential via the multitask neural network model (based on a submodule `CCA_representation_ML`)

- the composition sampling takes the represnetation of combintorial physical vapour depostion `SputteringCompoMapNormalised.dat` and permutation of different mixing of neighbouring elements

The computation results can be condensed into, e.g. below plots showing the FCC alloy formation tendency under different thermdynamic evaluations (different alloy fabrication method) and the property evaluation by physical-based models to evalutate solid solution strengtehtng and also the properties computed from neural network models.

![sns_plot_30](./sns_plot_30.png)

## Citation

- Wu et al., "Harnessing representation in exploring compositional complex alloys [under review]", 2023.

## Directory structure and functionalities

```bash
|-- CCA_CALPHAD_SSS_ML

    <#### phase stability and solid solution strengthening calculation>

    |-- v6_A_B_C_D_E_Gmin_FullEquil_SputterCompo_master.m
    |-- v6_A_B_C_D_E_SSS_SputterCompo_master.m
    |-- SputteringCompoMapNormalised.dat
    |-- v6_A_B_C_D_E_Gmin_FullEquil_SputterCompo_batch.m
    |-- v6_A_B_C_D_E_SSS_SputterCompo_batch.m






    |-- v6_A-B-C-D-E_Sputtering_ML

    |-- CCA_representation_ML

    |-- sns_plot.ipynb

|-- v6_Fe_Cr_Ni_Al_Si_Sputtering
|-- v6_Fe_Cr_Ni_Al_Ta_Sputtering
|-- ...

```

#### phase stability and solid solution strengthening calculation

`v6_A_B_C_D_E_Gmin_FullEquil_SputterCompo_master.m` computes the phase stability under full equilibrium and minimum Gibbs energy, with an emphasis on obtaining FCC alloys. `v6_A_B_C_D_E_SSS_SputterCompo_master.m` computes the solid solution strengthening for the FCC phase under the same sampled compositions. The composition takes a

`CCA_representation_ML`: the machine learning submodule maintained in a different repository

`sns_plot.ipynb` to generate summary plots

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

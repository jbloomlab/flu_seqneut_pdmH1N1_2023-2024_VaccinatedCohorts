# Sequencing-based neutralization assays to determine serum neutralizing titers in vaccinated adults using a library of 58 H1N1 influenza strains circulating in late 2023 as well as recent and historical vaccine strains
This repository contains data and analysis of sequencing-based neutralization assays using a library of 66 H1N1 influenza viruses, including 6 recent cell-based vaccine strains (A/California/07/2009, A/Michigan/45/2015. A/Brisbane/02/2018, A/Hawaii/70/2019, A/Wisconsin/588/2019, and A/Wisconsin/67/2022) as well the recent egg-based vaccine (A/Victoria/4897/2022_IVR238), 58 strains selected to represent the diversity of circulating H1N1 strains in November 2023, and one strain similar to A/Victoria/4897/2022_IVR238 but lacking the egg-associated mutation Q223R (A/Oregon/Flu-OHSU-241140095/2023).

Experimental data included and analyzed in this repository was generated Andrea N. Loes and Rosario Araceli L. Tarabi. Library design was completed with contributions from John Huddleston. Analysis was performed by Andrea Loes and Jesse D. Bloom. We thank all additional individuals involved in collection of serum for the Penn Vaccine Cohort and DRIVE Vaccine Cohort, samples from which are analyzed in this study.

For in depth description of sequencing-based neutralization assay which was used to collect the data shown here, please see preprint by [Loes et al (2024)](https://doi.org/10.1101/2024.03.08.584176).

## Quick summary
* The list of strains included in the library are listed in CSV format in [./data/H1N1library_2023-2024_allStrains.csv](./data/H1N1library_2023-2024_allStrains.csv), and the process of library design is described in [librarydesign/README.md](librarydesign/README.md). This panel of 58 circulating H1N1 viruses was selected in the late fall of 2023, including frequently observed and recently observed haplotypes from the Nextstrain tree build from 11-22-2023.
    * The full length protein sequences of the HAs from the 58 recent strains as they are represented in the library are available in: [./librarydesign/2023-2024_H1_library_full-length_proteins_chimeric.fasta](./librarydesign/2023-2024_H1_library_full-length_proteins_chimeric_withvaccinestrains.fas). These are the chimeric HA protein sequences containing the first 20 and last 46 amino acids from A/WSN/1933 (H1N1) and the ectodomain from the recent HA strain of interest.
    * The protein sequences for the ectodomains of the HAs of the recent strains included in the library are available in: [./librarydesign/2023-2024_H1_library_protein_HA_ectodomains.fasta](./librarydesign/2023-2024_H1_library_protein_HA_ectodomains_withvaccinestrains.fas). This file shows the region of the protein sequence for each HA ectodomain which matches the HA protein sequence from the originating strain, as trimmed to be incorporated into the barcoded HA segment. The starting amino acid is HA1 position 4.
    * The HA1 sequences are available in [./librarydesign/2023-2024_H1_library_protein_HA1.fasta](./librarydesign/2023-2024_H1_library_protein_HA1_withvaccinestrains.fas). Note that HA1 position 3 is fixed to the WSN amino-acid at this site (isoleucine) rather than the leucine observed in recent circulating sequences in the final library. This was done to maintain the entire WSN packaging signal. Therefore, in this file the HA1s start at position 4.
* This library was then assayed against sera from the Penn Vaccine Cohort, conducted at the University of Pennsylvania:
    * Samples collected day 0 and day 30 post vaccination with the egg-based 2023-2024 seasonal influenza virus vaccine. The H1N1 vaccine component that season was A/Victoria/4897/2022.
    * Serum neutralizing titers measured from the University of Pennsylvania cohort are placed in [./results/aggregated_titers/titers_PennVaccineCohort.csv](results/aggregated_titers/titers_PennVaccineCohort.csv).
    * Serum neutralizing titers measured from the DRIVE Repeated Vaccination cohort are placed in [./results/aggregated_titers/titers_PennVaccineCohort.csv](results/aggregated_titers/titers_DRIVE.csv).

## Description of input data
The input data are in [./data/](data), and include:
* [./data/neut_standard_sets/](./data/neut_standard_sets/): directory containing the CSV listing the barcodes linked to the spike-in non-neutralized control RNAs. See [Loes et al. 2024](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10942427/) for more details.
* [./data/plates/](./data/plates/): directory of CSV files that maps 96-well plate well IDs to each individual serum-containing or no-serum well. See [`seqneut-pipeline` documentation on `plates`](https://github.com/jbloomlab/seqneut-pipeline/tree/87580b7425494a4b8277749f9aa220ace3fe1541?tab=readme-ov-file#plates) for more details. This directory includes both plates that were run through the entire pipeline to generate NT50s, but also plates that were used to optimize parameters for running the assay, such as pooling related plates and MOI tests. Plates are grouped in final analysis into either MOItest groups or PennVaccineCohort. The PennVaccineCohort samples are the data that was collected on serum using the optimized concentration of pooled virus library.
* [./data/viral_libraries/](./data/viral_libraries/): directory of CSV files that match 16-nucleotide barcodes to the library strain names.

## Library background and design
Information on the library design is placed in [./librarydesign/](librarydesign).

## Running the pipeline
This repository contains an analysis of the data using [seqneut-pipeline](https://github.com/jbloomlab/seqneut-pipeline).
Briefly, that pipeline is a submodule of this analysis.
The configuration for the analysis is in [config.yml](config.yml), the input data are in [./data/](data), the analysis itself is run by `snakemake` using [Snakefile](Snakefile), the results are placed in [./results/](results), and HTML rendering of results is in [./docs/](docs).

See [seqneut-pipeline](https://github.com/jbloomlab/seqneut-pipeline) for more description of how the pipeline works.
In addition to running the pipeline itself, [Snakefile](Snakefile) also contains a few extra rules that run the Jupyter notebooks in [./notebooks/](notebooks) to create some additional plots.
To run the pipeline, build the `seqneut-pipeline` conda environment in [seqneut-pipeline/environment.yml](seqneut-pipeline/environment.yml).
Then run the pipeline using:

    snakemake -j <n_jobs> --software-deployment-method conda

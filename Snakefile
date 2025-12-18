"""Top-level ``snakemake`` file that runs analysis."""

configfile: "config.yml"

include: "seqneut-pipeline/seqneut-pipeline.smk"

rule all:
    input:
        seqneut_pipeline_outputs,  # outputs from pipeline
        "results/custom_plots/titerschart_BothCohorts.html",

rule make_summary_plots:
    """Plot NT50s for all samples."""
    input:
        DRIVE_input_titers = "results/aggregated_titers/titers_DRIVE.csv",
        PENN_input_titers = "results/aggregated_titers/titers_PennVaccineCohort.csv",
        viral_strain_plot_order = "data/viral_libraries/H1N1library_2023-2024_allStrains.csv",
        metadata_csv = "data/metadata/251209_SampleMetadata_bothcohorts.csv",
    output:
        titers_html="results/custom_plots/titerschart_BothCohorts.html",
    log:
        notebook="results/custom_plots/plot_cohorttiters.ipynb",
    conda:
        "notebooks/environment.yml"
    notebook:
        "notebooks/plot_cohorttiters.ipynb"
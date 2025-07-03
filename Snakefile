"""Top-level ``snakemake`` file that runs analysis."""

configfile: "config.yml"

include: "seqneut-pipeline/seqneut-pipeline.smk"

rule all:
    input:
        seqneut_pipeline_outputs,  # outputs from pipeline
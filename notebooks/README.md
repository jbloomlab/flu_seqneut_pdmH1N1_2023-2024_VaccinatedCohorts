# notebooks README
This directory contains analysis notebook for processing titer data and plotting titers by metadata parameters. This includes the code for generating all plots seen in the paper and all tests for significance.

Running this notebook requires installation of a custom environment, provided in the environment.yml file in this directory.

Note, a single serum sample (PENN23_y1964_s006) was excluded from cohort level analysis as it appeared that the timepoints for this sample had been mixed up (i.e. titers decreased for several recent strains and vaccine strains post-vaccination). Titers for this individual pre- and post-vaccination are available in titer files. All analysis plots were run with and without this individuals sample to confirm that inclusion or exclusion did not impact the overall results or significance of any comparisons that are described.
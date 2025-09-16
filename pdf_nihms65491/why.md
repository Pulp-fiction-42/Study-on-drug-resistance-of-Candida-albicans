
   1. `accession.txt` (31 entries): This file contains the accession numbers for all the MRR1 alleles that were sequenced and deposited in GenBank as part of this study. This includes
      alleles from both the drug-susceptible parental strains and the drug-resistant strains.

   2. `metadata_verified.json` (20 entries): This file is based on the data extracted directly from the paper's text, tables, and figures (specifically Figures 3 and 4, which show MIC
      values). The criteria for extraction in Step 1 were to include only strains that were tested for antifungal susceptibility and had a drug resistance indicator.

  The parental, drug-susceptible strains (e.g., B3, 1442, DSY291, etc.) have accession numbers listed in accession.txt, but the paper does not present their specific MIC values in
  the same way it does for the resistant strains. My extraction focused only on the strains for which a clear, quantitative resistance value was provided in the context of the
  study's main findings.

  Therefore, the JSON file correctly represents the subset of strains for which complete experimental data (sequencing + drug susceptibility) was presented and relevant to the
  study's conclusion about resistance mechanisms. The accession.txt file is a more comprehensive list of all genetic material sequenced for the project.
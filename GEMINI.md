# Project Overview: Candida Albicans Data Mining

This working directory is used to mine *Candida albicans* sequencing data and drug susceptibility phenotypes from scientific literature and to construct a dataset for fine-tuning large genomic models.

The directory contains five sub-folders, each corresponding to a scientific article. The general directory hierarchy within each of these folders is as follows:

```
.
├── json/
│   ├── metadata_initial.json
│   └── metadata_verified.json
├── Original_paper_supplementary_materials/
│   ├── journal.ppat.1012497.s001.tsv
│   └── ppat.1012497.pdf
├── public_db/
│   ├── accession.tsv
│   └── sra_metadata.csv
├── science_background.md
└── workflow.md
```

### Folder and File Descriptions

*   **`json/`**: Contains metadata about the collected training data.
    *   `metadata_initial.json`: Data initially extracted from the literature by AI agents.
    *   `metadata_verified.json`: The final, manually verified dataset.
*   **`Original_paper_supplementary_materials/`**: Stores the original scientific literature (PDFs) and any related supplementary materials (e.g., TSV, XLSX files).
*   **`public_db/`**: Holds data related to the NCBI public database, such as accession lists and metadata retrieved from NCBI.
*   **`science_background.md`**: A summary of the scientific background of the source literature.
*   **`workflow.md`**: A document detailing the complete workflow, including the process of using AI agents for initial data extraction and the manual verification steps taken to produce the final `metadata_verified.json` file.

# 项目概述：白色念珠菌数据挖掘

该工作目录用于从科学文献中挖掘*白色念珠菌*的测序数据和药敏表型，并构建用于微调大型基因组模型的数据集。

该目录包含五个子文件夹，每个子文件夹对应一篇科学文章。每个文件夹内的一般目录层次结构如下：

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

### 文件夹和文件说明

*   **`json/`**: 包含收集的训练数据的元数据。
    *   `metadata_initial.json`: 由AI代理从文献中初步提取的数据。
    *   `metadata_verified.json`: 最终经过手动验证的数据集。
*   **`Original_paper_supplementary_materials/`**: 存储原始科学文献（PDF）及任何相关的补充材料（例如，TSV，XLSX文件）。
*   **`public_db/`**: 保存与NCBI公共数据库相关的数据，例如登录号列表和从NCBI检索的元数据。
*   **`science_background.md`**: 源文献的科学背景摘要。
*   **`workflow.md`**: 详细说明完整工作流程的文档，包括使用AI代理进行初始数据提取的过程以及为生成最终的`metadata_verified.json`文件而采取的手动验证步骤。

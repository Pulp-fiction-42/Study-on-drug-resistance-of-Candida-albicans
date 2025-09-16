
# 元数据提取与验证工作流程文档

### 引言
本文档旨在详细记录从科研论文（*Mutations in the multidrug resistance regulator MRR1, followed by loss of heterozygosity, are the main cause of MDR1 overexpression in fluconazole-resistant Candida albicans strains*）中提取、验证和总结白色念珠菌（*Candida albicans*）菌株元数据的完整流程。

---

### 第一步：从PDF初步提取元数据
- **任务：** 识别并提取所有满足以下两个条件的白色念珠菌菌株的元数据：
  1. 基因组测序数据已公开发布至NCBI数据库。
  2. 菌株已经过抗真菌药物敏感性测试，并有明确的耐药指标。
- **提取字段：**
  - 参考文献标识符
  - 菌株唯一编号
  - NCBI登录号
  - 菌株来源
  - 地理位置
  - 收集日期
  - 测序方法
  - 抗真菌药敏试验用药
  - 耐药指标类型
  - 耐药值
  - 药敏标准
  - 试验方法
  - 培养条件
- **输出：** 一个名为 `metadata_initial.json` 的文件，其中包含所有初步提取的数据。

---

### 第二步：从NCBI智能获取元数据
- **描述：** 利用 `accession.txt` 文件中提供的NCBI登录号列表，从NCBI数据库中获取官方发布的元数据。
- **工具：** 使用NCBI Entrez Direct命令行工具集中的 `efetch` 命令。
- **任务：** 以 `accession.txt` 作为输入，从 `nuccore` 数据库中批量获取每个登录号对应的完整GenBank格式记录。
- **输出：** 所有获取的GenBank记录被合并并保存到 `ncbi_metadata.gb` 文件中，作为后续验证的权威数据源。

---

### 第三步：规划验证方案
- **核心内容：**
  - **菌株数量验证：** 设计策略以确认 `metadata_initial.json` 和 `ncbi_metadata.gb` 文件中的菌株记录总数是否一致。
  - **内容一致性验证：** 制定逐字段的比对计划，用于核对两个数据源中相同菌株的元数据（菌株编号、参考文献ID、来源等）是否一致。

---

### 第四步：执行验证并更新JSON文件（流程核心）
- **描述：** 此步骤是整个工作流程的核心，通过将人工提取的数据与NCBI的权威数据元信息进行交叉比对
- **交叉引用与验证流程：**
  1. **数据解析：** 系统自动解析 `metadata_initial.json` 的JSON结构和 `ncbi_metadata.gb` 文件中每个条目的GenBank记录。
  2. **逐条比对：** 以 `metadata_initial.json` 中的每一条记录为基础，使用其 "NCBI登录号" 在 `ncbi_metadata.gb` 中查找到对应的权威记录。
  3. **字段验证与修正详情：**
      - **参考文献标识符：** 将 `metadata_initial.json` 中提取的DOI和PubMed ID与GenBank记录中 `REFERENCE` 部分的 `PUBMED` 字段进行核对。验证后发现信息一致，因此将该字段统一并简化为更精确的 `PubMed ID: 18547333`，确保了数据来源的单一性和准确性。
      - **菌株唯一编号：** 将 `metadata_initial.json` 中的 "菌株唯一编号" (例如 "B4", "2271") 与GenBank记录源部分的 `/strain` 或 `/isolate` 字段进行比对。在此次验证中，所有菌株的编号均完全一致，这有力地确认了菌株身份的准确性。
      - **补充与确认信息：** 检查GenBank记录中是否存在 `metadata_initial.json` 中标记为 "未指定" 的信息（如 `/country`, `/collection_date`）。在此案例中，NCBI记录同样未提供这些信息，因此保留 "未指定" 状态。
  4. **数据合并原则：**
      - **权威性原则：** 当两个数据源信息冲突时，以NCBI GenBank的记录为最终标准。
      - **完整性原则：** 保留从PDF中提取的、而NCBI记录中没有的独特信息。这主要包括所有与抗真菌药敏试验相关的字段（药物名称、MIC值、测试方法、培养条件等），因为这些实验数据通常不会包含在序列本身的GenBank记录中。
- **输出：** 生成 `metadata_verified.json` 文件。该文件中的数据经过了上述流程的严格验证和合并，达到了高质量、可信赖的标准。

---

### 第五步：创建科学背景总结
- **输出：** 生成 `science_background.md` 文件，为数据使用者提供必要的科学语境。

---

### ⚠️:entry of final json file 不等于 accession.txt
- **具体原因：** 参照:`why.md`

#!/bin/bash

OUTPUT_FILE="metadata_initial.json"
INPUT_FILE="spectrum.03807-22-s0002.tsv"
DOI="10.1128/spectrum.03807-22"

awk -F'\t' -v doi="$DOI" '
BEGIN {
    print "["
    first = 1
}
# Only process lines that start with known strain prefixes to avoid headers
($1 ~ /^F[0-9]/ || $1 ~ /^CEC/ || $1 ~ /^SC/) {
    if ($4 == "- / -") {
        next
    }

    if (!first) {
        printf ",\n"
    }
    first = 0

    printf "    {\n"
    printf "        \"参考标识符\": \"%s\",\n", doi
    printf "        \"菌株唯一编号\": \"%s\",\n", $1
    printf "        \"NCBI登录号\": \"\",\n"
    printf "        \"菌株来源\": \"%s\",\n", $23
    printf "        \"地理位置\": \"%s\",\n", $22
    printf "        \"收集日期\": \"\",\n"
    printf "        \"测序方法\": \"\",\n"

    drug_names[0] = "Fluconazole"; drug_cols[0] = 4
    drug_names[1] = "Voriconazole"; drug_cols[1] = 5
    drug_names[2] = "Itraconazole"; drug_cols[2] = 6
    drug_names[3] = "Posaconazole"; drug_cols[3] = 7
    drug_names[4] = "Caspofungin"; drug_cols[4] = 8
    drug_names[5] = "Micafungin"; drug_cols[5] = 9
    drug_names[6] = "Anidulafungin"; drug_cols[6] = 10
    drug_names[7] = "5-Flucytosine"; drug_cols[7] = 11
    drug_names[8] = "Amphotericin B"; drug_cols[8] = 12

    drug_list = ""
    value_list = ""
    
    for (i = 0; i < 9; i++) {
        col_idx = drug_cols[i]
        if ($(col_idx) != "- / -") {
            split($(col_idx), arr, "/")
            if (drug_list != "") {
                drug_list = drug_list ","
                value_list = value_list ","
            }
            drug_list = drug_list "\"" drug_names[i] "\""
            value_list = value_list "\"" arr[1] "\""
        }
    }

    printf "        \"抗真菌药敏试验中的药物\": [%s],\n", drug_list
    printf "        \"药敏指标类型\": \"MIC\",\n"
    printf "        \"耐药性值\": [%s],\n", value_list
    printf "        \"药敏标准\": \"CLSI\",\n"
    printf "        \"测试方法\": \"肉汤微量稀释法\",\n"
    printf "        \"培养条件\": \"CHROMagar Candida培养基，28°C，24小时\"\n"
    printf "    }"
}
END {
    print "\n]"
}
' "$INPUT_FILE" > "$OUTPUT_FILE"
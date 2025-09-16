import json
import xml.etree.ElementTree as ET

# Load the initial metadata
with open('/Users/tom_lee/wdr/datasets_mining_building/PRJNA689765/json/metadata_initial.json', 'r', encoding='utf-8') as f:
    initial_data = json.load(f)

# Parse the SRA metadata XML
tree = ET.parse('/Users/tom_lee/wdr/datasets_mining_building/PRJNA689765/public_db/sra_metadata.xml')
root = tree.getroot()

# Create a dictionary to map strain alias to accession number
strain_to_accession = {}
for experiment_package in root.findall('EXPERIMENT_PACKAGE'):
    experiment_alias = experiment_package.find('EXPERIMENT').get('alias')
    run_accession = experiment_package.find('.//RUN').get('accession')
    if experiment_alias and run_accession:
        strain_to_accession[experiment_alias] = run_accession

# Update the initial data with the accession numbers
for strain in initial_data:
    strain_id = strain.get('菌株唯一编号')
    if strain_id in strain_to_accession:
        strain['NCBI登录号'] = strain_to_accession[strain_id]

# Write the verified data to a new JSON file
with open('/Users/tom_lee/wdr/datasets_mining_building/PRJNA689765/json/metadata_verified.json', 'w', encoding='utf-8') as f:
    json.dump(initial_data, f, ensure_ascii=False, indent=4)

print("Successfully updated metadata_verified.json with NCBI accession numbers.")
from pathlib import Path
from zipfile import ZipFile
from google.colab import files  # Khusus untuk Google Colab

# Nama preset dan isi dari metadatanya
preset_name = "Pastel_Dreamy_Sakura"
preset_content = """<?xml version="1.0" encoding="UTF-8"?>
<x:xmpmeta xmlns:x="adobe:ns:meta/">
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about=""
xmlns:crs="http://ns.adobe.com/camera-raw-settings/1.0/"
crs:Version="12.0"
crs:ProcessVersion="11.0"
crs:WhiteBalance="As Shot"
crs:Temperature="10"
crs:Tint="8"
crs:Exposure2012="0.30"
crs:Contrast2012="-10"
crs:Highlights2012="-15"
crs:Shadows2012="20"
crs:Whites2012="10"
crs:Blacks2012="-10"
crs:Clarity2012="-10"
crs:Dehaze="-5"
crs:Vibrance="15"
crs:Saturation="-5"
crs:SplitToningHighlightHue="340"
crs:SplitToningHighlightSaturation="20"
crs:SplitToningShadowHue="25"
crs:SplitToningShadowSaturation="20"
crs:SplitToningBalance="30"
crs:GrainAmount="5"
crs:VignetteAmount="-5"
/>
</rdf:RDF>
</x:xmpmeta>
"""

# Simpan ke direktori kerja Google Colab
xmp_path = Path(f"{preset_name}.xmp")
zip_path = Path(f"{preset_name}.zip")

# Simpan file xmp
with open(xmp_path, "w") as file:
    file.write(preset_content)

# Kompres ke file zip
with ZipFile(zip_path, "w") as zipf:
    zipf.write(xmp_path, arcname=xmp_path.name)

print("Preset berhasil dibuat!")

# Unduh file ke perangkat
files.download(zip_path)

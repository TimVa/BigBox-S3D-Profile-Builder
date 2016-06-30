#/bin/sh
for f in *.xsl; do java -classpath ./bin/saxon9he.jar net.sf.saxon.Transform "./profiles/BigBox Base.fff" "$f" "PEIPlate=1"; done
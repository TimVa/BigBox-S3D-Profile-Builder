#/bin/sh
for f in *.xsl; do java -classpath ./bin/saxon9he.jar net.sf.saxon.Transform "./profiles/BigBox Dual.fff" "$f"; done
#/bin/sh

if [ $# -eq 0 ]
then
	echo ""
	echo "BigBox S3D Profile Builder"
	echo ""
	echo "Select your leveling mechanism:"
	echo ""
	echo "1 - ABL (auto bed leveling)"
	echo "2 - MBL (mesh/manual bed leveling)"
	echo ""
	echo -n "Type 1 or 2 then press ENTER:"
	read choice
	case $choice in
		1 ) Leveling=ABL
			;;
		2 ) Leveling=MBL
			;;
		* ) echo "You did not enter a number!"
	esac

	echo ""
	echo ""
	echo "Do you have a PEI build plate?"
	echo ""
	echo "1 - No"
	echo "2 - Yes"
	echo ""
	echo -n "Type 1 or 2 then press ENTER:"
	read choice
	case $choice in
		1 ) PEIPlate=0
			;;
		2 ) PEIPlate=1
			;;
		* ) echo "You did not enter a number!"
	esac

	echo ""
elif [ $# -eq 2 ]
then
	Leveling=$1
	PEIPlate=$2
else
	exit 1
fi

echo "Generating profiles..."

for f in *.xsl; do java -classpath ./bin/saxon9he.jar net.sf.saxon.Transform "./profiles/BigBox Base.fff" "$f" "Leveling=$Leveling" "PEIPlate=$PEIPlate"; done

echo ""
echo "Profiles generated!"
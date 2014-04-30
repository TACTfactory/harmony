# pull all repot

FOLDERS=`ls -d vendor/*/`

cd vendor/tact-core
gradlew jar
cd ../..

for FILE in $FOLDERS
do
	echo "Process $FILE bundle"
	echo "================================================================"
	cd $FILE
	gradlew jar
	cd ../..
done

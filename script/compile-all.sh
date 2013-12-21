# pull all repot

FOLDERS=`ls -d vendor/*/`

cd vendor/tact-core
ant buildall
cd ../..

for FILE in $FOLDERS
do
	echo "Process $FILE bundle"
	echo "================================================================"
	cd $FILE
	ant buildall
	cd ../..
done

# pull all repot

FOLDERS=`ls -d vendor/*/`
BRANCH="master"
REMOTE="origin"

for FILE in $FOLDERS
do
	echo "Process $FILE bundle"
	echo "================================================================"
	cd $FILE
	git fetch --all
	git checkout $BRANCH
	git pull $REMOTE $BRANCH
	cd ../..
done

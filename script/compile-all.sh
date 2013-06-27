# pull all repot

cd vendor/tact-core
ant buildall
cd ../..

cd vendor/tact-rest
ant build
cd ../..

cd vendor/tact-search
ant build
cd ../..

cd vendor/tact-social
ant build
cd ../..

cd vendor/tact-symfony
ant build
cd ../..

cd vendor/tact-sync
ant build
cd ../..

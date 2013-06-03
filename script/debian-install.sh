echo "Debian install..."

echo "> Install depandency"
#sudo aptitude install phpmyadmin mysql-server

echo "> make sym link"
#sudo ln -s www /var/www/demact

echo "> Security setting"
#sudo 
chown :www-data -R www
#sudo 
chmod 775 -R www

echo "> Apache setting"
#sudo a2dissite default
#sudo a2ensite <projectName>
#sudo a2enmod rewrite

echo "> Config Database"
cd www/Symfony/

#sudo 
nano app/config/parameters.yml

echo "> Restart Apache2 service"
#sudo /etc/init.d/apache restart

echo "> Create database"
php app/console doctrine:database:create

echo "> Create schema"
php app/console doctrine:schema:create

echo "done."

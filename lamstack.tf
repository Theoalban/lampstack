LAMP Stack installation on a Linux machine

Owned Theo Kemajou

Last updated: Oct 15, 2023 min read
40 people viewed
Objective: 
At the end of this tutorial, you must be able to install a LAMP Stack server on a Linux machine (Centos 7).

Prerequisite: 
Before following this tutorial, you must have an account on AWS.

LAMP stands for Linux Apache MySQL Php

Linux is the Operating system software.

Apache is the web server software.

MySQL is the database software.

Php is a web development software.

To install the LAMP STACK server on a Centos 7 machine, follow the steps below:

Step 1: Launch a centos7 lightsail server
We will install the Lamp stack server on a Centos 7 lightsail machine. So we have to launch the machine where we will install all the necessary tools.

At this step of the course, you already know how to create a lightsail server and connect to it. So, go ahead and launch a Centos 7 lightsail server and connect to it via ssh.

Once connected to the server, use this command to grant root privileges:



sudo -i
You can check the OS version using: 



cat /etc/*release
Now, update all packages on the Centos 7 server with: 



yum update -y
Step 2: Install Apache
To install Apache on Centos 7, follow the steps below:

Use the following command to install Apache: 



yum install httpd -y
Now enable the httpd daemon with: 



systemctl enable httpd
Start the httpd daemon with:



systemctl start httpd
Check the status of the httpd daemon:



systemctl status httpd
The Apache Web server uses port 80 and it is open by default in a lightsail server, if not we should have opened it.

Check the installation of Apache in your browser by adding port 80 to the public IP address of the server. You will get the page in the image below.


Apache test page
Step 3: Install MySQL
Why do we need a database for a website or web app?

When a user fills out a form on a website or in an app, the information entered needs to be stored somewhere.

A database is like a server on which database software like MySQL is installed to keep users' information.

To install MySQL on Centos 7, use this command:



yum install mariadb-server -y 
Start the mysql service with:



systemctl start mariadb
Now enable it with:



systemctl enable mariadb
Let’s set the root password for MySQL



mysql_secure_installation
Enter the current password for root: Press Enter (since we don’t have one)

Set root password? : y

New password: school1

Re-enter new password: school1

Remove anonymous users?: y

Disallow root login remotely? : y

Remove test database and access to it?:  y

Reload privilege tables now?: y

Now, log in to MySQL to create a database to store information for our website 



mysql -u root -p
Enter the root password: school1

You must have the MySQL prompt ie mysql>

Let’s display all the databases in there using the command: 



show databases;

In the MySQL prompt, let’s create our database (webserver):



create database webserver;
show databases;

Let’s create a user oracle that can access the database with its password 'school1’:



create user oracle@localhost identified by 'school1';
Give the user oracle access to the database webserver



grant all privileges on webserver.* to oracle@localhost identified by 'school1';
Let’s load the privileges and exit the MySQL prompt:



flush privileges; 
exit
Step 4: Install Php
To install PHP on Centos 7, use the following command:



yum install php php-mysql -y
We need to test if PHP is successfully installed and running fine. To do that:

Create a file called info.php in the directory /var/www/html



cd /var/www/html
vi info.php 
Add the following lines to the info.php file in the insert mode:



<?php
phpinfo();
?>
Save and quit (:wq)

Let’s restart Apache:



systemctl restart httpd
To access the page in the browser, enter the public IP address of your host with port number 80 to verify the Apache page. 

Then add info.php at the end (IPaddress:80/info.php) to check the PHP page

Ex: 13.58.158.87:80/info.php

If you see the following page, then all is working successfully! 


Let’s install some additional packages for Php: php-gd



yum install php-gd -y
Step 5: Install WordPress
What’s WordPress?

WordPress is a CMS (Content Management System). It’s just a tool that helps to host websites easily with clicks, drag and drop etc.

To install WordPress, we need to download the compressed file and extract it:



cd /tmp
wget http://wordpress.org/wordpress-5.1.1.tar.gz
Note: If wget command is not found, install it: yum install wget -y

Now, let’s extract the file



tar -xzvf wordpress-5.1.1.tar.gz
ls
You can remove the tar.gz file now: 



rm -rf wordpress-5.1.1.tar.gz
Copy wordpress content to /var/www/html folder and make sure the command worked fine



cp -r wordpress/* /var/www/html/
cd /var/www/html/      
ll
Now create a directory called wp-content/uploads in /var/www/html



mkdir /var/www/html/wp-content/uploads
Now, copy the content of wp-config-sample.php to the file wp-config.php



cp wp-config-sample.php wp-config.php
ls
For ls to display the last item created at the end of the list, you can use:



ls -ltr
Let’s modify that file to set up the MySQL connection with the webserver database and the user oracle:



vi wp-config.php
Then modify it as shown in the below images


wp-config.php before 

wp-config.php after
Save and exit (:wq)

After saving and exiting vi, we need to change the ownership on /var/www/html 



chown -R apache:apache /var/www/html/*
The new owner of that directory is apache and the group owner is apache and -R means recursive (set the same ownership on all the subdirectories and files under a folder)

Restart the httpd service 



systemctl restart httpd
Open the browser and let’s install WordPress: by using your server’s public IP-address:80 in the browser

For the WordPress installation, choose the language English and continue:

Now, fill out the form as in the following image and click on Install WordPress

Username: student

Password: school1


You can now log in with the user student and its password school1.



The dashboard will open: this is the backend of the website. If you click on the name of the site, you will have a default preview

We can change the theme of the site by going back to the dashboard


Click on Appearance then Themes and Activate one


Choose one theme and click on Activate to enable it.


Preview the site once more

This is how some websites are easily set up with Wordpress!

You will get the final result:


 

Warning: Always remember to delete the lightsail instance created when you are done. This can avoid you further charges.


Return-Path: <SRS0=Zo7G=CK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,WEIRD_PORT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E364C433E6
	for <selinux@archiver.kernel.org>; Tue,  1 Sep 2020 02:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1914C208DB
	for <selinux@archiver.kernel.org>; Tue,  1 Sep 2020 02:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgIACGK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Aug 2020 22:06:10 -0400
Received: from ec2-3-21-30-127.us-east-2.compute.amazonaws.com ([3.21.30.127]:36628
        "EHLO www.teo-en-ming.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgIACGK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Aug 2020 22:06:10 -0400
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Aug 2020 22:06:08 EDT
Received: from localhost (localhost [IPv6:::1])
        by www.teo-en-ming.com (Postfix) with ESMTPA id 0DFFB40415D;
        Tue,  1 Sep 2020 09:56:23 +0800 (+08)
MIME-Version: 1.0
Date:   Tue, 01 Sep 2020 09:56:22 +0800
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming.com>
To:     selinux@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Subject: How to Migrate Wordpress Website from 32-bit CentOS Linux 6.3 to
 64-bit CentOS Linux 8.2 (2004)
Message-ID: <146d1d41153da1ae75876fcc17a8455a@teo-en-ming.com>
X-Sender: ceo@teo-en-ming.com
User-Agent: Roundcube Webmail/1.2.3
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Subject: How to Migrate Wordpress Website from 32-bit CentOS Linux 6.3 
to 64-bit CentOS Linux 8.2 (2004)

Author of this Guide: Mr. Turritopsis Dohrnii Teo En Ming (TARGETED 
INDIVIDUAL)

Country: Singapore

Date: 31 August 2020 Monday Singapore Time

Type of Publication: Plain Text

Document Version: 20200831.01

SECTION 1 Information Gathering Stage
=====================================

Host operating system is Windows Server 2008 R2 Standard

Host Processor: Intel Xeon CPU E5620 @ 2.40 GHz

Host Memory: 24 GB RAM

Old Oracle VirtualBox version is 4.1.18

Upgrade to Virtualbox version 6.1.12 (COMPLETED SUCCESSFULLY AFTER 
RESTARTING WINDOWS SERVER)

Old CentOS Linux VM is version 6.3 (32-bit only)

Old Apache web server version 2.2.15

Old MySQL database server version 5.1.61

Old PHP version 5.6.40

Interface eth0: AAA.BBB.CCC.3/24 (ifconfig)
Gateway: AAA.BBB.CCC.2 (ip route) (Gateway is the next hop router which 
is also the Fortigate firewall)
/etc/resolv.conf (for DNS Client):
nameserver AAA.BBB.CCC.1 (This is the Windows Server with DNS Server 
role installed)

How to login to OLD MySQL database server:

mysql -u root -p

Old hostname: centos63.teo-en-ming-corp.com

Old Virtual Machine Settings
============================

4 GB RAM, 2 processors, 20 GB storage, network adapter: bridged to 
broadcom bcm5709c

NEW Virtual Machine Settings
============================

4 GB RAM, 4 processors, 100 GB storage, network adapter: bridged to 
broadcom bcm5709c

After using Advanced IP scanner and checking DHCP scope in Microsoft 
DHCP server in Windows Server,

Unused IP address: AAA.BBB.CCC.4 (Use this IP address for new CentOS 8.2 
Linux VM)

SECTION 2 Installation of NEW CentOS 8.2 Linux Virtual Machine
==============================================================

New Hostname: centos82.teo-en-ming-corp.com

NEW IP: AAA.BBB.CCC.4
Subnet mask: 255.255.255.0 (Class C)
Gateway: AAA.BBB.CCC.2
DNS1: 8.8.8.8

Problem
=======

CentOS 8.2 Linux 64-bit will not start and run because VirtualBox is too 
old (version 4.1.18). Intel Virtualization and VT-d already enabled in 
server BIOS previously.
So running 64-bit virtual machines is not an issue.

Solution
========

After upgrading to VirtualBox 6.1.12, CentOS 8.2 Linux 64-bit is able to 
start and run.

SECTION 3 Generate a Backup of ALL Databases in the Old VM
===========================================================

Reference Guide: How to backup and restore MySQL databases using the 
mysqldump command

Link: 
https://www.sqlshack.com/how-to-backup-and-restore-mysql-databases-using-the-mysqldump-command/

Reference Guide: How to Show Users in MySQL using Linux

Link: https://www.hostinger.com/tutorials/mysql-show-users/

# cd /root

# mysqldump -u root -p --all-databases > all-databases-20200829.sql

# du -h all-databases-20200829.sql

70M all-databases-20200829.sql

SECTION 4 Disable SELinux (Security Enhanced Linux)
===================================================

You MUST disable SELinux, otherwise Apache web server will not work.

If you DO NOT want to disable SELinux, you must be an expert in SELinux 
to configure SELinux.

# nano /etc/selinux/config

SELINUX=disabled

# reboot

SECTION 5 Disable firewalld Software Firewall
=============================================

Because already protected by Fortigate firewall at the perimeter.

# systemctl disable firewalld

# reboot

SECTION 6 LAMP (Linux, Apache, MySQL and PHP) Installation
==========================================================

I will be installing Apache web server 2.4.37-21, MariaDB server 
3:10.3.17-1, PHP 7.2.24-1 and OpenSSL 1:1.1.1c-15 in 64-bit CentOS Linux 
8.2 (2004).

Sub-Section on Installing Apache Web Server
===========================================

# dnf install php php-fpm php-gd

You *MUST* install php-gd, otherwise Apache Web Server cannot execute 
PHP scripts.

# dnf install httpd

# systemctl enable httpd

# systemctl start httpd

[root@centos82 ~]# ps -ef | grep httpd
root       33214       1  0 22:03 ?        00:00:00 /usr/sbin/httpd 
-DFOREGROUND
apache     33351   33214  0 22:03 ?        00:00:00 /usr/sbin/httpd 
-DFOREGROUND
apache     33352   33214  1 22:03 ?        00:00:00 /usr/sbin/httpd 
-DFOREGROUND
apache     33355   33214  1 22:03 ?        00:00:00 /usr/sbin/httpd 
-DFOREGROUND
apache     33357   33214  0 22:03 ?        00:00:00 /usr/sbin/httpd 
-DFOREGROUND
root       36374    7368  0 22:03 pts/0    00:00:00 grep --color=auto 
httpd

On the OLD CentOS 6.3 server:

# cd /etc/httpd

# tar cfvz apacheconf.tar.gz conf conf.d

# mv apacheconf.tar.gz /root

On the NEW CentOS 8.2 server:

# cd /etc/httpd

# cp -r conf conf.original

# cp -r conf.d conf.d.original

# scp root@AAA.BBB.CCC.3:/root/apacheconf.tar.gz .

# tar xfvz apacheconf.tar.gz

On the OLD CentOS 6.3 server:

# cd /var/www/html

# tar cfvz websites.tar.gz *

(1.4 GB)

On the NEW CentOS 8.2 server:

# cd /var/www/html

# scp root@AAA.BBB.CCC.3:/root/websites.tar.gz .

# tar xfvz websites.tar.gz

Continuing on the NEW CentOS 8.2 server
=======================================

How to troubleshoot Apache web server
=====================================

The following are TWO very important Linux troubleshooting commands.

# systemctl status httpd (check the error Apache web server gives out)

# httpd -t (for checking Apache web server configuration syntax)

Make the following changes to /etc/httpd/conf/httpd.conf, as follows:

Rationale for unloading modules here: The modules were already loaded in 
config files in another location /etc/httpd/conf.modules.d, so we 
disable in httpd.conf to avoid duplication.
If there are duplication for loading modules, Apache web server cannot 
start.

#
# Dynamic Shared Object (DSO) Support
#
# To be able to use the functionality of a module which was built as a 
DSO you
# have to place corresponding `LoadModule' lines at this location so the
# directives contained in it are actually available _before_ they are 
used.
# Statically compiled modules (those listed by `httpd -l') do not need
# to be loaded here.
#
# Example:
# LoadModule foo_module modules/mod_foo.so
#
#LoadModule auth_basic_module modules/mod_auth_basic.so
#LoadModule auth_digest_module modules/mod_auth_digest.so
#LoadModule authn_file_module modules/mod_authn_file.so
#LoadModule authn_alias_module modules/mod_authn_alias.so
#LoadModule authn_anon_module modules/mod_authn_anon.so
#LoadModule authn_dbm_module modules/mod_authn_dbm.so
#LoadModule authn_default_module modules/mod_authn_default.so
#LoadModule authz_host_module modules/mod_authz_host.so
#LoadModule authz_user_module modules/mod_authz_user.so
#LoadModule authz_owner_module modules/mod_authz_owner.so
#LoadModule authz_groupfile_module modules/mod_authz_groupfile.so
#LoadModule authz_dbm_module modules/mod_authz_dbm.so
#LoadModule authz_default_module modules/mod_authz_default.so
#LoadModule ldap_module modules/mod_ldap.so
#LoadModule authnz_ldap_module modules/mod_authnz_ldap.so
#LoadModule include_module modules/mod_include.so
#LoadModule log_config_module modules/mod_log_config.so
#LoadModule logio_module modules/mod_logio.so
#LoadModule env_module modules/mod_env.so
#LoadModule ext_filter_module modules/mod_ext_filter.so
#LoadModule mime_magic_module modules/mod_mime_magic.so
#LoadModule expires_module modules/mod_expires.so
#LoadModule deflate_module modules/mod_deflate.so
#LoadModule headers_module modules/mod_headers.so
LoadModule usertrack_module modules/mod_usertrack.so
#LoadModule setenvif_module modules/mod_setenvif.so
#LoadModule mime_module modules/mod_mime.so
#LoadModule dav_module modules/mod_dav.so
#LoadModule status_module modules/mod_status.so
#LoadModule autoindex_module modules/mod_autoindex.so
#LoadModule info_module modules/mod_info.so
#LoadModule dav_fs_module modules/mod_dav_fs.so
#LoadModule vhost_alias_module modules/mod_vhost_alias.so
#LoadModule negotiation_module modules/mod_negotiation.so
#LoadModule dir_module modules/mod_dir.so
#LoadModule actions_module modules/mod_actions.so
LoadModule speling_module modules/mod_speling.so
#LoadModule userdir_module modules/mod_userdir.so
#LoadModule alias_module modules/mod_alias.so
#LoadModule substitute_module modules/mod_substitute.so
#LoadModule rewrite_module modules/mod_rewrite.so
#LoadModule proxy_module modules/mod_proxy.so
#LoadModule proxy_balancer_module modules/mod_proxy_balancer.so
#LoadModule proxy_ftp_module modules/mod_proxy_ftp.so
#LoadModule proxy_http_module modules/mod_proxy_http.so
#LoadModule proxy_ajp_module modules/mod_proxy_ajp.so
#LoadModule proxy_connect_module modules/mod_proxy_connect.so
#LoadModule cache_module modules/mod_cache.so
#LoadModule suexec_module modules/mod_suexec.so
#LoadModule disk_cache_module modules/mod_disk_cache.so
LoadModule cgi_module modules/mod_cgi.so
#LoadModule version_module modules/mod_version.so

IncludeOptional conf.d/*.conf (Notice the use of OPTIONAL)
Include conf.modules.d/*.conf (DEFAULT CONFIG FILES INSTALLED BY APACHE 
WEB SERVER 2.4.37)

Install the Secure Sockets Layer (SSL) module for Apache web server

# dnf install mod_ssl

Make the following changes to /etc/httpd/conf.d/ssl.conf, as follows:

#SSLMutex default (MUST be disabled)

Transferring Public Key from OLD server to NEW server:

# cd /etc/pki/tls/certs

# scp root@AAA.BBB.CCC.3:/root/teo-en-ming-corp.crt .

Transferring Private Key from OLD server to NEW server:

# cd /etc/pki/tls/private/

# scp root@AAA.BBB.CCC.3:/root/teo-en-ming-corp.key .

Install Python3 module for Apache web server:

# dnf install python3-mod_wsgi

Make the following changes to /etc/httpd/conf.d/wsgi.conf, as follows:

LoadModule wsgi_module modules/mod_wsgi_python3.so

Install the Perl module:

# dnf install epel-release

# dnf install mod_perl

Make the following changes to /etc/httpd/conf.d/perl.conf, as follows:

#LoadModule perl_module modules/mod_perl.so

Because Perl module is already loaded in /etc/httpd/conf.modules.d/

Disable SSL virtual hosts for now (Our server will support only http and 
no https at the moment)

# cd /etc/httpd/conf.modules.d/

# mv 00-ssl.conf 00-ssl.conf.original

# cd /etc/httpd/conf.d

# mv ssl.conf ssl.conf.1

Sub-Section on Installing MariaDB (MySQL) Database Server
=========================================================

# dnf install mariadb-server

# systemctl enable mariadb

# systemctl start mariadb

Reference Guide: How to Use SCP Command to Securely Transfer Files
Link: 
https://linuxize.com/post/how-to-use-scp-command-to-securely-transfer-files/

Transfer backup of ALL databases from OLD server to NEW server:

# scp root@AAA.BBB.CCC.3:/root/all-databases-20200829.sql .

Restore ALL databases on NEW server:

# mysql < all-databases-20200829.sql

Login to MySQL (MariaDB):

# mysql

Check all MySQL users are imported:

MariaDB [(none)]> select user from mysql.user;
+------------------+
| user             |
+------------------+
| root             |
|                  |
| root             |
|                  |
| root             |
| aaa              |
| bbb              |
| ccc              |
+------------------+
8 rows in set (0.001 sec)

Sub-Section on Installing PHP 7.2
=================================

We WON'T be using PHP configuration from OLD CentOS 6.3 server:

# /etc/httpd/conf.d

# mv php.conf php.conf.63

Use the PHP configuration on NEW CentOS 8.2 server:

# cp php.conf.rpmnew php.conf

ERROR ENCOUNTERED
=================

ERROR: Your PHP installation appears to be missing the MySQL extension 
which is required by WordPress

Solution is found at: 
https://www.howtoforge.com/tutorial/centos-lamp-server-apache-mysql-php/

SOLUTION
========

MUST install php-mysqlnd

# dnf install php-mysqlnd

SECTION 7 Apache Web Server Virtual Hosts
=========================================

/etc/httpd/conf/httpd.conf

### Section 3: Virtual Hosts
#
# VirtualHost: If you want to maintain multiple domains/hostnames on 
your
# machine you can setup VirtualHost containers for them. Most 
configurations
# use only name-based virtual hosts so the server doesn't need to worry 
about
# IP addresses. This is indicated by the asterisks in the directives 
below.
#
# Please see the documentation at
# <URL:http://httpd.apache.org/docs/2.2/vhosts/>
# for further details before you try to setup virtual hosts.
#
# You may use the command line option '-S' to verify your virtual host
# configuration.

#
# Use name-based virtual hosting.
#
#NameVirtualHost *:80
#
# NOTE: NameVirtualHost cannot be used without a port specifier
# (e.g. :80) if mod_ssl is being used, due to the nature of the
# SSL protocol.
#

#
# VirtualHost example:
# Almost any Apache directive may go into a VirtualHost container.
# The first VirtualHost section is used for requests without a known
# server name.
#
#<VirtualHost *:80>
#    ServerAdmin webmaster@dummy-host.example.com
#    DocumentRoot /www/docs/dummy-host.example.com
#    ServerName dummy-host.example.com
#    ErrorLog logs/dummy-host.example.com-error_log
#    CustomLog logs/dummy-host.example.com-access_log common
#</VirtualHost>


#NameVirtualHost *:80

<VirtualHost *:80>
     ServerAdmin ceo@teo-en-ming-corp.com
     DocumentRoot /var/www/html/Teo-En-Ming-Corp
     ServerName teo-en-ming-corp.com
     redirect permanent / http://www.teo-en-ming-corp.com
</VirtualHost>

<VirtualHost *:80>
     ServerAdmin ceo@teo-en-ming-corp.com
     DocumentRoot /var/www/html/Teo-En-Ming-Corp
     ServerName www.teo-en-ming-corp.com

     RewriteEngine off
<Directory /var/www/html/Teo-En-Ming-Corp/>
         AllowOverride All
</Directory>

     <Location />
         RewriteEngine on
         RewriteCond %{REQUEST_FILENAME} !-f
         RewriteCond %{REQUEST_FILENAME} !-d
         RewriteRule !\.(js|ico|gif|jpg|png|css)$ /index.php
     </Location>
</VirtualHost>

<VirtualHost *:80>
     ServerAdmin ceo@teo-en-ming-corp.com
     DocumentRoot /var/www/html/DonaldTrump
     ServerName donaldtrump.com.sg
     redirect permanent / http://www.donaldtrump.com.sg
</VirtualHost>

<VirtualHost *:80>
     ServerAdmin ceo@teo-en-ming-corp.com
     DocumentRoot /var/www/html/DonaldTrump
     ServerName www.donaldtrump.com.sg

     RewriteEngine off

     <Location />
         RewriteEngine on
         RewriteCond %{REQUEST_FILENAME} !-f
         RewriteCond %{REQUEST_FILENAME} !-d
         RewriteRule !\.(js|ico|gif|jpg|png|css)$ /index.php
     </Location>
</VirtualHost>

#<VirtualHost *:80>
#    ServerAdmin ceo@teo-en-ming-corp.com
#    DocumentRoot /var/webmiln
#    ServerName centos.teo-en-ming-corp.com
#    redirect permanent / https://centos.teo-en-ming-corp.com:10000
#</VirtualHost>

<VirtualHost *:80>
     ServerAdmin ceo@teo-en-ming-corp.com
     DocumentRoot /var/www/html/Teo-En-Ming-Corp_old
     ServerName old.teo-en-ming-corp.com

     RewriteEngine off

     <Location />
         RewriteEngine on
         RewriteCond %{REQUEST_FILENAME} !-f
         RewriteCond %{REQUEST_FILENAME} !-d
         RewriteRule !\.(js|ico|gif|jpg|png|css)$ /index.php
     </Location>
</VirtualHost>

SECTION 8 .htaccess
===================

/var/www/html/Teo-En-Ming-Corp/wp-admin/.htaccess:

order deny,allow
deny from all
allow from AAA.BBB.CCC.DDD
allow from AAA.BBB.CCC.DDD
allow from AAA.BBB.CCC.DDD
allow from AAA.BBB.CCC.DDD
allow from AAA.BBB.CCC.DDD

SECTION 9 FORTIGATE FIREWALL (STATIC NAT/PORT FORWARDING CONFIGURATION)
=======================================================================

Create Virtual IPs for Static NAT/port forwarding.

Edit Virtual IP
===============

Name: Wordpress-Website

Interface: Internet (wan1)

Type: Static NAT

External IP Address/Range: AAA.BBB.CCC.DDD - AAA.BBB.CCC.DDD

Mapped IP Address/Range: AAA.BBB.CCC.4 - AAA.BBB.CCC.4

Optional Filters: No

Port Forwarding: No

Click OK.

Then create IPv4 firewall polic(ies) from WAN1 to Internal using the 
created Virtual IP, allowing http, https, icmp, ssh, and/or other 
networking protocols as you wish.

You may also use Security Profiles in Fortigate firewall as you wish:

Antivirus

Web Filter

DNS Filter

Application Control

FortiClient Compliance

SSL/SSH Inspection

Web Rating Overrides

Custom Signatures







-- 
-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: 
https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the 
United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan (5 Aug 
2019) and Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----

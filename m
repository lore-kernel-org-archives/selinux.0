Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA29152
	for <selinux@tycho.nsa.gov>; Fri, 25 Oct 2002 10:42:54 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA26688
	for <selinux@tycho.nsa.gov>; Fri, 25 Oct 2002 14:40:48 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id OAA26684 for <selinux@tycho.nsa.gov>; Fri, 25 Oct 2002 14:40:46 GMT
Date: Fri, 25 Oct 2002 16:42:28 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: New Apache policy
Message-ID: <20021025164228.A18830@lemuria.org>
References: <20021024160624.B2010@lemuria.org> <200210241643.38762.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
In-Reply-To: <200210241643.38762.russell@coker.com.au>; from russell@coker.com.au on Thu, Oct 24, 2002 at 04:43:38PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2002 at 04:43:38PM +0200, Russell Coker wrote:
> I am thinking of addressing this by having some macros file doing define() 
> statements for what functionality you want.  So you could do the following if 
> you want PHP:
> define(`use_http_php')

I don't yet feel comfortable with these defines, so I've left them out
for now. However, it definitely is a good idea.

I've also thought about writing a php.te file instead of including PHP
stuff in apache.te, which is pretty large as it is. Maybe I'll still do
that later, reorganizing apache into apache.te, apache-cgi.te, etc.
Advantage: With the Debian install process you could choose right there
which options to include.


I have attached two diff files, both against the latest default policy.
One is for apache, taking into account your comments and adding a
section for running PHP as a CGI, but with its own type.
I did this because I believe many people will want to give PHP scripts
more access than they would other scripts. It also helps me to seperate
out the PHP stuff from the other CGI and suexec parts.

The second diff is a new subversion policy, using a macro as you
suggested. It was a lot of work to get it right initially, but I do
agree that it's the better way to do it.


Again, if anyone has comments or suggestions, please don't hesitate. I
feel more comfortable with writing SELinux policies every day, but I'm
still just beginning.



-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="apache.diff"

diff -urN default/domains/program/apache.te current/domains/program/apache.te
--- default/domains/program/apache.te	2002-10-17 01:24:36.000000000 +0200
+++ current/domains/program/apache.te	2002-10-25 18:26:35.000000000 +0200
@@ -55,9 +55,6 @@
 domain_auto_trans(initrc_t, httpd_exec_t, httpd_t)
 type_transition init_t httpd_exec_t:process httpd_t;
 
-# for php
-tmp_domain(httpd)
-
 #
 # A type for files in /var/run specific to httpd
 #
@@ -367,14 +364,14 @@
 
 ########################################
 # When the admin starts the server, the server wants to acess
-# the TTY or PTY associated with the session. The httpd appears
-# to run correctly without this permission, so the permission
-# are commented out here. If you decide that access is needed,
-# then uncomment, but be aware that this will grant httpd access
-# to all sysadm_r TTYs and PTYs.
+# the TTY or PTY associated with the session. This is very bad
+# behaviour as it allows the server access to the sysadm_r TTYs
+# and PTYs, but apache2 doesn't work without.
+# If you run apache 1.x.x, try disabling this. For apache2,
+# this is currently the only solution.
 ##################################################
-allow httpd_t admin_tty_type:chr_file write;
-dontaudit httpd_t admin_tty_type:chr_file { read write };
+allow httpd_t admin_tty_type:chr_file { read write };
+
 
 ###########################
 # Allow httpd to receive messages from the network card
@@ -387,8 +384,7 @@
 allow httpd_t home_root_t:dir { getattr search };
 allow httpd_t user_home_dir_type:dir { getattr search };
 allow httpd_t user_home_type:dir { getattr search read };
-# need ioctl for php3
-allow httpd_t user_home_type:{ file lnk_file } { getattr read ioctl };
+allow httpd_t user_home_type:{ file lnk_file } { getattr read };
 dontaudit httpd_t sysadm_home_dir_t:dir { getattr search };
 
 ############################################################################
@@ -399,8 +395,7 @@
 #################################################
 # Allow the httpd_t to read the web servers config files
 ###################################################
-allow httpd_t httpd_config_t:file r_file_perms;
-allow httpd_t httpd_config_t:dir r_dir_perms;
+r_dir_file(httpd_t, httpd_config_t)
 # allow logrotate to read the config files for restart
 ifdef(`logrotate.te', `
 r_dir_file(logrotate_t, httpd_config_t)
@@ -489,3 +484,41 @@
 # Uncomment the following line to enable:
 #can_exec(httpd_t, shell_exec_t)
 
+
+##################################################
+#
+# PHP Directives
+##################################################
+
+type httpd_php_exec_t, file_type, exec_type;
+type httpd_php_t, domain;
+
+# Transition from the user domain to this domain.
+domain_auto_trans(httpd_t, httpd_php_exec_t, httpd_php_t)
+
+# The user role is authorized for this domain.
+role system_r types httpd_php_t;
+
+general_domain_access(httpd_php_t)
+general_file_read_access(httpd_php_t)
+uses_shlib(httpd_php_t)
+can_exec(httpd_php_t, lib_t)
+
+# allow php to read and append to apache logfiles
+allow httpd_php_t httpd_log_files_t:file ra_file_perms;
+
+# access to /tmp
+type httpd_php_tmp_t, file_type, sysadmfile, tmpfile;
+file_type_auto_trans(httpd_php_t, tmp_t, httpd_php_tmp_t)
+
+# ignore these things, PHP seems to work fine without
+dontaudit httpd_php_t httpd_sys_script_t:dir { search };
+
+
+# connect to mysql
+ifdef(`mysqld.te', `
+can_unix_connect(httpd_php_t, mysqld_t)
+allow httpd_php_t var_run_mysqld_t:dir { search };
+allow httpd_php_t var_run_mysqld_t:sock_file { write };
+')
+
diff -urN default/file_contexts/program/apache.fc current/file_contexts/program/apache.fc
--- default/file_contexts/program/apache.fc	2002-10-17 01:24:36.000000000 +0200
+++ current/file_contexts/program/apache.fc	2002-10-25 17:45:24.000000000 +0200
@@ -3,6 +3,7 @@
 /var/www/mrtg(/.*)?		system_u:object_r:httpd_sys_content_t
 /var/www/cgi-bin(/.*)?		system_u:object_r:httpd_sys_script_t
 /usr/lib/cgi-bin(/.*)?		system_u:object_r:httpd_sys_script_t
+/usr/lib/cgi-bin/php(3|4)?	system_u:object_r:httpd_php_exec_t
 /var/www/perl(/.*)?		system_u:object_r:httpd_sys_script_t
 /var/www/icons(/.*)?		system_u:object_r:httpd_sys_content_t
 /var/cache/httpd(/.*)?		system_u:object_r:httpd_cache_t

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="svn.diff"

diff -urN default/domains/program/svn.te current/domains/program/svn.te
--- default/domains/program/svn.te	1970-01-01 01:00:00.000000000 +0100
+++ current/domains/program/svn.te	2002-10-25 14:17:41.000000000 +0200
@@ -0,0 +1,28 @@
+#DESC Subversion revision control system
+#
+# Author:  Tom Vogt <tom@lemuria.org>
+#
+
+#################################
+#
+# Rules for the subversion domains
+#
+# The client programs (svn_exec_t) have a domain defined in
+# macros/program/svn_macros.te
+# 
+# svn_repos_t is the type of the repository files.
+#
+type svn_exec_t, file_type, sysadmfile, exec_type;
+type svn_repos_t, file_type;
+
+###############################################################################
+#
+# Rules for the server
+#
+# Subversion server runs as an apache2 module
+#
+ifdef(`apache.te', `
+allow httpd_t svn_repos_t:dir create_dir_perms;
+allow httpd_t svn_repos_t:file create_file_perms;
+')
+
diff -urN default/file_contexts/program/svn.fc current/file_contexts/program/svn.fc
--- default/file_contexts/program/svn.fc	1970-01-01 01:00:00.000000000 +0100
+++ current/file_contexts/program/svn.fc	2002-10-25 14:19:01.000000000 +0200
@@ -0,0 +1,5 @@
+# types for subversion version control system
+/usr/bin/svn			system_u:object_r:svn_exec_t
+/usr/bin/svnlook		system_u:object_r:svn_exec_t
+/usr/bin/svnadmin		system_u:object_r:svn_exec_t
+/var/svn(/.*)?			system_u:object_r:svn_repos_t
diff -urN default/macros/program/svn_macros.te current/macros/program/svn_macros.te
--- default/macros/program/svn_macros.te	1970-01-01 01:00:00.000000000 +0100
+++ current/macros/program/svn_macros.te	2002-10-25 15:49:05.000000000 +0200
@@ -0,0 +1,81 @@
+#
+# Macros for subversion domains.
+#
+# Author:  Tom Vogt <tom@lemuria.org>
+#
+
+#
+# svn_domain(domain_prefix)
+#
+# Define a derived domain for the svn programs when executed
+# by a user domain.
+#
+# The type declaration for the executable type for this program is
+# provided separately in domains/program/svn.te. 
+#
+undefine(`svn_domain')
+ifdef(`svn.te', `
+define(`svn_domain',`
+# Derived domain based on the calling user domain and the program.
+type $1_svn_t, domain;
+
+# Transition from the user domain to this domain.
+domain_auto_trans($1_t, svn_exec_t, $1_svn_t)
+
+# The user role is authorized for this domain.
+role $1_r types $1_svn_t;
+
+# Inherit and use descriptors from gnome-pty-helper.
+ifdef(`gnome-pty-helper.te',
+`allow $1_svn_t $1_gph_t:fd use;
+allow $1_t $1_gph_t:fd use;')
+
+# Inherit and use descriptors from newrole.
+ifdef(`newrole.te', `allow $1_svn_t newrole_t:fd use;')
+
+# allow ps to show svn
+allow $1_t $1_svn_t:dir { search getattr read };
+allow $1_t $1_svn_t:{ file lnk_file } { read getattr };
+allow $1_t $1_svn_t:process signal;
+
+# access to the repository
+allow $1_svn_t svn_repos_t:dir create_dir_perms;
+allow $1_svn_t svn_repos_t:file create_file_perms;
+
+# Use the network.
+# 2nd line is for local or labeled networking
+can_network($1_svn_t)
+can_tcp_connect($1_svn_t,httpd_t)
+
+uses_shlib($1_svn_t)
+general_domain_access($1_svn_t)
+general_file_read_access($1_svn_t)
+allow $1_svn_t proc_t:dir { search };
+
+# ignore this stuff, svn works just fine without
+dontaudit $1_svn_t devtty_t:chr_file { read write };
+dontaudit $1_svn_t sysctl_kernel_t:dir { search };
+dontaudit $1_svn_t sysctl_t:dir { search };
+
+
+# Write to the user domain tty.
+allow $1_svn_t $1_tty_device_t:chr_file rw_file_perms;
+allow $1_svn_t $1_devpts_t:chr_file rw_file_perms;
+
+
+# Create, access, and remove files in home directory.
+file_type_auto_trans($1_svn_t, $1_home_dir_t, $1_home_t)
+allow $1_svn_t $1_home_t:dir_file_class_set { relabelfrom relabelto };
+allow $1_svn_t $1_home_dir_t:dir { search };
+allow $1_svn_t $1_home_t:dir create_file_perms;
+allow $1_svn_t $1_home_t:file create_file_perms;
+
+# access files under /tmp
+file_type_auto_trans($1_svn_t, tmp_t, $1_tmp_t)
+')
+
+', `
+
+define(`svn_domain',`')
+
+')
diff -urN default/macros/user_macros.te current/macros/user_macros.te
--- default/macros/user_macros.te	2002-10-17 01:24:36.000000000 +0200
+++ current/macros/user_macros.te	2002-10-25 17:31:15.000000000 +0200
@@ -133,6 +133,7 @@
 ifdef(`sendmail.te', `sendmail_user_domain($1)')
 ifdef(`crontab.te', `crontab_domain($1)')
 ifdef(`ssh.te', `ssh_domain($1)')
+ifdef(`svn.te', `svn_domain($1)')
 ifdef(`irc.te', `irc_domain($1)')
 ifdef(`clamav.te', `user_clamscan_domain($1)')
 ifdef(`fingerd.te', `fingerd_macro($1)')

--VbJkn9YxBvnuCH5J--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

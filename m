Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA20789
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2002 10:06:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA24566
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2002 14:04:52 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id OAA24562
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2002 14:04:48 GMT
Date: Thu, 24 Oct 2002 16:06:24 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: New Apache policy
Message-ID: <20021024160624.B2010@lemuria.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached patch includes the earlier one, fixes what Russell
commented on and thus should get apache working in both the 1.x and 2.x
versions. No guarantees for PHP, CGI and other modules, I will tackle
that next.

However, I have also included my very first own from-scratch policy
file, for Subversion. Subversion is a CVS replacement and the server
runs under Apache2 using DAV.
My policy file tackles both the client tools and the server side,
allowing a server and both remote and local repository access.

Since this is my first from-scratch policy file, please take a look and
comment on it. It works for me, but I may have granted too much
permissions somewhere, even though I tried hard not to.


Finally, there is also a tiny fix for postfix that is required on my
system to silence pickup. No idea if this was just missed elsewhere or
if pickup works without and a simple dontaudit would've done it.


Is it OK to submit this stuff in one patch or should I have made
several?


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="apache-svn.diff"

diff -urN default/domains/program/apache.te current/domains/program/apache.te
--- default/domains/program/apache.te	2002-10-17 01:24:36.000000000 +0200
+++ current/domains/program/apache.te	2002-10-24 14:29:59.000000000 +0200
@@ -367,14 +367,14 @@
 
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
@@ -401,6 +401,7 @@
 ###################################################
 allow httpd_t httpd_config_t:file r_file_perms;
 allow httpd_t httpd_config_t:dir r_dir_perms;
+allow httpd_t httpd_config_t:lnk_file r_file_perms;
 # allow logrotate to read the config files for restart
 ifdef(`logrotate.te', `
 r_dir_file(logrotate_t, httpd_config_t)
diff -urN default/domains/program/postfix.te current/domains/program/postfix.te
--- default/domains/program/postfix.te	2002-10-17 01:24:36.000000000 +0200
+++ current/domains/program/postfix.te	2002-10-24 14:29:41.000000000 +0200
@@ -225,6 +225,8 @@
 allow postfix_pickup_t postfix_spool_maildrop_t:file r_file_perms;
 allow postfix_pickup_t postfix_spool_maildrop_t:file unlink;
 allow postfix_pickup_t self:tcp_socket create_socket_perms;
+allow postfix_pickup_t postfix_pickup_t:capability { sys_chroot };
+
 
 postfix_public_domain(qmgr)
 allow postfix_qmgr_t postfix_public_t:fifo_file rw_file_perms;
diff -urN default/domains/program/svn.te current/domains/program/svn.te
--- default/domains/program/svn.te	1970-01-01 01:00:00.000000000 +0100
+++ current/domains/program/svn.te	2002-10-24 17:40:13.000000000 +0200
@@ -0,0 +1,92 @@
+#DESC Subversion revision control system
+#
+# Author:  Tom Vogt <tom@lemuria.org>
+#
+
+#################################
+#
+# Rules for the subversion domains
+#
+# svn_t is the domain for the subversion client programs.
+# svn_sysadm_t is the domain for the subversion client programs if run by the sysadmin.
+# svn_exec_t is the type of the corresponding programs.
+# svn_admin_t is the domain for the subversion admin program.
+# svn_admin_t is the domain for the subversion admin program.
+# svn_admin_exec_t is the type of the corresponding programs.
+# svn_repos_t is the type of the repository files.
+#
+#
+type svn_t, domain, privlog;
+type svn_sysadm_t, domain, privlog;
+type svn_admin_t, domain, privlog;
+type svn_repos_t, file_type, sysadmfile;
+role user_r types svn_t;
+role sysadm_r types svn_sysadm_t;
+role system_r types svn_sysadm_t;
+role sysadm_r types svn_admin_t;
+every_domain(svn_t)
+every_domain(svn_sysadm_t)
+every_domain(svn_admin_t)
+type svn_exec_t, file_type, sysadmfile, exec_type;
+type svn_admin_exec_t, file_type, sysadmfile, exec_type;
+
+# allow network access to repositories
+# the first two lines allow regular networking, while
+# the second two take care of labeled or local networking
+can_network(svn_t)
+can_network(svn_sysadm_t)
+can_tcp_connect(svn_t,httpd_t)
+can_tcp_connect(svn_sysadm_t,httpd_t)
+
+# Transition into this domain when you run these programs.
+domain_auto_trans(user_t, svn_exec_t, svn_t)
+domain_auto_trans(sysadm_t, svn_exec_t, svn_sysadm_t)
+domain_auto_trans(initrc_t, svn_exec_t, svn_t)
+domain_auto_trans(sysadm_t, svn_admin_exec_t, svn_admin_t)
+
+# allow svnadmin full access to the repositories
+allow svn_admin_t svn_repos_t:dir create_dir_perms; 
+allow svn_admin_t svn_repos_t:file create_file_perms; 
+
+# allow sysadm direct access to the repository.
+# this is required for import via the file:// method
+allow svn_sysadm_t svn_repos_t:dir rw_dir_perms;
+allow svn_sysadm_t svn_repos_t:file rw_file_perms;
+
+
+# Create, access, and remove files in home directory.
+# (needed to read and possibly create our config file)
+file_type_auto_trans(svn_t, user_home_dir_t, user_home_t)
+file_type_auto_trans(svn_sysadm_t, sysadm_home_dir_t, sysadm_home_t)
+
+# the log/history is written using an external editor,
+# so we need permissions to execute it. we remain in our
+# domain, however, to ensure the confidentiality of the
+# change information
+allow svn_sysadm_t shell_exec_t:file { execute execute_no_trans };
+allow svn_sysadm_t bin_t:file { execute execute_no_trans };
+
+# Access the terminal.
+allow svn_t user_tty_device_t:chr_file rw_file_perms;
+allow svn_t user_devpts_t:chr_file rw_file_perms;
+ifdef(`gnome-pty-helper.te', `allow svn_t user_gph_t:fd use;')
+
+allow svn_sysadm_t sysadm_tty_device_t:chr_file rw_file_perms;
+allow svn_sysadm_t sysadm_devpts_t:chr_file rw_file_perms;
+ifdef(`gnome-pty-helper.te', `allow svn_sysadm_t sysadm_gph_t:fd use;')
+
+allow svn_admin_t sysadm_tty_device_t:chr_file rw_file_perms;
+allow svn_admin_t sysadm_devpts_t:chr_file rw_file_perms;
+ifdef(`gnome-pty-helper.te', `allow svn_admin_t sysadm_gph_t:fd use;')
+
+
+###############################################################################
+#
+# If we are running a server, the apache daemon needs access to the 
+# repositories
+ifdef(`apache.te', `
+allow httpd_t svn_repos_t:dir create_dir_perms;
+allow httpd_t svn_repos_t:file create_file_perms;
+')
+
+
diff -urN default/file_contexts/program/svn.fc current/file_contexts/program/svn.fc
--- default/file_contexts/program/svn.fc	1970-01-01 01:00:00.000000000 +0100
+++ current/file_contexts/program/svn.fc	2002-10-24 14:52:29.000000000 +0200
@@ -0,0 +1,5 @@
+# types for subversion version control system
+/usr/bin/svn			system_u:object_r:svn_exec_t
+/usr/bin/svnlook		system_u:object_r:svn_exec_t
+/usr/bin/svnadmin		system_u:object_r:svn_admin_exec_t
+/var/svn(/.*)?			system_u:object_r:svn_repos_t

--mYCpIKhGyMATD0i+--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

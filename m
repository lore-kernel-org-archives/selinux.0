Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5R5tP0S011947
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2003 01:55:25 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5R5sbss010172
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2003 05:54:37 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id h5R5sbhY010168
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2003 05:54:37 GMT
Subject: various policy fixes: suexec and user content, apache2 reload,
	mount and locales
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Cc: russell@coker.com.au
Content-Type: multipart/mixed; boundary="=-9q046VUtIihXXYCbaNNr"
Message-Id: <1056693151.11057.47.camel@columbia>
Mime-Version: 1.0
Date: 27 Jun 2003 01:52:31 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-9q046VUtIihXXYCbaNNr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi, here's a set of some policy fixes that I hit while setting up a
server, decreasing in importance.

First, I have a setup that looks like this:

(root):walters:sysadm_r:sysadm_t@monk> lc /var/www/verbum.org/autonet/
drwxr-xr-x  walters  walters  walters:object_r:httpd_user_script_ro_t .
drwxr-xr-x  walters  walters  walters:object_r:httpd_user_content_t ..
drwxr-xr-x  walters  walters  walters:object_r:httpd_user_script_rw_t data
-rwxr-xr-x  walters  walters  walters:object_r:httpd_user_script_exec_t moin.cgi
-rw-r--r--  walters  walters  walters:object_r:httpd_user_script_ro_t moin_config.py
-rw-r--r--  walters  walters  walters:object_r:httpd_user_script_ro_t moin_config.pyc

moin.cgi is exec'ed by suexec, which in this case needs to be able to 
{ search getattr } httpd_user_script_ro_t in order to access it.  A
patch to macros/program/apache_macros.te is attached.

Second, "/etc/init.d/apache2 reload" apparently talks to apache2 over HTTP, so I added
the ability for httpd_t to connect to httpd_t.  A patch to domains/program/apache.te is attached.

Thirdly, I have LANG=en_US.UTF-8 (as I do on all my machines), and I
noticed mount was accessing stuff in locale_t.  But since mount isn't
i18n-ized, I just added some dontaudit rules for the locale bits.  Patch
to domains/program/mount.te is attached.


--=-9q046VUtIihXXYCbaNNr
Content-Disposition: attachment; filename=apache-macros-te.patch
Content-Type: text/plain; name=apache-macros-te.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- /usr/share/selinux/policy/default/macros/program/apache_macros.te	Sat M=
ay 24 22:07:24 2003
+++ apache_macros.te	Fri Jun 27 01:42:18 2003
@@ -57,6 +57,8 @@
 allow httpd_suexec_t httpd_$1_content_t:dir { getattr search };
 domain_auto_trans_read(httpd_suexec_t, httpd_$1_script_exec_t, httpd_$1_sc=
ript_t)
=20
+allow httpd_suexec_t httpd_$1_script_ro_t:dir { search getattr };
+allow httpd_suexec_t httpd_$1_script_rw_t:dir { search getattr };
 allow httpd_suexec_t httpd_$1_script_exec_t:dir { search getattr };
=20
 allow httpd_$1_script_t httpd_t:fifo_file { write };

--=-9q046VUtIihXXYCbaNNr
Content-Disposition: attachment; filename=apache-te.patch
Content-Type: text/plain; name=apache-te.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- /usr/share/selinux/policy/default/domains/program/apache.te	Sat May 24 =
22:07:24 2003
+++ apache.te	Fri Jun 27 01:36:23 2003
@@ -100,6 +100,8 @@
 can_exec(httpd_t, bin_t)
=20
 can_network(httpd_t)
+# For /etc/init.d/apache2 reload
+can_tcp_connect(httpd_t,httpd_t);
=20
 ###################
 # Allow httpd to search users diretories

--=-9q046VUtIihXXYCbaNNr
Content-Disposition: attachment; filename=mount-te.patch
Content-Type: text/plain; name=mount-te.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- /usr/share/selinux/policy/default/domains/program/mount.te	Sat May 24 2=
2:07:24 2003
+++ mount.te	Fri Jun 27 01:37:39 2003
@@ -42,4 +42,6 @@
 ')
 allow mount_t root_t:filesystem unmount;
=20
+dontaudit mount_t locale_t:{file lnk_file} r_file_perms;
+dontaudit mount_t locale_t:dir r_dir_perms;
=20

--=-9q046VUtIihXXYCbaNNr--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9EBZ2rT026761
	for <selinux@tycho.nsa.gov>; Thu, 14 Oct 2004 07:35:02 -0400 (EDT)
Received: from mailrelay1.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9EBXnmT021655
	for <selinux@tycho.nsa.gov>; Thu, 14 Oct 2004 11:33:50 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 14 Oct 2004 13:34:58 +0200
Date: Thu, 14 Oct 2004 13:35:36 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: policy compile fixes
Message-Id: <20041014113536.GC2540@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--vGgW1X5XWziG23Ko
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch fixes a few compile problems with latest policy:
        consoletype.te: firstboot.te may not be there
        cups.fc: cupsd_config only exists if hald.te is available
        apache_macros.te: allow_ypbind is only declared if ypbind.te is
                          available

Add a few file_contexts.

Conditionalize the file_type_auto_trans rule in apache.te, otherwise log
files get created with the wrong context.

Add can_exec($1_ssh_t, { shell_exec_t bin_t }), it is needed for some
programs like x11-ssh-askpass (and I suspect sftp_server).

Please apply.
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="compile-fixes.patch"
Content-Transfer-Encoding: quoted-printable

diff -ur orig/domains/program/sulogin.te mod/domains/program/sulogin.te
--- orig/domains/program/sulogin.te	2004-10-14 13:09:52.000000000 +0200
+++ mod/domains/program/sulogin.te	2004-10-14 13:22:35.000000000 +0200
@@ -12,7 +12,7 @@
 type sulogin_exec_t, file_type, exec_type, sysadmfile;
 role system_r types sulogin_t;
=20
-general_domain_access(sulogin_t);
+general_domain_access(sulogin_t)
=20
 domain_auto_trans({ initrc_t init_t }, sulogin_exec_t, sulogin_t)
 uses_shlib(sulogin_t)
diff -ur orig/domains/program/unused/apache.te mod/domains/program/unused/a=
pache.te
--- orig/domains/program/unused/apache.te	2004-10-14 13:09:52.000000000 +02=
00
+++ mod/domains/program/unused/apache.te	2004-10-14 13:22:34.000000000 +0200
@@ -285,12 +285,14 @@
 allow httpd_t tmp_t:sock_file rw_file_perms;
 ') dnl targeted policy
=20
+ifdef(`distro_redhat', `
 #
 # mod_jk2 creates /var/log/httpd/jk2.shm to communicate with tomcat
 # This is a bug but it still exists in FC2
 #
 type httpd_runtime_t, file_type, sysadmfile;
 file_type_auto_trans(httpd_t, httpd_log_t, httpd_runtime_t, file)
+') dnl distro_redhat
 #
 # Customer reported the following
 #
diff -ur orig/domains/program/unused/consoletype.te mod/domains/program/unu=
sed/consoletype.te
--- orig/domains/program/unused/consoletype.te	2004-09-28 09:34:16.00000000=
0 +0200
+++ mod/domains/program/unused/consoletype.te	2004-10-14 13:22:35.000000000=
 +0200
@@ -54,6 +54,8 @@
 ifdef(`distro_redhat', `
 allow consoletype_t tmpfs_t:chr_file { getattr ioctl read write };
 ')
+ifdef(`firstboot.te', `
 allow consoletype_t firstboot_t:fifo_file { write };
+')
 dontaudit consoletype_t proc_t:file { read };
 dontaudit consoletype_t root_t:file { read };
Nur in mod/domains/program/unused: consoletype.te.orig.
diff -ur orig/file_contexts/program/apache.fc mod/file_contexts/program/apa=
che.fc
--- orig/file_contexts/program/apache.fc	2004-09-21 22:24:43.000000000 +0200
+++ mod/file_contexts/program/apache.fc	2004-10-14 13:22:34.000000000 +0200
@@ -26,6 +26,7 @@
 /var/cache/ssl.*\.sem	--	system_u:object_r:httpd_cache_t
 /var/cache/mod_ssl(/.*)?	system_u:object_r:httpd_cache_t
 /var/run/apache(2)?.pid.* --	system_u:object_r:httpd_var_run_t
+/var/lib/httpd(/.*)?		system_u:object_r:httpd_var_lib_t
 /etc/apache-ssl(2)?(/.*)?	system_u:object_r:httpd_config_t
 /usr/lib/apache-ssl(/.*)? --	system_u:object_r:httpd_exec_t
 /usr/sbin/apache-ssl(2)? --	system_u:object_r:httpd_exec_t
diff -ur orig/file_contexts/program/cups.fc mod/file_contexts/program/cups.=
fc
--- orig/file_contexts/program/cups.fc	2004-10-14 13:09:54.000000000 +0200
+++ mod/file_contexts/program/cups.fc	2004-10-14 13:22:35.000000000 +0200
@@ -18,8 +18,11 @@
 /usr/lib(64)?/cups/backend/.* --	system_u:object_r:cupsd_exec_t
 /usr/lib(64)?/cups/daemon/.*	 --	system_u:object_r:cupsd_exec_t
 /usr/sbin/cupsd		--	system_u:object_r:cupsd_exec_t
+ifdef(`hald.te', `
+# cupsd_config depends on hald
 /usr/bin/cups-config-daemon --	system_u:object_r:cupsd_config_exec_t
 /usr/sbin/hal_lpadmin --	system_u:object_r:cupsd_config_exec_t
+')
 /usr/sbin/printconf-backend --	system_u:object_r:sbin_t
 /var/log/cups(/.*)?		system_u:object_r:cupsd_log_t
 /var/spool/cups(/.*)?		system_u:object_r:print_spool_t
diff -ur orig/file_contexts/program/initrc.fc mod/file_contexts/program/ini=
trc.fc
--- orig/file_contexts/program/initrc.fc	2004-09-21 22:24:43.000000000 +0200
+++ mod/file_contexts/program/initrc.fc	2004-10-14 13:22:35.000000000 +0200
@@ -11,6 +11,11 @@
 /var/run/runlevel\.dir		system_u:object_r:initrc_var_run_t
 /var/run/random-seed	--	system_u:object_r:initrc_var_run_t
 /var/run/setmixer_flag	--	system_u:object_r:initrc_var_run_t
+ifdef(`distro_suse', `
+/var/run/sysconfig(/.*)?	system_u:object_r:initrc_var_run_t
+/var/run/keymap		--	system_u:object_r:initrc_var_run_t
+/var/run/numlock-on	--	system_u:object_r:initrc_var_run_t
+')
=20
 ifdef(`distro_gentoo', `
 /sbin/rc		--	system_u:object_r:initrc_exec_t
diff -ur orig/file_contexts/program/ssh.fc mod/file_contexts/program/ssh.fc
--- orig/file_contexts/program/ssh.fc	2004-03-09 16:31:36.000000000 +0100
+++ mod/file_contexts/program/ssh.fc	2004-10-14 13:22:35.000000000 +0200
@@ -12,3 +12,6 @@
 /usr/lib(64)?/misc/sftp-server --	system_u:object_r:bin_t
 /usr/libexec/openssh/sftp-server -- system_u:object_r:bin_t
 /usr/lib(64)?/sftp-server	--	system_u:object_r:bin_t
+ifdef(`distro_suse', `
+/usr/lib(64)?/ssh/.*	--	system_u:object_r:bin_t
+')
diff -ur orig/macros/program/apache_macros.te mod/macros/program/apache_mac=
ros.te
--- orig/macros/program/apache_macros.te	2004-10-14 13:09:56.000000000 +0200
+++ mod/macros/program/apache_macros.te	2004-10-14 13:22:35.000000000 +0200
@@ -64,9 +64,11 @@
 allow httpd_$1_script_t device_t:dir { getattr search };
 allow httpd_$1_script_t null_device_t:chr_file rw_file_perms;
 }
+ifdef(`ypbind.te', `
 if (httpd_enable_cgi && allow_ypbind) {
 uncond_can_ypbind(httpd_$1_script_t)
 }
+')
 # The following are the only areas that=20
 # scripts can read, read/write, or append to
 #
diff -ur orig/macros/program/ssh_macros.te mod/macros/program/ssh_macros.te
--- orig/macros/program/ssh_macros.te	2004-10-14 13:09:56.000000000 +0200
+++ mod/macros/program/ssh_macros.te	2004-10-14 13:22:35.000000000 +0200
@@ -92,6 +92,9 @@
 # Use capabilities.
 allow $1_ssh_t self:capability { setuid setgid dac_override dac_read_searc=
h };
=20
+# run helper programs - needed eg for x11-ssh-askpass
+can_exec($1_ssh_t, { shell_exec_t bin_t })
+
 # Read the ssh key file.
 allow $1_ssh_t sshd_key_t:file r_file_perms;
=20

--5mCyUwZo2JvN/JJP--

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBbmSHxWIrrrL0q+cRAvwiAJ93nyvT/6MvKDAeG00TtaEOBCPhEACeO6MI
1miDLGrh3iTswoKUji7mXh4=
=lyoy
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA27532
	for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 00:39:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id EAA26823
	for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 04:37:32 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id EAA26812 for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 04:37:30 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 044CC92472
	for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 14:39:14 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id E7D796CB
	for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 06:39:05 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: policy patch
Date: Sat, 21 Sep 2002 06:39:05 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_59URDCCD1J7LQI6VF2PY"
Message-Id: <200209210639.05547.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_59URDCCD1J7LQI6VF2PY
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

This one should be mostly self-explanatory, a few notes:

dontaudit ldconfig_t device_t:dir search;
It doesn't really need search access, so I removed the allow rule.

dontaudit ntpd_t var_t:dir getattr;
My var.diff patch allows this...

can_udp_send(init_t, portmap_t)
For NFS...

I solved the Postgresql problems that needed the gross hacks so I removed 
them.

-- 
There is no point PGP/GPG signing an email unless the signature can be
verified.  If you post to a list then don't sign the message unless your
key is available on public key servers and has been signed by someone
who is in the web of trust, otherwise you just waste bandwidth and CPU.

--------------Boundary-00=_59URDCCD1J7LQI6VF2PY
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

diff -ru /tmp/policy/domains/program/dpkg.te policy/domains/program/dpkg.te
--- /tmp/policy/domains/program/dpkg.te	2002-09-21 06:04:23.000000000 +0200
+++ policy/domains/program/dpkg.te	2002-09-21 05:19:00.000000000 +0200
@@ -115,7 +115,7 @@
 ')
 
 r_dir_file(install_menu_t, var_lib_dpkg_t)
-allow { install_menu_t userdomain system_crond_t } etc_dpkg_t:file r_file_perms;
+allow { apt_t install_menu_t userdomain system_crond_t } etc_dpkg_t:file r_file_perms;
 can_exec(sysadm_t, etc_dpkg_t)
 
 # Inherit and use descriptors from any domain.
@@ -237,7 +238,7 @@
 domain_auto_trans(dpkg_t, install_menu_exec_t, install_menu_t)
 allow dpkg_t install_menu_t:process signal_perms;
 
-allow install_menu_t newrole_t:fd use;
+allow install_menu_t privfd:fd use;
 uses_shlib(install_menu_t)
 
 allow install_menu_t self:process { fork sigchld };
diff -ru /tmp/policy/domains/program/fcron.te policy/domains/program/fcron.te
--- /tmp/policy/domains/program/fcron.te	2002-09-21 05:01:26.000000000 +0200
+++ policy/domains/program/fcron.te	2002-09-10 22:35:26.000000000 +0200
@@ -6,8 +6,8 @@
 #
 # Author: Russell Coker <russell@coker.com.au>
 
-# ideally we would not give it privowner!
-daemon_domain(fcron, `, privuser, privrole, privmail, privfd, privowner')
+# ideally we would not give it privowner or auth!
+daemon_domain(fcron, `, privuser, privrole, privmail, privfd, privowner, auth')
 
 general_domain_access(fcron_t)
 
diff -ru /tmp/policy/domains/program/ldconfig.te policy/domains/program/ldconfig.te
--- /tmp/policy/domains/program/ldconfig.te	2002-09-21 05:01:27.000000000 +0200
+++ policy/domains/program/ldconfig.te	2002-09-15 19:23:39.000000000 +0200
@@ -13,8 +13,8 @@
 role system_r types ldconfig_t;
 
 domain_auto_trans({ sysadm_t initrc_t ifdef(`dpkg.te', `dpkg_t') }, ldconfig_exec_t, ldconfig_t)
-allow ldconfig_t device_t:dir search;
-allow ldconfig_t { sysadm_devpts_t sysadm_tty_device_t }:chr_file rw_file_perms;
+dontaudit ldconfig_t device_t:dir search;
+allow ldconfig_t admin_tty_type:chr_file rw_file_perms;
 allow ldconfig_t privfd:fd use;
 
 uses_shlib(ldconfig_t)
diff -ru /tmp/policy/domains/program/named.te policy/domains/program/named.te
--- /tmp/policy/domains/program/named.te	2002-09-21 06:08:50.000000000 +0200
+++ policy/domains/program/named.te	2002-09-21 05:23:54.000000000 +0200
@@ -100,6 +100,9 @@
 allow ndc_t self:capability dac_override;
 allow ndc_t var_run_named_t:sock_file rw_file_perms;
 allow ndc_t named_t:unix_stream_socket connectto;
+allow ndc_t privfd:fd use;
+# seems to need read as well for some reason
+allow ndc_t admin_tty_type:chr_file { getattr read write };
 
 # for ndc_t to be used for restart shell scripts
 ifdef(`ndc_shell_script', `
diff -ru /tmp/policy/domains/program/ntpd.te policy/domains/program/ntpd.te
--- /tmp/policy/domains/program/ntpd.te	2002-09-09 19:54:13.000000000 +0200
+++ policy/domains/program/ntpd.te	2002-09-13 23:24:30.000000000 +0200
@@ -24,11 +24,13 @@
 dontaudit ntpd_t self:capability fsetid;
 dontaudit ntpd_t domain:lnk_file read;
 
+# for some reason it creates a file in /tmp
+tmp_domain(ntpd)
+
 allow ntpd_t etc_t:dir r_dir_perms;
 allow ntpd_t etc_t:lnk_file r_file_perms;
 allow ntpd_t resolv_conf_t:file { read getattr };
 allow ntpd_t etc_ntp_t:file rw_file_perms;
-dontaudit ntpd_t var_t:dir getattr;
 
 # Use the network.
 can_network(ntpd_t)
diff -ru /tmp/policy/domains/program/portmap.te policy/domains/program/portmap.te
--- /tmp/policy/domains/program/portmap.te	2002-09-09 19:54:14.000000000 +0200
+++ policy/domains/program/portmap.te	2002-09-17 14:44:29.000000000 +0200
@@ -31,6 +31,7 @@
 ifdef(`ypbind.te',
 `can_udp_send(portmap_t, ypbind_t)')
 can_udp_send(portmap_t, initrc_t)
+can_udp_send(init_t, portmap_t)
 ifdef(`rpcd.te',
 `can_udp_send(portmap_t, rpcd_t)')
 ifdef(`inetd.te',
diff -ru /tmp/policy/domains/program/portslave.te policy/domains/program/portslave.te
--- /tmp/policy/domains/program/portslave.te	2002-08-23 20:44:19.000000000 +0200
+++ policy/domains/program/portslave.te	2002-09-20 05:19:59.000000000 +0200
@@ -13,6 +13,7 @@
 
 allow portslave_t shadow_t:file { read getattr };
 general_domain_access(portslave_t)
+domain_auto_trans(init_t, portslave_exec_t, portslave_t)
 ifdef(`rlogind.te', `
 domain_auto_trans(rlogind_t, portslave_exec_t, portslave_t)
 ')
@@ -23,10 +24,12 @@
 
 allow portslave_t proc_t:file { getattr read };
 
-allow portslave_t { var_log_t devpts_t }:dir r_dir_perms;
+allow portslave_t { var_t var_log_t devpts_t }:dir search;
 
 allow portslave_t devtty_t:chr_file { setattr rw_file_perms };
 
+allow portslave_t pppd_secret_t:file r_file_perms;
+
 can_network(portslave_t)
 allow portslave_t fs_t:filesystem getattr;
 ifdef(`radius.te', `
@@ -61,7 +64,7 @@
 allow portslave_t wtmp_t:file rw_file_perms;
 
 # Read and write ttys.
-allow portslave_t tty_device_t:chr_file rw_file_perms;
+allow portslave_t tty_device_t:chr_file { setattr rw_file_perms };
 allow portslave_t ttyfile:chr_file rw_file_perms;
 
 
diff -ru /tmp/policy/domains/program/postgresql.te policy/domains/program/postgresql.te
--- /tmp/policy/domains/program/postgresql.te	2002-09-21 05:01:28.000000000 +0200
+++ policy/domains/program/postgresql.te	2002-09-21 05:32:02.000000000 +0200
@@ -15,8 +15,6 @@
 # gross hack
 domain_auto_trans(dpkg_t, postgresql_exec_t, postgresql_t)
 ')
-# a grosser hack, and not a good idea
-#allow postgresql_t etc_t:file setattr;
 
 dontaudit postgresql_t { sysadm_home_dir_t var_spool_t }:dir search;
 
@@ -70,10 +68,6 @@
 allow postgresql_t bin_t:lnk_file read;
 allow postgresql_t postgresql_exec_t:lnk_file read;
 
-# Not a good idea.
-#allow postgresql_t initrc_var_run_t:file { read write lock };
-allow postgresql_t initrc_var_run_t:file { read };
-
 allow postgresql_t self:sem rw_sem_perms;
 
 allow postgresql_t self:udp_socket recvfrom;
diff -ru /tmp/policy/domains/program/tmpreaper.te policy/domains/program/tmpreaper.te
--- /tmp/policy/domains/program/tmpreaper.te	2002-09-09 19:54:16.000000000 +0200
+++ policy/domains/program/tmpreaper.te	2002-09-21 05:37:06.000000000 +0200
@@ -15,6 +15,10 @@
 uses_shlib(tmpreaper_t)
 allow tmpreaper_t crond_t:fd use;
 allow tmpreaper_t crond_t:fifo_file { read write };
+ifdef(`fcron.te', `
+allow tmpreaper_t fcron_t:fd use;
+allow tmpreaper_t fcron_t:fifo_file { read write };
+')
 create_dir_file(tmpreaper_t, tmpfile)
 allow tmpreaper_t tmpfile:dir { rw_dir_perms rmdir };
 allow tmpreaper_t tmpfile:notdevfile_class_set { getattr unlink };
diff -ru /tmp/policy/file_contexts/program/portslave.fc policy/file_contexts/program/portslave.fc
--- /tmp/policy/file_contexts/program/portslave.fc	2002-07-12 17:19:44.000000000 +0200
+++ policy/file_contexts/program/portslave.fc	2002-09-20 05:22:13.000000000 +0200
@@ -1,3 +1,4 @@
 # portslave
 /usr/sbin/portslave		system_u:object_r:portslave_exec_t
 /etc/portslave(/.*)?		system_u:object_r:portslave_etc_t
+/var/run/radius.(id)|(seq)	system_u:object_r:var_run_pppd_t
diff -ru /tmp/policy/genfs_contexts policy/genfs_contexts
--- /tmp/policy/genfs_contexts	2002-09-21 05:01:24.000000000 +0200
+++ policy/genfs_contexts	2002-09-15 19:17:05.000000000 +0200
@@ -84,6 +84,8 @@
 ')
 ifdef(`lpd.te', `
 genfscon devfs /printers	-c	system_u:object_r:printer_t
+genfscon devfs /lp		-c	system_u:object_r:printer_t
+genfscon devfs /usb/lp		-c	system_u:object_r:printer_t
 ')
 genfscon devfs /ppp			system_u:object_r:ppp_device_t
 genfscon devfs /fb	-c		system_u:object_r:framebuf_device_t

--------------Boundary-00=_59URDCCD1J7LQI6VF2PY--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA23420
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 12:53:03 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA22735
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 16:51:33 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id QAA22731
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 16:51:33 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA12408
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 12:52:57 -0400 (EDT)
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA20749
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 08:19:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA11090
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 12:17:37 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id MAA11086 for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 12:17:34 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 85B7692467
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 22:19:18 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 889D37155
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 14:19:11 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: big patch
Date: Thu, 26 Sep 2002 14:18:25 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_PUO120A7R0K4JZYH1C6O"
Message-Id: <200209261418.25737.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_PUO120A7R0K4JZYH1C6O
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I've attached a patch that contains everything in my tree that I am certain is 
worthy of inclusion.

I have removed the things that Steve doesn't like, and I haven't included some 
new .te files.

This patch applies against the sourceforge CVS, for Debian systems at least it 
contains some changes that are necessary for the latest kernel patch.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_PUO120A7R0K4JZYH1C6O
Content-Type: text/x-diff;
  charset="us-ascii";
  name="big.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="big.diff"

diff -ru /tmp/policy/domains/misc/kernel.te ./domains/misc/kernel.te
--- /tmp/policy/domains/misc/kernel.te	2002-08-16 16:25:32.000000000 +0200
+++ ./domains/misc/kernel.te	2002-09-25 17:03:10.000000000 +0200
@@ -40,6 +40,11 @@
 # Access the initrd filesystem.
 allow kernel_t file_t:chr_file rw_file_perms;
 can_exec(kernel_t, file_t)
+ifdef(`chroot.te', `
+can_exec(kernel_t, chroot_exec_t)
+')
+allow kernel_t self:capability sys_chroot;
+
 allow kernel_t file_t:dir mounton;
 allow kernel_t file_t:dir rw_dir_perms;
 allow kernel_t file_t:blk_file create_file_perms;
diff -ru /tmp/policy/domains/program/acct.te ./domains/program/acct.te
--- /tmp/policy/domains/program/acct.te	2002-08-23 21:04:27.000000000 +0200
+++ ./domains/program/acct.te	2002-09-12 10:28:18.000000000 +0200
@@ -18,6 +18,8 @@
 
 # gzip needs chown capability for some reason
 allow acct_t self:capability chown;
+
+allow acct_t var_t:dir { getattr search };
 rw_dir_create_file(acct_t, acct_data_t)
 
 can_exec(acct_t, { shell_exec_t bin_t etc_t acct_exec_t })
diff -ru /tmp/policy/domains/program/apache.te ./domains/program/apache.te
--- /tmp/policy/domains/program/apache.te	2002-08-23 21:04:28.000000000 +0200
+++ ./domains/program/apache.te	2002-09-24 23:48:01.000000000 +0200
@@ -55,6 +55,9 @@
 domain_auto_trans(initrc_t, httpd_exec_t, httpd_t)
 type_transition init_t httpd_exec_t:process httpd_t;
 
+# for php
+tmp_domain(httpd)
+
 #
 # A type for files in /var/run specific to httpd
 #
@@ -367,8 +374,8 @@
 # then uncomment, but be aware that this will grant httpd access
 # to all sysadm_r TTYs and PTYs.
 ##################################################
-#allow httpd_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file write;
-dontaudit httpd_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file { read write };
+#allow httpd_t admin_tty_type:chr_file write;
+dontaudit httpd_t admin_tty_type:chr_file { read write };
 
 ###########################
 # Allow httpd to receive messages from the network card
@@ -470,7 +477,7 @@
 # Several options for handling SSI exec cmd elements:
 # Option #1:  Don't support them at all.  This is the default, since
 # httpd_t is not permitted to execute shell_exec_t.
-# Option #1:  Run SSI exec's in the same domain as system CGI scripts.
+# Option #2:  Run SSI exec's in the same domain as system CGI scripts.
 # Uncomment the following line to enable:
 #domain_auto_trans(httpd_t, shell_exec_t, httpd_sys_script_process_t)
 # Option #3:  Run SSI exec's directly in the httpd_t domain.  This means
diff -ru /tmp/policy/domains/program/bootloader.te ./domains/program/bootloader.te
--- /tmp/policy/domains/program/bootloader.te	2002-09-11 21:33:05.000000000 +0200
+++ ./domains/program/bootloader.te	2002-09-25 00:15:46.000000000 +0200
@@ -37,6 +37,7 @@
 allow bootloader_t etc_bootloader_t:file r_file_perms;
 
 can_exec(bootloader_t, { bootloader_exec_t shell_exec_t bin_t sbin_t })
+allow bootloader_t shell_exec_t:lnk_file read;
 allow bootloader_t { bin_t sbin_t }:dir search;
 allow bootloader_t { bin_t sbin_t }:lnk_file read;
 
@@ -72,6 +73,8 @@
 allow bootloader_t proc_t:dir r_dir_perms;
 allow bootloader_t proc_t:file r_file_perms;
 allow bootloader_t proc_t:lnk_file read;
+allow bootloader_t sysctl_kernel_t:dir search;
+allow bootloader_t sysctl_kernel_t:file { getattr read };
 allow bootloader_t etc_runtime_t:file r_file_perms;
 
 allow bootloader_t devtty_t:chr_file rw_file_perms;
@@ -80,8 +83,11 @@
 
 ifdef(`dpkg.te', `
 # for making an initrd
-can_exec(bootloader_t, { mount_exec_t })
-')
+can_exec(bootloader_t, mount_exec_t)
+ifdef(`chroot.te', `
+can_exec(bootloader_t, chroot_exec_t)
+')dnl end chroot.te
+')dnl end dpkg.te
 
 # for reading BIOS data
 allow bootloader_t memory_device_t:chr_file r_file_perms;
diff -ru /tmp/policy/domains/program/courier.te ./domains/program/courier.te
--- /tmp/policy/domains/program/courier.te	2002-09-21 05:01:25.000000000 +0200
+++ ./domains/program/courier.te	2002-09-24 14:22:41.000000000 +0200
@@ -108,6 +108,9 @@
 # for calendaring
 courier_domain(pcp)
 
+# courier pcpd will not start (from an admin shell) without this!
+allow courier_pcp_t admin_tty_type:chr_file { read write };
+
 allow courier_pcp_t self:capability { setuid setgid };
 allow courier_pcp_t random_device_t:chr_file r_file_perms;
 
diff -ru /tmp/policy/domains/program/crack.te ./domains/program/crack.te
--- /tmp/policy/domains/program/crack.te	2002-09-21 05:01:25.000000000 +0200
+++ ./domains/program/crack.te	2002-09-19 23:39:01.000000000 +0200
@@ -12,10 +12,15 @@
 domain_auto_trans(system_crond_t, crack_exec_t, crack_t)
 
 type crack_db_t, file_type, sysadmfile;
+allow crack_t var_t:dir search;
 rw_dir_create_file(crack_t, crack_db_t)
 
 allow crack_t crond_t:fd use;
 allow crack_t crond_t:fifo_file r_file_perms;
+ifdef(`fcron.te', `
+allow crack_t fcron_t:fd use;
+allow crack_t fcron_t:fifo_file r_file_perms;
+')
 allow crack_t device_t:dir search;
 allow crack_t devtty_t:chr_file rw_file_perms;
 allow crack_t self:fifo_file { read write getattr };
diff -ru /tmp/policy/domains/program/devfsd.te ./domains/program/devfsd.te
--- /tmp/policy/domains/program/devfsd.te	2002-09-09 19:54:10.000000000 +0200
+++ ./domains/program/devfsd.te	2002-09-21 06:06:07.000000000 +0200
@@ -19,7 +19,7 @@
 allow devfsd_t proc_t:dir r_dir_perms;
 allow devfsd_t { etc_t etc_runtime_t proc_t }:file r_file_perms;
 allow devfsd_t devtty_t:chr_file rw_file_perms;
-#allow devfsd_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file { read write };
+#allow devfsd_t admin_tty_type:chr_file { read write };
 
 # Run /sbin/modprobe
 allow devfsd_t sbin_t:dir r_dir_perms;
diff -ru /tmp/policy/domains/program/dpkg.te ./domains/program/dpkg.te
--- /tmp/policy/domains/program/dpkg.te	2002-09-21 06:04:23.000000000 +0200
+++ ./domains/program/dpkg.te	2002-09-25 17:03:40.000000000 +0200
@@ -41,6 +41,8 @@
 allow cardmgr_t dpkg_t:fd use;
 allow cardmgr_t dpkg_t:fifo_file write;
 domain_auto_trans(dpkg_t, { cardctl_exec_t cardmgr_exec_t }, cardmgr_t)
+# for start-stop-daemon
+allow dpkg_t cardmgr_t:process signull;
 ')
 ifdef(`netscape.te', `
 # hate to do this, for netscape install scripts
@@ -115,7 +117,7 @@
 ')
 
 r_dir_file(install_menu_t, var_lib_dpkg_t)
-allow { install_menu_t userdomain system_crond_t } etc_dpkg_t:file r_file_perms;
+allow { apt_t install_menu_t userdomain system_crond_t } etc_dpkg_t:file r_file_perms;
 can_exec(sysadm_t, etc_dpkg_t)
 
 # Inherit and use descriptors from any domain.
@@ -224,6 +226,7 @@
 allow install_menu_t { bin_t sbin_t }:dir search;
 allow install_menu_t bin_t:lnk_file read;
 
+allow install_menu_t var_t:dir search;
 file_type_auto_trans(install_menu_t, var_run_t, install_menu_var_run_t)
 file_type_auto_trans(install_menu_t, tmp_t, install_menu_tmp_t)
 
@@ -237,7 +240,7 @@
 domain_auto_trans(dpkg_t, install_menu_exec_t, install_menu_t)
 allow dpkg_t install_menu_t:process signal_perms;
 
-allow install_menu_t newrole_t:fd use;
+allow install_menu_t privfd:fd use;
 uses_shlib(install_menu_t)
 
 allow install_menu_t self:process { fork sigchld };
diff -ru /tmp/policy/domains/program/fcron.te ./domains/program/fcron.te
--- /tmp/policy/domains/program/fcron.te	2002-09-21 05:01:26.000000000 +0200
+++ ./domains/program/fcron.te	2002-09-10 22:35:26.000000000 +0200
@@ -6,8 +6,8 @@
 #
 # Author: Russell Coker <russell@coker.com.au>
 
-# ideally we would not give it privowner!
-daemon_domain(fcron, `, privuser, privrole, privmail, privfd, privowner')
+# ideally we would not give it privowner or auth!
+daemon_domain(fcron, `, privuser, privrole, privmail, privfd, privowner, auth')
 
 general_domain_access(fcron_t)
 
diff -ru /tmp/policy/domains/program/fingerd.te ./domains/program/fingerd.te
--- /tmp/policy/domains/program/fingerd.te	2002-09-21 05:01:26.000000000 +0200
+++ ./domains/program/fingerd.te	2002-09-24 13:08:25.000000000 +0200
@@ -20,11 +20,15 @@
 
 type var_log_fingerd_t, file_type, sysadmfile, logfile;
 file_type_auto_trans(fingerd_t, var_log_t, var_log_fingerd_t)
+system_crond_entry(fingerd_exec_t, fingerd_t)
 
 allow fingerd_t fingerd_port_t:tcp_socket name_bind;
 ifdef(`inetd.te', `
 allow inetd_t fingerd_port_t:tcp_socket name_bind;
 ')
+ifdef(`tcpd.te', `
+domain_auto_trans(tcpd_t, fingerd_exec_t, fingerd_t)
+')
 
 # can be run from inetd
 domain_auto_trans(inetd_t, fingerd_exec_t, fingerd_t)
diff -ru /tmp/policy/domains/program/initrc.te ./domains/program/initrc.te
--- /tmp/policy/domains/program/initrc.te	2002-09-26 13:37:04.000000000 +0200
+++ ./domains/program/initrc.te	2002-09-25 00:03:35.000000000 +0200
@@ -9,7 +9,12 @@
 # initrc_t is the domain of the init rc scripts.
 # initrc_exec_t is the type of the init program.
 #
+ifdef(`sendmail.te', `
+# do not use privmail for sendmail as it creates a type transition conflict
 type initrc_t, domain, privlog, privowner;
+', `
+type initrc_t, domain, privlog, privowner, privmail;
+')
 role system_r types initrc_t;
 every_domain(initrc_t)
 type initrc_exec_t, file_type, sysadmfile, exec_type;
diff -ru /tmp/policy/domains/program/ircd.te ./domains/program/ircd.te
--- /tmp/policy/domains/program/ircd.te	2002-09-21 05:01:27.000000000 +0200
+++ ./domains/program/ircd.te	2002-09-21 06:07:04.000000000 +0200
@@ -21,7 +21,7 @@
 type var_lib_ircd_t, sysadmfile, file_type;
 file_type_auto_trans(ircd_t, var_lib_t, var_lib_ircd_t)
 
-#allow ircd_t sysadm_devpts_t:chr_file rw_file_perms;
+#allow ircd_t admin_tty_type:chr_file rw_file_perms;
 
 # Use the network.
 can_network(ircd_t)
diff -ru /tmp/policy/domains/program/kcheckpass.te ./domains/program/kcheckpass.te
--- /tmp/policy/domains/program/kcheckpass.te	2002-09-21 05:01:27.000000000 +0200
+++ ./domains/program/kcheckpass.te	2002-09-23 01:01:09.000000000 +0200
@@ -33,6 +33,7 @@
 allow kcheckpass_t fs_t:filesystem getattr;
 
 dontaudit kcheckpass_t user_home_dir_type:dir search;
+dontaudit kcheckpass_t user_home_type:dir read;
 dontaudit kcheckpass_t xdm_t:fd use;
 dontaudit kcheckpass_t user_tmpfile:file read;
 dontaudit kcheckpass_t device_t:dir search;
diff -ru /tmp/policy/domains/program/ldconfig.te ./domains/program/ldconfig.te
--- /tmp/policy/domains/program/ldconfig.te	2002-09-21 05:01:27.000000000 +0200
+++ ./domains/program/ldconfig.te	2002-09-15 19:23:39.000000000 +0200
@@ -13,8 +13,8 @@
 role system_r types ldconfig_t;
 
 domain_auto_trans({ sysadm_t initrc_t ifdef(`dpkg.te', `dpkg_t') }, ldconfig_exec_t, ldconfig_t)
-allow ldconfig_t device_t:dir search;
-allow ldconfig_t { sysadm_devpts_t sysadm_tty_device_t }:chr_file rw_file_perms;
+dontaudit ldconfig_t device_t:dir search;
+allow ldconfig_t admin_tty_type:chr_file rw_file_perms;
 allow ldconfig_t privfd:fd use;
 
 uses_shlib(ldconfig_t)
diff -ru /tmp/policy/domains/program/logrotate.te ./domains/program/logrotate.te
--- /tmp/policy/domains/program/logrotate.te	2002-09-21 05:01:27.000000000 +0200
+++ ./domains/program/logrotate.te	2002-09-23 02:25:31.000000000 +0200
@@ -15,14 +15,14 @@
 every_domain(logrotate_t)
 type logrotate_exec_t, file_type, sysadmfile, exec_type;
 domain_auto_trans(system_crond_t, logrotate_exec_t, logrotate_t)
+allow logrotate_t crond_t:fifo_file write;
 domain_auto_trans(sysadm_t, logrotate_exec_t, logrotate_t)
 
 # it should not require this
 allow logrotate_t sysadm_home_dir_t:dir { read getattr search };
 
 # Create temporary files.
-type logrotate_tmp_t, file_type, sysadmfile, tmpfile;
-file_type_auto_trans(logrotate_t, tmp_t, logrotate_tmp_t)
+tmp_domain(logrotate)
 
 # Run helper programs.
 can_exec_any(logrotate_t)
@@ -52,10 +52,12 @@
 ')
 
 # Change ownership on log files.
-allow logrotate_t logrotate_t:capability { chown dac_override kill fsetid fowner };
+allow logrotate_t self:capability { chown dac_override kill fsetid fowner };
+# for mailx
+dontaudit logrotate_t self:capability { setuid setgid };
 
 ifdef(`mta.te', `
-allow system_mail_t logrotate_tmp_t:file r_file_perms;
+allow { system_mail_t mta_user_agent } logrotate_tmp_t:file r_file_perms;
 ')
 
 # Write to /var/lib/logrotate.status - should be moved into its own type.
diff -ru /tmp/policy/domains/program/lpd.te ./domains/program/lpd.te
--- /tmp/policy/domains/program/lpd.te	2002-09-09 19:54:12.000000000 +0200
+++ ./domains/program/lpd.te	2002-09-24 14:23:21.000000000 +0200
@@ -32,6 +32,7 @@
 type checkpc_t, domain, privlog;
 role system_r types checkpc_t;
 every_domain(checkpc_t)
+log_domain(checkpc)
 type checkpc_exec_t, file_type, sysadmfile, exec_type;
 domain_auto_trans({ initrc_t system_crond_t }, checkpc_exec_t, checkpc_t)
 allow checkpc_t crond_t:fd use;
diff -ru /tmp/policy/domains/program/mrtg.te ./domains/program/mrtg.te
--- /tmp/policy/domains/program/mrtg.te	2002-09-21 05:01:27.000000000 +0200
+++ ./domains/program/mrtg.te	2002-09-19 10:39:55.000000000 +0200
@@ -34,6 +34,7 @@
 can_exec(mrtg_t, { shell_exec_t bin_t sbin_t })
 allow mrtg_t { bin_t sbin_t }:dir { getattr search };
 allow mrtg_t bin_t:lnk_file read;
+allow mrtg_t var_t:dir { getattr search };
 r_dir_file(mrtg_t, var_lib_snmpd_t)
 
 ifdef(`snmpd.te', `
@@ -55,6 +56,7 @@
 allow mrtg_t sysctl_kernel_t:file read;
 
 # for uptime
+allow mrtg_t var_run_t:dir search;
 allow mrtg_t initrc_var_run_t:file read;
 dontaudit mrtg_t initrc_var_run_t:file { write lock };
 allow mrtg_t etc_runtime_t:file { getattr read };
diff -ru /tmp/policy/domains/program/mta.te ./domains/program/mta.te
--- /tmp/policy/domains/program/mta.te	2002-09-21 05:01:27.000000000 +0200
+++ ./domains/program/mta.te	2002-09-25 19:37:31.000000000 +0200
@@ -31,9 +31,15 @@
 allow mta_user_agent userdomain:process sigchld;
 allow mta_user_agent { userdomain privfd }:fd use;
 allow mta_user_agent crond_t:process sigchld;
-allow mta_user_agent crond_t:fifo_file { read write };
 allow mta_user_agent sysadm_t:fifo_file { read write };
 
+allow { system_mail_t mta_user_agent } privmail:fd use;
+allow { system_mail_t mta_user_agent } privmail:fifo_file rw_file_perms;
+
+# for piping mail to a command
+can_exec(mta_delivery_agent, shell_exec_t)
+allow mta_delivery_agent bin_t:dir search;
+allow mta_delivery_agent bin_t:lnk_file read;
+allow mta_delivery_agent devtty_t:chr_file rw_file_perms;
+allow mta_delivery_agent { etc_runtime_t proc_t }:file { getattr read };
 
-allow system_mail_t privmail:fd use;
-allow system_mail_t privmail:fifo_file rw_file_perms;
diff -ru /tmp/policy/domains/program/mysqld.te ./domains/program/mysqld.te
--- /tmp/policy/domains/program/mysqld.te	2002-08-23 20:44:19.000000000 +0200
+++ ./domains/program/mysqld.te	2002-09-22 22:54:16.000000000 +0200
@@ -47,3 +47,11 @@
 # for /root/.my.cnf - should not be needed
 allow mysqld_t sysadm_home_dir_t:dir search;
 allow mysqld_t sysadm_home_t:file { read getattr };
+
+ifdef(`logrotate.te', `
+r_dir_file(logrotate_t, etc_mysqld_t)
+allow logrotate_t mysqld_db_t:dir search;
+allow logrotate_t var_run_mysqld_t:dir search;
+allow logrotate_t var_run_mysqld_t:sock_file write;
+can_unix_connect(logrotate_t, mysqld_t)
+')
diff -ru /tmp/policy/domains/program/named.te ./domains/program/named.te
--- /tmp/policy/domains/program/named.te	2002-09-21 06:04:23.000000000 +0200
+++ ./domains/program/named.te	2002-09-21 19:30:52.000000000 +0200
@@ -92,7 +92,7 @@
 domain_auto_trans(sysadm_t, ndc_exec_t, ndc_t)
 uses_shlib(ndc_t)
 can_tcp_connect(ndc_t, named_t)
-allow { named_t ndc_t } rndc_conf_t:file { getattr read };
+allow { named_t ndc_t initrc_t } rndc_conf_t:file { getattr read };
 
 allow ndc_t etc_t:dir r_dir_perms;
 allow ndc_t self:unix_stream_socket create_stream_socket_perms;
@@ -100,6 +100,9 @@
 allow ndc_t self:capability dac_override;
 allow ndc_t var_run_named_t:sock_file rw_file_perms;
 allow ndc_t named_t:unix_stream_socket connectto;
+allow ndc_t privfd:fd use;
+# seems to need read as well for some reason
+allow ndc_t admin_tty_type:chr_file { getattr read write };
 
 # for ndc_t to be used for restart shell scripts
 ifdef(`ndc_shell_script', `
diff -ru /tmp/policy/domains/program/ntpd.te ./domains/program/ntpd.te
--- /tmp/policy/domains/program/ntpd.te	2002-09-09 19:54:13.000000000 +0200
+++ ./domains/program/ntpd.te	2002-09-13 23:24:30.000000000 +0200
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
diff -ru /tmp/policy/domains/program/portmap.te ./domains/program/portmap.te
--- /tmp/policy/domains/program/portmap.te	2002-09-26 13:37:04.000000000 +0200
+++ ./domains/program/portmap.te	2002-09-25 00:03:35.000000000 +0200
@@ -30,7 +30,8 @@
 # Send to ypbind, initrc, rpc.statd, xinetd.
 ifdef(`ypbind.te',
 `can_udp_send(portmap_t, ypbind_t)')
-can_udp_send(portmap_t, initrc_t)
+can_udp_send(portmap_t, { initrc_t init_t })
+can_udp_send(init_t, portmap_t)
 ifdef(`rpcd.te',
 `can_udp_send(portmap_t, rpcd_t)')
 ifdef(`inetd.te',
diff -ru /tmp/policy/domains/program/portslave.te ./domains/program/portslave.te
--- /tmp/policy/domains/program/portslave.te	2002-08-23 20:44:19.000000000 +0200
+++ ./domains/program/portslave.te	2002-09-20 05:19:59.000000000 +0200
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
 
 
diff -ru /tmp/policy/domains/program/postfix.te ./domains/program/postfix.te
--- /tmp/policy/domains/program/postfix.te	2002-09-21 05:01:27.000000000 +0200
+++ ./domains/program/postfix.te	2002-09-13 10:56:28.000000000 +0200
@@ -88,7 +88,8 @@
 allow postfix_master_t privfd:fd use;
 allow postfix_master_t etc_aliases_t:file r_file_perms;
 create_dir_file(postfix_master_t, postfix_spool_flush_t)
-#allow postfix_master_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file { read write };
+# should not need read, getattr does not matter
+allow postfix_master_t admin_tty_type:chr_file { getattr read write };
 
 # allow access to deferred queue
 allow postfix_master_t postfix_spool_t:dir create_dir_perms;
diff -ru /tmp/policy/domains/program/postgresql.te ./domains/program/postgresql.te
--- /tmp/policy/domains/program/postgresql.te	2002-09-21 05:01:28.000000000 +0200
+++ ./domains/program/postgresql.te	2002-09-25 17:08:04.000000000 +0200
@@ -11,16 +11,18 @@
 #
 daemon_domain(postgresql)
 
+# postgresql will not start (from an admin shell) without this!
+allow postgresql_t admin_tty_type:chr_file { read write };
+
 ifdef(`dpkg.te', `
 # gross hack
 domain_auto_trans(dpkg_t, postgresql_exec_t, postgresql_t)
 ')
-# a grosser hack, and not a good idea
-#allow postgresql_t etc_t:file setattr;
 
 dontaudit postgresql_t { sysadm_home_dir_t var_spool_t }:dir search;
 
-allow postgresql_t self:capability { dac_override dac_read_search chown fowner fsetid setuid setgid };
+# capability kill is for shutdown script
+allow postgresql_t self:capability { kill dac_override dac_read_search chown fowner fsetid setuid setgid };
 
 type etc_postgresql_t, file_type, sysadmfile;
 type postgresql_db_t, file_type, sysadmfile;
@@ -28,7 +30,14 @@
 
 file_type_auto_trans(postgresql_t, var_log_t, postgresql_log_t)
 
-allow postgresql_t system_crond_script_t:file { getattr read };
+# allow crond to find /usr/lib/postgresql/bin/do.maintenance
+allow crond_t postgresql_db_t:dir search;
+
+domain_auto_trans(system_crond_t, postgresql_exec_t, postgresql_t)
+allow postgresql_t crond_t:fifo_file { getattr read write ioctl };
+
+# what is this for?
+#allow postgresql_t system_crond_script_t:file { getattr read };
 
 tmp_domain(postgresql);
 file_type_auto_trans(postgresql_t, tmpfs_t, postgresql_tmp_t)
@@ -39,6 +48,7 @@
 can_network(postgresql_t)
 allow postgresql_t self:fifo_file { getattr read write ioctl };
 allow postgresql_t self:unix_stream_socket create_stream_socket_perms;
+can_unix_connect(postgresql_t, self)
 allow postgresql_t self:unix_dgram_socket create_socket_perms;
 
 allow postgresql_t self:shm rw_shm_perms;
@@ -47,6 +57,7 @@
 can_tcp_connect(userdomain, postgresql_t)
 
 allow postgresql_t proc_t:file { getattr read };
+allow postgresql_t fs_t:filesystem getattr;
 
 # Allow access to the postgresql databases
 create_dir_file(postgresql_t, postgresql_db_t)
@@ -70,10 +81,6 @@
 allow postgresql_t bin_t:lnk_file read;
 allow postgresql_t postgresql_exec_t:lnk_file read;
 
-# Not a good idea.
-#allow postgresql_t initrc_var_run_t:file { read write lock };
-allow postgresql_t initrc_var_run_t:file { read };
-
 allow postgresql_t self:sem rw_sem_perms;
 
 allow postgresql_t self:udp_socket recvfrom;
diff -ru /tmp/policy/domains/program/procmail.te ./domains/program/procmail.te
--- /tmp/policy/domains/program/procmail.te	2002-09-09 19:54:14.000000000 +0200
+++ ./domains/program/procmail.te	2002-09-21 05:33:25.000000000 +0200
@@ -35,7 +35,7 @@
 # for /var/mail
 rw_dir_create_file(procmail_t, mail_spool_t)
 
-allow procmail_t var_t:dir r_dir_perms;
+allow procmail_t var_t:dir { getattr search };
 allow procmail_t var_spool_t:dir r_dir_perms;
 
 allow procmail_t fs_t:filesystem getattr;
diff -ru /tmp/policy/domains/program/qmail.te ./domains/program/qmail.te
--- /tmp/policy/domains/program/qmail.te	2002-08-23 20:44:19.000000000 +0200
+++ ./domains/program/qmail.te	2002-09-24 13:11:03.000000000 +0200
@@ -88,7 +88,7 @@
 allow qmail_clean_t qmail_spool_t:file { unlink read getattr };
 
 # privhome will do until we get a separate maildir type
-daemon_sub_domain(qmail_lspawn_t, qmail_local, `, privhome')
+daemon_sub_domain(qmail_lspawn_t, qmail_local, `, privhome, mta_delivery_agent')
 allow qmail_lspawn_t qmail_local_exec_t:file read;
 allow qmail_local_t self:process fork;
 domain_auto_trans(qmail_local_t, qmail_queue_exec_t, qmail_queue_t)
@@ -131,7 +131,7 @@
 role sysadm_r types qmail_inject_t;
 in_user_role(qmail_inject_t)
 
-daemon_sub_domain(userdomain, qmail_qread)
+daemon_sub_domain(userdomain, qmail_qread, `, mta_user_agent')
 in_user_role(qmail_qread_t)
 r_dir_file(qmail_qread_t, qmail_spool_t)
 allow qmail_qread_t self:capability dac_override;
@@ -140,7 +140,7 @@
 allow qmail_qread_t etc_qmail_t:dir search;
 allow qmail_qread_t privfd:fd use;
 
-daemon_sub_domain(qmail_inject_t, qmail_queue)
+daemon_sub_domain(qmail_inject_t, qmail_queue, `, mta_user_agent')
 role sysadm_r types qmail_queue_t;
 in_user_role(qmail_queue_t)
 allow qmail_inject_t qmail_queue_exec_t:file read;
diff -ru /tmp/policy/domains/program/radius.te ./domains/program/radius.te
--- /tmp/policy/domains/program/radius.te	2002-08-26 18:50:43.000000000 +0200
+++ ./domains/program/radius.te	2002-09-22 22:58:15.000000000 +0200
@@ -48,7 +48,8 @@
 
 allow radiusd_t devtty_t:chr_file { read write };
 allow radiusd_t self:fifo_file rw_file_perms;
-allow radiusd_t self:capability { kill setuid setgid dac_override };
+# fsetid is for gzip which needs it when run from scripts
+allow radiusd_t self:capability { fsetid kill setuid setgid dac_override };
 
 can_network(radiusd_t)
 allow radiusd_t { radius_port_t radacct_port_t }:udp_socket name_bind;
diff -ru /tmp/policy/domains/program/radvd.te ./domains/program/radvd.te
--- /tmp/policy/domains/program/radvd.te	2002-09-09 19:54:14.000000000 +0200
+++ ./domains/program/radvd.te	2002-09-21 06:10:51.000000000 +0200
@@ -14,6 +14,8 @@
 allow radvd_t self:{ rawip_socket unix_dgram_socket } rw_socket_perms;
 allow radvd_t self:{ rawip_socket } recvfrom;
 
+allow radvd_t admin_tty_type:chr_file { read write };
+
 allow radvd_t self:capability { net_raw };
 allow radvd_t self:{ unix_dgram_socket rawip_socket } create;
 allow radvd_t self:unix_stream_socket create_socket_perms;
diff -ru /tmp/policy/domains/program/rpcd.te ./domains/program/rpcd.te
--- /tmp/policy/domains/program/rpcd.te	2002-09-26 13:37:04.000000000 +0200
+++ ./domains/program/rpcd.te	2002-09-25 17:24:29.000000000 +0200
@@ -14,8 +14,9 @@
 every_domain(rpcd_t)
 type rpcd_exec_t, file_type, sysadmfile, exec_type;
 domain_auto_trans(initrc_t, rpcd_exec_t, rpcd_t)
-can_udp_send(initrc_t, rpcd_t)
-can_udp_send(rpcd_t, initrc_t)
+can_udp_send({ init_t initrc_t }, rpcd_t)
+can_udp_send(rpcd_t, { init_t initrc_t })
+
 can_udp_send(rpcd_t, rpcd_t)
 can_udp_send(mount_t, rpcd_t)
 can_udp_send(rpcd_t, mount_t)
diff -ru /tmp/policy/domains/program/slapd.te ./domains/program/slapd.te
--- /tmp/policy/domains/program/slapd.te	2002-08-23 20:44:19.000000000 +0200
+++ ./domains/program/slapd.te	2002-09-21 05:51:20.000000000 +0200
@@ -18,6 +18,9 @@
 type slapd_db_t, file_type, sysadmfile;
 type slapd_replog_t, file_type, sysadmfile;
 
+# slapd will not start (from an admin shell) without this!
+allow slapd_t admin_tty_type:chr_file { read write };
+
 tmp_domain(slapd)
 
 # Use the network.
diff -ru /tmp/policy/domains/program/sxid.te ./domains/program/sxid.te
--- /tmp/policy/domains/program/sxid.te	2002-09-21 05:01:28.000000000 +0200
+++ ./domains/program/sxid.te	2002-09-23 23:11:45.000000000 +0200
@@ -38,9 +38,6 @@
 allow sxid_t self:unix_stream_socket create_socket_perms;
 
 allow sxid_t { proc_t self }:file { read getattr };
-ifdef(`mta.te', `
-allow system_mail_t sxid_t:file { read getattr };
-')
 allow sxid_t { sysctl_kernel_t sysctl_t }:dir search;
 allow sxid_t sysctl_kernel_t:file read;
 allow sxid_t devtty_t:chr_file rw_file_perms;
@@ -49,10 +46,13 @@
 dontaudit sxid_t self:capability { setuid setgid };
 
 ifdef(`mta.te', `
+# sxid leaves an open file handle to /proc/mounts
+dontaudit { system_mail_t mta_user_agent } sxid_t:file { read getattr };
+
 # allow mta to read the log files
-allow system_mail_t { sxid_tmp_t var_log_sxid_t }:file { getattr read };
+allow { system_mail_t mta_user_agent } { sxid_tmp_t var_log_sxid_t }:file { getattr read };
 # stop warnings if mailx is passed a read/write file handle
-dontaudit system_mail_t { sxid_tmp_t var_log_sxid_t }:file write;
+dontaudit { system_mail_t mta_user_agent } { sxid_tmp_t var_log_sxid_t }:file write;
 ')
 
 allow logrotate_t sxid_t:file { getattr write };
diff -ru /tmp/policy/domains/program/sysstat.te ./domains/program/sysstat.te
--- /tmp/policy/domains/program/sysstat.te	2002-09-21 05:01:28.000000000 +0200
+++ ./domains/program/sysstat.te	2002-09-19 11:49:41.000000000 +0200
@@ -35,6 +35,7 @@
 # Type for files created during execution of sysstatd.
 type var_log_sysstat_t, file_type, sysadmfile;
 
+allow sysstat_t var_t:dir search;
 allow sysstat_t var_log_t:dir r_dir_perms;
 allow sysstat_t var_log_sysstat_t:dir rw_dir_perms;
 allow sysstat_t var_log_sysstat_t:file create_file_perms;
diff -ru /tmp/policy/domains/program/tmpreaper.te ./domains/program/tmpreaper.te
--- /tmp/policy/domains/program/tmpreaper.te	2002-09-09 19:54:16.000000000 +0200
+++ ./domains/program/tmpreaper.te	2002-09-21 05:37:06.000000000 +0200
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
@@ -22,7 +26,7 @@
 allow tmpreaper_t self:capability { dac_override dac_read_search fowner };
 
 r_dir_file(tmpreaper_t, etc_t)
-r_dir_file(tmpreaper_t, var_t)
+allow tmpreaper_t var_t:dir { getattr search };
 r_dir_file(tmpreaper_t, var_lib_t)
 allow tmpreaper_t device_t:dir { getattr search };
 
diff -ru /tmp/policy/domains/program/transproxy.te ./domains/program/transproxy.te
--- /tmp/policy/domains/program/transproxy.te	2002-09-09 19:54:16.000000000 +0200
+++ ./domains/program/transproxy.te	2002-09-21 05:37:35.000000000 +0200
@@ -16,7 +16,7 @@
 # Use the network.
 can_network(transproxy_t)
 allow transproxy_t transproxy_port_t:tcp_socket name_bind;
-#allow transproxy_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file { read write };
+#allow transproxy_t admin_tty_type:chr_file { read write };
 
 #allow transproxy_t self:fifo_file { read write };
 allow transproxy_t self:unix_stream_socket create_socket_perms;
diff -ru /tmp/policy/file_contexts/program/apache.fc ./file_contexts/program/apache.fc
--- /tmp/policy/file_contexts/program/apache.fc	2002-09-09 19:54:18.000000000 +0200
+++ ./file_contexts/program/apache.fc	2002-09-24 23:51:30.000000000 +0200
@@ -19,3 +19,4 @@
 /var/log/apache(/.*)?		system_u:object_r:httpd_log_files_t
 /var/log/cgiwrap.log.*		system_u:object_r:httpd_log_files_t
 /var/cache/ssl.*\.sem		system_u:object_r:httpd_cache_t
+/var/run/apache.pid		system_u:object_r:httpd_var_run_t
diff -ru /tmp/policy/file_contexts/program/fingerd.fc ./file_contexts/program/fingerd.fc
--- /tmp/policy/file_contexts/program/fingerd.fc	2002-08-23 20:44:20.000000000 +0200
+++ ./file_contexts/program/fingerd.fc	2002-09-23 13:04:29.000000000 +0200
@@ -1,5 +1,6 @@
 # fingerd
 /usr/sbin/in.fingerd		system_u:object_r:fingerd_exec_t
 /usr/sbin/[cef]fingerd		system_u:object_r:fingerd_exec_t
+/etc/cron.weekly/fingerd	system_u:object_r:fingerd_exec_t
 /etc/cfingerd(/.*)?		system_u:object_r:etc_fingerd_t
 /var/log/cfingerd.log.*		system_u:object_r:var_log_fingerd_t
diff -ru /tmp/policy/file_contexts/program/logrotate.fc ./file_contexts/program/logrotate.fc
--- /tmp/policy/file_contexts/program/logrotate.fc	2002-07-03 22:26:22.000000000 +0200
+++ ./file_contexts/program/logrotate.fc	2002-09-22 23:27:53.000000000 +0200
@@ -1,3 +1,4 @@
 # logrotate
 /usr/sbin/logrotate		system_u:object_r:logrotate_exec_t
+/usr/sbin/logcheck		system_u:object_r:logrotate_exec_t
 /etc/cron.(daily|weekly)/sysklogd system_u:object_r:logrotate_exec_t
diff -ru /tmp/policy/file_contexts/program/openca-common.fc ./file_contexts/program/openca-common.fc
--- /tmp/policy/file_contexts/program/openca-common.fc	2002-08-23 20:44:20.000000000 +0200
+++ ./file_contexts/program/openca-common.fc	2002-09-19 08:49:40.000000000 +0200
@@ -5,4 +5,3 @@
 /var/lib/openca/crypto/keys(/.*)?	system_u:object_r:openca_var_lib_keys_t
 /usr/share/openca(/.*)?			system_u:object_r:openca_usr_share_t
 /usr/share/openca/htdocs(/.*)?		system_u:object_r:httpd_sys_content_t
-/usr/share/openca/cgi-bin/ca(/.*)?	system_u:object_r:openca_ca_exec_t
diff -ru /tmp/policy/file_contexts/program/portslave.fc ./file_contexts/program/portslave.fc
--- /tmp/policy/file_contexts/program/portslave.fc	2002-07-12 17:19:44.000000000 +0200
+++ ./file_contexts/program/portslave.fc	2002-09-25 17:08:32.000000000 +0200
@@ -1,3 +1,4 @@
 # portslave
 /usr/sbin/portslave		system_u:object_r:portslave_exec_t
 /etc/portslave(/.*)?		system_u:object_r:portslave_etc_t
+/var/run/radius.((id)|(seq))	system_u:object_r:var_run_pppd_t
diff -ru /tmp/policy/file_contexts/program/postfix.fc ./file_contexts/program/postfix.fc
--- /tmp/policy/file_contexts/program/postfix.fc	2002-08-26 18:50:44.000000000 +0200
+++ ./file_contexts/program/postfix.fc	2002-09-13 13:49:12.000000000 +0200
@@ -7,7 +7,7 @@
 /usr/lib/postfix/local		system_u:object_r:postfix_local_exec_t
 /usr/lib/postfix/master		system_u:object_r:postfix_master_exec_t
 /usr/lib/postfix/pickup		system_u:object_r:postfix_pickup_exec_t
-/usr/lib/postfix/qmgr		system_u:object_r:postfix_qmgr_exec_t
+/usr/lib/postfix/(n)?qmgr	system_u:object_r:postfix_qmgr_exec_t
 /usr/lib/postfix/showq		system_u:object_r:postfix_showq_exec_t
 /usr/lib/postfix/smtp		system_u:object_r:postfix_smtp_exec_t
 /usr/lib/postfix/smtpd		system_u:object_r:postfix_smtpd_exec_t
diff -ru /tmp/policy/file_contexts/program/radius.fc ./file_contexts/program/radius.fc
--- /tmp/policy/file_contexts/program/radius.fc	2002-07-12 17:19:44.000000000 +0200
+++ ./file_contexts/program/radius.fc	2002-09-24 14:56:20.000000000 +0200
@@ -7,3 +7,5 @@
 /var/log/radutmp		system_u:object_r:var_log_radiusd_t
 /var/log/radwtmp.*		system_u:object_r:var_log_radiusd_t
 /etc/cron.(daily|monthly)/radiusd system_u:object_r:radiusd_exec_t
+/etc/cron.(daily|weekly|monthly)/freeradius system_u:object_r:radiusd_exec_t
+/var/run/radiusd.pid		system_u:object_r:var_run_radiusd_t
diff -ru /tmp/policy/file_contexts/types.fc ./file_contexts/types.fc
--- /tmp/policy/file_contexts/types.fc	2002-09-09 19:54:17.000000000 +0200
+++ ./file_contexts/types.fc	2002-09-25 00:10:26.000000000 +0200
@@ -94,7 +95,7 @@
 /bin/tcsh			system_u:object_r:shell_exec_t
 /bin/bash			system_u:object_r:shell_exec_t
 /bin/bash2			system_u:object_r:shell_exec_t
-/bin/ash			system_u:object_r:shell_exec_t
+/bin/d?ash			system_u:object_r:shell_exec_t
 /bin/zsh.*			system_u:object_r:shell_exec_t
 /bin/ls				system_u:object_r:ls_exec_t
 
@@ -129,6 +130,7 @@
 /dev/nb[^/]+			system_u:object_r:fixed_disk_device_t
 /dev/ataraid/.*			system_u:object_r:fixed_disk_device_t
 /dev/loop.*			system_u:object_r:fixed_disk_device_t
+/dev/ram.*			system_u:object_r:fixed_disk_device_t
 /dev/s(cd|r)[^/]*		system_u:object_r:removable_device_t
 /dev/fd[^/]+			system_u:object_r:removable_device_t
 /dev/rtc			system_u:object_r:clock_device_t
diff -ru /tmp/policy/genfs_contexts ./genfs_contexts
--- /tmp/policy/genfs_contexts	2002-09-21 05:01:24.000000000 +0200
+++ ./genfs_contexts	2002-09-15 19:17:05.000000000 +0200
@@ -84,6 +84,8 @@
 ')
 ifdef(`lpd.te', `
 genfscon devfs /printers	-c	system_u:object_r:printer_t
+genfscon devfs /lp		-c	system_u:object_r:printer_t
+genfscon devfs /usb/lp		-c	system_u:object_r:printer_t
 ')
 genfscon devfs /ppp			system_u:object_r:ppp_device_t
 genfscon devfs /fb	-c		system_u:object_r:framebuf_device_t
diff -ru /tmp/policy/macros/global_macros.te ./macros/global_macros.te
--- /tmp/policy/macros/global_macros.te	2002-09-26 13:37:04.000000000 +0200
+++ ./macros/global_macros.te	2002-09-25 23:28:04.000000000 +0200
@@ -928,7 +928,7 @@
 allow $1_t { self proc_t }:dir r_dir_perms;
 allow $1_t { self proc_t }:lnk_file read;
 
-allow $1_t device_t:dir search;
+allow $1_t device_t:dir { getattr search };
 allow $1_t null_device_t:chr_file rw_file_perms;
 allow $1_t console_device_t:chr_file rw_file_perms;
 ')dnl
@@ -936,7 +936,7 @@
 define(`daemon_domain', `
 daemon_base_domain($1, `$2')
 # Create pid file.
-allow $1_t var_t:dir search;
+allow $1_t var_t:dir { getattr search };
 type var_run_$1_t, file_type, sysadmfile, pidfile;
 file_type_auto_trans($1_t, var_run_t, var_run_$1_t)
 
@@ -1014,7 +1014,7 @@
 ')
 
 define(`system_domain', `
-type $1_t, domain, privlog;
+type $1_t, domain, privlog $2;
 type $1_exec_t, file_type, sysadmfile, exec_type;
 role system_r types $1_t;
 uses_shlib($1_t)
diff -ru /tmp/policy/macros/program/crond_macros.te ./macros/program/crond_macros.te
--- /tmp/policy/macros/program/crond_macros.te	2002-08-23 20:44:20.000000000 +0200
+++ ./macros/program/crond_macros.te	2002-09-23 13:02:27.000000000 +0200
@@ -74,3 +74,13 @@
 # Run scripts in user home directory.
 can_exec($1_crond_t, $1_home_t)
 ')
+
+# When system_crond_t domain executes a type $1 executable then transition to
+# domain $2, allow $2 to interact with crond_t as well.
+define(`system_crond_entry', `
+domain_auto_trans(system_crond_t, $1, $2)
+allow $2 crond_t:fifo_file { getattr read write ioctl };
+# a rule for privfd may make this obsolete
+allow $2 crond_t:fd use;
+allow $2 crond_t:process sigchld;
+')
diff -ru /tmp/policy/macros/program/mta_macros.te ./macros/program/mta_macros.te
--- /tmp/policy/macros/program/mta_macros.te	2002-08-26 18:50:44.000000000 +0200
+++ ./macros/program/mta_macros.te	2002-09-21 21:07:01.000000000 +0200
@@ -62,6 +62,8 @@
 ')
 allow mta_user_agent $1_tmp_t:file { read getattr };
 
+allow mta_user_agent { $1_devpts_t $1_tty_device_t }:chr_file { getattr read write };
+
 # Write to the user domain tty.
 allow $1_mail_t $1_tty_device_t:chr_file rw_file_perms;
 allow $1_mail_t $1_devpts_t:chr_file rw_file_perms;
diff -ru /tmp/policy/macros/program/su_macros.te ./macros/program/su_macros.te
--- /tmp/policy/macros/program/su_macros.te	2002-09-09 19:54:24.000000000 +0200
+++ ./macros/program/su_macros.te	2002-09-17 03:24:12.000000000 +0200
@@ -15,46 +15,49 @@
 # The type declaration for the executable type for this program is
 # provided separately in domains/program/su.te. 
 #
+undefine(`su_mini_domain')
 undefine(`su_domain')
 ifdef(`su.te', `
-define(`su_domain',`
+define(`su_mini_domain', `
 # Derived domain based on the calling user domain and the program.
 type $1_su_t, domain, privlog, auth;
 
 # Transition from the user domain to this domain.
 domain_auto_trans($1_t, su_exec_t, $1_su_t)
 
-# The user role is authorized for this domain.
-role $1_r types $1_su_t;
-
 # This domain is granted permissions common to most domains.
 every_domain($1_su_t)
 
 # Use capabilities.
-allow $1_su_t self:capability { setuid setgid net_bind_service chown dac_override sys_resource };
+allow $1_su_t self:capability { setuid setgid net_bind_service chown dac_override sys_nice sys_resource };
 
 # Revert to the user domain when a shell is executed.
 domain_auto_trans($1_su_t, shell_exec_t, $1_t)
 
-# Run chkpwd.
-can_exec($1_su_t, chkpwd_exec_t)
-
-# Execute xauth.
-can_exec($1_su_t, bin_t)
-
 # Inherit and use descriptors from gnome-pty-helper.
 ifdef(`gnome-pty-helper.te',
 `allow $1_su_t $1_gph_t:fd use;
 allow $1_t $1_gph_t:fd use;')
 
-# Inherit and use descriptors from newrole.
-ifdef(`newrole.te', `allow $1_su_t newrole_t:fd use;')
+allow $1_su_t privfd:fd use;
 
 # Write to utmp.
 allow $1_su_t initrc_var_run_t:file rw_file_perms;
 
 # Use the network.
 can_network($1_su_t)
+')dnl end su_mini_domain
+
+define(`su_domain', `
+su_mini_domain($1)
+# Run chkpwd.
+can_exec($1_su_t, chkpwd_exec_t)
+
+# The user role is authorized for this domain.
+role $1_r types $1_su_t;
+
+# Execute xauth.
+can_exec($1_su_t, bin_t)
 
 # Write to the user domain tty.
 allow $1_su_t $1_tty_device_t:chr_file rw_file_perms;
@@ -70,7 +73,7 @@
 
 # stop su complaining if you run it from a directory with restrictive perms
 dontaudit $1_su_t file_type:dir search;
-')
+')dnl end su_domain
 
 ', `
 
diff -ru /tmp/policy/macros/user_macros.te ./macros/user_macros.te
--- /tmp/policy/macros/user_macros.te	2002-09-26 13:37:05.000000000 +0200
+++ ./macros/user_macros.te	2002-09-23 02:05:36.000000000 +0200
@@ -15,7 +15,7 @@
 undefine(`user_domain')
 define(`user_domain',`
 # Use capabilities
-allow $1_t self:capability { net_bind_service dac_override setuid setgid chown fowner };
+allow $1_t self:capability { setgid chown fowner };
 dontaudit $1_t self:capability { sys_nice fsetid };
 
 # Type for home directory.

--------------Boundary-00=_PUO120A7R0K4JZYH1C6O--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

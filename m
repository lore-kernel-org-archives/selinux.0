Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA00646
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 06:46:16 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA18847
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 11:44:02 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id LAA18843
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 11:43:59 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 42B9A92668
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 22:46:09 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 8F56026D
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 12:46:00 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: policy patch
Date: Fri, 29 Nov 2002 12:45:59 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_N06CJPN9E9H3KMDPLEFF"
Message-Id: <200211291245.59722.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_N06CJPN9E9H3KMDPLEFF
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I've attached my latest patch.  Please read the following before applying.

Steve, apart from a few exceptions I think it's all good for the CVS.

Adds support for flag defines for domains/misc.

Finishes off the changes for the new fcron policy, and uses the 
system_crond_entry() macro more.

Allows automount_t to get the attributes of any fs_type directory because it 
appears to need it.

Puts the "allow daemon fs_t:filesystem getattr;" into the daemon_domain macro 
and removes it from numerous daemons.

Adds the following for devfsd, not sure if it should be needed in an ideal 
situation, but it seems to be needed on some of my systems now for the 
initial boot phase.
allow kernel_t device_t:filesystem mount;

Allow lsof as sysadm_t to see stats on ipsec_t:key_socket.

The latest version of mrtg seems to do some spurious ioctls, that we don't 
want to audit.

ping_t needs to be able to receive from itself for pinging 127.0.0.1.

Finished the changes to xdm that I started some time ago.  Now it's fully 
functional again.

Put in some changes to user.te and rbac.  They make things a bit easier when 
adding multiple user roles (I think).  Steve, let me know if you don't like 
them and I'll re-arrange them a bit.

Fixed fsadm.fc to correctly label all the fsck/mkfs type programs.

Correctly label all the .tdb files for Samba.

Changes to xdm.fc and xserver.fc.  Steve you will want to carefully consider 
my changes to /tmp.  I have been considering the matter for some time (I made 
the change in my tree months ago).  The xdm.fc stuff that isn't related to 
/tmp is all good and should go in however.

Also made some changes to types.fc, Steve, you may not like the /tmp and 
/var/tmp changes.

For the global_macros.te file I added ioctl to rw_dir_perms as previously 
discussed.  Also I gave all daemons access to devtty_t:chr_file and added a 
new macro var_lib_domain().

I made some minor changes to x_client_macros for ssh tunnels and for some 
other types of file access.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_N06CJPN9E9H3KMDPLEFF
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

diff -ruN /tmp/policy/Makefile policy/Makefile
--- /tmp/policy/Makefile	2002-09-27 22:27:36.000000000 +0200
+++ policy/Makefile	2002-11-08 10:31:17.000000000 +0100
@@ -77,6 +79,7 @@
 tmp/program_used_flags.te: $(wildcard domains/program/*.te) domains/program
 	mkdir -p tmp
 	( cd domains/program/ ; for n in *.te ; do echo "define(\`$$n')"; done ) > $@
+	( cd domains/misc/ ; for n in *.te ; do echo "define(\`$$n')"; done ) >> $@
 
 tmp/all_macros.te:  macros $(wildcard macros/*.te) tmp/all_program_macros.te
 	cat $(wildcard macros/*.te) tmp/all_program_macros.te > $@
diff -ruN /tmp/policy/domains/program/acct.te policy/domains/program/acct.te
--- /tmp/policy/domains/program/acct.te	2002-11-29 12:19:33.000000000 +0100
+++ policy/domains/program/acct.te	2002-11-14 23:11:04.000000000 +0100
@@ -10,10 +10,12 @@
 # acct_exec_t is the type of the acct executable.
 #
 daemon_base_domain(acct)
-domain_auto_trans(system_crond_t, acct_exec_t, acct_t)
+ifdef(`crond.te', `
+system_crond_entry(acct_exec_t, acct_t)
 
 # for monthly cron job
 file_type_auto_trans(acct_t, var_log_t, wtmp_t)
+')
 
 ifdef(`logrotate.te', `
 allow acct_t logrotate_exec_t:file getattr;
diff -ruN /tmp/policy/domains/program/automount.te policy/domains/program/automount.te
--- /tmp/policy/domains/program/automount.te	2002-11-29 12:19:34.000000000 +0100
+++ policy/domains/program/automount.te	2002-11-24 10:16:54.000000000 +0100
@@ -33,6 +33,7 @@
 file_type_auto_trans(automount_t, tmp_t, automount_tmp_t)
 
 allow automount_t autofs_t:dir { create_dir_perms ioctl };
+allow automount_t fs_type:dir getattr;
 allow autofs_t self:filesystem associate;
 
 domain_auto_trans(automount_t, fsadm_exec_t, fsadm_t)
diff -ruN /tmp/policy/domains/program/crack.te policy/domains/program/crack.te
--- /tmp/policy/domains/program/crack.te	2002-09-27 22:27:37.000000000 +0200
+++ policy/domains/program/crack.te	2002-11-08 10:32:25.000000000 +0100
@@ -9,18 +9,14 @@
 # crack_exec_t is the type of the crack executable.
 #
 system_domain(crack)
-domain_auto_trans(system_crond_t, crack_exec_t, crack_t)
+ifdef(`crond.te', `
+system_crond_entry(crack_exec_t, crack_t)
+')
 
 type crack_db_t, file_type, sysadmfile;
 allow crack_t var_t:dir search;
 rw_dir_create_file(crack_t, crack_db_t)
 
-allow crack_t crond_t:fd use;
-allow crack_t crond_t:fifo_file r_file_perms;
-ifdef(`fcron.te', `
-allow crack_t fcron_t:fd use;
-allow crack_t fcron_t:fifo_file r_file_perms;
-')
 allow crack_t device_t:dir search;
 allow crack_t devtty_t:chr_file rw_file_perms;
 allow crack_t self:fifo_file { read write getattr };
diff -ruN /tmp/policy/domains/program/crond.te policy/domains/program/crond.te
--- /tmp/policy/domains/program/crond.te	2002-11-29 12:19:34.000000000 +0100
+++ policy/domains/program/crond.te	2002-11-20 14:24:13.000000000 +0100
@@ -71,8 +71,6 @@
 # Run a shell.
 can_exec(crond_t, shell_exec_t)
 
-allow crond_t fs_t:filesystem getattr;
-
 ifdef(`rpm.te',
 `# Run the rpm program in the rpm_t domain. Allow creation of RPM log files
 # via redirection of standard out.
diff -ruN /tmp/policy/domains/program/ddt-client.te policy/domains/program/ddt-client.te
--- /tmp/policy/domains/program/ddt-client.te	2002-08-23 21:04:28.000000000 +0200
+++ policy/domains/program/ddt-client.te	2002-11-20 14:27:02.000000000 +0100
@@ -27,7 +27,6 @@
 
 # Use capabilities
 allow ddt_client_t self:capability { setuid setgid dac_override chown };
-allow ddt_client_t fs_t:filesystem getattr;
 
 allow ddt_client_t etc_t:dir search;
 allow ddt_client_t etc_t:lnk_file read;
diff -ruN /tmp/policy/domains/program/devfsd.te policy/domains/program/devfsd.te
--- /tmp/policy/domains/program/devfsd.te	2002-10-28 22:55:52.000000000 +0100
+++ policy/domains/program/devfsd.te	2002-11-20 14:24:32.000000000 +0100
@@ -27,6 +27,9 @@
 ifdef(`dpkg.te', `
 # for the makedev script - this may be a bad idea
 domain_auto_trans_read(dpkg_t, devfsd_exec_t, devfsd_t)
+
+# for package upgrade
+allow devfsd_t lib_t:file execute;
 ')
 
 # mknod capability is for the startup scripts
@@ -49,8 +52,6 @@
 # allow all devices to be under device_t
 allow file_type device_t:filesystem associate;
 
-allow devfsd_t fs_t:filesystem getattr;
-
 # allow context lookups
 allow devfsd_t security_t:security { context_to_sid sid_to_context };
 
@@ -80,6 +81,8 @@
 
 allow devfsd_t privfd:fd use;
 
+allow kernel_t device_t:filesystem mount;
+
 # for nss-ldap etc
 can_network(devfsd_t)
 allow devfsd_t self:tcp_socket create_socket_perms;
diff -ruN /tmp/policy/domains/program/dpkg.te policy/domains/program/dpkg.te
--- /tmp/policy/domains/program/dpkg.te	2002-11-29 12:19:34.000000000 +0100
+++ policy/domains/program/dpkg.te	2002-11-19 13:57:32.000000000 +0100
@@ -18,6 +18,10 @@
 allow dpkg_t security_t:security load_policy;
 
 can_exec(dpkg_t, { dpkg_exec_t bin_t shell_exec_t tmp_dpkg_t ls_exec_t var_lib_dpkg_t etc_dpkg_t sbin_t })
+ifdef(`rlogind.te', `
+# for ssh
+can_exec(dpkg_t, rlogind_exec_t)
+')
 can_exec(dpkg_t, init_exec_t)
 file_type_auto_trans(dpkg_t, tmp_t, tmp_dpkg_t)
 ifdef(`mta.te', `
@@ -136,8 +140,9 @@
 allow { apt_t install_menu_t userdomain } etc_dpkg_t:file r_file_perms;
 can_exec(sysadm_t, etc_dpkg_t)
 
-# Inherit and use descriptors from any domain.
+# Inherit and use descriptors from open_init_pty
 allow { apt_t dpkg_t install_menu_t } initrc_t:fd use;
+dontaudit dpkg_t privfd:fd use;
 allow { apt_t dpkg_t install_menu_t } devpts_t:dir search;
 allow { apt_t dpkg_t install_menu_t } initrc_devpts_t:chr_file rw_file_perms;
 
diff -ruN /tmp/policy/domains/program/hotplug.te policy/domains/program/hotplug.te
--- /tmp/policy/domains/program/hotplug.te	2002-09-21 05:01:26.000000000 +0200
+++ policy/domains/program/hotplug.te	2002-11-20 14:24:53.000000000 +0100
@@ -34,8 +34,6 @@
 r_dir_file(hotplug_t, usbdevfs_t)
 allow hotplug_t usbdevfs_device_t:file getattr;
 
-allow hotplug_t fs_t:filesystem getattr;
-
 # read config files
 allow hotplug_t etc_t:dir r_dir_perms;
 allow hotplug_t etc_t:{ file lnk_file } r_file_perms;
diff -ruN /tmp/policy/domains/program/ipsec.te policy/domains/program/ipsec.te
--- /tmp/policy/domains/program/ipsec.te	2002-11-04 13:27:51.000000000 +0100
+++ policy/domains/program/ipsec.te	2002-11-17 03:11:03.000000000 +0100
@@ -56,6 +56,9 @@
 
 allow ipsec_t self:key_socket { create write read };
 
+# for lsof
+allow sysadm_t ipsec_t:key_socket getattr;
+
 # the ipsec wrapper wants to run /usr/bin/logger (should we put
 # it in its own domain?)
 can_exec(ipsec_mgmt_t, bin_t)
diff -ruN /tmp/policy/domains/program/ircd.te policy/domains/program/ircd.te
--- /tmp/policy/domains/program/ircd.te	2002-10-28 22:55:53.000000000 +0100
+++ policy/domains/program/ircd.te	2002-11-20 14:25:02.000000000 +0100
@@ -29,8 +29,6 @@
 
 allow ircd_t devtty_t:chr_file rw_file_perms;
 
-allow ircd_t fs_t:filesystem getattr;
-
 allow ircd_t sbin_t:dir search;
 
 allow ircd_t proc_t:file { getattr read };
diff -ruN /tmp/policy/domains/program/kcheckpass.te policy/domains/program/kcheckpass.te
--- /tmp/policy/domains/program/kcheckpass.te	2002-10-01 19:28:43.000000000 +0200
+++ policy/domains/program/kcheckpass.te	2002-11-20 01:12:49.000000000 +0100
@@ -34,6 +34,8 @@
 
 dontaudit kcheckpass_t { home_root_t user_home_dir_type }:dir search;
 dontaudit kcheckpass_t user_home_type:dir read;
+ifdef(`xdm.te', `
 dontaudit kcheckpass_t xdm_t:fd use;
+')
 dontaudit kcheckpass_t user_tmpfile:file read;
 dontaudit kcheckpass_t device_t:dir search;
diff -ruN /tmp/policy/domains/program/load_policy.te policy/domains/program/load_policy.te
--- /tmp/policy/domains/program/load_policy.te	2002-11-04 13:27:51.000000000 +0100
+++ policy/domains/program/load_policy.te	2002-11-20 01:02:54.000000000 +0100
@@ -49,3 +49,4 @@
 
 allow load_policy_t { initrc_t privfd }:fd use;
 
+allow load_policy_t fs_t:filesystem getattr;
diff -ruN /tmp/policy/domains/program/lpd.te policy/domains/program/lpd.te
--- /tmp/policy/domains/program/lpd.te	2002-10-17 00:01:10.000000000 +0200
+++ policy/domains/program/lpd.te	2002-11-09 14:53:02.000000000 +0100
@@ -54,7 +54,7 @@
 type lpd_var_run_t, file_type, sysadmfile, pidfile;
 file_type_auto_trans(lpd_t, var_run_t, lpd_var_run_t)
 
-allow checkpc_t lpd_var_run_t:dir getattr;
+allow checkpc_t lpd_var_run_t:dir { search getattr };
 
 
 # This is needed to permit chown to read /var/spool/lpd/lp.
diff -ruN /tmp/policy/domains/program/mailman.te policy/domains/program/mailman.te
--- /tmp/policy/domains/program/mailman.te	2002-10-01 18:40:37.000000000 +0200
+++ policy/domains/program/mailman.te	2002-11-08 10:32:25.000000000 +0100
@@ -86,10 +86,6 @@
 domain_auto_trans(system_crond_t, mailman_queue_exec_t, mailman_queue_t)
 allow mailman_queue_t crond_t:fd use;
 allow mailman_queue_t crond_t:fifo_file { ioctl read write };
-ifdef(`fcron.te', `
-allow mailman_queue_t fcron_t:fd use;
-allow mailman_queue_t fcron_t:fifo_file { ioctl read write };
-')
 allow mailman_queue_t devtty_t:chr_file { read write };
 allow mailman_queue_t self:process { fork signal sigchld };
 
diff -ruN /tmp/policy/domains/program/mrtg.te policy/domains/program/mrtg.te
--- /tmp/policy/domains/program/mrtg.te	2002-10-23 21:38:18.000000000 +0200
+++ policy/domains/program/mrtg.te	2002-11-29 09:35:14.000000000 +0100
@@ -12,10 +12,8 @@
 daemon_base_domain(mrtg)
 
 ifdef(`crond.te', `
-domain_auto_trans(system_crond_t, mrtg_exec_t, mrtg_t)
-allow mrtg_t crond_t:fifo_file { ioctl read write };
+system_crond_entry(mrtg_exec_t, mrtg_t)
 allow mrtg_t cron_log_t:file rw_file_perms;
-allow mrtg_t crond_t:process sigchld;
 ')
 
 type etc_mrtg_t, file_type, sysadmfile;
@@ -44,6 +42,7 @@
 ')
 
 allow mrtg_t proc_t:file { read getattr };
+dontaudit mrtg_t proc_t:file ioctl;
 
 allow mrtg_t { var_lock_t var_lib_t }:dir search;
 rw_dir_create_file(mrtg_t, var_lib_mrtg_t)
@@ -51,6 +50,7 @@
 
 # read config files
 allow mrtg_t { etc_t etc_mrtg_t resolv_conf_t }:file { read getattr };
+dontaudit mrtg_t etc_mrtg_t:file ioctl;
 allow mrtg_t etc_mrtg_t:dir { read search getattr };
 dontaudit mrtg_t etc_mrtg_t:dir write;
 allow mrtg_t etc_t:lnk_file read;
diff -ruN /tmp/policy/domains/program/named.te policy/domains/program/named.te
--- /tmp/policy/domains/program/named.te	2002-11-04 13:27:52.000000000 +0100
+++ policy/domains/program/named.te	2002-11-20 14:25:36.000000000 +0100
@@ -63,8 +63,6 @@
 allow named_t self:unix_stream_socket create_stream_socket_perms;
 allow named_t self:unix_dgram_socket create_socket_perms;
 
-allow named_t fs_t:filesystem getattr;
-
 # Read sysctl kernel variables.
 allow named_t sysctl_t:dir r_dir_perms;
 allow named_t sysctl_kernel_t:dir r_dir_perms;
@@ -112,6 +110,9 @@
 allow ndc_t self:fifo_file { read write getattr ioctl };
 allow ndc_t named_zone_t:dir search;
 
+# for chmod in start script
+dontaudit initrc_t var_run_named_t:dir setattr;
+
 # for ndc_t to be used for restart shell scripts
 ifdef(`ndc_shell_script', `
 allow ndc_t crond_t:fd use;
diff -ruN /tmp/policy/domains/program/ntpd.te policy/domains/program/ntpd.te
--- /tmp/policy/domains/program/ntpd.te	2002-09-27 22:27:38.000000000 +0200
+++ policy/domains/program/ntpd.te	2002-11-20 14:25:48.000000000 +0100
@@ -63,8 +63,6 @@
 
 allow ntpd_t devtty_t:chr_file rw_file_perms;
 
-allow ntpd_t fs_t:filesystem getattr;
-
 can_udp_send(ntpd_t, sysadm_t)
 can_udp_send(sysadm_t, ntpd_t)
 can_udp_send(ntpd_t, ntpd_t)
diff -ruN /tmp/policy/domains/program/ping.te policy/domains/program/ping.te
--- /tmp/policy/domains/program/ping.te	2002-11-04 13:27:52.000000000 +0100
+++ policy/domains/program/ping.te	2002-11-13 19:04:17.000000000 +0100
@@ -24,7 +24,7 @@
 allow ping_t any_socket_t:rawip_socket sendto;
 
 # Let ping receive ICMP replies.
-allow ping_t icmp_socket_t:rawip_socket recvfrom;
+allow ping_t { self icmp_socket_t }:rawip_socket recvfrom;
 
 # Use capabilities.
 allow ping_t ping_t:capability { net_raw setuid };
diff -ruN /tmp/policy/domains/program/postfix.te policy/domains/program/postfix.te
--- /tmp/policy/domains/program/postfix.te	2002-11-29 12:19:35.000000000 +0100
+++ policy/domains/program/postfix.te	2002-11-09 16:27:44.000000000 +0100
@@ -131,6 +131,7 @@
 postfix_server_domain(local, `, mta_delivery_agent')
 ifdef(`procmail.te', `
 domain_auto_trans_read(postfix_local_t, procmail_exec_t, procmail_t)
+# for a bug in the postfix local program
 dontaudit procmail_t postfix_local_t:tcp_socket { read write };
 ')
 allow postfix_local_t { etc_aliases_t }:file r_file_perms;
diff -ruN /tmp/policy/domains/program/postgresql.te policy/domains/program/postgresql.te
--- /tmp/policy/domains/program/postgresql.te	2002-11-29 12:19:35.000000000 +0100
+++ policy/domains/program/postgresql.te	2002-11-20 14:25:55.000000000 +0100
@@ -18,6 +18,9 @@
 
 dontaudit postgresql_t sysadm_home_dir_t:dir search;
 
+# quiet ps
+dontaudit postgresql_t domain:dir getattr;
+
 # for currect directory of scripts
 allow postgresql_t { var_spool_t cron_spool_t }:dir search;
 
@@ -57,7 +60,6 @@
 can_tcp_connect(userdomain, postgresql_t)
 
 allow postgresql_t { proc_t self }:file { getattr read };
-allow postgresql_t fs_t:filesystem getattr;
 
 # Allow access to the postgresql databases
 create_dir_file(postgresql_t, postgresql_db_t)
diff -ruN /tmp/policy/domains/program/pppd.te policy/domains/program/pppd.te
--- /tmp/policy/domains/program/pppd.te	2002-10-01 19:28:45.000000000 +0200
+++ policy/domains/program/pppd.te	2002-11-20 14:26:05.000000000 +0100
@@ -10,11 +10,11 @@
 # pppd_t is the domain for the pppd program.
 # pppd_exec_t is the type of the pppd executable.
 # pppd_secret_t is the type of the pap and chap password files
-# pppd_log_t is the type of the ppp log files
 #
 daemon_domain(pppd, `, privmail')
 type pppd_secret_t, file_type, sysadmfile;
-type pppd_log_t, file_type, sysadmfile, logfile;
+
+log_domain(pppd)
 
 # Use the network.
 can_network(pppd_t)
@@ -22,14 +22,9 @@
 # Use capabilities.
 allow pppd_t self:capability { net_admin setuid setgid fsetid };
 
-allow pppd_t fs_t:filesystem getattr;
-
 allow pppd_t var_lock_t:dir rw_dir_perms;
 allow pppd_t var_lock_t:file create_file_perms;
 
-# allow writing log files
-file_type_auto_trans(pppd_t, var_log_t, pppd_log_t)
-
 # Access secret files
 allow pppd_t pppd_secret_t:file r_file_perms;
 
diff -ruN /tmp/policy/domains/program/procmail.te policy/domains/program/procmail.te
--- /tmp/policy/domains/program/procmail.te	2002-10-10 17:50:17.000000000 +0200
+++ policy/domains/program/procmail.te	2002-11-20 01:07:27.000000000 +0100
@@ -39,6 +39,8 @@
 allow procmail_t var_spool_t:dir r_dir_perms;
 
 allow procmail_t fs_t:filesystem getattr;
+allow procmail_t proc_t:dir search;
+allow procmail_t proc_t:file { getattr read };
 
 # for if /var/mail is a symlink to /var/spool/mail
 #allow procmail_t mail_spool_t:lnk_file r_file_perms;
diff -ruN /tmp/policy/domains/program/qmail.te policy/domains/program/qmail.te
--- /tmp/policy/domains/program/qmail.te	2002-10-17 00:01:13.000000000 +0200
+++ policy/domains/program/qmail.te	2002-11-07 12:38:13.000000000 +0100
@@ -55,6 +55,7 @@
 allow qmail_lspawn_t qmail_spool_t:dir search;
 allow qmail_lspawn_t qmail_spool_t:file { read getattr };
 allow qmail_lspawn_t etc_t:file { getattr read };
+allow qmail_lspawn_t tmp_t:dir getattr;
 dontaudit qmail_lspawn_t user_home_dir_type:dir { getattr search };
 
 qmail_daemon_domain(send)
diff -ruN /tmp/policy/domains/program/snmpd.te policy/domains/program/snmpd.te
--- /tmp/policy/domains/program/snmpd.te	2002-11-04 13:27:54.000000000 +0100
+++ policy/domains/program/snmpd.te	2002-11-20 14:26:16.000000000 +0100
@@ -35,5 +35,4 @@
 
 allow snmpd_t proc_t:dir search;
 allow snmpd_t proc_t:file r_file_perms;
-allow snmpd_t fs_t:filesystem getattr;
 allow snmpd_t self:file { getattr read };
diff -ruN /tmp/policy/domains/program/squid.te policy/domains/program/squid.te
--- /tmp/policy/domains/program/squid.te	2002-10-28 21:31:50.000000000 +0100
+++ policy/domains/program/squid.te	2002-11-20 14:26:24.000000000 +0100
@@ -39,8 +39,6 @@
 
 allow squid_t devtty_t:chr_file rw_file_perms;
 
-allow squid_t fs_t:filesystem getattr;
-
 allow squid_t { self proc_t }:file { read getattr };
 
 # for when we use /var/spool/cache
diff -ruN /tmp/policy/domains/program/ssh.te policy/domains/program/ssh.te
--- /tmp/policy/domains/program/ssh.te	2002-10-28 22:55:57.000000000 +0100
+++ policy/domains/program/ssh.te	2002-11-05 18:37:02.000000000 +0100
@@ -48,6 +48,7 @@
 # sshd_key_t is the type of the ssh private key files
 #
 sshd_program_domain(sshd_t)
+allow sshd_t initrc_devpts_t:chr_file rw_file_perms;
 allow sshd_t ssh_port_t:tcp_socket name_bind;
 sshd_program_domain(sshd_login_t)
 undefine(`sshd_program_domain')
diff -ruN /tmp/policy/domains/program/sxid.te policy/domains/program/sxid.te
--- /tmp/policy/domains/program/sxid.te	2002-09-27 22:27:38.000000000 +0200
+++ policy/domains/program/sxid.te	2002-11-08 10:32:25.000000000 +0100
@@ -13,10 +13,10 @@
 
 allow sxid_t fs_t:filesystem getattr;
 
-domain_auto_trans(system_crond_t, sxid_exec_t, sxid_t)
-allow sxid_t crond_t:fd use;
-allow sxid_t crond_t:fifo_file { read ioctl };
-allow system_crond_t var_log_sxid_t:file create_file_perms;
+ifdef(`crond.te', `
+system_crond_entry(sxid_exec_t, sxid_t)
+')
+#allow system_crond_t var_log_sxid_t:file create_file_perms;
 
 allow sxid_t etc_t:lnk_file read;
 
diff -ruN /tmp/policy/domains/program/tftpd.te policy/domains/program/tftpd.te
--- /tmp/policy/domains/program/tftpd.te	2002-09-21 05:01:28.000000000 +0200
+++ policy/domains/program/tftpd.te	2002-11-20 14:26:35.000000000 +0100
@@ -35,6 +35,3 @@
 
 allow tftpd_t var_t:dir r_dir_perms;
 allow tftpd_t var_t:{ file lnk_file } r_file_perms;
-
-allow tftpd_t fs_t:filesystem getattr;
-
diff -ruN /tmp/policy/domains/program/tmpreaper.te policy/domains/program/tmpreaper.te
--- /tmp/policy/domains/program/tmpreaper.te	2002-10-23 21:38:19.000000000 +0200
+++ policy/domains/program/tmpreaper.te	2002-11-08 10:32:25.000000000 +0100
@@ -15,10 +15,6 @@
 uses_shlib(tmpreaper_t)
 allow tmpreaper_t crond_t:fd use;
 allow tmpreaper_t crond_t:fifo_file { read write };
-ifdef(`fcron.te', `
-allow tmpreaper_t fcron_t:fd use;
-allow tmpreaper_t fcron_t:fifo_file { read write };
-')
 allow tmpreaper_t tmpfile:dir { rw_dir_perms rmdir };
 allow tmpreaper_t tmpfile:notdevfile_class_set { getattr unlink };
 allow tmpreaper_t home_type:notdevfile_class_set { getattr unlink };
diff -ruN /tmp/policy/domains/program/xdm.te policy/domains/program/xdm.te
--- /tmp/policy/domains/program/xdm.te	2002-11-29 12:19:36.000000000 +0100
+++ policy/domains/program/xdm.te	2002-11-09 16:13:05.000000000 +0100
@@ -14,12 +14,20 @@
 # xdm_exec_t is the type of the [xgk]dm program
 #
 daemon_domain(xdm, `, privuser, privrole, auth, privowner, privmem')
-#every_domain(xdm_t)
 tmp_domain(xdm)
+var_lib_domain(xdm)
+# NB we do NOT allow xdm_xserver_t var_lib_xdm_t:dir!!!
+allow xdm_xserver_t var_lib_xdm_t:file { getattr read };
+dontaudit xdm_xserver_t var_lib_xdm_t:dir search;
 type xsession_exec_t, file_type, sysadmfile, exec_type;
 
 allow xdm_t default_context_t:file { read getattr };
 
+can_network(xdm_t)
+allow xdm_t self:unix_stream_socket create_stream_socket_perms;
+allow xdm_t self:unix_dgram_socket create_socket_perms;
+allow xdm_t self:fifo_file rw_file_perms;
+
 # for reboot
 allow xdm_t initctl_t:fifo_file write;
 
@@ -31,6 +39,8 @@
 # Commented out by default.
 #allow xdm_t memory_device_t:chr_file { execute read write };
 
+allow xdm_t random_device_t:chr_file { getattr read };
+
 # Transition to user domains for user sessions.
 domain_trans(xdm_t, xsession_exec_t, unpriv_userdomain)
 
@@ -67,14 +77,14 @@
 allow xdm_t gpmctl_t:sock_file { getattr setattr };')
 
 # Update utmp and wtmp.
-allow xdm_t initrc_var_run_t: file { read write };
+allow xdm_t initrc_var_run_t: file { read write lock };
 allow xdm_t wtmp_t:file { append };
 
 # Update lastlog.
 allow xdm_t lastlog_t:file rw_file_perms;
 
 # Ask the security server for SIDs for user sessions.
-allow xdm_t security_t:security { get_user_sids };
+allow xdm_t security_t:security { get_user_sids context_to_sid };
 
 # Access the shared memory pseudo file system.
 # Should really define a derived type for this.
@@ -93,9 +103,15 @@
 allow xdm_t xfs_tmp_t:sock_file { write };
 can_unix_connect(xdm_t, xfs_t)')
 
+allow xdm_t self:process { setpgid setsched };
+allow xdm_t etc_t:lnk_file read;
+allow xdm_t etc_runtime_t:file { getattr read };
+
 # Signal any user domain.
 allow xdm_t userdomain:process signal_perms;
 
+allow xdm_t proc_t:file { getattr read };
+
 # Search /proc for any user domain processes.
 allow xdm_t userdomain:dir r_dir_perms;
 allow xdm_t userdomain:{ file lnk_file } r_file_perms;
diff -ruN /tmp/policy/domains/user.te policy/domains/user.te
--- /tmp/policy/domains/user.te	2002-10-17 00:01:05.000000000 +0200
+++ policy/domains/user.te	2002-10-23 20:14:43.000000000 +0200
@@ -5,16 +5,26 @@
 full_user_role(user)
 #full_user_role(second_user)
 
-# Add role allow rules in policy/rbac as desired to 
-# support transitions among the user roles, and to permit
-# system_r to transition to user_r.  
+allow system_r user_r;
+#allow system_r second_user_r;
 
-# system_r is authorized for user_t as a fallback for unmodified daemons.
-role system_r types user_t;
+#
+# Allow the user roles to transition
+# into each other.
+#
+allow user_r sysadm_r;
+allow sysadm_r user_r;
+#allow sysadm_r second_user_r;
+
+# if adding new user roles make sure you edit the in_user_role macro in
+# macros/user_macros.te to match
 
 # lots of user programs accidentally search /root, and also the admin often
 # logs in as UID=0 domain=user_t...
 dontaudit unpriv_userdomain sysadm_home_dir_t:dir { getattr search };
 
+# system_r is authorized for user_t as a fallback for unmodified daemons.
+role system_r types user_t;
+
 # "ps aux" and "ls -l /dev/pts" make too much noise without this
 dontaudit unpriv_userdomain ptyfile:chr_file getattr;
diff -ruN /tmp/policy/file_contexts/program/fsadm.fc policy/file_contexts/program/fsadm.fc
--- /tmp/policy/file_contexts/program/fsadm.fc	2002-09-09 19:54:20.000000000 +0200
+++ policy/file_contexts/program/fsadm.fc	2002-11-08 10:33:05.000000000 +0100
@@ -1,12 +1,12 @@
 # fs admin utilities
-/sbin/fsck			system_u:object_r:fsadm_exec_t
-/sbin/fsck\.ext2		system_u:object_r:fsadm_exec_t
-/sbin/fsck\.ext3		system_u:object_r:fsadm_exec_t
+/sbin/fsck.*			system_u:object_r:fsadm_exec_t
+/sbin/mkfs.*			system_u:object_r:fsadm_exec_t
 /sbin/e2fsck			system_u:object_r:fsadm_exec_t
+/sbin/reiserfs(ck|tune)		system_u:object_r:fsadm_exec_t
+/sbin/mkreiserfs		system_u:object_r:fsadm_exec_t
 /sbin/e2label			system_u:object_r:fsadm_exec_t
 /sbin/mkfs			system_u:object_r:fsadm_exec_t
 /sbin/mke2fs			system_u:object_r:fsadm_exec_t
-/sbin/mkfs.ext2			system_u:object_r:fsadm_exec_t
 /sbin/mkswap			system_u:object_r:fsadm_exec_t
 /sbin/scsi_info			system_u:object_r:fsadm_exec_t
 /sbin/sfdisk			system_u:object_r:fsadm_exec_t
diff -ruN /tmp/policy/file_contexts/program/named.fc policy/file_contexts/program/named.fc
--- /tmp/policy/file_contexts/program/named.fc	2002-10-01 19:28:51.000000000 +0200
+++ policy/file_contexts/program/named.fc	2002-11-18 20:37:48.000000000 +0100
@@ -8,4 +8,5 @@
 /usr/sbin/r?ndc			system_u:object_r:ndc_exec_t
 /var/cache/bind(/.*)?		system_u:object_r:named_cache_t
 /var/run/ndc			system_u:object_r:var_run_named_t
+/var/run/bind(/.*)?		system_u:object_r:var_run_named_t
 /usr/sbin/lwresd		system_u:object_r:named_exec_t
diff -ruN /tmp/policy/file_contexts/program/pppd.fc policy/file_contexts/program/pppd.fc
--- /tmp/policy/file_contexts/program/pppd.fc	2002-09-21 05:01:29.000000000 +0200
+++ policy/file_contexts/program/pppd.fc	2002-11-09 14:36:12.000000000 +0100
@@ -6,3 +6,4 @@
 /var/run/pppd.tdb		system_u:object_r:var_run_pppd_t
 /etc/ppp/.*secrets		system_u:object_r:pppd_secret_t
 /var/run/ipppd.*pid		system_u:object_r:var_run_pppd_t
+/var/log/ppp-connect-errors.*	system_u:object_r:pppd_log_t
diff -ruN /tmp/policy/file_contexts/program/samba.fc policy/file_contexts/program/samba.fc
--- /tmp/policy/file_contexts/program/samba.fc	2002-10-28 21:32:43.000000000 +0100
+++ policy/file_contexts/program/samba.fc	2002-11-22 22:40:06.000000000 +0100
@@ -7,3 +7,12 @@
 /var/lib/samba(/.*)?		system_u:object_r:samba_var_t
 /etc/samba/secrets.tdb		system_u:object_r:samba_secrets_t
 /etc/samba/MACHINE.SID		system_u:object_r:samba_secrets_t
+/var/run/samba/locking.tdb	system_u:object_r:var_run_smbd_t
+/var/run/samba/connections.tdb	system_u:object_r:var_run_smbd_t
+/var/run/samba/sessionid.tdb	system_u:object_r:var_run_smbd_t
+/var/run/samba/brlock.tdb	system_u:object_r:var_run_smbd_t
+/var/run/samba/namelist.debug	system_u:object_r:var_run_nmbd_t
+/var/run/samba/messages.tdb	system_u:object_r:var_run_nmbd_t
+/var/run/samba/unexpected.tdb	system_u:object_r:var_run_nmbd_t
+/var/run/samba/smbd.pid		system_u:object_r:var_run_smbd_t
+/var/run/samba/nmbd.pid		system_u:object_r:var_run_nmbd_t
diff -ruN /tmp/policy/file_contexts/program/xdm.fc policy/file_contexts/program/xdm.fc
--- /tmp/policy/file_contexts/program/xdm.fc	2002-08-23 21:04:28.000000000 +0200
+++ policy/file_contexts/program/xdm.fc	2002-11-05 01:01:51.000000000 +0100
@@ -3,7 +3,8 @@
 /var/[xgk]dm(/.*)?              system_u:object_r:xserver_var_log_t
 /usr/var/[xgk]dm(/.*)?          system_u:object_r:xserver_var_log_t
 /var/log/kdm.log		system_u:object_r:xserver_var_log_t
-#/tmp/.X11-unix(/.*)?           system_u:object_r:xdm_tmp_t
-#/tmp/.X0-lock                  system_u:object_r:xdm_tmp_t
-/etc/X11/Xsession[^/]* --	system_u:object_r:xsession_exec_t
-
+/tmp/.X11-unix(/.*)?            system_u:object_r:xdm_tmp_t
+/tmp/.X0-lock                   system_u:object_r:xdm_tmp_t
+/etc/X11/Xsession[^/]*	--	system_u:object_r:xsession_exec_t
+/var/run/xdmctl			system_u:object_r:var_run_xdm_t
+/var/lib/kdm/authfiles(/.*)?	system_u:object_r:var_lib_xdm_t
diff -ruN /tmp/policy/file_contexts/program/xserver.fc policy/file_contexts/program/xserver.fc
--- /tmp/policy/file_contexts/program/xserver.fc	2002-08-23 21:04:28.000000000 +0200
+++ policy/file_contexts/program/xserver.fc	2002-10-23 20:12:44.000000000 +0200
@@ -1,8 +1,6 @@
 # X server
 /dev/agpgart			system_u:object_r:agp_device_t
 /dev/dri(/.*)?			system_u:object_r:dri_device_t
-/tmp/.X11-unix(/.*)?		system_u:object_r:user_xserver_tmp_t
-/tmp/.X0-lock			system_u:object_r:user_xserver_tmp_t
 /usr/X11R6/bin/Xwrapper		system_u:object_r:xserver_exec_t
 /usr/X11R6/bin/X		system_u:object_r:xserver_exec_t
 /usr/X11R6/bin/XFree86		system_u:object_r:xserver_exec_t
diff -ruN /tmp/policy/file_contexts/types.fc policy/file_contexts/types.fc
--- /tmp/policy/file_contexts/types.fc	2002-10-23 21:38:20.000000000 +0200
+++ policy/file_contexts/types.fc	2002-11-20 18:18:57.000000000 +0100
@@ -58,8 +58,10 @@
 /var/lib(/.*)?			system_u:object_r:var_lib_t
 /var/lib/nfs(/.*)?		system_u:object_r:var_lib_nfs_t
 /var/lib/texmf(/.*)?		system_u:object_r:tetex_data_t
+/var/cache/fonts(/.*)?		system_u:object_r:tetex_data_t
 /var/lock(/.*)?			system_u:object_r:var_lock_t
-/var/tmp(/.*)?			system_u:object_r:tmp_t
+/var/tmp			system_u:object_r:tmp_t
+/var/tmp/.*			<<none>>
 /var/tmp/vi.recover		system_u:object_r:tmp_t
 
 #
@@ -136,12 +138,13 @@
 /dev/psaux			system_u:object_r:mouse_device_t
 /dev/.*mouse.*	-c		system_u:object_r:mouse_device_t
 /dev/input/.*mouse.*		system_u:object_r:mouse_device_t
+/dev/input/mice			system_u:object_r:mouse_device_t
 /dev/ptmx			system_u:object_r:ptmx_t
 /dev/sequencer			system_u:object_r:misc_device_t
 /dev/fb[0-9]*			system_u:object_r:framebuf_device_t
 /dev/apm_bios			system_u:object_r:apm_bios_t
 /dev/cpu/mtrr			system_u:object_r:mtrr_device_t
-/dev/(radio|video|vbi|vtx).*	system_u:object_r:v4l_device_t
+/dev/(radio|video|vbi|vtx).* -c	system_u:object_r:v4l_device_t
 
 /proc(/.*)?			<<none>>
 
@@ -187,7 +190,8 @@
 #
 # /tmp
 #
-/tmp(/.*)?			system_u:object_r:tmp_t
+/tmp				system_u:object_r:tmp_t
+/tmp/.*				<<none>>
 /tmp/orbit.*			system_u:object_r:user_tmp_t
 /tmp/.ICE-unix(/.*)?		system_u:object_r:user_tmp_t
 
diff -ruN /tmp/policy/macros/global_macros.te policy/macros/global_macros.te
--- /tmp/policy/macros/global_macros.te	2002-10-28 22:56:04.000000000 +0100
+++ policy/macros/global_macros.te	2002-11-29 10:17:35.000000000 +0100
@@ -104,7 +104,7 @@
 # 
 # Permissions for reading and writing directories and their attributes.
 #
-define(`rw_dir_perms', `{ read getattr lock search add_name remove_name write }')
+define(`rw_dir_perms', `{ read getattr lock search ioctl add_name remove_name write }')
 
 # 
 # Permissions for reading and adding names to directories.
@@ -950,8 +950,13 @@
 type var_run_$1_t, file_type, sysadmfile, pidfile;
 file_type_auto_trans($1_t, var_run_t, var_run_$1_t)
 
+allow $1_t devtty_t:chr_file rw_file_perms;
+
 # for daemons that look at /root on startup
 dontaudit $1_t sysadm_home_dir_t:dir search;
+
+# for df
+allow $1_t fs_type:filesystem getattr;
 ')dnl
 
 define(`uses_authbind',
@@ -996,6 +1001,11 @@
 file_type_auto_trans($1_t, tmp_t, $1_tmp_t)
 ')
 
+define(`var_lib_domain', `
+type var_lib_$1_t, file_type, sysadmfile;
+file_type_auto_trans($1_t, var_lib_t, var_lib_$1_t)
+')
+
 define(`log_domain', `
 type $1_log_t, file_type, sysadmfile, logfile;
 file_type_auto_trans($1_t, var_log_t, $1_log_t)
diff -ruN /tmp/policy/macros/program/crond_macros.te policy/macros/program/crond_macros.te
--- /tmp/policy/macros/program/crond_macros.te	2002-09-27 22:27:44.000000000 +0200
+++ policy/macros/program/crond_macros.te	2002-11-08 10:33:44.000000000 +0100
@@ -29,11 +29,6 @@
 # via execve_secure.  There is no way to set up an automatic
 # transition, since crontabs are configuration files, not executables.
 domain_trans(crond_t, shell_exec_t, $1_crond_t)
-ifdef(`fcron.te', `
-domain_trans(fcron_t, shell_exec_t, $1_crond_t)
-# should get the spool file created under a different type or use a fifo
-allow $1_crond_t fcron_spool_t:file rw_file_perms;
-')
 
 ifdef(`mta.te', `
 domain_auto_trans($1_crond_t, sendmail_exec_t, $1_mail_t)
diff -ruN /tmp/policy/macros/program/crontab_macros.te policy/macros/program/crontab_macros.te
--- /tmp/policy/macros/program/crontab_macros.te	2002-10-28 21:33:15.000000000 +0100
+++ policy/macros/program/crontab_macros.te	2002-11-08 10:33:44.000000000 +0100
@@ -44,13 +44,12 @@
 allow sysadm_crontab_t $1_cron_spool_t:file { getattr read };
 file_type_auto_trans($1_crontab_t, cron_spool_t, $1_cron_spool_t)
 ifdef(`fcron.te', `
-file_type_auto_trans($1_crontab_t, fcron_spool_t, $1_cron_spool_t)
-allow fcron_t $1_cron_spool_t:file create_file_perms;
+allow crond_t $1_cron_spool_t:file create_file_perms;
 # fcron wants an instant update of a crontab change for the administrator
 ifelse(`$1', `sysadm', `
-allow $1_crontab_t fcron_t:process signal;
+allow $1_crontab_t crond_t:process signal;
 ', `
-dontaudit $1_crontab_t fcron_t:process signal;
+dontaudit $1_crontab_t crond_t:process signal;
 ')dnl end ifelse
 ')dnl end ifdef fcron
 
diff -ruN /tmp/policy/macros/program/x_client_macros.te policy/macros/program/x_client_macros.te
--- /tmp/policy/macros/program/x_client_macros.te	2002-10-10 17:50:31.000000000 +0200
+++ policy/macros/program/x_client_macros.te	2002-11-27 19:04:03.000000000 +0100
@@ -52,7 +52,9 @@
 # Type for files that are read-only for this domain
 type $1_$2_ro_t, file_type, sysadmfile;
 r_dir_file($1_$2_t, $1_$2_ro_t)
-rw_dir_create_file($1_t, $1_$2_ro_t)
+allow $1_$2_t $1_$2_ro_t:fifo_file { read write };
+create_dir_file($1_t, $1_$2_ro_t)
+allow $1_t $1_$2_ro_t:fifo_file create_file_perms;
 allow $1_t $1_$2_ro_t:{ dir file lnk_file } { relabelto relabelfrom };
 
 # Allow the user domain to send any signal to the $2 process.
@@ -91,6 +93,10 @@
 allow $1_$2_t xdm_xserver_tmp_t:sock_file { read write };
 allow $1_$2_t xdm_t:fd use;
 dontaudit $1_$2_t xdm_t:tcp_socket { read write };
+# for X over a ssh tunnel
+ifdef(`ssh.te', `
+can_tcp_connect($1_$2_t, sshd_t)
+')
 
 # for .xsession-errors
 dontaudit $1_$2_t $1_home_t:file write;
diff -ruN /tmp/policy/macros/user_macros.te policy/macros/user_macros.te
--- /tmp/policy/macros/user_macros.te	2002-11-29 12:19:38.000000000 +0100
+++ policy/macros/user_macros.te	2002-11-29 12:30:08.000000000 +0100
@@ -270,6 +270,8 @@
 dontaudit $1_t syslogd_t:unix_dgram_socket sendto;
 ')
 
+# stop warnings about "ls -l" on directories with unlabelled files
+dontaudit $1_t file_t:{ dir file lnk_file } getattr;
 ')
 
 undefine(`in_user_role')
diff -ruN /tmp/policy/rbac policy/rbac
--- /tmp/policy/rbac	2002-07-03 22:26:19.000000000 +0200
+++ policy/rbac	2002-10-23 20:18:03.000000000 +0200
@@ -31,19 +31,11 @@
 
 #
 # Allow the system_r role to transition 
-# into any of the user roles.
+# into the sysadm_r role.
 #
-allow system_r user_r;
 allow system_r sysadm_r;
 
 #
-# Allow the user roles to transition
-# into each other.
-#
-allow user_r sysadm_r;
-allow sysadm_r user_r;
-
-#
 # Allow the user and admin role to transition to httpd_admin_r
 #
 ifdef(`apache.te',

--------------Boundary-00=_N06CJPN9E9H3KMDPLEFF--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

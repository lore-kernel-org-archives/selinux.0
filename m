Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2MMEjx6027774
	for <selinux@tycho.nsa.gov>; Sat, 22 Mar 2003 17:14:46 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2MMEiR1018606
	for <selinux@tycho.nsa.gov>; Sat, 22 Mar 2003 22:14:44 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h2MMETj9018603 for <selinux@tycho.nsa.gov>; Sat, 22 Mar 2003 22:14:41 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id BD863BF42
	for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2003 09:14:15 +1100 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 10039-01
 for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2003 09:14:14 +1100 (EST)
Received: from tsv.sws.net.au (unknown [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 0F307BF41
	for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2003 09:14:14 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 88CFA9253C
	for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2003 09:14:11 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id D47DD101
	for <selinux@tycho.nsa.gov>; Sat, 22 Mar 2003 23:14:01 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policy patches
Date: Sat, 22 Mar 2003 23:14:01 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pAOf+x5xVQGfTmI"
Message-Id: <200303222314.01287.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_pAOf+x5xVQGfTmI
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've attached a patch for the passwd_t policy as previously described.

I've also attached a patch containing some trivial changes, none of which 
should require much consideration before being included.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_pAOf+x5xVQGfTmI
Content-Type: text/x-diff;
  charset="us-ascii";
  name="passwd"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="passwd"

diff -ru /tmp/policy/assert.te policy/assert.te
--- /tmp/policy/assert.te	2003-01-20 01:03:58.000000000 +0100
+++ policy/assert.te	2003-03-07 10:11:56.000000000 +0100
@@ -113,7 +113,7 @@
 #
 ifdef(`passwd.te',
 `neverallow passwd_t ~{ admin_passwd_exec_t passwd_exec_t }:file entrypoint;
-neverallow passwd_t ~{ bin_t sbin_t shell_exec_t ld_so_t }:file execute_no_trans;')
+neverallow passwd_t ~{ bin_t sbin_t shell_exec_t ld_so_t passwd_real_exec_t }:file execute_no_trans;')
 
 #
 # Verify that only the admin domains and initrc_t have avc_toggle.
diff -ru /tmp/policy/domains/program/passwd.te policy/domains/program/passwd.te
--- /tmp/policy/domains/program/passwd.te	2003-03-13 16:14:38.000000000 +0100
+++ policy/domains/program/passwd.te	2003-03-22 22:23:00.000000000 +0100
@@ -18,6 +18,7 @@
 role sysadm_r types passwd_t;
 
 type passwd_exec_t, file_type, sysadmfile, exec_type;
+type passwd_real_exec_t, file_type, sysadmfile;
 type admin_passwd_exec_t, file_type, sysadmfile;
 
 general_domain_access(passwd_t);
@@ -27,6 +28,9 @@
 domain_auto_trans(userdomain, passwd_exec_t, passwd_t)
 domain_auto_trans(sysadm_t, admin_passwd_exec_t, passwd_t)
 
+# for vipw - vi looks in the root home directory for config
+dontaudit passwd_t sysadm_home_dir_t:dir { getattr search };
+
 # Use capabilities.
 allow passwd_t passwd_t:capability { chown dac_override fsetid setuid sys_resource };
 
@@ -35,7 +39,7 @@
 
 # Execute /usr/bin/{passwd,chfn,chsh} and /usr/sbin/{useradd,vipw}.
 allow passwd_t { bin_t sbin_t }:dir r_dir_perms;
-can_exec(passwd_t, { bin_t sbin_t shell_exec_t })
+can_exec(passwd_t, { bin_t sbin_t shell_exec_t passwd_real_exec_t })
 
 # allow checking if a shell is executable
 allow passwd_t shell_exec_t:file execute;
@@ -72,3 +76,5 @@
 # audit those denials.
 # Access denials to /var aren't audited either.
 dontaudit passwd_t { proc_t device_t var_t }:dir { search read };
+
+allow passwd_t device_t:dir getattr;
diff -ru /tmp/policy/file_contexts/program/passwd.fc policy/file_contexts/program/passwd.fc
--- /tmp/policy/file_contexts/program/passwd.fc	2002-09-27 22:27:40.000000000 +0200
+++ policy/file_contexts/program/passwd.fc	2003-03-07 10:15:28.000000000 +0100
@@ -5,6 +5,7 @@
 /usr/local/selinux/bin/svipw    system_u:object_r:admin_passwd_exec_t
 /usr/local/selinux/bin/sadminpasswd system_u:object_r:admin_passwd_exec_t
 /usr/bin/spasswd		system_u:object_r:passwd_exec_t
+/usr/bin/passwd			system_u:object_r:passwd_real_exec_t
 /usr/bin/schsh			system_u:object_r:passwd_exec_t
 /usr/bin/schfn			system_u:object_r:passwd_exec_t
 /usr/bin/svipw                 system_u:object_r:admin_passwd_exec_t

--Boundary-00=_pAOf+x5xVQGfTmI
Content-Type: text/x-diff;
  charset="us-ascii";
  name="trivial"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="trivial"

diff -ru /tmp/policy/domains/program/crond.te policy/domains/program/crond.te
--- /tmp/policy/domains/program/crond.te	2003-01-20 01:04:00.000000000 +0100
+++ policy/domains/program/crond.te	2003-02-24 08:12:09.000000000 +0100
@@ -10,7 +10,7 @@
 #	    Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser
 #
 
-# Domain for crond.  Does it really need auth?
+# Domain for crond.  It needs auth to check for locked accounts.
 daemon_domain(crond, `, privrole, privmail, auth, privfd')
 
 # This domain is granted permissions common to most domains (including can_net)
@@ -157,6 +157,9 @@
 system_crond_entry(insmod_exec_t, insmod_t)
 ')
 
+# for if /var/mail is a symlink
+allow crond_t mail_spool_t:lnk_file read;
+
 # Run logrotate in the logrotate_t domain.
 ifdef(`logrotate.te', `
 system_crond_entry(logrotate_exec_t, logrotate_t)
diff -ru /tmp/policy/domains/program/init.te policy/domains/program/init.te
--- /tmp/policy/domains/program/init.te	2003-03-22 21:52:23.000000000 +0100
+++ policy/domains/program/init.te	2003-03-22 22:07:25.000000000 +0100
@@ -100,7 +100,7 @@
 # get stuck if you don't allow unlabeled policies to signal init
 # If you load an incompatible policy, you should probably reboot,
 # since you may have compromised system security.
-# allow unlabeled_t init_t:process sigchld;
+allow unlabeled_t init_t:process sigchld;
 
 # Read and write the console and ttys.
 allow init_t console_device_t:chr_file rw_file_perms;
diff -ru /tmp/policy/domains/program/initrc.te policy/domains/program/initrc.te
--- /tmp/policy/domains/program/initrc.te	2003-03-22 21:52:23.000000000 +0100
+++ policy/domains/program/initrc.te	2003-03-22 22:12:15.000000000 +0100
@@ -173,10 +173,12 @@
 allow initrc_t ttyfile:chr_file relabelfrom;
 allow initrc_t tty_device_t:chr_file relabelto;
 
+ifdef(`rpm.te', `
 # Create and read /boot/kernel.h.
 # Redhat systems typically create this file at boot time.
 allow initrc_t boot_t:lnk_file r_file_perms;
 file_type_auto_trans(initrc_t, boot_t, boot_runtime_t)
+')
 
 # Delete and re-create /boot/System.map.
 allow initrc_t boot_t:dir { read getattr write remove_name add_name };
diff -ru /tmp/policy/domains/program/modutil.te policy/domains/program/modutil.te
--- /tmp/policy/domains/program/modutil.te	2003-03-22 21:52:25.000000000 +0100
+++ policy/domains/program/modutil.te	2003-03-22 22:14:03.000000000 +0100
@@ -115,7 +115,7 @@
 allow update_modules_t privfd:fd use;
 allow update_modules_t init_t:fd use;
 
-allow update_modules_t device_t:dir search;
+allow update_modules_t device_t:dir { getattr search };
 allow update_modules_t { console_device_t devtty_t }:chr_file rw_file_perms;
 allow update_modules_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
 
@@ -127,7 +127,7 @@
 allow update_modules_t modules_dep_t:file rw_file_perms;
 file_type_auto_trans(update_modules_t, modules_object_t, modules_conf_t)
 domain_auto_trans_read(update_modules_t, depmod_exec_t, depmod_t)
-can_exec(update_modules_t, { shell_exec_t bin_t update_modules_exec_t })
+can_exec(update_modules_t, { shell_exec_t bin_t sbin_t update_modules_exec_t etc_t })
 allow update_modules_t bin_t:lnk_file read;
 allow update_modules_t { sbin_t bin_t }:dir search;
 allow update_modules_t { etc_t etc_runtime_t }:file r_file_perms;
diff -ru /tmp/policy/domains/program/newrole.te policy/domains/program/newrole.te
--- /tmp/policy/domains/program/newrole.te	2003-03-22 21:52:25.000000000 +0100
+++ policy/domains/program/newrole.te	2003-03-22 22:21:36.000000000 +0100
@@ -78,8 +78,10 @@
 #
 allow newrole_t security_t:security { sid_to_context context_to_sid change_sid };
 
-# for some PAM modules
-dontaudit newrole_t { home_type }:dir search;
+allow newrole_t fs_t:filesystem getattr;
+
+# for some PAM modules and for cwd
+dontaudit newrole_t { home_root_t home_type }:dir search;
 
 # Failed reads to /proc cause no harm, so don't audit them
 dontaudit newrole_t proc_t:dir search;
diff -ru /tmp/policy/domains/program/setfiles.te policy/domains/program/setfiles.te
--- /tmp/policy/domains/program/setfiles.te	2003-01-20 01:04:01.000000000 +0100
+++ policy/domains/program/setfiles.te	2003-03-18 12:09:56.000000000 +0100
@@ -23,7 +23,7 @@
 allow setfiles_t privfd:fd use;
 
 uses_shlib(setfiles_t)
-allow setfiles_t self:capability dac_override;
+allow setfiles_t self:capability { dac_override dac_read_search };
 
 # for upgrading glibc - without this the glibc upgrade scripts will put things
 # in a state such that setfiles can not be run!
@@ -44,5 +44,9 @@
 allow setfiles_t fs_t:filesystem getattr;
 allow setfiles_t fs_type:dir r_dir_perms;
 
+allow setfiles_t etc_runtime_t:file read;
+allow setfiles_t etc_t:file read;
+allow setfiles_t proc_t:file { getattr read };
+
 # for config files in a home directory
 allow setfiles_t home_type:file r_file_perms;
diff -ru /tmp/policy/file_contexts/program/crond.fc policy/file_contexts/program/crond.fc
--- /tmp/policy/file_contexts/program/crond.fc	2003-03-16 12:33:44.000000000 +0100
+++ policy/file_contexts/program/crond.fc	2003-03-17 00:02:51.000000000 +0100
@@ -1,6 +1,6 @@
 # crond
 /etc/crontab			system_u:object_r:system_crond_script_t
-/etc/cron.d(/.*)?		system_u:object_r:system_crond_script_t
+/etc/cron\.d(/.*)?		system_u:object_r:system_crond_script_t
 /usr/sbin/cron(d)?		system_u:object_r:crond_exec_t
 /usr/sbin/anacron		system_u:object_r:anacron_exec_t
 /var/spool/cron			system_u:object_r:cron_spool_t
@@ -9,7 +9,7 @@
 /var/spool/cron/crontabs/root	system_u:object_r:sysadm_cron_spool_t
 /var/log/cron			system_u:object_r:cron_log_t
 /var/log/mrtg(/.*)?		system_u:object_r:cron_log_t
-/var/run/crond.reboot		system_u:object_r:var_run_crond_t
+/var/run/crond\.reboot		system_u:object_r:var_run_crond_t
 /var/run/crond\.pid		system_u:object_r:var_run_crond_t
 # fcron
 /usr/sbin/fcron			system_u:object_r:crond_exec_t
diff -ru /tmp/policy/file_contexts/program/dhcpc.fc policy/file_contexts/program/dhcpc.fc
--- /tmp/policy/file_contexts/program/dhcpc.fc	2003-03-16 12:33:44.000000000 +0100
+++ policy/file_contexts/program/dhcpc.fc	2003-03-16 23:57:14.000000000 +0100
@@ -6,3 +6,4 @@
 /sbin/dhclient.*		system_u:object_r:dhcpc_exec_t
 /var/lib/dhcp(3)?		system_u:object_r:dhcp_state_t
 /var/lib/dhcp(3)?/dhclient.*	system_u:object_r:dhcpc_state_t
+/var/run/dhclient\.pid		system_u:object_r:var_run_dhcpc_t
diff -ru /tmp/policy/file_contexts/program/dpkg.fc policy/file_contexts/program/dpkg.fc
--- /tmp/policy/file_contexts/program/dpkg.fc	2003-03-13 16:14:48.000000000 +0100
+++ policy/file_contexts/program/dpkg.fc	2003-03-18 12:16:55.000000000 +0100
@@ -32,3 +32,5 @@
 /usr/share/console/getkmapchoice\.pl system_u:object_r:bin_t
 /var/run/update-menus\.pid	system_u:object_r:install_menu_var_run_t
 /usr/share/openoffice\.org-debian-files/install-hook system_u:object_r:bin_t
+/usr/share/dlint/digparse	system_u:object_r:bin_t
+/usr/share/gimp/1.2/user_install system_u:object_r:bin_t
diff -ru /tmp/policy/file_contexts/program/gpg.fc policy/file_contexts/program/gpg.fc
--- /tmp/policy/file_contexts/program/gpg.fc	2003-02-13 17:16:50.000000000 +0100
+++ policy/file_contexts/program/gpg.fc	2003-03-12 23:13:38.000000000 +0100
@@ -1,4 +1,4 @@
 # gpg
-/home/[^/]+/\.gnupg(/.+)?		system_u:object_r:user_gpg_secret_t
-/root/[^/]+/\.gnupg(/.+)?		system_u:object_r:sysadm_gpg_secret_t
+/home/[^/]+/\.gnupg(/.+)?	system_u:object_r:user_gpg_secret_t
+/root/\.gnupg(/.+)?		system_u:object_r:sysadm_gpg_secret_t
 /usr/bin/gpg			system_u:object_r:gpg_exec_t
diff -ru /tmp/policy/file_contexts/program/modutil.fc policy/file_contexts/program/modutil.fc
--- /tmp/policy/file_contexts/program/modutil.fc	2003-03-16 12:33:44.000000000 +0100
+++ policy/file_contexts/program/modutil.fc	2003-03-17 00:30:21.000000000 +0100
@@ -2,7 +2,7 @@
 /etc/modules\.conf(.old)?	system_u:object_r:modules_conf_t
 /lib/modules(/.*)?		system_u:object_r:modules_object_t
 /lib/modules/[^/]+/modules\..+ system_u:object_r:modules_dep_t
-/lib/modules/modprobe\.conf	system_u:object_r:modules_conf_t
+/lib/modules/modprobe\.conf.*	system_u:object_r:modules_conf_t
 /sbin/depmod.*			system_u:object_r:depmod_exec_t
 /sbin/modprobe.*		system_u:object_r:insmod_exec_t
 /sbin/insmod.*			system_u:object_r:insmod_exec_t
diff -ru /tmp/policy/file_contexts/program/netutils.fc policy/file_contexts/program/netutils.fc
--- /tmp/policy/file_contexts/program/netutils.fc	2002-07-03 22:26:22.000000000 +0200
+++ policy/file_contexts/program/netutils.fc	2003-02-06 08:58:52.000000000 +0100
@@ -1,5 +1,5 @@
 # network utilities
-/sbin/ip			system_u:object_r:netutils_exec_t
+/(s)?bin/ip			system_u:object_r:netutils_exec_t
 /sbin/arping			system_u:object_r:netutils_exec_t
 /usr/sbin/tcpdump		system_u:object_r:netutils_exec_t
 /etc/network/ifstate		system_u:object_r:etc_runtime_t
diff -ru /tmp/policy/file_contexts/program/ping.fc policy/file_contexts/program/ping.fc
--- /tmp/policy/file_contexts/program/ping.fc	2002-05-03 14:26:41.000000000 +0200
+++ policy/file_contexts/program/ping.fc	2003-03-22 21:02:01.000000000 +0100
@@ -1,2 +1,2 @@
 # ping
-/bin/ping 			system_u:object_r:ping_exec_t
+/bin/ping.* 			system_u:object_r:ping_exec_t
diff -ru /tmp/policy/file_contexts/program/postfix.fc policy/file_contexts/program/postfix.fc
--- /tmp/policy/file_contexts/program/postfix.fc	2003-03-13 16:14:49.000000000 +0100
+++ policy/file_contexts/program/postfix.fc	2003-02-15 19:44:20.000000000 +0100
@@ -12,6 +12,7 @@
 /usr/lib/postfix/smtp		system_u:object_r:postfix_smtp_exec_t
 /usr/lib/postfix/smtpd		system_u:object_r:postfix_smtpd_exec_t
 /usr/lib/postfix/bounce		system_u:object_r:postfix_bounce_exec_t
+/usr/lib/postfix/pipe		system_u:object_r:postfix_pipe_exec_t
 /usr/sbin/postalias		system_u:object_r:postfix_master_exec_t
 /usr/sbin/postcat		system_u:object_r:postfix_master_exec_t
 /usr/sbin/postconf		system_u:object_r:postfix_master_exec_t
diff -ru /tmp/policy/file_contexts/program/traceroute.fc policy/file_contexts/program/traceroute.fc
--- /tmp/policy/file_contexts/program/traceroute.fc	2003-03-13 16:14:51.000000000 +0100
+++ policy/file_contexts/program/traceroute.fc	2003-03-05 15:20:15.000000000 +0100
@@ -1,3 +1,3 @@
 # traceroute
-/usr/bin/traceroute.*		system_u:object_r:traceroute_exec_t
-/usr/sbin/traceroute		system_u:object_r:traceroute_exec_t
+/usr/(s)?bin/traceroute.*	system_u:object_r:traceroute_exec_t
+/usr/bin/lft			system_u:object_r:traceroute_exec_t
diff -ru /tmp/policy/file_contexts/types.fc policy/file_contexts/types.fc
--- /tmp/policy/file_contexts/types.fc	2003-03-16 12:33:43.000000000 +0100
+++ policy/file_contexts/types.fc	2003-03-22 21:28:34.000000000 +0100
@@ -216,6 +220,7 @@
 /usr/lib/lib.*\.so.*		system_u:object_r:shlib_t
 /usr/lib/python.*\.so		system_u:object_r:shlib_t
 /usr/lib/.*/lib[^/]*\.so.*	system_u:object_r:shlib_t
+/usr/lib/.*/.*\.so		system_u:object_r:shlib_t
 /usr/lib/autofs/.*\.so		system_u:object_r:shlib_t
 /usr/lib/perl5/man(/.*)?	system_u:object_r:man_t
 /usr/lib/perl.*\.so		system_u:object_r:shlib_t
diff -ru /tmp/policy/fs_use policy/fs_use
--- /tmp/policy/fs_use	2002-07-03 22:26:19.000000000 +0200
+++ policy/fs_use	2003-03-01 18:54:03.000000000 +0100
@@ -9,6 +9,7 @@
 fs_use_psid ext2;
 fs_use_psid ext3;
 fs_use_psid reiserfs;
+fs_use_psid jfs;
 
 # Use the allocating task SID to label inodes in the following filesystem
 # types, and label the filesystem itself with the specified context.
diff -ru /tmp/policy/macros/admin_macros.te policy/macros/admin_macros.te
--- /tmp/policy/macros/admin_macros.te	2003-02-12 13:36:15.000000000 +0100
+++ policy/macros/admin_macros.te	2003-03-07 10:15:59.000000000 +0100
@@ -54,7 +54,7 @@
 allow $1_t domain:notdevfile_class_set r_file_perms;
 
 # Send signals to all processes.
-allow $1_t domain:process signal_perms;
+allow $1_t { domain unlabeled_t }:process signal_perms;
 
 # Access all user terminals.
 allow $1_t tty_device_t:chr_file rw_file_perms;
diff -ru /tmp/policy/macros/global_macros.te policy/macros/global_macros.te
--- /tmp/policy/macros/global_macros.te	2003-03-22 21:52:43.000000000 +0100
+++ policy/macros/global_macros.te	2003-03-22 22:38:33.000000000 +0100
@@ -109,7 +109,7 @@
 # 
 # Permissions for reading and adding names to directories.
 #
-define(`ra_dir_perms', `{ read getattr lock search add_name write }')
+define(`ra_dir_perms', `{ read getattr lock search ioctl add_name write }')
 
 
 #
@@ -183,6 +183,11 @@
 allow $1 $2:{ file lnk_file } rw_file_perms;
 ')
 
+define(`ra_dir_file', `
+allow $1 $2:dir ra_dir_perms;
+allow $1 $2:{ file lnk_file } ra_file_perms;
+')
+
 define(`rw_dir_create_file', `
 allow $1 $2:dir rw_dir_perms;
 allow $1 $2:{ file lnk_file } create_file_perms;
@@ -287,6 +292,16 @@
 
 #################################
 #
+# can_ptrace(domain, domain)
+#
+# Permissions for running ptrace (strace or gdb) on another domain
+#
+define(`can_ptrace',`
+allow $1 $2:process ptrace;
+')
+
+#################################
+#
 # can_exec(domain, type)
 #
 # Permissions for executing programs with
@@ -987,12 +1007,11 @@
 
 allow $2_t device_t:dir { getattr search };
 allow $2_t null_device_t:chr_file rw_file_perms;
-allow $2_t console_device_t:chr_file rw_file_perms;
 ')
 
 
 define(`tmp_domain', `
-type $1_tmp_t, file_type, sysadmfile, tmpfile;
+type $1_tmp_t, file_type, sysadmfile, tmpfile $2;
 file_type_auto_trans($1_t, tmp_t, $1_tmp_t)
 ')
 
@@ -1006,6 +1025,11 @@
 file_type_auto_trans($1_t, var_log_t, $1_log_t)
 ')
 
+define(`lock_domain', `
+type $1_lock_t, file_type, sysadmfile, lockfile;
+file_type_auto_trans($1_t, var_lock_t, $1_lock_t)
+')
+
 #######################
 # application_domain(domain_prefix)
 #
diff -ru /tmp/policy/macros/program/gpg_macros.te policy/macros/program/gpg_macros.te
--- /tmp/policy/macros/program/gpg_macros.te	2003-01-20 01:04:03.000000000 +0100
+++ policy/macros/program/gpg_macros.te	2003-03-05 21:03:46.000000000 +0100
@@ -65,9 +65,11 @@
 # so ~/.gnupg will be of $1_gpg_secret_t, then files created under it such as
 # secring.gpg will be of $1_gpg_secret_t too.  But when you use gpg to decrypt
 # a file and write output to your home directory it will use user_home_t.
-file_type_trans($1_gpg_t, $1_home_dir_t, $1_gpg_secret_t)
-type_transition $1_gpg_t $1_home_dir_t:dir $1_gpg_secret_t;
-rw_dir_create_file($1_gpg_t, $1_home_t)
+file_type_auto_trans($1_gpg_t, $1_home_dir_t, $1_gpg_secret_t, dir)
+rw_dir_create_file($1_gpg_t, $1_gpg_secret_t)
+
+file_type_auto_trans($1_gpg_t, $1_home_dir_t, $1_home_t, file)
+create_dir_file($1_gpg_t, $1_home_t)
 
 # allow the usual access to /tmp
 file_type_auto_trans($1_gpg_t, tmp_t, $1_tmp_t)
diff -ru /tmp/policy/macros/program/su_macros.te policy/macros/program/su_macros.te
--- /tmp/policy/macros/program/su_macros.te	2003-03-13 16:14:56.000000000 +0100
+++ policy/macros/program/su_macros.te	2003-03-10 19:19:31.000000000 +0100
@@ -43,8 +43,10 @@
 
 define(`su_domain', `
 su_mini_domain($1)
+ifdef(`chkpwd.te', `
 # Run chkpwd.
 can_exec($1_su_t, chkpwd_exec_t)
+')
 
 # Inherit and use descriptors from gnome-pty-helper.
 ifdef(`gnome-pty-helper.te', `
diff -ru /tmp/policy/macros/user_macros.te policy/macros/user_macros.te
--- /tmp/policy/macros/user_macros.te	2003-03-22 21:52:43.000000000 +0100
+++ policy/macros/user_macros.te	2003-03-22 22:43:57.000000000 +0100
@@ -200,6 +207,9 @@
 # do not audit getattr on tmpfile, otherwise ls -l /tmp fills the logs
 dontaudit $1_t tmpfile:dir_file_class_set getattr;
 
+# do not audit getattr on disk devices, otherwise KDE fills the logs
+dontaudit $1_t { removable_device_t fixed_disk_device_t }:blk_file getattr;
+
 ifdef(`xdm.te', `
 # Connect to the X server run by the X Display Manager.
 can_unix_connect($1_t, xdm_t)

--Boundary-00=_pAOf+x5xVQGfTmI--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2GNaax6024875
	for <selinux@tycho.nsa.gov>; Sun, 16 Mar 2003 18:36:36 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA06979
	for <selinux@tycho.nsa.gov>; Sun, 16 Mar 2003 23:33:10 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id XAA06964
	for <selinux@tycho.nsa.gov>; Sun, 16 Mar 2003 23:33:04 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 0C6F5BF42
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 10:36:27 +1100 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 16583-10
 for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 10:36:25 +1100 (EST)
Received: from tsv.sws.net.au (unknown [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 9D4ADBF41
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 10:36:25 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id A14A49253C
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 10:36:25 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 8159F41B0
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 00:36:14 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: general policy stuff
Date: Mon, 17 Mar 2003 00:36:11 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_spQd+t6SnJpBMXl"
Message-Id: <200303170036.12421.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_spQd+t6SnJpBMXl
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The Makefile for the policy has constraints mis-spelled in the following line:
POLICYFILES += tmp/contraints-contexts.m4

Temporary files don't matter much how they are spelled, but I still think it 
should be right.

Recently the line
allow $2_t console_device_t:chr_file rw_file_perms;
was added to the daemon_sub_domain() macro.  I don't think that this is 
desired as the ability to read/write to the console can allow a daemon a 
dangerous level of access (maybe offering a trojan login prompt).

Although there are probably some other things that need to be considered 
regarding the console (last time I wanted to run a getty on a serial console 
I found the default policy incapable of it).

I have attached the diff between my policy and the CVS policy for the core 
files and the .fc files.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_spQd+t6SnJpBMXl
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

diff -ruw /tmp/policy/assert.te policy/assert.te
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
diff -ruw /tmp/policy/domains/program/crond.te policy/domains/program/crond.te
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
diff -ruw /tmp/policy/domains/program/fsadm.te policy/domains/program/fsadm.te
--- /tmp/policy/domains/program/fsadm.te	2003-02-12 13:36:05.000000000 +0100
+++ policy/domains/program/fsadm.te	2003-03-16 23:14:45.000000000 +0100
@@ -26,8 +26,8 @@
 # remount file system to apply changes
 allow fsadm_t fs_t:filesystem remount;
 
-# Use capabilities.
-allow fsadm_t fsadm_t:capability { sys_admin sys_rawio };
+# Use capabilities.  ipc_lock is for losetup
+allow fsadm_t self:capability { ipc_lock sys_rawio sys_admin };
 
 # Write to /etc/mtab.
 file_type_auto_trans(fsadm_t, etc_t, etc_runtime_t)
diff -ruw /tmp/policy/domains/program/init.te policy/domains/program/init.te
--- /tmp/policy/domains/program/init.te	2003-01-20 01:04:01.000000000 +0100
+++ policy/domains/program/init.te	2003-02-04 15:32:12.000000000 +0100
@@ -66,7 +66,8 @@
 allow init_t domain:process signal_perms;
 
 # Allow all processes to send SIGCHLD to init.
-allow domain init_t:process sigchld;
+allow domain init_t:process { sigchld signull };
+allow unlabeled_t init_t:process sigchld;
 
 # Read and write the console and ttys.
 allow init_t console_device_t:chr_file rw_file_perms;
diff -ruw /tmp/policy/domains/program/modutil.te policy/domains/program/modutil.te
--- /tmp/policy/domains/program/modutil.te	2003-02-12 13:36:07.000000000 +0100
+++ policy/domains/program/modutil.te	2003-03-09 12:38:45.000000000 +0100
@@ -114,7 +114,7 @@
 allow update_modules_t privfd:fd use;
 allow update_modules_t init_t:fd use;
 
-allow update_modules_t device_t:dir search;
+allow update_modules_t device_t:dir { getattr search };
 allow update_modules_t { console_device_t devtty_t }:chr_file rw_file_perms;
 allow update_modules_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
 
@@ -126,10 +126,11 @@
 allow update_modules_t modules_dep_t:file rw_file_perms;
 file_type_auto_trans(update_modules_t, modules_object_t, modules_conf_t)
 domain_auto_trans_read(update_modules_t, depmod_exec_t, depmod_t)
-can_exec(update_modules_t, { shell_exec_t bin_t update_modules_exec_t })
+can_exec(update_modules_t, { shell_exec_t bin_t sbin_t update_modules_exec_t etc_t })
 allow update_modules_t bin_t:lnk_file read;
 allow update_modules_t { sbin_t bin_t }:dir search;
 allow update_modules_t { etc_t etc_runtime_t }:file r_file_perms;
+allow update_modules_t etc_t:lnk_file read;
 allow update_modules_t fs_t:filesystem getattr;
 
 allow update_modules_t proc_t:dir search;
diff -ruw /tmp/policy/domains/program/newrole.te policy/domains/program/newrole.te
--- /tmp/policy/domains/program/newrole.te	2003-03-13 16:14:38.000000000 +0100
+++ policy/domains/program/newrole.te	2003-03-14 14:57:21.000000000 +0100
@@ -51,6 +51,9 @@
 # Read the /etc/security/default_type file
 allow newrole_t etc_t:file r_file_perms;
 
+# read /etc/localtime
+allow newrole_t etc_t:lnk_file read;
+
 # Read /var.
 allow newrole_t var_t:dir r_dir_perms;
 allow newrole_t var_t:notdevfile_class_set r_file_perms;
@@ -78,17 +81,10 @@
 #
 allow newrole_t security_t:security { sid_to_context context_to_sid change_sid };
 
-#
-# Additional type_change rules to deal with ttys that
-# were left in an old type due to an expected termination of newrole.
-#
-type_change sysadm_t user_tty_device_t:chr_file sysadm_tty_device_t;
-type_change user_t sysadm_tty_device_t:chr_file user_tty_device_t;
-type_change sysadm_t user_devpts_t:chr_file sysadm_devpts_t;
-type_change user_t sysadm_devpts_t:chr_file user_devpts_t;
+allow newrole_t fs_t:filesystem getattr;
 
-# for some PAM modules
-dontaudit newrole_t { home_type }:dir search;
+# for some PAM modules and for cwd
+dontaudit newrole_t { home_root_t home_type }:dir search;
 
 # Failed reads to /proc cause no harm, so don't audit them
 dontaudit newrole_t proc_t:dir search;
diff -ruw /tmp/policy/domains/program/passwd.te policy/domains/program/passwd.te
--- /tmp/policy/domains/program/passwd.te	2003-03-13 16:14:38.000000000 +0100
+++ policy/domains/program/passwd.te	2003-03-13 16:43:09.000000000 +0100
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
diff -ruw /tmp/policy/domains/program/setfiles.te policy/domains/program/setfiles.te
--- /tmp/policy/domains/program/setfiles.te	2003-01-20 01:04:01.000000000 +0100
+++ policy/domains/program/setfiles.te	2003-03-09 12:34:57.000000000 +0100
@@ -23,7 +23,7 @@
 allow setfiles_t privfd:fd use;
 
 uses_shlib(setfiles_t)
-allow setfiles_t self:capability dac_override;
+allow setfiles_t self:capability { dac_override dac_read_search };
 
 # for upgrading glibc - without this the glibc upgrade scripts will put things
 # in a state such that setfiles can not be run!
diff -ruw /tmp/policy/domains/user.te policy/domains/user.te
--- /tmp/policy/domains/user.te	2002-12-03 15:56:38.000000000 +0100
+++ policy/domains/user.te	2003-03-05 16:07:28.000000000 +0100
@@ -3,18 +3,13 @@
 #
 
 full_user_role(user)
-#full_user_role(second_user)
 
-allow system_r user_r;
-#allow system_r second_user_r;
-
-#
-# Allow the user roles to transition
-# into each other.
-#
-allow user_r sysadm_r;
-allow sysadm_r user_r;
-#allow sysadm_r second_user_r;
+# a role for staff that allows seeing all domains and control over the user_t
+# domain
+full_user_role(staff)
+#allow staff_t user_t:process signal_perms;
+#r_dir_file(staff_t, domain)
+#file_type_auto_trans(staff_t, user_home_dir_t, user_home_t)
 
 # if adding new user roles make sure you edit the in_user_role macro in
 # macros/user_macros.te to match
@@ -26,5 +21,22 @@
 # system_r is authorized for user_t as a fallback for unmodified daemons.
 role system_r types user_t;
 
+# change from role $1_r to $2_r and relabel tty appropriately
+define(`role_tty_type_change', `
+allow $1_r $2_r;
+type_change $2_t $1_devpts_t:chr_file $2_devpts_t;
+type_change $2_t $1_tty_device_t:chr_file $2_tty_device_t;
+')
+
+ifdef(`newrole.te', `
+#
+# Allow the user roles to transition
+# into each other.
+role_tty_type_change(sysadm, user)
+role_tty_type_change(user, sysadm)
+role_tty_type_change(staff, sysadm)
+role_tty_type_change(sysadm, staff)
+')
+
 # "ps aux" and "ls -l /dev/pts" make too much noise without this
 dontaudit unpriv_userdomain ptyfile:chr_file getattr;
diff -ruw /tmp/policy/file_contexts/program/apache.fc policy/file_contexts/program/apache.fc
--- /tmp/policy/file_contexts/program/apache.fc	2003-03-16 12:33:43.000000000 +0100
+++ policy/file_contexts/program/apache.fc	2003-02-25 21:33:21.000000000 +0100
@@ -1,14 +1,16 @@
 # apache
+/home/[^/]+/((www)|(web)|(public_html))(/.+)? system_u:object_r:httpd_user_content_t
+/var/www			system_u:object_r:httpd_sys_content_t
 /var/www/html(/.*)?		system_u:object_r:httpd_sys_content_t
 /var/www/mrtg(/.*)?		system_u:object_r:httpd_sys_content_t
-/var/www/cgi-bin(/.*)?		system_u:object_r:httpd_sys_script_t
-/usr/lib/cgi-bin(/.*)?		system_u:object_r:httpd_sys_script_t
-/var/www/perl(/.*)?		system_u:object_r:httpd_sys_script_t
+/var/www/cgi-bin(/.*)?		system_u:object_r:httpd_sys_script_exec_t
+/usr/lib/cgi-bin(/.*)?		system_u:object_r:httpd_sys_script_exec_t
+/var/www/perl(/.*)?		system_u:object_r:httpd_sys_script_exec_t
 /var/www/icons(/.*)?		system_u:object_r:httpd_sys_content_t
 /var/cache/httpd(/.*)?		system_u:object_r:httpd_cache_t
 /etc/httpd			system_u:object_r:httpd_config_t
 /etc/httpd/conf(/.*)?		system_u:object_r:httpd_config_t
-/etc/httpd/logs			system_u:object_r:httpd_log_files_t
+/etc/httpd/logs			system_u:object_r:httpd_log_t
 /etc/httpd/modules		system_u:object_r:httpd_modules_t
 /etc/apache(2)?(/.*)?		system_u:object_r:httpd_config_t
 /etc/vhosts			system_u:object_r:httpd_config_t
@@ -19,8 +21,8 @@
 /usr/sbin/suexec		system_u:object_r:httpd_suexec_exec_t
 /usr/lib/cgi-bin/(nph-)?cgiwrap(d)? system_u:object_r:httpd_suexec_exec_t
 /usr/lib/apache(2)?/suexec(2)?	system_u:object_r:httpd_suexec_exec_t
-/var/log/httpd(/.*)?		system_u:object_r:httpd_log_files_t
-/var/log/apache(2)?(/.*)?	system_u:object_r:httpd_log_files_t
-/var/log/cgiwrap\.log.*		system_u:object_r:httpd_log_files_t
+/var/log/httpd(/.*)?		system_u:object_r:httpd_log_t
+/var/log/apache(2)?(/.*)?	system_u:object_r:httpd_log_t
+/var/log/cgiwrap.log.*		system_u:object_r:httpd_log_t
 /var/cache/ssl.*\.sem		system_u:object_r:httpd_cache_t
-/var/run/apache(2)?.pid.*	system_u:object_r:httpd_var_run_t
+/var/run/apache(2)?.pid.*	system_u:object_r:var_run_httpd_t
diff -ruw /tmp/policy/file_contexts/program/crond.fc policy/file_contexts/program/crond.fc
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
diff -ruw /tmp/policy/file_contexts/program/dhcpc.fc policy/file_contexts/program/dhcpc.fc
--- /tmp/policy/file_contexts/program/dhcpc.fc	2003-03-16 12:33:44.000000000 +0100
+++ policy/file_contexts/program/dhcpc.fc	2003-03-16 23:57:14.000000000 +0100
@@ -6,3 +6,4 @@
 /sbin/dhclient.*		system_u:object_r:dhcpc_exec_t
 /var/lib/dhcp(3)?		system_u:object_r:dhcp_state_t
 /var/lib/dhcp(3)?/dhclient.*	system_u:object_r:dhcpc_state_t
+/var/run/dhclient\.pid		system_u:object_r:var_run_dhcpc_t
diff -ruw /tmp/policy/file_contexts/program/dpkg.fc policy/file_contexts/program/dpkg.fc
--- /tmp/policy/file_contexts/program/dpkg.fc	2003-03-13 16:14:48.000000000 +0100
+++ policy/file_contexts/program/dpkg.fc	2003-03-16 15:35:45.000000000 +0100
@@ -32,3 +32,4 @@
 /usr/share/console/getkmapchoice\.pl system_u:object_r:bin_t
 /var/run/update-menus\.pid	system_u:object_r:install_menu_var_run_t
 /usr/share/openoffice\.org-debian-files/install-hook system_u:object_r:bin_t
+/usr/share/dlint/digparse	system_u:object_r:bin_t
diff -ruw /tmp/policy/file_contexts/program/gpg.fc policy/file_contexts/program/gpg.fc
--- /tmp/policy/file_contexts/program/gpg.fc	2003-02-13 17:16:50.000000000 +0100
+++ policy/file_contexts/program/gpg.fc	2003-03-12 23:13:38.000000000 +0100
@@ -1,4 +1,4 @@
 # gpg
 /home/[^/]+/\.gnupg(/.+)?		system_u:object_r:user_gpg_secret_t
-/root/[^/]+/\.gnupg(/.+)?		system_u:object_r:sysadm_gpg_secret_t
+/root/\.gnupg(/.+)?		system_u:object_r:sysadm_gpg_secret_t
 /usr/bin/gpg			system_u:object_r:gpg_exec_t
diff -ruw /tmp/policy/file_contexts/program/netutils.fc policy/file_contexts/program/netutils.fc
--- /tmp/policy/file_contexts/program/netutils.fc	2002-07-03 22:26:22.000000000 +0200
+++ policy/file_contexts/program/netutils.fc	2003-02-06 08:58:52.000000000 +0100
@@ -1,5 +1,5 @@
 # network utilities
-/sbin/ip			system_u:object_r:netutils_exec_t
+/(s)?bin/ip			system_u:object_r:netutils_exec_t
 /sbin/arping			system_u:object_r:netutils_exec_t
 /usr/sbin/tcpdump		system_u:object_r:netutils_exec_t
 /etc/network/ifstate		system_u:object_r:etc_runtime_t
diff -ruw /tmp/policy/file_contexts/program/passwd.fc policy/file_contexts/program/passwd.fc
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
diff -ruw /tmp/policy/file_contexts/program/postfix.fc policy/file_contexts/program/postfix.fc
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
diff -ruw /tmp/policy/file_contexts/program/traceroute.fc policy/file_contexts/program/traceroute.fc
--- /tmp/policy/file_contexts/program/traceroute.fc	2003-03-13 16:14:51.000000000 +0100
+++ policy/file_contexts/program/traceroute.fc	2003-03-05 15:20:15.000000000 +0100
@@ -1,3 +1,3 @@
 # traceroute
-/usr/bin/traceroute.*		system_u:object_r:traceroute_exec_t
-/usr/sbin/traceroute		system_u:object_r:traceroute_exec_t
+/usr/(s)?bin/traceroute.*	system_u:object_r:traceroute_exec_t
+/usr/bin/lft			system_u:object_r:traceroute_exec_t
diff -ruw /tmp/policy/file_contexts/program/xdm.fc policy/file_contexts/program/xdm.fc
--- /tmp/policy/file_contexts/program/xdm.fc	2003-03-16 12:33:46.000000000 +0100
+++ policy/file_contexts/program/xdm.fc	2003-03-17 00:11:11.000000000 +0100
@@ -7,4 +7,4 @@
 /tmp/\.X0-lock                   system_u:object_r:xdm_tmp_t
 /etc/X11/Xsession[^/]*	--	system_u:object_r:xsession_exec_t
 /var/run/xdmctl			system_u:object_r:var_run_xdm_t
-/var/lib/kdm/authfiles(/.*)?	system_u:object_r:var_lib_xdm_t
+/var/lib/kdm(/.*)?		system_u:object_r:var_lib_xdm_t
diff -ruw /tmp/policy/file_contexts/types.fc policy/file_contexts/types.fc
--- /tmp/policy/file_contexts/types.fc	2003-03-16 12:33:43.000000000 +0100
+++ policy/file_contexts/types.fc	2003-03-17 00:26:42.000000000 +0100
@@ -216,6 +218,7 @@
 /usr/lib/lib.*\.so.*		system_u:object_r:shlib_t
 /usr/lib/python.*\.so		system_u:object_r:shlib_t
 /usr/lib/.*/lib[^/]*\.so.*	system_u:object_r:shlib_t
+/usr/lib/.*/.*\.so		system_u:object_r:shlib_t
 /usr/lib/autofs/.*\.so		system_u:object_r:shlib_t
 /usr/lib/perl5/man(/.*)?	system_u:object_r:man_t
 /usr/lib/perl.*\.so		system_u:object_r:shlib_t
diff -ruw /tmp/policy/fs_use policy/fs_use
--- /tmp/policy/fs_use	2002-07-03 22:26:19.000000000 +0200
+++ policy/fs_use	2003-03-01 18:54:03.000000000 +0100
@@ -9,6 +9,7 @@
 fs_use_psid ext2;
 fs_use_psid ext3;
 fs_use_psid reiserfs;
+fs_use_psid jfs;
 
 # Use the allocating task SID to label inodes in the following filesystem
 # types, and label the filesystem itself with the specified context.
diff -ruw /tmp/policy/macros/admin_macros.te policy/macros/admin_macros.te
--- /tmp/policy/macros/admin_macros.te	2003-02-12 13:36:15.000000000 +0100
+++ policy/macros/admin_macros.te	2003-03-07 10:15:59.000000000 +0100
@@ -54,7 +54,7 @@
 allow $1_t domain:notdevfile_class_set r_file_perms;
 
 # Send signals to all processes.
-allow $1_t domain:process signal_perms;
+allow $1_t { domain unlabeled_t }:process signal_perms;
 
 # Access all user terminals.
 allow $1_t tty_device_t:chr_file rw_file_perms;
diff -ruw /tmp/policy/macros/global_macros.te policy/macros/global_macros.te
--- /tmp/policy/macros/global_macros.te	2003-01-20 01:04:03.000000000 +0100
+++ policy/macros/global_macros.te	2003-03-16 23:19:39.000000000 +0100
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
@@ -992,12 +1007,11 @@
 
 allow $2_t device_t:dir { getattr search };
 allow $2_t null_device_t:chr_file rw_file_perms;
-allow $2_t console_device_t:chr_file rw_file_perms;
 ')
 
 
 define(`tmp_domain', `
-type $1_tmp_t, file_type, sysadmfile, tmpfile;
+type $1_tmp_t, file_type, sysadmfile, tmpfile $2;
 file_type_auto_trans($1_t, tmp_t, $1_tmp_t)
 ')
 
@@ -1011,6 +1025,11 @@
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
diff -ruw /tmp/policy/macros/program/gpg_macros.te policy/macros/program/gpg_macros.te
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
diff -ruw /tmp/policy/macros/program/ssh_macros.te policy/macros/program/ssh_macros.te
--- /tmp/policy/macros/program/ssh_macros.te	2003-01-20 01:04:03.000000000 +0100
+++ policy/macros/program/ssh_macros.te	2003-02-13 20:28:34.000000000 +0100
@@ -83,7 +83,7 @@
 # Communicate with the X server.
 can_unix_connect($1_ssh_t, $1_xserver_t)
 allow $1_ssh_t $1_xserver_tmp_t:sock_file rw_file_perms;
-allow $1_ssh_t $1_xserver_tmp_t:dir r_dir_perms;
+allow $1_ssh_t { initrc_xserver_tmp_t $1_xserver_tmp_t }:dir search;
 ')
 
 ifdef(`xdm.te', `
diff -ruw /tmp/policy/macros/program/su_macros.te policy/macros/program/su_macros.te
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
diff -ruw /tmp/policy/macros/program/x_client_macros.te policy/macros/program/x_client_macros.te
--- /tmp/policy/macros/program/x_client_macros.te	2003-01-20 01:04:03.000000000 +0100
+++ policy/macros/program/x_client_macros.te	2003-02-04 15:26:07.000000000 +0100
@@ -80,7 +80,14 @@
 
 # Allow connections to X server.
 ifdef(`xserver.te', `
-allow $1_$2_t $1_xserver_tmp_t:dir r_dir_perms;
+# for when /tmp/.X11-unix is created by the X server
+allow $1_$2_t $1_xserver_tmp_t:dir search;
+# for when /tmp/.X11-unix is created by the system
+allow $1_$2_t initrc_xserver_tmp_t:dir search;
+
+# for /tmp/.X0-lock
+allow $1_$2_t $1_xserver_tmp_t:file getattr;
+
 allow $1_$2_t $1_xserver_tmp_t:sock_file rw_file_perms;
 can_unix_connect($1_$2_t, $1_xserver_t)')
 
diff -ruw /tmp/policy/macros/program/xserver_macros.te policy/macros/program/xserver_macros.te
--- /tmp/policy/macros/program/xserver_macros.te	2003-01-20 01:04:03.000000000 +0100
+++ policy/macros/program/xserver_macros.te	2003-03-07 17:53:53.000000000 +0100
@@ -37,12 +37,35 @@
 role $1_r types $1_xserver_t;
 ')dnl
 
-# This domain is granted permissions common to most domains (includes can_net)
-every_domain($1_xserver_t)
+uses_shlib($1_xserver_t)
+can_network($1_xserver_t)
 
-# Use capabilities.  Access /dev/mem.  
-allow $1_xserver_t self:capability { net_bind_service setuid setgid chown dac_override fsetid sys_rawio sys_admin sys_nice sys_tty_config };
-allow $1_xserver_t memory_device_t:chr_file { rw_file_perms execute };
+# for access within the domain
+general_domain_access($1_xserver_t)
+
+# for access to lots of base files
+general_file_read_access($1_xserver_t)
+
+allow $1_xserver_t proc_t:dir search;
+
+# Use capabilities.
+# allow setuid/setgid for the wrapper program to change UID
+# sys_rawio is for iopl access - should not be needed for frame-buffer
+# sys_admin, locking shared mem?  chowning IPC message queues or semaphores?
+# admin of APM bios?
+# sys_nice is so that the X server can set a negative nice value
+allow $1_xserver_t self:capability { setuid setgid sys_rawio sys_admin sys_nice };
+dontaudit $1_xserver_t self:capability { dac_override dac_read_search };
+
+# memory_device_t access is needed if not using the frame buffer
+dontaudit $1_xserver_t memory_device_t:chr_file read;
+#allow $1_xserver_t memory_device_t:chr_file { rw_file_perms execute };
+# net_bind_service is needed if you want your X server to allow TCP connections
+# from other hosts, EG an XDM serving a network of X terms
+# if you want good security you do not want this
+# not sure why some people want chown, fsetid, and sys_tty_config.
+#allow $1_xserver_t self:capability { net_bind_service chown fsetid sys_tty_config };
+dontaudit $1_xserver_t self:capability chown;
 
 allow $1_xserver_t mtrr_device_t:file rw_file_perms;
 allow $1_xserver_t apm_bios_t:chr_file rw_file_perms;
@@ -51,9 +74,9 @@
 allow $1_xserver_t devtty_t:lnk_file read;
 
 # Type for temporary files.
-type $1_xserver_tmp_t, file_type, sysadmfile, tmpfile;
-# Use this type when creating files in /tmp.
-file_type_auto_trans($1_xserver_t, tmp_t, $1_xserver_tmp_t)
+tmp_domain($1_xserver)
+file_type_auto_trans($1_xserver_t, initrc_xserver_tmp_t, $1_xserver_tmp_t, sock_file)
+allow $1_t initrc_xserver_tmp_t:dir r_dir_perms;
 
 # Create files in /var/log with the xserver_var_log_t type.
 file_type_auto_trans($1_xserver_t, var_log_t, xserver_var_log_t)
diff -ruw /tmp/policy/macros/user_macros.te policy/macros/user_macros.te
--- /tmp/policy/macros/user_macros.te	2003-02-25 22:58:20.000000000 +0100
+++ policy/macros/user_macros.te	2003-03-05 16:07:36.000000000 +0100
@@ -22,21 +22,19 @@
 ifelse($1, sysadm, `
 type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type;
 type $1_home_t, file_type, sysadmfile, home_type;
-type $1_tmp_t, file_type, sysadmfile, tmpfile;
+tmp_domain($1)
 ', `
 type $1_home_dir_t, file_type, sysadmfile, home_dir_type, user_home_dir_type, home_type, user_home_type;
 type $1_home_t, file_type, sysadmfile, home_type, user_home_type;
 # do not allow privhome access to sysadm_home_dir_t
 file_type_auto_trans(privhome, $1_home_dir_t, $1_home_t)
-type $1_tmp_t, file_type, sysadmfile, tmpfile, user_tmpfile;
+tmp_domain($1, `, user_tmpfile')
 ')
 
 # Create, access, and remove files in home directory.
 file_type_auto_trans($1_t, $1_home_dir_t, $1_home_t)
 allow $1_t $1_home_t:dir_file_class_set { relabelfrom relabelto };
 
-# Use the type when creating files in /tmp.
-file_type_auto_trans($1_t, tmp_t, $1_tmp_t)
 # Bind to a Unix domain socket in /tmp.
 allow $1_t $1_tmp_t:unix_stream_socket name_bind;
 
@@ -133,6 +131,7 @@
 ifdef(`crontab.te', `crontab_domain($1)')
 ifdef(`ssh.te', `ssh_domain($1)')
 ifdef(`irc.te', `irc_domain($1)')
+ifdef(`uml.te', `uml_domain($1)')
 ifdef(`clamav.te', `user_clamscan_domain($1)')
 ifdef(`fingerd.te', `fingerd_macro($1)')
 
@@ -149,6 +148,12 @@
 # Access other miscellaneous devices.
 allow $1_t misc_device_t:file_class_set rw_file_perms;
 
+ifdef(`apache.te', `
+ifelse(`$1', `sysadm', `', `
+apache_domain($1)
+')
+')
+
 # Use the network.
 can_network($1_t)
 
@@ -203,6 +208,9 @@
 # do not audit getattr on tmpfile, otherwise ls -l /tmp fills the logs
 dontaudit $1_t tmpfile:dir_file_class_set getattr;
 
+# do not audit getattr on disk devices, otherwise KDE fills the logs
+dontaudit $1_t { removable_device_t fixed_disk_device_t }:blk_file getattr;
+
 ifdef(`xdm.te', `
 # Connect to the X server run by the X Display Manager.
 can_unix_connect($1_t, xdm_t)
@@ -246,6 +254,7 @@
 
 # $1_r is authorized for $1_t for the initial login domain.
 role $1_r types $1_t;
+allow system_r $1_r;
 
 # user domains are granted the permissions common to most domains.
 every_domain($1_t)
@@ -277,6 +286,6 @@
 undefine(`in_user_role')
 define(`in_user_role', `
 role user_r types $1;
-#role second_user_r types $1;
+role staff_r types $1;
 ')
 
diff -ruw /tmp/policy/rbac policy/rbac
--- /tmp/policy/rbac	2002-12-03 15:56:38.000000000 +0100
+++ policy/rbac	2003-02-18 11:54:11.000000000 +0100
@@ -36,13 +36,6 @@
 allow system_r sysadm_r;
 
 #
-# Allow the user and admin role to transition to httpd_admin_r
-#
-ifdef(`apache.te',
-`allow user_r httpd_admin_r;
-allow sysadm_r httpd_admin_r;')
-
-# 
 # Allow the admin role to transition to the system
 # role for run_init.
 #

--Boundary-00=_spQd+t6SnJpBMXl--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA24814
	for <selinux@tycho.nsa.gov>; Mon, 4 Nov 2002 07:41:15 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA17726
	for <selinux@tycho.nsa.gov>; Mon, 4 Nov 2002 12:39:17 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id MAA17722 for <selinux@tycho.nsa.gov>; Mon, 4 Nov 2002 12:39:15 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 1891592713
	for <selinux@tycho.nsa.gov>; Mon,  4 Nov 2002 23:41:10 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id CA08B2253
	for <selinux@tycho.nsa.gov>; Mon,  4 Nov 2002 13:41:02 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: policy patches
Date: Mon, 4 Nov 2002 13:41:02 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_EWX16XXT69O6T8ZV7SJL"
Message-Id: <200211041341.02370.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_EWX16XXT69O6T8ZV7SJL
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I have attached two patches.  Games.diff addresses an unpublished security 
hole that will soon become public, and also a family of other similar 
problems.

The other patch has a bunch of things, a few things related to the 
initrc_devpts_t issue.  A change to the postfix policy which seems to be 
needed (for unknown reasons) on some systems (it's harmless enough that 
there's no reason not to include it in the main policy).  It also has a 
rewrite of xdm.te to use daemon_domain().  I've put in a change to courier.fc 
which allows you to press TAB in bash at the command line as a unpriv user 
without generating AVC messages...

There's a bunch of other things too which aren't very important.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_EWX16XXT69O6T8ZV7SJL
Content-Type: text/x-diff;
  charset="us-ascii";
  name="games.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="games.diff"

diff -ru /tmp/policy/domains/program/games.te policy/domains/program/games.te
--- /tmp/policy/domains/program/games.te	2002-10-01 18:40:37.000000000 +0200
+++ policy/domains/program/games.te	2002-11-04 02:25:59.000000000 +0100
@@ -3,8 +3,14 @@
 # Author:  Russell Coker <russell@coker.com.au>
 #
 
-# Type for the games that use X
-type games_exec_t, file_type, sysadmfile, exec_type;
+# type for shared data from games
+type games_data_t, file_type, sysadmfile;
+
+# domain games_t is for system operation of games, generic games daemons and
+# games recovery scripts, also defines games_exec_t
+daemon_domain(games)
+rw_dir_create_file(games_t, games_data_t)
+r_dir_file(initrc_t, games_data_t)
 
 # Everything else is in the x_client_domain macro in
 # macros/program/x_client_macros.te.
diff -ru /tmp/policy/file_contexts/program/games.fc policy/file_contexts/program/games.fc
--- /tmp/policy/file_contexts/program/games.fc	2002-10-01 18:40:37.000000000 +0200
+++ policy/file_contexts/program/games.fc	2002-11-04 02:26:15.000000000 +0100
@@ -1,2 +1,4 @@
 #  netscape/mozilla
 /usr/games/.*		system_u:object_r:games_exec_t
+/usr/lib/games/.* --	system_u:object_r:games_exec_t
+/var/games(/.*)?	system_u:object_r:games_data_t
diff -ru /tmp/policy/macros/user_macros.te policy/macros/user_macros.te
--- /tmp/policy/macros/user_macros.te	2002-10-28 22:56:04.000000000 +0100
+++ policy/macros/user_macros.te	2002-11-04 02:26:41.000000000 +0100
@@ -120,7 +120,10 @@
 ifdef(`chkpwd.te', `chkpwd_domain($1)')
 ifdef(`screen.te', `screen_domain($1)')
 ifdef(`netscape.te', `netscape_domain($1)')
-ifdef(`games.te', `x_client_domain($1, games)')
+ifdef(`games.te', `
+x_client_domain($1, games)
+rw_dir_create_file($1_games_t, games_data_t)
+')
 ifdef(`gpg.te', `gpg_domain($1)')
 ifdef(`xauth.te', `xauth_domain($1)')
 ifdef(`xserver.te', `xserver_domain($1)')

--------------Boundary-00=_EWX16XXT69O6T8ZV7SJL
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

Only in /tmp/policy/domains: admin
diff -ru /tmp/policy/domains/program/acct.te policy/domains/program/acct.te
--- /tmp/policy/domains/program/acct.te	2002-09-27 22:27:37.000000000 +0200
+++ policy/domains/program/acct.te	2002-11-02 13:15:30.000000000 +0100
@@ -12,6 +12,13 @@
 daemon_base_domain(acct)
 domain_auto_trans(system_crond_t, acct_exec_t, acct_t)
 
+# for monthly cron job
+file_type_auto_trans(acct_t, var_log_t, wtmp_t)
+
+ifdef(`logrotate.te', `
+allow acct_t logrotate_exec_t:file getattr;
+')
+
 type acct_data_t, file_type, sysadmfile;
 
 allow acct_t self:capability sys_pacct;
diff -ru /tmp/policy/domains/program/automount.te policy/domains/program/automount.te
--- /tmp/policy/domains/program/automount.te	2002-08-23 21:04:28.000000000 +0200
+++ policy/domains/program/automount.te	2002-11-02 13:15:30.000000000 +0100
@@ -23,6 +23,11 @@
 type automount_var_run_t, file_type, sysadmfile, pidfile;
 file_type_auto_trans(automount_t, var_run_t, automount_var_run_t)
 
+allow automount_t initrc_devpts_t:chr_file rw_file_perms;
+
+# for if the mount point is not labelled
+allow automount_t file_t:dir getattr;
+
 # Create temporary files.
 type automount_tmp_t, file_type, sysadmfile, tmpfile;
 file_type_auto_trans(automount_t, tmp_t, automount_tmp_t)
diff -ru /tmp/policy/domains/program/backup.te policy/domains/program/backup.te
--- /tmp/policy/domains/program/backup.te	2002-09-21 05:01:25.000000000 +0200
+++ policy/domains/program/backup.te	2002-11-01 15:30:00.000000000 +0100
@@ -29,7 +29,7 @@
 
 allow backup_t file_type:dir r_dir_perms;
 allow backup_t file_type:{ file lnk_file } r_file_perms;
-allow backup_t file_type:{ sock_file fifo_file } getattr;
+allow backup_t file_type:{ sock_file fifo_file chr_file blk_file } getattr;
 allow backup_t var_t:file create_file_perms;
 
 allow backup_t proc_t:dir r_dir_perms;
diff -ru /tmp/policy/domains/program/bootloader.te policy/domains/program/bootloader.te
--- /tmp/policy/domains/program/bootloader.te	2002-11-04 13:27:50.000000000 +0100
+++ policy/domains/program/bootloader.te	2002-10-30 22:25:50.000000000 +0100
@@ -20,7 +20,7 @@
 allow bootloader_t var_log_t:file write;
 
 domain_auto_trans(sysadm_t, bootloader_exec_t, bootloader_t)
-allow bootloader_t privfd:fd use;
+allow bootloader_t { initrc_t privfd }:fd use;
 
 file_type_auto_trans(bootloader_t, tmp_t, bootloader_tmp_t)
 allow bootloader_t bootloader_tmp_t:devfile_class_set create_file_perms;
@@ -78,7 +78,7 @@
 allow bootloader_t etc_runtime_t:file r_file_perms;
 
 allow bootloader_t devtty_t:chr_file rw_file_perms;
-allow bootloader_t admin_tty_type:chr_file rw_file_perms;
+allow bootloader_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
 
 ifdef(`dpkg.te', `
 # for making an initrd
diff -ru /tmp/policy/domains/program/dpkg.te policy/domains/program/dpkg.te
--- /tmp/policy/domains/program/dpkg.te	2002-11-04 13:27:51.000000000 +0100
+++ policy/domains/program/dpkg.te	2002-11-02 23:26:16.000000000 +0100
@@ -32,6 +32,7 @@
 ifdef(`modutil.te', `
 domain_auto_trans(dpkg_t, update_modules_exec_t, update_modules_t)
 domain_auto_trans(dpkg_t, insmod_exec_t, insmod_t)
+domain_auto_trans(dpkg_t, depmod_exec_t, depmod_t)
 ')
 ifdef(`ipsec.te', `
 allow { ipsec_mgmt_t ipsec_t } dpkg_t:fd use;
@@ -123,10 +124,16 @@
 r_dir_file({ apt_t userdomain }, { var_lib_dpkg_t var_lib_apt_t var_cache_apt_t })
 ifdef(`crond.te', `
 r_dir_file(system_crond_t, var_lib_dpkg_t)
+allow system_crond_t etc_dpkg_t:file r_file_perms;
+
+# for Debian cron job
+allow system_crond_t shadow_t:file { read getattr };
+create_dir_file(system_crond_t, tetex_data_t)
+can_exec(dpkg_t, tetex_data_t)
 ')
 
 r_dir_file(install_menu_t, var_lib_dpkg_t)
-allow { apt_t install_menu_t userdomain system_crond_t } etc_dpkg_t:file r_file_perms;
+allow { apt_t install_menu_t userdomain } etc_dpkg_t:file r_file_perms;
 can_exec(sysadm_t, etc_dpkg_t)
 
 # Inherit and use descriptors from any domain.
@@ -168,7 +175,6 @@
 allow dpkg_t root_dir_type:dir getattr;
 
 allow dpkg_t security_t:security sid_to_context;
-domain_auto_trans(dpkg_t, depmod_exec_t, depmod_t)
 
 # change to the apt_t domain on exec from dpkg_t (dselect)
 domain_auto_trans(dpkg_t, apt_exec_t, apt_t)
@@ -254,13 +260,6 @@
 
 allow install_menu_t self:process { fork sigchld };
 
-# for Debian cron job
-ifdef(`crond.te', `
-allow system_crond_t shadow_t:file { read getattr };
-create_dir_file(system_crond_t, tetex_data_t)
-can_exec(dpkg_t, tetex_data_t)
-')
-
 role system_r types { dpkg_t apt_t install_menu_t };
 
 #################################
diff -ru /tmp/policy/domains/program/fcron.te policy/domains/program/fcron.te
--- /tmp/policy/domains/program/fcron.te	2002-10-01 19:28:43.000000000 +0200
+++ policy/domains/program/fcron.te	2002-11-02 23:45:13.000000000 +0100
@@ -39,7 +39,7 @@
 allow fcron_t system_crond_script_t:file create_file_perms;
 
 # Read /etc/security/cron_context
-allow fcron_t cron_context_t:file r_file_perms;
+allow fcron_t default_context_t:file r_file_perms;
 
 allow fcron_t etc_t:lnk_file read;
 allow fcron_t { etc_t resolv_conf_t }:file { read getattr };
diff -ru /tmp/policy/domains/program/postfix.te policy/domains/program/postfix.te
--- /tmp/policy/domains/program/postfix.te	2002-11-04 13:27:52.000000000 +0100
+++ policy/domains/program/postfix.te	2002-11-01 12:38:12.000000000 +0100
@@ -177,7 +177,7 @@
 postfix_user_domain(postqueue)
 allow postfix_postqueue_t postfix_public_t:dir search;
 allow postfix_postqueue_t postfix_public_t:fifo_file getattr;
-allow postfix_postqueue_t self:udp_socket create;
+allow postfix_postqueue_t self:udp_socket { create ioctl };
 allow postfix_master_t postfix_postqueue_exec_t:file getattr;
 
 # to write the mailq output, it really should not need read access!
@@ -193,6 +193,7 @@
 postfix_user_domain(showq)
 # the following auto_trans is usually in postfix server domain
 domain_auto_trans_read(postfix_master_t, postfix_showq_exec_t, postfix_showq_t)
+allow postfix_showq_t self:udp_socket { create ioctl };
 allow postfix_showq_t { postfix_spool_t }:dir r_dir_perms;
 r_dir_file(postfix_showq_t, postfix_spool_maildrop_t)
 domain_auto_trans_read(postfix_postqueue_t, postfix_showq_exec_t, postfix_showq_t)
diff -ru /tmp/policy/domains/program/postgresql.te policy/domains/program/postgresql.te
--- /tmp/policy/domains/program/postgresql.te	2002-10-28 22:55:56.000000000 +0100
+++ policy/domains/program/postgresql.te	2002-11-03 10:33:24.000000000 +0100
@@ -16,7 +16,10 @@
 domain_auto_trans(dpkg_t, postgresql_exec_t, postgresql_t)
 ')
 
-dontaudit postgresql_t { sysadm_home_dir_t var_spool_t }:dir search;
+dontaudit postgresql_t sysadm_home_dir_t:dir search;
+
+# for currect directory of scripts
+allow postgresql_t { var_spool_t cron_spool_t }:dir search;
 
 # capability kill is for shutdown script
 allow postgresql_t self:capability { kill dac_override dac_read_search chown fowner fsetid setuid setgid };
diff -ru /tmp/policy/domains/program/xdm.te policy/domains/program/xdm.te
--- /tmp/policy/domains/program/xdm.te	2002-10-10 17:50:21.000000000 +0200
+++ policy/domains/program/xdm.te	2002-11-02 23:53:31.000000000 +0100
@@ -13,21 +13,13 @@
 # spawned by getty.
 # xdm_exec_t is the type of the [xgk]dm program
 #
-type xdm_t, domain, privuser, privrole, privlog, auth, privowner, privmem;
-role system_r types xdm_t;
-every_domain(xdm_t)
-type xdm_exec_t, file_type, sysadmfile, exec_type;
-type xdm_var_run_t, file_type, sysadmfile, pidfile;
-type xdm_tmp_t, file_type, sysadmfile, tmpfile;
+daemon_domain(xdm, `, privuser, privrole, auth, privowner, privmem')
+#every_domain(xdm_t)
+tmp_domain(xdm)
 type xsession_exec_t, file_type, sysadmfile, exec_type;
 
-# Run the X Display Manager in its own domain.
-domain_auto_trans({ init_t initrc_t }, xdm_exec_t, xdm_t)
-
 allow xdm_t default_context_t:file { read getattr };
 
-allow xdm_t init_t:fd use;
-
 # for reboot
 allow xdm_t initctl_t:fifo_file write;
 
@@ -43,8 +35,6 @@
 domain_trans(xdm_t, xsession_exec_t, unpriv_userdomain)
 
 # Label pid and temporary files with derived types.
-file_type_auto_trans(xdm_t, var_run_t, xdm_var_run_t)
-file_type_auto_trans(xdm_t, tmp_t, xdm_tmp_t)
 rw_dir_create_file(xdm_xserver_t, xdm_tmp_t)
 allow xdm_xserver_t xdm_tmp_t:sock_file create_file_perms;
 
Only in /tmp/policy/domains: system
Only in /tmp/policy/domains: user
diff -ru /tmp/policy/file_contexts/program/courier.fc policy/file_contexts/program/courier.fc
--- /tmp/policy/file_contexts/program/courier.fc	2002-07-12 17:19:44.000000000 +0200
+++ policy/file_contexts/program/courier.fc	2002-10-29 17:23:06.000000000 +0100
@@ -1,9 +1,9 @@
 # courier pop, imap, and webmail
-/usr/lib/courier(/.*)?		system_u:object_r:etc_courier_t
+/usr/lib/courier(/.*)?		system_u:object_r:bin_t
+/usr/lib/courier/rootcerts(/.*)? system_u:object_r:etc_courier_t
 /usr/lib/courier/authlib/.*	system_u:object_r:courier_authdaemon_exec_t
 /usr/lib/courier/courier/.*	system_u:object_r:courier_exec_t
 /usr/lib/courier/courier/courierpop.*	system_u:object_r:courier_pop_exec_t
-/usr/lib/courier/courier/courierpop3.*	system_u:object_r:courier_pop_exec_t
 /usr/lib/courier/courier/imaplogin	system_u:object_r:courier_pop_exec_t
 /usr/lib/courier/courier/pcpd	system_u:object_r:courier_pcp_exec_t
 /usr/lib/courier/imapd		system_u:object_r:courier_pop_exec_t
diff -ru /tmp/policy/file_contexts/program/fcron.fc policy/file_contexts/program/fcron.fc
--- /tmp/policy/file_contexts/program/fcron.fc	2002-09-21 05:01:29.000000000 +0200
+++ policy/file_contexts/program/fcron.fc	2002-11-02 23:47:22.000000000 +0100
@@ -3,3 +3,4 @@
 /var/spool/fcron		system_u:object_r:fcron_spool_t
 /var/spool/fcron/.*		<<none>>
 /var/spool/fcron/systab.orig	system_u:object_r:sysadm_cron_spool_t
+/var/run/fcron.fifo		system_u:object_r:var_run_fcron_t
diff -ru /tmp/policy/file_contexts/program/ipsec.fc policy/file_contexts/program/ipsec.fc
--- /tmp/policy/file_contexts/program/ipsec.fc	2002-09-21 05:01:29.000000000 +0200
+++ policy/file_contexts/program/ipsec.fc	2002-11-02 23:47:02.000000000 +0100
@@ -16,3 +16,4 @@
 /usr/sbin/ipsec			system_u:object_r:ipsec_mgmt_exec_t
 /usr/local/sbin/ipsec		system_u:object_r:ipsec_mgmt_exec_t
 /var/run/ipsec.info		system_u:object_r:ipsec_var_run_t
+/var/run/pluto.ctl		system_u:object_r:ipsec_var_run_t
diff -ru /tmp/policy/macros/program/netscape_macros.te policy/macros/program/netscape_macros.te
--- /tmp/policy/macros/program/netscape_macros.te	2002-10-01 19:28:53.000000000 +0200
+++ policy/macros/program/netscape_macros.te	2002-11-02 13:19:56.000000000 +0100
@@ -27,6 +27,9 @@
 allow httpd_t $1_netscape_t:tcp_socket { recvfrom acceptfrom };
 ')
 
+dontaudit $1_netscape_t $1_home_t:dir rw_dir_perms;
+dontaudit $1_netscape_t $1_home_t:file rw_file_perms;
+
 # Use printer
 ifdef(`lpr.te', `domain_auto_trans($1_netscape_t, lpr_exec_t, $1_lpr_t)')
 

--------------Boundary-00=_EWX16XXT69O6T8ZV7SJL--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Message-ID: <41AB98FB.4020702@redhat.com>
Date: Mon, 29 Nov 2004 16:47:39 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: policy patch
References: <200411260027.41899.russell@coker.com.au>
In-Reply-To: <200411260027.41899.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>The attached patch makes some trivial policy changes.
>
>Allows Debian systems to touch /etc from an init script.
>
>Only Red Hat needs initrc_t to be able to stat all files from an init script.
>
>$1_login_t should not inherit a file handle from init (maybe a bug that has to 
>be fixed - it certainly needs something other than a dontaudit).
>
>Updated policy for the latest version of asterisk and postgrey.
>
>No domain should have both auth and auth_chkpwd attributes.  If the domain has 
>auth then it will never have a need to run unix_chkpwd.
>
>Removed some duplicate rules and needless {}.
>
>Allow kudzu to do everything it wants.
>
>Mailman should not have a dontaudit for access to src_t.  Any access to src_t 
>is a bug.  The bug that caused this to be added is supposed to be fixed in 
>Fedora now.  If it turns out that /usr/src is accessed for other reasons then 
>it's more bugs we need to fix and we don't want it hidden.
>
>Don't use a dontaudit rule for rhgb_t access to /tmp, that will cause us pain 
>later on if rhgb is changed to need such access.
>
>Don't use the root_dir_type attribute for type tftpdir_t, it's usually not the 
>root of a file system, and there's no good reason for using it.  Maybe we can 
>do as the comment suggests and remove that attribute entirely?
>
>Put in a dontaudit rule to stop some annoying messages on sighup.
>
>Removed the CVS comment line from amanda.fc.  We don't seem to be using CVS in 
>a way that makes sense of that line and it just makes for needless file 
>changes on every update.  Best to be consistent with the other files and 
>remove that line.
>
>/var/spool/mqueue is part of Sendmail.  It should not be referenced apart from 
>through the sendmail policy.
>
>  
>
/var/spool/mqueue is needed for targeted policy which does not include 
sendmail.te. 
Targeted policy uses mta.te and squirrelmail to access this directory.

>$1_tty_device_t is not a file, the attribute file_type does not belong.  Also 
>updated types/file.te to allow the terminal devices to be associated with the 
>root fs without this attribute.
>
>mozilla should not be permitted to write to random devices (this means append 
>too).  Now that we aren't labelling a /usr/tmp sym-link as tmp_t we can 
>remove the access to tmp_t:lnk_file.
>
>gam_server seems to run wild and want to explore every part of the file 
>system.  I put in a ifdef(`distro_redhat' as Fedora is the only distribution 
>currently relying on gam.  I think that some changes need to be made to gam.
>
>  
>
>------------------------------------------------------------------------
>
>diff -ru /usr/src/se/policy/domains/program/initrc.te ./domains/program/initrc.te
>--- /usr/src/se/policy/domains/program/initrc.te	2004-11-21 21:51:11.000000000 +1100
>+++ ./domains/program/initrc.te	2004-11-25 23:20:31.000000000 +1100
>@@ -12,7 +12,7 @@
> # initrc_exec_t is the type of the init program.
> #
> # do not use privmail for sendmail as it creates a type transition conflict
>-type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, auth_write, unrestricted, ') domain, privlog, privowner, privmodule, ifdef(`sendmail.te', `', `privmail,') sysctl_kernel_writer;
>+type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, auth_write, unrestricted, ') domain, privlog, privowner, privmodule, ifdef(`sendmail.te', `', `privmail,') ifdef(`distro_debian', `etc_writer, ') sysctl_kernel_writer;
> ifdef(`sendmail.te', `
> allow system_mail_t initrc_t:fd use;
> allow system_mail_t initrc_t:fifo_file write;
>@@ -36,6 +36,7 @@
> # Read system information files in /proc.
> allow initrc_t proc_t:dir r_dir_perms;
> allow initrc_t proc_t:{ file lnk_file } r_file_perms;
>+allow initrc_t proc_mdstat_t:file { getattr read };
> 
> # Allow IPC with self
> allow initrc_t self:unix_dgram_socket create_socket_perms;
>@@ -63,6 +64,14 @@
> allow initrc_t var_run_t:{ file sock_file lnk_file } unlink;
> allow initrc_t var_run_t:dir { create rmdir };
> 
>+ifdef(`distro_debian', `
>+allow initrc_t etc_t:dir setattr;
>+
>+# for storing state under /dev/shm
>+file_type_auto_trans(initrc_t, tmpfs_t, initrc_var_run_t, dir)
>+allow initrc_var_run_t tmpfs_t:filesystem associate;
>+')
>+
> allow initrc_t framebuf_device_t:chr_file r_file_perms;
> 
> # Use capabilities.
>@@ -330,7 +338,9 @@
> 
> r_dir_file(initrc_t,selinux_config_t)
> 
>+ifdef(`distro_redhat', `
> allow initrc_t file_type:{ dir_file_class_set socket_class_set } getattr;
>+')
> 
> ifdef(`unlimitedRC', `
> unconfined_domain(initrc_t) 
>diff -ru /usr/src/se/policy/domains/program/login.te ./domains/program/login.te
>--- /usr/src/se/policy/domains/program/login.te	2004-11-21 21:51:11.000000000 +1100
>+++ ./domains/program/login.te	2004-11-22 03:14:43.000000000 +1100
>@@ -126,7 +126,7 @@
> r_dir_file($1_login_t, selinux_config_t)
> 
> allow $1_login_t mouse_device_t:chr_file { getattr setattr };
>-dontaudit $1_login_t init_t:fd use;
>+
> ')dnl end login_domain macro
> #################################
> #
>diff -ru /usr/src/se/policy/domains/program/unused/asterisk.te ./domains/program/unused/asterisk.te
>--- /usr/src/se/policy/domains/program/unused/asterisk.te	2004-10-20 09:31:06.000000000 +1000
>+++ ./domains/program/unused/asterisk.te	2004-11-13 04:12:14.000000000 +1100
>@@ -15,6 +15,10 @@
> 
> allow asterisk_t proc_t:file { getattr read };
> 
>+allow asterisk_t { bin_t sbin_t }:dir search;
>+allow asterisk_t bin_t:lnk_file read;
>+can_exec(asterisk_t, bin_t)
>+
> etcdir_domain(asterisk)
> logdir_domain(asterisk)
> var_lib_domain(asterisk)
>@@ -47,5 +51,8 @@
> # for /var/run/asterisk
> allow asterisk_t self:capability dac_override;
> 
>+# for shutdown
>+dontaudit asterisk_t self:capability sys_tty_config;
>+
> tmpfs_domain(asterisk)
> tmp_domain(asterisk)
>diff -ru /usr/src/se/policy/domains/program/unused/consoletype.te ./domains/program/unused/consoletype.te
>--- /usr/src/se/policy/domains/program/unused/consoletype.te	2004-11-21 21:51:13.000000000 +1100
>+++ ./domains/program/unused/consoletype.te	2004-11-22 03:14:43.000000000 +1100
>@@ -52,7 +52,7 @@
> allow consoletype_t pam_var_run_t:file { getattr read };
> ')
> ifdef(`distro_redhat', `
>-allow consoletype_t tmpfs_t:chr_file { getattr ioctl read write };
>+allow consoletype_t tmpfs_t:chr_file rw_file_perms;
> ')
> ifdef(`firstboot.te', `
> allow consoletype_t firstboot_t:fifo_file write;
>diff -ru /usr/src/se/policy/domains/program/unused/cups.te ./domains/program/unused/cups.te
>--- /usr/src/se/policy/domains/program/unused/cups.te	2004-11-21 21:51:13.000000000 +1100
>+++ ./domains/program/unused/cups.te	2004-11-25 21:09:23.000000000 +1100
>@@ -184,7 +184,7 @@
> allow cupsd_config_t cupsd_var_run_t:file { getattr read };
> allow cupsd_config_t cupsd_t:process { signal };
> allow cupsd_config_t cupsd_t:{ file lnk_file } { getattr read };
>-r_dir_file(cupsd_config_t, cupsd_t)
>+can_ps(cupsd_config_t, cupsd_t)
> 
> allow cupsd_config_t self:capability chown;
> 
>diff -ru /usr/src/se/policy/domains/program/unused/dovecot.te ./domains/program/unused/dovecot.te
>--- /usr/src/se/policy/domains/program/unused/dovecot.te	2004-11-20 01:18:15.000000000 +1100
>+++ ./domains/program/unused/dovecot.te	2004-11-22 03:14:43.000000000 +1100
>@@ -38,7 +38,7 @@
> allow dovecot_t mail_spool_t:lnk_file read;
> allow dovecot_t var_spool_t:dir { search };
> 
>-daemon_sub_domain(dovecot_t, dovecot_auth, `, auth, auth_chkpwd')
>+daemon_sub_domain(dovecot_t, dovecot_auth, `, auth_chkpwd')
> allow dovecot_auth_t self:process { fork signal_perms };
> allow dovecot_auth_t dovecot_t:unix_stream_socket { getattr accept read write ioctl };
> allow dovecot_auth_t self:unix_dgram_socket create_socket_perms;
>diff -ru /usr/src/se/policy/domains/program/unused/gpm.te ./domains/program/unused/gpm.te
>--- /usr/src/se/policy/domains/program/unused/gpm.te	2004-11-25 20:37:11.000000000 +1100
>+++ ./domains/program/unused/gpm.te	2004-11-25 21:11:40.000000000 +1100
>@@ -32,8 +32,6 @@
> allow gpm_t self:unix_dgram_socket create_socket_perms;
> allow gpm_t self:unix_stream_socket create_stream_socket_perms;
> 
>-allow gpm_t mouse_device_t:chr_file rw_file_perms;
>-
> # Read and write ttys.
> allow gpm_t tty_device_t:chr_file rw_file_perms;
> 
>diff -ru /usr/src/se/policy/domains/program/unused/hald.te ./domains/program/unused/hald.te
>--- /usr/src/se/policy/domains/program/unused/hald.te	2004-11-25 20:37:11.000000000 +1100
>+++ ./domains/program/unused/hald.te	2004-11-25 21:12:51.000000000 +1100
>@@ -54,7 +54,7 @@
> allow hald_t udev_tbl_t:file { getattr read };
> ')
> 
>-ifdef(`udev.te', `
>+ifdef(`hotplug.te', `
> r_dir_file(hald_t, hotplug_etc_t)
> ')
> allow hald_t usbdevfs_t:dir search;
>diff -ru /usr/src/se/policy/domains/program/unused/iptables.te ./domains/program/unused/iptables.te
>--- /usr/src/se/policy/domains/program/unused/iptables.te	2004-11-25 20:37:11.000000000 +1100
>+++ ./domains/program/unused/iptables.te	2004-11-25 23:18:50.000000000 +1100
>@@ -54,7 +54,7 @@
> ifdef(`gnome-pty-helper.te', `allow iptables_t sysadm_gph_t:fd use;')
> 
> allow iptables_t proc_t:file { getattr read };
>-allow iptables_t proc_net_t:dir { search };
>+allow iptables_t proc_net_t:dir search;
> allow iptables_t proc_net_t:file { read getattr };
> 
> # system-config-network appends to /var/log
>diff -ru /usr/src/se/policy/domains/program/unused/kudzu.te ./domains/program/unused/kudzu.te
>--- /usr/src/se/policy/domains/program/unused/kudzu.te	2004-11-21 21:51:13.000000000 +1100
>+++ ./domains/program/unused/kudzu.te	2004-11-25 21:14:19.000000000 +1100
>@@ -3,13 +3,17 @@
> # Author:  Russell Coker <russell@coker.com.au>
> #
> 
>-daemon_base_domain(kudzu, `, etc_writer, privmodule, sysctl_kernel_writer, fs_domain')
>+daemon_base_domain(kudzu, `, etc_writer, privmodule, sysctl_kernel_writer, fs_domain, privmem')
> 
> read_locale(kudzu_t)
> 
> # for /etc/sysconfig/hwconf - probably need a new type
> allow kudzu_t etc_runtime_t:file rw_file_perms;
> 
>+# for kmodule
>+allow kudzu_t zero_device_t:chr_file rx_file_perms;
>+allow kudzu_t memory_device_t:chr_file { read write execute };
>+
> allow kudzu_t ramfs_t:dir search;
> allow kudzu_t ramfs_t:sock_file write;
> allow kudzu_t etc_t:file { getattr read };
>diff -ru /usr/src/se/policy/domains/program/unused/mailman.te ./domains/program/unused/mailman.te
>--- /usr/src/se/policy/domains/program/unused/mailman.te	2004-11-20 01:18:16.000000000 +1100
>+++ ./domains/program/unused/mailman.te	2004-11-25 21:14:51.000000000 +1100
>@@ -71,8 +71,7 @@
> domain_auto_trans({ httpd_t httpd_suexec_t }, mailman_cgi_exec_t, mailman_cgi_t)
> # should have separate types for public and private archives
> r_dir_file(httpd_t, mailman_archive_t)
>-rw_dir_file(mailman_cgi_t, mailman_archive_t)
>-allow mailman_cgi_t mailman_archive_t:lnk_file create_lnk_perms;
>+rw_dir_create_file(mailman_cgi_t, mailman_archive_t)
> allow httpd_t mailman_data_t:dir { getattr search };
> 
> dontaudit mailman_cgi_t httpd_log_t:file append;
>@@ -84,7 +83,6 @@
> allow mailman_cgi_t devtty_t:chr_file { read write };
> allow mailman_cgi_t self:process { fork sigchld };
> allow mailman_cgi_t var_spool_t:dir search;
>-dontaudit mailman_cgi_t src_t:dir search;
> ')
> 
> allow mta_delivery_agent mailman_data_t:dir search;
>diff -ru /usr/src/se/policy/domains/program/unused/ping.te ./domains/program/unused/ping.te
>--- /usr/src/se/policy/domains/program/unused/ping.te	2004-11-20 01:18:16.000000000 +1100
>+++ ./domains/program/unused/ping.te	2004-11-22 03:14:43.000000000 +1100
>@@ -55,5 +55,5 @@
> # it tries to access /var/run
> dontaudit ping_t var_t:dir search;
> dontaudit ping_t devtty_t:chr_file { read write };
>-dontaudit ping_t ping_t:capability sys_tty_config;
>+dontaudit ping_t self:capability sys_tty_config;
> 
>diff -ru /usr/src/se/policy/domains/program/unused/postgresql.te ./domains/program/unused/postgresql.te
>--- /usr/src/se/policy/domains/program/unused/postgresql.te	2004-11-25 20:37:12.000000000 +1100
>+++ ./domains/program/unused/postgresql.te	2004-11-25 22:35:08.000000000 +1100
>@@ -34,7 +34,7 @@
> 
> # capability kill is for shutdown script
> allow postgresql_t self:capability { kill dac_override dac_read_search chown fowner fsetid setuid setgid sys_nice sys_tty_config };
>-dontaudit postgresql_t postgresql_t:capability { sys_admin };
>+dontaudit postgresql_t self:capability sys_admin;
> 
> etcdir_domain(postgresql)
> typealias postgresql_etc_t alias etc_postgresql_t;
>diff -ru /usr/src/se/policy/domains/program/unused/postgrey.te ./domains/program/unused/postgrey.te
>--- /usr/src/se/policy/domains/program/unused/postgrey.te	2004-08-28 12:05:04.000000000 +1000
>+++ ./domains/program/unused/postgrey.te	2004-11-13 01:02:26.000000000 +1100
>@@ -20,10 +20,11 @@
> can_network(postgrey_t)
> can_ypbind(postgrey_t)
> allow postgrey_t postgrey_port_t:tcp_socket name_bind;
>+allow postgrey_t self:unix_dgram_socket create_socket_perms;
> allow postgrey_t self:unix_stream_socket create_stream_socket_perms;
> allow postgrey_t proc_t:file { getattr read };
> 
>-allow postgrey_t self:capability { chown setuid };
>+allow postgrey_t self:capability { chown setgid setuid };
> dontaudit postgrey_t self:capability sys_tty_config;
> 
> var_lib_domain(postgrey)
>diff -ru /usr/src/se/policy/domains/program/unused/rhgb.te ./domains/program/unused/rhgb.te
>--- /usr/src/se/policy/domains/program/unused/rhgb.te	2004-11-13 03:56:03.000000000 +1100
>+++ ./domains/program/unused/rhgb.te	2004-11-22 03:14:43.000000000 +1100
>@@ -22,7 +22,7 @@
> allow rhgb_t proc_t:file { getattr read };
> 
> allow rhgb_t devtty_t:chr_file { read write };
>-allow rhgb_t tty_device_t:chr_file { ioctl read write };
>+allow rhgb_t tty_device_t:chr_file rw_file_perms;
> 
> read_locale(rhgb_t)
> allow rhgb_t { etc_t etc_runtime_t }:file { getattr read };
>@@ -85,7 +85,7 @@
> ifdef(`firstboot.te', `
> allow rhgb_t firstboot_rw_t:file r_file_perms;
> ')
>-dontaudit rhgb_t tmp_t:dir search;
>+allow rhgb_t tmp_t:dir search;
> allow rhgb_t xdm_xserver_t:process sigkill;
> allow domain rhgb_devpts_t:chr_file { read write };
> ifdef(`fsadm.te', `
>diff -ru /usr/src/se/policy/domains/program/unused/sendmail.te ./domains/program/unused/sendmail.te
>--- /usr/src/se/policy/domains/program/unused/sendmail.te	2004-11-13 03:56:04.000000000 +1100
>+++ ./domains/program/unused/sendmail.te	2004-11-25 22:43:05.000000000 +1100
>@@ -99,5 +99,7 @@
> allow system_mail_t sysctl_kernel_t:file read;
> dontaudit system_mail_t system_crond_tmp_t:file append;
> dontaudit sendmail_t admin_tty_type:chr_file { getattr ioctl };
>+
>+# sendmail wants to read /var/run/utmp if the controlling tty is /dev/console
> allow sendmail_t initrc_var_run_t:file { getattr read };
> dontaudit sendmail_t initrc_var_run_t:file { lock write };
>diff -ru /usr/src/se/policy/domains/program/unused/sxid.te ./domains/program/unused/sxid.te
>--- /usr/src/se/policy/domains/program/unused/sxid.te	2004-08-19 17:10:37.000000000 +1000
>+++ ./domains/program/unused/sxid.te	2004-11-13 04:00:22.000000000 +1100
>@@ -29,6 +29,7 @@
> 
> allow sxid_t file_type:notdevfile_class_set getattr;
> allow sxid_t { device_t device_type }:{ chr_file blk_file } getattr;
>+allow sxid_t ttyfile:chr_file getattr;
> allow sxid_t file_type:dir { getattr read search };
> allow sxid_t sysadmfile:file read;
> allow sxid_t root_dir_type:dir { getattr read search };
>diff -ru /usr/src/se/policy/domains/program/unused/tftpd.te ./domains/program/unused/tftpd.te
>--- /usr/src/se/policy/domains/program/unused/tftpd.te	2004-10-20 09:31:10.000000000 +1000
>+++ ./domains/program/unused/tftpd.te	2004-11-13 04:00:39.000000000 +1100
>@@ -16,7 +16,7 @@
> type tftp_port_t, port_type, reserved_port_type;
> 
> # tftpdir_t is the type of files in the /tftpboot directories.
>-type tftpdir_t, file_type, root_dir_type, sysadmfile;
>+type tftpdir_t, file_type, sysadmfile;
> r_dir_file(tftpd_t, tftpdir_t)
> 
> domain_auto_trans(inetd_t, tftpd_exec_t, tftpd_t)
>diff -ru /usr/src/se/policy/domains/user.te ./domains/user.te
>--- /usr/src/se/policy/domains/user.te	2004-11-25 20:37:08.000000000 +1100
>+++ ./domains/user.te	2004-11-25 22:46:14.000000000 +1100
>@@ -48,6 +48,8 @@
> allow $1_r $2_r;
> type_change $2_t $1_devpts_t:chr_file $2_devpts_t;
> type_change $2_t $1_tty_device_t:chr_file $2_tty_device_t;
>+# avoid annoying messages on terminal hangup
>+dontaudit $1_t { $2_devpts_t $2_tty_device_t }:chr_file ioctl;
> ')
> 
> # Reach sysadm_t via programs like userhelper/sudo/su
>diff -ru /usr/src/se/policy/file_contexts/program/amanda.fc ./file_contexts/program/amanda.fc
>--- /usr/src/se/policy/file_contexts/program/amanda.fc	2004-11-13 03:56:05.000000000 +1100
>+++ ./file_contexts/program/amanda.fc	2004-11-13 04:03:15.000000000 +1100
>@@ -1,8 +1,6 @@
> #
> # Author:  Carsten Grohmann <carstengrohmann@gmx.de>
> #
>-# $Id: amanda.fc,v 1.3 2004/03/03 20:55:53 sds Exp $
>-#
> 
> # amanda
> /etc/amanda(/.*)?			system_u:object_r:amanda_config_t
>diff -ru /usr/src/se/policy/file_contexts/program/sendmail.fc ./file_contexts/program/sendmail.fc
>--- /usr/src/se/policy/file_contexts/program/sendmail.fc	2004-11-21 21:51:16.000000000 +1100
>+++ ./file_contexts/program/sendmail.fc	2004-11-22 02:45:31.000000000 +1100
>@@ -1,5 +1,6 @@
> # sendmail
> /etc/mail(/.*)?				system_u:object_r:etc_mail_t
>+/var/spool/(client)?mqueue(/.*)?	system_u:object_r:mqueue_spool_t
> /var/log/sendmail\.st		--	system_u:object_r:sendmail_log_t
> /var/log/mail(/.*)?			system_u:object_r:sendmail_log_t
> /var/run/sendmail\.pid		--	system_u:object_r:sendmail_var_run_t
>diff -ru /usr/src/se/policy/file_contexts/types.fc ./file_contexts/types.fc
>--- /usr/src/se/policy/file_contexts/types.fc	2004-11-25 20:37:14.000000000 +1100
>+++ ./file_contexts/types.fc	2004-11-22 03:14:43.000000000 +1100
>@@ -399,7 +396,6 @@
> #
> /var/spool(/.*)?		system_u:object_r:var_spool_t
> /var/spool/texmf(/.*)?		system_u:object_r:tetex_data_t
>-/var/spool/(client)?mqueue(/.*)?	system_u:object_r:mqueue_spool_t
> 
> # 
> # /var/log
>diff -ru /usr/src/se/policy/macros/admin_macros.te ./macros/admin_macros.te
>--- /usr/src/se/policy/macros/admin_macros.te	2004-11-25 20:37:20.000000000 +1100
>+++ ./macros/admin_macros.te	2004-11-25 22:57:58.000000000 +1100
>@@ -25,7 +25,7 @@
> tmp_domain($1)
> 
> # Type for tty devices.
>-type $1_tty_device_t, file_type, sysadmfile, ttyfile, dev_fs;
>+type $1_tty_device_t, sysadmfile, ttyfile, dev_fs;
> 
> # Inherit rules for ordinary users.
> base_user_domain($1)
>diff -ru /usr/src/se/policy/macros/base_user_macros.te ./macros/base_user_macros.te
>--- /usr/src/se/policy/macros/base_user_macros.te	2004-11-25 20:37:20.000000000 +1100
>+++ ./macros/base_user_macros.te	2004-11-25 23:01:56.000000000 +1100
>@@ -349,7 +344,7 @@
> #
> # Running ifconfig as a user generates the following
> #
>-dontaudit $1_t $1_t:socket create;
>+dontaudit $1_t self:socket create;
> dontaudit $1_t sysctl_net_t:dir search;
> 
> dontaudit $1_t default_context_t:dir search;
>diff -ru /usr/src/se/policy/macros/program/crontab_macros.te ./macros/program/crontab_macros.te
>--- /usr/src/se/policy/macros/program/crontab_macros.te	2004-11-13 03:56:11.000000000 +1100
>+++ ./macros/program/crontab_macros.te	2004-11-22 03:14:43.000000000 +1100
>@@ -55,6 +55,7 @@
> allow $1_crontab_t self:process { fork signal_perms };
> ifdef(`fcron.te', `
> # fcron wants an instant update of a crontab change for the administrator
>+# also crontab does a security check for crontab -u
> ifelse(`$1', `sysadm', `
> allow $1_crontab_t crond_t:process signal;
> can_setfscreate($1_crontab_t)
>@@ -63,6 +64,9 @@
> ')dnl end ifelse
> ')dnl end ifdef fcron
> 
>+# for the checks used by crontab -u
>+dontaudit $1_crontab_t security_t:dir search;
>+
> # crontab signals crond by updating the mtime on the spooldir
> allow $1_crontab_t cron_spool_t:dir setattr;
> # Allow crond to read those crontabs in cron spool.
>diff -ru /usr/src/se/policy/macros/program/mozilla_macros.te ./macros/program/mozilla_macros.te
>--- /usr/src/se/policy/macros/program/mozilla_macros.te	2004-11-25 20:37:21.000000000 +1100
>+++ ./macros/program/mozilla_macros.te	2004-11-25 23:07:56.000000000 +1100
>@@ -29,8 +30,7 @@
> 
> allow $1_mozilla_t usr_t:{ lnk_file file } { getattr read };
> allow $1_mozilla_t var_lib_t:file { getattr read };
>-allow $1_mozilla_t { random_device_t urandom_device_t }:chr_file { getattr ioctl read append };
>-
>+allow $1_mozilla_t { random_device_t urandom_device_t }:chr_file { getattr ioctl read };
> allow $1_mozilla_t self:socket create_socket_perms;
> allow $1_mozilla_t self:file { getattr read };
> 
>@@ -71,8 +71,6 @@
> dontaudit $1_lpr_t $1_mozilla_t:unix_stream_socket { read write };
> ')
> 
>-dontaudit $1_mozilla_t tmp_t:lnk_file read;
>-
> #
> # This is another place where I sould like to allow system customization.
> # We need to allow the admin to select whether then want to allow mozilla
>diff -ru /usr/src/se/policy/macros/program/screen_macros.te ./macros/program/screen_macros.te
>--- /usr/src/se/policy/macros/program/screen_macros.te	2004-11-20 01:18:25.000000000 +1100
>+++ ./macros/program/screen_macros.te	2004-11-22 03:18:59.000000000 +1100
>@@ -88,7 +88,6 @@
> # get stats
> allow $1_screen_t proc_t:dir search;
> allow $1_screen_t proc_t:lnk_file read;
>-dontaudit $1_screen_t device_t:chr_file getattr;
> allow $1_screen_t etc_t:{ file lnk_file } { read getattr };
> allow $1_screen_t self:dir { search read };
> allow $1_screen_t self:lnk_file read;
>diff -ru /usr/src/se/policy/macros/program/userhelper_macros.te ./macros/program/userhelper_macros.te
>--- /usr/src/se/policy/macros/program/userhelper_macros.te	2004-11-25 20:37:21.000000000 +1100
>+++ ./macros/program/userhelper_macros.te	2004-11-22 03:14:43.000000000 +1100
>@@ -38,9 +38,6 @@
> # Inherit descriptors from the current session.
> allow $1_userhelper_t { init_t privfd }:fd use;
> 
>-# Execute /sbin/unix_chkpwd to check the password.
>-allow $1_userhelper_t sbin_t:dir r_dir_perms;
>-
> can_exec($1_userhelper_t, { bin_t sbin_t userhelper_exec_t })
> 
> # Execute shells
>diff -ru /usr/src/se/policy/macros/user_macros.te ./macros/user_macros.te
>--- /usr/src/se/policy/macros/user_macros.te	2004-11-20 01:18:25.000000000 +1100
>+++ ./macros/user_macros.te	2004-11-22 03:14:43.000000000 +1100
>@@ -197,8 +197,10 @@
> 
> dontaudit $1_t sysadm_home_t:dir { read search getattr };
> dontaudit $1_t sysadm_home_t:file { read getattr append };
>+ifdef(`distro_redhat', `
> # gam_server fires off these when exploring with mozilla/nautilous
> dontaudit $1_t file_type:dir getattr;
>+')
> 
> ifdef(`syslogd.te', `
> # Some programs that are left in $1_t will try to connect
>diff -ru /usr/src/se/policy/types/file.te ./types/file.te
>--- /usr/src/se/policy/types/file.te	2004-11-13 03:56:14.000000000 +1100
>+++ ./types/file.te	2004-11-22 03:14:43.000000000 +1100
>@@ -256,7 +256,7 @@
> # Allow each file type to be associated with 
> # the default file system type.
> #
>-allow { file_type device_type } fs_t:filesystem associate;
>+allow { file_type device_type ttyfile } fs_t:filesystem associate;
> ifdef(`distro_redhat', `
> allow { dev_fs ttyfile } tmpfs_t:filesystem associate;
> ')
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

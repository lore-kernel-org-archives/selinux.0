Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i81HxnrT023072
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 13:59:49 -0400 (EDT)
Message-ID: <41360E0A.5080704@redhat.com>
Date: Wed, 01 Sep 2004 13:59:38 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: russell@coker.com.au, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Previous patch broken.
References: <20040823215636.GD13677@lkcl.net>	 <200408242147.44485.russell@coker.com.au>	 <1093640980.24188.47.camel@moss-lions.epoch.ncsc.mil>	 <41337903.7020308@redhat.com> <1094052344.2523.48.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1094052344.2523.48.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Carter wrote:

>Mostly Merged.  I removed the stuff reverting recent patches from
>Russell that I just merged.
>
>Below is some comments, and attached is the diff that I merged.
> 
>On Mon, 2004-08-30 at 14:59, Daniel J Walsh wrote:
>
>  
>
>>diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ssh.te policy-1.17.7/domains/program/ssh.te
>>--- nsapolicy/domains/program/ssh.te	2004-08-27 14:44:11.000000000 -0400
>>+++ policy-1.17.7/domains/program/ssh.te	2004-08-30 14:54:52.330858292 -0400
>>@@ -232,6 +232,7 @@
>> 
>> # Type for the ssh executable.
>> type ssh_exec_t, file_type, exec_type, sysadmfile;
>>+can_exec(sshd_t, ssh_exec_t)
>> 
>> # Everything else is in the ssh_domain macro in
>> # macros/program/ssh_macros.te.
>>    
>>
>
>Also added r_dir_file(sshd_t, self) further up in ssh.te to allow sshd
>to access /proc/pid/fd. (Why does it want to?)
>
>  
>
ssh now reexecs it self in order to increase it's security.  Not sure 
why it wants to access /proc/pid/fd.

>>diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/syslogd.te policy-1.17.7/domains/program/syslogd.te
>>--- nsapolicy/domains/program/syslogd.te	2004-08-30 09:49:15.000000000 -0400
>>+++ policy-1.17.7/domains/program/syslogd.te	2004-08-30 14:54:52.331858177 -0400
>>@@ -95,3 +95,6 @@
>> #
>> dontaudit syslogd_t file_t:dir search;
>> allow syslogd_t devpts_t:dir { search };
>>+# For tageted policy tries to read /init
>>+dontaudit syslogd_t root_t:file { getattr read };
>>+
>>    
>>
>
>Instead I did:
>diff -u -r1.55 global_macros.te
>--- macros/global_macros.te	1 Sep 2004 12:59:59 -0000	1.55
>+++ macros/global_macros.te	1 Sep 2004 14:56:38 -0000
>@@ -295,7 +295,7 @@
> ')dnl end if automount.te
> ifdef(`targeted_policy', `
> dontaudit $1_t devpts_t:chr_file { read write };
>-dontaudit $1_t unlabeled_t:file read;
>+dontaudit $1_t root_t:file { getattr read };
> ')dnl end if targeted_policy
>  
> ')dnl end macro daemon_core_rules
>
>  
>
Ok

>>diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.17.7/domains/program/unused/apache.te
>>--- nsapolicy/domains/program/unused/apache.te	2004-08-30 09:49:15.000000000 -0400
>>+++ policy-1.17.7/domains/program/unused/apache.te	2004-08-30 14:54:52.331858177 -0400
>>@@ -41,6 +41,7 @@
>> append_logdir_domain(httpd)
>> #can read /etc/httpd/logs
>> allow httpd_t httpd_log_t:lnk_file { read };
>>+allow httpd_t httpd_log_t:dir { remove_name };
>> 
>> # For /etc/init.d/apache2 reload
>> can_tcp_connect(httpd_t, httpd_t)
>>    
>>
>
>Do we really want to do this?
>
>  
>
Russell?

>>diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dbusd.te policy-1.17.7/domains/program/unused/dbusd.te
>>--- nsapolicy/domains/program/unused/dbusd.te	2004-08-27 14:44:11.000000000 -0400
>>+++ policy-1.17.7/domains/program/unused/dbusd.te	2004-08-30 14:55:40.446348342 -0400
>>@@ -32,3 +32,4 @@
>> 
>> # SE-DBus specific permissions
>> allow { dbus_client_domain userdomain } { dbusd_t self }:dbus { send_msg };
>>+domain_auto_trans(userdomain, dbusd_exec_t, dbusd_t)
>>    
>>
>
>Steve posted on the list earlier today about this not being desired for
>the longterm.
>
>  
>
Colin is doing a rewrite as we speak.

>------------------------------------------------------------------------
>
>Index: domains/program/crond.te
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/crond.te,v
>retrieving revision 1.33
>diff -u -r1.33 crond.te
>--- domains/program/crond.te	20 Aug 2004 17:53:50 -0000	1.33
>+++ domains/program/crond.te	31 Aug 2004 15:08:51 -0000
>@@ -81,11 +81,13 @@
> ifdef(`distro_redhat', `
> # Run the rpm program in the rpm_t domain. Allow creation of RPM log files
> # via redirection of standard out.
>+ifdef(`rpm.te', `
> allow crond_t rpm_log_t: file create_file_perms;
> 
> system_crond_entry(rpm_exec_t, rpm_t)
> allow system_crond_t rpm_log_t:file create_file_perms;
> ')
>+')
> 
> allow system_crond_t var_log_t:file r_file_perms;
> 
>Index: domains/program/ssh.te
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/ssh.te,v
>retrieving revision 1.36
>diff -u -r1.36 ssh.te
>--- domains/program/ssh.te	1 Sep 2004 12:58:21 -0000	1.36
>+++ domains/program/ssh.te	1 Sep 2004 14:16:20 -0000
>@@ -147,6 +147,7 @@
> # sshd_extern_t is the domain for ssh from outside our network
> #
> sshd_program_domain(sshd)
>+r_dir_file(sshd_t, self)
> if (ssh_sysadm_login) {
> sshd_spawn_domain(sshd, userdomain, { sysadm_devpts_t userpty_type })
> } else {
>@@ -232,6 +233,7 @@
> 
> # Type for the ssh executable.
> type ssh_exec_t, file_type, exec_type, sysadmfile;
>+can_exec(sshd_t, ssh_exec_t)
> 
> # Everything else is in the ssh_domain macro in
> # macros/program/ssh_macros.te.
>Index: domains/program/unused/canna.te
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/unused/canna.te,v
>retrieving revision 1.7
>diff -u -r1.7 canna.te
>--- domains/program/unused/canna.te	30 Jul 2004 19:57:15 -0000	1.7
>+++ domains/program/unused/canna.te	31 Aug 2004 15:08:51 -0000
>@@ -40,4 +40,3 @@
> can_unix_connect(i18n_input_t, canna_t)
> ')
> 
>-allow canna_t tmp_t:dir search;
>Index: domains/program/unused/dbusd.te
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/unused/dbusd.te,v
>retrieving revision 1.9
>diff -u -r1.9 dbusd.te
>--- domains/program/unused/dbusd.te	23 Aug 2004 14:56:57 -0000	1.9
>+++ domains/program/unused/dbusd.te	1 Sep 2004 14:48:53 -0000
>@@ -32,3 +32,4 @@
> 
> # SE-DBus specific permissions
> allow { dbus_client_domain userdomain } { dbusd_t self }:dbus { send_msg };
>+domain_auto_trans(userdomain, dbusd_exec_t, dbusd_t)
>Index: domains/program/unused/dovecot.te
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/unused/dovecot.te,v
>retrieving revision 1.4
>diff -u -r1.4 dovecot.te
>--- domains/program/unused/dovecot.te	30 Aug 2004 12:29:19 -0000	1.4
>+++ domains/program/unused/dovecot.te	31 Aug 2004 15:08:51 -0000
>@@ -19,8 +19,13 @@
> allow dovecot_t self:unix_stream_socket create_stream_socket_perms;
> can_unix_connect(dovecot_t, self)
> 
>+# For SSL certificates
>+allow dovecot_t usr_t:file { getattr read };
>+
> allow dovecot_t etc_t:file { getattr read };
> allow dovecot_t initrc_var_run_t:file { getattr };
>+# Dovecot sub-binaries are lib_t on Debian and bin_t on Fedora
>+allow dovecot_t lib_t:file { execute execute_no_trans };
> allow dovecot_t bin_t:dir { getattr search };
> can_exec(dovecot_t, bin_t)
> 
>Index: domains/program/unused/ftpd.te
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/unused/ftpd.te,v
>retrieving revision 1.22
>diff -u -r1.22 ftpd.te
>--- domains/program/unused/ftpd.te	30 Aug 2004 12:29:19 -0000	1.22
>+++ domains/program/unused/ftpd.te	31 Aug 2004 15:08:51 -0000
>@@ -101,3 +101,4 @@
> allow ftpd_t nfs_t:file r_file_perms;
> }
> ')dnl end if nfs_home_dirs
>+dontaudit ftpd_t selinux_config_t:dir { search };
>Index: domains/program/unused/hald.te
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/unused/hald.te,v
>retrieving revision 1.4
>diff -u -r1.4 hald.te
>--- domains/program/unused/hald.te	30 Aug 2004 12:29:20 -0000	1.4
>+++ domains/program/unused/hald.te	31 Aug 2004 15:08:51 -0000
>@@ -33,7 +33,10 @@
> allow hald_t { fixed_disk_device_t removable_device_t }:blk_file { getattr read ioctl };
> allow hald_t event_device_t:chr_file { getattr read };
> 
>-ifdef(`updfstab.te', `domain_auto_trans(hald_t, updfstab_exec_t, updfstab_t)')
>+ifdef(`updfstab.te', `
>+domain_auto_trans(hald_t, updfstab_exec_t, updfstab_t)
>+allow updfstab_t hald_t:dbus { send_msg };
>+')
> ifdef(`udev.te', `
> domain_auto_trans(hald_t, udev_exec_t, udev_t)
> allow udev_t hald_t:unix_dgram_socket sendto;
>Index: domains/program/unused/hotplug.te
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/unused/hotplug.te,v
>retrieving revision 1.27
>diff -u -r1.27 hotplug.te
>--- domains/program/unused/hotplug.te	30 Aug 2004 12:29:20 -0000	1.27
>+++ domains/program/unused/hotplug.te	31 Aug 2004 15:08:51 -0000
>@@ -137,7 +137,6 @@
> 
> ifdef(`udev.te', `
> domain_auto_trans(hotplug_t, { udev_exec_t udev_helper_exec_t }, udev_t)
>-allow hotplug_t udev_helper_exec_t:lnk_file read;
> ')
> 
> file_type_auto_trans(hotplug_t, etc_t, etc_runtime_t, file)
>Index: domains/program/unused/iptables.te
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/unused/iptables.te,v
>retrieving revision 1.6
>diff -u -r1.6 iptables.te
>--- domains/program/unused/iptables.te	30 Jul 2004 19:57:15 -0000	1.6
>+++ domains/program/unused/iptables.te	31 Aug 2004 15:08:51 -0000
>@@ -23,10 +23,9 @@
> # to allow rules to be saved on reboot
> allow iptables_t initrc_tmp_t:file rw_file_perms;
> 
>-type iptables_var_run_t, file_type, sysadmfile, pidfile;
>-
> domain_auto_trans(iptables_t, ifconfig_exec_t, ifconfig_t)
>-file_type_auto_trans(iptables_t, var_run_t, iptables_var_run_t, file)
>+allow iptables_t var_t:dir search;
>+var_run_domain(iptables)
> 
> allow iptables_t self:process { fork signal_perms };
> 
>@@ -57,4 +56,3 @@
> 
> # system-config-network appends to /var/log
> allow iptables_t var_log_t:file { append };
>-allow iptables_t var_t:dir { search };
>Index: domains/program/unused/mdadm.te
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/unused/mdadm.te,v
>retrieving revision 1.7
>diff -u -r1.7 mdadm.te
>--- domains/program/unused/mdadm.te	12 Aug 2004 17:19:52 -0000	1.7
>+++ domains/program/unused/mdadm.te	31 Aug 2004 15:08:51 -0000
>@@ -28,7 +28,6 @@
> # Ignore attempts to read every device file
> dontaudit mdadm_t device_type:{ chr_file blk_file } getattr;
> dontaudit mdadm_t device_t:{ fifo_file file dir chr_file blk_file } { read getattr };
>-dontaudit mdadm_t device_t:dir r_dir_perms;
> dontaudit mdadm_t devpts_t:dir r_dir_perms;
> 
> # Ignore attempts to read/write sysadmin tty
>Index: domains/program/unused/openca-ca.te
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/unused/openca-ca.te,v
>retrieving revision 1.8
>diff -u -r1.8 openca-ca.te
>--- domains/program/unused/openca-ca.te	8 Mar 2004 13:48:21 -0000	1.8
>+++ domains/program/unused/openca-ca.te	31 Aug 2004 15:08:51 -0000
>@@ -39,11 +39,6 @@
> allow httpd_t openca_ca_t:process {transition};
> allow httpd_t openca_ca_exec_t:dir r_dir_perms;
> 
>-#############################################################
>-# Allow the script access to the library files so it can run
>-#############################################################
>-can_exec(openca_ca_t, lib_t)
>-
> ##################################################################
> # Allow the script to get the file descriptor from the http deamon
> # and send sigchild to http deamon
>@@ -52,6 +47,16 @@
> allow openca_ca_t httpd_t:fd use;
> allow openca_ca_t httpd_t:fifo_file {getattr write};
> 
>+############################################
>+# Allow scripts to append to http logs
>+#########################################
>+allow openca_ca_t httpd_log_t:file { append getattr };
>+
>+#############################################################
>+# Allow the script access to the library files so it can run
>+#############################################################
>+can_exec(openca_ca_t, lib_t)
>+
> ########################################################################
> # The script needs to inherit the file descriptor and find the script it
> # needs to run
>@@ -79,11 +84,6 @@
> ##############################################################################
> allow openca_ca_t openca_ca_exec_t:dir search;
> 
>-############################################
>-# Allow scripts to append to http logs
>-#########################################
>-allow openca_ca_t httpd_log_t:file { append getattr };
>-
> #
> # Allow access to writeable files under /etc/openca
> #
>Index: domains/program/unused/portmap.te
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/unused/portmap.te,v
>retrieving revision 1.7
>diff -u -r1.7 portmap.te
>--- domains/program/unused/portmap.te	30 Aug 2004 12:29:20 -0000	1.7
>+++ domains/program/unused/portmap.te	31 Aug 2004 15:08:51 -0000
>@@ -26,6 +26,7 @@
> 
> # portmap binds to arbitary ports
> allow portmap_t port_t:{ udp_socket tcp_socket } name_bind;
>+allow portmap_t reserved_port_t:{ udp_socket tcp_socket } name_bind;
> 
> allow portmap_t etc_t:file { getattr read };
> 
>Index: domains/program/unused/rpm.te
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/unused/rpm.te,v
>retrieving revision 1.30
>diff -u -r1.30 rpm.te
>--- domains/program/unused/rpm.te	30 Aug 2004 19:58:53 -0000	1.30
>+++ domains/program/unused/rpm.te	1 Sep 2004 14:36:01 -0000
>@@ -10,7 +10,7 @@
> # var_log_rpm_t is the type for rpm log files (/var/log/rpmpkgs*)
> # var_lib_rpm_t is the type for rpm files in /var/lib
> #
>-type rpm_t, domain, admin, etc_writer, privlog, privowner, privmem, priv_system_role, fs_domain, privfd ifdef(`unlimitedRPM', `,auth_write, unrestricted');
>+type rpm_t, domain, admin, etc_writer, privlog, privowner, privmem, priv_system_role, fs_domain, privfd ifdef(`unlimitedRPM', `, unrestricted, auth_write');
> role system_r types rpm_t;
> uses_shlib(rpm_t)
> type rpm_exec_t, file_type, sysadmfile, exec_type;
>@@ -117,7 +117,7 @@
> 
> allow { insmod_t depmod_t } rpm_t:fifo_file rw_file_perms;
> 
>-type rpm_script_t, domain, admin, etc_writer, privlog, privowner, privmodule, privmem, fs_domain, privfd, priv_system_role ifdef(`unlimitedRPM', `,auth_write, unrestricted');
>+type rpm_script_t, domain, admin, etc_writer, privlog, privowner, privmodule, privmem, fs_domain, privfd, priv_system_role ifdef(`unlimitedRPM', `, unrestricted, auth_write');
> # policy for rpm scriptlet
> role system_r types rpm_script_t;
> uses_shlib(rpm_script_t)
>Index: domains/program/unused/xdm.te
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/unused/xdm.te,v
>retrieving revision 1.29
>diff -u -r1.29 xdm.te
>--- domains/program/unused/xdm.te	30 Aug 2004 12:29:20 -0000	1.29
>+++ domains/program/unused/xdm.te	31 Aug 2004 15:08:51 -0000
>@@ -29,6 +29,7 @@
> allow xdm_t xdm_var_run_t:fifo_file create_file_perms;
> allow initrc_t xdm_var_run_t:fifo_file unlink;
> file_type_auto_trans(xdm_t, var_run_t, xdm_var_run_t, fifo_file)
>+file_type_auto_trans(xdm_t, var_run_t, xdm_var_run_t, dir)
> 
> tmp_domain(xdm)
> var_lib_domain(xdm)
>Index: domains/program/unused/xfs.te
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/unused/xfs.te,v
>retrieving revision 1.10
>diff -u -r1.10 xfs.te
>--- domains/program/unused/xfs.te	20 Aug 2004 17:53:53 -0000	1.10
>+++ domains/program/unused/xfs.te	31 Aug 2004 15:08:51 -0000
>@@ -40,4 +40,3 @@
> # Read /usr/X11R6/lib/X11/fonts/.* and /usr/share/fonts/.*
> allow xfs_t fonts_t:dir search;
> allow xfs_t fonts_t:file { getattr read };
>-allow xfs_t tmpfs_t:dir { search };
>Index: file_contexts/program/mailman.fc
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/policy/file_contexts/program/mailman.fc,v
>retrieving revision 1.10
>diff -u -r1.10 mailman.fc
>--- file_contexts/program/mailman.fc	30 Aug 2004 12:29:21 -0000	1.10
>+++ file_contexts/program/mailman.fc	31 Aug 2004 15:08:51 -0000
>@@ -4,7 +4,6 @@
> /usr/lib/cgi-bin/mailman/.* -- system_u:object_r:mailman_cgi_exec_t
> /usr/lib/mailman/cron/.*	-- system_u:object_r:mailman_queue_exec_t
> /usr/lib/mailman/mail/wrapper -- system_u:object_r:mailman_mail_exec_t
>-/usr/lib/mailman/bin/mailmanctl -- system_u:object_r:mailman_mail_exec_t
> /usr/mailman/mail/wrapper 	-- system_u:object_r:mailman_mail_exec_t
> /var/lib/mailman(/.*)?	   system_u:object_r:mailman_data_t
> /var/lib/mailman/archives(/.*)?	system_u:object_r:mailman_archive_t
>@@ -14,8 +13,6 @@
> ifdef(`distro_redhat', `
> /var/mailman/cgi-bin/.*		-- system_u:object_r:mailman_cgi_exec_t
> /var/mailman/data(/.*)?		   system_u:object_r:mailman_data_t
>-/var/mailman/pythonlib(/.*)?	   system_u:object_r:mailman_data_t
>-/var/mailman/Mailman(/.*)?	   system_u:object_r:mailman_data_t
> /var/mailman/locks(/.*)?	   system_u:object_r:mailman_lock_t
> /var/mailman/cron		-d system_u:object_r:bin_t
> /var/mailman/cron/.+		-- system_u:object_r:mailman_queue_exec_t
>Index: macros/global_macros.te
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/policy/macros/global_macros.te,v
>retrieving revision 1.55
>diff -u -r1.55 global_macros.te
>--- macros/global_macros.te	1 Sep 2004 12:59:59 -0000	1.55
>+++ macros/global_macros.te	1 Sep 2004 14:56:38 -0000
>@@ -295,7 +295,7 @@
> ')dnl end if automount.te
> ifdef(`targeted_policy', `
> dontaudit $1_t devpts_t:chr_file { read write };
>-dontaudit $1_t unlabeled_t:file read;
>+dontaudit $1_t root_t:file { getattr read };
> ')dnl end if targeted_policy
>  
> ')dnl end macro daemon_core_rules
>@@ -599,7 +599,6 @@
> 
> # Set user information and skip authentication.
> allow $1 self:passwd *;
>-
> allow $1 self:dbus *;
> allow $1 self:nscd *;
>-')
>+')dnl end unconfined_domain
>Index: macros/program/screen_macros.te
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/policy/macros/program/screen_macros.te,v
>retrieving revision 1.10
>diff -u -r1.10 screen_macros.te
>--- macros/program/screen_macros.te	26 Jul 2004 19:45:05 -0000	1.10
>+++ macros/program/screen_macros.te	31 Aug 2004 15:08:51 -0000
>@@ -48,9 +48,8 @@
> ifdef(`gnome-pty-helper.te', `allow $1_screen_t $1_gph_t:fd use;')
> 
> allow $1_screen_t $1_home_screen_t:{ file lnk_file } r_file_perms;
>-allow $1_t $1_home_screen_t:{ file lnk_file } create_file_perms;
>-allow $1_t $1_home_screen_t:{ file lnk_file } { relabelfrom relabelto };
>-
>+allow $1_t $1_home_screen_t:file { create_file_perms relabelfrom relabelto };
>+allow $1_t $1_home_screen_t:lnk_file { create_lnk_perms relabelfrom relabelto };
> ifdef(`nfs_home_dirs', `
> r_dir_file($1_screen_t, nfs_t)
> ')dnl end if nfs_home_dirs
>Index: macros/program/xserver_macros.te
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/policy/macros/program/xserver_macros.te,v
>retrieving revision 1.25
>diff -u -r1.25 xserver_macros.te
>--- macros/program/xserver_macros.te	23 Aug 2004 14:52:40 -0000	1.25
>+++ macros/program/xserver_macros.te	31 Aug 2004 15:08:51 -0000
>@@ -241,6 +241,7 @@
> 
> allow $1_xserver_t var_lib_t:dir search;
> rw_dir_create_file($1_xserver_t, var_lib_xkb_t)
>+dontaudit $1_xserver_t selinux_config_t:dir { search };
> 
> # for fonts
> r_dir_file($1_xserver_t, fonts_t)
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Message-ID: <427A757F.9040009@redhat.com>
Date: Thu, 05 May 2005 15:35:27 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: [Fwd: Latest Diff]
Content-Type: multipart/mixed;
 boundary="------------030802090903080709050304"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030802090903080709050304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 



--------------030802090903080709050304
Content-Type: message/rfc822;
 name="Latest Diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Latest Diff"

Message-ID: <427A755F.7090903@redhat.com>
Date: Thu, 05 May 2005 15:34:55 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.2-1 (X11/20050323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim Carter <jwcart2@epoch.ncsc.mil>
Subject: Latest Diff
Content-Type: multipart/mixed;
 boundary="------------060607050306050408000604"

This is a multi-part message in MIME format.
--------------060607050306050408000604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

- Add debugfs
- Add Russell fixes for restorecon, games, postfix
- Turn off user_canbe_sysadm for strict policy
- Add a couple of privs for kernel to look at domain
- Don't transition from unconfined_t (sysadm_t) to ipconfig_t for 
targeted policy
- Insmod wants to write to /proc file system
- Apmd needs to write to /sys file system
- Automount needs additional privs
- Cups creates fifo_file in /tmp that it needs to communicate with.
- Hal needs additional privs
- lvm needs var_run_domain
- tighten up privoxy network
- Allow udev to work with tmpfs_t before /dev is labeled
- misc minor fixes
- misc minor changes to file_context
- Turn on reiserfs again



-- 



--------------060607050306050408000604
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/misc/kernel.te policy-1.23.14/domains/misc/kernel.te
--- nsapolicy/domains/misc/kernel.te	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.23.14/domains/misc/kernel.te	2005-05-02 14:57:26.000000000 -0400
@@ -36,6 +36,7 @@
 
 # Send signal to any process.
 allow kernel_t domain:process signal;
+allow kernel_t domain:dir search;
 
 # Access the console.
 allow kernel_t device_t:dir search;
@@ -50,6 +51,7 @@
 allow kernel_t self:capability sys_chroot;
 
 allow kernel_t { unlabeled_t root_t file_t }:dir mounton;
+allow kernel_t unlabeled_t:fifo_file rw_file_perms;
 allow kernel_t file_t:dir rw_dir_perms;
 allow kernel_t file_t:blk_file create_file_perms;
 allow kernel_t { sysctl_t sysctl_kernel_t }:file { setattr rw_file_perms };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ifconfig.te policy-1.23.14/domains/program/ifconfig.te
--- nsapolicy/domains/program/ifconfig.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.14/domains/program/ifconfig.te	2005-05-02 14:57:26.000000000 -0400
@@ -21,7 +21,9 @@
 general_domain_access(ifconfig_t)
 
 domain_auto_trans(initrc_t, ifconfig_exec_t, ifconfig_t)
+ifdef(`targeted_policy', `', `
 domain_auto_trans(sysadm_t, ifconfig_exec_t, ifconfig_t)
+')
 
 # for /sbin/ip
 allow ifconfig_t self:netlink_route_socket rw_netlink_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/modutil.te policy-1.23.14/domains/program/modutil.te
--- nsapolicy/domains/program/modutil.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.14/domains/program/modutil.te	2005-05-02 14:57:26.000000000 -0400
@@ -143,7 +143,7 @@
 allow insmod_t proc_t:dir search;
 allow insmod_t sysctl_kernel_t:file { setattr rw_file_perms };
 
-allow insmod_t proc_t:file { getattr read };
+allow insmod_t proc_t:file rw_file_perms;
 allow insmod_t proc_t:lnk_file read;
 
 # Write to /proc/mtrr.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/restorecon.te policy-1.23.14/domains/program/restorecon.te
--- nsapolicy/domains/program/restorecon.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.14/domains/program/restorecon.te	2005-05-05 15:11:06.000000000 -0400
@@ -20,7 +20,7 @@
 role secadm_r types restorecon_t;
 
 allow restorecon_t initrc_devpts_t:chr_file { read write ioctl };
-allow restorecon_t { tty_device_t admin_tty_type }:chr_file { read write ioctl };
+allow restorecon_t { tty_device_t admin_tty_type devtty_t }:chr_file { read write ioctl };
 
 domain_auto_trans({ initrc_t sysadm_t secadm_t }, restorecon_exec_t, restorecon_t)
 allow restorecon_t { userdomain init_t privfd }:fd use;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apmd.te policy-1.23.14/domains/program/unused/apmd.te
--- nsapolicy/domains/program/unused/apmd.te	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.23.14/domains/program/unused/apmd.te	2005-05-02 14:57:26.000000000 -0400
@@ -31,7 +31,7 @@
 
 allow apmd_t device_t:lnk_file read;
 allow apmd_t proc_t:file { getattr read };
-read_sysctl(apmd_t)
+can_sysctl(apmd_t)
 allow apmd_t self:unix_dgram_socket create_socket_perms;
 allow apmd_t self:unix_stream_socket create_stream_socket_perms;
 allow apmd_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/auditd.te policy-1.23.14/domains/program/unused/auditd.te
--- nsapolicy/domains/program/unused/auditd.te	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.23.14/domains/program/unused/auditd.te	2005-05-02 14:57:26.000000000 -0400
@@ -56,3 +56,4 @@
 allow auditctl_t sysctl_kernel_t:file read;
 allow auditd_t self:process setsched;
 dontaudit auditctl_t init_t:fd use; 
+allow auditctl_t initrc_devpts_t:chr_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/automount.te policy-1.23.14/domains/program/unused/automount.te
--- nsapolicy/domains/program/unused/automount.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.14/domains/program/unused/automount.te	2005-05-02 14:57:26.000000000 -0400
@@ -26,7 +26,7 @@
 allow automount_t { etc_t etc_runtime_t }:file { getattr read };
 allow automount_t proc_t:file { getattr read };
 allow automount_t self:process { setpgid setsched };
-allow automount_t self:capability sys_nice;
+allow automount_t self:capability { sys_nice dac_override };
 allow automount_t self:unix_stream_socket create_socket_perms;
 allow automount_t self:unix_dgram_socket create_socket_perms;
 
@@ -66,4 +66,9 @@
 allow automount_t home_root_t:dir getattr;
 allow automount_t mnt_t:dir { getattr search };
 
-allow initrc_t automount_etc_t:file { getattr read };
+can_exec(initrc_t, automount_etc_t)
+
+# Need something like the following
+# file_type_auto_trans(automount_t, file_type, automount_tmp_t, dir)
+
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/consoletype.te policy-1.23.14/domains/program/unused/consoletype.te
--- nsapolicy/domains/program/unused/consoletype.te	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.23.14/domains/program/unused/consoletype.te	2005-05-02 14:57:26.000000000 -0400
@@ -57,6 +57,7 @@
 ifdef(`firstboot.te', `
 allow consoletype_t firstboot_t:fifo_file write;
 ')
+dontaudit consoletype_t proc_t:dir search;
 dontaudit consoletype_t proc_t:file read;
 dontaudit consoletype_t root_t:file read;
 allow consoletype_t crond_t:fifo_file { read getattr ioctl };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.23.14/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.23.14/domains/program/unused/cups.te	2005-05-02 14:57:26.000000000 -0400
@@ -22,6 +22,7 @@
 logdir_domain(cupsd)
 
 tmp_domain(cupsd)
+file_type_auto_trans(cupsd_t, tmp_t, cupsd_tmp_t, fifo_file)
 
 allow cupsd_t devpts_t:dir search;
 
@@ -246,8 +247,9 @@
 allow cupsd_config_t logrotate_t:fd use;
 ')dnl end if logrotate.te
 allow cupsd_config_t system_crond_t:fd use;
-allow cupsd_config_t crond_t:fifo_file read;
+allow cupsd_config_t crond_t:fifo_file r_file_perms;
 allow cupsd_t crond_t:fifo_file read;
+allow cupsd_t crond_t:fd use;
 
 # Alternatives asks for this
 allow cupsd_config_t initrc_exec_t:file getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.23.14/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.23.14/domains/program/unused/hald.te	2005-05-02 14:57:26.000000000 -0400
@@ -10,12 +10,12 @@
 #
 # hald_exec_t is the type of the hald executable.
 #
-daemon_domain(hald, `, fs_domain, nscd_client_domain')
+daemon_domain(hald, `, fs_domain, nscd_client_domain, privmem')
 
 can_exec_any(hald_t)
 
 allow hald_t { etc_t etc_runtime_t }:file { getattr read };
-allow hald_t self:unix_stream_socket create_stream_socket_perms;
+allow hald_t self:unix_stream_socket { connectto create_stream_socket_perms };
 allow hald_t self:unix_dgram_socket create_socket_perms;
 
 ifdef(`dbusd.te', `
@@ -36,7 +36,7 @@
 
 allow hald_t self:netlink_kobject_uevent_socket create_socket_perms;
 allow hald_t self:netlink_route_socket r_netlink_socket_perms;
-allow hald_t self:capability { net_admin sys_admin dac_override dac_read_search mknod };
+allow hald_t self:capability { net_admin sys_admin dac_override dac_read_search mknod sys_rawio };
 can_network_server(hald_t)
 can_ypbind(hald_t)
 
@@ -47,6 +47,7 @@
 allow hald_t printer_device_t:chr_file rw_file_perms;
 allow hald_t urandom_device_t:chr_file read;
 allow hald_t mouse_device_t:chr_file r_file_perms;
+allow hald_t memory_device_t:chr_file r_file_perms;
 
 can_getsecurity(hald_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hotplug.te policy-1.23.14/domains/program/unused/hotplug.te
--- nsapolicy/domains/program/unused/hotplug.te	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.23.14/domains/program/unused/hotplug.te	2005-05-02 14:57:26.000000000 -0400
@@ -156,4 +156,4 @@
 domain_auto_trans(hotplug_t, sendmail_exec_t, system_mail_t) 
 ')
 
-allow kernel_t hotplug_etc_t:dir search;
+allow { insmod_t kernel_t } hotplug_etc_t:dir { search getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/i18n_input.te policy-1.23.14/domains/program/unused/i18n_input.te
--- nsapolicy/domains/program/unused/i18n_input.te	2005-04-27 10:28:51.000000000 -0400
+++ policy-1.23.14/domains/program/unused/i18n_input.te	2005-05-02 14:57:26.000000000 -0400
@@ -14,6 +14,7 @@
 can_ypbind(i18n_input_t)
 
 can_tcp_connect(userdomain, i18n_input_t)
+can_unix_connect(i18n_input_t, initrc_t)
 
 allow i18n_input_t self:fifo_file rw_file_perms;
 allow i18n_input_t i18n_input_port_t:tcp_socket name_bind;
@@ -28,3 +29,4 @@
 allow i18n_input_t self:unix_stream_socket create_stream_socket_perms;
 allow i18n_input_t i18n_input_var_run_t:dir create_dir_perms;
 allow i18n_input_t i18n_input_var_run_t:sock_file create_file_perms;
+allow i18n_input_t usr_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kudzu.te policy-1.23.14/domains/program/unused/kudzu.te
--- nsapolicy/domains/program/unused/kudzu.te	2005-04-27 10:28:51.000000000 -0400
+++ policy-1.23.14/domains/program/unused/kudzu.te	2005-05-02 14:57:26.000000000 -0400
@@ -26,6 +26,7 @@
 allow kudzu_t mouse_device_t:chr_file { read write };
 allow kudzu_t proc_net_t:dir r_dir_perms;
 allow kudzu_t { proc_net_t proc_t }:file { getattr read };
+allow kudzu_t proc_t:lnk_file getattr;
 allow kudzu_t { fixed_disk_device_t removable_device_t }:blk_file rw_file_perms;
 allow kudzu_t scsi_generic_device_t:chr_file r_file_perms;
 allow kudzu_t { bin_t sbin_t }:dir { getattr search };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/lvm.te policy-1.23.14/domains/program/unused/lvm.te
--- nsapolicy/domains/program/unused/lvm.te	2005-04-27 10:28:51.000000000 -0400
+++ policy-1.23.14/domains/program/unused/lvm.te	2005-05-02 14:57:26.000000000 -0400
@@ -112,7 +112,7 @@
 allow lvm_t lvm_control_t:chr_file rw_file_perms;
 allow initrc_t lvm_control_t:chr_file { getattr read unlink };
 allow initrc_t device_t:chr_file create;
-dontaudit lvm_t var_run_t:dir getattr;
+var_run_domain(lvm)
 
 # for when /usr is not mounted
 dontaudit lvm_t file_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/pamconsole.te policy-1.23.14/domains/program/unused/pamconsole.te
--- nsapolicy/domains/program/unused/pamconsole.te	2005-04-27 10:28:52.000000000 -0400
+++ policy-1.23.14/domains/program/unused/pamconsole.te	2005-05-02 14:57:26.000000000 -0400
@@ -45,5 +45,5 @@
 ifdef(`xdm.te', `
 allow pam_console_t xdm_var_run_t:file { getattr read };
 ')
-allow initrc_t pam_var_console_t:dir r_dir_perms;
+allow initrc_t pam_var_console_t:dir rw_dir_perms;
 allow pam_console_t file_context_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postfix.te policy-1.23.14/domains/program/unused/postfix.te
--- nsapolicy/domains/program/unused/postfix.te	2005-04-27 10:28:52.000000000 -0400
+++ policy-1.23.14/domains/program/unused/postfix.te	2005-05-05 15:10:42.000000000 -0400
@@ -180,6 +180,7 @@
 # for OpenSSL certificates
 r_dir_file(postfix_smtpd_t,usr_t)
 allow postfix_smtpd_t etc_aliases_t:file r_file_perms;
+allow postfix_smtpd_t self:file { getattr read };
 
 # for prng_exch
 allow postfix_smtpd_t postfix_spool_t:file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/privoxy.te policy-1.23.14/domains/program/unused/privoxy.te
--- nsapolicy/domains/program/unused/privoxy.te	2005-04-27 10:28:52.000000000 -0400
+++ policy-1.23.14/domains/program/unused/privoxy.te	2005-05-03 10:27:27.000000000 -0400
@@ -8,7 +8,7 @@
 #
 # Rules for the privoxy_t domain.
 #
-daemon_domain(privoxy)
+daemon_domain(privoxy, `, web_client_domain')
 
 logdir_domain(privoxy)
 
@@ -16,9 +16,10 @@
 allow privoxy_t self:capability net_bind_service;
 
 # Use the network.
-can_network(privoxy_t)
-allow privoxy_t port_type:tcp_socket name_connect;
-allow privoxy_t port_t:{ tcp_socket udp_socket } name_bind;
+can_network_tcp(privoxy_t)
+can_ypbind(privoxy_t)
+can_resolve(privoxy_t)
+allow privoxy_t http_cache_port_t:tcp_socket name_bind;
 allow privoxy_t etc_t:file { getattr read };
 allow privoxy_t self:capability { setgid setuid };
 allow privoxy_t self:unix_stream_socket create_socket_perms ;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.23.14/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.23.14/domains/program/unused/udev.te	2005-05-02 14:57:26.000000000 -0400
@@ -38,8 +38,8 @@
 allow udev_t device_t:lnk_file create_lnk_perms;
 allow udev_t { device_t device_type }:{ chr_file blk_file } { relabelfrom relabelto create_file_perms };
 ifdef(`distro_redhat', `
-allow udev_t tmpfs_t:dir rw_dir_perms;
-allow udev_t tmpfs_t:sock_file create_file_perms;
+allow udev_t tmpfs_t:dir create_dir_perms;
+allow udev_t tmpfs_t:{ sock_file file } create_file_perms;
 allow udev_t tmpfs_t:lnk_file create_lnk_perms;
 allow udev_t tmpfs_t:{ chr_file blk_file } { relabelfrom relabelto create_file_perms };
 allow udev_t tmpfs_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/updfstab.te policy-1.23.14/domains/program/unused/updfstab.te
--- nsapolicy/domains/program/unused/updfstab.te	2005-04-27 10:28:53.000000000 -0400
+++ policy-1.23.14/domains/program/unused/updfstab.te	2005-05-02 14:57:26.000000000 -0400
@@ -31,6 +31,8 @@
 ifdef(`dbusd.te', `
 dbusd_client(system, updfstab)
 allow updfstab_t system_dbusd_t:dbus { send_msg };
+allow initrc_t updfstab_t:dbus send_msg;
+allow updfstab_t initrc_t:dbus send_msg;
 ')
 
 # not sure what the sysctl_kernel_t file is, or why it wants to write it, so
@@ -73,3 +75,7 @@
 dontaudit updfstab_t { home_dir_type home_type }:dir search;
 allow updfstab_t fs_t:filesystem { getattr };
 allow updfstab_t tmpfs_t:dir getattr;
+ifdef(`hald.te', `
+can_unix_connect(updfstab_t, hald_t)
+')
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xdm.te policy-1.23.14/domains/program/unused/xdm.te
--- nsapolicy/domains/program/unused/xdm.te	2005-04-27 10:28:54.000000000 -0400
+++ policy-1.23.14/domains/program/unused/xdm.te	2005-05-02 14:57:26.000000000 -0400
@@ -344,3 +344,4 @@
 
 # Run telinit->init to shutdown.
 can_exec(xdm_t, init_exec_t)
+allow xdm_t self:sem create_sem_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xserver.te policy-1.23.14/domains/program/unused/xserver.te
--- nsapolicy/domains/program/unused/xserver.te	2005-04-27 10:28:54.000000000 -0400
+++ policy-1.23.14/domains/program/unused/xserver.te	2005-05-02 14:57:26.000000000 -0400
@@ -20,3 +20,4 @@
 # Everything else is in the xserver_domain macro in
 # macros/program/xserver_macros.te.
 
+allow initrc_t xserver_log_t:fifo_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/distros.fc policy-1.23.14/file_contexts/distros.fc
--- nsapolicy/file_contexts/distros.fc	2005-05-02 14:06:56.000000000 -0400
+++ policy-1.23.14/file_contexts/distros.fc	2005-05-02 14:57:26.000000000 -0400
@@ -37,7 +37,8 @@
 /usr/share/texmf/web2c/mktexupd	--	system_u:object_r:bin_t
 /usr/share/ssl/certs(/.*)?		system_u:object_r:cert_t
 /usr/share/ssl/private(/.*)?		system_u:object_r:cert_t
-/etc/pki(/.*)?		system_u:object_r:cert_t
+/etc/pki(/.*)?				system_u:object_r:cert_t
+/etc/rhgb(/.*)?		-d		system_u:object_r:mnt_t
 /usr/share/ssl/misc(/.*)?		system_u:object_r:bin_t
 #
 # /emul/ia32-linux/usr
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/cups.fc policy-1.23.14/file_contexts/program/cups.fc
--- nsapolicy/file_contexts/program/cups.fc	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.14/file_contexts/program/cups.fc	2005-05-02 14:57:26.000000000 -0400
@@ -25,6 +25,7 @@
 /usr/sbin/printconf-backend --	system_u:object_r:cupsd_config_exec_t
 ')
 /var/log/cups(/.*)?		system_u:object_r:cupsd_log_t
+/var/log/turboprint_cups\.log.* -- system_u:object_r:cupsd_log_t
 /var/spool/cups(/.*)?		system_u:object_r:print_spool_t
 /var/run/cups/printcap	--	system_u:object_r:cupsd_var_run_t
 /usr/lib(64)?/cups/filter/.*	--	system_u:object_r:bin_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/rhgb.fc policy-1.23.14/file_contexts/program/rhgb.fc
--- nsapolicy/file_contexts/program/rhgb.fc	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.14/file_contexts/program/rhgb.fc	2005-05-02 14:57:26.000000000 -0400
@@ -1,2 +1 @@
 /usr/bin/rhgb		--	system_u:object_r:rhgb_exec_t
-/etc/rhgb(/.*)?		-d	system_u:object_r:mnt_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.23.14/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2005-05-02 14:06:56.000000000 -0400
+++ policy-1.23.14/file_contexts/types.fc	2005-05-05 15:00:35.000000000 -0400
@@ -129,6 +129,7 @@
 /dev/nvram		-c	system_u:object_r:memory_device_t
 /dev/random		-c	system_u:object_r:random_device_t
 /dev/urandom		-c	system_u:object_r:urandom_device_t
+/dev/adb.*		-c	system_u:object_r:tty_device_t
 /dev/capi.*		-c	system_u:object_r:tty_device_t
 /dev/dcbri[0-9]+	-c	system_u:object_r:tty_device_t
 /dev/irlpt[0-9]+	-c	system_u:object_r:printer_device_t
@@ -381,6 +382,7 @@
 /usr/local/etc(/.*)?		system_u:object_r:etc_t
 /usr/local/src(/.*)?		system_u:object_r:src_t
 /usr/local/man(/.*)?		system_u:object_r:man_t
+/usr/local/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
 
 #
 # /usr/X11R6/man
diff --exclude-from=exclude -N -u -r nsapolicy/fs_use policy-1.23.14/fs_use
--- nsapolicy/fs_use	2005-03-15 08:02:23.000000000 -0500
+++ policy-1.23.14/fs_use	2005-05-03 08:38:23.000000000 -0400
@@ -8,6 +8,7 @@
 fs_use_xattr ext3 system_u:object_r:fs_t;
 fs_use_xattr xfs system_u:object_r:fs_t;
 fs_use_xattr jfs system_u:object_r:fs_t;
+fs_use_xattr reiserfs system_u:object_r:fs_t;
 
 # Use the allocating task SID to label inodes in the following filesystem
 # types, and label the filesystem itself with the specified context.
diff --exclude-from=exclude -N -u -r nsapolicy/genfs_contexts policy-1.23.14/genfs_contexts
--- nsapolicy/genfs_contexts	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.14/genfs_contexts	2005-05-03 08:37:51.000000000 -0400
@@ -91,8 +91,7 @@
 genfscon nfs4 /				system_u:object_r:nfs_t
 genfscon afs /				system_u:object_r:nfs_t
 
-# reiserfs - until xattr security support works properly
-genfscon reiserfs /			system_u:object_r:nfs_t
+genfscon debugfs /			system_u:object_r:debugfs_t
 
 # needs more work
 genfscon eventpollfs / system_u:object_r:eventpollfs_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/core_macros.te policy-1.23.14/macros/core_macros.te
--- nsapolicy/macros/core_macros.te	2005-05-02 14:06:57.000000000 -0400
+++ policy-1.23.14/macros/core_macros.te	2005-05-02 14:57:26.000000000 -0400
@@ -341,7 +341,6 @@
 # Get the selinuxfs mount point via /proc/self/mounts.
 allow $1 proc_t:dir search;
 allow $1 proc_t:lnk_file read;
-allow $1 proc_t:file { getattr read };
 allow $1 self:dir search;
 allow $1 self:file { getattr read };
 # Access selinuxfs.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/games_domain.te policy-1.23.14/macros/program/games_domain.te
--- nsapolicy/macros/program/games_domain.te	2005-04-27 10:28:54.000000000 -0400
+++ policy-1.23.14/macros/program/games_domain.te	2005-05-05 15:10:05.000000000 -0400
@@ -17,11 +17,14 @@
 if (! disable_games_trans) {
 domain_auto_trans($1_t, games_exec_t, $1_games_t)
 }
+can_exec($1_games_t, games_exec_t)
 role $1_r types $1_games_t;
 
+can_create_pty($1_games)
+
 # X access, /tmp files
 x_client_domain($1_games, $1)
-tmp_domain($1_games)
+tmp_domain($1_games, `', { dir notdevfile_class_set })
 
 uses_shlib($1_games_t)
 read_locale($1_games_t)
@@ -36,6 +39,10 @@
 allow $1_games_t self:process execmem;
 }
 
+if (allow_execmod) {
+allow $1_games_t texrel_shlib_t:file execmod;
+}
+
 allow $1_games_t var_t:dir { search getattr };
 rw_dir_create_file($1_games_t, games_data_t)
 allow $1_games_t sound_device_t:chr_file rw_file_perms;
@@ -65,8 +72,8 @@
 
 allow $1_games_t var_lib_t:dir search;
 r_dir_file($1_games_t, man_t)
-allow $1_games_t proc_t:dir search;
-allow $1_games_t proc_t:file { read getattr };
+allow $1_games_t { proc_t self }:dir search;
+allow $1_games_t { proc_t self }:{ file lnk_file } { read getattr };
 ifdef(`mozilla.te', ` 
 dontaudit $1_games_t $1_mozilla_t:unix_stream_socket connectto;
 ')
@@ -75,15 +82,23 @@
 allow $1_games_t self:file { getattr read };
 allow $1_games_t self:fifo_file rw_file_perms;
 
-# kpat spews errors
-dontaudit $1_games_t bin_t:dir getattr;
+allow $1_games_t self:sem create_sem_perms;
+
+allow $1_games_t { bin_t sbin_t }:dir { getattr search };
+can_exec($1_games_t, { shell_exec_t bin_t utempter_exec_t })
+allow $1_games_t bin_t:lnk_file read;
+
 dontaudit $1_games_t var_run_t:dir search;
+dontaudit $1_games_t initrc_var_run_t:file { read write };
+dontaudit $1_games_t var_log_t:dir search;
 
 # Allow games to read /etc/mtab and /etc/nsswitch.conf
 allow $1_games_t etc_t:file { getattr read };
 allow $1_games_t etc_runtime_t:file { getattr read };
 
-# 
+can_network($1_games_t)
+allow $1_games_t port_t:tcp_socket name_bind;
+allow $1_games_t port_t:tcp_socket name_connect;
 
 ')dnl end macro definition
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/su_macros.te policy-1.23.14/macros/program/su_macros.te
--- nsapolicy/macros/program/su_macros.te	2005-05-02 14:06:57.000000000 -0400
+++ policy-1.23.14/macros/program/su_macros.te	2005-05-02 14:57:26.000000000 -0400
@@ -61,7 +61,7 @@
 ')
 
 # Use capabilities.
-allow $1_su_t self:capability { setuid setgid net_bind_service chown dac_override fowner sys_nice sys_resource };
+allow $1_su_t self:capability { setuid setgid net_bind_service chown dac_override fowner sys_nice sys_resource audit_control };
 dontaudit $1_su_t self:capability sys_tty_config;
 #
 # Caused by su - init scripts
@@ -90,9 +90,10 @@
 
 ifdef(`chkpwd.te', `
 domain_auto_trans($1_su_t, chkpwd_exec_t, $2_chkpwd_t)
-allow $1_su_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
 ')
 
+allow $1_su_t self:netlink_audit_socket { nlmsg_relay create_netlink_socket_perms };
+
 ') dnl end su_restricted_domain
 
 define(`su_mini_domain', `
diff --exclude-from=exclude -N -u -r nsapolicy/Makefile policy-1.23.14/Makefile
--- nsapolicy/Makefile	2005-04-20 15:40:34.000000000 -0400
+++ policy-1.23.14/Makefile	2005-05-03 08:38:52.000000000 -0400
@@ -196,7 +196,7 @@
 	( cd domains/misc/ ; for n in *.te ; do echo "define(\`$$n')"; done ) >> $@.tmp
 	mv $@.tmp $@
 
-FILESYSTEMS=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[23]| xfs| jfs).*rw/{print $$3}';`
+FILESYSTEMS=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[23]| xfs| jfs | reiserfs ).*rw/{print $$3}';`
 
 checklabels: $(SETFILES)
 	$(SETFILES) -v -n $(FC) $(FILESYSTEMS)
diff --exclude-from=exclude -N -u -r nsapolicy/net_contexts policy-1.23.14/net_contexts
--- nsapolicy/net_contexts	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.23.14/net_contexts	2005-05-02 14:57:26.000000000 -0400
@@ -227,6 +227,8 @@
 portcon tcp 3128  system_u:object_r:http_cache_port_t
 portcon tcp 8080  system_u:object_r:http_cache_port_t
 portcon udp 3130  system_u:object_r:http_cache_port_t
+# 8118 is for privoxy
+portcon tcp 8118  system_u:object_r:http_cache_port_t
 
 ifdef(`clockspeed.te', `portcon udp 4041 system_u:object_r:clockspeed_port_t')
 ifdef(`transproxy.te', `portcon tcp 8081 system_u:object_r:transproxy_port_t')
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.23.14/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.14/tunables/distro.tun	2005-05-02 14:57:26.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.23.14/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-04-14 15:01:54.000000000 -0400
+++ policy-1.23.14/tunables/tunable.tun	2005-05-05 15:16:58.000000000 -0400
@@ -2,7 +2,7 @@
 dnl define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
 dnl define(`unlimitedUtils')
@@ -20,7 +20,7 @@
 
 # Do not audit things that we know to be broken but which
 # are not security risks
-dnl define(`hide_broken_symptoms')
+define(`hide_broken_symptoms')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
diff --exclude-from=exclude -N -u -r nsapolicy/types/file.te policy-1.23.14/types/file.te
--- nsapolicy/types/file.te	2005-04-27 10:28:56.000000000 -0400
+++ policy-1.23.14/types/file.te	2005-05-03 07:58:12.000000000 -0400
@@ -312,6 +312,9 @@
 type cifs_t, fs_type, noexattrfile, sysadmfile;
 allow cifs_t self:filesystem associate;
 
+type debugfs_t, fs_type, sysadmfile;
+allow debugfs_t self:filesystem associate;
+
 # removable_t is the default type of all removable media
 type removable_t, file_type, sysadmfile, usercanread;
 allow removable_t self:filesystem associate;
@@ -320,3 +323,5 @@
 
 # Type for anonymous FTP data, used by ftp and rsync
 type ftpd_anon_t, file_type, sysadmfile, customizable;
+
+

--------------060607050306050408000604--


--------------030802090903080709050304--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

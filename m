Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9A1QQrT029915
	for <selinux@tycho.nsa.gov>; Sat, 9 Oct 2004 21:26:26 -0400 (EDT)
Message-ID: <41688FAF.5010601@redhat.com>
Date: Sat, 09 Oct 2004 21:26:07 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
Subject: Re: More SELinux fixes.
References: <4165B9AA.8090803@redhat.com> <1097258770.13326.14.camel@moss-lions.epoch.ncsc.mil> <200410091622.08531.russell@coker.com.au>
In-Reply-To: <200410091622.08531.russell@coker.com.au>
Content-Type: multipart/mixed;
 boundary="------------090206010102060600020700"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090206010102060600020700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Includes Collin's new cups patch.

I turned on every service in an everything install and came up with many 
fixes for all the AVC messages.

Added arpwatch policy.

Changed allow_ypbind to a boolean, so policy can be turned on/off by 
sysadmin.

Working with ipsec team to get program cleaned up so we can write better 
policy.

Temporarily added a rule to allow apache to talk to tmp_t:sock_file in 
targeted policy.  This allows
it to work with postgresql.  Not sure of a good way to fix this.  One we 
could add postgresql policy to targeted
but I am afraid this is a slipperly slope,  Colin suggested that we add 
a new policy postgresql_unconfined.te for
targeted that basically runs postgres unconfined but creates /tmp files 
with an appropriate security context. 
What do you guys think?  Lastly we could tell any users who want to use 
apache with postgres to turn off the
transition of apache to context.

Dan

--------------090206010102060600020700
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/mount.te policy-1.17.29/domains/program/mount.te
--- nsapolicy/domains/program/mount.te	2004-10-09 21:06:13.967473559 -0400
+++ policy-1.17.29/domains/program/mount.te	2004-10-08 10:47:33.000000000 -0400
@@ -72,7 +72,6 @@
 can_udp_send(portmap_t, mount_t)
 allow mount_t rpc_pipefs_t:dir search;
 ')
-dontaudit mount_t reserved_port_type:{tcp_socket udp_socket} name_bind;
 
 #
 # required for mount.smbfs
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/acct.te policy-1.17.29/domains/program/unused/acct.te
--- nsapolicy/domains/program/unused/acct.te	2004-08-20 13:57:28.000000000 -0400
+++ policy-1.17.29/domains/program/unused/acct.te	2004-10-09 10:46:43.000000000 -0400
@@ -65,3 +65,7 @@
 allow acct_t devtty_t:chr_file { read write };
 
 allow acct_t { etc_t etc_runtime_t }:file { read getattr };
+
+ifdef(`logrotate.te', `
+allow logrotate_t acct_data_t:file create_file_perms;
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.17.29/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2004-10-09 21:06:14.078460984 -0400
+++ policy-1.17.29/domains/program/unused/apache.te	2004-10-08 13:44:21.000000000 -0400
@@ -279,6 +279,10 @@
 allow httpd_sys_script_t user_home_dir_t:dir { getattr search };
 allow httpd_t user_home_dir_t:dir { getattr search };
 }
+# 
+# Allow httpd to work with postgresql
+#
+allow httpd_t tmp_t:sock_file rw_file_perms;
 ') dnl targeted policy
 
 #
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/arpwatch.te policy-1.17.29/domains/program/unused/arpwatch.te
--- nsapolicy/domains/program/unused/arpwatch.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.29/domains/program/unused/arpwatch.te	2004-10-09 14:36:10.000000000 -0400
@@ -0,0 +1,22 @@
+#DESC arpwatch -  keep track of ethernet/ip address pairings
+#
+# Author:  Dan Walsh <dwalsh@redhat.com>
+#
+
+#################################
+#
+# Rules for the arpwatch_t domain.
+#
+# arpwatch_exec_t is the type of the arpwatch executable.
+#
+daemon_domain(arpwatch, `, privmail')
+type arpwatch_data_t, file_type, sysadmfile;
+allow arpwatch_t self:netlink_route_socket r_netlink_socket_perms;
+allow arpwatch_t self:capability { net_admin net_raw };
+allow arpwatch_t self:udp_socket create_socket_perms;
+allow arpwatch_t self:unix_dgram_socket create_socket_perms;
+allow arpwatch_t arpwatch_t:capability { setgid setuid };
+allow arpwatch_t arpwatch_t:packet_socket create_socket_perms;
+allow arpwatch_t arpwatch_t:unix_stream_socket create_stream_socket_perms;
+create_dir_file(arpwatch_t,arpwatch_data_t)
+allow arpwatch_t tmp_t:dir { search };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.17.29/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2004-10-09 21:06:14.140453960 -0400
+++ policy-1.17.29/domains/program/unused/cups.te	2004-10-09 21:08:35.809404520 -0400
@@ -52,8 +52,6 @@
 # write to spool
 allow cupsd_t var_spool_t:dir search;
 
-rw_dir_create_file(cupsd_t, printconf_t)
-
 # this is not ideal, and allowing setattr access to cupsd_etc_t is wrong
 file_type_auto_trans(cupsd_t, cupsd_etc_t, cupsd_rw_etc_t, file)
 file_type_auto_trans(cupsd_t, var_t, cupsd_rw_etc_t, file)
@@ -165,11 +163,50 @@
 dontaudit cupsd_t selinux_config_t:dir search;
 dontaudit cupsd_t selinux_config_t:file { getattr read };
 
+allow cupsd_t printconf_t:file { getattr read };
+
 ifdef(`hald.te', `
-allow cupsd_t hald_t:dbus { send_msg };
-allow hald_t cupsd_t:dbus { send_msg };
-allow hald_t cupsd_etc_t:dir search;
-allow hald_t printconf_t:file { getattr read };
-domain_auto_trans(hald_t, cupsd_exec_t, cupsd_t)
+
+# CUPS configuration daemon
+daemon_domain(cupsd_config)
+
+allow cupsd_config_t { etc_t etc_runtime_t net_conf_t }:file { getattr read };
+allow cupsd_config_t self:file { getattr read };
+
+allow cupsd_config_t proc_t:file { getattr read };
+allow cupsd_config_t cupsd_var_run_t:file { getattr read };
+allow cupsd_config_t cupsd_t:process { signal };
+allow cupsd_config_t cupsd_t:{ file lnk_file } { getattr read };
+allow cupsd_config_t cupsd_t:dir { search };
+
+allow cupsd_config_t self:capability { chown };
+
+rw_dir_create_file(cupsd_config_t, cupsd_etc_t)
+rw_dir_create_file(cupsd_config_t, cupsd_rw_etc_t)
+
+can_network(cupsd_config_t)
+can_tcp_connect(cupsd_config_t, cupsd_t)
+allow cupsd_config_t self:fifo_file rw_file_perms;
+
+dbusd_client(system, cupsd_config_t)
+allow cupsd_config_t self:unix_stream_socket create_socket_perms;
+allow cupsd_config_t userdomain:dbus { send_msg };
+allow userdomain cupsd_config_t:dbus { send_msg };
+allow cupsd_config_t hald_t:dbus { send_msg };
+allow hald_t cupsd_config_t:dbus { send_msg };
+
+
+can_exec(cupsd_config_t, { bin_t sbin_t shell_exec_t })
+allow cupsd_config_t { bin_t sbin_t }:dir { search getattr };
+allow cupsd_config_t { bin_t sbin_t }:lnk_file read;
+
+allow cupsd_config_t usr_t:file { getattr read };
+allow cupsd_config_t var_lib_t:dir { getattr search };
+allow cupsd_config_t rpm_var_lib_t:file { getattr read };
+allow cupsd_config_t printconf_t:file { getattr read };
+
+allow cupsd_config_t urandom_device_t:chr_file { getattr read };
+
+domain_auto_trans(hald_t, cupsd_config_exec_t, cupsd_config_t)
+
 ')
-allow cupsd_t userdomain:dbus { send_msg };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpc.te policy-1.17.29/domains/program/unused/dhcpc.te
--- nsapolicy/domains/program/unused/dhcpc.te	2004-10-09 21:06:14.172450335 -0400
+++ policy-1.17.29/domains/program/unused/dhcpc.te	2004-10-08 13:30:19.000000000 -0400
@@ -36,7 +36,9 @@
 ifdef(`consoletype.te', `
 domain_auto_trans(dhcpc_t, consoletype_exec_t, consoletype_t)
 ')
-
+ifdef(`nscd.te', `
+domain_auto_trans(dhcpc_t, nscd_exec_t, nscd_t)
+')
 ifdef(`cardmgr.te', `
 domain_auto_trans(cardmgr_t, dhcpc_exec_t, dhcpc_t)
 allow cardmgr_t dhcpc_var_run_t:file { getattr read };
@@ -132,3 +134,4 @@
 allow dhcpc_t home_root_t:dir { search };
 allow initrc_t dhcpc_state_t:file { getattr read };
 dontaudit dhcpc_t var_lock_t:dir { search };
+dontaudit dhcpc_t selinux_config_t:dir { search };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dovecot.te policy-1.17.29/domains/program/unused/dovecot.te
--- nsapolicy/domains/program/unused/dovecot.te	2004-09-13 15:58:18.000000000 -0400
+++ policy-1.17.29/domains/program/unused/dovecot.te	2004-10-09 14:36:10.000000000 -0400
@@ -44,3 +44,6 @@
 allow dovecot_auth_t etc_t:file { getattr read };
 allow dovecot_auth_t { self proc_t }:file { getattr read };
 read_locale(dovecot_auth_t)
+allow dovecot_auth_t sysctl_kernel_t:dir search;
+allow dovecot_auth_t sysctl_kernel_t:file read;
+allow dovecot_auth_t sysctl_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.17.29/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2004-10-07 08:02:01.000000000 -0400
+++ policy-1.17.29/domains/program/unused/hald.te	2004-10-09 11:22:40.000000000 -0400
@@ -61,3 +61,5 @@
 allow hald_t usbfs_t:file { getattr read };
 allow hald_t bin_t:lnk_file read;
 dontaudit hald_t selinux_config_t:dir { search };
+allow hald_t initrc_t:dbus { send_msg };
+allow initrc_t hald_t:dbus { send_msg };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/howl.te policy-1.17.29/domains/program/unused/howl.te
--- nsapolicy/domains/program/unused/howl.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.17.29/domains/program/unused/howl.te	2004-10-09 20:49:54.576412905 -0400
@@ -2,7 +2,7 @@
 allow howl_t proc_t:file { getattr read };
 can_network(howl_t)
 can_ypbind(howl_t)
-allow howl_t self:capability net_admin;
+allow howl_t self:capability { kill net_admin };
 
 allow howl_t self:fifo_file rw_file_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/innd.te policy-1.17.29/domains/program/unused/innd.te
--- nsapolicy/domains/program/unused/innd.te	2004-10-09 21:06:14.281437986 -0400
+++ policy-1.17.29/domains/program/unused/innd.te	2004-10-09 10:44:22.000000000 -0400
@@ -69,3 +69,8 @@
 allow syslogd_t innd_log_t:dir search;
 allow syslogd_t innd_log_t:file create_file_perms;
 ')
+allow innd_t self:file { getattr read };
+dontaudit innd_t selinux_config_t:dir { search };
+allow system_crond_t innd_etc_t:file { getattr read };
+allow innd_t bin_t:lnk_file { read };
+allow innd_t sbin_t:lnk_file { read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ipsec.te policy-1.17.29/domains/program/unused/ipsec.te
--- nsapolicy/domains/program/unused/ipsec.te	2004-09-13 15:58:18.000000000 -0400
+++ policy-1.17.29/domains/program/unused/ipsec.te	2004-10-09 14:36:11.000000000 -0400
@@ -30,6 +30,7 @@
 domain_auto_trans(ipsec_mgmt_t, ipsec_exec_t, ipsec_t)
 file_type_auto_trans(ipsec_mgmt_t, var_run_t, ipsec_var_run_t, sock_file)
 file_type_auto_trans(ipsec_t, var_run_t, ipsec_var_run_t, sock_file)
+file_type_auto_trans(ipsec_mgmt_t, etc_t, ipsec_key_file_t, file)
 
 allow ipsec_mgmt_t modules_object_t:dir search;
 allow ipsec_mgmt_t modules_object_t:file getattr;
@@ -74,8 +75,6 @@
 can_exec(ipsec_t, shell_exec_t)
 can_exec(ipsec_t, bin_t)
 can_exec(ipsec_t, ipsec_mgmt_exec_t)
-can_exec(ipsec_mgmt_t, ifconfig_exec_t)
-
 # now for a icky part...
 # pluto runs an updown script (by calling popen()!); as this is by default
 # a shell script, we need to find a way to make things work without
@@ -125,6 +124,7 @@
 
 # from initrc.te
 domain_auto_trans(initrc_t, ipsec_mgmt_exec_t, ipsec_mgmt_t)
+domain_auto_trans(initrc_t, ipsec_exec_t, ipsec_t)
 
 
 ########## The following rules were added by cvance@tislabs.com ##########
@@ -224,3 +228,8 @@
 dontaudit ipsec_t ttyfile:chr_file { read write };
 allow ipsec_t self:capability { dac_override dac_read_search };
 allow ipsec_t reserved_port_t:udp_socket { name_bind };
+allow ipsec_mgmt_t dev_fs:file_class_set getattr;
+dontaudit ipsec_mgmt_t device_t:lnk_file read;
+allow ipsec_mgmt_t self:{ tcp_socket udp_socket } create_socket_perms;
+allow ipsec_mgmt_t sysctl_net_t:file { getattr read };
+rw_dir_create_file(ipsec_mgmt_t, ipsec_var_run_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/iptables.te policy-1.17.29/domains/program/unused/iptables.te
--- nsapolicy/domains/program/unused/iptables.te	2004-09-27 20:48:35.000000000 -0400
+++ policy-1.17.29/domains/program/unused/iptables.te	2004-10-08 13:30:41.000000000 -0400
@@ -37,10 +37,11 @@
 # for iptables -L
 allow iptables_t self:unix_stream_socket create_socket_perms;
 can_network(iptables_t)
+can_ypbind(iptables_t)
 
 allow iptables_t bin_t:file { execute execute_no_trans };
 allow iptables_t iptables_exec_t:file { execute_no_trans };
-allow iptables_t iptables_t:capability { net_admin net_raw };
+allow iptables_t iptables_t:capability { net_admin net_raw net_bind_service };
 allow iptables_t iptables_t:rawip_socket create_socket_perms;
 
 allow iptables_t etc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mdadm.te policy-1.17.29/domains/program/unused/mdadm.te
--- nsapolicy/domains/program/unused/mdadm.te	2004-09-10 10:45:48.000000000 -0400
+++ policy-1.17.29/domains/program/unused/mdadm.te	2004-10-09 14:36:11.000000000 -0400
@@ -18,7 +18,7 @@
 read_locale(mdadm_t)
 
 # Linux capabilities
-allow mdadm_t self:capability { dac_override sys_admin };
+allow mdadm_t self:capability { dac_override sys_admin ipc_lock };
 
 # Helper program access
 can_exec(mdadm_t, { bin_t sbin_t })
@@ -38,3 +38,4 @@
 dontaudit mdadm_t tmpfs_t:dir r_dir_perms;
 dontaudit mdadm_t initctl_t:fifo_file { getattr };
 var_run_domain(mdadm)
+allow mdadm_t var_t:dir { getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.17.29/domains/program/unused/nscd.te
--- nsapolicy/domains/program/unused/nscd.te	2004-10-09 21:06:14.466417028 -0400
+++ policy-1.17.29/domains/program/unused/nscd.te	2004-10-08 13:30:51.000000000 -0400
@@ -58,7 +58,7 @@
 allow nscd_t self:process { getattr setsched };
 allow nscd_t self:unix_dgram_socket create_socket_perms;
 allow nscd_t self:fifo_file { read write };
-allow nscd_t self:capability { kill setgid setuid };
+allow nscd_t self:capability { kill setgid setuid net_bind_service };
 
 # for when /etc/passwd has just been updated and has the wrong type
 allow nscd_t shadow_t:file getattr;
@@ -74,5 +74,4 @@
 can_getsecurity(nscd_t)
 allow nscd_t self:netlink_selinux_socket create_socket_perms;
 
-dontaudit nscd_t reserved_port_type:{ tcp_socket udp_socket } name_bind;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postgresql.te policy-1.17.29/domains/program/unused/postgresql.te
--- nsapolicy/domains/program/unused/postgresql.te	2004-09-13 15:58:18.000000000 -0400
+++ policy-1.17.29/domains/program/unused/postgresql.te	2004-10-09 16:11:06.000000000 -0400
@@ -32,7 +32,8 @@
 allow postgresql_t { var_spool_t cron_spool_t }:dir search;
 
 # capability kill is for shutdown script
-allow postgresql_t self:capability { kill dac_override dac_read_search chown fowner fsetid setuid setgid sys_tty_config };
+allow postgresql_t self:capability { kill dac_override dac_read_search chown fowner fsetid setuid setgid sys_nice sys_tty_config };
+dontaudit postgresql_t postgresql_t:capability { sys_admin };
 
 etcdir_domain(postgresql)
 typealias postgresql_etc_t alias etc_postgresql_t;
@@ -93,7 +94,7 @@
 allow postgresql_t devtty_t:chr_file { read write };
 allow postgresql_t devpts_t:dir search;
 
-can_exec(postgresql_t, { postgresql_exec_t bin_t sbin_t ls_exec_t su_exec_t shell_exec_t etc_t })
+can_exec(postgresql_t, { postgresql_exec_t bin_t sbin_t ls_exec_t su_exec_t shell_exec_t etc_t hostname_exec_t })
 allow postgresql_t { bin_t sbin_t }:dir search;
 allow postgresql_t { bin_t sbin_t }:lnk_file read;
 allow postgresql_t postgresql_exec_t:lnk_file read;
@@ -101,3 +102,6 @@
 allow postgresql_t self:sem create_sem_perms;
 
 allow postgresql_t initrc_var_run_t:file { getattr read lock };
+dontaudit postgresql_t selinux_config_t:dir { search };
+allow postgresql_t mail_spool_t:dir { search };
+rw_dir_create_file(postgresql_t, var_lock_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/procmail.te policy-1.17.29/domains/program/unused/procmail.te
--- nsapolicy/domains/program/unused/procmail.te	2004-08-27 16:51:30.000000000 -0400
+++ policy-1.17.29/domains/program/unused/procmail.te	2004-10-08 10:47:33.000000000 -0400
@@ -71,3 +71,4 @@
 ifdef(`sendmail.te', `
 r_dir_file(procmail_t, etc_mail_t)
 ')
+allow procmail_t mqueue_spool_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpcd.te policy-1.17.29/domains/program/unused/rpcd.te
--- nsapolicy/domains/program/unused/rpcd.te	2004-10-09 21:06:14.975359364 -0400
+++ policy-1.17.29/domains/program/unused/rpcd.te	2004-10-08 14:27:20.000000000 -0400
@@ -122,4 +122,4 @@
 
 r_dir_file(rpcd_t, rpc_pipefs_t)
 allow rpcd_t rpc_pipefs_t:sock_file { read write };
-
+dontaudit rpcd_t selinux_config_t:dir { search };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpm.te policy-1.17.29/domains/program/unused/rpm.te
--- nsapolicy/domains/program/unused/rpm.te	2004-10-07 08:02:01.000000000 -0400
+++ policy-1.17.29/domains/program/unused/rpm.te	2004-10-08 12:44:01.000000000 -0400
@@ -216,6 +216,7 @@
 allow rpm_script_t fs_t:filesystem { getattr mount unmount };
 allow rpm_script_t rpm_script_tmp_t:dir { mounton };
 can_exec(rpm_script_t, usr_t)
+can_exec(rpm_script_t, sbin_t)
 
 allow rpm_t mount_t:tcp_socket { write };
 create_dir_file(rpm_t, nfs_t)
@@ -248,7 +249,7 @@
 allow rpmbuild_t policy_src_t:file { getattr read };
 can_getsecurity(rpmbuild_t)
 
-allow rpm_script_t userdomain:process { signal };
+allow rpm_script_t domain:process { signal signull };
 
 ifdef(`unlimitedRPM', `
 unconfined_domain(rpm_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rsync.te policy-1.17.29/domains/program/unused/rsync.te
--- nsapolicy/domains/program/unused/rsync.te	2004-10-06 09:18:32.000000000 -0400
+++ policy-1.17.29/domains/program/unused/rsync.te	2004-10-08 11:01:29.000000000 -0400
@@ -11,3 +11,5 @@
 #
 
 inetd_child_domain(rsync)
+type rsync_data_t, file_type, sysadmfile;
+r_dir_file(rsync_t, rsync_data_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/samba.te policy-1.17.29/domains/program/unused/samba.te
--- nsapolicy/domains/program/unused/samba.te	2004-10-09 21:06:15.009355512 -0400
+++ policy-1.17.29/domains/program/unused/samba.te	2004-10-09 14:36:09.000000000 -0400
@@ -113,4 +113,6 @@
 allow nmbd_t samba_log_t:file { create ra_file_perms };
 allow nmbd_t var_log_t:dir search;
 allow nmbd_t samba_log_t:dir ra_dir_perms;
-
+ifdef(`cups.te', `
+allow smbd_t cupsd_rw_etc_t:file { getattr read };
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/sendmail.te policy-1.17.29/domains/program/unused/sendmail.te
--- nsapolicy/domains/program/unused/sendmail.te	2004-10-07 08:02:01.000000000 -0400
+++ policy-1.17.29/domains/program/unused/sendmail.te	2004-10-08 10:47:33.000000000 -0400
@@ -99,3 +99,5 @@
 allow system_mail_t sysctl_kernel_t:file read;
 dontaudit system_mail_t system_crond_tmp_t:file { append };
 dontaudit sendmail_t admin_tty_type:chr_file { getattr ioctl };
+allow sendmail_t initrc_var_run_t:file { getattr read };
+dontaudit sendmail_t initrc_var_run_t:file { lock write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/slrnpull.te policy-1.17.29/domains/program/unused/slrnpull.te
--- nsapolicy/domains/program/unused/slrnpull.te	2004-10-06 09:18:32.000000000 -0400
+++ policy-1.17.29/domains/program/unused/slrnpull.te	2004-10-08 10:47:33.000000000 -0400
@@ -21,3 +21,4 @@
 allow userdomain slrnpull_spool_t:dir { search };
 rw_dir_create_file(slrnpull_t, slrnpull_spool_t)
 allow slrnpull_t var_spool_t:dir { search };
+allow slrnpull_t slrnpull_spool_t:dir create_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/snmpd.te policy-1.17.29/domains/program/unused/snmpd.te
--- nsapolicy/domains/program/unused/snmpd.te	2004-10-09 21:06:15.044351547 -0400
+++ policy-1.17.29/domains/program/unused/snmpd.te	2004-10-09 14:36:09.000000000 -0400
@@ -25,7 +25,8 @@
 # for the .index file
 var_lib_domain(snmpd)
 file_type_auto_trans(snmpd_t, var_t, snmpd_var_lib_t, dir)
-file_type_auto_trans(snmpd_t, { usr_t var_t }, snmpd_var_lib_t, file)
+file_type_auto_trans(snmpd_t, usr_t, snmpd_var_lib_t, file)
+file_type_auto_trans(snmpd_t, var_t, snmpd_var_lib_t, file)
 typealias snmpd_var_lib_t alias snmpd_var_rw_t;
 
 log_domain(snmpd)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.17.29/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2004-10-09 21:06:15.309321525 -0400
+++ policy-1.17.29/domains/program/unused/udev.te	2004-10-08 13:29:55.000000000 -0400
@@ -106,7 +106,8 @@
 
 allow udev_t device_t:dir { relabelfrom relabelto create_dir_perms };
 allow udev_t sysctl_dev_t:dir { search };
-allow udev_t sysctl_dev_t:file { getattr read };
-allow udev_t sysctl_modprobe_t:file { getattr read };
 allow udev_t udev_t:rawip_socket create_socket_perms;
 dontaudit  udev_t domain:dir r_dir_perms;
+allow udev_t mnt_t:dir { search };
+allow udev_t { sysctl_dev_t sysctl_modprobe_t sysctl_kernel_t sysctl_hotplug_t }:file { getattr read };
+allow udev_t dev_fs:{ chr_file blk_file } { relabelfrom relabelto };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/updfstab.te policy-1.17.29/domains/program/unused/updfstab.te
--- nsapolicy/domains/program/unused/updfstab.te	2004-09-22 16:19:12.000000000 -0400
+++ policy-1.17.29/domains/program/unused/updfstab.te	2004-10-08 14:29:32.000000000 -0400
@@ -69,3 +69,4 @@
 can_exec(updfstab_t, { sbin_t bin_t ls_exec_t } )
 dontaudit updfstab_t home_root_t:dir { getattr search };
 dontaudit updfstab_t { home_dir_type home_type }:dir { search };
+allow updfstab_t fs_t:filesystem { getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ypbind.te policy-1.17.29/domains/program/unused/ypbind.te
--- nsapolicy/domains/program/unused/ypbind.te	2004-10-09 21:06:15.335318580 -0400
+++ policy-1.17.29/domains/program/unused/ypbind.te	2004-10-08 10:47:33.000000000 -0400
@@ -12,6 +12,8 @@
 #
 daemon_domain(ypbind)
 
+bool allow_ypbind true;
+
 tmp_domain(ypbind)
 
 # Use capabilities.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ypserv.te policy-1.17.29/domains/program/unused/ypserv.te
--- nsapolicy/domains/program/unused/ypserv.te	2004-03-17 13:26:05.000000000 -0500
+++ policy-1.17.29/domains/program/unused/ypserv.te	2004-10-09 11:22:39.000000000 -0400
@@ -13,7 +13,7 @@
 tmp_domain(ypserv)
 
 # Use capabilities.
-allow ypserv_t self:capability net_bind_service;
+allow ypserv_t self:capability { net_admin net_bind_service };
 
 # Use the network.
 can_network(ypserv_t)
@@ -35,3 +35,8 @@
 allow ypserv_t var_yp_t:file create_file_perms;
 allow ypserv_t ypserv_conf_t:file { getattr read };
 allow ypserv_t self:unix_dgram_socket create_socket_perms;
+allow ypserv_t self:netlink_route_socket r_netlink_socket_perms;
+ifdef(`rpcd.te', `
+allow rpcd_t ypserv_conf_t:file { getattr read };
+')
+allow ypserv_t reserved_port_t:{ udp_socket tcp_socket } { name_bind };
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/arpwatch.fc policy-1.17.29/file_contexts/program/arpwatch.fc
--- nsapolicy/file_contexts/program/arpwatch.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.29/file_contexts/program/arpwatch.fc	2004-10-09 11:24:04.000000000 -0400
@@ -0,0 +1,3 @@
+# arpwatch - keep track of ethernet/ip address pairings
+/usr/sbin/arpwatch	--	system_u:object_r:arpwatch_exec_t
+/var/arpwatch(/.*)?	system_u:object_r:arpwatch_data_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/cups.fc policy-1.17.29/file_contexts/program/cups.fc
--- nsapolicy/file_contexts/program/cups.fc	2004-10-01 15:05:32.000000000 -0400
+++ policy-1.17.29/file_contexts/program/cups.fc	2004-10-09 21:08:49.289877534 -0400
@@ -18,8 +18,9 @@
 /usr/lib(64)?/cups/backend/.* --	system_u:object_r:cupsd_exec_t
 /usr/lib(64)?/cups/daemon/.*	 --	system_u:object_r:cupsd_exec_t
 /usr/sbin/cupsd		--	system_u:object_r:cupsd_exec_t
-/usr/bin/cups-config-daemon --	system_u:object_r:cupsd_exec_t
-/usr/sbin/printconf-backend --	system_u:object_r:cupsd_exec_t
+/usr/bin/cups-config-daemon --	system_u:object_r:cupsd_config_exec_t
+/usr/sbin/hal_lpadmin --	system_u:object_r:cupsd_config_exec_t
+/usr/sbin/printconf-backend --	system_u:object_r:sbin_t
 /var/log/cups(/.*)?		system_u:object_r:cupsd_log_t
 /var/spool/cups(/.*)?		system_u:object_r:print_spool_t
 /var/run/cups/printcap	--	system_u:object_r:cupsd_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/ipsec.fc policy-1.17.29/file_contexts/program/ipsec.fc
--- nsapolicy/file_contexts/program/ipsec.fc	2004-09-02 14:45:46.000000000 -0400
+++ policy-1.17.29/file_contexts/program/ipsec.fc	2004-10-08 16:45:52.000000000 -0400
@@ -3,8 +3,10 @@
 /etc/ipsec\.secrets	--	system_u:object_r:ipsec_key_file_t
 /etc/ipsec\.conf	--	system_u:object_r:ipsec_conf_file_t
 /etc/ipsec\.d(/.*)?		system_u:object_r:ipsec_key_file_t
-/usr/lib(64)?/ipsec/.*	--	system_u:object_r:ipsec_mgmt_exec_t
-/usr/local/lib(64)?/ipsec/.*	--	system_u:object_r:ipsec_mgmt_exec_t
+/usr/lib(64)?/ipsec/.*	--	system_u:object_r:sbin_t
+/usr/lib(64)?/ipsec/_plutoload -- 	system_u:object_r:ipsec_mgmt_exec_t
+/usr/lib(64)?/ipsec/_plutorun  --	system_u:object_r:ipsec_mgmt_exec_t
+/usr/local/lib(64)?/ipsec/.*	--	system_u:object_r:sbin_t
 /usr/libexec/ipsec/eroute	--	system_u:object_r:ipsec_exec_t
 /usr/lib(64)?/ipsec/eroute	--	system_u:object_r:ipsec_exec_t
 /usr/local/lib(64)?/ipsec/eroute --	system_u:object_r:ipsec_exec_t
@@ -17,10 +19,7 @@
 /usr/libexec/ipsec/spi	--	system_u:object_r:ipsec_exec_t
 /usr/lib(64)?/ipsec/spi	--	system_u:object_r:ipsec_exec_t
 /usr/local/lib(64)?/ipsec/spi --	system_u:object_r:ipsec_exec_t
-/usr/sbin/ipsec		--	system_u:object_r:ipsec_mgmt_exec_t
-/usr/local/sbin/ipsec	--	system_u:object_r:ipsec_mgmt_exec_t
-/var/run/ipsec\.info		system_u:object_r:ipsec_var_run_t
-/var/run/pluto\.ctl		system_u:object_r:ipsec_var_run_t
+/var/run/pluto(/.*)?		system_u:object_r:ipsec_var_run_t
 
 # Kame
 /usr/sbin/racoon	--	system_u:object_r:ipsec_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.17.29/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2004-10-09 21:06:15.394311896 -0400
+++ policy-1.17.29/macros/base_user_macros.te	2004-10-08 16:27:42.000000000 -0400
@@ -43,6 +43,8 @@
 # for eject
 allow $1_t fixed_disk_device_t:blk_file { getattr };
 
+allow $1_t root_dir_type:dir { getattr };
+
 # open office is looking for the following
 dontaudit $1_t dri_device_t:chr_file rw_file_perms;
 # Do not flood message log, if the user does ls /dev 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.17.29/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2004-10-06 09:18:33.000000000 -0400
+++ policy-1.17.29/macros/global_macros.te	2004-10-08 10:47:33.000000000 -0400
@@ -396,6 +396,7 @@
 
 # for df
 allow $1_t fs_type:filesystem getattr;
+allow $1_t removable_t:filesystem getattr;
 
 read_locale($1_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.17.29/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2004-09-02 14:45:47.000000000 -0400
+++ policy-1.17.29/macros/program/apache_macros.te	2004-10-08 10:47:33.000000000 -0400
@@ -45,7 +45,6 @@
 
 uses_shlib(httpd_$1_script_t)
 can_network(httpd_$1_script_t)
-can_ypbind(httpd_$1_script_t)
 allow httpd_$1_script_t { usr_t lib_t }:file { getattr read ioctl };
 allow httpd_$1_script_t usr_t:lnk_file { getattr read };
 
@@ -65,7 +64,9 @@
 allow httpd_$1_script_t device_t:dir { getattr search };
 allow httpd_$1_script_t null_device_t:chr_file rw_file_perms;
 }
-
+if (httpd_enable_cgi && allow_ypbind) {
+uncond_can_ypbind(httpd_$1_script_t)
+}
 # The following are the only areas that 
 # scripts can read, read/write, or append to
 #
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/spamassassin_macros.te policy-1.17.29/macros/program/spamassassin_macros.te
--- nsapolicy/macros/program/spamassassin_macros.te	2004-09-30 20:48:49.000000000 -0400
+++ policy-1.17.29/macros/program/spamassassin_macros.te	2004-10-08 10:57:36.000000000 -0400
@@ -90,9 +90,10 @@
 # set tunable if you have spamassassin do DNS lookups
 if (spamassasin_can_network) {
 can_network($1_spamassassin_t)
-can_ypbind($1_spamassassin_t)
 }
-
+if (spamassasin_can_network && allow_ypbind) {
+uncond_can_ypbind($1_spamassassin_t)
+}
 ###
 # Define the domain for /usr/bin/spamc
 #
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/userhelper_macros.te policy-1.17.29/macros/program/userhelper_macros.te
--- nsapolicy/macros/program/userhelper_macros.te	2004-09-09 16:22:13.000000000 -0400
+++ policy-1.17.29/macros/program/userhelper_macros.te	2004-10-08 14:14:26.000000000 -0400
@@ -142,6 +142,7 @@
 domain_auto_trans($1_userhelper_t, xauth_exec_t, $1_xauth_t)
 allow $1_userhelper_t $1_home_xauth_t:file { getattr read };
 ')
+allow $1_userhelper_t pam_var_console_t:dir { search };
 
 ')dnl end ifdef single_userdomain
 ')dnl end userhelper macro
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xserver_macros.te policy-1.17.29/macros/program/xserver_macros.te
--- nsapolicy/macros/program/xserver_macros.te	2004-10-09 21:06:15.724274511 -0400
+++ policy-1.17.29/macros/program/xserver_macros.te	2004-10-09 11:23:24.000000000 -0400
@@ -64,7 +64,7 @@
 
 allow xdm_xserver_t init_t:fd use;
 
-dontaudit xdm_xserver_t homedirfile:dir { read search };
+dontaudit xdm_xserver_t home_dir_type:dir { read search };
 ', `
 # The user role is authorized for this domain.
 role $1_r types $1_xserver_t;
@@ -110,7 +110,7 @@
 # sys_admin, locking shared mem?  chowning IPC message queues or semaphores?
 # admin of APM bios?
 # sys_nice is so that the X server can set a negative nice value
-allow $1_xserver_t self:capability { dac_override fsetid setgid setuid ipc_owner sys_rawio sys_admin sys_nice sys_tty_config mknod };
+allow $1_xserver_t self:capability { dac_override fsetid setgid setuid ipc_owner sys_rawio sys_admin sys_nice sys_tty_config mknod net_bind_service };
 allow $1_xserver_t nfs_t:dir { getattr search };
 
 # memory_device_t access is needed if not using the frame buffer
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ypbind_macros.te policy-1.17.29/macros/program/ypbind_macros.te
--- nsapolicy/macros/program/ypbind_macros.te	2004-09-15 15:59:55.000000000 -0400
+++ policy-1.17.29/macros/program/ypbind_macros.te	2004-10-08 13:31:20.000000000 -0400
@@ -1,21 +1,13 @@
-define(`can_ypbind',`')
 
-ifdef(`targeted_policy', `
-pushdef(`ypbind.te')
+define(`uncond_can_ypbind', `
+dontaudit $1 reserved_port_type:{ tcp_socket udp_socket } name_bind;
+can_network($1)
+r_dir_file($1,var_yp_t)
+allow $1 { reserved_port_t port_t }:{ tcp_socket udp_socket } name_bind;
 ')
 
-ifdef(`ypbind.te', `
-ifdef(`allow_ypbind', `
-undefine(`can_ypbind')
 define(`can_ypbind', `
-r_dir_file($1,var_yp_t)
-can_network($1)
-dontaudit $1 reserved_port_t:{ tcp_socket udp_socket } name_bind;
-allow $1 port_t:{ tcp_socket udp_socket } name_bind;
+if (allow_ypbind) {
+uncond_can_ypbind($1)
+}
 ') dnl can_ypbind
-') dnl allow_ypbind
-') dnl ypbind.te
-
-ifdef(`targeted_policy', `
-popdef(`ypbind.te')
-')
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.29/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
+++ policy-1.17.29/tunables/distro.tun	2004-10-08 10:47:33.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.29/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-09-27 20:48:36.000000000 -0400
+++ policy-1.17.29/tunables/tunable.tun	2004-10-08 10:47:33.000000000 -0400
@@ -1,42 +1,39 @@
 # Allow all domains to connect to nscd
-dnl define(`nscd_all_connect')
+define(`nscd_all_connect')
 
 # Allow users to control network interfaces (also needs USERCTL=true)
 dnl define(`user_net_control')
 
 # Allow users to execute the mount command
-dnl define(`user_can_mount')
+define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
-dnl define(`unlimitedUtils')
+define(`unlimitedUtils')
 
 # Support NFS home directories
-dnl define(`nfs_home_dirs')
+define(`nfs_home_dirs')
 
 # Allow users to run games
-dnl define(`use_games')
-
-# Allow ypbind to run with NIS
-dnl define(`allow_ypbind')
+define(`use_games')
 
 # Allow rc scripts to run unconfined, including any daemon
 # started by an rc script that does not have a domain transition
 # explicitly defined.
-dnl define(`unlimitedRC')
+define(`unlimitedRC')
 
 # Allow sysadm_t to directly start daemons
 define(`direct_sysadm_daemon')
 
 # Do not audit things that we know to be broken but which
 # are not security risks
-dnl define(`hide_broken_symptoms')
+define(`hide_broken_symptoms')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.
diff --exclude-from=exclude -N -u -r nsapolicy/types/network.te policy-1.17.29/types/network.te
--- nsapolicy/types/network.te	2004-08-23 14:54:51.000000000 -0400
+++ policy-1.17.29/types/network.te	2004-10-08 14:26:29.000000000 -0400
@@ -42,7 +42,7 @@
 ifdef(`dovecot.te', `define(`use_pop')')
 ifdef(`uwimapd.te', `define(`use_pop')')
 ifdef(`use_pop', `
-type pop_port_t, port_type;
+type pop_port_t, port_type, reserved_port_type;
 ')
 ifdef(`apache.te', `define(`use_http_cache')')
 ifdef(`squid.te', `define(`use_http_cache')')

--------------090206010102060600020700--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

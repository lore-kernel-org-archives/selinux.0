Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8L596rT022548
	for <selinux@tycho.nsa.gov>; Tue, 21 Sep 2004 01:09:06 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8L583aY007150
	for <selinux@tycho.nsa.gov>; Tue, 21 Sep 2004 05:08:05 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: File types that are not sysadmfiles...
Date: Tue, 21 Sep 2004 15:08:59 +1000
Cc: Colin Walters <walters@verbum.org>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>,
   Joshua Brindle <method@gentoo.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
References: <414DA0A7.1000708@gentoo.org> <1095695627.4431.157.camel@nexus.verbum.private> <414F4113.1000208@redhat.com>
In-Reply-To: <414F4113.1000208@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rd7TBiVFY/eaifW"
Message-Id: <200409211508.59158.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_rd7TBiVFY/eaifW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 21 Sep 2004 06:44, Daniel J Walsh <dwalsh@redhat.com> wrote:
> grep file_type policy.conf | grep -v sysadmfile | grep "^type "
> type printer_device_t, file_type, device_type, dev_fs;
> type httpd_php_exec_t, file_type, exec_type;
> type lvm_control_t, file_type, device_type, dev_fs;
> type vmware_user_exec_t, file_type, exec_type;
> type vmware_device_t, file_type, device_type, dev_fs;
> type vmware_user_var_run_t, file_type, pidfile;
> type vmware_user_file_t, homedirfile, file_type;
> type vmware_user_conf_t, homedirfile, file_type;
> type watchdog_device_t, file_type, device_type, dev_fs;

The above are all bugs in the policy.  I have attached a patch that fixes them 
along with a few other minor things.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_rd7TBiVFY/eaifW
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru /usr/src/se/policy/domains/program/hostname.te ./domains/program/hostname.te
--- /usr/src/se/policy/domains/program/hostname.te	2004-09-16 18:06:45.000000000 +1000
+++ ./domains/program/hostname.te	2004-09-16 21:39:22.000000000 +1000
@@ -1,4 +1,4 @@
-#DESC hostname - show or set the system's host name
+#DESC hostname - show or set the system host name
 #
 # Author: Russell Coker <russell@coker.com.au>
 # X-Debian-Packages: hostname
diff -ru /usr/src/se/policy/domains/program/unused/cups.te ./domains/program/unused/cups.te
--- /usr/src/se/policy/domains/program/unused/cups.te	2004-09-15 16:31:22.000000000 +1000
+++ ./domains/program/unused/cups.te	2004-09-20 07:15:57.000000000 +1000
@@ -27,6 +27,7 @@
 
 allow cupsd_t devpts_t:dir search;
 
+allow cupsd_t device_t:lnk_file read;
 allow cupsd_t printer_device_t:chr_file rw_file_perms;
 allow cupsd_t urandom_device_t:chr_file { getattr read };
 dontaudit cupsd_t random_device_t:chr_file ioctl;
diff -ru /usr/src/se/policy/domains/program/unused/dpkg.te ./domains/program/unused/dpkg.te
--- /usr/src/se/policy/domains/program/unused/dpkg.te	2004-08-28 12:05:02.000000000 +1000
+++ ./domains/program/unused/dpkg.te	2004-09-11 19:48:52.000000000 +1000
@@ -295,9 +295,6 @@
 allow dpkg_t sysadmfile:{ file fifo_file sock_file } create_file_perms;
 allow dpkg_t sysadmfile:lnk_file create_lnk_perms;
 allow dpkg_t device_type:{ chr_file blk_file } getattr;
-ifdef(`devfsd.te', `', `
-allow dpkg_t device_type:{ chr_file blk_file } { create setattr rename };
-')
 dontaudit dpkg_t domain:{ socket unix_dgram_socket udp_socket unix_stream_socket tcp_socket fifo_file rawip_socket packet_socket } getattr;
 allow dpkg_t proc_kmsg_t:file getattr;
 allow dpkg_t root_dir_type:dir getattr;
diff -ru /usr/src/se/policy/domains/program/unused/hald.te ./domains/program/unused/hald.te
--- /usr/src/se/policy/domains/program/unused/hald.te	2004-09-17 22:01:26.000000000 +1000
+++ ./domains/program/unused/hald.te	2004-09-20 08:47:12.000000000 +1000
@@ -34,11 +34,10 @@
 allow hald_t self:capability { net_admin sys_admin };
 can_network(hald_t)
 can_ypbind(hald_t)
-dbusd_client(system, hald_t)
 
 allow hald_t device_t:lnk_file read;
 allow hald_t { fixed_disk_device_t removable_device_t }:blk_file { getattr read ioctl };
-allow hald_t event_device_t:chr_file { getattr read };
+allow hald_t event_device_t:chr_file { getattr read ioctl };
 
 ifdef(`updfstab.te', `
 domain_auto_trans(hald_t, updfstab_exec_t, updfstab_t)
diff -ru /usr/src/se/policy/domains/program/unused/hotplug.te ./domains/program/unused/hotplug.te
--- /usr/src/se/policy/domains/program/unused/hotplug.te	2004-09-11 16:21:44.000000000 +1000
+++ ./domains/program/unused/hotplug.te	2004-09-16 22:01:03.000000000 +1000
@@ -69,6 +69,8 @@
 
 ifdef(`hald.te', `
 allow hotplug_t hald_t:unix_dgram_socket sendto;
+allow hald_t hotplug_etc_t:dir search;
+allow hald_t hotplug_etc_t:file { getattr read };
 ')
 
 # for killall
diff -ru /usr/src/se/policy/domains/program/unused/iptables.te ./domains/program/unused/iptables.te
--- /usr/src/se/policy/domains/program/unused/iptables.te	2004-09-21 14:39:14.000000000 +1000
+++ ./domains/program/unused/iptables.te	2004-08-24 18:16:47.000000000 +1000
@@ -56,7 +56,3 @@
 
 # system-config-network appends to /var/log
 allow iptables_t var_log_t:file { append };
-
-# for /usr/bin/tc
-allow iptables_t self:netlink_route_socket { create getattr bind nlmsg_read nlmsg_write read write };
- 
diff -ru /usr/src/se/policy/domains/program/unused/lvm.te ./domains/program/unused/lvm.te
--- /usr/src/se/policy/domains/program/unused/lvm.te	2004-09-11 16:21:44.000000000 +1000
+++ ./domains/program/unused/lvm.te	2004-09-21 14:41:09.000000000 +1000
@@ -16,7 +16,7 @@
 #
 type lvm_vg_t, file_type, sysadmfile;
 type lvm_metadata_t, file_type, sysadmfile;
-type lvm_control_t, file_type, device_type, dev_fs;
+type lvm_control_t, device_type, dev_fs;
 etcdir_domain(lvm)
 allow lvm_t var_t:dir search;
 lock_domain(lvm)
diff -ru /usr/src/se/policy/domains/program/unused/mta.te ./domains/program/unused/mta.te
--- /usr/src/se/policy/domains/program/unused/mta.te	2004-06-17 15:10:40.000000000 +1000
+++ ./domains/program/unused/mta.te	2004-09-20 02:30:12.000000000 +1000
@@ -48,6 +48,7 @@
 
 # for /var/spool/mail
 ra_dir_file(mta_delivery_agent, mail_spool_t)
+allow mta_delivery_agent mail_spool_t:file create;
 
 # for piping mail to a command
 can_exec(mta_delivery_agent, shell_exec_t)
diff -ru /usr/src/se/policy/domains/program/unused/postfix.te ./domains/program/unused/postfix.te
--- /usr/src/se/policy/domains/program/unused/postfix.te	2004-09-16 18:06:52.000000000 +1000
+++ ./domains/program/unused/postfix.te	2004-09-20 02:30:27.000000000 +1000
@@ -81,6 +81,9 @@
 domain_auto_trans(sysadm_t, postfix_master_exec_t, postfix_master_t)
 allow sysadm_t postfix_master_t:process { noatsecure siginh rlimitinh };
 role_transition sysadm_r postfix_master_exec_t system_r;
+domain_auto_trans(sysadm_mail_t, postfix_master_exec_t, system_mail_t)
+allow system_mail_t sysadm_t:process sigchld;
+allow system_mail_t privfd:fd use;
 ')dnl end direct_sysadm_daemon
 
 allow postfix_master_t privfd:fd use;
@@ -88,10 +91,16 @@
 allow postfix_master_t initrc_devpts_t:chr_file rw_file_perms;
 
 # postfix does a "find" on startup for some reason - keep it quiet
+dontaudit postfix_master_t selinux_config_t:dir search;
 can_exec({ sysadm_mail_t system_mail_t }, postfix_master_exec_t)
+ifdef(`distro_redhat', `
+file_type_auto_trans({ sysadm_mail_t system_mail_t }, postfix_etc_t, etc_aliases_t)
+', `
 file_type_auto_trans({ sysadm_mail_t system_mail_t }, etc_t, etc_aliases_t)
+')
 allow postfix_master_t sendmail_exec_t:file r_file_perms;
 allow postfix_master_t sbin_t:lnk_file { getattr read };
+domain_auto_trans(initrc_t, postfix_master_exec_t, postfix_master_t)
 ifdef(`pppd.te', `
 domain_auto_trans(pppd_t, postfix_master_exec_t, postfix_master_t)
 ')
@@ -338,3 +347,4 @@
 allow postfix_map_t self:capability setgid;
 allow postfix_map_t self:unix_dgram_socket create_socket_perms;
 dontaudit postfix_map_t var_t:dir search;
+can_network(postfix_map_t)
diff -ru /usr/src/se/policy/domains/program/unused/quota.te ./domains/program/unused/quota.te
--- /usr/src/se/policy/domains/program/unused/quota.te	2004-09-16 18:06:53.000000000 +1000
+++ ./domains/program/unused/quota.te	2004-03-06 05:49:35.000000000 +1100
@@ -17,6 +17,10 @@
 role sysadm_r types quota_t;
 allow quota_t admin_tty_type:chr_file { read write };
 
+domain_auto_trans(sysadm_t, quota_exec_t, quota_t)
+role sysadm_r types quota_t;
+allow quota_t admin_tty_type:chr_file { read write };
+
 type quota_flag_t, file_type, sysadmfile;
 type quota_db_t, file_type, sysadmfile;
 
diff -ru /usr/src/se/policy/domains/program/unused/watchdog.te ./domains/program/unused/watchdog.te
--- /usr/src/se/policy/domains/program/unused/watchdog.te	2004-09-11 16:21:45.000000000 +1000
+++ ./domains/program/unused/watchdog.te	2004-09-21 14:40:50.000000000 +1000
@@ -10,7 +10,7 @@
 #
 
 daemon_domain(watchdog, `, privmail')
-type watchdog_device_t, file_type, device_type, dev_fs;
+type watchdog_device_t, device_type, dev_fs;
 
 log_domain(watchdog)
 
diff -ru /usr/src/se/policy/file_contexts/program/fsadm.fc ./file_contexts/program/fsadm.fc
--- /usr/src/se/policy/file_contexts/program/fsadm.fc	2004-08-28 12:05:09.000000000 +1000
+++ ./file_contexts/program/fsadm.fc	2004-09-17 02:39:36.000000000 +1000
@@ -33,3 +33,4 @@
 /usr/bin/raw		--	system_u:object_r:fsadm_exec_t
 /sbin/partx		--	system_u:object_r:fsadm_exec_t
 /usr/bin/partition_uuid	--	system_u:object_r:fsadm_exec_t
+/sbin/partprobe		--	system_u:object_r:fsadm_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/hald.fc ./file_contexts/program/hald.fc
--- /usr/src/se/policy/file_contexts/program/hald.fc	2004-09-15 16:31:23.000000000 +1000
+++ ./file_contexts/program/hald.fc	2004-09-16 21:56:09.000000000 +1000
@@ -2,3 +2,4 @@
 /usr/sbin/hald		--	system_u:object_r:hald_exec_t
 /usr/libexec/hal-hotplug-map -- system_u:object_r:hald_exec_t
 /etc/hal/device.d/printer_remove.hal -- system_u:object_r:hald_exec_t
+/etc/hal/capability.d/printer_update.hal -- system_u:object_r:hald_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/postfix.fc ./file_contexts/program/postfix.fc
--- /usr/src/se/policy/file_contexts/program/postfix.fc	2004-07-13 09:08:05.000000000 +1000
+++ ./file_contexts/program/postfix.fc	2004-09-20 01:15:11.000000000 +1000
@@ -1,5 +1,8 @@
 # postfix
 /etc/postfix(/.*)?		system_u:object_r:postfix_etc_t
+ifdef(`distro_redhat', `
+/etc/postfix/aliases.*		system_u:object_r:etc_aliases_t
+')
 /etc/postfix/postfix-script.* -- system_u:object_r:postfix_exec_t
 /etc/postfix/prng_exch	--	system_u:object_r:postfix_prng_t
 /usr/lib(exec)?/postfix/.*	--	system_u:object_r:postfix_exec_t
diff -ru /usr/src/se/policy/macros/program/rssh_macros.te ./macros/program/rssh_macros.te
--- /usr/src/se/policy/macros/program/rssh_macros.te	2004-08-24 05:46:55.000000000 +1000
+++ ./macros/program/rssh_macros.te	2004-09-19 17:51:46.000000000 +1000
@@ -27,7 +27,7 @@
 base_file_read_access(rssh_$1_t);
 allow rssh_$1_t var_t:dir r_dir_perms;
 r_dir_file(rssh_$1_t, etc_t);
-r_dir_file(rssh_$1_t, etc_runtime_t);
+allow rssh_$1_t etc_runtime_t:file { getattr read };
 r_dir_file(rssh_$1_t, locale_t);
 can_exec(rssh_$1_t, bin_t);
 
diff -ru /usr/src/se/policy/types/device.te ./types/device.te
--- /usr/src/se/policy/types/device.te	2004-09-11 16:21:48.000000000 +1000
+++ ./types/device.te	2004-09-21 14:40:17.000000000 +1000
@@ -62,7 +62,7 @@
 #
 # printer_device_t is the type for printer devices
 #
-type printer_device_t, file_type, device_type, dev_fs;
+type printer_device_t, device_type, dev_fs;
 
 #
 # fixed_disk_device_t is the type of 
diff -ru /usr/src/se/policy/types/devpts.te ./types/devpts.te
--- /usr/src/se/policy/types/devpts.te	2004-09-11 16:21:48.000000000 +1000
+++ ./types/devpts.te	2004-09-21 14:40:27.000000000 +1000
@@ -10,7 +10,7 @@
 #
 # ptmx_t is the type for /dev/ptmx.
 #
-type ptmx_t, file_type, sysadmfile, device_type, dev_fs;
+type ptmx_t, sysadmfile, device_type, dev_fs;
 
 #
 # devpts_t is the type of the devpts file system and 
diff -ru /usr/src/se/policy/types/procfs.te ./types/procfs.te
--- /usr/src/se/policy/types/procfs.te	2004-09-16 18:07:10.000000000 +1000
+++ ./types/procfs.te	2004-09-16 21:49:45.000000000 +1000
@@ -11,7 +11,7 @@
 # proc_t is the type of /proc.
 # proc_kmsg_t is the type of /proc/kmsg.
 # proc_kcore_t is the type of /proc/kcore.
-# proc_mdtat_t is the type of /proc/mdstat.
+# proc_mdstat_t is the type of /proc/mdstat.
 #
 type proc_t, fs_type, proc_fs, root_dir_type;
 type proc_kmsg_t, proc_fs;
--- /usr/src/se/policy/domains/program/unused/apache.te	2004-08-28 12:05:01.000000000 +1000
+++ domains/program/unused/apache.te	2004-09-21 15:04:15.000000000 +1000
@@ -205,7 +205,7 @@
 # PHP Directives
 ##################################################
 
-type httpd_php_exec_t, file_type, exec_type;
+type httpd_php_exec_t, file_type, sysadmfile, exec_type;
 type httpd_php_t, domain;
 
 # Transition from the user domain to this domain.
--- /usr/src/se/policy/domains/program/unused/vmware.te	2004-09-11 16:21:45.000000000 +1000
+++ domains/program/unused/vmware.te	2004-09-21 15:06:29.000000000 +1000
@@ -24,22 +24,22 @@
 #
 # The vmware_user_exec_t type is for the user programs.
 #
-type vmware_user_exec_t, file_type, exec_type;
+type vmware_user_exec_t, file_type, sysadmfile, exec_type;
 
 # Type for vmware devices.
-type vmware_device_t, file_type, device_type, dev_fs;
+type vmware_device_t, device_type, dev_fs;
 
 # Type for files in /var/run when a user starts VMWare
-type vmware_user_var_run_t, file_type, pidfile;
+type vmware_user_var_run_t, file_type, sysadmfile, pidfile;
 
 # The sys configuration used for the /etc/vmware configuration files
-type vmware_sys_conf_t, file_type, sysadmfile;
+type vmware_sys_conf_t, file_type, sysadmfile, sysadmfile;
 
 # The user file type is for files created when the user is running VMWare
-type vmware_user_file_t, homedirfile, file_type;
+type vmware_user_file_t, homedirfile, file_type, sysadmfile;
 
 # The user file type for the VMWare configuration files
-type vmware_user_conf_t, homedirfile, file_type;
+type vmware_user_conf_t, homedirfile, file_type, sysadmfile;
 
 #########################################################################
 # Additional rules to start/stop VMWare

--Boundary-00=_rd7TBiVFY/eaifW--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

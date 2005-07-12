Message-ID: <42D42709.2070003@redhat.com>
Date: Tue, 12 Jul 2005 16:24:41 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>, Jim Carter <jwcart2@epoch.ncsc.mil>
Subject: Latest Diffs
Content-Type: multipart/mixed;
 boundary="------------030405000503090503060304"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030405000503090503060304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added auth_bool attribute to allow domains read access to shadow_t if a 
boolean is set.
saslauthd needs such a boolean.

Allow pppd to insmod kernel modules for modems.

radvd fixes.

Allow nfs to export noexattrfile types.


Fixes for winbind to read/write /tmp files

Change apachectl to initrc_exec_t to properly start apache domain.

iiimd.bin name change

unix_chpwd needs access to cert files and random devices to use encryption




-- 



--------------030405000503090503060304
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/assert.te policy-1.25.2/assert.te
--- nsapolicy/assert.te	2005-05-25 11:28:09.000000000 -0400
+++ policy-1.25.2/assert.te	2005-07-12 16:12:07.000000000 -0400
@@ -41,7 +41,7 @@
 
 #
 # Verify that only appropriate domains can access /etc/shadow
-neverallow { domain -auth -auth_write -unrestricted } shadow_t:file ~getattr;
+neverallow { domain -auth_bool -auth -auth_write -unrestricted } shadow_t:file ~getattr;
 neverallow { domain -auth_write -unrestricted } shadow_t:file ~r_file_perms;
 
 #
diff --exclude-from=exclude -N -u -r nsapolicy/attrib.te policy-1.25.2/attrib.te
--- nsapolicy/attrib.te	2005-07-06 17:15:06.000000000 -0400
+++ policy-1.25.2/attrib.te	2005-07-12 16:12:07.000000000 -0400
@@ -141,6 +141,10 @@
 # to read /etc/shadow, and grants the permission.
 attribute auth;
 
+# The auth_bool attribute identifies every domain that can 
+# read /etc/shadow if its boolean is set;
+attribute auth_bool;
+
 # The auth_write attribute identifies every domain that can have write or
 # relabel access to /etc/shadow, but does not grant it.
 attribute auth_write;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ifconfig.te policy-1.25.2/domains/program/ifconfig.te
--- nsapolicy/domains/program/ifconfig.te	2005-05-07 00:41:08.000000000 -0400
+++ policy-1.25.2/domains/program/ifconfig.te	2005-07-12 16:12:07.000000000 -0400
@@ -26,6 +26,7 @@
 ')
 
 # for /sbin/ip
+allow ifconfig_t self:packet_socket create_socket_perms;
 allow ifconfig_t self:netlink_route_socket rw_netlink_socket_perms;
 allow ifconfig_t self:tcp_socket { create ioctl };
 allow ifconfig_t etc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/pppd.te policy-1.25.2/domains/program/unused/pppd.te
--- nsapolicy/domains/program/unused/pppd.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.2/domains/program/unused/pppd.te	2005-07-12 16:12:07.000000000 -0400
@@ -102,3 +102,11 @@
 allow pppd_t self:netlink_route_socket r_netlink_socket_perms;
 allow pppd_t initrc_var_run_t:file r_file_perms;
 dontaudit pppd_t initrc_var_run_t:file { lock write };
+
+# pppd needs to load kernel modules for certain modems
+bool pppd_can_insmod false;
+if (pppd_can_insmod) {
+ifdef(`modutil.te', `
+domain_auto_trans(pppd_t, insmod_exec_t, insmod_t)
+')
+}
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/radvd.te policy-1.25.2/domains/program/unused/radvd.te
--- nsapolicy/domains/program/unused/radvd.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.2/domains/program/unused/radvd.te	2005-07-12 16:12:07.000000000 -0400
@@ -15,15 +15,15 @@
 
 allow radvd_t self:{ rawip_socket unix_dgram_socket } rw_socket_perms;
 
-allow radvd_t self:capability { net_raw setgid };
+allow radvd_t self:capability { setgid setuid net_raw setgid };
 allow radvd_t self:{ unix_dgram_socket rawip_socket } create;
 allow radvd_t self:unix_stream_socket create_socket_perms;
 
 can_network_server(radvd_t)
 can_ypbind(radvd_t)
 
-allow radvd_t proc_t:dir r_dir_perms;
-allow radvd_t proc_t:file { getattr read };
+allow radvd_t { proc_t proc_net_t }:dir r_dir_perms;
+allow radvd_t { proc_t proc_net_t }:file { getattr read };
 allow radvd_t etc_t:lnk_file read;
 
 allow radvd_t sysctl_net_t:file r_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpcd.te policy-1.25.2/domains/program/unused/rpcd.te
--- nsapolicy/domains/program/unused/rpcd.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.2/domains/program/unused/rpcd.te	2005-07-12 16:12:07.000000000 -0400
@@ -93,7 +93,8 @@
 bool nfs_export_all_rw false;
 
 if(nfs_export_all_rw) {
-allow nfsd_t { file_type -shadow_t }:dir r_dir_perms;
+allow nfsd_t { noexattrfile file_type -shadow_t }:dir r_dir_perms;
+r_dir_file(kernel_t, noexattrfile)
 create_dir_file(kernel_t,{ file_type -shadow_t })
 }
 
@@ -102,8 +103,8 @@
 bool nfs_export_all_ro false;
 
 if(nfs_export_all_ro) {
-allow nfsd_t { file_type -shadow_t }:dir r_dir_perms;
-r_dir_file(kernel_t,{ file_type -shadow_t })
+allow nfsd_t { noexattrfile file_type -shadow_t }:dir r_dir_perms;
+r_dir_file(kernel_t,{ noexattrfile file_type -shadow_t })
 }
 
 allow nfsd_t { nfsd_rw_t nfsd_ro_t }:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/saslauthd.te policy-1.25.2/domains/program/unused/saslauthd.te
--- nsapolicy/domains/program/unused/saslauthd.te	2005-05-25 11:28:10.000000000 -0400
+++ policy-1.25.2/domains/program/unused/saslauthd.te	2005-07-12 16:12:07.000000000 -0400
@@ -3,7 +3,7 @@
 # Author: Colin Walters <walters@verbum.org>
 #
 
-daemon_domain(saslauthd, `, auth_chkpwd')
+daemon_domain(saslauthd, `, auth_chkpwd, auth_bool')
 
 allow saslauthd_t self:fifo_file { read write };
 allow saslauthd_t self:unix_dgram_socket create_socket_perms;
@@ -21,3 +21,11 @@
 
 # Needs investigation
 dontaudit saslauthd_t home_root_t:dir getattr;
+can_network_client_tcp(saslauthd_t)
+allow saslauthd_t pop_port_t:tcp_socket name_connect;
+
+bool allow_saslauthd_read_shadow false;
+
+if (allow_saslauthd_read_shadow) {
+allow saslauthd_t shadow_t:file r_file_perms;
+}
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/winbind.te policy-1.25.2/domains/program/unused/winbind.te
--- nsapolicy/domains/program/unused/winbind.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.2/domains/program/unused/winbind.te	2005-07-12 16:12:07.000000000 -0400
@@ -10,6 +10,7 @@
 
 daemon_domain(winbind, `, privhome, auth_chkpwd, nscd_client_domain')
 log_domain(winbind)
+tmp_domain(winbind)
 allow winbind_t etc_t:file r_file_perms;
 allow winbind_t etc_t:lnk_file read;
 can_network(winbind_t)
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/apache.fc policy-1.25.2/file_contexts/program/apache.fc
--- nsapolicy/file_contexts/program/apache.fc	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.2/file_contexts/program/apache.fc	2005-07-12 16:12:07.000000000 -0400
@@ -50,3 +50,5 @@
 ifdef(`targeted_policy', `', `
 /var/spool/cron/apache		-- 	system_u:object_r:user_cron_spool_t
 ')
+/usr/sbin/apachectl		-- 	system_u:object_r:initrc_exec_t
+
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/i18n_input.fc policy-1.25.2/file_contexts/program/i18n_input.fc
--- nsapolicy/file_contexts/program/i18n_input.fc	2005-05-02 14:06:56.000000000 -0400
+++ policy-1.25.2/file_contexts/program/i18n_input.fc	2005-07-12 16:12:07.000000000 -0400
@@ -1,7 +1,7 @@
 # i18n_input.fc
 /usr/sbin/htt                   --     system_u:object_r:i18n_input_exec_t
 /usr/sbin/htt_server            --     system_u:object_r:i18n_input_exec_t
-/usr/bin/iiimd		        --     system_u:object_r:i18n_input_exec_t
+/usr/bin/iiimd\.bin	        --     system_u:object_r:i18n_input_exec_t
 /usr/bin/httx                   --     system_u:object_r:i18n_input_exec_t
 /usr/bin/htt_xbe                --     system_u:object_r:i18n_input_exec_t
 /usr/bin/iiimx                  --     system_u:object_r:i18n_input_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/chkpwd_macros.te policy-1.25.2/macros/program/chkpwd_macros.te
--- nsapolicy/macros/program/chkpwd_macros.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.2/macros/program/chkpwd_macros.te	2005-07-12 16:12:07.000000000 -0400
@@ -42,6 +42,9 @@
 ifdef(`winbind.te', `
 r_dir_file(auth_chkpwd, winbind_var_run_t)
 ')
+r_dir_file(auth_chkpwd, cert_t)
+r_dir_file($1_chkpwd_t, cert_t)
+allow $1_chkpwd_t { random_device_t urandom_device_t }:chr_file { getattr read };
 ', `
 domain_auto_trans($1_t, chkpwd_exec_t, $1_chkpwd_t)
 allow $1_t sbin_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.25.2/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.25.2/tunables/distro.tun	2005-07-12 16:12:07.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.25.2/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-05-25 11:28:11.000000000 -0400
+++ policy-1.25.2/tunables/tunable.tun	2005-07-12 16:12:07.000000000 -0400
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

--------------030405000503090503060304--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

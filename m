Message-ID: <412B607F.6070708@redhat.com>
Date: Tue, 24 Aug 2004 11:36:31 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Policy changes
Content-Type: multipart/mixed;
 boundary="------------080002060808090704050200"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080002060808090704050200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I am trying to remove unrestricted_admin, so I added a new attribute 
unrestricted.  Then replaced all the special code within
assert.te to check unrestricted.

Dan



--------------080002060808090704050200
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/assert.te policy-1.17.3/assert.te
--- nsapolicy/assert.te	2004-06-16 13:37:32.000000000 -0400
+++ policy-1.17.3/assert.te	2004-08-24 11:27:40.740906331 -0400
@@ -30,7 +30,7 @@
 # Verify that only the insmod_t and kernel_t domains 
 # have the sys_module capability.
 #
-neverallow {domain ifdef(`unrestricted_admin', `-admin') -insmod_t -kernel_t ifdef(`anaconda.te', `-anaconda_t') ifdef(`firstboot.te', `-firstboot_t') ifdef(`unconfined.te', `-unconfined_t') } self:capability sys_module;
+neverallow {domain -unrestricted -insmod_t -kernel_t } self:capability sys_module;
 
 #
 # Verify that executable types, the system dynamic loaders, and the
@@ -71,10 +71,10 @@
 # Verify that /proc/kmsg is only accessible to klogd.
 #
 ifdef(`klogd.te', `
-neverallow {domain ifdef(`firstboot.te', `-firstboot_t') ifdef(`unrestricted_admin', `-admin') -klogd_t ifdef(`anaconda.te', `-anaconda_t') ifdef(`unconfined.te', `-unconfined_t') } proc_kmsg_t:file ~stat_file_perms;
+neverallow {domain -unrestricted -klogd_t } proc_kmsg_t:file ~stat_file_perms;
 ', `
 ifdef(`syslogd.te', `
-neverallow {domain ifdef(`unrestricted_admin', `-admin') ifdef(`unconfined.te', `-unconfined_t') -syslogd_t ifdef(`anaconda.te', `-anaconda_t') } proc_kmsg_t:file ~stat_file_perms;
+neverallow {domain -unrestricted -syslogd_t } proc_kmsg_t:file ~stat_file_perms;
 ')dnl end if syslogd
 ')dnl end if klogd
 
@@ -82,7 +82,7 @@
 # Verify that /proc/kcore is inaccessible.
 #
 
-neverallow { domain ifdef(`unrestricted_admin', `-admin') ifdef(`unconfined.te', `-unconfined_t') ifdef(`firstboot.te', `-firstboot_t') ifdef(`anaconda.te', `-anaconda_t') } proc_kcore_t:file ~stat_file_perms;
+neverallow { domain -unrestricted } proc_kcore_t:file ~stat_file_perms;
 
 #
 # Verify that sysctl variables are only changeable
@@ -145,7 +145,7 @@
 # Verify that only the kernel and load_policy_t have load_policy.
 #
 
-neverallow { domain ifdef(`unrestricted_admin', `-admin') ifdef(`anaconda.te', `-anaconda_t') ifdef(`firstboot.te', `-firstboot_t') ifdef(`unconfined.te', `-unconfined_t') -kernel_t -load_policy_t } security_t:security load_policy;
+neverallow { domain -unrestricted -kernel_t -load_policy_t } security_t:security load_policy;
 
 #
 # for gross mistakes in policy
diff --exclude-from=exclude -N -u -r nsapolicy/attrib.te policy-1.17.3/attrib.te
--- nsapolicy/attrib.te	2004-07-08 14:27:26.000000000 -0400
+++ policy-1.17.3/attrib.te	2004-08-24 10:47:42.609521782 -0400
@@ -382,3 +382,7 @@
 # For serial devices
 #
 attribute serial_device;
+
+# Attribute to designate unrestricted access
+attribute unrestricted;
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/admin.te policy-1.17.3/domains/admin.te
--- nsapolicy/domains/admin.te	2004-07-12 13:51:16.000000000 -0400
+++ policy-1.17.3/domains/admin.te	2004-08-24 10:50:01.102289773 -0400
@@ -4,7 +4,7 @@
 
 # sysadm_t is the system administrator domain.
 type sysadm_t, domain, privlog, privowner, admin, userdomain, web_client_domain, privhome, etc_writer, privmodule
-ifdef(`unrestricted_admin', `,etc_writer, fs_domain, privmem, privlog, privowner, sysctl_kernel_writer, auth, auth_write')
+ifdef(`unrestricted_admin', `,etc_writer, fs_domain, privmem, privlog, privowner, sysctl_kernel_writer, auth, auth_write, unrestricted')
 ifdef(`direct_sysadm_daemon', `, priv_system_role')
 ; dnl end of sysadm_t type declaration
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.17.3/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2004-08-23 14:05:45.000000000 -0400
+++ policy-1.17.3/domains/program/initrc.te	2004-08-24 10:49:17.702376498 -0400
@@ -13,7 +13,7 @@
 #
 ifdef(`sendmail.te', `
 # do not use privmail for sendmail as it creates a type transition conflict
-type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, auth_write, ') domain, privlog, privowner, privmodule, sysctl_kernel_writer;
+type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, auth_write, unrestricted, ') domain, privlog, privowner, privmodule, sysctl_kernel_writer;
 allow system_mail_t initrc_t:fd use;
 allow system_mail_t initrc_t:fifo_file write;
 ', `
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/modutil.te policy-1.17.3/domains/program/modutil.te
--- nsapolicy/domains/program/modutil.te	2004-07-12 13:51:16.000000000 -0400
+++ policy-1.17.3/domains/program/modutil.te	2004-08-24 10:49:28.740082818 -0400
@@ -69,7 +69,7 @@
 # Rules for the insmod_t domain.
 #
 
-type insmod_t, domain, privlog, sysctl_kernel_writer ifdef(`unlimitedUtils', `, admin, etc_writer, fs_domain, privmem, auth_write, privowner, privmodule' )
+type insmod_t, domain, privlog, sysctl_kernel_writer ifdef(`unlimitedUtils', `, admin, etc_writer, fs_domain, privmem, auth_write, privowner, privmodule, unrestricted' )
 ;
 role system_r types insmod_t;
 role sysadm_r types insmod_t;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unconfined.te policy-1.17.3/domains/program/unconfined.te
--- nsapolicy/domains/program/unconfined.te	2004-06-16 13:37:32.000000000 -0400
+++ policy-1.17.3/domains/program/unconfined.te	2004-08-24 10:49:03.390053977 -0400
@@ -6,7 +6,7 @@
 # chcon -t unconfined_exec_t /usr/local/bin/appsrv
 # Or alternatively add it to /etc/security/selinux/src/policy/file_contexts/program/unconfined.fc
 
-type unconfined_t, domain, privlog, admin, privmem, fs_domain, auth_write;
+type unconfined_t, domain, privlog, admin, privmem, fs_domain, auth_write, unrestricted;
 type unconfined_exec_t, file_type, sysadmfile, exec_type;
 role sysadm_r types unconfined_t;
 domain_auto_trans(sysadm_t, unconfined_exec_t, unconfined_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/anaconda.te policy-1.17.3/domains/program/unused/anaconda.te
--- nsapolicy/domains/program/unused/anaconda.te	2004-08-22 20:55:01.000000000 -0400
+++ policy-1.17.3/domains/program/unused/anaconda.te	2004-08-24 11:26:49.959735795 -0400
@@ -10,7 +10,7 @@
 #
 # anaconda_t is the domain of the installation program
 #
-type anaconda_t, admin, etc_writer, fs_domain, privmem, auth_write, domain, privlog, privowner, privmodule, sysctl_kernel_writer;
+type anaconda_t, admin, etc_writer, fs_domain, privmem, auth_write, domain, privlog, privowner, privmodule, sysctl_kernel_writer, unrestricted;
 role system_r types anaconda_t;
 uses_shlib(anaconda_t);
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/firstboot.te policy-1.17.3/domains/program/unused/firstboot.te
--- nsapolicy/domains/program/unused/firstboot.te	2004-05-24 09:48:33.000000000 -0400
+++ policy-1.17.3/domains/program/unused/firstboot.te	2004-08-24 11:27:02.451300120 -0400
@@ -10,7 +10,7 @@
 #
 # firstboot_exec_t is the type of the firstboot executable.
 #
-application_domain(firstboot,`, admin, etc_writer, fs_domain, privmem, auth_write, privlog, privowner, privmodule, sysctl_kernel_writer')
+application_domain(firstboot,`, admin, etc_writer, fs_domain, privmem, auth_write, privlog, privowner, privmodule, sysctl_kernel_writer, unrestricted')
 type firstboot_rw_t, file_type, sysadmfile;
 role system_r types firstboot_t;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.17.3/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2004-08-18 08:42:50.000000000 -0400
+++ policy-1.17.3/domains/program/unused/hald.te	2004-08-24 10:46:58.252720504 -0400
@@ -13,7 +13,7 @@
 daemon_domain(hald, `, dbus_client_domain')
 
 allow hald_t etc_t:file { getattr read };
-allow hald_t self:unix_stream_socket create_stream_socket_perms;
+allow hald_t self:{ unix_dgram_socket unix_stream_socket } create_stream_socket_perms;
 
 allow hald_t dbusd_t:dbus { acquire_svc };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hotplug.te policy-1.17.3/domains/program/unused/hotplug.te
--- nsapolicy/domains/program/unused/hotplug.te	2004-08-22 20:55:01.000000000 -0400
+++ policy-1.17.3/domains/program/unused/hotplug.te	2004-08-24 10:48:28.965088742 -0400
@@ -11,7 +11,7 @@
 # hotplug_exec_t is the type of the hotplug executable.
 #
 ifdef(`unlimitedUtils', `
-daemon_domain(hotplug, `, admin, etc_writer, fs_domain, privmem, auth_write, privowner, privmodule, domain, privlog, sysctl_kernel_writer, dbus_client_domain')
+daemon_domain(hotplug, `, admin, etc_writer, fs_domain, privmem, auth_write, privowner, privmodule, domain, privlog, sysctl_kernel_writer, dbus_client_domain, unrestricted')
 ', `
 daemon_domain(hotplug, `, privmodule, dbus_client_domain')
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpm.te policy-1.17.3/domains/program/unused/rpm.te
--- nsapolicy/domains/program/unused/rpm.te	2004-08-22 20:55:02.000000000 -0400
+++ policy-1.17.3/domains/program/unused/rpm.te	2004-08-24 10:48:42.380516396 -0400
@@ -10,7 +10,7 @@
 # var_log_rpm_t is the type for rpm log files (/var/log/rpmpkgs*)
 # var_lib_rpm_t is the type for rpm files in /var/lib
 #
-type rpm_t, domain, admin, etc_writer, privlog, privowner, privmem, priv_system_role, fs_domain, privfd ifdef(`unlimitedRPM', `,auth_write');
+type rpm_t, domain, admin, etc_writer, privlog, privowner, privmem, priv_system_role, fs_domain, privfd ifdef(`unlimitedRPM', `,auth_write, unrestricted');
 role system_r types rpm_t;
 uses_shlib(rpm_t)
 type rpm_exec_t, file_type, sysadmfile, exec_type;
@@ -115,7 +115,7 @@
 
 allow { insmod_t depmod_t } rpm_t:fifo_file rw_file_perms;
 
-type rpm_script_t, domain, admin, etc_writer, privlog, privowner, privmodule, privmem, fs_domain, privfd, priv_system_role ifdef(`unlimitedRPM', `,auth_write');
+type rpm_script_t, domain, admin, etc_writer, privlog, privowner, privmodule, privmem, fs_domain, privfd, priv_system_role ifdef(`unlimitedRPM', `,auth_write, unrestricted');
 # policy for rpm scriptlet
 role system_r types rpm_script_t;
 uses_shlib(rpm_script_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.17.3/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2004-08-18 07:50:46.000000000 -0400
+++ policy-1.17.3/domains/program/unused/udev.te	2004-08-24 11:31:34.303264232 -0400
@@ -37,6 +37,8 @@
 allow udev_t { sbin_t bin_t }:lnk_file read;
 can_exec(udev_t, { shell_exec_t bin_t sbin_t } )
 can_exec(udev_t, udev_exec_t)
+can_exec(udev_t, hostname_exec_t)
+can_exec(udev_t, iptables_exec_t)
 r_dir_file(udev_t, sysfs_t)
 allow udev_t sysadm_tty_device_t:chr_file { read write };
 allow udev_t { device_t device_type }:{chr_file blk_file} { relabelfrom relabelto create_file_perms };
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.3/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-22 20:55:02.000000000 -0400
+++ policy-1.17.3/tunables/distro.tun	2004-08-24 10:46:58.253720387 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.3/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-08-02 15:14:25.000000000 -0400
+++ policy-1.17.3/tunables/tunable.tun	2004-08-24 10:46:58.254720270 -0400
@@ -5,40 +5,40 @@
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
+define(`use_games')
 
 # Allow ypbind to run with NIS
-dnl define(`allow_ypbind')
+define(`allow_ypbind')
 
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
 
 # Allow sysadm_t to do almost everything
 dnl define(`unrestricted_admin')
 
 # Allow the read/write/create on any NFS file system
-dnl define(`nfs_export_all_rw')
+define(`nfs_export_all_rw')
 
 # Allow users to unrestricted access
 dnl define(`unlimitedUsers')
@@ -48,7 +48,7 @@
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.

--------------080002060808090704050200--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

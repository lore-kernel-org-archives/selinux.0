From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux <SELinux@tycho.nsa.gov>
Subject: policy patches
Date: Wed, 29 Sep 2004 23:54:15 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_H6rWB15UO9TouUx"
Message-Id: <200409292354.15227.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_H6rWB15UO9TouUx
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I can't reproduce syslogd_t getting access to a kernel_t fd, so I removed the 
rules relating to that (I think it was a kernel bug that has since been 
fixed).

kudzu needs to execute /sbin/init to enable/disable serial console.

nash needs to read /dev/mapper/control (temporary thing, hopefully udev will 
take care of this soon).

Removed a redundant rule from postfix.te and some redundant rules from 
quota.te .

Added some extra rules to rpm.te for the most strict configuration and added 
sysadmfile to rpmbuild_exec_t.

Allow udev to execute more types to prepare for removing can_exec_any.

Added a new fc entry for cups so that hal can detect a new printer and add it.

kmodule is part of kudzu.

More name change stuff netsaint -> nagios.

Added start_udev to udev.fc.

Fixed home directory labelling for uml.

Added quagga entries to zebra.fc.  Maybe we should rename the policy from 
zebra to quagga too.

Added some ifdef(`targeted_policy' conditionals where needed.

Removed a reference to tmp_t:lnk_file, there should never be a tmp_t:lnk_file 
in the strict policy (and targetted has no mozilla policy).

Updated ssh_agent_macros.te with the latest stuff from Thomas Bleher.  Also 
gave him full credit (I don't recall doing anything significant with that 
file).

Allow ssh client to execute bash.  ssh client can use the shell to launch 
scripts and this can be defined in ~/.ssh/config .

Removed a reference to user_home_dir_t from xserver_macros.te.  Any time a 
policy has a reference to user_t, user_home_dir_t, etc it's a bug.

Removed a line giving xdm access to the NVIDIA device node.  xdm has no 
business with that, it's for the X server.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_H6rWB15UO9TouUx
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru /usr/src/se/policy/domains/program/initrc.te ./domains/program/initrc.te
--- /usr/src/se/policy/domains/program/initrc.te	2004-09-29 00:49:54.000000000 +1000
+++ ./domains/program/initrc.te	2004-09-26 02:48:05.000000000 +1000
@@ -219,7 +219,7 @@
 allow initrc_t var_lib_rpm_t:dir rw_dir_perms;
 allow initrc_t var_lib_rpm_t:file create_file_perms;
 ')
-')
+')dnl end distro_redhat
 
 allow initrc_t system_map_t:{ file lnk_file } r_file_perms;
 
diff -ru /usr/src/se/policy/domains/program/syslogd.te ./domains/program/syslogd.te
--- /usr/src/se/policy/domains/program/syslogd.te	2004-09-11 16:21:44.000000000 +1000
+++ ./domains/program/syslogd.te	2004-09-10 14:37:28.000000000 +1000
@@ -95,6 +95,3 @@
 #
 dontaudit syslogd_t file_t:dir search;
 allow syslogd_t devpts_t:dir { search };
-
-dontaudit syslogd_t kernel_t:fd use;
-dontaudit syslogd_t kernel_t:file read;
diff -ru /usr/src/se/policy/domains/program/unused/kudzu.te ./domains/program/unused/kudzu.te
--- /usr/src/se/policy/domains/program/unused/kudzu.te	2004-09-09 04:22:47.000000000 +1000
+++ ./domains/program/unused/kudzu.te	2004-09-21 17:22:19.000000000 +1000
@@ -50,7 +50,7 @@
 rw_dir_create_file(kudzu_t, etc_t)
 
 rw_dir_create_file(kudzu_t, mnt_t)
-can_exec(kudzu_t, { bin_t sbin_t })
+can_exec(kudzu_t, { bin_t sbin_t init_exec_t })
 # Read /usr/lib/gconv/gconv-modules.*
 allow kudzu_t lib_t:file { read getattr };
 # Read /usr/share/hwdata/.* and /usr/share/terminfo/l/linux
diff -ru /usr/src/se/policy/domains/program/unused/lvm.te ./domains/program/unused/lvm.te
--- /usr/src/se/policy/domains/program/unused/lvm.te	2004-09-23 22:31:17.000000000 +1000
+++ ./domains/program/unused/lvm.te	2004-09-24 20:36:26.000000000 +1000
@@ -110,7 +110,7 @@
 allow lvm_t sbin_t:dir search;
 dontaudit lvm_t sbin_t:file getattr;
 allow lvm_t lvm_control_t:chr_file rw_file_perms;
-allow initrc_t lvm_control_t:chr_file { getattr unlink };
+allow initrc_t lvm_control_t:chr_file { getattr read unlink };
 allow initrc_t device_t:chr_file create;
 dontaudit lvm_t var_run_t:dir getattr;
 
diff -ru /usr/src/se/policy/domains/program/unused/postfix.te ./domains/program/unused/postfix.te
--- /usr/src/se/policy/domains/program/unused/postfix.te	2004-09-23 22:31:17.000000000 +1000
+++ ./domains/program/unused/postfix.te	2004-09-23 23:18:20.000000000 +1000
@@ -100,7 +100,6 @@
 ')
 allow postfix_master_t sendmail_exec_t:file r_file_perms;
 allow postfix_master_t sbin_t:lnk_file { getattr read };
-domain_auto_trans(initrc_t, postfix_master_exec_t, postfix_master_t)
 ifdef(`pppd.te', `
 domain_auto_trans(pppd_t, postfix_master_exec_t, postfix_master_t)
 ')
diff -ru /usr/src/se/policy/domains/program/unused/quota.te ./domains/program/unused/quota.te
--- /usr/src/se/policy/domains/program/unused/quota.te	2004-09-23 22:31:17.000000000 +1000
+++ ./domains/program/unused/quota.te	2004-09-23 23:18:49.000000000 +1000
@@ -17,10 +17,6 @@
 role sysadm_r types quota_t;
 allow quota_t admin_tty_type:chr_file { read write };
 
-domain_auto_trans(sysadm_t, quota_exec_t, quota_t)
-role sysadm_r types quota_t;
-allow quota_t admin_tty_type:chr_file { read write };
-
 type quota_flag_t, file_type, sysadmfile;
 type quota_db_t, file_type, sysadmfile;
 
diff -ru /usr/src/se/policy/domains/program/unused/rpm.te ./domains/program/unused/rpm.te
--- /usr/src/se/policy/domains/program/unused/rpm.te	2004-09-21 14:39:14.000000000 +1000
+++ ./domains/program/unused/rpm.te	2004-09-29 01:05:44.000000000 +1000
@@ -16,9 +16,15 @@
 type rpm_exec_t, file_type, sysadmfile, exec_type;
 
 general_domain_access(rpm_t)
+can_ps(rpm_t, domain)
+allow rpm_t self:process setrlimit;
 system_crond_entry(rpm_exec_t, rpm_t)
 role sysadm_r types rpm_t;
 domain_auto_trans(sysadm_t, rpm_exec_t, rpm_t)
+ifdef(`unlimitedUsers', `
+role staff_r types rpm_t;
+domain_auto_trans(staff_t, rpm_exec_t, rpm_t)
+')
 
 type rpm_file_t, file_type, sysadmfile;
 
@@ -239,7 +245,7 @@
 allow rpm_t rpc_pipefs_t:dir search;
 allow rpm_script_t init_t:dir search;
 
-type rpmbuild_exec_t, file_type, exec_type;
+type rpmbuild_exec_t, file_type, sysadmfile, exec_type;
 type rpmbuild_t, domain;
 allow rpmbuild_t policy_config_t:dir { search };
 allow rpmbuild_t policy_src_t:dir { search };
diff -ru /usr/src/se/policy/domains/program/unused/udev.te ./domains/program/unused/udev.te
--- /usr/src/se/policy/domains/program/unused/udev.te	2004-09-29 00:50:00.000000000 +1000
+++ ./domains/program/unused/udev.te	2004-09-11 17:14:58.000000000 +1000
@@ -42,6 +42,8 @@
 allow udev_t { bin_t sbin_t }:dir r_dir_perms;
 allow udev_t { sbin_t bin_t }:lnk_file read;
 allow udev_t bin_t:lnk_file read;
+can_exec(udev_t, { shell_exec_t bin_t sbin_t etc_t } )
+can_exec(udev_t, udev_exec_t)
 r_dir_file(udev_t, sysfs_t)
 allow udev_t sysadm_tty_device_t:chr_file { read write };
 
diff -ru /usr/src/se/policy/file_contexts/program/cups.fc ./file_contexts/program/cups.fc
--- /usr/src/se/policy/file_contexts/program/cups.fc	2004-08-19 17:10:38.000000000 +1000
+++ ./file_contexts/program/cups.fc	2004-09-24 01:44:14.000000000 +1000
@@ -18,6 +18,7 @@
 /usr/lib(64)?/cups/backend/.* --	system_u:object_r:cupsd_exec_t
 /usr/lib(64)?/cups/daemon/.*	 --	system_u:object_r:cupsd_exec_t
 /usr/sbin/cupsd		--	system_u:object_r:cupsd_exec_t
+/usr/bin/cups-config-daemon --	system_u:object_r:cupsd_exec_t
 /usr/sbin/printconf-backend --	system_u:object_r:cupsd_exec_t
 /var/log/cups(/.*)?		system_u:object_r:cupsd_log_t
 /var/spool/cups(/.*)?		system_u:object_r:print_spool_t
diff -ru /usr/src/se/policy/file_contexts/program/kudzu.fc ./file_contexts/program/kudzu.fc
--- /usr/src/se/policy/file_contexts/program/kudzu.fc	2003-11-27 05:04:46.000000000 +1100
+++ ./file_contexts/program/kudzu.fc	2004-09-26 05:24:38.000000000 +1000
@@ -1,2 +1,3 @@
 # kudzu
 /usr/sbin/kudzu	--	system_u:object_r:kudzu_exec_t
+/sbin/kmodule	--	system_u:object_r:kudzu_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/nagios.fc ./file_contexts/program/nagios.fc
--- /usr/src/se/policy/file_contexts/program/nagios.fc	2004-06-17 03:38:16.000000000 +1000
+++ ./file_contexts/program/nagios.fc	2004-09-24 20:44:24.000000000 +1000
@@ -1,7 +1,10 @@
-# netsaint - network monitoring server
-/usr/sbin/netsaint		--	system_u:object_r:nagios_exec_t
-#/var/run/netsaint(/.*)?		system_u:object_r:nagios_var_run_t
-/etc/netsaint(/.*)?			system_u:object_r:nagios_etc_t
+# nagios - network monitoring server
 /var/log/netsaint(/.*)?			system_u:object_r:nagios_log_t
 /usr/lib(64)?/netsaint/plugins(/.*)?		system_u:object_r:bin_t
 /usr/lib(64)?/cgi-bin/netsaint/.+	--	system_u:object_r:nagios_cgi_exec_t
+# nagios
+/usr/bin/nagios			--	system_u:object_r:nagios_exec_t
+/etc/nagios(/.*)?			system_u:object_r:nagios_etc_t
+/var/log/nagios(/.*)?			system_u:object_r:nagios_log_t
+/usr/lib(64)?/nagios/plugins(/.*)?	system_u:object_r:bin_t
+/usr/lib(64)?/nagios/cgi/.+	--	system_u:object_r:nagios_cgi_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/udev.fc ./file_contexts/program/udev.fc
--- /usr/src/se/policy/file_contexts/program/udev.fc	2004-09-01 10:52:39.000000000 +1000
+++ ./file_contexts/program/udev.fc	2004-09-24 03:38:36.000000000 +1000
@@ -2,6 +2,7 @@
 /sbin/udevsend	--	system_u:object_r:udev_exec_t
 /sbin/udev	--	system_u:object_r:udev_exec_t
 /sbin/udevd	--	system_u:object_r:udev_exec_t
+/sbin/start_udev --	system_u:object_r:udev_exec_t
 /usr/bin/udevinfo --	system_u:object_r:udev_exec_t
 /etc/dev\.d/.+	--	system_u:object_r:udev_helper_exec_t
 /etc/udev/scripts/.+	-- system_u:object_r:udev_helper_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/uml.fc ./file_contexts/program/uml.fc
--- /usr/src/se/policy/file_contexts/program/uml.fc	2004-03-04 07:53:52.000000000 +1100
+++ ./file_contexts/program/uml.fc	2004-09-24 20:43:58.000000000 +1000
@@ -1,4 +1,4 @@
 # User Mode Linux
 /usr/bin/uml_switch	--	system_u:object_r:uml_switch_exec_t
 /var/run/uml-utilities(/.*)?	system_u:object_r:uml_switch_var_run_t
-/home/[^/]+/.uml(/.*)?		system_u:object_r:user_uml_rw_t
+HOME_DIR/\.uml(/.*)?		system_u:object_r:ROLE_uml_rw_t
diff -ru /usr/src/se/policy/file_contexts/program/zebra.fc ./file_contexts/program/zebra.fc
--- /usr/src/se/policy/file_contexts/program/zebra.fc	2004-08-19 17:10:45.000000000 +1000
+++ ./file_contexts/program/zebra.fc	2004-09-24 20:43:58.000000000 +1000
@@ -5,3 +5,9 @@
 /etc/zebra(/.*)?		system_u:object_r:zebra_conf_t
 /var/run/.zserv		-s	system_u:object_r:zebra_var_run_t
 /var/run/.zebra		-s	system_u:object_r:zebra_var_run_t
+# Quagga
+/usr/sbin/rip.*  	--	system_u:object_r:zebra_exec_t
+/usr/sbin/ospf.*  	--	system_u:object_r:zebra_exec_t
+/etc/quagga(/.*)?		system_u:object_r:zebra_conf_t
+/var/log/quagga(/.*)?		system_u:object_r:zebra_log_t
+/var/run/quagga(/.*)?		system_u:object_r:zebra_var_run_t
diff -ru /usr/src/se/policy/macros/admin_macros.te ./macros/admin_macros.te
--- /usr/src/se/policy/macros/admin_macros.te	2004-09-24 06:31:34.000000000 +1000
+++ ./macros/admin_macros.te	2004-09-24 20:38:03.000000000 +1000
@@ -77,6 +77,10 @@
 allow $1_t sysadmfile:lnk_file create_lnk_perms;
 allow $1_t sysadmfile:dir create_dir_perms;
 
+# for lsof
+allow $1_t mtrr_device_t:file getattr;
+allow $1_t fs_type:dir getattr;
+
 # Set an exec context, e.g. for runcon.
 can_setexec($1_t)
 
diff -ru /usr/src/se/policy/macros/program/chkpwd_macros.te ./macros/program/chkpwd_macros.te
--- /usr/src/se/policy/macros/program/chkpwd_macros.te	2004-09-11 16:21:48.000000000 +1000
+++ ./macros/program/chkpwd_macros.te	2004-09-29 01:15:19.000000000 +1000
@@ -51,7 +51,9 @@
 allow $1_chkpwd_t etc_t:file { getattr read };
 allow $1_chkpwd_t self:unix_dgram_socket create_socket_perms;
 allow $1_chkpwd_t self:unix_stream_socket create_socket_perms;
+ifdef(`targeted_policy', `
 allow $1_chkpwd_t tty_device_t:chr_file { read write };
+')
 read_locale($1_chkpwd_t)
 
 # Use capabilities.
diff -ru /usr/src/se/policy/macros/program/mozilla_macros.te ./macros/program/mozilla_macros.te
--- /usr/src/se/policy/macros/program/mozilla_macros.te	2004-09-29 00:50:10.000000000 +1000
+++ ./macros/program/mozilla_macros.te	2004-09-16 21:47:34.000000000 +1000
@@ -71,8 +71,6 @@
 allow $1_lpr_t $1_mozilla_rw_t:file rw_file_perms;
 ')
 
-dontaudit $1_mozilla_t tmp_t:lnk_file read;
-
 #
 # This is another place where I sould like to allow system customization.
 # We need to allow the admin to select whether then want to allow mozilla
diff -ru /usr/src/se/policy/macros/program/ssh_agent_macros.te ./macros/program/ssh_agent_macros.te
--- /usr/src/se/policy/macros/program/ssh_agent_macros.te	2004-09-21 14:39:17.000000000 +1000
+++ ./macros/program/ssh_agent_macros.te	2004-09-12 14:50:44.000000000 +1000
@@ -3,8 +3,7 @@
 #
 
 #
-# Authors:  Russell Coker <russell@coker.com.au>,
-#           Thomas Bleher <ThomasBleher@gmx.de>
+# Author:  Thomas Bleher <ThomasBleher@gmx.de>
 #
 
 # 
@@ -70,7 +69,10 @@
 can_unix_connect($1_t, $1_ssh_agent_t)
 
 # transition back to normal privs upon exec
-domain_auto_trans($1_ssh_agent_t, { bin_t shell_exec_t $1_home_t ifdef(`nfs_home_dirs', `nfs_t')}, $1_t)
+domain_auto_trans($1_ssh_agent_t, { bin_t shell_exec_t $1_home_t }, $1_t)
+ifdef(`nfs_home_dirs', `
+domain_auto_trans($1_ssh_agent_t, nfs_t, $1_t)
+')
 allow $1_ssh_agent_t bin_t:dir search;
 
 # allow reading of /usr/bin/X11 (is a symlink)
diff -ru /usr/src/se/policy/macros/program/ssh_macros.te ./macros/program/ssh_macros.te
--- /usr/src/se/policy/macros/program/ssh_macros.te	2004-09-21 14:39:17.000000000 +1000
+++ ./macros/program/ssh_macros.te	2004-09-12 17:18:07.000000000 +1000
@@ -118,6 +118,7 @@
 # for /bin/sh used to execute xauth
 dontaudit $1_ssh_t proc_t:dir search;
 dontaudit $1_ssh_t proc_t:file { getattr read };
+can_exec($1_ssh_t, shell_exec_t)
 
 # Inherit and use descriptors from gnome-pty-helper.
 ifdef(`gnome-pty-helper.te', `allow $1_ssh_t $1_gph_t:fd use;')
diff -ru /usr/src/se/policy/macros/program/xserver_macros.te ./macros/program/xserver_macros.te
--- /usr/src/se/policy/macros/program/xserver_macros.te	2004-09-21 14:39:17.000000000 +1000
+++ ./macros/program/xserver_macros.te	2004-09-24 01:49:01.000000000 +1000
@@ -64,7 +64,6 @@
 
 allow xdm_xserver_t init_t:fd use;
 
-dontaudit xdm_xserver_t user_home_dir_t:dir { read search };
 dontaudit xdm_xserver_t sysadm_home_dir_t:dir { read search };
 ', `
 # The user role is authorized for this domain.
@@ -162,7 +161,6 @@
 ifdef(`xdm.te', `
 allow $1_t xdm_tmp_t:sock_file { unlink };
 allow $1_xserver_t xdm_var_run_t:dir { search };
-allow xdm_t xserver_misc_device_t:chr_file { getattr };
 # for /tmp/.ICE-unix
 file_type_auto_trans($1_t, xdm_xserver_tmp_t, $1_tmp_t, sock_file)
 ')

--Boundary-00=_H6rWB15UO9TouUx--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Message-ID: <36282A1733C57546BE392885C0618592D39D43@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>,
   "Daniel J Walsh (E-mail)"
	 <dwalsh@redhat.com>
Cc: "Stephen Smalley (E-mail)" <sds@epoch.ncsc.mil>,
   Darrel Goeddel
	 <DGoeddel@TrustedCS.com>
Subject: [PATCH] MLS Support
Date: Thu, 20 Oct 2005 18:05:25 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C5D5C2.5FBB2880"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C5D5C2.5FBB2880
Content-Type: text/plain;
	charset="iso-8859-1"


The attached patch is relative to selinux-policy-mls-1.27.1-21, and fixes
the following issues:

-daemons restarted by sysadm will run with the correct MLS range
-the auditd will run at the highest MLS level
-the audit log files will be stored at the highest MLS level
-various device files are now at the highest MLS level
-the policy sources and file contexts configuration are now stored at the
  highest MLS level
-added MLS attributes for several domains

Note: After applying this patch, an admin will need to newrole -l
s15:c0.c255 (SystemHigh)to view the audit log and make changes to the
SELinux policy.

Otherwise, other actions can continue to be performed at s0.

-Chad

 <<mls_level.patch>> 

------_=_NextPart_000_01C5D5C2.5FBB2880
Content-Type: application/octet-stream;
	name="mls_level.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mls_level.patch"

diff -Nur policy-1.27.1.orig/domains/admin.te =
policy-1.27.1/domains/admin.te=0A=
--- policy-1.27.1.orig/domains/admin.te	2005-09-16 15:17:27.000000000 =
+0000=0A=
+++ policy-1.27.1/domains/admin.te	2005-10-20 14:22:03.000000000 =
+0000=0A=
@@ -4,7 +4,7 @@=0A=
 =0A=
 # sysadm_t is the system administrator domain.=0A=
 type sysadm_t, domain, privlog, privowner, admin, userdomain, =
web_client_domain, privhome, etc_writer, privmodule, =
nscd_client_domain=0A=
-ifdef(`direct_sysadm_daemon', `, priv_system_role')=0A=
+ifdef(`direct_sysadm_daemon', `, priv_system_role, privrangetrans')=0A=
 ; dnl end of sysadm_t type declaration=0A=
 =0A=
 allow privhome home_root_t:dir { getattr search };=0A=
diff -Nur policy-1.27.1.orig/domains/program/auditd.te =
policy-1.27.1/domains/program/auditd.te=0A=
--- policy-1.27.1.orig/domains/program/auditd.te	2005-10-20 =
14:09:56.000000000 +0000=0A=
+++ policy-1.27.1/domains/program/auditd.te	2005-10-20 =
14:22:03.000000000 +0000=0A=
@@ -12,6 +12,12 @@=0A=
 =0A=
 daemon_domain(auditd)=0A=
 =0A=
+ifdef(`mls_policy', `=0A=
+# run at the highest MLS level=0A=
+typeattribute auditd_t mlsrangetrans;=0A=
+range_transition initrc_t auditd_exec_t s15:c0.c255;=0A=
+')=0A=
+=0A=
 allow auditd_t self:netlink_audit_socket { create_netlink_socket_perms =
nlmsg_relay nlmsg_readpriv };=0A=
 allow auditd_t self:unix_dgram_socket create_socket_perms;=0A=
 allow auditd_t self:capability { audit_write audit_control sys_nice =
sys_resource };=0A=
diff -Nur policy-1.27.1.orig/domains/program/fsadm.te =
policy-1.27.1/domains/program/fsadm.te=0A=
--- policy-1.27.1.orig/domains/program/fsadm.te	2005-10-20 =
14:09:56.000000000 +0000=0A=
+++ policy-1.27.1/domains/program/fsadm.te	2005-10-20 =
14:54:48.981565914 +0000=0A=
@@ -12,7 +12,7 @@=0A=
 # administration.=0A=
 # fsadm_exec_t is the type of the corresponding programs.=0A=
 #=0A=
-type fsadm_t, domain, privlog, fs_domain, mlsfileread;=0A=
+type fsadm_t, domain, privlog, fs_domain, mlsfileread, =
mlsfilewrite;=0A=
 role system_r types fsadm_t;=0A=
 role sysadm_r types fsadm_t;=0A=
 =0A=
diff -Nur policy-1.27.1.orig/domains/program/initrc.te =
policy-1.27.1/domains/program/initrc.te=0A=
--- policy-1.27.1.orig/domains/program/initrc.te	2005-10-20 =
14:09:56.000000000 +0000=0A=
+++ policy-1.27.1/domains/program/initrc.te	2005-10-20 =
14:58:24.145993997 +0000=0A=
@@ -12,7 +12,7 @@=0A=
 # initrc_exec_t is the type of the init program.=0A=
 #=0A=
 # do not use privmail for sendmail as it creates a type transition =
conflict=0A=
-type initrc_t, fs_domain, ifdef(`unlimitedRC', `admin, etc_writer, =
privmem, auth_write, ') domain, privlog, privowner, privmodule, =
ifdef(`sendmail.te', `', `privmail,') ifdef(`distro_debian', =
`etc_writer, ') sysctl_kernel_writer, nscd_client_domain, mlsfileread, =
mlsfilewrite, mlsprocread, mlsprocwrite;=0A=
+type initrc_t, fs_domain, ifdef(`unlimitedRC', `admin, etc_writer, =
privmem, auth_write, ') domain, privlog, privowner, privmodule, =
ifdef(`sendmail.te', `', `privmail,') ifdef(`distro_debian', =
`etc_writer, ') sysctl_kernel_writer, nscd_client_domain, mlsfileread, =
mlsfilewrite, mlsprocread, mlsprocwrite, privrangetrans;=0A=
 =0A=
 role system_r types initrc_t;=0A=
 uses_shlib(initrc_t);=0A=
@@ -283,6 +283,10 @@=0A=
 ifdef(`direct_sysadm_daemon', `=0A=
 role_transition sysadm_r initrc_exec_t system_r;=0A=
 domain_auto_trans(sysadm_t, initrc_exec_t, initrc_t)=0A=
+ifdef(`mls_policy', `=0A=
+typeattribute initrc_t mlsrangetrans;=0A=
+range_transition sysadm_t initrc_exec_t s0 - s15:c0.c255;=0A=
+')=0A=
 ')=0A=
 =0A=
 #=0A=
diff -Nur policy-1.27.1.orig/domains/program/init.te =
policy-1.27.1/domains/program/init.te=0A=
--- policy-1.27.1.orig/domains/program/init.te	2005-09-16 =
15:17:27.000000000 +0000=0A=
+++ policy-1.27.1/domains/program/init.te	2005-10-20 14:55:57.035667413 =
+0000=0A=
@@ -14,7 +14,7 @@=0A=
 # by init during initialization.  This pipe is used=0A=
 # to communicate with init.=0A=
 #=0A=
-type init_t, domain, privlog, sysctl_kernel_writer, =
nscd_client_domain, mlsrangetrans, mlsfileread, mlsfilewrite;=0A=
+type init_t, domain, privlog, sysctl_kernel_writer, =
nscd_client_domain, mlsrangetrans, mlsfileread, mlsfilewrite, =
mlsprocwrite;=0A=
 role system_r types init_t;=0A=
 uses_shlib(init_t);=0A=
 type init_exec_t, file_type, sysadmfile, exec_type;=0A=
diff -Nur policy-1.27.1.orig/domains/program/logrotate.te =
policy-1.27.1/domains/program/logrotate.te=0A=
--- policy-1.27.1.orig/domains/program/logrotate.te	2005-09-16 =
15:17:27.000000000 +0000=0A=
+++ policy-1.27.1/domains/program/logrotate.te	2005-10-20 =
14:59:39.066307231 +0000=0A=
@@ -13,7 +13,7 @@=0A=
 # logrotate_t is the domain for the logrotate program.=0A=
 # logrotate_exec_t is the type of the corresponding program.=0A=
 #=0A=
-type logrotate_t, domain, privowner, privmail, priv_system_role, =
nscd_client_domain;=0A=
+type logrotate_t, domain, privowner, privmail, priv_system_role, =
nscd_client_domain, mlsfileread, mlsfilewrite, mlsfileupgrade;=0A=
 role system_r types logrotate_t;=0A=
 role sysadm_r types logrotate_t;=0A=
 uses_shlib(logrotate_t)=0A=
diff -Nur policy-1.27.1.orig/domains/program/pamconsole.te =
policy-1.27.1/domains/program/pamconsole.te=0A=
--- policy-1.27.1.orig/domains/program/pamconsole.te	2005-10-20 =
14:09:56.000000000 +0000=0A=
+++ policy-1.27.1/domains/program/pamconsole.te	2005-10-20 =
15:01:35.608723374 +0000=0A=
@@ -3,7 +3,7 @@=0A=
 #=0A=
 # pam_console_apply=0A=
 =0A=
-daemon_base_domain(pam_console, `, nscd_client_domain, =
mlsfileread')=0A=
+daemon_base_domain(pam_console, `, nscd_client_domain, mlsfileread, =
mlsfilewrite')=0A=
 =0A=
 type pam_var_console_t, file_type, sysadmfile;=0A=
 =0A=
diff -Nur policy-1.27.1.orig/domains/program/rpm.te =
policy-1.27.1/domains/program/rpm.te=0A=
--- policy-1.27.1.orig/domains/program/rpm.te	2005-09-16 =
15:17:27.000000000 +0000=0A=
+++ policy-1.27.1/domains/program/rpm.te	2005-10-20 15:04:03.548918390 =
+0000=0A=
@@ -10,7 +10,7 @@=0A=
 # rpm_log_t is the type for rpm log files (/var/log/rpmpkgs*)=0A=
 # rpm_var_lib_t is the type for rpm files in /var/lib=0A=
 #=0A=
-type rpm_t, domain, admin, etc_writer, privlog, privowner, privmem, =
priv_system_role, fs_domain, privfd;=0A=
+type rpm_t, domain, admin, etc_writer, privlog, privowner, privmem, =
priv_system_role, fs_domain, privfd, mlsfileread, mlsfilewrite, =
mlsfileupgrade;=0A=
 role system_r types rpm_t;=0A=
 uses_shlib(rpm_t)=0A=
 type rpm_exec_t, file_type, sysadmfile, exec_type;=0A=
@@ -114,7 +114,7 @@=0A=
 =0A=
 allow { insmod_t depmod_t } rpm_t:fifo_file rw_file_perms;=0A=
 =0A=
-type rpm_script_t, domain, admin, etc_writer, privlog, privowner, =
privmodule, privmem, fs_domain, privfd, privrole, priv_system_role;=0A=
+type rpm_script_t, domain, admin, etc_writer, privlog, privowner, =
privmodule, privmem, fs_domain, privfd, privrole, priv_system_role, =
mlsfileread, mlsfilewrite;=0A=
 # policy for rpm scriptlet=0A=
 role system_r types rpm_script_t;=0A=
 uses_shlib(rpm_script_t)=0A=
diff -Nur policy-1.27.1.orig/domains/program/tmpreaper.te =
policy-1.27.1/domains/program/tmpreaper.te=0A=
--- policy-1.27.1.orig/domains/program/tmpreaper.te	2005-09-16 =
15:17:27.000000000 +0000=0A=
+++ policy-1.27.1/domains/program/tmpreaper.te	2005-10-20 =
15:05:05.840585101 +0000=0A=
@@ -8,7 +8,7 @@=0A=
 #=0A=
 # Rules for the tmpreaper_t domain.=0A=
 #=0A=
-type tmpreaper_t, domain, privlog;=0A=
+type tmpreaper_t, domain, privlog, mlsfileread, mlsfilewrite;=0A=
 type tmpreaper_exec_t, file_type, sysadmfile, exec_type;=0A=
 =0A=
 role system_r types tmpreaper_t;=0A=
diff -Nur policy-1.27.1.orig/file_contexts/program/auditd.fc =
policy-1.27.1/file_contexts/program/auditd.fc=0A=
--- policy-1.27.1.orig/file_contexts/program/auditd.fc	2005-10-20 =
14:09:57.000000000 +0000=0A=
+++ policy-1.27.1/file_contexts/program/auditd.fc	2005-10-20 =
14:22:03.000000000 +0000=0A=
@@ -1,8 +1,8 @@=0A=
 # auditd=0A=
 /sbin/auditctl		--	system_u:object_r:auditctl_exec_t:s0=0A=
 /sbin/auditd		--	system_u:object_r:auditd_exec_t:s0=0A=
-/var/log/audit.log 	-- 	system_u:object_r:auditd_log_t:s0=0A=
-/var/log/audit(/.*)?  	 	system_u:object_r:auditd_log_t:s0=0A=
+/var/log/audit.log 	-- 	system_u:object_r:auditd_log_t:s15:c0.c255=0A=
+/var/log/audit(/.*)?  	 	system_u:object_r:auditd_log_t:s15:c0.c255=0A=
 /etc/auditd.conf	--	system_u:object_r:auditd_etc_t:s0=0A=
 /etc/audit.rules	--	system_u:object_r:auditd_etc_t:s0=0A=
 =0A=
diff -Nur policy-1.27.1.orig/file_contexts/types.fc =
policy-1.27.1/file_contexts/types.fc=0A=
--- policy-1.27.1.orig/file_contexts/types.fc	2005-10-20 =
14:09:59.000000000 +0000=0A=
+++ policy-1.27.1/file_contexts/types.fc	2005-10-20 14:22:03.000000000 =
+0000=0A=
@@ -124,7 +124,7 @@=0A=
 /dev/zero		-c	system_u:object_r:zero_device_t:s0=0A=
 /dev/console		-c	system_u:object_r:console_device_t:s0=0A=
 /dev/xconsole		-p	system_u:object_r:xconsole_device_t:s0=0A=
-/dev/(kmem|mem|port)	-c	system_u:object_r:memory_device_t:s0=0A=
+/dev/(kmem|mem|port)	-c	=
system_u:object_r:memory_device_t:s15:c0.c255=0A=
 /dev/nvram		-c	system_u:object_r:memory_device_t:s0=0A=
 /dev/random		-c	system_u:object_r:random_device_t:s0=0A=
 /dev/urandom		-c	system_u:object_r:urandom_device_t:s0=0A=
@@ -149,31 +149,31 @@=0A=
 /dev/usb/lp.*		-c	system_u:object_r:printer_device_t:s0=0A=
 /dev/usblp.*		-c	system_u:object_r:printer_device_t:s0=0A=
 ifdef(`distro_redhat', `=0A=
-/dev/root		-b	system_u:object_r:fixed_disk_device_t:s0=0A=
+/dev/root		-b	system_u:object_r:fixed_disk_device_t:s15:c0.c255=0A=
 ')=0A=
-/dev/[shmx]d[^/]*	-b	system_u:object_r:fixed_disk_device_t:s0=0A=
-/dev/dm-[0-9]+	-b	system_u:object_r:fixed_disk_device_t:s0=0A=
+/dev/[shmx]d[^/]*	-b	=
system_u:object_r:fixed_disk_device_t:s15:c0.c255=0A=
+/dev/dm-[0-9]+	-b	system_u:object_r:fixed_disk_device_t:s15:c0.c255=0A=
 /dev/sg[0-9]+		-c	system_u:object_r:scsi_generic_device_t:s0=0A=
-/dev/rd.*		-b	system_u:object_r:fixed_disk_device_t:s0=0A=
-/dev/i2o/hd[^/]*	-b	system_u:object_r:fixed_disk_device_t:s0=0A=
-/dev/ubd[^/]*		-b	system_u:object_r:fixed_disk_device_t:s0=0A=
-/dev/cciss/[^/]*	-b	system_u:object_r:fixed_disk_device_t:s0=0A=
-/dev/mapper/.*		-b	system_u:object_r:fixed_disk_device_t:s0=0A=
-/dev/ida/[^/]*	-b	system_u:object_r:fixed_disk_device_t:s0=0A=
-/dev/dasd[^/]*	-b	system_u:object_r:fixed_disk_device_t:s0=0A=
-/dev/flash[^/]*	-b	system_u:object_r:fixed_disk_device_t:s0=0A=
-/dev/nb[^/]+		-b	system_u:object_r:fixed_disk_device_t:s0=0A=
-/dev/ataraid/.*	-b	system_u:object_r:fixed_disk_device_t:s0=0A=
-/dev/loop.*		-b	system_u:object_r:fixed_disk_device_t:s0=0A=
+/dev/rd.*		-b	system_u:object_r:fixed_disk_device_t:s15:c0.c255=0A=
+/dev/i2o/hd[^/]*	-b	=
system_u:object_r:fixed_disk_device_t:s15:c0.c255=0A=
+/dev/ubd[^/]*		-b	system_u:object_r:fixed_disk_device_t:s15:c0.c255=0A=
+/dev/cciss/[^/]*	-b	=
system_u:object_r:fixed_disk_device_t:s15:c0.c255=0A=
+/dev/mapper/.*		-b	=
system_u:object_r:fixed_disk_device_t:s15:c0.c255=0A=
+/dev/ida/[^/]*	-b	system_u:object_r:fixed_disk_device_t:s15:c0.c255=0A=
+/dev/dasd[^/]*	-b	system_u:object_r:fixed_disk_device_t:s15:c0.c255=0A=
+/dev/flash[^/]*	-b	=
system_u:object_r:fixed_disk_device_t:s15:c0.c255=0A=
+/dev/nb[^/]+		-b	system_u:object_r:fixed_disk_device_t:s15:c0.c255=0A=
+/dev/ataraid/.*	-b	=
system_u:object_r:fixed_disk_device_t:s15:c0.c255=0A=
+/dev/loop.*		-b	system_u:object_r:fixed_disk_device_t:s15:c0.c255=0A=
 /dev/net/.*		-c	system_u:object_r:tun_tap_device_t:s0=0A=
-/dev/ram.*		-b	system_u:object_r:fixed_disk_device_t:s0=0A=
-/dev/rawctl		-c	system_u:object_r:fixed_disk_device_t:s0=0A=
-/dev/raw/raw[0-9]+	-c	system_u:object_r:fixed_disk_device_t:s0=0A=
-/dev/scramdisk/.*	-b	system_u:object_r:fixed_disk_device_t:s0=0A=
-/dev/initrd		-b	system_u:object_r:fixed_disk_device_t:s0=0A=
-/dev/jsfd		-b	system_u:object_r:fixed_disk_device_t:s0=0A=
+/dev/ram.*		-b	system_u:object_r:fixed_disk_device_t:s15:c0.c255=0A=
+/dev/rawctl		-c	system_u:object_r:fixed_disk_device_t:s15:c0.c255=0A=
+/dev/raw/raw[0-9]+	-c	=
system_u:object_r:fixed_disk_device_t:s15:c0.c255=0A=
+/dev/scramdisk/.*	-b	=
system_u:object_r:fixed_disk_device_t:s15:c0.c255=0A=
+/dev/initrd		-b	system_u:object_r:fixed_disk_device_t:s15:c0.c255=0A=
+/dev/jsfd		-b	system_u:object_r:fixed_disk_device_t:s15:c0.c255=0A=
 /dev/js.*		-c	system_u:object_r:mouse_device_t:s0=0A=
-/dev/jsflash		-c	system_u:object_r:fixed_disk_device_t:s0=0A=
+/dev/jsflash		-c	system_u:object_r:fixed_disk_device_t:s15:c0.c255=0A=
 /dev/s(cd|r)[^/]*	-b	system_u:object_r:removable_device_t:s0=0A=
 /dev/usb/rio500	-c	system_u:object_r:removable_device_t:s0=0A=
 /dev/fd[^/]+		-b	system_u:object_r:removable_device_t:s0=0A=
@@ -306,10 +306,11 @@=0A=
 /etc/resolv\.conf.*	--	system_u:object_r:net_conf_t:s0=0A=
 =0A=
 /etc/selinux(/.*)?		system_u:object_r:selinux_config_t:s0=0A=
-/etc/selinux/([^/]*/)?policy(/.*)?	=
system_u:object_r:policy_config_t:s0=0A=
-/etc/selinux/([^/]*/)?src(/.*)?	system_u:object_r:policy_src_t:s0=0A=
+/etc/selinux/([^/]*/)?users(/.*)?	=
system_u:object_r:selinux_config_t:s15:c0.c255=0A=
+/etc/selinux/([^/]*/)?policy(/.*)?	=
system_u:object_r:policy_config_t:s15:c0.c255=0A=
+/etc/selinux/([^/]*/)?src(/.*)?	=
system_u:object_r:policy_src_t:s15:c0.c255=0A=
 /etc/selinux/([^/]*/)?contexts(/.*)?	=
system_u:object_r:default_context_t:s0=0A=
-/etc/selinux/([^/]*/)?contexts/files(/.*)? =
system_u:object_r:file_context_t:s0=0A=
+/etc/selinux/([^/]*/)?contexts/files(/.*)? =
system_u:object_r:file_context_t:s15:c0.c255=0A=
 =0A=
 =0A=
 #=0A=

------_=_NextPart_000_01C5D5C2.5FBB2880--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

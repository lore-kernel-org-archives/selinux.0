Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7T7bPrT028834
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 03:37:25 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7T7bKis025861
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 07:37:21 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com, "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Re: Progress! .532 boots! -- but dbus/hotplug/udev problems remain?
Date: Sun, 29 Aug 2004 17:37:17 +1000
Cc: Tom London <selinux@comcast.net>
References: <4130CF1B.3090909@comcast.net>
In-Reply-To: <4130CF1B.3090909@comcast.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_teYMB4zJOFGC3+f"
Message-Id: <200408291737.17497.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_teYMB4zJOFGC3+f
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun, 29 Aug 2004 04:29, Tom London <selinux@comcast.net> wrote:
> Newest Rawhide updates (including udev-030-10, mkinitrd-4.1.8-1,
> kernel-2.6.8-1.532, and selinux-policy-strict-1.17.5-2)
> now boots in strict/enforcing.

I've attached a diff against the CVS policy as well as the .te and .fc files 
for udev changes which fix this and address some other issues as well.

Please try it out and let me know how it goes.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_teYMB4zJOFGC3+f
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="udev.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="udev.diff"

--- /usr/src/se/policy/domains/program/unused/udev.te	2004-08-28 12:05:05.000000000 +1000
+++ domains/program/unused/udev.te	2004-08-29 17:32:55.000000000 +1000
@@ -16,7 +16,6 @@
 etc_domain(udev)
 typealias udev_etc_t alias etc_udev_t;
 type udev_helper_exec_t, file_type, sysadmfile, exec_type;
-r_dir_file(udev_t, udev_helper_exec_t)
 can_exec(udev_t, udev_helper_exec_t)
 
 #
@@ -32,19 +31,20 @@
 allow udev_t device_t:blk_file create_file_perms;
 allow udev_t device_t:chr_file create_file_perms;
 allow udev_t device_t:sock_file create_file_perms;
-allow udev_t etc_t:file { getattr read execute };
+allow udev_t device_t:lnk_file create_lnk_perms;
+allow udev_t etc_t:file { getattr read };
 allow udev_t { bin_t sbin_t }:dir r_dir_perms;
 allow udev_t { sbin_t bin_t }:lnk_file read;
-can_exec(udev_t, { shell_exec_t bin_t sbin_t } )
+allow udev_t bin_t:lnk_file read;
+can_exec(udev_t, { shell_exec_t bin_t sbin_t etc_t } )
 can_exec(udev_t, udev_exec_t)
-can_exec(udev_t, hostname_exec_t)
-can_exec(udev_t, iptables_exec_t)
 r_dir_file(udev_t, sysfs_t)
 allow udev_t sysadm_tty_device_t:chr_file { read write };
 allow udev_t { device_t device_type }:{chr_file blk_file} { relabelfrom relabelto create_file_perms };
 	
-# to read the file_contexts file?
-r_dir_file(udev_t, policy_config_t)
+# to read the file_contexts file
+allow udev_t { selinux_config_t default_context_t }:dir search;
+allow udev_t default_context_t:file { getattr read };
 
 allow udev_t policy_config_t:dir { search };
 allow udev_t proc_t:file { read };
@@ -52,6 +52,9 @@
 # Get security policy decisions.
 can_getsecurity(udev_t)
 
+# set file system create context
+can_setfscreate(udev_t)
+
 allow udev_t kernel_t:fd { use };
 allow udev_t kernel_t:unix_dgram_socket { sendto ioctl read write };
 
@@ -61,7 +64,9 @@
 domain_auto_trans(initrc_t, udev_exec_t, udev_t)
 domain_auto_trans(kernel_t, udev_exec_t, udev_t)
 domain_auto_trans(udev_t, restorecon_exec_t, restorecon_t)
-allow restorecon_t udev_t:unix_dgram_socket { read write };
+ifdef(`hide_broken_symptoms', `
+dontaudit restorecon_t udev_t:unix_dgram_socket { read write };
+')
 allow udev_t devpts_t:dir { search };
 allow udev_t etc_runtime_t:file { getattr read };
 allow udev_t etc_t:file { ioctl };
@@ -79,12 +84,11 @@
 can_exec(udev_t, consoletype_exec_t)
 ')
 domain_auto_trans(udev_t, ifconfig_exec_t, ifconfig_t)
-allow ifconfig_t udev_t:unix_dgram_socket { read write };
+ifdef(`hide_broken_symptoms', `
+dontaudit ifconfig_t udev_t:unix_dgram_socket { read write };
+')
 
 dontaudit udev_t file_t:dir search;
-allow udev_t device_t:lnk_file create_file_perms;
-allow udev_t var_lock_t:dir { search };
-allow udev_t var_lock_t:file { getattr read };
 ifdef(`dhcpc.te', `
 domain_auto_trans(udev_t, dhcpc_exec_t, dhcpc_t)
 ')
--- /usr/src/se/policy/file_contexts/program/udev.fc	2004-08-28 12:05:11.000000000 +1000
+++ file_contexts/program/udev.fc	2004-08-29 17:26:29.000000000 +1000
@@ -3,7 +3,8 @@
 /sbin/udev	--	system_u:object_r:udev_exec_t
 /sbin/udevd	--	system_u:object_r:udev_exec_t
 /usr/bin/udevinfo --	system_u:object_r:udev_exec_t
-/etc/dev\.d(/.*)? 	system_u:object_r:udev_helper_exec_t
-/etc/hotplug.d/default/udev.* system_u:object_r:udev_helper_exec_t
+/etc/dev\.d/.+	--	system_u:object_r:udev_helper_exec_t
+/etc/udev/scripts/.+	-- system_u:object_r:udev_helper_exec_t
+/etc/hotplug.d/default/udev.* -- system_u:object_r:udev_helper_exec_t
 /dev/udev\.tbl	--	system_u:object_r:udev_tbl_t
 /dev/\.udev\.tdb --	system_u:object_r:udev_tbl_t

--Boundary-00=_teYMB4zJOFGC3+f
Content-Type: text/plain;
  charset="iso-8859-1";
  name="udev.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="udev.te"

#DESC udev - Linux configurable dynamic device naming support
#
# Author:  Dan Walsh dwalsh@redhat.com
#

#################################
#
# Rules for the udev_t domain.
#
# udev_exec_t is the type of the udev executable.
#
daemon_domain(udev, `, privmodule, privmem, fs_domain, privfd, dbus_client_domain')

general_domain_access(udev_t)

etc_domain(udev)
typealias udev_etc_t alias etc_udev_t;
type udev_helper_exec_t, file_type, sysadmfile, exec_type;
can_exec(udev_t, udev_helper_exec_t)

#
# Rules used for udev
#
type udev_tbl_t, file_type, sysadmfile;
file_type_auto_trans(udev_t, device_t, udev_tbl_t, file)
allow udev_t self:capability { chown dac_override dac_read_search fowner fsetid sys_admin mknod };
allow udev_t self:file { getattr read };
allow udev_t self:unix_stream_socket {connectto create_stream_socket_perms};
allow udev_t self:unix_dgram_socket create_socket_perms;
allow udev_t self:fifo_file rw_file_perms;
allow udev_t device_t:blk_file create_file_perms;
allow udev_t device_t:chr_file create_file_perms;
allow udev_t device_t:sock_file create_file_perms;
allow udev_t device_t:lnk_file create_lnk_perms;
allow udev_t etc_t:file { getattr read };
allow udev_t { bin_t sbin_t }:dir r_dir_perms;
allow udev_t { sbin_t bin_t }:lnk_file read;
allow udev_t bin_t:lnk_file read;
can_exec(udev_t, { shell_exec_t bin_t sbin_t etc_t } )
can_exec(udev_t, udev_exec_t)
r_dir_file(udev_t, sysfs_t)
allow udev_t sysadm_tty_device_t:chr_file { read write };
allow udev_t { device_t device_type }:{chr_file blk_file} { relabelfrom relabelto create_file_perms };
	
# to read the file_contexts file
allow udev_t { selinux_config_t default_context_t }:dir search;
allow udev_t default_context_t:file { getattr read };

allow udev_t policy_config_t:dir { search };
allow udev_t proc_t:file { read };

# Get security policy decisions.
can_getsecurity(udev_t)

# set file system create context
can_setfscreate(udev_t)

allow udev_t kernel_t:fd { use };
allow udev_t kernel_t:unix_dgram_socket { sendto ioctl read write };

allow udev_t initrc_var_run_t:file r_file_perms;
dontaudit udev_t initrc_var_run_t:file write;

domain_auto_trans(initrc_t, udev_exec_t, udev_t)
domain_auto_trans(kernel_t, udev_exec_t, udev_t)
domain_auto_trans(udev_t, restorecon_exec_t, restorecon_t)
ifdef(`hide_broken_symptoms', `
dontaudit restorecon_t udev_t:unix_dgram_socket { read write };
')
allow udev_t devpts_t:dir { search };
allow udev_t etc_runtime_t:file { getattr read };
allow udev_t etc_t:file { ioctl };
allow udev_t proc_t:file { getattr };
ifdef(`xdm.te', `
allow udev_t xdm_var_run_t:file { getattr read };
')

ifdef(`hotplug.te', `
r_dir_file(udev_t, hotplug_etc_t)
')
allow udev_t var_log_t:dir { search };

ifdef(`consoletype.te', `
can_exec(udev_t, consoletype_exec_t)
')
domain_auto_trans(udev_t, ifconfig_exec_t, ifconfig_t)
ifdef(`hide_broken_symptoms', `
dontaudit ifconfig_t udev_t:unix_dgram_socket { read write };
')

dontaudit udev_t file_t:dir search;
ifdef(`dhcpc.te', `
domain_auto_trans(udev_t, dhcpc_exec_t, dhcpc_t)
')

--Boundary-00=_teYMB4zJOFGC3+f
Content-Type: text/plain;
  charset="iso-8859-1";
  name="udev.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="udev.fc"

# udev
/sbin/udevsend	--	system_u:object_r:udev_exec_t
/sbin/udev	--	system_u:object_r:udev_exec_t
/sbin/udevd	--	system_u:object_r:udev_exec_t
/usr/bin/udevinfo --	system_u:object_r:udev_exec_t
/etc/dev\.d/.+	--	system_u:object_r:udev_helper_exec_t
/etc/udev/scripts/.+	-- system_u:object_r:udev_helper_exec_t
/etc/hotplug.d/default/udev.* -- system_u:object_r:udev_helper_exec_t
/dev/udev\.tbl	--	system_u:object_r:udev_tbl_t
/dev/\.udev\.tdb --	system_u:object_r:udev_tbl_t

--Boundary-00=_teYMB4zJOFGC3+f--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

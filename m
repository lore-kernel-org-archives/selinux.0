Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j36MZdDo022000
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 18:35:39 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j36MXEkY010938
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 22:33:14 GMT
Subject: Re: More patches
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <42544387.6010706@redhat.com>
References: <200502032350.40924.russell@coker.com.au>
	 <1108048794.10328.14.camel@moss-lions.epoch.ncsc.mil>
	 <4253CD52.1090206@redhat.com>
	 <1112790317.4187.1.camel@moss-lions.epoch.ncsc.mil>
	 <4253D7BA.6030604@redhat.com> <1112810151.7822.4.camel@cobra.ivg2.net>
	 <42542F02.2020304@redhat.com> <1112811239.3469.4.camel@cobra.ivg2.net>
	 <42543BBD.4090308@redhat.com> <1112814718.3817.6.camel@cobra.ivg2.net>
	 <42544387.6010706@redhat.com>
Content-Type: multipart/mixed; boundary="=-88L4VE+8o8uznvleDQMs"
Date: Wed, 06 Apr 2005 17:39:09 -0400
Message-Id: <1112823549.20840.4.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-88L4VE+8o8uznvleDQMs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> BTW have you done anything with dmidecode?

Now attached - small domain for dmidecode that allows
it to read /dev/mem and gives it rawio privileges.

Patch for hal to transition to this domain, 
as well as bringing back the netlink rule for backwards compatibility.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-88L4VE+8o8uznvleDQMs
Content-Disposition: attachment; filename=hal_dmidecode.diff
Content-Type: text/x-patch; name=hal_dmidecode.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -aru policy.old/domains/program/hald.te policy/domains/program/hald.te
--- policy.old/domains/program/hald.te	2005-04-06 17:23:59.000000000 -0400
+++ policy/domains/program/hald.te	2005-04-06 17:30:22.000000000 -0400
@@ -29,8 +29,11 @@
 allow hald_t { bin_t sbin_t }:dir search;
 allow hald_t self:fifo_file rw_file_perms;
 allow hald_t usr_t:file { getattr read };
-
 allow hald_t bin_t:file getattr;
+
+# For backwards compatibility with older kernels
+allow hald_t self:netlink_socket create_socket_perms;
+
 allow hald_t self:netlink_kobject_uevent_socket create_socket_perms;
 allow hald_t self:netlink_route_socket r_netlink_socket_perms;
 allow hald_t self:capability { net_admin sys_admin dac_override dac_read_search mknod };
@@ -77,17 +80,14 @@
 allow hald_t mnt_t:dir search;
 r_dir_file(hald_t, proc_net_t)
 
-
-# For /usr/libxexc/hald-addon-acpi - writes to /var/run/acpid.socket
+# For /usr/libexec/hald-addon-acpi - writes to /var/run/acpid.socket
 ifdef(`apmd.te', `
 allow hald_t apmd_var_run_t:sock_file write;
 allow hald_t apmd_t:unix_stream_socket connectto;
 ')
 
-# For /usr/sbin/dmidecode
-# Violates assertion
-#allow hald_t memory_device_t:chr_file read;
-allow hald_t self:capability sys_rawio;
+# For /usr/libexec/hald-probe-smbios
+domain_auto_trans(hald_t, dmidecode_exec_t, dmidecode_t)
 
 # ??
 ifdef(`lvm.te', `

--=-88L4VE+8o8uznvleDQMs
Content-Disposition: attachment; filename=dmidecode.fc
Content-Type: text/plain; name=dmidecode.fc; charset=utf-8
Content-Transfer-Encoding: 7bit

# dmidecode 
/usr/sbin/dmidecode	--	   	system_u:object_r:dmidecode_exec_t
/usr/sbin/ownership	--		system_u:object_r:dmidecode_exec_t
/usr/sbin/vpddecode	--		system_u:object_r:dmidecode_exec_t

--=-88L4VE+8o8uznvleDQMs
Content-Disposition: attachment; filename=dmidecode.te
Content-Type: text/plain; name=dmidecode.te; charset=utf-8
Content-Transfer-Encoding: 7bit

#DESC dmidecode - decodes DMI data for x86/ia64 bioses 
#
# Author: Ivan Gyurdiev <ivg2@cornell.edu>
#

type dmidecode_t, domain, privmem;
type dmidecode_exec_t, file_type, exec_type, sysadmfile;

# Allow execution by the sysadm
role sysadm_r types dmidecode_t;
role system_r types dmidecode_t;
domain_auto_trans(sysadm_t, dmidecode_exec_t, dmidecode_t)

uses_shlib(dmidecode_t)

# Allow terminal access
access_terminal(dmidecode_t, sysadm)

# Allow dmidecode to read /dev/mem
allow dmidecode_t memory_device_t:chr_file read;

allow dmidecode_t self:capability sys_rawio;

--=-88L4VE+8o8uznvleDQMs--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

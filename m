Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAJDfBIi020362
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 08:41:11 -0500 (EST)
Received: from passage.avira.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAJDfAlF003170
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 13:41:12 GMT
Message-ID: <419DF805.80002@gentoo.org>
Date: Fri, 19 Nov 2004 15:41:25 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: SELinux <selinux@tycho.nsa.gov>, Chris PeBenito <pebenito@gentoo.org>
Subject: Re: gentoo diff for snmpd
References: <4198D752.2020405@gentoo.org> <1100808061.26930.18.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1100808061.26930.18.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig91C22DF200866834D4375593"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig91C22DF200866834D4375593
Content-Type: multipart/mixed;
 boundary="------------090003010509050202090300"

This is a multi-part message in MIME format.
--------------090003010509050202090300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi James,

James Carter wrote:
> Merged.
> 
> Oops, there is no proc_net_t defined.
> Petre, could you send me the proc_net_t stuff as well.

please see the attachment.

> On Mon, 2004-11-15 at 11:20, petre rodan wrote:
> 
>>Hi,
>>
>>gentoo as a special context for /proc/net:
>>genfscon proc /net  system_u:object_r:proc_net_t
>>
>>so a small diff is needed for the snmpd policy. attached.

bye,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------090003010509050202090300
Content-Type: text/plain;
 name="proc_net_t.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc_net_t.diff"

Index: policy/genfs_contexts
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/genfs_contexts,v
retrieving revision 1.16
diff -u -B -r1.16 genfs_contexts
--- policy/genfs_contexts	8 Oct 2004 17:56:47 -0000	1.16
+++ policy/genfs_contexts	19 Nov 2004 13:31:04 -0000
@@ -36,6 +36,7 @@
 genfscon proc /kcore			system_u:object_r:proc_kcore_t
 genfscon proc /mdstat			system_u:object_r:proc_mdstat_t
 genfscon proc /mtrr			system_u:object_r:mtrr_device_t
+genfscon proc /net			system_u:object_r:proc_net_t
 genfscon proc /sysvipc			system_u:object_r:proc_t
 genfscon proc /sys			system_u:object_r:sysctl_t
 genfscon proc /sys/kernel		system_u:object_r:sysctl_kernel_t
Index: policy/domains/program/ifconfig.te
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/domains/program/ifconfig.te,v
retrieving revision 1.9
diff -u -B -r1.9 ifconfig.te
--- policy/domains/program/ifconfig.te	10 Sep 2004 14:45:48 -0000	1.9
+++ policy/domains/program/ifconfig.te	19 Nov 2004 13:31:04 -0000
@@ -38,8 +38,8 @@
 allow ifconfig_t { kernel_t init_t }:fd use;
 
 # Access /proc
-allow ifconfig_t proc_t:dir r_dir_perms;
-allow ifconfig_t proc_t:file r_file_perms;
+allow ifconfig_t { proc_t proc_net_t }:dir r_dir_perms;
+allow ifconfig_t { proc_t proc_net_t }:file r_file_perms;
 
 allow ifconfig_t privfd:fd use;
 allow ifconfig_t run_init_t:fd use;
Index: policy/domains/program/unused/iptables.te
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/domains/program/unused/iptables.te,v
retrieving revision 1.13
diff -u -B -r1.13 iptables.te
--- policy/domains/program/unused/iptables.te	8 Nov 2004 20:57:04 -0000	1.13
+++ policy/domains/program/unused/iptables.te	19 Nov 2004 13:31:04 -0000
@@ -54,6 +54,8 @@
 ifdef(`gnome-pty-helper.te', `allow iptables_t sysadm_gph_t:fd use;')
 
 allow iptables_t proc_t:file { getattr read };
+allow iptables_t proc_net_t:dir { search };
+allow iptables_t proc_net_t:file { read getattr };
 
 # system-config-network appends to /var/log
 allow iptables_t var_log_t:file append;
Index: policy/domains/program/unused/rpcd.te
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/domains/program/unused/rpcd.te,v
retrieving revision 1.26
diff -u -B -r1.26 rpcd.te
--- policy/domains/program/unused/rpcd.te	8 Nov 2004 20:57:04 -0000	1.26
+++ policy/domains/program/unused/rpcd.te	19 Nov 2004 13:31:04 -0000
@@ -71,6 +71,7 @@
 
 # for /proc/fs/nfs/exports - should we have a new type?
 allow nfsd_t proc_t:file r_file_perms;
+allow nfsd_t proc_net_t:dir search;
 allow nfsd_t exports_t:file { getattr read };
 
 allow nfsd_t nfsd_fs_t:filesystem mount;
Index: policy/macros/global_macros.te
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/macros/global_macros.te,v
retrieving revision 1.46
diff -u -B -r1.46 global_macros.te
--- policy/macros/global_macros.te	17 Nov 2004 19:51:54 -0000	1.46
+++ policy/macros/global_macros.te	19 Nov 2004 13:31:05 -0000
@@ -214,6 +214,8 @@
 # Read system information files in /proc.
 allow $1 proc_t:dir r_dir_perms;
 allow $1 proc_t:notdevfile_class_set r_file_perms;
+allow $1 proc_net_t:dir r_dir_perms;
+allow $1 proc_net_t:file r_file_perms;
 allow $1 proc_mdstat_t:file r_file_perms;
 
 # Stat /proc/kmsg and /proc/kcore.
Index: policy/macros/program/vmware_macros.te
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/macros/program/vmware_macros.te,v
retrieving revision 1.3
diff -u -B -r1.3 vmware_macros.te
--- policy/macros/program/vmware_macros.te	17 Nov 2004 19:51:55 -0000	1.3
+++ policy/macros/program/vmware_macros.te	19 Nov 2004 13:31:05 -0000
@@ -55,6 +55,8 @@
 
 # Access /proc
 r_dir_file($1_vmware_t, proc_t)
+allow $1_vmware_t proc_net_t:dir search;
+allow $1_vmware_t proc_net_t:file { getattr read };
 
 # Access to some files in the user home directory
 r_dir_file($1_vmware_t, $1_home_t)
Index: policy/types/procfs.te
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/types/procfs.te,v
retrieving revision 1.7
diff -u -B -r1.7 procfs.te
--- policy/types/procfs.te	22 Sep 2004 20:19:14 -0000	1.7
+++ policy/types/procfs.te	19 Nov 2004 13:31:05 -0000
@@ -17,6 +17,7 @@
 type proc_kmsg_t, proc_fs;
 type proc_kcore_t, proc_fs;
 type proc_mdstat_t, proc_fs;
+type proc_net_t, proc_fs;
 
 #
 # sysctl_t is the type of /proc/sys.

--------------090003010509050202090300--

--------------enig91C22DF200866834D4375593
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBnfgJGSBEIeh4AEYRAgPgAJsErnYvqALASe2Nfv6czIFHEfG13QCeLyXc
VDQbY+CxYRCY1xVUdBVui/Y=
=rSKx
-----END PGP SIGNATURE-----

--------------enig91C22DF200866834D4375593--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

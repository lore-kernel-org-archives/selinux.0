Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1PCcfwq005379
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 07:38:42 -0500
Received: from vidle.i.cz (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1PCcaa4022211
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 12:38:37 GMT
Date: Mon, 25 Feb 2008 13:38:30 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: refpolicy: patch rpc
Message-ID: <20080225123830.GA31035@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
following denials appears during startup of rpc.statd (nfs-common
service) on Debian Sid:

Feb 22 23:27:45 sid kernel: audit(1203719264.336:3): avc:  denied  { search } for  pid=1482 comm="rpc.statd" name="sbin" dev=sda1 ino=245761 scontext=system_u:system_r:rpcd_t:s0 tcontext=system_u:object_r:bin_t:s0 tclass=dir
Feb 22 23:27:45 sid kernel: audit(1203719264.336:4): avc:  denied  { execute } for  pid=1482 comm="rpc.statd" name="sm-notify" dev=sda1 ino=376910 scontext=system_u:system_r:rpcd_t:s0 tcontext=system_u:object_r:bin_t:s0 tclass=file
Feb 22 23:27:45 sid kernel: audit(1203719264.336:5): avc:  denied  { execute_no_trans } for  pid=1482 comm="rpc.statd" name="sm-notify" dev=sda1 ino=376910 scontext=system_u:system_r:rpcd_t:s0 tcontext=system_u:object_r:bin_t:s0 tclass=file
Feb 22 23:27:45 sid kernel: audit(1203719264.336:6): avc:  denied  { read } for  pid=1482 comm="rpc.statd" name="sm-notify" dev=sda1 ino=376910 scontext=system_u:system_r:rpcd_t:s0 tcontext=system_u:object_r:bin_t:s0 tclass=file
Feb 22 23:27:45 sid kernel: audit(1203719264.724:7): avc:  denied  { search } for  pid=1482 comm="sm-notify" name="fs" dev=proc ino=-268435429 scontext=system_u:system_r:rpcd_t:s0 tcontext=system_u:object_r:sysctl_fs_t:s0 tclass=dir

Added patch is taken from Fedora policy...
Thanks
-- 
Zito

--ZGiS0Q5IWpPtfppv
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="rpc.patch"

Index: policy/modules/services/rpc.te
===================================================================
--- policy/modules/services/rpc.te	(revision 2624)
+++ policy/modules/services/rpc.te	(working copy)
@@ -60,10 +60,13 @@
 manage_files_pattern(rpcd_t,rpcd_var_run_t,rpcd_var_run_t)
 files_pid_filetrans(rpcd_t,rpcd_var_run_t,file)
 
+corecmd_exec_bin(rpcd_t)
+
 kernel_read_system_state(rpcd_t) 
 kernel_search_network_state(rpcd_t) 
 # for rpc.rquotad
 kernel_read_sysctl(rpcd_t)  
+kernel_rw_fs_sysctls(rpcd_t)
 
 fs_list_rpc(rpcd_t)
 fs_read_rpc_files(rpcd_t)

--ZGiS0Q5IWpPtfppv--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

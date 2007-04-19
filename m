Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3JEinZa025107
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 10:44:49 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3JEimUG017201
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 14:44:49 GMT
Message-ID: <46278057.6000608@redhat.com>
Date: Thu, 19 Apr 2007 10:44:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: modutils policy patch
Content-Type: multipart/mixed;
 boundary="------------010404070506090807070607"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010404070506090807070607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

insmod needs to be able to mount kvmfs for kvm.

insmod executes init scripts when inserting and removing certain modules.

Any gui tool that is launched via userhelper can trigger a 
unconfined_rw_pipe including ones that insert modules.



--------------010404070506090807070607
Content-Type: text/x-patch;
 name="modutils.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modutils.patch"

--- nsaserefpolicy/policy/modules/system/modutils.te	2007-04-11 15:52:54.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/system/modutils.te	2007-04-17 15:50:53.000000000 -0400
@@ -58,6 +58,7 @@
 kernel_read_system_state(insmod_t)
 kernel_write_proc_files(insmod_t)
 kernel_mount_debugfs(insmod_t)
+kernel_mount_kvmfs(insmod_t)
 kernel_read_debugfs(insmod_t)
 # Rules for /proc/sys/kernel/tainted
 kernel_read_kernel_sysctls(insmod_t)
@@ -101,6 +102,7 @@
 init_use_fds(insmod_t)
 init_use_script_fds(insmod_t)
 init_use_script_ptys(insmod_t)
+init_spec_domtrans_script(insmod_t)
 
 libs_use_ld_so(insmod_t)
 libs_use_shared_libs(insmod_t)
@@ -163,6 +165,10 @@
 	xserver_getattr_log(insmod_t)
 ')
 
+optional_policy(`
+	unconfined_dontaudit_rw_pipes(insmod_t)
+')
+
 ########################################
 #
 # depmod local policy
--- nsaserefpolicy/policy/modules/kernel/kernel.if	2007-02-19 11:32:51.000000000 -0500
+++ serefpolicy-2.5.12/policy/modules/kernel/kernel.if	2007-04-17 15:50:55.000000000 -0400
@@ -2408,3 +2425,22 @@
 
 	typeattribute $1 kern_unconfined;
 ')
+
+########################################
+## <summary>
+##	Mount a kernel vm filesystem.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the domain mounting the filesystem.
+##	</summary>
+## </param>
+#
+interface(`kernel_mount_kvmfs',`
+	gen_require(`
+		type kvmfs_t;
+	')
+
+	allow $1 kvmfs_t:filesystem mount;
+')
+

--------------010404070506090807070607--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBDMG1MA002342
	for <selinux@tycho.nsa.gov>; Tue, 13 Dec 2005 17:16:01 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBDM7NN7025394
	for <selinux@tycho.nsa.gov>; Tue, 13 Dec 2005 22:07:23 GMT
Message-ID: <439F4626.4000408@redhat.com>
Date: Tue, 13 Dec 2005 17:07:34 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Latest Diffs
Content-Type: multipart/mixed;
 boundary="------------000400030000060805010508"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000400030000060805010508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Certain applications linked with rpmlibes call the rpm_script_t so 
unconfined_t needs to transition.

rpmbuild policy should be dropped.


-- 



--------------000400030000060805010508
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/Makefile serefpolicy-2.1.5/Makefile
--- nsaserefpolicy/Makefile	2005-12-09 23:35:04.000000000 -0500
+++ serefpolicy-2.1.5/Makefile	2005-12-13 17:02:23.000000000 -0500
@@ -92,7 +92,7 @@
 
 # enable MLS if requested.
 ifneq ($(findstring -mls,$(TYPE)),)
-	override M4PARAM += -D enable_mls
+	override M4PARAM += -D enable_mls -D separate_secadm
 	override CHECKPOLICY += -M
 	override CHECKMODULE += -M
 endif
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/rpm.if serefpolicy-2.1.5/policy/modules/admin/rpm.if
--- nsaserefpolicy/policy/modules/admin/rpm.if	2005-12-02 17:53:26.000000000 -0500
+++ serefpolicy-2.1.5/policy/modules/admin/rpm.if	2005-12-13 17:02:23.000000000 -0500
@@ -28,6 +28,31 @@
 
 ########################################
 ## <summary>
+##	Execute rpm_script programs in the rpm_script domain.
+## </summary>
+## <param name="domain">
+##	The type of the process performing this action.
+## </param>
+#
+interface(`rpm_script_domtrans',`
+	gen_require(`
+		type rpm_exec_t;
+		class process sigchld;
+		class fd use;
+		class fifo_file rw_file_perms;
+	')
+
+	# transition to rpm script:
+	corecmd_shell_domtrans($1,rpm_script_t)
+
+	allow $1 rpm_script_t:fd use;
+	allow rpm_script_t $1:fd use;
+	allow rpm_script_t $1:fifo_file rw_file_perms;
+	allow rpm_script_t $1:process sigchld;
+')
+
+########################################
+## <summary>
 ##	Execute RPM programs in the RPM domain.
 ## </summary>
 ## <param name="domain">
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/rpm.te serefpolicy-2.1.5/policy/modules/admin/rpm.te
--- nsaserefpolicy/policy/modules/admin/rpm.te	2005-12-09 23:35:04.000000000 -0500
+++ serefpolicy-2.1.5/policy/modules/admin/rpm.te	2005-12-13 17:02:23.000000000 -0500
@@ -47,12 +47,6 @@
 type rpm_script_tmpfs_t;
 files_tmpfs_file(rpm_script_tmpfs_t)
 
-type rpmbuild_t;
-domain_type(rpmbuild_t)
-
-type rpmbuild_exec_t;
-domain_entry_file(rpmbuild_t,rpmbuild_exec_t)
-
 ########################################
 #
 # rpm Local policy
@@ -140,7 +134,7 @@
 corecmd_exec_bin(rpm_t)
 corecmd_exec_sbin(rpm_t)
 # transition to rpm script:
-corecmd_shell_domtrans(rpm_t,rpm_script_t)
+rpm_script_domtrans(rpm_t)
 
 domain_exec_all_entry_files(rpm_t)
 domain_read_all_domains_state(rpm_t)
@@ -369,19 +363,6 @@
 # rpm-build Local policy
 #
 
-# cjp: this looks like dead policy.  nothing
-# can transition to this domain, nor can it
-# really do anything useful.
-
-selinux_get_fs_mount(rpmbuild_t)
-selinux_validate_context(rpmbuild_t)
-selinux_compute_access_vector(rpmbuild_t)
-selinux_compute_create_context(rpmbuild_t)
-selinux_compute_relabel_context(rpmbuild_t)
-selinux_compute_user_contexts(rpmbuild_t)
-
-seutil_read_src_pol(rpmbuild_t)
-
 ifdef(`TODO',`
 
 optional_policy(`cups',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/mls.te serefpolicy-2.1.5/policy/modules/kernel/mls.te
--- nsaserefpolicy/policy/modules/kernel/mls.te	2005-12-13 15:51:49.000000000 -0500
+++ serefpolicy-2.1.5/policy/modules/kernel/mls.te	2005-12-13 17:02:23.000000000 -0500
@@ -79,6 +79,7 @@
 # these might be targeted_policy only
 range_transition unconfined_t su_exec_t s0 - s0:c0.c255;
 range_transition unconfined_t initrc_exec_t s0;
+range_transition unconfined_t ping_exec_t s0;
 ')
 
 ifdef(`enable_mls',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/nis.if serefpolicy-2.1.5/policy/modules/services/nis.if
--- nsaserefpolicy/policy/modules/services/nis.if	2005-12-06 19:49:50.000000000 -0500
+++ serefpolicy-2.1.5/policy/modules/services/nis.if	2005-12-13 17:04:12.000000000 -0500
@@ -217,11 +217,11 @@
 #
 interface(`nis_read_ypbind_pid',`
 	gen_require(`
-		type ypbind_t;
+		type ypbind_var_run_t;
 	')
 
 	files_search_pids($1)
-	allow $1 ypbind_t:file r_file_perms;
+	allow $1 ypbind_var_run_t:file r_file_perms;
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.fc serefpolicy-2.1.5/policy/modules/system/libraries.fc
--- nsaserefpolicy/policy/modules/system/libraries.fc	2005-12-12 15:35:53.000000000 -0500
+++ serefpolicy-2.1.5/policy/modules/system/libraries.fc	2005-12-13 17:02:23.000000000 -0500
@@ -113,6 +113,7 @@
 /usr/lib(64)?/.*/program/libsvx680li\.so --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/.*/program/libcomphelp4gcc3\.so -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/.*/program/libsoffice\.so  --	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr(/.*)?/pcsc/drivers(/.*)?/libcm(2020|4000|SCR24x)\.so(\.[^/]*)*  		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/firefox.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/mozilla.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/sunbird.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.te serefpolicy-2.1.5/policy/modules/system/unconfined.te
--- nsaserefpolicy/policy/modules/system/unconfined.te	2005-12-13 15:51:50.000000000 -0500
+++ serefpolicy-2.1.5/policy/modules/system/unconfined.te	2005-12-13 17:02:23.000000000 -0500
@@ -118,6 +118,7 @@
 
 	optional_policy(`rpm',`
 		rpm_domtrans(unconfined_t)
+		rpm_script_domtrans(unconfined_t)
 	')
 
 	optional_policy(`samba',`

--------------000400030000060805010508--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBF1mJsm016616
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:48:19 -0500
Received: from e6.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBF1mq9T012825
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 01:48:52 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBF1nJAn031995
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:49:19 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kBF1mpXn289134
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:48:51 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kBF1mpSH022756
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:48:51 -0500
Date: Thu, 14 Dec 2006 19:35:00 -0600
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200612150135.kBF1Z0bC002707@faith.austin.ibm.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/7] labeled ipsec policy changes
Cc: cpebenito@tresys.com
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add interfaces for association:polmatch and
association:setcontext permission.

Signed-off-by: Joy Latten <latten@austin.ibm.com>

 kernel/domain.if |   18 ++++++++++++++++++
 system/ipsec.if  |   18 ++++++++++++++++++
 system/ipsec.te  |    3 +++
 3 files changed, 39 insertions(+)
--------------------------------------------------------------

diff -urpN serefpolicy-2.4.6/policy/modules/kernel/domain.if serefpolicy-2.4.6.patchbox1/policy/modules/kernel/domain.if
--- serefpolicy-2.4.6/policy/modules/kernel/domain.if	2006-11-29 11:04:51.000000000 -0600
+++ serefpolicy-2.4.6.patchbox1/policy/modules/kernel/domain.if	2006-12-14 12:14:11.000000000 -0600
@@ -1276,3 +1276,21 @@ template(`domain_auto_trans',`
 	domain_trans($1,$2,$3)
 	type_transition $1 $2:process $3;
 ')
+
+########################################
+## <summary>
+##	Allow specified type to set context on domain attribute.
+## </summary>
+## <param name="type">
+##	<summary>
+##	Type of subject to be allowed this.
+##	</summary>
+## </param>
+#
+interface(`domain_setcontext',`
+	gen_require(`
+		attribute domain;
+	')
+
+	allow $1 domain:association setcontext;
+')
diff -urpN serefpolicy-2.4.6/policy/modules/system/ipsec.if serefpolicy-2.4.6.patchbox1/policy/modules/system/ipsec.if
--- serefpolicy-2.4.6/policy/modules/system/ipsec.if	2006-11-29 11:04:51.000000000 -0600
+++ serefpolicy-2.4.6.patchbox1/policy/modules/system/ipsec.if	2006-12-14 12:02:48.000000000 -0600
@@ -119,3 +119,21 @@ interface(`ipsec_manage_pid',`
 	allow $1 ipsec_var_run_t:dir rw_dir_perms;
 	allow $1 ipsec_var_run_t:file create_file_perms;
 ')
+
+########################################
+## <summary>
+##	Allow an IPsec SA to be used by an IPsec Policy.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`ipsec_label_sa_pol',`
+	gen_require(`
+		type ipsec_spd_t;
+	')
+
+	allow $1 ipsec_spd_t:association polmatch;
+')
diff -urpN serefpolicy-2.4.6/policy/modules/system/ipsec.te serefpolicy-2.4.6.patchbox1/policy/modules/system/ipsec.te
--- serefpolicy-2.4.6/policy/modules/system/ipsec.te	2006-11-29 11:04:51.000000000 -0600
+++ serefpolicy-2.4.6.patchbox1/policy/modules/system/ipsec.te	2006-12-14 11:50:31.000000000 -0600
@@ -35,6 +35,9 @@ files_lock_file(ipsec_mgmt_lock_t)
 type ipsec_mgmt_var_run_t;
 files_pid_file(ipsec_mgmt_var_run_t)
 
+# default type for ipsec-tools ipsec policy
+type ipsec_spd_t;
+
 ########################################
 #
 # ipsec Local policy




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

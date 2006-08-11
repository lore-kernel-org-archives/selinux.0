Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7BDYNj1003493
	for <selinux@tycho.nsa.gov>; Fri, 11 Aug 2006 09:34:23 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k7BDY57f019161
	for <selinux@tycho.nsa.gov>; Fri, 11 Aug 2006 13:34:05 GMT
Subject: [PATCH 2/3] Separate local file contexts into file_contexts.local
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 09:34:28 -0400
Message-Id: <1155303268.8722.63.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch stops libsemanage from merging local file contexts into the
main file contexts provided by the policy, and then will copy the local
file contexts out to the system.

 libsemanage/src/policy_components.c |    3 ---
 libsemanage/src/semanage_store.c    |   13 +++++++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --exclude .svn -urN trunk/libsemanage/src/policy_components.c fc-local-fix/libsemanage/src/policy_components.c
--- trunk/libsemanage/src/policy_components.c	2006-07-03 10:42:01.031370000 -0400
+++ fc-local-fix/libsemanage/src/policy_components.c	2006-08-10 10:10:19.483096500 -0400
@@ -132,9 +132,6 @@
 		{semanage_bool_dbase_local(handle),
 		 semanage_bool_dbase_policy(handle), MODE_SET},
 
-		{semanage_fcontext_dbase_local(handle),
-		 semanage_fcontext_dbase_policy(handle), MODE_MODIFY},
-
 		{semanage_seuser_dbase_local(handle),
 		 semanage_seuser_dbase_policy(handle), MODE_MODIFY},
 
diff --exclude .svn -urN trunk/libsemanage/src/semanage_store.c fc-local-fix/libsemanage/src/semanage_store.c
--- trunk/libsemanage/src/semanage_store.c	2006-08-03 11:01:12.429812000 -0400
+++ fc-local-fix/libsemanage/src/semanage_store.c	2006-08-10 10:11:33.943750000 -0400
@@ -1006,6 +1006,8 @@
 	const char *active_kernel =
 	    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_KERNEL);
 	const char *active_fc = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC);
+	const char *active_fc_loc =
+	    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC_LOCAL);
 	const char *active_hd =
 	    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_HOMEDIR_TMPL);
 	const char *active_seusers =
@@ -1013,6 +1015,7 @@
 	const char *active_nc = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_NC);
 
 	const char *running_fc = selinux_file_context_path();
+	const char *running_fc_loc = selinux_file_context_local_path();
 	const char *running_hd = selinux_homedir_context_path();
 	const char *running_policy = selinux_binary_policy_path();
 	const char *running_seusers = selinux_usersconf_path();
@@ -1023,6 +1026,7 @@
 	 * building code in libselinux so that you can get paths for a given 
 	 * POLICYTYPE and should probably be done in the future. */
 	char store_fc[PATH_MAX];
+	char store_fc_loc[PATH_MAX];
 	char store_hd[PATH_MAX];
 	char store_pol[PATH_MAX];
 	char store_seusers[PATH_MAX];
@@ -1030,6 +1034,7 @@
 
 	len = strlen(really_active_store);
 	running_fc += len;
+	running_fc_loc += len;
 	running_hd += len;
 	running_policy += len;
 	running_seusers += len;
@@ -1062,6 +1067,14 @@
 		goto cleanup;
 	}
 
+	snprintf(store_fc_loc, PATH_MAX, "%s%s", storepath, running_fc_loc);
+	if (semanage_copy_file(active_fc_loc, store_fc_loc, sh->conf->file_mode)
+	    < 0) {
+		ERR(sh, "Could not copy %s to %s.", active_fc_loc,
+		    store_fc_loc);
+		goto cleanup;
+	}
+
 	snprintf(store_seusers, PATH_MAX, "%s%s", storepath, running_seusers);
 	if (semanage_copy_file
 	    (active_seusers, store_seusers, sh->conf->file_mode) == -1) {


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

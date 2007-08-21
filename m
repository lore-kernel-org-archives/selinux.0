Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7LHhjMT009661
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 13:43:45 -0400
Received: from tresys-sp-eval (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7LHhhYx001406
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 17:43:43 GMT
Received: from tresys-sp-eval (localhost.localdomain [127.0.0.1])
	by tresys-sp-eval (8.13.8/8.13.8) with ESMTP id l7LJAjAn008260
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 15:10:45 -0400
Received: (from paul@localhost)
	by tresys-sp-eval (8.13.8/8.13.8/Submit) id l7LJAioG008259
	for selinux@tycho.nsa.gov; Tue, 21 Aug 2007 15:10:44 -0400
Message-Id: <20070821191044.407498969@tresys.com>
References: <20070821191042.482612921@tresys.com>
Date: Tue, 21 Aug 2007 15:10:43 -0400
From: tmiller@tresys.com
To: selinux@tycho.nsa.gov
Subject: [patch 1/5] libsemanage: genhomedircon initial cleanup
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Does a series of simple cleanups to make way for the new
genhomedircon.
 
Index: selinux-unmodified-trunk/libsemanage/src/semanage_store.c
===================================================================
--- selinux-unmodified-trunk.orig/libsemanage/src/semanage_store.c
+++ selinux-unmodified-trunk/libsemanage/src/semanage_store.c
@@ -1008,14 +1008,15 @@ static int semanage_install_active(seman
 	const char *active_fc = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC);
 	const char *active_fc_loc =
 	    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC_LOCAL);
-	const char *active_hd =
-	    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_HOMEDIR_TMPL);
 	const char *active_seusers =
 	    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_SEUSERS);
 	const char *active_nc = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_NC);
+	const char *active_fc_hd =
+	    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC_HOMEDIRS);
 
 	const char *running_fc = selinux_file_context_path();
 	const char *running_fc_loc = selinux_file_context_local_path();
+	const char *running_fc_hd = selinux_file_context_homedir_path();
 	const char *running_hd = selinux_homedir_context_path();
 	const char *running_policy = selinux_binary_policy_path();
 	const char *running_seusers = selinux_usersconf_path();
@@ -1027,14 +1028,15 @@ static int semanage_install_active(seman
 	 * POLICYTYPE and should probably be done in the future. */
 	char store_fc[PATH_MAX];
 	char store_fc_loc[PATH_MAX];
-	char store_hd[PATH_MAX];
 	char store_pol[PATH_MAX];
 	char store_seusers[PATH_MAX];
 	char store_nc[PATH_MAX];
+	char store_fc_hd[PATH_MAX];
 
 	len = strlen(really_active_store);
 	running_fc += len;
 	running_fc_loc += len;
+	running_fc_hd += len;
 	running_hd += len;
 	running_policy += len;
 	running_seusers += len;
@@ -1055,9 +1057,10 @@ static int semanage_install_active(seman
 		goto cleanup;
 	}
 
-	snprintf(store_hd, PATH_MAX, "%s%s", storepath, running_hd);
-	if (semanage_copy_file(active_hd, store_hd, sh->conf->file_mode) == -1) {
-		ERR(sh, "Could not copy %s to %s.", active_hd, store_hd);
+	snprintf(store_fc_hd, PATH_MAX, "%s%s", storepath, running_fc_hd);
+	if (semanage_copy_file(active_fc_hd, store_fc_hd, sh->conf->file_mode)
+	    == -1) {
+		ERR(sh, "Could not copy %s to %s.", active_fc_hd, store_fc_hd);
 		goto cleanup;
 	}
 
@@ -1197,6 +1200,10 @@ static int semanage_commit_sandbox(seman
 		retval = -1;
 		goto cleanup;
 	}
+
+	/* clean up some files from the sandbox before install */
+	/* remove homedir_template from sandbox */
+
 	if (rename(sandbox, active) == -1) {
 		ERR(sh, "Error while renaming %s to %s.", sandbox, active);
 		/* note that if an error occurs during the next

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

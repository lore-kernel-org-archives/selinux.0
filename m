Message-ID: <442D663F.8010200@cornell.edu>
Date: Fri, 31 Mar 2006 12:26:23 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: sds@tycho.nsa.gov
CC: Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: The sort algorithm is broken by the second rule,  We need a	way
 to pin these rules to the top.
References: <442D41CA.8070702@redhat.com>  <442D436A.1010805@tresys.com> <1143817846.24555.329.camel@moss-spartans.epoch.ncsc.mil> <442D5A3F.9090409@cornell.edu>
In-Reply-To: <442D5A3F.9090409@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------050909060206010601050704"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050909060206010601050704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> Hmm, I think we actually don't have this capability as of right now - 
> my fault, as I didn't get around to addressing this issue, which would 
> consist of either not merging the .local file into the other one (as 
> we do now), or moving the sort algorithm into libsemanage, where it 
> would sort the local things separately from the module things. 
...maybe this will help.



--------------050909060206010601050704
Content-Type: text/x-patch;
 name="libsemanage.install_fc_local.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.install_fc_local.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2006-03-15 12:21:56.000000000 -0500
+++ new/libsemanage/src/policy_components.c	2006-03-31 12:22:34.000000000 -0500
@@ -136,8 +136,11 @@ int semanage_base_merge_components(
 		{ semanage_bool_dbase_local(handle),
 		  semanage_bool_dbase_policy(handle), MODE_SET },
 
+#if 0
+		/* Sorting algorithm must be moved to libsemanage first */
 		{ semanage_fcontext_dbase_local(handle),
 		  semanage_fcontext_dbase_policy(handle), MODE_MODIFY },
+#endif
 
 		{ semanage_seuser_dbase_local(handle),
 		  semanage_seuser_dbase_policy(handle), MODE_MODIFY },
@@ -219,7 +222,10 @@ int semanage_commit_components(
 		semanage_user_extra_dbase_policy(handle),
 		semanage_port_dbase_local(handle),
 		semanage_fcontext_dbase_local(handle),
+#if 0
+		/* Sorting algorithm must be moved to libsemanage first */
 		semanage_fcontext_dbase_policy(handle),
+#endif
 		semanage_seuser_dbase_local(handle),
 		semanage_seuser_dbase_policy(handle),
 		semanage_bool_dbase_active(handle),
diff -Naurp --exclude-from excludes old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2006-03-08 12:15:25.000000000 -0500
+++ new/libsemanage/src/semanage_store.c	2006-03-31 12:11:13.000000000 -0500
@@ -931,6 +931,7 @@ static int semanage_install_active(seman
 	struct stat astore, istore;
 	const char *active_kernel = semanage_path(SEMANAGE_ACTIVE,SEMANAGE_KERNEL);
 	const char *active_fc = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC);
+	const char *active_fc_local = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC_LOCAL);
 	const char *active_hd = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_HOMEDIR_TMPL);
 	const char *active_seusers = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_SEUSERS);
 
@@ -944,6 +945,7 @@ static int semanage_install_active(seman
 	 * building code in libselinux so that you can get paths for a given 
 	 * POLICYTYPE and should probably be done in the future. */
 	char store_fc[PATH_MAX];
+	char store_fc_local[PATH_MAX];
 	char store_hd[PATH_MAX];
 	char store_pol[PATH_MAX];
 	char store_seusers[PATH_MAX];
@@ -979,6 +981,13 @@ static int semanage_install_active(seman
 		goto cleanup;
 	}
 
+	/* Should not be necessary once sorting algorithm is moved into libsemanage */
+	snprintf(store_fc_local, PATH_MAX, "%s%s.local", storepath, running_fc);
+	if (semanage_copy_file(active_fc_local, store_fc_local, sh->conf->file_mode) == -1) {
+		ERR(sh, "Could not copy %s to %s.", active_fc_local, store_fc_local);
+		goto cleanup;
+	}
+
 	snprintf(store_seusers, PATH_MAX, "%s%s", storepath, running_seusers);
 	if (semanage_copy_file(active_seusers, store_seusers, sh->conf->file_mode) == -1) {
 		INFO(sh, "Non-fatal error:  Could not copy %s to %s.", active_seusers, store_seusers);

--------------050909060206010601050704--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

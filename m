Message-ID: <4372824F.7050904@cornell.edu>
Date: Wed, 09 Nov 2005 18:12:15 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Move seuser validation to proper place
Content-Type: multipart/mixed;
 boundary="------------010309040508030101020900"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010309040508030101020900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Moves seuser validation from commit_components into merge_components.
This is the logical place for it - it's:

1) after modules are loaded and all components merged
2) inside the attach-detach section where policy has not been written 
back to disk
3) still in policy_components.c, which is supposedly backend-independent 
code.

This should result in a speedup, because the policy does not need to be 
re-read in for the sake of seuser validation, which was occuring in 
commit(). Note that seuser validation is incomplete at this point, since 
MLS checks are not done.


--------------010309040508030101020900
Content-Type: text/x-patch;
 name="libsemanage.move_seuser_vcheck.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.move_seuser_vcheck.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2005-11-08 12:10:26.000000000 -0500
+++ new/libsemanage/src/policy_components.c	2005-11-09 17:48:32.000000000 -0500
@@ -63,6 +63,9 @@ typedef struct load_table {
 	int mode;
 } load_table_t;
 
+/* This function must be called AFTER all modules are loaded.
+ * Modules could be represented as a database, in which case
+ * they should be loaded first, before the other components. */
 int semanage_base_merge_components(
 	semanage_handle_t* handle) {
 
@@ -88,6 +91,7 @@ int semanage_base_merge_components(
 	load_handler_arg_t load_arg;
 	load_arg.handle = handle;
 
+	/* Merge components into policy (and validate) */
 	for (i = 0; i < CCOUNT; i++) {
 		dbase_config_t* from = components[i].from;
 		dbase_config_t* to = components[i].to;
@@ -106,6 +110,10 @@ int semanage_base_merge_components(
 			handle, from->dbase, load_handler, &load_arg) < 0) 
 			goto err;
 	}	
+
+	/* Validate seusers against policy */
+	if (semanage_seuser_validate(handle) < 0)
+		goto err;
 	
 	return STATUS_SUCCESS;
 
@@ -128,10 +136,6 @@ int semanage_commit_components(
 	};
 	const int CCOUNT = sizeof(components)/sizeof(components[0]);
 
-	/* Validate seusers */
-	if (semanage_seuser_validate(handle) < 0)
-		goto err;
-
 	for (i = 0; i < CCOUNT; i++) {
 		/* Flush to disk */
 		if (components[i]->dtable->flush(
@@ -139,7 +143,6 @@ int semanage_commit_components(
 			goto err;
 	}
 
-
 	/* Drop cache, because we're leaving transaction soon */
 	for (i=0; i < CCOUNT; i++)
 		components[i]->dtable->drop_cache(components[i]->dbase);

--------------010309040508030101020900--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

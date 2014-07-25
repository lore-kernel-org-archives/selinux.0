Message-ID: <53D28DBB.8000905@tycho.nsa.gov>
Date: Fri, 25 Jul 2014 13:02:51 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux-NSA <SELinux@tycho.nsa.gov>,
 Joshua Brindle <brindle@quarksecurity.com>,
 Steve Lawrence <slawrence@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>
Subject: [RFC] [PATCH] libsemanage: Skip policy module re-link when only
 setting booleans.
Content-Type: multipart/mixed; boundary="------------000209030208020403080902"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------000209030208020403080902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Motivated by:
https://bugzilla.redhat.com/show_bug.cgi?id=1098446

I believe this is always safe for booleans because we only set their
value; we are never adding new ones via semanage, unlike for example
users, ports, nodes, and interfaces.  For the rest, I was wondering why
we don't save the linked file and just reuse it on those changes rather
than re-linking each time - that seems like it would be straightforward
to do in libsemanage and make those operations significantly faster and
less memory intensive.

--------------000209030208020403080902
Content-Type: text/x-patch;
 name="0001-Skip-policy-module-re-link-when-only-setting-boolean.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Skip-policy-module-re-link-when-only-setting-boolean.pa";
 filename*1="tch"

>From 11f35253194036bde941042fa6a2665297853017 Mon Sep 17 00:00:00 2001
From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Fri, 25 Jul 2014 12:05:43 -0400
Subject: [PATCH] Skip policy module re-link when only setting booleans.

Since booleans are only set, not added/removed, we do not need to re-link
modules when setting them.  We can instead just take the existing binary
policy and mutate it for the new values.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsemanage/src/direct_api.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 64dc7d9..5b94725 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -690,7 +690,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	/* Declare some variables */
 	int modified = 0, fcontexts_modified, ports_modified,
 	    seusers_modified, users_extra_modified, dontaudit_modified,
-	    preserve_tunables_modified;
+	    preserve_tunables_modified, bools_modified;
 	dbase_config_t *users = semanage_user_dbase_local(sh);
 	dbase_config_t *users_base = semanage_user_base_dbase_local(sh);
 	dbase_config_t *pusers_base = semanage_user_base_dbase_policy(sh);
@@ -771,11 +771,11 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	users_extra_modified =
 	    users_extra->dtable->is_modified(users_extra->dbase);
 	ports_modified = ports->dtable->is_modified(ports->dbase);
+	bools_modified = bools->dtable->is_modified(bools->dbase);
 
 	modified = sh->modules_modified;
 	modified |= ports_modified;
 	modified |= users->dtable->is_modified(users_base->dbase);
-	modified |= bools->dtable->is_modified(bools->dbase);
 	modified |= ifaces->dtable->is_modified(ifaces->dbase);
 	modified |= nodes->dtable->is_modified(nodes->dbase);
 	modified |= dontaudit_modified;
@@ -891,15 +891,26 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 
 		/* ==================== Policydb-backed ================ */
 
-		/* Create new policy object, then attach to policy databases
-		 * that work with a policydb */
+		/* Create new policy object */
 		retval = semanage_expand_sandbox(sh, base, &out);
 		if (retval < 0)
 			goto cleanup;
 	
 		sepol_module_package_free(base);
 		base = NULL;
+	} else {
+		/* Load already linked policy */
+		retval = sepol_policydb_create(&out);
+		if (retval < 0)
+			goto cleanup;
+
+		retval = semanage_read_policydb(sh, out);
+		if (retval < 0)
+			goto cleanup;
+	}
 
+	if (sh->do_rebuild || modified || bools_modified) {
+		/* Attach to policy databases that work with a policydb. */
 		dbase_policydb_attach((dbase_policydb_t *) pusers_base->dbase,
 				      out);
 		dbase_policydb_attach((dbase_policydb_t *) pports->dbase, out);
@@ -921,14 +932,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 		if (retval < 0)
 			goto cleanup;
 	} else {
-		retval = sepol_policydb_create(&out);
-		if (retval < 0)
-			goto cleanup;
-
-		retval = semanage_read_policydb(sh, out);
-		if (retval < 0)
-			goto cleanup;
-		
+		/* Changes to non-kernel policy configurations only. */
 		if (seusers_modified || users_extra_modified) {
 			retval = semanage_link_base(sh, &base);
 			if (retval < 0)
@@ -1007,7 +1011,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	sepol_policydb_free(out);
 	out = NULL;
 
-	if (sh->do_rebuild || modified || 
+	if (sh->do_rebuild || modified || bools_modified ||
 	    seusers_modified || fcontexts_modified || users_extra_modified) {
 		retval = semanage_install_sandbox(sh);
 	}
@@ -1017,7 +1021,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 		free(mod_filenames[i]);
 	}
 
-	if (modified) {
+	if (modified || bools_modified) {
 		/* Detach from policydb, so it can be freed */
 		dbase_policydb_detach((dbase_policydb_t *) pusers_base->dbase);
 		dbase_policydb_detach((dbase_policydb_t *) pports->dbase);
-- 
1.9.3


--------------000209030208020403080902--

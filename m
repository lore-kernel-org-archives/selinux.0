Message-ID: <48B41D0E.6060509@redhat.com>
Date: Tue, 26 Aug 2008 11:11:10 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        ivg231@gmail.com
Subject: Re: libsemage patch to not compile modules for seusers and fcontext
References: <48A48B8C.3070908@redhat.com> <1219412317.18600.60.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1219412317.18600.60.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------080800070506090503080208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080800070506090503080208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Updated patch.  Comments inlined.

Stephen Smalley wrote:
> On Thu, 2008-08-14 at 15:46 -0400, Daniel J Walsh wrote:
> Patch speeds up semanage command from 17-20 seconds to 3-4 seconds.
> 
plain text document attachment (libsemanage-rhat.patch)
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/direct_api.c
libsemanage-2.0.27/src/direct_api.c
--- nsalibsemanage/src/direct_api.c	2008-06-12 23:25:16.000000000 -0400
+++ libsemanage-2.0.27/src/direct_api.c	2008-08-14 11:51:15.000000000 -0400
@@ -489,12 +489,6 @@
 	modified |= ifaces->dtable->is_modified(ifaces->dbase);
 	modified |= nodes->dtable->is_modified(nodes->dbase);

-	/* FIXME: get rid of these, once we support loading the existing policy,
-	 * instead of rebuilding it */
-	modified |= seusers_modified;
-	modified |= fcontexts_modified;
-	modified |= users_extra_modified;
-
 	/* If there were policy changes, or explicitly requested, rebuild the
policy */
 	if (sh->do_rebuild || modified) {

@@ -667,11 +661,34 @@
 		retval = semanage_verify_kernel(sh);
 		if (retval < 0)
 			goto cleanup;
-	}
+	} else {
+		sepol_policydb_create(&out);

> We should test for failure here (out of memory condition possible).

Ok I will modify


+		modified |= seusers_modified;
+		modified |= fcontexts_modified;
+		modified |= users_extra_modified;

> Should we be setting modified here or just testing for these other
> _modified flags where needed?

Ditto
+		
+		retval = semanage_read_policydb(sh, out);

> Are there any other situations where we can re-use the existing kernel
> policy like this?  e.g. Do we really need to re-link/expand the modules
> if we aren't actually modifying modules?  Although there I suppose we
> might want a copy of the policy before merging local customizations.

Maybe although you would need someone who understands the library better
then I do.

> Also reminds me of the whole question of why we don't do incremental
> linking to avoid having to re-link each time.

That sounds good to me.
+		if (retval < 0)
+			goto cleanup;
+		
+		dbase_policydb_attach((dbase_policydb_t *) pusers_base->dbase,out);
+		dbase_policydb_attach((dbase_policydb_t *) pports->dbase, out);
+		dbase_policydb_attach((dbase_policydb_t *) pifaces->dbase, out);
+		dbase_policydb_attach((dbase_policydb_t *) pbools->dbase, out);
+		dbase_policydb_attach((dbase_policydb_t *) pnodes->dbase, out);

> Ivan suggested these shouldn't be necessary as long as you make the
> later detach conditional.  But he also raised a concern about merging
> with the base seusers or users_extra from the modules?  

Removed and only detach if modified is set.

-	/* FIXME: else if !modified, but seusers_modified,
-	 * load the existing policy instead of rebuilding */
+		if (seusers_modified) {
+			retval = pseusers->dtable->clear(sh, pseusers->dbase);
+			if (retval < 0)
+				goto cleanup;

> I'm a little unclear on what this is doing - can you clarify?
This is clearing the existing seusers.final file, otherwise delete was
not working.


+		}

+		retval = semanage_base_merge_components(sh);
+		if (retval < 0)
+		  goto cleanup;
+
+		/* Seusers */
+	}
 	/* ======= Post-process: Validate non-policydb components ===== */

 	/* Validate local modifications to file contexts.
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage_store.c
libsemanage-2.0.27/src/semanage_store.c
--- nsalibsemanage/src/semanage_store.c	2008-06-12 23:25:16.000000000 -0400
+++ libsemanage-2.0.27/src/semanage_store.c	2008-08-08
15:23:20.000000000 -0400
@@ -1648,6 +1648,47 @@
 }

 /**
+ * Read the policy from the sandbox (kernel)
+ */
+int semanage_read_policydb(semanage_handle_t * sh, sepol_policydb_t * in)
+{
+
+	int retval = STATUS_ERR;
+	const char *kernel_filename = NULL;
+	struct sepol_policy_file *pf = NULL;
+	FILE *infile = NULL;
+
+	if ((kernel_filename =
+	     semanage_path(SEMANAGE_ACTIVE, SEMANAGE_KERNEL)) == NULL) {
+		goto cleanup;
+	}
+	if ((infile = fopen(kernel_filename, "r")) == NULL) {
+		ERR(sh, "Could not open kernel policy %s for reading.",
+		    kernel_filename);
+		goto cleanup;
+	}
+	__fsetlocking(infile, FSETLOCKING_BYCALLER);
+	if (sepol_policy_file_create(&pf)) {
+		ERR(sh, "Out of memory!");
+		goto cleanup;
+	}
+	sepol_policy_file_set_fp(pf, infile);
+	sepol_policy_file_set_handle(pf, sh->sepolh);
+	if (sepol_policydb_read(in, pf) == -1) {
+		ERR(sh, "Error while reading kernel policy from %s.",
+		    kernel_filename);
+		goto cleanup;
+	}
+	retval = STATUS_SUCCESS;
+
+      cleanup:
+	if (infile != NULL) {
+		fclose(infile);
+	}
+	sepol_policy_file_free(pf);
+	return retval;
+}
+/**
  * Writes the final policy to the sandbox (kernel)
  */
 int semanage_write_policydb(semanage_handle_t * sh, sepol_policydb_t * out)
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage_store.h
libsemanage-2.0.27/src/semanage_store.h
--- nsalibsemanage/src/semanage_store.h	2008-06-12 23:25:16.000000000 -0400
+++ libsemanage-2.0.27/src/semanage_store.h	2008-08-11
09:05:16.000000000 -0400
@@ -97,6 +97,9 @@
 			    sepol_module_package_t * base,
 			    sepol_policydb_t ** policydb);

+int semanage_read_policydb(semanage_handle_t * sh,
+			    sepol_policydb_t * policydb);
+
 int semanage_write_policydb(semanage_handle_t * sh,
 			    sepol_policydb_t * policydb);



--------------080800070506090503080208
Content-Type: text/plain;
 name="libsemanage-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibsemanage/src/direct_api.c libsemanage-2.0.27/src/direct_api.c
--- nsalibsemanage/src/direct_api.c	2008-06-12 23:25:16.000000000 -0400
+++ libsemanage-2.0.27/src/direct_api.c	2008-08-26 10:25:38.000000000 -0400
@@ -489,12 +489,6 @@
 	modified |= ifaces->dtable->is_modified(ifaces->dbase);
 	modified |= nodes->dtable->is_modified(nodes->dbase);
 
-	/* FIXME: get rid of these, once we support loading the existing policy,
-	 * instead of rebuilding it */
-	modified |= seusers_modified;
-	modified |= fcontexts_modified;
-	modified |= users_extra_modified;
-
 	/* If there were policy changes, or explicitly requested, rebuild the policy */
 	if (sh->do_rebuild || modified) {
 
@@ -667,11 +661,33 @@
 		retval = semanage_verify_kernel(sh);
 		if (retval < 0)
 			goto cleanup;
-	}
+	} else {
+		retval = sepol_policydb_create(&out);
+		if (retval < 0)
+			goto cleanup;
+		
+		retval = semanage_read_policydb(sh, out);
+		if (retval < 0)
+			goto cleanup;
+		
+		/*		dbase_policydb_attach((dbase_policydb_t *) pusers_base->dbase,out);
+		dbase_policydb_attach((dbase_policydb_t *) pports->dbase, out);
+		dbase_policydb_attach((dbase_policydb_t *) pifaces->dbase, out);
+		dbase_policydb_attach((dbase_policydb_t *) pbools->dbase, out);
+		dbase_policydb_attach((dbase_policydb_t *) pnodes->dbase, out);
+		*/
+		if (seusers_modified) {
+			retval = pseusers->dtable->clear(sh, pseusers->dbase);
+			if (retval < 0)
+				goto cleanup;
+		}
 
-	/* FIXME: else if !modified, but seusers_modified, 
-	 * load the existing policy instead of rebuilding */
+		retval = semanage_base_merge_components(sh);
+		if (retval < 0)
+		  goto cleanup;
 
+		/* Seusers */
+	}
 	/* ======= Post-process: Validate non-policydb components ===== */
 
 	/* Validate local modifications to file contexts.
@@ -724,7 +740,8 @@
 	sepol_policydb_free(out);
 	out = NULL;
 
-	if (sh->do_rebuild || modified) {
+	if (sh->do_rebuild || modified || 
+	    seusers_modified || fcontexts_modified || users_extra_modified) {
 		retval = semanage_install_sandbox(sh);
 	}
 
@@ -733,12 +750,14 @@
 		free(mod_filenames[i]);
 	}
 
-	/* Detach from policydb, so it can be freed */
-	dbase_policydb_detach((dbase_policydb_t *) pusers_base->dbase);
-	dbase_policydb_detach((dbase_policydb_t *) pports->dbase);
-	dbase_policydb_detach((dbase_policydb_t *) pifaces->dbase);
-	dbase_policydb_detach((dbase_policydb_t *) pnodes->dbase);
-	dbase_policydb_detach((dbase_policydb_t *) pbools->dbase);
+	if (modified) {
+		/* Detach from policydb, so it can be freed */
+		dbase_policydb_detach((dbase_policydb_t *) pusers_base->dbase);
+		dbase_policydb_detach((dbase_policydb_t *) pports->dbase);
+		dbase_policydb_detach((dbase_policydb_t *) pifaces->dbase);
+		dbase_policydb_detach((dbase_policydb_t *) pnodes->dbase);
+		dbase_policydb_detach((dbase_policydb_t *) pbools->dbase);
+	}
 
 	free(mod_filenames);
 	sepol_policydb_free(out);
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/genhomedircon.c libsemanage-2.0.27/src/genhomedircon.c
--- nsalibsemanage/src/genhomedircon.c	2008-08-05 09:57:28.000000000 -0400
+++ libsemanage-2.0.27/src/genhomedircon.c	2008-08-26 10:30:30.000000000 -0400
@@ -487,7 +487,6 @@
 				  const char *role_prefix)
 {
 	replacement_pair_t repl[] = {
-		{.search_for = TEMPLATE_SEUSER,.replace_with = seuser},
 		{.search_for = TEMPLATE_HOME_DIR,.replace_with = home},
 		{.search_for = TEMPLATE_ROLE,.replace_with = role_prefix},
 		{NULL, NULL}
@@ -547,7 +546,6 @@
 	replacement_pair_t repl[] = {
 		{.search_for = TEMPLATE_USER,.replace_with = user},
 		{.search_for = TEMPLATE_ROLE,.replace_with = role_prefix},
-		{.search_for = TEMPLATE_SEUSER,.replace_with = seuser},
 		{NULL, NULL}
 	};
 	Ustr *line = USTR_NULL;
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage.conf libsemanage-2.0.27/src/semanage.conf
--- nsalibsemanage/src/semanage.conf	2008-06-12 23:25:16.000000000 -0400
+++ libsemanage-2.0.27/src/semanage.conf	2008-08-14 14:53:32.000000000 -0400
@@ -35,4 +35,4 @@
 # given in <sepol/policydb.h>.  Change this setting if a different
 # version is necessary.
 #policy-version = 19
-
+expand-check=0
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage_store.c libsemanage-2.0.27/src/semanage_store.c
--- nsalibsemanage/src/semanage_store.c	2008-06-12 23:25:16.000000000 -0400
+++ libsemanage-2.0.27/src/semanage_store.c	2008-08-14 14:53:32.000000000 -0400
@@ -1648,6 +1648,47 @@
 }
 
 /**
+ * Read the policy from the sandbox (kernel)
+ */
+int semanage_read_policydb(semanage_handle_t * sh, sepol_policydb_t * in)
+{
+
+	int retval = STATUS_ERR;
+	const char *kernel_filename = NULL;
+	struct sepol_policy_file *pf = NULL;
+	FILE *infile = NULL;
+
+	if ((kernel_filename =
+	     semanage_path(SEMANAGE_ACTIVE, SEMANAGE_KERNEL)) == NULL) {
+		goto cleanup;
+	}
+	if ((infile = fopen(kernel_filename, "r")) == NULL) {
+		ERR(sh, "Could not open kernel policy %s for reading.",
+		    kernel_filename);
+		goto cleanup;
+	}
+	__fsetlocking(infile, FSETLOCKING_BYCALLER);
+	if (sepol_policy_file_create(&pf)) {
+		ERR(sh, "Out of memory!");
+		goto cleanup;
+	}
+	sepol_policy_file_set_fp(pf, infile);
+	sepol_policy_file_set_handle(pf, sh->sepolh);
+	if (sepol_policydb_read(in, pf) == -1) {
+		ERR(sh, "Error while reading kernel policy from %s.",
+		    kernel_filename);
+		goto cleanup;
+	}
+	retval = STATUS_SUCCESS;
+
+      cleanup:
+	if (infile != NULL) {
+		fclose(infile);
+	}
+	sepol_policy_file_free(pf);
+	return retval;
+}
+/**
  * Writes the final policy to the sandbox (kernel)
  */
 int semanage_write_policydb(semanage_handle_t * sh, sepol_policydb_t * out)
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage_store.h libsemanage-2.0.27/src/semanage_store.h
--- nsalibsemanage/src/semanage_store.h	2008-06-12 23:25:16.000000000 -0400
+++ libsemanage-2.0.27/src/semanage_store.h	2008-08-14 14:53:32.000000000 -0400
@@ -97,6 +97,9 @@
 			    sepol_module_package_t * base,
 			    sepol_policydb_t ** policydb);
 
+int semanage_read_policydb(semanage_handle_t * sh,
+			    sepol_policydb_t * policydb);
+
 int semanage_write_policydb(semanage_handle_t * sh,
 			    sepol_policydb_t * policydb);
 
diff --exclude-from=exclude -N -u -r nsalibsemanage/tests/test_fcontext.c libsemanage-2.0.27/tests/test_fcontext.c
--- nsalibsemanage/tests/test_fcontext.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage-2.0.27/tests/test_fcontext.c	2008-08-15 10:59:48.000000000 -0400
@@ -0,0 +1,72 @@
+#include <semanage/fcontext_record.h>
+#include <semanage/semanage.h>
+#include <semanage/fcontexts_local.h>
+#include <sepol/sepol.h>
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+int main(const int argc, const char **argv) {
+	semanage_handle_t *sh = NULL;
+	semanage_fcontext_t *fcontext;
+	semanage_context_t *con;
+	semanage_fcontext_key_t *k;
+
+	int exist = 0;
+	sh = semanage_handle_create();
+	if (sh == NULL) { 
+		perror("Can't create semanage handle\n");
+		return -1;
+	}
+        if (semanage_access_check(sh) < 0) {
+		perror("Semanage access check failed\n");
+		return -1;
+	}
+        if (semanage_connect(sh) < 0) {
+		perror("Semanage connect failed\n");
+		return -1;
+	}
+
+	if (semanage_fcontext_key_create(sh, argv[2], SEMANAGE_FCONTEXT_REG, &k) < 0) {
+		fprintf(stderr, "Could not create key for %s", argv[2]);
+		return -1;
+	}
+
+	if(semanage_fcontext_exists(sh, k, &exist) < 0) {
+		fprintf(stderr,"Could not check if key exists for %s", argv[2]);
+		return -1;
+	}
+	if (exist) {
+		fprintf(stderr,"Could create %s mapping already exists", argv[2]);
+		return -1;
+	}
+
+	if (semanage_fcontext_create(sh, &fcontext) < 0) {
+		fprintf(stderr,"Could not create file context for %s", argv[2]);
+		return -1;
+	}
+	semanage_fcontext_set_expr(sh, fcontext, argv[2]);
+
+	if (semanage_context_from_string(sh, argv[1], &con)) {
+		fprintf(stderr,"Could not create context using %s for file context %s", argv[1], argv[2]);
+		return -1;
+	}
+
+	if (semanage_fcontext_set_con(sh, fcontext, con) < 0) {
+		fprintf(stderr,"Could not set file context for %s", argv[2]);
+		return -1;
+	}
+
+	semanage_fcontext_set_type(fcontext, SEMANAGE_FCONTEXT_REG);
+
+	if(semanage_fcontext_modify_local(sh, k, fcontext) < 0) {
+		fprintf(stderr,"Could not add file context for %s", argv[2]);
+		return -1;
+	}
+	semanage_fcontext_key_free(k);
+	semanage_fcontext_free(fcontext);
+
+	return 0;
+}
+

--------------080800070506090503080208--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Message-ID: <48C7D9F0.4000405@redhat.com>
Date: Wed, 10 Sep 2008 10:30:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg231@gmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: libsemage patch to not compile modules for seusers and fcontext
References: <48A48B8C.3070908@redhat.com> <1219412317.18600.60.camel@moss-spartans.epoch.ncsc.mil> <48B41D0E.6060509@redhat.com> <48B4B348.2080801@gmail.com>
In-Reply-To: <48B4B348.2080801@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------020207090707040504050606"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020207090707040504050606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ivan Gyurdiev wrote:
> 
>>> I'm a little unclear on what this is doing - can you clarify?
>>>     
>> This is clearing the existing seusers.final file, otherwise delete was
>> not working.
>>   
> I think the previous code was doing more - it was merging the local file
> with the shipped base package file, like this:
> 
>    data = extract_file_from_policy_package( )
>    write_file ( "seusers.final", data )
>    if ( data != null ) {
>        seusers.clear_cache()  // thereby forcing reload from
> seusers.final when cache() is called again (in merge_components)
>    } else {
>        seusers.clear()
>    }
> 
> It's also doing this three times (once for fcontexts, once for seusers,
> once for seusers_extra).
> The problem is that you're skipping the link_sandbox call, which builds
> the base package, containing this information.
> 
> Ivan
> 
> 
Ok I found some problems with the previous patch and did some code
reuse.  I added a function that only read base.pp in order to handle the
 base user_extra and seusers problem.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjH2e8ACgkQrlYvE4MpobM/KwCZAQQ/GCqo2qtHVrwKdvSVyVsW
yr4An16jcLDYVX6tjzwRXRJ1kL4tugcf
=8o75
-----END PGP SIGNATURE-----

--------------020207090707040504050606
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibsemanage/src/direct_api.c libsemanage-2.0.27/src/direct_api.c
--- nsalibsemanage/src/direct_api.c	2008-08-28 09:34:24.000000000 -0400
+++ libsemanage-2.0.27/src/direct_api.c	2008-09-10 10:22:42.000000000 -0400
@@ -430,6 +430,58 @@
 	}
 	return 0;
 }
+static int semanage_direct_update_user_extra(semanage_handle_t * sh, sepol_module_package_t *base ) {
+	const char *ofilename = NULL;
+	int retval = -1;
+
+	dbase_config_t *pusers_extra = semanage_user_extra_dbase_policy(sh);
+
+	if (sepol_module_package_get_user_extra_len(base)) {
+		ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA);
+		if (ofilename == NULL) {
+			return retval;
+		}
+		retval = write_file(sh, ofilename,
+				    sepol_module_package_get_user_extra(base),
+				    sepol_module_package_get_user_extra_len(base));
+		if (retval < 0)
+			return retval;
+
+		pusers_extra->dtable->drop_cache(pusers_extra->dbase);
+		
+	} else {
+		retval =  pusers_extra->dtable->clear(sh, pusers_extra->dbase);
+	}
+
+	return retval;
+}
+	
+
+static int semanage_direct_update_seuser(semanage_handle_t * sh, sepol_module_package_t *base ) {
+
+	const char *ofilename = NULL;
+	int retval = -1;
+
+	dbase_config_t *pseusers = semanage_seuser_dbase_policy(sh);
+
+	if (sepol_module_package_get_seusers_len(base)) {
+		ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS);
+		if (ofilename == NULL) {
+			return -1;
+		}
+		retval = write_file(sh, ofilename,
+				    sepol_module_package_get_seusers(base),
+				    sepol_module_package_get_seusers_len(base));
+		if (retval < 0)
+			return retval;
+		
+		pseusers->dtable->drop_cache(pseusers->dbase);
+		
+	} else {
+		retval = pseusers->dtable->clear(sh, pseusers->dbase);
+	}
+	return retval;
+}
 
 /********************* direct API functions ********************/
 
@@ -453,7 +505,6 @@
 	dbase_config_t *users_base = semanage_user_base_dbase_local(sh);
 	dbase_config_t *pusers_base = semanage_user_base_dbase_policy(sh);
 	dbase_config_t *users_extra = semanage_user_extra_dbase_local(sh);
-	dbase_config_t *pusers_extra = semanage_user_extra_dbase_policy(sh);
 	dbase_config_t *ports = semanage_port_dbase_local(sh);
 	dbase_config_t *pports = semanage_port_dbase_policy(sh);
 	dbase_config_t *bools = semanage_bool_dbase_local(sh);
@@ -465,7 +516,6 @@
 	dbase_config_t *fcontexts = semanage_fcontext_dbase_local(sh);
 	dbase_config_t *pfcontexts = semanage_fcontext_dbase_policy(sh);
 	dbase_config_t *seusers = semanage_seuser_dbase_local(sh);
-	dbase_config_t *pseusers = semanage_seuser_dbase_policy(sh);
 
 	/* Before we do anything else, flush the join to its component parts.
 	 * This *does not* flush to disk automatically */
@@ -489,12 +539,6 @@
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
 
@@ -575,46 +619,13 @@
 
 		pfcontexts->dtable->drop_cache(pfcontexts->dbase);
 
-		/* Seusers */
-		if (sepol_module_package_get_seusers_len(base)) {
-			ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS);
-			if (ofilename == NULL) {
-				retval = -1;
-				goto cleanup;
-			}
-			retval = write_file(sh, ofilename,
-					    sepol_module_package_get_seusers(base),
-					    sepol_module_package_get_seusers_len(base));
-			if (retval < 0)
-				goto cleanup;
-
-			pseusers->dtable->drop_cache(pseusers->dbase);
-
-		} else {
-			retval = pseusers->dtable->clear(sh, pseusers->dbase);
-			if (retval < 0)
-				goto cleanup;
-		}
-
-		/* Users_extra */
-		if (sepol_module_package_get_user_extra_len(base)) {
-			ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA);
-			if (ofilename == NULL) {
-				retval = -1;
-				goto cleanup;
-			}
-			retval = write_file(sh, ofilename,
-					    sepol_module_package_get_user_extra(base),
-					    sepol_module_package_get_user_extra_len(base));
-			if (retval < 0)
-				goto cleanup;
-			pusers_extra->dtable->drop_cache(pusers_extra->dbase);
+		retval = semanage_direct_update_seuser(sh, base );
+		if (retval < 0)
+			goto cleanup;
 
-		} else {
-			retval = pusers_extra->dtable->clear(sh, pusers_extra->dbase);
-			if (retval < 0)
-				goto cleanup;
-		}
+		retval = semanage_direct_update_user_extra(sh, base );
+		if (retval < 0)
+			goto cleanup;
 
 		/* Netfilter Contexts */
 		/* Sort the netfilter contexts. */
@@ -667,11 +678,41 @@
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
+		if (seusers_modified || users_extra_modified) {
+			retval = semanage_link_base(sh, &base);
+			if (retval < 0)
+				goto cleanup;
+
+			if (seusers_modified) {
+				retval = semanage_direct_update_seuser(sh, base );
+				if (retval < 0)
+					goto cleanup;
+			}
+			if (users_extra_modified) {
+				/* Users_extra */
+				retval = semanage_direct_update_user_extra(sh, base );
+				if (retval < 0)
+					goto cleanup;
+			}
 
-	/* FIXME: else if !modified, but seusers_modified, 
-	 * load the existing policy instead of rebuilding */
+			sepol_module_package_free(base);
+			base = NULL;
+		}
 
+		retval = semanage_base_merge_components(sh);
+		if (retval < 0)
+		  goto cleanup;
+
+	}
 	/* ======= Post-process: Validate non-policydb components ===== */
 
 	/* Validate local modifications to file contexts.
@@ -724,7 +765,8 @@
 	sepol_policydb_free(out);
 	out = NULL;
 
-	if (sh->do_rebuild || modified) {
+	if (sh->do_rebuild || modified || 
+	    seusers_modified || fcontexts_modified || users_extra_modified) {
 		retval = semanage_install_sandbox(sh);
 	}
 
@@ -733,12 +775,14 @@
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
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage_store.c libsemanage-2.0.27/src/semanage_store.c
--- nsalibsemanage/src/semanage_store.c	2008-08-28 09:34:24.000000000 -0400
+++ libsemanage-2.0.27/src/semanage_store.c	2008-09-10 10:24:12.000000000 -0400
@@ -1608,6 +1608,41 @@
 	return retval;
 }
 
+/* Links only the base module within the sandbox into the base module.
+ * '*base' will point to the module package that contains everything
+ * linked together (caller must call sepol_module_package_destroy() on
+ * it afterwards).  '*base' will be set to NULL upon entering this
+ * function.  Returns 0 on success, -1 on error.
+ */
+int semanage_link_base(semanage_handle_t * sh,
+			  sepol_module_package_t ** base)
+{
+	const char *base_filename = NULL;
+	int retval = -1;
+
+	*base = NULL;
+
+	/* first make sure that base module is readable */
+	if ((base_filename =
+	     semanage_path(SEMANAGE_TMP, SEMANAGE_BASE)) == NULL) {
+		goto cleanup;
+	}
+	if (access(base_filename, R_OK) == -1) {
+		ERR(sh, "Could not access sandbox base file %s.",
+		    base_filename);
+		goto cleanup;
+	}
+
+	if (semanage_load_module(sh, base_filename, base) == -1) {
+		goto cleanup;
+	}
+
+	retval = 0;
+
+      cleanup:
+	return retval;
+}
+
 /* 
  * Expands the policy contained within *base 
  */
@@ -1648,6 +1683,47 @@
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
--- nsalibsemanage/src/semanage_store.h	2008-08-28 09:34:24.000000000 -0400
+++ libsemanage-2.0.27/src/semanage_store.h	2008-09-10 10:22:42.000000000 -0400
@@ -93,10 +93,16 @@
 int semanage_link_sandbox(semanage_handle_t * sh,
 			  sepol_module_package_t ** base);
 
+int semanage_link_base(semanage_handle_t * sh,
+		       sepol_module_package_t ** base);
+
 int semanage_expand_sandbox(semanage_handle_t * sh,
 			    sepol_module_package_t * base,
 			    sepol_policydb_t ** policydb);
 
+int semanage_read_policydb(semanage_handle_t * sh,
+			    sepol_policydb_t * policydb);
+
 int semanage_write_policydb(semanage_handle_t * sh,
 			    sepol_policydb_t * policydb);
 
diff --exclude-from=exclude -N -u -r nsalibsemanage/tests/test_fcontext.c libsemanage-2.0.27/tests/test_fcontext.c
--- nsalibsemanage/tests/test_fcontext.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage-2.0.27/tests/test_fcontext.c	2008-09-10 10:22:42.000000000 -0400
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

--------------020207090707040504050606
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iEYEABECAAYFAkjH2e8ACgkQrlYvE4MpobM8YgCgksMxKSQ5gOFl0cMGFpNrR/Wq0EIAmwUS
VEyOL5ye3ko+gaGXCr1JAQSc
--------------020207090707040504050606--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Message-ID: <489CB1BE.70406@redhat.com>
Date: Fri, 08 Aug 2008 16:51:10 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Why is customizing labeling and seusers so SLOOOOOOOWWWWW.
References: <489C6852.7060501@redhat.com> <489C797B.6000206@manicmethod.com>
In-Reply-To: <489C797B.6000206@manicmethod.com>
Content-Type: multipart/mixed;
 boundary="------------000107050209030803050900"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000107050209030803050900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here is the patch as far as I have gotten too.

fcontext seems to work but seusers is not working yet.

I will not be able to work on it until next week.

The seuser.final handling is a problem.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkicsb0ACgkQrlYvE4MpobNXQgCfbidqndTVwoJFb/qGy8Y8aqBC
Fm0An1gMtWAbeg4ZsN4iWfMy92BHpEAj
=9NoU
-----END PGP SIGNATURE-----

--------------000107050209030803050900
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibsemanage/src/direct_api.c libsemanage-2.0.27/src/direct_api.c
--- nsalibsemanage/src/direct_api.c	2008-06-12 23:25:16.000000000 -0400
+++ libsemanage-2.0.27/src/direct_api.c	2008-08-08 15:54:40.000000000 -0400
@@ -491,9 +491,9 @@
 
 	/* FIXME: get rid of these, once we support loading the existing policy,
 	 * instead of rebuilding it */
-	modified |= seusers_modified;
-	modified |= fcontexts_modified;
-	modified |= users_extra_modified;
+	//	modified |= seusers_modified;
+	//	modified |= fcontexts_modified;
+	//	modified |= users_extra_modified;
 
 	/* If there were policy changes, or explicitly requested, rebuild the policy */
 	if (sh->do_rebuild || modified) {
@@ -667,8 +667,71 @@
 		retval = semanage_verify_kernel(sh);
 		if (retval < 0)
 			goto cleanup;
-	}
+	} else {
+		sepol_policydb_create(&out);
+		modified |= seusers_modified;
+		modified |= fcontexts_modified;
+		modified |= users_extra_modified;
+		ERR(sh, "modified %d.",modified);
+		
+		retval = semanage_read_policydb(sh, out);
+		if (retval < 0)
+			goto cleanup;
+
+		dbase_policydb_attach((dbase_policydb_t *) pusers_base->dbase,out);
+		dbase_policydb_attach((dbase_policydb_t *) pports->dbase, out);
+		dbase_policydb_attach((dbase_policydb_t *) pifaces->dbase, out);
+		dbase_policydb_attach((dbase_policydb_t *) pbools->dbase, out);
+		dbase_policydb_attach((dbase_policydb_t *) pnodes->dbase, out);
+
+		if (seusers_modified) {
+			retval = semanage_link_sandbox(sh, &base);
+			if (retval < 0)
+				goto cleanup;
+			/* Seusers */
+			if (sepol_module_package_get_seusers_len(base)) {
+				ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS);
+				ERR(sh, "out %s", ofilename);
+				if (ofilename == NULL) {
+					retval = -1;
+					goto cleanup;
+				}
+				retval = write_file(sh, ofilename,
+						    sepol_module_package_get_seusers(base),
+						    sepol_module_package_get_seusers_len(base));
+				if (retval < 0)
+					goto cleanup;
+				
+				pseusers->dtable->drop_cache(pseusers->dbase);
+				
+			} else {
+				retval = pseusers->dtable->clear(sh, pseusers->dbase);
+				if (retval < 0)
+					goto cleanup;
+			}
 
+			/* Users_extra */
+			if (sepol_module_package_get_user_extra_len(base)) {
+				ERR(sh, "out %s", ofilename);
+				ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA);
+				if (ofilename == NULL) {
+					retval = -1;
+					goto cleanup;
+				}
+				retval = write_file(sh, ofilename,
+						    sepol_module_package_get_user_extra(base),
+						    sepol_module_package_get_user_extra_len(base));
+				if (retval < 0)
+					goto cleanup;
+				pusers_extra->dtable->drop_cache(pusers_extra->dbase);
+				
+			} else {
+				retval = pusers_extra->dtable->clear(sh, pusers_extra->dbase);
+				if (retval < 0)
+					goto cleanup;
+			}
+		}
+	}
 	/* FIXME: else if !modified, but seusers_modified, 
 	 * load the existing policy instead of rebuilding */
 
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage_store.c libsemanage-2.0.27/src/semanage_store.c
--- nsalibsemanage/src/semanage_store.c	2008-06-12 23:25:16.000000000 -0400
+++ libsemanage-2.0.27/src/semanage_store.c	2008-08-08 15:23:20.000000000 -0400
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

--------------000107050209030803050900
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iEYEABECAAYFAkicsb0ACgkQrlYvE4MpobOkbQCgxvqEZ7f4Sqp7ABqpmnkB7cBi5y4An3qb
KdQK5NkaTE+b70lXYjdK0eQc
--------------000107050209030803050900--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

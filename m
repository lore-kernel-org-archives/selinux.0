Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7BFm00j031018
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 11:48:00 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7BFlxPn014557
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 15:47:59 GMT
Message-ID: <48A05EEE.9090609@redhat.com>
Date: Mon, 11 Aug 2008 11:46:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Cleaned up patch
Content-Type: multipart/mixed;
 boundary="------------090104000103000707010303"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090104000103000707010303
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

seusers still does not seem to work correctly.

semanage login -a -s staff_u username
semanage login -m -s user_u username

seem to work.

semanage login -d username

leaves it in a wierd state.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkigXu4ACgkQrlYvE4MpobOc/wCeO26g+v1iaVTd6Ue60Yn2VmJy
eZUAniVcFJHM0iahxmXp3m0FnXC4OZU5
=0Jes
-----END PGP SIGNATURE-----

--------------090104000103000707010303
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibsemanage/src/direct_api.c libsemanage-2.0.27/src/direct_api.c
--- nsalibsemanage/src/direct_api.c	2008-06-12 23:25:16.000000000 -0400
+++ libsemanage-2.0.27/src/direct_api.c	2008-08-11 11:39:20.000000000 -0400
@@ -491,9 +491,9 @@
 
 	/* FIXME: get rid of these, once we support loading the existing policy,
 	 * instead of rebuilding it */
-	modified |= seusers_modified;
-	modified |= fcontexts_modified;
-	modified |= users_extra_modified;
+	//      modified |= seusers_modified;
+	//	modified |= fcontexts_modified;
+	//	modified |= users_extra_modified;
 
 	/* If there were policy changes, or explicitly requested, rebuild the policy */
 	if (sh->do_rebuild || modified) {
@@ -582,6 +582,7 @@
 				retval = -1;
 				goto cleanup;
 			}
+
 			retval = write_file(sh, ofilename,
 					    sepol_module_package_get_seusers(base),
 					    sepol_module_package_get_seusers_len(base));
@@ -667,11 +668,25 @@
 		retval = semanage_verify_kernel(sh);
 		if (retval < 0)
 			goto cleanup;
-	}
-
-	/* FIXME: else if !modified, but seusers_modified, 
-	 * load the existing policy instead of rebuilding */
+	} else {
+		sepol_policydb_create(&out);
+		modified |= seusers_modified;
+		modified |= fcontexts_modified;
+		modified |= users_extra_modified;
+		
+		retval = semanage_read_policydb(sh, out);
+		if (retval < 0)
+			goto cleanup;
 
+		dbase_policydb_attach((dbase_policydb_t *) pusers_base->dbase,out);
+		dbase_policydb_attach((dbase_policydb_t *) pports->dbase, out);
+		dbase_policydb_attach((dbase_policydb_t *) pifaces->dbase, out);
+		dbase_policydb_attach((dbase_policydb_t *) pbools->dbase, out);
+		dbase_policydb_attach((dbase_policydb_t *) pnodes->dbase, out);
+		retval = semanage_base_merge_components(sh);
+		if (retval < 0)
+		  goto cleanup;
+	}
 	/* ======= Post-process: Validate non-policydb components ===== */
 
 	/* Validate local modifications to file contexts.
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
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage_store.h libsemanage-2.0.27/src/semanage_store.h
--- nsalibsemanage/src/semanage_store.h	2008-06-12 23:25:16.000000000 -0400
+++ libsemanage-2.0.27/src/semanage_store.h	2008-08-11 09:05:16.000000000 -0400
@@ -97,6 +97,9 @@
 			    sepol_module_package_t * base,
 			    sepol_policydb_t ** policydb);
 
+int semanage_read_policydb(semanage_handle_t * sh,
+			    sepol_policydb_t * policydb);
+
 int semanage_write_policydb(semanage_handle_t * sh,
 			    sepol_policydb_t * policydb);
 

--------------090104000103000707010303
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iEYEABECAAYFAkigXu4ACgkQrlYvE4MpobOR2ACgq/69gR1wRSC6ouVoSsFh18na53MAn1qo
fO0PI5QyLVfJ+4HYnFcu/76l
--------------090104000103000707010303--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

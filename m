Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7EJlpl1020545
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 15:47:51 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7EJlkBU007100
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 19:47:50 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m7EJldfu021672
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 15:47:39 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m7EJldOL029287
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 15:47:39 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m7EJlcNG014108
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 15:47:38 -0400
Message-ID: <48A48B8C.3070908@redhat.com>
Date: Thu, 14 Aug 2008 15:46:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: libsemage patch to not compile modules for seusers and fcontext
Content-Type: multipart/mixed;
 boundary="------------070307080502040901050109"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070307080502040901050109
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Patch speeds up semanage command from 17-20 seconds to 3-4 seconds.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkiki4sACgkQrlYvE4MpobM9WwCfY1dRI+NDNiUpu0bwhajASwzR
WVkAnRpWzNWiP+CfBW7n2QTfs+yu0CM1
=8h+v
-----END PGP SIGNATURE-----

--------------070307080502040901050109
Content-Type: text/plain;
 name="libsemanage-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibsemanage/src/direct_api.c libsemanage-2.0.27/src/direct_api.c
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
 	/* If there were policy changes, or explicitly requested, rebuild the policy */
 	if (sh->do_rebuild || modified) {
 
@@ -667,11 +661,34 @@
 		retval = semanage_verify_kernel(sh);
 		if (retval < 0)
 			goto cleanup;
-	}
+	} else {
+		sepol_policydb_create(&out);
+		modified |= seusers_modified;
+		modified |= fcontexts_modified;
+		modified |= users_extra_modified;
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
 
-	/* FIXME: else if !modified, but seusers_modified, 
-	 * load the existing policy instead of rebuilding */
+		if (seusers_modified) {
+			retval = pseusers->dtable->clear(sh, pseusers->dbase);
+			if (retval < 0)
+				goto cleanup;
+		}
 
+		retval = semanage_base_merge_components(sh);
+		if (retval < 0)
+		  goto cleanup;
+
+		/* Seusers */
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
 

--------------070307080502040901050109
Content-Type: application/octet-stream;
 name="libsemanage-rhat.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libsemanage-rhat.patch.sig"

iEUEABECAAYFAkiki4sACgkQrlYvE4MpobPgOwCeOk5AOPaXGzG+AmEYYYrOM3dsjXYAmNTz
Gdk+uNytdRmnx0xXyDVOSqA=
--------------070307080502040901050109--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

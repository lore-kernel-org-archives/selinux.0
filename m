Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LHtagA028219
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:55:36 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LHowrg028589
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 17:50:59 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j6LHoxRp021319
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:50:59 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j6LHoxV00658
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:50:59 -0400
Received: from celtics.boston.redhat.com (celtics.boston.redhat.com [172.16.80.115])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j6LHoxll028433
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:50:59 -0400
Subject: [ libsepol 5/6] Policydb_convert in legacy
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-wRZaYfGHs6x/i7D0Fg5F"
Date: Thu, 21 Jul 2005 13:48:34 -0400
Message-Id: <1121968114.9844.39.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-wRZaYfGHs6x/i7D0Fg5F
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following patch makes legacy
genbools.c and genusers.c use
the new policydb_convert functions:

libsepol-2.2-convert_in_legacy.diff

It depends on:
libsepol-2.1-users.diff



--=-wRZaYfGHs6x/i7D0Fg5F
Content-Disposition: attachment; filename=libsepol-2.2-convert_in_legacy.diff
Content-Type: text/x-patch; name=libsepol-2.2-convert_in_legacy.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aru libsepol.work/src/genbools.c libsepol-2.2-convert_in_legacy/src/genbools.c
--- libsepol.work/src/genbools.c	2005-07-18 15:05:30.000000000 -0400
+++ libsepol-2.2-convert_in_legacy/src/genbools.c	2005-07-20 20:17:45.000000000 -0400
@@ -114,15 +114,8 @@
 	struct policy_file pf;
 	int rc;
 
-	pf.type = PF_USE_MEMORY;
-	pf.data = data;
-	pf.len = len;
-	if (policydb_read(&policydb,&pf, 0)) {
-		__sepol_debug_printf("%s:  binary policy image is invalid\n",
-			__FUNCTION__);
-		errno = EINVAL;
-		return -1;
-	}
+	if (policydb_from_image(data, len, &policydb) < 0)
+		goto err;
 
 	/* Preserve the policy version of the original policy
 	   for the new policy. */
@@ -137,7 +130,7 @@
 		__sepol_debug_printf("%s:  Error while re-evaluating conditionals\n",
 				     __FUNCTION__);
 		errno = EINVAL;
-		goto err;
+		goto err_destroy;
 	}
 
 	pf.data = data;
@@ -147,14 +140,16 @@
 		__sepol_debug_printf("%s: Can't write new binary policy image\n",
 				     __FUNCTION__);
 		errno = EINVAL;
-		goto err;
+		goto err_destroy;
 	}
 
 	policydb_destroy(&policydb);
 	return 0;
 
- err:
+	err_destroy:
 	policydb_destroy(&policydb);
+
+	err:
 	return -1;
 }
 
@@ -177,15 +172,9 @@
 	int rc, i, errors = 0;
 	struct cond_bool_datum *datum;
 
-	pf.type = PF_USE_MEMORY;
-	pf.data = data;
-	pf.len = len;
-	if (policydb_read(&policydb,&pf, 0)) {
-		__sepol_debug_printf("%s:  binary policy image is invalid\n",
-				     __FUNCTION__);
-		errno = EINVAL;
-		return -1;
-	}
+	/* Create policy database from image */
+	if (policydb_from_image(data, len, &policydb) < 0) 
+		goto err;
 
 	/* Preserve the policy version of the original policy
 	   for the new policy. */
@@ -211,7 +200,7 @@
 		__sepol_debug_printf("%s:  Error while re-evaluating conditionals\n",
 				     __FUNCTION__);
 		errno = EINVAL;
-		goto err;
+		goto err_destroy;
 	}
 
 	pf.data = data;
@@ -221,17 +210,20 @@
 		__sepol_debug_printf("%s:  Can't write binary policy\n",
 				     __FUNCTION__);
 		errno = EINVAL;
-		goto err;
+		goto err_destroy;
 	}
 	if (errors) {
 		errno = EINVAL;
-		goto err;
+		goto err_destroy;
 	}
 
 	policydb_destroy(&policydb);
 	return 0;
-err:
+
+	err_destroy:
 	policydb_destroy(&policydb);
+
+	err:
 	return -1;
 }
 
diff -aru libsepol.work/src/genusers.c libsepol-2.2-convert_in_legacy/src/genusers.c
--- libsepol.work/src/genusers.c	2005-07-21 13:06:48.000000000 -0400
+++ libsepol-2.2-convert_in_legacy/src/genusers.c	2005-07-20 20:17:42.000000000 -0400
@@ -344,29 +344,20 @@
 		   void **newdata, size_t *newlen)
 {
 	struct policydb policydb;
-	struct policy_file pf;
 	struct ebitmap free_users;
 	struct kill_user_data kud;
 	char path[PATH_MAX];
-	int rc;
 
-	/* Parse the original binary policy image into a struct policydb. */
-	pf.type = PF_USE_MEMORY;
-	pf.data = data;
-	pf.len = len;
-	if (policydb_read(&policydb,&pf, 0)) {
-		__sepol_debug_printf("%s:  binary policy image is invalid\n",
-				     __FUNCTION__);
-		errno = EINVAL;
-		return -1;
-	}
+	/* Construct policy database */
+	if (policydb_from_image(data, len, &policydb) < 0)
+		goto err;
 
 	/* Load base set of system users from the policy package. */
 	snprintf(path, sizeof path, "%s/system.users", usersdir);
 	if (load_users(&policydb, path) < 0) {
 		__sepol_debug_printf("%s: Can't load system.users:  %s\n",
 				     __FUNCTION__, strerror(errno));
-		goto err;
+		goto err_destroy;
 	}
 
 	/* Load locally defined users. */
@@ -374,7 +365,7 @@
 	if (load_users(&policydb, path) < 0) {
 		__sepol_debug_printf("%s:  Can't load local.users:  %s\n",
 				     __FUNCTION__, strerror(errno));
-		goto err;
+		goto err_destroy;
 	}
 
 	if (selinux_delusers) {
@@ -387,62 +378,17 @@
 		ebitmap_destroy(&free_users);
 	}
 
-	/* Set the policy version for the new binary policy image we are
-	   about to generate so that it stays the same as the original,
-	   even if we support a newer one. */
-	sepol_set_policyvers(POLICY_KERN, policydb.policyvers);
-
-	/* Compute the length for the new binary policy image. */
-	pf.type = PF_LEN;
-	pf.data = NULL;
-	pf.len = 0;
-	rc = policydb_write(&policydb, &pf);
-	if (rc) {
-		__sepol_debug_printf("%s: Can't compute length of binary policy\n",
-				     __FUNCTION__);
-		errno = EINVAL;
-		goto err;
-	}
-
-	/* Allocate the new binary policy image. */
-	pf.type = PF_USE_MEMORY;	
-	pf.data = malloc(pf.len);
-	if (!pf.data) {
-		__sepol_debug_printf("%s:  out of memory\n", __FUNCTION__);
-		goto err;
-	}
-
-	/* Need to save len and data prior to modification by policydb_write. */
-	*newlen = pf.len;
-	*newdata = pf.data;
-
-	/* Write out the new binary policy image. */
-	rc = policydb_write(&policydb, &pf);
-	if (rc) {
-		__sepol_debug_printf("%s:  Can't write binary policy\n",
-				     __FUNCTION__);
-		free(pf.data);
-		errno = EINVAL;
-		goto err;
-	}
-	policydb_destroy(&policydb);
-
-	/* Verify the new binary policy image. */
-	pf.type = PF_USE_MEMORY;
-	pf.data = *newdata;
-	pf.len = *newlen;
-	if (policydb_read(&policydb,&pf, 0)) {
-		__sepol_debug_printf("%s:  new binary policy image is invalid\n",
-				     __FUNCTION__);
-		errno = EINVAL;
-		return -1;
-	}
+	/* Write policy database */
+	if (policydb_to_image(&policydb, newdata, newlen) < 0)
+		goto err_destroy;
 
 	policydb_destroy(&policydb);
 	return 0;
 
-err:
+	err_destroy:
 	policydb_destroy(&policydb);
+
+	err:
 	return -1;
 }
 

--=-wRZaYfGHs6x/i7D0Fg5F--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

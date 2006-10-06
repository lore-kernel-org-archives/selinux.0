Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96KB5Mv007826
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 16:11:05 -0400
Received: from localhost.localdomain (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96K9oQW024031
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 20:09:50 GMT
Message-Id: <20061006201103.986960000@tresys.com>>
References: <20061006200951.006196000@tresys.com>>
Date: Fri, 06 Oct 2006 16:09:53 -0400
From: Chad Sellers <csellers@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/4] Remove current validation mechanism
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch removes the current object class and permission validation code, as it makes it impossible to add, remove, or change object classes and permissions on a running system. Note that this validation code is replaced in the fourth patch of this set, but I removed it completely here to make the patches more readable.

Signed-off-by: Chad Sellers <csellers@tresys.com>

---
 security/selinux/ss/services.c |   91 -----------------------------------------
 1 file changed, 91 deletions(-)

Index: linux-2.6-discovery/security/selinux/ss/services.c
===================================================================
--- linux-2.6-discovery.orig/security/selinux/ss/services.c
+++ linux-2.6-discovery/security/selinux/ss/services.c
@@ -1018,89 +1018,6 @@ int security_change_sid(u32 ssid,
 	return security_compute_sid(ssid, tsid, tclass, AVTAB_CHANGE, out_sid);
 }
 
-/*
- * Verify that each permission that is defined under the
- * existing policy is still defined with the same value
- * in the new policy.
- */
-static int validate_perm(void *key, void *datum, void *p)
-{
-	struct hashtab *h;
-	struct perm_datum *perdatum, *perdatum2;
-	int rc = 0;
-
-
-	h = p;
-	perdatum = datum;
-
-	perdatum2 = hashtab_search(h, key);
-	if (!perdatum2) {
-		printk(KERN_ERR "security:  permission %s disappeared",
-		       (char *)key);
-		rc = -ENOENT;
-		goto out;
-	}
-	if (perdatum->value != perdatum2->value) {
-		printk(KERN_ERR "security:  the value of permission %s changed",
-		       (char *)key);
-		rc = -EINVAL;
-	}
-out:
-	return rc;
-}
-
-/*
- * Verify that each class that is defined under the
- * existing policy is still defined with the same
- * attributes in the new policy.
- */
-static int validate_class(void *key, void *datum, void *p)
-{
-	struct policydb *newp;
-	struct class_datum *cladatum, *cladatum2;
-	int rc;
-
-	newp = p;
-	cladatum = datum;
-
-	cladatum2 = hashtab_search(newp->p_classes.table, key);
-	if (!cladatum2) {
-		printk(KERN_ERR "security:  class %s disappeared\n",
-		       (char *)key);
-		rc = -ENOENT;
-		goto out;
-	}
-	if (cladatum->value != cladatum2->value) {
-		printk(KERN_ERR "security:  the value of class %s changed\n",
-		       (char *)key);
-		rc = -EINVAL;
-		goto out;
-	}
-	if ((cladatum->comdatum && !cladatum2->comdatum) ||
-	    (!cladatum->comdatum && cladatum2->comdatum)) {
-		printk(KERN_ERR "security:  the inherits clause for the access "
-		       "vector definition for class %s changed\n", (char *)key);
-		rc = -EINVAL;
-		goto out;
-	}
-	if (cladatum->comdatum) {
-		rc = hashtab_map(cladatum->comdatum->permissions.table, validate_perm,
-		                 cladatum2->comdatum->permissions.table);
-		if (rc) {
-			printk(" in the access vector definition for class "
-			       "%s\n", (char *)key);
-			goto out;
-		}
-	}
-	rc = hashtab_map(cladatum->permissions.table, validate_perm,
-	                 cladatum2->permissions.table);
-	if (rc)
-		printk(" in access vector definition for class %s\n",
-		       (char *)key);
-out:
-	return rc;
-}
-
 /* Clone the SID into the new SID table. */
 static int clone_sid(u32 sid,
 		     struct context *context,
@@ -1265,14 +1182,6 @@ int security_load_policy(void *data, siz
 
 	sidtab_init(&newsidtab);
 
-	/* Verify that the existing classes did not change. */
-	if (hashtab_map(policydb.p_classes.table, validate_class, &newpolicydb)) {
-		printk(KERN_ERR "security:  the definition of an existing "
-		       "class changed\n");
-		rc = -EINVAL;
-		goto err;
-	}
-
 	/* Clone the SID table. */
 	sidtab_shutdown(&sidtab);
 	if (sidtab_map(&sidtab, clone_sid, &newsidtab)) {

--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

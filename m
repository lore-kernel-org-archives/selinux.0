Subject: [PATCH] sepol, leaks and extra checking
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-j3Z+fByghiZcc0A2tt6Z"
Date: Thu, 22 Sep 2005 16:56:02 -0400
Message-Id: <1127422562.21806.47.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-j3Z+fByghiZcc0A2tt6Z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The first patch fixes a couple memory leaks.

The second sets the base policy version correctly, and changes the
NETLINK class warnings to only check on kernel policies during
policydb_read. Added sanity check to policydb_read to check for the
existance of symbols when they are read in as a require.

Joshua Brindle

--=-j3Z+fByghiZcc0A2tt6Z
Content-Disposition: attachment; filename=10-sepol-policydb-leaks.patch
Content-Type: text/x-patch; name=10-sepol-policydb-leaks.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- libsepol/src/policydb.c	2005-09-22 09:41:17.000000000 -0400
+++ libsepol/src/policydb.c	2005-09-22 15:29:15.000000000 -0400
@@ -894,7 +894,8 @@ void policydb_destroy(policydb_t * p)
 		hashtab_destroy(p->scope[i].table);
         }
         avrule_block_list_destroy(p->global);
-
+        free(p->name);
+        free(p->version);
 
 	avtab_destroy(&p->te_avtab);
 
@@ -982,7 +983,7 @@ void symtabs_destroy(symtab_t *symtab) {
 int scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
         scope_datum_t *cur = (scope_datum_t *) datum;
-	free(key);
+        free(key);
         if (cur != NULL) {
                 free (cur->decl_ids);
         }
@@ -2596,7 +2604,6 @@ int policydb_read(policydb_t * p, struct
         else {
                 /* first read the AV rule blocks, then the scope tables */
                 avrule_block_destroy(p->global);
-                free(p->global);
                 p->global = NULL;
                 if (avrule_block_read(p, &p->global, info->sym_num, fp) == -1) {
                         goto bad;

--=-j3Z+fByghiZcc0A2tt6Z
Content-Disposition: attachment; filename=11-sepol-policydb-fixes.patch
Content-Type: text/x-patch; name=11-sepol-policydb-fixes.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- libsepol/src/policydb.c	2005-09-22 09:41:17.000000000 -0400
+++ libsepol/src/policydb.c	2005-09-22 15:29:15.000000000 -0400
@@ -17,7 +17,7 @@
  *      Code cleanup
  *
  * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
- * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ * Copyright (C) 2003 - 2005 Tresys Technology, LLC
  * Copyright (C) 2003 - 2004 Red Hat, Inc.
  *
  *  This library is free software; you can redistribute it and/or
@@ -93,7 +93,7 @@ static struct policydb_compat_info polic
 	},
 	{
 		.type		= POLICY_BASE,
-		.version 	= POLICYDB_VERSION_MAX,
+		.version 	= MOD_POLICYDB_VERSION_BASE,
 		.sym_num	= SYM_NUM,
 		.ocon_num	= OCON_NODE6 + 1,
         },
@@ -2338,13 +2339,15 @@ static int avrule_block_read(policydb_t 
         return 0;
 }
 
-static int scope_read(policydb_t * p, hashtab_t h, struct policy_file * fp)
+
+static int scope_read(policydb_t * p, int symnum, struct policy_file * fp)
 {
 	scope_datum_t *scope = NULL;
 	uint32_t *buf;
         char *key = NULL;
         size_t key_len;
         unsigned int i;
+        hashtab_t h = p->scope[symnum].table;
 
         if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
                 goto cleanup;
@@ -2358,6 +2361,11 @@ static int scope_read(policydb_t * p, ha
         }
         memcpy(key, buf, key_len);
         key[key_len] = '\0';
+        
+        /* ensure that there already exists a symbol with this key */
+        if (hashtab_search(p->symtab[symnum].table, key) == NULL) {
+                goto cleanup;
+        }
                 
 	if ((scope = calloc(1, sizeof(*scope))) == NULL) {
                 goto cleanup;
@@ -2492,7 +2500,7 @@ int policydb_read(policydb_t * p, struct
 	}
 
 	r_policyvers = buf[bufindex];
-        if (policy_type == POLICY_KERN || policy_type == POLICY_BASE) {
+        if (policy_type == POLICY_KERN) {
                 if (r_policyvers < POLICYDB_VERSION_MIN ||
                     r_policyvers > POLICYDB_VERSION_MAX) {
 			DEBUG(__FUNCTION__, "policydb version %d does not match "
@@ -2501,7 +2509,7 @@ int policydb_read(policydb_t * p, struct
                         return -1;
                 }
         }
-        else if (policy_type == POLICY_MOD) {
+        else if (policy_type == POLICY_BASE || policy_type == POLICY_MOD) {
                 if (r_policyvers < MOD_POLICYDB_VERSION_MIN ||
                     r_policyvers > MOD_POLICYDB_VERSION_MAX) {
 			DEBUG(__FUNCTION__, "policydb module version %d does "
@@ -2607,7 +2614,7 @@ int policydb_read(policydb_t * p, struct
                         }
                         nel = le32_to_cpu(buf[0]);
                         for (j = 0; j < nel; j++) {
-                                if (scope_read(p, p->scope[i].table, fp))
+                                if (scope_read(p, i, fp))
                                         goto bad;
                         }
                 }

--=-j3Z+fByghiZcc0A2tt6Z--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 4/4] SELinux: merge policydb_index_classes and
	policydb_index_others
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, paul.moore@hp.com
Date: Tue, 23 Nov 2010 11:52:45 -0500
Message-ID: <20101123165245.4489.27671.stgit@paris.rdu.redhat.com>
In-Reply-To: <20101123165227.4489.29282.stgit@paris.rdu.redhat.com>
References: <20101123165227.4489.29282.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We duplicate functionality in policydb_index_classes() and
policydb_index_others().  This patch merges those functions just to make it
clear there is nothing special happening here.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/ss/policydb.c |   69 ++++++----------------------------------
 1 files changed, 10 insertions(+), 59 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 5adca67..be9de38 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -411,58 +411,6 @@ static int (*index_f[SYM_NUM]) (void *key, void *datum, void *datap) =
 	cat_index,
 };
 
-/*
- * Define the common val_to_name array and the class
- * val_to_name and val_to_struct arrays in a policy
- * database structure.
- *
- * Caller must clean up upon failure.
- */
-static int policydb_index_classes(struct policydb *p)
-{
-	int rc;
-
-	rc = -ENOMEM;
-	p->sym_val_to_name[SYM_COMMONS] = flex_array_alloc(sizeof(char *),
-							   p->p_commons.nprim,
-							   GFP_KERNEL | __GFP_ZERO);
-	if (!p->sym_val_to_name[SYM_COMMONS])
-		goto out;
-
-	rc = flex_array_prealloc(p->sym_val_to_name[SYM_COMMONS],
-				 0, p->p_commons.nprim - 1,
-				 GFP_KERNEL | __GFP_ZERO);
-	if (rc)
-		goto out;
-
-	rc = hashtab_map(p->p_commons.table, common_index, p);
-	if (rc)
-		goto out;
-
-	rc = -ENOMEM;
-	p->class_val_to_struct =
-		kmalloc(p->p_classes.nprim * sizeof(*(p->class_val_to_struct)), GFP_KERNEL);
-	if (!p->class_val_to_struct)
-		goto out;
-
-	rc = -ENOMEM;
-	p->sym_val_to_name[SYM_CLASSES] = flex_array_alloc(sizeof(char *),
-							   p->p_classes.nprim,
-							   GFP_KERNEL | __GFP_ZERO);
-	if (!p->sym_val_to_name[SYM_CLASSES])
-		goto out;
-
-	rc = flex_array_prealloc(p->sym_val_to_name[SYM_CLASSES],
-				 0, p->p_classes.nprim - 1,
-				 GFP_KERNEL | __GFP_ZERO);
-	if (rc)
-		goto out;
-
-	rc = hashtab_map(p->p_classes.table, class_index, p);
-out:
-	return rc;
-}
-
 #ifdef DEBUG_HASHES
 static void symtab_hash_eval(struct symtab *s)
 {
@@ -500,7 +448,7 @@ static inline void rangetr_hash_eval(struct hashtab *h)
  *
  * Caller must clean up on failure.
  */
-static int policydb_index_others(struct policydb *p)
+static int policydb_index(struct policydb *p)
 {
 	int i, rc;
 
@@ -520,6 +468,13 @@ static int policydb_index_others(struct policydb *p)
 #endif
 
 	rc = -ENOMEM;
+	p->class_val_to_struct =
+		kmalloc(p->p_classes.nprim * sizeof(*(p->class_val_to_struct)),
+			GFP_KERNEL);
+	if (!p->class_val_to_struct)
+		goto out;
+
+	rc = -ENOMEM;
 	p->role_val_to_struct =
 		kmalloc(p->p_roles.nprim * sizeof(*(p->role_val_to_struct)),
 			GFP_KERNEL);
@@ -550,7 +505,7 @@ static int policydb_index_others(struct policydb *p)
 	if (cond_init_bool_indexes(p))
 		goto out;
 
-	for (i = SYM_ROLES; i < SYM_NUM; i++) {
+	for (i = 0; i < SYM_NUM; i++) {
 		rc = -ENOMEM;
 		p->sym_val_to_name[i] = flex_array_alloc(sizeof(char *),
 							 p->symtab[i].nprim,
@@ -2296,11 +2251,7 @@ int policydb_read(struct policydb *p, void *fp)
 		lra = ra;
 	}
 
-	rc = policydb_index_classes(p);
-	if (rc)
-		goto bad;
-
-	rc = policydb_index_others(p);
+	rc = policydb_index(p);
 	if (rc)
 		goto bad;
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

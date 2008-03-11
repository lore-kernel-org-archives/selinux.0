Subject: [PATCH] SELinux: printk normalization
From: Eric Paris <eparis@redhat.com>
To: selinux <selinux@tycho.nsa.gov>
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Tue, 11 Mar 2008 16:00:13 -0400
Message-Id: <1205265613.5297.131.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Attach a KERN_* to the front of every printk and make sure that every
printk ends with a \n

Signed-off-by: Eric Paris <eparis@redhat.com>

---

 security/selinux/ss/avtab.c       |   22 +++++++++++-----------
 security/selinux/ss/conditional.c |   14 +++++++-------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index cd10e27..f740887 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -364,19 +364,19 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		val = le32_to_cpu(buf32[items++]);
 		key.source_type = (u16)val;
 		if (key.source_type != val) {
-			printk("security: avtab: truncated source type\n");
+			printk(KERN_ERR "security: avtab: truncated source type\n");
 			return -1;
 		}
 		val = le32_to_cpu(buf32[items++]);
 		key.target_type = (u16)val;
 		if (key.target_type != val) {
-			printk("security: avtab: truncated target type\n");
+			printk(KERN_ERR "security: avtab: truncated target type\n");
 			return -1;
 		}
 		val = le32_to_cpu(buf32[items++]);
 		key.target_class = (u16)val;
 		if (key.target_class != val) {
-			printk("security: avtab: truncated target class\n");
+			printk(KERN_ERR "security: avtab: truncated target class\n");
 			return -1;
 		}
 
@@ -384,12 +384,12 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		enabled = (val & AVTAB_ENABLED_OLD) ? AVTAB_ENABLED : 0;
 
 		if (!(val & (AVTAB_AV | AVTAB_TYPE))) {
-			printk("security: avtab: null entry\n");
+			printk(KERN_ERR "security: avtab: null entry\n");
 			return -1;
 		}
 		if ((val & AVTAB_AV) &&
 		    (val & AVTAB_TYPE)) {
-			printk("security: avtab: entry has both access vectors and types\n");
+			printk(KERN_ERR "security: avtab: entry has both access vectors and types\n");
 			return -1;
 		}
 
@@ -403,7 +403,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		}
 
 		if (items != items2) {
-			printk("security: avtab: entry only had %d items, expected %d\n", items2, items);
+			printk(KERN_ERR "security: avtab: entry only had %d items, expected %d\n", items2, items);
 			return -1;
 		}
 		return 0;
@@ -411,7 +411,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 
 	rc = next_entry(buf16, fp, sizeof(u16)*4);
 	if (rc < 0) {
-		printk("security: avtab: truncated entry\n");
+		printk(KERN_ERR "security: avtab: truncated entry\n");
 		return -1;
 	}
 
@@ -424,7 +424,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 	if (!policydb_type_isvalid(pol, key.source_type) ||
 	    !policydb_type_isvalid(pol, key.target_type) ||
 	    !policydb_class_isvalid(pol, key.target_class)) {
-		printk(KERN_WARNING "security: avtab: invalid type or class\n");
+		printk(KERN_ERR "security: avtab: invalid type or class\n");
 		return -1;
 	}
 
@@ -434,20 +434,20 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 			set++;
 	}
 	if (!set || set > 1) {
-		printk(KERN_WARNING
+		printk(KERN_ERR
 			"security:  avtab:  more than one specifier\n");
 		return -1;
 	}
 
 	rc = next_entry(buf32, fp, sizeof(u32));
 	if (rc < 0) {
-		printk("security: avtab: truncated entry\n");
+		printk(KERN_ERR "security: avtab: truncated entry\n");
 		return -1;
 	}
 	datum.data = le32_to_cpu(*buf32);
 	if ((key.specified & AVTAB_TYPE) &&
 	    !policydb_type_isvalid(pol, datum.data)) {
-		printk(KERN_WARNING "security: avtab: invalid type\n");
+		printk(KERN_ERR "security: avtab: invalid type\n");
 		return -1;
 	}
 	return insertf(a, &key, &datum, p);
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 50ad85d..1a5b6da 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -276,7 +276,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 	 */
 	if (k->specified & AVTAB_TYPE) {
 		if (avtab_search(&p->te_avtab, k)) {
-			printk("security: type rule already exists outside of a conditional.");
+			printk(KERN_ERR "security: type rule already exists outside of a conditional.\n");
 			goto err;
 		}
 		/*
@@ -291,7 +291,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 			node_ptr = avtab_search_node(&p->te_cond_avtab, k);
 			if (node_ptr) {
 				if (avtab_search_node_next(node_ptr, k->specified)) {
-					printk("security: too many conflicting type rules.");
+					printk(KERN_ERR "security: too many conflicting type rules.\n");
 					goto err;
 				}
 				found = 0;
@@ -302,13 +302,13 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 					}
 				}
 				if (!found) {
-					printk("security: conflicting type rules.\n");
+					printk(KERN_ERR "security: conflicting type rules.\n");
 					goto err;
 				}
 			}
 		} else {
 			if (avtab_search(&p->te_cond_avtab, k)) {
-				printk("security: conflicting type rules when adding type rule for true.\n");
+				printk(KERN_ERR "security: conflicting type rules when adding type rule for true.\n");
 				goto err;
 			}
 		}
@@ -316,7 +316,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 
 	node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, k, d);
 	if (!node_ptr) {
-		printk("security: could not insert rule.");
+		printk(KERN_ERR "security: could not insert rule.\n");
 		goto err;
 	}
 
@@ -376,12 +376,12 @@ static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list *
 static int expr_isvalid(struct policydb *p, struct cond_expr *expr)
 {
 	if (expr->expr_type <= 0 || expr->expr_type > COND_LAST) {
-		printk("security: conditional expressions uses unknown operator.\n");
+		printk(KERN_ERR "security: conditional expressions uses unknown operator.\n");
 		return 0;
 	}
 
 	if (expr->bool > p->p_bools.nprim) {
-		printk("security: conditional expressions uses unknown bool.\n");
+		printk(KERN_ERR "security: conditional expressions uses unknown bool.\n");
 		return 0;
 	}
 	return 1;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

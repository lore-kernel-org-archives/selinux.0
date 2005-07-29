Subject: [RFC][PATCH 1/3] Reduce number of avtab nodes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 29 Jul 2005 13:16:46 -0400
Message-Id: <1122657406.6573.205.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch, relative to the kernel patch to reduce avtab node size,
modifies the SELinux module to create a type->attribute reverse mapping,
with the type always included in its own mapping as a degenerate case,
and to use this mapping when computing access vectors.  This occurs even
if the binary policy lacks the mapping (i.e. older binary policy
version), in which case only the type itself is set in the bitmap and
used for computations.  This patch also happens to include a fix for a
longstanding memory leak in policydb_destroy for role_allow, role_trans,
and range_trans rules that was discovered in the corresponding libsepol
code by Ivan.  We can split that out separately for upstream if
necessary.

---

 security/selinux/ss/policydb.c |   40 ++++++++++++++++++++++++++++++++++++++
 security/selinux/ss/policydb.h |    3 ++
 security/selinux/ss/services.c |   43 +++++++++++++++++++++++++++--------------
 3 files changed, 72 insertions(+), 14 deletions(-)

diff -X /home/sds/dontdiff -rup linux-2.6.13-rc3-mm1-avtab1/security/selinux/ss/policydb.c linux-2.6.13-rc3-mm1-avtab2/security/selinux/ss/policydb.c
--- linux-2.6.13-rc3-mm1-avtab1/security/selinux/ss/policydb.c	2005-07-29 09:20:05.000000000 -0400
+++ linux-2.6.13-rc3-mm1-avtab2/security/selinux/ss/policydb.c	2005-07-29 09:21:01.000000000 -0400
@@ -589,6 +589,9 @@ void policydb_destroy(struct policydb *p
 	struct ocontext *c, *ctmp;
 	struct genfs *g, *gtmp;
 	int i;
+	struct role_allow *ra, *lra = NULL;
+	struct role_trans *tr, *ltr = NULL;
+	struct range_trans *rt, *lrt = NULL;
 
 	for (i = 0; i < SYM_NUM; i++) {
 		hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
@@ -629,6 +632,28 @@ void policydb_destroy(struct policydb *p
 
 	cond_policydb_destroy(p);
 
+	for (tr = p->role_tr; tr; tr = tr->next) {
+		if (ltr) kfree(ltr);
+		ltr = tr;
+	}
+	if (ltr) kfree(ltr);
+
+	for (ra = p->role_allow; ra; ra = ra -> next) {
+		if (lra) kfree(lra);
+		lra = ra;
+	}
+	if (lra) kfree(lra);
+
+	for (rt = p->range_tr; rt; rt = rt -> next) {
+		if (lrt) kfree(lrt);
+		lrt = rt;
+	}
+	if (lrt) kfree(lrt);
+
+	for (i = 0; i < p->p_types.nprim; i++)
+		ebitmap_destroy(&p->type_attr_map[i]);
+	kfree(p->type_attr_map);
+
 	return;
 }
 
@@ -1830,6 +1855,21 @@ int policydb_read(struct policydb *p, vo
 		}
 	}
 
+	p->type_attr_map = kmalloc(p->p_types.nprim*sizeof(struct ebitmap), GFP_KERNEL);
+	if (!p->type_attr_map)
+		goto bad;
+
+	for (i = 0; i < p->p_types.nprim; i++) {
+		ebitmap_init(&p->type_attr_map[i]);
+		if (p->policyvers >= POLICYDB_VERSION_AVTAB) {
+			if (ebitmap_read(&p->type_attr_map[i], fp))
+				goto bad;
+		}
+		/* add the type itself as the degenerate case */
+		if (ebitmap_set_bit(&p->type_attr_map[i], i, 1))
+				goto bad;
+	}
+
 	rc = 0;
 out:
 	return rc;
diff -X /home/sds/dontdiff -rup linux-2.6.13-rc3-mm1-avtab1/security/selinux/ss/policydb.h linux-2.6.13-rc3-mm1-avtab2/security/selinux/ss/policydb.h
--- linux-2.6.13-rc3-mm1-avtab1/security/selinux/ss/policydb.h	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.13-rc3-mm1-avtab2/security/selinux/ss/policydb.h	2005-07-29 09:21:01.000000000 -0400
@@ -237,6 +237,9 @@ struct policydb {
 	/* range transitions */
 	struct range_trans *range_tr;
 
+	/* type -> attribute reverse mapping */
+	struct ebitmap *type_attr_map;
+
 	unsigned int policyvers;
 };
 
diff -X /home/sds/dontdiff -rup linux-2.6.13-rc3-mm1-avtab1/security/selinux/ss/services.c linux-2.6.13-rc3-mm1-avtab2/security/selinux/ss/services.c
--- linux-2.6.13-rc3-mm1-avtab1/security/selinux/ss/services.c	2005-07-29 09:20:05.000000000 -0400
+++ linux-2.6.13-rc3-mm1-avtab2/security/selinux/ss/services.c	2005-07-29 09:21:01.000000000 -0400
@@ -268,6 +268,8 @@ static int context_struct_compute_av(str
 	struct avtab_key avkey;
 	struct avtab_node *node;
 	struct class_datum *tclass_datum;
+	struct ebitmap *sattr, *tattr;
+	unsigned int i, j;
 
 	/*
 	 * Remap extended Netlink classes for old policy versions.
@@ -300,23 +302,36 @@ static int context_struct_compute_av(str
 	 * If a specific type enforcement rule was defined for
 	 * this permission check, then use it.
 	 */
-	avkey.source_type = scontext->type;
-	avkey.target_type = tcontext->type;
 	avkey.target_class = tclass;
 	avkey.specified = AVTAB_AV;
-	for (node = avtab_search_node(&policydb.te_avtab, &avkey);
-	     node != NULL;
-	     node = avtab_search_node_next(node, avkey.specified)) {
-		if (node->key.specified == AVTAB_ALLOWED)
-			avd->allowed = node->datum.data;
-		else if (node->key.specified == AVTAB_AUDITALLOW)
-			avd->auditallow = node->datum.data;
-		else if (node->key.specified == AVTAB_AUDITDENY)
-			avd->auditdeny = node->datum.data;
-	}
+	sattr = &policydb.type_attr_map[scontext->type - 1];
+	tattr = &policydb.type_attr_map[tcontext->type - 1];
+	for (i = ebitmap_startbit(sattr); 
+	     i < ebitmap_length(sattr); i++) {
+		if (!ebitmap_get_bit(sattr, i))
+		    continue;
+		for (j = ebitmap_startbit(tattr); 
+		     j < ebitmap_length(tattr); j++) {
+			if (!ebitmap_get_bit(tattr, j))
+				continue;
+			avkey.source_type = i + 1;
+			avkey.target_type = j + 1;
+			for (node = avtab_search_node(&policydb.te_avtab, &avkey);
+			     node != NULL;
+			     node = avtab_search_node_next(node, avkey.specified)) {
+				if (node->key.specified == AVTAB_ALLOWED)
+					avd->allowed |= node->datum.data;
+				else if (node->key.specified == AVTAB_AUDITALLOW)
+					avd->auditallow |= node->datum.data;
+				else if (node->key.specified == AVTAB_AUDITDENY)
+					avd->auditdeny &= node->datum.data;
+			}
+
+			/* Check conditional av table for additional permissions */
+			cond_compute_av(&policydb.te_cond_avtab, &avkey, avd);
 
-	/* Check conditional av table for additional permissions */
-	cond_compute_av(&policydb.te_cond_avtab, &avkey, avd);
+		}
+	}
 
 	/*
 	 * Remove any permissions prohibited by a constraint (this includes


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

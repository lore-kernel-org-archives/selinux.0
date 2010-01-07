Subject: [RFC][PATCH] selinux:  convert range transition list to a hashtab
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 07 Jan 2010 15:55:16 -0500
Message-Id: <1262897716.2821.100.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Per https://bugzilla.redhat.com/show_bug.cgi?id=548145
there are sufficient range transition rules in modern (Fedora) policy to
make mls_compute_sid a significant factor on the shmem file setup path
due to the length of the range_tr list.  Replace the simple range_tr
list with a hashtab inside the security server to help mitigate this
problem.

Signed-off-by:  Stephen D. Smalley <sds@tycho.nsa.gov>

---

Comments, testing, performance measurements, etc. are welcome.
Also tuning of the hash function is welcome.  You can see how it is doing by
removing the leading _ in the #define _DEBUG_HASHES in policydb.c.

 security/selinux/ss/mls.c      |   18 +++----
 security/selinux/ss/policydb.c |  103 ++++++++++++++++++++++++++++++-----------
 security/selinux/ss/policydb.h |    6 --
 3 files changed, 86 insertions(+), 41 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index e6654b5..443ae73 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -513,7 +513,8 @@ int mls_compute_sid(struct context *scontext,
 		    u32 specified,
 		    struct context *newcontext)
 {
-	struct range_trans *rtr;
+	struct range_trans rtr;
+	struct mls_range *r;
 
 	if (!selinux_mls_enabled)
 		return 0;
@@ -521,15 +522,12 @@ int mls_compute_sid(struct context *scontext,
 	switch (specified) {
 	case AVTAB_TRANSITION:
 		/* Look for a range transition rule. */
-		for (rtr = policydb.range_tr; rtr; rtr = rtr->next) {
-			if (rtr->source_type == scontext->type &&
-			    rtr->target_type == tcontext->type &&
-			    rtr->target_class == tclass) {
-				/* Set the range from the rule */
-				return mls_range_set(newcontext,
-						     &rtr->target_range);
-			}
-		}
+		rtr.source_type = scontext->type;
+		rtr.target_type = tcontext->type;
+		rtr.target_class = tclass;
+		r = hashtab_search(policydb.range_tr, &rtr);
+		if (r)
+			return mls_range_set(newcontext, r);
 		/* Fallthrough */
 	case AVTAB_CHANGE:
 		if (tclass == policydb.process_class)
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index f036672..5b92c02 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -177,6 +177,21 @@ out_free_role:
 	goto out;
 }
 
+static u32 rangetr_hash(struct hashtab *h, const void *k)
+{
+	const struct range_trans *key = k;
+	return (key->source_type + (key->target_type << 3) +
+		(key->target_class << 5)) & (h->size - 1);
+}
+
+static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
+{
+	const struct range_trans *key1 = k1, *key2 = k2;
+	return (key1->source_type != key2->source_type ||
+		key1->target_type != key2->target_type ||
+		key1->target_class != key2->target_class);
+}
+
 /*
  * Initialize a policy database structure.
  */
@@ -204,6 +219,10 @@ static int policydb_init(struct policydb *p)
 	if (rc)
 		goto out_free_symtab;
 
+	p->range_tr = hashtab_create(rangetr_hash, rangetr_cmp, 256);
+	if (!p->range_tr)
+		goto out_free_symtab;
+
 	ebitmap_init(&p->policycaps);
 	ebitmap_init(&p->permissive_map);
 
@@ -408,6 +427,20 @@ static void symtab_hash_eval(struct symtab *s)
 		       info.slots_used, h->size, info.max_chain_len);
 	}
 }
+
+static void rangetr_hash_eval(struct hashtab *h)
+{
+	struct hashtab_info info;
+
+	hashtab_stat(h, &info);
+	printk(KERN_DEBUG "SELinux: rangetr:  %d entries and %d/%d buckets used, "
+	       "longest chain length %d\n", h->nel,
+	       info.slots_used, h->size, info.max_chain_len);
+}
+#else
+static inline void rangetr_hash_eval(struct hashtab *h)
+{
+}
 #endif
 
 /*
@@ -612,6 +645,17 @@ static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap) =
 	cat_destroy,
 };
 
+static int range_tr_destroy(void *key, void *datum, void *p)
+{
+	struct mls_range *rt = datum;
+	kfree(key);
+	ebitmap_destroy(&rt->level[0].cat);
+	ebitmap_destroy(&rt->level[1].cat);
+	kfree(datum);
+	cond_resched();
+	return 0;
+}
+
 static void ocontext_destroy(struct ocontext *c, int i)
 {
 	context_destroy(&c->context[0]);
@@ -632,7 +676,6 @@ void policydb_destroy(struct policydb *p)
 	int i;
 	struct role_allow *ra, *lra = NULL;
 	struct role_trans *tr, *ltr = NULL;
-	struct range_trans *rt, *lrt = NULL;
 
 	for (i = 0; i < SYM_NUM; i++) {
 		cond_resched();
@@ -693,20 +736,8 @@ void policydb_destroy(struct policydb *p)
 	}
 	kfree(lra);
 
-	for (rt = p->range_tr; rt; rt = rt->next) {
-		cond_resched();
-		if (lrt) {
-			ebitmap_destroy(&lrt->target_range.level[0].cat);
-			ebitmap_destroy(&lrt->target_range.level[1].cat);
-			kfree(lrt);
-		}
-		lrt = rt;
-	}
-	if (lrt) {
-		ebitmap_destroy(&lrt->target_range.level[0].cat);
-		ebitmap_destroy(&lrt->target_range.level[1].cat);
-		kfree(lrt);
-	}
+	hashtab_map(p->range_tr, range_tr_destroy, NULL);
+	hashtab_destroy(p->range_tr);
 
 	if (p->type_attr_map) {
 		for (i = 0; i < p->p_types.nprim; i++)
@@ -1689,7 +1720,8 @@ int policydb_read(struct policydb *p, void *fp)
 	u32 len, len2, config, nprim, nel, nel2;
 	char *policydb_str;
 	struct policydb_compat_info *info;
-	struct range_trans *rt, *lrt;
+	struct range_trans *rt;
+	struct mls_range *r;
 
 	config = 0;
 
@@ -2122,44 +2154,61 @@ int policydb_read(struct policydb *p, void *fp)
 		if (rc < 0)
 			goto bad;
 		nel = le32_to_cpu(buf[0]);
-		lrt = NULL;
 		for (i = 0; i < nel; i++) {
 			rt = kzalloc(sizeof(*rt), GFP_KERNEL);
 			if (!rt) {
 				rc = -ENOMEM;
 				goto bad;
 			}
-			if (lrt)
-				lrt->next = rt;
-			else
-				p->range_tr = rt;
 			rc = next_entry(buf, fp, (sizeof(u32) * 2));
-			if (rc < 0)
+			if (rc < 0) {
+				kfree(rt);
 				goto bad;
+			}
 			rt->source_type = le32_to_cpu(buf[0]);
 			rt->target_type = le32_to_cpu(buf[1]);
 			if (new_rangetr) {
 				rc = next_entry(buf, fp, sizeof(u32));
-				if (rc < 0)
+				if (rc < 0) {
+					kfree(rt);
 					goto bad;
+				}
 				rt->target_class = le32_to_cpu(buf[0]);
 			} else
 				rt->target_class = p->process_class;
 			if (!policydb_type_isvalid(p, rt->source_type) ||
 			    !policydb_type_isvalid(p, rt->target_type) ||
 			    !policydb_class_isvalid(p, rt->target_class)) {
+				kfree(rt);
 				rc = -EINVAL;
 				goto bad;
 			}
-			rc = mls_read_range_helper(&rt->target_range, fp);
-			if (rc)
+			r = kzalloc(sizeof(*r), GFP_KERNEL);
+			if (!r) {
+				kfree(rt);
+				rc = -ENOMEM;
 				goto bad;
-			if (!mls_range_isvalid(p, &rt->target_range)) {
+			}
+			rc = mls_read_range_helper(r, fp);
+			if (rc) {
+				kfree(rt);
+				kfree(r);
+				goto bad;
+			}
+			if (!mls_range_isvalid(p, r)) {
 				printk(KERN_WARNING "SELinux:  rangetrans:  invalid range\n");
+				kfree(rt);
+				kfree(r);
+				goto bad;
+			}
+			rc = hashtab_insert(p->range_tr, rt, r);
+			if (rc) {
+				kfree(rt);
+				kfree(r);
 				goto bad;
 			}
-			lrt = rt;
 		}
+		rangetr_hash_eval(p->range_tr);
 	}
 
 	p->type_attr_map = kmalloc(p->p_types.nprim*sizeof(struct ebitmap), GFP_KERNEL);
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index cdcc570..193736b 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -113,8 +113,6 @@ struct range_trans {
 	u32 source_type;
 	u32 target_type;
 	u32 target_class;
-	struct mls_range target_range;
-	struct range_trans *next;
 };
 
 /* Boolean data type */
@@ -240,8 +238,8 @@ struct policydb {
 	   fixed labeling behavior. */
 	struct genfs *genfs;
 
-	/* range transitions */
-	struct range_trans *range_tr;
+	/* range transitions table (range_trans_key -> mls_range) */
+	struct hashtab *range_tr;
 
 	/* type -> attribute reverse mapping */
 	struct ebitmap *type_attr_map;



-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

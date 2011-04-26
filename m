From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 6/6] SELinux: put name based create rules in a hashtable
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Tue, 26 Apr 2011 14:08:08 -0400
Message-ID: <20110426180808.20636.83622.stgit@paris.rdu.redhat.com>
In-Reply-To: <20110426180739.20636.50947.stgit@paris.rdu.redhat.com>
References: <20110426180739.20636.50947.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

To shorten the list we need to run if filename trans rules exist for the type
of the given parent directory I put them in a hashtable.  Given the policy we
are expecting to use in Fedora this takes the worst case list run from about
5,000 entries to 17.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/ss/policydb.c |  167 +++++++++++++++++++++++++++++-----------
 security/selinux/ss/policydb.h |    9 +-
 security/selinux/ss/services.c |   20 ++---
 3 files changed, 135 insertions(+), 61 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index ca7a723..549120c 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -184,6 +184,43 @@ out:
 	return rc;
 }
 
+static u32 filenametr_hash(struct hashtab *h, const void *k)
+{
+	const struct filename_trans *ft = k;
+	unsigned long hash;
+	unsigned int byte_num;
+	unsigned char focus;
+
+	hash = ft->stype ^ ft->ttype ^ ft->tclass;
+
+	byte_num = 0;
+	while ((focus = ft->name[byte_num++]))
+		hash = partial_name_hash(focus, hash);
+	return hash & (h->size - 1);
+}
+
+static int filenametr_cmp(struct hashtab *h, const void *k1, const void *k2)
+{
+	const struct filename_trans *ft1 = k1;
+	const struct filename_trans *ft2 = k2;
+	int v;
+
+	v = ft1->stype - ft2->stype;
+	if (v)
+		return v;
+
+	v = ft1->ttype - ft2->ttype;
+	if (v)
+		return v;
+
+	v = ft1->tclass - ft2->tclass;
+	if (v)
+		return v;
+
+	return strcmp(ft1->name, ft2->name);
+
+}
+
 static u32 rangetr_hash(struct hashtab *h, const void *k)
 {
 	const struct range_trans *key = k;
@@ -236,6 +273,10 @@ static int policydb_init(struct policydb *p)
 	if (rc)
 		goto out;
 
+	p->filename_trans = hashtab_create(filenametr_hash, filenametr_cmp, (1 << 10));
+	if (!p->filename_trans)
+		goto out;
+
 	p->range_tr = hashtab_create(rangetr_hash, rangetr_cmp, 256);
 	if (!p->range_tr)
 		goto out;
@@ -246,6 +287,8 @@ static int policydb_init(struct policydb *p)
 
 	return 0;
 out:
+	hashtab_destroy(p->filename_trans);
+	hashtab_destroy(p->range_tr);
 	for (i = 0; i < SYM_NUM; i++)
 		hashtab_destroy(p->symtab[i].table);
 	return rc;
@@ -675,6 +718,16 @@ static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap) =
 	cat_destroy,
 };
 
+static int filenametr_destroy(void *key, void *datum, void *p)
+{
+	struct filename_trans *ft = key;
+	kfree(ft->name);
+	kfree(key);
+	kfree(datum);
+	cond_resched();
+	return 0;
+}
+
 static int range_tr_destroy(void *key, void *datum, void *p)
 {
 	struct mls_range *rt = datum;
@@ -709,7 +762,6 @@ void policydb_destroy(struct policydb *p)
 	int i;
 	struct role_allow *ra, *lra = NULL;
 	struct role_trans *tr, *ltr = NULL;
-	struct filename_trans *ft, *nft;
 
 	for (i = 0; i < SYM_NUM; i++) {
 		cond_resched();
@@ -773,6 +825,9 @@ void policydb_destroy(struct policydb *p)
 	}
 	kfree(lra);
 
+	hashtab_map(p->filename_trans, filenametr_destroy, NULL);
+	hashtab_destroy(p->filename_trans);
+
 	hashtab_map(p->range_tr, range_tr_destroy, NULL);
 	hashtab_destroy(p->range_tr);
 
@@ -788,14 +843,6 @@ void policydb_destroy(struct policydb *p)
 		flex_array_free(p->type_attr_map_array);
 	}
 
-	ft = p->filename_trans;
-	while (ft) {
-		nft = ft->next;
-		kfree(ft->name);
-		kfree(ft);
-		ft = nft;
-	}
-
 	ebitmap_destroy(&p->filename_trans_ttypes);
 	ebitmap_destroy(&p->policycaps);
 	ebitmap_destroy(&p->permissive_map);
@@ -1806,9 +1853,10 @@ out:
 
 static int filename_trans_read(struct policydb *p, void *fp)
 {
-	struct filename_trans *ft, *last;
-	u32 nel, len;
+	struct filename_trans *ft;
+	struct filename_trans_datum *otype;
 	char *name;
+	u32 nel, len;
 	__le32 buf[4];
 	int rc, i;
 
@@ -1817,25 +1865,23 @@ static int filename_trans_read(struct policydb *p, void *fp)
 
 	rc = next_entry(buf, fp, sizeof(u32));
 	if (rc)
-		goto out;
+		return rc;
 	nel = le32_to_cpu(buf[0]);
 
-	last = p->filename_trans;
-	while (last && last->next)
-		last = last->next;
-
 	for (i = 0; i < nel; i++) {
+		ft = NULL;
+		otype = NULL;
+		name = NULL;
+
 		rc = -ENOMEM;
 		ft = kzalloc(sizeof(*ft), GFP_KERNEL);
 		if (!ft)
 			goto out;
 
-		/* add it to the tail of the list */
-		if (!last)
-			p->filename_trans = ft;
-		else
-			last->next = ft;
-		last = ft;
+		rc = -ENOMEM;
+		otype = kmalloc(sizeof(*otype), GFP_KERNEL);
+		if (!otype)
+			goto out;
 
 		/* length of the path component string */
 		rc = next_entry(buf, fp, sizeof(u32));
@@ -1863,14 +1909,22 @@ static int filename_trans_read(struct policydb *p, void *fp)
 		ft->stype = le32_to_cpu(buf[0]);
 		ft->ttype = le32_to_cpu(buf[1]);
 		ft->tclass = le32_to_cpu(buf[2]);
-		ft->otype = le32_to_cpu(buf[3]);
+
+		otype->otype = le32_to_cpu(buf[3]);
 
 		rc = ebitmap_set_bit(&p->filename_trans_ttypes, ft->ttype, 1);
 		if (rc)
 			goto out;
+
+		hashtab_insert(p->filename_trans, ft, otype);
 	}
-	rc = 0;
+	hash_eval(p->filename_trans, "filenametr");
+	return 0;
 out:
+	kfree(ft);
+	kfree(name);
+	kfree(otype);
+
 	return rc;
 }
 
@@ -3131,43 +3185,60 @@ static int range_write(struct policydb *p, void *fp)
 	return 0;
 }
 
-static int filename_trans_write(struct policydb *p, void *fp)
+static int filename_write_helper(void *key, void *data, void *ptr)
 {
-	struct filename_trans *ft;
-	u32 len, nel = 0;
 	__le32 buf[4];
+	struct filename_trans *ft = key;
+	struct filename_trans_datum *otype = data;
+	void *fp = ptr;
 	int rc;
+	u32 len;
 
-	for (ft = p->filename_trans; ft; ft = ft->next)
-		nel++;
-
-	buf[0] = cpu_to_le32(nel);
+	len = strlen(ft->name);
+	buf[0] = cpu_to_le32(len);
 	rc = put_entry(buf, sizeof(u32), 1, fp);
 	if (rc)
 		return rc;
 
-	for (ft = p->filename_trans; ft; ft = ft->next) {
-		len = strlen(ft->name);
-		buf[0] = cpu_to_le32(len);
-		rc = put_entry(buf, sizeof(u32), 1, fp);
-		if (rc)
-			return rc;
+	rc = put_entry(ft->name, sizeof(char), len, fp);
+	if (rc)
+		return rc;
 
-		rc = put_entry(ft->name, sizeof(char), len, fp);
-		if (rc)
-			return rc;
+	buf[0] = ft->stype;
+	buf[1] = ft->ttype;
+	buf[2] = ft->tclass;
+	buf[3] = otype->otype;
 
-		buf[0] = ft->stype;
-		buf[1] = ft->ttype;
-		buf[2] = ft->tclass;
-		buf[3] = ft->otype;
+	rc = put_entry(buf, sizeof(u32), 4, fp);
+	if (rc)
+		return rc;
 
-		rc = put_entry(buf, sizeof(u32), 4, fp);
-		if (rc)
-			return rc;
-	}
 	return 0;
 }
+
+static int filename_trans_write(struct policydb *p, void *fp)
+{
+	u32 nel;
+	__le32 buf[1];
+	int rc;
+
+	nel = 0;
+	rc = hashtab_map(p->filename_trans, hashtab_cnt, &nel);
+	if (rc)
+		return rc;
+
+	buf[0] = cpu_to_le32(nel);
+	rc = put_entry(buf, sizeof(u32), 1, fp);
+	if (rc)
+		return rc;
+
+	rc = hashtab_map(p->filename_trans, filename_write_helper, fp);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
 /*
  * Write the configuration data in a policy database
  * structure to a policy database binary representation
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index f054a9d..b846c03 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -79,11 +79,13 @@ struct role_trans {
 };
 
 struct filename_trans {
-	struct filename_trans *next;
 	u32 stype;		/* current process */
 	u32 ttype;		/* parent dir context */
 	u16 tclass;		/* class of new object */
 	const char *name;	/* last path component */
+};
+
+struct filename_trans_datum {
 	u32 otype;		/* expected of new object */
 };
 
@@ -227,10 +229,11 @@ struct policydb {
 	/* role transitions */
 	struct role_trans *role_tr;
 
+	/* file transitions with the last path component */
 	/* quickly exclude lookups when parent ttype has no rules */
 	struct ebitmap filename_trans_ttypes;
-	/* file transitions with the last path component */
-	struct filename_trans *filename_trans;
+	/* actual set of filename_trans rules */
+	struct hashtab *filename_trans;
 
 	/* bools indexed by (value - 1) */
 	struct cond_bool_datum **bool_val_to_struct;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 0d55071..c3e4b52 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1362,7 +1362,8 @@ static void filename_compute_type(struct policydb *p, struct context *newcontext
 				  u32 stype, u32 ttype, u16 tclass,
 				  const char *objname)
 {
-	struct filename_trans *ft;
+	struct filename_trans ft;
+	struct filename_trans_datum *otype;
 
 	/*
 	 * Most filename trans rules are going to live in specific directories
@@ -1372,15 +1373,14 @@ static void filename_compute_type(struct policydb *p, struct context *newcontext
 	if (!ebitmap_get_bit(&p->filename_trans_ttypes, ttype))
 		return;
 
-	for (ft = p->filename_trans; ft; ft = ft->next) {
-		if (ft->stype == stype &&
-		    ft->ttype == ttype &&
-		    ft->tclass == tclass &&
-		    !strcmp(ft->name, objname)) {
-			newcontext->type = ft->otype;
-			return;
-		}
-	}
+	ft.stype = stype;
+	ft.ttype = ttype;
+	ft.tclass = tclass;
+	ft.name = objname;
+
+	otype = hashtab_search(p->filename_trans, &ft);
+	if (otype)
+		newcontext->type = otype->otype;
 }
 
 static int security_compute_sid(u32 ssid,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

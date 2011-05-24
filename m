From: <rongqing.li@windriver.com>
To: <sds@tycho.nsa.gov>, <jmorris@namei.org>, <eparis@parisplace.org>
CC: <selinux@tycho.nsa.gov>
Subject: [v0 PATCH 1/2] SELinux: Reorganize the role transition rule
Date: Tue, 24 May 2011 17:46:13 +0800
Message-ID: <1306230374-29019-2-git-send-email-rongqing.li@windriver.com>
In-Reply-To: <1306230374-29019-1-git-send-email-rongqing.li@windriver.com>
References: <1306230374-29019-1-git-send-email-rongqing.li@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Roy.Li <rongqing.li@windriver.com>

Reorganize the role transition rule in hash table rather than single
list

Signed-off-by: Roy.Li <rongqing.li@windriver.com>
---
 security/selinux/ss/policydb.c |  228 ++++++++++++++++++++++++++--------------
 security/selinux/ss/policydb.h |   11 ++-
 2 files changed, 158 insertions(+), 81 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index d246aca..48c4a96 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -246,6 +246,31 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
 	return v;
 }
 
+static u32 roletr_hash(struct hashtab *h, const void *k)
+{
+	const struct roletr_key *key = k;
+	return (key->type + (key->tclass << 3) +
+		(key->role << 5)) & (h->size - 1);
+}
+
+static int roletr_cmp(struct hashtab *h, const void *k1, const void *k2)
+{
+	const struct roletr_key *key1 = k1, *key2 = k2;
+	int v;
+
+	v = key1->type - key2->type;
+	if (v)
+		return v;
+
+	v = key1->tclass - key2->tclass;
+	if (v)
+		return v;
+
+	v = key1->role - key2->role;
+
+	return v;
+}
+
 /*
  * Initialize a policy database structure.
  */
@@ -281,6 +306,10 @@ static int policydb_init(struct policydb *p)
 	if (!p->range_tr)
 		goto out;
 
+	p->role_tr = hashtab_create(roletr_hash, roletr_cmp, 256);
+	if (!p->role_tr)
+		goto out;
+
 	ebitmap_init(&p->filename_trans_ttypes);
 	ebitmap_init(&p->policycaps);
 	ebitmap_init(&p->permissive_map);
@@ -289,6 +318,7 @@ static int policydb_init(struct policydb *p)
 out:
 	hashtab_destroy(p->filename_trans);
 	hashtab_destroy(p->range_tr);
+	hashtab_destroy(p->role_tr);
 	for (i = 0; i < SYM_NUM; i++)
 		hashtab_destroy(p->symtab[i].table);
 	return rc;
@@ -739,6 +769,14 @@ static int range_tr_destroy(void *key, void *datum, void *p)
 	return 0;
 }
 
+static int role_tr_destroy(void *key, void *datum, void *p)
+{
+	kfree(key);
+	kfree(datum);
+	cond_resched();
+	return 0;
+}
+
 static void ocontext_destroy(struct ocontext *c, int i)
 {
 	if (!c)
@@ -761,7 +799,6 @@ void policydb_destroy(struct policydb *p)
 	struct genfs *g, *gtmp;
 	int i;
 	struct role_allow *ra, *lra = NULL;
-	struct role_trans *tr, *ltr = NULL;
 
 	for (i = 0; i < SYM_NUM; i++) {
 		cond_resched();
@@ -811,12 +848,8 @@ void policydb_destroy(struct policydb *p)
 
 	cond_policydb_destroy(p);
 
-	for (tr = p->role_tr; tr; tr = tr->next) {
-		cond_resched();
-		kfree(ltr);
-		ltr = tr;
-	}
-	kfree(ltr);
+	hashtab_map(p->role_tr, role_tr_destroy, NULL);
+	hashtab_destroy(p->role_tr);
 
 	for (ra = p->role_allow; ra; ra = ra->next) {
 		cond_resched();
@@ -1851,6 +1884,65 @@ out:
 	return rc;
 }
 
+static int roletr_read(struct policydb *p, void *fp)
+{
+	struct roletr_key *rtkey = NULL;
+	struct roletr_datum *rtdatum = NULL;
+	int i, rc;
+	__le32 buf[3];
+	u32 nel;
+
+	rc = next_entry(buf, fp, sizeof(u32));
+	if (rc)
+		goto out;
+	nel = le32_to_cpu(buf[0]);
+	for (i = 0; i < nel; i++) {
+		rc = -ENOMEM;
+		rtkey = kzalloc(sizeof(*rtkey), GFP_KERNEL);
+		if (!rtkey)
+			goto out;
+
+		rtdatum = kzalloc(sizeof(*rtdatum), GFP_KERNEL);
+		if (!rtdatum)
+			goto out;
+
+		rc = next_entry(buf, fp, sizeof(u32)*3);
+		if (rc)
+			goto out;
+
+		rc = -EINVAL;
+		rtkey->role = le32_to_cpu(buf[0]);
+		rtkey->type = le32_to_cpu(buf[1]);
+		rtdatum->new_role = le32_to_cpu(buf[2]);
+		if (p->policyvers >= POLICYDB_VERSION_ROLETRANS) {
+			rc = next_entry(buf, fp, sizeof(u32));
+			if (rc)
+				goto out;
+			rtkey->tclass = le32_to_cpu(buf[0]);
+		} else
+			rtkey->tclass = p->process_class;
+
+		if (!policydb_role_isvalid(p, rtkey->role) ||
+		    !policydb_type_isvalid(p, rtkey->type) ||
+		    !policydb_class_isvalid(p, rtkey->tclass) ||
+		    !policydb_role_isvalid(p, rtdatum->new_role))
+			goto out;
+		rc = hashtab_insert(p->role_tr, rtkey, rtdatum);
+		if (rc)
+			goto out;
+
+		rtkey = NULL;
+		rtdatum = NULL;
+	}
+	hash_eval(p->role_tr, "roletr");
+	rc = 0;
+
+out:
+	kfree(rtkey);
+	kfree(rtdatum);
+	return rc;
+}
+
 static int filename_trans_read(struct policydb *p, void *fp)
 {
 	struct filename_trans *ft;
@@ -2190,7 +2282,6 @@ out:
 int policydb_read(struct policydb *p, void *fp)
 {
 	struct role_allow *ra, *lra;
-	struct role_trans *tr, *ltr;
 	int i, j, rc;
 	__le32 buf[4];
 	u32 len, nprim, nel;
@@ -2340,44 +2431,9 @@ int policydb_read(struct policydb *p, void *fp)
 			goto bad;
 	}
 
-	rc = next_entry(buf, fp, sizeof(u32));
+	rc = roletr_read(p, fp);
 	if (rc)
 		goto bad;
-	nel = le32_to_cpu(buf[0]);
-	ltr = NULL;
-	for (i = 0; i < nel; i++) {
-		rc = -ENOMEM;
-		tr = kzalloc(sizeof(*tr), GFP_KERNEL);
-		if (!tr)
-			goto bad;
-		if (ltr)
-			ltr->next = tr;
-		else
-			p->role_tr = tr;
-		rc = next_entry(buf, fp, sizeof(u32)*3);
-		if (rc)
-			goto bad;
-
-		rc = -EINVAL;
-		tr->role = le32_to_cpu(buf[0]);
-		tr->type = le32_to_cpu(buf[1]);
-		tr->new_role = le32_to_cpu(buf[2]);
-		if (p->policyvers >= POLICYDB_VERSION_ROLETRANS) {
-			rc = next_entry(buf, fp, sizeof(u32));
-			if (rc)
-				goto bad;
-			tr->tclass = le32_to_cpu(buf[0]);
-		} else
-			tr->tclass = p->process_class;
-
-		if (!policydb_role_isvalid(p, tr->role) ||
-		    !policydb_type_isvalid(p, tr->type) ||
-		    !policydb_class_isvalid(p, tr->tclass) ||
-		    !policydb_role_isvalid(p, tr->new_role))
-			goto bad;
-		ltr = tr;
-	}
-
 	rc = next_entry(buf, fp, sizeof(u32));
 	if (rc)
 		goto bad;
@@ -2585,39 +2641,6 @@ static int cat_write(void *vkey, void *datum, void *ptr)
 	return 0;
 }
 
-static int role_trans_write(struct policydb *p, void *fp)
-{
-	struct role_trans *r = p->role_tr;
-	struct role_trans *tr;
-	u32 buf[3];
-	size_t nel;
-	int rc;
-
-	nel = 0;
-	for (tr = r; tr; tr = tr->next)
-		nel++;
-	buf[0] = cpu_to_le32(nel);
-	rc = put_entry(buf, sizeof(u32), 1, fp);
-	if (rc)
-		return rc;
-	for (tr = r; tr; tr = tr->next) {
-		buf[0] = cpu_to_le32(tr->role);
-		buf[1] = cpu_to_le32(tr->type);
-		buf[2] = cpu_to_le32(tr->new_role);
-		rc = put_entry(buf, sizeof(u32), 3, fp);
-		if (rc)
-			return rc;
-		if (p->policyvers >= POLICYDB_VERSION_ROLETRANS) {
-			buf[0] = cpu_to_le32(tr->tclass);
-			rc = put_entry(buf, sizeof(u32), 1, fp);
-			if (rc)
-				return rc;
-		}
-	}
-
-	return 0;
-}
-
 static int role_allow_write(struct role_allow *r, void *fp)
 {
 	struct role_allow *ra;
@@ -3185,6 +3208,57 @@ static int range_write(struct policydb *p, void *fp)
 	return 0;
 }
 
+static int roletr_write_helper(void *key, void *data, void *ptr)
+{
+	struct roletr_key *rtkey = key;
+	struct roletr_datum *rtdatum = data;
+	u32 buf[3];
+	int rc;
+	struct policy_data *pd = ptr;
+	void *fp = pd->fp;
+	struct policydb *p = pd->p;
+
+	buf[0] = cpu_to_le32(rtkey->role);
+	buf[1] = cpu_to_le32(rtkey->type);
+	buf[2] = cpu_to_le32(rtdatum->new_role);
+	rc = put_entry(buf, sizeof(u32), 3, fp);
+	if (rc)
+		return rc;
+
+	if (p->policyvers >= POLICYDB_VERSION_ROLETRANS) {
+		buf[0] = cpu_to_le32(rtkey->tclass);
+		rc = put_entry(buf, sizeof(u32), 1, fp);
+		if (rc)
+			return rc;
+	}
+
+	return rc;
+}
+
+static int role_trans_write(struct policydb *p, void *fp)
+{
+	u32 buf[3], nel;
+	int rc;
+	struct policy_data pd;
+
+	pd.p = p;
+	pd.fp = fp;
+
+	nel = 0;
+	rc = hashtab_map(p->role_tr, hashtab_cnt, &nel);
+	if (rc)
+		return rc;
+
+	buf[0] = cpu_to_le32(nel);
+	rc = put_entry(buf, sizeof(u32), 1, fp);
+	if (rc)
+		return rc;
+
+	 /* actually write all of the entries */
+	rc = hashtab_map(p->role_tr, roletr_write_helper, &pd);
+	return rc;
+}
+
 static int filename_write_helper(void *key, void *data, void *ptr)
 {
 	__le32 buf[4];
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index b846c03..2d11c05 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -70,12 +70,15 @@ struct role_datum {
 	struct ebitmap types;		/* set of authorized types for role */
 };
 
-struct role_trans {
+/* Role tranistion */
+struct roletr_datum {
+	u32 new_role;		/* permission bit + 1 */
+};
+
+struct roletr_key {
 	u32 role;		/* current role */
 	u32 type;		/* program executable type, or new object type */
 	u32 tclass;		/* process class, or new object class */
-	u32 new_role;		/* new role */
-	struct role_trans *next;
 };
 
 struct filename_trans {
@@ -227,7 +230,7 @@ struct policydb {
 	struct avtab te_avtab;
 
 	/* role transitions */
-	struct role_trans *role_tr;
+	struct hashtab *role_tr;
 
 	/* file transitions with the last path component */
 	/* quickly exclude lookups when parent ttype has no rules */
-- 
1.7.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

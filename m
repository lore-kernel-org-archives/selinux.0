From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 5/6] SELinux: allow userspace to read policy back out of the
	kernel
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Wed, 13 Oct 2010 17:50:25 -0400
Message-ID: <20101013215025.17293.42799.stgit@paris.rdu.redhat.com>
In-Reply-To: <20101013215002.17293.43060.stgit@paris.rdu.redhat.com>
References: <20101013215002.17293.43060.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There is interest in being able to see what the actual policy is that was
loaded into the kernel.  The patch creates a new selinuxfs file
/selinux/policy which can be read by userspace.  The actual policy that is
loaded into the kernel will be written back out to userspace.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/include/classmap.h |    2 
 security/selinux/include/security.h |    2 
 security/selinux/selinuxfs.c        |   95 ++++
 security/selinux/ss/avtab.c         |   42 ++
 security/selinux/ss/avtab.h         |    2 
 security/selinux/ss/conditional.c   |  123 +++++
 security/selinux/ss/conditional.h   |    2 
 security/selinux/ss/ebitmap.c       |   81 +++
 security/selinux/ss/ebitmap.h       |    1 
 security/selinux/ss/policydb.c      |  841 +++++++++++++++++++++++++++++++++++
 security/selinux/ss/policydb.h      |   20 +
 security/selinux/ss/services.c      |   48 ++
 12 files changed, 1256 insertions(+), 3 deletions(-)

diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index b4c9eb4..8858d2b 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -17,7 +17,7 @@ struct security_class_mapping secclass_map[] = {
 	  { "compute_av", "compute_create", "compute_member",
 	    "check_context", "load_policy", "compute_relabel",
 	    "compute_user", "setenforce", "setbool", "setsecparam",
-	    "setcheckreqprot", NULL } },
+	    "setcheckreqprot", "read_policy", NULL } },
 	{ "process",
 	  { "fork", "transition", "sigchld", "sigkill",
 	    "sigstop", "signull", "signal", "ptrace", "getsched", "setsched",
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 4b66f19..79df4a2 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -82,6 +82,8 @@ extern int selinux_policycap_openperm;
 int security_mls_enabled(void);
 
 int security_load_policy(void *data, size_t len);
+int security_read_policy(void **data, ssize_t *len);
+size_t security_policydb_len(void);
 
 int security_policycap_supported(unsigned int req_cap);
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index a2e7a85..8eb102c 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -68,6 +68,8 @@ static int *bool_pending_values;
 static struct dentry *class_dir;
 static unsigned long last_class_ino;
 
+static char policy_opened;
+
 /* global data for policy capabilities */
 static struct dentry *policycap_dir;
 
@@ -111,6 +113,7 @@ enum sel_inos {
 	SEL_REJECT_UNKNOWN, /* export unknown reject handling to userspace */
 	SEL_DENY_UNKNOWN, /* export unknown deny handling to userspace */
 	SEL_STATUS,	/* export current status using mmap() */
+	SEL_POLICY,	/* allow userspace to read the in kernel policy */
 	SEL_INO_NEXT,	/* The next inode number to use */
 };
 
@@ -351,6 +354,97 @@ static const struct file_operations sel_mls_ops = {
 	.llseek		= generic_file_llseek,
 };
 
+struct policy_load_memory {
+	size_t len;
+	void *data;
+};
+
+static int sel_open_policy(struct inode *inode, struct file *filp)
+{
+	struct policy_load_memory *plm = NULL;
+	int rc;
+
+	BUG_ON(filp->private_data);
+
+	mutex_lock(&sel_mutex);
+
+	rc = task_has_security(current, SECURITY__READ_POLICY);
+	if (rc)
+		goto err;
+
+	rc = -EBUSY;
+	if (policy_opened)
+		goto err;
+
+	rc = -ENOMEM;
+	plm = kzalloc(sizeof(*plm), GFP_KERNEL);
+	if (!plm)
+		goto err;
+
+	if (i_size_read(inode) != security_policydb_len()) {
+		mutex_lock(&inode->i_mutex);
+		i_size_write(inode, security_policydb_len());
+		mutex_unlock(&inode->i_mutex);
+	}
+
+	rc = security_read_policy(&plm->data, &plm->len);
+	if (rc)
+		goto err;
+
+	policy_opened = 1;
+
+	filp->private_data = plm;
+
+	mutex_unlock(&sel_mutex);
+
+	return 0;
+err:
+	mutex_unlock(&sel_mutex);
+
+	if (plm)
+		vfree(plm->data);
+	kfree(plm);
+	return rc;
+}
+
+static int sel_release_policy(struct inode *inode, struct file *filp)
+{
+	struct policy_load_memory *plm = filp->private_data;
+
+	BUG_ON(!plm);
+
+	policy_opened = 0;
+
+	vfree(plm->data);
+	kfree(plm);
+
+	return 0;
+}
+
+static ssize_t sel_read_policy(struct file *filp, char __user *buf,
+			       size_t count, loff_t *ppos)
+{
+	struct policy_load_memory *plm = filp->private_data;
+	int ret;
+
+	mutex_lock(&sel_mutex);
+
+	ret = task_has_security(current, SECURITY__READ_POLICY);
+	if (ret)
+		goto out;
+
+	ret = simple_read_from_buffer(buf, count, ppos, plm->data, plm->len);
+out:
+	mutex_unlock(&sel_mutex);
+	return ret;
+}
+
+static const struct file_operations sel_policy_ops = {
+	.open		= sel_open_policy,
+	.read		= sel_read_policy,
+	.release	= sel_release_policy,
+};
+
 static ssize_t sel_write_load(struct file *file, const char __user *buf,
 			      size_t count, loff_t *ppos)
 
@@ -1668,6 +1762,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 		[SEL_REJECT_UNKNOWN] = {"reject_unknown", &sel_handle_unknown_ops, S_IRUGO},
 		[SEL_DENY_UNKNOWN] = {"deny_unknown", &sel_handle_unknown_ops, S_IRUGO},
 		[SEL_STATUS] = {"status", &sel_handle_status_ops, S_IRUGO},
+		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUSR},
 		/* last one */ {""}
 	};
 	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 77a917c..a3dd9fa 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -501,6 +501,48 @@ bad:
 	goto out;
 }
 
+int avtab_write_item(struct policydb *p, struct avtab_node *cur, void *fp)
+{
+	__le16 buf16[4];
+	__le32 buf32[1];
+	int rc;
+
+	buf16[0] = cpu_to_le16(cur->key.source_type);
+	buf16[1] = cpu_to_le16(cur->key.target_type);
+	buf16[2] = cpu_to_le16(cur->key.target_class);
+	buf16[3] = cpu_to_le16(cur->key.specified);
+	rc = put_entry(buf16, sizeof(u16), 4, fp);
+	if (rc)
+		return rc;
+	buf32[0] = cpu_to_le32(cur->datum.data);
+	rc = put_entry(buf32, sizeof(u32), 1, fp);
+	if (rc)
+		return rc;
+	return 0;
+}
+
+int avtab_write(struct policydb *p, struct avtab *a, void *fp)
+{
+	unsigned int i;
+	int rc = 0;
+	struct avtab_node *cur;
+	__le32 buf[1];
+
+	buf[0] = cpu_to_le32(a->nel);
+	rc = put_entry(buf, sizeof(u32), 1, fp);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < a->nslot; i++) {
+		for (cur = a->htable[i]; cur; cur = cur->next) {
+			rc = avtab_write_item(p, cur, fp);
+			if (rc)
+				return rc;
+		}
+	}
+
+	return rc;
+}
 void avtab_cache_init(void)
 {
 	avtab_node_cachep = kmem_cache_create("avtab_node",
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 32bd8b3..dff0c75 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -71,6 +71,8 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		    void *p);
 
 int avtab_read(struct avtab *a, void *fp, struct policydb *pol);
+int avtab_write_item(struct policydb *p, struct avtab_node *cur, void *fp);
+int avtab_write(struct policydb *p, struct avtab *a, void *fp);
 
 struct avtab_node *avtab_insert_nonunique(struct avtab *h, struct avtab_key *key,
 					  struct avtab_datum *datum);
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index c91e150..655fe1c 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -490,6 +490,129 @@ err:
 	return rc;
 }
 
+int cond_write_bool(void *vkey, void *datum, void *ptr)
+{
+	char *key = vkey;
+	struct cond_bool_datum *booldatum = datum;
+	struct policy_data *pd = ptr;
+	void *fp = pd->fp;
+	__le32 buf[3];
+	u32 len;
+	int rc;
+
+	len = strlen(key);
+	buf[0] = cpu_to_le32(booldatum->value);
+	buf[1] = cpu_to_le32(booldatum->state);
+	buf[2] = cpu_to_le32(len);
+	rc = put_entry(buf, sizeof(u32), 3, fp);
+	if (rc)
+		return rc;
+	rc = put_entry(key, 1, len, fp);
+	if (rc)
+		return rc;
+	return 0;
+}
+
+/*
+ * cond_write_cond_av_list doesn't write out the av_list nodes.
+ * Instead it writes out the key/value pairs from the avtab. This
+ * is necessary because there is no way to uniquely identifying rules
+ * in the avtab so it is not possible to associate individual rules
+ * in the avtab with a conditional without saving them as part of
+ * the conditional. This means that the avtab with the conditional
+ * rules will not be saved but will be rebuilt on policy load.
+ */
+static int cond_write_av_list(struct policydb *p,
+			      struct cond_av_list *list, struct policy_file *fp)
+{
+	__le32 buf[1];
+	struct cond_av_list *cur_list;
+	u32 len;
+	int rc;
+
+	len = 0;
+	for (cur_list = list; cur_list != NULL; cur_list = cur_list->next)
+		len++;
+
+	buf[0] = cpu_to_le32(len);
+	rc = put_entry(buf, sizeof(u32), 1, fp);
+	if (rc)
+		return rc;
+
+	if (len == 0)
+		return 0;
+
+	for (cur_list = list; cur_list != NULL; cur_list = cur_list->next) {
+		rc = avtab_write_item(p, cur_list->node, fp);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+int cond_write_node(struct policydb *p, struct cond_node *node,
+		    struct policy_file *fp)
+{
+	struct cond_expr *cur_expr;
+	__le32 buf[2];
+	int rc;
+	u32 len = 0;
+
+	buf[0] = cpu_to_le32(node->cur_state);
+	rc = put_entry(buf, sizeof(u32), 1, fp);
+	if (rc)
+		return rc;
+
+	for (cur_expr = node->expr; cur_expr != NULL; cur_expr = cur_expr->next)
+		len++;
+
+	buf[0] = cpu_to_le32(len);
+	rc = put_entry(buf, sizeof(u32), 1, fp);
+	if (rc)
+		return rc;
+
+	for (cur_expr = node->expr; cur_expr != NULL; cur_expr = cur_expr->next) {
+		buf[0] = cpu_to_le32(cur_expr->expr_type);
+		buf[1] = cpu_to_le32(cur_expr->bool);
+		rc = put_entry(buf, sizeof(u32), 2, fp);
+		if (rc)
+			return rc;
+	}
+
+	rc = cond_write_av_list(p, node->true_list, fp);
+	if (rc)
+		return rc;
+	rc = cond_write_av_list(p, node->false_list, fp);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+int cond_write_list(struct policydb *p, struct cond_node *list, void *fp)
+{
+	struct cond_node *cur;
+	u32 len;
+	__le32 buf[1];
+	int rc;
+
+	len = 0;
+	for (cur = list; cur != NULL; cur = cur->next)
+		len++;
+	buf[0] = cpu_to_le32(len);
+	rc = put_entry(buf, sizeof(u32), 1, fp);
+	if (rc)
+		return rc;
+
+	for (cur = list; cur != NULL; cur = cur->next) {
+		rc = cond_write_node(p, cur, fp);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
 /* Determine whether additional permissions are granted by the conditional
  * av table, and if so, add them to the result
  */
diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index 53ddb01..3f209c6 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -69,6 +69,8 @@ int cond_index_bool(void *key, void *datum, void *datap);
 
 int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp);
 int cond_read_list(struct policydb *p, void *fp);
+int cond_write_bool(void *key, void *datum, void *ptr);
+int cond_write_list(struct policydb *p, struct cond_node *list, void *fp);
 
 void cond_compute_av(struct avtab *ctab, struct avtab_key *key, struct av_decision *avd);
 
diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 04b6145..d42951f 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -22,6 +22,8 @@
 #include "ebitmap.h"
 #include "policydb.h"
 
+#define BITS_PER_U64	(sizeof(u64) * 8)
+
 int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2)
 {
 	struct ebitmap_node *n1, *n2;
@@ -363,10 +365,10 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 	e->highbit = le32_to_cpu(buf[1]);
 	count = le32_to_cpu(buf[2]);
 
-	if (mapunit != sizeof(u64) * 8) {
+	if (mapunit != BITS_PER_U64) {
 		printk(KERN_ERR "SELinux: ebitmap: map size %u does not "
 		       "match my size %Zd (high bit was %d)\n",
-		       mapunit, sizeof(u64) * 8, e->highbit);
+		       mapunit, BITS_PER_U64, e->highbit);
 		goto bad;
 	}
 
@@ -446,3 +448,78 @@ bad:
 	ebitmap_destroy(e);
 	goto out;
 }
+
+int ebitmap_write(struct ebitmap *e, void *fp)
+{
+	struct ebitmap_node *n;
+	u32 count;
+	__le32 buf[3];
+	u64 map;
+	int bit, last_bit, last_startbit, rc;
+
+	buf[0] = cpu_to_le32(BITS_PER_U64);
+
+	count = 0;
+	last_bit = 0;
+	last_startbit = -1;
+	ebitmap_for_each_positive_bit(e, n, bit) {
+		if (rounddown(bit, (int)BITS_PER_U64) > last_startbit) {
+			count++;
+			last_startbit = rounddown(bit, BITS_PER_U64);
+		}
+		last_bit = roundup(bit + 1, BITS_PER_U64);
+	}
+	buf[1] = cpu_to_le32(last_bit);
+	buf[2] = cpu_to_le32(count);
+
+	rc = put_entry(buf, sizeof(u32), 3, fp);
+	if (rc)
+		return rc;
+
+	map = 0;
+	last_startbit = INT_MIN;
+	ebitmap_for_each_positive_bit(e, n, bit) {
+		if (rounddown(bit, (int)BITS_PER_U64) > last_startbit) {
+			__le64 buf64[1];
+
+			/* this is the very first bit */
+			if (!map) {
+				last_startbit = rounddown(bit, BITS_PER_U64);
+				map = (u64)1 << (bit - last_startbit);
+				continue;
+			}
+
+			/* write the last node */
+			buf[0] = cpu_to_le32(last_startbit);
+			rc = put_entry(buf, sizeof(u32), 1, fp);
+			if (rc)
+				return rc;
+
+			buf64[0] = cpu_to_le64(map);
+			rc = put_entry(buf64, sizeof(u64), 1, fp);
+			if (rc)
+				return rc;
+
+			/* set up for the next node */
+			map = 0;
+			last_startbit = rounddown(bit, BITS_PER_U64);
+		}
+		map |= (u64)1 << (bit - last_startbit);
+	}
+	/* write the last node */
+	if (map) {
+		__le64 buf64[1];
+
+		/* write the last node */
+		buf[0] = cpu_to_le32(last_startbit);
+		rc = put_entry(buf, sizeof(u32), 1, fp);
+		if (rc)
+			return rc;
+
+		buf64[0] = cpu_to_le64(map);
+		rc = put_entry(buf64, sizeof(u64), 1, fp);
+		if (rc)
+			return rc;
+	}
+	return 0;
+}
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index f283b43..1f4e93c 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -123,6 +123,7 @@ int ebitmap_get_bit(struct ebitmap *e, unsigned long bit);
 int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value);
 void ebitmap_destroy(struct ebitmap *e);
 int ebitmap_read(struct ebitmap *e, void *fp);
+int ebitmap_write(struct ebitmap *e, void *fp);
 
 #ifdef CONFIG_NETLABEL
 int ebitmap_netlbl_export(struct ebitmap *ebmap,
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 97fb0cf..94f630d 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -37,6 +37,7 @@
 #include "policydb.h"
 #include "conditional.h"
 #include "mls.h"
+#include "services.h"
 
 #define _DEBUG_HASHES
 
@@ -2316,3 +2317,843 @@ bad:
 	policydb_destroy(p);
 	goto out;
 }
+
+/*
+ * Write a MLS level structure to a policydb binary
+ * representation file.
+ */
+static int mls_write_level(struct mls_level *l, void *fp)
+{
+	__le32 buf[1];
+	int rc;
+
+	buf[0] = cpu_to_le32(l->sens);
+	rc = put_entry(buf, sizeof(u32), 1, fp);
+	if (rc)
+		return rc;
+
+	rc = ebitmap_write(&l->cat, fp);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+/*
+ * Write a MLS range structure to a policydb binary
+ * representation file.
+ */
+static int mls_write_range_helper(struct mls_range *r, void *fp)
+{
+	__le32 buf[3];
+	size_t items;
+	int rc, eq;
+
+	eq = mls_level_eq(&r->level[1], &r->level[0]);
+
+	if (eq)
+		items = 2;
+	else
+		items = 3;
+	buf[0] = cpu_to_le32(items-1);
+	buf[1] = cpu_to_le32(r->level[0].sens);
+	if (!eq)
+		buf[2] = cpu_to_le32(r->level[1].sens);
+
+	BUG_ON(items > (sizeof(buf)/sizeof(buf[0])));
+
+	rc = put_entry(buf, sizeof(u32), items, fp);
+	if (rc)
+		return rc;
+
+	rc = ebitmap_write(&r->level[0].cat, fp);
+	if (rc)
+		return rc;
+	if (!eq) {
+		rc = ebitmap_write(&r->level[1].cat, fp);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int sens_write(void *vkey, void *datum, void *ptr)
+{
+	char *key = vkey;
+	struct level_datum *levdatum = datum;
+	struct policy_data *pd = ptr;
+	void *fp = pd->fp;
+	__le32 buf[2];
+	size_t len;
+	int rc;
+
+	len = strlen(key);
+	buf[0] = cpu_to_le32(len);
+	buf[1] = cpu_to_le32(levdatum->isalias);
+	rc = put_entry(buf, sizeof(u32), 2, fp);
+	if (rc)
+		return rc;
+
+	rc = put_entry(key, 1, len, fp);
+	if (rc)
+		return rc;
+
+	rc = mls_write_level(levdatum->level, fp);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int cat_write(void *vkey, void *datum, void *ptr)
+{
+	char *key = vkey;
+	struct cat_datum *catdatum = datum;
+	struct policy_data *pd = ptr;
+	void *fp = pd->fp;
+	__le32 buf[3];
+	size_t len;
+	int rc;
+
+	len = strlen(key);
+	buf[0] = cpu_to_le32(len);
+	buf[1] = cpu_to_le32(catdatum->value);
+	buf[2] = cpu_to_le32(catdatum->isalias);
+	rc = put_entry(buf, sizeof(u32), 3, fp);
+	if (rc)
+		return rc;
+
+	rc = put_entry(key, 1, len, fp);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int role_trans_write(struct role_trans *r, void *fp)
+{
+	struct role_trans *tr;
+	u32 buf[3];
+	size_t nel;
+	int rc;
+
+	nel = 0;
+	for (tr = r; tr; tr = tr->next)
+		nel++;
+	buf[0] = cpu_to_le32(nel);
+	rc = put_entry(buf, sizeof(u32), 1, fp);
+	if (rc)
+		return rc;
+	for (tr = r; tr; tr = tr->next) {
+		buf[0] = cpu_to_le32(tr->role);
+		buf[1] = cpu_to_le32(tr->type);
+		buf[2] = cpu_to_le32(tr->new_role);
+		rc = put_entry(buf, sizeof(u32), 3, fp);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int role_allow_write(struct role_allow *r, void *fp)
+{
+	struct role_allow *ra;
+	u32 buf[2];
+	size_t nel;
+	int rc;
+
+	nel = 0;
+	for (ra = r; ra; ra = ra->next)
+		nel++;
+	buf[0] = cpu_to_le32(nel);
+	rc = put_entry(buf, sizeof(u32), 1, fp);
+	if (rc)
+		return rc;
+	for (ra = r; ra; ra = ra->next) {
+		buf[0] = cpu_to_le32(ra->role);
+		buf[1] = cpu_to_le32(ra->new_role);
+		rc = put_entry(buf, sizeof(u32), 2, fp);
+		if (rc)
+			return rc;
+	}
+	return 0;
+}
+
+/*
+ * Write a security context structure
+ * to a policydb binary representation file.
+ */
+static int context_write(struct policydb *p, struct context *c,
+			 void *fp)
+{
+	int rc;
+	__le32 buf[3];
+
+	buf[0] = cpu_to_le32(c->user);
+	buf[1] = cpu_to_le32(c->role);
+	buf[2] = cpu_to_le32(c->type);
+
+	rc = put_entry(buf, sizeof(u32), 3, fp);
+	if (rc)
+		return rc;
+
+	rc = mls_write_range_helper(&c->range, fp);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+/*
+ * The following *_write functions are used to
+ * write the symbol data to a policy database
+ * binary representation file.
+ */
+
+static int perm_write(void *vkey, void *datum, void *fp)
+{
+	char *key = vkey;
+	struct perm_datum *perdatum = datum;
+	__le32 buf[2];
+	size_t len;
+	int rc;
+
+	len = strlen(key);
+	buf[0] = cpu_to_le32(len);
+	buf[1] = cpu_to_le32(perdatum->value);
+	rc = put_entry(buf, sizeof(u32), 2, fp);
+	if (rc)
+		return rc;
+
+	rc = put_entry(key, 1, len, fp);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int common_write(void *vkey, void *datum, void *ptr)
+{
+	char *key = vkey;
+	struct common_datum *comdatum = datum;
+	struct policy_data *pd = ptr;
+	void *fp = pd->fp;
+	__le32 buf[4];
+	size_t len;
+	int rc;
+
+	len = strlen(key);
+	buf[0] = cpu_to_le32(len);
+	buf[1] = cpu_to_le32(comdatum->value);
+	buf[2] = cpu_to_le32(comdatum->permissions.nprim);
+	buf[3] = cpu_to_le32(comdatum->permissions.table->nel);
+	rc = put_entry(buf, sizeof(u32), 4, fp);
+	if (rc)
+		return rc;
+
+	rc = put_entry(key, 1, len, fp);
+	if (rc)
+		return rc;
+
+	rc = hashtab_map(comdatum->permissions.table, perm_write, fp);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int write_cons_helper(struct policydb *p, struct constraint_node *node,
+			     void *fp)
+{
+	struct constraint_node *c;
+	struct constraint_expr *e;
+	__le32 buf[3];
+	u32 nel;
+	int rc;
+
+	for (c = node; c; c = c->next) {
+		nel = 0;
+		for (e = c->expr; e; e = e->next)
+			nel++;
+		buf[0] = cpu_to_le32(c->permissions);
+		buf[1] = cpu_to_le32(nel);
+		rc = put_entry(buf, sizeof(u32), 2, fp);
+		if (rc)
+			return rc;
+		for (e = c->expr; e; e = e->next) {
+			buf[0] = cpu_to_le32(e->expr_type);
+			buf[1] = cpu_to_le32(e->attr);
+			buf[2] = cpu_to_le32(e->op);
+			rc = put_entry(buf, sizeof(u32), 3, fp);
+			if (rc)
+				return rc;
+
+			switch (e->expr_type) {
+			case CEXPR_NAMES:
+				rc = ebitmap_write(&e->names, fp);
+				if (rc)
+					return rc;
+				break;
+			default:
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int class_write(void *vkey, void *datum, void *ptr)
+{
+	char *key = vkey;
+	struct class_datum *cladatum = datum;
+	struct policy_data *pd = ptr;
+	void *fp = pd->fp;
+	struct policydb *p = pd->p;
+	struct constraint_node *c;
+	__le32 buf[6];
+	u32 ncons;
+	size_t len, len2;
+	int rc;
+
+	len = strlen(key);
+	if (cladatum->comkey)
+		len2 = strlen(cladatum->comkey);
+	else
+		len2 = 0;
+
+	ncons = 0;
+	for (c = cladatum->constraints; c; c = c->next)
+		ncons++;
+
+	buf[0] = cpu_to_le32(len);
+	buf[1] = cpu_to_le32(len2);
+	buf[2] = cpu_to_le32(cladatum->value);
+	buf[3] = cpu_to_le32(cladatum->permissions.nprim);
+	if (cladatum->permissions.table)
+		buf[4] = cpu_to_le32(cladatum->permissions.table->nel);
+	else
+		buf[4] = 0;
+	buf[5] = cpu_to_le32(ncons);
+	rc = put_entry(buf, sizeof(u32), 6, fp);
+	if (rc)
+		return rc;
+
+	rc = put_entry(key, 1, len, fp);
+	if (rc)
+		return rc;
+
+	if (cladatum->comkey) {
+		rc = put_entry(cladatum->comkey, 1, len2, fp);
+		if (rc)
+			return rc;
+	}
+
+	rc = hashtab_map(cladatum->permissions.table, perm_write, fp);
+	if (rc)
+		return rc;
+
+	rc = write_cons_helper(p, cladatum->constraints, fp);
+	if (rc)
+		return rc;
+
+	/* write out the validatetrans rule */
+	ncons = 0;
+	for (c = cladatum->validatetrans; c; c = c->next)
+		ncons++;
+
+	buf[0] = cpu_to_le32(ncons);
+	rc = put_entry(buf, sizeof(u32), 1, fp);
+	if (rc)
+		return rc;
+
+	rc = write_cons_helper(p, cladatum->validatetrans, fp);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int role_write(void *vkey, void *datum, void *ptr)
+{
+	char *key = vkey;
+	struct role_datum *role = datum;
+	struct policy_data *pd = ptr;
+	void *fp = pd->fp;
+	struct policydb *p = pd->p;
+	__le32 buf[3];
+	size_t items, len;
+	int rc;
+
+	len = strlen(key);
+	items = 0;
+	buf[items++] = cpu_to_le32(len);
+	buf[items++] = cpu_to_le32(role->value);
+	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
+		buf[items++] = cpu_to_le32(role->bounds);
+
+	BUG_ON(items > (sizeof(buf)/sizeof(buf[0])));
+
+	rc = put_entry(buf, sizeof(u32), items, fp);
+	if (rc)
+		return rc;
+
+	rc = put_entry(key, 1, len, fp);
+	if (rc)
+		return rc;
+
+	rc = ebitmap_write(&role->dominates, fp);
+	if (rc)
+		return rc;
+
+	rc = ebitmap_write(&role->types, fp);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int type_write(void *vkey, void *datum, void *ptr)
+{
+	char *key = vkey;
+	struct type_datum *typdatum = datum;
+	struct policy_data *pd = ptr;
+	struct policydb *p = pd->p;
+	void *fp = pd->fp;
+	__le32 buf[4];
+	int rc;
+	size_t items, len;
+
+	len = strlen(key);
+	items = 0;
+	buf[items++] = cpu_to_le32(len);
+	buf[items++] = cpu_to_le32(typdatum->value);
+	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY) {
+		u32 properties = 0;
+
+		if (typdatum->primary)
+			properties |= TYPEDATUM_PROPERTY_PRIMARY;
+
+		if (typdatum->attribute)
+			properties |= TYPEDATUM_PROPERTY_ATTRIBUTE;
+
+		buf[items++] = cpu_to_le32(properties);
+		buf[items++] = cpu_to_le32(typdatum->bounds);
+	} else {
+		buf[items++] = cpu_to_le32(typdatum->primary);
+	}
+	BUG_ON(items > (sizeof(buf) / sizeof(buf[0])));
+	rc = put_entry(buf, sizeof(u32), items, fp);
+	if (rc)
+		return rc;
+
+	rc = put_entry(key, 1, len, fp);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int user_write(void *vkey, void *datum, void *ptr)
+{
+	char *key = vkey;
+	struct user_datum *usrdatum = datum;
+	struct policy_data *pd = ptr;
+	struct policydb *p = pd->p;
+	void *fp = pd->fp;
+	__le32 buf[3];
+	size_t items, len;
+	int rc;
+
+	len = strlen(key);
+	items = 0;
+	buf[items++] = cpu_to_le32(len);
+	buf[items++] = cpu_to_le32(usrdatum->value);
+	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
+		buf[items++] = cpu_to_le32(usrdatum->bounds);
+	BUG_ON(items > (sizeof(buf) / sizeof(buf[0])));
+	rc = put_entry(buf, sizeof(u32), items, fp);
+	if (rc)
+		return rc;
+
+	rc = put_entry(key, 1, len, fp);
+	if (rc)
+		return rc;
+
+	rc = ebitmap_write(&usrdatum->roles, fp);
+	if (rc)
+		return rc;
+
+	rc = mls_write_range_helper(&usrdatum->range, fp);
+	if (rc)
+		return rc;
+
+	rc = mls_write_level(&usrdatum->dfltlevel, fp);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int (*write_f[SYM_NUM]) (void *key, void *datum,
+				void *datap) =
+{
+	common_write,
+	class_write,
+	role_write,
+	type_write,
+	user_write,
+	cond_write_bool,
+	sens_write,
+	cat_write,
+};
+
+static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
+			  void *fp)
+{
+	unsigned int i, j, rc;
+	size_t nel, len;
+	__le32 buf[3];
+	u32 nodebuf[8];
+	struct ocontext *c;
+	for (i = 0; i < info->ocon_num; i++) {
+		nel = 0;
+		for (c = p->ocontexts[i]; c; c = c->next)
+			nel++;
+		buf[0] = cpu_to_le32(nel);
+		rc = put_entry(buf, sizeof(u32), 1, fp);
+		if (rc)
+			return rc;
+		for (c = p->ocontexts[i]; c; c = c->next) {
+			switch (i) {
+			case OCON_ISID:
+				buf[0] = cpu_to_le32(c->sid[0]);
+				rc = put_entry(buf, sizeof(u32), 1, fp);
+				if (rc)
+					return rc;
+				rc = context_write(p, &c->context[0], fp);
+				if (rc)
+					return rc;
+				break;
+			case OCON_FS:
+			case OCON_NETIF:
+				len = strlen(c->u.name);
+				buf[0] = cpu_to_le32(len);
+				rc = put_entry(buf, sizeof(u32), 1, fp);
+				if (rc)
+					return rc;
+				rc = put_entry(c->u.name, 1, len, fp);
+				if (rc)
+					return rc;
+				rc = context_write(p, &c->context[0], fp);
+				if (rc)
+					return rc;
+				rc = context_write(p, &c->context[1], fp);
+				if (rc)
+					return rc;
+				break;
+			case OCON_PORT:
+				buf[0] = cpu_to_le32(c->u.port.protocol);
+				buf[1] = cpu_to_le32(c->u.port.low_port);
+				buf[2] = cpu_to_le32(c->u.port.high_port);
+				rc = put_entry(buf, sizeof(u32), 3, fp);
+				if (rc)
+					return rc;
+				rc = context_write(p, &c->context[0], fp);
+				if (rc)
+					return rc;
+				break;
+			case OCON_NODE:
+				nodebuf[0] = c->u.node.addr; /* network order */
+				nodebuf[1] = c->u.node.mask; /* network order */
+				rc = put_entry(nodebuf, sizeof(u32), 2, fp);
+				if (rc)
+					return rc;
+				rc = context_write(p, &c->context[0], fp);
+				if (rc)
+					return rc;
+				break;
+			case OCON_FSUSE:
+				buf[0] = cpu_to_le32(c->v.behavior);
+				len = strlen(c->u.name);
+				buf[1] = cpu_to_le32(len);
+				rc = put_entry(buf, sizeof(u32), 2, fp);
+				if (rc)
+					return rc;
+				rc = put_entry(c->u.name, 1, len, fp);
+				if (rc)
+					return rc;
+				rc = context_write(p, &c->context[0], fp);
+				if (rc)
+					return rc;
+				break;
+			case OCON_NODE6:
+				for (j = 0; j < 4; j++)
+					nodebuf[j] = c->u.node6.addr[j]; /* network order */
+				for (j = 0; j < 4; j++)
+					nodebuf[j + 4] = c->u.node6.mask[j]; /* network order */
+				rc = put_entry(nodebuf, sizeof(u32), 8, fp);
+				if (rc)
+					return rc;
+				rc = context_write(p, &c->context[0], fp);
+				if (rc)
+					return rc;
+				break;
+			}
+		}
+	}
+	return 0;
+}
+
+static int genfs_write(struct policydb *p, void *fp)
+{
+	struct genfs *genfs;
+	struct ocontext *c;
+	size_t len;
+	__le32 buf[1];
+	int rc;
+
+	len = 0;
+	for (genfs = p->genfs; genfs; genfs = genfs->next)
+		len++;
+	buf[0] = cpu_to_le32(len);
+	rc = put_entry(buf, sizeof(u32), 1, fp);
+	if (rc)
+		return rc;
+	for (genfs = p->genfs; genfs; genfs = genfs->next) {
+		len = strlen(genfs->fstype);
+		buf[0] = cpu_to_le32(len);
+		rc = put_entry(buf, sizeof(u32), 1, fp);
+		if (rc)
+			return rc;
+		rc = put_entry(genfs->fstype, 1, len, fp);
+		if (rc)
+			return rc;
+		len = 0;
+		for (c = genfs->head; c; c = c->next)
+			len++;
+		buf[0] = cpu_to_le32(len);
+		rc = put_entry(buf, sizeof(u32), 1, fp);
+		if (rc)
+			return rc;
+		for (c = genfs->head; c; c = c->next) {
+			len = strlen(c->u.name);
+			buf[0] = cpu_to_le32(len);
+			rc = put_entry(buf, sizeof(u32), 1, fp);
+			if (rc)
+				return rc;
+			rc = put_entry(c->u.name, 1, len, fp);
+			if (rc)
+				return rc;
+			buf[0] = cpu_to_le32(c->v.sclass);
+			rc = put_entry(buf, sizeof(u32), 1, fp);
+			if (rc)
+				return rc;
+			rc = context_write(p, &c->context[0], fp);
+			if (rc)
+				return rc;
+		}
+	}
+	return 0;
+}
+
+static int range_count(void *key, void *data, void *ptr)
+{
+	int *cnt = ptr;
+	*cnt = *cnt + 1;
+
+	return 0;
+}
+
+static int range_write_helper(void *key, void *data, void *ptr)
+{
+	__le32 buf[2];
+	struct range_trans *rt = key;
+	struct mls_range *r = data;
+	struct policy_data *pd = ptr;
+	void *fp = pd->fp;
+	struct policydb *p = pd->p;
+	int rc;
+
+	buf[0] = cpu_to_le32(rt->source_type);
+	buf[1] = cpu_to_le32(rt->target_type);
+	rc = put_entry(buf, sizeof(u32), 2, fp);
+	if (rc)
+		return rc;
+	if (p->policyvers >= POLICYDB_VERSION_RANGETRANS) {
+		buf[0] = cpu_to_le32(rt->target_class);
+		rc = put_entry(buf, sizeof(u32), 1, fp);
+		if (rc)
+			return rc;
+	}
+	rc = mls_write_range_helper(r, fp);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int range_write(struct policydb *p, void *fp)
+{
+	size_t nel;
+	__le32 buf[1];
+	int rc;
+	struct policy_data pd;
+
+	pd.p = p;
+	pd.fp = fp;
+
+	/* count the number of entries in the hashtab */
+	nel = 0;
+	rc = hashtab_map(p->range_tr, range_count, &nel);
+	if (rc)
+		return rc;
+
+	buf[0] = cpu_to_le32(nel);
+	rc = put_entry(buf, sizeof(u32), 1, fp);
+	if (rc)
+		return rc;
+
+	/* actually write all of the entries */
+	rc = hashtab_map(p->range_tr, range_write_helper, &pd);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+/*
+ * Write the configuration data in a policy database
+ * structure to a policy database binary representation
+ * file.
+ */
+int policydb_write(struct policydb *p, void *fp)
+{
+	unsigned int i, num_syms;
+	int rc;
+	__le32 buf[4];
+	u32 config;
+	size_t len;
+	struct policydb_compat_info *info;
+
+	/*
+	 * refuse to write policy older than compressed avtab
+	 * to simplify the writer.  There are other tests dropped
+	 * since we assume this throughout the writer code.  Be
+	 * careful if you ever try to remove this restriction
+	 */
+	if (p->policyvers < POLICYDB_VERSION_AVTAB) {
+		printk(KERN_ERR "SELinux: refusing to write policy version %d."
+		       "  Because it is less than version %d\n", p->policyvers,
+		       POLICYDB_VERSION_AVTAB);
+		return -EINVAL;
+	}
+
+	config = 0;
+	if (p->mls_enabled)
+		config |= POLICYDB_CONFIG_MLS;
+
+	if (p->reject_unknown)
+		config |= REJECT_UNKNOWN;
+	if (p->allow_unknown)
+		config |= ALLOW_UNKNOWN;
+
+	/* Write the magic number and string identifiers. */
+	buf[0] = cpu_to_le32(POLICYDB_MAGIC);
+	len = strlen(POLICYDB_STRING);
+	buf[1] = cpu_to_le32(len);
+	rc = put_entry(buf, sizeof(u32), 2, fp);
+	if (rc)
+		return rc;
+	rc = put_entry(POLICYDB_STRING, 1, len, fp);
+	if (rc)
+		return rc;
+
+	/* Write the version, config, and table sizes. */
+	info = policydb_lookup_compat(p->policyvers);
+	if (!info) {
+		printk(KERN_ERR "SELinux: compatibility lookup failed for policy "
+		    "version %d", p->policyvers);
+		return rc;
+	}
+
+	buf[0] = cpu_to_le32(p->policyvers);
+	buf[1] = cpu_to_le32(config);
+	buf[2] = cpu_to_le32(info->sym_num);
+	buf[3] = cpu_to_le32(info->ocon_num);
+
+	rc = put_entry(buf, sizeof(u32), 4, fp);
+	if (rc)
+		return rc;
+
+	if (p->policyvers >= POLICYDB_VERSION_POLCAP) {
+		rc = ebitmap_write(&p->policycaps, fp);
+		if (rc)
+			return rc;
+	}
+
+	if (p->policyvers >= POLICYDB_VERSION_PERMISSIVE) {
+		rc = ebitmap_write(&p->permissive_map, fp);
+		if (rc)
+			return rc;
+	}
+
+	num_syms = info->sym_num;
+	for (i = 0; i < num_syms; i++) {
+		struct policy_data pd;
+
+		pd.fp = fp;
+		pd.p = p;
+
+		buf[0] = cpu_to_le32(p->symtab[i].nprim);
+		buf[1] = cpu_to_le32(p->symtab[i].table->nel);
+
+		rc = put_entry(buf, sizeof(u32), 2, fp);
+		if (rc)
+			return rc;
+		rc = hashtab_map(p->symtab[i].table, write_f[i], &pd);
+		if (rc)
+			return rc;
+	}
+
+	rc = avtab_write(p, &p->te_avtab, fp);
+	if (rc)
+		return rc;
+
+	rc = cond_write_list(p, p->cond_list, fp);
+	if (rc)
+		return rc;
+
+	rc = role_trans_write(p->role_tr, fp);
+	if (rc)
+		return rc;
+
+	rc = role_allow_write(p->role_allow, fp);
+	if (rc)
+		return rc;
+
+	rc = ocontext_write(p, info, fp);
+	if (rc)
+		return rc;
+
+	rc = genfs_write(p, fp);
+	if (rc)
+		return rc;
+
+	rc = range_write(p, fp);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < p->p_types.nprim; i++) {
+		struct ebitmap *e = flex_array_get(p->type_attr_map_array, i);
+
+		BUG_ON(!e);
+		rc = ebitmap_write(e, fp);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 310e944..95d3d7d 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -254,6 +254,9 @@ struct policydb {
 
 	struct ebitmap permissive_map;
 
+	/* length of this policy when it was loaded */
+	size_t len;
+
 	unsigned int policyvers;
 
 	unsigned int reject_unknown : 1;
@@ -270,6 +273,7 @@ extern int policydb_class_isvalid(struct policydb *p, unsigned int class);
 extern int policydb_type_isvalid(struct policydb *p, unsigned int type);
 extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
 extern int policydb_read(struct policydb *p, void *fp);
+extern int policydb_write(struct policydb *p, void *fp);
 
 #define PERM_SYMTAB_SIZE 32
 
@@ -290,6 +294,11 @@ struct policy_file {
 	size_t len;
 };
 
+struct policy_data {
+	struct policydb *p;
+	void *fp;
+};
+
 static inline int next_entry(void *buf, struct policy_file *fp, size_t bytes)
 {
 	if (bytes > fp->len)
@@ -301,6 +310,17 @@ static inline int next_entry(void *buf, struct policy_file *fp, size_t bytes)
 	return 0;
 }
 
+static inline int put_entry(void *buf, size_t bytes, int num, struct policy_file *fp)
+{
+	size_t len = bytes * num;
+
+	memcpy(fp->data, buf, len);
+	fp->data += len;
+	fp->len -= len;
+
+	return 0;
+}
+
 extern u16 string_to_security_class(struct policydb *p, const char *name);
 extern u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name);
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 494ff52..a899619 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1769,6 +1769,7 @@ int security_load_policy(void *data, size_t len)
 			return rc;
 		}
 
+		policydb.len = len;
 		rc = selinux_set_mapping(&policydb, secclass_map,
 					 &current_mapping,
 					 &current_mapping_size);
@@ -1805,6 +1806,7 @@ int security_load_policy(void *data, size_t len)
 	if (rc)
 		return rc;
 
+	newpolicydb.len = len;
 	/* If switching between different policy types, log MLS status */
 	if (policydb.mls_enabled && !newpolicydb.mls_enabled)
 		printk(KERN_INFO "SELinux: Disabling MLS support...\n");
@@ -1885,6 +1887,17 @@ err:
 
 }
 
+size_t security_policydb_len(void)
+{
+	size_t len;
+
+	read_lock(&policy_rwlock);
+	len = policydb.len;
+	read_unlock(&policy_rwlock);
+
+	return len;
+}
+
 /**
  * security_port_sid - Obtain the SID for a port.
  * @protocol: protocol number
@@ -3132,3 +3145,38 @@ netlbl_sid_to_secattr_failure:
 	return rc;
 }
 #endif /* CONFIG_NETLABEL */
+
+/**
+ * security_read_policy - read the policy.
+ * @data: binary policy data
+ * @len: length of data in bytes
+ *
+ */
+int security_read_policy(void **data, ssize_t *len)
+{
+	int rc;
+	struct policy_file fp;
+
+	if (!ss_initialized)
+		return -EINVAL;
+
+	*len = security_policydb_len();
+
+	*data = vmalloc(*len);
+	if (!*data)
+		return -ENOMEM;
+
+	fp.data = *data;
+	fp.len = *len;
+
+	read_lock(&policy_rwlock);
+	rc = policydb_write(&policydb, &fp);
+	read_unlock(&policy_rwlock);
+
+	if (rc)
+		return rc;
+
+	*len = (unsigned long)fp.data - (unsigned long)*data;
+	return 0;
+
+}


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Message-ID: <1382398322.27942.61.camel@localhost>
Subject: SELinux: Update policy version to support constraints info
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Date: Mon, 21 Oct 2013 19:32:02 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Richard Haines <richard_c_haines@btinternet.com>
Date: Tue, 18 Dec 2012 19:37:46 +0000

Update the policy version (POLICYDB_VERSION_CONSTRAINT_NAMES) to allow
holding of policy source info for constraints.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 security/selinux/include/security.h |    3 +-
 security/selinux/ss/constraint.h    |    1 +
 security/selinux/ss/policydb.c      |  100 ++++++++++++++++++++++++++++++++---
 security/selinux/ss/policydb.h      |   11 ++++
 4 files changed, 107 insertions(+), 8 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 927fc14..bdf0a56 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -33,13 +33,14 @@
 #define POLICYDB_VERSION_ROLETRANS	26
 #define POLICYDB_VERSION_NEW_OBJECT_DEFAULTS	27
 #define POLICYDB_VERSION_DEFAULT_TYPE	28
+#define POLICYDB_VERSION_CONSTRAINT_NAMES	29
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
 #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
 #define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
 #else
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_DEFAULT_TYPE
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_CONSTRAINT_NAMES
 #endif
 
 /* Mask for just the mount related flags */
diff --git a/security/selinux/ss/constraint.h b/security/selinux/ss/constraint.h
index 149dda7..3855ea8 100644
--- a/security/selinux/ss/constraint.h
+++ b/security/selinux/ss/constraint.h
@@ -48,6 +48,7 @@ struct constraint_expr {
 	u32 op;			/* operator */
 
 	struct ebitmap names;	/* names */
+	struct type_set_datum *type_names;
 
 	struct constraint_expr *next;   /* next expression */
 };
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 9cd9b7c..f1b23df 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -143,6 +143,11 @@ static struct policydb_compat_info policydb_compat[] = {
 		.sym_num	= SYM_NUM,
 		.ocon_num	= OCON_NUM,
 	},
+	{
+		.version	= POLICYDB_VERSION_CONSTRAINT_NAMES,
+		.sym_num	= SYM_NUM,
+		.ocon_num	= OCON_NUM,
+	},
 };
 
 static struct policydb_compat_info *policydb_lookup_compat(int version)
@@ -613,11 +618,20 @@ static int common_destroy(void *key, void *datum, void *p)
 	return 0;
 }
 
-static int cls_destroy(void *key, void *datum, void *p)
+static void type_set_destroy(struct type_set_datum * t)
+{
+	if (t != NULL) {
+		ebitmap_destroy(&t->types);
+		ebitmap_destroy(&t->negset);
+	}
+}
+
+static int cls_destroy(void *key, void *datum, void *datap)
 {
 	struct class_datum *cladatum;
 	struct constraint_node *constraint, *ctemp;
 	struct constraint_expr *e, *etmp;
+	struct policydb *p = datap;
 
 	kfree(key);
 	if (datum) {
@@ -629,6 +643,10 @@ static int cls_destroy(void *key, void *datum, void *p)
 			e = constraint->expr;
 			while (e) {
 				ebitmap_destroy(&e->names);
+				if (p->policyvers >= POLICYDB_VERSION_CONSTRAINT_NAMES) {
+					type_set_destroy(e->type_names);
+					kfree(e->type_names);
+				}
 				etmp = e;
 				e = e->next;
 				kfree(etmp);
@@ -643,6 +661,10 @@ static int cls_destroy(void *key, void *datum, void *p)
 			e = constraint->expr;
 			while (e) {
 				ebitmap_destroy(&e->names);
+				if (p->policyvers >= POLICYDB_VERSION_CONSTRAINT_NAMES) {
+					type_set_destroy(e->type_names);
+					kfree(e->type_names);
+				}
 				etmp = e;
 				e = e->next;
 				kfree(etmp);
@@ -775,7 +797,7 @@ void policydb_destroy(struct policydb *p)
 
 	for (i = 0; i < SYM_NUM; i++) {
 		cond_resched();
-		hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
+		hashtab_map(p->symtab[i].table, destroy_f[i], p);
 		hashtab_destroy(p->symtab[i].table);
 	}
 
@@ -1156,8 +1178,34 @@ bad:
 	return rc;
 }
 
-static int read_cons_helper(struct constraint_node **nodep, int ncons,
-			    int allowxtarget, void *fp)
+static void type_set_init(struct type_set_datum * t)
+{
+	ebitmap_init(&t->types);
+	ebitmap_init(&t->negset);
+}
+
+static int type_set_read(struct type_set_datum * t, void *fp)
+{
+	__le32 buf[1];
+	int rc;
+
+	if (ebitmap_read(&t->types, fp))
+		return -EINVAL;
+	if (ebitmap_read(&t->negset, fp))
+		return -EINVAL;
+
+	rc = next_entry(buf, fp, sizeof(u32));
+	if (rc < 0)
+		return -EINVAL;
+	t->flags = le32_to_cpu(buf[0]);
+
+	return 0;
+}
+
+
+static int read_cons_helper(struct policydb *p,
+				struct constraint_node **nodep,
+				int ncons, int allowxtarget, void *fp)
 {
 	struct constraint_node *c, *lc;
 	struct constraint_expr *e, *le;
@@ -1196,6 +1244,7 @@ static int read_cons_helper(struct constraint_node **nodep, int ncons,
 			rc = next_entry(buf, fp, (sizeof(u32) * 3));
 			if (rc)
 				return rc;
+
 			e->expr_type = le32_to_cpu(buf[0]);
 			e->attr = le32_to_cpu(buf[1]);
 			e->op = le32_to_cpu(buf[2]);
@@ -1225,6 +1274,17 @@ static int read_cons_helper(struct constraint_node **nodep, int ncons,
 				rc = ebitmap_read(&e->names, fp);
 				if (rc)
 					return rc;
+
+				if (p->policyvers >= POLICYDB_VERSION_CONSTRAINT_NAMES) {
+					e->type_names = kzalloc(sizeof(*e->type_names), GFP_KERNEL);
+					if (!e->type_names)
+						return -ENOMEM;
+
+					type_set_init(e->type_names);
+					rc = type_set_read(e->type_names, fp);
+					if (rc)
+						return rc;
+				}
 				break;
 			default:
 				return -EINVAL;
@@ -1233,6 +1293,7 @@ static int read_cons_helper(struct constraint_node **nodep, int ncons,
 		}
 		if (depth != 0)
 			return -EINVAL;
+
 		lc = c;
 	}
 
@@ -1301,7 +1362,7 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 			goto bad;
 	}
 
-	rc = read_cons_helper(&cladatum->constraints, ncons, 0, fp);
+	rc = read_cons_helper(p, &cladatum->constraints, ncons, 0, fp);
 	if (rc)
 		goto bad;
 
@@ -1311,7 +1372,7 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 		if (rc)
 			goto bad;
 		ncons = le32_to_cpu(buf[0]);
-		rc = read_cons_helper(&cladatum->validatetrans, ncons, 1, fp);
+		rc = read_cons_helper(p, &cladatum->validatetrans, ncons, 1, fp);
 		if (rc)
 			goto bad;
 	}
@@ -1339,7 +1400,7 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 
 	return 0;
 bad:
-	cls_destroy(key, cladatum, NULL);
+	cls_destroy(key, cladatum, p);
 	return rc;
 }
 
@@ -2750,6 +2811,24 @@ static int common_write(void *vkey, void *datum, void *ptr)
 	return 0;
 }
 
+static int type_set_write(struct type_set_datum * t, void *fp)
+{
+	int rc;
+	__le32 buf[1];
+
+	if (ebitmap_write(&t->types, fp))
+		return -EINVAL;
+	if (ebitmap_write(&t->negset, fp))
+		return -EINVAL;
+
+	buf[0] = cpu_to_le32(t->flags);
+	rc = put_entry(buf, sizeof(u32), 1, fp);
+	if (rc)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int write_cons_helper(struct policydb *p, struct constraint_node *node,
 			     void *fp)
 {
@@ -2781,6 +2860,13 @@ static int write_cons_helper(struct policydb *p, struct constraint_node *node,
 				rc = ebitmap_write(&e->names, fp);
 				if (rc)
 					return rc;
+
+				if (p->policyvers >= POLICYDB_VERSION_CONSTRAINT_NAMES) {
+					rc = type_set_write(e->type_names, fp);
+					if (rc)
+						return rc;
+				}
+
 				break;
 			default:
 				break;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index da63747..c0bb6cb 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -154,6 +154,17 @@ struct cond_bool_datum {
 struct cond_node;
 
 /*
+ * type set preserves data needed to determine constraint info from
+ * policy source. This is not used by the kernel policy but allows
+ * utilities such as audit2allow to determine constraint denials.
+ */
+struct type_set_datum {
+	struct ebitmap types;
+	struct ebitmap negset;
+	u32 flags;
+};
+
+/*
  * The configuration data includes security contexts for
  * initial SIDs, unlabeled file systems, TCP and UDP port numbers,
  * network interfaces, and nodes.  This structure stores the
-- 
1.7.7.6




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

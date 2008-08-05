Message-ID: <4897EB5A.1040404@ak.jp.nec.com>
Date: Tue, 05 Aug 2008 14:55:38 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: jmorris@namei.org, paul.moore@hp.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
Subject: [PATCH 1/3] Thread/Child-Domain Assignment (rev.2)
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com> <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com>
In-Reply-To: <4897E974.2040003@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[1/3] thread-context-kernel.2.patch
  It allows a multithreaded process to assign an individual
  "more bounded" security context, and it also enables to
  handle binary policy format version 24 in kernel space.

Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
--
 security/selinux/avc.c              |    2 +-
 security/selinux/hooks.c            |   12 +-
 security/selinux/include/security.h |    6 +-
 security/selinux/ss/policydb.c      |  244 +++++++++++++++++++++++++--
 security/selinux/ss/policydb.h      |    4 +
 security/selinux/ss/services.c      |  324 +++++++++++++++++++++++++++++++----
 6 files changed, 541 insertions(+), 51 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 114b4b4..cb30c7e 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -136,7 +136,7 @@ static inline int avc_hash(u32 ssid, u32 tsid, u16 tclass)
  * @tclass: target security class
  * @av: access vector
  */
-static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
+void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
 {
 	const char **common_pts = NULL;
 	u32 common_base = 0;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index bc1c3ae..2c2fad3 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5180,8 +5180,12 @@ static int selinux_setprocattr(struct task_struct *p,

 		if (sid == 0)
 			return -EINVAL;
-
-		/* Only allow single threaded processes to change context */
+		/*
+		 * SELinux allows to change context in the following case only.
+		 *  - Single threaded processes.
+		 *  - Multi threaded processes intend to change its context into
+		 *    more restricted domain (defined by TYPEBOUNDS statement).
+		 */
 		if (atomic_read(&p->mm->mm_users) != 1) {
 			struct task_struct *g, *t;
 			struct mm_struct *mm = p->mm;
@@ -5189,11 +5193,15 @@ static int selinux_setprocattr(struct task_struct *p,
 			do_each_thread(g, t) {
 				if (t->mm == mm && t != p) {
 					read_unlock(&tasklist_lock);
+					if (!security_bounded_transition(tsec->sid, sid))
+						goto boundary_ok;
+
 					return -EPERM;
 				}
 			} while_each_thread(g, t);
 			read_unlock(&tasklist_lock);
 		}
+boundary_ok:

 		/* Check permissions for the transition. */
 		error = avc_has_perm(tsec->sid, sid, SECCLASS_PROCESS,
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index ad30ac4..ef6b3db 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -27,13 +27,14 @@
 #define POLICYDB_VERSION_RANGETRANS	21
 #define POLICYDB_VERSION_POLCAP		22
 #define POLICYDB_VERSION_PERMISSIVE	23
+#define POLICYDB_VERSION_BOUNDARY	24

 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
 #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
 #define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
 #else
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_PERMISSIVE
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_BOUNDARY
 #endif

 #define CONTEXT_MNT	0x01
@@ -112,6 +113,9 @@ int security_node_sid(u16 domain, void *addr, u32 addrlen,
 int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 				 u16 tclass);

+#define POLICYDB_BOUNDS_MAXDEPTH	4
+int security_bounded_transition(u32 oldsid, u32 newsid);
+
 int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);

 int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 84f8cc7..f6eb676 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -30,6 +30,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/errno.h>
+#include <linux/audit.h>
 #include "security.h"

 #include "policydb.h"
@@ -116,7 +117,12 @@ static struct policydb_compat_info policydb_compat[] = {
 		.version	= POLICYDB_VERSION_PERMISSIVE,
 		.sym_num	= SYM_NUM,
 		.ocon_num	= OCON_NUM,
-	}
+	},
+	{
+		.version	= POLICYDB_VERSION_BOUNDARY,
+		.sym_num	= SYM_NUM,
+		.ocon_num	= OCON_NUM,
+	},
 };

 static struct policydb_compat_info *policydb_lookup_compat(int version)
@@ -254,7 +260,9 @@ static int role_index(void *key, void *datum, void *datap)

 	role = datum;
 	p = datap;
-	if (!role->value || role->value > p->p_roles.nprim)
+	if (!role->value
+	    || role->value > p->p_roles.nprim
+	    || role->bounds > p->p_roles.nprim)
 		return -EINVAL;
 	p->p_role_val_to_name[role->value - 1] = key;
 	p->role_val_to_struct[role->value - 1] = role;
@@ -270,9 +278,12 @@ static int type_index(void *key, void *datum, void *datap)
 	p = datap;

 	if (typdatum->primary) {
-		if (!typdatum->value || typdatum->value > p->p_types.nprim)
+		if (!typdatum->value
+		    || typdatum->value > p->p_types.nprim
+		    || typdatum->bounds > p->p_types.nprim)
 			return -EINVAL;
 		p->p_type_val_to_name[typdatum->value - 1] = key;
+		p->type_val_to_struct[typdatum->value - 1] = typdatum;
 	}

 	return 0;
@@ -285,7 +296,9 @@ static int user_index(void *key, void *datum, void *datap)

 	usrdatum = datum;
 	p = datap;
-	if (!usrdatum->value || usrdatum->value > p->p_users.nprim)
+	if (!usrdatum->value
+	    || usrdatum->value > p->p_users.nprim
+	    || usrdatum->bounds > p->p_users.nprim)
 		return -EINVAL;
 	p->p_user_val_to_name[usrdatum->value - 1] = key;
 	p->user_val_to_struct[usrdatum->value - 1] = usrdatum;
@@ -423,7 +436,7 @@ static int policydb_index_others(struct policydb *p)
 #endif

 	p->role_val_to_struct =
-		kmalloc(p->p_roles.nprim * sizeof(*(p->role_val_to_struct)),
+		kzalloc(p->p_roles.nprim * sizeof(*(p->role_val_to_struct)),
 			GFP_KERNEL);
 	if (!p->role_val_to_struct) {
 		rc = -ENOMEM;
@@ -431,13 +444,21 @@ static int policydb_index_others(struct policydb *p)
 	}

 	p->user_val_to_struct =
-		kmalloc(p->p_users.nprim * sizeof(*(p->user_val_to_struct)),
+		kzalloc(p->p_users.nprim * sizeof(*(p->user_val_to_struct)),
 			GFP_KERNEL);
 	if (!p->user_val_to_struct) {
 		rc = -ENOMEM;
 		goto out;
 	}

+	p->type_val_to_struct =
+		kzalloc(p->p_types.nprim * sizeof(*(p->type_val_to_struct)),
+			GFP_KERNEL);
+	if (!p->type_val_to_struct) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
 	if (cond_init_bool_indexes(p)) {
 		rc = -ENOMEM;
 		goto out;
@@ -625,6 +646,7 @@ void policydb_destroy(struct policydb *p)
 	kfree(p->class_val_to_struct);
 	kfree(p->role_val_to_struct);
 	kfree(p->user_val_to_struct);
+	kfree(p->type_val_to_struct);

 	avtab_destroy(&p->te_avtab);

@@ -1176,8 +1198,8 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
 {
 	char *key = NULL;
 	struct role_datum *role;
-	int rc;
-	__le32 buf[2];
+	int rc, to_read = 2;
+	__le32 buf[3];
 	u32 len;

 	role = kzalloc(sizeof(*role), GFP_KERNEL);
@@ -1186,12 +1208,17 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
 		goto out;
 	}

+	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
+		to_read = 3;
+
 	rc = next_entry(buf, fp, sizeof buf);
 	if (rc < 0)
 		goto bad;

 	len = le32_to_cpu(buf[0]);
 	role->value = le32_to_cpu(buf[1]);
+	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
+		role->bounds = le32_to_cpu(buf[2]);

 	key = kmalloc(len + 1, GFP_KERNEL);
 	if (!key) {
@@ -1236,8 +1263,8 @@ static int type_read(struct policydb *p, struct hashtab *h, void *fp)
 {
 	char *key = NULL;
 	struct type_datum *typdatum;
-	int rc;
-	__le32 buf[3];
+	int rc, to_read = 3;
+	__le32 buf[4];
 	u32 len;

 	typdatum = kzalloc(sizeof(*typdatum), GFP_KERNEL);
@@ -1246,13 +1273,18 @@ static int type_read(struct policydb *p, struct hashtab *h, void *fp)
 		return rc;
 	}

-	rc = next_entry(buf, fp, sizeof buf);
+	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
+		to_read = 4;
+
+	rc = next_entry(buf, fp, sizeof(buf[0]) * to_read);
 	if (rc < 0)
 		goto bad;

 	len = le32_to_cpu(buf[0]);
 	typdatum->value = le32_to_cpu(buf[1]);
 	typdatum->primary = le32_to_cpu(buf[2]);
+	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
+		typdatum->bounds = le32_to_cpu(buf[3]);

 	key = kmalloc(len + 1, GFP_KERNEL);
 	if (!key) {
@@ -1309,8 +1341,8 @@ static int user_read(struct policydb *p, struct hashtab *h, void *fp)
 {
 	char *key = NULL;
 	struct user_datum *usrdatum;
-	int rc;
-	__le32 buf[2];
+	int rc, to_read = 2;
+	__le32 buf[3];
 	u32 len;

 	usrdatum = kzalloc(sizeof(*usrdatum), GFP_KERNEL);
@@ -1319,12 +1351,17 @@ static int user_read(struct policydb *p, struct hashtab *h, void *fp)
 		goto out;
 	}

-	rc = next_entry(buf, fp, sizeof buf);
+	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
+		to_read = 3;
+
+	rc = next_entry(buf, fp, sizeof(buf[0]) * to_read);
 	if (rc < 0)
 		goto bad;

 	len = le32_to_cpu(buf[0]);
 	usrdatum->value = le32_to_cpu(buf[1]);
+	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
+		usrdatum->bounds = le32_to_cpu(buf[2]);

 	key = kmalloc(len + 1, GFP_KERNEL);
 	if (!key) {
@@ -1465,6 +1502,181 @@ static int (*read_f[SYM_NUM]) (struct policydb *p, struct hashtab *h, void *fp)
 	cat_read,
 };

+static int user_bounds_sanity_check(void *key, void *datum, void *datap)
+{
+	struct user_datum *upper, *user;
+	struct policydb *p = datap;
+	int rc, depth = 0;
+
+	upper = user = datum;
+	while (upper->bounds) {
+		struct ebitmap_node *node;
+		unsigned long bit;
+
+		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
+			printk(KERN_ERR
+			       "SELinux: user %s: too deep bounds\n",
+			       (char *) key);
+			return -EINVAL;
+		}
+
+		upper = p->user_val_to_struct[upper->bounds - 1];
+		if (!upper) {
+			printk(KERN_ERR
+			       "SELinux: user %s: broken boundary\n",
+			       (char *) key);
+			return -EINVAL;
+		}
+		/* drop bounded bit from user->roles */
+retry:
+		ebitmap_for_each_positive_bit(&user->roles, node, bit) {
+			if (ebitmap_get_bit(&upper->roles, bit))
+				continue;
+
+			audit_log(current->audit_context, GFP_KERNEL,
+				  AUDIT_SELINUX_ERR,
+				  "boundary violation: "
+				  "user=%s role=%s bounds=%s",
+				  p->p_user_val_to_name[user->value - 1],
+				  p->p_role_val_to_name[bit],
+				  p->p_user_val_to_name[upper->value - 1]);
+
+			rc = ebitmap_set_bit(&user->roles, bit, 0);
+			if (rc)
+				return rc;
+			goto retry;
+		}
+	}
+	return 0;
+}
+
+static int role_bounds_sanity_check(void *key, void *datum, void *poldbp)
+{
+	struct role_datum *upper, *role;
+	struct policydb *p = poldbp;
+	int rc, depth = 0;
+
+	upper = role = datum;
+	while (upper->bounds) {
+		struct ebitmap_node *node;
+		unsigned long bit;
+
+		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
+			printk(KERN_ERR
+			       "SELinux: role %s: too deep bounds\n",
+			       (char *) key);
+			return -EINVAL;
+		}
+
+		upper = p->role_val_to_struct[upper->bounds - 1];
+		if (!upper) {
+			printk(KERN_ERR
+			       "SELinux: role %s: broken boundary\n",
+			       (char *) key);
+			return -EINVAL;
+		}
+		/* drop bounded bit from user->roles */
+retry:
+		ebitmap_for_each_positive_bit(&role->types, node, bit) {
+			if (ebitmap_get_bit(&upper->types, bit))
+				continue;
+
+			audit_log(current->audit_context, GFP_KERNEL,
+				  AUDIT_SELINUX_ERR,
+				  "boundary violation: "
+				  "role=%s type=%s bounds=%s",
+				  p->p_role_val_to_name[role->value - 1],
+				  p->p_type_val_to_name[bit],
+				  p->p_role_val_to_name[upper->value - 1]);
+
+			rc = ebitmap_set_bit(&role->types, bit, 0);
+			if (rc)
+				return rc;
+			goto retry;
+		}
+	}
+	return 0;
+}
+
+static int type_bounds_sanity_check(void *key, void *datum, void *poldbp)
+{
+	struct type_datum *upper, *type;
+	struct policydb *p = poldbp;
+	int rc, depth = 0;
+
+	upper = type = datum;
+	while (upper->bounds) {
+		struct ebitmap *type_attrs, *upper_attrs;
+		struct ebitmap_node *node;
+		unsigned long bit;
+
+		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
+			printk(KERN_ERR
+			       "SELinux: type %s: too deep boundary\n",
+			       (char *) key);
+			return -EINVAL;
+		}
+
+		upper = p->type_val_to_struct[upper->bounds - 1];
+		if (!upper) {
+			printk(KERN_ERR
+			       "SELinux: type %s: broken boundary\n",
+			       (char *) key);
+			return -EINVAL;
+		}
+		/* drop bounded bit from type_attr_map */
+retry:
+		type_attrs = &p->type_attr_map[type->value - 1];
+		upper_attrs = &p->type_attr_map[upper->value - 1];
+		ebitmap_for_each_positive_bit(type_attrs, node, bit) {
+			if (type->value == bit + 1)
+				continue;
+
+			if (ebitmap_get_bit(upper_attrs, bit))
+				continue;
+
+			audit_log(current->audit_context, GFP_KERNEL,
+				  AUDIT_SELINUX_ERR,
+				  "boundary violation: "
+				  "type=%s attribute=%lu bounds=%s",
+				  p->p_type_val_to_name[type->value - 1],
+				  bit + 1,
+				  p->p_type_val_to_name[upper->value - 1]);
+
+			rc = ebitmap_set_bit(type_attrs, bit, 0);
+			if (rc)
+				return rc;
+			goto retry;
+		}
+	}
+	return 0;
+}
+
+static int policydb_bounds_sanity_check(struct policydb *p)
+{
+	int rc;
+
+	if (p->policyvers < POLICYDB_VERSION_BOUNDARY)
+		return 0;
+
+	rc = hashtab_map(p->p_users.table,
+			 user_bounds_sanity_check, p);
+	if (rc)
+		return rc;
+
+	rc = hashtab_map(p->p_roles.table,
+			 role_bounds_sanity_check, p);
+	if (rc)
+		return rc;
+
+	rc = hashtab_map(p->p_types.table,
+			 type_bounds_sanity_check, p);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
 extern int ss_initialized;

 /*
@@ -1960,6 +2172,10 @@ int policydb_read(struct policydb *p, void *fp)
 				goto bad;
 	}

+	rc = policydb_bounds_sanity_check(p);
+	if (rc)
+		goto bad;
+
 	rc = 0;
 out:
 	return rc;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 4253370..320fa23 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -61,6 +61,7 @@ struct class_datum {
 /* Role attributes */
 struct role_datum {
 	u32 value;			/* internal role value */
+	u32 bounds;			/* boundary of role */
 	struct ebitmap dominates;	/* set of roles dominated by this role */
 	struct ebitmap types;		/* set of authorized types for role */
 };
@@ -81,12 +82,14 @@ struct role_allow {
 /* Type attributes */
 struct type_datum {
 	u32 value;		/* internal type value */
+	u32 bounds;		/* boundary of type */
 	unsigned char primary;	/* primary name? */
 };

 /* User attributes */
 struct user_datum {
 	u32 value;			/* internal user value */
+	u32 bounds;			/* bounds of user */
 	struct ebitmap roles;		/* set of authorized roles for user */
 	struct mls_range range;		/* MLS range (min - max) for user */
 	struct mls_level dfltlevel;	/* default login MLS level for user */
@@ -209,6 +212,7 @@ struct policydb {
 	struct class_datum **class_val_to_struct;
 	struct role_datum **role_val_to_struct;
 	struct user_datum **user_val_to_struct;
+	struct type_datum **type_val_to_struct;

 	/* type enforcement access vectors and transitions */
 	struct avtab te_avtab;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index dcc2e1c..a584c1d 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -95,6 +95,8 @@ static u32 latest_granting;
 /* Forward declaration. */
 static int context_struct_to_string(struct context *context, char **scontext,
 				    u32 *scontext_len);
+static void security_bounded_permission(u16 source_type, u16 target_type,
+					u16 tclass, struct av_decision *avd);

 /*
  * Return the boolean value of a constraint expression
@@ -107,6 +109,81 @@ static int context_struct_to_string(struct context *context, char **scontext,
  * of the process performing the transition.  All other callers of
  * constraint_expr_eval should pass in NULL for xcontext.
  */
+static int cexpr_user_names_eval(struct ebitmap *names, u16 user_value)
+{
+	struct user_datum *user
+		= policydb.user_val_to_struct[user_value - 1];
+	int bit;
+
+	while (true) {
+		bit = ebitmap_get_bit(names, user->value - 1);
+		if (!bit) {
+			if (user->value != user_value)
+				audit_log(current->audit_context,
+					  GFP_ATOMIC, AUDIT_SELINUX_ERR,
+					  "boundary violation: "
+					  "user=%s bounds=%s",
+					  policydb.p_user_val_to_name[user_value - 1],
+					  policydb.p_user_val_to_name[user->value - 1]);
+			break;
+		}
+		if (!user->bounds)
+			break;
+		user = policydb.user_val_to_struct[user->bounds - 1];
+	}
+	return bit;
+}
+
+static int cexpr_role_names_eval(struct ebitmap *names, u16 role_value)
+{
+	struct role_datum *role
+		= policydb.role_val_to_struct[role_value - 1];
+	int bit;
+
+	while (true) {
+		bit = ebitmap_get_bit(names, role->value - 1);
+		if (!bit) {
+			if (role->value != role_value)
+				audit_log(current->audit_context,
+					  GFP_ATOMIC, AUDIT_SELINUX_ERR,
+					  "boundary violation: "
+					  "role=%s bounds=%s",
+					  policydb.p_role_val_to_name[role_value - 1],
+					  policydb.p_role_val_to_name[role->value - 1]);
+			break;
+		}
+		if (!role->bounds)
+			break;
+		role = policydb.role_val_to_struct[role->bounds - 1];
+	}
+	return bit;
+}
+
+static int cexpr_type_names_eval(struct ebitmap *names, u16 type_value)
+{
+	struct type_datum *type
+		= policydb.type_val_to_struct[type_value - 1];
+	int bit;
+
+	while (1) {
+		bit = ebitmap_get_bit(names, type->value - 1);
+		if (!bit) {
+			if (type->value != type_value)
+				audit_log(current->audit_context,
+					  GFP_ATOMIC, AUDIT_SELINUX_ERR,
+					  "boundary violation: "
+					  "type=%s bounded=%s",
+					  policydb.p_type_val_to_name[type_value - 1],
+					  policydb.p_type_val_to_name[type->value - 1]);
+			break;
+		}
+		if (!type->bounds)
+			break;
+		type = policydb.type_val_to_struct[type->bounds - 1];
+	}
+	return bit;
+}
+
 static int constraint_expr_eval(struct context *scontext,
 				struct context *tcontext,
 				struct context *xcontext,
@@ -118,6 +195,7 @@ static int constraint_expr_eval(struct context *scontext,
 	struct mls_level *l1, *l2;
 	struct constraint_expr *e;
 	int s[CEXPR_MAXDEPTH];
+	int bit;
 	int sp = -1;

 	for (e = cexpr; e; e = e->next) {
@@ -249,11 +327,14 @@ mls_ops:
 				}
 			}
 			if (e->attr & CEXPR_USER)
-				val1 = c->user;
+				bit = cexpr_user_names_eval(&e->names,
+							    c->user);
 			else if (e->attr & CEXPR_ROLE)
-				val1 = c->role;
+				bit = cexpr_role_names_eval(&e->names,
+							    c->role);
 			else if (e->attr & CEXPR_TYPE)
-				val1 = c->type;
+				bit = cexpr_type_names_eval(&e->names,
+							    c->type);
 			else {
 				BUG();
 				return 0;
@@ -261,10 +342,10 @@ mls_ops:

 			switch (e->op) {
 			case CEXPR_EQ:
-				s[++sp] = ebitmap_get_bit(&e->names, val1 - 1);
+				s[++sp] = bit;
 				break;
 			case CEXPR_NEQ:
-				s[++sp] = !ebitmap_get_bit(&e->names, val1 - 1);
+				s[++sp] = !bit;
 				break;
 			default:
 				BUG();
@@ -281,6 +362,44 @@ mls_ops:
 	return s[0];
 }

+static void type_attribute_compute_av(u16 source_type,
+				      u16 target_type,
+				      u16 tclass,
+				      u16 specified,
+				      struct av_decision *avd)
+{
+	struct avtab_key avkey;
+	struct avtab_node *node;
+	struct ebitmap *sattr, *tattr;
+	struct ebitmap_node *snode, *tnode;
+	unsigned int sbit, tbit;
+
+	avkey.target_class = tclass;
+	avkey.specified = specified & AVTAB_AV;
+	sattr = &policydb.type_attr_map[source_type - 1];
+	tattr = &policydb.type_attr_map[target_type - 1];
+
+	ebitmap_for_each_positive_bit(sattr, snode, sbit) {
+		ebitmap_for_each_positive_bit(tattr, tnode, tbit) {
+			avkey.source_type = sbit + 1;
+			avkey.target_type = tbit + 1;
+
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
+			/* Check conditional av table for additional permissions */
+			cond_compute_av(&policydb.te_cond_avtab, &avkey, avd);
+		}
+	}
+}
+
 /*
  * Compute access vectors based on a context structure pair for
  * the permissions in a particular class.
@@ -293,13 +412,8 @@ static int context_struct_compute_av(struct context *scontext,
 {
 	struct constraint_node *constraint;
 	struct role_allow *ra;
-	struct avtab_key avkey;
-	struct avtab_node *node;
 	struct class_datum *tclass_datum;
-	struct ebitmap *sattr, *tattr;
-	struct ebitmap_node *snode, *tnode;
 	const struct selinux_class_perm *kdefs = &selinux_class_perm;
-	unsigned int i, j;

 	/*
 	 * Remap extended Netlink classes for old policy versions.
@@ -355,30 +469,13 @@ static int context_struct_compute_av(struct context *scontext,
 	 * If a specific type enforcement rule was defined for
 	 * this permission check, then use it.
 	 */
-	avkey.target_class = tclass;
-	avkey.specified = AVTAB_AV;
-	sattr = &policydb.type_attr_map[scontext->type - 1];
-	tattr = &policydb.type_attr_map[tcontext->type - 1];
-	ebitmap_for_each_positive_bit(sattr, snode, i) {
-		ebitmap_for_each_positive_bit(tattr, tnode, j) {
-			avkey.source_type = i + 1;
-			avkey.target_type = j + 1;
-			for (node = avtab_search_node(&policydb.te_avtab, &avkey);
-			     node != NULL;
-			     node = avtab_search_node_next(node, avkey.specified)) {
-				if (node->key.specified == AVTAB_ALLOWED)
-					avd->allowed |= node->datum.data;
-				else if (node->key.specified == AVTAB_AUDITALLOW)
-					avd->auditallow |= node->datum.data;
-				else if (node->key.specified == AVTAB_AUDITDENY)
-					avd->auditdeny &= node->datum.data;
-			}
+	type_attribute_compute_av(scontext->type,
+				  tcontext->type,
+				  tclass, AVTAB_AV, avd);

-			/* Check conditional av table for additional permissions */
-			cond_compute_av(&policydb.te_cond_avtab, &avkey, avd);
-
-		}
-	}
+	security_bounded_permission(scontext->type,
+				    tcontext->type,
+				    tclass, avd);

 	/*
 	 * Remove any permissions prohibited by a constraint (this includes
@@ -547,6 +644,167 @@ out:
 	return rc;
 }

+extern void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av);
+
+/*
+ * security_boundary_permission - drops violated permissions
+ * on boundary constraint.
+ */
+static void security_bounded_permission(u16 source_type,
+					u16 target_type,
+					u16 tclass,
+					struct av_decision *avd)
+{
+	struct type_datum *source
+		= policydb.type_val_to_struct[source_type - 1];
+	struct type_datum *target
+		= policydb.type_val_to_struct[target_type - 1];
+	struct av_decision lo_avd;
+	u32 masked = 0;
+
+	if (source->bounds) {
+		memset(&lo_avd, 0, sizeof(lo_avd));
+
+		type_attribute_compute_av(source->bounds,
+					  target_type,
+					  tclass,
+					  AVTAB_ALLOWED,
+					  &lo_avd);
+
+		security_bounded_permission(source->bounds,
+					    target_type,
+					    tclass, &lo_avd);
+
+		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
+			return;		/* no masked permission */
+		masked = ~lo_avd.allowed & avd->allowed;
+	}
+
+	if (target->bounds) {
+		memset(&lo_avd, 0, sizeof(lo_avd));
+
+		type_attribute_compute_av(source_type,
+					  target->bounds,
+					  tclass,
+					  AVTAB_ALLOWED,
+					  &lo_avd);
+
+		security_bounded_permission(source_type,
+					    target->bounds,
+					    tclass, &lo_avd);
+
+		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
+			return;		/* no masked permission */
+		masked = ~lo_avd.allowed & avd->allowed;
+	}
+
+	if (source->bounds && target->bounds) {
+		memset(&lo_avd, 0, sizeof(lo_avd));
+
+		type_attribute_compute_av(source->bounds,
+					  target->bounds,
+					  tclass,
+					  AVTAB_ALLOWED,
+					  &lo_avd);
+
+		security_bounded_permission(source->bounds,
+					    target->bounds,
+					    tclass, &lo_avd);
+
+		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
+			return;		/* no masked permission */
+		masked = ~lo_avd.allowed & avd->allowed;
+	}
+
+	if (masked) {
+		struct audit_buffer *ab;
+
+		/* mask violated permissions */
+		avd->allowed &= ~masked;
+
+		/* notice to userspace via audit message */
+		ab = audit_log_start(current->audit_context,
+				     GFP_ATOMIC, AUDIT_SELINUX_ERR);
+		if (!ab)
+			return;
+
+		audit_log_format(ab, "boundary violation: "
+				 "source=%s target=%s tclass=%s",
+				 policydb.p_type_val_to_name[source_type - 1],
+				 policydb.p_type_val_to_name[target_type - 1],
+				 policydb.p_class_val_to_name[tclass - 1]);
+		avc_dump_av(ab, tclass, masked);
+		audit_log_end(ab);
+	}
+}
+
+/*
+ * security_bounded_transition - check whether the given
+ * transition is directed to bounded, or not.
+ * It returns 0, if @newsid is bounded by @oldsid. Otherwise,
+ * 1 or any other error code can be returned.
+ *
+ * @oldsid : current security identifier
+ * @newsid : destinated security identifier
+ */
+int security_bounded_transition(u32 old_sid, u32 new_sid)
+{
+	struct context *old_context, *new_context;
+	struct type_datum *type;
+	int index;
+	int rc = -EINVAL;
+
+	read_lock(&policy_rwlock);
+
+	old_context = sidtab_search(&sidtab, old_sid);
+	if (!old_context) {
+		printk(KERN_ERR "SELinux: %s: unrecognized SID %u\n",
+		       __func__, old_sid);
+		goto out;
+	}
+
+	new_context = sidtab_search(&sidtab, new_sid);
+	if (!new_context) {
+		printk(KERN_ERR "SELinux: %s: unrecognized SID %u\n",
+		       __func__, new_sid);
+		goto out;
+	}
+
+	/* type/domain unchaned */
+	if (old_context->type == new_context->type) {
+		rc = 0;
+		goto out;
+	}
+
+	index = new_context->type;
+	while (true) {
+		type = policydb.type_val_to_struct[index - 1];
+		if (!type) {
+			printk(KERN_ERR "SELinux: broken type boundary.\n");
+			rc = -EINVAL;
+			break;
+		}
+
+		/* not bounded anymore */
+		if (!type->bounds) {
+			rc = 1;
+			break;
+		}
+
+		/* @newsid is bounded by @oldsid */
+		if (type->bounds == old_context->type) {
+			rc = 0;
+			break;
+		}
+		index = type->bounds;
+	}
+out:
+	read_unlock(&policy_rwlock);
+
+	return rc;
+}
+
+
 /**
  * security_compute_av - Compute access vector decisions.
  * @ssid: source security identifier

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

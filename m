From: Eric Paris <eparis@redhat.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: allow default source/target selectors for user/role/range
Date: Tue,  6 Mar 2012 19:28:48 -0500
Message-Id: <1331080128-26425-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When new objects are created we have great and flexible rules to
determine the type of the new object.  We aren't quite as flexible or
mature when it comes to determining the user, role, and range.  This
patch adds a new ability to specify the place a new objects user, role,
and range should come from.  For users and roles it can come from either
the source or the target of the operation.  aka for files the user can
either come from the source (the running process and todays default) or
it can come from the target (aka the parent directory of the new file)

examples always are done with
directory context: system_u:object_r:mnt_t:s0-s0:c0.c512
process context: unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023

[no rule]
	unconfined_u:object_r:mnt_t:s0   test_none
[default user source]
	unconfined_u:object_r:mnt_t:s0   test_user_source
[default user target]
	system_u:object_r:mnt_t:s0       test_user_target
[default role source]
	unconfined_u:unconfined_r:mnt_t:s0 test_role_source
[default role target]
	unconfined_u:object_r:mnt_t:s0   test_role_target
[default range source low]
	unconfined_u:object_r:mnt_t:s0 test_range_source_low
[default range source high]
	unconfined_u:object_r:mnt_t:s0:c0.c1023 test_range_source_high
[default range source low-high]
	unconfined_u:object_r:mnt_t:s0-s0:c0.c1023 test_range_source_low-high
[default range target low]
	unconfined_u:object_r:mnt_t:s0 test_range_target_low
[default range target high]
	unconfined_u:object_r:mnt_t:s0:c0.c512 test_range_target_high
[default range target low-high]
	unconfined_u:object_r:mnt_t:s0-s0:c0.c512 test_range_target_low-high

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/include/security.h |    3 ++-
 security/selinux/ss/context.h       |   20 ++++++++++++++++++++
 security/selinux/ss/mls.c           |   19 +++++++++++++++++++
 security/selinux/ss/policydb.c      |   25 +++++++++++++++++++++++++
 security/selinux/ss/policydb.h      |   13 +++++++++++++
 security/selinux/ss/services.c      |   32 +++++++++++++++++++++++---------
 6 files changed, 102 insertions(+), 10 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index d871e8a..ba53400 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -31,13 +31,14 @@
 #define POLICYDB_VERSION_BOUNDARY	24
 #define POLICYDB_VERSION_FILENAME_TRANS	25
 #define POLICYDB_VERSION_ROLETRANS	26
+#define POLICYDB_VERSION_NEW_OBJECT_DEFAULTS	27
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
 #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
 #define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
 #else
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_ROLETRANS
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_NEW_OBJECT_DEFAULTS
 #endif
 
 /* Mask for just the mount related flags */
diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
index 45e8fb0..212e347 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -74,6 +74,26 @@ out:
 	return rc;
 }
 
+/*
+ * Sets both levels in the MLS range of 'dst' to the high level of 'src'.
+ */
+static inline int mls_context_cpy_high(struct context *dst, struct context *src)
+{
+	int rc;
+
+	dst->range.level[0].sens = src->range.level[1].sens;
+	rc = ebitmap_cpy(&dst->range.level[0].cat, &src->range.level[1].cat);
+	if (rc)
+		goto out;
+
+	dst->range.level[1].sens = src->range.level[1].sens;
+	rc = ebitmap_cpy(&dst->range.level[1].cat, &src->range.level[1].cat);
+	if (rc)
+		ebitmap_destroy(&dst->range.level[0].cat);
+out:
+	return rc;
+}
+
 static inline int mls_context_cmp(struct context *c1, struct context *c2)
 {
 	return ((c1->range.level[0].sens == c2->range.level[0].sens) &&
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index fbf9c58..2e3013d 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -517,6 +517,7 @@ int mls_compute_sid(struct context *scontext,
 {
 	struct range_trans rtr;
 	struct mls_range *r;
+	struct class_datum *cladatum;
 
 	if (!policydb.mls_enabled)
 		return 0;
@@ -530,6 +531,24 @@ int mls_compute_sid(struct context *scontext,
 		r = hashtab_search(policydb.range_tr, &rtr);
 		if (r)
 			return mls_range_set(newcontext, r);
+
+		cladatum = policydb.class_val_to_struct[tclass - 1];
+
+		switch (cladatum->default_range) {
+		case DEFAULT_SOURCE_LOW:
+			return mls_context_cpy_low(newcontext, scontext);
+		case DEFAULT_SOURCE_HIGH:
+			return mls_context_cpy_high(newcontext, scontext);
+		case DEFAULT_SOURCE_LOW_HIGH:
+			return mls_context_cpy(newcontext, scontext);
+		case DEFAULT_TARGET_LOW:
+			return mls_context_cpy_low(newcontext, tcontext);
+		case DEFAULT_TARGET_HIGH:
+			return mls_context_cpy_high(newcontext, tcontext);
+		case DEFAULT_TARGET_LOW_HIGH:
+			return mls_context_cpy(newcontext, tcontext);
+		}
+
 		/* Fallthrough */
 	case AVTAB_CHANGE:
 		if ((tclass == policydb.process_class) || (sock == true))
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index a7f61d5..2bb9c2f 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -133,6 +133,11 @@ static struct policydb_compat_info policydb_compat[] = {
 		.sym_num	= SYM_NUM,
 		.ocon_num	= OCON_NUM,
 	},
+	{
+		.version	= POLICYDB_VERSION_NEW_OBJECT_DEFAULTS,
+		.sym_num	= SYM_NUM,
+		.ocon_num	= OCON_NUM,
+	},
 };
 
 static struct policydb_compat_info *policydb_lookup_compat(int version)
@@ -1306,6 +1311,16 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 			goto bad;
 	}
 
+	if (p->policyvers >= POLICYDB_VERSION_NEW_OBJECT_DEFAULTS) {
+		rc = next_entry(buf, fp, sizeof(u32) * 3);
+		if (rc)
+			goto bad;
+
+		cladatum->default_user = le32_to_cpu(buf[0]);
+		cladatum->default_role = le32_to_cpu(buf[1]);
+		cladatum->default_range = le32_to_cpu(buf[2]);
+	}
+
 	rc = hashtab_insert(h, key, cladatum);
 	if (rc)
 		goto bad;
@@ -2832,6 +2847,16 @@ static int class_write(void *vkey, void *datum, void *ptr)
 	if (rc)
 		return rc;
 
+	if (p->policyvers >= POLICYDB_VERSION_NEW_OBJECT_DEFAULTS) {
+		buf[0] = cpu_to_le32(cladatum->default_user);
+		buf[1] = cpu_to_le32(cladatum->default_role);
+		buf[2] = cpu_to_le32(cladatum->default_range);
+
+		rc = put_entry(buf, sizeof(uint32_t), 3, fp);
+		if (rc)
+			return rc;
+	}
+
 	return 0;
 }
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index b846c03..a949f1a 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -60,6 +60,19 @@ struct class_datum {
 	struct symtab permissions;	/* class-specific permission symbol table */
 	struct constraint_node *constraints;	/* constraints on class permissions */
 	struct constraint_node *validatetrans;	/* special transition rules */
+	/* Options how a new object user and role should be decided */
+#define DEFAULT_SOURCE         1
+#define DEFAULT_TARGET         2
+	char default_user;
+	char default_role;
+/* Options how a new object range should be decided */
+#define DEFAULT_SOURCE_LOW     1
+#define DEFAULT_SOURCE_HIGH    2
+#define DEFAULT_SOURCE_LOW_HIGH        3
+#define DEFAULT_TARGET_LOW     4
+#define DEFAULT_TARGET_HIGH    5
+#define DEFAULT_TARGET_LOW_HIGH        6
+	char default_range;
 };
 
 /* Role attributes */
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 185f849..579c8b0 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1389,6 +1389,7 @@ static int security_compute_sid(u32 ssid,
 				u32 *out_sid,
 				bool kern)
 {
+	struct class_datum *cladatum;
 	struct context *scontext = NULL, *tcontext = NULL, newcontext;
 	struct role_trans *roletr = NULL;
 	struct avtab_key avkey;
@@ -1437,12 +1438,17 @@ static int security_compute_sid(u32 ssid,
 		goto out_unlock;
 	}
 
+	cladatum = policydb.class_val_to_struct[tclass - 1];
 	/* Set the user identity. */
 	switch (specified) {
 	case AVTAB_TRANSITION:
 	case AVTAB_CHANGE:
-		/* Use the process user identity. */
-		newcontext.user = scontext->user;
+		if (cladatum->default_user == DEFAULT_TARGET)
+			/* Use the process user identity. */
+			newcontext.user = tcontext->user;
+		else
+			/* notice this gets both DEFAULT_SOURCE and unset */
+			newcontext.user = scontext->user;
 		break;
 	case AVTAB_MEMBER:
 		/* Use the related object owner. */
@@ -1450,17 +1456,25 @@ static int security_compute_sid(u32 ssid,
 		break;
 	}
 
-	/* Set the role and type to default values. */
-	if ((tclass == policydb.process_class) || (sock == true)) {
-		/* Use the current role and type of process. */
+	/* Set the role to default values. */
+	if (cladatum->default_role == DEFAULT_SOURCE) {
 		newcontext.role = scontext->role;
-		newcontext.type = scontext->type;
+	} else if (cladatum->default_role == DEFAULT_TARGET) {
+		newcontext.role = tcontext->role;
 	} else {
-		/* Use the well-defined object role. */
-		newcontext.role = OBJECT_R_VAL;
+		if ((tclass == policydb.process_class) || (sock == true))
+			newcontext.role = scontext->role;
+		else
+			newcontext.role = OBJECT_R_VAL;
+	}
+
+	/* Set the type to default values. */
+	if ((tclass == policydb.process_class) || (sock == true))
+		/* Use the type of process. */
+		newcontext.type = scontext->type;
+	else
 		/* Use the type of the related object. */
 		newcontext.type = tcontext->type;
-	}
 
 	/* Look for a type transition/member/change rule. */
 	avkey.source_type = scontext->type;
-- 
1.7.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

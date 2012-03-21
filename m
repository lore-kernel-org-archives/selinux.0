From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH 2/2] SELinux: add default_type statements
Date: Wed, 21 Mar 2012 10:04:59 -0400
Message-Id: <1332338699-16839-2-git-send-email-eparis@redhat.com>
In-Reply-To: <1332338699-16839-1-git-send-email-eparis@redhat.com>
References: <1332338699-16839-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Because Fedora shipped userspace based on my development tree we now
have policy version 27 in the wild defining only default user, role, and
range.  Thus to add default_type we need a policy.28.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/include/security.h |    3 ++-
 security/selinux/ss/policydb.c      |   19 +++++++++++++++++++
 security/selinux/ss/policydb.h      |    3 ++-
 security/selinux/ss/services.c      |   14 ++++++++++----
 4 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index ba53400..dde2005 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -32,13 +32,14 @@
 #define POLICYDB_VERSION_FILENAME_TRANS	25
 #define POLICYDB_VERSION_ROLETRANS	26
 #define POLICYDB_VERSION_NEW_OBJECT_DEFAULTS	27
+#define POLICYDB_VERSION_DEFAULT_TYPE	28
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
 #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
 #define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
 #else
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_NEW_OBJECT_DEFAULTS
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_DEFAULT_TYPE
 #endif
 
 /* Mask for just the mount related flags */
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 2bb9c2f..9cd9b7c 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -138,6 +138,11 @@ static struct policydb_compat_info policydb_compat[] = {
 		.sym_num	= SYM_NUM,
 		.ocon_num	= OCON_NUM,
 	},
+	{
+		.version	= POLICYDB_VERSION_DEFAULT_TYPE,
+		.sym_num	= SYM_NUM,
+		.ocon_num	= OCON_NUM,
+	},
 };
 
 static struct policydb_compat_info *policydb_lookup_compat(int version)
@@ -1321,6 +1326,13 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 		cladatum->default_range = le32_to_cpu(buf[2]);
 	}
 
+	if (p->policyvers >= POLICYDB_VERSION_DEFAULT_TYPE) {
+		rc = next_entry(buf, fp, sizeof(u32) * 1);
+		if (rc)
+			goto bad;
+		cladatum->default_type = le32_to_cpu(buf[0]);
+	}
+
 	rc = hashtab_insert(h, key, cladatum);
 	if (rc)
 		goto bad;
@@ -2857,6 +2869,13 @@ static int class_write(void *vkey, void *datum, void *ptr)
 			return rc;
 	}
 
+	if (p->policyvers >= POLICYDB_VERSION_DEFAULT_TYPE) {
+		buf[0] = cpu_to_le32(cladatum->default_type);
+		rc = put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (rc)
+			return rc;
+	}
+
 	return 0;
 }
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index a949f1a..da63747 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -60,11 +60,12 @@ struct class_datum {
 	struct symtab permissions;	/* class-specific permission symbol table */
 	struct constraint_node *constraints;	/* constraints on class permissions */
 	struct constraint_node *validatetrans;	/* special transition rules */
-	/* Options how a new object user and role should be decided */
+/* Options how a new object user, role, and type should be decided */
 #define DEFAULT_SOURCE         1
 #define DEFAULT_TARGET         2
 	char default_user;
 	char default_role;
+	char default_type;
 /* Options how a new object range should be decided */
 #define DEFAULT_SOURCE_LOW     1
 #define DEFAULT_SOURCE_HIGH    2
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 2ea108c..1ded0ec 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1472,12 +1472,18 @@ static int security_compute_sid(u32 ssid,
 	}
 
 	/* Set the type to default values. */
-	if ((tclass == policydb.process_class) || (sock == true)) {
-		/* Use the type of process. */
+	if (cladatum && cladatum->default_type == DEFAULT_SOURCE) {
 		newcontext.type = scontext->type;
-	} else {
-		/* Use the type of the related object. */
+	} else if (cladatum && cladatum->default_type == DEFAULT_TARGET) {
 		newcontext.type = tcontext->type;
+	} else {
+		if ((tclass == policydb.process_class) || (sock == true)) {
+			/* Use the type of process. */
+			newcontext.type = scontext->type;
+		} else {
+			/* Use the type of the related object. */
+			newcontext.type = tcontext->type;
+		}
 	}
 
 	/* Look for a type transition/member/change rule. */
-- 
1.7.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

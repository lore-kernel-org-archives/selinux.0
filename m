Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t97N8oRx016009
 for <selinux@tycho.nsa.gov>; Wed, 7 Oct 2015 19:08:51 -0400
Subject: [RFC PATCH v3 4/5] selinux: introduce kdbus names into the policy
From: Paul Moore <pmoore@redhat.com>
To: linux-security-module@vger.kernel.org, linux-audit@redhat.com,
 selinux@tycho.nsa.gov
Cc: Paul Osmialowski <p.osmialowsk@samsung.com>
Date: Wed, 07 Oct 2015 19:08:42 -0400
Message-ID: <20151007230842.7823.70790.stgit@localhost>
In-Reply-To: <20151007230615.7823.74519.stgit@localhost>
References: <20151007230615.7823.74519.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

SELinux treats kdbus service names as objects and therefore needs a
mechanism to map service names to security labels.  This patch adds
support for loading kdbus name/label matches with the security policy.

The patch supports service name prefix matching to lessen the burden
on the policy developers and reduce the size of the resulting policy.

Signed-off-by: Paul Moore <pmoore@redhat.com>

---
ChangeLog:
- v3
 * Ported to the 4.3-rc4 based kdbus tree, v2 hacks removed
- v2
 * Porting needed to work with ioctl xperms
- v1
 * Initial draft
---
 security/selinux/include/security.h |    5 ++
 security/selinux/ss/policydb.c      |   88 +++++++++++++++++++++++++++++------
 security/selinux/ss/policydb.h      |    3 +
 security/selinux/ss/services.c      |   38 +++++++++++++++
 4 files changed, 116 insertions(+), 18 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 6a681d2..339b32b 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -36,13 +36,14 @@
 #define POLICYDB_VERSION_DEFAULT_TYPE	28
 #define POLICYDB_VERSION_CONSTRAINT_NAMES	29
 #define POLICYDB_VERSION_XPERMS_IOCTL	30
+#define POLICYDB_VERSION_KDBUS		31
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
 #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
 #define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
 #else
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_XPERMS_IOCTL
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_KDBUS
 #endif
 
 /* Mask for just the mount related flags */
@@ -212,6 +213,8 @@ int security_fs_use(struct super_block *sb);
 int security_genfs_sid(const char *fstype, char *name, u16 sclass,
 	u32 *sid);
 
+int security_kdbus_sid(const char *name, u32 *sid);
+
 #ifdef CONFIG_NETLABEL
 int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 				   u32 *sid);
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 992a315..9be2e6d 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -76,81 +76,86 @@ static struct policydb_compat_info policydb_compat[] = {
 	{
 		.version	= POLICYDB_VERSION_BASE,
 		.sym_num	= SYM_NUM - 3,
-		.ocon_num	= OCON_NUM - 1,
+		.ocon_num	= OCON_NUM - 2,
 	},
 	{
 		.version	= POLICYDB_VERSION_BOOL,
 		.sym_num	= SYM_NUM - 2,
-		.ocon_num	= OCON_NUM - 1,
+		.ocon_num	= OCON_NUM - 2,
 	},
 	{
 		.version	= POLICYDB_VERSION_IPV6,
 		.sym_num	= SYM_NUM - 2,
-		.ocon_num	= OCON_NUM,
+		.ocon_num	= OCON_NUM - 1,
 	},
 	{
 		.version	= POLICYDB_VERSION_NLCLASS,
 		.sym_num	= SYM_NUM - 2,
-		.ocon_num	= OCON_NUM,
+		.ocon_num	= OCON_NUM - 1,
 	},
 	{
 		.version	= POLICYDB_VERSION_MLS,
 		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM,
+		.ocon_num	= OCON_NUM - 1,
 	},
 	{
 		.version	= POLICYDB_VERSION_AVTAB,
 		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM,
+		.ocon_num	= OCON_NUM - 1,
 	},
 	{
 		.version	= POLICYDB_VERSION_RANGETRANS,
 		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM,
+		.ocon_num	= OCON_NUM - 1,
 	},
 	{
 		.version	= POLICYDB_VERSION_POLCAP,
 		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM,
+		.ocon_num	= OCON_NUM - 1,
 	},
 	{
 		.version	= POLICYDB_VERSION_PERMISSIVE,
 		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM,
+		.ocon_num	= OCON_NUM - 1,
 	},
 	{
 		.version	= POLICYDB_VERSION_BOUNDARY,
 		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM,
+		.ocon_num	= OCON_NUM - 1,
 	},
 	{
 		.version	= POLICYDB_VERSION_FILENAME_TRANS,
 		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM,
+		.ocon_num	= OCON_NUM - 1,
 	},
 	{
 		.version	= POLICYDB_VERSION_ROLETRANS,
 		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM,
+		.ocon_num	= OCON_NUM - 1,
 	},
 	{
 		.version	= POLICYDB_VERSION_NEW_OBJECT_DEFAULTS,
 		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM,
+		.ocon_num	= OCON_NUM - 1,
 	},
 	{
 		.version	= POLICYDB_VERSION_DEFAULT_TYPE,
 		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM,
+		.ocon_num	= OCON_NUM - 1,
 	},
 	{
 		.version	= POLICYDB_VERSION_CONSTRAINT_NAMES,
 		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM,
+		.ocon_num	= OCON_NUM - 1,
 	},
 	{
 		.version	= POLICYDB_VERSION_XPERMS_IOCTL,
 		.sym_num	= SYM_NUM,
+		.ocon_num	= OCON_NUM - 1,
+	},
+	{
+		.version	= POLICYDB_VERSION_KDBUS,
+		.sym_num	= SYM_NUM,
 		.ocon_num	= OCON_NUM,
 	},
 };
@@ -2111,7 +2116,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
 	int i, j, rc;
 	u32 nel, len;
 	__le32 buf[3];
-	struct ocontext *l, *c;
+	struct ocontext *l, *l2, *c;
 	u32 nodebuf[8];
 
 	for (i = 0; i < info->ocon_num; i++) {
@@ -2130,6 +2135,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
 				l->next = c;
 			else
 				p->ocontexts[i] = c;
+			l2 = l;
 			l = c;
 
 			switch (i) {
@@ -2219,6 +2225,43 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
 					goto out;
 				break;
 			}
+			case OCON_KDBUS: {
+				struct ocontext *iter, *last;
+				u32 len2;
+
+				rc = next_entry(buf, fp, sizeof(u32));
+				if (rc)
+					goto out;
+				len = le32_to_cpu(buf[0]);
+				rc = str_read(&c->u.name, GFP_KERNEL, fp, len);
+				if (rc)
+					goto out;
+				rc = context_read_and_validate(&c->context[0], p, fp);
+				if (rc) {
+					kfree(c->u.name);
+					goto out;
+				}
+
+				/* sort by ->u.name length, longest first */
+				last = NULL;
+				iter = p->ocontexts[OCON_KDBUS];
+				while (iter != c) {
+					len2 = strlen(iter->u.name);
+					if (len > len2) {
+						if (l2)
+							l2->next = NULL;
+						c->next = iter;
+						if (last == NULL)
+							p->ocontexts[i] = c;
+						else
+							last->next = c;
+						break;
+					}
+					last = iter;
+					iter = iter->next;
+				}
+				break;
+			}
 			}
 		}
 	}
@@ -3147,6 +3190,19 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
 				if (rc)
 					return rc;
 				break;
+			case OCON_KDBUS:
+				len = strlen(c->u.name);
+				buf[0] = cpu_to_le32(len);
+				rc = put_entry(buf, sizeof(u32), 1, fp);
+				if (rc)
+					return rc;
+				rc = put_entry(c->u.name, len, 1, fp);
+				if (rc)
+					return rc;
+				rc = context_write(p, &c->context[0], fp);
+				if (rc)
+					return rc;
+				break;
 			}
 		}
 	}
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 725d594..ee9c120 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -222,7 +222,8 @@ struct genfs {
 #define OCON_NODE  4	/* nodes */
 #define OCON_FSUSE 5	/* fs_use */
 #define OCON_NODE6 6	/* IPv6 nodes */
-#define OCON_NUM   7
+#define OCON_KDBUS 7	/* kdbus names */
+#define OCON_NUM   8
 
 /* The policy database */
 struct policydb {
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index b7df12b..ada2d28 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2536,6 +2536,44 @@ int security_genfs_sid(const char *fstype,
 }
 
 /**
+ * security_kdbus_sid - Obtain a SID for a kdbus name
+ * @name: kdbus name
+ * @sid: SID for the kdbus name
+ *
+ * Obtain a SID for the given kdbus service name.  Returns zero on success,
+ * negative values on error.
+ */
+int security_kdbus_sid(const char *name, u32 *sid)
+{
+	int rc = 0;
+	struct ocontext *c;
+
+	read_lock(&policy_rwlock);
+
+	c = policydb.ocontexts[OCON_KDBUS];
+	while (c) {
+		if (strncmp(c->u.name, name, strlen(c->u.name)) == 0)
+			break;
+		c = c->next;
+	}
+
+	if (c) {
+		if (!c->sid[0]) {
+			rc = sidtab_context_to_sid(&sidtab,
+						   &c->context[0], &c->sid[0]);
+			if (rc)
+				goto out;
+		}
+		*sid = c->sid[0];
+	} else
+		*sid = SECINITSID_UNLABELED;
+
+out:
+	read_unlock(&policy_rwlock);
+	return rc;
+}
+
+/**
  * security_fs_use - Determine how to handle labeling for a filesystem.
  * @sb: superblock in question
  */

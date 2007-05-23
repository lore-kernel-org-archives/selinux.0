From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: sds@tycho.nsa.gov, jmorris@redhat.com, eparis@redhat.com
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: [PATCH 1/4] selinux: add support for querying object classes and permissions from the running policy
Date: Wed, 23 May 2007 09:12:06 -0400
Message-Id: <11799259343624-git-send-email-cpebenito@tresys.com>
In-Reply-To: <1179925929721-git-send-email-cpebenito@tresys.com>
References: <1179925929721-git-send-email-cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Christopher J. PeBenito <cpebenito@tresys.com>

Add support to the SELinux security server for obtaining a list of classes,
and for obtaining a list of permissions for a specified class.

Signed-off-by: Christopher J. PeBenito <cpebenito@tresys.com>

---
 security/selinux/include/security.h |    3 +
 security/selinux/ss/services.c      |   95 +++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 0 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index b94378a..731a173 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -87,6 +87,9 @@ int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 
 int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
 
+int security_get_classes(char ***classes, int *nclasses);
+int security_get_permissions(char *class, char ***perms, int *nperms);
+
 #define SECURITY_FS_USE_XATTR		1 /* use xattr */
 #define SECURITY_FS_USE_TRANS		2 /* use transition SIDs, e.g. devpts/tmpfs */
 #define SECURITY_FS_USE_TASK		3 /* use task SIDs, e.g. pipefs/sockfs */
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 40660ff..a1909bf 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1996,6 +1996,101 @@ out:
 	return rc;
 }
 
+static int get_classes_callback(void *k, void *d, void *args)
+{
+	struct class_datum *datum = d;
+	char *name = k, **classes = args;
+	int value = datum->value - 1;
+
+	classes[value] = kstrdup(name, GFP_ATOMIC);
+	if (!classes[value])
+		return -ENOMEM;
+
+	return 0;
+}
+
+int security_get_classes(char ***classes, int *nclasses)
+{
+	int rc = -ENOMEM;
+
+	POLICY_RDLOCK;
+
+	*nclasses = policydb.p_classes.nprim;
+	*classes = kcalloc(*nclasses, sizeof(*classes), GFP_ATOMIC);
+	if (!*classes)
+		goto out;
+
+	rc = hashtab_map(policydb.p_classes.table, get_classes_callback,
+			*classes);
+	if (rc < 0) {
+		int i;
+		for (i = 0; i < *nclasses; i++)
+			kfree((*classes)[i]);
+		kfree(*classes);
+	}
+	
+out:
+	POLICY_RDUNLOCK;
+	return rc;
+}
+
+static int get_permissions_callback(void *k, void *d, void *args)
+{
+	struct perm_datum *datum = d;
+	char *name = k, **perms = args;
+	int value = datum->value - 1;
+
+	perms[value] = kstrdup(name, GFP_ATOMIC);
+	if (!perms[value])
+		return -ENOMEM;
+
+	return 0;
+}
+
+int security_get_permissions(char *class, char ***perms, int *nperms)
+{
+	int rc = -ENOMEM, i;
+	struct class_datum *match;
+
+	POLICY_RDLOCK;
+
+	match = hashtab_search(policydb.p_classes.table, class);
+	if (!match) {
+		printk(KERN_ERR "%s:  unrecognized class %s\n",
+			__FUNCTION__, class);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	*nperms = match->permissions.nprim;
+	*perms = kcalloc(*nperms, sizeof(*perms), GFP_ATOMIC);
+	if (!*perms)
+		goto out;
+
+	if (match->comdatum) {
+		rc = hashtab_map(match->comdatum->permissions.table,
+				get_permissions_callback, *perms);
+		if (rc < 0)
+			goto err;
+	}
+
+	rc = hashtab_map(match->permissions.table, get_permissions_callback,
+			*perms);
+	if (rc < 0)
+		goto err;
+
+out:
+	POLICY_RDUNLOCK;
+	return rc;
+
+err:
+	POLICY_RDUNLOCK;
+	for (i = 0; i < *nperms; i++)
+		kfree((*perms)[i]);
+	kfree(*perms);
+	return rc;
+}
+
 struct selinux_audit_rule {
 	u32 au_seqno;
 	struct context au_ctxt;
-- 
1.5.1.6


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

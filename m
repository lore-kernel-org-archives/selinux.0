From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: special dontaudit for access checks
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov
Date: Tue, 27 Apr 2010 15:57:42 -0400
Message-ID: <20100427195741.3759.51155.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently there are a number of applications (nautilus being the main one) which
calls access() on files in order to determine how they should be displayed.  It
is normal and expected that nautilus will want to see if files are executable
or if they are really read/write-able.  access() should return the real
permission.  SELinux policy checks are done in access() and can result in lots
of AVC denials as policy denies RWX on files which DAC allows.  Currently
SELinux must dontaudit actual attempts to read/write/execute a file in
order to silence these messages (and not flood the logs.)  But dontaudit rules
like that can hide real attacks.  This patch addes a new common file
permission audit_access.  This permission is special in that it is meaningless
and should never show up in an allow rule.  Instead the only place this
permission has meaning is in a dontaudit rule like so:

dontaudit nautilus_t sbin_t:file audit_access

With such a rule if nautilus just checks access() we will still get denied and
thus userspace will still get the correct answer but we will not log the denial.
If nautilus attempted to actually perform one of the forbidden actions
(rather than just querying access(2) about it) we would still log a denial.
This type of dontaudit rule should be used sparingly, as it could be a
method for an attacker to probe the system permissions without detection.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 include/linux/lsm_audit.h           |    1 +
 security/selinux/avc.c              |   17 ++++++++++++++---
 security/selinux/hooks.c            |   18 +++++++++++++-----
 security/selinux/include/classmap.h |    2 +-
 4 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index f78f83d..ce62294 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -87,6 +87,7 @@ struct common_audit_data {
 			u32 ssid;
 			u32 tsid;
 			u16 tclass;
+			bool from_access;	/* was this from access(2) ? */
 			u32 requested;
 			u32 audited;
 			u32 denied;
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 989fef8..48b5fa4 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -489,9 +489,20 @@ void avc_audit(u32 ssid, u32 tsid,
 	struct common_audit_data stack_data;
 	u32 denied, audited;
 	denied = requested & ~avd->allowed;
-	if (denied)
-		audited = denied & avd->auditdeny;
-	else if (result)
+	if (denied) {
+		/*
+		 * If this check came from the access(2) syscall and there was
+		 * an explicit rule in policy like:
+		 *	dontaudit source dest : file { audit_access }
+		 * Then don't audit this sucker.
+		 */
+		if (a &&
+		    a->selinux_audit_data.from_access &&
+		    !(avd->auditdeny & FILE__AUDIT_ACCESS))
+			audited = 0;
+		else
+			audited = denied & avd->auditdeny;
+	} else if (result)
 		audited = denied = requested;
 	else
 		audited = requested & avd->auditallow;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 47c86f4..972ba00 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2698,16 +2698,24 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct nameidata *na
 static int selinux_inode_permission(struct inode *inode, int mask)
 {
 	const struct cred *cred = current_cred();
+	struct common_audit_data ad;
+	u32 perms;
+	bool from_access;
 
+	from_access = mask & MAY_ACCESS;
 	mask &= (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND);
 
-	if (!mask) {
-		/* No permission to check.  Existence test. */
+	/* No permission to check.  Existence test. */
+	if (!mask)
 		return 0;
-	}
 
-	return inode_has_perm(cred, inode,
-			      file_mask_to_av(inode->i_mode, mask), NULL);
+	COMMON_AUDIT_DATA_INIT(&ad, FS);
+	ad.u.fs.inode = inode;
+	ad.selinux_audit_data.from_access = from_access;
+
+	perms = file_mask_to_av(inode->i_mode, mask);
+
+	return inode_has_perm(cred, inode, perms, &ad);
 }
 
 static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 8b32e95..d64603e 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -2,7 +2,7 @@
     "getattr", "setattr", "lock", "relabelfrom", "relabelto", "append"
 
 #define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link", \
-    "rename", "execute", "swapon", "quotaon", "mounton"
+    "rename", "execute", "swapon", "quotaon", "mounton", "audit_access"
 
 #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
     "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

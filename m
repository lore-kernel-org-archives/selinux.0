From: Eric Paris <eparis@redhat.com>
Subject: [PATCH -v3] SELinux: special dontaudit for access checks
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Mon, 03 May 2010 18:29:31 -0400
Message-ID: <20100503222931.9662.9780.stgit@paris.rdu.redhat.com>
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

 include/linux/lsm_audit.h           |    5 +++++
 security/selinux/avc.c              |   24 ++++++++++++++++++++++--
 security/selinux/hooks.c            |   20 +++++++++++++++-----
 security/selinux/include/classmap.h |    2 +-
 4 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 6907251..788f0ab 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -90,6 +90,11 @@ struct common_audit_data {
 			u32 requested;
 			u32 audited;
 			u32 denied;
+			/*
+			 * auditdeny is a bit tricky and unintuitive.  See the
+			 * comments in avc.c for it's meaning and usage.
+			 */
+			u32 auditdeny;
 			struct av_decision *avd;
 			int result;
 		} selinux_audit_data;
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 7f1a304..64e7fec 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -489,9 +489,29 @@ void avc_audit(u32 ssid, u32 tsid,
 	struct common_audit_data stack_data;
 	u32 denied, audited;
 	denied = requested & ~avd->allowed;
-	if (denied)
+	if (denied) {
 		audited = denied & avd->auditdeny;
-	else if (result)
+		/*
+		 * a->selinux_audit_data.auditdeny it TRICKY!  Setting a bit in
+		 * this field means that ANY denials should NOT be audited if
+		 * the policy contains an explicit dontaudit rule for that
+		 * permission.  Take notice that this is unrelated to the
+		 * actual permissions that were denied.  As an example lets
+		 * assume:
+		 *
+		 * denied == READ
+		 * avd.auditdeny & ACCESS == 0 (not set means explicit rule)
+		 * selinux_audit_data.auditdeny & ACCESS == 1
+		 *
+		 * We will NOT audit the denial even though the denied
+		 * permission was READ and the auditdeny checks were for
+		 * ACCESS
+		 */
+		if (a &&
+		    a->selinux_audit_data.auditdeny &&
+		    !(a->selinux_audit_data.auditdeny & avd->auditdeny))
+			audited = 0;
+	} else if (result)
 		audited = denied = requested;
 	else
 		audited = requested & avd->auditallow;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f48010d..09f1f6d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2698,16 +2698,26 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct nameidata *na
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
+
+	if (from_access)
+		ad.selinux_audit_data.auditdeny |= FILE__AUDIT_ACCESS;
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

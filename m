Subject: [PATCH] selinux:  enable processes with mac_admin to get the raw
	inode contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain
Date: Wed, 21 May 2008 14:16:12 -0400
Message-Id: <1211393772.7486.392.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Enable processes with CAP_MAC_ADMIN + mac_admin permission in policy
to get undefined contexts on inodes.  This extends the support for
deferred mapping of security contexts in order to permit restorecon
and similar programs to see the raw file contexts unknown to the
system policy in order to check them.


Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/hooks.c |   27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4be1563..91b666a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2754,9 +2754,7 @@ static int selinux_inode_removexattr(struct dentry *dentry, const char *name)
 }
 
 /*
- * Copy the in-core inode security context value to the user.  If the
- * getxattr() prior to this succeeded, check to see if we need to
- * canonicalize the value to be finally returned to the user.
+ * Copy the inode security context value to the user.
  *
  * Permission check is handled by selinux_inode_getxattr hook.
  */
@@ -2765,12 +2763,33 @@ static int selinux_inode_getsecurity(const struct inode *inode, const char *name
 	u32 size;
 	int error;
 	char *context = NULL;
+	struct task_security_struct *tsec = current->security;
 	struct inode_security_struct *isec = inode->i_security;
 
 	if (strcmp(name, XATTR_SELINUX_SUFFIX))
 		return -EOPNOTSUPP;
 
-	error = security_sid_to_context(isec->sid, &context, &size);
+	/*
+	 * If the caller has CAP_MAC_ADMIN, then get the raw context
+	 * value even if it is not defined by current policy; otherwise,
+	 * use the in-core value under current policy.
+	 * Use the non-auditing forms of the permission checks since
+	 * getxattr may be called by unprivileged processes commonly
+	 * and lack of permission just means that we fall back to the
+	 * in-core context value, not a denial.
+	 */
+	error = secondary_ops->capable(current, CAP_MAC_ADMIN);
+	if (!error)
+		error = avc_has_perm_noaudit(tsec->sid, tsec->sid,
+					     SECCLASS_CAPABILITY2,
+					     CAPABILITY2__MAC_ADMIN,
+					     0,
+					     NULL);
+	if (!error)
+		error = security_sid_to_context_force(isec->sid, &context,
+						      &size);
+	else
+		error = security_sid_to_context(isec->sid, &context, &size);
 	if (error)
 		return error;
 	error = size;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

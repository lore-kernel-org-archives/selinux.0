Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9T0lfPi011960
 for <selinux@tycho.nsa.gov>; Wed, 28 Oct 2015 20:47:43 -0400
From: Andreas Gruenbacher <agruenba@redhat.com>
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v4 2/7] security: Make inode argument of inode_getsecurity
 non-const
Date: Thu, 29 Oct 2015 01:47:10 +0100
Message-Id: <1446079635-22462-3-git-send-email-agruenba@redhat.com>
In-Reply-To: <1446079635-22462-1-git-send-email-agruenba@redhat.com>
References: <1446079635-22462-1-git-send-email-agruenba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Make the inode argument of the inode_getsecurity hook non-const so that
we can use it to revalidate invalid security labels.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 include/linux/lsm_hooks.h  | 2 +-
 include/linux/security.h   | 4 ++--
 security/security.c        | 2 +-
 security/selinux/hooks.c   | 2 +-
 security/smack/smack_lsm.c | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ec3a6ba..bdd0a3a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1413,7 +1413,7 @@ union security_list_options {
 	int (*inode_removexattr)(struct dentry *dentry, const char *name);
 	int (*inode_need_killpriv)(struct dentry *dentry);
 	int (*inode_killpriv)(struct dentry *dentry);
-	int (*inode_getsecurity)(const struct inode *inode, const char *name,
+	int (*inode_getsecurity)(struct inode *inode, const char *name,
 					void **buffer, bool alloc);
 	int (*inode_setsecurity)(struct inode *inode, const char *name,
 					const void *value, size_t size,
diff --git a/include/linux/security.h b/include/linux/security.h
index 2f4c1f7..9ee61b2 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -270,7 +270,7 @@ int security_inode_listxattr(struct dentry *dentry);
 int security_inode_removexattr(struct dentry *dentry, const char *name);
 int security_inode_need_killpriv(struct dentry *dentry);
 int security_inode_killpriv(struct dentry *dentry);
-int security_inode_getsecurity(const struct inode *inode, const char *name, void **buffer, bool alloc);
+int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
 void security_inode_getsecid(const struct inode *inode, u32 *secid);
@@ -719,7 +719,7 @@ static inline int security_inode_killpriv(struct dentry *dentry)
 	return cap_inode_killpriv(dentry);
 }
 
-static inline int security_inode_getsecurity(const struct inode *inode, const char *name, void **buffer, bool alloc)
+static inline int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index 46f405c..73514c9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -697,7 +697,7 @@ int security_inode_killpriv(struct dentry *dentry)
 	return call_int_hook(inode_killpriv, 0, dentry);
 }
 
-int security_inode_getsecurity(const struct inode *inode, const char *name, void **buffer, bool alloc)
+int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fc8f626..adec2e2 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3110,7 +3110,7 @@ static int selinux_inode_removexattr(struct dentry *dentry, const char *name)
  *
  * Permission check is handled by selinux_inode_getxattr hook.
  */
-static int selinux_inode_getsecurity(const struct inode *inode, const char *name, void **buffer, bool alloc)
+static int selinux_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
 {
 	u32 size;
 	int error;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 996c889..07d0344 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1435,7 +1435,7 @@ static int smack_inode_removexattr(struct dentry *dentry, const char *name)
  *
  * Returns the size of the attribute or an error code
  */
-static int smack_inode_getsecurity(const struct inode *inode,
+static int smack_inode_getsecurity(struct inode *inode,
 				   const char *name, void **buffer,
 				   bool alloc)
 {
-- 
2.5.0

Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3QJUoHO010214
 for <selinux@tycho.nsa.gov>; Tue, 26 Apr 2016 15:30:54 -0400
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 Richard Weinberger <richard.weinberger@gmail.com>,
 Austin S Hemmelgarn <ahferroin7@gmail.com>,
 Miklos Szeredi <mszeredi@redhat.com>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
 dm-devel@redhat.com, linux-raid@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.sourceforge.net,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 cgroups@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH v4 14/21] fs: Allow superblock owner to change ownership of
 inodes with unmappable ids
Date: Tue, 26 Apr 2016 14:30:37 -0500
Message-Id: <1461699046-30485-15-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1461699046-30485-1-git-send-email-seth.forshee@canonical.com>
References: <1461699046-30485-1-git-send-email-seth.forshee@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In a userns mount some on-disk inodes may have ids which do not
map into s_user_ns, in which case the in-kernel inodes are owned
by invalid users. The superblock owner should be able to change
attributes of these inodes but cannot. However it is unsafe to
grant the superblock owner privileged access to all inodes in the
superblock since proc, sysfs, etc. use DAC to protect files which
may not belong to s_user_ns. The problem is restricted to only
inodes where the owner or group is an invalid user.

We can work around this by allowing users with CAP_CHOWN in
s_user_ns to change an invalid owner or group id, so long as the
other id is either invalid or mappable in s_user_ns. After
changing ownership the user will be privileged towards the inode
and thus able to change other attributes.

As an precaution, checks for invalid ids are added to the proc
and kernfs setattr interfaces. These filesystems are not expected
to have inodes with invalid ids, but if it does happen any
setattr operations will return -EPERM.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
---
 fs/attr.c             | 62 ++++++++++++++++++++++++++++++++++++++++++++-------
 fs/kernfs/inode.c     |  2 ++
 fs/proc/base.c        |  2 ++
 fs/proc/generic.c     |  3 +++
 fs/proc/proc_sysctl.c |  2 ++
 5 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 3cfaaac4a18e..06bb3f401559 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -16,6 +16,58 @@
 #include <linux/evm.h>
 #include <linux/ima.h>
 
+static bool chown_ok(const struct inode *inode, kuid_t uid)
+{
+	struct user_namespace *user_ns;
+
+	if (uid_eq(current_fsuid(), inode->i_uid) && uid_eq(uid, inode->i_uid))
+		return true;
+	if (capable_wrt_inode_uidgid(inode, CAP_CHOWN))
+		return true;
+
+	/*
+	 * Inode uids/gids are of type kuid_t/kgid_t. As such, they can be
+	 * a) INVALID_UID/INVALID_GID, b) valid and mappable into
+	 * i_sb->s_user_ns, or c) valid but not mappable into
+	 * i_sb->s_user_ns.
+	 *
+	 * For filesystems on user-supplied media ids will either be (a) or
+	 * (b), so we permit CAP_CHOWN in s_user_ns to change INVALID_UID if
+	 * the gid meets these conditions (and vice versa for INVALID_GID).
+	 *
+	 * For psuedo-filesystems like proc or sysfs ids will be either (b)
+	 * or (c), so these conditions do not permit namespace-root to chown
+	 * in those filesystems.
+	 */
+	user_ns = inode->i_sb->s_user_ns;
+	if (!uid_valid(inode->i_uid) &&
+	    (!gid_valid(inode->i_gid) || kgid_has_mapping(user_ns, inode->i_gid)) &&
+	    ns_capable(user_ns, CAP_CHOWN))
+		return true;
+
+	return false;
+}
+
+static bool chgrp_ok(const struct inode *inode, kgid_t gid)
+{
+	struct user_namespace *user_ns;
+
+	if (uid_eq(current_fsuid(), inode->i_uid) &&
+	    (in_group_p(gid) || gid_eq(gid, inode->i_gid)))
+		return true;
+	if (capable_wrt_inode_uidgid(inode, CAP_CHOWN))
+		return true;
+
+	/* Logic here is the same as in chown_ok(); see comment there. */
+	user_ns = inode->i_sb->s_user_ns;
+	if (!gid_valid(inode->i_gid) &&
+	    (!uid_valid(inode->i_uid) || kuid_has_mapping(user_ns, inode->i_uid)) &&
+	    ns_capable(user_ns, CAP_CHOWN))
+		return true;
+
+	return false;
+}
+
 /**
  * inode_change_ok - check if attribute changes to an inode are allowed
  * @inode:	inode to check
@@ -58,17 +110,11 @@ int inode_change_ok(const struct inode *inode, struct iattr *attr)
 		return 0;
 
 	/* Make sure a caller can chown. */
-	if ((ia_valid & ATTR_UID) &&
-	    (!uid_eq(current_fsuid(), inode->i_uid) ||
-	     !uid_eq(attr->ia_uid, inode->i_uid)) &&
-	    !capable_wrt_inode_uidgid(inode, CAP_CHOWN))
+	if ((ia_valid & ATTR_UID) && !chown_ok(inode, attr->ia_uid))
 		return -EPERM;
 
 	/* Make sure caller can chgrp. */
-	if ((ia_valid & ATTR_GID) &&
-	    (!uid_eq(current_fsuid(), inode->i_uid) ||
-	    (!in_group_p(attr->ia_gid) && !gid_eq(attr->ia_gid, inode->i_gid))) &&
-	    !capable_wrt_inode_uidgid(inode, CAP_CHOWN))
+	if ((ia_valid & ATTR_GID) && !chgrp_ok(inode, attr->ia_gid))
 		return -EPERM;
 
 	/* Make sure a caller can chmod. */
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 16405ae88d2d..2e97a337ee5f 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -117,6 +117,8 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
 
 	if (!kn)
 		return -EINVAL;
+	if (!uid_valid(inode->i_uid) || !gid_valid(inode->i_gid))
+		return -EPERM;
 
 	mutex_lock(&kernfs_mutex);
 	error = inode_change_ok(inode, iattr);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index b1755b23893e..648d623e2158 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -711,6 +711,8 @@ int proc_setattr(struct dentry *dentry, struct iattr *attr)
 
 	if (attr->ia_valid & ATTR_MODE)
 		return -EPERM;
+	if (!uid_valid(inode->i_uid) || !gid_valid(inode->i_gid))
+		return -EPERM;
 
 	error = inode_change_ok(inode, attr);
 	if (error)
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index ff3ffc76a937..1461570c552c 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -105,6 +105,9 @@ static int proc_notify_change(struct dentry *dentry, struct iattr *iattr)
 	struct proc_dir_entry *de = PDE(inode);
 	int error;
 
+	if (!uid_valid(inode->i_uid) || !gid_valid(inode->i_gid))
+		return -EPERM;
+
 	error = inode_change_ok(inode, iattr);
 	if (error)
 		return error;
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index fe5b6e6c4671..f5d575157194 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -752,6 +752,8 @@ static int proc_sys_setattr(struct dentry *dentry, struct iattr *attr)
 
 	if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
 		return -EPERM;
+	if (!uid_valid(inode->i_uid) || !gid_valid(inode->i_gid))
+		return -EPERM;
 
 	error = inode_change_ok(inode, attr);
 	if (error)
-- 
2.7.4

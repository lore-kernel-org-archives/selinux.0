Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB2FgWlQ006648
 for <selinux@tycho.nsa.gov>; Wed, 2 Dec 2015 10:42:45 -0500
Received: by igcto18 with SMTP id to18so34147084igc.0
 for <selinux@tycho.nsa.gov>; Wed, 02 Dec 2015 07:42:27 -0800 (PST)
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Serge Hallyn <serge.hallyn@canonical.com>
Cc: Richard Weinberger <richard.weinberger@gmail.com>,
 Austin S Hemmelgarn <ahferroin7@gmail.com>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-bcache@vger.kernel.org,
 dm-devel@redhat.com, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH 11/19] fs: Ensure the mounter of a filesystem is privileged
 towards its inodes
Date: Wed,  2 Dec 2015 09:40:11 -0600
Message-Id: <1449070821-73820-12-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1449070821-73820-1-git-send-email-seth.forshee@canonical.com>
References: <1449070821-73820-1-git-send-email-seth.forshee@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The mounter of a filesystem should be privileged towards the
inodes of that filesystem. Extend the checks in
inode_owner_or_capable() and capable_wrt_inode_uidgid() to
permit access by users priviliged in the user namespace of the
inode's superblock.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 fs/inode.c          |  3 +++
 kernel/capability.c | 13 +++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 1be5f9003eb3..01c036fe1950 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1962,6 +1962,9 @@ bool inode_owner_or_capable(const struct inode *inode)
 	ns = current_user_ns();
 	if (ns_capable(ns, CAP_FOWNER) && kuid_has_mapping(ns, inode->i_uid))
 		return true;
+
+	if (ns_capable(inode->i_sb->s_user_ns, CAP_FOWNER))
+		return true;
 	return false;
 }
 EXPORT_SYMBOL(inode_owner_or_capable);
diff --git a/kernel/capability.c b/kernel/capability.c
index 45432b54d5c6..5137a38a5670 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -437,13 +437,18 @@ EXPORT_SYMBOL(file_ns_capable);
  *
  * Return true if the current task has the given capability targeted at
  * its own user namespace and that the given inode's uid and gid are
- * mapped into the current user namespace.
+ * mapped into the current user namespace, or if the current task has
+ * the capability towards the user namespace of the inode's superblock.
  */
 bool capable_wrt_inode_uidgid(const struct inode *inode, int cap)
 {
-	struct user_namespace *ns = current_user_ns();
+	struct user_namespace *ns;
 
-	return ns_capable(ns, cap) && kuid_has_mapping(ns, inode->i_uid) &&
-		kgid_has_mapping(ns, inode->i_gid);
+	ns = current_user_ns();
+	if (ns_capable(ns, cap) && kuid_has_mapping(ns, inode->i_uid) &&
+	    kgid_has_mapping(ns, inode->i_gid))
+		return true;
+
+	return ns_capable(inode->i_sb->s_user_ns, cap);
 }
 EXPORT_SYMBOL(capable_wrt_inode_uidgid);
-- 
1.9.1

Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3MFdlDZ004476
 for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2016 11:39:48 -0400
Received: by mail-ob0-f169.google.com with SMTP id bg3so50698382obb.1
 for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2016 08:39:13 -0700 (PDT)
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>
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
Subject: [PATCH v3 10/21] fs: Check for invalid i_uid in may_follow_link()
Date: Fri, 22 Apr 2016 10:38:27 -0500
Message-Id: <1461339521-123191-11-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1461339521-123191-1-git-send-email-seth.forshee@canonical.com>
References: <1461339521-123191-1-git-send-email-seth.forshee@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Filesystem uids which don't map into a user namespace may result
in inode->i_uid being INVALID_UID. A symlink and its parent
could have different owners in the filesystem can both get
mapped to INVALID_UID, which may result in following a symlink
when this would not have otherwise been permitted when protected
symlinks are enabled.

Add a new helper function, uid_valid_eq(), and use this to
validate that the ids in may_follow_link() are both equal and
valid. Also add an equivalent helper for gids, which is
currently unused.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
---
 fs/namei.c             |  2 +-
 include/linux/uidgid.h | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index a29094c6f4a1..6fe8b0d8ca90 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -915,7 +915,7 @@ static inline int may_follow_link(struct nameidata *nd)
 		return 0;
 
 	/* Allowed if parent directory and link owner match. */
-	if (uid_eq(parent->i_uid, inode->i_uid))
+	if (uid_valid_eq(parent->i_uid, inode->i_uid))
 		return 0;
 
 	if (nd->flags & LOOKUP_RCU)
diff --git a/include/linux/uidgid.h b/include/linux/uidgid.h
index 03835522dfcb..e09529fe2668 100644
--- a/include/linux/uidgid.h
+++ b/include/linux/uidgid.h
@@ -117,6 +117,16 @@ static inline bool gid_valid(kgid_t gid)
 	return __kgid_val(gid) != (gid_t) -1;
 }
 
+static inline bool uid_valid_eq(kuid_t left, kuid_t right)
+{
+	return uid_eq(left, right) && uid_valid(left);
+}
+
+static inline bool gid_valid_eq(kgid_t left, kgid_t right)
+{
+	return gid_eq(left, right) && gid_valid(left);
+}
+
 #ifdef CONFIG_USER_NS
 
 extern kuid_t make_kuid(struct user_namespace *from, uid_t uid);
-- 
1.9.1

Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3MFdlDU004476
 for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2016 11:39:47 -0400
Received: by mail-oi0-f48.google.com with SMTP id p188so136863738oih.2
 for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2016 08:39:19 -0700 (PDT)
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
Subject: [PATCH v3 12/21] fs: Refuse uid/gid changes which don't map into
 s_user_ns
Date: Fri, 22 Apr 2016 10:38:29 -0500
Message-Id: <1461339521-123191-13-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1461339521-123191-1-git-send-email-seth.forshee@canonical.com>
References: <1461339521-123191-1-git-send-email-seth.forshee@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add checks to inode_change_ok to verify that uid and gid changes
will map into the superblock's user namespace. If they do not
fail with -EOVERFLOW. This cannot be overriden with ATTR_FORCE.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
---
 fs/attr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/attr.c b/fs/attr.c
index 25b24d0f6c88..3cfaaac4a18e 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -42,6 +42,17 @@ int inode_change_ok(const struct inode *inode, struct iattr *attr)
 			return error;
 	}
 
+	/*
+	 * Verify that uid/gid changes are valid in the target namespace
+	 * of the superblock. This cannot be overriden using ATTR_FORCE.
+	 */
+	if (ia_valid & ATTR_UID &&
+	    from_kuid(inode->i_sb->s_user_ns, attr->ia_uid) == (uid_t)-1)
+		return -EOVERFLOW;
+	if (ia_valid & ATTR_GID &&
+	    from_kgid(inode->i_sb->s_user_ns, attr->ia_gid) == (gid_t)-1)
+		return -EOVERFLOW;
+
 	/* If force is set do it anyway. */
 	if (ia_valid & ATTR_FORCE)
 		return 0;
-- 
1.9.1

Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB2FgWlH006648
 for <selinux@tycho.nsa.gov>; Wed, 2 Dec 2015 10:42:35 -0500
Received: by igcmv3 with SMTP id mv3so120229769igc.0
 for <selinux@tycho.nsa.gov>; Wed, 02 Dec 2015 07:42:24 -0800 (PST)
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 Richard Weinberger <richard.weinberger@gmail.com>,
 Austin S Hemmelgarn <ahferroin7@gmail.com>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-bcache@vger.kernel.org,
 dm-devel@redhat.com, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH 09/19] fs: Refuse uid/gid changes which don't map into
 s_user_ns
Date: Wed,  2 Dec 2015 09:40:09 -0600
Message-Id: <1449070821-73820-10-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1449070821-73820-1-git-send-email-seth.forshee@canonical.com>
References: <1449070821-73820-1-git-send-email-seth.forshee@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add checks to inode_change_ok to verify that uid and gid changes
will map into the superblock's user namespace. If they do not
fail with -EOVERFLOW. This cannot be overriden with ATTR_FORCE.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 fs/attr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/attr.c b/fs/attr.c
index 6530ced19697..55b46e3aa888 100644
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

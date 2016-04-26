Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3QJUoHM010214
 for <selinux@tycho.nsa.gov>; Tue, 26 Apr 2016 15:30:53 -0400
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Serge Hallyn <serge.hallyn@canonical.com>,
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
Subject: [PATCH v4 11/21] cred: Reject inodes with invalid ids in
 set_create_file_as()
Date: Tue, 26 Apr 2016 14:30:34 -0500
Message-Id: <1461699046-30485-12-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1461699046-30485-1-git-send-email-seth.forshee@canonical.com>
References: <1461699046-30485-1-git-send-email-seth.forshee@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Using INVALID_[UG]ID for the LSM file creation context doesn't
make sense, so return an error if the inode passed to
set_create_file_as() has an invalid id.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
---
 kernel/cred.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cred.c b/kernel/cred.c
index 0c0cd8a62285..5f264fb5737d 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -689,6 +689,8 @@ EXPORT_SYMBOL(set_security_override_from_ctx);
  */
 int set_create_files_as(struct cred *new, struct inode *inode)
 {
+	if (!uid_valid(inode->i_uid) || !gid_valid(inode->i_gid))
+		return -EINVAL;
 	new->fsuid = inode->i_uid;
 	new->fsgid = inode->i_gid;
 	return security_kernel_create_files_as(new, inode);
-- 
2.7.4

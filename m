Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3QJak04011587
 for <selinux@tycho.nsa.gov>; Tue, 26 Apr 2016 15:37:11 -0400
Received: by mail-ig0-f179.google.com with SMTP id u10so52245908igr.1
 for <selinux@tycho.nsa.gov>; Tue, 26 Apr 2016 12:37:10 -0700 (PDT)
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
Subject: [PATCH v4 15/21] fs: Don't remove suid for CAP_FSETID in s_user_ns
Date: Tue, 26 Apr 2016 14:36:28 -0500
Message-Id: <1461699396-33000-16-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1461699396-33000-1-git-send-email-seth.forshee@canonical.com>
References: <1461699396-33000-1-git-send-email-seth.forshee@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Expand the check in should_remove_suid() to keep privileges for
CAP_FSETID in s_user_ns rather than init_user_ns.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
---
 fs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 69b8b526c194..cd52170f9117 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1690,7 +1690,8 @@ int should_remove_suid(struct dentry *dentry)
 	if (unlikely((mode & S_ISGID) && (mode & S_IXGRP)))
 		kill |= ATTR_KILL_SGID;
 
-	if (unlikely(kill && !capable(CAP_FSETID) && S_ISREG(mode)))
+	if (unlikely(kill && !ns_capable(dentry->d_sb->s_user_ns, CAP_FSETID) &&
+		     S_ISREG(mode)))
 		return kill;
 
 	return 0;
-- 
2.7.4

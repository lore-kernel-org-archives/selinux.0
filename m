Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3QJUoHH010214
 for <selinux@tycho.nsa.gov>; Tue, 26 Apr 2016 15:30:50 -0400
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
Subject: [PATCH v4 02/21] fs: Remove check of s_user_ns for existing mounts in
 fs_fully_visible()
Date: Tue, 26 Apr 2016 14:30:25 -0500
Message-Id: <1461699046-30485-3-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1461699046-30485-1-git-send-email-seth.forshee@canonical.com>
References: <1461699046-30485-1-git-send-email-seth.forshee@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

fs_fully_visible() ignores MNT_LOCK_NODEV when FS_USERS_DEV_MOUNT
is not set for the filesystem, but there is a bug in the logic
that may cause mounting to fail. It is doing this only when the
existing mount is not in init_user_ns but should check the new
mount instead. But the new mount is always in a non-init
namespace when fs_fully_visible() is called, so that condition
can simply be removed.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 fs/namespace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index f20c82f91ecb..c133318bec35 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3234,8 +3234,7 @@ static bool fs_fully_visible(struct file_system_type *type, int *new_mnt_flags)
 		mnt_flags = mnt->mnt.mnt_flags;
 		if (mnt->mnt.mnt_sb->s_iflags & SB_I_NOEXEC)
 			mnt_flags &= ~(MNT_LOCK_NOSUID | MNT_LOCK_NOEXEC);
-		if (mnt->mnt.mnt_sb->s_user_ns != &init_user_ns &&
-		    !(mnt->mnt.mnt_sb->s_type->fs_flags & FS_USERNS_DEV_MOUNT))
+		if (!(mnt->mnt.mnt_sb->s_type->fs_flags & FS_USERNS_DEV_MOUNT))
 			mnt_flags &= ~(MNT_LOCK_NODEV);
 
 		/* Verify the mount flags are equal to or more permissive
-- 
2.7.4

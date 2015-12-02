Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB2FgWlI006648
 for <selinux@tycho.nsa.gov>; Wed, 2 Dec 2015 10:42:37 -0500
Received: by igl9 with SMTP id 9so113072239igl.0
 for <selinux@tycho.nsa.gov>; Wed, 02 Dec 2015 07:42:30 -0800 (PST)
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
Subject: [PATCH 13/19] fs: Allow superblock owner to access do_remount_sb()
Date: Wed,  2 Dec 2015 09:40:13 -0600
Message-Id: <1449070821-73820-14-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1449070821-73820-1-git-send-email-seth.forshee@canonical.com>
References: <1449070821-73820-1-git-send-email-seth.forshee@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Superblock level remounts are currently restricted to global
CAP_SYS_ADMIN, as is the path for changing the root mount to
read only on umount. Loosen both of these permission checks to
also allow CAP_SYS_ADMIN in any namespace which is privileged
towards the userns which originally mounted the filesystem.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/namespace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 18fc58760aec..b00a765895e7 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1510,7 +1510,7 @@ static int do_umount(struct mount *mnt, int flags)
 		 * Special case for "unmounting" root ...
 		 * we just try to remount it readonly.
 		 */
-		if (!capable(CAP_SYS_ADMIN))
+		if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
 			return -EPERM;
 		down_write(&sb->s_umount);
 		if (!(sb->s_flags & MS_RDONLY))
@@ -2199,7 +2199,7 @@ static int do_remount(struct path *path, int flags, int mnt_flags,
 	down_write(&sb->s_umount);
 	if (flags & MS_BIND)
 		err = change_mount_flags(path->mnt, flags);
-	else if (!capable(CAP_SYS_ADMIN))
+	else if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
 		err = -EPERM;
 	else
 		err = do_remount_sb(sb, flags, data, 0);
-- 
1.9.1

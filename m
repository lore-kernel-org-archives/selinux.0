Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2FCBFUU030553
 for <selinux@tycho.nsa.gov>; Tue, 15 Mar 2016 08:11:15 -0400
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: Seth Forshee <seth.forshee@canonical.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, <devel@openvz.org>
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Jeff Layton <jlayton@poochiereds.net>,
 "J. Bruce Fields" <bfields@fieldses.org>,
 Andy Lutomirski <luto@amacapital.net>,
 linux-security-module@vger.kernel.org, linux-mtd@lists.infradead.org,
 selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Konstantin Khorenko <khorenko@virtuozzo.com>,
 Pavel Emelyanov <xemul@virtuozzo.com>
Subject: [PATCH] fs: fix a posible leak of allocated superblock
Date: Tue, 15 Mar 2016 15:08:50 +0300
Message-Id: <1458043730-14296-1-git-send-email-ptikhomirov@virtuozzo.com>
In-Reply-To: <1443039368-55445-2-git-send-email-seth.forshee@canonical.com>
References: <1443039368-55445-2-git-send-email-seth.forshee@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

We probably need to fix superblock leak in patch (v4 "fs: Add user
namesapace member to struct super_block"):

Imagine posible code path in sget_userns: we iterate through
type->fs_supers and do not find suitable sb, we drop sb_lock to
allocate s and go to retry. After we dropped sb_lock some other
task from different userns takes sb_lock, it is already in retry
stage and has s allocated, so it puts its s in type->fs_supers
list. So in retry we will find these sb in list and check it has
a different userns, and finally we will return without freeing s.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 fs/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index b4ee02b..24771b5 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -458,6 +458,10 @@ struct super_block *sget_userns(struct file_system_type *type,
 				continue;
 			if (user_ns != old->s_user_ns) {
 				spin_unlock(&sb_lock);
+				if (s) {
+					up_write(&s->s_umount);
+					destroy_super(s);
+				}
 				return ERR_PTR(-EBUSY);
 			}
 			if (!grab_super(old))
-- 
1.9.3

Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2FCAlE4030360
 for <selinux@tycho.nsa.gov>; Tue, 15 Mar 2016 08:10:48 -0400
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: Andy Lutomirski <luto@amacapital.net>,
 Seth Forshee <seth.forshee@canonical.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, <devel@openvz.org>
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-security-module@vger.kernel.org, linux-mtd@lists.infradead.org,
 selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Konstantin Khorenko <khorenko@virtuozzo.com>,
 Pavel Emelyanov <xemul@virtuozzo.com>
Subject: [PATCH] fs: remove excess check for in_userns
Date: Tue, 15 Mar 2016 15:09:00 +0300
Message-Id: <1458043740-14229-1-git-send-email-ptikhomirov@virtuozzo.com>
In-Reply-To: <1451930639-94331-4-git-send-email-seth.forshee@canonical.com>
References: <1451930639-94331-4-git-send-email-seth.forshee@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If in_userns returns false mnt_may_suid also returns false, and we
will reach second(removed) if-check only in case it does not trigger,
so remove it.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 security/commoncap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index ca0c04ae..82f930c 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -445,8 +445,6 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_c
 
 	if (!mnt_may_suid(bprm->file->f_path.mnt))
 		return 0;
-	if (!in_userns(current_user_ns(), bprm->file->f_path.mnt->mnt_sb->s_user_ns))
-		return 0;
 
 	dentry = dget(bprm->file->f_dentry);
 
-- 
1.9.3

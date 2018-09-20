Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8K0KMwn020744
 for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2018 20:20:22 -0400
To: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, SE Linux <selinux@tycho.nsa.gov>,
 LKLM <linux-kernel@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?=
 <mic@digikod.net>, Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <de3681aa-3e2e-a3dc-bc1d-9c7edb2f12a6@schaufler-ca.com>
Date: Wed, 19 Sep 2018 17:20:10 -0700
MIME-Version: 1.0
In-Reply-To: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH v3 04/16] SELinux: Remove cred security blob
 poisoning
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

SELinux: Remove cred security blob poisoning

The SELinux specific credential poisioning only makes sense
if SELinux is managing the credentials. As the intent of this
patch set is to move the blob management out of the modules
and into the infrastructure, the SELinux specific code has
to go. The poisioning could be introduced into the infrastructure
at some later date.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/cred.c            | 13 -------------
 security/selinux/hooks.c |  6 ------
 2 files changed, 19 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index ecf03657e71c..fa2061ee4955 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -704,19 +704,6 @@ bool creds_are_invalid(const struct cred *cred)
 {
 	if (cred->magic != CRED_MAGIC)
 		return true;
-#ifdef CONFIG_SECURITY_SELINUX
-	/*
-	 * cred->security == NULL if security_cred_alloc_blank() or
-	 * security_prepare_creds() returned an error.
-	 */
-	if (selinux_is_enabled() && cred->security) {
-		if ((unsigned long) cred->security < PAGE_SIZE)
-			return true;
-		if ((*(u32 *)cred->security & 0xffffff00) ==
-		    (POISON_FREE << 24 | POISON_FREE << 16 | POISON_FREE << 8))
-			return true;
-	}
-#endif
 	return false;
 }
 EXPORT_SYMBOL(creds_are_invalid);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9d6cdd21acb6..80614ca25a2b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3920,12 +3920,6 @@ static void selinux_cred_free(struct cred *cred)
 {
 	struct task_security_struct *tsec = selinux_cred(cred);
 
-	/*
-	 * cred->security == NULL if security_cred_alloc_blank() or
-	 * security_prepare_creds() returned an error.
-	 */
-	BUG_ON(cred->security && (unsigned long) cred->security < PAGE_SIZE);
-	cred->security = (void *) 0x7UL;
 	kfree(tsec);
 }
 
-- 
2.17.1

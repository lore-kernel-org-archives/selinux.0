Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w6GIZpvq023492
 for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2018 14:35:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC13.oob.disa.mil (Postfix) with SMTP id 41TsYC0n6gz25sSK
 for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2018 18:35:43 +0000 (UTC)
Received: from UPBD19PA04.eemsg.mil (unknown [192.168.18.5])
 by UPDCF3IC13.oob.disa.mil (Postfix) with ESMTP id 41TsYB1lKqz25sSD
 for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2018 18:35:42 +0000 (UTC)
To: LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 James Morris <jmorris@namei.org>
Cc: "Schaufler, Casey" <casey.schaufler@intel.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <e22d6647-fa1c-6f7d-975d-2dadf38b8f6b@schaufler-ca.com>
Date: Mon, 16 Jul 2018 11:24:07 -0700
MIME-Version: 1.0
In-Reply-To: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH v1 15/22] LSM: Mark security blob allocation
 failures as unlikely
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

LSM: Mark security blob allocation failures as unlikely

The allocation of security blobs is unlikely to fail.
Mark the checks thus for performance reasons.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/security.c b/security/security.c
index b95a151f7347..de5008d6715c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1245,7 +1245,7 @@ int security_file_alloc(struct file *file)
 {
 	int rc = lsm_file_alloc(file);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
 	rc = call_int_hook(file_alloc_security, 0, file);
 	if (unlikely(rc))
@@ -1368,7 +1368,7 @@ int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
 	int rc = lsm_task_alloc(task);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
 	rc = call_int_hook(task_alloc, 0, task, clone_flags);
 	if (unlikely(rc))
@@ -1388,7 +1388,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 {
 	int rc = lsm_cred_alloc(cred, gfp);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
 
 	rc = call_int_hook(cred_alloc_blank, 0, cred, gfp);
@@ -1409,7 +1409,7 @@ int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
 {
 	int rc = lsm_cred_alloc(new, gfp);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
 
 	rc = call_int_hook(cred_prepare, 0, new, old, gfp);
-- 
2.17.1

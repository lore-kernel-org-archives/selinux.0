Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8M0J3XK009872
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 20:19:05 -0400
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
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <bd7c5604-ebb1-b42b-cf29-589494dbb1c5@schaufler-ca.com>
Date: Fri, 21 Sep 2018 17:18:49 -0700
MIME-Version: 1.0
In-Reply-To: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH v4 10/19] Smack: Abstract use of file security blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Don't use the file->f_security pointer directly.
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack.h     |  5 +++++
 security/smack/smack_lsm.c | 12 ++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 01a922856eba..22ca30379209 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -361,6 +361,11 @@ static inline struct task_smack *smack_cred(const struct cred *cred)
 	return cred->security;
 }
 
+static inline struct smack_known **smack_file(const struct file *file)
+{
+	return (struct smack_known **)&file->f_security;
+}
+
 /*
  * Is the directory transmuting?
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a06ea8aa89c4..9ec595f0c3f1 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1571,9 +1571,9 @@ static void smack_inode_getsecid(struct inode *inode, u32 *secid)
  */
 static int smack_file_alloc_security(struct file *file)
 {
-	struct smack_known *skp = smk_of_current();
+	struct smack_known **blob = smack_file(file);
 
-	file->f_security = skp;
+	*blob = smk_of_current();
 	return 0;
 }
 
@@ -1813,7 +1813,9 @@ static int smack_mmap_file(struct file *file,
  */
 static void smack_file_set_fowner(struct file *file)
 {
-	file->f_security = smk_of_current();
+	struct smack_known **blob = smack_file(file);
+
+	*blob = smk_of_current();
 }
 
 /**
@@ -1830,6 +1832,7 @@ static void smack_file_set_fowner(struct file *file)
 static int smack_file_send_sigiotask(struct task_struct *tsk,
 				     struct fown_struct *fown, int signum)
 {
+	struct smack_known **blob;
 	struct smack_known *skp;
 	struct smack_known *tkp = smk_of_task(smack_cred(tsk->cred));
 	struct file *file;
@@ -1842,7 +1845,8 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
 	file = container_of(fown, struct file, f_owner);
 
 	/* we don't log here as rc can be overriden */
-	skp = file->f_security;
+	blob = smack_file(file);
+	skp = *blob;
 	rc = smk_access(skp, tkp, MAY_DELIVER, NULL);
 	rc = smk_bu_note("sigiotask", skp, tkp, MAY_DELIVER, rc);
 	if (rc != 0 && has_capability(tsk, CAP_MAC_OVERRIDE))
-- 
2.17.1

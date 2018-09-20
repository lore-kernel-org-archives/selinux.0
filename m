Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8K0Kcc4020759
 for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2018 20:20:39 -0400
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
Message-ID: <2eb4065c-1bae-203c-dbe0-47980e009a2c@schaufler-ca.com>
Date: Wed, 19 Sep 2018 17:20:28 -0700
MIME-Version: 1.0
In-Reply-To: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH v3 06/16] AppArmor: Abstract use of cred security
 blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

AppArmor: Abstract use of cred security blob

Don't use the cred->security pointer directly.
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/domain.c       |  2 +-
 security/apparmor/include/cred.h | 16 +++++++++++++++-
 security/apparmor/lsm.c          | 10 +++++-----
 security/apparmor/task.c         |  6 +++---
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 08c88de0ffda..726910bba84b 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -975,7 +975,7 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
 	}
 	aa_put_label(cred_label(bprm->cred));
 	/* transfer reference, released when cred is freed */
-	cred_label(bprm->cred) = new;
+	set_cred_label(bprm->cred, new);
 
 done:
 	aa_put_label(label);
diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
index e287b7d0d4be..a90eae76d7c1 100644
--- a/security/apparmor/include/cred.h
+++ b/security/apparmor/include/cred.h
@@ -23,8 +23,22 @@
 #include "policy_ns.h"
 #include "task.h"
 
-#define cred_label(X) ((X)->security)
+static inline struct aa_label *cred_label(const struct cred *cred)
+{
+	struct aa_label **blob = cred->security;
+
+	AA_BUG(!blob);
+	return *blob;
+}
 
+static inline void set_cred_label(const struct cred *cred,
+				  struct aa_label *label)
+{
+	struct aa_label **blob = cred->security;
+
+	AA_BUG(!blob);
+	*blob = label;
+}
 
 /**
  * aa_cred_raw_label - obtain cred's label
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 8b8b70620bbe..4f51705c3c71 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -57,7 +57,7 @@ DEFINE_PER_CPU(struct aa_buffers, aa_buffers);
 static void apparmor_cred_free(struct cred *cred)
 {
 	aa_put_label(cred_label(cred));
-	cred_label(cred) = NULL;
+	set_cred_label(cred, NULL);
 }
 
 /*
@@ -65,7 +65,7 @@ static void apparmor_cred_free(struct cred *cred)
  */
 static int apparmor_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 {
-	cred_label(cred) = NULL;
+	set_cred_label(cred, NULL);
 	return 0;
 }
 
@@ -75,7 +75,7 @@ static int apparmor_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 static int apparmor_cred_prepare(struct cred *new, const struct cred *old,
 				 gfp_t gfp)
 {
-	cred_label(new) = aa_get_newest_label(cred_label(old));
+	set_cred_label(new, aa_get_newest_label(cred_label(old)));
 	return 0;
 }
 
@@ -84,7 +84,7 @@ static int apparmor_cred_prepare(struct cred *new, const struct cred *old,
  */
 static void apparmor_cred_transfer(struct cred *new, const struct cred *old)
 {
-	cred_label(new) = aa_get_newest_label(cred_label(old));
+	set_cred_label(new, aa_get_newest_label(cred_label(old)));
 }
 
 static void apparmor_task_free(struct task_struct *task)
@@ -1455,7 +1455,7 @@ static int __init set_init_ctx(void)
 	if (!ctx)
 		return -ENOMEM;
 
-	cred_label(cred) = aa_get_label(ns_unconfined(root_ns));
+	set_cred_label(cred, aa_get_label(ns_unconfined(root_ns)));
 	task_ctx(current) = ctx;
 
 	return 0;
diff --git a/security/apparmor/task.c b/security/apparmor/task.c
index c6b78a14da91..4551110f0496 100644
--- a/security/apparmor/task.c
+++ b/security/apparmor/task.c
@@ -81,7 +81,7 @@ int aa_replace_current_label(struct aa_label *label)
 	 */
 	aa_get_label(label);
 	aa_put_label(cred_label(new));
-	cred_label(new) = label;
+	set_cred_label(new, label);
 
 	commit_creds(new);
 	return 0;
@@ -138,7 +138,7 @@ int aa_set_current_hat(struct aa_label *label, u64 token)
 		return -EACCES;
 	}
 
-	cred_label(new) = aa_get_newest_label(label);
+	set_cred_label(new, aa_get_newest_label(label));
 	/* clear exec on switching context */
 	aa_put_label(ctx->onexec);
 	ctx->onexec = NULL;
@@ -172,7 +172,7 @@ int aa_restore_previous_label(u64 token)
 		return -ENOMEM;
 
 	aa_put_label(cred_label(new));
-	cred_label(new) = aa_get_newest_label(ctx->previous);
+	set_cred_label(new, aa_get_newest_label(ctx->previous));
 	AA_BUG(!cred_label(new));
 	/* clear exec && prev information when restoring to previous context */
 	aa_clear_task_ctx_trans(ctx);
-- 
2.17.1

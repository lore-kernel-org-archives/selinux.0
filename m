Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w031KbBw006334
 for <selinux@tycho.nsa.gov>; Tue, 2 Jan 2018 20:20:37 -0500
Received: by mail-oi0-f74.google.com with SMTP id j135so88912oih.9
 for <selinux@tycho.nsa.gov>; Tue, 02 Jan 2018 17:20:24 -0800 (PST)
MIME-Version: 1.0
Date: Tue,  2 Jan 2018 17:20:16 -0800
In-Reply-To: <20180103012017.7022-1-mjg59@google.com>
Message-Id: <20180103012017.7022-2-mjg59@google.com>
References: <20180103012017.7022-1-mjg59@google.com>
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: Matthew Garrett <mjg59@google.com>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 Casey Schaufler <casey@schaufler-ca.com>,
 linux-security-module@vger.kernel.org,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [PATCH V4 2/3] IMA: Use consistent creds
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Right now most of the IMA code is using current->creds, but the LSM
checks are using security_task_getsecid() which ends up looking at
real_creds. Switch to using security_cred_getsecid() in order to make
this consistent.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org
---
 security/integrity/ima/ima_policy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index ee4613fa5840..52951ac445ea 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -249,7 +249,6 @@ static void ima_lsm_update_rules(void)
 static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 			    enum ima_hooks func, int mask)
 {
-	struct task_struct *tsk = current;
 	const struct cred *cred = current_cred();
 	int i;
 
@@ -305,7 +304,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			security_task_getsecid(tsk, &sid);
+			security_cred_getsecid(cred, &sid);
 			rc = security_filter_rule_match(sid,
 							rule->lsm[i].type,
 							Audit_equal,
-- 
2.15.1.620.gb9897f4670-goog

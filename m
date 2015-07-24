From: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@amacapital.net>, Arnd Bergmann <arnd@arndb.de>,
 Casey Schaufler <casey@schaufler-ca.com>,
 David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Eric Paris <eparis@parisplace.org>,
 Fabian Frederick <fabf@skynet.be>, Greg KH <gregkh@linuxfoundation.org>,
 James Morris <james.l.morris@oracle.com>, Jiri Slaby <jslaby@suse.com>,
 Joe Perches <joe@perches.com>, John Johansen <john.johansen@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
 Lukasz Pawelczyk <l.pawelczyk@samsung.com>,
 Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 NeilBrown <neilb@suse.de>, Oleg Nesterov <oleg@redhat.com>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Zefan Li <lizefan@huawei.com>, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: [PATCH v3 05/11] smack: extend capability functions and fix 2 checks
Date: Fri, 24 Jul 2015 12:04:39 +0200
Message-id: <1437732285-11524-6-git-send-email-l.pawelczyk@samsung.com>
In-reply-to: <1437732285-11524-1-git-send-email-l.pawelczyk@samsung.com>
References: <1437732285-11524-1-git-send-email-l.pawelczyk@samsung.com>
Cc: havner@gmail.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch extends smack capability functions to a full list to those
equivalent in the kernel

has_ns_capability -> smack_has_ns_privilege
has_capability    -> smack_has_privilege
ns_capable        -> smack_ns_privileged
capable           -> smack_privileged

It also puts the smack related part to a common function:
smack_capability_allowed()

Those functions will be needed for capability checks in the upcoming
Smack namespace patches.

Additionally there were 2 smack capability checks that used generic
capability functions instead of specific Smack ones effectively ignoring
the onlycap rule. This has been fixed now with the introduction of those
new functions.

This has implications on the Smack namespace as well as the additional
Smack checks in smack_capability_allowed() will be extended beyond the
onlycap rule. Not using Smack specific checks in those 2 places could
mean breaking the Smack label namespace separation.

Signed-off-by: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack.h        |  5 ++++
 security/smack/smack_access.c | 64 +++++++++++++++++++++++++++++++++++++++----
 security/smack/smack_lsm.c    |  4 +--
 3 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 69ab9eb..e11cc13 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -272,6 +272,11 @@ int smk_netlbl_mls(int, char *, struct netlbl_lsm_secattr *, int);
 struct smack_known *smk_import_entry(const char *, int);
 void smk_insert_entry(struct smack_known *skp);
 struct smack_known *smk_find_entry(const char *);
+int smack_has_ns_privilege(struct task_struct *task,
+			   struct user_namespace *user_ns,
+			   int cap);
+int smack_has_privilege(struct task_struct *task, int cap);
+int smack_ns_privileged(struct user_namespace *user_ns, int cap);
 int smack_privileged(int cap);
 
 /*
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 00f6b38..188b354 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -629,17 +629,19 @@ LIST_HEAD(smack_onlycap_list);
 DEFINE_MUTEX(smack_onlycap_lock);
 
 /*
- * Is the task privileged and allowed to be privileged
- * by the onlycap rule.
+ * Internal smack capability check complimentary to the
+ * set of kernel capable() and has_capability() functions
  *
- * Returns 1 if the task is allowed to be privileged, 0 if it's not.
+ * For a capability in smack related checks to be effective it needs to:
+ * - be allowed to be privileged by the onlycap rule.
+ * - be in the initial user ns
  */
-int smack_privileged(int cap)
+static int smack_capability_allowed(struct smack_known *skp,
+				    struct user_namespace *user_ns)
 {
-	struct smack_known *skp = smk_of_current();
 	struct smack_onlycap *sop;
 
-	if (!capable(cap))
+	if (user_ns != &init_user_ns)
 		return 0;
 
 	rcu_read_lock();
@@ -658,3 +660,53 @@ int smack_privileged(int cap)
 
 	return 0;
 }
+
+/*
+ * Is the task privileged in a namespace and allowed to be privileged
+ * by additional smack rules.
+ */
+int smack_has_ns_privilege(struct task_struct *task,
+			   struct user_namespace *user_ns,
+			   int cap)
+{
+	struct smack_known *skp = smk_of_task_struct(task);
+
+	if (!has_ns_capability(task, user_ns, cap))
+		return 0;
+	if (smack_capability_allowed(skp, user_ns))
+		return 1;
+	return 0;
+}
+
+/*
+ * Is the task privileged and allowed to be privileged
+ * by additional smack rules.
+ */
+int smack_has_privilege(struct task_struct *task, int cap)
+{
+	return smack_has_ns_privilege(task, &init_user_ns, cap);
+}
+
+/*
+ * Is the current task privileged in a namespace and allowed to be privileged
+ * by additional smack rules.
+ */
+int smack_ns_privileged(struct user_namespace *user_ns, int cap)
+{
+	struct smack_known *skp = smk_of_current();
+
+	if (!ns_capable(user_ns, cap))
+		return 0;
+	if (smack_capability_allowed(skp, user_ns))
+		return 1;
+	return 0;
+}
+
+/*
+ * Is the current task privileged and allowed to be privileged
+ * by additional smack rules.
+ */
+int smack_privileged(int cap)
+{
+	return smack_ns_privileged(&init_user_ns, cap);
+}
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index cdcabf4..6098518 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -413,7 +413,7 @@ static int smk_ptrace_rule_check(struct task_struct *tracer,
 			rc = 0;
 		else if (smack_ptrace_rule == SMACK_PTRACE_DRACONIAN)
 			rc = -EACCES;
-		else if (capable(CAP_SYS_PTRACE))
+		else if (smack_has_privilege(tracer, CAP_SYS_PTRACE))
 			rc = 0;
 		else
 			rc = -EACCES;
@@ -1805,7 +1805,7 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
 	skp = file->f_security;
 	rc = smk_access(skp, tkp, MAY_WRITE, NULL);
 	rc = smk_bu_note("sigiotask", skp, tkp, MAY_WRITE, rc);
-	if (rc != 0 && has_capability(tsk, CAP_MAC_OVERRIDE))
+	if (rc != 0 && smack_has_privilege(tsk, CAP_MAC_OVERRIDE))
 		rc = 0;
 
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_TASK);
-- 
2.4.3

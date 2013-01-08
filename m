Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0829uwk017944
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2013 21:10:04 -0500
Message-ID: <50EB7FEB.2070506@schaufler-ca.com>
Date: Mon, 07 Jan 2013 18:09:47 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: Casey Schaufler <casey@schaufler-ca.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>, SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v12 9/9] LSM: Multiple concurrent LSMs
References: <50EB7C50.3070605@schaufler-ca.com>
In-Reply-To: <50EB7C50.3070605@schaufler-ca.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Subject: [PATCH v12 9/9] LSM: Multiple concurrent LSMs

Change the infrastructure for Linux Security Modules (LSM)s
from a single vector of hook handlers to a list based method
for handling multiple concurrent modules. 

Remove special case Yama stacking. Remove commoncap calls.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

---
 security/yama/Kconfig    |    7 -------
 security/yama/yama_lsm.c |   33 +++------------------------------
 2 files changed, 3 insertions(+), 37 deletions(-)

diff --git a/security/yama/Kconfig b/security/yama/Kconfig
index 20ef514..a99aa1d 100644
--- a/security/yama/Kconfig
+++ b/security/yama/Kconfig
@@ -12,10 +12,3 @@ config SECURITY_YAMA
 
 	  If you are unsure how to answer this question, answer N.
 
-config SECURITY_YAMA_STACKED
-	bool "Yama stacked with other LSMs"
-	depends on SECURITY_YAMA
-	default n
-	help
-	  When Yama is built into the kernel, force it to stack with the
-	  selected primary LSM.
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 23414b9..acfe1f0 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -154,13 +154,9 @@ void yama_task_free(struct task_struct *task)
 int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			   unsigned long arg4, unsigned long arg5)
 {
-	int rc;
+	int rc = -ENOSYS;
 	struct task_struct *myself = current;
 
-	rc = cap_task_prctl(option, arg2, arg3, arg4, arg5);
-	if (rc != -ENOSYS)
-		return rc;
-
 	switch (option) {
 	case PR_SET_PTRACER:
 		/* Since a thread can call prctl(), find the group leader
@@ -282,14 +278,7 @@ static int ptracer_exception_found(struct task_struct *tracer,
 int yama_ptrace_access_check(struct task_struct *child,
 				    unsigned int mode)
 {
-	int rc;
-
-	/* If standard caps disallows it, so does Yama.  We should
-	 * only tighten restrictions further.
-	 */
-	rc = cap_ptrace_access_check(child, mode);
-	if (rc)
-		return rc;
+	int rc = 0;
 
 	/* require ptrace target be a child of ptracer on attach */
 	if (mode == PTRACE_MODE_ATTACH) {
@@ -335,14 +324,7 @@ int yama_ptrace_access_check(struct task_struct *child,
  */
 int yama_ptrace_traceme(struct task_struct *parent)
 {
-	int rc;
-
-	/* If standard caps disallows it, so does Yama.  We should
-	 * only tighten restrictions further.
-	 */
-	rc = cap_ptrace_traceme(parent);
-	if (rc)
-		return rc;
+	int rc = 0;
 
 	/* Only disallow PTRACE_TRACEME on more aggressive settings. */
 	switch (ptrace_scope) {
@@ -366,7 +348,6 @@ int yama_ptrace_traceme(struct task_struct *parent)
 	return rc;
 }
 
-#ifndef CONFIG_SECURITY_YAMA_STACKED
 static struct security_operations yama_ops = {
 	.name =			"yama",
 
@@ -375,7 +356,6 @@ static struct security_operations yama_ops = {
 	.task_prctl =		yama_task_prctl,
 	.task_free =		yama_task_free,
 };
-#endif
 
 #ifdef CONFIG_SYSCTL
 static int yama_dointvec_minmax(struct ctl_table *table, int write,
@@ -422,18 +402,11 @@ static struct ctl_table yama_sysctl_table[] = {
 
 static __init int yama_init(void)
 {
-#ifndef CONFIG_SECURITY_YAMA_STACKED
 	if (!security_module_enable(&yama_ops))
 		return 0;
-#endif
 
 	printk(KERN_INFO "Yama: becoming mindful.\n");
 
-#ifndef CONFIG_SECURITY_YAMA_STACKED
-	if (register_security(&yama_ops))
-		panic("Yama: kernel registration failed.\n");
-#endif
-
 #ifdef CONFIG_SYSCTL
 	if (!register_sysctl_paths(yama_sysctl_path, yama_sysctl_table))
 		panic("Yama: sysctl registration failed.\n");


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

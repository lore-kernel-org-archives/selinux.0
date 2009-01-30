Date: Fri, 30 Jan 2009 11:28:46 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, eparis@redhat.com,
        linux-security-module@vger.kernel.org
Subject: [PATCH][RFC] selinux: remove hooks which simply defer to
 capabilities
In-Reply-To: <1233252002.5109.138.camel@localhost.localdomain>
Message-ID: <alpine.LRH.1.10.0901301127180.30367@tundra.namei.org>
References: <1233201347-17568-1-git-send-email-jmorris@namei.org>  <1233251523.5109.132.camel@localhost.localdomain> <1233252002.5109.138.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 29 Jan 2009, Stephen Smalley wrote:

> Other tidying:
> - drop selinux_inode*killpriv 
> - drop selinux_task*setuid 
> - drop selinux_task_prctl
> since the hooks will default to the capability functions if SELinux
> doesn't define them.

Ok, see below.  (I also removed task_setgroups).

Please review.

---

commit 4d51a060468068b8db48883301c9318547aec454
Author: James Morris <jmorris@namei.org>
Date:   Fri Jan 30 10:05:06 2009 +1100

    selinux: remove hooks which simply defer to capabilities
    
    Remove SELinux hooks which do nothing except defer to the capabilites
    hooks (or in one case, replicates the function).
    
    Signed-off-by: James Morris <jmorris@namei.org>

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d960479..a69d6f8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1892,6 +1892,16 @@ static int selinux_capset(struct cred *new, const struct cred *old,
 	return cred_has_perm(old, new, PROCESS__SETCAP);
 }
 
+/*
+ * (This comment used to live with the selinux_task_setuid hook,
+ * which was removed).
+ *
+ * Since setuid only affects the current process, and since the SELinux
+ * controls are not based on the Linux identity attributes, SELinux does not
+ * need to control this operation.  However, SELinux does control the use of
+ * the CAP_SETUID and CAP_SETGID capabilities using the capable hook.
+ */
+
 static int selinux_capable(struct task_struct *tsk, const struct cred *cred,
 			   int cap, int audit)
 {
@@ -2909,16 +2919,6 @@ static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t
 	return len;
 }
 
-static int selinux_inode_need_killpriv(struct dentry *dentry)
-{
-	return secondary_ops->inode_need_killpriv(dentry);
-}
-
-static int selinux_inode_killpriv(struct dentry *dentry)
-{
-	return secondary_ops->inode_killpriv(dentry);
-}
-
 static void selinux_inode_getsecid(const struct inode *inode, u32 *secid)
 {
 	struct inode_security_struct *isec = inode->i_security;
@@ -3288,29 +3288,6 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 	return 0;
 }
 
-static int selinux_task_setuid(uid_t id0, uid_t id1, uid_t id2, int flags)
-{
-	/* Since setuid only affects the current process, and
-	   since the SELinux controls are not based on the Linux
-	   identity attributes, SELinux does not need to control
-	   this operation.  However, SELinux does control the use
-	   of the CAP_SETUID and CAP_SETGID capabilities using the
-	   capable hook. */
-	return 0;
-}
-
-static int selinux_task_fix_setuid(struct cred *new, const struct cred *old,
-				   int flags)
-{
-	return secondary_ops->task_fix_setuid(new, old, flags);
-}
-
-static int selinux_task_setgid(gid_t id0, gid_t id1, gid_t id2, int flags)
-{
-	/* See the comment for setuid above. */
-	return 0;
-}
-
 static int selinux_task_setpgid(struct task_struct *p, pid_t pgid)
 {
 	return current_has_perm(p, PROCESS__SETPGID);
@@ -3331,12 +3308,6 @@ static void selinux_task_getsecid(struct task_struct *p, u32 *secid)
 	*secid = task_sid(p);
 }
 
-static int selinux_task_setgroups(struct group_info *group_info)
-{
-	/* See the comment for setuid above. */
-	return 0;
-}
-
 static int selinux_task_setnice(struct task_struct *p, int nice)
 {
 	int rc;
@@ -3417,18 +3388,6 @@ static int selinux_task_kill(struct task_struct *p, struct siginfo *info,
 	return rc;
 }
 
-static int selinux_task_prctl(int option,
-			      unsigned long arg2,
-			      unsigned long arg3,
-			      unsigned long arg4,
-			      unsigned long arg5)
-{
-	/* The current prctl operations do not appear to require
-	   any SELinux controls since they merely observe or modify
-	   the state of the current process. */
-	return secondary_ops->task_prctl(option, arg2, arg3, arg4, arg5);
-}
-
 static int selinux_task_wait(struct task_struct *p)
 {
 	return task_has_perm(p, current, PROCESS__SIGCHLD);
@@ -5563,8 +5522,6 @@ static struct security_operations selinux_ops = {
 	.inode_getsecurity =		selinux_inode_getsecurity,
 	.inode_setsecurity =		selinux_inode_setsecurity,
 	.inode_listsecurity =		selinux_inode_listsecurity,
-	.inode_need_killpriv =		selinux_inode_need_killpriv,
-	.inode_killpriv =		selinux_inode_killpriv,
 	.inode_getsecid =		selinux_inode_getsecid,
 
 	.file_permission =		selinux_file_permission,
@@ -5586,14 +5543,10 @@ static struct security_operations selinux_ops = {
 	.cred_prepare =			selinux_cred_prepare,
 	.kernel_act_as =		selinux_kernel_act_as,
 	.kernel_create_files_as =	selinux_kernel_create_files_as,
-	.task_setuid =			selinux_task_setuid,
-	.task_fix_setuid =		selinux_task_fix_setuid,
-	.task_setgid =			selinux_task_setgid,
 	.task_setpgid =			selinux_task_setpgid,
 	.task_getpgid =			selinux_task_getpgid,
 	.task_getsid =			selinux_task_getsid,
 	.task_getsecid =		selinux_task_getsecid,
-	.task_setgroups =		selinux_task_setgroups,
 	.task_setnice =			selinux_task_setnice,
 	.task_setioprio =		selinux_task_setioprio,
 	.task_getioprio =		selinux_task_getioprio,
@@ -5603,7 +5556,6 @@ static struct security_operations selinux_ops = {
 	.task_movememory =		selinux_task_movememory,
 	.task_kill =			selinux_task_kill,
 	.task_wait =			selinux_task_wait,
-	.task_prctl =			selinux_task_prctl,
 	.task_to_inode =		selinux_task_to_inode,
 
 	.ipc_permission =		selinux_ipc_permission,

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

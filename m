Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7SL4wbC026482
	for <selinux@tycho.nsa.gov>; Fri, 28 Aug 2009 17:04:58 -0400
Received: from e33.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7SL4M5q005720
	for <selinux@tycho.nsa.gov>; Fri, 28 Aug 2009 21:04:22 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7SL2reF004038
	for <selinux@tycho.nsa.gov>; Fri, 28 Aug 2009 15:02:53 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7SL4sgF225068
	for <selinux@tycho.nsa.gov>; Fri, 28 Aug 2009 15:04:54 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7SL4ocH011625
	for <selinux@tycho.nsa.gov>; Fri, 28 Aug 2009 15:04:53 -0600
Date: Fri, 28 Aug 2009 16:04:49 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Oren Laadan <orenl@cs.columbia.edu>
Cc: Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 4/5] cr: add smack support to lsm c/r
Message-ID: <20090828210449.GD28048@us.ibm.com>
References: <20090828210041.GA27878@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090828210041.GA27878@us.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Documentation/checkpoint/readme.txt begins:
"""
Application checkpoint/restart is the ability to save the state
of a running application so that it can later resume its execution
from the time at which it was checkpointed.
"""

This patch implements checkpoint and restore of Smack security
labels.  The rules are the same as in previous versions:

	1. when objects are created during restore() they are
	   automatically labeled with current_security().
	2. if there was a label checkpointed with the object,
	   and that label != current_security() (which is the
	   same as obj->security), then the object is relabeled
	   if the sys_restart() caller has CAP_MAC_ADMIN.
	   Otherwise we return -EPERM.

This has been tested by checkpointing tasks under labels
_, vs1, and vs2, and restarting from tasks under _, vs1,
and vs2, with and without CAP_MAC_ADMIN in the bounding
set, and with and without the '-k' (keep_lsm) flag to mktree.
Expected results:

	#shell 1:
	echo vs1 > /proc/self/attr/current
	ckpt > out
	echo vs2 > /proc/self/attr/current
	mktree -F /cgroup/2 < out
		(frozen)
	# shell 2:
	cat /proc/`pidof ckpt`/attr/current
		vs2
	echo THAWED > /cgroup/2/freezer.state
	# shell 1:
	mktree -k -F /cgroup/2 < out
		(frozen)
	# shell 2:
	cat /proc/`pidof ckpt`/attr/current
		vs1
	echo THAWED > /cgroup/2/freezer.state
	# shell 1:
	capsh --drop=cap_mac_admin --
	mktree -k -F /cgroup/2 < out
		(permission denied)

There are testcases in git://git.sr71.net/~hallyn/cr_tests.git
under cr_tests/smack, which automate the above (and pass).

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 checkpoint/restart.c       |    1 +
 security/security.c        |    8 ++++
 security/smack/smack_lsm.c |   90 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 0 deletions(-)

diff --git a/checkpoint/restart.c b/checkpoint/restart.c
index f0ca1f6..11def5e 100644
--- a/checkpoint/restart.c
+++ b/checkpoint/restart.c
@@ -435,6 +435,7 @@ static int restore_read_header(struct ckpt_ctx *ctx)
 		}
 		/* to be implemented later, per-lsm */
 		if (strcmp(ctx->lsm_name, "lsm_none") != 0 &&
+				strcmp(ctx->lsm_name, "smack") != 0 &&
 				strcmp(ctx->lsm_name, "default") != 0) {
 			pr_warning("c/r: RESTART_KEEP_LSM unsupported for %s\n",
 					ctx->lsm_name);
diff --git a/security/security.c b/security/security.c
index 6bafb9e..d198d0c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1316,6 +1316,14 @@ int security_checkpoint_obj(struct ckpt_ctx *ctx, void *security,
 	char *str;
 	int len;
 
+	/*
+	 * to simplify the LSM code, short-cut a null security
+	 * here - hopefully not actually needed; test without
+	 * this one day.
+	 */
+	if (!security)
+		return -EOPNOTSUPP;
+
 	switch (sectype) {
 	case CKPT_SECURITY_MSG_MSG:
 		str = security_msg_msg_get_ctx(security);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0023182..279fdce 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -892,6 +892,28 @@ static int smack_file_permission(struct file *file, int mask)
 	return 0;
 }
 
+static inline char *smack_file_get_ctx(void *security)
+{
+	return kstrdup((char *)security, GFP_KERNEL);
+}
+
+static inline int smack_file_restore(struct file *file, char *ctx)
+{
+	char *newsmack = smk_import(ctx, 0);
+
+	if (newsmack == NULL)
+		return -EINVAL;
+	/* I think by definition, file->f_security == current_security
+	 * right now, but let's assume somehow it might not be */
+	if (newsmack == file->f_security)
+		return 0;
+	if (!capable(CAP_MAC_ADMIN))
+		return -EPERM;
+	file->f_security = newsmack;
+
+	return 0;
+}
+
 /**
  * smack_file_alloc_security - assign a file security blob
  * @file: the object
@@ -1079,6 +1101,26 @@ static int smack_file_receive(struct file *file)
  * Task hooks
  */
 
+static inline char *smack_cred_get_ctx(void *security)
+{
+	return kstrdup((char *)security, GFP_KERNEL);
+}
+
+static inline int smack_cred_restore(struct cred *cred, char *ctx)
+{
+	char *newsmack = smk_import(ctx, 0);
+
+	if (newsmack == NULL)
+		return -EINVAL;
+	if (newsmack == cred->security)
+		return 0;
+	if (!capable(CAP_MAC_ADMIN))
+		return -EPERM;
+	cred->security = newsmack;
+
+	return 0;
+}
+
 /**
  * smack_cred_free - "free" task-level security credentials
  * @cred: the credentials in question
@@ -1742,6 +1784,26 @@ static int smack_msg_msg_alloc_security(struct msg_msg *msg)
 	return 0;
 }
 
+static inline char *smack_msg_msg_get_ctx(void *security)
+{
+	return kstrdup((char *)security, GFP_KERNEL);
+}
+
+static inline int smack_msg_msg_restore(struct msg_msg *msg, char *ctx)
+{
+	char *newsmack = smk_import(ctx, 0);
+
+	if (newsmack == NULL)
+		return -EINVAL;
+	if (newsmack == msg->security)
+		return 0;
+	if (!capable(CAP_MAC_ADMIN))
+		return -EPERM;
+	msg->security = newsmack;
+
+	return 0;
+}
+
 /**
  * smack_msg_msg_free_security - Clear the security blob for msg_msg
  * @msg: the object
@@ -2175,6 +2237,26 @@ static void smack_ipc_getsecid(struct kern_ipc_perm *ipp, u32 *secid)
 	*secid = smack_to_secid(smack);
 }
 
+static inline char *smack_ipc_get_ctx(void *security)
+{
+	return kstrdup((char *)security, GFP_KERNEL);
+}
+
+static inline int smack_ipc_restore(struct kern_ipc_perm *ipcp, char *ctx)
+{
+	char *newsmack = smk_import(ctx, 0);
+
+	if (newsmack == NULL)
+		return -EINVAL;
+	if (newsmack == ipcp->security)
+		return 0;
+	if (!capable(CAP_MAC_ADMIN))
+		return -EPERM;
+	ipcp->security = newsmack;
+
+	return 0;
+}
+
 /**
  * smack_d_instantiate - Make sure the blob is correct on an inode
  * @opt_dentry: unused
@@ -3064,6 +3146,8 @@ struct security_operations smack_ops = {
 	.inode_getsecid =		smack_inode_getsecid,
 
 	.file_permission = 		smack_file_permission,
+	.file_get_ctx = 		smack_file_get_ctx,
+	.file_restore = 		smack_file_restore,
 	.file_alloc_security = 		smack_file_alloc_security,
 	.file_free_security = 		smack_file_free_security,
 	.file_ioctl = 			smack_file_ioctl,
@@ -3073,6 +3157,8 @@ struct security_operations smack_ops = {
 	.file_send_sigiotask = 		smack_file_send_sigiotask,
 	.file_receive = 		smack_file_receive,
 
+	.cred_get_ctx =			smack_cred_get_ctx,
+	.cred_restore =			smack_cred_restore,
 	.cred_free =			smack_cred_free,
 	.cred_prepare =			smack_cred_prepare,
 	.cred_commit =			smack_cred_commit,
@@ -3094,8 +3180,12 @@ struct security_operations smack_ops = {
 
 	.ipc_permission = 		smack_ipc_permission,
 	.ipc_getsecid =			smack_ipc_getsecid,
+	.ipc_get_ctx =			smack_ipc_get_ctx,
+	.ipc_restore =			smack_ipc_restore,
 
 	.msg_msg_alloc_security = 	smack_msg_msg_alloc_security,
+	.msg_msg_get_ctx =		smack_msg_msg_get_ctx,
+	.msg_msg_restore =		smack_msg_msg_restore,
 	.msg_msg_free_security = 	smack_msg_msg_free_security,
 
 	.msg_queue_alloc_security = 	smack_msg_queue_alloc_security,
-- 
1.6.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

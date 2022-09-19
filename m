Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82117C6FA82
	for <selinux@archiver.kernel.org>; Mon, 19 Sep 2022 23:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiISXyP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Sep 2022 19:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiISXyO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Sep 2022 19:54:14 -0400
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3745350058
        for <selinux@vger.kernel.org>; Mon, 19 Sep 2022 16:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663631650; bh=26vkkN2ko4WHfblN3V11U0OqHqhsIeh6APonDlk5cTc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=YunUs9g7gxYQChQCV/PPrGL9rpFOuNsKb6vYV/j6gDpg1LMI54nH9QSvGsqrSCbN41iGUWtG5PAr7VO6S0CcQglzz/922V3kg02D9WBV4x/Ka0Zns2rl+zh5M45gq/iZiyeWVOAhYXbRTHQZBPXGW3HsM5lPMUq+xETkQL7+L4mMfhCHL6Pg3T16GkzvomnOt+HzWzyABM9laGe4xRj0AeFKB0WUrwOnm9yeR6qv+RLE6Tb8+q75+rgldVGXyNgB4LsFxhEAEgBz0TOxAO9ybPZrMCMeLsoyFP2wbGwTR8HCu2AYJOM3TPSGSOPWPGBalgOs35g6Y0KqzkG3ZXumHw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663631650; bh=UwefBNKcXLuan5mSgEX4RoRDDbHcJ20v2GaWrZmW4Ze=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=uFYuFOCK9NgNUYSaBq9w58VznBVCPpElWMc1CxQAe1UOUERlMLRRkaHT+Zt2LbyL1jx84XE9zvzOJh0VCLgCxthjTETzV6OumCRaTU5d95X/E3jrkJ0VGoZPci2cBXCGr3XK75L9T/2xJBmMV0w8FHo64n5kimebyBW/1Ru0axuhRJsaGjVz9Ujp27tVmy2A8tkWucn9wPyEXxkohAenObVOFsKqNxO6bg+z2ZPfrnBZZUpjBDnnl+MVRQXOVGx62yM4WAmGJIFzWNMNFGOXkMPn202lQMl/alyVfPbojR1/F71+gHVNBRq/tM+6zEqrPGJ0at1BGUn7kqql6pZ2xg==
X-YMail-OSG: eqE88WkVM1mjlnD5XQTrFFp0DNG80H8YvfWBFvfPqQE.Ryl60T1D2EuArjSU0ft
 qwQQjxfAUr2FembyNSZyJlDYyqReg5wLUEC0dO.2ygXxD6hq6uZtOdZsg8HyDWf9MebPcTY1RDkM
 iJ1yvdiRsq336HWCy8.lt5hnxPOVAPSyL3.ZCi4X7YS9DLofn4XDn.FAxBOu9oZaoH7ZcuaI7IPt
 ABDYFVbcfeRYoI1ibuc3DjSa4bEMM6_JjIDRSUnm_TNJqkm4PLUuz2PRhsBIdMoJMhDmGMt_WCEw
 Ym.50pdu8ON5jSOlW2Yyj.dQ4yjIVtxWnCk4GhZYpCDm5kRM93dBAQzQ4dupq7Vb6YER5wAyYjWm
 MMONlYPc4I92x6BiQg5432A9S.n1eum5XlhhsWFeBPjYCb8Nm04HDhI2JAje.Q2qaFcYoKCKj6u.
 haJ_XA6U9Wu6vtSbpOd4I.ErHpNMOIMqvrbT7h9hOtfobBXPehpF4GyvZjjIeLa8rC1pXynTFnmu
 LIg0lndqZf3QXSMMxBwMeW7JGpab8uSyG1HRsoGzQClGF0Lcl_6wdgjccDopjxdvNvNgFyL8aBCN
 iTwkDl9V1nVsZfrO0NLZCdAQOtTAte0NEDYrWphBrrEDCC1QRF5zdYRJH3KxELyulZ9cqh45PFKx
 7.Xi7sHNKBS2mw4hd2pNU2v8YhS9PTHTOGaNW5nDkNm8CfbZIQVwB304mQa0Cq7GBcdcu9xzh9WW
 SpK8312018CoXvfwSWSwuJ6SnahNftb3S70wMPsnsQU1Llbpb0pIgary2vQqIAUhN3SvE0.ihZjt
 nuZiPflaQEW9Dewb8qqwxiu1yLrSgHG1JN_qXw6Mu6_5QlqrTn437f7sJcv0Fhy457_gmmUgB4JI
 FrTE2ph6DQ53dSPR_fBntVeKvvelknnlrNWXFgXy1SpWd4xkYu5YtSmoujziBXf9XW.mJDiBdMAs
 d5MwSjqvQULUspVUaGE.u3CtXvbUs.adHUpYR2Sr6AwdArbH7kDze1ZsRVZJiMxajEOYyTbAba7K
 8qgnEscOeQyRbv1yzBGnQMXOEQhzMGH2wmUDabmgxFvzlMsFle0TColCilDTWH.MtMFhcsWK_vLY
 pvtbTeFtmM57l_2FQHoUa466UFs1ml3fzaFn5F51Dio5.SZjM4eT3lzD1H4cGGlFMEob2Q1QHdMm
 AJMWggw.MgcX15im7RV_yYa00GpY8_AoDEVxDc.keUYzknkynRHX6EFA0GWga00fYDo.5TYbJY7F
 xjl6r3PwtVkvgVoM96urfvVENDyskEoUCRiS9mmy6d8JxFJxEzIWiml3TU_eOVkbqBh1UYoYmClW
 _aspgbiO_XKk4laVpWfsG0sA_PRII2vl0pPNRNewShMev0piztLBNA92B1VnwV.5Hl9.6W5.KeZQ
 aC29NoMTM7_QME7adohNbQuVu8Otft7sv.WV5YO8ixJPR3Wpb1Z4QQMezhD4G1a5El.X8EyqSJJM
 CqbbqAC8Wyn.RD4rqQbkN5vzfS_jqyyC_te3azGA6Q2eyuCocOg96N12miOLyw7ufHLp2wZMq7t5
 yHhka2eElSw6LB29lDBo_kCtZz_4UedgAI6LmDEIJMtGXLUZitkW2lEl1i69NvoY23GgMRO5TkGE
 ISrJJlrTbOOwNifsubjHsIIwYiI._sMwx4MvnUS.5PHC3ey8PWQFg0qNL6kKnXAqk0DBJhFqcpKh
 29VE.ImwcmEjRxlfSE9MW4thS0t2G7y3oDncQn36hEHlHXN0vXF3mWrN5gv9gKSOVkL8nL_VkSOq
 L5dPlBblrb0QPfqctjCWuCf2hSqbyXJRiuYejmM6yMT7uF4JURz6_QuhQ10uJZOwO286fdwgVEja
 n3IOM1P0iXtHPgbrPVnxMsOk2sEN2HIBP3L0lcKbO9OGSJK2sMJKFF1JNB83tgvXO2_SOwGA4YWp
 8t1yxwWeFb2ZbbOBNhiaHLKTkT0M.WOsfI9Gj6uTtZDXKivMXsDFCcMnPVAR.dZKLdEQu6LOPNM4
 jqbqTIm9yrZVlcuO_DCNUdJ_toggDPkUr2J2QbVpvz_eO9Rf_fXgVa4Pj8abgIJ6zgTkN3ByhGhE
 RTeEvVqt43LgnLXTC64MxjHnHkx4MD4XYzjre5fMrXwOFaMC8vkVCwNm5hKwc0FL77E_shJ17bjI
 dSOddKLKXjbmr1Yj50dLM0fBeS6klw5.ElRUyY0D7lq.UvyE7Ey35lgQond6HcSOJ4_ui0mmCmc.
 z6hEbEMkp1SEqwzVVnR4C1kkOvRfxeIRcTOGj2sB7YroT
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 19 Sep 2022 23:54:10 +0000
Received: by hermes--production-ne1-544744cc75-m62bc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 296bc5abdbd1e536791ac9da76c02f1c;
          Mon, 19 Sep 2022 23:54:08 +0000 (UTC)
Message-ID: <2e8649ea-1389-5ff2-6d56-630276fb8ab3@schaufler-ca.com>
Date:   Mon, 19 Sep 2022 16:54:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: [PATCH v2 RFC] LSM: lsm_self_attr syscall for LSM self attributes
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        LSM List <linux-security-module@vger.kernel.org>
Cc:     John Johansen <john.johansen@canonical.com>,
        linux-audit@redhat.com, Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        SElinux list <selinux@vger.kernel.org>, casey@schaufler-ca.com
References: <5a9ff61e-cfe1-7385-aa17-5b800e489a9a.ref@schaufler-ca.com>
 <5a9ff61e-cfe1-7385-aa17-5b800e489a9a@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <5a9ff61e-cfe1-7385-aa17-5b800e489a9a@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20663 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create a system call lsm_self_attr() to provide the security
module maintained attributes of the current process. Historically
these attributes have been exposed to user space via entries in
procfs under /proc/self/attr.

Attributes are provided as a collection of lsm_ctx structures
which are placed into a user supplied buffer. Each structure
identifys the security module providing the attribute, which
of the possible attributes is provided, the size of the
attribute, and finally the attribute value. The format of the
attribute value is defined by the security module, but will
always be \0 terminated. The ctx_len value will be larger than
strlen(ctx).

	------------------------------
	| unsigned int id            |
	------------------------------
	| unsigned int flags         |
	------------------------------
	| __kernel_size_t ctx_len    |
	------------------------------
	| unsigned char ctx[ctx_len] |
	------------------------------
	| unsigned int id            |
	------------------------------
	| unsigned int flags         |
	------------------------------
	| __kernel_size_t ctx_len    |
	------------------------------
	| unsigned char ctx[ctx_len] |
	------------------------------

The individual security modules have been updated to report
which security attributes they can provide. That information
is collected in a table managed by the LSM infrastructure.

As this is the first system call interface provided by the
LSM infrastructure the uapi header file is added. It includes
LSM ID values for each of the up-stream security modules.
As these values are required for the API they can also be
leveraged to improve the performance of the /proc attribute
processing for security_[gs]etprocattr().

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/proc/base.c                         |  29 ++---
 fs/proc/internal.h                     |   2 +-
 include/linux/lsm_hooks.h              |  13 ++-
 include/linux/security.h               |  28 ++++-
 include/linux/syscalls.h               |   1 +
 include/uapi/asm-generic/unistd.h      |   5 +-
 include/uapi/linux/lsm.h               |  69 +++++++++++
 kernel/sys_ni.c                        |   3 +
 security/Makefile                      |   2 +-
 security/apparmor/lsm.c                |   9 +-
 security/bpf/hooks.c                   |  14 ++-
 security/commoncap.c                   |   9 +-
 security/landlock/cred.c               |   2 +-
 security/landlock/fs.c                 |   2 +-
 security/landlock/ptrace.c             |   2 +-
 security/landlock/setup.c              |   7 ++
 security/landlock/setup.h              |   1 +
 security/loadpin/loadpin.c             |  10 +-
 security/lockdown/lockdown.c           |   9 +-
 security/lsm_syscalls.c                | 156 +++++++++++++++++++++++++
 security/safesetid/lsm.c               |  10 +-
 security/security.c                    |  39 +++++--
 security/selinux/hooks.c               |  11 +-
 security/smack/smack_lsm.c             |   9 +-
 security/tomoyo/tomoyo.c               |  10 +-
 security/yama/yama_lsm.c               |   9 +-
 27 files changed, 414 insertions(+), 48 deletions(-)
 create mode 100644 include/uapi/linux/lsm.h
 create mode 100644 security/lsm_syscalls.c

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..56d5c5202fd0 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,7 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	lsm_self_attr		sys_lsm_self_attr
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 93f7e3d971e4..b2bda7d0619f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -96,6 +96,7 @@
 #include <linux/time_namespace.h>
 #include <linux/resctrl.h>
 #include <linux/cn_proc.h>
+#include <uapi/linux/lsm.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -145,10 +146,10 @@ struct pid_entry {
 	NOD(NAME, (S_IFREG|(MODE)),			\
 		NULL, &proc_single_file_operations,	\
 		{ .proc_show = show } )
-#define ATTR(LSM, NAME, MODE)				\
+#define ATTR(LSMID, NAME, MODE)				\
 	NOD(NAME, (S_IFREG|(MODE)),			\
 		NULL, &proc_pid_attr_operations,	\
-		{ .lsm = LSM })
+		{ .lsmid = LSMID })
 
 /*
  * Count the number of hardlinks for the pid_entry table, excluding the .
@@ -2727,7 +2728,7 @@ static ssize_t proc_pid_attr_read(struct file * file, char __user * buf,
 	if (!task)
 		return -ESRCH;
 
-	length = security_getprocattr(task, PROC_I(inode)->op.lsm,
+	length = security_getprocattr(task, PROC_I(inode)->op.lsmid,
 				      (char*)file->f_path.dentry->d_name.name,
 				      &p);
 	put_task_struct(task);
@@ -2785,7 +2786,7 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 	if (rv < 0)
 		goto out_free;
 
-	rv = security_setprocattr(PROC_I(inode)->op.lsm,
+	rv = security_setprocattr(PROC_I(inode)->op.lsmid,
 				  file->f_path.dentry->d_name.name, page,
 				  count);
 	mutex_unlock(&current->signal->cred_guard_mutex);
@@ -2834,27 +2835,27 @@ static const struct inode_operations proc_##LSM##_attr_dir_inode_ops = { \
 
 #ifdef CONFIG_SECURITY_SMACK
 static const struct pid_entry smack_attr_dir_stuff[] = {
-	ATTR("smack", "current",	0666),
+	ATTR(LSM_ID_SMACK, "current",	0666),
 };
 LSM_DIR_OPS(smack);
 #endif
 
 #ifdef CONFIG_SECURITY_APPARMOR
 static const struct pid_entry apparmor_attr_dir_stuff[] = {
-	ATTR("apparmor", "current",	0666),
-	ATTR("apparmor", "prev",	0444),
-	ATTR("apparmor", "exec",	0666),
+	ATTR(LSM_ID_APPARMOR, "current",	0666),
+	ATTR(LSM_ID_APPARMOR, "prev",		0444),
+	ATTR(LSM_ID_APPARMOR, "exec",		0666),
 };
 LSM_DIR_OPS(apparmor);
 #endif
 
 static const struct pid_entry attr_dir_stuff[] = {
-	ATTR(NULL, "current",		0666),
-	ATTR(NULL, "prev",		0444),
-	ATTR(NULL, "exec",		0666),
-	ATTR(NULL, "fscreate",		0666),
-	ATTR(NULL, "keycreate",		0666),
-	ATTR(NULL, "sockcreate",	0666),
+	ATTR(LSM_ID_INVALID, "current",		0666),
+	ATTR(LSM_ID_INVALID, "prev",		0444),
+	ATTR(LSM_ID_INVALID, "exec",		0666),
+	ATTR(LSM_ID_INVALID, "fscreate",	0666),
+	ATTR(LSM_ID_INVALID, "keycreate",	0666),
+	ATTR(LSM_ID_INVALID, "sockcreate",	0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 06a80f78433d..3f6f4a7a1498 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -87,7 +87,7 @@ union proc_op {
 	int (*proc_show)(struct seq_file *m,
 		struct pid_namespace *ns, struct pid *pid,
 		struct task_struct *task);
-	const char *lsm;
+	int lsmid;
 };
 
 struct proc_inode {
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 3aa6030302f5..ded76db3f523 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1598,6 +1598,15 @@ struct security_hook_heads {
 	#undef LSM_HOOK
 } __randomize_layout;
 
+/*
+ * Information that identifies a security module.
+ */
+struct lsm_id {
+	const char	*lsm;		/* Name of the LSM */
+	int		id;		/* LSM ID */
+	int		features;	/* Set of LSM features */
+};
+
 /*
  * Security module hook list structure.
  * For use with generic list macros for common operations.
@@ -1606,7 +1615,7 @@ struct security_hook_list {
 	struct hlist_node		list;
 	struct hlist_head		*head;
 	union security_list_options	hook;
-	const char			*lsm;
+	struct lsm_id			*lsmid;
 } __randomize_layout;
 
 /*
@@ -1641,7 +1650,7 @@ extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				const char *lsm);
+			       struct lsm_id *lsmid);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 #define LSM_FLAG_EXCLUSIVE	BIT(1)
diff --git a/include/linux/security.h b/include/linux/security.h
index 7bd0c490703d..c4696f14daac 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -136,6 +136,23 @@ enum lockdown_reason {
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
 
+#define LSMID_ENTRIES ( \
+	1 + /* capabilities */ \
+	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_IMA) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_LOCKDOWN) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
+
+extern int lsm_id;
+extern struct lsm_id *lsm_idlist[];
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
@@ -461,10 +478,9 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
 int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
 			unsigned nsops, int alter);
 void security_d_instantiate(struct dentry *dentry, struct inode *inode);
-int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
+int security_getprocattr(struct task_struct *p, int lsmid, char *name,
 			 char **value);
-int security_setprocattr(const char *lsm, const char *name, void *value,
-			 size_t size);
+int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
@@ -1300,14 +1316,14 @@ static inline void security_d_instantiate(struct dentry *dentry,
 					  struct inode *inode)
 { }
 
-static inline int security_getprocattr(struct task_struct *p, const char *lsm,
+static inline int security_getprocattr(struct task_struct *p, int lsmid,
 				       char *name, char **value)
 {
 	return -EINVAL;
 }
 
-static inline int security_setprocattr(const char *lsm, char *name,
-				       void *value, size_t size)
+static inline int security_setprocattr(int lsmid, char *name, void *value,
+				       size_t size)
 {
 	return -EINVAL;
 }
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a34b0f9a9972..7f87ef8be546 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1056,6 +1056,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
+asmlinkage long sys_lsm_self_attr(struct lsm_ctx *ctx, size_t *size, int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 45fa180cc56a..aa66718e1b48 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -886,8 +886,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 
+#define __NR_lsm_self_attr 451
+__SYSCALL(__NR_lsm_self_attr, sys_lsm_self_attr)
+
 #undef __NR_syscalls
-#define __NR_syscalls 451
+#define __NR_syscalls 452
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
new file mode 100644
index 000000000000..832a4d700ff1
--- /dev/null
+++ b/include/uapi/linux/lsm.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Linus Security Modules (LSM) - User space API
+ *
+ * Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
+ * Copyright (C) Intel Corporation
+ */
+
+#ifndef _UAPI_LINUX_LSM_H
+#define _UAPI_LINUX_LSM_H
+
+#include <linux/types.h>
+#include <linux/unistd.h>
+
+/**
+ * struct lsm_ctx - LSM context
+ * @id: the LSM id number, see LSM_ID_XXX
+ * @flags: context specifier and LSM specific flags
+ * @ctx_len: the size of @ctx
+ * @ctx: the LSM context, a nul terminated string
+ *
+ * @ctx in a nul terminated string.
+ *	(strlen(@ctx) < @ctx_len) is always true.
+ *	(strlen(@ctx) == @ctx_len + 1) is not guaranteed.
+ */
+struct lsm_ctx {
+	unsigned int		id;
+	unsigned int		flags;
+	__kernel_size_t		ctx_len;
+	unsigned char		ctx[];
+};
+
+/*
+ * ID values to identify security modules.
+ * A system may use more than one security module.
+ *
+ * LSM_ID_XXX values 32 and below are reserved for future use
+ */
+#define LSM_ID_INVALID		-1
+#define LSM_ID_SELINUX		33
+#define LSM_ID_SMACK		34
+#define LSM_ID_TOMOYO		35
+#define LSM_ID_IMA		36
+#define LSM_ID_APPARMOR		37
+#define LSM_ID_YAMA		38
+#define LSM_ID_LOADPIN		39
+#define LSM_ID_SAFESETID	40
+#define LSM_ID_LOCKDOWN		41
+#define LSM_ID_BPF		42
+#define LSM_ID_LANDLOCK		43
+#define LSM_ID_CAPABILITY	44
+
+/*
+ * Flag values.
+ *
+ * LSM_ATTR_XXX values identify the /proc/.../attr entry that the
+ * context represents. Not all security modules provide all of these
+ * values. Some security modules provide none of them.
+ */
+/* clang-format off */
+#define LSM_ATTR_CURRENT	(1UL << 0)
+#define LSM_ATTR_EXEC		(1UL << 1)
+#define LSM_ATTR_FSCREATE	(1UL << 2)
+#define LSM_ATTR_KEYCREATE	(1UL << 3)
+#define LSM_ATTR_PREV		(1UL << 4)
+#define LSM_ATTR_SOCKCREATE	(1UL << 5)
+/* clang-format on */
+
+#endif /* _UAPI_LINUX_LSM_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 860b2dcf3ac4..99bf07e64409 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -262,6 +262,9 @@ COND_SYSCALL_COMPAT(recvmsg);
 /* mm/nommu.c, also with MMU */
 COND_SYSCALL(mremap);
 
+/* security/lsm_syscalls.c */
+COND_SYSCALL(lsm_attr_self);
+
 /* security/keys/keyctl.c */
 COND_SYSCALL(add_key);
 COND_SYSCALL(request_key);
diff --git a/security/Makefile b/security/Makefile
index 18121f8f85cd..409c47a25fcf 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -6,7 +6,7 @@
 obj-$(CONFIG_KEYS)			+= keys/
 
 # always enable default capabilities
-obj-y					+= commoncap.o
+obj-y					+= commoncap.o lsm_syscalls.o
 obj-$(CONFIG_MMU)			+= min_addr.o
 
 # Object file lists
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index e29cade7b662..40266cc4866c 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -24,6 +24,7 @@
 #include <linux/zlib.h>
 #include <net/sock.h>
 #include <uapi/linux/mount.h>
+#include <uapi/linux/lsm.h>
 
 #include "include/apparmor.h"
 #include "include/apparmorfs.h"
@@ -1202,6 +1203,12 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 	.lbs_task = sizeof(struct aa_task_ctx),
 };
 
+static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
+	.lsm      = "apparmor",
+	.id       = LSM_ID_APPARMOR,
+	.features = LSM_ATTR_CURRENT | LSM_ATTR_PREV | LSM_ATTR_EXEC,
+};
+
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
@@ -1897,7 +1904,7 @@ static int __init apparmor_init(void)
 		goto buffers_out;
 	}
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
-				"apparmor");
+				&apparmor_lsmid);
 
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index e5971fa74fd7..ad75ffd17319 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -5,6 +5,7 @@
  */
 #include <linux/lsm_hooks.h>
 #include <linux/bpf_lsm.h>
+#include <uapi/linux/lsm.h>
 
 static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
@@ -15,9 +16,20 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
 };
 
+/*
+ * slot has to be LSMBLOB_NEEDED because some of the hooks
+ * supplied by this module require a slot.
+ */
+struct lsm_id bpf_lsmid __lsm_ro_after_init = {
+	.lsm      = "bpf",
+	.id       = LSM_ID_BPF,
+	.features = 0,
+};
+
 static int __init bpf_lsm_init(void)
 {
-	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
+	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks),
+			   &bpf_lsmid);
 	pr_info("LSM support for eBPF active\n");
 	return 0;
 }
diff --git a/security/commoncap.c b/security/commoncap.c
index 5fc8986c3c77..1ef9e2cc2c31 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -25,6 +25,7 @@
 #include <linux/binfmts.h>
 #include <linux/personality.h>
 #include <linux/mnt_idmapping.h>
+#include <uapi/linux/lsm.h>
 
 /*
  * If a non-root user executes a setuid-root binary in
@@ -1446,6 +1447,12 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 
 #ifdef CONFIG_SECURITY
 
+static struct lsm_id capability_lsmid __lsm_ro_after_init = {
+	.lsm      = "capability",
+	.id       = LSM_ID_CAPABILITY,
+	.features = 0,
+};
+
 static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(capable, cap_capable),
 	LSM_HOOK_INIT(settime, cap_settime),
@@ -1470,7 +1477,7 @@ static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 static int __init capability_init(void)
 {
 	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
-				"capability");
+			   &capability_lsmid);
 	return 0;
 }
 
diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index ec6c37f04a19..2eb1d65f10d6 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -42,5 +42,5 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 __init void landlock_add_cred_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			   LANDLOCK_NAME);
+			   &landlock_lsmid);
 }
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index a9dbd99d9ee7..b1515fc67d57 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1201,5 +1201,5 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 __init void landlock_add_fs_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			   LANDLOCK_NAME);
+			   &landlock_lsmid);
 }
diff --git a/security/landlock/ptrace.c b/security/landlock/ptrace.c
index 4c5b9cd71286..eab35808f395 100644
--- a/security/landlock/ptrace.c
+++ b/security/landlock/ptrace.c
@@ -116,5 +116,5 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 __init void landlock_add_ptrace_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			   LANDLOCK_NAME);
+			   &landlock_lsmid);
 }
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index f8e8e980454c..237b49cf5ab6 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -8,6 +8,7 @@
 
 #include <linux/init.h>
 #include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
 
 #include "common.h"
 #include "cred.h"
@@ -23,6 +24,12 @@ struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
 	.lbs_superblock = sizeof(struct landlock_superblock_security),
 };
 
+struct lsm_id landlock_lsmid __lsm_ro_after_init = {
+	.lsm      = LANDLOCK_NAME,
+	.id       = LSM_ID_LANDLOCK,
+	.features = 0,
+};
+
 static int __init landlock_init(void)
 {
 	landlock_add_cred_hooks();
diff --git a/security/landlock/setup.h b/security/landlock/setup.h
index 1daffab1ab4b..38bce5b172dc 100644
--- a/security/landlock/setup.h
+++ b/security/landlock/setup.h
@@ -14,5 +14,6 @@
 extern bool landlock_initialized;
 
 extern struct lsm_blob_sizes landlock_blob_sizes;
+extern struct lsm_id landlock_lsmid;
 
 #endif /* _SECURITY_LANDLOCK_SETUP_H */
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 44521582dcba..1d526ea5d996 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -20,6 +20,7 @@
 #include <linux/string_helpers.h>
 #include <linux/dm-verity-loadpin.h>
 #include <uapi/linux/loadpin.h>
+#include <uapi/linux/lsm.h>
 
 static void report_load(const char *origin, struct file *file, char *operation)
 {
@@ -195,6 +196,12 @@ static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
 	return loadpin_read_file(NULL, (enum kernel_read_file_id) id, contents);
 }
 
+static struct lsm_id loadpin_lsmid __lsm_ro_after_init = {
+	.lsm      = "loadpin",
+	.id       = LSM_ID_LOADPIN,
+	.features = 0,
+};
+
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
@@ -242,7 +249,8 @@ static int __init loadpin_init(void)
 	pr_info("ready to pin (currently %senforcing)\n",
 		enforce ? "" : "not ");
 	parse_exclude();
-	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks),
+			   &loadpin_lsmid);
 
 	return 0;
 }
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 87cbdc64d272..8871b4e0900c 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -13,6 +13,7 @@
 #include <linux/security.h>
 #include <linux/export.h>
 #include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
 
 static enum lockdown_reason kernel_locked_down;
 
@@ -75,6 +76,12 @@ static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
 };
 
+static struct lsm_id lockdown_lsmid __lsm_ro_after_init = {
+	.lsm     = "lockdown",
+	.id       = LSM_ID_LOCKDOWN,
+	.features = 0,
+};
+
 static int __init lockdown_lsm_init(void)
 {
 #if defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY)
@@ -83,7 +90,7 @@ static int __init lockdown_lsm_init(void)
 	lock_kernel_down("Kernel configuration", LOCKDOWN_CONFIDENTIALITY_MAX);
 #endif
 	security_add_hooks(lockdown_hooks, ARRAY_SIZE(lockdown_hooks),
-			   "lockdown");
+			   &lockdown_lsmid);
 	return 0;
 }
 
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
new file mode 100644
index 000000000000..da0fab7065e2
--- /dev/null
+++ b/security/lsm_syscalls.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * System calls implementing the Linux Security Module API.
+ *
+ *  Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
+ *  Copyright (C) Intel Corporation
+ */
+
+#include <asm/current.h>
+#include <linux/compiler_types.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/security.h>
+#include <linux/stddef.h>
+#include <linux/syscalls.h>
+#include <linux/types.h>
+#include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
+
+struct feature_map {
+	char *name;
+	int feature;
+};
+
+static const struct feature_map lsm_attr_names[] = {
+	{ .name = "current",	.feature = LSM_ATTR_CURRENT, },
+	{ .name = "exec",	.feature = LSM_ATTR_EXEC, },
+	{ .name = "fscreate",	.feature = LSM_ATTR_FSCREATE, },
+	{ .name = "keycreate",	.feature = LSM_ATTR_KEYCREATE, },
+	{ .name = "prev",	.feature = LSM_ATTR_PREV, },
+	{ .name = "sockcreate",	.feature = LSM_ATTR_SOCKCREATE, },
+};
+
+/**
+ * lsm_self_attr - Return current task's security module attributes
+ * @ctx: the LSM contexts
+ * @size: size of @ctx, updated on return
+ * @flags: reserved for future use, must be zero
+ *
+ * Returns the calling task's LSM contexts. On success this
+ * function returns the number of @ctx array elements. This value
+ * may be zero if there are no LSM contexts assigned. If @size is
+ * insufficient to contain the return data -E2BIG is returned and
+ * @size is set to the minimum required size. In all other cases
+ * a negative value indicating the error is returned.
+ */
+SYSCALL_DEFINE3(lsm_self_attr,
+	       struct lsm_ctx __user *, ctx,
+	       size_t __user *, size,
+	       int, flags)
+{
+	struct lsm_ctx *final = NULL;
+	struct lsm_ctx *interum;
+	struct lsm_ctx *ip;
+	void *curr;
+	char **interum_ctx;
+	char *cp;
+	size_t total_size = 0;
+	int count = 0;
+	int attr;
+	int len;
+	int rc = 0;
+	int i;
+
+	interum = kzalloc(ARRAY_SIZE(lsm_attr_names) * lsm_id *
+			  sizeof(*interum), GFP_KERNEL);
+	if (interum == NULL)
+		return -ENOMEM;
+	ip = interum;
+
+	interum_ctx = kzalloc(ARRAY_SIZE(lsm_attr_names) * lsm_id *
+			      sizeof(*interum_ctx), GFP_KERNEL);
+	if (interum_ctx == NULL) {
+		kfree(interum);
+		return -ENOMEM;
+	}
+
+	for (attr = 0; attr < ARRAY_SIZE(lsm_attr_names); attr++) {
+		for (i = 0; i < lsm_id; i++) {
+			if ((lsm_idlist[i]->features &
+			     lsm_attr_names[attr].feature) == 0)
+				continue;
+
+			len = security_getprocattr(current, lsm_idlist[i]->id,
+						   lsm_attr_names[attr].name,
+						   &cp);
+			if (len <= 0)
+				continue;
+
+			ip->id = lsm_idlist[i]->id;
+			ip->flags = lsm_attr_names[attr].feature;
+			/* space for terminating \0 is allocated below */
+			ip->ctx_len = len + 1;
+			interum_ctx[count] = cp;
+			/*
+			 * Security modules have been inconsistent about
+			 * including the \0 terminator in the size. The
+			 * context len has been adjusted to ensure there
+			 * is one.
+			 * At least one security module adds a \n at the
+			 * end of a context to make it look nicer. Change
+			 * that to a \0 so that user space doesn't have to
+			 * work around it. Because of this meddling it is
+			 * safe to assume that lsm_ctx.name is terminated
+			 * and that strlen(lsm_ctx.name) < lsm.ctx_len.
+			 */
+			total_size += sizeof(*interum) + ip->ctx_len;
+			cp = strnchr(cp, len, '\n');
+			if (cp != NULL)
+				*cp = '\0';
+			ip++;
+			count++;
+		}
+	}
+
+	if (count == 0)
+		goto free_out;
+
+	final = kzalloc(total_size, GFP_KERNEL);
+	if (final == NULL) {
+		rc = -ENOMEM;
+		goto free_out;
+	}
+
+	curr = final;
+	ip = interum;
+	for (i = 0; i < count; i++) {
+		memcpy(curr, ip, sizeof(*interum));
+		curr += sizeof(*interum);
+		memcpy(curr, interum_ctx[i], ip->ctx_len);
+		curr += ip->ctx_len;
+		ip++;
+	}
+
+	if (get_user(len, size)) {
+		rc = -EFAULT;
+		goto free_out;
+	}
+	if (total_size > len) {
+		rc = -ERANGE;
+		goto free_out;
+	}
+	if (copy_to_user(ctx, final, total_size) != 0 ||
+	    put_user(total_size, size) != 0)
+		rc = -EFAULT;
+	else
+		rc = count;
+
+free_out:
+	for (i = 0; i < count; i++)
+		kfree(interum_ctx[i]);
+	kfree(interum_ctx);
+	kfree(interum);
+	kfree(final);
+	return rc;
+}
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index e806739f7868..fc8255a22836 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -19,6 +19,7 @@
 #include <linux/ptrace.h>
 #include <linux/sched/task_stack.h>
 #include <linux/security.h>
+#include <uapi/linux/lsm.h>
 #include "lsm.h"
 
 /* Flag indicating whether initialization completed */
@@ -261,6 +262,12 @@ static int safesetid_task_fix_setgroups(struct cred *new, const struct cred *old
 	return 0;
 }
 
+static struct lsm_id safesetid_lsmid __lsm_ro_after_init = {
+	.lsm      = "safesetid",
+	.id       = LSM_ID_SAFESETID,
+	.features = 0,
+};
+
 static struct security_hook_list safesetid_security_hooks[] = {
 	LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
 	LSM_HOOK_INIT(task_fix_setgid, safesetid_task_fix_setgid),
@@ -271,7 +278,8 @@ static struct security_hook_list safesetid_security_hooks[] = {
 static int __init safesetid_security_init(void)
 {
 	security_add_hooks(safesetid_security_hooks,
-			   ARRAY_SIZE(safesetid_security_hooks), "safesetid");
+			   ARRAY_SIZE(safesetid_security_hooks),
+			   &safesetid_lsmid);
 
 	/* Report that SafeSetID successfully initialized */
 	safesetid_initialized = 1;
diff --git a/security/security.c b/security/security.c
index 4b95de24bc8d..faf99e1600b3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,6 +28,7 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <linux/msg.h>
+#include <uapi/linux/lsm.h>
 #include <net/flow.h>
 
 #define MAX_LSM_EVM_XATTR	2
@@ -318,6 +319,13 @@ static void __init lsm_early_task(struct task_struct *task);
 
 static int lsm_append(const char *new, char **result);
 
+/*
+ * Current index to use while initializing the lsm id list.
+ */
+int lsm_id __lsm_ro_after_init;
+struct lsm_id *lsm_idlist[LSMID_ENTRIES] __lsm_ro_after_init;
+
+
 static void __init ordered_lsm_init(void)
 {
 	struct lsm_info **lsm;
@@ -362,6 +370,8 @@ static void __init ordered_lsm_init(void)
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		initialize_lsm(*lsm);
 
+	init_debug("lsm count            = %d\n", lsm_id);
+
 	kfree(ordered_lsms);
 }
 
@@ -474,17 +484,27 @@ static int lsm_append(const char *new, char **result)
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
  * @count: the number of hooks to add
- * @lsm: the name of the security module
+ * @lsmid: the identification information for the security module
  *
  * Each LSM has to register its hooks with the infrastructure.
  */
 void __init security_add_hooks(struct security_hook_list *hooks, int count,
-				const char *lsm)
+			       struct lsm_id *lsmid)
 {
 	int i;
 
+	/*
+	 * A security module may call security_add_hooks() more
+	 * than once. Landlock is one such case.
+	 */
+	if (lsm_id == 0 || lsm_idlist[lsm_id - 1] != lsmid)
+		lsm_idlist[lsm_id++] = lsmid;
+
+	if (lsm_id > LSMID_ENTRIES)
+		panic("%s Too many LSMs registered.\n", __func__);
+
 	for (i = 0; i < count; i++) {
-		hooks[i].lsm = lsm;
+		hooks[i].lsmid = lsmid;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
 	}
 
@@ -493,7 +513,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	 * and fix this up afterwards.
 	 */
 	if (slab_is_available()) {
-		if (lsm_append(lsm, &lsm_names) < 0)
+		if (lsm_append(lsmid->lsm, &lsm_names) < 0)
 			panic("%s - Cannot get early memory.\n", __func__);
 	}
 }
@@ -2057,26 +2077,25 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
-int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
-				char **value)
+int security_getprocattr(struct task_struct *p, int lsmid, char *name,
+			 char **value)
 {
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsmid != LSM_ID_INVALID && lsmid != hp->lsmid->id)
 			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
 	return LSM_RET_DEFAULT(getprocattr);
 }
 
-int security_setprocattr(const char *lsm, const char *name, void *value,
-			 size_t size)
+int security_setprocattr(int lsmid, const char *name, void *value, size_t size)
 {
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsmid != LSM_ID_INVALID && lsmid != hp->lsmid->id)
 			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 03bca97c8b29..625cc791c440 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -92,6 +92,7 @@
 #include <linux/fsnotify.h>
 #include <linux/fanotify.h>
 #include <linux/io_uring.h>
+#include <uapi/linux/lsm.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -7012,6 +7013,13 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 }
 #endif /* CONFIG_IO_URING */
 
+static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
+	.lsm      = "selinux",
+	.id       = LSM_ID_SELINUX,
+	.features = LSM_ATTR_CURRENT | LSM_ATTR_EXEC | LSM_ATTR_FSCREATE |
+		    LSM_ATTR_KEYCREATE | LSM_ATTR_PREV | LSM_ATTR_SOCKCREATE,
+};
+
 /*
  * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
  * 1. any hooks that don't belong to (2.) or (3.) below,
@@ -7331,7 +7339,8 @@ static __init int selinux_init(void)
 
 	hashtab_cache_init();
 
-	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
+			   &selinux_lsmid);
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index bffccdc494cb..e79640a6bfd7 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -43,6 +43,7 @@
 #include <linux/fs_parser.h>
 #include <linux/watch_queue.h>
 #include <linux/io_uring.h>
+#include <uapi/linux/lsm.h>
 #include "smack.h"
 
 #define TRANS_TRUE	"TRUE"
@@ -4774,6 +4775,12 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 	.lbs_superblock = sizeof(struct superblock_smack),
 };
 
+static struct lsm_id smack_lsmid __lsm_ro_after_init = {
+	.lsm      = "smack",
+	.id       = LSM_ID_SMACK,
+	.features = LSM_ATTR_CURRENT,
+};
+
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
@@ -4976,7 +4983,7 @@ static __init int smack_init(void)
 	/*
 	 * Register with LSM
 	 */
-	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), &smack_lsmid);
 	smack_enabled = 1;
 
 	pr_info("Smack:  Initializing.\n");
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 71e82d855ebf..9304487d4577 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
 #include "common.h"
 
 /**
@@ -530,6 +531,12 @@ static void tomoyo_task_free(struct task_struct *task)
 	}
 }
 
+static struct lsm_id tomoyo_lsmid __lsm_ro_after_init = {
+	.lsm      = "tomoyo",
+	.id       = LSM_ID_TOMOYO,
+	.features = 0,
+};
+
 /*
  * tomoyo_security_ops is a "struct security_operations" which is used for
  * registering TOMOYO.
@@ -582,7 +589,8 @@ static int __init tomoyo_init(void)
 	struct tomoyo_task *s = tomoyo_task(current);
 
 	/* register ourselves with the security framework */
-	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
+	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks),
+			   &tomoyo_lsmid);
 	pr_info("TOMOYO Linux initialized\n");
 	s->domain_info = &tomoyo_kernel_domain;
 	atomic_inc(&tomoyo_kernel_domain.users);
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 06e226166aab..8a9a0d407647 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -18,6 +18,7 @@
 #include <linux/task_work.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <uapi/linux/lsm.h>
 
 #define YAMA_SCOPE_DISABLED	0
 #define YAMA_SCOPE_RELATIONAL	1
@@ -421,6 +422,12 @@ static int yama_ptrace_traceme(struct task_struct *parent)
 	return rc;
 }
 
+static struct lsm_id yama_lsmid __lsm_ro_after_init = {
+	.lsm      = "yama",
+	.id       = LSM_ID_YAMA,
+	.features = 0,
+};
+
 static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
@@ -477,7 +484,7 @@ static inline void yama_init_sysctl(void) { }
 static int __init yama_init(void)
 {
 	pr_info("Yama: becoming mindful.\n");
-	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
+	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), &yama_lsmid);
 	yama_init_sysctl();
 	return 0;
 }
-- 
2.36.1



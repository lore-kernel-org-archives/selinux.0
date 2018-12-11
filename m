Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948F8C67839
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E30E2086D
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Hj9Fgv2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E30E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeLKWn5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:43:57 -0500
Received: from sonic308-17.consmr.mail.ne1.yahoo.com ([66.163.187.40]:37751
        "EHLO sonic308-17.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726559AbeLKWny (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568231; bh=PBT9NIfIFWqve0jgHQc8SqCsASaMC4tLfOD1iemFqzE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Hj9Fgv2BK6BOQPCOoYDUfB4tmj4W3L1lGRX2NAf3zA+i9kBjgae4aj/2Otb9Qf3apKW5DFVkTKN33MLZ2aryahfpxNqvnCIXvA9nyCtgKSZHSxp1RoL57mw8LIwh2N6Ib/rU3o77jOl5XwaJ9duGn4GV4SPn3DUxJEYvFRxzvg6GFlMbAwMmow/7ABhxK9aTmsjkQpmat/PdzkOD3y6uLkEV3cjjz8QIUkHkxjQaKlLLGck12rhmzy/te3wk/nWUcsE2OnYOWdFLsNWiQt3WM6Hz5rtPqUsBdPQS0jFZU5yB6Jzu9kvaqKFJbmhkEqJAo6oweb0EkxES/f9pqyezPg==
X-YMail-OSG: GFYM0dwVM1nBF2LyWlPECLqKVLs3YI.0Lzskt_B4WcwqBqe9vBHbj39Xk1QbLfz
 zfFvlFUqn9Gd6WxUFRK6HFqRlvfzeQ34PDrwmV1w3GCxoZtgI.69B3XQnvbfJm3JeJDQVjuLryEC
 3HCTDrh0k1DrSJJ5jLybZ6gAB29h3.RZMcoUaZAZMZ6Mw_ze2inBXO4t8IvlznjgDm0xYGKIXVQL
 lRDnfIJA1A12FaF_w7jR8LK4UD8OD6uK09ilcV69ZH5XvZO3dZD.F6uVd0GDd6irOTkm28L0sJ1t
 YMRRf920119Z.Ini79ozHD6xMDKJTcbEa0qpEYwYDvH337kInUI2uvvjBbTriIn0CVVSds5foWms
 S4yiMn1WzJwck_5UZTOCqTZndCsFpqaPuluA1eEmrECZFE66Ga5T3ucCvDSlMd.F7zP3ShHH7Xxc
 _906RlgeVwVgo1Tp9JUwA9CClRURKvbIuLEH.TecgzyK28XDt.4UDnllGnd.ZeZsPc80S56j5SXM
 GCXIJb2UZqMRyxhoLrAnTOTo8eLJ7FgW79dMk9C4YH.KVaqNVHJ.1mZp7S7BkmKC17nYYyGvPREI
 RdES3V2ORakg5qDWS3ZPmeLgn5zMKR5YylRDMfUgAP6YjCJuvFJRNpsvsjH1mDSoB64NrG_NRl5o
 o.iAzbOOjPJMOXO5r.78VCMqJS2ushazcnGUQ1TJ8RBgD8w9YDlrVAp8VMcu4ZbDn_ABceslahYB
 LYvK8m5XHDYMaPiWA_uFLD.iPFpOeTGbugBECFIf0LZZy0qJTqzS1HulYXDX7012903mDOlbrdVb
 dihLjMaoXMUVCJuwHvhMSkqvay6l.xhRWn7OxXoVHjrg_IeEWR_ZcY_WbhgcfocS3xq0N2m2SHw8
 2O22kQ.mtz0IPQS5QdZVZHXazI30PGxCWFE49qP9uCfd6Xwk.UtiITMahfkk83mkEZqTq88TcZbJ
 Pcc.qELOp2gYXtVzr0.7OAKEWRNmKlsXk3rFueXLpP1_djUKw._4F.qtjLwj3EHTbezFBLAfsHD7
 Pz.4NjX6py23Jvs69hGHEjPlB0votRo1pHN7Hu5vwhWQyOpH155Y4DKlcRF4gsqgpACEifAkXHio
 80hWLnqYcoMemFIbqHybd1cgho9qrBfvSBrN9kg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:51 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8f4847c15ff2a33ea2e557120f9f24e5;
          Tue, 11 Dec 2018 22:43:46 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 20/38] procfs: add smack subdir to attrs
Date:   Tue, 11 Dec 2018 14:42:56 -0800
Message-Id: <20181211224314.22412-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Back in 2007 I made what turned out to be a rather serious
mistake in the implementation of the Smack security module.
The SELinux module used an interface in /proc to manipulate
the security context on processes. Rather than use a similar
interface, I used the same interface. The AppArmor team did
likewise. Now /proc/.../attr/current will tell you the
security "context" of the process, but it will be different
depending on the security module you're using.

This patch provides a subdirectory in /proc/.../attr for
Smack. Smack user space can use the "current" file in
this subdirectory and never have to worry about getting
SELinux attributes by mistake. Programs that use the
old interface will continue to work (or fail, as the case
may be) as before.

The proposed S.A.R.A security module is dependent on
the mechanism to create its own attr subdirectory.

The original implementation is by Kees Cook.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/LSM/index.rst | 13 +++++--
 fs/proc/base.c                          | 64 ++++++++++++++++++++++++++++-----
 fs/proc/internal.h                      |  1 +
 include/linux/security.h                | 15 +++++---
 security/security.c                     | 24 ++++++++++---
 5 files changed, 96 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
index c980dfe9abf1..9842e21afd4a 100644
--- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -17,9 +17,8 @@ MAC extensions, other extensions can be built using the LSM to provide
 specific changes to system operation when these tweaks are not available
 in the core functionality of Linux itself.
 
-Without a specific LSM built into the kernel, the default LSM will be the
-Linux capabilities system. Most LSMs choose to extend the capabilities
-system, building their checks on top of the defined capability hooks.
+The Linux capabilities modules will always be included. This may be
+followed by any number of "minor" modules and at most one "major" module.
 For more details on capabilities, see ``capabilities(7)`` in the Linux
 man-pages project.
 
@@ -30,6 +29,14 @@ order in which checks are made. The capability module will always
 be first, followed by any "minor" modules (e.g. Yama) and then
 the one "major" module (e.g. SELinux) if there is one configured.
 
+Process attributes associated with "major" security modules should
+be accessed and maintained using the special files in ``/proc/.../attr``.
+A security module may maintain a module specific subdirectory there,
+named after the module. ``/proc/.../attr/smack`` is provided by the Smack
+security module and contains all its special files. The files directly
+in ``/proc/.../attr`` remain as legacy interfaces for modules that provide
+subdirectories.
+
 .. toctree::
    :maxdepth: 1
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ce3465479447..e133de4897df 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -140,9 +140,13 @@ struct pid_entry {
 #define REG(NAME, MODE, fops)				\
 	NOD(NAME, (S_IFREG|(MODE)), NULL, &fops, {})
 #define ONE(NAME, MODE, show)				\
-	NOD(NAME, (S_IFREG|(MODE)), 			\
+	NOD(NAME, (S_IFREG|(MODE)),			\
 		NULL, &proc_single_file_operations,	\
 		{ .proc_show = show } )
+#define ATTR(LSM, NAME, MODE)				\
+	NOD(NAME, (S_IFREG|(MODE)),			\
+		NULL, &proc_pid_attr_operations,	\
+		{ .lsm = LSM })
 
 /*
  * Count the number of hardlinks for the pid_entry table, excluding the .
@@ -2517,7 +2521,7 @@ static ssize_t proc_pid_attr_read(struct file * file, char __user * buf,
 	if (!task)
 		return -ESRCH;
 
-	length = security_getprocattr(task,
+	length = security_getprocattr(task, PROC_I(inode)->op.lsm,
 				      (char*)file->f_path.dentry->d_name.name,
 				      &p);
 	put_task_struct(task);
@@ -2566,7 +2570,9 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 	if (rv < 0)
 		goto out_free;
 
-	rv = security_setprocattr(file->f_path.dentry->d_name.name, page, count);
+	rv = security_setprocattr(PROC_I(inode)->op.lsm,
+				  file->f_path.dentry->d_name.name, page,
+				  count);
 	mutex_unlock(&current->signal->cred_guard_mutex);
 out_free:
 	kfree(page);
@@ -2580,13 +2586,53 @@ static const struct file_operations proc_pid_attr_operations = {
 	.llseek		= generic_file_llseek,
 };
 
+#define LSM_DIR_OPS(LSM) \
+static int proc_##LSM##_attr_dir_iterate(struct file *filp, \
+			     struct dir_context *ctx) \
+{ \
+	return proc_pident_readdir(filp, ctx, \
+				   LSM##_attr_dir_stuff, \
+				   ARRAY_SIZE(LSM##_attr_dir_stuff)); \
+} \
+\
+static const struct file_operations proc_##LSM##_attr_dir_ops = { \
+	.read		= generic_read_dir, \
+	.iterate	= proc_##LSM##_attr_dir_iterate, \
+	.llseek		= default_llseek, \
+}; \
+\
+static struct dentry *proc_##LSM##_attr_dir_lookup(struct inode *dir, \
+				struct dentry *dentry, unsigned int flags) \
+{ \
+	return proc_pident_lookup(dir, dentry, \
+				  LSM##_attr_dir_stuff, \
+				  ARRAY_SIZE(LSM##_attr_dir_stuff)); \
+} \
+\
+static const struct inode_operations proc_##LSM##_attr_dir_inode_ops = { \
+	.lookup		= proc_##LSM##_attr_dir_lookup, \
+	.getattr	= pid_getattr, \
+	.setattr	= proc_setattr, \
+}
+
+#ifdef CONFIG_SECURITY_SMACK
+static const struct pid_entry smack_attr_dir_stuff[] = {
+	ATTR("smack", "current",	0666),
+};
+LSM_DIR_OPS(smack);
+#endif
+
 static const struct pid_entry attr_dir_stuff[] = {
-	REG("current",    S_IRUGO|S_IWUGO, proc_pid_attr_operations),
-	REG("prev",       S_IRUGO,	   proc_pid_attr_operations),
-	REG("exec",       S_IRUGO|S_IWUGO, proc_pid_attr_operations),
-	REG("fscreate",   S_IRUGO|S_IWUGO, proc_pid_attr_operations),
-	REG("keycreate",  S_IRUGO|S_IWUGO, proc_pid_attr_operations),
-	REG("sockcreate", S_IRUGO|S_IWUGO, proc_pid_attr_operations),
+	ATTR(NULL, "current",		0666),
+	ATTR(NULL, "prev",		0444),
+	ATTR(NULL, "exec",		0666),
+	ATTR(NULL, "fscreate",		0666),
+	ATTR(NULL, "keycreate",		0666),
+	ATTR(NULL, "sockcreate",	0666),
+#ifdef CONFIG_SECURITY_SMACK
+	DIR("smack",			0555,
+	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
+#endif
 };
 
 static int proc_attr_dir_readdir(struct file *file, struct dir_context *ctx)
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 5185d7f6a51e..d4f9989063d0 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -81,6 +81,7 @@ union proc_op {
 	int (*proc_show)(struct seq_file *m,
 		struct pid_namespace *ns, struct pid *pid,
 		struct task_struct *task);
+	const char *lsm;
 };
 
 struct proc_inode {
diff --git a/include/linux/security.h b/include/linux/security.h
index d170a5b031f3..35691877c3e1 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -390,8 +390,10 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
 int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
 			unsigned nsops, int alter);
 void security_d_instantiate(struct dentry *dentry, struct inode *inode);
-int security_getprocattr(struct task_struct *p, char *name, char **value);
-int security_setprocattr(const char *name, void *value, size_t size);
+int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
+			 char **value);
+int security_setprocattr(const char *lsm, const char *name, void *value,
+			 size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
@@ -1139,15 +1141,18 @@ static inline int security_sem_semop(struct kern_ipc_perm *sma,
 	return 0;
 }
 
-static inline void security_d_instantiate(struct dentry *dentry, struct inode *inode)
+static inline void security_d_instantiate(struct dentry *dentry,
+					  struct inode *inode)
 { }
 
-static inline int security_getprocattr(struct task_struct *p, char *name, char **value)
+static inline int security_getprocattr(struct task_struct *p, const char *lsm,
+				       char *name, char **value)
 {
 	return -EINVAL;
 }
 
-static inline int security_setprocattr(char *name, void *value, size_t size)
+static inline int security_setprocattr(const char *lsm, char *name,
+				       void *value, size_t size)
 {
 	return -EINVAL;
 }
diff --git a/security/security.c b/security/security.c
index eab64bdc60fb..81ff6a71e78e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1472,14 +1472,30 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
-int security_getprocattr(struct task_struct *p, char *name, char **value)
+int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
+				char **value)
 {
-	return call_int_hook(getprocattr, -EINVAL, p, name, value);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
+		if (lsm != NULL && strcmp(lsm, hp->lsm))
+			continue;
+		return hp->hook.getprocattr(p, name, value);
+	}
+	return -EINVAL;
 }
 
-int security_setprocattr(const char *name, void *value, size_t size)
+int security_setprocattr(const char *lsm, const char *name, void *value,
+			 size_t size)
 {
-	return call_int_hook(setprocattr, -EINVAL, name, value, size);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
+		if (lsm != NULL && strcmp(lsm, hp->lsm))
+			continue;
+		return hp->hook.setprocattr(name, value, size);
+	}
+	return -EINVAL;
 }
 
 int security_netlink_send(struct sock *sk, struct sk_buff *skb)
-- 
2.14.5


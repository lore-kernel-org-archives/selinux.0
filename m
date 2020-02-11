Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8243AC3B187
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 22:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503922073C
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 22:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gxgroxdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgBKW4S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:56:18 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:34371 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgBKW4R (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 17:56:17 -0500
Received: by mail-pl1-f202.google.com with SMTP id j8so26060plk.1
        for <selinux@vger.kernel.org>; Tue, 11 Feb 2020 14:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=vHcKO3QArnYrq5IS1lBB+LSw7l3zk+6PTDFMKlLqjVY=;
        b=gxgroxdpy5apY+CiXlDvZ3ykbKxa6+DwISy7zYL64iaChm9WJXkU2eLLN7um5g8isj
         BOhtMjfkisilUoD1Djqg2bvSgeeDHdBVCYxg2Ut2KaCKn2bl6700QGsUZD+HoyobtI+E
         WiwDPOQmNQpSTpbyT6EdUAc4+QZV3rZA5o/dXf4j8wiHg3U3a3pxbBgMQ/16RGiBTBTX
         ajTB2PSHjdqaBEHWdmpxBJKkTVtdeF+C8Tvar0wr/jL0Ka+18+lZ9tN2a3pflblIv5vq
         vVR55P8bXSH7XwmnU+/GxqhJ/TP+Ku/aEAUmTpRXwSmZwzNylmwgsWmfUyDmDQEZkrFf
         wfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=vHcKO3QArnYrq5IS1lBB+LSw7l3zk+6PTDFMKlLqjVY=;
        b=oNpFUyUGvnBYAjwGdFUlvF58utYRkPSz+5eRIT5WuBLrzZfYqaxGJOob/I7qfFwOt+
         YMSHN3zZKSRcGLb6/s5Bc0ECae5JzzC2fnuun9VDLH95BqFjIoH/On7wcMqc7g6jO5o0
         iWBs/kHBVor90AN42OZmFBwR+ZejGb83sHiuCw5RHW6kiLqm7bIq8SeEFMJMFUQL1hqE
         VyHxIwr0H4wLQJ1h0M9frLottU6JHgMQQJyQLxlYQV/HR8vqMLlFLfX1eXgexG1tJtvK
         6UKD85Fgeedj7ICvfAJ8/+4j01jA19aZCVt0HzBKE8pspic6y7jo9aOYYYtuPiFY3cuW
         oaig==
X-Gm-Message-State: APjAAAXpk9rk/5X5ZhA7J39ihlp9FJpaKPSW6ETGN6bqs68j5DFOYdbI
        7KisT/a5AlJ2LlJRa1zWjCGVLrsb7tw=
X-Google-Smtp-Source: APXvYqzJIL6WHUsPALso0TDvxO22ttnZWGbNBfpf2ul38VP3YBkBW8QGBonli8y5cLEtZ7ZHBcRd9HxSwbo=
X-Received: by 2002:a63:594a:: with SMTP id j10mr9436698pgm.227.1581461776754;
 Tue, 11 Feb 2020 14:56:16 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:55:44 -0800
In-Reply-To: <20200211225547.235083-1-dancol@google.com>
Message-Id: <20200211225547.235083-4-dancol@google.com>
Mime-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v2 3/6] Teach SELinux about a new userfaultfd class
From:   Daniel Colascione <dancol@google.com>
To:     dancol@google.com, timmurray@google.com, nosh@google.com,
        nnk@google.com, lokeshgidra@google.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the secure anonymous inode LSM hook we just added to let SELinux
policy place restrictions on userfaultfd use. The create operation
applies to processes creating new instances of these file objects;
transfer between processes is covered by restrictions on read, write,
and ioctl access already checked inside selinux_file_receive.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 fs/userfaultfd.c                    |  4 +-
 include/linux/userfaultfd_k.h       |  2 +
 security/selinux/hooks.c            | 68 +++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 +
 4 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 37df7c9eedb1..07b0f6e03849 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1014,8 +1014,6 @@ static __poll_t userfaultfd_poll(struct file *file, poll_table *wait)
 	}
 }
 
-static const struct file_operations userfaultfd_fops;
-
 static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
 				  struct userfaultfd_ctx *new,
 				  struct uffd_msg *msg)
@@ -1920,7 +1918,7 @@ static void userfaultfd_show_fdinfo(struct seq_file *m, struct file *f)
 }
 #endif
 
-static const struct file_operations userfaultfd_fops = {
+const struct file_operations userfaultfd_fops = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= userfaultfd_show_fdinfo,
 #endif
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index ac9d71e24b81..549c8b0cca52 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -30,6 +30,8 @@
 
 extern int sysctl_unprivileged_userfaultfd;
 
+extern const struct file_operations userfaultfd_fops;
+
 extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
 
 extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1659b59fb5d7..e178f6f40e93 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -92,6 +92,10 @@
 #include <linux/fsnotify.h>
 #include <linux/fanotify.h>
 
+#ifdef CONFIG_USERFAULTFD
+#include <linux/userfaultfd_k.h>
+#endif
+
 #include "avc.h"
 #include "objsec.h"
 #include "netif.h"
@@ -2915,6 +2919,69 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	return 0;
 }
 
+static int selinux_inode_init_security_anon(struct inode *inode,
+					    const char *name,
+					    const struct file_operations *fops)
+{
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	struct common_audit_data ad;
+	struct inode_security_struct *isec;
+
+	if (unlikely(IS_PRIVATE(inode)))
+		return 0;
+
+	/*
+	 * We shouldn't be creating secure anonymous inodes before LSM
+	 * initialization completes.
+	 */
+	if (unlikely(!selinux_state.initialized))
+		return -EBUSY;
+
+	isec = selinux_inode(inode);
+
+	/*
+	 * We only get here once per ephemeral inode.  The inode has
+	 * been initialized via inode_alloc_security but is otherwise
+	 * untouched, so check that the state is as
+	 * inode_alloc_security left it.
+	 */
+	BUG_ON(isec->initialized != LABEL_INVALID);
+	BUG_ON(isec->sclass != SECCLASS_FILE);
+
+#ifdef CONFIG_USERFAULTFD
+	if (fops == &userfaultfd_fops)
+		isec->sclass = SECCLASS_UFFD;
+#endif
+
+	if (isec->sclass == SECCLASS_FILE) {
+		printk(KERN_WARNING "refusing to create secure anonymous inode "
+		       "of unknown type");
+		return -EOPNOTSUPP;
+	}
+	/*
+	 * Always give secure anonymous inodes the sid of the
+	 * creating task.
+	 */
+
+	isec->sid = tsec->sid;
+	isec->initialized = LABEL_INITIALIZED;
+
+	/*
+	 * Now that we've initialized security, check whether we're
+	 * allowed to actually create this type of anonymous inode.
+	 */
+
+	ad.type = LSM_AUDIT_DATA_INODE;
+	ad.u.inode = inode;
+
+	return avc_has_perm(&selinux_state,
+			    tsec->sid,
+			    isec->sid,
+			    isec->sclass,
+			    FILE__CREATE,
+			    &ad);
+}
+
 static int selinux_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	return may_create(dir, dentry, SECCLASS_FILE);
@@ -6923,6 +6990,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(inode_free_security, selinux_inode_free_security),
 	LSM_HOOK_INIT(inode_init_security, selinux_inode_init_security),
+	LSM_HOOK_INIT(inode_init_security_anon, selinux_inode_init_security_anon),
 	LSM_HOOK_INIT(inode_create, selinux_inode_create),
 	LSM_HOOK_INIT(inode_link, selinux_inode_link),
 	LSM_HOOK_INIT(inode_unlink, selinux_inode_unlink),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 986f3ac14282..6d4f9ebf2017 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -248,6 +248,8 @@ struct security_class_mapping secclass_map[] = {
 	  {"open", "cpu", "kernel", "tracepoint", "read", "write"} },
 	{ "lockdown",
 	  { "integrity", "confidentiality", NULL } },
+	{ "uffd",
+	  { COMMON_FILE_PERMS, NULL } },
 	{ NULL }
   };
 
-- 
2.25.0.225.g125e21ebc7-goog


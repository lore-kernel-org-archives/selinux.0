Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AA4C54EBD
	for <selinux@archiver.kernel.org>; Mon,  9 Jan 2023 21:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbjAIVkG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Jan 2023 16:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238145AbjAIVjq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Jan 2023 16:39:46 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF3C60DD
        for <selinux@vger.kernel.org>; Mon,  9 Jan 2023 13:38:37 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i10-20020a25f20a000000b006ea4f43c0ddso10512757ybe.21
        for <selinux@vger.kernel.org>; Mon, 09 Jan 2023 13:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SQeNgY+J6MKzCRrIntmsIbLAzrhXUK7Ksf6ShqqTDqg=;
        b=JBDEWasB+3OrvV/Y27HbN2Neb2kEXiiVXQ+wxK++73bxItz+h84CoAdQzRT6NPJANE
         CLVxy9fExG/dYCBL9Kj+T7e6Fb6ul1yD6ZQb8A+AL4pzEaI7DoHPA9JZGXcUqFYa49aP
         iAkXaV01QrmTY+TL3EB8WOUxQiuibhGQDvpIh6fIzVNuB+Qk+ocz4E7Y33kxzw4PYa6g
         NN/E4LuCqSW7+xRTARJMsEa7Pt/FZojDU3MFoN6807jAGeTOdKlMYAXKehPKnbE4ZgBV
         im2AF/krq07AeNXvCPN706WdUF61A4jBsp9p0BqVwBod4BUCHSRlawT3zlavAiChILB8
         KYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQeNgY+J6MKzCRrIntmsIbLAzrhXUK7Ksf6ShqqTDqg=;
        b=krEDrPZFIQOINyU5FRHF6Zg+a5/AtpfQ3xiM7lfC5FHGf8okgyKfci6jkzue4KrMdS
         fyVMApe+279vyEwpx9lyr0YNonrcHtM0BYyOprZWOKnCva1KoqSphnBEmO9XJuvX6krF
         ZB44uSBpff8GuYZIvf5mW6RFCOMAxkEI1vNvGD/OV6HeWlq+hlYtcni2vZ6mAfuvPPFo
         ZL1q1fYMpMwitNV+DyTC3RzBCrITvjU14h+QFDyzU9/W8jNeYRH8TXhDhnC1YXIkmLOr
         evcG/L4Syg8XRZOGXH3oqmHoyMUCMHrRAOKI6wEuicu0/d4oMiO0aZwuu7D1n62iAv/f
         snkQ==
X-Gm-Message-State: AFqh2kp3IllR9QAqWD1ALOACcMPl/v84iyD1YyoNRZ4uxpTZre3X9qel
        Q7tMXD+5DlPi6JGP2Ap9llnzlVTshzxYct4=
X-Google-Smtp-Source: AMrXdXsly8ftnTGxkXWURs6cgQlim0110CyvAjtUB2YdXI6XZT+4/hpYTJ6JlWae8xNU5rTd/sJIbiwGsASFKCY=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a0d:eb07:0:b0:475:794e:90e3 with SMTP id
 u7-20020a0deb07000000b00475794e90e3mr515886ywe.483.1673300316284; Mon, 09 Jan
 2023 13:38:36 -0800 (PST)
Date:   Mon,  9 Jan 2023 21:38:07 +0000
In-Reply-To: <20230109213809.418135-1-tjmercier@google.com>
Mime-Version: 1.0
References: <20230109213809.418135-1-tjmercier@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109213809.418135-5-tjmercier@google.com>
Subject: [PATCH 4/4] security: binder: Add transfer_charge SElinux hook
From:   "T.J. Mercier" <tjmercier@google.com>
To:     tjmercier@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Cc:     hannes@cmpxchg.org, daniel.vetter@ffwll.ch, android-mm@google.com,
        jstultz@google.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Any process can cause a memory charge transfer to occur to any other
process when transmitting a file descriptor through binder. This should
only be possible for central allocator processes, so a new SELinux
permission is added to restrict which processes are allowed to initiate
these charge transfers.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 drivers/android/binder.c            | 5 +++++
 include/linux/lsm_hook_defs.h       | 2 ++
 include/linux/lsm_hooks.h           | 6 ++++++
 include/linux/security.h            | 2 ++
 security/security.c                 | 6 ++++++
 security/selinux/hooks.c            | 9 +++++++++
 security/selinux/include/classmap.h | 2 +-
 7 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 9830848c8d25..9063db04826d 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2279,6 +2279,11 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset, __u32 flags,
 	if (IS_ENABLED(CONFIG_MEMCG) && (flags & BINDER_FD_FLAG_XFER_CHARGE)) {
 		struct dma_buf *dmabuf;
 
+		if (security_binder_transfer_charge(proc->cred, target_proc->cred)) {
+			ret = -EPERM;
+			goto err_security;
+		}
+
 		if (unlikely(!is_dma_buf_file(file))) {
 			binder_user_error(
 				"%d:%d got transaction with XFER_CHARGE for non-dmabuf fd, %d\n",
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ed6cb2ac55fa..8db2a958557e 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -33,6 +33,8 @@ LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
 	 const struct cred *to)
 LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
 	 const struct cred *to, struct file *file)
+LSM_HOOK(int, 0, binder_transfer_charge, const struct cred *from,
+	 const struct cred *to)
 LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
 	 unsigned int mode)
 LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 0a5ba81f7367..39c40c7bf519 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1385,6 +1385,12 @@
  *	@file contains the struct file being transferred.
  *	@to contains the struct cred for the receiving process.
  *	Return 0 if permission is granted.
+ * @binder_transfer_charge:
+ *	Check whether @from is allowed to transfer the memory charge for a
+ *	buffer out of its cgroup to @to.
+ *	@from contains the struct cred for the sending process.
+ *	@to contains the struct cred for the receiving process.
+ *	Return 0 if permission is granted.
  *
  * @ptrace_access_check:
  *	Check permission before allowing the current process to trace the
diff --git a/include/linux/security.h b/include/linux/security.h
index 5b67f208f7de..3b7472308430 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -270,6 +270,8 @@ int security_binder_transfer_binder(const struct cred *from,
 				    const struct cred *to);
 int security_binder_transfer_file(const struct cred *from,
 				  const struct cred *to, struct file *file);
+int security_binder_transfer_charge(const struct cred *from,
+				    const struct cred *to);
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
 int security_ptrace_traceme(struct task_struct *parent);
 int security_capget(struct task_struct *target,
diff --git a/security/security.c b/security/security.c
index d1571900a8c7..97e1e74d1ff2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -801,6 +801,12 @@ int security_binder_transfer_file(const struct cred *from,
 	return call_int_hook(binder_transfer_file, 0, from, to, file);
 }
 
+int security_binder_transfer_charge(const struct cred *from,
+				    const struct cred *to)
+{
+	return call_int_hook(binder_transfer_charge, 0, from, to);
+}
+
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode)
 {
 	return call_int_hook(ptrace_access_check, 0, child, mode);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3c5be76a9199..823ef14924bd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2066,6 +2066,14 @@ static int selinux_binder_transfer_file(const struct cred *from,
 			    &ad);
 }
 
+static int selinux_binder_transfer_charge(const struct cred *from, const struct cred *to)
+{
+	return avc_has_perm(&selinux_state,
+			    cred_sid(from), cred_sid(to),
+			    SECCLASS_BINDER, BINDER__TRANSFER_CHARGE,
+			    NULL);
+}
+
 static int selinux_ptrace_access_check(struct task_struct *child,
 				       unsigned int mode)
 {
@@ -7052,6 +7060,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
 	LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
 	LSM_HOOK_INIT(binder_transfer_file, selinux_binder_transfer_file),
+	LSM_HOOK_INIT(binder_transfer_charge, selinux_binder_transfer_charge),
 
 	LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index a3c380775d41..2eef180d10d7 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -172,7 +172,7 @@ const struct security_class_mapping secclass_map[] = {
 	{ "tun_socket",
 	  { COMMON_SOCK_PERMS, "attach_queue", NULL } },
 	{ "binder", { "impersonate", "call", "set_context_mgr", "transfer",
-		      NULL } },
+		      "transfer_charge", NULL } },
 	{ "cap_userns",
 	  { COMMON_CAP_PERMS, NULL } },
 	{ "cap2_userns",
-- 
2.39.0.314.g84b9a713c41-goog


Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2A3C433EF
	for <selinux@archiver.kernel.org>; Thu, 24 Feb 2022 18:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiBXSUn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Feb 2022 13:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbiBXSUl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Feb 2022 13:20:41 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DCA2556C3
        for <selinux@vger.kernel.org>; Thu, 24 Feb 2022 10:20:10 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d7eaa730d9so6077697b3.13
        for <selinux@vger.kernel.org>; Thu, 24 Feb 2022 10:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Kr3msHxcEEuMu9ueVhf1C+yPycv5P/dhrWgKPHzNZeU=;
        b=fPfQHUeXB8dFNhcE0pSs43bdxCMaS/5S9/DzhMcZXeydaAkCzPRYjyJPHchp7jv7Fl
         YcI6FCU2KPWMX0IIyPh1fLisosge1/9iqrTFR4l3gwQI7GOxBAm65qyTsWZdNkjOK/NE
         k4jN0vbm5oQiFlMVAdO2u8bXj4BrV70nE30yhUXw+c2oICHiL9Bcbrbx9AJSeWZ1qVOx
         O0RxVsAvhoJ96n6AihRhyP/iKtz9DskulRg3Xx3PELkjLDNWIoeUowiVk8EiM0w4TMMA
         qq+Tzg42a1SC40LYdWFOJm2uDwMGriG9HWn5UcdO7D//xszsaVryahaBE1Q/mOIF7Jnw
         cvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Kr3msHxcEEuMu9ueVhf1C+yPycv5P/dhrWgKPHzNZeU=;
        b=FGH5IY/x6k/1lwZi7fgUzEIUPa+l/k1j0s4GL18xTJsslubuZaK25vFZ3vuZz0ZvTs
         jbSo1uqpL2lOQRpTf51EdWcI8sDEIAJO8XK4+DyUJafbT8kUWd6HtT+4NtgZAwR9o/gf
         ETJhL4zn9q4H6YtB0XD7y4s9x2AVEclIvN5NOYB0k+pIaxuwkFjGez6Sfxhz+0RkAGHP
         KfO9+SgF00NpdCjLDvHkP4lBC2L/lfQFDlAXFs2af10BfD3dsja971X8J5gwdYW0ex+c
         AOLRiASp3gyRquZsKENk6va0+8bGDzEGS9ILLaGRxmfbdn1zFEI3SDhfMmiVyAjxWkKg
         cJQA==
X-Gm-Message-State: AOAM533mAwGIoL1nbcEeZ13nC4b2qibxduWVOYyBMbuRXGe9AKbatXQw
        vIdrOBMnMoHzLpkhbi20CJNZnyierx1m344excFq
X-Google-Smtp-Source: ABdhPJykrFAu6LDou6qQ+GvUENavEY0K5NwYoXaucR3RWYojp3M1TWx2uHE2Wm2gvvSBpVRlJMazTjkK9Vnl7gjXfQT4
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:5d35:89ab:52c:6dea])
 (user=axelrasmussen job=sendgmr) by 2002:a25:8887:0:b0:622:77:ecad with SMTP
 id d7-20020a258887000000b006220077ecadmr3666746ybl.30.1645726809505; Thu, 24
 Feb 2022 10:20:09 -0800 (PST)
Date:   Thu, 24 Feb 2022 10:19:53 -0800
Message-Id: <20220224181953.1030665-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH] userfaultfd, capability: introduce CAP_USERFAULTFD
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Historically, it has been shown that intercepting kernel faults with
userfaultfd (thereby forcing the kernel to wait for an arbitrary amount
of time) can be exploited, or at least can make some kinds of exploits
easier. So, in 37cd0575b8 "userfaultfd: add UFFD_USER_MODE_ONLY" we
changed things so, in order for kernel faults to be handled by
userfaultfd, either the process needs CAP_SYS_PTRACE, or this sysctl
must be configured so that any unprivileged user can do it.

In a typical implementation of a hypervisor with live migration (take
QEMU/KVM as one such example), we do indeed need to be able to handle
kernel faults. But, both options above are less than ideal:

- Toggling the sysctl increases attack surface by allowing any
  unprivileged user to do it.

- Granting the live migration process CAP_SYS_PTRACE gives it this
  ability, but *also* the ability to "observe and control the
  execution of another process [...], and examine and change [its]
  memory and registers" (from ptrace(2)). This isn't something we need
  or want to be able to do, so granting this permission violates the
  "principle of least privilege".

This is all a long winded way to say: we want a more fine-grained way to
grant access to userfaultfd, without granting other additional
permissions at the same time.

So, add CAP_USERFAULTFD, for this specific case.

Setup a helper which accepts either CAP_USERFAULTFD, or for backward
compatibility reasons (existing userspaces may depend on the old way of
doing things), CAP_SYS_PTRACE.

One special case is UFFD_FEATURE_EVENT_FORK: this is left requiring only
CAP_SYS_PTRACE, since it is specifically about manipulating the memory
of another (child) process, it sems like a better fit the way it is. To
my knowledge, this isn't a feature required by typical live migration
implementations, so this doesn't obviate the above.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c                    | 6 +++---
 include/linux/capability.h          | 5 +++++
 include/uapi/linux/capability.h     | 7 ++++++-
 security/selinux/include/classmap.h | 4 ++--
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e26b10132d47..1ec0d9b49a70 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -411,7 +411,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	    ctx->flags & UFFD_USER_MODE_ONLY) {
 		printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
 			"sysctl knob to 1 if kernel faults must be handled "
-			"without obtaining CAP_SYS_PTRACE capability\n");
+			"without obtaining CAP_USERFAULTFD capability\n");
 		goto out;
 	}
 
@@ -2068,10 +2068,10 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 
 	if (!sysctl_unprivileged_userfaultfd &&
 	    (flags & UFFD_USER_MODE_ONLY) == 0 &&
-	    !capable(CAP_SYS_PTRACE)) {
+	    !userfaultfd_capable()) {
 		printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
 			"sysctl knob to 1 if kernel faults must be handled "
-			"without obtaining CAP_SYS_PTRACE capability\n");
+			"without obtaining CAP_USERFAULTFD capability\n");
 		return -EPERM;
 	}
 
diff --git a/include/linux/capability.h b/include/linux/capability.h
index 65efb74c3585..f1e7b3506432 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -270,6 +270,11 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 		ns_capable(ns, CAP_SYS_ADMIN);
 }
 
+static inline bool userfaultfd_capable(void)
+{
+	return capable(CAP_USERFAULTFD) || capable(CAP_SYS_PTRACE);
+}
+
 /* audit system wants to get cap info from files as well */
 int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
 			   const struct dentry *dentry,
diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 463d1ba2232a..83a5d8601508 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -231,6 +231,7 @@ struct vfs_ns_cap_data {
 #define CAP_SYS_CHROOT       18
 
 /* Allow ptrace() of any process */
+/* Allow everything under CAP_USERFAULTFD for backward compatibility */
 
 #define CAP_SYS_PTRACE       19
 
@@ -417,7 +418,11 @@ struct vfs_ns_cap_data {
 
 #define CAP_CHECKPOINT_RESTORE	40
 
-#define CAP_LAST_CAP         CAP_CHECKPOINT_RESTORE
+/* Allow intercepting kernel faults with userfaultfd */
+
+#define CAP_USERFAULTFD		41
+
+#define CAP_LAST_CAP         CAP_USERFAULTFD
 
 #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
 
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 35aac62a662e..98e37b220159 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -28,9 +28,9 @@
 
 #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
 		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf", \
-		"checkpoint_restore"
+		"checkpoint_restore", "userfaultfd"
 
-#if CAP_LAST_CAP > CAP_CHECKPOINT_RESTORE
+#if CAP_LAST_CAP > CAP_USERFAULTFD
 #error New capability defined, please update COMMON_CAP2_PERMS.
 #endif
 
-- 
2.35.1.574.g5d30c73bfb-goog


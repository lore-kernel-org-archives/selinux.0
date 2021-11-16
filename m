Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5499C433EF
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 11:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B304A61994
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 11:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhKPLab (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Nov 2021 06:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbhKPL3o (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Nov 2021 06:29:44 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDABAC06120C
        for <selinux@vger.kernel.org>; Tue, 16 Nov 2021 03:26:19 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso1616588wmh.0
        for <selinux@vger.kernel.org>; Tue, 16 Nov 2021 03:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N27l+XMKWdszX2BfYpogoJ8jy9cvir6UuzZ5HEPoQTU=;
        b=n1Jk6sXyjYZg3s5Vm4uEohM/H+qyzxMzykmWMtErm3eduwh5TEx/dpVTZihZ60T6fj
         oH0lU1mE3t6o9DHLR4nuxqLUothwHaKqIQ8SQGdPKGDmSR9yY8QjYvXjSwfOM3xjZSom
         xktbtuIypiVwdG3PvRZgV//X06txis4QljbYBpoaHsP2Y5j9vXT0xcCy8i/BD9raTB1x
         PqTHQSfvEH9/RFLs7nq6bOfCr7tNpA225AyFph7CTpGuICcvuVYLtHVK6A0Cu3y/rDq+
         03kMCjxnZc9Pxf7obM8Laz+++FQDtbfPqIh7xgOw0letT7oh/9zMXqVp/2xnC1tC9lf6
         dgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N27l+XMKWdszX2BfYpogoJ8jy9cvir6UuzZ5HEPoQTU=;
        b=4mLr2iV0h701BzQfptOpqxnNt7SoP2sxYU+icKFtV4N2aNLGZSaJnpnFkO9/0PMxIw
         t/1B5NEfkfwsjV1o+hAcLPUKuNBoPupL1njdWri/kC9k7Q1IukrxPcH7wDNiSDKlz4bg
         TDrF14dwhvqPxL5cbEZUoM51sjWFLaLeXDwFfS8tIclkVIw38JyZWu9xoQ9vg0URiP+m
         z52OMPYq+4ZMMZ/5fB1y63hyg3TtUtq1Tp8syzHv0TtjSPECqn8HWNTNt1yE3qh93GwL
         fzxd3OW9kyd8ztgX7d/TKtzb+jQIrxAuxvQDAwAVhjhUPbtn58iVg/okxlacuVVGvywS
         la4Q==
X-Gm-Message-State: AOAM532Drn1Ui+F8McUb4fNd0rpCuCiyIaZ4UXQRocVIQ5duxZNKj5Mg
        YsMIZnL/btsYiC1mabbLkvEB2HsH5AE=
X-Google-Smtp-Source: ABdhPJx7KpFBxmaWRyocQDcqYiyuFgsGFFRPqTQJ4vAP6jCE5QePx6efBei9GV9kVMego+Q+1Ym9zA==
X-Received: by 2002:a1c:1d42:: with SMTP id d63mr67438105wmd.184.1637061978324;
        Tue, 16 Nov 2021 03:26:18 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-006-183-176.77.6.pool.telefonica.de. [77.6.183.176])
        by smtp.gmail.com with ESMTPSA id h7sm16635069wrt.64.2021.11.16.03.26.17
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:26:17 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH] capability: add capable_or to test for multiple caps with exactly one audit message
Date:   Tue, 16 Nov 2021 12:24:37 +0100
Message-Id: <20211116112437.43412-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

WARNING: only compile tested and just to test the water

Add the interface `capable_or()` as an alternative to or multiple
`capable()` calls, like `capable_or(CAP_SYS_NICE, CAP_SYS_ADMIN)`
instead of `capable(CAP_SYS_NICE) || capable(CAP_SYS_ADMIN)`.
`capable_or()` will in particular generate exactly one audit message,
either for the left most capability in effect or, if the task has none,
the first one.
This is especially helpful with regard to SELinux, where each audit
message about a not allowed capability will create an avc denial.
Using this function with the least invasive capability as left most
argument (e.g. CAP_SYS_NICE before CAP_SYS_ADMIN) enables policy writers
to only allow the least invasive one and SELinux domains pass this check
with only capability:sys_nice or capability:sys_admin allowed without
any avc denial message.

Fixes: 94c4b4fd25e6 ("block: Check ADMIN before NICE for IOPRIO_CLASS_RT")
---
 block/ioprio.c             |  2 +-
 include/linux/capability.h |  6 +++++
 kernel/capability.c        | 46 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 0e4ff245f2bf..d00466d46da3 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -69,7 +69,7 @@ int ioprio_check_cap(int ioprio)
 
 	switch (class) {
 		case IOPRIO_CLASS_RT:
-			if (!capable(CAP_SYS_NICE) && !capable(CAP_SYS_ADMIN))
+			if (!capable_or(CAP_SYS_NICE, CAP_SYS_ADMIN))
 				return -EPERM;
 			fallthrough;
 			/* rt has prio field too */
diff --git a/include/linux/capability.h b/include/linux/capability.h
index 65efb74c3585..b9943b44cdc8 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -207,6 +207,8 @@ extern bool has_ns_capability(struct task_struct *t,
 extern bool has_capability_noaudit(struct task_struct *t, int cap);
 extern bool has_ns_capability_noaudit(struct task_struct *t,
 				      struct user_namespace *ns, int cap);
+#define capable_or(...) _capable_or((sizeof((int[]){__VA_ARGS__}) / sizeof(int)), __VA_ARGS__)
+extern bool _capable_or(int count, ...);
 extern bool capable(int cap);
 extern bool ns_capable(struct user_namespace *ns, int cap);
 extern bool ns_capable_noaudit(struct user_namespace *ns, int cap);
@@ -230,6 +232,10 @@ static inline bool has_ns_capability_noaudit(struct task_struct *t,
 {
 	return true;
 }
+static inline bool capable_or(int first_cap, ...)
+{
+	return true;
+}
 static inline bool capable(int cap)
 {
 	return true;
diff --git a/kernel/capability.c b/kernel/capability.c
index 46a361dde042..0ee03ae4c1b2 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -434,6 +434,52 @@ bool ns_capable_setid(struct user_namespace *ns, int cap)
 }
 EXPORT_SYMBOL(ns_capable_setid);
 
+/**
+ * _capable_or - Determine if the current task has one of multiple superior capabilities in effect
+ * @cap: The capabilities to be tested for
+ *
+ * Return true if the current task has at least one of the given superior capabilities currently
+ * available for use, false if not.
+ *
+ * In contrast to or'ing capable() this call will create exactly one audit message, either for the
+ * left most capability in effect or (if the task has none of the tested capabilities) the first
+ * capabilit in the test list.
+ *
+ * This sets PF_SUPERPRIV on the task if the capability is available on the
+ * assumption that it's about to be used.
+ */
+bool _capable_or(int count, ...)
+{
+	va_list args;
+	int cap, first_cap, i;
+
+	BUG_ON(count < 1);
+	BUG_ON(count > CAP_LAST_CAP);
+
+	va_start(args, count);
+
+	for (i = 0; i < count; i++) {
+		int ret;
+
+		cap = va_arg(args, int);
+		if (i == 0)
+			first_cap = cap;
+
+		rcu_read_lock();
+		ret = security_capable(current_cred(), &init_user_ns, cap, CAP_OPT_NOAUDIT);
+		rcu_read_unlock();
+
+		if (ret == 0)
+			goto out;
+	}
+
+	cap = first_cap;
+
+out:
+	va_end(args);
+	return ns_capable(&init_user_ns, cap);
+}
+
 /**
  * capable - Determine if the current task has a superior capability in effect
  * @cap: The capability to be tested for
-- 
2.33.1


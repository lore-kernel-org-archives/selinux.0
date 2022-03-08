Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ED5C433F5
	for <selinux@archiver.kernel.org>; Tue,  8 Mar 2022 22:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350669AbiCHWNH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350630AbiCHWM5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Mar 2022 17:12:57 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8548047AEA
        for <selinux@vger.kernel.org>; Tue,  8 Mar 2022 14:12:00 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id gm1so580824qvb.7
        for <selinux@vger.kernel.org>; Tue, 08 Mar 2022 14:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=72xk7Jlho0pYjqgQheRrTK8I77jAVz6E4v8YsyW0uCE=;
        b=abkyG5Yk1sctXcPXKaVKoa1ZFZJP73ncjChNiz/eMsSNY9t6yzTUDSETCjKt/hYZ73
         /V6MwYq9uPDpu9IMoE9D8BOaIpYiObyyOlKYYZOC1PY9YkI9lQ5lSJTIgXo5LTl2EkG2
         I1TL07sSoQ4A5a4Q/85PXcsUx+w4QHr/ZZUEV5+OSCsYQAn0xmnaUbyEilWvKBlcVOwb
         APwITWJ+qgtD070mCiwzD7C1rtEH80lCbqWoofp11WugYzkFIKr0wVtBP6dsapTMfEe+
         2f01xIGIyhKAzgrXOOoKrKA3N28Kx7QxjgXH5QzocfI5wzIPbOvl9r+nMEW0iyVPkGMw
         L7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=72xk7Jlho0pYjqgQheRrTK8I77jAVz6E4v8YsyW0uCE=;
        b=2dkP2kxXK0GrvpDVl73y3suIIMFDJEFdgDjSIJ3Trrqa++hcHldOANtvFAp9oX9rgl
         1le6UJFozaabY0xFXj5+IlKTrtdbxOMmjPro5J3xLLizzTHx7rQ54XuZxLC+HpGBEHE6
         4lClKJ7T4D45oltd+vJmn5wOFewsxafRZGzzDUlQdeeiX6zZ0KyRx++DpSDaVP1KSmwN
         /p7GhF92/7G1wVnDhyI9kzBvLSMM3z1iIMuX4hKbe7l47eq2BiYyXaTuAPbnEhm3XwQx
         43yalMe1ZUEuVHOF4EltS2ezsTnrhV1L0kzeewm2809FeWNjMye4hV8aNzXVKF4W57tU
         I14g==
X-Gm-Message-State: AOAM533ErDoBH0+CNONuAXcj7z/XnetAt7iGZa+49nf2fScEyvrkC1pA
        gAjIj5Cii1F9ClEbUmAUut1XHh9tOA98
X-Google-Smtp-Source: ABdhPJwSZM55qlAU7Kfcy2aiAYFu1RZOEIZ/Qi67iPOqS8xhh4DT6gFnZput1M4cNQWwNY3NpWz+FQ==
X-Received: by 2002:ad4:5ca2:0:b0:435:bd63:1e2d with SMTP id q2-20020ad45ca2000000b00435bd631e2dmr447661qvh.37.1646777519165;
        Tue, 08 Mar 2022 14:11:59 -0800 (PST)
Received: from localhost (pool-96-237-52-46.bstnma.fios.verizon.net. [96.237.52.46])
        by smtp.gmail.com with ESMTPSA id o18-20020a05622a139200b002de25b59013sm115516qtk.84.2022.03.08.14.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:11:58 -0800 (PST)
Subject: [RFC PATCH] selinux: checkreqprot is deprecated,
 add some ssleep() discomfort
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Tue, 08 Mar 2022 17:11:57 -0500
Message-ID: <164677751730.170741.6493351205403681020.stgit@olly>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The checkreqprot functionality was disabled by default back in
Linux v4.4 (2015) with commit 2a35d196c160e3 ("selinux: change
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE default") and it was
officially marked as deprecated in Linux v5.7.  It was always a
bit of a hack to workaround very old userspace and to the best of
our knowledge, the checkreqprot functionality has been disabled by
Linux distributions for quite some time.

This patch moves the deprecation messages from KERN_WARNING to
KERN_ERR and adds a five second sleep to anyone using it to help
draw their attention to the deprecation and provide a URL which
helps explain things in more detail.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c            |    4 +++-
 security/selinux/include/security.h |    6 ++++++
 security/selinux/selinuxfs.c        |    4 ++--
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b12e14b2797b..cff129f96e97 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -146,7 +146,7 @@ static int __init checkreqprot_setup(char *str)
 	if (!kstrtoul(str, 0, &checkreqprot)) {
 		selinux_checkreqprot_boot = checkreqprot ? 1 : 0;
 		if (checkreqprot)
-			pr_warn("SELinux: checkreqprot set to 1 via kernel parameter.  This is deprecated and will be rejected in a future kernel release.\n");
+			pr_err("SELinux: checkreqprot set to 1 via kernel parameter.  This is deprecated and will be rejected in a future kernel release.\n");
 	}
 	return 1;
 }
@@ -7295,6 +7295,8 @@ static __init int selinux_init(void)
 
 	memset(&selinux_state, 0, sizeof(selinux_state));
 	enforcing_set(&selinux_state, selinux_enforcing_boot);
+	if (CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE)
+		pr_err("SELinux: CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE is non-zero.  This is deprecated and will be rejected in a future kernel release.\n");
 	checkreqprot_set(&selinux_state, selinux_checkreqprot_boot);
 	selinux_avc_init(&selinux_state.avc);
 	mutex_init(&selinux_state.status_lock);
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index ace4bd13e808..f7e6be63adfb 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -16,6 +16,8 @@
 #include <linux/rcupdate.h>
 #include <linux/refcount.h>
 #include <linux/workqueue.h>
+#include <linux/delay.h>
+#include <linux/printk.h>
 #include "flask.h"
 #include "policycap.h"
 
@@ -150,6 +152,10 @@ static inline bool checkreqprot_get(const struct selinux_state *state)
 
 static inline void checkreqprot_set(struct selinux_state *state, bool value)
 {
+	if (value) {
+		pr_err("SELinux: https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-checkreqprot\n");
+		ssleep(5);
+	}
 	WRITE_ONCE(state->checkreqprot, value);
 }
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 6568bc48cd3e..6c8b6a0ddecf 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -757,8 +757,8 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 		char comm[sizeof(current->comm)];
 
 		memcpy(comm, current->comm, sizeof(comm));
-		pr_warn_once("SELinux: %s (%d) set checkreqprot to 1. This is deprecated and will be rejected in a future kernel release.\n",
-			     comm, current->pid);
+		pr_err("SELinux: %s (%d) set checkreqprot to 1. This is deprecated and will be rejected in a future kernel release.\n",
+		       comm, current->pid);
 	}
 
 	checkreqprot_set(fsi->state, (new_value ? 1 : 0));


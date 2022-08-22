Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F7FC3F6B0
	for <selinux@archiver.kernel.org>; Mon, 22 Aug 2022 21:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbiHVVVO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Aug 2022 17:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbiHVVVL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Aug 2022 17:21:11 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C585208E
        for <selinux@vger.kernel.org>; Mon, 22 Aug 2022 14:21:09 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id i7so8912318qka.13
        for <selinux@vger.kernel.org>; Mon, 22 Aug 2022 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc;
        bh=tBvBvoY7Kax3qLh+hCG+8GOl8mJNoIgfMsJnNPYNA+o=;
        b=WxNfdds9Z31JwSLesJVUKuuFnOze2bcmZvqgp6FrbYYzhFiTS+zzBZh9YHAhrqHQNI
         ajQq0VJ/Scjw+6DlFDICkSV0AhNQQUpU6SaUfdCw13SJh+bSKAnGXb+M1ojmSe00mqJ4
         acD25E1LPop7+4/XSNZ7N6PVZvIKyn/8U7P1iyabrpgDcIgCxylxZDm4MvlCcsSYcAC2
         lViqt2c89LeNLAbeXKcDbmunxyWg6WguaM8rEcur1zWRoYv70IqOx3x36Z4EGeh8YF+t
         URmci5DMWxHqMWzGmLKuInKjrnYvkxX/SsGzysMz0UxBlg97yUH6J4S7038t2y1YbRUA
         JYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc;
        bh=tBvBvoY7Kax3qLh+hCG+8GOl8mJNoIgfMsJnNPYNA+o=;
        b=GMrUwpADqG5R17CGFd17VO0XfQ7/MQHbAV7l/pMgCxBe8kxt1ehrccy45YcI3IYu3C
         /jCoAGMa5wSR8V+X9xd1dEieOkYMUbgg47VMktRepXg7YQmTtVjFezaSPfzXbVZD14S5
         iPAqAXbHwSJWOXvloBPwDHa1bu/FhntGZkv3t6xa88kAk+TpSiTcq9lAMryY7nbZBRl6
         RTIk/g29QYNaRKEXZNX97NUhj0cri5olOxi8sXjX61BB3Qawod5thcLOW4jbcVzofjMT
         BFUzdJNdjGmhgl1ZPx0Pp0Q4i6uRuEMfD1ANfoKReeEdCVfnM9NO62+7XaIzt/BpzqFB
         7m2A==
X-Gm-Message-State: ACgBeo0sla7Q4ymf3EPTdYDbCMm+ksJfFB5gE143JyK48Hqivw8e2AcB
        Zc6wpNUknNZRrkDoMUIlvm4O
X-Google-Smtp-Source: AA6agR6LFqis/vbXNQ9SBwbPQPKo79xErEry6IV+AxmlSucjhhdge/XotZYCjJYccJBlidk4Wsyu4Q==
X-Received: by 2002:a05:620a:448f:b0:6b5:fdcc:fe74 with SMTP id x15-20020a05620a448f00b006b5fdccfe74mr13889545qkp.64.1661203268664;
        Mon, 22 Aug 2022 14:21:08 -0700 (PDT)
Received: from localhost (pool-96-237-52-46.bstnma.fios.verizon.net. [96.237.52.46])
        by smtp.gmail.com with ESMTPSA id dt2-20020a05620a478200b006bb024c5021sm11980062qkb.25.2022.08.22.14.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 14:21:08 -0700 (PDT)
Subject: [PATCH 1/3] lsm,io_uring: add LSM hooks for the new uring_cmd file op
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        io-uring@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Date:   Mon, 22 Aug 2022 17:21:07 -0400
Message-ID: <166120326788.369593.18304806499678048620.stgit@olly>
In-Reply-To: <166120321387.369593.7400426327771894334.stgit@olly>
References: <166120321387.369593.7400426327771894334.stgit@olly>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

io-uring cmd support was added through ee692a21e9bf ("fs,io_uring:
add infrastructure for uring-cmd"), this extended the struct
file_operations to allow a new command which each subsystem can use
to enable command passthrough. Add an LSM specific for the command
passthrough which enables LSMs to inspect the command details.

This was discussed long ago without no clear pointer for something
conclusive, so this enables LSMs to at least reject this new file
operation.

[0] https://lkml.kernel.org/r/8adf55db-7bab-f59d-d612-ed906b948d19@schaufler-ca.com

Fixes: ee692a21e9bf ("fs,io_uring: add infrastructure for uring-cmd")
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Acked-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hook_defs.h |    1 +
 include/linux/lsm_hooks.h     |    3 +++
 include/linux/security.h      |    5 +++++
 io_uring/uring_cmd.c          |    5 +++++
 security/security.c           |    4 ++++
 5 files changed, 18 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 806448173033..60fff133c0b1 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -407,4 +407,5 @@ LSM_HOOK(int, 0, perf_event_write, struct perf_event *event)
 #ifdef CONFIG_IO_URING
 LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
 LSM_HOOK(int, 0, uring_sqpoll, void)
+LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
 #endif /* CONFIG_IO_URING */
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 84a0d7e02176..3aa6030302f5 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1582,6 +1582,9 @@
  *      Check whether the current task is allowed to spawn a io_uring polling
  *      thread (IORING_SETUP_SQPOLL).
  *
+ * @uring_cmd:
+ *      Check whether the file_operations uring_cmd is allowed to run.
+ *
  */
 union security_list_options {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
diff --git a/include/linux/security.h b/include/linux/security.h
index 1bc362cb413f..7bd0c490703d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2060,6 +2060,7 @@ static inline int security_perf_event_write(struct perf_event *event)
 #ifdef CONFIG_SECURITY
 extern int security_uring_override_creds(const struct cred *new);
 extern int security_uring_sqpoll(void);
+extern int security_uring_cmd(struct io_uring_cmd *ioucmd);
 #else
 static inline int security_uring_override_creds(const struct cred *new)
 {
@@ -2069,6 +2070,10 @@ static inline int security_uring_sqpoll(void)
 {
 	return 0;
 }
+static inline int security_uring_cmd(struct io_uring_cmd *ioucmd)
+{
+	return 0;
+}
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_IO_URING */
 
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 8e0cc2d9205e..0f7ad956ddcb 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -3,6 +3,7 @@
 #include <linux/errno.h>
 #include <linux/file.h>
 #include <linux/io_uring.h>
+#include <linux/security.h>
 
 #include <uapi/linux/io_uring.h>
 
@@ -88,6 +89,10 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 	if (!req->file->f_op->uring_cmd)
 		return -EOPNOTSUPP;
 
+	ret = security_uring_cmd(ioucmd);
+	if (ret)
+		return ret;
+
 	if (ctx->flags & IORING_SETUP_SQE128)
 		issue_flags |= IO_URING_F_SQE128;
 	if (ctx->flags & IORING_SETUP_CQE32)
diff --git a/security/security.c b/security/security.c
index 14d30fec8a00..4b95de24bc8d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2660,4 +2660,8 @@ int security_uring_sqpoll(void)
 {
 	return call_int_hook(uring_sqpoll, 0);
 }
+int security_uring_cmd(struct io_uring_cmd *ioucmd)
+{
+	return call_int_hook(uring_cmd, 0, ioucmd);
+}
 #endif /* CONFIG_IO_URING */


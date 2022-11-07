Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EA1C43219
	for <selinux@archiver.kernel.org>; Mon,  7 Nov 2022 20:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiKGU6W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbiKGU6T (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Nov 2022 15:58:19 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9884F2C66B
        for <selinux@vger.kernel.org>; Mon,  7 Nov 2022 12:58:18 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-36b1a68bfa6so119382727b3.22
        for <selinux@vger.kernel.org>; Mon, 07 Nov 2022 12:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3foneq/Me5MTssYGRHO4cGLKeUJVeV+052anuIJ7S1g=;
        b=BrFmlNhvbOfCgXUKcVpdmu+NeI+MZF8/aiOApx8jPEdBDiyEV3Svvh1o/TCdDBZaKO
         1igwTKOeqGVj7P7hdEp7nKWYI5ppHUVzVJyTdW5P7ZCModH92BK9BO2rEUSSsXavDkWH
         pQHtiH/zjEzWTB6z+RTIWqzXySFbyTQ2c1p8q/mW/oVKlJcP9iwKOSeI9L2vKx4Cc6gt
         ruMiDy0Jphz1RFajd/fyO2Z98Y5cY1pf7JumDbhSvATPuFGxPJ8aLWBqjsfh41MBWC+Q
         7sQswNHVn80xUfnEpl3eSW7hRFuo3ch0878Z5IgbP82LpVJzJXgImFD51qoR9+ejNUCk
         Vqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3foneq/Me5MTssYGRHO4cGLKeUJVeV+052anuIJ7S1g=;
        b=AzJ4cGPtPJVs/WzYoA1vzwaCqD7AeM7WhsNt9As6RTUtkW7EMaL4Nn8D5rXCllEw/8
         4tUQTWoiBHhWDaHSMwhY4axO+vj/goxdeZcRKeIRJNcQjpSouAwNeR/+S4CNhpwKGl8x
         w0Co2SwyLfK7NackQjBOe9rMxnM9Ter7dfBZXdfPy+WFYRmdL75lgL/FqxTrba3JXq3c
         LxSiYr2+tqzaLDgD3GD6VCyocAxqxMWHK+eFKhBocZ/3tfNIXUHCjtMQkbkyKMzawYGn
         SO2Pq6KGYXbCZVy5tIWwEQgU89BQplIvi6fyNDd7FqjSm0Ar/jWycHc+a6tGTjPC/N31
         0aqw==
X-Gm-Message-State: ACrzQf2GHeV5j3AaxdpJzUzn6LAgf6XXPVjQOhr4vyshZr+cn1HRF/Gs
        8qooaNmZf9ykSevkirZJsco2+49YDg==
X-Google-Smtp-Source: AMsMyM79Sr2FjutrrhIUyLR+MG6TrL/mZtICyJMPRV3JOwtMH/oKViBoSdzJYvHnTeZTwNMsCoWM/oBh3A==
X-Received: from cukie91.nyc.corp.google.com ([2620:0:1003:314:8113:36e9:8e90:5fb8])
 (user=cukie job=sendgmr) by 2002:a25:7102:0:b0:6be:a3ae:e43b with SMTP id
 m2-20020a257102000000b006bea3aee43bmr797309ybc.302.1667854697844; Mon, 07 Nov
 2022 12:58:17 -0800 (PST)
Date:   Mon,  7 Nov 2022 15:57:53 -0500
In-Reply-To: <20221107205754.2635439-1-cukie@google.com>
Mime-Version: 1.0
References: <20221107205754.2635439-1-cukie@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221107205754.2635439-3-cukie@google.com>
Subject: [PATCH v1 2/2] selinux: add support for the io_uring setup permission
From:   Gil Cukierman <cukie@google.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Cc:     Gil Cukierman <cukie@google.com>, kernel-team@android.com,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch implements a new io_uring permission that controls
access to the io_uring_setup system call. The new permission,
io_uring { setup }, is added to the existing io_uring class.
This is important as it allows users to restrict their attack
surface by limiting which subjects are allowed retrieve fds
from the kernel that are necessary for the use of all other
io_uring functionality.

Signed-off-by: Gil Cukierman <cukie@google.com>
---
 security/selinux/hooks.c            | 13 +++++++++++++
 security/selinux/include/classmap.h |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f553c370397e..d2becf833a07 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7012,6 +7012,18 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 	return avc_has_perm(&selinux_state, current_sid(), isec->sid,
 			    SECCLASS_IO_URING, IO_URING__CMD, &ad);
 }
+/**
+ * selinux_uring_setup - check to see if io_uring setup is allowed
+ *
+ * Check to see if the current task is allowed to execute io_uring_setup.
+ */
+static int selinux_uring_setup(void)
+{
+	int sid = current_sid();
+
+	return avc_has_perm(&selinux_state, sid, sid, SECCLASS_IO_URING,
+			    IO_URING__SETUP, NULL);
+}
 #endif /* CONFIG_IO_URING */
 
 /*
@@ -7258,6 +7270,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(uring_override_creds, selinux_uring_override_creds),
 	LSM_HOOK_INIT(uring_sqpoll, selinux_uring_sqpoll),
 	LSM_HOOK_INIT(uring_cmd, selinux_uring_cmd),
+	LSM_HOOK_INIT(uring_setup, selinux_uring_setup),
 #endif
 
 	/*
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index a3c380775d41..48da4e7f7d62 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -253,7 +253,7 @@ const struct security_class_mapping secclass_map[] = {
 	{ "anon_inode",
 	  { COMMON_FILE_PERMS, NULL } },
 	{ "io_uring",
-	  { "override_creds", "sqpoll", "cmd", NULL } },
+	  { "override_creds", "sqpoll", "cmd", "setup", NULL } },
 	{ "user_namespace",
 	  { "create", NULL } },
 	{ NULL }
-- 
2.38.0.135.g90850a2211-goog


Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E985C4332F
	for <selinux@archiver.kernel.org>; Thu, 10 Nov 2022 18:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiKJSYR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Nov 2022 13:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKJSYQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Nov 2022 13:24:16 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C9BB1F5
        for <selinux@vger.kernel.org>; Thu, 10 Nov 2022 10:24:15 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id t25so7101694ejb.8
        for <selinux@vger.kernel.org>; Thu, 10 Nov 2022 10:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHgZ5/S5EjCy5k2k9oW8FuOSTIixkMLcNcaSssVe1io=;
        b=IfjGkAmDChq2YQ2rg1UKY7h/71oMHcMgIJBQQaNbq5s3KeRAB3pWTNu5/5W6PKEhqY
         f+ZRJFqUrMcwpuVlWm3RitgeASUORxkrrNoPxogsvTPSUx+m+FgVJU9J8bF6Mxko201W
         HjeqLztcUG5EvEyGiBXdSjbrND84E128SxXWuuts2lBifK5dAUMejSqofkbLY4AV4hFM
         vBbOnZlD3nnHR5UlTy8d3KsSqn8fJcu0w5fV7U9JsKuQzx4GrHbwGRc1AHC8z3M4RlUc
         hz7jrbdVrj840IWS0frR10U2FdXLOa04LDECP/zZDO7d8IKzMQEJshXqqFs0vpQpL9CO
         lyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHgZ5/S5EjCy5k2k9oW8FuOSTIixkMLcNcaSssVe1io=;
        b=zQNXdhoVGXQJqej11DiNqoR1v7/hom24NZVaXMZJ82UQ9uTuKqZrmbAFKO+Cl+q9nC
         xsU7vp701D62Xhlfk+UvP1kpHb4V7C5E+9Xtpj0D4+Xkm1YOykbW3Rc3F/Eubaqr0cse
         u9B52QDgxgSv7ZeEkbCikFnY0418qpoRbDqw6HgHo3E8bk5vncY4WG54wZwOq/0c94uP
         y5ClY+klyMoi/15h6KRk13ZCYLCxP3D/5vEGvxSXiLGVSHsOOb2AFqYDEhoXwyAwI9sK
         4w8yCG8eTkxObAPOCYP3jBNYhDeNQRdgGTU3lj5hg7Co/PcZWIgNfzpMj6PgpMowa0Xq
         o8lA==
X-Gm-Message-State: ACrzQf2TACE8R4AGJ7tAY8UrAYicrwJnuTXHVfFeQYbjtu043Cxc30iG
        dX7U9Gux19ATlY6rtraP8h7OScw6S+A=
X-Google-Smtp-Source: AMsMyM6O+nb81KmiLepdSTkUtRrjx8zPCzJDfRE4ek7aPPU2ZhNsGbg89yWWYVBheq+/FmSdd78ZGw==
X-Received: by 2002:a17:906:8314:b0:7ad:e52c:12eb with SMTP id j20-20020a170906831400b007ade52c12ebmr3412865ejx.524.1668104654419;
        Thu, 10 Nov 2022 10:24:14 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-183-034.77.10.pool.telefonica.de. [77.10.183.34])
        by smtp.gmail.com with ESMTPSA id g17-20020aa7c851000000b0046383354bf9sm129306edt.40.2022.11.10.10.24.13
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:24:14 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 2/3] libselinux: bail out on path truncations
Date:   Thu, 10 Nov 2022 19:23:42 +0100
Message-Id: <20221110182342.81869-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221109195640.60484-2-cgzones@googlemail.com>
References: <20221109195640.60484-2-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Bail out if computed paths based on user input are being truncated, to
avoid wrong files to be opened.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  - drop now obsolete assert(3) statements
  - use size_t as type for length variables
---
 libselinux/src/booleans.c            |  9 +++------
 libselinux/src/get_initial_context.c |  8 ++++++--
 libselinux/src/stringrep.c           | 15 ++++++++++++---
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index ef1f64a0..dbcccd70 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -7,7 +7,6 @@
 
 #ifndef DISABLE_BOOL
 
-#include <assert.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -147,7 +146,7 @@ out:
 static int bool_open(const char *name, int flag) {
 	char *fname = NULL;
 	char *alt_name = NULL;
-	int len;
+	size_t len;
 	int fd = -1;
 	int ret;
 	char *ptr;
@@ -164,9 +163,8 @@ static int bool_open(const char *name, int flag) {
 		return -1;
 
 	ret = snprintf(fname, len, "%s%s%s", selinux_mnt, SELINUX_BOOL_DIR, name);
-	if (ret < 0)
+	if (ret < 0 || (size_t)ret >= len)
 		goto out;
-	assert(ret < len);
 
 	fd = open(fname, flag);
 	if (fd >= 0 || errno != ENOENT)
@@ -184,9 +182,8 @@ static int bool_open(const char *name, int flag) {
 	fname = ptr;
 
 	ret = snprintf(fname, len, "%s%s%s", selinux_mnt, SELINUX_BOOL_DIR, alt_name);
-	if (ret < 0)
+	if (ret < 0 || (size_t)ret >= len)
 		goto out;
-	assert(ret < len);
 
 	fd = open(fname, flag);
 out:
diff --git a/libselinux/src/get_initial_context.c b/libselinux/src/get_initial_context.c
index 97ae3dcf..87c8adfa 100644
--- a/libselinux/src/get_initial_context.c
+++ b/libselinux/src/get_initial_context.c
@@ -23,8 +23,12 @@ int security_get_initial_context_raw(const char * name, char ** con)
 		return -1;
 	}
 
-	snprintf(path, sizeof path, "%s%s%s", 
-		 selinux_mnt, SELINUX_INITCON_DIR, name);
+	ret = snprintf(path, sizeof path, "%s%s%s", selinux_mnt, SELINUX_INITCON_DIR, name);
+	if (ret < 0 || (size_t)ret >= sizeof path) {
+		errno = EOVERFLOW;
+		return -1;
+	}
+
 	fd = open(path, O_RDONLY | O_CLOEXEC);
 	if (fd < 0)
 		return -1;
diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index 592410e5..d2237d1c 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -82,7 +82,10 @@ static struct discover_class_node * discover_class(const char *s)
 		goto err2;
 
 	/* load up class index */
-	snprintf(path, sizeof path, "%s/class/%s/index", selinux_mnt,s);
+	ret = snprintf(path, sizeof path, "%s/class/%s/index", selinux_mnt,s);
+	if (ret < 0 || (size_t)ret >= sizeof path)
+		goto err3;
+
 	fd = open(path, O_RDONLY | O_CLOEXEC);
 	if (fd < 0)
 		goto err3;
@@ -97,7 +100,10 @@ static struct discover_class_node * discover_class(const char *s)
 		goto err3;
 
 	/* load up permission indices */
-	snprintf(path, sizeof path, "%s/class/%s/perms",selinux_mnt,s);
+	ret = snprintf(path, sizeof path, "%s/class/%s/perms",selinux_mnt,s);
+	if (ret < 0 || (size_t)ret >= sizeof path)
+		goto err3;
+
 	dir = opendir(path);
 	if (dir == NULL)
 		goto err3;
@@ -107,7 +113,10 @@ static struct discover_class_node * discover_class(const char *s)
 		unsigned int value;
 		struct stat m;
 
-		snprintf(path, sizeof path, "%s/class/%s/perms/%s", selinux_mnt,s,dentry->d_name);
+		ret = snprintf(path, sizeof path, "%s/class/%s/perms/%s", selinux_mnt,s,dentry->d_name);
+		if (ret < 0 || (size_t)ret >= sizeof path)
+			goto err4;
+
 		fd = open(path, O_RDONLY | O_CLOEXEC);
 		if (fd < 0)
 			goto err4;
-- 
2.38.1


Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC001C433FE
	for <selinux@archiver.kernel.org>; Wed,  9 Nov 2022 19:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiKIT4z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Nov 2022 14:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiKIT4x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Nov 2022 14:56:53 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE5D2F00C
        for <selinux@vger.kernel.org>; Wed,  9 Nov 2022 11:56:51 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id n12so49703091eja.11
        for <selinux@vger.kernel.org>; Wed, 09 Nov 2022 11:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fseVezmR5p/YxJ3up3swvrMLFD852DcFyKhRxvReSIU=;
        b=FuedeF23U+lGECXXERm5gIbkAAZS++YooTcELXfiyu6mfih8V6nlTMatL4tbEL9n2l
         Hdv/94q1Ytieq34Z7XYzLZ3IRpixhp2RxiBBiKJLmNOnfbGOdxxR2/e07BjRWR00d5Lw
         hykOZMptcIqkvC0yolnEqphH8LnXz/15zV9WO2LL7yyI3J4/tiX3KTS8zWq3f8h89hxE
         w5Erk8QxrbAtyMNyY6X86pMZicKKp2+9p2Si1clvWWToUFV/Piy0goS5W/2Mptd+93tX
         lB8jWFjrpGhgBe5IbxfjGcL64AJbphq91OXt5ufq2uPcretUNAgUVtnARqbbqS5IUH7d
         LbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fseVezmR5p/YxJ3up3swvrMLFD852DcFyKhRxvReSIU=;
        b=MaKRt47PM+/UJvu/f7393Y4gIS01cvdO2Iv03GIvfoO5v6Ubdu8vwv3CGziVfv/noG
         mJYFJ0rC2gpgGG7jz7WrfBgfVQcp/PJQ7lwFPPAoLoupGKTAFHvBVx5aw4f/48HfDAb7
         BHyEM/m1bs36jGDaYkS9JeqkjsSvF974wmLHKJZf7VMz5iLobobxq2StIPB2nSXsNU/J
         LP40dfw2s29m4f5I4qJ2L6RBwY8PJTtIkpE603MzN9LJaYWoLmEhOhrJQ5DTM2RsqHFQ
         F5sGMLaStiCX0rIw/nx26R28feQzB64KVK+TKnGBkqHfZfkbx3qiJWBymQlPA3upt3mR
         /KHw==
X-Gm-Message-State: ACrzQf0RsqJdle83QvDadrfrpcfEoT8tT5EuQ1rwvuH5iM+PantoLJf3
        M7YxfbNvmyZPGuZUW9k4BKyzaESoXw8=
X-Google-Smtp-Source: AMsMyM5BzZ1GcAbi5JgvizwGxhklyrYcgu2eBmmylt1RMV95B6tMx4T0c+MNj2Ea9pZFSoUNYuMKVQ==
X-Received: by 2002:a17:906:55ca:b0:7ad:b822:d2e4 with SMTP id z10-20020a17090655ca00b007adb822d2e4mr1620633ejp.35.1668023810268;
        Wed, 09 Nov 2022 11:56:50 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-185-019.77.10.pool.telefonica.de. [77.10.185.19])
        by smtp.gmail.com with ESMTPSA id bh1-20020a170906a0c100b00787a6adab7csm6379089ejb.147.2022.11.09.11.56.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:56:49 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] libselinux: bail out on path truncations
Date:   Wed,  9 Nov 2022 20:56:39 +0100
Message-Id: <20221109195640.60484-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221109195640.60484-1-cgzones@googlemail.com>
References: <20221109195640.60484-1-cgzones@googlemail.com>
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
 libselinux/src/booleans.c            |  4 ++--
 libselinux/src/get_initial_context.c |  8 ++++++--
 libselinux/src/stringrep.c           | 15 ++++++++++++---
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index ef1f64a0..66c946f9 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -164,7 +164,7 @@ static int bool_open(const char *name, int flag) {
 		return -1;
 
 	ret = snprintf(fname, len, "%s%s%s", selinux_mnt, SELINUX_BOOL_DIR, name);
-	if (ret < 0)
+	if (ret < 0 || (size_t)ret >= len)
 		goto out;
 	assert(ret < len);
 
@@ -184,7 +184,7 @@ static int bool_open(const char *name, int flag) {
 	fname = ptr;
 
 	ret = snprintf(fname, len, "%s%s%s", selinux_mnt, SELINUX_BOOL_DIR, alt_name);
-	if (ret < 0)
+	if (ret < 0 || (size_t)ret >= len)
 		goto out;
 	assert(ret < len);
 
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


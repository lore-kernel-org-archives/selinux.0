Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B093C4332F
	for <selinux@archiver.kernel.org>; Mon, 14 Nov 2022 19:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbiKNTcU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Nov 2022 14:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbiKNTcT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Nov 2022 14:32:19 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311A6B7C8
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 11:32:18 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x2so18827183edd.2
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 11:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9yaoPVKguoNZHv+hHuGKMFhO69aQQ/VSNBqrhD6M7c=;
        b=DNl76Xj1pCHu5wAxCyQE7IW8c4mm3WOeizY2//jYvmFbS6qATXix6p7iRW7aTgEMaA
         ini1OZKUv5CuLc5cs8QO9SrsIElCkt4WjB/n0fvw+s3xiBh4Yx23wol95aA8qvEyx1ko
         IypY/+HqR2rTkD6ukFFiCqUqSV1lCXrYJGxsQlpldYoL3NKqtNmyJ8zEobUQWJtmjQn8
         rgcbo2BlDj9VHXVa7kW091NznhABBaDUcf8f0AFzIAhqwZX7VLAwIWUi6VQB1ktJ4z1A
         ULukQhZg9PStJslWQ4exuR8K1x8Qj2HdlxLkeKrhqDTxVzlg9HgvFhfj5NMJiD77e7Kh
         cuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9yaoPVKguoNZHv+hHuGKMFhO69aQQ/VSNBqrhD6M7c=;
        b=eXBUphLQHdAjz/nni/m/x4nYGQFytQ7jB2xq3FL/R8CTgVL2cFjOZz3I/q87KVTm+H
         sAQ5iHOguI3+/2yVtFaDQCMjEbT/DBs7O68qM4ppaDHz1ljbAJqIC1k1EhQ404wbKutK
         4KsCCl1tjkwjaS3XB20LRsAfHR0SrnbBZDLRGCb7XXOH15Bj8uU0Mmyv8pok8DUEKJSM
         3ViID43/vkLtSEc0ALlezlufqwcekfl+SVQDVp71p+u3xtAe3VXtwJT3MPsjAmOMIUy2
         d/AptTyAvOx7XYVwZAjSTNb0pJi6k0QK7Z7fHt05YV9VgXrMFVLlawVFK5EPPGNOMxkM
         BBXA==
X-Gm-Message-State: ANoB5plpsT+l/spKUAtThgxfPHzDAEtEkitKv2dHrDxCJfFoYywq7jTm
        I1WT7KsNBUNc2Ycgy5DRfyvvaRp3AlI=
X-Google-Smtp-Source: AA0mqf4QusTo5thC3R0g69ukMbv8R6qwyFO884rL+BBbeo10YL0LnMZ9vZAQHjphUAAXSR8nHt06DA==
X-Received: by 2002:a05:6402:515c:b0:461:b1b9:bed0 with SMTP id n28-20020a056402515c00b00461b1b9bed0mr12415256edd.122.1668454336726;
        Mon, 14 Nov 2022 11:32:16 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-090-138.77.3.pool.telefonica.de. [77.3.90.138])
        by smtp.gmail.com with ESMTPSA id ft31-20020a170907801f00b0078d9cd0d2d6sm4666356ejc.11.2022.11.14.11.32.15
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:32:16 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 3/3] libselinux: filter arguments with path separators
Date:   Mon, 14 Nov 2022 20:32:08 +0100
Message-Id: <20221114193208.9413-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221109195640.60484-3-cgzones@googlemail.com>
References: <20221109195640.60484-3-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Boolean names, taken by security_get_boolean_pending(3),
security_get_boolean_active(3) and security_set_boolean(3), as well as
user names, taken by security_get_initial_context(3), are used in path
constructions.  Ensure they do not contain path separators to avoid
unwanted path traversal.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
  - move check for translated boolean name into selinux_boolean_sub()
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/booleans.c            | 5 +++--
 libselinux/src/get_initial_context.c | 5 +++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index dbcccd70..e34b39ff 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -131,7 +131,8 @@ char *selinux_boolean_sub(const char *name)
 			ptr++;
 		*ptr = '\0';
 
-		sub = strdup(dst);
+		if (!strchr(dst, '/'))
+			sub = strdup(dst);
 
 		break;
 	}
@@ -151,7 +152,7 @@ static int bool_open(const char *name, int flag) {
 	int ret;
 	char *ptr;
 
-	if (!name) {
+	if (!name || strchr(name, '/')) {
 		errno = EINVAL;
 		return -1;
 	}
diff --git a/libselinux/src/get_initial_context.c b/libselinux/src/get_initial_context.c
index 87c8adfa..0f25ba3f 100644
--- a/libselinux/src/get_initial_context.c
+++ b/libselinux/src/get_initial_context.c
@@ -23,6 +23,11 @@ int security_get_initial_context_raw(const char * name, char ** con)
 		return -1;
 	}
 
+	if (strchr(name, '/')) {
+		errno = EINVAL;
+		return -1;
+	}
+
 	ret = snprintf(path, sizeof path, "%s%s%s", selinux_mnt, SELINUX_INITCON_DIR, name);
 	if (ret < 0 || (size_t)ret >= sizeof path) {
 		errno = EOVERFLOW;
-- 
2.38.1


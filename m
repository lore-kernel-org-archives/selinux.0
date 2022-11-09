Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CBEC43219
	for <selinux@archiver.kernel.org>; Wed,  9 Nov 2022 19:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiKIT44 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Nov 2022 14:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiKIT4x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Nov 2022 14:56:53 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8912F010
        for <selinux@vger.kernel.org>; Wed,  9 Nov 2022 11:56:52 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u24so28595436edd.13
        for <selinux@vger.kernel.org>; Wed, 09 Nov 2022 11:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2/9uHZatBPqiWBVGD6EcLxst6Tri9L6fGhTfHOAu80=;
        b=A9Ooa8nKx78Y8Tzahh3wy9OrmWp2R7k5aP8q2LsRmOGt12sg5nE9UKBdpIRdKouzb6
         OyeZ0aBxFIoO4baL6tWW5YMmnuZ2h7wu6VJfnVUtTL+WYhRtIehbVpF6K3J8OvY8o5Rb
         jIuEi9m+KEflgom+B/IoeY1IeK9Zwt2KObT5YmvzU9u1I6jABj+j5WbQcI3BBxNelqOh
         aF0ei+sEvM1ZVzeZhfVbxjTrJCgPCtBfZLlPgfOnqgfiXheZ9zO/0ENmO8cLCgd0lYCd
         FXIV9nKkaNwf4RL+U/ISMgGB7isp/oOGRKVEi0mCuyRrw3xTBaJA9K8euw/8RqZMMFJ9
         aPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2/9uHZatBPqiWBVGD6EcLxst6Tri9L6fGhTfHOAu80=;
        b=6m9/Nno5vaEb9ORKIiVgEN2v7ajv3CAejnd3vYApoa4ga6Sa1XwW7o2aygLmv/3LlJ
         M+nhbxgnYKmjZe9F2fVvVD4pi9o5tTdHvnLHc3xQolQlJ4zMhlFGOG0Jd2e7F+QZPaIV
         r2QBJ+MWzXrqjgVLbsrSArEe2ARrld7mJI9mHlabcHuVCgNQCoXMEft1Hca+kBxHX09l
         GpOWrVLXUg/5bS81/xkLRsL/b723mtAAiuMqtcbV/ZnF0vCjQ4Gb9nSap2A2mXKWFJuq
         eraEkYGNpsgKQ+M90Dzw53cOYdgHVRHNYvyPiQrRSdVL0enoiVjXHFCtJIPMJDWh9Kcd
         hdGg==
X-Gm-Message-State: ACrzQf3gEXY/3wvAfUQMw2Rgue5wPvTEunk2WqHXwHO4sZMaPKoEvnbJ
        JotB3Qz3EH8ZIYikZ8qIHo0V8x5IEGI=
X-Google-Smtp-Source: AMsMyM5dxY1LKEkmypHr70/9mUJQuHPnbPYhj09ljcAaZn2iQwNBBdHWAIP/6GwFrtTLBcJr4lBkxA==
X-Received: by 2002:aa7:ca54:0:b0:461:ec03:3c04 with SMTP id j20-20020aa7ca54000000b00461ec033c04mr1204419edt.24.1668023810804;
        Wed, 09 Nov 2022 11:56:50 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-185-019.77.10.pool.telefonica.de. [77.10.185.19])
        by smtp.gmail.com with ESMTPSA id bh1-20020a170906a0c100b00787a6adab7csm6379089ejb.147.2022.11.09.11.56.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:56:50 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/3] libselinux: filter arguments with path separators
Date:   Wed,  9 Nov 2022 20:56:40 +0100
Message-Id: <20221109195640.60484-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221109195640.60484-1-cgzones@googlemail.com>
References: <20221109195640.60484-1-cgzones@googlemail.com>
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
 libselinux/src/booleans.c            | 7 ++++++-
 libselinux/src/get_initial_context.c | 5 +++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index 66c946f9..64248191 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -152,7 +152,7 @@ static int bool_open(const char *name, int flag) {
 	int ret;
 	char *ptr;
 
-	if (!name) {
+	if (!name || strchr(name, '/')) {
 		errno = EINVAL;
 		return -1;
 	}
@@ -176,6 +176,11 @@ static int bool_open(const char *name, int flag) {
 	if (!alt_name)
 		goto out;
 
+	if (strchr(alt_name, '/')) {
+		errno = EINVAL;
+		goto out;
+	}
+
 	/* note the 'sizeof' gets us enough room for the '\0' */
 	len = strlen(alt_name) + strlen(selinux_mnt) + sizeof(SELINUX_BOOL_DIR);
 	ptr = realloc(fname, len);
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


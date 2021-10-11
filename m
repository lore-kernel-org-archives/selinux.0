Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DCAC433FE
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC42E60E8B
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhJKQ2q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbhJKQ2l (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD62C06161C
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id p13so70637342edw.0
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RZ5+gxXPH9Zd+h08Fh/97W+plWtGJeY6+EoQt7QAdMk=;
        b=WeWBVoW2jSbPeQ6AEo8wtegK+CzlFGbDAp84nDcQRVrNJfFVEtnw8bvmRw/tpN1mct
         kznpS56ZFDafkYrZT9hRE4oySSoMh7l6XuVngFWUhV2qq2o2QHZlQBw41nUrd1AIl23a
         bLYqDTQ4ghpX8EERdVMBz6/b/DKvkCBVRESyMxnqbGKsUClpmlUmMq0oHRRZi8q4MIFO
         51B+aKGBZeAdwXzRddtJsbGqrhNcqP9aooz0A2kjb/KJO9OcEAINctISDG4t3SBG66P2
         FRPaZlDdbTFxqvWb9HQffTQh4ieZR1qjfCo9p7VJRzBVmpIhXcb22tIxEvDFu2Ec4oHu
         uxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RZ5+gxXPH9Zd+h08Fh/97W+plWtGJeY6+EoQt7QAdMk=;
        b=bag8D87IgQfpkkFsT+OXzFoM+JhtWIqxvFYc5DB5pTjT/GJGBKpeDVy3784xbe5IEd
         /vA3qCFV7kb8bKWv/+3Hsj9frtLbxoJrSXpykIhrSl9KGBTBAqwKRGBOfUxqKnhCMZoe
         cvma3UFUe6zCc2UP3n1vj6gH1B1oIyoum4ZdfTXg/Ais0s9xhBx4ejEW9XxWfl2tayYc
         Fi5Y0rHrN7Rs0RLaGczX9Crx4+oSCgGBAb57qseosZPoNAF20Gn+s9eWcb/+ynPttRqX
         DGm+lmaZPkjCRfZNovZDMVWoqR1wPXpXmPNOmr9YQr6VXxp0/BitqQGDtRlXZH/dnJ+g
         /Qrw==
X-Gm-Message-State: AOAM531qpklJ/PoW1KhVzth+GICPjbcJ7tU2UEy6K4eqcnR7rSVDVTD3
        O3JJFPciFNeM8GphGqF1AP8wVVvU1Bs=
X-Google-Smtp-Source: ABdhPJx72ewRXGwldsY1BD/9bucySIEdoSkn/8TZTE9hYb9m6Zwhcvl8j8sa0cdcDcLq4YDalruLsg==
X-Received: by 2002:a17:906:1e55:: with SMTP id i21mr26385522ejj.547.1633969599768;
        Mon, 11 Oct 2021 09:26:39 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:39 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 35/35] libsepol: do not create a string list with initial size zero
Date:   Mon, 11 Oct 2021 18:25:33 +0200
Message-Id: <20211011162533.53404-36-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently is it implementation defined, due to the size being passed to
calloc(3), whether the operations fails nor not.
Also strs_add() does not handle a size of zero, cause it just multiplies
the size by two.

Use a default size of 1 if 0 is passed and swap the calloc arguments for
consistency.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index 152f2816..9f5400c9 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -107,6 +107,10 @@ int strs_init(struct strs **strs, size_t size)
 {
 	struct strs *new;
 
+	if (size == 0) {
+		size = 1;
+	}
+
 	*strs = NULL;
 
 	new = malloc(sizeof(struct strs));
@@ -115,7 +119,7 @@ int strs_init(struct strs **strs, size_t size)
 		return -1;
 	}
 
-	new->list = calloc(sizeof(char *), size);
+	new->list = calloc(size, sizeof(char *));
 	if (!new->list) {
 		sepol_log_err("Out of memory");
 		free(new);
-- 
2.33.0


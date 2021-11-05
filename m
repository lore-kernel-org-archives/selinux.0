Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D32AC433FE
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2688761245
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbhKEPsl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbhKEPsk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD394C061714
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:46:00 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f4so34276224edx.12
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TpsQZvP2/3Bt8hzneRPE//fvOIRquXJ1qShM+ktaxq8=;
        b=FSdJPzzYDtkrDdpjYXRutFoiWrrtpFm3kpXMQuOZB6ylAqoNXyj/t6UTrZmHp6ZKDJ
         CfNdco0KfsfGvloVXO7l2sjh4Oew1Z7pioC7Bv4exELIge5/FkDKoCZwgL9zsXPcfnWn
         NRR39wEh9EXeaQ7wXCOmKeRZ7JGwxxEW1dDC21NJ/wT6v8CiS9e8OMTL46E2SzTaQD72
         BVHuot5AEYBn9QAlwhv0Jgmfw0jrX0f6L2RF7gawvtvKLHcWUyO0+0RTry+ZgN04Eghj
         NpJFzoyYtTRWraLf3QzwZpL/dlZDGnpUHnkO+UMqdE4KEgiD50NmHyzX6at6SArs+JzW
         Kz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TpsQZvP2/3Bt8hzneRPE//fvOIRquXJ1qShM+ktaxq8=;
        b=6kl5ZC419m+QzaTqRTzDHmdUyKSrNx6PG2gbky7zyOyeKr11SmzofvTTeee/lW81Lp
         4C81gsxSBHYClRdJd1/msAhU1cBj8lTOW/X7ztGy92Fno5Be+qRHHyKVdBJP4Ws+BAkF
         N8yDS4az4dfptW4/yFKtvM6CFwjSpW3xlC2ad7Q9fRbhxGVN5LHH+w3R8NF4t9ex2G8B
         zZbRNThwoo4Yt8KJ58rkFymJrqSj9fjSYjMh09r7O/POvnuvzyPon5B+x8mr+9JEBpLp
         xUCGCTY/wDHFTf4lpeXdpK18d/T6lU+TJPT0VO0fqCU8jzAd1GM7OLEeVIOV3qCWCpdA
         AvlQ==
X-Gm-Message-State: AOAM532R/MUsnwmpHJ4SB+5fq2HhLBe9F3bw7UDJ0DMObP1h+q9Jo6T/
        zXDJLwwK+f4mFR30876p06doKoNfkXA=
X-Google-Smtp-Source: ABdhPJyEdkVUxse+8YCephNiMNPw+CZbIxPOmqddD0JZxzpzDBtU7R7Qw3+FlF/MM0l6mtXOo120Qg==
X-Received: by 2002:a17:907:7253:: with SMTP id ds19mr47659282ejc.476.1636127158225;
        Fri, 05 Nov 2021 08:45:58 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:57 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 21/36] libsepol: do not create a string list with initial size zero
Date:   Fri,  5 Nov 2021 16:45:23 +0100
Message-Id: <20211105154542.38434-22-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105154542.38434-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com>
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
2.33.1


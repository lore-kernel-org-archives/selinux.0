Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C99DC433FE
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 18:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbhLQSTd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbhLQSTc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 13:19:32 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424E2C06173E
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:32 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id p3so3169246qvj.9
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=38U78WGYR/L8/AuwymvaYK3uZ/Ep9BAcF3uvxLGoLmY=;
        b=IAuI9yMAymZSTfLImeq8ZFzpw1xLmZVGLX20vdA8vHguK2xTcdw75jSYeQS2+EF2VD
         htfg65xLWs/GaItbHOKZ2j+WS4dOTxJPvMHttl/szfeV1KDzTpTaLDFcwIt4bw+yKWvZ
         3b4OyZ99Ww2p1E4o9U3Xt/7RdVTVQMeRlwu++1AC9wPmanhj+6KWqFeaXLqc5t23bj7V
         hvJgzYV/vRT4FyYETTY/viLwBmEpvL8xFJIPyUQV0vv3sYTu3qRE2yqMVleRwfP1Hy7u
         Ll6Ex+0niv3VJqpqCOTYaJoP5Q1fT9Nc+hs1PGE6hARm247vUgiKtna+HyoRMBYv5KoO
         o1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=38U78WGYR/L8/AuwymvaYK3uZ/Ep9BAcF3uvxLGoLmY=;
        b=30KEVQRA3kEAxMOp8pXMsmbETjPGNdZ6XosJauZiYToZ+ZjNBjlT8YKSp6MUfihhoZ
         eoEYQhGouBciBsxbnW2aDQBzzrKHoAUwOoZ3oyyGZLp//l27JY7XanDSQf+yDQOdaHdJ
         m9Jh/DI/oPc8Tb9XOf1hXUHd/d8NykKGD0Pdc/3QU9i9lBB3wWWh3mCbrWuTIOzEQ+e3
         Y1gAiNvAbRfQCGEMpkYZJfOihBRSZfQcFPac17rUc4wnVYb5+rWijQkLEAr/IucxPdEC
         n4QbklTjcr61DL/Lj6pLPdqAmcSwbs+okTpqcecgl54QUMRCAYRUPE8Hh/R2zyhZ7ckc
         2Gmg==
X-Gm-Message-State: AOAM531FvSOLotNY6z83w22VwRe527gYgBj5JwB9teSN/Oe2bOeYIbqv
        NDzC6c31rhf9MgpwTQ78rBdnlUg5Fao=
X-Google-Smtp-Source: ABdhPJwFKNgnl7HxMAv5pp4L53A9i9Sov4USJm9kSTpIwouMLXh+yQHHu+Uz565FDLSudj5GkxeITQ==
X-Received: by 2002:ad4:574f:: with SMTP id q15mr3720950qvx.97.1639765171367;
        Fri, 17 Dec 2021 10:19:31 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o17sm7468094qtv.30.2021.12.17.10.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:19:31 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 12/16] libsepol: Refactor match_any_class_permissions() to be clearer
Date:   Fri, 17 Dec 2021 13:19:09 -0500
Message-Id: <20211217181913.336360-13-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211217181913.336360-1-jwcart2@gmail.com>
References: <20211217181913.336360-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 4c9b9557..0bd620a7 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -65,14 +65,11 @@ static void report_failure(sepol_handle_t *handle, policydb_t *p, const avrule_t
 static int match_any_class_permissions(class_perm_node_t *cp, uint32_t class, uint32_t data)
 {
 	for (; cp; cp = cp->next) {
-		if ((cp->tclass == class) && (cp->data & data)) {
-			break;
-		}
+		if ((cp->tclass == class) && (cp->data & data))
+			return 1;
 	}
-	if (!cp)
-		return 0;
 
-	return 1;
+	return 0;
 }
 
 static int extended_permissions_and(uint32_t *perms1, uint32_t *perms2) {
-- 
2.31.1


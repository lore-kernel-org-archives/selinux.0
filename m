Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69882C43461
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D11A61244
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhECRy6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbhECRyx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:53 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DADC06138C
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:53:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id m12so9215292eja.2
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8a+ODB1LNoDtrvnUe/G+OpgSlNOTGtjaWoaMUWoLAfg=;
        b=oV0kE8T2LWYtaGvHAyFsWnr2BEg2AC7Q2Th7/W9gYEsYARrkBQ5oKpcCHq7X6H64jF
         fm51JGLsljF/bJKXvMl50qndEv1bP9ZBsY59vfzPABF0+8vgWpOH5Ycj/41g9Hm/SALT
         xMpDI5VJ7WADrGAZ6JnvM+rLO5amx3tA9XVzbIQjnFlO+brWJVUK+jrwACgOETJcl6f1
         8CKkZywEbFJG9/IkQ8hbbBxxeQYBvLiG/9csP0Q2antaly5pOotKkYu4/WQjN3PoxPej
         y+Tdw8rc5A7BUzbZzvM5+wh2fdh9DRkr/MmKksG28BwMwqY7auxnGZeo3AicBE5xgkMy
         OtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8a+ODB1LNoDtrvnUe/G+OpgSlNOTGtjaWoaMUWoLAfg=;
        b=CgW7z3VYWfLjz5YE/0cHzDXG+M3uHrddhmdntFeEC84yfMx4p1wZbRNyyDspx3aAf4
         CtGyTY3tWoJvzJp6kVqBZZEdJ81E3xOOx7qrCSJUyS6tvGMwzO0dOLnFRb/Nakz3hBmi
         WzsuVmQwhDaekK/LpHHIzTt18w9kSiM8s3xL7KD+rPvcu0SWBuiggPb090dYpBYWOVYO
         5hR9eorParbvbao+z2Rc7amE6DdtS3tKI6Lb0+33hFIve6xWESGngHntNJRuYJgXVt19
         bj3O5zkgvzJ0UF4bzhtSs4zRaqajDfBnUVECntJDJjjSGmBpTRNBqWblYbh9FBiD8+vT
         heiw==
X-Gm-Message-State: AOAM531ICNDu8IXUqj6c/wV45Lr+3tTL+s0etctUjDdwFaQlunyeYm6g
        gKfgX9iY1cpBqh1Pt3i7Omq8yHW08Q90fQ==
X-Google-Smtp-Source: ABdhPJxAksrNkn/FbGjs2R0fDQz/bSjKfaXSOKM/SKqJNanfaiJvKtPq/p2JCwhNLTiYmiw61YDY+g==
X-Received: by 2002:a17:906:17ca:: with SMTP id u10mr17393611eje.124.1620064437330;
        Mon, 03 May 2021 10:53:57 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.53.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:53:57 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 05/25] libselinux: sefcontext_compile: mark local variable static
Date:   Mon,  3 May 2021 19:53:30 +0200
Message-Id: <20210503175350.55954-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The variable `policy_file` is only used in sefcontext_compile.c.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/sefcontext_compile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index dcb0085a..6c32172d 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -14,7 +14,7 @@
 #include "../src/label_file.h"
 #include "../src/regex.h"
 
-const char *policy_file;
+static const char *policy_file;
 static int ctx_err;
 
 static int validate_context(char **ctxp)
-- 
2.31.1


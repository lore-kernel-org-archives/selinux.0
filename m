Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88954C77B75
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 09:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239963AbjELJXW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 05:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240134AbjELJXV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 05:23:21 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6B1E702
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 02:23:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-965ab8ed1c0so1597852466b.2
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 02:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683883398; x=1686475398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJRImihViRtxLkLyyQjnpBc4bhOKrp7RsdW83/Maleg=;
        b=MJ9xgv/Wq0fPLBEZLUqQieO4aFI6izMJE+gDysP4Ya+sfsF4I3N4obXQ7XuyvAr+Go
         hMGIu31j8iDPg8oWbxdnKYGs+eT8hqhLTQn8TKQ8ttYDpFMet9Bi04AH0fdy549fHUwk
         qMGlZALZFGQr4tx9dyJbGlhJXEIrn8oaL5LBNBA6y9uHb5suQT30Irb6UyO7P3dqdNOB
         VSXNlKb8LjCliIRgF/7hx/7k2dheq+N1cqWwtOFE38uLXsqwgQKzFHz5pyclmm4a++oD
         fmB5p3O/skOCDRp7lT5QOgAA1oIYaDqTl6GJMW6xLMtvsOkfH/gcuVdwkOGN/IhIe0LZ
         nrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683883398; x=1686475398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJRImihViRtxLkLyyQjnpBc4bhOKrp7RsdW83/Maleg=;
        b=R8J6+9dMZp27qbvJag73GFu9b0vc8k7HZgeJgbhWG1XgVwxYsWziK3LV0+Fu4+sDhM
         jwTJpbKCl8R7EPu0hB0m/AE9YXAKeM6bCRLrOrPkGBoCcS1V4tn8QOtqmXouFY1rBu+q
         wDOKrLgiPuPgJsCGY6CW6x5I4nrXxh5CxWTE1sngbfX+xlwZyzmlnPqrW9UP+aMHrXxK
         t/SWauNt1a3VvJA2z7oi/ep+yHzWuTejA+i82z1YMHkq7IqyS/STPUlBqNm9GKa1Jt9i
         N86ov92a6b1cOoWbHMETfG0ZgYixIkr3m+WiJtqyr+fyBw0sLJ+tghS3cM8FIOFfzea2
         uWxQ==
X-Gm-Message-State: AC+VfDyOdJfdByKka8Jt0bf7mS7P0vYAbuv86jbDFIFtqPtdlNFy7uwp
        WKYe8n45sBXkVky9rAVlZhs8ej8nBPp1nA==
X-Google-Smtp-Source: ACHHUZ56Ef5eHOn1NYYRN1XQ+/Jh+3/YJR4iI2YVpJmu2QFErDYPThi4Hxj1qg04S3xifG+cwa/36A==
X-Received: by 2002:a17:907:7b8b:b0:962:ec98:cd75 with SMTP id ne11-20020a1709077b8b00b00962ec98cd75mr25216982ejc.67.1683883398291;
        Fri, 12 May 2023 02:23:18 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id de25-20020a1709069bd900b0096664376ec9sm5186040ejc.55.2023.05.12.02.23.17
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 02:23:17 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/4] checkpolicy: drop unused token CLONE
Date:   Fri, 12 May 2023 11:23:08 +0200
Message-Id: <20230512092311.42583-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The token CLONE is never used in the grammar; drop it.

As side effect `clone` and `CLONE` become available as identifier names.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_parse.y | 1 -
 checkpolicy/policy_scan.l  | 2 --
 2 files changed, 3 deletions(-)

diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 45f973ff..da32a776 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -85,7 +85,6 @@ typedef int (* require_func_t)(int pass);
 %token PATH
 %token QPATH
 %token FILENAME
-%token CLONE
 %token COMMON
 %token CLASS
 %token CONSTRAIN
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 9fefea7b..2c025b61 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -77,8 +77,6 @@ hexval	[0-9A-Fa-f]
 				      source_lineno++;
 				  yyless(1);
 				}
-CLONE |
-clone				{ return(CLONE); }
 COMMON |
 common				{ return(COMMON); }
 CLASS |
-- 
2.40.1


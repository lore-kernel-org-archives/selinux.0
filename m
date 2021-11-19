Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAE2C433F5
	for <selinux@archiver.kernel.org>; Fri, 19 Nov 2021 21:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhKSVrv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Nov 2021 16:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhKSVrv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Nov 2021 16:47:51 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C71CC061574
        for <selinux@vger.kernel.org>; Fri, 19 Nov 2021 13:44:49 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id z34so49337274lfu.8
        for <selinux@vger.kernel.org>; Fri, 19 Nov 2021 13:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2V99k1q9klSy70ozgsIPkUtgHIa7NQ1D9Ww0X2n4TK4=;
        b=C2V7yAUgNuT95XMCU/dATdLkksbuTaAOj96wLjTFQkVSDd1iPj0PV5Mi1uLn2BECNy
         Hg+uF5AA0YmJoQRNQK0FggH5wl8dZu4PgKT6jg/vhWE/N9a/Iyh3wJT293raMgu18xTa
         hIIxm+nz7vE99f3Bvi2dxU+OEJF6J9Pla+hPJRYAD9Xtw5QgF41GF5Wc20um5bo3B7cV
         CFhCJqHYPGjUUAk8nKQYBG77fe+YDkf0qELDu59vjjMWN0pDhAClhmmqbVJg0KzlUqWi
         xtnQQzRREekhHq/9dlGa4zuF2+s49Q3qUpw+5eDGGRO5C1y6UCM58qKHU9Tdqh5zzi5+
         q2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2V99k1q9klSy70ozgsIPkUtgHIa7NQ1D9Ww0X2n4TK4=;
        b=ktiPO3i5ewQHkEKs1eu6W+IriL9zU2u1wXMiyQ8SKojXfsyA87CnvNRs0CkVy2svbj
         Gif2BZgGbbHjSao2Zavek8P+i9WApYsmZF4JZn0JEnLNICiVIOL6MfVc3RIHfMfijqSd
         zhMS+giGdSrdT4oK9L2aKqkPZSsHFcO/6zSZBdnvrGRLUldA1AmHe2ch1l4dwxDfLh6S
         YSqXDBZCz9giYb013tWv4Qv7kmkw/6ngXBuBpTAMB47q75MQgpVhoVosme8XCaPmrSx6
         MrVP+/PsEp1JbxWsIkrHpnwiv2jK1fEQEvkCCLJdMzkMa+4WT3yIQ1gEgpY/hs3/xSQd
         wkmQ==
X-Gm-Message-State: AOAM5332mBl6e53C12WpK04odITNOtVeRWGBb3Vp0Iyx2+7YAdstnII1
        OxsYdntQwGaKmObRrhJkIhx0BJE7THg=
X-Google-Smtp-Source: ABdhPJynuMCnE0Q9e8NifKCpMQ1qO4bD9aj4USvl1dR+ms52enPt6AmvhMDdtnWVkMjpan/VZJx8YQ==
X-Received: by 2002:a19:9157:: with SMTP id y23mr36259173lfj.277.1637358287149;
        Fri, 19 Nov 2021 13:44:47 -0800 (PST)
Received: from localhost.localdomain (81-197-199-108.elisa-laajakaista.fi. [81.197.199.108])
        by smtp.gmail.com with ESMTPSA id t15sm102888lfp.181.2021.11.19.13.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 13:44:46 -0800 (PST)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH] Kernel policy language is infix
Date:   Fri, 19 Nov 2021 23:37:26 +0200
Message-Id: <20211119213728.19331-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Prefix / Polish: and a b
Infix: a and b
Postfix: 1 2 and

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 secilc/docs/cil_reference_guide.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/secilc/docs/cil_reference_guide.md b/secilc/docs/cil_reference_guide.md
index 1e63e680..ac800b12 100644
--- a/secilc/docs/cil_reference_guide.md
+++ b/secilc/docs/cil_reference_guide.md
@@ -189,7 +189,7 @@ Expressions
 
 Expressions may occur in the following CIL statements: [`booleanif`](cil_conditional_statements.md#booleanif), [`tunableif`](cil_conditional_statements.md#tunableif), [`classpermissionset`](cil_class_and_permission_statements.md#classpermissionset), [`typeattributeset`](cil_type_statements.md#typeattributeset), [`roleattributeset`](cil_role_statements.md#roleattributeset), [`categoryset`](cil_mls_labeling_statements.md#categoryset), [`constrain`](cil_constraint_statements.md#constrain), [`mlsconstrain`](cil_constraint_statements.md#mlsconstrain), [`validatetrans`](cil_constraint_statements.md#validatetrans), [`mlsvalidatetrans`](cil_constraint_statements.md#mlsvalidatetrans)
 
-CIL expressions use the [prefix](http://www.cs.man.ac.uk/~pjj/cs212/fix.html) or Polish notation and may be nested (note that the kernel policy language uses postfix or reverse Polish notation). The syntax is as follows, where the parenthesis are part of the syntax:
+CIL expressions use the [prefix](http://www.cs.man.ac.uk/~pjj/cs212/fix.html) or Polish notation and may be nested (note that the kernel policy language uses infix notation). The syntax is as follows, where the parenthesis are part of the syntax:
 
 ```
     expr_set = (name ... | expr ...)
-- 
2.33.0


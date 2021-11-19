Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D87C433EF
	for <selinux@archiver.kernel.org>; Fri, 19 Nov 2021 20:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E4F61A89
	for <selinux@archiver.kernel.org>; Fri, 19 Nov 2021 20:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhKSUVZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Nov 2021 15:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhKSUVY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Nov 2021 15:21:24 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D4DC061574
        for <selinux@vger.kernel.org>; Fri, 19 Nov 2021 12:18:22 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id c32so48481920lfv.4
        for <selinux@vger.kernel.org>; Fri, 19 Nov 2021 12:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2V99k1q9klSy70ozgsIPkUtgHIa7NQ1D9Ww0X2n4TK4=;
        b=WPunY9fNC+J7qq09znsUleN/Y1imJi3WyQoY2PyoBIJBDl6u82sLVKjwuHz5SlRTTZ
         gZz+kgCZQv/1O5r4sGz5IDN5nRwus/4uSWLz5Xg8GcfUyHeGo0lh7qONnFwjNt9UtK6W
         jiy2GwseBEugeQEBB8tRLKOiHCELNAYxqlgvUnKKnxeUjIoA1UqpfsKjw+LhOnj+hOMM
         h6LQs0vs96Jjco7LymrydXt7H4HwfPRwbbPvx0+yjdWDRzObUAa5plBGn9wG6bCM6D8c
         0QtNuWu5gy9okT9xwWrBfNPIxtgmBXvC3QSZZjYdMjyEAu5XI4W5DeEvrP1cQ9bcOKNu
         MfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2V99k1q9klSy70ozgsIPkUtgHIa7NQ1D9Ww0X2n4TK4=;
        b=bI6o1jXbTLHti96gSepty+cTQbQ4rE4McI30dpo9G2HOWen9vrckAOEHnPLLVOWLC/
         CPEvOWwiNZ0HJFZ3EP2Lkrlp0kSJvnYYNgXp/a1vamqX0D0AM+pOEeYBn8ZP0nBrlg0o
         VOVyym+/8JrJHIrQrFcQIv9XMcPszMdOOCW0iR0gC2Z2jqnTJ6NXWXaJiDPFyOqGD8Oy
         B73GqeWDJg9pnRR5dtgBB2qgk00LFuMr3XYqR9z3tGyvzzwFRHmFjz+Jaw/Bay+KEi4Q
         Y2nGSfas+BYPf2BYKThHCR4jCuIATDmvujXPjfCCbIwwKXVzyCG069JmwAWitxe8lgh9
         vEwg==
X-Gm-Message-State: AOAM53376VN9uFnvd+Y92NrVrf+RZfiOltVWYQg0YfaPv1AJisYKRyf6
        C0E8/4He8qSkD5dyf+mWj1yGRroLrkk=
X-Google-Smtp-Source: ABdhPJxxHmlBJung04mQeKRIzGmFqn8oJSuLMqhUwdGYbeyaQd3PQB7PiWJWHSL1IpwS3xKCLwBVFg==
X-Received: by 2002:a05:6512:3a88:: with SMTP id q8mr37157611lfu.140.1637353100460;
        Fri, 19 Nov 2021 12:18:20 -0800 (PST)
Received: from localhost.localdomain (81-197-199-108.elisa-laajakaista.fi. [81.197.199.108])
        by smtp.gmail.com with ESMTPSA id be30sm84565lfb.3.2021.11.19.12.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 12:18:20 -0800 (PST)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH] Kernel policy language is infix
Date:   Fri, 19 Nov 2021 22:14:12 +0200
Message-Id: <20211119201412.15915-1-toiwoton@gmail.com>
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


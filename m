Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EA8C433DB
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 20:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E64864E76
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 20:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhCPUsa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Mar 2021 16:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbhCPUrA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Mar 2021 16:47:00 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04ADC06175F
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 13:46:59 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id l15so354749qvl.4
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 13:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KndiZX6ZvuL4L7L+mv14eJRLLDWcGmyh90ql2dfT/To=;
        b=UE6vBORfGlWZaZcXavJhrt69IvGi9KQP/hYnSYfPv+KU7zT9ZQMW4jAm7nytIgvXYa
         tYJueCk2jlS3U/1eOj1aA4nT1D2uKQ1z6bYC0GO1Av7rqZH3eTMx/d8zix6jbI6mrMWG
         MR2L4aa9JxVY1hcszysCSARIBqMTWoGjCcZSsjTN/QidWTw9U2c3WJLunpJAFyxlFpGx
         y4kQ5BMnOd/j5fbYIlDSw6mM+4Rw02RSgaZpstR+GXF9JaAie0mbOcBY9TriCUB9jt9l
         lLozs9CoRGZ7F2DJKB42mM5zfDNa/FrhyjpetxVg83TSUIQhu3Y6/dgnyVXGoA/qMrmm
         UZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KndiZX6ZvuL4L7L+mv14eJRLLDWcGmyh90ql2dfT/To=;
        b=XrTLC+Sa+Gk79ZswjIjefTWcCJy/WX5EyLvSMfgFUA60wOr+rjgouoTj91qncECz3U
         OKJVWJdc7yWhhUG4fUbI6a+lCvV78ytq7YOdebEuS5tjxrnw0tAkusZ7XAXO7YyG2bcc
         Rb88lujNt20+HrVQOlCYxqSEs9CB7eCgCxQm7djBLMA7yVXmJOlfwOmIDQVzIglvIzXU
         S1XHSN8gwBH/wKCs0NYyfkCffoX9mgSIEjTeLDryJxMvYBbwdGWLuzkfMrXvXUmrPuhW
         RaPVAyqEgrQt6CcQVpOCEf8FZfwULk1/04BnT6J0tkVgbq1xeKxixExIKrUSIpMvOBLT
         V6rg==
X-Gm-Message-State: AOAM5324xAVjFgFYePIo4ByGoMOlZ+0egl85eG1WR8ocbE/NI/ZaBZ49
        qzq/sAgVm6ymeoQVFY3GfHDA37eZmjg=
X-Google-Smtp-Source: ABdhPJzMG6WYpY+fNIP02LJ1pQlDAN55/v1JeV3a1jxG9OXSWpeZEzM5bmQQvwX4ngxj40UA1TA6xw==
X-Received: by 2002:a0c:e385:: with SMTP id a5mr1436900qvl.12.1615927618768;
        Tue, 16 Mar 2021 13:46:58 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id v4sm13905687qte.18.2021.03.16.13.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 13:46:58 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/4] secilc/docs: Lists are now allowed in constraint expressions
Date:   Tue, 16 Mar 2021 16:46:44 -0400
Message-Id: <20210316204646.52060-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210316204646.52060-1-jwcart2@gmail.com>
References: <20210316204646.52060-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Update the CIL documentation to show that lists are allowed in
constraint expressions.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/docs/cil_constraint_statements.md | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/secilc/docs/cil_constraint_statements.md b/secilc/docs/cil_constraint_statements.md
index 2dd6e6f0..358927d6 100644
--- a/secilc/docs/cil_constraint_statements.md
+++ b/secilc/docs/cil_constraint_statements.md
@@ -34,12 +34,12 @@ Enable constraints to be placed on the specified permissions of the object class
 <p><code>    (op u1 u2)</code></p>
 <p><code>    (role_op r1 r2)</code></p>
 <p><code>    (op t1 t2)</code></p>
-<p><code>    (op u1 user_id)</code></p>
-<p><code>    (op u2 user_id)</code></p>
-<p><code>    (op r1 role_id)</code></p>
-<p><code>    (op r2 role_id)</code></p>
-<p><code>    (op t1 type_id)</code></p>
-<p><code>    (op t2 type_id)</code></p>
+<p><code>    (op u1 user_id | (user_id ...))</code></p>
+<p><code>    (op u2 user_id | (user_id ...))</code></p>
+<p><code>    (op r1 role_id | (role_id ...))</code></p>
+<p><code>    (op r2 role_id | (role_id ...))</code></p>
+<p><code>    (op t1 type_id | (type_id ...))</code></p>
+<p><code>    (op t2 type_id | (type_id ...))</code></p>
 <p>where:</p>
 <p><code>  u1, r1, t1 = Source context: user, role or type</code></p>
 <p><code>  u2, r2, t2 = Target context: user, role or type</code></p>
-- 
2.26.2


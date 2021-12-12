Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09F8C433F5
	for <selinux@archiver.kernel.org>; Sun, 12 Dec 2021 18:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhLLSt4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 12 Dec 2021 13:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhLLSt4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 12 Dec 2021 13:49:56 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5100C061714
        for <selinux@vger.kernel.org>; Sun, 12 Dec 2021 10:49:55 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u3so27186244lfl.2
        for <selinux@vger.kernel.org>; Sun, 12 Dec 2021 10:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZvRM2X00jfDFIruTcGr59Wfcbuab5Dfux9Oqkr/CCY=;
        b=jv7Q/zAQc6/KzpYXEFU/MPUPcI/Sf8BpvWjFEuC2MzuRPLAlevVZrNFUmJsqhhHW9B
         MTJJ7MooSU8RdBujOycj2PU9ghTh8hLF2/1K6nfWNRR0Z2wemXmQDvX//4NRdETw595I
         jgAQB3yVbaIdoAiW7Ak/75v2ArWgC/5ncBauWuo7C/WbmlUGExi58riv2ISZ05tcTATW
         8UYRJ6M1b+5Lbq/UE4J0wCZOj4DsRaiFjH3i189q0KcmWI0JyqT7BEyeLtC4xCBlrzr5
         9umpBXU8AZblp1ijXrTYeO5rwkAAHeUQLjRkoQUappOstdlR0ueH9NI/92TRSJAxumpx
         ufvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZvRM2X00jfDFIruTcGr59Wfcbuab5Dfux9Oqkr/CCY=;
        b=NQJVXix3UsgJrgpQ2GAVWtCyVQjF0dA2dIMbwqZaWZEHsfW+sYHxkf/6uBWlH1BRiE
         5Ltw1+hlw4kKLNVczezwtGA158d/jyYjYHAuLIGdN4fQBFa2d9s5G3KG79YgnPsFLfpp
         ca7BCCuvD/tygnMpHb45yqn5+005xuiUXQyOGOpp+ZYUoQJm9NyAcisuuw9ABb7jhNm5
         BkdCIcHEWNA0Ds0XCEs5haADy2s/vX0sTNDAMfAe9OJ31/oh7v8ySNknt8tTebl7ejEe
         ZBGpdy0iH9VO6q75DIpylFZiHcOc6tfWKtQ1zXVt7y9fCmkuxZn8kWBdDg1fg490Dgqj
         fIog==
X-Gm-Message-State: AOAM533nir39n1p6ccci/l64AeaFB1wIed9I4nD0ArPoSBNQ7RQbtHGi
        mgQVoKvlvDbxBKZO5ecTwouZ8x6fN1F8kw==
X-Google-Smtp-Source: ABdhPJxJqiH5BokotOZYUoelGXQJteqODhlLHaCB7NEPIcddR/sMo1fbklsOVCk5BBOCvAWaOuRDXw==
X-Received: by 2002:a05:6512:3341:: with SMTP id y1mr12979159lfd.311.1639334993734;
        Sun, 12 Dec 2021 10:49:53 -0800 (PST)
Received: from localhost.localdomain (81-197-199-108.elisa-laajakaista.fi. [81.197.199.108])
        by smtp.gmail.com with ESMTPSA id w8sm1122442lfe.183.2021.12.12.10.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 10:49:53 -0800 (PST)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH v2] secilc: kernel policy language is infix
Date:   Sun, 12 Dec 2021 20:49:44 +0200
Message-Id: <20211212184944.8681-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Prefix / Polish (CIL): and a b
Infix (KPL): a and b
Postfix / Reverse Polish: a b and

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
v2: improved commit message

v1: https://lore.kernel.org/selinux/20211119213728.19331-1-toiwoton@gmail.com/
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

base-commit: f7ec4b4a84aaf3e60b099e267dbfdabbfb1878c7
-- 
2.33.0


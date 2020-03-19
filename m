Return-Path: <SRS0=B1VM=5E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4322CC4332D
	for <selinux@archiver.kernel.org>; Thu, 19 Mar 2020 10:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEDA20724
	for <selinux@archiver.kernel.org>; Thu, 19 Mar 2020 10:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HNfWPxkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgCSKLO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:11:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44824 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgCSKLO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Mar 2020 06:11:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id o12so1514576wrh.11
        for <selinux@vger.kernel.org>; Thu, 19 Mar 2020 03:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xAMaWKCR3WA8Tl6CF0/9M3ThW7GAm/rLGWY+m02L+po=;
        b=HNfWPxkMSAWPMAakplOlE/hhDGq89Xc2ZkOv5qSCLnQO7TcN1SMnfS0BaXNiuHypgR
         Ahyf/gzxIONaNVlVzalVC3ACCrjA/nCRycHMyFhuEICncKvoARw+f8yLFAgUxV1cgGj2
         7QGo6Ru6Di+1U5/TXmlQR8pqGJUe+3tZQFVfIdbuWT/OZ83ABIGIZ0j0x4E6CU6/h9ok
         3bfMcXxK3rqi23+BjGM2JN4AxqSZSvQdadYy43XfZG9KUzlfi3zywJMYfTsLrjcivd0F
         Un4e4OFi/or41C+8jFTAOl63TncXydigth45wVvuNiZRGEKy7IvCnxdhn6Dr7evsN7fi
         g90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xAMaWKCR3WA8Tl6CF0/9M3ThW7GAm/rLGWY+m02L+po=;
        b=l/CyX3CfWQhFSK1Dh2xw3xa9X408GYVNJ6ZaC0nHblUzxqnC4FweQQdi6pM9Sd2qby
         PrkdmZ59hsQLk4W+vliv+ka9kJkRdE4IHb12m3TsrS1FObqgeXrF/D4fCAOAQy5jE9aN
         tix8J5twH1Wh2PfbQR19Ms4Yc5KJ/q7thQPmCnU3fzENYgj06Y0ybS5pftdev5cABcD7
         XMY8bWTYkP/v8xdqNv9jLLX5pI6x/bD9v8aQqdF4CZlic+jiUMRn/MB+krd258YKnmiN
         +7w9EslJFxDmOlxJ7PkUge+4mfBWuFI0kYS17BNS/DMpOg5FN3faLn2vMTUZqMP1paPQ
         q3MA==
X-Gm-Message-State: ANhLgQ0hCzEtLJLCqwH83NEsFjofM2c+i/mMszMsXgshB9apsX4RDMKZ
        /LkANrr+2St9N1TIt0mZtVT5gh/w
X-Google-Smtp-Source: ADFU+vsR3qMSnn8VpmQoTfuwD1oC4N15JeKt6QKTKTodhibFxB8N+YSE0Jv8qJ/egaKS98lCIWg0Rg==
X-Received: by 2002:adf:e58b:: with SMTP id l11mr3254138wrm.284.1584612671653;
        Thu, 19 Mar 2020 03:11:11 -0700 (PDT)
Received: from debianHome.localdomain (x4d01d445.dyn.telefonica.de. [77.1.212.69])
        by smtp.gmail.com with ESMTPSA id u16sm2698297wro.23.2020.03.19.03.11.10
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 03:11:11 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: set correct second argument of (t1 == t2) constraint
Date:   Thu, 19 Mar 2020 11:11:02 +0100
Message-Id: <20200319101102.14298-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <CAJ2a_Df884P05jEnWmcKkwP4rb-RQoVMCkK7aS+fNqQyM3rZqA@mail.gmail.com>
References: <CAJ2a_Df884P05jEnWmcKkwP4rb-RQoVMCkK7aS+fNqQyM3rZqA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently a constraint `t1 == t2` gets converted to the invalid cil syntax `(mlsconstrain (class_name (perm_name)) (eq t1 ))` and fails to be loaded into the kernel.

Fixes: 893851c0a146ef392b8d77de737d52245345129e ("policycoreutils: add a HLL compiler to convert policy packages (.pp) to CIL")
---
Does nobody ever used a constraint with this syntax ever ??

 libsepol/src/module_to_cil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 6fe7d336..a87bc15e 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1745,7 +1745,7 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 			case CEXPR_ROLE:                 attr1 = "r1"; attr2 = "r2"; break;
 			case CEXPR_ROLE | CEXPR_TARGET:  attr1 = "r2"; attr2 = "";   break;
 			case CEXPR_ROLE | CEXPR_XTARGET: attr1 = "r3"; attr2 = "";   break;
-			case CEXPR_TYPE:                 attr1 = "t1"; attr2 = "";   break;
+			case CEXPR_TYPE:                 attr1 = "t1"; attr2 = "t2"; break;
 			case CEXPR_TYPE | CEXPR_TARGET:  attr1 = "t2"; attr2 = "";   break;
 			case CEXPR_TYPE | CEXPR_XTARGET: attr1 = "t3"; attr2 = "";   break;
 			case CEXPR_L1L2:                 attr1 = "l1"; attr2 = "l2"; break;
-- 
2.26.0.rc2


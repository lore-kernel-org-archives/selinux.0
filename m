Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC89C433EF
	for <selinux@archiver.kernel.org>; Tue, 26 Apr 2022 10:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbiDZLCh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Apr 2022 07:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiDZLCf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Apr 2022 07:02:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D488152486
        for <selinux@vger.kernel.org>; Tue, 26 Apr 2022 03:59:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id m20so14527842ejj.10
        for <selinux@vger.kernel.org>; Tue, 26 Apr 2022 03:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=383Qx2l79NcYLwmcemk/vWMZ6mVWqnmDv67ArpPogcI=;
        b=phSEVNgFazlZg9i4u/C2WfVsmuHCS+XjhUiUBx2wR8tl7zsTwK7cYI9XUIJDC8PEUc
         opFiCOs4PH1qkn9sbUFvHxJYbUh171DS3qAqU4Q6Ny0azWL0WvJn7DJcYKgbxlysNqKs
         6y9OHJSDiBGyjhO2vfRefTLXEnW1adll5o0haVpQwGtegEbQKe8HGMArfPBzJjEe3CQe
         ysOZMaBGwNzbyFkOiJ7YgnhSJNSkL1+FAKyjJ/F8a5JE4l2MoG4Y6zGwTijKeW+cSI6D
         cDRrehAZzQtVeIiWdd/VhCqLu678Vdvjibayx2r5v5A//d9UAlHFIvl8j4a98+17/dRs
         BszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=383Qx2l79NcYLwmcemk/vWMZ6mVWqnmDv67ArpPogcI=;
        b=I1TL4IQenAzOpcYkcNM6t9W/0aXakoR6tsQxqv/gJJxSd637RAoxO980iRLZV9DBs2
         7kHdBsLP2IMIP7WPUTzMFPUxU+v50ZSn8UXDxNAbU7hzfqXr3FBxHOGtv9supb8wgmEo
         FDH6Q0GvQDMhnLugEFIw13CSOoOXZchTXEMDpU/e0N0tO23xEuYJ5leDcsG6yI01tRxg
         BPyRMCPph7Y9JJGXwymz9P1Y0POE38cOCssdl+RBLqbR47QXOO+4tEod0OuDaKwr2zuT
         Ha3G9hjri90+V1u5/hqGJjZrHFXrtbtRtLfkILoiEbbKqKFBFT44wGAH+AcnIdGLpQKO
         YZSw==
X-Gm-Message-State: AOAM530DoqmIGmUVXdfIktX/zx+sgPF01UzuklW5KfGM2g88uIYvZTd5
        ctnNdAC3mjDPgX/2CJZqtCMkXCQYPj0=
X-Google-Smtp-Source: ABdhPJwtxCwvAoqqivmTe/vTXTwZSNCcgrzzh1aooa6zNtPDDo2NqUKIxjn924SzwH0Tt3FWqLzisA==
X-Received: by 2002:a17:907:7289:b0:6f3:6ac5:44b7 with SMTP id dt9-20020a170907728900b006f36ac544b7mr16922779ejc.566.1650970766866;
        Tue, 26 Apr 2022 03:59:26 -0700 (PDT)
Received: from dlaptop.localdomain (dynamic-077-000-044-201.77.0.pool.telefonica.de. [77.0.44.201])
        by smtp.gmail.com with ESMTPSA id x19-20020a05640226d300b004228faf83desm6386424edd.12.2022.04.26.03.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 03:59:26 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] checkpolicy: mention class name on invalid permission
Date:   Tue, 26 Apr 2022 12:59:14 +0200
Message-Id: <20220426105914.15817-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When a permission for a constraint statement cannot be found also
mention the related class name.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 16b78346..a4c24115 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -3627,7 +3627,7 @@ int define_constraint(constraint_expr_t * expr)
 				}
 				if (!perdatum) {
 					yyerror2("permission %s is not"
-						 " defined", id);
+						 " defined for class %s", id, policydbp->p_class_val_to_name[i]);
 					free(id);
 					ebitmap_destroy(&classmap);
 					return -1;
-- 
2.36.0


Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ECFC433EF
	for <selinux@archiver.kernel.org>; Fri, 10 Sep 2021 12:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B7F6611C7
	for <selinux@archiver.kernel.org>; Fri, 10 Sep 2021 12:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhIJMON (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Sep 2021 08:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbhIJMOL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Sep 2021 08:14:11 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F374C061574
        for <selinux@vger.kernel.org>; Fri, 10 Sep 2021 05:13:00 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id k4so3598848lfj.7
        for <selinux@vger.kernel.org>; Fri, 10 Sep 2021 05:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z+RFjCoXQqxJY5jppB0NdqJwCsB+dXD64dlW0gdum88=;
        b=gMFvm08XbiF7kKArg/X2Nv5pDbh958m9QE7L9ON/kkrrk3EblX3Fgg0t9rD7K5/AeH
         k4vMexZ0ulvYwIEx8tAYPJXc41X5V6CWh4OttqZluWGUJYy0SZZHYJFiQyLiULWTEOlo
         NaSve5QsqhqXWcEfYWLoRVoCInVOMBPdojwju5tq3b4jtuxrZ6aC52SJFA7oVxqTGHd2
         qVOhUS6a0Khwvhbmzwxk6mnpStPQN5r35feUBkxK0+xtHCCXLwqv9zA3GJ/amxPI7adH
         iNA2BgVEfkDsfxRQ68Hm3u3IuhHWE8nnry+QeSD8WUtPm83NMWTKFZmW5aBFcktu/XDr
         wXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z+RFjCoXQqxJY5jppB0NdqJwCsB+dXD64dlW0gdum88=;
        b=NikERm87GLx991ivS0ZTnA9lqOKOnJ6KCjh3K1weYVbaVWXEgJuw6VQiZ6Yl4cpNIS
         wvzTlWaBFq4EPuElMW1LE0V14MqIVaTT33w/Coo8V35a7bH2zGJe539QSBV1VGcaoMvq
         tqj6JgC3o1V5uwxj4zaUIpK5SvpXxngKDLeUbEcztYdrn2O4LfdFturHMCwb9/+/hRwI
         xks1rrxY5UmWP1xSMHEyytAi8TKF5WKUGykjxPeSp92wgtxTjFipuZErghDkSffH7zN6
         rL4+z+rVZtBjNm9uzeSBob/cN9TKRiN7snMEGLcFe43fE3cSIQ3vC8iBycFEU3QIxihJ
         WO+w==
X-Gm-Message-State: AOAM530/HJ8+qE00zTNZdHvBFX7DSSeVx3eABo155VfGQcJQQEaj4EdD
        tmZZaHUjZQi+nfk6LtGoxSiVvrCRPWw=
X-Google-Smtp-Source: ABdhPJxD+NC4XRP0kh0tGoR5lz4RVoR7MO3kj5BJOEL5L7aUZiEU8m/nFqlIFACStyDIEa+h99tnuA==
X-Received: by 2002:a05:6512:102e:: with SMTP id r14mr3447860lfr.639.1631275978621;
        Fri, 10 Sep 2021 05:12:58 -0700 (PDT)
Received: from localhost.localdomain (85-156-66-84.elisa-laajakaista.fi. [85.156.66.84])
        by smtp.gmail.com with ESMTPSA id i5sm555210ljg.53.2021.09.10.05.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 05:12:58 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH] libsepol: fix typo
Date:   Fri, 10 Sep 2021 15:12:52 +0300
Message-Id: <20210910121252.71710-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 libsepol/src/module_to_cil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 9c7e3d3a..3c8ba10a 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -573,7 +573,7 @@ static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type, const
 		rule = "auditallow";
 		break;
 	case AVRULE_AUDITDENY:
-		rule = "auditdenty";
+		rule = "auditdeny";
 		break;
 	case AVRULE_DONTAUDIT:
 		rule = "dontaudit";
-- 
2.30.2


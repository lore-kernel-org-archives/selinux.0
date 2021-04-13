Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C391C43461
	for <selinux@archiver.kernel.org>; Tue, 13 Apr 2021 12:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F254361242
	for <selinux@archiver.kernel.org>; Tue, 13 Apr 2021 12:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhDMMZk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Apr 2021 08:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhDMMZi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Apr 2021 08:25:38 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2CEC06138D
        for <selinux@vger.kernel.org>; Tue, 13 Apr 2021 05:25:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ba6so19157724edb.1
        for <selinux@vger.kernel.org>; Tue, 13 Apr 2021 05:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lk8g5P7Zm4WeSRSQ1+veQ2B7PE6U664/oG7ijqgJa+8=;
        b=JuANSKwtBgTk5qareIXKn+GH8qTesaxz+MQnT+IntxUWvLsoiZujSReyUF89rK4epv
         mXvaqULpee7+8DDAwo+yCDfCZwCrBCuH+a6FSk3BVq91HtU4K6ERv2htq8rrthTx8JBf
         CGJPkkZlYVf/juU4o8h6TmHazAT8MTbGuOFc5hYkXOBX7XjlgWs0Co4gT7GInmfcdPDZ
         DCFyGrsPtxpB2WcpKfP43KlTYAb7GFuHnZVWgb46Z+XgR/8MbCWQie5qaOBiu32DiI9S
         e30GWJH5h46l6X0Rb2vtczTLL5luKqM5qdy8bf3Bl4vW2T1wgPsVxqW7qluRc9oO9gJg
         ci1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lk8g5P7Zm4WeSRSQ1+veQ2B7PE6U664/oG7ijqgJa+8=;
        b=d0Oz/K15JSQQboqsT5dFg+/b15KcdPi85l/BNnIN78ieko46KiQfrUZfTnVZi8gR/3
         1ntLAHILtLWVYOf3uNqhV8uMEeAaTgwG9XCPHWmjEoBGhLYTB7GRPuKPmF36ZjXSAjTl
         wJUb6Rvak7qoOGD0qsO6z3YhzV86P5DQbb8Ht261VrtM2T7aG9Y3v85GOlcreSL2VMXJ
         cHVy/UqB1WJxRoXD1nsu5uRtyXAgPXIcjaloIsGGcTl11DrJPUwIsDGD4A6NV1CNm/+7
         pyDh/j/VzyJehZ2JQdraXM8elrxfK11EsTaoRmcWKfiaZU45V/KD/T/SToWaotGZh/0X
         2d2g==
X-Gm-Message-State: AOAM531AFZo2bFBAXpDhZSKkDVOid9PQhgtERUBp9GklRhpfOcsBsqL+
        BWIa14SZNfyfx58dCTOqtVYo2bXeK5Q=
X-Google-Smtp-Source: ABdhPJy5q0rnDJBWouef3QU0DW+NDbv8ZEqkDoP580NxNFtOIDegkPraSVu8kyFUiykaGmy20DP+pQ==
X-Received: by 2002:a05:6402:3487:: with SMTP id v7mr34600773edc.302.1618316715622;
        Tue, 13 Apr 2021 05:25:15 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-170-158.77.1.pool.telefonica.de. [77.1.170.158])
        by smtp.gmail.com with ESMTPSA id mp36sm7594438ejc.48.2021.04.13.05.25.15
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 05:25:15 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC SHADOW PATCH 4/7] selinux.c:reset_selinux_file_context(): do not fail in permissive mode
Date:   Tue, 13 Apr 2021 14:25:05 +0200
Message-Id: <20210413122508.24745-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210413122508.24745-1-cgzones@googlemail.com>
References: <20210413122508.24745-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Return 0 on setfscreatecon(3) failure, like set_selinux_file_context().
---
 lib/selinux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/selinux.c b/lib/selinux.c
index e31a5f92..a2ea91c8 100644
--- a/lib/selinux.c
+++ b/lib/selinux.c
@@ -94,7 +94,7 @@ int reset_selinux_file_context (void)
 	}
 	if (selinux_enabled) {
 		if (setfscreatecon_raw (NULL) != 0) {
-			return 1;
+			return security_getenforce () != 0;
 		}
 	}
 	return 0;
-- 
2.31.0


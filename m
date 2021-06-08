Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C55C4743D
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CFB560FEA
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhFHQCi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:02:38 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:37801 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbhFHQCi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:02:38 -0400
Received: by mail-ej1-f51.google.com with SMTP id ce15so33437718ejb.4
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 09:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nD5lJovil9XnGQKRHbSaMqa7v0oI1yzr4hFIaEC2C1o=;
        b=OGrT4NIziwGReDyrC2/wc+tWSHicLkzywfh/DZ3pMaVbXcnyGTZAToTXRowuy6DooV
         RlMSza8SGQmkwsFkvvAXIhKwUozjDUtbtGA8HP6qO8fdY61pmmRkTfC8Aeop7SyKTXYL
         x/5REDwvyLJ0Nz8jSoU3RFB8A1TgXGSyzWor5gW3DNX5yedO57Dhf07TPuxgY3VztLym
         zfikKLxGCiUAaAr3+BCajQKuiCulnKm2V+0cmHdjS6+3/E2FXCoXh78PcCTSDMTdOv6u
         9Rxs7S6Wj5lffErBB80nbRpIs2o2gDRJ2G3bYOD/0uXIttr5dDL21EtzGBHAZlKtHee9
         bdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nD5lJovil9XnGQKRHbSaMqa7v0oI1yzr4hFIaEC2C1o=;
        b=MnYBOJdsmDTjxFNR6dx+c9KoGR3GalPM81wz2tZRpsGsHVbxPDmM++oW4KqJaCeocw
         3SZ6CxHWgFms5kyqtyNnPxLi4KcvPraGFTPBSIoEmePnfnJ5SpZsPO6xUADdKpYMdkqL
         oDY4ZSVEA+9McM1gB6iRbfvfrRl6UDFEdM1zsQD7Pgj7lpmKyA7Zo2isZJuidJHZnZjo
         bSZHNx+VSjOletr5Kz6E7WoUWh8OOc9gxuVD8yL+cD9UZ6V/9UiEjQ0iN7sW1J+g1KVO
         py4al56PkSd4Tnv7uGGyYyHeHNP7JtkbngPTGamaYVclX7owmDd5vCp3lln73OKpMgU+
         hPoQ==
X-Gm-Message-State: AOAM532tNE23B5Vyen1K7sAIoknlwZSTU/UKbQczVAxsqk1zMr1T9Wj8
        hkFTrzwx2ZHMrqjdnlaU6pg9O9yIOQs=
X-Google-Smtp-Source: ABdhPJz6KnhLr3P9NvjoY9q1jroOiP4+Ztpo35ieXJon7Mzn8EU2Ek0ecTYHOMHBt0iiBU3tQ4EjTQ==
X-Received: by 2002:a17:906:998c:: with SMTP id af12mr22974695ejc.510.1623167971559;
        Tue, 08 Jun 2021 08:59:31 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.31
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:31 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 22/23] libsepol: declare file local variable static
Date:   Tue,  8 Jun 2021 17:59:11 +0200
Message-Id: <20210608155912.32047-23-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Clang issues:

    module_to_cil.c:65:7: warning: no previous extern declaration for non-static variable 'out_file' [-Wmissing-variable-declarations]
    FILE *out_file;
          ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/module_to_cil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 73ec7971..1d724b91 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -62,7 +62,7 @@
 #  define UNUSED(x) UNUSED_ ## x
 #endif
 
-FILE *out_file;
+static FILE *out_file;
 
 #define STACK_SIZE 16
 #define DEFAULT_LEVEL "systemlow"
-- 
2.32.0


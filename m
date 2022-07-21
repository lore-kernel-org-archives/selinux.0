Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66383C43334
	for <selinux@archiver.kernel.org>; Thu, 21 Jul 2022 15:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiGUPFb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiGUPF2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Jul 2022 11:05:28 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD9F13CF4
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:05:27 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id z23so3656814eju.8
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hi6jPaXouB/1D7rTQLM7doOPdIZe/Co24uh16MQ4VXc=;
        b=qpRlmBoeIZkGlugIAfB1F4rsVB2z50hr9c+tOmI4L40u7lcCn+u/aI0IOamzheVg7C
         K777pzWrQ/WzHEjxc3/B/0tEKMBdNGVwbFIvY6MT3XZERUEKB+e/yeKwW0bVHykcTER1
         AurlnA2EMdVKDEILPshAdmI46Tun9A4rtzg4Z5IU/gtyRpvSKP4re5xm9B/YKJe08UoL
         JQ82dbhbpRn1KnbcOvLr9+4EjQYE33I2qL/D0djYsMTHeQmGJg3bLOHEN1FTmOSHX2Gw
         hCOk2HmlpdCeRK5NNsanshZ4zC/prn+SUIGKCrDpRB2dgFaooFadpYyzleJLkfZ2VEty
         eyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hi6jPaXouB/1D7rTQLM7doOPdIZe/Co24uh16MQ4VXc=;
        b=DjJ2Wpxop2zJ1yMfDSXCrYilk48ooy2y+bsGVuiNX3p51NNjIgWzQJYvyvEOQXRgEY
         +jiIucslmlWhiZoivvZawX5fQDH8rrpZphVPR1Il2UlbUwrVZQnpTSdaH+aGCCDhi/WV
         grrdZn0Xh/P7rOOdmmgWWpsXpOSRftxXmXp6/o5API9XTAqvHqElGCwLNwlWAtiNBe7U
         5I01iHtM2gUTrAg/1r057AFwfjQ3vtFk1DTSICZvzQrcgzZUPvECEbEFMqLLZHcT72Z1
         jTgIOxR1RlmJKmHPZjxWHl9xMx/dRbGudKLxt/qSLx/M9sODcFl6ecAu0/jCJZZJe15l
         kUog==
X-Gm-Message-State: AJIora8KOJnOl6XRboY2EmqwjrgRsJwtb0mSXBBtE6sg3fB7fx3vc7xZ
        v+OOWya1MegWt6rs8PCGsvQGDQuYsLxKww==
X-Google-Smtp-Source: AGRyM1ssj7BuslFUf1PBAdeRzPBtV3THFM1MG8tbW0Ze1yWEiX3UBWU2KbnQRWqnZgTTbFOdy0k/gQ==
X-Received: by 2002:a17:907:1c11:b0:72f:20:e1ea with SMTP id nc17-20020a1709071c1100b0072f0020e1eamr29646197ejc.427.1658415926781;
        Thu, 21 Jul 2022 08:05:26 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-209-027.77.0.pool.telefonica.de. [77.0.209.27])
        by smtp.gmail.com with ESMTPSA id s7-20020aa7c547000000b0043a1255bc68sm1120992edr.94.2022.07.21.08.05.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:05:26 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 7/8] secilc: run tests against development version of libsepol
Date:   Thu, 21 Jul 2022 17:05:14 +0200
Message-Id: <20220721150515.19843-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721150515.19843-1-cgzones@googlemail.com>
References: <20220721150515.19843-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since secilc is dynamically linked against libsepol do not run tests
against the system version of libsepol to support new features currently
in development.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 secilc/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/secilc/Makefile b/secilc/Makefile
index 94be0481..543df43b 100644
--- a/secilc/Makefile
+++ b/secilc/Makefile
@@ -34,8 +34,8 @@ $(SECILC): $(SECILC_OBJS)
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 test: $(SECILC)
-	./$(SECILC) test/policy.cil
-	./$(SECILC) -c $(POL_VERS) -O -M 1 -f /dev/null -o opt-actual.bin test/opt-input.cil
+	env LD_LIBRARY_PATH="$(DESTDIR)/lib:$(DESTDIR)/usr/lib" ./$(SECILC) test/policy.cil
+	env LD_LIBRARY_PATH="$(DESTDIR)/lib:$(DESTDIR)/usr/lib" ./$(SECILC) -c $(POL_VERS) -O -M 1 -f /dev/null -o opt-actual.bin test/opt-input.cil
 	$(CHECKPOLICY) -b -C -M -o opt-actual.cil opt-actual.bin >/dev/null
 	$(DIFF) test/opt-expected.cil opt-actual.cil
 
-- 
2.36.1


Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC668C7EE24
	for <selinux@archiver.kernel.org>; Fri,  2 Jun 2023 13:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbjFBNGz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Jun 2023 09:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235882AbjFBNGz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Jun 2023 09:06:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9732E1B3
        for <selinux@vger.kernel.org>; Fri,  2 Jun 2023 06:06:52 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96f50e26b8bso310193266b.2
        for <selinux@vger.kernel.org>; Fri, 02 Jun 2023 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685711211; x=1688303211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MG+ffzPl84exiJcw9X4L8znDUy91yk3c2UfIzQJ7opU=;
        b=AyqN+uvnCWN9462X/gwF24jBYaL4bmFxeKOb2FcmuwXp3+d+4rrhTNMph8lpqL+O6V
         FgGDZXH8I3PwVO3URY2eCoQXBD47ucOySB3/LY01ba1H0mkyVSGoosR1KlGKnJjKmQqx
         C278vCYkSSvIVETRwmrAVmYaBPFz0r9+uBsHyD3hVzgTnsPCeTVqm1x7+2ZdaQmLweWk
         VaKjFfWgvHgviHgBV4Mn8cp7QvmsJjQaCrgpBIA246YLRai6nu4BpmKQ+HJ0aP+si/57
         nUeYpMeAe3SGq5P0omQ5d2ar9G0vm8moSnMkD0beo4kAeD80oeYkT0xVo8HMPEoVwkSA
         FcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711211; x=1688303211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MG+ffzPl84exiJcw9X4L8znDUy91yk3c2UfIzQJ7opU=;
        b=C2oX5Y9aCUgp0dVt+BtpaADJc5tElfFZGeVLFATHXZ3fVR2JLty4l9LG77Mn7XcwNb
         Fa37KjZN7fv70tUsCYDyjKCz7lP2xwUw1KI0Ip6/HROrZK0PsVm268exmeRWXpAL3aYp
         JHzhVlRGmdZX0cPxgo4Ts20Z1zGYRIaaXgmNXJLOnpX9J1qssEbc3aGp4f5UwbvUrPUS
         7SjrCOTOCVoizTC0YR4iprX2ViU4bNRQicpkYdMmtIjTN6JWnCo3c0eWL3Xy0dXqSnhX
         TvgatGxCQSSfjHb8N3K2mp94jBe4t/r6d7XOwCirDfhARHOa19mavAz2yomlvjvDL4F7
         GKrg==
X-Gm-Message-State: AC+VfDymX1Cyd2QcoVljM5/n1tUuyyn6fYCTrF3XT5YRiXPmd+jQG2iR
        5NQIJkCd3vlE99+gO8qEMo87cFdVmq+HTA==
X-Google-Smtp-Source: ACHHUZ44U+e5Yt13il03phfw790AfUcLapJET/OJ0vsvmQyxWXAUNRkpVFFUjri3N1nvdcLnUPDMUQ==
X-Received: by 2002:a17:906:6a08:b0:96a:6e42:7123 with SMTP id qw8-20020a1709066a0800b0096a6e427123mr7549999ejc.36.1685711210819;
        Fri, 02 Jun 2023 06:06:50 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-062-107.95.112.pool.telefonica.de. [95.112.62.107])
        by smtp.gmail.com with ESMTPSA id gs20-20020a170906f19400b0096b3f72b1a0sm749546ejb.107.2023.06.02.06.06.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:06:50 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] secilc: consider DESTDIR in tests
Date:   Fri,  2 Jun 2023 15:06:45 +0200
Message-Id: <20230602130646.24835-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the script `env_use_destdir` to preload libsepol from the DESTDIR
location to support development changes like policy version bumps.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 secilc/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/secilc/Makefile b/secilc/Makefile
index 94be0481..5a85df67 100644
--- a/secilc/Makefile
+++ b/secilc/Makefile
@@ -34,9 +34,9 @@ $(SECILC): $(SECILC_OBJS)
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 test: $(SECILC)
-	./$(SECILC) test/policy.cil
-	./$(SECILC) -c $(POL_VERS) -O -M 1 -f /dev/null -o opt-actual.bin test/opt-input.cil
-	$(CHECKPOLICY) -b -C -M -o opt-actual.cil opt-actual.bin >/dev/null
+	../scripts/env_use_destdir ./$(SECILC) test/policy.cil
+	../scripts/env_use_destdir ./$(SECILC) -c $(POL_VERS) -O -M 1 -f /dev/null -o opt-actual.bin test/opt-input.cil
+	../scripts/env_use_destdir $(CHECKPOLICY) -b -C -M -o opt-actual.cil opt-actual.bin >/dev/null
 	$(DIFF) test/opt-expected.cil opt-actual.cil
 
 $(SECIL2CONF): $(SECIL2CONF_OBJS)
-- 
2.40.1


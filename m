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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9839C07E96
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A052A61C44
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhGFR5V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jul 2021 13:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhGFR5V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jul 2021 13:57:21 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4268C061574
        for <selinux@vger.kernel.org>; Tue,  6 Jul 2021 10:54:41 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id hc16so35505100ejc.12
        for <selinux@vger.kernel.org>; Tue, 06 Jul 2021 10:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h2Pt8JnW2D+pveT6afpanrEwrxDiu7/G5JngJ3+BvHA=;
        b=pi9ipwEuO9V7q74twnTt2X+5qVdlXESnSXgef60zBCOxCBzkCmoZD93PPVPBl/x5AW
         k7Z54ssne61ajocmNK26h+rsd1nzLNAetkL0+fENHDwwu1xCkVeDwGwcEE0/IUluCanW
         wNvtOxNLWZa8PN7pSUBObEmcNstWWfiXr+MpA8/jugNdpra17HKb3dGgG4oiP8lvN5rE
         Ofh/W61TA7Ri3E1nmU6SAZ79Hsb3q9L+ToOm0WpomOWdbufW4XP9SpBQQMV8EfJXd417
         YEyt/5DZojj/KkteUNugn/Kf39PErMsHHnasOPzJ9AqjrdNXXuFo3sHOY7RLFmqpb4k8
         9GBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h2Pt8JnW2D+pveT6afpanrEwrxDiu7/G5JngJ3+BvHA=;
        b=lU1eX/2R7SKDNLoQTA7gwkZUbp1oOTeY2Yi+Q6elUokDrjlBKG24kSq0J1/4PdX3Gs
         FHJZ4zws23sgyHBDFknASRI2F/BQ/OKqJ/McQLy0ITKKJfYEG3pR4wgNFOHyOyvtS6JY
         mIF6o2e4iDE11kPrppGYOo0/PJQbY5isDYj8Cp3uBeqZa2Nbg2WspnT0gsrLrZbSZvry
         Y5reM9Fwu7xu5qX0TAxiO1pI2nSrfxiqQpa6udfbEurz0EDed9LwZwKy8MeTUqY5E+V8
         OVzDE5JG/BNa0bLKPiszeRfJAVaeEger5bUANfeWy7ps7TCTc7qrM0a6TchAiVOhuWNV
         GBAw==
X-Gm-Message-State: AOAM530b61srRDYp8j6En2dHI+ydeQWt1wP0A58IIwo2AfcrCNdhzOp6
        GumiWM8hVhXVikUTwI+ShQfvO33Elgo=
X-Google-Smtp-Source: ABdhPJzsXIX1e/XkQTqbcy+uAP6gD/hN/7gVWnrICqFOuJ8aPEXcFf4RLaYcDeMSRZbB6ny3epbLQQ==
X-Received: by 2002:a17:907:728e:: with SMTP id dt14mr19779370ejc.75.1625594080276;
        Tue, 06 Jul 2021 10:54:40 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-100-174.95.116.pool.telefonica.de. [95.116.100.174])
        by smtp.gmail.com with ESMTPSA id lg16sm6050950ejb.69.2021.07.06.10.54.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 10:54:39 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 01/13] checkpolicy: pass CFLAGS at link stage
Date:   Tue,  6 Jul 2021 19:54:21 +0200
Message-Id: <20210706175433.29270-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Pass CFLAGS when invoking CC at link time, it might contain optimization
or sanitizer flags required for linking.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/Makefile      | 4 ++--
 checkpolicy/test/Makefile | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index 0d282ef9..be63c018 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -30,10 +30,10 @@ all:  $(TARGETS)
 	$(MAKE) -C test
 
 checkpolicy: $(CHECKPOLOBJS) $(LIBSEPOLA)
-	$(CC) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
+	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
 
 checkmodule: $(CHECKMODOBJS) $(LIBSEPOLA)
-	$(CC) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
+	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
 
 %.o: %.c 
 	$(CC) $(CFLAGS) -o $@ -c $<
diff --git a/checkpolicy/test/Makefile b/checkpolicy/test/Makefile
index 89e7557c..e2a332b5 100644
--- a/checkpolicy/test/Makefile
+++ b/checkpolicy/test/Makefile
@@ -13,10 +13,10 @@ endif
 all: dispol dismod
 
 dispol: dispol.o $(LIBSEPOLA)
-	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
 
 dismod: dismod.o $(LIBSEPOLA)
-	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
 
 clean:
 	-rm -f dispol dismod *.o 
-- 
2.32.0


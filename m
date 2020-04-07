Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEA4C2D0EC
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 21:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7CB12075E
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 21:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6RIzGSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgDGVCj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:02:39 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54797 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgDGVCj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Apr 2020 17:02:39 -0400
Received: by mail-pj1-f65.google.com with SMTP id np9so263367pjb.4
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2020 14:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h6I8zN/d/xmujFE3HUglqlgdXoJtBRDJCR0QtM2uGfc=;
        b=U6RIzGStUehO6/iJ4XfnmodvRB0k+Sv4h2gmN/E9QZW4Y7zRwb4/pSJ7+l1P3laE4L
         27szeOpH+lmGaYrHVqS7E9M4XyGBiOMw4kBtfW5p16yVXCkFaEOdW5no5SbiGqrWX47h
         QjLW2KE9KsGjcPRgphb3bLKhAJBjNbMHTddZLlAm8ZVtLbNueK6kGl4VpCYbunPke4/U
         TLy0l/+tSj5kspCqGopheN8LFzgVa3bUazW8ycoQuQOjMPsab12S06oV8sw2FgTnY+JB
         YVLMicXpyn2KMsn0qvowHbVwX83cxnkOGOi+FCDRJaWyh+C+WDwX3k0BCCBhQfB0EifQ
         GyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h6I8zN/d/xmujFE3HUglqlgdXoJtBRDJCR0QtM2uGfc=;
        b=CWcgShcTQdF0dqj3+p1RVYYULoXw3G+P15UQ372fRXY04Od8TXDnvl8ON04sfrhlA+
         PpQL9Yr+RzFdNndtpSauUhFyer9JqjYD+hPjZa/7i+dIgOuaMRHKtz343tJLo062M2uX
         q17/LulbqW1q3fYtvKeAP39MS5U5Hdkoo7nXQl7AQqOVhrbU83cE2s0uFi2xvRxBcmZa
         3zh78fgqyplFwaXlD/d2O7jN51f5LJjKslTfg4gll6Ne/nymrQWKi8F1nn102H7MBGUa
         NK+T9lbTK8fOeJfC8nPbEzzY5bnMc0l/I4uhVo2Rthl6Q5Tca3nV+C/CWkE9Swh1bkXb
         JwaQ==
X-Gm-Message-State: AGi0PuZesazNWOHxenzXVseteDN+AhI1KipYQRGJjODwGOtM+RtrZRoB
        XdbskHA92wB2m27MYh0aT5Gibfn5
X-Google-Smtp-Source: APiQypI5hBCte22KMVrGuqzQcccmxUc34cYDXaAjbhxtkQN4BBAvZ/mZiiAWEZ8a4vk8unAgGM/NkQ==
X-Received: by 2002:a17:90a:fb94:: with SMTP id cp20mr1339576pjb.117.1586293358068;
        Tue, 07 Apr 2020 14:02:38 -0700 (PDT)
Received: from localhost.localdomain ([47.149.8.172])
        by smtp.gmail.com with ESMTPSA id y3sm14610871pfy.158.2020.04.07.14.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 14:02:37 -0700 (PDT)
From:   aduskett@gmail.com
To:     selinux@vger.kernel.org
Cc:     Adam Duskett <Aduskett@gmail.com>
Subject: [PATCH v2 1/1] fix building against musl and uClibc libc libraries.
Date:   Tue,  7 Apr 2020 14:02:35 -0700
Message-Id: <20200407210235.3282295-1-aduskett@gmail.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Adam Duskett <Aduskett@gmail.com>

Currently, the src/Makefile provides the FTS_LDLIBS when building against musl
or uClibc. However, this is missing from utils/Makefile, which causes linking
to fail.

Add the FTS_LDLIBS variable to the LDLIBS variable in utils/Makefile to fix
compiling against uClibc and musl.

Signed-off-by: Adam Duskett <Aduskett@gmail.com>
---
Changes v1 -> v2:
  - Updated the patch series to the latest master.

 libselinux/utils/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 36150638..a5632b7c 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -45,7 +45,7 @@ endif
 
 override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
 override LDFLAGS += -L../src
-override LDLIBS += -lselinux
+override LDLIBS += -lselinux $(FTS_LDLIBS)
 PCRE_LDLIBS ?= -lpcre
 
 ifeq ($(ANDROID_HOST),y)
-- 
2.25.2


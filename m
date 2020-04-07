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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7679EC2D0EC
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 18:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFAA20730
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 18:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5sH8G4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgDGSmm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:42:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45538 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgDGSmm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Apr 2020 14:42:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id o26so2122547pgc.12
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2020 11:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UqWlM8XlZnN4aiHNk8g41u7UVsJnBUOpAD1qI9bwrC0=;
        b=d5sH8G4uy4EyT5ksAbDwUPTL843hVjwulbu9gCJiM6ziHvmGZijdL3wwoX5+B4JZ/j
         z/FRLIkJ86wtE0UWLIgHMzl46uE4odfFOy5blLnFrnicAeya+ubmeib32n9zf4dFAyQ3
         /Idh27h7IMeVn8MkrIAs4rw3WYhkf3jDG2aswLr2qCdm84K9ARz0Ec3el3IKZDcEHkAa
         43nAAYFC7kGu7Ujftb7MxFdCrHpgpMBW1CTrMMB7o1TNXyi6BssLFvhytSdHSaKtfv+n
         FQ732StNytJKPjlx2SWjcVTxa9dk4pNFuoQUgHZHfrwmIS87LayYK/c/JmlwiFjprecS
         p0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UqWlM8XlZnN4aiHNk8g41u7UVsJnBUOpAD1qI9bwrC0=;
        b=aTDyr4Z/bmwVNapW9QbH/azfZkO6xtJ8+J8mVkZV25kkb/cFWv59pK3lnOHgv6tiIS
         hSSFJr6DjxFS1kLW4l9Aepw+YGMHu1JuK25aJxgn0xQzh0+tQLayd9HFoSUIMKmR5P5A
         G/2xZ1pAm1NdBrO2HFVwc39q2Vlvs+cGmYby2jSrBPCxA6K9YVzTJbiBSgd5frdjd4/u
         kYkovaVCkVHXN+FnxyrP4FNKYXGnw1hSY37E8pdNFAClYFbSv5LGWt3lTL9QITqn9OHB
         aN476eJZVt8jFFqYOGKjrV+D28AVsVhsxvFUs3VJFJIS8vX76Rnmw4TUPZ4baZiaGKna
         RCAQ==
X-Gm-Message-State: AGi0PuZ0KtndnzZH7k0LXNA0ou5gYm7t8J4jBvG9leFMEI0j2RFz8eJ6
        iOphkUVOZIDELC/77+JBuWaZifw0
X-Google-Smtp-Source: APiQypIHg4yvzH1Ij8h63jNCl7Im0fTchI+7ILr2VGYpEez6Kb6wE3prVTAxjecpLfrDkCEwVDpHGw==
X-Received: by 2002:aa7:9150:: with SMTP id 16mr4033349pfi.209.1586284961609;
        Tue, 07 Apr 2020 11:42:41 -0700 (PDT)
Received: from localhost.localdomain ([47.149.8.172])
        by smtp.gmail.com with ESMTPSA id h10sm13950560pgf.23.2020.04.07.11.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 11:42:41 -0700 (PDT)
From:   aduskett@gmail.com
To:     selinux@vger.kernel.org
Cc:     Adam Duskett <Aduskett@gmail.com>
Subject: [PATCH 1/1] fix building against musl and uClibc libc libraries.
Date:   Tue,  7 Apr 2020 11:42:39 -0700
Message-Id: <20200407184239.2700998-1-aduskett@gmail.com>
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
2.25.1


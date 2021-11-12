Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA581C433F5
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D6860296
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbhKLPpB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Nov 2021 10:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbhKLPpB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Nov 2021 10:45:01 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1202AC061767
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:10 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b15so39080932edd.7
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YFhXaHULBOuwz63rW/5RrcMDt/edsv5vTFRaH+MB818=;
        b=idkKkEub23Z2zN/nSY33b/TaQzZKHbgjwY7AOt3kd1AeCC8mEI37JpdW8rTkVh1CNI
         /9LXhn5QkYQm4RgG3znB5c5xPT/D2xb6ayzpfwQp0YnJX1CBJD1TYOg6BN3UN4v9XLef
         XtBQRznJkWCK0ZVj8QAHyXWj9EckJ0/NMBXROF7T+6ix3c6qyls3pTWVcoxsz/j4tpbB
         pVbim/A3P7Ev3VT2jys+6H2RrjsvPzntkx0p0w3ZfMRnOr1Llmq5+PV13fNIUc6IZqWy
         o7ZCGUUiYJBic3/V6cE+3AJXLZTowfZEnYSW8uf6vRlsDUJhfvhMtaeDPGyZl1uJTtZV
         XweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YFhXaHULBOuwz63rW/5RrcMDt/edsv5vTFRaH+MB818=;
        b=x1vg1kSne3Xke6s61XYpFDmOpMjOHxb1fJeEDXIhqZBK+DBN3FCAlINi4lU4k6mG1x
         gX6+9G/Me1knB7oOs16KvRkF0JMdQ4EUT01ZfVsn9pkLZAU8WXTr4hwa52F8t4wo8goE
         +UrFGfriXEFUNRpWbfmjLQU/z+6bFbo0ukWc7ppgurvb7y7rHcf94gGm5N1BVyzQauLc
         271t7JhGGAMy7vBPlryVF3UoaiDK/5WBac8PyAvNRfYyW08nsKTMuEMzSu/6LlWUO3gf
         phSpOdqODW732hE+GBRBbs6TgpR0OHJLZmccfUrq40EMuNhZiXgAbVzB1SKWd3UoRX5a
         yzPQ==
X-Gm-Message-State: AOAM530Uh+QpXyc1SJoxbqZUOpj2rpvIJK9kRlLgoS0S7f2hlhBDrgwt
        9KkhF+m1SUihm8ztktjHzGpRLbT433E=
X-Google-Smtp-Source: ABdhPJzf01peZPVZMyTnwqsFJQpJnI25k1BxZ0/NlDspHD+CmhDtHTayZVYtuBRG/vcKkZokBK4tAw==
X-Received: by 2002:a05:6402:354f:: with SMTP id f15mr22886054edd.390.1636731728515;
        Fri, 12 Nov 2021 07:42:08 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-195-130.77.0.pool.telefonica.de. [77.0.195.130])
        by smtp.gmail.com with ESMTPSA id m9sm2628914eje.102.2021.11.12.07.42.07
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:42:08 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 04/12] Enable extra global compiler warnings
Date:   Fri, 12 Nov 2021 16:41:53 +0100
Message-Id: <20211112154201.78217-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112154201.78217-1-cgzones@googlemail.com>
References: <20211112154201.78217-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Enable some extra compiler warnings in the global Makefile. These are
supported by GCC and Clang. The global Makefile is almost solely used by
developers and the CI, so the interaction with the preexisting -Werror
flag is desirable.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 298cd2b7..215e313e 100644
--- a/Makefile
+++ b/Makefile
@@ -9,8 +9,12 @@ ifeq ($(DEBUG),1)
 	export LDFLAGS = -g
 else
 	export CFLAGS ?= -O2 -Werror -Wall -Wextra \
+		-Wfloat-equal \
+		-Wformat=2 \
+		-Winit-self \
 		-Wmissing-format-attribute \
 		-Wmissing-noreturn \
+		-Wnull-dereference \
 		-Wpointer-arith \
 		-Wshadow \
 		-Wstrict-prototypes \
-- 
2.33.1


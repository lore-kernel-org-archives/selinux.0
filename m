Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A87C4332F
	for <selinux@archiver.kernel.org>; Thu, 31 Mar 2022 14:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiCaOtw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Mar 2022 10:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbiCaOtv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Mar 2022 10:49:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824EB21FF4B
        for <selinux@vger.kernel.org>; Thu, 31 Mar 2022 07:48:04 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g22so17364655edz.2
        for <selinux@vger.kernel.org>; Thu, 31 Mar 2022 07:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=i0cgS0FbDn4/xdmDmKmJ0vA5phS4qMhOq2NbGUueCr4=;
        b=ArfoErsH5cIZDugxQa0MYuVN6kIqF4bRnq4/lNKncTouFdsp/5BEeNSXlFSbfm6yf7
         7x/Mdzk4D4TMb3/SC7bX0umIfgkGJDNGKcYue3SPgCRlvUEl4cu4WEhpZZ0icJ7efFqZ
         3A8/MnAmxV7pCnNABop1cqMRlblLLHhDWh4etUyi6o7QK7/8ETVX46oGZUnogidfb125
         /8TwSrQrXGfewYMztkAial0IENuq9H3+R1d3N4B2xiPVap9pe4btSItTMtG+4qI2Rvb+
         b273jKJpWtAqCnzfa0djls8e+JuYAxL+XWWQ8i6wZoC1kIriefKofyKGUKSFLPNBJfMp
         +2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i0cgS0FbDn4/xdmDmKmJ0vA5phS4qMhOq2NbGUueCr4=;
        b=qV+kWpTKvTbwYdyWadB3vfyUecXpJFZDiEKb6hGjEhb3FHFrWPMZkQLrdQHmAsFIK1
         apfiLHQ+jbMPKgDDqDFyU2hWu3j1ZIyE4DBhx/znbrYu4MJcuwFL3jN7UmKypHaRfXfR
         7NS7Cpw5mTub6tU45ruunWL3OaOtik/Y/oto4dP06GxtstKrMPg11sWlkVazFrxdq3MV
         fi85rH0VRQZyDjincIK8xblrD/4Bcrjm27WH0TfcyRKjS2wSB2EXO5FUMXMfFxWVoetk
         selvoAZFwaXpXhwncZb7QgqdUYZDuKKxArd5zEd97rGxQ95aOKihswIy7DsdVUVh1xuZ
         +kuw==
X-Gm-Message-State: AOAM533he1Fp58tz1yh2u8w83oBx5tIJL/YEppo/YDOX8qqsVy9qtRjj
        XDX9qdSxsQNFmPu18kH0cPqDzJMaWkk=
X-Google-Smtp-Source: ABdhPJxo7ZzMf3LUiFLcj22JlUWOTNcO+9d7KhcZp+FMtO1rtvHr5hA3Kl7FljCcWEmMQL2aOT/SoA==
X-Received: by 2002:aa7:c3ce:0:b0:41b:679c:adc3 with SMTP id l14-20020aa7c3ce000000b0041b679cadc3mr8713868edr.344.1648738082996;
        Thu, 31 Mar 2022 07:48:02 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-006-065-043.77.6.pool.telefonica.de. [77.6.65.43])
        by smtp.gmail.com with ESMTPSA id r3-20020aa7cb83000000b0041b573e2654sm3163368edt.94.2022.03.31.07.48.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 07:48:02 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 4/4] Enable missing prototypes
Date:   Thu, 31 Mar 2022 16:47:52 +0200
Message-Id: <20220331144752.31495-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331144752.31495-1-cgzones@googlemail.com>
References: <20220331144752.31495-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check for missing prototypes like file local functions not declared
static or external functions not being declared to avoid declaration/
definition desynchronizations.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 215e313e..2ffba8e9 100644
--- a/Makefile
+++ b/Makefile
@@ -14,6 +14,7 @@ else
 		-Winit-self \
 		-Wmissing-format-attribute \
 		-Wmissing-noreturn \
+		-Wmissing-prototypes \
 		-Wnull-dereference \
 		-Wpointer-arith \
 		-Wshadow \
-- 
2.35.1


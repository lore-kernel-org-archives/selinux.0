Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6040DC433FE
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4818960273
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbhKLPpF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Nov 2021 10:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbhKLPpF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Nov 2021 10:45:05 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079BAC061766
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:14 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id w1so39406459edd.10
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2seubjY8734BEV72WueGd6LV/9Ai9sYr/7KGlo9eHE8=;
        b=SISBNaKgH94ZtB0vKyie5E7v6t3r2hhLhlmZijSBscvE0+x1vmJEE10NDLwkRvyI+K
         NKb/0Qiv8chMxr6LnFmBjHZem1Zee6d7gUepUNpJQSNrJR3vkEqPpJEl3MW74znjilL3
         ddmdNRc1z/SwX61JEVI59Kg5pA+UwgsqtQD9x8UCSw24TicoVjYCRl/PSDnh2+O5tbY9
         XOdrV9eqgy+AXDusAdVMcyJdKTaZ0EAR17/wd8KZInKItRr9rhDHab+hH24LyeeXEs1Y
         ilBaAyl9MHr+wBXrT23+ZfpbS0Nbu0052hodNUXl7WTLl4C0FcSriH1uHoG9oi+GclwN
         x1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2seubjY8734BEV72WueGd6LV/9Ai9sYr/7KGlo9eHE8=;
        b=ayxQ05tOE8t6uXjh32c3VPtkmj+0TejigNGWGNfHMoxYt2L4h2YpMTHeVY0l4JDD4V
         B8iTWcgdVvNy1IaZqSJcWE3XuIlBA60rP7RsYiSmc/SVJgeBwxmIDGZFz+8XFbjhicYO
         YCmFSxJz/3yI2OT+nNjeqy/y1JsAJUKC69lYiYMEtnbTB6cKOpnpIPlpn/ttRqQ4cGli
         vLJ5mey2PCzlQRNANU+TW//zhEE5bdWwEiMdyTywh9WshgkAPnzLjVyyMsZg/ZJJq5xW
         juGBozs4VMa3T8nXhbZC6WI3IESmfBhS+tse7QTmEVPQ03MCcOhg9UbmtAMrrDJLP6fg
         WGeA==
X-Gm-Message-State: AOAM5313D0VETia+R9QiUem05yVu3wF/DKqA6hOyyaY3MkYmZxwbW6W2
        ccBoaGLVPhGesPwPmtkumtkPJ+hWbPM=
X-Google-Smtp-Source: ABdhPJy3GwEkbKKejNQh28iO71HoApVozNBWsqRTa4pbuGHCCjmiwW16hIO3JFCixTv2qTtSiyXWqQ==
X-Received: by 2002:a17:906:d196:: with SMTP id c22mr20204620ejz.231.1636731732538;
        Fri, 12 Nov 2021 07:42:12 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-195-130.77.0.pool.telefonica.de. [77.0.195.130])
        by smtp.gmail.com with ESMTPSA id m9sm2628914eje.102.2021.11.12.07.42.12
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:42:12 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 11/12] libsemanage: include paired header for prototypes
Date:   Fri, 12 Nov 2021 16:42:00 +0100
Message-Id: <20211112154201.78217-11-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112154201.78217-1-cgzones@googlemail.com>
References: <20211112154201.78217-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    context_record.c:11:13: warning: no previous prototype for ‘semanage_context_get_user’ [-Wmissing-prototypes]
       11 | const char *semanage_context_get_user(const semanage_context_t * con)
          |             ^~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/context_record.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsemanage/src/context_record.c b/libsemanage/src/context_record.c
index 16ba518e..dafb90fc 100644
--- a/libsemanage/src/context_record.c
+++ b/libsemanage/src/context_record.c
@@ -7,6 +7,8 @@ typedef sepol_context_t semanage_context_t;
 
 #define _SEMANAGE_CONTEXT_DEFINED_
 
+#include <semanage/context_record.h>
+
 /* User */
 const char *semanage_context_get_user(const semanage_context_t * con)
 {
-- 
2.33.1


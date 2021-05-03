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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE213C433B4
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 976B461244
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhECRzA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhECRyz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC87C061343
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:53:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d14so7284195edc.12
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MFtCCqwgvbVttNpGX4eKRO2mNR7gMa014+Tni4SwScw=;
        b=QMt+Z/JxMqFg28fLE5YGnw6rABSgErAinBWelaYbYbD6LN6jPkKqy3NzKqkpsPs90R
         Hz02A2mCiBt6ieck6QNn6tBFoA9Vc2oYKUBESNWepGc4IQ6YCwBpx9qbajpJ5DcfZmUb
         ElHbxuquD3IQpntXuV5mNs+UCy85qBPFZuMdfvy8ucdNAngOD3XXBBOIRyvqfmDv+YK1
         0W7nycKjsDCw6ilmicHiXDIx5Cyx5NrNUydJYG0lB0O5kK3HGF5mvZ71zdhJzNSE3IXP
         Dq6xHerqJ4Y6Bt2pmJqN/Lx+yAUNrfEKvxdhGA88r6/Hlt1luRUnOJACpEhBcoEStkhG
         PuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MFtCCqwgvbVttNpGX4eKRO2mNR7gMa014+Tni4SwScw=;
        b=dFMhmbqEO27ERrPPWeLE6Vi9iI3EPLKZDW7V/O7Ab6wCD7blUwcNn3IzKwJPII4Pet
         BuWazPrHRBooFk3+9MV3qFadmLLdmd8xlPSSgULJe5MR94qyLfhNS9LLpgMqk71exVVa
         oQ6t2CeJELns8EV7yNIi+vcEsNFT3l4PVDUSBhw0RWrmBiPsLjXZa66OwLM/oy61A7Ti
         Rk5s3j4kgIhWl/ycLwVL4csrOBzTLqjNYcomzzsMImTbiTvDLlu4I1L6CzleVhG/lCHZ
         KCuS5l4MagPjJeb8g4DgpMSBRGdL9PRi9d3N68kzoJVX2OzauG+y7fcy7c0tu1ssHXR6
         y28A==
X-Gm-Message-State: AOAM530wyvP/aqJ898B6hgO44SV2j84IfalwZpcoJ8tTBCT8wDgYT0ds
        Ygo58KSCgZx2PopffzMzLD7Soz8zCv/mxQ==
X-Google-Smtp-Source: ABdhPJzBQQiIW8mrPJnoJkHOFi112pg7QkGfRLQKX1E5fuRlhidvL+v5Cias6GsGQ6C/l+NTbsUQdw==
X-Received: by 2002:aa7:c495:: with SMTP id m21mr8393629edq.123.1620064438454;
        Mon, 03 May 2021 10:53:58 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.53.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:53:58 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 09/25] libselinux: getconlist: free memory on multiple level arguments
Date:   Mon,  3 May 2021 19:53:34 +0200
Message-Id: <20210503175350.55954-10-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not leak memory if the program argument `l` got passed more than
once.

Found by clang-analyzer.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/getconlist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libselinux/utils/getconlist.c b/libselinux/utils/getconlist.c
index 76654b75..0bb28469 100644
--- a/libselinux/utils/getconlist.c
+++ b/libselinux/utils/getconlist.c
@@ -26,6 +26,7 @@ int main(int argc, char **argv)
 	while ((opt = getopt(argc, argv, "l:")) > 0) {
 		switch (opt) {
 		case 'l':
+			free(level);
 			level = strdup(optarg);
 			if (!level) {
 				fprintf(stderr, "memory allocation failure: %d(%s)\n",
-- 
2.31.1


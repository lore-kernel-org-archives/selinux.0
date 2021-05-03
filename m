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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E174C433ED
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682586121D
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhECRyv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhECRyu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:50 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596D8C06138B
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:53:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id n25so7317960edr.5
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=i+AX9Fkiq+kBYkU8B5ajVJ41iLmCTWfcP89Zz6lYb0o=;
        b=rSIU8dNmNdl1HxEW3+9wlImh8q2s/twx7zaFO8udPt8XGRe2CkzC3BuVDijGIpQHog
         OZGC00vmMYQbz9LaW1dP/qOmOlcNPDbaOF1SwiMxnBNYyKaDFTtpz+GVhJECzPohe2nV
         eBHU1mlEHkxvcKXGztIkqGfEgbLqqB4+PkvsGnpftTf2ylLyHnbcu9LvFfwtnavYaFHc
         zyf084w0YwlOVLv2l8C7uuXEM3ixAaP9ovsIj/Kvw2+YMuErLFSZdJSHSkOw18520GYV
         16/uzOYxctM6aFvz/z0ReEvKg2a1l/7px8Pe3x+vmmRKtJhOqsQUau+kF10WTL7eGcQ4
         acsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i+AX9Fkiq+kBYkU8B5ajVJ41iLmCTWfcP89Zz6lYb0o=;
        b=D+7Mp3u0NpHln7jBydRNnNwXrVc9sCmrv75yDqcbelKqvWc2jkGJymOdVRjZhJzNx5
         51Dse/51EnyzR6gkEht5Sno1fWVKIe1UC0ywb6s01TK2Zd2GoxRswICDgSLnlQ2wHpTX
         r7skTrLF73TZOABzcnrPV9eAVCfnK66ASGquvwbkjD5Wc/9SDx7vwSW+ge9Bw4Cp1dmi
         /cNRN4LjHeB1ff3v1C6Ko/r5EFkPijhxJIhR7yUBR6E4JG0jSSSKEo0597FVKH35qIL2
         wsMYIUVj1elQySKyADU8/ewkMIxnWUc/SI+LwZfByiOzoJLGffW23GwSJ4lBsFi4OkYt
         2qdA==
X-Gm-Message-State: AOAM531OjLDkn3/DPk4fargX0dJA8pwonGkDFKiLU4yjDuR+wcaEOjAY
        BwmmuABNu+rbUELfAhJZxRlR88dU1NDf9w==
X-Google-Smtp-Source: ABdhPJzm4wdAfeQ5BW4enHuIP0wJEd1kp612s+O7yggmKtQZu2Uawc7TqaVAwyQ5m4SUcL8dT5gDrw==
X-Received: by 2002:a05:6402:8d3:: with SMTP id d19mr21273907edz.302.1620064436128;
        Mon, 03 May 2021 10:53:56 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.53.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:53:55 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 01/25] libselinux: sidtab_hash(): do not discard const qualifier
Date:   Mon,  3 May 2021 19:53:26 +0200
Message-Id: <20210503175350.55954-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not discard the const qualifier of the function argument, and drop
the redundant local variable `keyp`.

avc_sidtab.c: In function ‘sidtab_hash’:
avc_sidtab.c:23:9: warning: cast discards ‘const’ qualifier from pointer target type [-Wcast-qual]
   23 |  keyp = (char *)key;
      |         ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/avc_sidtab.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/avc_sidtab.c b/libselinux/src/avc_sidtab.c
index 9669264d..8dc87560 100644
--- a/libselinux/src/avc_sidtab.c
+++ b/libselinux/src/avc_sidtab.c
@@ -15,14 +15,13 @@
 
 static inline unsigned sidtab_hash(const char * key)
 {
-	char *p, *keyp;
+	const char *p;
 	unsigned int size;
 	unsigned int val;
 
 	val = 0;
-	keyp = (char *)key;
-	size = strlen(keyp);
-	for (p = keyp; (unsigned int)(p - keyp) < size; p++)
+	size = strlen(key);
+	for (p = key; (unsigned int)(p - key) < size; p++)
 		val =
 		    (val << 4 | (val >> (8 * sizeof(unsigned int) - 4))) ^ (*p);
 	return val & (SIDTAB_SIZE - 1);
-- 
2.31.1


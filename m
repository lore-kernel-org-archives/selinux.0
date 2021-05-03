Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA59C43460
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1751F61244
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhECRzD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhECRy5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9BAC061347
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:54:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j28so7295333edy.9
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YJonApMKNzdL/cbI0eBHeOHnjKGop1qXt55KgjZnRuk=;
        b=bE6ha8XeSYcCdNnIoT28T7LKD54kUUIudZrH/nHywKMJQSsEveLUPx9yGfN7xiT3Xm
         pD3lvN3cpZriyY5SY6ROAOO9dx+oe8qEsu9bR1nMgWW1O4yleSq8lyxbyZ2fv1cD+mmc
         +czfbtWnHT1ZkhTAGhgn3kq0Qr5bgQmI1FQNZOz6I22JrmSFIrbXQExm1DgUVa5Y92e4
         vPQD6OpXpndPvkOO+1ThjEJ+RZPs58BBnf2h0BfpotpSOYcJ/mo/lSO7XyHHiA5MM6jf
         eue1TnBmjW5EknjTK67GD5qpxAvyoSZ82pRn7s1fq85RlB643GOb4l1Z30QTuw2DA8uv
         1Rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJonApMKNzdL/cbI0eBHeOHnjKGop1qXt55KgjZnRuk=;
        b=rrGIlxx9voLREsyB0W1IlA/SnKd4Ejn86utMIPDh5iENpOkwviR1S2lG57gVzHhCHw
         90KikhSmM2ar0o7XrnzNRkcwP1dfkjXd4iNF3Bv+dH2s8rWCHSgStg0GdUPAoiOUspA0
         WmGw9ilXe8/NmIP1bXlbp9CEhvkZnij1N6PuiYKoPJ/6U2azqXFxpHnIl3A0hZU7jy/E
         J3IWUWeNtyQxAb08PGffl3ngyNvEANLnY0U0e4BbCO6pSL+kke9Am7YaYLz/6Iwuslg5
         bfhzSefFYFDnvea/M/5J4SNIw+mVibUzMdOLpQwb55nsvZGfOYSRLeWCO3iTv2Hn5BuZ
         vMBA==
X-Gm-Message-State: AOAM5306YZWUYzwDbfFUCyxVXYGek+ztzw1gtU+8gyEGwvJF6PiPxcIF
        Hk407sUt9AMEfGSrqXRZExyc4y6CLAELbw==
X-Google-Smtp-Source: ABdhPJwO+5Iwkr0xtZwImySFdT+T7vzQKi+qvDV/tmhRhBM6Du3aXRPBbuZgbkMA2SjwSb34l/LdUQ==
X-Received: by 2002:aa7:c4d0:: with SMTP id p16mr22097203edr.102.1620064440538;
        Mon, 03 May 2021 10:54:00 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.54.00
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:54:00 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 16/25] libselinux: store_stem(): do not free possible non-heap object
Date:   Mon,  3 May 2021 19:53:41 +0200
Message-Id: <20210503175350.55954-17-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

GCC 11 complains:

In file included from label_file.c:24:
In function ‘store_stem’,
    inlined from ‘load_mmap’ at label_file.c:277:12,
    inlined from ‘process_file’ at label_file.c:551:5:
label_file.h:289:25: error: ‘free’ called on pointer ‘*mmap_area.next_addr’ with nonzero offset 4 [-Werror=free-nonheap-object]
  289 |                         free(buf);
      |                         ^~~~~~~~~

Free the pointer on failure at the caller instead of inside `store_stem()`.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_file.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index baed3341..9f633701 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -286,7 +286,6 @@ static inline int store_stem(struct saved_data *data, char *buf, int stem_len)
 		tmp_arr = realloc(data->stem_arr,
 				  sizeof(*tmp_arr) * alloc_stems);
 		if (!tmp_arr) {
-			free(buf);
 			return -1;
 		}
 		data->alloc_stems = alloc_stems;
@@ -308,6 +307,7 @@ static inline int find_stem_from_spec(struct saved_data *data, const char *buf)
 	int stem_len = get_stem_from_spec(buf);
 	int stemid;
 	char *stem;
+	int r;
 
 	if (!stem_len)
 		return -1;
@@ -321,7 +321,11 @@ static inline int find_stem_from_spec(struct saved_data *data, const char *buf)
 	if (!stem)
 		return -1;
 
-	return store_stem(data, stem, stem_len);
+	r = store_stem(data, stem, stem_len);
+	if (r < 0)
+		free(stem);
+
+	return r;
 }
 
 /* This will always check for buffer over-runs and either read the next entry
-- 
2.31.1


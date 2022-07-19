Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AC7C43334
	for <selinux@archiver.kernel.org>; Tue, 19 Jul 2022 15:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiGSPbL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbiGSPbI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Jul 2022 11:31:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AAE237E1
        for <selinux@vger.kernel.org>; Tue, 19 Jul 2022 08:31:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y8so20128209eda.3
        for <selinux@vger.kernel.org>; Tue, 19 Jul 2022 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xCtNwp6k/KqLKgW3B8b22oqNaVxmuyDq1r807l0Ud9I=;
        b=fq9hvniqeGey9Npr3ae6ymO1dzfWDQCTvngVQq16MhChocC51GGvDD0aLL5cCKwwI2
         R/GBg3UcRgzpMzUM79tWtzykMXoKAFgm9tJGiXpYJzqcF89KdkAAqZRxhsJu7/YGSURP
         /4lzLgAOg01fdgkyZ8VyK87mKHqdHoxco2iHtFQELMWIRNuDh3zJmY6VqZ/Xa8jLjAqf
         b7KAJlkbWhd0C2e1eyEUCO3w2WC1WiLa/zZWFA9UpX+w6xlG3NqEVrJRppQfrbM+LCZd
         6ToIqIyTNIB0RPC975o6t95RZ8lTII2KH/dgnKswpS1q6o38AkYdJeZvCPUvOB+tkxWb
         CZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xCtNwp6k/KqLKgW3B8b22oqNaVxmuyDq1r807l0Ud9I=;
        b=1Vuh4CPxqzODdvFw5DWFEcmK2Oz5x2q6b7PbFnvLnto1/oLjDWNB057LZp7vBjJvYn
         Gp4TdQCjI+5SPdjG1y+qbVrTxN4w6SzAYrxMvE6O1lAZ93BkhuNW/Qyo39Ea/0lkXlJq
         l/p07SRf3q/nz9aWx5sEuHdxNkk2gA73uD8UkkcjXa9xhtYSJKyN2OebH14t7ghReDXz
         qruI/eQKwM3GjiI9CJKQW7PLkaOIDlzuRGidMPfyXvgL7UgmfO1xjNGmQ7q5AtVgtlKt
         M3RUbImswzsJb76657t/GceFrVqwBrv7jrdgnmiyqdkaXtRzx3g5HuVUlbe9iwHncthr
         Di3w==
X-Gm-Message-State: AJIora8wl+JuaIyVOy9UyeojI1oPyFAr8BrKxTRuyjFYh7V/Mxq+HyL0
        ScTj3/n3j8H4T0Fam1+14gWUjRZtlMHzHw==
X-Google-Smtp-Source: AGRyM1s5I/JD2o+wZLxRSje/vvNjMWxzBfZhaJS4rU6axnyX+eVL8B61/6nrD77e9BMDQGiQhtrUOA==
X-Received: by 2002:a05:6402:440f:b0:435:2e63:aca9 with SMTP id y15-20020a056402440f00b004352e63aca9mr43623890eda.162.1658244666344;
        Tue, 19 Jul 2022 08:31:06 -0700 (PDT)
Received: from dlaptop.localdomain (dynamic-077-001-147-221.77.1.pool.telefonica.de. [77.1.147.221])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906311b00b0072b7b317aadsm6809621ejx.150.2022.07.19.08.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:31:06 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 6/7] libsepol: optimize ebitmap_xor
Date:   Tue, 19 Jul 2022 17:30:43 +0200
Message-Id: <20220719153045.70041-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220719153045.70041-1-cgzones@googlemail.com>
References: <20220719153045.70041-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Iterate on nodes instead of single bits to save node resolution for each
single bit.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/ebitmap.c | 49 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index 6dbbddfd..7d26f949 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -117,14 +117,51 @@ int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2)
 
 int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2)
 {
-	unsigned int i, length = max(ebitmap_length(e1), ebitmap_length(e2));
+	const ebitmap_node_t *n1, *n2;
+	ebitmap_node_t *new, *prev = NULL;
+	uint32_t startbit;
+	MAPTYPE map;
+
 	ebitmap_init(dst);
-	for (i=0; i < length; i++) {
-		int val = ebitmap_get_bit(e1, i) ^ ebitmap_get_bit(e2, i);
-		int rc = ebitmap_set_bit(dst, i, val);
-		if (rc < 0)
-			return rc;
+
+	n1 = e1->node;
+	n2 = e2->node;
+	while (n1 || n2) {
+		if (n1 && n2 && n1->startbit == n2->startbit) {
+			startbit = n1->startbit;
+			map = n1->map ^ n2->map;
+			n1 = n1->next;
+			n2 = n2->next;
+		} else if (!n2 || (n1 && n1->startbit < n2->startbit)) {
+			startbit = n1->startbit;
+			map = n1->map;
+			n1 = n1->next;
+		} else {
+			startbit = n2->startbit;
+			map = n2->map;
+			n2 = n2->next;
+		}
+
+		if (map != 0) {
+			new = malloc(sizeof(ebitmap_node_t));
+			if (!new) {
+				ebitmap_destroy(dst);
+				return -ENOMEM;
+			}
+			new->startbit = startbit;
+			new->map = map;
+			new->next = NULL;
+			if (prev)
+				prev->next = new;
+			else
+				dst->node = new;
+			prev = new;
+		}
 	}
+
+	if (prev)
+		dst->highbit = prev->startbit + MAPSIZE;
+
 	return 0;
 }
 
-- 
2.36.1


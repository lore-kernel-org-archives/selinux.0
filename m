Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FFFC433EF
	for <selinux@archiver.kernel.org>; Tue, 19 Jul 2022 15:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbiGSPbK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiGSPbH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Jul 2022 11:31:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4046658868
        for <selinux@vger.kernel.org>; Tue, 19 Jul 2022 08:31:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id b11so27837777eju.10
        for <selinux@vger.kernel.org>; Tue, 19 Jul 2022 08:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Oi1SP+HLX1gKBYbPAvOxTHVFnYtctn7wi4GBcEPx2A=;
        b=oJ42SaqOM19KAziV4LKgd3p8TJeO5gmU3OKGQ6wK+9+xx8qtJhexJcjjF5MF20PG3T
         MK4q2OaXSOvYpi+EyugPLJXPk+OVp6hX7BVctXvOf768RErF2ENgXvn1MDyThzmw3ICu
         E+OFT6tSDZx2lUO5Xsgp+512E2kRVZuoMFqPi1LPlYazj+DSqXsE9Ib5DonlPy0Qi8fx
         pg9jmYaRwgfdehJJetac3OgUNeokhkLjJcYHiCvaW1eYWd0OjK4z2CqZax0sXARKsD6g
         ExFikzSpXhcG2bx8hhfVJ++PEkLToo63sfTu+pZqoydcOC6XDQNYMbSIugFk/2m43ZB0
         pkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Oi1SP+HLX1gKBYbPAvOxTHVFnYtctn7wi4GBcEPx2A=;
        b=fmPGKzr4jlAZ4BlrXLuPkvRfFPaauA9p103EYJzNTPNur4w9bId5Bb6RhRtIyLqPod
         rTnlxX9pFbFjJYHgThWW6Ikf3xQoFHmHeed44sfoqOec3JadCEvkm4t416YwoidVU0v0
         71QgB+95OwK6spTe9zPx+/K4ZVXO3Ol+JACQ+0IlbFPlloZ4XvRU1Seq5mqgQtq7Apfl
         1eOqSK9ojxEBxxf9DdqWwSrEz0fABUHyM/RcoOY8PtHg3Sb6YvhBmNKWoJPM3AHnPBL9
         sVTPjybnKwG3+lyhSvKi2tFqgB9kRgs5lof6QId8cfX9Dy5f9qJapV4Jc3J8ecrFnUAV
         SEKg==
X-Gm-Message-State: AJIora+KHqjVdVoszr7Gegru3MH16uNclJffTkzFRB2BXhy48NZSBnZI
        uoRUvLtBGRe4ZvxW2OLMdqSCFebFQoA6pw==
X-Google-Smtp-Source: AGRyM1uX13vyp7BQUkYahrPnGPs4L8vj9apruheSug9tew/0z+6O8GwlYipBjXd2XUvQUsUBvZHAYg==
X-Received: by 2002:a17:907:a40b:b0:72b:64e3:4c5e with SMTP id sg11-20020a170907a40b00b0072b64e34c5emr32026633ejc.612.1658244664803;
        Tue, 19 Jul 2022 08:31:04 -0700 (PDT)
Received: from dlaptop.localdomain (dynamic-077-001-147-221.77.1.pool.telefonica.de. [77.1.147.221])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906311b00b0072b7b317aadsm6809621ejx.150.2022.07.19.08.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:31:04 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 4/7] libsepol: optimize ebitmap_not
Date:   Tue, 19 Jul 2022 17:30:41 +0200
Message-Id: <20220719153045.70041-4-cgzones@googlemail.com>
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
 libsepol/src/ebitmap.c | 48 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index 0f9afd62..c9164c5e 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -101,14 +101,50 @@ int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2)
 
 int ebitmap_not(ebitmap_t *dst, const ebitmap_t *e1, unsigned int maxbit)
 {
-	unsigned int i;
+	const ebitmap_node_t *n;
+	ebitmap_node_t *new, *prev = NULL;
+	uint32_t startbit, cur_startbit;
+	MAPTYPE map;
+
 	ebitmap_init(dst);
-	for (i=0; i < maxbit; i++) {
-		int val = ebitmap_get_bit(e1, i);
-		int rc = ebitmap_set_bit(dst, i, !val);
-		if (rc < 0)
-			return rc;
+
+	n = e1->node;
+	for (cur_startbit = 0; cur_startbit < maxbit; cur_startbit += MAPSIZE) {
+		if (n && n->startbit == cur_startbit) {
+			startbit = n->startbit;
+			map = ~n->map;
+
+			n = n->next;
+		} else {
+			startbit = cur_startbit;
+			map = ~((MAPTYPE) 0);
+		}
+
+		if (maxbit - cur_startbit < MAPSIZE)
+			map &= (((MAPTYPE)1) << (maxbit - cur_startbit)) - 1;
+
+		if (map != 0) {
+			new = malloc(sizeof(ebitmap_node_t));
+			if (!new) {
+				ebitmap_destroy(dst);
+				return -ENOMEM;
+			}
+
+			new->startbit = startbit;
+			new->map = map;
+			new->next = NULL;
+
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


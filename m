Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEFFEB64DD
	for <selinux@archiver.kernel.org>; Thu,  3 Aug 2023 16:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbjHCQWz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Aug 2023 12:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjHCQWy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Aug 2023 12:22:54 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB19110
        for <selinux@vger.kernel.org>; Thu,  3 Aug 2023 09:22:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bed101b70so160214366b.3
        for <selinux@vger.kernel.org>; Thu, 03 Aug 2023 09:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691079771; x=1691684571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hmPAjE6WCW23K7fgLKeSgmmoy87xKaE8fFnbtrHJ0uA=;
        b=HJeMv6xy0w8eEU1ndica33sieJY4hpLdeQK4vwvmA9ZeK9HMkN6R3Mr8zDmT1TMoMs
         9ZJ2WIse/j5Z3OuuumxasN1zct/EeIX+pRm2UiiPctwZjdRBcNNQbYRKbzkIwG+JSJP9
         UgP/mss6MYxYfggrDxJbE7szu4nBVGD+Z5R5AxLK2EfFKOyGAKnkRJ4O4K0PUOU3hgrz
         MxfZyVInCVE8tD1XvWvD/VgkdhbY/5H5Pc5PNp2cZHlmKFx557ZbHRV8yaWnajuZ6Pmg
         X6v6CX7Ys9T8ImdfeiMk3hc2eTEa6ROgwEA6JSy/zOBQCrt5QNzwC5VPfkr5pDgJWM+M
         j64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691079771; x=1691684571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmPAjE6WCW23K7fgLKeSgmmoy87xKaE8fFnbtrHJ0uA=;
        b=HsfOzzEevC3vLaKu0OYHEFLt2Vmaa2Nk6RCRX67q7LUBcow56agHLm+bkXfagqn666
         I6j82O0wrLkV2bfUnDTRPyPG37giL6wfwou/Tz0XSVlnXUoYiq4sY6lA+x9Qz1hCfKv7
         G/hByRNrOLHXzrhDZsS8eDIwnwpx9OEvs8qyoreoPA+NGuz2jLEr4fsrP84gXhlHF6HV
         ZTaW/0VQJAnIHT7HylIcwxDXNyp7sq7ckVnvdmNmP1z5aep3Zxd4rxlgeV/9FsSMP+oY
         FKZoqiTP3jmxxOOGemJkm2pHy+E5PITnKKxzLRcsIw+AmgnnA9lVRuPQ9LkQgRnkWlsg
         UC7w==
X-Gm-Message-State: ABy/qLaINpKX5ku1AHcoDHDzdu7SdhifkZfr/FXAzIFv9FWkmLgzTJrT
        +AlcfaDY6U/XKNzs4YTGR7i/9Ep1zw2zUP5HFW0=
X-Google-Smtp-Source: APBJJlENgdVnV8yXA0MDmeiVlO1iMh2QrOK0Xoqzt3ucenMWc2LN88uF7VdJgGfcjpJXCX1NWpsTCA==
X-Received: by 2002:a17:906:3144:b0:99b:5085:42a2 with SMTP id e4-20020a170906314400b0099b508542a2mr7736131eje.40.1691079771070;
        Thu, 03 Aug 2023 09:22:51 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-150-191.77.0.pool.telefonica.de. [77.0.150.191])
        by smtp.gmail.com with ESMTPSA id r22-20020a17090638d600b00985ed2f1584sm31027ejd.187.2023.08.03.09.22.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:22:50 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: ebitmap: avoid branches for iteration
Date:   Thu,  3 Aug 2023 18:22:45 +0200
Message-Id: <20230803162245.302488-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Otherwise Linus might think we don't understand pointers.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/ebitmap.c | 83 +++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 46 deletions(-)

diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index 3ec1042f..f166b7d6 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -18,13 +18,13 @@
 int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebitmap_t * e2)
 {
 	const ebitmap_node_t *n1, *n2;
-	ebitmap_node_t *new, *prev;
+	ebitmap_node_t *new = NULL, **prev;
 
 	ebitmap_init(dst);
 
+	prev = &dst->node;
 	n1 = e1->node;
 	n2 = e2->node;
-	prev = 0;
 	while (n1 || n2) {
 		new = (ebitmap_node_t *) malloc(sizeof(ebitmap_node_t));
 		if (!new) {
@@ -46,12 +46,10 @@ int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebitmap_t * e2)
 			n2 = n2->next;
 		}
 
-		new->next = 0;
-		if (prev)
-			prev->next = new;
-		else
-			dst->node = new;
-		prev = new;
+		new->next = NULL;
+
+		*prev = new;
+		prev = &new->next;
 	}
 
 	dst->highbit = (e1->highbit > e2->highbit) ? e1->highbit : e2->highbit;
@@ -74,10 +72,11 @@ int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1)
 int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2)
 {
 	const ebitmap_node_t *n1, *n2;
-	ebitmap_node_t *new, *prev = NULL;
+	ebitmap_node_t *new = NULL, **prev;
 
 	ebitmap_init(dst);
 
+	prev = &dst->node;
 	n1 = e1->node;
 	n2 = e2->node;
 	while (n1 && n2) {
@@ -92,11 +91,8 @@ int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2)
 				new->map = n1->map & n2->map;
 				new->next = NULL;
 
-				if (prev)
-					prev->next = new;
-				else
-					dst->node = new;
-				prev = new;
+				*prev = new;
+				prev = &new->next;
 			}
 
 			n1 = n1->next;
@@ -108,8 +104,8 @@ int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2)
 		}
 	}
 
-	if (prev)
-		dst->highbit = prev->startbit + MAPSIZE;
+	if (new)
+		dst->highbit = new->startbit + MAPSIZE;
 
 	return 0;
 }
@@ -117,12 +113,13 @@ int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2)
 int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2)
 {
 	const ebitmap_node_t *n1, *n2;
-	ebitmap_node_t *new, *prev = NULL;
+	ebitmap_node_t *new = NULL, **prev;
 	uint32_t startbit;
 	MAPTYPE map;
 
 	ebitmap_init(dst);
 
+	prev = &dst->node;
 	n1 = e1->node;
 	n2 = e2->node;
 	while (n1 || n2) {
@@ -150,16 +147,14 @@ int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2)
 			new->startbit = startbit;
 			new->map = map;
 			new->next = NULL;
-			if (prev)
-				prev->next = new;
-			else
-				dst->node = new;
-			prev = new;
+
+			*prev = new;
+			prev = &new->next;
 		}
 	}
 
-	if (prev)
-		dst->highbit = prev->startbit + MAPSIZE;
+	if (new)
+		dst->highbit = new->startbit + MAPSIZE;
 
 	return 0;
 }
@@ -167,12 +162,13 @@ int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2)
 int ebitmap_not(ebitmap_t *dst, const ebitmap_t *e1, unsigned int maxbit)
 {
 	const ebitmap_node_t *n;
-	ebitmap_node_t *new, *prev = NULL;
+	ebitmap_node_t *new = NULL, **prev;
 	uint32_t startbit, cur_startbit;
 	MAPTYPE map;
 
 	ebitmap_init(dst);
 
+	prev = &dst->node;
 	n = e1->node;
 	for (cur_startbit = 0; cur_startbit < maxbit; cur_startbit += MAPSIZE) {
 		if (n && n->startbit == cur_startbit) {
@@ -199,16 +195,13 @@ int ebitmap_not(ebitmap_t *dst, const ebitmap_t *e1, unsigned int maxbit)
 			new->map = map;
 			new->next = NULL;
 
-			if (prev)
-				prev->next = new;
-			else
-				dst->node = new;
-			prev = new;
+			*prev = new;
+			prev = &new->next;
 		}
 	}
 
-	if (prev)
-		dst->highbit = prev->startbit + MAPSIZE;
+	if (new)
+		dst->highbit = new->startbit + MAPSIZE;
 
 	return 0;
 }
@@ -278,11 +271,11 @@ int ebitmap_cmp(const ebitmap_t * e1, const ebitmap_t * e2)
 int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * src)
 {
 	const ebitmap_node_t *n;
-	ebitmap_node_t *new, *prev;
+	ebitmap_node_t *new = NULL, **prev;
 
 	ebitmap_init(dst);
 	n = src->node;
-	prev = 0;
+	prev = &dst->node;
 	while (n) {
 		new = (ebitmap_node_t *) malloc(sizeof(ebitmap_node_t));
 		if (!new) {
@@ -291,12 +284,11 @@ int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * src)
 		}
 		new->startbit = n->startbit;
 		new->map = n->map;
-		new->next = 0;
-		if (prev)
-			prev->next = new;
-		else
-			dst->node = new;
-		prev = new;
+		new->next = NULL;
+
+		*prev = new;
+		prev = &new->next;
+
 		n = n->next;
 	}
 
@@ -450,7 +442,7 @@ int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value)
 
 int ebitmap_init_range(ebitmap_t * e, unsigned int minbit, unsigned int maxbit)
 {
-	ebitmap_node_t *new, *prev = NULL;
+	ebitmap_node_t *new = NULL, **prev;
 	uint32_t minstartbit = minbit & ~(MAPSIZE - 1);
 	uint32_t maxstartbit = maxbit & ~(MAPSIZE - 1);
 	uint32_t minhighbit = minstartbit + MAPSIZE;
@@ -466,6 +458,8 @@ int ebitmap_init_range(ebitmap_t * e, unsigned int minbit, unsigned int maxbit)
 	if (minhighbit == 0 || maxhighbit == 0)
 		return -EOVERFLOW;
 
+	prev = &e->node;
+
 	for (startbit = minstartbit; startbit <= maxstartbit; startbit += MAPSIZE) {
 		new = malloc(sizeof(ebitmap_node_t));
 		if (!new)
@@ -485,11 +479,8 @@ int ebitmap_init_range(ebitmap_t * e, unsigned int minbit, unsigned int maxbit)
 			new->map = (mask << (minbit - startbit));
 		}
 
-		if (prev)
-			prev->next = new;
-		else
-			e->node = new;
-		prev = new;
+		*prev = new;
+		prev = &new->next;
 	}
 
 	e->highbit = maxhighbit;
-- 
2.40.1


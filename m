Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7963CC433EF
	for <selinux@archiver.kernel.org>; Tue, 12 Jul 2022 16:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbiGLQJR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Jul 2022 12:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbiGLQJI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Jul 2022 12:09:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7705127FD3
        for <selinux@vger.kernel.org>; Tue, 12 Jul 2022 09:09:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r18so10714486edb.9
        for <selinux@vger.kernel.org>; Tue, 12 Jul 2022 09:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6i9iU/qgXKqe/f/E8m+XyaPz1V6XYcq7ck58+zDr220=;
        b=j68Ksh6ior9qeiCMNaFVMlsS9AOOao3YWAkxhO4nh1aLbjJVnw78s7ByA8hEyfn1Ed
         6k0PBX3dkHVwbn5afeAbnAcd+p/vmYBdGLoEkn3f6oJIA35fMiD1IJTmK6xjH6StNU71
         3GvQUxdQl9PxZXyDOnzrPdGodXelvMylZ3gwREL050nNPuoCUZmvwg92FHYVuY5Hy+W7
         X1dPaM1kc2mTCwfArOZVpWY9bbbQUhu6KYBIOXq16P+Dx/AieRoila7uiH46ExoKSQwO
         fIEWXQOmYo93rwOaxb5pUD1OB6hcDFq/JsrjG7atgAjRBS6AOEgK26x/aPYY24NJ8YQh
         Hi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6i9iU/qgXKqe/f/E8m+XyaPz1V6XYcq7ck58+zDr220=;
        b=kX6k2SscBV+DpxAAyegVo5aA+KXV2TFAKgKPWjjRzCbHFLq9SdC2ObBaCqVQtpDUNY
         G1UGHL131LkaPXF59lAB+I0dGrC/UJ01CnqGaYZblHtntzmyHe9ziuMJJ28rHjncfT9h
         hMNsAkaBOtREpbOyCPWAuxYyz5NQDukyoQ64Ki30jrwiwYmf8bl9ogxweDQ27vhv02C5
         m8VszpNc2N3/6UUHQOPYwsaYtz3Oyvpk1+JIVszIlwd/a2qm0V26EwHGnTToR6WgRT71
         i5GuoL0GblsZ/zMlkeHdRAWDee82xPKTHh8Yu9Ql2sIKF+LNZb9MAOmPDM/i8kbd2PCc
         ivAA==
X-Gm-Message-State: AJIora8KDac2EQIB2b+Po5B9hrmu9RzIh4704VGyCG6WLIoHCgpUi/4j
        Rx0grWtH/06s8C1+4NypQnWPmBdD1SiAiA==
X-Google-Smtp-Source: AGRyM1t/pQN2EEOTOA7QindNtxd9EZvL2jv+mAOdWZqDYZRcU8lUkANl3OvF9a+uSCTWJB61bKHX+g==
X-Received: by 2002:a05:6402:228f:b0:43a:896:e4f0 with SMTP id cw15-20020a056402228f00b0043a0896e4f0mr32087123edb.81.1657642146036;
        Tue, 12 Jul 2022 09:09:06 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-190-079.77.10.pool.telefonica.de. [77.10.190.79])
        by smtp.gmail.com with ESMTPSA id p13-20020a17090653cd00b006fed85c1a8fsm3887127ejo.202.2022.07.12.09.09.05
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:09:05 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/7] libsepol: optimize ebitmap_not
Date:   Tue, 12 Jul 2022 18:08:55 +0200
Message-Id: <20220712160858.22677-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220712160858.22677-1-cgzones@googlemail.com>
References: <20220712160858.22677-1-cgzones@googlemail.com>
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
index fb20e994..6a63e559 100644
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


Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE3ECCA47C
	for <selinux@archiver.kernel.org>; Tue, 12 Jul 2022 16:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbiGLQJR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Jul 2022 12:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiGLQJJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Jul 2022 12:09:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A27D12D2F
        for <selinux@vger.kernel.org>; Tue, 12 Jul 2022 09:09:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l23so15162788ejr.5
        for <selinux@vger.kernel.org>; Tue, 12 Jul 2022 09:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KWFaMKkeTX17vWaSfNfz/271fEVh8cMtoLZ4z8S3Jx4=;
        b=fLcJ1m4nNv8gZ7N3qf8XZBQujtQk9hgp8tJNt6f0PASQI6hkpRS2P12nEVtCdje/af
         yc0CmFTRN/CukgyXw7BXh7/pFt0cg/YPEt/3LgdVWJFCfpnz7EATJjhsYeSJ+PzhBcgV
         8twqlAO0QT1h+bC1DodH+94P6pp1X/mK/bOlhImNSs7b52f0uKXctDJhYRZsTTjMWKjE
         wF029lrvPjBeMuqCZ9lEQY4dCXzgYjvKnQLFUdzWo6SsW9Si7zN9Q+sNBamE6K6ccxS4
         JemHsMBEja7ylnl4Xi/AS3g68MaKjBRsSOBTJ0tqyHCNIDoQCxSdzICLPvNsQlqBO7hX
         o2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KWFaMKkeTX17vWaSfNfz/271fEVh8cMtoLZ4z8S3Jx4=;
        b=c5Br/fp+b7BawIzI8ioUKJRZ68Gfln4CyJdloMKc5QxbhzpGS7jAQaALoCDDNGfqmZ
         rsYhx7OdVYUSr8q5IKAHJyrPW7KcmcfYEM4HPvdps4TiSF7s/z++crNdonn2lcWl/A3i
         npOqX99q5gTze9rycoBgtI4E4gq3+21QqHIn1yHW2GIY8Z18PfjZKfxkUheAUpW8Fbxc
         T4hSg4xR84gu4fwbBsv6Sxe4/CZQSKzkcw0A0kVnbfDMnkmdTsAp25AnsAOjhCpW/pyp
         HOO5NBdSM92S5rxzaqAh452v/REP6RCg60KodrfFG/7eJ8AiKDcMzdL9WcRuQ76ZF62l
         NRwQ==
X-Gm-Message-State: AJIora+qApYdO7jNFgftHRxe5wislIYnWM+KLpphLGoxOzm0e2M+tIMx
        i3zXTfQJuKBsxloZ1ucsz2ukgPgXg0Fh/g==
X-Google-Smtp-Source: AGRyM1ut6BDqhGpX/481ErKRi/JTFt5cqyDNWyAyccsRWrU1BpS1WwVC4YDk50FCK2Xmx/0XcaG8dw==
X-Received: by 2002:a17:907:a074:b0:72b:5851:361b with SMTP id ia20-20020a170907a07400b0072b5851361bmr10274999ejc.310.1657642146573;
        Tue, 12 Jul 2022 09:09:06 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-190-079.77.10.pool.telefonica.de. [77.10.190.79])
        by smtp.gmail.com with ESMTPSA id p13-20020a17090653cd00b006fed85c1a8fsm3887127ejo.202.2022.07.12.09.09.06
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:09:06 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 5/7] libsepol: optimize ebitmap_and
Date:   Tue, 12 Jul 2022 18:08:56 +0200
Message-Id: <20220712160858.22677-5-cgzones@googlemail.com>
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
 libsepol/src/ebitmap.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index 6a63e559..c3d706e9 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -74,15 +74,43 @@ int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1)
 
 int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2)
 {
-	unsigned int i, length = min(ebitmap_length(e1), ebitmap_length(e2));
+	const ebitmap_node_t *n1, *n2;
+	ebitmap_node_t *new, *prev = NULL;
+
 	ebitmap_init(dst);
-	for (i=0; i < length; i++) {
-		if (ebitmap_get_bit(e1, i) && ebitmap_get_bit(e2, i)) {
-			int rc = ebitmap_set_bit(dst, i, 1);
-			if (rc < 0)
-				return rc;
-		}
+
+	n1 = e1->node;
+	n2 = e2->node;
+	while (n1 && n2) {
+		if (n1->startbit == n2->startbit) {
+			if (n1->map & n2->map) {
+				new = malloc(sizeof(ebitmap_node_t));
+				if (!new) {
+					ebitmap_destroy(dst);
+					return -ENOMEM;
+				}
+				new->startbit = n1->startbit;
+				new->map = n1->map & n2->map;
+				new->next = NULL;
+
+				if (prev)
+					prev->next = new;
+				else
+					dst->node = new;
+				prev = new;
+			}
+
+			n1 = n1->next;
+			n2 = n2->next;
+		} else if (n1->startbit > n2->startbit)
+			n2 = n2->next;
+		else
+			n1 = n1->next;
 	}
+
+	if (prev)
+		dst->highbit = prev->startbit + MAPSIZE;
+
 	return 0;
 }
 
-- 
2.36.1


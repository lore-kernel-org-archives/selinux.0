Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7463FCCA485
	for <selinux@archiver.kernel.org>; Tue, 19 Jul 2022 15:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiGSPbM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbiGSPbJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Jul 2022 11:31:09 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5845885F
        for <selinux@vger.kernel.org>; Tue, 19 Jul 2022 08:31:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l23so27886427ejr.5
        for <selinux@vger.kernel.org>; Tue, 19 Jul 2022 08:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YYAya2IjPo0e6G7r+k7JrvFxc/U5lYIslrGMlcbbDvg=;
        b=Y/LMHPF6a81NuPuuAisd7c6z6pDiDwaNOTLKGxyj6KS7E1yLfbaSRVa4QVZfDXPbq8
         uGscSZMhhmqeiGhL/aOcGKj7Wc1O0wgGYuhixvdQEaGuWYZQ4bngAvZ5l8grwod71EQR
         CH4uYvdLL1nyOShsSi5as2NXT8svBTK7gUdmfmRBYtM6YX2Z5HT3wcmDIsP1M6BL9x6O
         wMPREBY//66ohZtS4cKSWFpekzlnf6h2mbzAyECj1Tg20vY+/K97sZlWD8GrBSJfLsKM
         wcEjUWMJK4eNAYGepUr2ojhPveM3gr6bbNbIz/0ispLlsI2n7PEFTVfZPqC82mnfYt9j
         hc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YYAya2IjPo0e6G7r+k7JrvFxc/U5lYIslrGMlcbbDvg=;
        b=HHctwG6qsbwe9bsu5lmGB3xiBlbsDSSyJlnBOqjlDiVdOyvDFJdM5dmSktA+iKM6Tc
         CRLjJhJqk2xuzQIo6c9AfGkQK/ctSHQg2rZxJXTQ1g4aPnQXiU8904dheguVVopmi7aB
         Ls5LLas9HZc+Sxq6lrKCdW6Roo5rxRF3aGtN4k1dEMmNYsBd1zPodN1kfNHBH2brGoTW
         hu5Kww30SOPCX8NOnJEiTxBJtsYuSyaZbgtAIo86sPCaJSb+5mM4RkUQUomd7EWAPaCT
         PSVBsy+MEfxn5K2IdTgjpqbrbQSP7MXMHE6PYKPEEJeByDKTdhzDIWYuHTpwXTg3xYqj
         lm0A==
X-Gm-Message-State: AJIora/1vGrzxWkI9grncNG+o0KSsILTQBLdQniAHmQViaZ9QGgFkGD+
        GNymJhG13ClGZZ21f4u17ajYGoZzOMF5rw==
X-Google-Smtp-Source: AGRyM1vV3EBnGj9/I5wf7jg6y7FY7zfUQwd2z13PRr3wa/m7ND7LzTB+y6U6qMXVCbxTc4Joao6UPw==
X-Received: by 2002:a17:907:728d:b0:72f:38d0:b8ae with SMTP id dt13-20020a170907728d00b0072f38d0b8aemr9218202ejc.30.1658244667107;
        Tue, 19 Jul 2022 08:31:07 -0700 (PDT)
Received: from dlaptop.localdomain (dynamic-077-001-147-221.77.1.pool.telefonica.de. [77.1.147.221])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906311b00b0072b7b317aadsm6809621ejx.150.2022.07.19.08.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:31:06 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 7/7] libsepol: skip superfluous memset calls in ebitmap operations
Date:   Tue, 19 Jul 2022 17:30:44 +0200
Message-Id: <20220719153045.70041-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220719153045.70041-1-cgzones@googlemail.com>
References: <20220719153045.70041-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The three members of struct ebitmap_node are all unconditionally
initialized.  Hinder compilers to optimize malloc() and memset() into
calloc(), which might be slightly slower.  Especially affects
ebitmap_or().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/ebitmap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index 7d26f949..3ec1042f 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -31,7 +31,6 @@ int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebitmap_t * e2)
 			ebitmap_destroy(dst);
 			return -ENOMEM;
 		}
-		memset(new, 0, sizeof(ebitmap_node_t));
 		if (n1 && n2 && n1->startbit == n2->startbit) {
 			new->startbit = n1->startbit;
 			new->map = n1->map | n2->map;
@@ -290,7 +289,6 @@ int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * src)
 			ebitmap_destroy(dst);
 			return -ENOMEM;
 		}
-		memset(new, 0, sizeof(ebitmap_node_t));
 		new->startbit = n->startbit;
 		new->map = n->map;
 		new->next = 0;
@@ -430,7 +428,6 @@ int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value)
 	new = (ebitmap_node_t *) malloc(sizeof(ebitmap_node_t));
 	if (!new)
 		return -ENOMEM;
-	memset(new, 0, sizeof(ebitmap_node_t));
 
 	new->startbit = startbit;
 	new->map = (MAPBIT << (bit - new->startbit));
-- 
2.36.1


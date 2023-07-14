Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFAAC0015E
	for <selinux@archiver.kernel.org>; Fri, 14 Jul 2023 18:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbjGNSo1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Jul 2023 14:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbjGNSoZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Jul 2023 14:44:25 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8D730DA
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 11:44:24 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9891c73e0fbso449935066b.1
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 11:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689360262; x=1691952262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GSdWxf980IDFfEMO7NEtxOJcw/hdc8ebbLMd1MVW6uw=;
        b=UcvP7dovPNEf92YH4t5uXtqb7SoQqi2sJa029sYI3gLSb8yk6upaCVOMIUK4x/j7+G
         IB8AUnF9qjR1m1UOcnwQ6JJftY1bGgGY3567tGzDYDI1Y1+xapf4mz1ABHzLoNR1GsiS
         uXTNwGcpsJZu2kXM+HQGr11PlypW1l4WRC+LCuqubXL59MA8mnKaF1SDKBlfq4A+o+Y2
         TBO1ukH/XiU3DOOP4SoObe7MgaE3oLaKXu3Y1CzrGBjbC8r9CFnAt1ecUuJa5Z4fQp8R
         qCQS4LXHGtlooDCKL0Zfc16Sfd758IirzMZOBpMVrE+dPYaZkKzZS3g5HGubHc4NGLSi
         g9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689360262; x=1691952262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSdWxf980IDFfEMO7NEtxOJcw/hdc8ebbLMd1MVW6uw=;
        b=a6jmQCAoQVo+HNp4yly132PWR3ewc7lemm8PIhLnoptMtCfqBNDMUksXfciJlhjEfa
         k36BKh6T2dkviqtZ01EOG99057bskw6hCTeDvd+iTUPXLOp3Jz+VZet2Pjjx6D1J7gYY
         YjJhLMxAjDymm3s8lSB/gwNAtQf4nfni1VCb2LPXd8truKRBQWFmdA+KzUJFzCMoW2st
         kQ7W79Et/L5tgCW77oG0OhCItxS4jx98UPgUxzBI2XXglyV4+UyVTV9rDck0MvO+o6TD
         WM+pOcRNiiSDG+b10Nsv16h+3pI9ovYjOAJEmqOMyrnr0biDylz38MK+jQ7AHz7CmRHq
         8J8w==
X-Gm-Message-State: ABy/qLZp2gPwxv9xIFGE4HSmfgGY2OxJRcNJ4dC8tuW1HOFLHco5H6Kx
        ARjHxRpFoBJi/Fcyvxqu++zubiPQDNPMow==
X-Google-Smtp-Source: APBJJlFPP/ZeTZe0j8puT2ueO1q/zZZVab2gqkuzcLDu+1vUvvtamkrKV33jX68vT7Sv+BqCbiXSJA==
X-Received: by 2002:a17:906:7a5b:b0:98e:370c:be69 with SMTP id i27-20020a1709067a5b00b0098e370cbe69mr4465685ejo.6.1689360262513;
        Fri, 14 Jul 2023 11:44:22 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-078-050-124-229.78.50.pool.telefonica.de. [78.50.124.229])
        by smtp.gmail.com with ESMTPSA id s7-20020a1709064d8700b00993004239a4sm5692167eju.215.2023.07.14.11.44.22
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 11:44:22 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/4] libsepol: expand: use identical type to avoid implicit conversion
Date:   Fri, 14 Jul 2023 20:44:13 +0200
Message-Id: <20230714184414.40724-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230714184414.40724-1-cgzones@googlemail.com>
References: <20230714184414.40724-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/expand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 7a011508..2ff06cd7 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2314,7 +2314,7 @@ static int type_attr_map(hashtab_key_t key
 	policydb_t *p = state->out;
 	unsigned int i;
 	ebitmap_node_t *tnode;
-	int value;
+	uint32_t value;
 
 	type = (type_datum_t *) datum;
 	value = type->s.value;
-- 
2.40.1


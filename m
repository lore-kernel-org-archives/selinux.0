Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE677C001B0
	for <selinux@archiver.kernel.org>; Wed, 16 Aug 2023 12:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244571AbjHPMjN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Aug 2023 08:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245334AbjHPMjB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Aug 2023 08:39:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A5E1FF9
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 05:39:00 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bccc9ec02so906283866b.2
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 05:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692189539; x=1692794339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+eEK6P0Emorw5bqNn4hrxlxmAnnitBogOhVrqsDH/0=;
        b=gZb+rEx384h0w+LO4arkODmSgek3G+SYKm/uYi13hflKlZU1tu43gGRDpDB08py0ba
         MG4dqMx5yEbBnnhCniEysDJwoqiMCvGZAIRU6a4gZvwPuqrILm9azN8keXte62hxxlwr
         R1aX/NvAN9XymTxvaCMaIDv0VaG2SqCNdNofXimup2UD3LnxvmQwwRRMdchdDZa9d3vZ
         cu856g81B4eh60ZfPXc/m3XH3djyaa0ZiBNCNl9sxNk19cJXeOqNKkceUHgGiK1RAc8L
         VRygLYNiswZ4e297zcNX+RdXAArTFXHhazOQ+qFgyIJlu6/HsjmWmYAxjR5ZVm4jz2o7
         shhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692189539; x=1692794339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+eEK6P0Emorw5bqNn4hrxlxmAnnitBogOhVrqsDH/0=;
        b=NziHudhV3glfqWBVN5Pteqp0X9eKXFb1JgU7MAb3FWCs+JJixrgxka4O2woa7M+XcF
         7l8l57Mlo4PQ5XERFcLM0oAtwCrJvHm5tk+sxqAaJcjWUneNqNKAXjyjjqFl4OupSTLL
         bHIyRpXnfFszfOBonrEU6Eou/KD5RouhQGoDr/+VzaH3lDSJIgm6Mr9hdmWNfMNo0Giu
         nkCmcmxc25lKTgXdHd663V5hZo+mUN73i2nT+I/XQA7GW2Zy8XeiL0mXUOnwL2MQnx5Q
         rBrIbbGfjQPkwR7ONR92yo/21Udy5YDEupFjhNnyz0Kz2mTe05ZX8XEEkcwivcBTUk9G
         ZmCQ==
X-Gm-Message-State: AOJu0YwRsTLMI/q1M6ePlCUrSz85s+o4KGZmmeIapQubGWTMeU/USMI0
        PVhgvvGL70m0cE1rQ7tf58TUY4LVKKQLtGSn
X-Google-Smtp-Source: AGHT+IESHjQVDC6Prx/A/1FOClkhgAgWc2VmUEg17/5OSIFzQDTacoeJ7rh3SJ1qaZ3olXCIeyzLTA==
X-Received: by 2002:a17:906:cc18:b0:99c:bb4d:f5a1 with SMTP id ml24-20020a170906cc1800b0099cbb4df5a1mr1195412ejb.4.1692189538666;
        Wed, 16 Aug 2023 05:38:58 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-001-094-128.77.1.pool.telefonica.de. [77.1.94.128])
        by smtp.gmail.com with ESMTPSA id l27-20020a170906415b00b009886aaeb722sm8434075ejk.137.2023.08.16.05.38.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 05:38:58 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/5] libsepol: include length squared in hashtab_hash_eval()
Date:   Wed, 16 Aug 2023 14:38:41 +0200
Message-Id: <20230816123845.80171-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Include the chain length squared sum as metric in the debug function
hashtab_hash_eval(), adopted from the kernel avtab.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/hashtab.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
index b1a9bdc2..2af3a9bf 100644
--- a/libsepol/src/hashtab.c
+++ b/libsepol/src/hashtab.c
@@ -243,11 +243,12 @@ int hashtab_map(hashtab_t h,
 void hashtab_hash_eval(hashtab_t h, const char *tag)
 {
 	unsigned int i;
-	size_t chain_len, slots_used, max_chain_len;
+	size_t chain_len, slots_used, max_chain_len, chain2_len_sum;
 	hashtab_ptr_t cur;
 
 	slots_used = 0;
 	max_chain_len = 0;
+	chain2_len_sum = 0;
 	for (i = 0; i < h->size; i++) {
 		cur = h->htable[i];
 		if (cur) {
@@ -260,10 +261,12 @@ void hashtab_hash_eval(hashtab_t h, const char *tag)
 
 			if (chain_len > max_chain_len)
 				max_chain_len = chain_len;
+			chain2_len_sum += chain_len * chain_len;
 		}
 	}
 
 	printf
-	    ("%s:  %d entries and %zu/%d buckets used, longest chain length %zu\n",
-	     tag, h->nel, slots_used, h->size, max_chain_len);
+	    ("%s:  %d entries and %zu/%d buckets used, longest chain length %zu, chain length^2 %zu, normalized chain length^2 %.2f\n",
+	     tag, h->nel, slots_used, h->size, max_chain_len, chain2_len_sum,
+	     chain2_len_sum ? (float)chain2_len_sum / slots_used : 0);
 }
-- 
2.40.1


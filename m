Return-Path: <SRS0=egAL=IG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1A5C433E0
	for <selinux@archiver.kernel.org>; Mon,  8 Mar 2021 11:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013A4651CD
	for <selinux@archiver.kernel.org>; Mon,  8 Mar 2021 11:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhCHLER (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Mar 2021 06:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhCHLDr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Mar 2021 06:03:47 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF30C06174A;
        Mon,  8 Mar 2021 03:03:47 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id j14-20020a17090a588eb02900cefe2daa2cso1233043pji.0;
        Mon, 08 Mar 2021 03:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O85t+OBSfp8FDlGiG7tVe4R0zkaZIbWN3LQDER9TICI=;
        b=PEGySiKL2Ji4S8Ja/a5hoM/hahDjT4eNfQAuCQNWJdi8lPrfkkMs+t9zFVZStLXhA0
         Rw4t2iZTFh6nDQp9SQ57+fBw0kCHqoEao1YObGlTlyoQW+QKeB7QAyS0J7YqxqurpdCx
         px3gf3gja1znTw2+DG+uoPNx7tbcLZ/kjKhl1TtVOX2AxS59WUGNm46iaUxfWRlHveOY
         4QNSIJJB4KdxlvSwC4YQcv82nZrKzTY5x0co2K+QPJm8K03Uz+kDL/y78v1SB/B79I8w
         mPoD8sgFds0mfdHrJZNkTkI+w+RR80IBP9wZufH8FY2D9zVSI/SyQaAW0n5xn94EjZzK
         pt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O85t+OBSfp8FDlGiG7tVe4R0zkaZIbWN3LQDER9TICI=;
        b=oKQBySfoAEAiIEMrULMH8GPNEczcidvt3Ilf/SiVnr2hivXrjHTy1Y6430vXjUXfKn
         yppi0l7odxv1zl+8Tek824NNTGycBgmC1RsF8Cib2q2sWctqdRoKDej4isrIp+n7KD4D
         Hmy8JnggPDTTNrN6UPrjiHtPyb7HYqm2skQfho9SRbi1wgsuSjB1RGdNGN5XxuI4S5ig
         w6eOD3l+0k8lT1GnWol6pVME3yUR8wji+v3pgprfxuxG5KDgOqNlCXs+DPxU/tf1kUjl
         Uwmtp7Is/nAplb7FGPYTB93R8zZV4HBgez5HvJt/TxVefLNvU0b0p+iHajbScWhHr3PS
         EuFQ==
X-Gm-Message-State: AOAM530YfIdNsGm6e1GxWco2QxdZNxH8sjY2Y3ucmtttn09TOGMcRN/K
        r/v+cfk0aA43MFScFP+lcPw=
X-Google-Smtp-Source: ABdhPJzIGH3Q4cXhui3wBlCClBbFdWBRQzT5psnh1O1Vaf5Vr3/2FxbtN8IrCmcoqj7OAfIxJ++5Sg==
X-Received: by 2002:a17:90b:3783:: with SMTP id mz3mr25290518pjb.88.1615201426611;
        Mon, 08 Mar 2021 03:03:46 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id w25sm9978180pfn.106.2021.03.08.03.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 03:03:45 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: xiong.zhenwu@zte.com.cn
To:     paul@paul-moore.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        omosnace@redhat.com, xiong.zhenwu@zte.com.cn,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] security/selinux/ss: fix misspellings using codespell tool
Date:   Mon,  8 Mar 2021 03:03:38 -0800
Message-Id: <20210308110338.259868-1-xiong.zhenwu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>

A typo is found out by codespell tool in 16th line of hashtab.c

$ codespell ./security/selinux/ss/
./hashtab.c:16: rouding  ==> rounding

Fix a typo found by codespell.

Signed-off-by: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
---
 security/selinux/ss/hashtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 3881787ce492..b8f6b3e0a921 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -13,7 +13,7 @@ static struct kmem_cache *hashtab_node_cachep __ro_after_init;
 
 /*
  * Here we simply round the number of elements up to the nearest power of two.
- * I tried also other options like rouding down or rounding to the closest
+ * I tried also other options like rounding down or rounding to the closest
  * power of two (up or down based on which is closer), but I was unable to
  * find any significant difference in lookup/insert performance that would
  * justify switching to a different (less intuitive) formula. It could be that
-- 
2.25.1


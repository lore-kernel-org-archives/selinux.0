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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B1AC43462
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5E196121D
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhECRzB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhECRy4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:56 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86847C061344
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:54:00 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c22so7313261edn.7
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OaHh7NFTPHxZgNaeYXwcDNkow2ilHSnWR7ngZniqiKE=;
        b=rAvm9nRAOHl126trajCq0EmJ6g8BSb/kJS4XK4w3lWmOTBV7fFLyDZC+w9Bf0JaBAS
         D/CT9qOELBXB516ANyfSRQQikb7T4nyUBhBHql2pK+QhyH1VSM4MKCWTC+++f5RQkBT5
         ztQu/GS3NSBkwEEcps+lMLzyZP2+CVOVSnRIHwSUw007pYRPduVFG2+YTPgDiuvqhSig
         7LB243PHy6i7Uzck6tDmCE9QRb4+RlQD+Bu/ybOdlj+ECRBqUdReJXBNVdAGRI0dy6Ea
         cDFI5FqsqvK32jeSzR4DqEb6qQhpk0eG5HTeKmrRj7HohXDQCHbl6DeeckrRGvHtT0Ca
         +hDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OaHh7NFTPHxZgNaeYXwcDNkow2ilHSnWR7ngZniqiKE=;
        b=hJ2vQ3wbhYVZyTD4cuGuoOjNoC9FC5wqxwPiOSl1eDzjUQPrXsUKibuDaNiPgHW3sV
         pgG6XdorlsD78hZbwfSt3U6UDt45+I+mPS/moSOUaS73WGQiOkiLPB51JaGOnp1A/4cn
         bjBrYmsJMpigt/gxnxqaC8Jz4kQ5fCAaldBBX6MO105tJhMizySTijYqod1p9RSopZjW
         nP6T0fOAQtArfHsVmdv3+TDmi4z9JMsp3iZovViOxGQUvef/W/HEIL2HmfO3FClXwIyI
         b0lmAr2PLcuMubuyoU+ELo71J64qKojY/hYC0F7iFhU4VI/88NDYvcFCAT8LW9+ICugr
         M79A==
X-Gm-Message-State: AOAM530IJAJhXBqHOP9EgjUFGa+88SN066kUvFPN6y/IMJ9tiEJxCovg
        rIsNeauN2ZvaybuuCakbSCnMmyW07wWqYQ==
X-Google-Smtp-Source: ABdhPJwvb5sWN4RG3nx47HfD/nw6PnRd0v7uXYDtbydblnyHuvONqaFPHatN8VshOExCHxFq/8bv5g==
X-Received: by 2002:aa7:c3c2:: with SMTP id l2mr21903758edr.41.1620064439302;
        Mon, 03 May 2021 10:53:59 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.53.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:53:59 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 12/25] libselinux: label_x::init(): drop dead assignment
Date:   Mon,  3 May 2021 19:53:37 +0200
Message-Id: <20210503175350.55954-13-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The variable `lineno` is only used in the preceding loop and is always
set prior that to 0.

Found by clang-analyzer.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index 96745299..e9fa063f 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -146,7 +146,6 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 			if (process_line(path, line_buf, pass, ++lineno, rec))
 				goto finish;
 		}
-		lineno = 0;
 
 		if (pass == 0) {
 			if (data->nspec == 0) {
-- 
2.31.1


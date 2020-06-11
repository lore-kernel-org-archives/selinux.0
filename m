Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7434AC433E1
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 13:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 539D220842
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 13:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="amM01U8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgFKNxV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgFKNxV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 09:53:21 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72FAC08C5C1
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 06:53:20 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n24so6583879ejd.0
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 06:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2dDQo5TBYzv5GbPVXqTse1qHbaGMhdlPKnh9NscWjuU=;
        b=amM01U8jVF70/yNAQfUR1810cIDmBt5yZFmz+F1x9rkgvHewkom79nebIm7T7GUt16
         SpTlkM2IIhV/EgRDTEIq/LsXLAR7Xqa5iTYds48dVKV/45qeUBOyynL8RZLV8Et5qZ64
         J6Bsuz+FTTTbzk3yfdaHFGbCZkshD6kGY7eV8PL2FP/QnaDHWQGGseDCP9fAqfoBwJHI
         HiK2yjIFTo/tWpLV6qEIzYmRonVvbHPr/1M0+fXrIjX8LF/sJX4hk8n2jTN2s1dDhAxm
         w2QAcA85Mj2MXVMSwpSkRrHiZDIBc2C77v7PimU517YUeRXVLkp4TgFYML4NNEEebcLs
         ieQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2dDQo5TBYzv5GbPVXqTse1qHbaGMhdlPKnh9NscWjuU=;
        b=dOuJSAYoAxm3ZZtNgKVP+GjSLObwRzYLf1O51k8ldQX9ruPwY7gvYnQk04L4m6WHb8
         9/lrXgqoryagcXsC+qsz9AmltnSVudVjVp5Avg9NIrLaJ4j+MzSaty9PEjjUr5gortCw
         JeIpXx9XUlgL6V53lrwKxDWN5T28AR5w2ixPvixKclWV8KK5dL3THR7lDQ4OWmZSDt6h
         8i3F79LAi9PHlcUZopyTYYv77rhSBlxcyXAskEumFwhAg/BCfNfXVDwXXHPmLee8yRny
         D85TU+1iryqyqFg4fi8Cf7UKEGFytGMPjmhtMwHOS97rJq24j22Py4mgSo6wFvaRfitN
         SZ6w==
X-Gm-Message-State: AOAM530QlHYMP90YGc5u4ijYkOYVq83F+a6acxzu5Y8DjcsLoYHYcKtJ
        7opm5PKEDmxIiBsXsyHzrUVJqKSE
X-Google-Smtp-Source: ABdhPJyJlsfkEVBEsKfpSbc+RRvXwbRd9NOTBzDPf/wFjkvohInwTaCzG0NtmJHy9PIugLAd+Ks83g==
X-Received: by 2002:a17:906:c10f:: with SMTP id do15mr8852621ejc.249.1591883599163;
        Thu, 11 Jun 2020 06:53:19 -0700 (PDT)
Received: from debianHome.localdomain (x4d03eb01.dyn.telefonica.de. [77.3.235.1])
        by smtp.gmail.com with ESMTPSA id bd19sm1575005edb.2.2020.06.11.06.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 06:53:18 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 2/3] refparser: add missing newline after error message
Date:   Thu, 11 Jun 2020 15:53:02 +0200
Message-Id: <20200611135303.19538-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200611135303.19538-1-cgzones@googlemail.com>
References: <20200528125128.26915-1-cgzones@googlemail.com>
 <20200611135303.19538-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v4: no changes
v3: no changes

 python/sepolgen/src/sepolgen/refparser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
index f3e0ae87..9f850990 100644
--- a/python/sepolgen/src/sepolgen/refparser.py
+++ b/python/sepolgen/src/sepolgen/refparser.py
@@ -1148,6 +1148,6 @@ def parse_headers(root, output=None, expand=True, debug=False):
             status.step()
 
     if len(failures):
-        o("failed to parse some headers: %s" % ", ".join(failures))
+        o("failed to parse some headers: %s\n" % ", ".join(failures))
 
     return headers
-- 
2.27.0


Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1070C4332F
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA7461183
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbhKEPsz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbhKEPss (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:48 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09453C061226
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:46:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id j21so34371964edt.11
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zSLcHCxAMmGMuhGNCJuJBcZvjfA97yIE1RNGGNKjbpM=;
        b=e/YDhF2IJmjWafXwbrmJWXCT/CGgsACX/wJ4jBFEUXoHcZ8Q9kvK0LhQ2LBdSd+ROe
         3hl7bKuPJMd+JVBTBfjTybwieQyQoJZmNgTT+N8Q3C3YKfJk6ibWxDt+SCCaqS7ceMVM
         GgY0eX++JIngreoGA0+8vswqmk8X3wajeqF5ThAoxI5wDAswGAr+63pCNYF8GjaxqN0I
         uYnNppIeJzlFL9yhzN5P7aoQ1pc/SLi3CYmhi/LaRtu0eNHgXDehBUtRpiA77KEQAuJ7
         mNLTLhOtTO9w9Rw5HtEeq2LcCit99gkdQRaE0V1PTapvlX9LyaNtXZW9fUFXQvq43OqQ
         izuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSLcHCxAMmGMuhGNCJuJBcZvjfA97yIE1RNGGNKjbpM=;
        b=38mOJcWC6zUMQIWyQZSGIUoinC+vmr4Tbp064l0S3Ltk5G104dsfZVDi5RbsFVfbis
         AMxz2dYuC+goRAfNHmP26O8Nn10VjhGTj5bnp0sKnt1kXg4n1BCR2i2STSCpcdhMsAq+
         HK9kHYVEqaqRMj8lfgQhaGChIikO6nfX7XExugGFexbatYfDb5iQbqdAu+ZqZ7rmsCzr
         AjzsxyYy6JW1tvF+HYKYWNnhCaKz3t3ucrBVjX9JZlVpExMCajQuR4HpBa0Bh5syhVCh
         IYrXOaBpsVCkMz/CbdkHID0IAiXwvFZt2k2n1W41dcHr/bZ7ydi7ujQ4n5K4atpQnluu
         763Q==
X-Gm-Message-State: AOAM532cNkxHSWrUNN4Z9YOrSBTvEUyFny3xv+gUH0oGhHi3ZB+hdY1T
        ZoK8qi+GBKBmT14DX2EXJ7TLlYK297A=
X-Google-Smtp-Source: ABdhPJwIALlo26E1pLOHLVws6Q43yGJ5i8La4xcCROBnkOiNejI7P00QdIW+FlVbMcZjkibQH3Zqfg==
X-Received: by 2002:a17:906:128d:: with SMTP id k13mr73587285ejb.517.1636127166637;
        Fri, 05 Nov 2021 08:46:06 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.46.06
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:46:06 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 33/36] libsepol: validate policy properties
Date:   Fri,  5 Nov 2021 16:45:35 +0100
Message-Id: <20211105154542.38434-34-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105154542.38434-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 51 ++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index ffa21ee1..27f25132 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -976,6 +976,54 @@ bad:
 	return -1;
 }
 
+static int validate_properties(sepol_handle_t *handle, policydb_t *p)
+{
+	switch (p->policy_type) {
+	case POLICY_KERN:
+		if (p->policyvers < POLICYDB_VERSION_MIN || p->policyvers > POLICYDB_VERSION_MAX)
+			goto bad;
+		break;
+	case POLICY_BASE:
+	case POLICY_MOD:
+		if (p->policyvers < MOD_POLICYDB_VERSION_MIN || p->policyvers > MOD_POLICYDB_VERSION_MAX)
+			goto bad;
+		break;
+	default:
+		goto bad;
+	}
+
+	switch (p->target_platform) {
+	case SEPOL_TARGET_SELINUX:
+	case SEPOL_TARGET_XEN:
+		break;
+	default:
+		goto bad;
+	}
+
+	switch (p->mls) {
+	case 0:
+	case 1:
+		break;
+	default:
+		goto bad;
+	}
+
+	switch (p->handle_unknown) {
+	case SEPOL_DENY_UNKNOWN:
+	case SEPOL_REJECT_UNKNOWN:
+	case SEPOL_ALLOW_UNKNOWN:
+		break;
+	default:
+		goto bad;
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid policy property");
+	return -1;
+}
+
 static void validate_array_destroy(validate_t flavors[])
 {
 	unsigned int i;
@@ -995,6 +1043,9 @@ int validate_policydb(sepol_handle_t *handle, policydb_t *p)
 	if (validate_array_init(p, flavors))
 		goto bad;
 
+	if (validate_properties(handle, p))
+		goto bad;
+
 	if (p->policy_type == POLICY_KERN) {
 		if (validate_avtab(handle, &p->te_avtab, flavors))
 			goto bad;
-- 
2.33.1


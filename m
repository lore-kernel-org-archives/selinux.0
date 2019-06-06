Return-Path: <SRS0=xZUV=UF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C657DC04AB5
	for <selinux@archiver.kernel.org>; Thu,  6 Jun 2019 08:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D402070B
	for <selinux@archiver.kernel.org>; Thu,  6 Jun 2019 08:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPDkSTVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfFFIzd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:55:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55317 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfFFIzd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jun 2019 04:55:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so1227498wmj.5;
        Thu, 06 Jun 2019 01:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1/TKE/QmlgGH1FFbgu8/s1F6UVtd/Yfiy+F2mc9SqpQ=;
        b=lPDkSTVeuBYLJ/kHz0jbAmaDqBJE2OPHrYYUwCgZE6l8zE1YHN+vLSe2UegG1UW/yY
         xnJMAAV6BnzK1GZ+t6r4u0AEvH2+okmVbHxjcfb9OvGETwGbwDJEBZRf9R/lNf6qtZlg
         BPnjUevyK22LpLZwLbkZzqIM0yBfPi9hfrbWZBwfY9De5UMfI/+UckNmaVSlLYmkrj7E
         omwCs8EVNrqlplW2/vRGowMeSFyA+Shobq7O5D77ORVqkhfh3h+c1WmNEDcggXc2dIFw
         NoiPLnJcpxbU92zhuu+4kruD2YBlx+uLFruFzd/Hqa/0m3vbQnUlp/AqukwEvzOPD9R+
         e4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1/TKE/QmlgGH1FFbgu8/s1F6UVtd/Yfiy+F2mc9SqpQ=;
        b=EVt2QLsymmKW+Q6RpR+1zviHUBTGAb6u2HpaBxayvechr7HL45XG9hdF9JOuQJd57x
         9UY43tAbTWyNmtlkfbPt1PQack8apPGqL2bXbDOk+tEaDUa5O0Sk5QHIrYC4T9q3texm
         Ro/RPtZLZSoUWuyiEjWstDAgXXOEgiBDNVtHfeMa0JYLRmfViFo373U2P5NpHigOG3xa
         bCu2/vcRi4yMHcNgDD/lSP67vN3w0QaAUDQc2kFkSXhswVD1Nt7vyeX0iNGzDoqu+bMW
         qhZvBMlHN4vl420HgYgtjkqhcnIj5AEuwlGefJc0ca+vW5wT6m/4sCtsFU8ZUBTPaXjy
         rDRg==
X-Gm-Message-State: APjAAAXLUnRudPg/ryuKdAiDV6W+RRAbEzsUBYW0Jy5vPFJu7Ezteal3
        B1cgEkbq5C54bI1d3rnhE59mMniq
X-Google-Smtp-Source: APXvYqw4/5UTPoHuSXJ/gNhhaP0vPWP4gK+OiS1arZxQOQm+S2/Ac66Ejla9Ht6CnkxKiL5lvYuWTA==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr22767614wml.97.1559811331099;
        Thu, 06 Jun 2019 01:55:31 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id r131sm1077565wmf.4.2019.06.06.01.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 01:55:30 -0700 (PDT)
Date:   Thu, 6 Jun 2019 16:55:24 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] selinux: lsm: fix a missing-check bug in
 selinux_sb_eat_lsm_o pts()
Message-ID: <20190606085524.GA21119@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
returns NULL when fails. So 'arg' should be checked. And 'mnt_opts' 
should be freed when error.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
Fixes: 99dbbb593fe6 ("selinux: rewrite selinux_sb_eat_lsm_opts()")
---
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3ec702c..13479cd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2616,10 +2616,11 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 	char *from = options;
 	char *to = options;
 	bool first = true;
+	int rc;
 
 	while (1) {
 		int len = opt_len(from);
-		int token, rc;
+		int token;
 		char *arg = NULL;
 
 		token = match_opt_prefix(from, len, &arg);
@@ -2635,15 +2636,15 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 						*q++ = c;
 				}
 				arg = kmemdup_nul(arg, q - arg, GFP_KERNEL);
+				if (!arg) {
+					rc = -ENOMEM;
+					goto free_opt;
+				}
 			}
 			rc = selinux_add_opt(token, arg, mnt_opts);
 			if (unlikely(rc)) {
 				kfree(arg);
-				if (*mnt_opts) {
-					selinux_free_mnt_opts(*mnt_opts);
-					*mnt_opts = NULL;
-				}
-				return rc;
+				goto free_opt;
 			}
 		} else {
 			if (!first) {	// copy with preceding comma
@@ -2661,6 +2662,12 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 	}
 	*to = '\0';
 	return 0;
+free_opt:
+	if (*mnt_opts) {
+		selinux_free_mnt_opts(*mnt_opts);
+		*mnt_opts = NULL;
+	}
+	return rc;
 }
 
 static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)

Return-Path: <SRS0=2Cbv=UL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71864C31E46
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 13:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4670620874
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 13:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSrXwfH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408642AbfFLNzv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:55:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37231 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407368AbfFLNzu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Jun 2019 09:55:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id 22so6653176wmg.2;
        Wed, 12 Jun 2019 06:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fjT883ULUg0KOjRNnt91vQVYlbimQpF6GMAdv9NYHKo=;
        b=KSrXwfH+q58M2eicVZryaiNSENDFaaaHyRQewqHcuQo+ReNIGhwdxOAX/gMVwkdSRH
         0sOMSUwHm99wKLSu73yn/ZwMIoPXXP4gfWp5FyHo8dIxsyrx3smrsGYvHM+1yuzmAVtk
         vNPiNaGGqUl3N37W1FivetZUVuKdun5i1zQkL9HlTvfCb2usP45LLssb1TLxYna5zu8K
         KvG+cnvH32uVxlJvybU5FoWEMS5KT1nZvpxpdlA8ET0S7StY+rD3jFFzE3Dg6EVEgKob
         WzJiLB6dJsLDGLZBnekVL3J/tNuHYTVglSy4RXOOKCHDXQxGCQ361xlym/rTKu+ziFE3
         Jz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fjT883ULUg0KOjRNnt91vQVYlbimQpF6GMAdv9NYHKo=;
        b=SQxmf6doqmOTx31NGrjDyTBW6R9IXCasHrNJgC3HcUCZRdZenfQp8rucWtZ0jOc29A
         q7poX+pl93th7xJYCWltSVJq1vVamZKzCdQBwj8xwNxnTP8JFp7ASC9O8nU9XboIZGnw
         sJfo+4/8fVzXPurGHO14wJHrYDLQPHgy0jR5oD3/PiCjZWawRvdLq74l9Nw3oN0QWaGj
         3NPGMRq95qQ48z+QT1Wb6+8D56wCKAjfUg8sVek/5xAuEr+rwK3o+R4iUhfnxFFiVvcw
         kHaaq5nJLXpWJI1/omLWJPSANw7if2hVpoa66MdU7yv4N8c36ES60uuRFaY6AC+Dcjzp
         lLmA==
X-Gm-Message-State: APjAAAUPpakjMAYcO0Q2J2zdmX8dwu9zUkSK/LcPhKwGBQ5qko9tzaFh
        +mOSNa869LpVM1kot53K7HJkQ5QBZ6c=
X-Google-Smtp-Source: APXvYqwb3RJyDC2/Is1wPOQDLwHdvdsQtIwG01k8n/BMfJKenlOPGWZNNktln9OyaIoymd0o+CAY9A==
X-Received: by 2002:a1c:cfc3:: with SMTP id f186mr20623819wmg.134.1560347748822;
        Wed, 12 Jun 2019 06:55:48 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id p2sm22560305wrx.90.2019.06.12.06.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 06:55:48 -0700 (PDT)
Date:   Wed, 12 Jun 2019 21:55:38 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] selinux: fix a missing-check bug in
 selinux_sb_eat_lsm_opts()
Message-ID: <20190612135538.GA4257@zhanggen-UX430UQ>
References: <20190612135114.GB4015@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612135114.GB4015@zhanggen-UX430UQ>
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
index 3ec702c..7a56f2a 100644
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
@@ -2661,6 +2662,13 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 	}
 	*to = '\0';
 	return 0;
+
+free_opt:
+	if (*mnt_opts) {
+		selinux_free_mnt_opts(*mnt_opts);
+		*mnt_opts = NULL;
+	}
+	return rc;
 }
 
 static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)

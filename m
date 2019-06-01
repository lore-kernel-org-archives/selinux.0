Return-Path: <SRS0=ThDI=UA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9F3C04AB6
	for <selinux@archiver.kernel.org>; Sat,  1 Jun 2019 02:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F154A270A7
	for <selinux@archiver.kernel.org>; Sat,  1 Jun 2019 02:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWBCB21H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfFACPn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 22:15:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45683 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfFACPn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 22:15:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id w34so4987048pga.12;
        Fri, 31 May 2019 19:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lTR0jTl5oD+Gm74Vzo4HY2zyqfQyqs0HXRg7trWVZDw=;
        b=rWBCB21HCyCQmjsTX5J+I8l8H9HdFrpIbABMMBZUeEykp/hqFwNyZA0QeFPrXhGpXM
         bVPFXYL0+LV36Q2SUZ7TamxilUye1NU1qZV3m1Mf9QBP0+cMdq4zvWa3DH1jYsdCoWIA
         SI9FfgJOEW+H7i4RAxxxUSNp//6rza4EPdPi1juhCaeTWG077LuqbCBjuOOz9T05vsyD
         iz6zyS1/4SVzPx5ZrWVt7nZUVkzDVaLJ+QZofE4Lb40EmZ5DNJWVWW/o2v9D9GM1uH2p
         f24y0AGYWNaOp5gxh/0AeQ37jRj9bWjFX6KSc0/Yvwn/JaQrIbgdfwRGbw+UvIVLDOs7
         yI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lTR0jTl5oD+Gm74Vzo4HY2zyqfQyqs0HXRg7trWVZDw=;
        b=pH/OGEflFicb8ovpwhXDq4JVDHm0mveWRTcgT04pB1laJs1GZ4YyGPZPXWDTFwgavd
         LM1x5kStGwkALfdQb0PVb0Z59yrUALJCnA83mKsENvvl9nBi96s7DphemP5WeYnhx6An
         bxlRLDAPyIuc3RDHT1sjM6C3sXxEz0fffh87nfbUALr3mgeT8AlqqFU1R+FStUE41gTi
         jOzkIxBci8+3qXlcuXgDoh4wOi7aO6n9GtJAf+bjJONnydv0HsAAJz/txCRkmANqLSCL
         /g6CmseLkicVHBr7X7h7moH7ZfPpgsZ1fiuCCNJRRneqflnweX66u6HLLr4ZT0cVwLVB
         OngA==
X-Gm-Message-State: APjAAAUZz3I42PnAHPAvmiy+8Ssyln6ZDuLXlXOR6imT0czJ5/HjQJZg
        8P+9lnznvjVrjCU6ghYPlL0=
X-Google-Smtp-Source: APXvYqw2UcKBg8KaCjlDxLjTX9foxqDY1SJrvZ1GppBqpCOrlc8ZOaEwdnuQZ7jf5NzrAX0z8BQ21Q==
X-Received: by 2002:aa7:9356:: with SMTP id 22mr14098622pfn.188.1559355342480;
        Fri, 31 May 2019 19:15:42 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id c17sm7934773pfo.114.2019.05.31.19.15.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 19:15:41 -0700 (PDT)
Date:   Sat, 1 Jun 2019 10:15:26 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH v3] selinux: lsm: fix a missing-check bug in
 selinux_sb_eat_lsm_opts()
Message-ID: <20190601021526.GA8264@zhanggen-UX430UQ>
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
Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Fixes: 99dbbb593fe6 ("selinux: rewrite selinux_sb_eat_lsm_opts()")
---
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3ec702c..f329fc0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2616,6 +2616,7 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 	char *from = options;
 	char *to = options;
 	bool first = true;
+	int ret;
 
 	while (1) {
 		int len = opt_len(from);
@@ -2635,15 +2636,16 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 						*q++ = c;
 				}
 				arg = kmemdup_nul(arg, q - arg, GFP_KERNEL);
+				if (!arg) {
+					ret = -ENOMEM;
+					goto free_opt;
+				}
 			}
 			rc = selinux_add_opt(token, arg, mnt_opts);
 			if (unlikely(rc)) {
+				ret = rc;
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
@@ -2661,6 +2663,12 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 	}
 	*to = '\0';
 	return 0;
+free_opt:
+	if (*mnt_opts) {
+		selinux_free_mnt_opts(*mnt_opts);
+		*mnt_opts = NULL;
+	}
+	return ret;
 }
 
 static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)

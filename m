Return-Path: <SRS0=2Cbv=UL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3C9C31E46
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 13:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE566208CA
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 13:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oq4e53UV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408080AbfFLNvY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:51:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36111 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407647AbfFLNvY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Jun 2019 09:51:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so17051017wrs.3;
        Wed, 12 Jun 2019 06:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rRZQ5CvqSo7Zb8yh0zW1MKbjakdIyzMfR0PSu30HFO8=;
        b=oq4e53UVMW1SsJJj/duLOfdOZ6GzRsQ4BiFAUCz5uhdn9GKeV76nGWMmy+7rHmoMFD
         80bfKfEJ69EkIBDnTXpZgHzrqEWw4I58peCNhNO1uP74xiDt1cbN+P09WM9CA/863F35
         H/shk5rpo2/RMeSW/QmZ1kDBPhAFpzgNJSqvyLRf2yCSS6+I0+J3PBzeacLq6fVTlCuI
         KX3SdouymQ9Q1zEwTPSHFgtwTJPeurlTHf5wkSXM5qVs+CW2rXm6t6nN75l9tDP5sU9Q
         P5Tj3Wu8AF28UbnQOU4ApcFgPjz/UAWupZbKg3msgwbSB4KaDqhMNT0Q8PXNMmNkbm30
         6kIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rRZQ5CvqSo7Zb8yh0zW1MKbjakdIyzMfR0PSu30HFO8=;
        b=gw26wyOxZnJIyZJ+gzUyNJpoSEDwW13YBjyj4Qb64PtPnCMthTCB8TFEPy3PQ22Da4
         qFE/TpnukWqzmvZf7PLePg0Xkd0R1uIs4n3UleQQ8+NnY2e0ckZA9qccXJ/LosK18yF9
         R0otJwCN6yS8q2t1QWGtEmB1/dc/O/zObQ0uoBda5pPLSQd0yvRusbjSycfaeARWvdlM
         BIzhryft6gAhyo1mm7uhuj3u0QF36d9kxym7mm6tApART9NhofyH4CcNdaVaUohl9dg1
         0Lmw8qIU9Xpd0bOUD3V8OZJTrhdl2p0GLzwPAidlRUx85a9iQ62AVhgSVDV/aa8O6D2q
         91iQ==
X-Gm-Message-State: APjAAAV1vyMDljHuSkHuLCFx9pprEc09hIWF20nCg0X/OYsmeFpgEUtE
        GfSICV8HLFSHrxMKrP3TG9A=
X-Google-Smtp-Source: APXvYqywrTlGs5MRkvztt/cIkFDfZTxl0Cd9acK0tvSiV2JH/7v5bKa0nA+YEjgqXOSG7ZwDOxjoFQ==
X-Received: by 2002:a05:6000:1285:: with SMTP id f5mr14215564wrx.85.1560347482708;
        Wed, 12 Jun 2019 06:51:22 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id c2sm18147195wrf.75.2019.06.12.06.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 06:51:22 -0700 (PDT)
Date:   Wed, 12 Jun 2019 21:51:14 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] selinux: fix a missing-check bug in
 selinux_sb_eat_lsm_opts()
Message-ID: <20190612135114.GB4015@zhanggen-UX430UQ>
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

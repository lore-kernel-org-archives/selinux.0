Return-Path: <SRS0=xZUV=UF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C982C04AB5
	for <selinux@archiver.kernel.org>; Thu,  6 Jun 2019 09:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C51120684
	for <selinux@archiver.kernel.org>; Thu,  6 Jun 2019 09:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gankvxH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfFFJXv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:23:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50708 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfFFJXv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jun 2019 05:23:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id f204so1660170wme.0;
        Thu, 06 Jun 2019 02:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=O+5z4ntuwugi22GIdYLSWkg/2i3n1YVE12LtK518dm8=;
        b=gankvxH1paBk1TRo7A5ugeSx/VRzXtByYA1W8dgck+dsa+6pJ6fRxRHqv5xdbiHFHJ
         7DLrn0B+QLGVSU/AOqHMIb5uEIC/V+j6XmLwz4B0RjMBd+7O9xZnntLqXcqs/xcU3T+5
         CmcCWckQPPo2btsqDg7gSw/JMbXAbj0oG5RQySMalFcsdNHDknJx7MGCftkCMpSF8q4u
         door876VMoxYlFaMY5PUPaUPenwE2a1I5Of32r4jPVPk0W9+AE/gbZUK6e3la+vwni/Y
         CuCt39RV/qvPLVQEMd5VGOaLrcK0N2K+f7eG/2N6rHYqN75fuKEkhRb51qSy+PJM9mXy
         czGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=O+5z4ntuwugi22GIdYLSWkg/2i3n1YVE12LtK518dm8=;
        b=SPsCD2sFGGzi8VGa6G2dzUCN0evjrjsVXPkTvoi4nJRiGdfGpu+4MU13C7sxtgYFRg
         MKI20rbhx/cDc+ppwR9l6tVkHLi7rUNX4MLIu6SankkXxfuMqQJev2IidTIPeIzcI32w
         GRN6byIS2beSqu9PSc8R1HxX2/8DwgrFh8vZo9fSxeQwIfqidh02bruQu9dAMe+uBTSY
         YK9Ca68sQXd2zzrH1k+Co0yTlm5B5zDqGkiuiCslYGubFGROR2uXexyOGanA0mNInGgH
         ocWvKCGh88IxF50USY+JhwBtwnTDwCUHC/vYPdrHmA9YNHnDv13JVIaVgWH4O8o78EN4
         xLUA==
X-Gm-Message-State: APjAAAXJSEmgvBJMz8rrvg9BzfYL7fBVjn65lmSUYLjckqmNM7QRWaNa
        mjBU2g9wqF5c3fH2By7xCAM=
X-Google-Smtp-Source: APXvYqzRJaLWZGWDtV+1oqoFuiQ/TF/KG8q4YJiF7E8ofqWh/JqjeE+iJEwLRgzTC4X22TWOoGItDQ==
X-Received: by 2002:a1c:c74a:: with SMTP id x71mr25796918wmf.121.1559813029331;
        Thu, 06 Jun 2019 02:23:49 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id j15sm1300940wrn.50.2019.06.06.02.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 02:23:48 -0700 (PDT)
Date:   Thu, 6 Jun 2019 17:23:42 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] selinux: lsm: fix a missing-check bug in
 selinux_add_mnt_opt( )
Message-ID: <20190606092342.GA21672@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In selinux_add_mnt_opt(), 'val' is allocated by kmemdup_nul(). It returns
NULL when fails. So 'val' should be checked. And 'mnt_opts' should be 
freed when error.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
Fixes: 757cbe597fe8 ("LSM: new method: ->sb_add_mnt_opt()")
---
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3ec702c..4e4c1c6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1052,15 +1052,23 @@ static int selinux_add_mnt_opt(const char *option, const char *val, int len,
 	if (token == Opt_error)
 		return -EINVAL;
 
-	if (token != Opt_seclabel)
-		val = kmemdup_nul(val, len, GFP_KERNEL);
+	if (token != Opt_seclabel) {
+			val = kmemdup_nul(val, len, GFP_KERNEL);
+			if (!val) {
+				rc = -ENOMEM;
+				goto free_opt;
+			}
+	}
 	rc = selinux_add_opt(token, val, mnt_opts);
 	if (unlikely(rc)) {
 		kfree(val);
-		if (*mnt_opts) {
-			selinux_free_mnt_opts(*mnt_opts);
-			*mnt_opts = NULL;
-		}
+		goto free_opt;
+	}
+	return rc;
+free_opt:
+	if (*mnt_opts) {
+		selinux_free_mnt_opts(*mnt_opts);
+		*mnt_opts = NULL;
 	}
 	return rc;
 }

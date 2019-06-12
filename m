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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3188DC31E46
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 13:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054AF20866
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 13:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyuWS3GD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfFLN2d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:28:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45340 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfFLN2d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Jun 2019 09:28:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so16888886wre.12;
        Wed, 12 Jun 2019 06:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CNyDYbzNuel0dys1IQuV1nwZIY+t4+V7JKy2VJB2erY=;
        b=pyuWS3GDx6wVjS6cEDEx8LRrR35dtKO2Hw2h58DLZsTWIJd3Ft4NL4fUx1jbTAY3kM
         tT3LiJai1UlggNCC7V4HBpRgxHqM769GllY6CBPd6sxD2dpSZAa1Y1RwJZX4EJ3x57Q2
         wOcm8yb3ksPFjwOk5A/V2YMiwxWUqBWmQylcFQT0qmQNWoVCs9XtSjwIWZYPmfYsYQjq
         +48PSC5R//q1PaMxHoGOPPjPafiSyNRmqrasFtAtx/TrzuWdDgi2OCSCDmsFAh+hj59a
         XUrt9hDF73gr/xGVcRnmKdQIKkl/YSzvKJNPSuN1Hl7wS9JV5HftOc5CJeemTfwRwDTg
         JVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CNyDYbzNuel0dys1IQuV1nwZIY+t4+V7JKy2VJB2erY=;
        b=lva8Bi2wvipy5R5bIpt9swu/k0iSxvJDzoP5TLWv4Jv25YTkNJgTxg7SRAqop8kwT3
         f+t+KrMKzRBa4Ikry4Z6DNb9BoaazmWUPyww8/NzMb0CNvehNTmgLPl4dymR11SsbQaM
         eCaBQxEZ92Os0AkVHd6uoPmpKee/xw0ina8zdsugfV56R74W7+P9pLQylMKJrq70+rKP
         zMR1a4nGQVpg9yJt2KiTncAgJ0yo9OttNBRVM3U2owAqzCeF+SgNp1Q0eEjKEef36XVC
         T3SFNx9eAOS3p+40FTeN0fgtiODxooYZtBU8CTRYczvf8DkBU7veWpNSteGLnDdxKp7S
         R2aA==
X-Gm-Message-State: APjAAAWdiyJjEQGqj7MTBVAvj52CRTBzxwX+jwQgmkLHjk/WvLwhP2dd
        Fgmn3q/1HB0Q8/D6NGe/XHVETnFewEc=
X-Google-Smtp-Source: APXvYqy9mInbXTt8kPG7W/KUJ5M8zbDloQLP+Puj+1e72bGowIAKkPFVRoBPZZxduk/GcAm86yd4Yg==
X-Received: by 2002:adf:8044:: with SMTP id 62mr7474470wrk.20.1560346111335;
        Wed, 12 Jun 2019 06:28:31 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id h90sm37628063wrh.15.2019.06.12.06.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 06:28:30 -0700 (PDT)
Date:   Wed, 12 Jun 2019 21:28:21 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] selinux: fix a missing-check bug in selinux_add_mnt_opt( )
Message-ID: <20190612132821.GA3816@zhanggen-UX430UQ>
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
index 3ec702c..b4b888e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1052,15 +1052,24 @@ static int selinux_add_mnt_opt(const char *option, const char *val, int len,
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
+
+free_opt:
+	if (*mnt_opts) {
+		selinux_free_mnt_opts(*mnt_opts);
+		*mnt_opts = NULL;
 	}
 	return rc;
 }

Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFBEC433EF
	for <selinux@archiver.kernel.org>; Thu, 14 Apr 2022 20:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbiDNUzq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Apr 2022 16:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiDNUzp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Apr 2022 16:55:45 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11E5BC840
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 13:53:18 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id hf18so4237434qtb.0
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 13:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=83qqNSD5a50lrVrVqmzIbyqHTWt0QTrr4wLT9zbM2Mg=;
        b=klTg/1/L4Ui0YlXwkDWXiPpF6hvUV8Fa3+joo2IQEuQiE040eHOhTC2ATttLT6YfEG
         tvc62Ym7gbQrhtih/ub9u8kZz0y73pc9/GJN/ibOzZ6Aa1ZKaqhf+y7QEnq3Z9SlTvZL
         vOsLrqWiC4WRpd8GJsAeAK29gs8C6sfs+T4cqvPLo57BfSyJPtqBGv0JuDOe/Xr6N6KO
         GIA8djXubdY1irXnWF/DQ1V2Dj841/kTWOsiumC6a/52LvdMzv01nts6jJ6Jfs1H9gvj
         xGG9WCxqmIQ3MKixf8MqBqOh+eudbCDY4I4uGCMC873CFoljcH841FzBnlB51fsrJuDh
         LXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=83qqNSD5a50lrVrVqmzIbyqHTWt0QTrr4wLT9zbM2Mg=;
        b=oVybLV3G8CBe1Yuu6+32s5lX0O46n11f1n5ChJLbMr345S7hBW7fUoJdBgQlii+eZk
         l2+ZM8TBnP2x8Z8/U8/4QhLtan9ZCdVfKUeASdSiWkwHg8QQ75sXk+Fghn04FY6qeHQ+
         WU10AvTsInGIdkPDF+E3GhrKHvjtHcG14rf3yUiEePYUqx6orP4+InxmT6YmwSGy/iWY
         Z84jhpOtmUsNkOaz/OaTURicemJZm+jY3ybyj6/6+gK8Q+IgdzyQi4AO0QRRft7W1tuK
         Dg06LaTlow6jtdMuZfNcqOlXk0KWrl64p9c3xylrAEihGtAe1w24a8yRWtuZHDjmECnB
         +hsQ==
X-Gm-Message-State: AOAM531T0/Hb43Lf7llr9qfevD7NqL582vxZyk3UvKAcuxDkMQVv6UZs
        9vIraYMRlJA1+dMCowKc2wcOSOA5NiWe
X-Google-Smtp-Source: ABdhPJw5pJy49aO2BSgxQOuEOZQEQZB3Hx0u6LPRYJvu/F+Swo/jzVs38p9CKHK3wG7zZGJVTI+PmQ==
X-Received: by 2002:ac8:6e87:0:b0:2eb:cd0e:b260 with SMTP id c7-20020ac86e87000000b002ebcd0eb260mr3330506qtv.340.1649969597686;
        Thu, 14 Apr 2022 13:53:17 -0700 (PDT)
Received: from localhost (pool-96-237-52-46.bstnma.fios.verizon.net. [96.237.52.46])
        by smtp.gmail.com with ESMTPSA id bs10-20020a05620a470a00b00680ae2f3decsm1671776qkb.8.2022.04.14.13.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 13:53:17 -0700 (PDT)
Subject: [PATCH] selinux: don't sleep when
 CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE is true
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 14 Apr 2022 16:53:16 -0400
Message-ID: <164996959615.228204.13557296900347416352.stgit@olly>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Unfortunately commit 81200b0265b1 ("selinux: checkreqprot is
deprecated, add some ssleep() discomfort") added a five second sleep
during early kernel boot, e.g. start_kernel(), which could cause a
"scheduling while atomic" panic.  This patch fixes this problem by
moving the sleep out of checkreqprot_set() and into
sel_write_checkreqprot() so that we only sleep when the checkreqprot
setting is set during runtime, after the kernel has booted.  The
error message remains the same in both cases.

Fixes: 81200b0265b1 ("selinux: checkreqprot is deprecated, add some ssleep() discomfort")
Reported-by: J. Bruce Fields <bfields@fieldses.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/include/security.h |    4 +---
 security/selinux/selinuxfs.c        |    2 ++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index f7e6be63adfb..393aff41d3ef 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -152,10 +152,8 @@ static inline bool checkreqprot_get(const struct selinux_state *state)
 
 static inline void checkreqprot_set(struct selinux_state *state, bool value)
 {
-	if (value) {
+	if (value)
 		pr_err("SELinux: https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-checkreqprot\n");
-		ssleep(5);
-	}
 	WRITE_ONCE(state->checkreqprot, value);
 }
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 6c8b6a0ddecf..8fcdd494af27 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -762,6 +762,8 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	}
 
 	checkreqprot_set(fsi->state, (new_value ? 1 : 0));
+	if (new_value)
+		ssleep(5);
 	length = count;
 
 	selinux_ima_measure_state(fsi->state);


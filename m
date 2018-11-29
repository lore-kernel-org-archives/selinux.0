Return-Path: <SRS0=qOBY=OI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB62AC43441
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 12:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7355D2081C
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 12:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7355D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeK3ACI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:02:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53186 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbeK3ACI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Nov 2018 19:02:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id r11-v6so2156616wmb.2
        for <selinux@vger.kernel.org>; Thu, 29 Nov 2018 04:56:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vFMSlwpIvOHYZBEXTxzaHGPly1ZVbM5GCygDsB/ndPA=;
        b=QP4hvXD1sksUuv2O3OOcz0orxiNdQMn72M2+xKnE6FOlyefjjdTAn+vgohSxgk76Zd
         5rorfYH8GXeY3t4FfLJpwc7F5+PoUFR4Y74edeFAmVa3KwKHsEBW2nRG/d82auH22hxw
         22qLDK/o7zm3RcQx/9hsQmxiVvRnm3M4b6Scl9oGCyrq4VuGpRq5DBvu6CsulAjcJxB8
         Ngc/srzAN5Qtl8AT+3an772UYNoO5hpyrts6uo0yAia6ftuoW632jqlSq7rbQJWMi3uo
         laKO4lOSsdLbieoOWognzDmsgRNVfSnr8l1p6fYWYCWnA4sv8BbZYKhLEyXb47XNlYqZ
         GtUA==
X-Gm-Message-State: AA+aEWYjSwzyZfHYTJkmMq8h1TXFPXl0yfVtAZo0wVAxV5DCckUMINzD
        gsG0rTyweoa/p/gOfPHweCSqjiWvtCs=
X-Google-Smtp-Source: AFSGD/WsoTelOxJoy/tHoyfFi3PepDptVVv/zrG8SRp6F82f9u/Xaq29mcF5AjgvjYgsQGoqZHtGHQ==
X-Received: by 2002:a1c:5506:: with SMTP id j6mr1796941wmb.44.1543496209880;
        Thu, 29 Nov 2018 04:56:49 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 125sm2344952wml.35.2018.11.29.04.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 04:56:49 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH v3 6/9] [fixup] fix handling of invalid context in convert_context
Date:   Thu, 29 Nov 2018 13:53:59 +0100
Message-Id: <20181129125402.5900-7-omosnace@redhat.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129125402.5900-1-omosnace@redhat.com>
References: <20181129125402.5900-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We can reuse the temporary string 's' and save one kstrdup() call.
---
 security/selinux/ss/services.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 3c5887838e12..e70c7c5d7f26 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1934,15 +1934,19 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 
 		rc = string_to_context_struct(args->newp, NULL, s,
 					      newc, SECSID_NULL);
+		if (rc == -EINVAL) {
+			/* Retain string representation for later mapping. */
+			context_init(newc);
+			newc->str = s;
+			newc->len = oldc->len;
+			rc = 0;
+			goto out;
+		}
 		kfree(s);
 		if (!rc) {
 			pr_info("SELinux:  Context %s became valid (mapped).\n",
 				oldc->str);
 			goto out;
-		} else if (rc == -EINVAL) {
-			/* Retain string representation for later mapping. */
-			rc = 0;
-			goto out;
 		} else {
 			/* Other error condition, e.g. ENOMEM. */
 			pr_err("SELinux:   Unable to map context %s, rc = %d.\n",
-- 
2.19.2


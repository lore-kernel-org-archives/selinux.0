Return-Path: <SRS0=qOBY=OI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EFEC04EBA
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 12:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE08F2081C
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 12:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE08F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeK3ACI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:02:08 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:36723 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbeK3ACI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Nov 2018 19:02:08 -0500
Received: by mail-wm1-f48.google.com with SMTP id a18so2145417wmj.1
        for <selinux@vger.kernel.org>; Thu, 29 Nov 2018 04:56:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AWBD3gnkw2z2gUixJ3zsNIjAdCtKiKPdXY/9H42fb5k=;
        b=BDl8sQGiEJut3NzPOFbiPweF7g4R4eWiZqXUI7Qv5N102n+Xq96AKb7bGoUExqLo0l
         rvA1P4d0yBlrlzGrk4Y2LveOOFeZd49dMxn6snGJ1I02UBKOYfHQ0PdbFfP1EgIxtrH/
         /e8bTyVKxaEkNvBsf1a1A8IkJMsqBDfLM+0gCg3du/WW78GZWz68MSkNRgc/LrVcdGb9
         bMjIdt0dyUp0S8CzB4QGQCM/HevBOmZ6IorRetww/taW0defbSQi4oQ8CnW8ACGHThSU
         oO/710FW5zW2CJkcVPc/0d5pOQPKse2RGeGcx0fnR3P4riBknLPi5oXWiJxYzn6PLrLj
         raGA==
X-Gm-Message-State: AA+aEWY7wySY48zneWdZZ4ZYeJrtVk27x69WyMq7jJthQvMXFMkPPye2
        0MDuLrJprgshHIEblqdMwTkOGjpL+8U=
X-Google-Smtp-Source: AFSGD/ULVoayY7dFls7prMFEl5uEpcsdL8bFFRNkFVC9mpMwy6OZjF+m03lcLncxU/HWImf/m+cV/w==
X-Received: by 2002:a1c:2b45:: with SMTP id r66mr1602543wmr.7.1543496210860;
        Thu, 29 Nov 2018 04:56:50 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 125sm2344952wml.35.2018.11.29.04.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 04:56:50 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH v3 7/9] [fixup] remove the now unneeded 'out' label
Date:   Thu, 29 Nov 2018 13:54:00 +0100
Message-Id: <20181129125402.5900-8-omosnace@redhat.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129125402.5900-1-omosnace@redhat.com>
References: <20181129125402.5900-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

---
 security/selinux/ss/services.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e70c7c5d7f26..2dc3189d684c 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1927,10 +1927,9 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 	args = p;
 
 	if (oldc->str) {
-		rc = -ENOMEM;
 		s = kstrdup(oldc->str, GFP_KERNEL);
 		if (!s)
-			goto out;
+			return -ENOMEM;
 
 		rc = string_to_context_struct(args->newp, NULL, s,
 					      newc, SECSID_NULL);
@@ -1939,20 +1938,18 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 			context_init(newc);
 			newc->str = s;
 			newc->len = oldc->len;
-			rc = 0;
-			goto out;
+			return 0;
 		}
 		kfree(s);
-		if (!rc) {
-			pr_info("SELinux:  Context %s became valid (mapped).\n",
-				oldc->str);
-			goto out;
-		} else {
+		if (rc) {
 			/* Other error condition, e.g. ENOMEM. */
 			pr_err("SELinux:   Unable to map context %s, rc = %d.\n",
 			       oldc->str, -rc);
-			goto out;
+			return rc;
 		}
+		pr_info("SELinux:  Context %s became valid (mapped).\n",
+			oldc->str);
+		return 0;
 	}
 
 	context_init(newc);
@@ -2015,9 +2012,7 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 			goto bad;
 	}
 
-	rc = 0;
-out:
-	return rc;
+	return 0;
 bad:
 	/* Map old representation to string and save it. */
 	rc = context_struct_to_string(args->oldp, oldc, &s, &len);
@@ -2028,8 +2023,7 @@ bad:
 	newc->len = len;
 	pr_info("SELinux:  Context %s became invalid (unmapped).\n",
 		newc->str);
-	rc = 0;
-	goto out;
+	return 0;
 }
 
 static void security_load_policycaps(struct selinux_state *state)
-- 
2.19.2


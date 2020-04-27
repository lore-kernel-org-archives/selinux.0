Return-Path: <SRS0=pnJ1=6L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F282C54FCB
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25F89206E2
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFyYZUcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgD0UXv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726972AbgD0UXn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 16:23:43 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4693C0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:43 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h69so9194828pgc.8
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C+dBKk4sABQjXVUTCO4ckp0agCDAnLVwhF1NHIjUJOw=;
        b=dFyYZUcPS5yjkIOBoF69NuqXsXt85uQBLWr5fuWrmfFvKSanzUqa44SLOWXIynm3ZX
         uOWKEZBaj/ZceHmxO+hQYyCSWd8BVBEs9vg4ctC3pWcupRYEwbFnQX+FSymGlgmRFvIh
         z4wxVToKx4VZ9eqC27yjZhiZRxxxHej8ksk+CRjbWR/oh/nDwlxft7x/Uf/74An1NnGU
         Bjm7T4W/+gWPMvfiFGF4rJnIgx0uZuASLwVzp+bYVBqPhaHMROCa9D13VqLxxEfFerGp
         FS95YcEBtKYmD4+5GS+aKFabihjcPK9kE6KS1Ij3WrtiCk/z/yxlnuJCjqJOGAWK+1jE
         NBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C+dBKk4sABQjXVUTCO4ckp0agCDAnLVwhF1NHIjUJOw=;
        b=BtLUJvndkOmF2o0rfqfyKLCA0TFxcqWLxpQFVgkal08hWHvhMkwj8B1Ayc6B5qJ6yZ
         tTqK3PiHMYitSy6yBaEAYtaskzkMvC7B/KQ89s+WdQ78covzWf6j8+uV28M5w+0cWhZ+
         TcSqT7KAFHAwD9kWLWC99GnT8tQ6yRC0QFwDUxtWZjt+kvwX9xYjEz+rhEUM4lOPBbew
         05IxQD0Gjprhqej5RtEg0jbObkbdHCqTQXYQZm3VpSIjQsTyhMFcXX2M/VR8lZySlPyN
         Mwj8m4lrE9vH5lx1COyaVeWgeR55f0I1CUC85+oN5cIEIeIbdepAVzbtwFm0VZEVeSJL
         8FKQ==
X-Gm-Message-State: AGi0PubkIvgOuVLfTitSCsoAT0XWVxAs36eKC9Dkxx0SESC/xgLST7PE
        dPb+LQVrZ4SehYbwtAe1RNY=
X-Google-Smtp-Source: APiQypK7+QpPv64NYv+DzwPBgAK+gF4fvoWU30IvSZ0/KcV+vzGrhOJjdqxpmSTIwYn9Jr0kJWwJ8g==
X-Received: by 2002:a63:651:: with SMTP id 78mr23584143pgg.129.1588019023165;
        Mon, 27 Apr 2020 13:23:43 -0700 (PDT)
Received: from localhost.localdomain ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id n30sm13329438pfq.88.2020.04.27.13.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:23:42 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v4 12/18] avc_init: annotate deprecated
Date:   Mon, 27 Apr 2020 15:23:09 -0500
Message-Id: <20200427202315.4943-13-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427202315.4943-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200427202315.4943-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/avc.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinux/avc.h
index c732824129cb..9b23357ad17f 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -200,7 +200,11 @@ extern int avc_init(const char *msgprefix,
 		    const struct avc_memory_callback *mem_callbacks,
 		    const struct avc_log_callback *log_callbacks,
 		    const struct avc_thread_callback *thread_callbacks,
-		    const struct avc_lock_callback *lock_callbacks);
+		    const struct avc_lock_callback *lock_callbacks)
+#ifdef __GNUC__
+	__attribute__ ((deprecated("Use avc_open and selinux_set_callback")))
+#endif
+;
 
 /**
  * avc_open - Initialize the AVC.
-- 
2.17.1


Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15CDC2BB55
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC45421927
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szMmDe8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405656AbgDPPoQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404563AbgDPPoL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 11:44:11 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD89C061A41
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:10 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d24so1485894pll.8
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J0tpirrIHAr4uXEvJ6/40RQ9XnxiPyilCzlgegHGP6M=;
        b=szMmDe8kI7h6fO6jBhhc6a/UtqGHSulo6gM8YjlaNH4wLD3sETq227bugLkam5ighI
         7EarM7nsELtgWfQmGGkiQqqn8wQoqRffNMBEWx906E+U54YmmRFavGqwCY5HvZCunOCY
         pmAHGMrxHdjp6FnR4/XBHHFnWv9FI0Cj8Bd16reMtIUzJc2RCBijUxx/K+g/+PDEM5HO
         ENq1ZB+2eWmOrfO4pYtKXNAtMrCiz1tPXgXpYJs8EQU71MGLBE8PU00K7/ybGa9nG21Y
         p56l49lYSqEYQ97KepXRdsc1wFfwPeJdFJN33qQ0HD4jToeMUbcjmWUXu3hoPx95S/wu
         VsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J0tpirrIHAr4uXEvJ6/40RQ9XnxiPyilCzlgegHGP6M=;
        b=bWDG8KoiUfTkTZz4eq6KaxaLMbdTnQPIZ1ZlAGSvfzOMYu50CtuQxgE0ZRi4S0jbey
         xIx+xpSOE66quv+DfLlzuPQa18/WEHllBsKUV3o7RXb2iLyHhHIZBHu+nd+rn/gXv9jA
         lYOKvEtXqvekvhEg02oAL81Cb+yc6cj8O+ce4TlMa2nNdYpprZV3EkKuElRfFrF82Qvh
         0q9fKJOuyNJaXdWc2IRpqMOte9MIqy7UN5fvTMx5vb5AlZG9LhGKilhREXtNf+DFIs2W
         HvMSnA/fKxa9FPrSkRkyl1Uges/HlpUqYPXn/f/kSf5rC2YM4BkXqyPnfAR+iBeEneqB
         dElA==
X-Gm-Message-State: AGi0PuaHIm3K/nRE/flPHHxyqnGgvFvikuYhLzu6OOFUKg0uWi1QdXp3
        8GC1QWzvNPs3JpeU7EKQ/Xo=
X-Google-Smtp-Source: APiQypIh3u2LyNa4GJJQizL0+dxYVdq3fpN4pczOHQAaKbUfAnBhBXp1VC/lIPwuZ9RS0ZhA+duHZQ==
X-Received: by 2002:a17:90a:ca8c:: with SMTP id y12mr6022970pjt.195.1587051850172;
        Thu, 16 Apr 2020 08:44:10 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id g25sm16888626pfh.55.2020.04.16.08.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:44:09 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v2 02/18] security_load_booleans: annotate deprecated
Date:   Thu, 16 Apr 2020 10:43:36 -0500
Message-Id: <20200416154352.21619-3-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416154352.21619-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200416154352.21619-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/selinux.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 948ca0689a07..38030fa8802e 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -325,7 +325,7 @@ extern int security_set_boolean_list(size_t boolcnt,
 /* Load policy boolean settings. Deprecated as local policy booleans no
  * longer supported. Will always return -1.
  */
-extern int security_load_booleans(char *path);
+extern int security_load_booleans(char *path) __attribute__ ((deprecated));
 
 /* Check the validity of a security context. */
 extern int security_check_context(const char * con);
-- 
2.17.1


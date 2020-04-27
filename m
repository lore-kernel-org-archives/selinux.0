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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DF4C54EEB
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C3432073C
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEW7OvOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgD0UXk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726898AbgD0UXk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 16:23:40 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CFDC0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h69so9194741pgc.8
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/gdQpJrLZSitamhMTzbbXA6Ho/ldV9+TjII6aENSShU=;
        b=jEW7OvOXudziRRmFHIDHealkP/YgEK+0oIJ74ZepXEztwehaLTfHVn9YgDu8eJWTmz
         4y1gRKAB5T6Wp55/KmLpVfBfqUDWQSLKwFwvvd6qKQTIqMIgeQeuqR8ixtb4IXkj+EnB
         7ryIS9YtrM6+x48yB3NO8ul2ICtUi4VQelyUfxFEMw1k+3rKZcohwxV7ug+hIRvCLGzJ
         QcDwhvCZ+enZe6KluEUrwCz89by7uDZf0lSuOQ2v0X8VimifFD73s02Myp/jny2aEJ2M
         taOsbHAvQq2PzBZVr61py4lAHgbDSwMuNVZvA4b7p6RkrktAaG6+QhNITY+6ljyz87R/
         8HPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/gdQpJrLZSitamhMTzbbXA6Ho/ldV9+TjII6aENSShU=;
        b=KIn1AAk61zzp7wa7wgoHybqC8qVkdpXbTbjqyLIdZhu69dpqOOb+9lhQsUQ2LJh76B
         3KNhGK5YCVPGpFTJsHUB1kEHnzTvzeTkSaSFrKMa1KjsFsY218o4IXOksIrQ+bY1iHsi
         W4mxOpKGxkzguMjZJ4S9OwcJa6a2wUFV/PF9XOdzVeeC5/FjmepZqBNGTzhrD0Fbm7kS
         tiFokCnL0UDRMkxqj0xjA/DhGvhDyRsrAgF38h627rz09wMftkBqVZ//EkwLH2TgfYO4
         NvCPwhNvNvGQTbJo3Jk2nlHYiGSce/nusVMT5w2dXH1yNbz3PHrNnRuUq2Zq58yb+VlA
         gwgw==
X-Gm-Message-State: AGi0PubKypgjIgiUPPE3L5fdpqCNHED5AYMkS3CFpdWemNsgnDRgEfuQ
        RP226PISyFG88lS+v8TOUBU=
X-Google-Smtp-Source: APiQypLayTQof9lYylm57lpgti/H1JfqmiELzzldfaR9W21rrDdqRYpQ8ESnur/ZOkmR/FlW1RG22w==
X-Received: by 2002:aa7:843a:: with SMTP id q26mr24613503pfn.240.1588019019220;
        Mon, 27 Apr 2020 13:23:39 -0700 (PDT)
Received: from localhost.localdomain ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id n30sm13329438pfq.88.2020.04.27.13.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:23:38 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v4 10/18] matchpathcon_fini: annotate deprecated
Date:   Mon, 27 Apr 2020 15:23:07 -0500
Message-Id: <20200427202315.4943-11-william.c.roberts@intel.com>
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
 libselinux/include/selinux/selinux.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 940c43eff8c9..b04f34a1b3bb 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -476,7 +476,11 @@ extern int matchpathcon_init(const char *path)
 extern int matchpathcon_init_prefix(const char *path, const char *prefix);
 
 /* Free the memory allocated by matchpathcon_init. */
-extern void matchpathcon_fini(void);
+extern void matchpathcon_fini(void)
+#ifdef __GNUC__
+   __attribute__ ((deprecated("Use selabel_close")))
+#endif
+;
 
 /* Resolve all of the symlinks and relative portions of a pathname, but NOT
  * the final component (same a realpath() unless the final component is a
-- 
2.17.1


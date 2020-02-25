Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F485C35E01
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0760320658
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3Qp2j08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbgBYUDD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:03:03 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36830 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgBYUDD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 15:03:03 -0500
Received: by mail-pj1-f67.google.com with SMTP id gv17so192355pjb.1
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 12:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tRfY3jxvNZrR+h46IvS2f/qCEZ7EEzHG2HA+QAqfxeg=;
        b=q3Qp2j08Dts0NNX+x6rSS537Dj98mpC7Z6eiQX0CtpwC4KcifDDOkHsvjJNWAij3aJ
         J66uybJOSSvqU7/Pf+hpUJ2Z1GepDoHgcNIzxvJ2/V+3dgJyoKECTLkVEkbmLnv4m1CN
         DwYOlvtUH6MBr5ALgnt+kxxPCsOdFHefVMXybqBohypJz5rjS3P4s6QuS9McqFqQ9XrG
         bXxd78Aa9W6KfiyIfJb4FHKYLkXpfk/Dnsl/QxYmEgESktsNknWc3UYET+AkutauwIh0
         AGgHH1tUri4cYbsQEm1dsfJmuKtJioy8TZdCipEWCL3SvbOCg83HJa8GXZoo8h4R06EB
         Zsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tRfY3jxvNZrR+h46IvS2f/qCEZ7EEzHG2HA+QAqfxeg=;
        b=JlpYF31YGoC4oxQyoILZZClvtLAYWXYOfwlbvEzf7YavV0+IG3CUmtda35rAjpJf04
         u7YSH+oeMFP+8hFUIRa9znUrlGDnYQjUWM4lmvp4CV3MrfKOxz3cEufrsUD2PTwZ8Kn2
         Ri56MI75chxBJAJb62i3IqKXwqQEWwCUPBpZldDNab8QoGytNHiXF/2Y0xvud9gRSbk3
         5/5a1b8on5c6K6x56XI6byzVZGKM8EGt0rp5bW5j2/C/Xpvao76AHWt9ZnVHAhmVMS+Z
         5UYgeJjp6uz44G9wuxqZAQfySlrEgtjf5DiAPty9L14bV5O8Og9XCNHGyz8pFWKFlnkA
         azQw==
X-Gm-Message-State: APjAAAXL8V0OQJXjxHuVso+DMY1P0TfgZV0QpzvRlrP0F2NK5ukP68r4
        84o3jfelLKL9KXiAWgAKO7c=
X-Google-Smtp-Source: APXvYqx3Mu2l1GZpwU+rjFa4Xzfr1NWhBkC28g9o5xABrDlC9Sc1R84EuiGdzoX1RkCUg1B2ptIi3Q==
X-Received: by 2002:a17:902:b587:: with SMTP id a7mr227686pls.82.1582660982937;
        Tue, 25 Feb 2020 12:03:02 -0800 (PST)
Received: from localhost.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id v29sm10636362pgc.72.2020.02.25.12.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:03:02 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     sds@tycho.nsa.gov, plautrba@redhat.com, selinux@vger.kernel.org
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH 14/17] selinux_internal.h: disable warnings on deprecated
Date:   Tue, 25 Feb 2020 14:02:16 -0600
Message-Id: <20200225200219.6163-15-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225200219.6163-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

selinux_internal.h marks the visibility of symbols, many of these are
the deprecated routines that get marked as hidden. This causes compilers
to warn about deprecated uses. However this is a valid annotation that
we want to keep, until the functions are finally removed.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/selinux_internal.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index f6a50cd36f63..2d9373b86190 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -2,6 +2,12 @@
 #include <pthread.h>
 #include "dso.h"
 
+/*
+ * Disable deprecated warnings for users internal to the library.
+ */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+
 hidden_proto(selinux_mkload_policy)
 hidden_proto(fini_selinuxmnt)
 hidden_proto(set_selinuxmnt)
@@ -181,3 +187,5 @@ extern int selinux_page_size hidden;
 #define SELINUXCONFIG SELINUXDIR "config"
 
 extern int has_selinux_config hidden;
+
+#pragma GCC diagnostic pop
-- 
2.17.1


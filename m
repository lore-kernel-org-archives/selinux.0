Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65481C433B4
	for <selinux@archiver.kernel.org>; Thu,  6 May 2021 17:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C04610A7
	for <selinux@archiver.kernel.org>; Thu,  6 May 2021 17:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbhEFRGr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 May 2021 13:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbhEFRGr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 May 2021 13:06:47 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB14C061574
        for <selinux@vger.kernel.org>; Thu,  6 May 2021 10:05:48 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id o5so5668325qkb.0
        for <selinux@vger.kernel.org>; Thu, 06 May 2021 10:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6jsFw/Ik7EkFLIYr8UbQq/CJAn2DzSSeGUPetRFDs/w=;
        b=r8ePO/ta9uCGTvEOaR0bradp1tmfvvCr27Clx1ykzBfJCGA7lPfrTspuQC26m6UA8O
         xjeDNFHeiiwBriDD3uFYamUzbvgVfAqy+ko4+klEvRzYK9c3sgmtQJY3rfittJPM5Ktc
         VOC8Ea5CLQQVTh/CFR8mtl09YV9hibRATxuz1LGGCmxxu5r9REROPzldYCRSSlxfi41c
         tn7bEwBi21sGGyC6g9Bu419v3YryG6SivuQzSHLstEIm4UIoH63OnlIhItlg6viYo1cS
         mQbP136xtSHnvLeIFfB+qHcn6VMAC7IFKu3L1ZtmkyRtI+eGs8pOwFaSIuE6mxWm6qMI
         YHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6jsFw/Ik7EkFLIYr8UbQq/CJAn2DzSSeGUPetRFDs/w=;
        b=NHXDh+yWB2UELjbDWDiP01h8f163xfZVXCaEHXWmm2dCYeU1BeBMPgyB3XdT1AC6Rx
         Lnboxsl13ZEFCN4AaoZx2c4DtU9RzGHHMu//vUWOuC/yiXy0ODp1ZOSSb3lMdidtoMSM
         oJbWaIl0OgQ6z8/oom3iOMMp6nNL9RUAj/gUORjnPyv2PUH+drkzRla101i4omks5nAb
         344Pw9a958u6ybgyOVUnngHNtA/vbziEBAsNrVfyIx+AqrWjLSeDX9wQz2i02vg9N54W
         2sqCMnuLuEXyyfQNK1ay+YRtBdAE73UrCoPsFxiWL6fM4jtzc+gla2EGAkVQMbKyfmWj
         0k3Q==
X-Gm-Message-State: AOAM530ZrMj4/1Ajkq/90x/lAxnkvzFkf5SBG+rTThFKpQU6hqHbX7i9
        BgfomRoFUnBWTRzw7ItVScWi1R2hKZNfVg==
X-Google-Smtp-Source: ABdhPJyoyv3QLU8p3NCbe+P1y7M8y8ldCfretlxdWjuZnH9LwlhEn84HJY7bOq6mM55vEaxk1gvmUw==
X-Received: by 2002:a37:a7c7:: with SMTP id q190mr5100325qke.476.1620320747270;
        Thu, 06 May 2021 10:05:47 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id f132sm2455965qke.104.2021.05.06.10.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 10:05:47 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/2] secilc/docs: Document the order that inherited rules are resolved in
Date:   Thu,  6 May 2021 13:05:37 -0400
Message-Id: <20210506170537.146337-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210506170537.146337-1-jwcart2@gmail.com>
References: <20210506170537.146337-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In the blockinherit section of the CIL documentation clearly state
the order in which inherited rules are resolved.

That order is:

1) The parent namespaces (if any) where the blockinherit rule is
   located with the exception of the global namespace.

2) The parent namespaces of the block being inherited (but not that
   block's namespace) with the exception of the global namespace.

3) The global namespace.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/docs/cil_container_statements.md | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/secilc/docs/cil_container_statements.md b/secilc/docs/cil_container_statements.md
index 7a7f67cc..41a4612c 100644
--- a/secilc/docs/cil_container_statements.md
+++ b/secilc/docs/cil_container_statements.md
@@ -103,6 +103,14 @@ blockinherit
 
 Used to add common policy rules to the current namespace via a template that has been defined with the [`blockabstract`](cil_container_statements.md#blockabstract) statement. All [`blockinherit`](cil_container_statements.md#blockinherit) statements are resolved first and then the contents of the block are copied. This is so that inherited blocks will not be inherited. For a concrete example, please see the examples section.
 
+Inherited rules are resolved by searching namespaces in the following order:
+
+-  The parent namespaces (if any) where the [`blockinherit`](cil_container_statements.md#blockinherit) rule is located with the exception of the global namespace.
+
+-  The parent namespaces of the block being inherited (but not that block's namespace) with the exception of the global namespace.
+
+-  The global namespace.
+
 Not allowed in [`macro`](cil_call_macro_statements.md#macro) blocks.
 
 **Statement definition:**
-- 
2.26.3


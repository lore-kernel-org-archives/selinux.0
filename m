Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6987C433ED
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 17:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4DC6141E
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 17:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhEGRix (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 May 2021 13:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbhEGRix (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 May 2021 13:38:53 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DE7C061574
        for <selinux@vger.kernel.org>; Fri,  7 May 2021 10:37:53 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id f8so2997872qth.6
        for <selinux@vger.kernel.org>; Fri, 07 May 2021 10:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qc24INqDpH9n53QfFon6+NSiYgfprG80aEUo2dO32BE=;
        b=cSg0m+eOG/VrT339AXYhwxim4gN9X/Gl7Os6IHK+AFoIJeoBsUfLhq1JkKBXN99CNu
         vSFVD36CkZgrp+T2vOeZcyPX+JhIyI21zSjdJZdOoXmBlK/j83HpxXcwT6y6eFgT1Lkx
         2UILe6mR6eSrxsunuN8faMmksy3xq7KavEqaioV9qgq7WFIBYTXYfxK7pTPMX683asaZ
         1+n0R/iaZyNiZZipt5gBSLUV9UikwdCOSyWud5Bl3W5obSmJYFjITiLNLdFZn+ne3QSz
         YQ2TD7QM+yDEaRxSgWx+9NgD1WkRtLq70gecRmBl1WPoF7Iy6O1jpRzejKhQmT9xPaDG
         Zz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qc24INqDpH9n53QfFon6+NSiYgfprG80aEUo2dO32BE=;
        b=I2veTVxR3tCqz70FNrzQRMV16rdgEj2+xQpVNjzkzzX04ZwOpklmZjjc2HCHR0Xfx6
         GM6/ivlvMumvv7kmNaai2P5SProtExpNUeTuA6mHUQuLYZo+YjNSABKgRbmGX/bOsLU9
         jLIv2Old6Zoffc+wDgtK3hx77s6Q7vLBoS4hzTukCc3XPp1tWMcLckLxJ9nOmi2PioUS
         4Jcu/JIEdm6YsBwjlaBlDlcPFr6xMQaTxv/MT9jgOC9E+YhSZ89bGdg3zHIpGg8QuYeC
         gK/7I+jv6It8vI8W58A90BxoWhxt7EuK3o6nh/4ykmhGjngD0oawAUfVg0N7Yo6Q1Nh0
         opbw==
X-Gm-Message-State: AOAM533PZJDRK7rivL8HWP43b2br+b75U1JrE/z0hJDN6wuqZxGXj69+
        rBe2Y3f5VLw2aHoEQLgRjVHawHeHKqPDOA==
X-Google-Smtp-Source: ABdhPJzk1aE3EjZ10xFwHoSgz+t7JlbeXu9vJB68Yi6tCBsFz3LYu7oeeeKg/lsujj5jisTbXKl5uQ==
X-Received: by 2002:a05:622a:100e:: with SMTP id d14mr10532051qte.143.1620409072691;
        Fri, 07 May 2021 10:37:52 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id f26sm5386475qtg.17.2021.05.07.10.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 10:37:52 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/3] secilc/docs: Relocate and reword macro call name resolution order
Date:   Fri,  7 May 2021 13:37:44 -0400
Message-Id: <20210507173744.198858-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210507173744.198858-1-jwcart2@gmail.com>
References: <20210507173744.198858-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The listing of the order was in the macro section, but it belongs
in the call section.

Move the listing of the order to the call section and provide a
better explanation.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/docs/cil_call_macro_statements.md | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/secilc/docs/cil_call_macro_statements.md b/secilc/docs/cil_call_macro_statements.md
index 352a9fb0..3cc14bf8 100644
--- a/secilc/docs/cil_call_macro_statements.md
+++ b/secilc/docs/cil_call_macro_statements.md
@@ -8,6 +8,18 @@ Instantiate a [macro](#macro) within the current namespace. There may be zero or
 
 Each parameter passed contains an argument to be resolved by the [macro](#macro), these can be named or anonymous but must conform to the parameter types defined in the [`macro`](cil_call_macro_statements.md#macro) statement.
 
+Macro rules are resolved by searching in the following order:
+
+-   The macro namespace (If found this means that the name was declared in the macro and is now declared in the namespace of one of the parents of the call.)
+
+-   The call arguments
+
+-   The parent namespaces of the macro being called (if any) with the exception of the global namespace.
+
+-   The parent namespaces of the call (if any) with the exception of the global namespace.
+
+-   The global namespace
+
 **Statement definition:**
 
 ```secil
@@ -46,18 +58,6 @@ macro
 
 Declare a macro in the current namespace with its associated parameters. The macro identifier is used by the [`call`](cil_call_macro_statements.md#call) statement to instantiate the macro and resolve any parameters. The call statement may be within the body of a macro.
 
-When resolving macros the following places are checked in this order:
-
--   Items defined inside the macro
-
--   Items passed into the macro as arguments
-
--   Items defined in the same namespace of the macro
-
--   Items defined in the callers namespace
-
--   Items defined in the global namespace
-
 [`tunable`](cil_conditional_statements.md#tunable), [`in`](cil_container_statements.md#in), [`block`](cil_container_statements.md#block), [`blockinherit`](cil_container_statements.md#blockinherit), [`blockabstract`](cil_container_statements.md#blockabstract), and other [`macro`](cil_call_macro_statements.md#macro) statements are not allowed in [`macro`](cil_call_macro_statements.md#macro) blocks.
 
 **Statement definition:**
-- 
2.26.3


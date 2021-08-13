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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74431C432BE
	for <selinux@archiver.kernel.org>; Fri, 13 Aug 2021 11:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5251D61042
	for <selinux@archiver.kernel.org>; Fri, 13 Aug 2021 11:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbhHMLwb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Aug 2021 07:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239044AbhHMLwa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Aug 2021 07:52:30 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D665FC061756
        for <selinux@vger.kernel.org>; Fri, 13 Aug 2021 04:52:03 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id y130so10384610qkb.6
        for <selinux@vger.kernel.org>; Fri, 13 Aug 2021 04:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yrINhV9dksqmtpVS2d2kGaMCqtMAbrXlsYav9HXqSH4=;
        b=EY5U3O9u01DC9wwmy7CdNGZYErPjsmAEqODRnfUWO2+PkPpr/YP2Pp9kBbcuXcsMMZ
         N9k7a0F2Ez0rjVR2USNDwx/QSgHrSRYrRN4H1HLCkWD4OPMpetv23iNHJoc2/h7XN1vb
         xzgP/zJD3dpwiQRNWtB4x49P732UZkbKDkbrNx88+RVEWbf8JGJr5zo/0mEb49BSyPm9
         21RUEXDA983AeSDEFzd/GK9608//uWVHv+Tqsl8hOZEBDj5fJ4egIUC0KfIRFWlOXg7d
         FGcCq9ek6mB5IQBs9PJDNNlc/71DGByt3px9kUBi/XoEODy7rEYkIMiW7RhMG35hMCgT
         GxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yrINhV9dksqmtpVS2d2kGaMCqtMAbrXlsYav9HXqSH4=;
        b=sDWUj89DoAVPP35ynl0aZUGogSAocFhmQZKBHZSBIlQKOsOjQzyiQcTZKpUCC/lINY
         lms9PcBGgl2Ef7Xu3BlZY/Ac0U8VlgyI+4HFOtzy/Boy4ZAXCGs7XdTZeeyqSVltuzdE
         b13qS9VdgliA/JMtc1UtM9IGT1GvjpJQMip86I3Yt01dJ7gsOPcfPcXFcbk86QX7uPEB
         9LlKXiRrplAKyATUQZJgfF4gcO95LpK4rJ/qEY6cQXDSrLzlrz/i4uZcea4ebxWn+qTA
         9Dc/N+mm3PuVJrRfllCgx5xpiUToGR9wzm59pZN0DjxDVwYrpTUPutFKEs6SGaOZo5nm
         CVig==
X-Gm-Message-State: AOAM5336oCgfaarwurho3IG2P3i/cRDq2bjwmOjoldCbQWs/0BwgDYP0
        cr6R6fD0m1mFrcSjcAUr7XwRtMUh8Tc/eg==
X-Google-Smtp-Source: ABdhPJwLv+OoZ3lAKEuKpwjWdHBDqyMO+/kJzYIypSZQ72NI+jP2XPElhXTgVUEpXXe8DChk+ErUvw==
X-Received: by 2002:a37:a613:: with SMTP id p19mr1739969qke.28.1628855522961;
        Fri, 13 Aug 2021 04:52:02 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id f5sm666975qtb.57.2021.08.13.04.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 04:52:02 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dominick.grift@defensec.nl, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/2] libsepol/secilc/docs: Update the CIL documentation
Date:   Fri, 13 Aug 2021 07:51:57 -0400
Message-Id: <20210813115157.789302-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210813115157.789302-1-jwcart2@gmail.com>
References: <20210813115157.789302-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Update the CIL documentation for the in-statement processing and
duplicate macro and block declarations with block inheritance.

Duplicate macro and block declarations are allowed if they occur as
the result of block inheritance. Document the fact that inherited
macros are overridden by any macros already declared in a
namespace and that declaring a block in a namespace that will
inherit a block with the same name can be used to allow in-statements
to be used on the block.

The new in-statement syntax still supports the old syntax but adds
the ability to specify whether the in-statement should be resolved
before or after block inheritance is resolved.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/docs/cil_call_macro_statements.md |  2 ++
 secilc/docs/cil_container_statements.md  | 12 +++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/secilc/docs/cil_call_macro_statements.md b/secilc/docs/cil_call_macro_statements.md
index 3cc14bf8..dcc6139f 100644
--- a/secilc/docs/cil_call_macro_statements.md
+++ b/secilc/docs/cil_call_macro_statements.md
@@ -60,6 +60,8 @@ Declare a macro in the current namespace with its associated parameters. The mac
 
 [`tunable`](cil_conditional_statements.md#tunable), [`in`](cil_container_statements.md#in), [`block`](cil_container_statements.md#block), [`blockinherit`](cil_container_statements.md#blockinherit), [`blockabstract`](cil_container_statements.md#blockabstract), and other [`macro`](cil_call_macro_statements.md#macro) statements are not allowed in [`macro`](cil_call_macro_statements.md#macro) blocks.
 
+Duplicate [`macro`](cil_call_macro_statements.md#macro) declarations in the same namespace will normally cause an error, but inheriting a macro into a namespace (with [`blockinherit`](cil_container_statements.md#blockinherit)) that already has a macro with the same name will only result in a warning message and not cause an error. This behavior allows inherited macros to be overridden with local ones.
+
 **Statement definition:**
 
 ```secil
diff --git a/secilc/docs/cil_container_statements.md b/secilc/docs/cil_container_statements.md
index 41a4612c..f70160cb 100644
--- a/secilc/docs/cil_container_statements.md
+++ b/secilc/docs/cil_container_statements.md
@@ -10,6 +10,8 @@ Not allowed in [`macro`](cil_call_macro_statements.md#macro) and [`optional`](ci
 
 [`sensitivity`](cil_mls_labeling_statements.md#sensitivity) and [`category`](cil_mls_labeling_statements.md#category) statements are not allowed in [`block`](cil_container_statements.md#block) blocks.
 
+Duplicate declarations of a [`block`](cil_container_statements.md#block) in the same namespace will normally cause an error, but inheriting a block into a namespace (with [`blockinherit`](cil_container_statements.md#blockinherit)) that already has a block with the same name will only result in a warning message and not cause an error. The policy from both blocks will end up in the binary policy. This behavior was used in the past to allow a block to be declared so that an [`in-statement`](cil_container_statements.md#in) could be used on it, but now an [`in-statement`](cil_container_statements.md#in) can be specified to occur after inheritance, so this behavior is not necessary (but is still allowed).
+
 **Statement definition:**
 
 ```secil
@@ -278,7 +280,7 @@ This example will instantiate the optional block `ext_gateway.move_file` into po
 in
 --
 
-Allows the insertion of CIL statements into a named container ([`block`](cil_container_statements.md#block), [`optional`](cil_container_statements.md#optional) or [`macro`](cil_call_macro_statements.md#macro)).
+Allows the insertion of CIL statements into a named container ([`block`](cil_container_statements.md#block), [`optional`](cil_container_statements.md#optional) or [`macro`](cil_call_macro_statements.md#macro)). This insertion can be specified to occur either before or after block inheritance has been resolved.
 
 Not allowed in [`macro`](cil_call_macro_statements.md#macro), [`booleanif`](cil_conditional_statements.md#booleanif), and other [`in`](cil_container_statements.md#in) blocks.
 
@@ -287,7 +289,7 @@ Not allowed in [`macro`](cil_call_macro_statements.md#macro), [`booleanif`](cil_
 **Statement definition:**
 
 ```secil
-    (in container_id
+    (in [before|after] container_id
         cil_statement
         ...
     )
@@ -306,10 +308,14 @@ Not allowed in [`macro`](cil_call_macro_statements.md#macro), [`booleanif`](cil_
 <td align="left"><p>The <code>in</code> keyword.</p></td>
 </tr>
 <tr class="even">
+<td align="left"><p><code>before|after</code></p></td>
+<td align="left"><p>An optional value that specifies whether to process the [`in`](cil_container_statements.md#in) <code>before</code> or <code>after</code> block inheritance. If no value is specified, then the [`in`](cil_container_statements.md#in) will be processed before block inheritance.</p></td>
+</tr>
+<tr class="odd">
 <td align="left"><p><code>container_id</code></p></td>
 <td align="left"><p>A valid <code>block</code>, <code>optional</code> or <code>macro</code> namespace identifier.</p></td>
 </tr>
-<tr class="odd">
+<tr class="even">
 <td align="left"><p><code>cil_statement</code></p></td>
 <td align="left"><p>Zero or more valid CIL statements.</p></td>
 </tr>
-- 
2.31.1


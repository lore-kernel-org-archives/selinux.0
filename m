Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549E4C433ED
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 20:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223F661376
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 20:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhEKUEX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 May 2021 16:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhEKUEX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 May 2021 16:04:23 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E17C06175F
        for <selinux@vger.kernel.org>; Tue, 11 May 2021 13:03:15 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id i67so20051697qkc.4
        for <selinux@vger.kernel.org>; Tue, 11 May 2021 13:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qc24INqDpH9n53QfFon6+NSiYgfprG80aEUo2dO32BE=;
        b=YzHl9I6HHqhj8JadwnJmtXbzKlzvjnx0JkrkbXklToFNLG+xoB+tjOR261iuZOpzrU
         oEWDVWT0INa+E4QSD0dsWzXOnS2oikBVuaHj24VSAa2mBI6RQLgcGsYOdU84WSCW1h2Y
         Y+Lb6q98j7B7JtVdL7+o6qJVoTf5LjBjaB3472S37DDVPxIZakxIjJoNwW8n3uB7DsZu
         TeaUM6GlhUWLkeVkWDwO2CG1yGZfTOvTkKVZfnLFMVe219tbE4XmDEfz0WOStaue8zch
         f4AAMchgT8fYEbmGUGhMgsypXnmNhfMFnKQH3yCZ2kh2xNxKeDOhwtsUNCVpd3U5KnIx
         9gLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qc24INqDpH9n53QfFon6+NSiYgfprG80aEUo2dO32BE=;
        b=DGRjdEvQP5bLrSnDO2iS1AW48oaCJzSJrvMq8VoBhNvupd3qkfi27kwWNz8R5IFHZP
         yjjBmx416BcY31fm5/rlltaCdcuhTVt/4W9bIJp+itIsKNM4Ek557j8GJxWWenZMT1SD
         abuZ7QJEDH0/GWKbsWCZHyLVVtGALi0O5xh/N0tcTrirjxpagaBguDyAUnooW29pYsHx
         OOzDEbE0vmO/quYpsEIHimdi9Giouk65aSSYIzroR6IVlElL9/1giFoM4cTj1sWXA0Ha
         PFnzsO6DYAXFM9XKL49rUvb5wk65W4mzin4Yez+NLS4U6vY+tJInSaz/jn0KiGlD4iUa
         5VSw==
X-Gm-Message-State: AOAM532NXY6Jp4V54C2PCERMfCxjIg7ANj0v/I20cWKHl/g5RXwayrQm
        IPGymRqNNLa8piF9R7xBAi5qMXZPvRDvNw==
X-Google-Smtp-Source: ABdhPJye0DHyl1D0RjVE38Q6Fzw8odeeXDz8968Z/ehM1zTwZ1VDJh65ucDTxd8DREzuyOF24t21zA==
X-Received: by 2002:a05:620a:3c3:: with SMTP id r3mr29016127qkm.35.1620763394606;
        Tue, 11 May 2021 13:03:14 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id z9sm4642533qtf.10.2021.05.11.13.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 13:03:14 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/5 v2] secilc/docs: Relocate and reword macro call name resolution order
Date:   Tue, 11 May 2021 16:03:01 -0400
Message-Id: <20210511200301.407855-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210511200301.407855-1-jwcart2@gmail.com>
References: <20210511200301.407855-1-jwcart2@gmail.com>
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


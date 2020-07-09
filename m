Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FD9C433E1
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 08:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0E6E20708
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 08:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WA/H3Kjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgGIIgm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgGIIgl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jul 2020 04:36:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D8AC061A0B
        for <selinux@vger.kernel.org>; Thu,  9 Jul 2020 01:36:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l2so951877wmf.0
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2020 01:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0bJq+/1jTYEI2UADdh2lGARD0myg1EItl8gGHU2hAkE=;
        b=WA/H3KjyCldHt617NioC5HGu9oviv/uCF+nP+7nSb9wxfUfPk5XRBwI5QrHI/PchYW
         CZmrx/EOuoHoTADSn7+twEX4NLJX1wKHTKt0nnyUIXsm1pkZxbae1S/79/te6C7s2RsE
         Q/a/G6dNsU0D2FateOF/6ziu7ExC5g0EPJZrF/sfWZMo93j8pnsKuGsWyspZo5H1iafd
         u2McRukxl3b1uWcT4i4pg4DViLw7iyVt553mnQnA8Fr98yUQGSv5EWFl8XIQom/CA5FQ
         rOu8KJ/QtWED7Xr4Fz0CDgLj2p4dZnibDCjKxpTc1pbkHXApIB6Mm4XNUJzsnxmASJ7O
         WFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0bJq+/1jTYEI2UADdh2lGARD0myg1EItl8gGHU2hAkE=;
        b=rdB3l/pOnp44xbAcAdKoZF8UaWmstd0rw6jrfsRi5RIyjVjfiDAfGbkcV0tkOMPkqU
         6/TGWBV5DE8AgFNI6trkHnBhKvvzEF0r96zMz/V23go63ZO+OFt+F6/q/x+lfN84ki4q
         01kmVAVOfPeMlrB/XBqaVf6FwxKA1e0nKspJgpXExyVUlU1ICvYkVrfFX4oLqR03nMTZ
         Tj5YFRRCHpECjclqkNMNQGQbuYLbCm5zV661ezCxPhmQBWbcTFVz64jw5aE2z4ZXKK0B
         0TmQY9YBJrqscUS74xlHipEZeVXOF57hY9C5p4zuN5beM73jSXVeqk8D184DvdIPXpwH
         3mtQ==
X-Gm-Message-State: AOAM5309EWXRzqasPAWSI26CuGAA7tJAbT8EsUTPwNDKcoQASTN0npaQ
        nQQoLKoB4nVBAWkr0aMYG+yEOh8/
X-Google-Smtp-Source: ABdhPJyitap0FvSwxEBX0HV9CHJE6aCADkWl3SqQeZ+9OC+8qvmT9BrBR0fTAW1DOmyHk57Vv3YMZg==
X-Received: by 2002:a7b:c746:: with SMTP id w6mr13924306wmk.171.1594283798224;
        Thu, 09 Jul 2020 01:36:38 -0700 (PDT)
Received: from ?IPv6:2a02:810d:4bc0:8098:78d9:64c7:b7ab:1b3a? ([2a02:810d:4bc0:8098:78d9:64c7:b7ab:1b3a])
        by smtp.gmail.com with ESMTPSA id f15sm3395915wmj.44.2020.07.09.01.36.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 01:36:37 -0700 (PDT)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Subject: [PATCH v2] Update the cil docs to match the current behaviour.
To:     selinux@vger.kernel.org
References: <CAP+JOzTduRu0U7gdvCrxRqTW+VUWc_imaOc0ozXGYe_GpXM9Cw@mail.gmail.com>
Autocrypt: addr=j2468h@gmail.com; keydata=
 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
 MzTZEAm15uwFxq66
Message-ID: <2da3deec-0098-9847-7412-9d9654b6645f@gmail.com>
Date:   Thu, 9 Jul 2020 10:36:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAP+JOzTduRu0U7gdvCrxRqTW+VUWc_imaOc0ozXGYe_GpXM9Cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Some features where dropped or change since the docs were last updated.

Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>
---

Notes:
    Updated to include additional fixes and a correct Signed-off-by line.

 secilc/docs/cil_call_macro_statements.md | 6 ++++--
 secilc/docs/cil_container_statements.md  | 2 +-
 secilc/docs/cil_reference_guide.md       | 2 +-
 secilc/docs/cil_user_statements.md       | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/secilc/docs/cil_call_macro_statements.md b/secilc/docs/cil_call_macro_statements.md
index 17c46ed9..98b70368 100644
--- a/secilc/docs/cil_call_macro_statements.md
+++ b/secilc/docs/cil_call_macro_statements.md
@@ -44,7 +44,7 @@ macro
 
 Declare a macro in the current namespace with its associated parameters. The macro identifier is used by the [`call`](cil_call_macro_statements.md#call) statement to instantiate the macro and resolve any parameters. The call statement may be within the body of a macro.
 
-Note that when resolving macros the callers namespace is not checked, only the following places:
+When resolving macros the following places are checked in this order:
 
 -   Items defined inside the macro
 
@@ -52,6 +52,8 @@ Note that when resolving macros the callers namespace is not checked, only the f
 
 -   Items defined in the same namespace of the macro
 
+-   Items defined in the callers namespace
+
 -   Items defined in the global namespace
 
 **Statement definition:**
@@ -80,7 +82,7 @@ Note that when resolving macros the callers namespace is not checked, only the f
 <tr class="odd">
 <td align="left"><p><code>param_type</code></p></td>
 <td align="left"><p>Zero or more parameters that are passed to the macro. The <code>param_type</code> is a keyword used to determine the declaration type (e.g. <code>type</code>, <code>class</code>, <code>categoryset</code>).</p>
-<p>The list of valid <code>param_type</code> entries are: <code>type</code>, <code>typealias</code>, <code>role</code>, <code>user</code>, <code>sensitivity</code>, <code>sensitivityalias</code>, <code>category</code>, <code>categoryalias</code>, <code>categoryset</code> (named or anonymous), <code>level</code> (named or anonymous), <code>levelrange</code> (named or anonymous), <code>class</code>, <code>classpermission</code> (named or anonymous), <code>ipaddr</code> (named or anonymous), <code>block</code>, <code>name</code> (a string), <code>classmap</code></p></td>
+<p>The list of valid <code>param_type</code> entries are: <code>type</code>, <code>typealias</code>, <code>role</code>, <code>user</code>, <code>sensitivity</code>, <code>sensitivityalias</code>, <code>category</code>, <code>categoryalias</code>, <code>categoryset</code> (named or anonymous), <code>level</code> (named or anonymous), <code>levelrange</code> (named or anonymous), <code>class</code>, <code>classpermission</code> (named or anonymous), <code>ipaddr</code> (named or anonymous), <code>name</code> (a string), <code>classmap</code></p></td>
 </tr>
 <tr class="even">
 <td align="left"><p><code>param_id</code></p></td>
diff --git a/secilc/docs/cil_container_statements.md b/secilc/docs/cil_container_statements.md
index a570cb23..58b3224d 100644
--- a/secilc/docs/cil_container_statements.md
+++ b/secilc/docs/cil_container_statements.md
@@ -254,7 +254,7 @@ This example will instantiate the optional block `ext_gateway.move_file` into po
 in
 --
 
-Allows the insertion of CIL statements into a named container ([`block`](cil_container_statements.md#block), [`optional`](cil_container_statements.md#optional) or [`macro`](cil_call_macro_statements.md#macro)). This statement is not allowed in [`booleanif`](cil_conditional_statements.md#booleanif) or [`tunableif`](cil_conditional_statements.md#tunableif) statements.
+Allows the insertion of CIL statements into a named container ([`block`](cil_container_statements.md#block), [`optional`](cil_container_statements.md#optional) or [`macro`](cil_call_macro_statements.md#macro)). This statement is not allowed in [`booleanif`](cil_conditional_statements.md#booleanif) or [`tunableif`](cil_conditional_statements.md#tunableif) statements. This only works for containers that aren't inherited using [`blockinherit`](cil_conditional_statements.md#blockinherit).
 
 **Statement definition:**
 
diff --git a/secilc/docs/cil_reference_guide.md b/secilc/docs/cil_reference_guide.md
index 1b1fccca..3e33c5f7 100644
--- a/secilc/docs/cil_reference_guide.md
+++ b/secilc/docs/cil_reference_guide.md
@@ -176,7 +176,7 @@ Should the symbol not be prefixed with a dot, the current namespace would be sea
 Expressions
 -----------
 
-Expressions may occur in the following CIL statements: [`booleanif`](cil_conditional_statements.md#booleanif), [`tunableif`](cil_conditional_statements.md#tunableif), [`classpermissionset`](cil_class_and_permission_statements.md#classpermissionset), [`typeattributeset`](cil_type_statements.md#typeattributeset), [`roleattributeset`](cil_role_statements.md#roleattributeset), [`categoryset`](cil_mls_labeling_statements.md#categoryset), [`constrain`](cil_constraint_statements.md#constrain), [`mlsconstrain`](cil_constraint_statements.md#mlsconstrain), [`validatetrans`](cil_constraint_statements.md#validatetrans), [`validatetrans`](cil_constraint_statements.md#validatetrans)
+Expressions may occur in the following CIL statements: [`booleanif`](cil_conditional_statements.md#booleanif), [`tunableif`](cil_conditional_statements.md#tunableif), [`classpermissionset`](cil_class_and_permission_statements.md#classpermissionset), [`typeattributeset`](cil_type_statements.md#typeattributeset), [`roleattributeset`](cil_role_statements.md#roleattributeset), [`categoryset`](cil_mls_labeling_statements.md#categoryset), [`constrain`](cil_constraint_statements.md#constrain), [`mlsconstrain`](cil_constraint_statements.md#mlsconstrain), [`validatetrans`](cil_constraint_statements.md#validatetrans), [`mlsvalidatetrans`](cil_constraint_statements.md#mlsvalidatetrans)
 
 CIL expressions use the [prefix](http://www.cs.man.ac.uk/~pjj/cs212/fix.html) or Polish notation and may be nested (note that the kernel policy language uses postfix or reverse Polish notation). The syntax is as follows, where the parenthesis are part of the syntax:
 
diff --git a/secilc/docs/cil_user_statements.md b/secilc/docs/cil_user_statements.md
index bbd76eff..26e45510 100644
--- a/secilc/docs/cil_user_statements.md
+++ b/secilc/docs/cil_user_statements.md
@@ -260,7 +260,7 @@ This example will associate `unconfined.user` with a named [`levelrange`](cil_ml
     (categoryorder (c0 c1))
     (sensitivity s0)
     (sensitivity s1)
-    (dominance (s0 s1))
+    (sensitivityorder (s0 s1))
     (sensitivitycategory s0 (c0 c1))
     (level systemLow (s0))
     (level systemHigh (s0 (c0 c1)))
-- 
2.27.0


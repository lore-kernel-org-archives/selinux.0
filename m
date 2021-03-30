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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3C1C433E1
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA83961864
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhC3Rkf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhC3RkN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Mar 2021 13:40:13 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B13EC061574
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:40:13 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id x27so8573431qvd.2
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WzMghQUs1oH00BdHfNvi3ygniiFTmqhXyLpJ3N4Slu4=;
        b=Rxr1l7acOHV7/JbZBI6OP2R57DwjdzYQ6WHM0MgO7B2wlKg05s/24e1P16IJM7A+TX
         k6VRDFqGuY6dzBiwpQq4jH4UKbHmMIMPAxTxKP+ovGJoiWs+jheBVzRRshvx9CNTud/J
         PBcdTU42ItpPgMoXmC/9+UHbd8GQ4w30jzgqS0epgielC7GubJyX9j9gltrCYGE1cp8E
         HX/SrYZYC2luGszV2Bdjpz90lYTaJy44+hc3gT/rowmdjPsnAmaWFTxS1PFkQI0SOSsb
         x3OHDwyu+cI2dIPYfL3KZgB0w/jhSWdZVC/UXZYYzwxU+Z9pCWHVY1OurPso+yGijAQf
         nLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WzMghQUs1oH00BdHfNvi3ygniiFTmqhXyLpJ3N4Slu4=;
        b=IvON5HABGmhO7y9cFxopWQ0ODA21+OI+GWVhGuZihtfaGJxHH2NfWhY5R+Zeny/Bxh
         dCySfglrLQIDKg3GRysTbGxWDS7q9xa2YAIq/94OduqVmiZGz5B0XhvVGZVzZ4URiZ76
         E3r9ses2ZgKOJoAZsmjZj1d5JrWF2nWKZAB0Rqtzx9SReExjsb2H1c7aH7v7/6D9yd19
         WHZGLrIA2h/BQmfzhhfWEJ3oAb4rZc4kPSC86GXOTXAQ2sPjnDxm0HtBuiCvSByJth0z
         ghKxzRAv3dMp3gh5VNZZwIHH+pmrnFfE0Hlg2/qXw3tFsmkqE+i4wRBsauVTJbdTEdW0
         Rk4A==
X-Gm-Message-State: AOAM532aKDSmjH0cUBBz2jih8rDHBDXJAGZ58wvoHNYDokCxP7hdXFQZ
        N1UZ5lGdbeGUAHVxwQg5dOYfMcaIaDroXw==
X-Google-Smtp-Source: ABdhPJw0AAOF5xvGKcpOYug33RdBV57EKWaXcEuVU7EB8VwYFb32vixJkIJNU6Nr2lotWYNqUl928w==
X-Received: by 2002:a0c:9e6a:: with SMTP id z42mr12363132qve.60.1617126012723;
        Tue, 30 Mar 2021 10:40:12 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id z11sm16295118qkg.52.2021.03.30.10.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 10:40:12 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 12/12] secilc/docs: Update the CIL documentation for various blocks
Date:   Tue, 30 Mar 2021 13:40:03 -0400
Message-Id: <20210330174003.281613-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330174003.281613-1-jwcart2@gmail.com>
References: <20210330174003.281613-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Update the documentation for macros, booleans, booleanifs, tunables,
tunableifs, blocks, blockabstracts, blockinherits, and optionals to
tell where these statements can be used and, for those that have
blocks, what statements are not allowed in them.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/docs/cil_call_macro_statements.md  |  2 ++
 secilc/docs/cil_conditional_statements.md |  6 +++++
 secilc/docs/cil_container_statements.md   | 28 +++++++++++++++--------
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/secilc/docs/cil_call_macro_statements.md b/secilc/docs/cil_call_macro_statements.md
index 332eb28f..352a9fb0 100644
--- a/secilc/docs/cil_call_macro_statements.md
+++ b/secilc/docs/cil_call_macro_statements.md
@@ -58,6 +58,8 @@ When resolving macros the following places are checked in this order:
 
 -   Items defined in the global namespace
 
+[`tunable`](cil_conditional_statements.md#tunable), [`in`](cil_container_statements.md#in), [`block`](cil_container_statements.md#block), [`blockinherit`](cil_container_statements.md#blockinherit), [`blockabstract`](cil_container_statements.md#blockabstract), and other [`macro`](cil_call_macro_statements.md#macro) statements are not allowed in [`macro`](cil_call_macro_statements.md#macro) blocks.
+
 **Statement definition:**
 
 ```secil
diff --git a/secilc/docs/cil_conditional_statements.md b/secilc/docs/cil_conditional_statements.md
index a55a9b6c..d0c8e2ce 100644
--- a/secilc/docs/cil_conditional_statements.md
+++ b/secilc/docs/cil_conditional_statements.md
@@ -6,6 +6,8 @@ boolean
 
 Declares a run time boolean as true or false in the current namespace. The [`booleanif`](cil_conditional_statements.md#booleanif) statement contains the CIL code that will be in the binary policy file.
 
+[`boolean`](cil_conditional_statements.md#boolean) are not allowed in [`booleanif`](cil_conditional_statements.md#booleanif) blocks.
+
 **Statement definition:**
 
 ```secil
@@ -126,6 +128,8 @@ Tunables are similar to booleans, however they are used to manage areas of CIL s
 
 Note that tunables can be treated as booleans by the CIL compiler command line parameter `-P` or `--preserve-tunables` flags.
 
+Since [`tunableif`](cil_conditional_statements.md#tunableif) statements are resolved first, [`tunable`](cil_conditional_statements.md#tunable) statements are not allowed in [`in`](cil_container_statements.md#in), [`macro`](cil_call_macro_statements.md#macro), [`optional`](cil_container_statements.md#optional), and [`booleanif`](cil_conditional_statements.md#booleanif) blocks. To simplify processing, they are also not allowed in [`tunableif`](cil_conditional_statements.md#tunableif) blocks.
+
 **Statement definition:**
 
 ```secil
@@ -164,6 +168,8 @@ tunableif
 
 Compile time conditional statement that may or may not add CIL statements to be compiled.
 
+If tunables are being treated as booleans (by using the CIL compiler command line parameter `-P` or `--preserve-tunables` flag), then only the statements allowed in a [`booleanif`](cil_conditional_statements.md#booleanif) block are allowed in a [`tunableif`](cil_conditional_statements.md#tunableif) block. Otherwise, [`tunable`](cil_conditional_statements.md#tunable) statements are not allowed in a [`tunableif`](cil_conditional_statements.md#tunableif) block.
+
 **Statement definition:**
 
 ```secil
diff --git a/secilc/docs/cil_container_statements.md b/secilc/docs/cil_container_statements.md
index 76e9da51..c75c2d7c 100644
--- a/secilc/docs/cil_container_statements.md
+++ b/secilc/docs/cil_container_statements.md
@@ -4,7 +4,11 @@ Container Statements
 block
 -----
 
-Start a new namespace where any CIL statement is valid.
+Start a new namespace.
+
+Not allowed in [`macro`](cil_call_macro_statements.md#macro) and [`optional`](cil_container_statements.md#optional) blocks. 
+
+[`sensitivity`](cil_mls_labeling_statements.md#sensitivity) and [`category`](cil_mls_labeling_statements.md#category) statements are not allowed in [`block`](cil_container_statements.md#block) blocks.
 
 **Statement definition:**
 
@@ -47,6 +51,8 @@ blockabstract
 
 Declares the namespace as a 'template' and does not generate code until instantiated by another namespace that has a [`blockinherit`](cil_container_statements.md#blockinherit) statement.
 
+Not allowed in [`macro`](cil_call_macro_statements.md#macro) and [`optional`](cil_container_statements.md#optional) blocks.
+
 **Statement definition:**
 
 ```secil
@@ -97,6 +103,8 @@ blockinherit
 
 Used to add common policy rules to the current namespace via a template that has been defined with the [`blockabstract`](cil_container_statements.md#blockabstract) statement. All [`blockinherit`](cil_container_statements.md#blockinherit) statements are resolved first and then the contents of the block are copied. This is so that inherited blocks will not be inherited. For a concrete example, please see the examples section.
 
+Not allowed in [`macro`](cil_call_macro_statements.md#macro) blocks.
+
 **Statement definition:**
 
 ```secil
@@ -199,15 +207,11 @@ This example contains a template `client_server` that is instantiated in two blo
 optional
 --------
 
-Declare an [`optional`](cil_container_statements.md#optional) namespace. All CIL statements in the optional block must be satisfied before instantiation in the binary policy. [`tunableif`](cil_conditional_statements.md#tunableif) and [`macro`](cil_call_macro_statements.md#macro) statements are not allowed in optional containers. The same restrictions apply to CIL policy statements within [`optional`](cil_container_statements.md#optional)'s that apply to kernel policy statements, i.e. only the policy statements shown in the following table are valid:
+Declare an [`optional`](cil_container_statements.md#optional) namespace. All CIL statements in the optional block must be satisfied before instantiation in the binary policy.
 
-|                     |                |                    |                    |
-| ------------------- | -------------- | ------------------ | ------------------ |
-| [`allow`](cil_access_vector_rules.md#allow)             | [`allowx`](cil_access_vector_rules.md#allowx)       | [`auditallow`](cil_access_vector_rules.md#auditallow)       | [`auditallowx`](cil_access_vector_rules.md#auditallowx)      |
-| [`booleanif`](cil_conditional_statements.md#booleanif)         | [`dontaudit`](cil_access_vector_rules.md#dontaudit)    | [`dontauditx`](cil_access_vector_rules.md#dontauditx)       | [`typepermissive`](cil_type_statements.md#typepermissive)   |
-| [`rangetransition`](cil_mls_labeling_statements.md#rangetransition)   | [`role`](cil_role_statements.md#role)         | [`roleallow`](cil_role_statements.md#roleallow)        | [`roleattribute`](cil_role_statements.md#roleattribute)    |
-| [`roletransition`](cil_role_statements.md#roletransition)    | [`type`](cil_type_statements.md#type)         | [`typealias`](cil_type_statements.md#typealias)        | [`typeattribute`](cil_type_statements.md#typeattribute)    |
-| [`typechange`](cil_type_statements.md#typechange)        | [`typemember`](cil_type_statements.md#typemember)   | [`typetransition`](cil_type_statements.md#typetransition)   |                    |
+Not allowed in [`booleanif`](cil_conditional_statements.md#booleanif) blocks.
+
+[`tunable`](cil_conditional_statements.md#tunable), [`in`](cil_container_statements.md#in), [`block`](cil_container_statements.md#block), [`blockabstract`](cil_container_statements.md#blockabstract), and [`macro`](cil_call_macro_statements.md#macro) statements are not allowed in [`optional`](cil_container_statements.md#optional) blocks.
 
 **Statement definition:**
 
@@ -266,7 +270,11 @@ This example will instantiate the optional block `ext_gateway.move_file` into po
 in
 --
 
-Allows the insertion of CIL statements into a named container ([`block`](cil_container_statements.md#block), [`optional`](cil_container_statements.md#optional) or [`macro`](cil_call_macro_statements.md#macro)). This statement is not allowed in [`booleanif`](cil_conditional_statements.md#booleanif) or [`tunableif`](cil_conditional_statements.md#tunableif) statements. This only works for containers that aren't inherited using [`blockinherit`](cil_conditional_statements.md#blockinherit).
+Allows the insertion of CIL statements into a named container ([`block`](cil_container_statements.md#block), [`optional`](cil_container_statements.md#optional) or [`macro`](cil_call_macro_statements.md#macro)).
+
+Not allowed in [`macro`](cil_call_macro_statements.md#macro), [`booleanif`](cil_conditional_statements.md#booleanif), and other [`in`](cil_container_statements.md#in) blocks.
+
+[`tunable`](cil_conditional_statements.md#tunable) and [`in`](cil_container_statements.md#in) statements are not allowed in [`in`](cil_container_statements.md#in) blocks.
 
 **Statement definition:**
 
-- 
2.26.3


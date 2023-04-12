Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E9AC77B76
	for <selinux@archiver.kernel.org>; Wed, 12 Apr 2023 21:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjDLVEf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Apr 2023 17:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjDLVET (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Apr 2023 17:04:19 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D4359E3
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 14:04:16 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id qh25so3207428qvb.1
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 14:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681333453; x=1683925453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z1om3Ty+ulg5PVW3gHISEbi7kxXYfJ8OvgNR+U1Vqw=;
        b=f9HJd8J9uYeXLQzGh2UicCCuP5aarrwuhEJY4NUVlR6qLWbyRwMi5AMoL2/p4A3BQw
         N8tc8kJtjl6XIb7UP/iiiWDqQsB2KmEAWuU4W7r8IlHMrVHLs35VEpFrk8poDbzjsTzB
         yx8Ovp+jbNk3SUVHKJVQc4fP/mCHQpULuxOM4iGpoVOgaZEHQtEAtl+aKUSnlfkTlAoN
         ctQqwJfhcwmn0f4zcgSZpu4t3lGyEf40qNRSWQAv9oybgiyqSf3hSbVn7xxjMtCElRLp
         f6s71bvFq0I3+Y8Ywi6PCkzQy9px8/Q59/Nh4kGln/QEQYx4zqAPxziP7zpU3VTS42Z1
         QchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681333453; x=1683925453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Z1om3Ty+ulg5PVW3gHISEbi7kxXYfJ8OvgNR+U1Vqw=;
        b=GJGsYou2ifapKr0muYizc7OXO6CxKSgctcYJJE338Wd7uB72QUnJzqBkrWhS6lGWGR
         bJ6FWBjrSzvcHMPuSW35VPWxqho9iw9g6yf2EBvBqNpJXvNoa/xCnWW1LolEdzV+KFnC
         tju83S5THriOerHCUtcFs8nI6vc/Lt3Pt71rUTjRSwdn9g4hsC9KGVXZik8JBhX+QosW
         K410SLypBy9MzRxFiryXgOtE1GmnSraYpWhwzoUoWLUvrUxGU/QSu0IxZ7oJd6qzgHo+
         SFhYmj+BZPRQ6qWxighW+++fpSYNFvLFH+24+MfySQl8Uewc5Dp5mVhy62m4gWY62BTy
         UKjg==
X-Gm-Message-State: AAQBX9dPK7LTK/oaOqgkHPNp6BgrQjfvjJrbrZahoP7L6jcnOQk0PIcP
        OiT//pcenxFuth/8xxO32Fs5QLsiYYU=
X-Google-Smtp-Source: AKy350Y6F/wCs9gvyYtGE6pcYMhtxx/L2LF1+JxKYF6LZw+7jwEWnJhcgVCsmCO/6e0Mjy4LSj4uVA==
X-Received: by 2002:a05:6214:e4d:b0:56f:b28f:cc30 with SMTP id o13-20020a0562140e4d00b0056fb28fcc30mr5640592qvc.4.1681333452706;
        Wed, 12 Apr 2023 14:04:12 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id oe6-20020a056214430600b005e16003edc9sm5025758qvb.104.2023.04.12.14.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:04:12 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/6] secilc/docs: Add notself and other keywords to CIL documentation
Date:   Wed, 12 Apr 2023 17:04:05 -0400
Message-Id: <20230412210406.522892-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412210406.522892-1-jwcart2@gmail.com>
References: <20230412210406.522892-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Also reorganize the access vector rules section to minimize duplication
explanation of the parts of access vector rules.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/docs/README.md                  |   1 -
 secilc/docs/cil_access_vector_rules.md | 244 +++----------------------
 secilc/docs/cil_reference_guide.md     |   9 -
 secilc/docs/secil.xml                  |   2 +
 4 files changed, 32 insertions(+), 224 deletions(-)

diff --git a/secilc/docs/README.md b/secilc/docs/README.md
index efab2a71..5e00fc3b 100644
--- a/secilc/docs/README.md
+++ b/secilc/docs/README.md
@@ -17,7 +17,6 @@ CIL (Common Intermediate Language)
   * [Global Namespace](cil_reference_guide.md#global-namespace)
   * [Expressions](cil_reference_guide.md#expressions)
   * [Name String](cil_reference_guide.md#name-string)
-  * [self](cil_reference_guide.md#self)
   * [Example CIL Policy](../test/policy.cil)
 
 * [Access Vector Rules](cil_access_vector_rules.md#access-vector-rules)
diff --git a/secilc/docs/cil_access_vector_rules.md b/secilc/docs/cil_access_vector_rules.md
index f0ba4a90..034185da 100644
--- a/secilc/docs/cil_access_vector_rules.md
+++ b/secilc/docs/cil_access_vector_rules.md
@@ -1,15 +1,12 @@
 Access Vector Rules
 ===================
 
-allow
------
-
-Specifies the access allowed between a source and target type. Note that access may be refined by constraint rules based on the source, target and class ([`validatetrans`](cil_constraint_statements.md#validatetrans) or [`mlsvalidatetrans`](cil_constraint_statements.md#mlsvalidatetrans)) or source, target class and permissions ([`constrain`](cil_constraint_statements.md#constrain) or [`mlsconstrain`](cil_constraint_statements.md#mlsconstrain) statements).
+Rules involving a source type, a target type, and class permissions or extended permissions.
 
 **Rule definition:**
 
 ```secil
-    (allow source_id target_id|self classpermissionset_id ...)
+    (av_flavor source_id target_id|self|notself|other classpermission_id|permissionx_id)
 ```
 
 **Where:**
@@ -21,9 +18,8 @@ Specifies the access allowed between a source and target type. Note that access
 </colgroup>
 <tbody>
 <tr class="odd">
-<td align="left"><p><code>allow</code></p></td>
-<td align="left"><p>The <code>allow</code> keyword.</p></td>
-</tr>
+<td align="left"><p><code>av_flavor</code></p></td>
+<td align="left"><p>The flavor of access vector rule. Possible flavors are <code>allow</code>, <code>auditallow</code>, <code>dontaudit</code>, <code>neverallow</code>, <code>allowx</code>, <code>auditallowx</code>, <code>dontauditx</code>, <code>neverallowx</code>.</p></td>
 <tr class="even">
 <td align="left"><p><code>source_id</code></p></td>
 <td align="left"><p>A single previously defined source <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
@@ -31,15 +27,31 @@ Specifies the access allowed between a source and target type. Note that access
 <tr class="odd">
 <td align="left"><p><code>target_id</code></p></td>
 <td align="left"><p>A single previously defined target <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p>
-<p>The <code>self</code> keyword may be used instead to signify that source and target are the same.</p></td>
+<p> Instead it can be one of the special keywords <code>self</code>, <code>notself</code> or <code>other</code>.</p>
+<p>The <code>self</code> keyword may be used to signify that source and target are the same. If the source is an attribute, each type of the source will be paired with itself as the target. The <code>notself</code> keyword may be used to signify that the target is all types except for the types of the source. The <code>other</code> keyword may be used as a short-hand way of writing a rule for each type of the source where it is paired with all of the other types of the source as the target.</p></td>
 </tr>
 <tr class="even">
-<td align="left"><p><code>classpermissionset_id</code></p></td>
-<td align="left"><p>A single named or anonymous <code>classpermissionset</code> or a single set of <code>classmap</code>/<code>classmapping</code> identifiers.</p></td>
+<td align="left"><p><code>classpermission_id</code></p></td>
+<td align="left"><p>A single named or anonymous <code>classpermissionset</code> or a single set of <code>classmap</code>/<code>classmapping</code> identifiers. Used for <code>allow</code>, <code>auditallow</code>, <code>dontaudit</code>, <code>neverallow</code> rules.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>permissionx_id</code></p></td>
+<td align="left"><p>A single named or anonymous <code>permissionx</code>. Used for <code>allowx</code>, <code>auditallowx</code>, <code>dontauditx</code>, <code>neverallowx</code> rules.</p></td>
 </tr>
 </tbody>
 </table>
 
+allow
+-----
+
+Specifies the access allowed between a source and target type. Note that access may be refined by constraint rules based on the source, target and class ([`validatetrans`](cil_constraint_statements.md#validatetrans) or [`mlsvalidatetrans`](cil_constraint_statements.md#mlsvalidatetrans)) or source, target class and permissions ([`constrain`](cil_constraint_statements.md#constrain) or [`mlsconstrain`](cil_constraint_statements.md#mlsconstrain) statements).
+
+**Rule definition:**
+
+```secil
+    (allow source_id target_id|self|notself|other classpermissionset_id ...)
+```
+
 **Examples:**
 
 These examples show a selection of possible permutations of [`allow`](cil_access_vector_rules.md#allow) rules:
@@ -97,37 +109,9 @@ Audit the access rights defined if there is a valid allow rule. Note: It does NO
 **Rule definition:**
 
 ```secil
-    (auditallow source_id target_id|self classpermissionset_id ...)
+    (auditallow source_id target_id|self|notself|other classpermissionset_id)
 ```
 
-**Where:**
-
-<table>
-<colgroup>
-<col width="29%" />
-<col width="70%" />
-</colgroup>
-<tbody>
-<tr class="odd">
-<td align="left"><p><code>auditallow</code></p></td>
-<td align="left"><p>The <code>auditallow</code> keyword.</p></td>
-</tr>
-<tr class="even">
-<td align="left"><p><code>source_id</code></p></td>
-<td align="left"><p>A single previously defined source <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
-</tr>
-<tr class="odd">
-<td align="left"><p><code>target_id</code></p></td>
-<td align="left"><p>A single previously defined target <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p>
-<p>The <code>self</code> keyword may be used instead to signify that source and target are the same.</p></td>
-</tr>
-<tr class="even">
-<td align="left"><p><code>classpermissionset_id</code></p></td>
-<td align="left"><p>A single named or anonymous <code>classpermissionset</code> or a single set of <code>classmap</code>/<code>classmapping</code> identifiers.</p></td>
-</tr>
-</tbody>
-</table>
-
 **Example:**
 
 This example will log an audit event whenever the corresponding [`allow`](cil_access_vector_rules.md#allow) rule grants access to the specified permissions:
@@ -148,37 +132,9 @@ Note that these rules can be omitted by the CIL compiler command line parameter
 **Rule definition:**
 
 ```secil
-    (dontaudit source_id target_id|self classpermissionset_id ...)
+    (dontaudit source_id target_id|self|notself|other classpermissionset_id ...)
 ```
 
-**Where:**
-
-<table>
-<colgroup>
-<col width="27%" />
-<col width="72%" />
-</colgroup>
-<tbody>
-<tr class="odd">
-<td align="left"><p><code>dontaudit</code></p></td>
-<td align="left"><p>The <code>dontaudit</code> keyword.</p></td>
-</tr>
-<tr class="even">
-<td align="left"><p><code>source_id</code></p></td>
-<td align="left"><p>A single previously defined source <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
-</tr>
-<tr class="odd">
-<td align="left"><p><code>target_id</code></p></td>
-<td align="left"><p>A single previously defined target <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p>
-<p>The <code>self</code> keyword may be used instead to signify that source and target are the same.</p></td>
-</tr>
-<tr class="even">
-<td align="left"><p><code>classpermissionset_id</code></p></td>
-<td align="left"><p>A single named or anonymous <code>classpermissionset</code> or a single set of <code>classmap</code>/<code>classmapping</code> identifiers.</p></td>
-</tr>
-</tbody>
-</table>
-
 **Example:**
 
 This example will not audit the denied access:
@@ -197,37 +153,9 @@ Note that these rules can be over-ridden by the CIL compiler command line parame
 **Rule definition:**
 
 ```secil
-    (neverallow source_id target_id|self classpermissionset_id ...)
+    (neverallow source_id target_id|self|notself|other classpermissionset_id ...)
 ```
 
-**Where:**
-
-<table>
-<colgroup>
-<col width="27%" />
-<col width="72%" />
-</colgroup>
-<tbody>
-<tr class="odd">
-<td align="left"><p><code>neverallow</code></p></td>
-<td align="left"><p>The <code>neverallow</code> keyword.</p></td>
-</tr>
-<tr class="even">
-<td align="left"><p><code>source_id</code></p></td>
-<td align="left"><p>A single previously defined source <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
-</tr>
-<tr class="odd">
-<td align="left"><p><code>target_id</code></p></td>
-<td align="left"><p>A single previously defined target <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p>
-<p>The <code>self</code> keyword may be used instead to signify that source and target are the same.</p></td>
-</tr>
-<tr class="even">
-<td align="left"><p><code>classpermissionset_id</code></p></td>
-<td align="left"><p>A single named or anonymous <code>classpermissionset</code> or a single set of <code>classmap</code>/<code>classmapping</code> identifiers.</p></td>
-</tr>
-</tbody>
-</table>
-
 **Example:**
 
 This example will not compile as `type_3` is not allowed to be a source type for the [`allow`](cil_access_vector_rules.md#allow) rule:
@@ -258,37 +186,9 @@ Note that for this to work there must *also* be valid equivalent [`allow`](cil_a
 **Rule definition:**
 
 ```secil
-    (allowx source_id target_id|self permissionx_id)
+    (allowx source_id target_id|self|notself|other permissionx_id)
 ```
 
-**Where:**
-
-<table>
-<colgroup>
-<col width="27%" />
-<col width="72%" />
-</colgroup>
-<tbody>
-<tr class="odd">
-<td align="left"><p><code>allowx</code></p></td>
-<td align="left"><p>The <code>allowx</code> keyword.</p></td>
-</tr>
-<tr class="even">
-<td align="left"><p><code>source_id</code></p></td>
-<td align="left"><p>A single previously defined source <code>type</code>, <code>typealias</code>, or <code>typeattribute</code> identifier.</p></td>
-</tr>
-<tr class="odd">
-<td align="left"><p><code>target_id</code></p></td>
-<td align="left"><p>A single previously defined target <code>type</code>, <code>typealias</code>, or <code>typeattribute</code> identifier.</p>
-<p>The <code>self</code> keyword may be used instead to signify that source and target are the same.</p></td>
-</tr>
-<tr class="even">
-<td align="left"><p><code>permissionx_id</code></p></td>
-<td align="left"><p>A single named or anonymous <code>permissionx</code>.</p></td>
-</tr>
-</tbody>
-</table>
-
 **Examples:**
 
 These examples show a selection of possible permutations of [`allowx`](cil_access_vector_rules.md#allowx) rules:
@@ -313,37 +213,9 @@ Note that for this to work there must *also* be valid equivalent [`auditallow`](
 **Rule definition:**
 
 ```secil
-    (auditallowx source_id target_id|self permissionx_id)
+    (auditallowx source_id target_id|self|notself|other permissionx_id)
 ```
 
-**Where:**
-
-<table>
-<colgroup>
-<col width="27%" />
-<col width="72%" />
-</colgroup>
-<tbody>
-<tr class="odd">
-<td align="left"><p><code>auditallowx</code></p></td>
-<td align="left"><p>The <code>auditallowx</code> keyword.</p></td>
-</tr>
-<tr class="even">
-<td align="left"><p><code>source_id</code></p></td>
-<td align="left"><p>A single previously defined source <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
-</tr>
-<tr class="odd">
-<td align="left"><p><code>target_id</code></p></td>
-<td align="left"><p>A single previously defined target <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p>
-<p>The <code>self</code> keyword may be used instead to signify that source and target are the same.</p></td>
-</tr>
-<tr class="even">
-<td align="left"><p><code>permissionx_id</code></p></td>
-<td align="left"><p>A single named or anonymous <code>permissionx</code>.</p></td>
-</tr>
-</tbody>
-</table>
-
 **Examples:**
 
 This example will log an audit event whenever the corresponding [`allowx`](cil_access_vector_rules.md#allowx) rule grants access to the specified extended permissions:
@@ -367,37 +239,9 @@ Note that these rules can be omitted by the CIL compiler command line parameter
 **Rule definition:**
 
 ```secil
-    (dontauditx source_id target_id|self permissionx_id)
+    (dontauditx source_id target_id|self|notself|other permissionx_id)
 ```
 
-**Where:**
-
-<table>
-<colgroup>
-<col width="27%" />
-<col width="72%" />
-</colgroup>
-<tbody>
-<tr class="odd">
-<td align="left"><p><code>dontauditx</code></p></td>
-<td align="left"><p>The <code>dontauditx</code> keyword.</p></td>
-</tr>
-<tr class="even">
-<td align="left"><p><code>source_id</code></p></td>
-<td align="left"><p>A single previously defined source <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
-</tr>
-<tr class="odd">
-<td align="left"><p><code>target_id</code></p></td>
-<td align="left"><p>A single previously defined target <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p>
-<p>The <code>self</code> keyword may be used instead to signify that source and target are the same.</p></td>
-</tr>
-<tr class="even">
-<td align="left"><p><code>permissionx_id</code></p></td>
-<td align="left"><p>A single named or anonymous <code>permissionx</code>.</p></td>
-</tr>
-</tbody>
-</table>
-
 **Examples:**
 
 This example will not audit the denied access:
@@ -416,37 +260,9 @@ Note that these rules can be over-ridden by the CIL compiler command line parame
 **Rule definition:**
 
 ```secil
-    (neverallowx source_id target_id|self permissionx_id)
+    (neverallowx source_id target_id|self|notself|other permissionx_id)
 ```
 
-**Where:**
-
-<table>
-<colgroup>
-<col width="27%" />
-<col width="72%" />
-</colgroup>
-<tbody>
-<tr class="odd">
-<td align="left"><p><code>neverallowx</code></p></td>
-<td align="left"><p>The <code>neverallowx</code> keyword.</p></td>
-</tr>
-<tr class="even">
-<td align="left"><p><code>source_id</code></p></td>
-<td align="left"><p>A single previously defined source <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
-</tr>
-<tr class="odd">
-<td align="left"><p><code>target_id</code></p></td>
-<td align="left"><p>A single previously defined target <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p>
-<p>The <code>self</code> keyword may be used instead to signify that source and target are the same.</p></td>
-</tr>
-<tr class="even">
-<td align="left"><p><code>permissionx_id</code></p></td>
-<td align="left"><p>A single named or anonymous <code>permissionx</code>.</p></td>
-</tr>
-</tbody>
-</table>
-
 **Examples:**
 
 This example will not compile as `type_3` is not allowed to be a source type and ioctl range for the [`allowx`](cil_access_vector_rules.md#allowx) rule:
diff --git a/secilc/docs/cil_reference_guide.md b/secilc/docs/cil_reference_guide.md
index ac800b12..d1d3ff16 100644
--- a/secilc/docs/cil_reference_guide.md
+++ b/secilc/docs/cil_reference_guide.md
@@ -316,12 +316,3 @@ Alternatively:
         (typetransition audit.process device.device chr_file ARG1 device.klog_device)
     )
 ```
-
-self
-----
-
-The [`self`](cil_reference_guide.md#self) keyword may be used as the target in AVC rule statements, and means that the target is the same as the source as shown in the following example:.
-
-```secil
-    (allow unconfined.process self (file (read write)))
-```
diff --git a/secilc/docs/secil.xml b/secilc/docs/secil.xml
index 38d7b030..60314e9a 100644
--- a/secilc/docs/secil.xml
+++ b/secilc/docs/secil.xml
@@ -145,6 +145,8 @@
             <item>r3</item>
             <item>sctp</item>
             <item>self</item>
+            <item>notself</item>
+            <item>other</item>
             <item>t1</item>
             <item>t2</item>
             <item>t3</item>
-- 
2.39.2


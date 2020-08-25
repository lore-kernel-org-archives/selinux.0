Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596AAC433E8
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3518520706
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="U/LoWXsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgHYIiY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:38:24 -0400
Received: from mailomta10-sa.btinternet.com ([213.120.69.16]:21504 "EHLO
        sa-prd-fep-041.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728109AbgHYIiR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 04:38:17 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20200825083809.MJXX19995.sa-prd-fep-041.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 25 Aug 2020 09:38:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598344689; 
        bh=WAke2q5HIFSVAmCRcXhPKk31kmXXju7pzkqUUlE2JGw=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=U/LoWXsFkAFsBX2DDgsbbJnimt0AHQRdboMQcs+9smjOIyn12n/e/Cv5hDfrhfmhxu5DdjK8bCIrqZ5Uq3OZNyjejHBj8Ja7Zq6o8Kd5D/nXbaAlfQQeDna7LIgCF0hL+MntAPiCfWU9P5hu/jwZx88fAAXcI0KFBloYfT48DOHSziWkmFa33vhMF9CMZspWd2E2227OyLaFygZFomlyd+5FFJ9XRRI5LwuSNBn2T+ztQUD5sNQvtrAhjHHvsHEHsWe7GFbeeLh0cqIesrUtgqVHFnzBI92OdEPB8CfqoANHExOgouaI+VPqL25eqXoB2p4mgLs5p+6g4UmpTGzOlw==
Authentication-Results: btinternet.com; none
X-Originating-IP: [109.155.130.160]
X-OWM-Source-IP: 109.155.130.160 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepuddtledrudehhedrudeftddrudeitdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehhedrudeftddrudeitddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.130.160) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B8A70D599DAC; Tue, 25 Aug 2020 09:38:09 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 06/18] class_permission_statements: Convert to markdown
Date:   Tue, 25 Aug 2020 09:37:31 +0100
Message-Id: <20200825083743.6508-7-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825083743.6508-1-richard_c_haines@btinternet.com>
References: <20200825083743.6508-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a TOC to aid navigation and convert to markdown.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/class_permission_statements.md | 231 ++++++++++++-----------------
 1 file changed, 93 insertions(+), 138 deletions(-)

diff --git a/src/class_permission_statements.md b/src/class_permission_statements.md
index 4090fa0..b1ef36a 100644
--- a/src/class_permission_statements.md
+++ b/src/class_permission_statements.md
@@ -1,5 +1,10 @@
 # Object Class and Permission Statements
 
+- [*class* (1)](#class-1)
+  - [Associating Permissions to a Class](#associating-permissions-to-a-class)
+- [*common*](#common)
+- [*class* (2)](#class-2)
+
 For those who write or manager SELinux policy, there is no need to
 define new objects and their associated permissions as these would be
 done by those who actually design and/or write object managers.
@@ -9,14 +14,14 @@ in the *./policy/flask/security\_classes* file.
 
 There are two variants of the *class* statement for writing policy:
 
-1.  There is the *class* statement that declares the actual class
-    identifier or name.
-2.  There is a further refinement of the *class* statement that
-    associates permissions to the class as discussed in the
-    [**Associating Permissions to a Class**](#associating-permissions-to-a-class)
-    section.
+1. There is the *class* statement that declares the actual class
+   identifier or name.
+2. There is a further refinement of the *class* statement that
+   associates permissions to the class as discussed in the
+   [**Associating Permissions to a Class**](#associating-permissions-to-a-class)
+   section.
 
-## *class*
+## *class* (1)
 
 Object classes are declared within a policy with the following statement
 definition:
@@ -27,45 +32,27 @@ class class_id
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>class</code></td>
-<td>The <code>class</code> keyword.</td>
-</tr>
-<tr>
-<td><code>class_id</code></td>
-<td>The <code>class</code> identifier. </td>
-</tr>
-</tbody>
-</table>
+*class*
+
+The *class* keyword.
+
+*class_id*
+
+The *class* identifier.
 
 **The statement is valid in:**
 
-<table style="text-align:center">
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Monolithic Policy</strong></td>
-<td><strong>Base Policy</strong></td>
-<td><strong>Module Policy</strong></td>
-</tr>
-<tr>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>No</td>
-<td>Yes</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | No                      |
+
+Conditional Policy Statements
+
+| *if* Statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | No                      | Yes                     |
 
 **Example:**
 
@@ -79,11 +66,11 @@ class db_tuple
 
 Permissions can be defined within policy in two ways:
 
-1.  Define a set of common permissions that can then be inherited by one
-    or more object classes using further *class* statements.
-2.  Define *class* specific permissions. This is where permissions are
-    declared for a specific object class only (i.e. the permission is
-    not inherited by any other object class).
+1. Define a set of common permissions that can then be inherited by one
+   or more object classes using further *class* statements.
+2. Define *class* specific permissions. This is where permissions are
+   declared for a specific object class only (i.e. the permission is
+   not inherited by any other object class).
 
 A list of classes and their permissions used by the **Reference Policy**
 can be found in the *./policy/flask/access_vectors* file.
@@ -100,49 +87,32 @@ common common_id { perm_set }
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>common</code></td>
-<td>The <code>common</code> keyword.</td>
-</tr>
-<tr>
-<td><code>common_id</code></td>
-<td>The <code>common</code> identifier. </td>
-</tr>
-<tr>
-<td><code>perm_set</code></td>
-<td>One or more permission identifiers in a space separated list enclosed within braces '{}'.</td>
-</tr>
-</tbody>
-</table>
+*common*
+
+The *common* keyword.
+
+*common_id*
+
+The *common* identifier.
+
+*perm_set*
+
+One or more permission identifiers in a space separated list enclosed within
+braces \'\{\}\'.
 
 **The statement is valid in:**
 
-<table style="text-align:center">
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Monolithic Policy</strong></td>
-<td><strong>Base Policy</strong></td>
-<td><strong>Module Policy</strong></td>
-</tr>
-<tr>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | No                      |
+
+Conditional Policy Statements
+
+| *if* Statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | No                      | No                      |
 
 **Example:**
 
@@ -152,9 +122,10 @@ common common_id { perm_set }
 common database { create drop getattr setattr relabelfrom relabelto }
 ```
 
-## *class*
+## *class* (2)
 
-Inherit and / or associate permissions to a perviously declared *class* identifier.
+Inherit and / or associate permissions to a perviously declared *class*
+identifier.
 
 **The statement definition is:**
 
@@ -164,60 +135,44 @@ class class_id [ inherits common_set ] [ { perm_set } ]
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>class</code></td>
-<td>The <code>class</code> keyword.</td>
-</tr>
-<tr>
-<td><code>class_id</code></td>
-<td>The previously declared <code>class</code> identifier. </td>
-</tr>
-<tr>
-<td><code>inherits</code></td>
-<td>The optional <code>inherits</code> keyword that allows a set of common permissions to be inherited.</td>
-</tr>
-<tr>
-<td><code>common_set</code></td>
-<td>A previously declared <code>common</code> identifier.</td>
-</tr>
-<tr>
-<td><code>perm_set</code></td>
-<td>One or more optional permission identifiers in a space separated list enclosed within braces '{}'.</td>
-</tr>
-</tbody>
-</table>
+*class*
+
+The *class* keyword.
+
+*class_id*
+
+The previously declared *class* identifier.
+
+*inherits*
+
+The optional *inherits* keyword that allows a set of common permissions to be
+inherited.
+
+*common_set*
+
+A previously declared *common* identifier.
+
+*perm_set*
+
+One or more optional permission identifiers in a space separated list enclosed
+within braces \'\{\}\'.</td>
 
 Note: There must be at least one *common_set* or one *perm_set* defined within
 the statement.
 
 **The statement is valid in:**
 
-<table style="text-align:center">
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Monolithic Policy</strong></td>
-<td><strong>Base Policy</strong></td>
-<td><strong>Module Policy</strong></td>
-</tr>
-<tr>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>No</td>
-<td>Yes</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | No                      |
+
+Conditional Policy Statements
+
+| *if* Statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | No                      | Yes                     |
 
 **Examples:**
 
-- 
2.26.2


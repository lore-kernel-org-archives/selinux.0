Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C90C433DF
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F7CE20706
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="S4oxa02S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgHYIiS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:38:18 -0400
Received: from mailomta10-sa.btinternet.com ([213.120.69.16]:46270 "EHLO
        sa-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728890AbgHYIiQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 04:38:16 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20200825083812.VUFU4609.sa-prd-fep-047.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 25 Aug 2020 09:38:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598344692; 
        bh=sxT9hoY/sJl5Qz9DRDnuzmbh1B6Uo+Wz1qgs0NSCirM=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=S4oxa02Smhi8r+/k5KCjY5nlW50sVCTtwVN2ZviIOy6lLtu19G+bK3db550Bk8lPxghjPQWN0EQxp7kQLPCRLl3FK+L1eNdLHf3Q7AYrtvBgdPa2aQWI17ZrB//2VZ78B10wR3UXczklLhWbMOdR7mrWJ60WLgSaWiBEgOz0T7hrF1217FObYPlZKVoAn33W6P2hL6iakdctEDO3IT4TEpDUaVMmmf4L2fex2/3y1EJA7Mug8aMzZ7+E30BhhqUjCao6VGDTz3uQgwIogXwrE3LH+TBnAzaAN4inWXWT4SDHoT07IOgMtIET1alCknSBznfzYl80hyYKMwgeApVcaw==
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
        id 5ED9B8A70D599E4D; Tue, 25 Aug 2020 09:38:12 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 13/18] default_rules: Convert to markdown
Date:   Tue, 25 Aug 2020 09:37:38 +0100
Message-Id: <20200825083743.6508-14-richard_c_haines@btinternet.com>
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
 src/default_rules.md | 293 ++++++++++++++++++-------------------------
 1 file changed, 119 insertions(+), 174 deletions(-)

diff --git a/src/default_rules.md b/src/default_rules.md
index 92ba272..e0d11e8 100644
--- a/src/default_rules.md
+++ b/src/default_rules.md
@@ -1,8 +1,14 @@
 # Default Object Rules
 
+- [*default_user*](#default_user)
+- [*default_role*](#default_role)
+- [*default_type*](#default_type)
+- [*default_range*](#default_range)
+
 These rules allow a default user, role, type and/or range to be used
 when computing a context for a new object. These require policy version
-27 or 28 with kernels 3.5 or greater.
+27 or 28 with kernels 3.5 or greater, for *glblub* support version 32 with
+kernel 5.5 is required.
 
 ## *default_user*
 
@@ -18,50 +24,34 @@ default_user class default;
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>default_user</code></td>
-<td>The <code>default_user</code> rule keyword.</td>
-</tr>
-<tr>
-<td><p><code>class</code></p></td>
-<td><p>One or more <code>class</code> identifiers. Multiple entries consist of a space separated list enclosed in braces '{}'. </p>
-<p>Entries can be excluded from the list by using the negative operator '-'.</p></td>
-</tr>
-<tr>
-<td><code>default</code></td>
-<td>A single keyword consisting of either <code>source</code> or <code>target</code> that will state whether the default user should be obtained from the source or target context.</td>
-</tr>
-</tbody>
-</table>
+*default_user*
+
+The *default_user* rule keyword.
+
+*class*
+
+One or more *class* identifiers. Multiple entries consist of a space separated
+list enclosed in braces \'\{\}\'. Entries can be excluded from the list by using
+the negative operator \'\-\'.
+
+*default*
+
+A single keyword consisting of either *source* or *target* that will state
+whether the default user should be obtained from the source or target context.
 
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
 
 **Examples:**
 
@@ -93,50 +83,35 @@ default_role class default;
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>default_role</code></td>
-<td>The <code>default_role</code> rule keyword.</td>
-</tr>
-<tr>
-<td><p><code>class</code></p></td>
-<td><p>One or more <code>class</code> identifiers. Multiple entries consist of a space separated list enclosed in braces '{}'. </p>
-<p>Entries can be excluded from the list by using the negative operator '-'.</p></td>
-</tr>
-<tr>
-<td><code>default</code></td>
-<td>A single keyword consisting of either <code>source</code> or <code>target</code> that will state whether the default role should be obtained from the source or target context.</td>
-</tr>
-</tbody>
-</table>
+*default_role*
+
+The *default_role* rule keyword.
+
+*class*
+
+One or more *class* identifiers. Multiple entries consist of a space
+separated list enclosed in braces \'\{\}\'.
+Entries can be excluded from the list by using the negative operator \'\-\'.
+
+*default*
+
+A single keyword consisting of either *source* or *target* that will state
+whether the default role should be obtained from the source or target context.
+
 
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
 
 **Examples:**
 
@@ -168,50 +143,34 @@ default_type class default;
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>default_type</code></td>
-<td>The <code>default_type</code> rule keyword.</td>
-</tr>
-<tr>
-<td><p><code>class</code></p></td>
-<td><p>One or more <code>class</code> identifiers. Multiple entries consist of a space separated list enclosed in braces '{}'. </p>
-<p>Entries can be excluded from the list by using the negative operator '-'.</p></td>
-</tr>
-<tr>
-<td><code>default</code></td>
-<td>A single keyword consisting of either <code>source</code> or <code>target</code> that will state whether the default type should be obtained from the source or target context.</td>
-</tr>
-</tbody>
-</table>
+*default_type*
+
+The *default_type* rule keyword.
+
+*class*
+
+One or more *class* identifiers. Multiple entries consist of a space
+separated list enclosed in braces \'\{\}\'. Entries can be excluded from the
+list by using the negative operator \'\-\'.
+
+*default*
+
+A single keyword consisting of either *source* or *target* that will state
+whether the default type should be obtained from the source or target context.
 
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
 
 **Examples:**
 
@@ -235,7 +194,7 @@ Allows the default range or level to be taken from the source or target
 context when computing a new context for an object of the defined class.
 Requires policy version 27.
 
-Policy verion 32 with kernel 5.5 allows the use of *glblub* as a
+Policy version 32 with kernel 5.5 allows the use of *glblub* as a
 *default_range* default and the computed transition will be the
 intersection of the MLS range of the two contexts. The *glb* (greatest
 lower bound) *lub* (lowest upper bound) of a range is calculated as the
@@ -249,58 +208,44 @@ default_range class [default range] | [glblub];
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>default_range</code></td>
-<td>The <code>default_range</code> rule keyword.</td>
-</tr>
-<tr>
-<td><p><code>class</code></p></td>
-<td><p>One or more <code>class</code> identifiers. Multiple entries consist of a space separated list enclosed in braces '{}'. </p>
-<p>Entries can be excluded from the list by using the negative operator '-'.</p></td>
-</tr>
-<tr>
-<td><code>default</code></td>
-<td>A single keyword consisting of either <code>source</code> or <code>target</code> that will state whether the default level or range should be obtained from the source or target context.</td>
-</tr>
-<tr>
-<td><code>range</code></td>
-<td>A single keyword consisting of either: <code>low</code>, <code>high</code> or <code>low_high</code> that will state what part of the range should be used.</td>
-</tr>
-<tr>
-<td><code>glblub</code></td>
-<td>The <code>glblub</code> keyword used instead of <code>[default range]</code>.</td>
-</tr>
-</tbody>
-</table>
+*default_range*
+
+The *default_range* rule keyword.
+
+*class*
+
+One or more *class* identifiers. Multiple entries consist of a space
+separated list enclosed in braces \'\{\}\'. Entries can be excluded from the
+list by using the negative operator \'\-\'.
+
+*default*
+
+A single keyword consisting of either *source* or *target* that will state
+whether the default level or range should be obtained from the source
+or target context.
+
+*range*
+
+A single keyword consisting of either: *low*, *high* or *low_high* that will
+state what part of the range should be used.
+
+*glblub*
+
+The *glblub* keyword used instead of *[default range]*.
 
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
 
 **Examples:**
 
-- 
2.26.2


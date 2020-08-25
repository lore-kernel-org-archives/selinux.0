Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0077AC433DF
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C52452071E
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="Gx8qqybc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgHYIiV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:38:21 -0400
Received: from mailomta27-sa.btinternet.com ([213.120.69.33]:53158 "EHLO
        sa-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728504AbgHYIiQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 04:38:16 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20200825083810.MPKQ26847.sa-prd-fep-043.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 25 Aug 2020 09:38:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598344690; 
        bh=rwUXWQzCJW6urkEMzOx9OdmAEPAgf2t+Upku6IVW1q8=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=Gx8qqybcJWmRI6KC2GoDhzyKx/k/HmnrUDvab/6JWvaJOgswdmSBT/hxHvSoKXkQP4XYEql0L8Fz6g0oNklbSAHTHQecuhlSdRS9nozZk6yy+mzv6f6Q0uSj+JH/kpQv/Y71HJ/tIe4amaA+mlrTq2bROAiuuabk3R0BQ1WYgniY689TEGHdB4zPvpuxQ+LjcqQTJRz6skkGeLQnhQg2C4DJ31z8Fr+GDxyJoVjmQGBsdEu54JVzwes2kWJlAQD8W/6Mq0obOIHIOmU2dNgcRhb2xhEW/flGAKsYudwMLucoY/7w46vfj+og66AOuakbxenxrTA2xj7tVNyp2eVLSQ==
Authentication-Results: btinternet.com; none
X-Originating-IP: [109.155.130.160]
X-OWM-Source-IP: 109.155.130.160 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepgfekgffghffgleekgfellefftedvhfejveehhfekkefgvdehueetgfffffelkedtnecukfhppedutdelrdduheehrddufedtrdduiedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduheehrddufedtrdduiedtpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.130.160) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B8A70D599DE1; Tue, 25 Aug 2020 09:38:10 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 09/18] conditional_statements: Convert to markdown
Date:   Tue, 25 Aug 2020 09:37:34 +0100
Message-Id: <20200825083743.6508-10-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825083743.6508-1-richard_c_haines@btinternet.com>
References: <20200825083743.6508-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a TOC to aid navigation and convert to markdown.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/conditional_statements.md | 159 ++++++++++++++--------------------
 1 file changed, 66 insertions(+), 93 deletions(-)

diff --git a/src/conditional_statements.md b/src/conditional_statements.md
index 3cf07df..4eeeec3 100644
--- a/src/conditional_statements.md
+++ b/src/conditional_statements.md
@@ -1,5 +1,8 @@
 # Conditional Policy Statements
 
+- [*if*](#if)
+- [*bool*](#bool)
+
 Conditional policies consist of a bool statement that defines a
 condition as *true* or *false*, with a supporting *if* / *else* construct that
 specifies what rules are valid under the condition as shown in the
@@ -56,7 +59,7 @@ getsebool -a
 getsebool allow_daemons_use_tty
 ```
 
-## bool
+## *bool*
 
 The *bool* statement is used to specify a boolean identifier and its
 initial state (*true* or *false*) that can then be used with the
@@ -71,49 +74,31 @@ bool bool_id default_value;
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>bool</code></td>
-<td>The <code>bool</code> keyword.</td>
-</tr>
-<tr>
-<td><code>bool_id</code></td>
-<td>The boolean identifier.</td>
-</tr>
-<tr>
-<td><code>default_value</code></td>
-<td>Either true or false.</td>
-</tr>
-</tbody>
-</table>
+*bool*
+
+The *bool* keyword.
+
+*bool_id*
+
+The boolean identifier.
+
+*default_value*
+
+Either true or false.
 
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
-<td>Yes</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>Yes</td>
-<td>Yes</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | Yes                     |
+
+Conditional Policy Statements
+
+| *if* Statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | Yes                     | Yes                     |
 
 **Examples:**
 
@@ -133,7 +118,7 @@ bool allow_execheap false;
 bool allow_execstack true;
 ```
 
-### if
+## *if*
 
 The if statement is used to form a 'conditional block' of statements and
 rules that are enforced depending on whether one or more boolean
@@ -154,60 +139,48 @@ if (conditional_expression) { true_list } [ else { false_list } ]
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>if</code></td>
-<td>The <code>if</code> keyword.</td>
-</tr>
-<tr>
-<td>conditional_expression</td>
-<td><p>One or more <code>bool_name<code> identifiers that have been previously defined by the <code>bool</code> Statement. Multiple identifiers must be separated by the following logical operators: &amp;&amp;, ¦¦, ^, !, ==, !=. </p>
-<p>The conditional_expression is enclosed in brackets ().</p></td>
-</tr>
-<tr>
-<td><code>true_list</code></td>
-<td><p>A list of rules enclosed within braces '{}' that will be executed when the <code>conditional_expression</code> is 'true'.</p>
-<p>Valid statements and rules are highlighted within each language definition statement.</p></td>
-</tr>
-<tr>
-<td><code>else</code></td>
-<td>Optional <code>else</code> keyword.</td>
-</tr>
-<tr>
-<td><code>false_list</code></td>
-<td><p>A list of rules enclosed within braces '{}' that will be executed when the optional <code>else</code> keyword is present and the conditional_expression is <code>false</code>.</p>
-<p>Valid statements and rules are highlighted within each language definition statement.</p></td>
-</tr>
-</tbody>
-</table>
+*if*
+
+The *if* keyword.
+
+*conditional_expression*
+
+One or more *bool_name* identifiers that have been previously defined by the
+*bool* Statement. Multiple identifiers must be separated by the following
+logical operators: &&, ¦¦, ^, !, ==, !=.
+The *conditional_expression* is enclosed in brackets \'\(\)\'.
+
+*true_list*
+
+A list of rules enclosed within braces \'\{\}\' that will be executed when the
+*conditional_expression* is 'true'.
+Valid statements and rules are highlighted within each language definition
+statement.
+
+*else*
+
+Optional *else* keyword.
+
+*false_list*
+
+A list of rules enclosed within braces \'\{\}\' that will be executed when the
+optional *else* keyword is present and the *conditional_expression* is *false*.
+Valid statements and rules are highlighted within each language definition
+statement.
 
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
-<td>Yes</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | Yes                     |
+
+Conditional Policy Statements
+
+| *if* Statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | Yes                     | No                      |
 
 **Examples:**
 
-- 
2.26.2


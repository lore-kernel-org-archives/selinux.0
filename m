Return-Path: <SRS0=vGri=CY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120F0C43461
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 09:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADD3D21974
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 09:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="BbIxsh0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgIOJhQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Sep 2020 05:37:16 -0400
Received: from mailomta10-sa.btinternet.com ([213.120.69.16]:14299 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726102AbgIOJhP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Sep 2020 05:37:15 -0400
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-042.btinternet.com with ESMTP
          id <20200902131745.VSZA26396.sa-prd-fep-042.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 2 Sep 2020 14:17:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599052665; 
        bh=5PGcYHMCN3Fy+tNhHTEN/QK+aIfiTYzRERfSRkoyMuk=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=BbIxsh0fPqlPFIH4zu5NuLDBWL+cRUKkhnIwpORb576H7yAam45ug6pdKhZIHxz9SuwCmG7fEn5cCXoqcfASpr9sRGBbp7z8Hix6zndi1RUprT95i0bUd5PgEJa5PmpP+6WBtUlhMGVYqkQnyjOXezCIuB662Po0S8ms90qZfUw/FC2VNltR2w+5rvj6KiwENYuvbDOtvnwOpB7vxG2n89531xBbKEraPqgHfEHqmYerFGDeXdGvxGoW2w/UeCl2+dOq5w0iOMxDsSSGxiozqoFuTG6ynLIMcbANAsYJiz19yyMpEpzCHLPaM0Io26xo6Zrx/Gafn8dO0n2qTH9lbw==
Authentication-Results: btinternet.com; none
X-Originating-IP: [109.155.32.197]
X-OWM-Source-IP: 109.155.32.197 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledgieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepuddtledrudehhedrfedvrdduleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduheehrdefvddrudeljedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.32.197) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AFBE0EF36B7F; Wed, 2 Sep 2020 14:17:45 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 03/13] modular_policy_statements: Convert to markdown
Date:   Wed,  2 Sep 2020 14:17:28 +0100
Message-Id: <20200902131738.18425-4-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902131738.18425-1-richard_c_haines@btinternet.com>
References: <20200902131738.18425-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a TOC to aid navigation and convert to markdown.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/modular_policy_statements.md | 229 +++++++++++++------------------
 1 file changed, 95 insertions(+), 134 deletions(-)

diff --git a/src/modular_policy_statements.md b/src/modular_policy_statements.md
index e829e32..e62e6ac 100644
--- a/src/modular_policy_statements.md
+++ b/src/modular_policy_statements.md
@@ -1,5 +1,9 @@
 # Modular Policy Support Statements
 
+- [*module*](#module)
+- [*require*](#require)
+- [*optional*](#optional)
+
 This section contains statements used to support policy modules. They are
 not part of the kernel policy language.
 
@@ -9,7 +13,7 @@ This statement is mandatory for loadable modules (non-base) and must be
 the first line of any module policy source file. The identifier should
 not conflict with other module names within the overall policy,
 otherwise it will over-write an existing module when loaded via the
-semodule command. The ***semodule -l*** command can be used to list all active
+semodule command. The *semodule -l* command can be used to list all active
 modules within the policy.
 
 **The statement definition is:**
@@ -20,49 +24,32 @@ module module_name version_number;
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>module</code></td>
-<td>The <code>module</code> keyword.</td>
-</tr>
-<tr>
-<td><code>module_name</code></td>
-<td>The <code>module</code> name. </td>
-</tr>
-<tr>
-<td><code>version_number</code></td>
-<td>The module version number in M.m.m format (where M = major version number and m = minor version numbers).</td>
-</tr>
-</tbody>
-</table>
+*module*
+
+The *module* keyword.
+
+*module_name*
+
+The *module* name.
+
+*version_number*
+
+The module version number in M.m.m format (where M = major version number
+and m = minor version numbers).
 
 **The statement is valid in:**
 
-<table style="text-align:center">
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Monolithic Policy</strong></td>
-<td><strong>Base Policy</strong></td>
-<td><strong>Module Policy</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>No</td>
-<td>Yes</td>
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
+| No                      | No                      | Yes                     |
+
+Conditional Policy Statements
+
+| *if* Statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | No                      | No                      |
 
 **Example:**
 
@@ -77,15 +64,15 @@ module bind 1.0.0;
 
 The require statement is used for two reasons:
 
-1.  Within loadable module policy source files to indicate what policy
-    components are required from an external source file (i.e. they are
-    not explicitly defined in this module but elsewhere). The examples
-    below show the usage.
-2.  Within a base policy source file, but only if preceded by the
-    [***optional***](#optional) to indicate what policy components
-    are required from an external source file (i.e. they are not
-    explicitly defined in the base policy but elsewhere). The examples
-    below show the usage.
+1. Within loadable module policy source files to indicate what policy
+   components are required from an external source file (i.e. they are
+   not explicitly defined in this module but elsewhere). The examples
+   below show the usage.
+2. Within a base policy source file, but only if preceded by the
+   [***optional***](#optional) to indicate what policy components
+   are required from an external source file (i.e. they are not
+   explicitly defined in the base policy but elsewhere). The examples
+   below show the usage.
 
 **The statement definition is:**
 
@@ -95,49 +82,38 @@ require { rule_list }
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>require</code></td>
-<td>The <code>require</code> keyword.</td>
-</tr>
-<tr>
-<td><code>require_list</code></td>
-<td><p>One or more specific statement keywords with their required identifiers in a semi-colon ';' separated list enclosed within braces '{}'. </p>
-<p>The valid statement keywords are:</p>
-<p><code>role</code>, <code>type</code>, <code>attribute</code>, <code>user</code>, <code>bool</code>, <code>sensitivity</code> and <code>category</code>. The keyword is followed by one or more identifiers in a comma ',' separated list, with the last entry being terminated with a semi-colon (;).</p>
-<p><code>class</code> - The class keyword is followed by a single object class identifier and one or more permissions. Multiple permissions consist of a space separated list enclosed within braces '{}'. The list is then terminated with a semi-colon ';'.</p>
-<p>The examples below show these in detail.</p></td>
-</tr>
-</tbody>
-</table>
+*require*
+
+The *require* keyword.
+
+*require_list*
+
+One or more specific statement keywords with their required identifiers
+in a semi-colon ';' separated list enclosed within braces '{}'. The examples
+below show these in detail. The valid statement keywords are:
+
+- *role*, *type*, *attribute*, *user*, *bool*, *sensitivity* and
+  *category* - The keyword is followed by one or more identifiers in a
+  comma ',' separated list, with the last entry being terminated with a
+  semi-colon ';'.
+- *class* - The class keyword is followed by a single object class identifier
+  and one or more permissions. Multiple permissions consist of a space
+  separated list enclosed within braces '{}'. The list is then terminated
+  with a semi-colon ';'.
 
 **The statement is valid in:**
 
-<table style="text-align:center">
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Monolithic Policy</strong></td>
-<td><strong>Base Policy</strong></td>
-<td><strong>Module Policy</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>Yes - But only if proceeded by the <code>optional</code> Statement</td>
-<td>Yes</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>Yes - But only if proceeded by the <code>optional</code> Statement</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| No | Yes (only if proceeded by the *optional* Statement) | Yes              |
+
+Conditional Policy Statements
+
+| *if* Statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes (only if proceeded by the *optional* Statement) | Yes       | No        |
 
 **Examples:**
 
@@ -183,53 +159,38 @@ optional { rule_list } [ else { rule_list } ]
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>optional</code></td>
-<td>The <code>optional</code> keyword.</td>
-</tr>
-<tr>
-<td><code>rule_list</code></td>
-<td>One or more statements enclosed within braces '{}'. The list of valid statements is given in <em><a href="kernel_policy_language.md#kernel-policy-language"><strong>Table 3:</strong> The policy language statements and rules that are allowed within each type of policy source file</a></em>.</td>
-</tr>
-<tr>
-<td><code>else</code></td>
-<td>An optional <code>else</code> keyword.</td>
-</tr>
-<tr>
-<td><code>rule_list</code></td>
-<td>As the <code>rule_list</code> above.</td>
-</tr>
-</tbody>
-</table>
+*optional*
+
+The *optional* keyword.
+
+*rule_list*
+
+One or more statements enclosed within braces '{}'. The list of valid
+statements is given in
+[**Table 3:** of the Kernel Policy Language](kernel_policy_language.md#kernel-policy-language)
+section.
+
+*else*
+
+An optional *else* keyword.
+
+*rule_list*
+
+As the *rule_list* above.
 
 **The statement is valid in:**
 
-<table style="text-align:center">
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Monolithic Policy</strong></td>
-<td><strong>Base Policy</strong></td>
-<td><strong>Module Policy</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>Yes</td>
-<td>Yes</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | Yes                     | Yes                     |
+
+Conditional Policy Statements
+
+| *if* Statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | Yes                     |
 
 **Examples:**
 
-- 
2.26.2


Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26987C433DF
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAFAA20706
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="CNCkUIho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgHYIi0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:38:26 -0400
Received: from mailomta26-sa.btinternet.com ([213.120.69.32]:46596 "EHLO
        sa-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728605AbgHYIiS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 04:38:18 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20200825083811.VUFQ4609.sa-prd-fep-047.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 25 Aug 2020 09:38:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598344691; 
        bh=XfI7YSDz9AOp789EAuW2cs4yNvVPVMWv3AJxxnNBuDM=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=CNCkUIhoa7mHCwXF7mmtH9A0ynLUiLL4v8R6HGTHtKmLlrYhxpDrAyqQIGi8UA/mg0Pk+ctkeRSZkDlfPhRA4hCBBpqWws16yFpn6xY63dwPjnZNlEV65LN2fC1+TRgvJRka+qKH8GQ9sqWmlksFxnWQ97Z/lFPZV0g7Nf+QR59dEcISXN4y1KcPQCp5HVvQpb5QZY3tWqxber+Qh8T+HRfDC8twSpjntvgSFOwX+d2c85bWmLSjkWmrvUpJzkVOf+mciB9r1ubfOp/fMhA4eKG6luq2kWUFkzf34id0Ltjy01APVhuaBbL72Iet3iIiZbqY8ewrCrveXDrX0TTffg==
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
        id 5ED9B8A70D599E2E; Tue, 25 Aug 2020 09:38:11 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 11/18] constraint_statements: Convert to markdown
Date:   Tue, 25 Aug 2020 09:37:36 +0100
Message-Id: <20200825083743.6508-12-richard_c_haines@btinternet.com>
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
 src/constraint_statements.md | 562 ++++++++++++++++-------------------
 1 file changed, 251 insertions(+), 311 deletions(-)

diff --git a/src/constraint_statements.md b/src/constraint_statements.md
index 4834f6b..4c9a621 100644
--- a/src/constraint_statements.md
+++ b/src/constraint_statements.md
@@ -1,93 +1,82 @@
 # Constraint Statements
 
+- [*constrain*](#constrain)
+- [*validatetrans*](#validatetrans)
+- [*mlsconstrain*](#mlsconstrain)
+- [*mlsvalidatetrans*](#mlsvalidatetrans)
+
 ## *constrain*
 
-The constrain statement allows further restriction on permissions for
+The *constrain* statement allows further restriction on permissions for
 the specified object classes by using boolean expressions covering:
 source and target types, roles and users as described in the examples.
 
 **The statement definition is:**
 
 ```
-constrain class perm_set expression;
+constrain class perm_set expression | expr ...;
 ```
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>constrain</code></td>
-<td>The <code>constrain</code> keyword.</td>
-</tr>
-<tr>
-<td><code>class</code></td>
-<td>One or more object classes. Multiple entries consist of a space separated list enclosed in braces '{}'.</td>
-</tr>
-<tr>
-<td><code>perm_set</code></td>
-<td>One or more permissions. Multiple entries consist of a space separated list enclosed in braces '{}'.</td>
-</tr>
-<tr>
-<td><code>expression</code></td>
-<td>The boolean expression of the constraint that is defined as follows:</td>
-</tr>
-<tr>
-<td></td>
-<td><p> <code>( expression : expression )</code> </p>
-<p><code>| not expression</code></p>
-<p><code>| expression and expression</code></p>
-<p><code>| expression or expression</code></p>
-<p><code>| u1 op u2</code></p>
-<p><code>| r1 role_op r2</code></p>
-<p><code>| t1 op t2</code></p>
-<p><code>| u1 op names</code></p>
-<p><code>| u2 op names</code></p>
-<p><code>| r1 op names</code></p>
-<p><code>| r2 op names</code></p>
-<p><code>| t1 op names</code></p>
-<p><code>| t2 op names</code></p></td>
-</tr>
-<tr>
-<td><p>Where:</p>
-<p>u1, r1, t1 = Source user, role, type</p>
-<p>u2, r2, t2 = Target user, role, type</p>
-<p>and:</p>
-<p>op : == | != </p>
-<p>role_op : == | != | eq | dom | domby | incomp</p>
-<p>names : name | { name_list }</p>
-<p>name_list : name | name_list name</p></td>
-<td></td>
-</tr>
-</tbody>
-</table>
+*constrain*
+
+The *constrain* keyword.
+
+*class*
+
+One or more object classes. Multiple entries consist of a space separated list
+enclosed in braces \'\{\}\'.
+
+*perm_set*
+
+One or more permissions. Multiple entries consist of a space separated list
+enclosed in braces \'\{\}\'.
+
+*expression*
+
+There must be one constraint *expression* or one or more *expr*'s. An
+*expression* consists of '*operand operator operand*' as follows:
+
+- *( u1 op u2 )*
+- *( r1 role_op r2 )*
+- *( t1 op t2 )*
+- *( u1 op names )*
+- *( u2 op names )*
+- *( r1 op names )*
+- *( r2 op names )*
+- *( t1 op names )*
+- *( t2 op names )*
+- Where:
+  - *u1*, *r1*, *t1* = Source *user*, *role*, *type*
+  - *u2*, *r2*, *t2* = Target *user*, *role*, *type*
+- And:
+  - *op : == | !=*
+  - *role_op : == | != | eq | dom | domby | incomp*
+  - *names : name | { name_list }*
+  - *name_list : name | name_list name*
+
+*expr*
+
+Zero or more *expr*'s, the valid operators and syntax are:
+
+- *( not expression )*
+- *( expression and expression )*
+- *( expression or expression )*
 
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
 
@@ -174,12 +163,12 @@ constrain { dir file lnk_file sock_file fifo_file chr_file blk_file } { create r
 
 ## *validatetrans*
 
-This statement is used to control the ability to change the objects
-security context.
+The *validatetrans* statement is used to control the ability to change the
+objects security context.
 
-The first context *u1.r1.t1* is the context before the transition, the
-second context *u2.r2.t2* is the context after the transition, and the
-third *u3.r3.t3* is the context of the process performing the transition.
+The first context *u1:r1:t1* is the context before the transition, the
+second context *u2:r2:t2* is the context after the transition, and the
+third *u3:r3:t3* is the context of the process performing the transition.
 
 Note there are no *validatetrans* statements specified within the
 **Reference Policy** source.
@@ -187,95 +176,78 @@ Note there are no *validatetrans* statements specified within the
 **The statement definition is:**
 
 ```
-validatetrans class expression;
+validatetrans class  expression | expr ...;
 ```
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>validatetrans</code></td>
-<td>The <code>validatetrans</code> keyword.</td>
-</tr>
-<tr>
-<td><code>class</code></td>
-<td>One or more file related object classes. Multiple entries consist of a space separated list enclosed in braces '{}'.</td>
-</tr>
-<tr>
-<td><code>expression</code></td>
-<td>The boolean expression of the constraint that is defined as follows:</td>
-</tr>
-<tr>
-<td></td>
-<td><p><code>( expression : expression )</code> </p>
-<p><code>| not expression</code></p>
-<p><code>| expression and expression</code></p>
-<p><code>| expression or expression</code></p>
-<p><code>| u1 op u2</code></p>
-<p><code>| r1 role_op r2</code></p>
-<p><code>| t1 op t2</code></p>
-<p><code>| u1 op names</code></p>
-<p><code>| u2 op names</code></p>
-<p><code>| r1 op names</code></p>
-<p><code>| r2 op names</code></p>
-<p><code>| t1 op names</code></p>
-<p><code>| t2 op names</code></p>
-<p><code>| u3 op names</code></p>
-<p><code>| r3 op names</code></p>
-<p><code>| t3 op names</p></code></td>
-</tr>
-<tr>
-<td><p>Where:</p>
-<p>u1, r1, t1 = Old user, role, type</p>
-<p>u2, r2, t2 = New user, role, type</p>
-<p>u3, r3, t3 = Process user, role, type</p>
-<p>and:</p>
-<p>op : == | !=</p>
-<p>role_op : == | != | eq | dom | domby | incomp</p>
-<p>names : name | { name_list }</p>
-<p>name_list : name | name_list name</p></td>
-<td></td>
-</tr>
-</tbody>
-</table>
+*validatetrans*
+
+The *validatetrans* keyword.
+
+*class*
+
+One or more object classes. Multiple entries consist of a space separated list
+enclosed in braces \'\{\}\'.
+
+*expression*
+
+There must be one constraint *expression* or one or more *expr*'s. An
+*expression* consists of '*operand operator operand*' as follows:
+
+- *( u1 op u2 )*
+- *( r1 role_op r2 )*
+- *( t1 op t2 )*
+- *( u1 op names )*
+- *( u2 op names )*
+- *( u3 op names )*
+- *( r1 op names )*
+- *( r2 op names )*
+- *( r3 op names )*
+- *( t1 op names )*
+- *( t2 op names )*
+- *( t3 op names )*
+- Where:
+  - *u1*, *r1*, *t1* = Source *user*, *role*, *type*
+  - *u2*, *r2*, *t2* = Target *user*, *role*, *type*
+  - *u3*, *r3*, *t3* = Process *user*, *role*, *type*
+- And:
+  - *op : == | !=*
+  - *role_op : == | != | eq | dom | domby | incomp*
+  - *names : name | { name_list }*
+  - *name_list : name | name_list name*
+
+*expr*
+
+Zero or more *expr*'s, the valid operators and syntax are:
+
+- *( not expression )*
+- *( expression and expression )*
+- *( expression or expression )*
 
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
 
 ```
-validatetrans { file } { t1 == unconfined_t );
+validatetrans { file } ( t1 == unconfined_t );
 ```
 
 ## *mlsconstrain*
 
-The mlsconstrain statement allows further restriction on permissions for
+The *mlsconstrain* statement allows further restriction on permissions for
 the specified object classes by using boolean expressions covering:
 source and target types, roles, users and security levels as described
 in the examples.
@@ -283,91 +255,75 @@ in the examples.
 **The statement definition is:**
 
 ```
-mlsconstrain class perm_set expression;
+mlsconstrain class perm_set expression | expr ...;
 ```
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>mlsconstrain</code></td>
-<td>The <code>mlsconstrain</code> keyword.</td>
-</tr>
-<tr>
-<td><code>class</code></td>
-<td>One or more object classes. Multiple entries consist of a space separated list enclosed in braces '{}'.</td>
-</tr>
-<tr>
-<td><code>perm_set</code></td>
-<td>One or more permissions. Multiple entries consist of a space separated list enclosed in braces '{}'.</td>
-</tr>
-<tr>
-<td><code>expression<code></td>
-<td>The boolean expression of the constraint that is defined as follows:</td>
-</tr>
-<tr>
-<td></td>
-<td><p><code> ( expression : expression ) </code></p>
-<p><code>| not expression</code></p>
-<p><code>| expression and expression</code></p>
-<p><code>| expression or expression</code></p>
-<p><code>| u1 op u2</code></p>
-<p><code>| r1 role_mls_op r2</code></p>
-<p><code>| t1 op t2</code></p>
-<p><code>| l1 role_mls_op l2</code></p>
-<p><code>| l1 role_mls_op h2</code></p>
-<p><code>| h1 role_mls_op l2</code></p>
-<p><code>| h1 role_mls_op h2</code></p>
-<p><code>| l1 role_mls_op h1</code></p>
-<p><code>| l2 role_mls_op h2</code></p>
-<p><code>| u1 op names</code></p>
-<p><code>| u2 op names</code></p>
-<p><code>| r1 op names</code></p>
-<p><code>| r2 op names</code></p>
-<p><code>| t1 op names</code></p>
-<p><code>| t2 op names</code></p></td>
-</tr>
-<tr>
-<td><p>Where:</p>
-<p>u1, r1, t1, l1, h1 = Source user, role, type, low level, high level</p>
-<p>u2, r2, t2, l2, h2 = Target user, role, type, low level, high level</p>
-<p>and:</p>
-<p>op : == | !=</p>
-<p>role_mls_op : == | != | eq | dom | domby | incomp</p>
-<p>names : name | { name_list }</p>
-<p>name_list : name | name_list name</p></td>
-<td></td>
-</tr>
-</tbody>
-</table>
+*mlsconstrain*
+
+The *mlsconstrain* keyword.
+
+*class*
+
+One or more object classes. Multiple entries consist of a space separated
+list enclosed in braces \'\{\}\'.
+
+*perm_set*
+
+One or more permissions. Multiple entries consist of a space separated
+list enclosed in braces \'\{\}\'.
+
+*expression*
+
+There must be one constraint *expression* or one or more *expr*'s. An
+*expression* consists of '*operand operator operand*' as follows:
+
+- *( u1 op u2 )*
+- *( r1 role_mls_op r2 )*
+- *( t1 op t2 )*
+- *( l1 role_mls_op l2 )*
+- *( l1 role_mls_op h2 )*
+- *( h1 role_mls_op l2 )*
+- *( h1 role_mls_op h2 )*
+- *( l1 role_mls_op h1 )*
+- *( l2 role_mls_op h2 )*
+- *( u1 op names )*
+- *( u2 op names )*
+- *( r1 op names )*
+- *( r2 op names )*
+- *( t1 op names )*
+- *( t2 op names )*
+- Where:
+  - *u1*, *r1*, *t1*, *l1*, *h1* = Source *user*, *role*, *type*, *low*, *high*
+  - *u2*, *r2*, *t2*, *l2*, *h2* = Target *user*, *role*, *type*, *low*, *high*
+- And:
+  - *op : == | !=*
+  - *role_mls_op : == | != | eq | dom | domby | incomp*
+  - *names : name | { name_list }*
+  - *name_list : name | name_list name*
+
+*expr*
+
+Zero or more *expr*'s, the valid operators and syntax are:
+
+- *( not expression )*
+- *( expression and expression )*
+- *( expression or expression )*
 
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
 
@@ -404,98 +360,82 @@ The *mlsvalidatetrans* is the MLS equivalent of the *validatetrans*
 statement where it is used to control the ability to change the objects
 security context.
 
-The first context *u1.r1.t1* is the context before the transition, the
-second context *u2.r2.t2* is the context after the transition, and the
-third *u3.r3.t3* is the context of the process performing the transition.
+The first context *u1:r1:t1:l1-h1* is the context before the transition, the
+second context *u2:r2:t2:l2-h2* is the context after the transition, and the
+third *u3:r3:t3:*\[*range*\] is the context of the process performing the
+transition.
 
 **The statement definition is:**
 
 ```
-mlsvalidatetrans class expression;
+mlsvalidatetrans class expression | expr ...;
 ```
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>mlsvalidatetrans</code></td>
-<td>The <code>mlsvalidatetrans</code> keyword.</td>
-</tr>
-<tr>
-<td><code>class</code></td>
-<td>One or more file type object classes. Multiple entries consist of a space separated list enclosed in braces '{}'.</td>
-</tr>
-<tr>
-<td><code>expression</code></td>
-<td>The boolean expression of the constraint that is defined as follows:</td>
-</tr>
-<tr>
-<td></td>
-<td><p><code>( expression : expression ) </code></p>
-<p><code>| not expression</code></p>
-<p><code>| and (expression and expression</code></p>
-<p><code>| or expression or expression</code></p>
-<p><code>| u1 op u2</code></p>
-<p><code>| r1 role_mls_op r2</code></p>
-<p><code>| t1 op t2</code></p>
-<p><code>| l1 role_mls_op l2</code></p>
-<p><code>| l1 role_mls_op h2</code></p>
-<p><code>| h1 role_mls_op l2</code></p>
-<p><code>| h1 role_mls_op h2</code></p>
-<p><code>| l1 role_mls_op h1</code></p>
-<p><code>| l2 role_mls_op h2</code></p>
-<p><code>| u1 op names</code></p>
-<p><code>| u2 op names</code></p>
-<p><code>| r1 op names</code></p>
-<p><code>| r2 op names</code></p>
-<p><code>| t1 op names</code></p>
-<p><code>| t2 op names</code></p>
-<p><code>| u3 op names</code></p>
-<p><code>| r3 op names</code></p>
-<p><code>| t3 op names</code></p></td>
-</tr>
-<tr>
-<td><p>Where:</p>
-<p>u1, r1, t1, l1, h1 = Old user, role, type, low level, high level</p>
-<p>u2, r2, t2, l2, h2 = New user, role, type, low level, high level</p>
-<p>u3, r3, t3, l3, h3 = Process user, role, type, low level, high level</p>
-<p>and:</p>
-<p>op : == | !=</p>
-<p>role_mls_op : == | != | eq | dom | domby | incomp</p>
-<p>names : name | { name_list }</p>
-<p>name_list : name | name_list name</p></td>
-<td></td>
-</tr>
-</tbody>
-</table>
+*mlsvalidatetrans*
+
+The *mlsvalidatetrans* keyword.
+
+*class*
+
+One or more object classes. Multiple entries consist of a space separated list
+enclosed in braces \'\{\}\'.
+
+*expression*
+
+There must be one constraint *expression* or one or more *expr*'s. An
+*expression* consists of '*operand operator operand*' as follows:
+
+- *( u1 op u2 )*
+- *( r1 role_mls_op r2 )*
+- *( t1 op t2 )*
+- *( l1 role_mls_op l2 )*
+- *( l1 role_mls_op h2 )*
+- *( h1 role_mls_op l2 )*
+- *( h1 role_mls_op h2 )*
+- *( l1 role_mls_op h1 )*
+- *( l2 role_mls_op h2 )*
+- *( u1 op names )*
+- *( u2 op names )*
+- *( u3 op names )*
+- *( r1 op names )*
+- *( r2 op names )*
+- *( r3 op names )*
+- *( t1 op names )*
+- *( t2 op names )*
+- *( t3 op names )*
+- Where:
+  - *u1*, *r1*, *t1*, *l1*, *h1* = Source *user*, *role*, *type*, *low*, *high*
+  - *u2*, *r2*, *t2*, *l2*, *h2* = Target *user*, *role*, *type*, *low*, *high*
+  - *u3*, *r3*, *t3*, \[*range*\] = Process *user*, *role*, *type*, \[*range*\]
+- And:
+  - *op : == | !=*
+  - *role_mls_op : == | != | eq | dom | domby | incomp*
+  - *names : name | { name_list }*
+  - *name_list : name | name_list name*
+
+*expr*
+
+Zero or more *expr*'s, the valid operators and syntax are:
+
+- *( not expression )*
+- *( expression and expression )*
+- *( expression or expression )*
 
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
 
-- 
2.26.2


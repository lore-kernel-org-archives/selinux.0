Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE1EC1B087
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 11:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF0623358
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 11:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgLGLnz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Dec 2020 06:43:55 -0500
Received: from mailomta12-sa.btinternet.com ([213.120.69.18]:19443 "EHLO
        sa-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726920AbgLGLnz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Dec 2020 06:43:55 -0500
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-042.btinternet.com with ESMTP
          id <20200902131749.VSZJ26396.sa-prd-fep-042.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 2 Sep 2020 14:17:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599052669; 
        bh=SiJK/x+UPWFOsLATevCqvVre/gI5Ap+L0Q69Dk7Hoys=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=pzgdPYW+73g8eNOPr4866ohW4irKoWNxwQeDMtH2jCHXAPhRscK6gyOx6NSMqBZS9oOFzZ4haT1Q449zB0611E/YOgyhJYWvvy1GX9KdXvNOG3Jo7WXlgRr4UGZhgbIOWL5qRte9UH8O11i351mf5nQyk/RblRQ84+vTgFsV3iG1I0i06Ps9PlW49Emb7SLJ9HL6hXDl1k07WazcTedhiVBr4T14gYR7l6YWdU3lOrUwR0e4iE0I/1sg1rC3QJhl3xKcJQCsuARdrMA7os2cw+O/d7NycEyhMgw4l4/DkVcKQBiomMqAoS9vT4xn2Dvn1HSRcDg4smeRB8LL+aPw5g==
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
        id 5ED9AFBE0EF36C0D; Wed, 2 Sep 2020 14:17:49 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 13/13] role_statements: Convert to markdown
Date:   Wed,  2 Sep 2020 14:17:38 +0100
Message-Id: <20200902131738.18425-14-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902131738.18425-1-richard_c_haines@btinternet.com>
References: <20200902131738.18425-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a TOC to aid navigation and convert to markdown.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/role_statements.md | 443 +++++++++++++++++------------------------
 1 file changed, 178 insertions(+), 265 deletions(-)

diff --git a/src/role_statements.md b/src/role_statements.md
index c11a01d..b706234 100644
--- a/src/role_statements.md
+++ b/src/role_statements.md
@@ -1,5 +1,12 @@
 # Role Statements
 
+- [*role*](#role)
+- [*attribute_role*](#attribute_role)
+- [*roleattribute*](#roleattribute)
+- [*allow*](#allow)
+- [*role_transition*](#role_transition)
+- [*dominance* - Deprecated](#dominance---deprecated)
+
 Policy version 26 introduced two new role statements aimed at replacing
 the deprecated role *dominance* rule by making role relationships easier to
 understand. These new statements: *attribute_role* and *roleattribute*
@@ -27,54 +34,42 @@ role role_id types type_id;
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>role</code></td>
-<td>The <code>role</code> keyword.</td>
-</tr>
-<tr>
-<td><code>role_id</code></td>
-<td>The identifier of the role being declared. The same role identifier can be declared more than once in a policy, in which case the <code>type_id</code> entries will be amalgamated by the compiler.</td>
-</tr>
-<tr>
-<td><code>types</code></td>
-<td>The optional <code>types</code> keyword.</td>
-</tr>
-<tr>
-<td><code>type_id</code></td>
-<td><p>When used with the <code>types</code> keyword, one or more type, <code>typealias</code> or <code>attribute</code> identifiers associated with the <code>role_id</code>. Multiple entries consist of a space separated list enclosed in braces '{}'. Entries can be excluded from the list by using the negative operator '-'.</p>
-<p>For <code>role</code> statements, only <code>type</code>, <code>typealias</code> or <code>attribute</code> identifiers associated to domains have any meaning within SELinux.</p></td>
-</tr>
-</tbody>
-</table>
+*role*
+
+The *role* keyword.
+
+*role_id*
+
+The identifier of the role being declared. The same *role* identifier can be
+declared more than once in a policy, in which case the *type_id* entries will
+be amalgamated by the compiler.
+
+*types*
+
+The optional *types* keyword.
+
+*type_id*
+
+When used with the *types* keyword, one or more type, *typealias* or
+*attribute* identifiers associated with the *role_id*. Multiple entries
+consist of a space separated list enclosed in braces '{}'. Entries can be
+excluded from the list by using the negative operator '-'.
+For *role* statements, only *type*, *typealias* or *attribute* identifiers
+associated to domains have any meaning within SELinux.
 
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
 
@@ -108,45 +103,27 @@ attribute_role attribute_id;
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>attribute_role</code></td>
-<td>The <code>attribute_role</code> keyword.</td>
-</tr>
-<tr>
-<td><code>attribute_id</code></td>
-<td>The <code>attribute</code> identifier.</td>
-</tr>
-</tbody>
-</table>
+*attribute_role*
+
+The *attribute_role* keyword.
+
+*attribute_id*
+
+The *attribute* identifier.
 
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
 
@@ -161,8 +138,8 @@ attribute_role srole_list_2;
 
 ## *roleattribute*
 
-The <code>roleattribute</code> statement allows the association of previously
-declared roles to one or more previously declared <code>attribute_roles</code>.
+The *roleattribute* statement allows the association of previously
+declared roles to one or more previously declared *attribute_roles*.
 
 **The statement definition is:**
 
@@ -172,49 +149,32 @@ roleattribute role_id attribute_id;
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>roleattribute</code></td>
-<td>The <code>roleattribute</code> keyword.</td>
-</tr>
-<tr>
-<td><code>role_id</code></td>
-<td>The identifier of a previously declared <code>role</code>.</td>
-</tr>
-<tr>
-<td><code>attribute_id</code></td>
-<td>One or more previously declared <code>attribute_role</code> identifiers. Multiple entries consist of a comma ',' separated list.</td>
-</tr>
-</tbody>
-</table>
+*roleattribute*
+
+The *roleattribute* keyword.
+
+*role_id*
+
+The identifier of a previously declared *role*.
+
+*attribute_id*
+
+One or more previously declared *attribute_role* identifiers. Multiple entries
+consist of a comma ',' separated list.
 
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
 
@@ -232,11 +192,11 @@ roleattribute service_r role_list_1;
 
 ## *allow*
 
-The role *allow* rule checks whether a request to change roles is allowed,
+The 'role *allow*' rule checks whether a request to change roles is allowed,
 if it is, then there may be a further request for a *role_transition* so
 that the process runs with the new role or role set.
 
-Note that the role allow rule has the same keyword as the allow AV rule.
+Note that the 'role *allow*' rule has the same keyword as the *allow* AV rule.
 
 **The statement definition is:**
 
@@ -246,49 +206,33 @@ allow from_role_id to_role_id;
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>allow</code></td>
-<td>The <code>role allow</code> rule keyword.</td>
-</tr>
-<tr>
-<td><code>from_role_id</code></td>
-<td>One or more <code>role</code> or <code>attribute_role</code> identifiers that identify the current role. Multiple entries consist of a space separated list enclosed in braces '{}'.</td>
-</tr>
-<tr>
-<td><code>to_role_id</code></td>
-<td>One or more <code>role</code> or <code>attribute_role</code> identifiers that identify the current role. Multiple entries consist of a space separated list enclosed in braces '{}'.</td>
-</tr>
-</tbody>
-</table>
+*allow*
+
+The role *allow* rule keyword.
+
+*from_role_id*
+
+One or more *role* or *attribute_role* identifiers that identify the current
+role. Multiple entries consist of a space separated list enclosed in braces '{}'.
+
+*to_role_id*
+
+One or more *role* or *attribute_role* identifiers that identify the current
+role. Multiple entries consist of a space separated list enclosed in braces '{}'.
 
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
 
 **Example:**
 
@@ -321,57 +265,43 @@ role_transition current_role_id type_id : class new_role_id;
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>role_transition</code></td>
-<td>The <code>role_transition</code> keyword.</td>
-</tr>
-<tr>
-<td><code>current_role_id</code></td>
-<td>One or more <code>role</code> or <code>attribute_role</code> identifiers that identify the current role. Multiple entries consist of a space separated list enclosed in braces '{}'.</td>
-</tr>
-<tr>
-<td><code>type_id</code></td>
-<td>One or more <code>type</code>, <code>typealias</code> or <code>attribute</code> identifiers. Multiple entries consist of a space separated list enclosed in braces '{}'. Entries can be excluded from the list by using the negative operator '-'. </td>
-</tr>
-<tr>
-<td><code>class</code></td>
-<td>For policy versions &gt;= 25 an object <code>class</code> that applies to the role transition. If omitted defaults to the <code>process</code> object class.</td>
-</tr>
-<tr>
-<td><code>new_role_id</code></td>
-<td>A single <code>role</code> identifier that will become the new role. </td>
-</tr>
-</tbody>
-</table>
+*role_transition*
+
+The *role_transition* keyword.
+
+*current_role_id*
+
+One or more *role* or *attribute_role* identifiers that identify the current
+role. Multiple entries consist of a space separated list enclosed in braces '{}'.
+
+*type_id*
+
+One or more *type*, *typealias* or *attribute* identifiers. Multiple entries
+consist of a space separated list enclosed in braces '{}'. Entries can be
+excluded from the list by using the negative operator '-'.
+
+*class*
+
+For policy versions \>= 25 an object *class* that applies to the role
+transition. If omitted defaults to the *process* object class.
+
+*new_role_id*
+
+A single *role* identifier that will become the new role.
 
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
 
 **Example:**
 
@@ -388,12 +318,12 @@ inherit all the type associations of the other roles.
 
 Notes:
 
-1.  There is another dominance rule for MLS (see the
-    [**MLS *dominance***](mls_statements.md#dominance) statement.
-2.  The role dominance rule is not used by the **Reference Policy** as
-    the policy manages role dominance using the
-    [***constrain***](constraint_statements.md#constraint-statements) statement.
-3.  Note the usage of braces '{}' and the ';' in the statement.
+1. There is another dominance rule for MLS (see the
+   [**MLS *dominance***](mls_statements.md#dominance) statement.
+2. The role dominance rule is not used by the **Reference Policy** as
+   the policy manages role dominance using the
+   [***constrain***](constraint_statements.md#constraint-statements) statement.
+3. Note the usage of braces '{}' and the ';' in the statement.
 
 **The statement definition is:**
 
@@ -401,55 +331,38 @@ Notes:
 dominance { role dom_role_id { role role_id; } }
 ```
 
-Where:
-
-<table>
-<tbody>
-<tr>
-<td><code>dominance</code></td>
-<td>The <code>dominance</code> keyword.</td>
-</tr>
-<tr>
-<td><code>role</code></td>
-<td>The <code>role</code> keyword.</td>
-</tr>
-<tr>
-<td><code>dom_role_id</code></td>
-<td>The dominant role identifier.</td>
-</tr>
-<tr>
-<td><code>role_id</code></td>
-<td>For the simple case each <code>{ role role_id; }</code> pair defines the <code>role_id</code> that will be dominated by the <code>dom_role_id</code>.</td>
-</tr>
-</tbody>
-</table>
+**Where:**
+
+*dominance*
+
+The *dominance* keyword.
+
+*role*
+
+The *role* keyword.
+
+*dom_role_id*
+
+The dominant role identifier.
+
+*role_id*
+
+For the simple case each *{ role role_id; }* pair defines the *role_id* that
+will be dominated by the *dom_role_id*.
 
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
 
 **Example:**
 
-- 
2.26.2


Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7730BC433E0
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 15:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43BA42224D
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 15:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="eM0ZBRKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgHGPRh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Aug 2020 11:17:37 -0400
Received: from mailomta9-re.btinternet.com ([213.120.69.102]:14825 "EHLO
        re-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725893AbgHGPRg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Aug 2020 11:17:36 -0400
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20200807151727.WMDR4701.re-prd-fep-048.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Fri, 7 Aug 2020 16:17:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1596813447; 
        bh=EPDccZIoxI9SuQpBnYU4Bk6UqDq7CcH6GETD48y7BxQ=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=eM0ZBRKRZb2RospdicwQCgrCgtha3gek0VwXUii9fV28wLcLaH+VaOEVMVxAwhDAOlttMngMT+QCvzAbe8g4X1QwHui7aZBp7XQcc2+q7FAIisjRlRtZj9fP2RUhqYfkCElFJiS1OVg3RHjH8jC1eNGg5cuiKuQ+tn+nTAyLcVOyoiHD+J3EaiVepp7yFj/6zSkAPerCA2WI4jijfQhiZEvuiHiiUbM9p8unFHwhMuQZ7IqxE9qDz9Otk4i2/fdqeKWIuOHiWNkG0O9L371AxyQOVfPvS4TQoZTy/1PxrpGensu+sUJ2S5UEyV/kMpOaUXLCKAWIHtdFNlIHOKHTRA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [213.122.112.2]
X-OWM-Source-IP: 213.122.112.2 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrkedvgdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepleetffegveevjeehvefhtefgueevudettedutdffvdejkeeiteegheevfeejtdefnecukfhppedvudefrdduvddvrdduuddvrddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedvudefrdduvddvrdduuddvrddvpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (213.122.112.2) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9BDD00AC9DDD9; Fri, 7 Aug 2020 16:17:27 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] selinux-notebook: kernel_policy_language.md convert to markdown
Date:   Fri,  7 Aug 2020 16:17:22 +0100
Message-Id: <20200807151722.12114-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a TOC to aid navigation and convert HTML tables to either pipe tables
or markdown unordered lists.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/kernel_policy_language.md | 1016 ++++++---------------------------
 1 file changed, 182 insertions(+), 834 deletions(-)

diff --git a/src/kernel_policy_language.md b/src/kernel_policy_language.md
index a4118f9..921c7d0 100644
--- a/src/kernel_policy_language.md
+++ b/src/kernel_policy_language.md
@@ -1,7 +1,14 @@
 # Kernel Policy Language
 
+-   [Policy Source Files](#policy-source-files)
+-   [Conditional, Optional and Require Statement Rules](#conditional-optional-and-require-statement-rules)
+-   [MLS Statements and Optional MLS Components](#mls-statements-and-optional-mls-components)
+-   [General Statement Information](#general-statement-information)
+-   [Policy Language Index](#policy-language-index)
+
 This section covers the policy source file types and what kernel policy
-statements and rule are allowed in each. The [**Section Contents**](#section-contents)
+statements and rule are allowed in each. The
+[**Policy Language Index**](#policy-language-index)
 then has links to each section within this document.
 
 ## Policy Source Files
@@ -12,7 +19,7 @@ are:
 
 **Monolithic Policy** - This is a single policy source file that
 contains all statements. By convention this file is called policy.conf
-and is compiled using the **checkpolicy**(8) command that produces the
+and is compiled using the ***checkpolicy**(8)* command that produces the
 binary policy file.
 
 **Base Policy** - This is the mandatory base policy source file that
@@ -33,176 +40,70 @@ extension. These files are compiled using the ***checkmodule**(8)* command.
 appear in source files with the mandatory statements that must be
 present.
 
-<table>
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Base Entries</strong></td>
-<td><strong>M&#47;O</strong></td>
-<td><strong>Module Entries</strong></td>
-<td><strong>M&#47;O</strong></td>
-</tr>
-<tr>
-<td>Security Classes (class)</td>
-<td>m</td>
-<td>module Statement</td>
-<td>o</td>
-</tr>
-<tr>
-<td>Initial SIDs</td>
-<td>m</td>
-<td></td>
-<td></td>
-</tr>
-<tr>
-<td>Access Vectors (permissions)</td>
-<td>m</td>
-<td>require Statement</td>
-<td>o</td>
-</tr>
-<tr>
-<td>MLS sensitivity, category and level Statements</td>
-<td>o</td>
-<td></td>
-<td></td>
-</tr>
-<tr>
-<td>MLS Constraints</td>
-<td>o</td>
-<td></td>
-<td></td>
-</tr>
-<tr>
-<td>Policy Capability Statements</td>
-<td>o</td>
-<td></td>
-<td></td>
-</tr>
-<tr>
-<td>Attributes</td>
-<td>o</td>
-<td>Attributes</td>
-<td>o</td>
-</tr>
-<tr>
-<td>Booleans</td>
-<td>o</td>
-<td>Booleans</td>
-<td>o</td>
-</tr>
-<tr>
-<td>Default user, role, type, range rules</td>
-<td>o</td>
-<td></td>
-<td></td>
-</tr>
-<tr>
-<td>Type / Type Alias</td>
-<td>m</td>
-<td>Type / Type Alias</td>
-<td>o</td>
-</tr>
-<tr>
-<td>Roles</td>
-<td>m</td>
-<td>Roles</td>
-<td>o</td>
-</tr>
-<tr>
-<td>Policy Rules</td>
-<td>m</td>
-<td>Policy Rules</td>
-<td>o</td>
-</tr>
-<tr>
-<td>Users</td>
-<td>m</td>
-<td>Users</td>
-<td>o</td>
-</tr>
-<tr>
-<td>Constraints</td>
-<td>o</td>
-<td></td>
-<td></td>
-</tr>
-<tr>
-<td>Default SID labeling</td>
-<td>m</td>
-<td></td>
-<td></td>
-</tr>
-<tr>
-<td>fs_use_xattr Statements</td>
-<td>o</td>
-<td></td>
-<td></td>
-</tr>
-<tr>
-<td>fs_use_task and fs_use_trans Statements</td>
-<td>o</td>
-<td></td>
-<td></td>
-</tr>
-<tr>
-<td>genfscon Statements</td>
-<td>o</td>
-<td></td>
-<td></td>
-</tr>
-<tr>
-<td>portcon, netifcon and nodecon Statements</td>
-<td>o</td>
-<td></td>
-<td></td>
-</tr>
-</tbody>
-</table>
-
-**Table 1: Base and Module Policy Statements** -*There must be at least one
+| Base Entries                                   | M/O |
+| :--------------------------------------------- | :-: |
+| Security Classes (class)                       | m   |
+| Initial SIDs                                   | m   |
+| Access Vectors (permissions)                   | m   |
+| require Statement                              | o   |
+| MLS sensitivity, category and level Statements | o   |
+| MLS Constraints                                | m   |
+| Policy Capability Statements                   | o   |
+| Attributes                                     | o   |
+| Booleans                                       | o   |
+| Default user, role, type, range rules          | o   |
+| Type / Type Alias                              | m   |
+| Roles                                          | m   |
+| Policy Rules (allow, dontaudit etc.)           | m   |
+| Users                                          | m   |
+| Constraints                                    | o   |
+| Default SID labeling                           | m   |
+| fs_use_xattr Statements                        | o   |
+| fs_use_task and fs_use_trans Statements        | o   |
+| genfscon Statements                            | o   |
+| portcon, netifcon and nodecon Statements       | o   |
+
+| Module Entries    | M/O |
+| :---------------- | :-: |
+| module Statement  | m   |
+| require Statement | o   |
+| Attributes        | o   |
+| Booleans          | o   |
+| Type / Type Alias | o   |
+| Roles             | o   |
+| Policy Rules      | o   |
+| Users             | o   |
+
+**Table 1: Base and Module Policy Statements** - *There must be at least one
 of each of the mandatory statements, plus at least one allow rule in a policy
 to successfully build.*
 
 The language grammar defines what statements and rules can be used
 within the different types of source file. To highlight these rules, the
 following table is included in each statement and rule section to show
-what circumstances each one is valid within a policy source file:
-
-<table style="text-align:center">
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Monolithic Policy</strong></td>
-<td><strong>Base Policy</strong></td>
-<td><strong>Module Policy</strong></td>
-</tr>
-<tr>
-<td>Yes/No</td>
-<td>Yes/No</td>
-<td>Yes/No</td>
-</tr>
-</tbody>
-</table>
-
-Where:
-
-<table>
-<tbody>
-<tr>
-<td>Monolithic Policy</td>
-<td>Whether the statement is allowed within a monolithic policy source file or not.</td>
-</tr>
-<tr>
-<td>Base Policy</td>
-<td>Whether the statement is allowed within a base (for loadable module support) policy source file or not.</td>
-</tr>
-<tr>
-<td>Module Policy</td>
-<td>Whether the statement is allowed within the optional loadable module policy source file or not.</td>
-</tr>
-</tbody>
-</table>
-
-**Table 3** shows a cross reference matrix of statements
-and rules allowed in each type of policy source file.
+what circumstances each one is valid within a policy source file.
+
+**Policy Type**:
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes/No                  | Yes/No                  | Yes/No                  |
+
+**Where:**
+
+*Monolithic Policy*
+
+-   Whether the statement is allowed within a monolithic policy source file or not.
+
+*Base Policy*
+
+-   Whether the statement is allowed within a base (for loadable module support)
+    policy source file or not.
+
+*Module Policy*
+
+-   Whether the statement is allowed within the optional loadable module policy
+    source file or not.
 
 ## Conditional, Optional and Require Statement Rules
 
@@ -221,42 +122,27 @@ To highlight these rules the following table is included in each
 statement and rule section to show what circumstances each one is valid
 within a policy source file:
 
-<table style="text-align:center">
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>Yes/No</td>
-<td>Yes/No</td>
-<td>Yes/No</td>
-</tr>
-</tbody>
-</table>
-
-Where:
-
-<table>
-<tbody>
-<tr>
-<td>Conditional Policy (if) Statement</td>
-<td>Whether the statement is allowed within a conditional statement (<code>if/else</code> construct). Conditional statements can be in all types of policy source file.</td>
-</tr>
-<tr>
-<td>optional Statement</td>
-<td>Whether the statement is allowed within the <code>optional { rule_list }</code> construct.</td>
-</tr>
-<tr>
-<td>require Statement</td>
-<td>Whether the statement is allowed within the <code>require { rule_list }</code> construct.</td>
-</tr>
-</tbody>
-</table>
-
-**Table 3** shows a cross reference matrix of statements
-and rules allowed in each of the above policy statements.
+**Conditional Policy Statements:**
+
+| *if* Statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes/No                  | Yes/No                  | Yes/No                  |
+
+**Where:**
+
+*if Statement*
+
+-   Whether the statement is allowed within a conditional statement
+    (*if/else* construct). Conditional statements can be in all types
+    of policy source file.
+
+*optional Statement*
+
+-   Whether the statement is allowed within the *optional { rule_list }* construct.
+
+*require Statement*
+
+-   Whether the statement is allowed within the *require { rule_list }* construct.
 
 ## MLS Statements and Optional MLS Components
 
@@ -265,7 +151,8 @@ statements specifically for MLS support. However when MLS is enabled,
 there are other statements that require the MLS component of a security
 context as an argument, (for example the
 [**Network Labeling Statements**](network_statements.md#network-labeling-statements)),
-therefore these statements show an example taken from the MLS **Reference Policy** build.
+therefore these statements show an example taken from the
+MLS **Reference Policy** build.
 
 ## General Statement Information
 
@@ -299,180 +186,35 @@ same).
     for all the possible command line options.
 2.  **Table 2** lists words reserved for the SELinux  policy language.
 
-<table>
-<tbody>
-<tr>
-<td>alias</td>
-<td>allow</td>
-<td>and </td>
-</tr>
-<tr>
-<td>attribute</td>
-<td>attribute_role</td>
-<td>auditallow</td>
-</tr>
-<tr>
-<td>auditdeny</td>
-<td>bool</td>
-<td>category</td>
-</tr>
-<tr>
-<td>cfalse</td>
-<td>class</td>
-<td>clone</td>
-</tr>
-<tr>
-<td>common</td>
-<td>constrain</td>
-<td>ctrue </td>
-</tr>
-<tr>
-<td>dom</td>
-<td>domby</td>
-<td>dominance</td>
-</tr>
-<tr>
-<td>dontaudit</td>
-<td>else</td>
-<td>equals</td>
-</tr>
-<tr>
-<td>false</td>
-<td>filename</td>
-<td>filesystem</td>
-</tr>
-<tr>
-<td>fscon</td>
-<td>fs_use_task</td>
-<td>fs_use_trans</td>
-</tr>
-<tr>
-<td>fs_use_xattr</td>
-<td>genfscon</td>
-<td>h1 </td>
-</tr>
-<tr>
-<td>h2</td>
-<td>identifier</td>
-<td>if</td>
-</tr>
-<tr>
-<td>incomp</td>
-<td>inherits</td>
-<td>iomemcon</td>
-</tr>
-<tr>
-<td>ioportcon</td>
-<td>ipv4_addr</td>
-<td>ipv6_addr</td>
-</tr>
-<tr>
-<td>l1</td>
-<td>l2</td>
-<td>level</td>
-</tr>
-<tr>
-<td>mlsconstrain</td>
-<td>mlsvalidatetrans</td>
-<td>module </td>
-</tr>
-<tr>
-<td>netifcon</td>
-<td>neverallow</td>
-<td>nodecon </td>
-</tr>
-<tr>
-<td>not</td>
-<td>notequal</td>
-<td>number</td>
-</tr>
-<tr>
-<td>object_r</td>
-<td>optional</td>
-<td>or</td>
-</tr>
-<tr>
-<td>path</td>
-<td>pcidevicecon</td>
-<td>permissive</td>
-</tr>
-<tr>
-<td>pirqcon</td>
-<td>policycap</td>
-<td>portcon</td>
-</tr>
-<tr>
-<td>r1</td>
-<td>r2</td>
-<td>r3 </td>
-</tr>
-<tr>
-<td>range</td>
-<td>range_transition</td>
-<td>require </td>
-</tr>
-<tr>
-<td>role</td>
-<td>roleattribute</td>
-<td>roles</td>
-</tr>
-<tr>
-<td>role_transition</td>
-<td>sameuser</td>
-<td>sensitivity</td>
-</tr>
-<tr>
-<td>sid</td>
-<td>source</td>
-<td>t1 </td>
-</tr>
-<tr>
-<td>t2</td>
-<td>t3</td>
-<td>target</td>
-</tr>
-<tr>
-<td>true</td>
-<td>type</td>
-<td>typealias</td>
-</tr>
-<tr>
-<td>typeattribute</td>
-<td>typebounds</td>
-<td>type_change</td>
-</tr>
-<tr>
-<td>type_member</td>
-<td>types</td>
-<td>type_transition</td>
-</tr>
-<tr>
-<td>u1</td>
-<td>u2</td>
-<td>u3 </td>
-</tr>
-<tr>
-<td>user</td>
-<td>validatetrans</td>
-<td>version_identifier </td>
-</tr>
-<tr>
-<td>xor</td>
-<td>default_user</td>
-<td>default_role</td>
-</tr>
-<tr>
-<td>default_type</td>
-<td>default_range</td>
-<td>low</td>
-</tr>
-<tr>
-<td>high</td>
-<td>low_high</td>
-<td></td>
-</tr>
-</tbody>
-</table>
+|                 |                |                    |                  |
+| :-------------- | :------------- | :----------------- | :--------------- |
+| alias           | allow          | allowxperm         | and              |
+| attribute       | attribute_role | auditallow         | auditallowxperm  |
+| auditdeny       | bool           | category           | cfalse           |
+| class           | clone          | common             | constrain        |
+| ctrue           | default_range  | default_role       | default_type     |
+| default_user    | dom            | domby              | dominance        |
+| dontaudit       | else           | equals             | expandattribute  |
+| false           | filename       | filesystem         | fscon            |
+| fs_use_task     | fs_use_trans   | fs_use_xattr       | genfscon         |
+| h1              | h2             | high               | ibendportcon     |
+| ibpkeycon       | identifier     | if                 | incomp           |
+| inherits        | iomemcon       | ioportcon          | ipv4_addr        |
+| ipv6_addr       | l1             | l2                 | level            |
+| low             | low_high       | mlsconstrain       | mlsvalidatetrans |
+| module          | netifcon       | neverallow         | neverallowxperm  |
+| neverallowxperm | nodecon        | not                | notequal         |
+| number          | object_r       | optional           | or               |
+| path            | pcidevicecon   | permissive         | pirqcon          |
+| policycap       | portcon        | r1                 | r2               |
+| r3              | range          | range_transition   | require          |
+| role            | roleattribute  | roles              | role_transition  |
+| sameuser        | sensitivity    | sid                | source           |
+| t1              | t2             | t3                 | target           |
+| true            | type           | typealias          | typeattribute    |
+| typebounds      | type_change    | type_member        | types            |
+| type_transition | u1             | u2                 | u3               |
+| user            | validatetrans  | version_identifier | xor              |
 
 **Table 2: Policy language reserved words**
 
@@ -481,469 +223,74 @@ within each type of policy source file, and whether the statement is valid
 within an *if/else* construct, *optional {rule_list}*, or
 *require {rule_list}* statement.
 
-<table>
-<tbody>
-<tr>
-<td>allow</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr>
-<td>allow - Role</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr>
-<td>attribute</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>Yes</td>
-<td>Yes</td>
-</tr>
-<tr>
-<td>attribute_role</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>Yes</td>
-<td>Yes</td>
-</tr>
-<tr>
-<td>auditallow</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr>
-<td>auditdeny (Deprecated)</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr>
-<td>bool</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>Yes</td>
-<td>Yes</td>
-</tr>
-<tr>
-<td>category</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>Yes</td>
-</tr>
-<tr>
-<td>class</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>Yes</td>
-</tr>
-<tr>
-<td>common</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-<tr>
-<td>constrain</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-<tr>
-<td>default_user</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-<tr>
-<td>default_role</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-<tr>
-<td>default_type</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-<tr>
-<td>default_range</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-<tr>
-<td>dominance - MLS</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-<tr>
-<td>dominance - Role (Deprecated)</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr>
-<td>dontaudit</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr>
-<td>fs_use_task</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-<tr>
-<td>fs_use_trans</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-<tr>
-<td>fs_use_xattr</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-<tr>
-<td>genfscon</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-<tr>
-<td>if</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr>
-<td>level</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-<tr>
-<td>mlsconstrain</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-<tr>
-<td>mlsvalidatetrans</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-<tr>
-<td>module</td>
-<td>No</td>
-<td>No</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-<tr>
-<td>netifcon </td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-<tr>
-<td>neverallow</td>
-<td>Yes</td>
-<td>Yes</td>
-<td><strong>Yes</strong>[^fn_kpl_3]</td>
-<td>No</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr>
-<td>nodecon</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-<tr>
-<td>optional</td>
-<td>No</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-</tr>
-<tr>
-<td>permissive</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr>
-<td>policycap</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-<tr>
-<td>portcon</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-<tr>
-<td>range_transition</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr>
-<td>require</td>
-<td>No</td>
-<td><strong>Yes</strong>[^fn_kpl_4]</td>
-<td>Yes</td>
-<td><strong>Yes</strong>[^fn_kpl_5]</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr>
-<td>role</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>Yes</td>
-<td>Yes</td>
-</tr>
-<tr>
-<td>roleattribute</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr>
-<td>role_transition</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr>
-<td>sensitivity</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>Yes</td>
-</tr>
-<tr>
-<td>sid</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-<tr>
-<td>type</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>Yes</td>
-</tr>
-<tr>
-<td>type_change</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr>
-<td>type_member</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr>
-<td>type_transition</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr>
-<td>typealias</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr>
-<td>typeattribute</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr>
-<td>typebounds</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr>
-<td>user</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>Yes</td>
-<td>Yes</td>
-</tr>
-<tr>
-<td>validatetrans</td>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-</tbody>
-</table>
+| Statement / Rule | Monolithic Policy | Base Policy | Module Policy | Conditional Statements | optional Statement | require Statement |
+| :--------------- | :---------------: | :---------: | :-----------: | :--------------------: | :----------------: | :---------------: |
+| *allow*          |        Yes        |      Yes    |      Yes      |          Yes           |         Yes        |        No         |
+| *allow* - Role   |        Yes        |      Yes    |      Yes      |          No            |         Yes        |        No         |
+| *allowxperm*     |        Yes        |      Yes    |      Yes      |          No            |         No         |        No         |
+| *attribute*      |        Yes        |      Yes    |      Yes      |          No            |         Yes        |        Yes        |
+| *attribute_role* |        Yes        |      Yes    |      Yes      |          No            |         Yes        |        Yes        |
+| *auditallow*     |        Yes        |      Yes    |      Yes      |          Yes           |         Yes        |        No         |
+| *auditallowxperm*|        Yes        |      Yes    |      Yes      |          No            |         No         |        No         |
+| *auditdeny* (Deprecated)| Yes        |      Yes    |      Yes      |          Yes           |         Yes        |        No         |
+| *bool*           |        Yes        |      Yes    |      Yes      |          No            |         Yes        |        Yes        |
+| *category*       |        Yes        |      Yes    |      No       |          No            |         No         |        Yes        |
+| *class*          |        Yes        |      Yes    |      No       |          No            |         No         |        Yes        |
+| *common*         |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
+| *constrain*      |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
+| *default_user*   |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
+| *default_role*   |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
+| *default_type*   |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
+| *default_range*  |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
+| *dominance* - MLS|        Yes        |      Yes    |      No       |          No            |         No         |        No         |
+| *dominance* - Role (Deprecated)| Yes |      Yes    |      Yes      |          No            |         Yes        |        No         |
+| *dontaudit*      |        Yes        |      Yes    |      Yes      |          Yes           |         Yes        |        No         |
+| *dontauditxperm* |        Yes        |      Yes    |      Yes      |          No            |         No         |        No         |
+| *expandattribute*|        Yes        |      Yes    |      Yes      |          No            |         Yes        |        No         |
+| *fs_use_task*    |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
+| *fs_use_trans*   |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
+| *fs_use_xattr*   |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
+| *genfscon*       |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
+| *ibpkeycon*      |        Yes        |      Yes    |      Yes      |          No            |         No         |        No         |
+| *ibendportcon*   |        Yes        |      Yes    |      Yes      |          No            |         No         |        No         |
+| *if*             |        Yes        |      Yes    |      Yes      |          No            |         Yes        |        No         |
+| *level*          |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
+| *mlsconstrain*   |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
+| *mlsvalidatetrans*|       Yes        |      Yes    |      No       |          No            |         No         |        No         |
+| *module*         |        No         |      No     |      Yes      |          No            |         No         |        No         |
+| *netifcon*       |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
+| *neverallow*     |        Yes        |      Yes    |Yes [^fn_kpl_3]|          No            |         Yes        |        No         |
+| *neverallowxperm*|        Yes        |      Yes    |      Yes      |          No            |         No         |        No         |
+| *nodecon*        |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
+| *optional*       |        No         |      Yes    |      Yes      |          Yes           |         Yes        |        Yes        |
+| *permissive*     |        Yes        |      Yes    |      Yes      |          Yes           |         Yes        |        No         |
+| *policycap*      |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
+| *portcon*        |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
+| *range_transition*|       Yes        |      Yes    |      Yes      |          No            |         Yes        |        No         |
+| *require*        |        No         |Yes [^fn_kpl_4]|    Yes      |     Yes [^fn_kpl_5]    |         Yes        |        No         |
+| *role*           |        Yes        |      Yes    |      Yes      |          No            |         Yes        |        Yes        |
+| *roleattribute*  |        Yes        |      Yes    |      Yes      |          No            |         Yes        |        No         |
+| *role_transition*|        Yes        |      Yes    |      Yes      |          No            |         Yes        |        No         |
+| *sensitivity*    |        Yes        |      Yes    |      No       |          No            |         No         |        Yes        |
+| *sid*            |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
+| *type*           |        Yes        |      Yes    |      Yes      |          No            |         No         |        Yes        |
+| *type_change*    |        Yes        |      Yes    |      Yes      |          Yes           |         Yes        |        No         |
+| *type_member*    |        Yes        |      Yes    |      Yes      |          Yes           |         Yes        |        No         |
+| *type_transition*|        Yes        |      Yes    |      Yes      |          Yes           |         Yes        |        No         |
+| *typealias*      |        Yes        |      Yes    |      Yes      |          No            |         Yes        |        No         |
+| *typeattribute*  |        Yes        |      Yes    |      Yes      |          No            |         Yes        |        No         |
+| *typebounds*     |        Yes        |      Yes    |      Yes      |          No            |         Yes        |        No         |
+| *user*           |        Yes        |      Yes    |      Yes      |          No            |         Yes        |        Yes        |
+| *validatetrans*  |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
 
 **Table 3: The policy language statements and rules that are allowed within
 each type of policy source file** - *The left hand side of the table shows
 what Policy Language Statements and Rules are allowed within each type of
 policy source file. The right hand side of the table shows whether the
-statement is valid within the *if/else* construct, *optional {rule_list}*,
-or *require {rule_list}* statement.*
+statement is valid within the if/else construct, optional {rule_list},
+or require {rule_list} statement.*
 
-## Section Contents
+## Policy Language Index
 
 The policy language statement and rule sections are as follows:
 
@@ -967,6 +314,7 @@ The policy language statement and rule sections are as follows:
 
 Note these are not kernel policy statements, but used by the Reference Policy
 to assist policy build:
+
 -   [Modular Policy Support Statements](modular_policy_statements.md#modular-policy-support-statements)
 
 [^fn_kpl_1]: It is important to note that the Reference Policy builds policy
-- 
2.26.2


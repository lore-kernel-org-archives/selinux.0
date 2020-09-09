Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92111C43461
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 19:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AFC020C09
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 19:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="JHlg4750"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgIJTRJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:17:09 -0400
Received: from mailomta3-re.btinternet.com ([213.120.69.96]:48668 "EHLO
        re-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725933AbgIJTPk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 15:15:40 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-045.btinternet.com with ESMTP
          id <20200909133043.LPHH4080.re-prd-fep-045.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658243; 
        bh=QNmkcD5nnmw72A16rADGX88Uk+/U5nU6iwmREQRffEY=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=JHlg4750ZkJh+ZteSFlKvJxzr5Vxy49xp4JR0LLit2u7/LU06iNyYI1yHaOnLw64tRV9g2x88XX4XLPvTckYfS7GrbghPHRoeDcOksMYaQ9tIGZ3t8bQHo2XP4o3lUwWgN/eY2SDNfNyoxGTTGjP1yUbg8l3h/ZvFiRt7KOsUBojlObUX5j8t4lKq2F8lS7gIL3eWTJhgm9yrd+9I0F+APqOJoWOfdsDfvma4rlREyNUyvU5LGsdhFRl3KVBnsrEUpUl9i/uOzDj5+EcjBlAgcjTWM+naSPNo01YaQBNsUmL4B1E5vhd4AYld5V82NFGN0vp1kjT08GYXDSZJtNA5w==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.154.154.133]
X-OWM-Source-IP: 86.154.154.133 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudehhedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepkeeirdduheegrdduheegrddufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudehgedrudehgedrudeffedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.154.154.133) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD10134D5E; Wed, 9 Sep 2020 14:30:43 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 01/22] kernel_policy_language: Tidy up formatting
Date:   Wed,  9 Sep 2020 14:30:18 +0100
Message-Id: <20200909133039.44498-2-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909133039.44498-1-richard_c_haines@btinternet.com>
References: <20200909133039.44498-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/kernel_policy_language.md | 106 +++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/src/kernel_policy_language.md b/src/kernel_policy_language.md
index 921c7d0..f1910dd 100644
--- a/src/kernel_policy_language.md
+++ b/src/kernel_policy_language.md
@@ -1,10 +1,10 @@
 # Kernel Policy Language
 
--   [Policy Source Files](#policy-source-files)
--   [Conditional, Optional and Require Statement Rules](#conditional-optional-and-require-statement-rules)
--   [MLS Statements and Optional MLS Components](#mls-statements-and-optional-mls-components)
--   [General Statement Information](#general-statement-information)
--   [Policy Language Index](#policy-language-index)
+- [Policy Source Files](#policy-source-files)
+- [Conditional, Optional and Require Statement Rules](#conditional-optional-and-require-statement-rules)
+- [MLS Statements and Optional MLS Components](#mls-statements-and-optional-mls-components)
+- [General Statement Information](#general-statement-information)
+- [Policy Language Index](#policy-language-index)
 
 This section covers the policy source file types and what kernel policy
 statements and rule are allowed in each. The
@@ -93,30 +93,30 @@ what circumstances each one is valid within a policy source file.
 
 *Monolithic Policy*
 
--   Whether the statement is allowed within a monolithic policy source file or not.
+- Whether the statement is allowed within a monolithic policy source file or not.
 
 *Base Policy*
 
--   Whether the statement is allowed within a base (for loadable module support)
-    policy source file or not.
+- Whether the statement is allowed within a base (for loadable module support)
+  policy source file or not.
 
 *Module Policy*
 
--   Whether the statement is allowed within the optional loadable module policy
-    source file or not.
+- Whether the statement is allowed within the optional loadable module policy
+  source file or not.
 
 ## Conditional, Optional and Require Statement Rules
 
 The language grammar specifies what statements and rules can be included
 within:
 
-1.   [**Conditional Policy**](conditional_statements.md#conditional-policy-statements)
-     rules that are part of the kernel policy language.
-2.   *optional* and *require* rules that are NOT part of the kernel policy
-     language, but **Reference Policy** ***m4**(1)* macros used to control
-     policy builds (see the
-     [**Modular Policy Support Statements**](modular_policy_statements.md#modular-policy-support-statements)
-     section.
+1. [**Conditional Policy**](conditional_statements.md#conditional-policy-statements)
+   rules that are part of the kernel policy language.
+2. *optional* and *require* rules that are NOT part of the kernel policy
+   language, but **Reference Policy** ***m4**(1)* macros used to control
+   policy builds (see the
+   [**Modular Policy Support Statements**](modular_policy_statements.md#modular-policy-support-statements)
+   section.
 
 To highlight these rules the following table is included in each
 statement and rule section to show what circumstances each one is valid
@@ -132,17 +132,17 @@ within a policy source file:
 
 *if Statement*
 
--   Whether the statement is allowed within a conditional statement
-    (*if/else* construct). Conditional statements can be in all types
-    of policy source file.
+- Whether the statement is allowed within a conditional statement
+  (*if/else* construct). Conditional statements can be in all types
+  of policy source file.
 
 *optional Statement*
 
--   Whether the statement is allowed within the *optional { rule_list }* construct.
+- Whether the statement is allowed within the *optional { rule_list }* construct.
 
 *require Statement*
 
--   Whether the statement is allowed within the *require { rule_list }* construct.
+- Whether the statement is allowed within the *require { rule_list }* construct.
 
 ## MLS Statements and Optional MLS Components
 
@@ -156,14 +156,14 @@ MLS **Reference Policy** build.
 
 ## General Statement Information
 
-1.  Identifiers can generally be any length but should be restricted to
-    the following characters: a-z, A-Z, 0-9 and \_ (underscore).
-2.  A '\#' indicates the start of a comment in policy source files.
-3.  All statements available to policy version 29 have been included.
-4.  When multiple source and target entries are shown in a single
-    statement or rule, the compiler (***checkpolicy**(8)* or
-    ***checkmodule**(8)*) will expand these to individual statements or
-    rules as shown in the following example:
+1. Identifiers can generally be any length but should be restricted to
+   the following characters: a-z, A-Z, 0-9 and \_ (underscore).
+2. A '\#' indicates the start of a comment in policy source files.
+3. All statements available to policy version 29 have been included.
+4. When multiple source and target entries are shown in a single
+   statement or rule, the compiler (***checkpolicy**(8)* or
+   ***checkmodule**(8)*) will expand these to individual statements or
+   rules as shown in the following example:
 
 ```
 # This allow rule has two target entries console_device_t and tty_device_t:
@@ -180,11 +180,11 @@ using (for example) ***apol**(8)*, **sedispol** or **sedismod**, the
 results will differ (however the resulting policy rules will be the
 same).
 
-1.  Some statements can be added to a policy via the policy store using
-    the **semanage**(8) command. Examples of these are shown where
-    applicable, however the **semanage** man page should be consulted
-    for all the possible command line options.
-2.  **Table 2** lists words reserved for the SELinux  policy language.
+1. Some statements can be added to a policy via the policy store using
+   the **semanage**(8) command. Examples of these are shown where
+   applicable, however the **semanage** man page should be consulted
+   for all the possible command line options.
+2. **Table 2** lists words reserved for the SELinux  policy language.
 
 |                 |                |                    |                  |
 | :-------------- | :------------- | :----------------- | :--------------- |
@@ -294,28 +294,28 @@ or require {rule_list} statement.*
 
 The policy language statement and rule sections are as follows:
 
--   [Policy Configuration Statements](policy_config_statements.md#policy-configuration-statements)
--   [Default Rules](default_rules.md#default-object-rules)
--   [User Statements](user_statements.md#user-statements)
--   [Role Statements](role_statements.md#role-statements)
--   [Type Statements](type_statements.md#type-statements)
--   [Bounds Rules](bounds_rules.md#bounds-rules)
--   [Access Vector Rules](avc_rules.md#access-vector-rules)
--   [Extended Access Vector Rules](xperm_rules.md#extended-access-vector-rules)
--   [Object Class and Permission Statements](class_permission_statements.md#object-class-and-permission-statements)
--   [Conditional Policy Statements](conditional_statements.md#conditional-policy-statements)
--   [Constraint Statements](constraint_statements.md#constraint-statements)
--   [MLS Statements](mls_statements.md#mls-statements)
--   [Security ID (SID) Statement](sid_statement.md#security-id-sid-statement)
--   [File System Labeling Statements](file-labeling-statements.md#file-system-labeling-statements)
--   [Network Labeling Statements](network_statements.md#network-labeling-statements)
--   [InfiniBand Labeling Statements](infiniband_statements.md#infiniband-labeling-statements)
--   [XEN Statements](xen_statements.md#xen-statements)
+- [Policy Configuration Statements](policy_config_statements.md#policy-configuration-statements)
+- [Default Rules](default_rules.md#default-object-rules)
+- [User Statements](user_statements.md#user-statements)
+- [Role Statements](role_statements.md#role-statements)
+- [Type Statements](type_statements.md#type-statements)
+- [Bounds Rules](bounds_rules.md#bounds-rules)
+- [Access Vector Rules](avc_rules.md#access-vector-rules)
+- [Extended Access Vector Rules](xperm_rules.md#extended-access-vector-rules)
+- [Object Class and Permission Statements](class_permission_statements.md#object-class-and-permission-statements)
+- [Conditional Policy Statements](conditional_statements.md#conditional-policy-statements)
+- [Constraint Statements](constraint_statements.md#constraint-statements)
+- [MLS Statements](mls_statements.md#mls-statements)
+- [Security ID (SID) Statement](sid_statement.md#security-id-sid-statement)
+- [File System Labeling Statements](file-labeling-statements.md#file-system-labeling-statements)
+- [Network Labeling Statements](network_statements.md#network-labeling-statements)
+- [InfiniBand Labeling Statements](infiniband_statements.md#infiniband-labeling-statements)
+- [XEN Statements](xen_statements.md#xen-statements)
 
 Note these are not kernel policy statements, but used by the Reference Policy
 to assist policy build:
 
--   [Modular Policy Support Statements](modular_policy_statements.md#modular-policy-support-statements)
+- [Modular Policy Support Statements](modular_policy_statements.md#modular-policy-support-statements)
 
 [^fn_kpl_1]: It is important to note that the Reference Policy builds policy
 using makefiles and m4 support macros within its own source file structure.
-- 
2.26.2


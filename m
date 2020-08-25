Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83076C433E3
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A132071E
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="aH0WwE0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgHYIiR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:38:17 -0400
Received: from mailomta8-sa.btinternet.com ([213.120.69.14]:24199 "EHLO
        sa-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728087AbgHYIiP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 04:38:15 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20200825083808.HLWA4112.sa-prd-fep-045.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 25 Aug 2020 09:38:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598344688; 
        bh=L3j/8ZLx2LOTL6IaLpkY5WKc4iBNLyiGz8srqIFRtF4=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=aH0WwE0zTKvpadY1xOq7HU4TWRNOEL/luQPmC+FgCQwnLUvbS15GrZDHp2fZwJKxF8fQV2YAIaGXllJItHGeWmvAu4O77wWkYjYM8eEarlnNBspUuxa9GNrBDbo1iynhWaDSpv/lUDrqGyTh/l6y5gHgRCQ7oI9rWNOMuO4jR6PZPyNM3B2zhrKSEoOZR7TcLR1cJs6eUyh2C8sNMI39j3+UZ2Z4VuhOnDEEEVmMBvswTjRp2NmY49tO8QwerQcjW0w/XUcn1rtVp+eaxWHQaa3XyOX0Nyh/JCkoXVT6WDADE8diZkrAUGNPbuhqo2YsixaLW5xNKSPzdsrNVW6j2A==
Authentication-Results: btinternet.com; none
X-Originating-IP: [109.155.130.160]
X-OWM-Source-IP: 109.155.130.160 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeujeduvdejkeevtddtgfejiedtvefggfekgeehudetjeefffekteelgeefkeevieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedutdelrdduheehrddufedtrdduiedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduheehrddufedtrdduiedtpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgv
        rhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.130.160) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B8A70D599D9F; Tue, 25 Aug 2020 09:38:08 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 05/18] cil_overview: Convert to markdown
Date:   Tue, 25 Aug 2020 09:37:30 +0100
Message-Id: <20200825083743.6508-6-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825083743.6508-1-richard_c_haines@btinternet.com>
References: <20200825083743.6508-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert to markdown

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/cil_overview.md | 63 ++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/src/cil_overview.md b/src/cil_overview.md
index aa22bff..ddb70f6 100644
--- a/src/cil_overview.md
+++ b/src/cil_overview.md
@@ -11,19 +11,17 @@ A PDF version is included in this documentation:
 The CIL compiler source can be found at:
 <https://github.com/SELinuxProject/selinux.git> within the *secilc* and
 *libsepol* sections and can be cloned via:
--    *git clone https://github.com/SELinuxProject/selinux.git*
+- *git clone https://github.com/SELinuxProject/selinux.git*
 
 While the CIL design web pages give the main objectives of CIL, from a
 language perspective it will:
 
-1.  Apply name and usage consistency to the current kernel language
-    statements. For example the kernel language uses *attribute* and
-    *attribute_role* to declare identifiers, whereas CIL uses
-    *typeattribute* and *roleattribute*. Also statements to associate
-    types or roles have been made consistent and enhanced to allow
-    expressions to be defined.
-
--   Examples:
+- Apply name and usage consistency to the current kernel language
+  statements. For example the kernel language uses *attribute* and
+  *attribute_role* to declare identifiers, whereas CIL uses
+  *typeattribute* and *roleattribute*. Also statements to associate
+  types or roles have been made consistent and enhanced to allow
+  expressions to be defined. Some examples are:
 
 |    Kernel        |      CIL           |
 | ---------------- | ------------------ |
@@ -35,32 +33,27 @@ language perspective it will:
 | *allow* (role)   | *roleallow*        |
 | *dominance*      | *sensitivityorder* |
 
-2.  Additional CIL statements have been defined to enhance
-    functionality:
-
--   *classpermission* - Declare a *classpermissionset* identifier.
-
--   *classpermissionset* - Associate class / permissions also supporting
-expressions.
-
--   *classmap* / *classmapping* - Statements to support declaration and
-association of multiple *classpermissionset*'s. Useful when defining an
-*allow* rule with multiple class/permissions.
-
--   *context* - Statement to declare security context.
-
-3.  Allow named and anonymous definitions to be supported.
-4.  Support namespace features allowing policy modules to be defined
-    within blocks with inheritance and template features.
-5.  Remove the order dependency in that policy statements can be
-    anywhere within the source (i.e. remove dependency of class, sid
-    etc. being within a base module).
-6.  Able to define macros and calls that will remove any dependency on
-    M4 macro support.
-7.  Directly generate the binary policy file and other configuration
-    files - currently the *file_contexts* file.
-8.  Support transformation services such as delete, transform and
-    inherit with exceptions.
+- Additional CIL statements have been defined to enhance
+  functionality:
+  - *classpermission* - Declare a *classpermissionset* identifier.
+  - *classpermissionset* - Associate class / permissions also supporting
+    expressions.
+  - *classmap* / *classmapping* - Statements to support declaration and
+    association of multiple *classpermissionset*'s. Useful when defining an
+    *allow* rule with multiple class/permissions.
+  - *context* - Statement to declare security context.
+- Allow named and anonymous definitions to be supported.
+- Support namespace features allowing policy modules to be defined
+  within blocks with inheritance and template features.
+- Remove the order dependency in that policy statements can be
+  anywhere within the source (i.e. remove dependency of class, sid
+  etc. being within a base module).
+- Able to define macros and calls that will remove any dependency on
+  M4 macro support.
+- Directly generate the binary policy file and other configuration
+  files - currently the *file_contexts* file.
+- Support transformation services such as delete, transform and
+  inherit with exceptions.
 
 An simple CIL policy is as follows:
 
-- 
2.26.2


Return-Path: <SRS0=UCTl=DO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5B1C4363C
	for <selinux@archiver.kernel.org>; Wed,  7 Oct 2020 06:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD7020797
	for <selinux@archiver.kernel.org>; Wed,  7 Oct 2020 06:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="swZI4/bK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgJGGuC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Oct 2020 02:50:02 -0400
Received: from mailomta22-re.btinternet.com ([213.120.69.115]:53107 "EHLO
        re-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725970AbgJGGuC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Oct 2020 02:50:02 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-045.btinternet.com with ESMTP
          id <20200909133047.LPHR4080.re-prd-fep-045.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658247; 
        bh=Q2sy49vY9OWzdQFitOviWWg3p8dZ6dI4unF7PXhsrlE=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=swZI4/bK0pPyq1hSyTwkymBTOiIHECaJ6e4KCHAWFIaNUxt9yPMBwfGDThASJM+lUM8S5RKwwKLBCiSvCWkJWGv94WH9cuPxfpiNvDHh+ov/XFTvkteRxwLYf9ucLQY93CCy8HTqx7wB8Msces90v0GgAStx3T6spgoRRJc5V2FArZfC47JFZg+ulvyFzcasIaoyPZfGuUE3g/4zwiirQlYMr8/OutrwHHxlEPTTmU4HYh2fmWISkmdRrwgDirKbtr1xL3EPbrEwtflc22+vOUXYMiUae3PlLdX5HweNC6aFLgAr9mb2ioDRBrTU9UVZbZR18hKnO174AQ65bDlvjw==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.154.154.133]
X-OWM-Source-IP: 86.154.154.133 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudehhedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepkeeirdduheegrdduheegrddufeefnecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudehgedrudehgedrudeffedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.154.154.133) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD10134E17; Wed, 9 Sep 2020 14:30:47 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 14/22] type_statements: Add toc, tidy up formatting
Date:   Wed,  9 Sep 2020 14:30:31 +0100
Message-Id: <20200909133039.44498-15-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909133039.44498-1-richard_c_haines@btinternet.com>
References: <20200909133039.44498-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/type_statements.md | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/src/type_statements.md b/src/type_statements.md
index b947fdd..0d7f137 100644
--- a/src/type_statements.md
+++ b/src/type_statements.md
@@ -1,7 +1,17 @@
 # Type Statements
 
+- [*type*](#type)
+- [*attribute*](#attribute)
+- [*expandattribute*](#expandattribute)
+- [*typeattribute*](#typeattribute)
+- [*typealias*](#typealias)
+- [*permissive*](#permissive)
+- [*type_transition*](#type_transition)
+- [*type_change*](#type_change)
+- [*type_member*](#type_member)
+
 These statements share the same namespace, therefore the general
-convention is to use *_t* as the final two characters of a type
+convention is to use *\_t* as the final two characters of a *type*
 identifier to differentiate it from an attribute identifier as shown in
 the following examples:
 
@@ -62,7 +72,7 @@ Policy Type
 
 Conditional Policy Statements
 
-| *if* statement          | *optional* Statement    | *require* Statement     |
+| *if* Statement          | *optional* Statement    | *require* Statement     |
 | ----------------------- | ----------------------- | ----------------------- |
 | No                      | Yes                     | Yes                     |
 
@@ -152,7 +162,7 @@ Policy Type
 
 Conditional Policy Statements
 
-| *if* statement          | *optional* Statement    | *require* Statement     |
+| *if* Statement          | *optional* Statement    | *require* Statement     |
 | ----------------------- | ----------------------- | ----------------------- |
 | No                      | Yes                     | Yes                     |
 
@@ -210,7 +220,7 @@ Policy Type
 
 Conditional Policy Statements
 
-| *if* statement          | *optional* Statement    | *require* Statement     |
+| *if* Statement          | *optional* Statement    | *require* Statement     |
 | ----------------------- | ----------------------- | ----------------------- |
 | Yes                     | Yes                     | No                      |
 
@@ -263,7 +273,7 @@ Policy Type
 
 Conditional Policy Statements
 
-| *if* statement          | *optional* Statement    | *require* Statement     |
+| *if* Statement          | *optional* Statement    | *require* Statement     |
 | ----------------------- | ----------------------- | ----------------------- |
 | No                      | Yes                     | No                      |
 
@@ -304,7 +314,7 @@ typeattribute setroubleshootd_exec_t file_type, non_security_file_type;
 
 The *typealias* statement allows the association of a previously declared
 *type* to one or more *alias* identifiers (an alternative way is to use the
-*type* statement.
+*type* statement).
 
 **The statement definition is:**
 
@@ -341,7 +351,7 @@ Policy Type
 
 Conditional Policy Statements
 
-| *if* statement          | *optional* Statement    | *require* Statement     |
+| *if* Statement          | *optional* Statement    | *require* Statement     |
 | ----------------------- | ----------------------- | ----------------------- |
 | No                      | Yes                     | No                      |
 
@@ -402,7 +412,7 @@ Policy Type
 
 Conditional Policy Statements
 
-| *if* statement          | *optional* Statement    | *require* Statement     |
+| *if* Statement          | *optional* Statement    | *require* Statement     |
 | ----------------------- | ----------------------- | ----------------------- |
 | No                      | Yes                     | No                      |
 
@@ -500,7 +510,7 @@ Policy Type
 
 Conditional Policy Statements
 
-| *if* statement          | *optional* Statement    | *require* Statement     |
+| *if* Statement          | *optional* Statement    | *require* Statement     |
 | ----------------------- | ----------------------- | ----------------------- |
 | Yes                     | Yes                     | No                      |
 
@@ -606,6 +616,7 @@ One or more object classes. Multiple entries consist of a space separated list
 enclosed in braces '{}'.
 
 *change_type*
+
 A single *type* or *typealias* identifier that will become the new *type*. 
 
 **The statement is valid in:**
@@ -618,7 +629,7 @@ Policy Type
 
 Conditional Policy Statements
 
-| *if* statement          | *optional* Statement    | *require* Statement     |
+| *if* Statement          | *optional* Statement    | *require* Statement     |
 | ----------------------- | ----------------------- | ----------------------- |
 | Yes                     | Yes                     | No                      |
 
@@ -691,7 +702,7 @@ Policy Type
 
 Conditional Policy Statements
 
-| *if* statement          | *optional* Statement    | *require* Statement     |
+| *if* Statement          | *optional* Statement    | *require* Statement     |
 | ----------------------- | ----------------------- | ----------------------- |
 | Yes                     | Yes                     | No                      |
 
-- 
2.26.2


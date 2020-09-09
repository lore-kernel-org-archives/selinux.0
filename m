Return-Path: <SRS0=npki=DT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5322C43467
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 22:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 965062078E
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 22:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="DnrJ2KSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388626AbgJLWTK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Oct 2020 18:19:10 -0400
Received: from mailomta31-re.btinternet.com ([213.120.69.124]:14194 "EHLO
        re-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388510AbgJLWSu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Oct 2020 18:18:50 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20200909133046.TZMX21348.re-prd-fep-044.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658246; 
        bh=lPFLzFsdNoO8Xkp6GfwuHFL3gAvxNJEQJjS5qMIqtwE=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=DnrJ2KSIjqGyROoS8qs3eSoDf5xoMJuRPDUs9aeDDg6Ct9ERP9AzcWx79GzgcefPiFSq/rXpv4DWOq9CAkYjknX7ODWhHGi253QCF2r63zC9Y9AH0IDQSP447q4LPHsZojUcXDultxFOzPm9sLI7rcNOvklKGHkXq1BjoqdluX/SoSucmOpXm5eZN4fZ2iKkJUxa+AQFiBRy/qvcOJlVesApVJkUFngIs8T91L8Kp7vlXRzZx/7qBa/T9m3QyxwWTkPZcw5WKMVoNNNKK0h0WvU8WTgvQE6uaLbs6IeCKg/1teC3eHH+9iC5SV0TrEQxXPv+MFR0Co9SWOz2w7OfnA==
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
        id 5ED9C2FD10134DE9; Wed, 9 Sep 2020 14:30:46 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 10/22] sid_statement: Convert to markdown
Date:   Wed,  9 Sep 2020 14:30:27 +0100
Message-Id: <20200909133039.44498-11-richard_c_haines@btinternet.com>
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
 src/sid_statement.md | 119 ++++++++++++++++---------------------------
 1 file changed, 43 insertions(+), 76 deletions(-)

diff --git a/src/sid_statement.md b/src/sid_statement.md
index 07feb2c..7d6bfcd 100644
--- a/src/sid_statement.md
+++ b/src/sid_statement.md
@@ -1,5 +1,8 @@
 # Security ID (SID) Statement
 
+- [*sid*](#sid)
+- [*sid context*](#sid-context)
+
 There are two *sid* statements, the first one declares the actual *sid*
 identifier and is defined at the start of a policy source file. The
 second statement is used to associate an initial security context to the
@@ -20,45 +23,27 @@ sid sid_id
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>sid</code></td>
-<td>The <code>sid</code> keyword.</td>
-</tr>
-<tr>
-<td><code>sid_id</code></td>
-<td>The <code>sid</code> identifier.</td>
-</tr>
-</tbody>
-</table>
+*sid*
+
+The *sid* keyword.
+
+*sid_id*
+
+The *sid* identifier.
 
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
 
@@ -86,49 +71,31 @@ sid sid_id context
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>sid</code></td>
-<td>The <code>sid<code> keyword.</td>
-</tr>
-<tr>
-<td><code>sid_id</code></td>
-<td>The previously declared sid identifier. </td>
-</tr>
-<tr>
-<td><code>context</code></td>
-<td>The initial security context.</td>
-</tr>
-</tbody>
-</table>
+*sid*
+
+The *sid* keyword.
+
+*sid_id*
+
+The previously declared *sid* identifier.
+
+*context*
+
+The initial security context.
 
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


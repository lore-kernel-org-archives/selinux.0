Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A428FC43461
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 22:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A666221E3
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 22:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="KCBe8mP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgIJWBz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:01:55 -0400
Received: from mailomta23-re.btinternet.com ([213.120.69.116]:55114 "EHLO
        re-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725306AbgIJWBz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 18:01:55 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20200909133043.HJKH4131.re-prd-fep-049.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658243; 
        bh=fDp+aiYMiKuGOrDkASPb9CISSP9yZVmBgu7MP00KTiM=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=KCBe8mP79KdUY+qAdznaP7QIlZXIfbau0TJwLCmZGp0/A+KKsG7m0YsBxqM6bLfslLpvOht4B0CZghcNOeV5iGTuhyP3HTmgT5Z+/6rxjbtCjQU/GHZEDP37kbGkHJI9OGBRxj2PuN3CPSynjdTBvRlWWQtvcCAlJ+0e6xSgCq6fk50qo223R80pIkHf3MxR762GwiSR9DM5sqTH4om7JQ0Esis28sCf/Q5pMlZFBRpuQaZN5csqlEpd7jmTl0tuUNbVFx+pR54TgDQ7lZQwyXw5KWWfyiB2eWBVsu4hWvp6Rjf551iOQfUxFJwHdhBfRGSgQW5Ru2m9PsANJTjVkw==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.154.154.133]
X-OWM-Source-IP: 86.154.154.133 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudehhedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeffieeigefgkeekteeifeffheevgfettdehjeeifeffudfggfdvkeefhefggeehveenucffohhmrghinheptghomhhprghrthhmvghnthhsrdgtvghnthgvrhdptggrthgvghhorhhivghsrdgtvghnthgvrhdpphholhhitgihrdgtvghnthgvrhenucfkphepkeeirdduheegrdduheegrddufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudehgedrudehgedrudeffedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgr
        ihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.154.154.133) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD10134D7F; Wed, 9 Sep 2020 14:30:43 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 02/22] mls_statements: Convert to markdown
Date:   Wed,  9 Sep 2020 14:30:19 +0100
Message-Id: <20200909133039.44498-3-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909133039.44498-1-richard_c_haines@btinternet.com>
References: <20200909133039.44498-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a TOC to aid navigation and convert to markdown.
Remove table 1 as didn't seem to add anything.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/mls_statements.md | 461 +++++++++++++++---------------------------
 1 file changed, 167 insertions(+), 294 deletions(-)

diff --git a/src/mls_statements.md b/src/mls_statements.md
index f61ced6..05ba185 100644
--- a/src/mls_statements.md
+++ b/src/mls_statements.md
@@ -1,74 +1,30 @@
 # MLS Statements
 
+- [MLS range Definition](#mls-range-definition)
+- [*sensitivity*](#sensitivity)
+- [*dominance*](#dominance)
+- [*category*](#category)
+- [*level*](#level)
+- [*range_transition*](#range_transition)
+- [*mlsconstrain*](#mlsconstrain)
+- [*mlsvalidatetrans*](#mlsvalidatetrans)
+
 The optional MLS policy extension adds an additional security context
 component that consists of the following highlighted entries:
 
-```
-user:role:type:sensitivity[:category,...]- sensitivity [:category,...]
-```
+*user:role:type:* ***sensitivity[:category,...] - sensitivity [:category,...]***
 
-These consist of a mandatory hierarchical
-[**sensitivity**](#sensitivity) and optional
-non-hierarchical [**category**](#category)'s. The
-combination of the two comprise a [**level**](#level) or security level as
-shown in **Table 1: Sensitivity and Category = Security Level**. Depending on
-the circumstances, there can be one level defined or a
-[**range**](#mls-range-definition) as shown in **Table 1**.
-
-<table>
-<tbody>
-<tr>
-<td><center><p><strong>Security Level (or Level)</strong></p></center>
-<p><center>Consisting of a sensitivity and zero or more category entries:</center></p></td>
-<td colspan="2"; rowspan="2";><center>Note that SELinux uses <code>level</code>, <code>sensitivity</code> and <code>category</code><br>in the language statements (see the <a href="mls_statements.md#mls-statements"> MLS Language Statements</a> section),<br>however when discussing these the following terms can also be used:<br> labels, classifications, and compartments.</center></td>
-</tr>
-<tr>
-<td><center><p><code>sensitivity [: category, ... ]</code><br>also known as:</p>
-<p><strong>Sensitivity Label</strong></p>
-<p>Consisting of a classification and compartment.</p></center></td>
-</tr>
-<tr>
-<td colspan="3"><center><strong>&lt;-------------- Range --------------&gt;</strong></center></td>
-</tr>
-<tr>
-<td><center><strong>Low</strong></center></td>
-<td rowspan="6"><center><strong>-</strong></center></td>
-<td><center><strong>High</strong></center></td>
-</tr>
-<tr>
-<td><center><code>sensitivity [: category, ... ]</code></center></td>
-<td><center><code>sensitivity [: category, ... ]</code></center></td>
-</tr>
-<tr>
-<td><center>For a process or subject this is the current level or sensitivity</center></td>
-<td><center>For a process or subject this is the Clearance</center></td>
-</tr>
-<tr>
-<td><center>For an object this is the current level or sensitivity</center></td>
-<td><center>For an object this is the maximum range</center></td>
-</tr>
-<tr>
-<td><center><strong>SystemLow</strong></center></td>
-
-<td><center><strong>SystemHigh</strong></center></td>
-</tr>
-<tr>
-<td><center>This is the lowest level or classification for the system<br>(for SELinux this is generally 's0', note that there are no categories).</center></td>
-
-<td><center>This is the highest level or classification for the system<br>(for SELinux this is generally 's15:c0,c255',<br>although note that they will be the highest set by the policy).</center></td>
-</tr>
-</tbody>
-</table>
-
-**Table 1: Sensitivity and Category = Security Level** - *this table shows
-the meanings depending on the context being discussed.*
+These consist of a mandatory hierarchical [**sensitivity**](#sensitivity) and
+optional non-hierarchical [**category**](#category)'s. The combination of the
+two comprise a [**level**](#level) or security level. Depending on the
+circumstances, there can be one level or a [**range**](#mls-range-definition).
 
 To make the security levels more meaningful, it is possible to use the
-setransd daemon to translate these to human readable formats. The
-**semanage**(8) command will allow this mapping to be defined as discussed
+***mcstransd**(8)* daemon to translate these to human readable formats. The
+***semanage**(8)* command will allow this mapping to be defined as discussed
 in the [**setrans.conf**](policy_config_files.md#setrans.conf) section.
 
-#### MLS range Definition
+## MLS range Definition
 
 The MLS range is appended to a number of statements and defines the lowest and
 highest security levels. The range can also consist of a single level as
@@ -82,23 +38,20 @@ low_level [ - high_level ]
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>low_level</code></td>
-<td><p>The processes lowest level identifier that has been previously declared by a <a href="#level"><code>level</code></a> statement.</p>
-<p>If a <code>high_level</code> is not defined, then it is taken as the same as the <code>low_level</code>.</p></td>
-</tr>
-<tr>
-<td>-</td>
-<td>The optional hyphen '-' separator if a <code>high_level</code> is also being defined.</td>
-</tr>
-<tr>
-<td><code>high_level</code></td>
-<td>The processes highest level identifier that has been previously declared by a <a href="#level"><code>level</code></a> statement. </td>
-</tr>
-</tbody>
-</table>
+*low_level*
+
+The processes lowest level identifier that has been previously declared by a
+[*level*](#level) statement. If a *high_level* is not defined, then it is taken
+as the same as the *low_level*.
+
+*\-*
+
+The optional hyphen '-' separator if a *high_level* is also being defined.
+
+*high_level*
+
+The processes highest level identifier that has been previously declared by
+a [*level*](#level) statement.
 
 ## *sensitivity*
 
@@ -113,53 +66,35 @@ sensitivity sens_id [alias sensitivityalias_id ...];
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>sensitivity</code></td>
-<td>The <code>sensitivity</code> keyword.</td>
-</tr>
-<tr>
-<td><code>sens_id</code></td>
-<td>The <code>sensitivity</code> identifier.</td>
-</tr>
-<tr>
-<td><code>alias</code></td>
-<td>The optional <code>alias</code> keyword.</td>
-</tr>
-<tr>
-<td><code>sensitivityalias_id</code></td>
-<td>One or more sensitivity alias identifiers in a space separated list.</td>
-</tr>
-</tbody>
-</table>
+*sensitivity*
+
+The *sensitivity* keyword.
+
+*sens_id*
+
+The *sensitivity* identifier.
+
+*alias*
+
+The optional *alias* keyword.
+
+*sensitivityalias_id*
+
+One or more sensitivity alias identifiers in a space separated list.
 
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
-<td>Yes</td>
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
+| No                      | No                      | Yes                     |
 
 **Examples:**
 
@@ -193,45 +128,29 @@ dominance { sensitivity_id ... }
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>dominance</code></td>
-<td>The <code>dominance</code> keyword.</td>
-</tr>
-<tr>
-<td><code>sensitivity_id</code></td>
-<td>A space separated list of previously declared <code>sensitivity</code> or <code>sensitivityalias</code> identifiers in the order lowest to highest. They are enclosed in braces '{}', and note that there is no terminating semi-colon ';'.</td>
-</tr>
-</tbody>
-</table>
-
-The statement is valid in:
-
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
+*dominance*
+
+The *dominance* keyword.
+
+*sensitivity_id*
+
+A space separated list of previously declared *sensitivity* or
+*sensitivityalias* identifiers in the order lowest to highest. They are
+enclosed in braces '{}', and note that there is no terminating semi-colon ';'.
+
+**The statement is valid in:**
+
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
 
@@ -255,53 +174,35 @@ category category_id [alias categoryalias_id ...];
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>category</code></td>
-<td>The <code>category</code> keyword.</td>
-</tr>
-<tr>
-<td><code>category_id</code></td>
-<td>The <code>category</code> identifier.</td>
-</tr>
-<tr>
-<td><code>alias</code></td>
-<td>The optional <code>alias</code> keyword.</td>
-</tr>
-<tr>
-<td><code>categoryalias_id</code></td>
-<td>One or more <code>alias</code> identifiers in a space separated list.</td>
-</tr>
-</tbody>
-</table>
+*category*
+
+The *category* keyword.
+
+*category_id*
+
+The *category* identifier.
+
+*alias*
+
+The optional *alias* keyword.
+
+*categoryalias_id*
+
+One or more *alias* identifiers in a space separated list.
 
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
-<td>Yes</td>
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
+| No                      | No                      | Yes                     |
 
 **Examples:**
 
@@ -337,52 +238,40 @@ level sensitivity_id [ :category_id ];
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>level</code></td>
-<td>The <code>level</code> keyword.</td>
-</tr>
-<tr>
-<td><code>sensitivity_id</code></td>
-<td>A previously declared <code>sensitivity</code> or <code>sensitivityalias</code> identifier.</td>
-</tr>
-<tr>
-<td><code>category_id</code></td>
-<td>An optional set of zero or more previously declared <code>category</code> or <code>categoryalias</code> identifiers that are preceded by a colon ':', that can be written as follows:
-<p>The period '.' separating two <code>category</code> identifiers means an inclusive set (e.g. <code>c0.c16</code>).</p>
-<p>The comma ',' separating two <code>category</code> identifiers means a non-contiguous list (e.g. <code>c21,c36,c45</code>).</p>
-<p>Both separators may be used (e.g. <code>c0.c16,c21,c36,c45</code>).</p></td>
-</tr>
-</tbody>
-</table>
+*level*
+
+The *level* keyword.
+
+*sensitivity_id*
+
+A previously declared *sensitivity* or *sensitivityalias* identifier.
+
+*category_id*
+
+An optional set of zero or more previously declared *category* or
+*categoryalias* identifiers that are preceded by a colon ':', that can be
+written as follows:
+
+- The period '.' separating two *category* identifiers means an inclusive
+  set (e.g. *c0.c16*).
+- The comma ',' separating two *category* identifiers means a non-contiguous
+  list (e.g. *c21,c36,c45*).
+
+Both separators may be used (e.g. *c0.c16,c21,c36,c45*).
 
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
 
@@ -417,55 +306,39 @@ range_transition source_type target_type : class new_range;
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>range_transition</code></td>
-<td>The <code>range_transition</code> keyword.</td>
-</tr>
-<tr>
-<td><p><code>source_type</code></p>
-<p><code>target_type</code></p></td>
-<td><p>One or more source / target <code>type</code> or <code>attribute</code> identifiers. Multiple entries consist of a space separated list enclosed in braces'{}'.</p>
-<p>Entries can be excluded from the list by using the negative operator '-'.</p></td>
-</tr>
-<tr>
-<td><code>class</code></td>
-<td>The optional object <code>class</code> keyword (this allows policy versions 21 and greater to specify a class other than the default of <code>process</code>).</td>
-</tr>
-<tr>
-<td><code>new_range</code></td>
-<td>The new MLS range for the object class. The format of this field is described in the <a href="#mls-range-definition">"MLS range Definition"</a> section.</td>
-</tr>
-</tbody>
-</table>
+*range_transition*
+
+The *range_transition* keyword.
+
+*source_type*, *target_type*
+
+One or more source / target *type* or *attribute* identifiers. Multiple entries
+consist of a space separated list enclosed in braces'{}'.
+Entries can be excluded from the list by using the negative operator '-'.
+
+*class*
+
+The optional object *class* keyword (this allows policy versions 21 and greater
+to specify a class other than the default of *process*).
+
+*new_range*
+
+The new MLS range for the object class. The format of this field is described
+in the [MLS range Definition](#mls-range-definition) section.
 
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


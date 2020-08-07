Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74FCC433DF
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 14:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B2492224D
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 14:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="aOVLzkwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgHGOkf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:40:35 -0400
Received: from mailomta8-sa.btinternet.com ([213.120.69.14]:10399 "EHLO
        sa-prd-fep-040.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbgHGOke (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Aug 2020 10:40:34 -0400
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-040.btinternet.com with ESMTP
          id <20200807144028.HTIW5290.sa-prd-fep-040.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Fri, 7 Aug 2020 15:40:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1596811228; 
        bh=/LttEA5JcayeMqWxnbafZ6xI3WYM3P87XdLES1Bb1Gw=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=aOVLzkwG2trwnmdFoRQMc+qRzw24kIaGIsBWAYZImnmfVtNfs0fAkUKETfD9t3WuuOydPZwU6aV6uD/xq4TvKZrZn5MSGFB4rwz6/8Ma5Vwn4xAlTBXjP/tBu7m8S7tS7pEdyFZDrhwDNvaIfEjnZ2N8dypngrt0up7rG0sP/a6S7wF3PttHUOrM3pqHOqxpAOTn7YYFZtT0/9Njs3aWsWAKt4ryLi2QSwJY7ki9uefu8O+cQf5uVnYlO83+fLIzeGGirQSsQsvXu6KObsmghUOegciSiPWw6H2tOfko7fWVVBDCGDSCM31Zfp17PGb9w6NrJAliKDS4AnkmAgov/g==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [213.122.112.2]
X-OWM-Source-IP: 213.122.112.2 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrkedvgdejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepudevleevgfejkeevkeevhfefudejudekgedvleffvedujeelvdffgeffudfguedvnecuffhomhgrihhnpegtohhmphgrrhhtmhgvnhhtshdrtggvnhhtvghrpdgtrghtvghgohhrihgvshdrtggvnhhtvghrpdhpohhlihgthidrtggvnhhtvghrpdgrrhgvrgdrtggvnhhtvghrpdgthedrshgvtghurhhithihpdgtohhmmhhonhgtrhhithgvrhhirghpohhrthgrlhdrohhrghenucfkphepvddufedruddvvddrudduvddrvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepvddufedruddvvddrudduvddrvddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhn
        vghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (213.122.112.2) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AFBE0AA1D09D; Fri, 7 Aug 2020 15:40:28 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH] selinux-notebook: mls_mcs.md convert and update text
Date:   Fri,  7 Aug 2020 15:40:25 +0100
Message-Id: <20200807144025.11668-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is an RFC patch to get some feedback as:
1) Table 1 is now a pipe table, however it still has <br> codes to
   break up the text. Also updated styles.html.css to match the pdf version
   to allow correct HTML rendering.
2) Table 2 is now a pipe table with updated text.

Add a TOC to aid navigation
Add text to clarify MCS/MLS

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/mls_mcs.md      | 236 ++++++++++++++++----------------------------
 src/styles_html.css |   5 +-
 2 files changed, 86 insertions(+), 155 deletions(-)

diff --git a/src/mls_mcs.md b/src/mls_mcs.md
index 4b4c15c..deb8c64 100644
--- a/src/mls_mcs.md
+++ b/src/mls_mcs.md
@@ -1,5 +1,13 @@
 # Multi-Level and Multi-Category Security
 
+-   [Security Levels](#security-levels)
+    -   [MLS or MCS Policy](#mls-or-mcs-policy)
+    -   [MLS / MCS Range Format](#mls-mcs-range-format)
+    -   [Translating Levels](#translating-levels)
+    -   [Managing Security Levels via Dominance Rules](#managing-security-levels-via-dominance-rules)
+-   [MLS Labeled Network and Database Support](#mls-labeled-network-and-database-support)
+-   [Common Criteria Certification](#common-criteria-certification)
+
 As stated in the
 [**Mandatory Access Control (MAC)**](mac.md#mandatory-access-control)
 section as well as supporting Type Enforcement (TE), SELinux also supports
@@ -48,6 +56,18 @@ The sections that follow discuss the format of a security level and
 range, and how these are managed by the constraints mechanism within
 SELinux using dominance rules.
 
+### MLS or MCS Policy
+
+From an SELinux perspective:
+
+-   An MLS policy has more than one security level with zero or more categories.
+    It is generally used in systems that require the 'Read Down' and 'Write Up'
+    services, whether it be for files, network services etc..
+-   An MCS policy has a single security level with zero or more categories.
+    Example uses are virtualization (see the
+    [**Virtual Machine Support**](vm_support.md#selinux-virtual-machine-support)
+    section) and container security.
+
 ## Security Levels
 
 **Table 1: Level, Label, Category or Compartment** shows the components that
@@ -59,50 +79,16 @@ within an MLS / MCS environment.
 The table also adds terminology in general use as other terms can be
 used that have the same meanings.
 
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
+|                                 |                                 |
+| :-----------------------------: | :-----------------------------: |
+| **Security Level (or Level)**<br>Consisting of a sensitivity and zero or more category entries: *sensitivity [: category, ... ]* also known as **Sensitivity Label** consisting of a classification and compartment. | Note that SELinux uses *level*, *sensitivity* and *category* in the language statements (see the [**MLS Language Statements**](mls_statements.md#mls-statements) section), however when discussing these the following terms can also be used: labels, classifications, and compartments. |
+
+| <---------------------------- Range ----------------------------> |
+| :---------------------------------------------------------------: |
+
+|                                 |                                 |
+| :-----------------------------: | :-----------------------------: |
+| **Low**<br>*sensitivity [: category, ... ]* For a process or subject this is the current level or sensitivity. For an object this is the current level or sensitivity.<br>**SystemLow**<br>This is the lowest level or classification for the system (for SELinux this is generally 's0', note that there are no categories). | **High**<br>*sensitivity [: category, ... ]* For a process or subject this is the Clearance. For an object this is the maximum range.<br>**SystemHigh**<br>This is the highest level or classification for the system (for SELinux this is generally 's15:c0,c255', although note that they will be the highest set by policy). |
 
 **Table 1: Level, Label, Category or Compartment** - *this table shows the meanings depending on the context
 being discussed.*
@@ -111,7 +97,7 @@ The format used in the policy language statements is fully described in
 the [MLS Statements](mls_statements.md#mls-statements) section, however
 a brief overview follows.
 
-#### MLS / MCS Range Format
+### MLS / MCS Range Format
 
 The following components (shown in bold) are used to define the MLS /
 MCS security levels within the security context:
@@ -125,26 +111,34 @@ user:role:type:sensitivity[:category,...]  -  sensitivity [:category,...]
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td>sensitivity</td>
-<td><p>Sensitivity levels are hierarchical with (traditionally) <code>s0</code> being the lowest. These values are defined using the <em><em>sensitivity</em></em> statement. To define their hierarchy, the <em>dominance</em> statement is used.</p>
-<p>For MLS systems the highest sensitivity is the last one defined in the dominance statement (low to high). Traditionally the maximum for MLS systems is <code>s15</code> (although the maximum value for the <em><em>Reference Policy</em></em> is a build time option). </p>
-<p>For MCS systems there is only one sensitivity defined, and that is <code>s0</code>.</p></td>
-</tr>
-<tr>
-<td>category</td>
-<td>Categories are optional (i.e. there can be zero or more categories) and they form unordered and unrelated lists of 'compartments'. These values are defined using the <code>category</code> statement, where for example <code>c0.c3</code> represents a <code>range (c0 c1 c3)</code> and <code>c0, c3, c7</code> represent an unordered list. Traditionally the values are between <code>c0</code> and <code>c255</code> (although the maximum value for the Reference Policy is a build time option).</td>
-</tr>
-<tr>
-<td>level</td>
-<td>The level is a combination of the <code>sensitivity</code> and <code>category</code> values that form the actual security level. These values are defined using the <code>level</code> statement.</td>
-</tr>
-</tbody>
-</table>
-
-#### Translating Levels
+*sensitivity*
+
+-   Sensitivity levels are hierarchical with (traditionally) *s0* being the
+    lowest. These values are defined using the *sensitivity* statement.
+    To define their hierarchy, the *dominance* statement is used.
+-   For MLS systems the highest sensitivity is the last one defined in the
+    dominance statement (low to high). Traditionally the maximum for MLS systems
+    is *s15* (although the maximum value for the *Reference Policy* is a build
+    time option).
+-   For MCS systems there is only one sensitivity defined, and that is *s0*.
+
+*category*
+
+-   Categories are optional (i.e. there can be zero or more categories) and they
+    form unordered and unrelated lists of 'compartments'. These values are
+    defined using the *category* statement, where for example *c0.c3*
+    represents the range that consists of *c0 c1 c2 c3* and *c0, c3, c7* that
+    represents an unordered list. Traditionally the values are between*c0* and
+    *c255* (although the maximum value for the Reference Policy is a build time
+    option).
+
+*level*
+
+-   The level is a combination of the *sensitivity* and *category* values that
+    form the actual security level. These values are defined using the *level*
+    statement.
+
+### Translating Levels
 
 When writing policy for MLS / MCS security level components it is usual
 to use an abbreviated form such as *s0*, *s1* etc. to represent
@@ -199,112 +193,48 @@ and within the dominance rules, the process will be constrained by using
 the *mlsconstrain* statement as illustrated in
 **Figure 9: *mlsconstrain* Statements controlling Read Down & Write Up**.
 
-<table>
-<tbody>
-<tr>
-<td></td>
-<td><center><strong>Category -&gt;</strong></center></td>
-<td>c0</td>
-<td>c1</td>
-<td>c2</td>
-<td>c3</td>
-<td>c4</td>
-<td>c5</td>
-<td>c6</td>
-<td>c7</td>
-</tr>
-<tr>
-<td>s3</td>
-<td>Secret</td>
-<td>s3:c0</td>
-<td style="background-color:#D3D3D3;"></td>
-<td style="background-color:#D3D3D3;"></td>
-<td style="background-color:#D3D3D3;"></td>
-<td style="background-color:#D3D3D3;"></td>
-<td style="background-color:#D3D3D3;">s3:c5</td>
-<td>s3:c6</td>
-<td></td>
-</tr>
-<tr>
-<td>s2</td>
-<td>Confidential</td>
-<td></td>
-<td style="background-color:#D3D3D3;">s2:c1</td>
-<td style="background-color:#D3D3D3;">s2:c2</td>
-<td style="background-color:#D3D3D3;">s2:c3</td>
-<td style="background-color:#D3D3D3;">s2:c4</td>
-<td style="background-color:#D3D3D3;"></td>
-<td></td>
-<td>s2:c7</td>
-</tr>
-<tr>
-<td>s1</td>
-<td>Restricted</td>
-<td>s1:c0</td>
-<td style="background-color:#D3D3D3;">s1:c1</td>
-<td style="background-color:#D3D3D3;"></td>
-<td style="background-color:#D3D3D3;"></td>
-<td style="background-color:#D3D3D3;"></td>
-<td style="background-color:#D3D3D3;"></td>
-<td></td>
-<td>s1:c7</td>
-</tr>
-<tr>
-<td>s0</td>
-<td>Unclassified</td>
-<td>s0:c0</td>
-<td style="background-color:#D3D3D3;"></td>
-<td style="background-color:#D3D3D3;"></td>
-<td style="background-color:#D3D3D3;">s0:c3</td>
-<td style="background-color:#D3D3D3;"></td>
-<td style="background-color:#D3D3D3;"></td>
-<td></td>
-<td>s0:c7</td>
-</tr>
-<tr>
-<td><p><center><strong>^<br><br>Sensitivity</strong></center></p>
-</td>
-<td><p><center><strong>^<br>Security Level</strong></p>
-<p>(sensitivity:category)<br>aka: classification</center></p>
-</td>
-<td colspan="8"><p><center><strong>^-------- File Labels --------^</strong></center></p>
-<p><center>A process running with a range of <code>s0 - s3:c1.c5</code> has access to the files within the grey boxed area.</center></p></td>
-</tr>
-</tbody>
-</table>
-
-**Table 2: MLS Security Levels** - *Showing the scope of a process running
-at a security range of *s0 - s3:c1.c5*.*
+|Security Level| Sensitivity    |       |           |           |           |           |           |       |     |
+| :----------- | :------------: | :---: | :-------: | :-------: | :-------: | :-------: | :-------: | :---: | :-: |
+|              |**Category -\>**| *c0*  |    *c1*   |    *c2*   |    *c3*   |    *c4*   |    *c5*   | *c6*  |*c7* |
+| Secret       |*s3*            |*s3:c0*|           |           |           |           |***s3:c5***|*s3:c6*|     |
+| Confidential |*s2*            |       |***s2:c1***|***s2:c2***|***s2:c3***|***s2:c4***|           |       |s2:c7|
+| Restricted   |*s1*            |*s1:c0*|***s1:c1***|           |           |           |           |       |s1:c7|
+| Unclassified |*s0*            |*s0:c0*|           |           |***s0:c3***|           |           |       |s0:c7|
+
+**Table 2: MLS Security Levels** - *Showing that a process running at
+s0 - s3:c1.c5 has access to the highlighted **sensitivity:category** files*.
 
 ![](./images/9-mls-constrain.png)
 
-**Figure 9: Showing the mlsconstrain Statements controlling Read Down & Write Up** - *This ties in with* **Table 2: MLS Security Levels** *that shows a process running with a security range of s0 - s3:c1.c5.*
+**Figure 9: Showing mlsconstrain Statements controlling Read Down & Write Up** -
+*This ties in with* **Table 2: MLS Security Levels** *that shows a process
+running with a security range of s0 - s3:c1.c5.*
 
 Using **Figure 9: *mlsconstrain* Statements controlling Read Down & Write Up**:
 
-1.  To allow write-up, the source level (l1) must be **dominated by**
-    the target level (l2):
--   Source level = s0:c3 or s1:c1
--   Target level = s2:c1.c4
+-   To allow write-up, the source level (*l1*) must be **dominated by**
+    the target level (*l2*):
+    -  Source level = *s0:c3* or *s1:c1*
+    -  Target level = *s2:c1.c4*
 
 As can be seen, either of the source levels are **dominated by** the
 target level.
 
-2.  To allow read-down, the source level (l1) must **dominate** the
-    target level (l2):
--   Source level = s2:c1.c4
--   Target level = s0:c3
+-   To allow read-down, the source level (*l1*) must **dominate** the
+    target level (*l2*):
+    -  Source level = *s2:c1.c4*
+    -  Target level = *s0:c3*
 
 As can be seen, the source level does **dominate** the target level.
 
 However in the real world the SELinux MLS Reference Policy does not
 allow the write-up unless the process has a special privilege (by having
 the domain type added to an attribute), although it does allow the
-read-down. The default is to use l1 eq l2 (i.e. the levels are equal).
+read-down. The default is to use *l1 eq l2* (i.e. the levels are equal).
 The reference policy MLS source file (policy/mls) shows these
 *mlsconstrain* statements.
 
-### MLS Labeled Network and Database Support
+## MLS Labeled Network and Database Support
 
 Networking for MLS is supported via the NetLabel CIPSO (commercial IP
 security option) and CALIPSO (Common Architecture Label
@@ -316,7 +246,7 @@ PostgreSQL supports labeling for MLS database services as discussed in
 the [**SE-PostgreSQL Support**](postgresql.md#postgresql-selinux-support)
 section.
 
-### Common Criteria Certification
+## Common Criteria Certification
 
 While the [*Common Criteria*](http://www.commoncriteriaportal.org/)
 certification process is beyond the scope of this Notebook, it is worth
diff --git a/src/styles_html.css b/src/styles_html.css
index fef851e..a5fa457 100644
--- a/src/styles_html.css
+++ b/src/styles_html.css
@@ -15,8 +15,9 @@ a {
 
 table {
 	/* limit to 95% page width */
-	min-width: 50%;
-	max-width: 95%;
+	margin-left: auto;
+	margin-right: auto;
+	width: 95%;
 	/* combine table borders when they are adjacent */
 	border-collapse: collapse;
 }
-- 
2.26.2


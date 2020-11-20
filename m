Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCF3C5519F
	for <selinux@archiver.kernel.org>; Fri, 20 Nov 2020 11:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C1BD22253
	for <selinux@archiver.kernel.org>; Fri, 20 Nov 2020 11:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="boAyPxLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgKTLiT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Nov 2020 06:38:19 -0500
Received: from mailomta30-sa.btinternet.com ([213.120.69.36]:43694 "EHLO
        sa-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727855AbgKTLiS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Nov 2020 06:38:18 -0500
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20201120113812.VJMC32244.sa-prd-fep-045.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Fri, 20 Nov 2020 11:38:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1605872292; 
        bh=K69gDVEx6M+PyJ764d3G2c7G/T/XKIsCNgTl42RJ9G4=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=boAyPxLglWQ5H3nqyDyXP7pX1t0NmwBEkEq+9crXmP3JVVb/Zpc052U+y5YGt7gkvIKR6DO18zkTJAjwNUY2AIxGs7NoXUlUaZwh2XJPyCJ2qRrJuPAf8fUq7gDbt+9F0xA09WJ3yOV5ZhJoMbEb3GBcNmlA6MjNrpWtmu4/vpraRp9ph+fYzQFpjN5Z8w6M6i6gWdC1co8J4Dw3cRaHrtpZTSg4Ao8lAwO34Zt60qSI74rQjBFOYuXK707SC7K6ADihRcyWWoF38OtVvsFjeV9fTjxXZ9fIF1Za2+Zp3X4XAt3YGextXomle5WtbxECeipLHDdGm2s0uoEhNC2cIQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9AFBE1B53F50F
X-Originating-IP: [86.184.97.134]
X-OWM-Source-IP: 86.184.97.134 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudegtddgvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeetgeeffeevkeejkeevjeeklefgieffgeetfffhffekgeeutdfgjeduvefggefgfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgtohhmphgrrhhtmhgvnhhtshdrtggvnhhtvghrpdgtrghtvghgohhrihgvshdrtggvnhhtvghrpdhpohhlihgthidrtggvnhhtvghrpdgrrhgvrgdrtggvnhhtvghrpdgthedrshgvtghurhhithihpdgtohhmmhhonhgtrhhithgvrhhirghpohhrthgrlhdrohhrghenucfkphepkeeirddukeegrdeljedrudefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddukeegrdeljedrudefgedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhi
        tghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.184.97.134) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AFBE1B53F50F; Fri, 20 Nov 2020 11:38:12 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] mls_mcs.md: Convert section to markdown
Date:   Fri, 20 Nov 2020 11:38:07 +0000
Message-Id: <20201120113807.11605-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a TOC to aid navigation and converted to markdown.

Reworked a table that required rewording some text.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
RFC Change: Updated MLS/MCS text to reflect [1] comments.

All Notebook sections should now be in markdown.

[1] https://lore.kernel.org/selinux/80e38828-1473-5bc5-1b23-067cd242125a@gmail.com/

 src/mls_mcs.md | 411 ++++++++++++++++++++++++-------------------------
 1 file changed, 204 insertions(+), 207 deletions(-)

diff --git a/src/mls_mcs.md b/src/mls_mcs.md
index 4b4c15c..0c25108 100644
--- a/src/mls_mcs.md
+++ b/src/mls_mcs.md
@@ -1,5 +1,13 @@
 # Multi-Level and Multi-Category Security
 
+- [MLS or MCS Policy](#mls-or-mcs-policy)
+- [Security Levels](#security-levels)
+  - [MLS / MCS Range Format](#mls-mcs-range-format)
+  - [Translating Levels](#translating-levels)
+  - [Managing Security Levels via Dominance Rules](#managing-security-levels-via-dominance-rules)
+- [MLS Labeled Network and Database Support](#mls-labeled-network-and-database-support)
+- [Common Criteria Certification](#common-criteria-certification)
+
 As stated in the
 [**Mandatory Access Control (MAC)**](mac.md#mandatory-access-control)
 section as well as supporting Type Enforcement (TE), SELinux also supports
@@ -32,89 +40,104 @@ except that the statement is called *mlsconstrain*.
 
 However, as always life is not so simple as:
 
-1.  Processes and objects can be given a range that represents the low
-    and high security levels.
-2.  The security level can be more complex, in that it is a hierarchical
-    sensitivity and zero or more non-hierarchical categories.
-3.  Allowing a process access to an object is managed by 'dominance'
-    rules applied to the security levels.
-4.  Trusted processes can be given privileges that will allow them to
-    bypass the BLP rules and basically do anything (that the security
-    policy allowed of course).
-5.  Some objects do not support separate read / write functions as they
-    need to read / respond in cases such as networks.
+1. Processes and objects can be given a range that represents the low
+   and high security levels.
+2. The security level can be more complex, in that it is a hierarchical
+   sensitivity and zero or more non-hierarchical categories.
+3. Allowing a process access to an object is managed by 'dominance'
+   rules applied to the security levels.
+4. Trusted processes can be given privileges that will allow them to
+   bypass the BLP rules and basically do anything (that the security
+   policy allowed of course).
+5. Some objects do not support separate read / write functions as they
+   need to read / respond in cases such as networks.
 
 The sections that follow discuss the format of a security level and
 range, and how these are managed by the constraints mechanism within
 SELinux using dominance rules.
 
+## MLS or MCS Policy
+
+SELinux only knows of MLS, i.e. it has a MLS engine in the security
+server[^fn_mls_1] and a MLS portion of the policy configuration that drives
+that engine. The MLS engine has been leveraged by two different types of
+policy:
+
+- The MLS configuration modeled after Bell-LaPadula.
+- The MCS configuration that allows a process or object to be labeled with
+  categories. This has proved useful as a transparent isolation mechanism
+  for sandbox, container, and virtualization runtimes (see the
+  [**Virtual Machine Support**](vm_support.md#selinux-virtual-machine-support)
+  section).
+
+As a security level is a combination of a hierarchical sensitivity and a
+non-hierarchical (potentially empty) category set, MCS doesn't employ
+sensitivities since there is no hierarchical relationship to be enforced.
+Note however, that the SELinux kernel policy language defines *sensitivity*
+as a single value such as *s0*, *s1* etc.. Therefore the BLP defined
+sensitivity is formed in an SELinux MLS policy by a combination of the
+following (excluding the category statements):
+
+```
+sensitivity s0;
+sensitivity s1;
+dominance { s0 s1 } # s1 dominates s0
+```
+
+While an MCS policy does not use the BLP sensitivity definition, an SELinux
+policy still requires the following entries (basically defining a single level):
+
+```
+sensitivity s0;
+dominance { s0 }
+```
+
+The number of sensitivities, number of categories, and the set of MLS
+constraints used to determine whether a permission is allowed are entirely up
+to the policy author. See the
+[**The Reference Policy**](reference_policy.md#the-reference-policy) section
+for its configuration parameters.
+
 ## Security Levels
 
-**Table 1: Level, Label, Category or Compartment** shows the components that
-make up a security level and how two security levels form a range for the
-fourth and optional *\[:range\]* of the
-[**Security Context**](security_context.md#security-context)
-within an MLS / MCS environment.
-
-The table also adds terminology in general use as other terms can be
-used that have the same meanings.
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
-**Table 1: Level, Label, Category or Compartment** - *this table shows the meanings depending on the context
-being discussed.*
+The optional MLS policy extension adds an additional security context
+component that consists of the following highlighted entries:
+
+*user:role:type* ***:sensitivity[:category,...] - sensitivity[:category,...]***
+
+Note that:
+
+- Security Levels on objects are called Classifications.
+- Security Levels on subjects are called Clearances.
+
+The list below describes the components that make up a security level and how
+two security levels form a range for an MLS
+[**Security Context**](security_context.md#security-context):
+
+- **Low**
+  - *sensitivity[:category, ... ]*
+    - For a process or subject this is the current level or sensitivity.
+      For an object this is the current level or sensitivity.
+- **SystemLow**
+  - This is the lowest level or classification for the system (for SELinux this
+    is generally *s0*, note that there are no categories).
+- **High**
+  - *sensitivity[:category, ... ]*
+    - For a process or subject this is the Clearance. For an object this is
+      the maximum range.
+- **SystemHigh**
+  - This is the highest level or classification for the system (for an MLS
+    Reference Policy the default is *s15:c0,c255*, although this is a
+    configurable build option).
 
 The format used in the policy language statements is fully described in
 the [MLS Statements](mls_statements.md#mls-statements) section, however
 a brief overview follows.
 
-#### MLS / MCS Range Format
+### MLS / MCS Range Format
 
-The following components (shown in bold) are used to define the MLS /
-MCS security levels within the security context:
+The components are used to define the MLS security levels and MCS categories
+within the security context are:
 
 ```
 user:role:type:sensitivity[:category,...]  -  sensitivity [:category,...]
@@ -125,26 +148,57 @@ user:role:type:sensitivity[:category,...]  -  sensitivity [:category,...]
 
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
+- Sensitivity levels are hierarchical with (traditionally) *s0* being the
+  lowest. These values are defined using the *sensitivity* statement.
+  To define their hierarchy, the *dominance* statement is used.
+- For MLS systems the highest sensitivity is the last one defined in the
+  *dominance* statement (low to high). Traditionally the maximum for MLS systems
+  is *s15* (although the maximum value for the *Reference Policy* is a build
+  time option).
+- For MCS systems there is only one *sensitivity* statement defined, and that
+  is *s0*.
+
+*category*
+
+- Categories are optional (i.e. there can be zero or more categories) and they
+  form unordered and unrelated lists of 'compartments'. These values are
+  defined using the *category* statement, where for example *c0.c3*
+  represents the range that consists of *c0 c1 c2 c3* and *c0, c3, c7* that
+  represents an unordered list. Traditionally the values are between*c0* and
+  *c255* (although the maximum value for the Reference Policy is a build time
+  option).
+
+*level*
+
+- The level is a combination of the *sensitivity* and *category* values that
+  form the actual security level. These values are defined using the *level*
+  statement.
+
+Example policy entries:
+
+```
+# MLS Policy statements:
+sensitivity s0;
+sensitivity s1;
+dominance { s0 s1 }
+category c0;
+category c1;
+level s0:c0.c1;
+level s1:c0.c1;
+```
+
+```
+# MCS Policy statements:
+sensitivity s0;
+dominance { s0 }
+category c0;
+category c1;
+level s0:c0.c1;
+```
+
+### Translating Levels
 
 When writing policy for MLS / MCS security level components it is usual
 to use an abbreviated form such as *s0*, *s1* etc. to represent
@@ -165,26 +219,30 @@ As stated earlier, allowing a process access to an object is managed by
 [***dominance***](mls_statements.md#dominance) rules applied to the security
 levels. These rules are as follows:
 
-**Security Level 1 dominates Security Level 2** - If the sensitivity of
-Security Level 1 is equal to or higher than the sensitivity of Security
-Level 2 and the categories of Security Level 1 are the same or a
-superset of the categories of Security Level 2.
+**Security Level 1 dominates Security Level 2**
+
+ - If the sensitivity of *Security Level 1* is equal to or higher than the
+   sensitivity of *Security Level 2* and the categories of *Security Level 1*
+   are the same or a superset of the categories of *Security Level 2*.
+
+**Security Level 1 is dominated by Security Level 2**
 
-**Security Level 1 is dominated by Security Level 2** - If the
-sensitivity of Security Level 1 is equal to or lower than the
-sensitivity of Security Level 2 and the categories of Security Level 1
-are a subset of the categories of Security Level 2.
+ - If the sensitivity of *Security Level 1* is equal to or lower than the
+   sensitivity of *Security Level 2* and the categories of *Security Level 1*
+   are a subset of the categories of *Security Level 2*.
 
-**Security Level 1 equals Security Level 2** - If the sensitivity of
-Security Level 1 is equal to Security Level 2 and the categories of
-Security Level 1 and Security Level 2 are the same set (sometimes
-expressed as: both Security Levels dominate each other).
+**Security Level 1 equals Security Level 2**
 
-**Security Level 1 is incomparable to Security Level 2** - If the
-categories of Security Level 1 and Security Level 2 cannot be compared
-(i.e. neither Security Level dominates the other).
+ - If the sensitivity of *Security Level 1* is equal to *Security Level 2*
+   and the categories of *Security Level 1* and *Security Level 2* are the
+   same set (sometimes expressed as: both Security Levels dominate each other).
 
-To illustrate the usage of these rules, **Table 2: MLS Security Levels** lists
+**Security Level 1 is incomparable to Security Level 2**
+
+ - If the categories of *Security Level 1* and *Security Level 2* cannot be
+   compared (i.e. neither Security Level dominates the other).
+
+To illustrate the usage of these rules, **Table 1: MLS Security Levels** lists
 the security level attributes in a table to show example files (or
 documents) that have been allocated labels such as *s3:c0*. The process
 that accesses these files (e.g. an editor) is running with a range of
@@ -199,112 +257,48 @@ and within the dominance rules, the process will be constrained by using
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
+| Security Level |  Sensitivity   |       |           |           |           |           |           |       |     |
+| :------------- | :------------: | :---: | :-------: | :-------: | :-------: | :-------: | :-------: | :---: | :-: |
+|                |**Category -\>**| *c0*  |    *c1*   |    *c2*   |    *c3*   |    *c4*   |    *c5*   | *c6*  |*c7* |
+|**Secret**      |*s3*            |*s3:c0*|           |           |           |           |***s3:c5***|*s3:c6*|     |
+|**Confidential**|*s2*            |       |***s2:c1***|***s2:c2***|***s2:c3***|***s2:c4***|           |       |s2:c7|
+|**Restricted**  |*s1*            |*s1:c0*|***s1:c1***|           |           |           |           |       |s1:c7|
+|**Unclassified**|*s0*            |*s0:c0*|           |           |***s0:c3***|           |           |       |s0:c7|
+
+**Table 1: MLS Security Levels** - *Showing that a process running at
+s0 - s3:c1.c5 has access to the highlighted **sensitivity:category** files*.
 
 ![](./images/9-mls-constrain.png)
 
-**Figure 9: Showing the mlsconstrain Statements controlling Read Down & Write Up** - *This ties in with* **Table 2: MLS Security Levels** *that shows a process running with a security range of s0 - s3:c1.c5.*
+**Figure 9: Showing mlsconstrain Statements controlling Read Down & Write Up** -
+*This ties in with* **Table 1: MLS Security Levels** *that shows a process
+running with a security range of s0 - s3:c1.c5.*
 
 Using **Figure 9: *mlsconstrain* Statements controlling Read Down & Write Up**:
 
-1.  To allow write-up, the source level (l1) must be **dominated by**
-    the target level (l2):
--   Source level = s0:c3 or s1:c1
--   Target level = s2:c1.c4
+- To allow write-up, the source level (*l1*) must be **dominated by**
+  the target level (*l2*):
+  - Source level = *s0:c3* or *s1:c1*
+  - Target level = *s2:c1.c4*
 
 As can be seen, either of the source levels are **dominated by** the
 target level.
 
-2.  To allow read-down, the source level (l1) must **dominate** the
-    target level (l2):
--   Source level = s2:c1.c4
--   Target level = s0:c3
+- To allow read-down, the source level (*l1*) must **dominate** the
+  target level (*l2*):
+  - Source level = *s2:c1.c4*
+  - Target level = *s0:c3*
 
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
@@ -316,7 +310,7 @@ PostgreSQL supports labeling for MLS database services as discussed in
 the [**SE-PostgreSQL Support**](postgresql.md#postgresql-selinux-support)
 section.
 
-### Common Criteria Certification
+## Common Criteria Certification
 
 While the [*Common Criteria*](http://www.commoncriteriaportal.org/)
 certification process is beyond the scope of this Notebook, it is worth
@@ -329,22 +323,25 @@ certificate should be obtained.
 
 The Red Hat evaluation process cover the:
 
--   Labeled Security Protection Profile
-    ([*LSPP*](http://www.commoncriteriaportal.org/files/ppfiles/lspp.pdf)
-    ) - This describes how systems that implement security labels (i.e.
-    MLS) should function.
--   Controlled Access Protection Profile
-    ([*CAPP*](http://www.commoncriteriaportal.org/files/ppfiles/capp.pdf)) -
-    This describes how systems that implement DAC should function.
+- Labeled Security Protection Profile
+  ([*LSPP*](http://www.commoncriteriaportal.org/files/ppfiles/lspp.pdf)) -
+  This describes how systems that implement security labels (i.e. MLS) should
+  function.
+- Controlled Access Protection Profile
+  ([*CAPP*](http://www.commoncriteriaportal.org/files/ppfiles/capp.pdf)) -
+  This describes how systems that implement DAC should function.
 
 An interesting point:
 
--   Both Red Hat Linux 5.1 and Microsoft Server 2003 (with XP) have both
-    been certified to EAL4+ , however while the evaluation levels may be
-    the same the Protection Profiles that they were evaluated under
-    were: Microsoft CAPP only, Red Hat CAPP and LSPP. Therefore always
-    look at the protection profiles as they define what was actually
-    evaluated.
+- Both Red Hat Linux 5.1 and Microsoft Server 2003 (with XP) have both
+  been certified to EAL4+ , however while the evaluation levels may be
+  the same the Protection Profiles that they were evaluated under
+  were: Microsoft CAPP only, Red Hat CAPP and LSPP. Therefore always
+  look at the protection profiles as they define what was actually
+  evaluated.
+
+[^fn_mls_1]:  See [**Figure 2: High Level SELinux Architecture**](core_components.md#core-selinux-components)
+in the 'Core SELinux Components' section.
 
 <!-- %CUTHERE% -->
 
-- 
2.28.0


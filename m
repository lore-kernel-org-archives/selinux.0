Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DC1C433DF
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0E2A20706
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="Ic23xeMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgHYIiP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:38:15 -0400
Received: from mailomta22-sa.btinternet.com ([213.120.69.28]:12727 "EHLO
        sa-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726905AbgHYIiO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 04:38:14 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20200825083808.MPKL26847.sa-prd-fep-043.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 25 Aug 2020 09:38:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598344688; 
        bh=/LagwUNmVydS69xhHfqyQiV7nB4ff26cXv4LpsqTBLk=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=Ic23xeMlPeTFrluruvHqIAfLHURo5dUS391yK+8IceWekUYWdOvphjq6MGLqsSG8xjxrz64MS/H74eChKp6zmsUisXgjlrSanvddBuo2CA632T31SdJxJcskiNt1Wg9q0XY+9xH4VMtAbA4SIN9PaOmjJ3DxqIEMtoX1Bwp2uSf6VPugVWbyXm5fzMpsOVyQWh11cUR1rLSvxSfP6MtmyJqwWkWeJfAmr4qPg3/em3BnymLKaN8A3QLUwEEriubxcDe49DJe4igKugRlnN7KcUoUvlRiXpzEzFd5BlPkSNO7gTcxIaxM5LTvNEj6E1c48Y2zi+XGjm/4j4eCILnPUg==
Authentication-Results: btinternet.com; none
X-Originating-IP: [109.155.130.160]
X-OWM-Source-IP: 109.155.130.160 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepgfekgffghffgleekgfellefftedvhfejveehhfekkefgvdehueetgfffffelkedtnecukfhppedutdelrdduheehrddufedtrdduiedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduheehrddufedtrdduiedtpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.130.160) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B8A70D599D8D; Tue, 25 Aug 2020 09:38:08 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 03/18] avc_rules: Convert to markdown
Date:   Tue, 25 Aug 2020 09:37:28 +0100
Message-Id: <20200825083743.6508-4-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825083743.6508-1-richard_c_haines@btinternet.com>
References: <20200825083743.6508-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a TOC to aid navigation and convert to markdown.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/avc_rules.md | 115 +++++++++++++++++++++++------------------------
 1 file changed, 56 insertions(+), 59 deletions(-)

diff --git a/src/avc_rules.md b/src/avc_rules.md
index 7572302..b1535d3 100644
--- a/src/avc_rules.md
+++ b/src/avc_rules.md
@@ -1,5 +1,11 @@
 # Access Vector Rules
 
+- [Access Vector Rules](#access-vector-rules)
+  - [*allow*](#allow)
+  - [*dontaudit*](#dontaudit)
+  - [*auditallow*](#auditallow)
+  - [*neverallow*](#neverallow)
+
 The AV rules define what access control privileges are allowed for
 processes and objects. There are four types of AV rule: *allow*,
 *dontaudit*, *auditallow*, and *neverallow* as explained in the sections that
@@ -26,63 +32,56 @@ rule_name source_type target_type : class perm_set;
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>rule_name</code></td>
-<td>The applicable <code>allow</code>, <code>dontaudit</code>, <code>auditallow</code>, and <code>neverallow</code> rule keyword.</td>
-</tr>
-<tr>
-<td><p><code>source_type</code></p>
-<p><code>target_type</code></p></td>
-<td><p>One or more source / target <code>type</code>, <code>typealias</code> or <code>attribute</code> identifiers. Multiple entries consist of a space separated list enclosed in braces '{}'. Entries can be excluded from the list by using the negative operator '-'.</p>
-<p>The *target_type* can have the self keyword instead of <code>type</code>, <code>typealias</code> or <code>attribute</code> identifiers. This means that the *target_type* is the same as the *source_type*.</p>
-<p>The <code>neverallow</code> rule also supports the wildcard operator '*' to specify that all types are to be included and the complement operator '~' to specify all types are to be included except those explicitly listed.</p></td>
-</tr>
-<tr>
-<td><code>class</code></td>
-<td>One or more object classes. Multiple entries consist of a space separated list enclosed in braces '{}'.</td>
-</tr>
-<tr>
-<td>perm_set</td>
-<td><p>The access permissions the source is allowed to access for the target object (also known as the Access Vector). Multiple entries consist of a space separated list enclosed in braces '{}'. </p>
-<p>The optional wildcard operator '*' specifies that all permissions for the object <code>class</code> can be used. </p>
-<p>The complement operator '~' is used to specify all permissions except those explicitly listed (although the compiler issues a warning if the <code>dontaudit</code> rule has '~'.</p></td>
-</tr>
-</tbody>
-</table>
+*rule_name*
+
+The applicable *allow*, *dontaudit*, *auditallow*, and *neverallow* rule keyword.
+
+*source_type*, *target_type*
+
+One or more source / target *type*, *typealias* or *attribute* identifiers.
+Multiple entries consist of a space separated list enclosed in braces \'\{\}\'.
+Entries can be excluded from the list by using the negative operator \'-\'.
+The *target_type* can have the self keyword instead of *type*, *typealias*
+or *attribute* identifiers. This means that the *target_type* is the same
+as the *source_type*.
+The *neverallow* rule also supports the wildcard operator \'\*\' to specify
+that all types are to be included and the complement operator \'\~\' to
+specify all types are to be included except those explicitly listed.
+
+*class*
+
+One or more object classes. Multiple entries consist of a space separated
+list enclosed in braces \'\{\}\'.
+
+*perm_set*
+
+The access permissions the source is allowed to access for the target
+object (also known as the Access Vector). Multiple entries consist of a
+space separated list enclosed in braces \'\{\}\'.
+The optional wildcard operator \'\*\' specifies that all permissions for
+the object *class* can be used.
+The complement operator \'\~\' is used to specify all permissions except
+those explicitly listed (although the compiler issues a warning if the
+*dontaudit* rule has \'\~\'.
 
 **The statements are valid in:**
 
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
-<td><strong>Yes:</strong> <code>allow</code>, <code>dontaudit</code>, <code>auditallow</code> <strong>No:</strong> <code>neverallow</code></td>
-<td><strong>Yes:</strong> <code>allow</code>, <code>dontaudit</code>, <code>auditallow</code>, <code>neverallow</code></td>
-<td><strong>No:</strong> <code>allow</code>, <code>dontaudit</code>, <code>auditallow</code>, <code>neverallow</code></td>
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
+| Yes: *allow*, *dontaudit*, *auditallow* No: *neverallow* | Yes     | No     |
 
 ## *allow*
 
-The allow rule checks whether the operations between the source\_type
-and target_type are allowed for the class and permissions defined. It
+The allow rule checks whether the operations between the *source_type*
+and *target_type* are allowed for the class and permissions defined. It
 is the most common statement that many of the **Reference Policy**
 helper macros and interface definitions expand into multiple allow rules.
 
@@ -177,8 +176,7 @@ auditallow ada_t self:process execstack;
 This rule specifies that an *allow* rule must not be generated for the
 operation, even if it has been previously allowed. The *neverallow*
 statement is a compiler enforced action, where the ***checkpolicy**(8)*,
-***checkmodule**(8)* <a href="#fna1" class="footnote-ref" id="fnavc1"><sup>1</sup></a>
-or ***secilc**(8)* <a href="#fna2" class="footnote-ref" id="fnavc2"><sup>2</sup></a>
+***checkmodule**(8)*[^fn_avc_1] or ***secilc**(8)*[^fn_avc_2]
 compiler checks if any allow rules have been generated in the policy source,
 if so it will issue a warning and stop.
 
@@ -201,12 +199,11 @@ neverallow ~can_read_shadow_passwords shadow_t:file read;
 neverallow { domain -mmap_low_domain_type } self:memprotect mmap_zero;
 ```
 
-<section class="footnotes">
-<ol>
-<li id="fna1"><p><code>neverallow</code> statements are allowed in modules, however to detect these the <em>semanage.conf</em> file must have the 'expand-check=1' entry present.<a href="#fnavc1" class="footnote-back">↩</a></p></li>
-<li id="fna2"><p>The *--disable-neverallow* option can be used with <em></strong>secilc</strong>(8)</em> to disable <code>neverallow</code> rule checking.<a href="#fnavc2" class="footnote-back">↩</a></p></li>
-</ol>
-</section>
+[^fn_avc_1]: *neverallow* statements are allowed in modules, however to detect
+these the *semanage.conf* file must have the 'expand-check=1' entry present.
+
+[^fn_avc_2]: The *\-\-disable-neverallow* option can be used with ***secilc**(8)*
+to disable *neverallow* rule checking.
 
 <!-- %CUTHERE% -->
 
-- 
2.26.2


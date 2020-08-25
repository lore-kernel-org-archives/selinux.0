Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE018C433EA
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B875A2071E
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="TL/N9Eik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgHYIiZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:38:25 -0400
Received: from mailomta9-sa.btinternet.com ([213.120.69.15]:35166 "EHLO
        sa-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729003AbgHYIiS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 04:38:18 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-046.btinternet.com with ESMTP
          id <20200825083814.RNYH4114.sa-prd-fep-046.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 25 Aug 2020 09:38:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598344694; 
        bh=Q88WSTdQzGbFHlFMHrp2oR2+T9Wza1NWJzWqze3a3Bg=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=TL/N9EikDQCHhnmr65fVSD8hXLazN1GGIW4RCRD5qxEJza9t8ua3z+B2NW1sriVQ7W1bgQGk8SQHD3yNzNBrBoKxTADAtLRpZF7AMOTWgObiLOwM8slpOEVzSRPkV9RfJoibLNPxKlnG7zy+vq8LDeLUrtm5Lg4k0SJsdfRsH07qxMbIGym9OYdDwPYAf+eDpCsbSxhGe+Jr9c9hAvEMI/CGQNRnEWgEbbKOYJXLLuqwlkTIW/B/z0XevVcLDScVNm8i4k7MSTT+9RSAx9KNt+5Y/dXuuvlSPRjO8GspVvcImkssZxYjfyXOf+k1ZQryZHdoDoD9bnV0q2+et04EvQ==
Authentication-Results: btinternet.com; none
X-Originating-IP: [109.155.130.160]
X-OWM-Source-IP: 109.155.130.160 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepuddtledrudehhedrudeftddrudeitdenucevlhhushhtvghrufhiiigvpeduudenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduheehrddufedtrdduiedtpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.130.160) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B8A70D599E8B; Tue, 25 Aug 2020 09:38:14 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 18/18] infiniband_statements: Convert to markdown
Date:   Tue, 25 Aug 2020 09:37:43 +0100
Message-Id: <20200825083743.6508-19-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825083743.6508-1-richard_c_haines@btinternet.com>
References: <20200825083743.6508-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a TOC to aid navigation and convert to markdown.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/infiniband_statements.md | 155 ++++++++++++++---------------------
 1 file changed, 61 insertions(+), 94 deletions(-)

diff --git a/src/infiniband_statements.md b/src/infiniband_statements.md
index 492bdb6..943cee6 100644
--- a/src/infiniband_statements.md
+++ b/src/infiniband_statements.md
@@ -1,5 +1,8 @@
 # InfiniBand Labeling Statements
 
+- [*ibpkeycon*](#ibpkeycon)
+- [*ibendportcon*](#ibendportcon)
+
 To support access control for InfiniBand (IB) partitions and subnet
 management, security contexts are provided for: Partition Keys (Pkey)
 that are 16 bit numbers assigned to subnets and their IB end ports. An
@@ -13,7 +16,7 @@ Note that there are no terminating semi-colons ';' on these statements.
 The *ibpkeycon* statement is used to label IB partition keys.
 
 It is also possible to add a security context to partition keys outside
-the policy using the ***semanage ibpkey*** command that will associate the
+the policy using the *semanage ibpkey* command that will associate the
 *pkey* (or range of pkeys) to a security context.
 
 **The statement definition is:**
@@ -24,53 +27,35 @@ ibpkeycon subnet pkey pkey_context
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>ibpkeycon</code></td>
-<td>The <code>ibpkeycon</code> keyword.</td>
-</tr>
-<tr>
-<td><code>subnet</code></td>
-<td>IP address in IPv6 format.</td>
-</tr>
-<tr>
-<td><code>pkey</code></td>
-<td>Partition key number or range. The range is separated by a hyphen '-'.</td>
-</tr>
-<tr>
-<td><code>pkey_context</code></td>
-<td>The security context for the pkey(s).</td>
-</tr>
-</tbody>
-</table>
+*ibpkeycon*
+
+The *ibpkeycon* keyword.
+
+*subnet*
+
+IP address in IPv6 format.
+
+*pkey*
+
+Partition key number or range. The range is separated by a hyphen \'\-\'.
+
+*pkey_context*
+
+The security context for the pkey(s).
 
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
-<td>No</td>
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
+| No                      | No                      | No                      |
 
 **Examples:**
 
@@ -86,8 +71,8 @@ semanage ibpkey -a -t default_ibpkey_t -x fe80:: 0xFFFF
 ```
 
 The above command will produce the following file:
-*/var/lib/selinux/&lt;SELINUXTYPE&gt;/active/ibpkeys.local*
-in the default *<SELINUXTYPE>* policy store and then activate the policy:
+*/var/lib/selinux/\<SELINUXTYPE\>/active/ibpkeys.local*
+in the default *\<SELINUXTYPE\>* policy store and then activate the policy:
 
 ```
 # This file is auto-generated by libsemanage
@@ -101,7 +86,7 @@ ibpkeycon fe80:: 0xFFFF system_u:object_r:default_ibpkey_t:s0
 The *ibendportcon* statement is used to label IB end ports.
 
 It is also possible to add a security context to ports outside the
-policy using the 'semanage ibendport' command that will associate the
+policy using the *semanage ibendport* command that will associate the
 end port to a security context.
 
 **The statement definition is:**
@@ -112,53 +97,35 @@ ibendportcon device_id port_number port_context
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>ibendportcon</code></td>
-<td>The <code>ibendportcon</code> keyword.</td>
-</tr>
-<tr>
-<td><code>device_id</code></td>
-<td>Device name</td>
-</tr>
-<tr>
-<td><code>port_number</code></td>
-<td>Single port number.</td>
-</tr>
-<tr>
-<td><code>port_context</code></td>
-<td>The security context for the port.</td>
-</tr>
-</tbody>
-</table>
+*ibendportcon*
+
+The *ibendportcon* keyword.
+
+*device_id*
+
+Device name
+
+*port_number*
+
+Single port number.
+
+*port_context*
+
+The security context for the port.
 
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
-<td>No</td>
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
+| No                      | No                      | No                      |
 
 **Examples:**
 
@@ -174,8 +141,8 @@ semanage ibendport -a -t opensm_ibendport_t -z mlx4_0 2
 ```
 
 This command will produce the following file
-*/var/lib/selinux/&lt;SELINUXTYPE&gt;/active/ibendports.local* in the default
-*<SELINUXTYPE>* policy store and then activate the policy:
+*/var/lib/selinux/\<SELINUXTYPE\>/active/ibendports.local* in the default
+*\<SELINUXTYPE\>* policy store and then activate the policy:
 
 ```
 # This file is auto-generated by libsemanage
-- 
2.26.2


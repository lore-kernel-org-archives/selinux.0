Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53BCC433E5
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B8C920706
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="hKqVTSmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgHYIiZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:38:25 -0400
Received: from mailomta31-sa.btinternet.com ([213.120.69.37]:46271 "EHLO
        sa-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728975AbgHYIiR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 04:38:17 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20200825083813.GKOM3440.sa-prd-fep-044.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 25 Aug 2020 09:38:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598344693; 
        bh=6O1rdI9AbGRZpTFs7nv0iB+4xDi2UYizI4rae+4FTZk=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=hKqVTSmbvH5zVhRagIENPlGK/c6WjMXa0iCVsCrKlNqtjqE062hg3RT3hTTgyB8sh7p+ccadxf/l1a7JWyI+SUY2Wzc5t7G2SDvwvUZbKO73i68DpNFr5RGcgeXO3nCYjcyDfqaCMFyXdZxPNsLm0cD4DmvK6YDw9DBfUA9244aeSrnHQI+Hs4TZRrQZggmTd7d647OvXLCruNnlR5/UEMCjRAP4WjGfd42dHtlsA224KBzyP19vhkddMB2pPPQnv31NF+PyVbX93CJwK7H+dKrZkhidfS5uKtSVhe5DPyQmnixMsvscjDzDxEnBf5ggN15O0Ixw43eJDnH/n7khBQ==
Authentication-Results: btinternet.com; none
X-Originating-IP: [109.155.130.160]
X-OWM-Source-IP: 109.155.130.160 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepuddtledrudehhedrudeftddrudeitdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehhedrudeftddrudeitddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.130.160) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B8A70D599E5F; Tue, 25 Aug 2020 09:38:12 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 15/18] file_labeling_statements: Convert to markdown
Date:   Tue, 25 Aug 2020 09:37:40 +0100
Message-Id: <20200825083743.6508-16-richard_c_haines@btinternet.com>
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
 src/file_labeling_statements.md | 260 ++++++++++++--------------------
 1 file changed, 96 insertions(+), 164 deletions(-)

diff --git a/src/file_labeling_statements.md b/src/file_labeling_statements.md
index 34c2ca8..47d0309 100644
--- a/src/file_labeling_statements.md
+++ b/src/file_labeling_statements.md
@@ -1,5 +1,10 @@
 # File System Labeling Statements
 
+- [*fs_use_xattr*](#fs_use_xattr)
+- [*fs_use_task*](#fs_use_task)
+- [*fs_use_trans*](#fs_use_trans)
+- [*genfscon*](#genfscon)
+
 There are four types of file labeling statements: *fs_use_xattr*,
 *fs_use_task*, *fs_use_trans* and *genfscon* that are explained below.
 
@@ -30,49 +35,33 @@ fs_use_xattr fs_name fs_context;
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>fs_use_xattr</code></td>
-<td>The <code>fs_use_xattr</code> keyword.</td>
-</tr>
-<tr>
-<td><code>fs_name</code></td>
-<td>The filesystem name that supports extended attributes. Example names are: encfs, ext2, ext3, ext4, ext4dev, gfs, gfs2, jffs2, jfs, lustre and xfs.</td>
-</tr>
-<tr>
-<td><code>fs_context</code></td>
-<td>The security context allocated to the filesystem.</td>
-</tr>
-</tbody>
-</table>
+*fs_use_xattr*
+
+The *fs_use_xattr* keyword.
+
+*fs_name*
+
+The filesystem name that supports extended attributes. Example names are:
+*encfs*, *ext2*, *ext3*, *ext4*, *ext4dev*, *gfs*, *gfs2*, *jffs2*, *jfs*,
+*lustre* and *xfs*.
+
+*fs_context*
+
+The security context allocated to the filesystem.
 
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
 
@@ -99,49 +88,30 @@ fs_use_task fs_name fs_context;
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>fs_use_task</code></td>
-<td>The <code>fs_use_task</code> keyword.</td>
-</tr>
-<tr>
-<td><code>fs_name</code></td>
-<td>Filesystem name that supports task related services. Example valid names are: eventpollfs, pipefs and sockfs.</td>
-</tr>
-<tr>
-<td><code>fs_context</code></td>
-<td>The security context allocated to the task based filesystem.</td>
-</tr>
-</tbody>
-</table>
+*fs_use_task*
+
+The *fs_use_task* keyword.
+
+*fs_name*
+
+Filesystem name that supports task related services. Example valid names are:
+*eventpollfs*, *pipefs* and *sockfs*.
+
+*fs_context*
+
+The security context allocated to the task based filesystem.
 
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
 
@@ -171,49 +141,30 @@ fs_use_trans fs_name fs_context;
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>fs_use_trans</code></td>
-<td>The <code>fs_use_trans</code> keyword.</td>
-</tr>
-<tr>
-<td><code>fs_name</code></td>
-<td>Filesystem name that supports transition rules. Example names are: mqueue, shm, tmpfs and devpts.</td>
-</tr>
-<tr>
-<td><code>fs_context</code></td>
-<td>The security context allocated to the transition based on that of the filesystem.</td>
-</tr>
-</tbody>
-</table>
+*fs_use_trans*
+
+The *fs_use_trans* keyword.
+
+*fs_name*
+
+Filesystem name that supports transition rules. Example names are:
+*mqueue*, *shm*, *tmpfs* and *devpts*.
+
+*fs_context*
+
+The security context allocated to the transition based on that of the filesystem.
 
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
 
@@ -247,53 +198,34 @@ genfscon fs_name partial_path fs_context
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>genfscon</code></td>
-<td>The <code>genfscon</code> keyword.</td>
-</tr>
-<tr>
-<td><code>fs_name</code></td>
-<td>The filesystem name.</td>
-</tr>
-<tr>
-<td><code>partial_path</code></td>
-<td>If <code>fs_name</code> is <code>proc</code>, then the partial path (see the examples). For all other types, this must be <code>/</code>.</td>
-</tr>
-<tr>
-<td><code>fs_context</code></td>
-<td>The security context allocated to the filesystem</td>
-</tr>
-</tbody>
-</table>
+*genfscon*
+
+The *genfscon* keyword.
+
+*fs_name*
+
+The filesystem name.
+
+*partial_path*
+
+If *fs_name* is *proc*, then the partial path (see the examples). For all other
+types, this must be */*.
+
+*fs_context*
+
+The security context allocated to the filesystem
 
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
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | No                      |
+
+Conditional Policy Statements
+
+| *if* Statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | No                      | No                      |
 
 **MLS Examples:**
 
-- 
2.26.2


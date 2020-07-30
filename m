Return-Path: <SRS0=qcS5=BJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95725C433DF
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 08:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134112075F
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 08:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="j+Yk/lia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgG3I4P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgG3I4P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jul 2020 04:56:15 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A8AAC061794
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2020 01:56:14 -0700 (PDT)
Received: from localhost.localdomain (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id A28D62A0FFC;
        Thu, 30 Jul 2020 10:56:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl A28D62A0FFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1596099369;
        bh=JlTF8t7ETMrSvBFaGt4wPASJh15rnO6RH0QTCeHGwcQ=;
        h=From:To:Cc:Subject:Date:From;
        b=j+Yk/liaLRhfgjHmRSS3ouYr5JHRX1HyxERvWvGFhV01yTQ8SM3nd+z+HeKp9pUaW
         NULFybAi/du7b6jYst4iIZapCqm75yLe7hfg0MSu8efD9FFqeX9/SB3b9MP3YwrEXG
         2Majxmcz5fNvTOSCYwqZQ1jQcT8k8A1jkrLMbYnc=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [SELinux-notebook PATCH] type_statements: document expandattribute
Date:   Thu, 30 Jul 2020 10:55:42 +0200
Message-Id: <20200730085542.895297-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.28.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This functionality was added for Androids Treble in 2017.

I was not sure whether this belong here or in conditional_statements.md

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
 src/type_statements.md | 70 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/src/type_statements.md b/src/type_statements.md
index 61c7191..8bea485 100644
--- a/src/type_statements.md
+++ b/src/type_statements.md
@@ -201,6 +201,76 @@ attribute non_security_file_type;
 
 <br>
 
+## `expandattribute`
+
+The `expandattribute` statement allows type attribute expansion
+compiler defaults to be overriden.
+
+**The statement definition is:**
+
+`expandattribute attribute_id default_value;`
+
+**Where:**
+
+<table>
+<tbody>
+<tr>
+<td><code>expandattribute</code></td>
+<td>The <code>expandattribute</code> keyword.</td>
+</tr>
+<tr>
+<td><code>attribute_id</code></td>
+<td>One or more previously declared <code>attribute</code>. Multiple entries consist of a space separated list enclosed in braces '{}'.</td>
+</tr>
+<tr>
+<td><code>default_value</code></td>
+<td>Either true or false</td>
+</tr>
+</tbody>
+</table>
+
+**The statement is valid in:**
+
+<table style="text-align:center">
+<tbody>
+<tr style="background-color:#D3D3D3;">
+<td><strong>Monolithic Policy</strong></td>
+<td><strong>Base Policy</strong></td>
+<td><strong>Module Policy</strong></td>
+</tr>
+<tr>
+<td>Yes</td>
+<td>Yes</td>
+<td>Yes</td>
+</tr>
+<tr style="background-color:#D3D3D3;">
+<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
+<td><strong><code>optional</code> Statement</strong></td>
+<td><strong><code>require</code> Statement</strong></td>
+</tr>
+<tr>
+<td>No</td>
+<td>Yes</td>
+<td>No</td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+```
+# Using the expandtypeattribute statement to forcibly expand a
+# previously declared domain attribute.
+
+# The previously declared attribute:
+attribute domain;
+
+# The attribute stripping using the expandtypeattribute statement:
+expandattribute domain true;
+```
+
+<br>
+
 ## `typeattribute`
 
 The `typeattribute` statement allows the association of previously
-- 
2.28.0.rc1


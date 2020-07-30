Return-Path: <SRS0=qcS5=BJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B56C433E0
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 09:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D0F20809
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 09:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="lT5NhXXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgG3Jbl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgG3Jbk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jul 2020 05:31:40 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EB1AC061794
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2020 02:31:40 -0700 (PDT)
Received: from localhost.localdomain (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id F0DA02A1010;
        Thu, 30 Jul 2020 11:31:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl F0DA02A1010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1596101499;
        bh=F/VD5C7d9i4lYDcd8TxazOFAgtLqKDTOaoAERK3J2nI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lT5NhXXm3MPbtGK1sBsK0cqK/ZIfVij4DywBv5gcCrSh7yOwhOehWKrLJYA9mkA+t
         9Z82wqPPsCnJSO3QhYIoJHq/W2gsymUCh7DfGZ7KhF0Pi5HSBwpuEn0n8FM0gRlCXo
         5OQuRRdAXU40BdpX3rL2V5RtiWuVtZcX4Y3j9V1Y=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [SELinux-notebook PATCH v2] type_statements: document expandattribute
Date:   Thu, 30 Jul 2020 11:31:25 +0200
Message-Id: <20200730093125.896974-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.28.0.rc1
In-Reply-To: <20200730085542.895297-1-dominick.grift@defensec.nl>
References: <20200730085542.895297-1-dominick.grift@defensec.nl>
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
v2: change expandtypeattribute to expandattribute

 src/type_statements.md | 70 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/src/type_statements.md b/src/type_statements.md
index 61c7191..1ca655d 100644
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
+# Using the expandattribute statement to forcibly expand a
+# previously declared domain attribute.
+
+# The previously declared attribute:
+attribute domain;
+
+# The attribute stripping using the expandattribute statement:
+expandattribute domain true;
+```
+
+<br>
+
 ## `typeattribute`
 
 The `typeattribute` statement allows the association of previously
-- 
2.28.0.rc1


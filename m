Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C5AC433F5
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 14:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E394B610A2
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 14:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhKJOuZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Nov 2021 09:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbhKJOuY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Nov 2021 09:50:24 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC54DC061764
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 06:47:36 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id v4so2281488qtw.8
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 06:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DD1SLL+U7omDa6qoOCacruhsKXLvRDg1jWHmYLp2aL8=;
        b=o9XUUBO5nxzi44FPr0ki8y9VpEdXg+m0ZSnR9xy3Fe7yEXv2Vfi5hnL1IvCoYM3l1s
         6u2mYO3qvbXc2NlRkoTynhF+GU2UVDGdkEQCn9DBKvyAD3tzWfJIcCNhIGxDDIWNKE7P
         G6sO2hRi+GGfdmhESwa7N0eLvZP/4Q+TOySL8YgDEfPIP4M5tiCQEoYaNPKOdqjN653t
         /E9Wh8S2B1n1JTeO6LfJKAU5p+W0bF9EFELgIR/vc+E+lWDDHMB/31JAqKmmhPwhCvsR
         D/inu9bobY5fv5oUSr9ZPB0yvq+fOUFw9LxCu/g2y+MdHwJXepe4y4XuTxZ5AJxfYP14
         rDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DD1SLL+U7omDa6qoOCacruhsKXLvRDg1jWHmYLp2aL8=;
        b=KIVkvRngBXuLIrV0oTSH6Z8iLBypDk9jA1paWbJ+oPoyUs4c1IIc6rw4dZQy/zTZdc
         tUJIG5UjvHthB4IaC3SmOwrAdYgSp740XdHVqdDjActcO8Py2iWl7ynm19HNrrSuxzdu
         mvdtpv1gXHRxXdDR5hL0ERyJste8HRs20ycZ5KYBYLMrbhx4NPdFtuR94sb+5qCtxDD1
         cyxWVzIFtDRPu5wdVTUmBVQt6m2/RvIENEx6dT+FjIAj7ZsWy1J5GUjUbfRLZL7xN7ya
         J7LbvBuq5OjaRtmUU+/J2VQthDW7Ow20SHNR2KdrPCXSWtMic07ejHr7AgrTFJeWUVNY
         Fh4A==
X-Gm-Message-State: AOAM531YOm6rpgskQ4khk511R7Q5bjdmXTkcfEy0OsnQG+ge8rfn+efp
        9gUXtr1z4SRhehnwKo+V81FiDmr/YQc=
X-Google-Smtp-Source: ABdhPJzLX+RwzpO+okFMdfz33G0mvc/1taavxZx4HoQ9mIsSK5gQ3JniU2WIz0yW/6WgxZQ06ZOIgQ==
X-Received: by 2002:ac8:58d1:: with SMTP id u17mr118516qta.137.1636555655746;
        Wed, 10 Nov 2021 06:47:35 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id r10sm58633qta.27.2021.11.10.06.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 06:47:35 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, stephen.smalley.work@gmail.com,
        James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/5 v2] secilc/docs: Document the optional file type for genfscon rules
Date:   Wed, 10 Nov 2021 09:47:26 -0500
Message-Id: <20211110144727.1467744-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110144727.1467744-1-jwcart2@gmail.com>
References: <20211110144727.1467744-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Update the CIL documentation to include the optional file type for
genfscon rules.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: No changes

 secilc/docs/cil_file_labeling_statements.md | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/secilc/docs/cil_file_labeling_statements.md b/secilc/docs/cil_file_labeling_statements.md
index ed7b7bf9..73f73885 100644
--- a/secilc/docs/cil_file_labeling_statements.md
+++ b/secilc/docs/cil_file_labeling_statements.md
@@ -36,11 +36,13 @@ Define entries for labeling files. The compiler will produce these entries in a
 <col width="44%" />
 <col width="55%" />
 </colgroup>
-<tbody>
+<thead>
 <tr class="odd">
 <td align="left"><p><strong>keyword</strong></p></td>
 <td align="left"><p><strong>file_contexts entry</strong></p></td>
 </tr>
+</thead>
+<tbody>
 <tr class="even">
 <td align="left"><p><code>file</code></p></td>
 <td align="left"><p><code>--</code></p></td>
@@ -185,7 +187,7 @@ Used to allocate a security context to filesystems that cannot support any of th
 **Statement definition:**
 
 ```secil
-    (genfscon fsname path context_id)
+    (genfscon fsname path [file_type] context_id)
 ```
 
 **Where:**
@@ -209,6 +211,10 @@ Used to allocate a security context to filesystems that cannot support any of th
 <td align="left"><p>If <code>fsname</code> is <code>proc</code>, then the partial path (see examples). For all other types this must be ‘<code>/</code>’.</p></td>
 </tr>
 <tr class="even">
+<td align="left"><p><code>file_type</code></p></td>
+<td align="left"><p>Optional keyword representing a file type. Valid values are the same as in [`filecon`](cil_file_labeling_statements.md#filecon) rules.</p></td>
+</tr>
+<tr class="odd">
 <td align="left"><p><code>context_id</code></p></td>
 <td align="left"><p>A previously declared <code>context</code> identifier or an anonymous security context (<code>user role type levelrange</code>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</p></td>
 </tr>
-- 
2.31.1


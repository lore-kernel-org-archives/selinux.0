Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9973C10F1E
	for <selinux@archiver.kernel.org>; Thu, 15 Dec 2022 21:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLOVes (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Dec 2022 16:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiLOVeq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Dec 2022 16:34:46 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B14B1E3D8
        for <selinux@vger.kernel.org>; Thu, 15 Dec 2022 13:34:45 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 186so319987ybe.8
        for <selinux@vger.kernel.org>; Thu, 15 Dec 2022 13:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8qB1CPKsP53+qhuipWgaZJi+ttYg5AGjCd4plxN8D0=;
        b=BcJjf72SBByW7ZpBJPSYsp4RmwMaKRmhCi3Y1wiyr7+wDO35+hNNlEcX95BUVxMo1s
         yJXAEsh51hH8o1jDlU89BcOLJHb2ABZueZq97MwPdyVNgIuEjn3ELGo1IynND4iSJ9w2
         l9EZYbRrv0NUZJ0fyFjnRaU3+/aoufPrjP8Hapnnf266ZLGfeAxHOidpw1REPxPSCoT2
         8iuINHUysewleWGUBc4LYn/VkVBf8Z7v+GOjGLsZyiStrTqjiOMmtPlU14Bw8SFTSj6u
         paXF0tVIFJJn9DtCSwv0ugi7HzJ+gm9AjOW9r9ae0rNJMDsKVeCwkiUqyiCH/7bDDeA1
         8JnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8qB1CPKsP53+qhuipWgaZJi+ttYg5AGjCd4plxN8D0=;
        b=5rHc8eVsMjRgqWpQ352JXmf5fXdJqt3VRBhnz3eRWGbyLY/z9YaPpTskag2WJRvMUU
         5nb5zilwnivlNTG7e/I70QlhFR/+u+B99zu4KXP7BGztsgu7LcNToA2NFzJVJicj/j/n
         22YJdZYMYya1K7v/HCrlQ7Q8U/fOrxdfukBEi38qOEdC1xaXLAv8OsVSeainZgP6r0tf
         efKkoxJNlquIcQlzgGuIvlzX3X3Osm84b/PSiHsMbB3C9Dy7tGEtWZuCpf4ciQk2dsC5
         tk/Ba8svS5PqOaERT4jum1V9NCFCZbkYkwqS84GDZra+MQh9idRadTkDzZ+D9QaUlaXD
         YLKg==
X-Gm-Message-State: ANoB5pn+8hmJoq0vbadcVIMR+4KnMTtQewp8NQdGg6rYE7g7wcSz/x7Q
        YlndNFqxl7tYCrfhil2SvnPf3KdfWwc=
X-Google-Smtp-Source: AA0mqf5a2R/29AOcGpZXsP8FVp2ab+72rasipnGuqSADK+Ey9uJ75gS8VC7e/7LsATT0XpULsHzazg==
X-Received: by 2002:a25:d911:0:b0:6fb:a7f8:8b55 with SMTP id q17-20020a25d911000000b006fba7f88b55mr25282031ybg.38.1671140084508;
        Thu, 15 Dec 2022 13:34:44 -0800 (PST)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a424a00b006a6ebde4799sm21066qko.90.2022.12.15.13.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 13:34:43 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 9/9] secilc/docs: Add deny rule to CIL documentation
Date:   Thu, 15 Dec 2022 16:34:29 -0500
Message-Id: <20221215213429.998948-10-jwcart2@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215213429.998948-1-jwcart2@gmail.com>
References: <20221215213429.998948-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/docs/cil_access_vector_rules.md | 68 ++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/secilc/docs/cil_access_vector_rules.md b/secilc/docs/cil_access_vector_rules.md
index f0ba4a90..35825283 100644
--- a/secilc/docs/cil_access_vector_rules.md
+++ b/secilc/docs/cil_access_vector_rules.md
@@ -247,6 +247,74 @@ This example will not compile as `type_3` is not allowed to be a source type for
         (allow type_3 self (property_service (set)))
     )
 ```
+deny
+----------
+
+Remove the access rights defined from any matching allow rules. These rules are processed before [`neverallow`](cil_access_vector_rules.md#neverallow) checking.
+
+**Rule definition:**
+
+```secil
+    (deny source_id target_id|self classpermissionset_id ...)
+```
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="27%" />
+<col width="72%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>deny</code></p></td>
+<td align="left"><p>The <code>deny</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>source_id</code></p></td>
+<td align="left"><p>A single previously defined source <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>target_id</code></p></td>
+<td align="left"><p>A single previously defined target <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p>
+<p>The <code>self</code> keyword may be used instead to signify that source and target are the same.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>classpermissionset_id</code></p></td>
+<td align="left"><p>A single named or anonymous <code>classpermissionset</code> or a single set of <code>classmap</code>/<code>classmapping</code> identifiers.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+```secil
+    (class class1 (perm1 perm2))
+
+	(type type_1)
+    (type type_2)
+	(allow type_1 type_2 (class1 (perm1))) ; Allow_1
+	(deny type_1 type_2 (class1 (perm1)))  ; Deny_1
+  	; Allow_1 will be complete removed by Deny_1.
+
+    (type type_3)
+	(type type_4)
+	(allow type_3 type_4 (class1 (perm1 perm2))) ; Allow_2
+	(deny type_3 type_4 (class1 (perm1)))        ; Deny_2
+	; Allow_2 will be removed and replaced with the following when Deny_2 is evaluated
+    ; (allow type_3 type_4 (class1 (perm2)))
+
+	(type type_5)
+	(type type_6)
+	(typeattribute attr_1)
+	(typeattributeset attr_1 (type_5 type_6))
+	(allow attr_1 attr_1 (class1 (perm1))) ; Allow_3
+	(deny type_5 type_6 (class1 (perm1)))  ; Deny_3
+	; Allow_3 will be removed and replaced with the following when Deny_3 is evaluated
+	; (allow type_6 attr_1 (class1 (perm1)))
+	; (allow attr_1 type_5 (class1 (perm1)))
+    )
+```
 
 allowx
 ------
-- 
2.38.1


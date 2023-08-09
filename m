Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F132C001DE
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 21:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjHIVCM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjHIVCL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 17:02:11 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E491BFA
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 14:02:10 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-76d1dc1ebfdso67169285a.0
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 14:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691614929; x=1692219729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4fvQ0wDzinPwZVRxwER+KXwY/zK6KJbBSwnhZnsOME=;
        b=XjTYgHbHBe9u6i5d50nUNt13gZ0XtBJGlzx9AM+EVSZU6n4aax+bUbDPpQtlZ4f2ms
         MkTesbBitnZ5/KYyKMD25vB/ck/MUJxVGutc7FucQVE9/yGDs2Wnk1Mog1hhGWrtIQnZ
         GGrdKByTNR1odOmZ1p3QM69yejpOn18SGBZuwAAaTQbB01VOsxlYi6XSIMv96XOD/saK
         +qKgcW8mJEzbxtCBhBAy9/ayaIhhalEjCAqya/xKyd0ZWGJwLgYqcX4ogZ8RwK3E/FQg
         Fmr8H6L/yRLfAiQ5pvX51nt8uYfG+m66H07+9pT1zsp1DSJVnJLTMStTuQ86D7Y8Uc1O
         9HnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691614929; x=1692219729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4fvQ0wDzinPwZVRxwER+KXwY/zK6KJbBSwnhZnsOME=;
        b=JH504w79TYS4wcYjBE2SZaG6ep2rQ+KKSDr+/lbYLHYbBCgz5gswUZte0+JMYt7tyg
         8AIEWD35O659qHm1CE/LUmHdfokHDlZHqS76r+DtpdoNGfx79FJCdhLi92DYxbJCid8Z
         xtGxOchNQDFfEIQa9gcHuJz3yRRjzBr4X1dukMjUjG66ZCSXQe6Azo939Mg/waY5AWRT
         sUsh+GmjSBm8pJKi+13rxgRYf6qh5VPGFjbfeDgEtSC61vNFqgKxZHl1Dcpc/mFj6F7Z
         6qjbb6GrdqX9QVV6jFfJtT5rMDZnJ8GhaALOTLIby6+ZwBRzoiLAMqst7BH6Jws3ohZy
         N40A==
X-Gm-Message-State: AOJu0YwHUKkwZ+wuAelTAZhFI8eaEhQ7uZSaCaZr0+yd8xLKJosJa9bn
        PLcG/EAxPdSHPpRbNpeQ6KhOAbvZS7o=
X-Google-Smtp-Source: AGHT+IEI20kxT4guZUtTZEKCG4z4m409Cw2NFcOMFDFbq+wPiM8xniotXPAFHFGctjTVstWi+X8QAg==
X-Received: by 2002:a05:620a:1926:b0:75b:23a1:d8d8 with SMTP id bj38-20020a05620a192600b0075b23a1d8d8mr58254qkb.28.1691614929551;
        Wed, 09 Aug 2023 14:02:09 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id h20-20020a05620a10b400b00766fbeb3e7csm4208287qkk.132.2023.08.09.14.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:02:09 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 9/9 v4] secilc/docs: Add deny rule to CIL documentation
Date:   Wed,  9 Aug 2023 17:01:57 -0400
Message-ID: <20230809210157.112275-10-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809210157.112275-1-jwcart2@gmail.com>
References: <20230809210157.112275-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v4: Remove the "*Where" section, since the notself patch series moves all
    of that to beginning of the access vector section before talking about
    specific rules.

 secilc/docs/cil_access_vector_rules.md | 41 +++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/secilc/docs/cil_access_vector_rules.md b/secilc/docs/cil_access_vector_rules.md
index 034185da..47da60fc 100644
--- a/secilc/docs/cil_access_vector_rules.md
+++ b/secilc/docs/cil_access_vector_rules.md
@@ -19,7 +19,7 @@ Rules involving a source type, a target type, and class permissions or extended
 <tbody>
 <tr class="odd">
 <td align="left"><p><code>av_flavor</code></p></td>
-<td align="left"><p>The flavor of access vector rule. Possible flavors are <code>allow</code>, <code>auditallow</code>, <code>dontaudit</code>, <code>neverallow</code>, <code>allowx</code>, <code>auditallowx</code>, <code>dontauditx</code>, <code>neverallowx</code>.</p></td>
+<td align="left"><p>The flavor of access vector rule. Possible flavors are <code>allow</code>, <code>auditallow</code>, <code>dontaudit</code>, <code>neverallow</code>, <code>deny</code>, <code>allowx</code>, <code>auditallowx</code>, <code>dontauditx</code>, and <code>neverallowx</code>.</p></td>
 <tr class="even">
 <td align="left"><p><code>source_id</code></p></td>
 <td align="left"><p>A single previously defined source <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
@@ -175,6 +175,45 @@ This example will not compile as `type_3` is not allowed to be a source type for
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
+**Example:**
+
+```secil
+    (class class1 (perm1 perm2))
+
+    (type type1)
+    (type type2)
+    (allow type1 type2 (class1 (perm1))) ; Allow-1
+    (deny type1 type2 (class1 (perm1)))  ; Deny-1
+    ; Allow-1 will be complete removed by Deny-1.
+
+    (type type3)
+    (type type4)
+    (allow type3 type4 (class1 (perm1 perm2))) ; Allow-2
+    (deny type3 type4 (class1 (perm1)))        ; Deny-2
+    ; Allow-2 will be removed and replaced with the following when Deny-2 is evaluated
+    ; (allow type3 type4 (class1 (perm2)))
+
+    (type type5)
+    (type type6)
+    (typeattribute attr1)
+    (typeattributeset attr1 (type5 type6))
+    (allow attr1 attr1 (class1 (perm1))) ; Allow-3
+    (deny type5 type6 (class1 (perm1)))  ; Deny-3
+    ; Allow-3 will be removed and replaced with the following when Deny-3 is evaluated
+    ; (allow type6 attr1 (class1 (perm1)))
+    ; (allow type5 type5 (class1 (perm1)))
+```
 
 allowx
 ------
-- 
2.41.0


Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA02C61DA4
	for <selinux@archiver.kernel.org>; Thu,  9 Mar 2023 21:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjCIVvh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Mar 2023 16:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjCIVv2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Mar 2023 16:51:28 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3AAFCF13
        for <selinux@vger.kernel.org>; Thu,  9 Mar 2023 13:51:26 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c18so3736424qte.5
        for <selinux@vger.kernel.org>; Thu, 09 Mar 2023 13:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678398685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Quyxxn1+0BncBOULA0rfDOofn2rc0PVFBDwEtBZu0bI=;
        b=EELaTjXQH+MZ1/bcY8IX+5XtX4uIY/3ZINxV4Aj99MME9kofZRsBAhPqI1tUFCe3Xp
         h84eSp/sEFMBPMZ015Bffo9obhyrcbmsB+lPkcwygxB6g8YP7hmpoJB03SqYHtZTynqp
         lT/uNrPRNN14ssctNhrptVce/Hh7e4LYHC5n6IRztexjFKAFlybxahBrzH0ooo/Jv34M
         Bd9eFlNqAkCFFPTQDkuC6bJ86S/h3HpyPXBmVbPthoBNiA/ZAnyziMaBqQJjjN3/fKWy
         sUFtaOrN83hTrYxoA93ptU1Sr489nt1LH/2ecDmJPgReItrRl/gdm87LwFZJEeqgmfWk
         iGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678398685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Quyxxn1+0BncBOULA0rfDOofn2rc0PVFBDwEtBZu0bI=;
        b=d8OqPS4MDnYk1xDAFwl1iGJz2otJTQW15EOB+F91VlIsu++opBySgYIZKYEMOtJDB7
         vuxzKuN/H2KHKbp1cZ5LAzQQTccSW1hwyRChV2+XNIq4+GtTMZbkJLwJTGcWcTBxj4M4
         ODmNMdNCLQlrEKyh/zyNW2VSrmz55i7uANxfZ9wb/VIbFnQ3ALE+nsAhrmUCqs+57+qM
         Cvj0ldYc+4qishuSRfEHT6CnMre4xEqomINQhDz3hSmKQPa9y3XOGrXUwG8r1UIfelSa
         01sWq/KgJPPWS/92aj7FOmv8N2LccdWkFSA4zW8CqH+WvzrxmMPicCe4KXWuXH72d+cJ
         N3Bg==
X-Gm-Message-State: AO0yUKV7+09HlDd4V+quvZf473ZyCmXVS10PCIAA+suZeidTMesDMSVF
        D3F2/0IXDPlWiBYsO2YeVqdzPTv/1tU=
X-Google-Smtp-Source: AK7set9NJBSUBv87iXnB4Fd3Sy8SmIUVUM5PA+W6pwDpEi1m3chVtvCiGkcLujq5vxxLKKoBNt9Ptw==
X-Received: by 2002:a05:622a:1aa4:b0:3bf:c69c:e31c with SMTP id s36-20020a05622a1aa400b003bfc69ce31cmr8157722qtc.13.1678398685400;
        Thu, 09 Mar 2023 13:51:25 -0800 (PST)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id m17-20020ae9e011000000b007422fa6376bsm25731qkk.77.2023.03.09.13.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 13:51:25 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 9/9 v2] secilc/docs: Add deny rule to CIL documentation
Date:   Thu,  9 Mar 2023 16:51:14 -0500
Message-Id: <20230309215114.357831-10-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309215114.357831-1-jwcart2@gmail.com>
References: <20230309215114.357831-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2:
Fixed the formating problems in the CIL documenation of the deny rule
    that was found by Daniel Burgener.

 secilc/docs/cil_access_vector_rules.md | 67 ++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/secilc/docs/cil_access_vector_rules.md b/secilc/docs/cil_access_vector_rules.md
index f0ba4a90..345f54e1 100644
--- a/secilc/docs/cil_access_vector_rules.md
+++ b/secilc/docs/cil_access_vector_rules.md
@@ -247,6 +247,73 @@ This example will not compile as `type_3` is not allowed to be a source type for
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
2.39.2


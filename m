Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B62C77B6E
	for <selinux@archiver.kernel.org>; Thu, 13 Apr 2023 19:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjDMTe7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Apr 2023 15:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjDMTe6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Apr 2023 15:34:58 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE5D6592
        for <selinux@vger.kernel.org>; Thu, 13 Apr 2023 12:34:56 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54bfa5e698eso456109647b3.13
        for <selinux@vger.kernel.org>; Thu, 13 Apr 2023 12:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681414496; x=1684006496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPYmd0AVAvyO35FFhEBNkB5Kg2hiu8cwglfHJh7btFQ=;
        b=JiT4cepSTvXtUD2NG+u+L8c07b+qPiScbO5FAFJDjF5n7FHPwSPcJakq8ZaxbetWDy
         abdnT6r03bHnCWvj5WyS9ODZwzR1aitozqrLrCnhRdmYEDUTfg9ro+vDnEJN68AAsPZX
         lun/Ub/LL4RzsXF2JwsiKomM7AOagbmIC7j3DYC1xY1VrWbMY/MeXrTRNLBJyvd2zOSF
         8oqwD80Pv6JGhjcLHHOutMglzApZRvkxkJR2LCSNesvbvxDnaleZIvQHLeKAVdQOZOid
         f2iod8FW+stZGgE5115RWc9/eKVvisEyjOst9vl0F3qwKiyY60C4RvHTADplkWt43Nh6
         S/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681414496; x=1684006496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPYmd0AVAvyO35FFhEBNkB5Kg2hiu8cwglfHJh7btFQ=;
        b=aFEeSEqOWzmb3SLOPgPcxD0KKH13la214+1ftuiSpfpqpfoTFSvjbmGQWAF2G674Im
         lDFOCwib4t52gBVyRDx8xiZ+Y6W82u/iAuCO8ADvNjIln6LAdkIwlTVEOtsUMuOf08VZ
         cK/fDVXcWxHBck9i+yoipIaCmaBFkfLNu94Ki5CNZYNVo2zmbUM80t9m6GbKxwwvb0QZ
         +45hbbIsfBHfxgUbLBbwUzgz9O20y2NOmuLE7D294NcxrHOesmtqUphm82BzpjVxAEak
         VBicemr4G3g1s9KnBkOR5AEvCmLLcZ9N2owpgQ2AZ/Q/iMnGR6KewQsEs9z6TZsFDQlD
         FS8A==
X-Gm-Message-State: AAQBX9dUIwy81VfJSals4eaXUIla2iYC2NNErqqRWPPindZrDgNdK/Xq
        ExFW1QPSgXNdmxcyrFefPpPZU9hr1xA=
X-Google-Smtp-Source: AKy350akvYtr6h3scxpbiL8AMkZZUvs0RxIE7QXNzvENvyAvMNvw670PDtTr3f6LK5B9GrJWuydbFw==
X-Received: by 2002:a81:83cd:0:b0:54f:9e41:df5a with SMTP id t196-20020a8183cd000000b0054f9e41df5amr2933098ywf.15.1681414495864;
        Thu, 13 Apr 2023 12:34:55 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id 21-20020a811615000000b0054c0f46b24bsm691350yww.5.2023.04.13.12.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 12:34:55 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 9/9 v3] secilc/docs: Add deny rule to CIL documentation
Date:   Thu, 13 Apr 2023 15:34:45 -0400
Message-Id: <20230413193445.588395-10-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413193445.588395-1-jwcart2@gmail.com>
References: <20230413193445.588395-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v3: Remove the "*Where" section, since the notself patch series moves all of
    that to beginning of the access vector section before talking about specific
    rules.

 secilc/docs/cil_access_vector_rules.md | 67 ++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/secilc/docs/cil_access_vector_rules.md b/secilc/docs/cil_access_vector_rules.md
index 034185da..385c4f4a 100644
--- a/secilc/docs/cil_access_vector_rules.md
+++ b/secilc/docs/cil_access_vector_rules.md
@@ -175,6 +175,73 @@ This example will not compile as `type_3` is not allowed to be a source type for
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


Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E6CC001E0
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 20:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjHIUkz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjHIUky (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 16:40:54 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F69A6
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 13:40:54 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40fd276621aso896661cf.2
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 13:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691613653; x=1692218453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnwXnT2ge/xc5k9DCBeERNeMibBFIofcb6WJ4vCZxQA=;
        b=SLYCSi+niUZaDtIFTq+DyUPCcmpsAY0BUj6LR9/f1TBD+5hmOLU2xzgB4k2vyfxYdS
         azzNekCgec3K0Bz+uMHsWxnltjDdhPTilFGFmvnck3EZn+QDaAeK7mM8FFjnnh1qGg4N
         EgkxiZh2oEiUWJWFo2vRSb+ZOmp17JKmXl4GVcBHIY5k9toygyr7sKjacgM5Q9Ka88ZJ
         +rG5+ibLZ24zuRp0Hfrb9Ez8WITcqwblGDmlxKmsc3tkdnMV7KpYqr9+RMT4W8EZErxP
         p/m6aBmnRoPWzHUxhUcNhfoBR1Xt3L70vnW527/WHrFPvMcIfM8ZisPxIV76Y5lTYF8e
         e+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691613653; x=1692218453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnwXnT2ge/xc5k9DCBeERNeMibBFIofcb6WJ4vCZxQA=;
        b=N4qSJeQ4kvX2NBGuvvALBq2Mlw0JpqV71r9VPZtitrp8qk7gpdXJxoon0U24/i7Nr5
         W4fBtmIcn+N1maUAhNDQALoqZ7xNKE8oEPuF0ROKwmNokvkwj1/pEaF0HY5/zOAVStp5
         3spJ7akz0i4FxM6aMmVcy/1ToxBV/iyFvAfKtWiIDmxJnrvzP1taljFk72AbnrpP3Q87
         FzuiQhqwjCnAWQm1Ak3FLSKlgKN2kwrMmYybctfVaJLXdaENb8C+Ii6QU5O9F28dRWk7
         1ONlt97xJg9OdYd4L3reBbyOWml9oAUriQzhnbEeqjEcCvm/EgG22ux3Wg1pTfbT57lU
         95/w==
X-Gm-Message-State: AOJu0YxmL7MEIFZVemmjheGuuYQF4pr8u4ZIUWjhilSAgJyFLP0/Bb+F
        +J/bggv3cC1n8XmLtwv9PjpjVYf7DsY=
X-Google-Smtp-Source: AGHT+IFftYOBCa2tj0MgisnRtklzfzu+Q6jBGuGhNTQUqgsM2Cg5ti3QFDR19t+xWCY5W2zfo41a3g==
X-Received: by 2002:ac8:5847:0:b0:403:e895:155b with SMTP id h7-20020ac85847000000b00403e895155bmr557060qth.34.1691613652972;
        Wed, 09 Aug 2023 13:40:52 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05622a14d200b0041020e8e261sm711295qtx.1.2023.08.09.13.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:40:52 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, cgzones@googlemail.com
Subject: [PATCH 4/7 v2] libsepol: update CIL generation for trivial not-self rules
Date:   Wed,  9 Aug 2023 16:40:43 -0400
Message-ID: <20230809204046.110783-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809204046.110783-1-jwcart2@gmail.com>
References: <20230809204046.110783-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Christian Göttsche <cgzones@googlemail.com>

Convert trivial not-self neverallow rules to CIL, e.g.

    neverallow TYPE1 ~self:CLASS1 PERM1;

into

    (neverallow TYPE1 notself (CLASS1 (PERM1)))

More complex targets are not yet supported in CIL and will fail to
convert, e.g.:

    neverallow TYPE1 ~{ self ATTR1 } : CLASS1 PERM1;
    neverallow TYPE2 { ATTR2 -self } : CLASS2 PERM2;

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/module_to_cil.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index a6b6d66f..3e168285 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1188,10 +1188,23 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *a
 			goto exit;
 		}
 
-		ts = &avrule->ttypes;
-		rc = process_typeset(pdb, ts, attr_list, &tnames, &num_tnames);
-		if (rc != 0) {
-			goto exit;
+		if (avrule->flags & RULE_NOTSELF) {
+			if (!ebitmap_is_empty(&avrule->ttypes.types) || !ebitmap_is_empty(&avrule->ttypes.negset)) {
+				if (avrule->source_filename) {
+					log_err("%s:%lu: Non-trivial neverallow rules with targets containing not or minus self not yet supported",
+						avrule->source_filename, avrule->source_line);
+				} else {
+					log_err("Non-trivial neverallow rules with targets containing not or minus self not yet supported");
+				}
+				rc = -1;
+				goto exit;
+			}
+		} else {
+			ts = &avrule->ttypes;
+			rc = process_typeset(pdb, ts, attr_list, &tnames, &num_tnames);
+			if (rc != 0) {
+				goto exit;
+			}
 		}
 
 		for (s = 0; s < num_snames; s++) {
@@ -1215,6 +1228,15 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *a
 				if (rc != 0) {
 					goto exit;
 				}
+			} else if (avrule->flags & RULE_NOTSELF) {
+				if (avrule->specified & AVRULE_XPERMS) {
+					rc = avrulex_to_cil(indent, pdb, avrule->specified, snames[s], "notself", avrule->perms, avrule->xperms);
+				} else {
+					rc = avrule_to_cil(indent, pdb, avrule->specified, snames[s], "notself", avrule->perms);
+				}
+				if (rc != 0) {
+					goto exit;
+				}
 			}
 		}
 
-- 
2.41.0


Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B15EC77B6C
	for <selinux@archiver.kernel.org>; Wed, 12 Apr 2023 21:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjDLVEd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Apr 2023 17:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjDLVER (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Apr 2023 17:04:17 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604D47A84
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 14:04:16 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id e9so8802352qvv.2
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 14:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681333452; x=1683925452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5reuVPD21ou8+nC4B88+z3QvyRqQ4C1pZl/XA+vTV0=;
        b=HLm2KbDyHaUlQq+/iqrqJMoHemqzCLy829V72x96+3IFTxeKg+iRiCHp3NtjMW43B6
         SWhDS2BTYuKbTUJAiUUc3VtKUEzBr7sr0cNi0xkjnTNH/n317HL7aO4sZVifivj6seMy
         iAiwHUs24J4k+hcLUYY3yuaB+xUpqrFB+EeKWiYPl4sNws2GjSEsWFUXvh4CRJknSOyK
         sbQz6odTviv6VqdOj0a6kBRLf6G4P1qwuTxllLZNVpC9y3YG7G32KFtZH1UNnVmPr0Cb
         9i1/1PraRdLdBECZQryy2bA84jmctwYjGgduXizZM6kPWTLPG4JTFTuZKgOVaFLb4Uk6
         51cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681333452; x=1683925452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5reuVPD21ou8+nC4B88+z3QvyRqQ4C1pZl/XA+vTV0=;
        b=NuXhJ8qfRRzF75bRaXsjYHmAAr0NgoTfcxqgx51sExFzUsLn8k5OSyftl+esBPM3WS
         BNupgCj6tzOYB0SjXaEpAtxFhPi4xQ8nFS/UCHWh5noHbjsZ5uQjsvC8Glai1YbTEZxI
         rIqk0pqXpAxW4E2kZu+B/KO6T88WN1dV8uCtWiWCgUALFDOhYSjOJG0Au03inhqy1w5a
         QDvmMjGFNvNhL9Mrm3nVTHOrX+9OZr142YzpBqBKPPElJvclI+f10F08zoddX4e4XFYU
         rnqYzGPTY5SBF6TppA1oTuBAs3h6fc3iluKMRnFU2O514bYnwO1ZPru6jAbdaDZPl98K
         8XCg==
X-Gm-Message-State: AAQBX9fr3ahrax6O+OOAl1yy2qzJMDnyEz+ow1vIUAbkhzaBWKXq+uVp
        XPK9v5yB5WfahsXkLnDh/aW+frcu5M8=
X-Google-Smtp-Source: AKy350aTDZ1qG2d3GImHaTw8ZxOPW0IL/v0bA5Xuo5fOx0bCzgVEZcPfqhVAl0TUH/CzVsEF7HpiJQ==
X-Received: by 2002:ad4:5e8c:0:b0:5ee:e18d:3f1 with SMTP id jl12-20020ad45e8c000000b005eee18d03f1mr935120qvb.35.1681333452014;
        Wed, 12 Apr 2023 14:04:12 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id oe6-20020a056214430600b005e16003edc9sm5025758qvb.104.2023.04.12.14.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:04:11 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com
Subject: [PATCH 4/6] libsepol: update CIL generation for trivial not-self rules
Date:   Wed, 12 Apr 2023 17:04:04 -0400
Message-Id: <20230412210406.522892-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412210406.522892-1-jwcart2@gmail.com>
References: <20230412210406.522892-1-jwcart2@gmail.com>
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
index 2b24d33e..c98f7142 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1201,10 +1201,23 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *a
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
@@ -1228,6 +1241,15 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *a
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
2.39.2


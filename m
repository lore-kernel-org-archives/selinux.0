Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4233C433FE
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC0760EE5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhJKQ2k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbhJKQ2g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:36 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97296C061570
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:36 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y12so57080411eda.4
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JVQIquMuJHiPVwX0HMvB2TldICYhNfD17LPr8jPECLg=;
        b=HEiMcYeANtep4PMWPZCqiXV3218b/IFIRwavxeNExbb8IMMdIeLghh9Fhv5Lwa15pv
         xmJIMq7XzqZJ0F5JAb620QAcmEiIyLKnMFIkugYN1Tt4pvx3zQKZxKt09i2FiEfUkZPX
         Tbo9UxYpHbr/zC/bQaBpCDAwy4hVN2PlfL8DxamebCMmn78NaFpN4vQQipgsDrCCZy9w
         Yo0xZlL1bfhCW5M8GSqyaDxPFK8RQbiqHXc9io2cSGScqrqBIYnpBetTfvbo9cpH/Kyc
         09mHpdiikXWbrIm5dCrNhBtYn36ExWawezhBQaAAs9Kn4HQ0kZV1Y2an2Z1TZ1dtV1ry
         JSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JVQIquMuJHiPVwX0HMvB2TldICYhNfD17LPr8jPECLg=;
        b=wLVcYLDiJqKqR30OW/48kdXIVHeEB/e4/fn4W6YwNcovZQnlNyi6is5Icg47so+LLn
         HhF8RWpPt4L9IeAigL0SJ3uxZQuU4dIrkMBw2XKGlo4ceJ0GadBGWOCZXrppt1kwO4Pf
         DvIl0a9boUDhDtZHU7Fs1f32h4nX00iio/7mAcsDA2/4umAbt6DO6xtIJXmRHyCN+2mF
         JqCdTX/Aj2lalXBgFOq6YtJV6hm9/FG7mQSqPrZhUVbPaRMwg2fEjPTpkLT/0t4Lj4U0
         QDgFziIK4ADOMYpG3O43o98H4mRAPNCbxjSw/AgcooVkhrrsou4CC+LxwE0n3Jnfxy8i
         QxDA==
X-Gm-Message-State: AOAM532WruQB3WBEahyKlBVzbrjMCE6OVRhQuok1UjWGtVLNTbOO3aPC
        fKt2yanzwLnVqQabrVSKHr+A7I49RwA=
X-Google-Smtp-Source: ABdhPJyhE2pWHlMGkwE93FOVbKXV9SKxpBGzjOSFhUp1AFUoHL+Y9cZ8lh8T736t/Xd7C8hudjqc/Q==
X-Received: by 2002:a17:906:1f95:: with SMTP id t21mr25815179ejr.234.1633969595234;
        Mon, 11 Oct 2021 09:26:35 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.34
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:34 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 26/35] libsepol: validate constraint expression operators and attributes
Date:   Mon, 11 Oct 2021 18:25:24 +0200
Message-Id: <20211011162533.53404-27-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 89830ff3..f0456583 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -185,6 +185,49 @@ static int validate_constraint_nodes(sepol_handle_t *handle, constraint_node_t *
 				if (validate_type_set(cexp->type_names, &flavors[SYM_TYPES]))
 					goto bad;
 			}
+
+			if (cexp->expr_type == CEXPR_ATTR || cexp->expr_type == CEXPR_NAMES) {
+				switch (cexp->op) {
+				case CEXPR_EQ:
+				case CEXPR_NEQ:
+				case CEXPR_DOM:
+				case CEXPR_DOMBY:
+				case CEXPR_INCOMP:
+					break;
+				default:
+					goto bad;
+				}
+
+				switch (cexp->attr) {
+				case CEXPR_USER:
+				case CEXPR_USER | CEXPR_TARGET:
+				case CEXPR_USER | CEXPR_XTARGET:
+				case CEXPR_ROLE:
+				case CEXPR_ROLE | CEXPR_TARGET:
+				case CEXPR_ROLE | CEXPR_XTARGET:
+				case CEXPR_TYPE:
+				case CEXPR_TYPE | CEXPR_TARGET:
+				case CEXPR_TYPE | CEXPR_XTARGET:
+				case CEXPR_L1L2:
+				case CEXPR_L1H2:
+				case CEXPR_H1L2:
+				case CEXPR_H1H2:
+				case CEXPR_L1H1:
+				case CEXPR_L2H2:
+					break;
+				default:
+					goto bad;
+				}
+			} else {
+				switch (cexp->expr_type) {
+				case CEXPR_NOT:
+				case CEXPR_AND:
+				case CEXPR_OR:
+					break;
+				default:
+					goto bad;
+				}
+			}
 		}
 	}
 
-- 
2.33.0


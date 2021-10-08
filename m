Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D39C4332F
	for <selinux@archiver.kernel.org>; Fri,  8 Oct 2021 21:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD48260F5E
	for <selinux@archiver.kernel.org>; Fri,  8 Oct 2021 21:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243261AbhJHVMf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhJHVMf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Oct 2021 17:12:35 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B020FC061570
        for <selinux@vger.kernel.org>; Fri,  8 Oct 2021 14:10:39 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id ay35so2031513qkb.10
        for <selinux@vger.kernel.org>; Fri, 08 Oct 2021 14:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wif+ppgPYXztMvb7yzrli0enkiBCtR1mqSF5JOtF2dI=;
        b=pnnoJfMtbwOxH0150A2VdovFur/cPooOhrabjcxIEI0hiPLmJTpB2zmjLpQKjElkNy
         Fetz7fN/WUJFgzw3rVSPmw3wuZqUaFBmqVKsWWTTBoHil1mIFzqKNEaeH+Swqi1MX0iC
         UXMpbPztdI9yEqU5Ro91v8rqsExvqWyHDXZ7MKfgood2nnKBO9PFiPhha/gSrZVOoSDc
         tw2Uml+S9KKp1F+pso0VvYG6dpJG15rxlFC9kVqUQ+KMdn+wuXjzKhbmHKTFQacm8s7h
         wYonWmcDg/8OODPq5dRq4uY9RtCEg1Fooetj+V6TqFB40QUKiGlhdwH7/9iNnLh84evS
         +ZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wif+ppgPYXztMvb7yzrli0enkiBCtR1mqSF5JOtF2dI=;
        b=y4M6PAI7m2UDqh5hufrIS+nDam3POD2tfZI4PZXOZzfOOcKucovXOhFg20mBt1jj++
         fUYcnm+qQDkThd+EpWcJb3XpQK66AAnvovfyPSvcMbMvD71kkOc6jT/2hlyhxS1rt1Zg
         //jRY8M0RKzAxMOYLNO0hidkP0Tarcujqn1QGv3vFpa6SL8vdddMso2VHwG1nL6FFKRl
         Q0t4RoXrbXkbwrsaB1vQAdkKD8mfrgayZ5BFm7OMFAQtrOArgAyecz+nz0p5/TBGUpU/
         JTJpDS2TgLqSUXfnWbt6jEs/c7ttO4H7S7v+tZ7QcV7R+h2AtqmSIWlVGAwlX6C5VNh3
         xZeQ==
X-Gm-Message-State: AOAM5338J32HWIZIfOlIuBsSOmFN8jNrn4rquiASq+ookDou4eMnazJS
        VeYZ6JiwY4ew+IRLfKCf6pyRYpIv5CU=
X-Google-Smtp-Source: ABdhPJxcFwGpomOuoHXbBRjWW47VzcErnXRUWUii7QfEE717ERWMyZX1UQYZ1wvdgwUWrIwr6Bd8kQ==
X-Received: by 2002:a05:620a:5f7:: with SMTP id z23mr4803891qkg.198.1633727438745;
        Fri, 08 Oct 2021 14:10:38 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id u9sm332453qta.90.2021.10.08.14.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 14:10:38 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/4] libselinux: Fix potential undefined shifts
Date:   Fri,  8 Oct 2021 17:10:31 -0400
Message-Id: <20211008211031.393884-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008211031.393884-1-jwcart2@gmail.com>
References: <20211008211031.393884-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

An expression of the form "1 << x" is undefined if x == 31 because
the "1" is an int and cannot be left shifted by 31.

Instead, use "UINT32_C(1) << x" which will be an unsigned int of
at least 32 bits.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libselinux/src/mapping.c   | 22 +++++++++++-----------
 libselinux/src/stringrep.c |  8 ++++----
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/libselinux/src/mapping.c b/libselinux/src/mapping.c
index 96395fd4..dd2f1039 100644
--- a/libselinux/src/mapping.c
+++ b/libselinux/src/mapping.c
@@ -144,9 +144,9 @@ unmap_perm(security_class_t tclass, access_vector_t tperm)
 		access_vector_t kperm = 0;
 
 		for (i = 0; i < current_mapping[tclass].num_perms; i++)
-			if (tperm & (1<<i)) {
+			if (tperm & (UINT32_C(1)<<i)) {
 				kperm |= current_mapping[tclass].perms[i];
-				tperm &= ~(1<<i);
+				tperm &= ~(UINT32_C(1)<<i);
 			}
 		return kperm;
 	}
@@ -191,7 +191,7 @@ map_perm(security_class_t tclass, access_vector_t kperm)
 
 		for (i = 0; i < current_mapping[tclass].num_perms; i++)
 			if (kperm & current_mapping[tclass].perms[i]) {
-				tperm |= 1<<i;
+				tperm |= UINT32_C(1)<<i;
 				kperm &= ~current_mapping[tclass].perms[i];
 			}
 
@@ -216,30 +216,30 @@ map_decision(security_class_t tclass, struct av_decision *avd)
 
 		for (i = 0, result = 0; i < n; i++) {
 			if (avd->allowed & mapping->perms[i])
-				result |= 1<<i;
+				result |= UINT32_C(1)<<i;
 			else if (allow_unknown && !mapping->perms[i])
-				result |= 1<<i;
+				result |= UINT32_C(1)<<i;
 		}
 		avd->allowed = result;
 
 		for (i = 0, result = 0; i < n; i++) {
 			if (avd->decided & mapping->perms[i])
-				result |= 1<<i;
+				result |= UINT32_C(1)<<i;
 			else if (allow_unknown && !mapping->perms[i])
-				result |= 1<<i;
+				result |= UINT32_C(1)<<i;
 		}
 		avd->decided = result;
 
 		for (i = 0, result = 0; i < n; i++)
 			if (avd->auditallow & mapping->perms[i])
-				result |= 1<<i;
+				result |= UINT32_C(1)<<i;
 		avd->auditallow = result;
 
 		for (i = 0, result = 0; i < n; i++) {
 			if (avd->auditdeny & mapping->perms[i])
-				result |= 1<<i;
+				result |= UINT32_C(1)<<i;
 			else if (!allow_unknown && !mapping->perms[i])
-				result |= 1<<i;
+				result |= UINT32_C(1)<<i;
 		}
 
 		/*
@@ -248,7 +248,7 @@ map_decision(security_class_t tclass, struct av_decision *avd)
 		 * a bug in the object manager.
 		 */
 		for (; i < (sizeof(result)*8); i++)
-			result |= 1<<i;
+			result |= UINT32_C(1)<<i;
 		avd->auditdeny = result;
 	}
 }
diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index 012a740a..2fe69f43 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -229,7 +229,7 @@ access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
 		size_t i;
 		for (i = 0; i < MAXVECTORS && node->perms[i] != NULL; i++)
 			if (strcmp(node->perms[i],s) == 0)
-				return map_perm(tclass, 1<<i);
+				return map_perm(tclass, UINT32_C(1)<<i);
 	}
 
 	errno = EINVAL;
@@ -261,7 +261,7 @@ const char *security_av_perm_to_string(security_class_t tclass,
 	node = get_class_cache_entry_value(tclass);
 	if (av && node)
 		for (i = 0; i<MAXVECTORS; i++)
-			if ((1<<i) & av)
+			if ((UINT32_C(1)<<i) & av)
 				return node->perms[i];
 
 	return NULL;
@@ -279,7 +279,7 @@ int security_av_string(security_class_t tclass, access_vector_t av, char **res)
 	/* first pass computes the required length */
 	for (i = 0; tmp; tmp >>= 1, i++) {
 		if (tmp & 1) {
-			str = security_av_perm_to_string(tclass, av & (1<<i));
+			str = security_av_perm_to_string(tclass, av & (UINT32_C(1)<<i));
 			if (str)
 				len += strlen(str) + 1;
 		}
@@ -303,7 +303,7 @@ int security_av_string(security_class_t tclass, access_vector_t av, char **res)
 	ptr += sprintf(ptr, "{ ");
 	for (i = 0; tmp; tmp >>= 1, i++) {
 		if (tmp & 1) {
-			str = security_av_perm_to_string(tclass, av & (1<<i));
+			str = security_av_perm_to_string(tclass, av & (UINT32_C(1)<<i));
 			if (str)
 				ptr += sprintf(ptr, "%s ", str);
 		}
-- 
2.31.1


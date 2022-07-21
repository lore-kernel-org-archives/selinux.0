Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1D5C43334
	for <selinux@archiver.kernel.org>; Thu, 21 Jul 2022 15:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiGUPF3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiGUPF1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Jul 2022 11:05:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8BB11A2A
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:05:24 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id z23so3656429eju.8
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7FHemlDb0HMjO1ZMLiH8Xt0H2UQ5CSY1zrfs602rxQ8=;
        b=oLoXFxWXJpFgC0+M1CUVi0RnPRG6L/ZrGaHC97QWbab/oUDR8pIVIxtolcuNEyGSoW
         eR/RpQWCMCJI0HVU0NRt20Thas1Q0zsV1DDajDc4hzyjpvH/pfsYdkJSKcQgBmirT+uy
         xZAmlL8X8t2B358+nryzMf+Snry/klxi6Eo+PlWZi2YMIqW42MR+wUCeLL4eTCLaAyiJ
         JDpP80PQHo6VfuwdyaclZ0CMGYZ0YfZnbwpyRkLFAc9tYMo5ZujsYvDbqnw8gZqqaIjl
         AG4FMIMKDELkpoLa42UIzXEEluz13cig0KzeIQo7EcafpcnS7k7LGXNovtHz9Bv1jEcy
         tuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7FHemlDb0HMjO1ZMLiH8Xt0H2UQ5CSY1zrfs602rxQ8=;
        b=0OZFiyzzy/yREwe7PJ+lub6hy8xFhyu5PaKsvBdxUYe9CxHnPtl5pJva/EWrXbiSI6
         m6BIMEkDxecY1cgN/14jqPH5qtty3wO3xSSSNcv9wGiqlKojl0MEfx03Jqpqw9bo5QUm
         kh8QDqBjMaAaAVRTS/ME40vggOIe3mkpvsNHHoEqhvWwIXYSPyO/S1+/2U2PrWrpgOPm
         nmBT7hRwLfBRCON5aMYLaIgTTzxSdunsdJdogu0H4YQ1W893m61V8TiVVLWiBvsPqG1p
         pXR/SAndq0yxFThTZ9LATE1OwT4bLeEyTp39gHqvM2SOJc0JbhJvUqgzlPZMgGyI95wg
         0kpA==
X-Gm-Message-State: AJIora+wuDpiyRIX3jBHBQ+tA4b2Kp3j65m5MIAFIV4bWoG1gQaV09FC
        Xs62SVj1CyQd+TGZ4pdjBq6u3Ylq5CIUug==
X-Google-Smtp-Source: AGRyM1tvqndE5ltiTuc5yWCPSa1OR8YsOYM0mkY0lm/FZk2jqnhRRLfIB/TR82EBhr7KAQkCV5SEHQ==
X-Received: by 2002:a17:907:9693:b0:72f:9cc:63d7 with SMTP id hd19-20020a170907969300b0072f09cc63d7mr27558401ejc.661.1658415922656;
        Thu, 21 Jul 2022 08:05:22 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-209-027.77.0.pool.telefonica.de. [77.0.209.27])
        by smtp.gmail.com with ESMTPSA id s7-20020aa7c547000000b0043a1255bc68sm1120992edr.94.2022.07.21.08.05.22
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:05:22 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 2/8] libsepol: add ebitmap iterator wrapper with startnode
Date:   Thu, 21 Jul 2022 17:05:09 +0200
Message-Id: <20220721150515.19843-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721150515.19843-1-cgzones@googlemail.com>
References: <20220721150515.19843-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Similar like ebitmap_for_each_bit() iterates over all bits of an ebitmap
add ebitmap_for_each_bit_starting() iterating over all bits starting
from a specific node and bit, which can be from an outer iteration.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   * use _after suffix
   * reorder parameters
---
 libsepol/include/sepol/policydb/ebitmap.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include/sepol/policydb/ebitmap.h
index 81d0c7a6..4696805f 100644
--- a/libsepol/include/sepol/policydb/ebitmap.h
+++ b/libsepol/include/sepol/policydb/ebitmap.h
@@ -80,6 +80,13 @@ static inline int ebitmap_node_get_bit(const ebitmap_node_t * n, unsigned int bi
 #define ebitmap_for_each_positive_bit(e, n, bit) \
 	ebitmap_for_each_bit(e, n, bit) if (ebitmap_node_get_bit(n, bit)) \
 
+#define ebitmap_for_each_bit_after(e, n, bit, startnode, startbit) \
+	n = startnode; \
+	for (bit = ebitmap_next(&n, startbit); bit < ebitmap_length(e); bit = ebitmap_next(&n, bit)) \
+
+#define ebitmap_for_each_positive_bit_after(e, n, bit, startnode, startbit) \
+	ebitmap_for_each_bit_after(e, n, bit, startnode, startbit) if (ebitmap_node_get_bit(n, bit)) \
+
 extern int ebitmap_cmp(const ebitmap_t * e1, const ebitmap_t * e2);
 extern int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebitmap_t * e2);
 extern int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1);
-- 
2.36.1


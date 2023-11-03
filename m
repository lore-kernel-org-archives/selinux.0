Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7111DC4332F
	for <selinux@archiver.kernel.org>; Fri,  3 Nov 2023 18:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjKCS0h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Nov 2023 14:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjKCS0g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Nov 2023 14:26:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3307CD6D
        for <selinux@vger.kernel.org>; Fri,  3 Nov 2023 11:26:20 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53e70b0a218so4086497a12.2
        for <selinux@vger.kernel.org>; Fri, 03 Nov 2023 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699035978; x=1699640778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=namISLHhEEcSEjTB1BLD076KzYz3DCMmwet9nb4ZxiM=;
        b=TnS0GYdA7uPZqpArF9jUsEvSWMrO4SSoSnS3i7Xsl/45dh434DtKO6bty79pssruE2
         qQCkxgwX+OH6G6yUAcfw8njVLVVaiTlv5s3v3fbfOowSXYyxmVtYpOOEFUWXrwQ8SlZG
         dhkSvAoW0rJlZoc0O1nax+amVbyJ3LvRZH6C74milfZiHqrtbmZ+l9qUltjwgj32e674
         cXHkFRhoF2kvsKmyZNKnIaporEvofu5f2zMDo1UwJ3iUNQZEQxaqZO+1JHFXa814Ypw/
         vY6npmlOYeGxNd8aU3nK/0ISYPaUt2DCV8ECvv65JE1PnPQau5y++3s9bCc07VRiMmqv
         oCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699035978; x=1699640778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=namISLHhEEcSEjTB1BLD076KzYz3DCMmwet9nb4ZxiM=;
        b=T9eK9W8jTNyeqg+0vDp3i0/EzQ5HFl9/MnU+XEnDX8I5DvtIzpoFOy7BvTrOd+vkfv
         c0XWCQsEJ+GNQzQCPfsE30JTVGNFKzz3ZZ38BirP1ZEJJ0XDOvuN4alkV8vK1NCKYklB
         +2t8lS8hgalp+Zo7MKpZtiOWi5FTYI2BiwRnG+Ejy9wiT0ZCzHclMBnSiGtkKyQ+fXSp
         dIhafZeWFqYx3fcUroIRHFy5rRRhDitwXjc0YOa5sF2uqdlyDt/6f08Qz0WiEaD0KCdj
         uUNipb/Bnh1dXqnBHUL+yNySS9HBkKcRF1uk9XoTOtPa+0jAAL8cVpgfOgLAFoKdDzlT
         vO3A==
X-Gm-Message-State: AOJu0YwXFlqozB09btFzgbJ6xeR0RDqA25NWEblPXpnYnZjE/whp2g/K
        cZafBhSvnCa/QdbLlazHyENwDFLfHL8=
X-Google-Smtp-Source: AGHT+IGPYa7t1vpyoQT5uGTgFxXl7Z1wrtfIvDuxMmr6dRm4SYQQHHwcxAQb65aISlWv/SsHd4C80g==
X-Received: by 2002:a17:907:9603:b0:9d3:f436:6807 with SMTP id gb3-20020a170907960300b009d3f4366807mr8229196ejc.42.1699035978518;
        Fri, 03 Nov 2023 11:26:18 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-003-098-230.77.3.pool.telefonica.de. [77.3.98.230])
        by smtp.gmail.com with ESMTPSA id lz8-20020a170906fb0800b00992b2c55c67sm1175270ejb.156.2023.11.03.11.26.17
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 11:26:18 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: reject unsupported policy capabilities
Date:   Fri,  3 Nov 2023 19:26:12 +0100
Message-ID: <20231103182612.84821-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Kernel policies with unsupported policy capabilities enabled can
currently be parsed, since they result just in a bit set inside an
ebitmap.  Writing such a loaded policy into the traditional language or
CIL will fail however, since the unsupported policy capabilities can not
be converted into a name.

Reject kernel policies with invalid policy capabilities.

Reported-by: oss-fuzz (issue 60573)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
Alternative to ("libsepol: ignore writing invalid polcaps in fuzzer"):
https://patchwork.kernel.org/project/selinux/patch/20231101163852.177983-1-cgzones@googlemail.com/
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 892a0ffd..1acaa74f 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1,6 +1,7 @@
 
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/ebitmap.h>
+#include <sepol/policydb/polcaps.h>
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/services.h>
 
@@ -1522,6 +1523,23 @@ bad:
 	return -1;
 }
 
+static int validate_policycaps(sepol_handle_t *handle, const policydb_t *p)
+{
+	ebitmap_node_t *node;
+	uint32_t i;
+
+	ebitmap_for_each_positive_bit(&p->policycaps, node, i) {
+		if (!sepol_polcap_getname(i))
+			goto bad;
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid policy capability");
+	return -1;
+}
+
 static void validate_array_destroy(validate_t flavors[])
 {
 	unsigned int i;
@@ -1544,6 +1562,9 @@ int policydb_validate(sepol_handle_t *handle, const policydb_t *p)
 	if (validate_properties(handle, p))
 		goto bad;
 
+	if (validate_policycaps(handle, p))
+		goto bad;
+
 	if (p->policy_type == POLICY_KERN) {
 		if (validate_avtab(handle, &p->te_avtab, p, flavors))
 			goto bad;
-- 
2.42.0


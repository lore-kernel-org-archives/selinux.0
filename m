Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB493CCA483
	for <selinux@archiver.kernel.org>; Tue, 19 Jul 2022 15:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbiGSPbM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiGSPbI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Jul 2022 11:31:08 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9265886C
        for <selinux@vger.kernel.org>; Tue, 19 Jul 2022 08:31:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y4so20108799edc.4
        for <selinux@vger.kernel.org>; Tue, 19 Jul 2022 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NYQLsg+OM3i1gj8SShF2mSYB6+VprKWtjfjk169htWo=;
        b=bSIs0LSmy0oPy4cCodR8hhgX/VmTIcbN6uvsMCvhUqrA7QqVaTd4c+WKG5YbJDj6MZ
         XmcTBYXEpQ70a+LRd08lU+zpdCj0JPbsqHOxVBwNiyivv/WTKdO5a45+MYg4ULVLuBJ1
         Pr2INsM7RtGgeHM/GbbQeJthUjGdXmZhQcCuzWgRdKxD9BkkClWoGTO8jkwcKrTtEydW
         WLF2LkGlCm++XkHBI81q4qmxIOg48LMIapEWT4WU3+iW+5HEthJEPXarax8WBxcmwZ1F
         2ISdOh0nvSHufHkdOGuFELdMWQsinjEKTU5qkdOfaaAnmhqSWxLUOML4A+zIjKv2huMV
         V+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYQLsg+OM3i1gj8SShF2mSYB6+VprKWtjfjk169htWo=;
        b=IwtuUxd/L3AnahvrO8/Ek86MXdcOxMqG3PU6h/f7yF86OuIFDJRA+VKGPZlXU/JkKK
         tQTPWxl7mWrN59GguSqGV6/D5DA2FrEmcFbuN6x7YxtQwBm7SFighGVsUJ9e5MUtGrTY
         yabQv3iYqRgB82SXecoobtCL4+68VHefZ3eEfDdHrqlcvDMXUuiomUmRVODutee+m0vj
         CwXh0OGBsflNM/tdTC7BKPsCRWG7GttFlh8Hu8nKVakDiD1/GXYLSxaVw3ID1ebHcb7f
         N09zRxcL+95Ri/5NEIZ+5bkEOmdzBDQ0lXR/MGRAmLDfdOq7kBEVPttKumw1veN3ncFX
         GLVQ==
X-Gm-Message-State: AJIora+WMOVkGIJbcYs+In9/InJJVdF40XVSNHfJpb8jHIay6Golbg21
        bAFMcEelsE0A4xmqWitBF2c3WfAY6G+mCg==
X-Google-Smtp-Source: AGRyM1tn3IWEpWqi9Z12gq3TA2qldfk7zOtB8DzbK6oTafcNjBOime0h1usoYfKjZn7gvDasccsHbA==
X-Received: by 2002:a05:6402:3553:b0:43a:dba8:9f65 with SMTP id f19-20020a056402355300b0043adba89f65mr44041247edd.323.1658244665518;
        Tue, 19 Jul 2022 08:31:05 -0700 (PDT)
Received: from dlaptop.localdomain (dynamic-077-001-147-221.77.1.pool.telefonica.de. [77.1.147.221])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906311b00b0072b7b317aadsm6809621ejx.150.2022.07.19.08.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:31:05 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 5/7] libsepol: optimize ebitmap_and
Date:   Tue, 19 Jul 2022 17:30:42 +0200
Message-Id: <20220719153045.70041-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220719153045.70041-1-cgzones@googlemail.com>
References: <20220719153045.70041-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Iterate on nodes instead of single bits to save node resolution for each
single bit.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  use braces for all if-else branches when used for at least one of them
---
 libsepol/src/ebitmap.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index c9164c5e..6dbbddfd 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -74,15 +74,44 @@ int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1)
 
 int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2)
 {
-	unsigned int i, length = min(ebitmap_length(e1), ebitmap_length(e2));
+	const ebitmap_node_t *n1, *n2;
+	ebitmap_node_t *new, *prev = NULL;
+
 	ebitmap_init(dst);
-	for (i=0; i < length; i++) {
-		if (ebitmap_get_bit(e1, i) && ebitmap_get_bit(e2, i)) {
-			int rc = ebitmap_set_bit(dst, i, 1);
-			if (rc < 0)
-				return rc;
+
+	n1 = e1->node;
+	n2 = e2->node;
+	while (n1 && n2) {
+		if (n1->startbit == n2->startbit) {
+			if (n1->map & n2->map) {
+				new = malloc(sizeof(ebitmap_node_t));
+				if (!new) {
+					ebitmap_destroy(dst);
+					return -ENOMEM;
+				}
+				new->startbit = n1->startbit;
+				new->map = n1->map & n2->map;
+				new->next = NULL;
+
+				if (prev)
+					prev->next = new;
+				else
+					dst->node = new;
+				prev = new;
+			}
+
+			n1 = n1->next;
+			n2 = n2->next;
+		} else if (n1->startbit > n2->startbit) {
+			n2 = n2->next;
+		} else {
+			n1 = n1->next;
 		}
 	}
+
+	if (prev)
+		dst->highbit = prev->startbit + MAPSIZE;
+
 	return 0;
 }
 
-- 
2.36.1


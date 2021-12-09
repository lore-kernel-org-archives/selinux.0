Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D6CC4332F
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbhLIQzH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbhLIQzH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:07 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918E2C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:51:33 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id l25so21579740eda.11
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SGoF1911AB4EV0Iv4ri18U1rOWqcokV6jCeV3aa52j4=;
        b=TYw6ZyLAg9ev/lXLKqfninUqlnmszcxR9h5y3Bde/Y3zZ5TIQHZeTMpf0RP18/8Oci
         5TERczKgFxAGMeBTQzVwH9ysyPtEmDfVpzB2eUuGpZYw8KTO6XW3Rzl/aXI+4K3Trbcy
         kp5W9iT1v/PU1+NnI3Xq6h6Nc30ijT4nt7jh6d/hVY1DyFE6msjhM7dDRBWHA4dJvFQ/
         uN2ZWPKt2+lUieLv8Z6ZiNu2Zk7BIxiyIm0hkmbhAsHnZnms1/7oqEflyZB4LfBDilOx
         Xw5LCwIVtwxfKBNDA1t5tGCNwayXr7Gqvg9Ui0tuZ30C8zGXAzoM6Bm9eXTxipo8/9hi
         T5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SGoF1911AB4EV0Iv4ri18U1rOWqcokV6jCeV3aa52j4=;
        b=rgjP8Dbg9/FbCK1sV2Mn9t3SXsfdCENBA7sMIVrsmOJjYU9GNxEd7GgBmw7Bt/LzLq
         JYWVb+nd6D0HHkPY9VZSSP0Cru4SQ4H1ixVO2R618odF1S0K3vSf2y7ToVnLTBldiTbY
         mdtLFmQqPyQV/X+j1IZ9Rj2kA6OGBEOmCtTvaS/qFRoFWy4PLw1cY58ZXIqD71HTfXh7
         LUExhMsd8QilZfzb2uCT2vGHzA5b+MdRm/2oVAuPGW2mvOKbyDzboN52Fcp3LdoaH+10
         eZ2baIV8Adl88JJTjQuSQTp0Z561HUUL+9U4Wp2PX1C5145RQFfvNNLYe8IA6bgVv7ny
         8vnw==
X-Gm-Message-State: AOAM533LpqLjCWtAmk54hcV/6BZbu/oKJPgxZGPqURK4jBG6ywI+YutB
        HxaRAg8LmnsCUt8kvZtEC2h3cWq5+Io=
X-Google-Smtp-Source: ABdhPJz03b/8gdcuTLpqKvwKx/vQJgEF2/dcHdhM1Mip3m7llAJmxyrwZO0b6HsmzV4D+99A6/xCeQ==
X-Received: by 2002:a05:6402:3596:: with SMTP id y22mr31057828edc.297.1639068579778;
        Thu, 09 Dec 2021 08:49:39 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:39 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 07/36] libsepol: use logging framework in ebitmap.c
Date:   Thu,  9 Dec 2021 17:48:59 +0100
Message-Id: <20211209164928.87459-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209164928.87459-1-cgzones@googlemail.com>
References: <20211105154542.38434-1-cgzones@googlemail.com>
 <20211209164928.87459-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the internal logging framework instead of directly writing to
stdout as it might be undesired to do so within a library.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/ebitmap.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index 1de3816a..fa728558 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -406,8 +406,7 @@ int ebitmap_read(ebitmap_t * e, void *fp)
 	count = le32_to_cpu(buf[2]);
 
 	if (mapsize != MAPSIZE) {
-		printf
-		    ("security: ebitmap: map size %d does not match my size %zu (high bit was %d)\n",
+		ERR(NULL, "security: ebitmap: map size %d does not match my size %zu (high bit was %d)\n",
 		     mapsize, MAPSIZE, e->highbit);
 		goto bad;
 	}
@@ -416,8 +415,7 @@ int ebitmap_read(ebitmap_t * e, void *fp)
 		goto ok;
 	}
 	if (e->highbit & (MAPSIZE - 1)) {
-		printf
-		    ("security: ebitmap: high bit (%d) is not a multiple of the map size (%zu)\n",
+		ERR(NULL, "security: ebitmap: high bit (%d) is not a multiple of the map size (%zu)\n",
 		     e->highbit, MAPSIZE);
 		goto bad;
 	}
@@ -429,12 +427,12 @@ int ebitmap_read(ebitmap_t * e, void *fp)
 	for (i = 0; i < count; i++) {
 		rc = next_entry(buf, fp, sizeof(uint32_t));
 		if (rc < 0) {
-			printf("security: ebitmap: truncated map\n");
+			ERR(NULL, "security: ebitmap: truncated map\n");
 			goto bad;
 		}
 		n = (ebitmap_node_t *) malloc(sizeof(ebitmap_node_t));
 		if (!n) {
-			printf("security: ebitmap: out of memory\n");
+			ERR(NULL, "security: ebitmap: out of memory\n");
 			rc = -ENOMEM;
 			goto bad;
 		}
@@ -443,34 +441,30 @@ int ebitmap_read(ebitmap_t * e, void *fp)
 		n->startbit = le32_to_cpu(buf[0]);
 
 		if (n->startbit & (MAPSIZE - 1)) {
-			printf
-			    ("security: ebitmap start bit (%d) is not a multiple of the map size (%zu)\n",
+			ERR(NULL, "security: ebitmap start bit (%d) is not a multiple of the map size (%zu)\n",
 			     n->startbit, MAPSIZE);
 			goto bad_free;
 		}
 		if (n->startbit > (e->highbit - MAPSIZE)) {
-			printf
-			    ("security: ebitmap start bit (%d) is beyond the end of the bitmap (%zu)\n",
+			ERR(NULL, "security: ebitmap start bit (%d) is beyond the end of the bitmap (%zu)\n",
 			     n->startbit, (e->highbit - MAPSIZE));
 			goto bad_free;
 		}
 		rc = next_entry(&map, fp, sizeof(uint64_t));
 		if (rc < 0) {
-			printf("security: ebitmap: truncated map\n");
+			ERR(NULL, "security: ebitmap: truncated map\n");
 			goto bad_free;
 		}
 		n->map = le64_to_cpu(map);
 
 		if (!n->map) {
-			printf
-			    ("security: ebitmap: null map in ebitmap (startbit %d)\n",
+			ERR(NULL, "security: ebitmap: null map in ebitmap (startbit %d)\n",
 			     n->startbit);
 			goto bad_free;
 		}
 		if (l) {
 			if (n->startbit <= l->startbit) {
-				printf
-				    ("security: ebitmap: start bit %d comes after start bit %d\n",
+				ERR(NULL, "security: ebitmap: start bit %d comes after start bit %d\n",
 				     n->startbit, l->startbit);
 				goto bad_free;
 			}
@@ -481,8 +475,7 @@ int ebitmap_read(ebitmap_t * e, void *fp)
 		l = n;
 	}
 	if (count && l->startbit + MAPSIZE != e->highbit) {
-		printf
-		    ("security: ebitmap: high bit %u has not the expected value %zu\n",
+		ERR(NULL, "security: ebitmap: high bit %u has not the expected value %zu\n",
 		     e->highbit, l->startbit + MAPSIZE);
 		goto bad;
 	}
-- 
2.34.1


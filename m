Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C3EC433FE
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE7C960E8B
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhJKQ21 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhJKQ20 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ABBC061570
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:26 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i20so53523262edj.10
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dMS8W/GAYYtBc6YxJ9Pe2XzQ2RnoX9Ik1pXdcIcfWic=;
        b=ZuDqiT2xiwnyiJ4jpfqlw/jQg2CE/D4QygxTQ8/QMyFDuS+xna6EzJh5hg+NkLYsYK
         wco3rU1Arg2xBTy573BbtdQPHgCja+ExOYo32+VKq6il6kaBwzaatF5ilcAzamEAzcqy
         5Qt1d5xIGt/yt/pDyWG076WYxi7h4AUcveorxmWpm+tEUEhTETiCWlhg0IxSGn1q3ncM
         JSxtlfazfE2MVThtIW7/XzZgoH+BPzdESKEQ2LYloCBuQzfLdY+OceDsFt29DDr3tg1L
         Xg92yVlHCifysz85AHDbhn6IAP81phRaAJbdZjvxKioMwQllDluoIp4LDLTZJv5QVNq3
         Ving==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dMS8W/GAYYtBc6YxJ9Pe2XzQ2RnoX9Ik1pXdcIcfWic=;
        b=opfh4W3GfVI77XU046m0iBbc8ySO0JjXjjc3eiUU/TFcx775RGFwzJiaQtz0QoPmfW
         UxDCCLmKRVaihy94WtsCkN/ENBVVi/rH2Ax15vaJzrDATjURAsHYqet9zG6dH1fuubez
         n8uEKmK88hMcPnfTPbGM5JiknWa/2F6PCiH1WqVw2owAEMEcFXJQ58TnTgRkBb4mXAZc
         mMmn7NnX1vUSsQksQpJTaxSEIFfhDj1dyf0vq1KG0E/trdOaLKM9VYPQC/AvUdQ+shi3
         xaNITTG+0rUwdK6CmrBnprhof+zM9LjGJZpbLXdHYmuaE0yR6t2LPBUbtoIUedO/0PtG
         HslA==
X-Gm-Message-State: AOAM530FTpehEdSwJkrpfKHHKpMlHxgxwfB3bQsWdlG2Z+SzAMxLYuWJ
        b9ZC0pQGNbyjskdAyfhLcinSZg5Qr7U=
X-Google-Smtp-Source: ABdhPJzxv1hztce1RGKIaitFH2oLimRZY37qiFonFxyYyP6nq/DSuaOy4qI6Llws0YDgrafxeyq0JA==
X-Received: by 2002:a17:906:d1d6:: with SMTP id bs22mr27041632ejb.554.1633969584940;
        Mon, 11 Oct 2021 09:26:24 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.24
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:24 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 07/35] libsepol: use logging framework in ebitmap.c
Date:   Mon, 11 Oct 2021 18:25:05 +0200
Message-Id: <20211011162533.53404-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
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
2.33.0


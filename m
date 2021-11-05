Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE136C4332F
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE3F61108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhKEPsc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhKEPsc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:32 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AC1C061205
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:45:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id j21so34368536edt.11
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7aPhMxSq2+akr31cTusNClg4NbPvTbnA0dtwLNwFaS4=;
        b=W1A4RlQpji5uM/R3oDKG2eiBOBxipAIAsohtavemXvFqtAly2xrW9DfhMoFNQOGaQ7
         wX/L/3bRK0km98+kz2zbB3roEQ84ida/VKLYLP487VDL9aGUaw5igOzjh7N54CqQZbU2
         qRH7r53g1eOf23qNw1B7DVNJluWFlxeyJRnNUwDTJhongHGQK0Zjks0k1yk7MPc34Xwx
         nWNSgjY5hYWhKEr0REB7CeQLlBUHTKq8XkwbOAFLCxlgYnRqDexo4xwEwDEeH5MERVVw
         9JFcXCAKQytbD7I0W1UwKq7066DRPtjDroYz4E2pZ+q4gYdSEL9SU1u9GBPQU1xfmu+Y
         /Uyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7aPhMxSq2+akr31cTusNClg4NbPvTbnA0dtwLNwFaS4=;
        b=KYyuEy3IqWoBVGQhmn6FebeUKhsl974oTUgnwBaU5KYN/eacskjGH6yD4HSi82tlfP
         EUvm4uGReyMBBHxEDY+9CIepbRa0lHbG9xlHp+35+3Ll+vR6Tb2I6EwzxL1th668+fhu
         fxII1bU/9hjUDl6yIj6Q25CuqdlYdAI8GzotX5G/qANDBdrRxdX8lsDqkoxwdhuSgZ3X
         1R9bS/gOhe8+ZF+Ua3wNttIw3lgRtu7iGvnv/1B8WkuRrDpd17dlChjqtIYHeMrXXU17
         DdOMTgUhrqoHwKDXuycPDsPG1WJi04MIswdeH+sMQIFZYgT5KojgGQuC9/y8hmqw6BZx
         sgZw==
X-Gm-Message-State: AOAM531Q8NKQraM/N4xxKoehfnxQkd01iznYv77fSJ6zExcTTTb2F7zE
        cvJuexRLQJDyIKv5ZAy+JtHmqeTQLIc=
X-Google-Smtp-Source: ABdhPJwpcnNT0uxkMf5hk3Dqo51g9TjMvNoxQEMHkI9vRi4u+JFoCpxochXkShnoI6jZV1hoOi6sfA==
X-Received: by 2002:a17:907:6287:: with SMTP id nd7mr20984062ejc.152.1636127150483;
        Fri, 05 Nov 2021 08:45:50 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:50 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 07/36] libsepol: use logging framework in ebitmap.c
Date:   Fri,  5 Nov 2021 16:45:09 +0100
Message-Id: <20211105154542.38434-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105154542.38434-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com>
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
2.33.1


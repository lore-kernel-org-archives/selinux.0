Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54130C433EF
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E60E60E8B
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhJKQ2f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbhJKQ2b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:31 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0E5C061745
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g8so70005948edt.7
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cHhtep0cGwqd0jmEBxKWu6uhtluT1d6mG+Xlx+HtB5k=;
        b=iPuqhQIkK6P6pW3c3RJtIfYujzEnmVlSHSaisoBUZbDsT/872mTiWJtWwawpQyRNEb
         /7y2HxFycM1AensDO+YFTPInONq5TB3EoqjfKrEIEgN4iBIZbKYxuP/kK9dMXlTegqjM
         7EA0YU3d3s0lmT94OA/017iUm3jTRKv3Hb7ZRkygn4IAOpWuym3StHVNxws0pS8gf4k8
         1RQ/xNFX8BQ0UcNeOAylEC4omktYsxJNEaVBpn3SQGfHPrVQOAs7uw27FyB5OdrJfZIx
         i/qvnmkKW9OCADz4RBxxLiz8QMlpgMvDxlGQ6IYkbZW6kQWDHdH1KlbdXS4PGca3B/pM
         3moQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHhtep0cGwqd0jmEBxKWu6uhtluT1d6mG+Xlx+HtB5k=;
        b=XXxne9rK+ARFe9DFrgZ12XRWUwdfw+RaGeTMoRn81T9a7yveT0RTayhj/sfwQ5VF5u
         A/zbbviGtUQDifSOcoAryzdqrh7zU1QL9KolKIrClWhFR5GplkSMffdD7j7LcggyXwTN
         YaK7vxeMhL6TBxQSGEQoCeHa2vBOR+9Nu66NpNKDHn73RBxfSoDn+PSZpYd6l9mC5i/u
         n+n7fHXdpFKAPPktKNlePUWzBH7t70xAfNguI5xpKdpdrIOaZh9aM7bNECl3xPMH7auV
         hLd7YD2/Fc0uJa6qhDrwLZ8YWhYl7OlQOZxRjiSSjEUDrMv2Zgc5e/eoA1OxJzCYLVcn
         s39A==
X-Gm-Message-State: AOAM533NXdtrs1Aws9zDFEYlJh3dzfbYTIuk6sbwsI22q9VJtJwYGx/W
        qncHX3FXdLsnIUsRr7vmqzl/IGX/49g=
X-Google-Smtp-Source: ABdhPJxjqSsdRGas5tllzv+Fxdb3iYOdqZRkFBOGrE7GIwYEbK50qBkGSKLKatYJa/tyBHDB9VYtTw==
X-Received: by 2002:a17:906:a1c1:: with SMTP id bx1mr19467181ejb.447.1633969589977;
        Mon, 11 Oct 2021 09:26:29 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.29
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:29 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 16/35] libsepol: validate expanded user range and level
Date:   Mon, 11 Oct 2021 18:25:14 +0200
Message-Id: <20211011162533.53404-17-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check those contains valid values.

    ==57532==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x603000001178 at pc 0x000000564c04 bp 0x7ffed7a5ad90 sp 0x7ffed7a5ad88
    READ of size 8 at 0x603000001178 thread T0
        #0 0x564c03 in level_to_str ./libsepol/src/kernel_to_conf.c:1901:19
        #1 0x564c03 in range_to_str ./libsepol/src/kernel_to_conf.c:1926:9
        #2 0x564c03 in write_user_decl_rules_to_conf ./libsepol/src/kernel_to_conf.c:2367:12
        #3 0x55b137 in sepol_kernel_policydb_to_conf ./libsepol/src/kernel_to_conf.c:3184:7
        #4 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:38:9
        #5 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #6 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #7 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #8 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #9 0x7f2c2e1a77ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #10 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 47 +++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index ca0dcca3..a6ae728a 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -290,38 +290,53 @@ bad:
 	return -1;
 }
 
-static int validate_user_datum(sepol_handle_t *handle, user_datum_t *user, validate_t flavors[])
+static int validate_mls_level(mls_level_t *level, validate_t *sens, validate_t *cats)
 {
-	if (validate_value(user->s.value, &flavors[SYM_USERS]))
-		goto bad;
-	if (validate_role_set(&user->roles, &flavors[SYM_ROLES]))
+	if (validate_value(level->sens, sens))
 		goto bad;
-	if (validate_mls_semantic_range(&user->range, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+	if (validate_ebitmap(&level->cat, cats))
 		goto bad;
-	if (validate_mls_semantic_level(&user->dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+
+	return 0;
+
+	bad:
+	return -1;
+}
+
+static int validate_mls_range(mls_range_t *range, validate_t *sens, validate_t *cats)
+{
+	if (validate_mls_level(&range->level[0], sens, cats))
 		goto bad;
-	if (user->bounds && validate_value(user->bounds, &flavors[SYM_USERS]))
+	if (validate_mls_level(&range->level[1], sens, cats))
 		goto bad;
 
 	return 0;
 
-bad:
-	ERR(handle, "Invalid user datum");
+	bad:
 	return -1;
 }
 
-static int validate_mls_level(mls_level_t *level, validate_t *sens, validate_t *cats)
+static int validate_user_datum(sepol_handle_t *handle, user_datum_t *user, validate_t flavors[], int mls)
 {
-	if (level->sens == 0)
-		return 0;
-	if (validate_value(level->sens, sens))
+	if (validate_value(user->s.value, &flavors[SYM_USERS]))
 		goto bad;
-	if (validate_ebitmap(&level->cat, cats))
+	if (validate_role_set(&user->roles, &flavors[SYM_ROLES]))
+		goto bad;
+	if (validate_mls_semantic_range(&user->range, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+		goto bad;
+	if (validate_mls_semantic_level(&user->dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+		goto bad;
+	if (mls && validate_mls_range(&user->exp_range, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+		goto bad;
+	if (mls && validate_mls_level(&user->exp_dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+		goto bad;
+	if (user->bounds && validate_value(user->bounds, &flavors[SYM_USERS]))
 		goto bad;
 
 	return 0;
 
-	bad:
+bad:
+	ERR(handle, "Invalid user datum");
 	return -1;
 }
 
@@ -383,7 +398,7 @@ static int validate_datum_arrays(sepol_handle_t *handle, policydb_t *p, validate
 		if (p->user_val_to_struct[i]) {
 			if (ebitmap_get_bit(&flavors[SYM_USERS].gaps, i))
 				goto bad;
-			if (validate_user_datum(handle, p->user_val_to_struct[i], flavors))
+			if (validate_user_datum(handle, p->user_val_to_struct[i], flavors, p->mls))
 				goto bad;
 		} else {
 			if (!ebitmap_get_bit(&flavors[SYM_USERS].gaps, i))
-- 
2.33.0


Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34C0C433FE
	for <selinux@archiver.kernel.org>; Fri,  8 Oct 2021 14:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F2360F58
	for <selinux@archiver.kernel.org>; Fri,  8 Oct 2021 14:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242823AbhJHOvX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Oct 2021 10:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242804AbhJHOvW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Oct 2021 10:51:22 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D5AC061570
        for <selinux@vger.kernel.org>; Fri,  8 Oct 2021 07:49:26 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id t63so4905809qkf.1
        for <selinux@vger.kernel.org>; Fri, 08 Oct 2021 07:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LJwuKvnrf/oImxNc0ejyfKWvIwS1bY9F4J7sIFsq+1k=;
        b=F/sfBksgNjC7w52NixW/RYCGXPXghGAX936iFNGN/OwqwwXMIynqnlxIHKWYOT756u
         6fwZuFN3HQpacWo7mWx4w2IqJ+CLCvTj1PjNRCvjpl0pmwjBYN/GV7nojY8i/HMC8y+R
         twbozLplIngsKtaD5cPNfsTNeD5/pMZgh4VwyoDmMepHrnxisGPeMWW75YGfCuNhKzej
         MbHpCm6Q2HobKhtEU4kH9il3FqVa3yIvzQ32Q3yy15Q4dT64pTlJC1VCDTTOfkARvWrd
         qO0heVfuMNprRmd1DKG1A8gU8qksZpR+2tpzgJm3o2M262h+Ln5W2U8wsv4zCigm3B5J
         Fn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LJwuKvnrf/oImxNc0ejyfKWvIwS1bY9F4J7sIFsq+1k=;
        b=nRc78BIz0MOz3jwV44TGGKuXHBn/HpCOfvCgOzwNNikKETgA/rkC9sAf7oIQEBwVAM
         yff1NnelUSRi90zFfkpmdCbiClILxv/CPIJPNHsYV6aiIN8tFirfBDi9oWjHElBLgr1j
         ftdAQdAaHkTorVKRJUOZY+sKls+TxcfNffXr1/zqmewPi+pR6o6+V4xGB0mARSrisjX/
         EKO8gGzVilVzqVJOcriZBydwKbGekDeV1hV7gG4KdIao+Fa576ET6XOZdzWNvvbAORwC
         YXkOwQJRb+0jeRVa3mMqbEg9z2u1TI00aOh0xYDr9mKMIXYuRPiHhhXFWIC9A+/M1Ulm
         i3rw==
X-Gm-Message-State: AOAM533hPpyz+Fysij7KyVbButfQBmGdOCRmKYMwbkw/217Fm83DZrJI
        qvg9Iyuclnia7bRmWs81dk7y8IkdAbs=
X-Google-Smtp-Source: ABdhPJymVS6WdiKMrFaBgw/F0h4Iws6Rlj6En9VeQ7XeXuQMkrBJ0ngy2EY+tnyIjwTyKJBMzo4YuA==
X-Received: by 2002:a37:9185:: with SMTP id t127mr3267717qkd.228.1633704565799;
        Fri, 08 Oct 2021 07:49:25 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id c142sm2201388qke.62.2021.10.08.07.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 07:49:25 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Fix potential undefined shifts
Date:   Fri,  8 Oct 2021 10:49:21 -0400
Message-Id: <20211008144921.377072-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The maximum number of permissions in a class is 32. This is so that
each permission can be represented by a bit in a uint32_t. In two
places while building the binary policy from CIL an expression of the
form "1 << x" is used to set the permission bit. Unfortunately, this
expression is undefined if x == 31 because the 1 is an int and cannot
be left shifted by 31.

Instead, use 1U << x, because an unsigned can be shifted 31.

This bug was found by the secilc-fuzzer.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_binary.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index ec5f01e5..90af430d 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1225,7 +1225,7 @@ int __perm_str_to_datum(char *perm_str, class_datum_t *sepol_class, uint32_t *da
 			goto exit;
 		}
 	}
-	*datum |= 1 << (sepol_perm->s.value - 1);
+	*datum |= 1U << (sepol_perm->s.value - 1);
 
 	return SEPOL_OK;
 
@@ -4760,7 +4760,7 @@ static struct cil_list *cil_classperms_from_sepol(policydb_t *pdb, uint16_t clas
 	cil_list_init(&cp->perms, CIL_PERM);
 	for (i = 0; i < sepol_class->permissions.nprim; i++) {
 		struct cil_perm *perm;
-		if ((data & (1 << i)) == 0) continue;
+		if ((data & (1U << i)) == 0) continue;
 		perm = perm_value_to_cil[class][i+1];
 		if (!perm) goto exit;
 		cil_list_append(cp->perms, CIL_PERM, perm);
-- 
2.31.1


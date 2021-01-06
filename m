Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75876C433DB
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 18:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4330423124
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 18:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbhAFSoM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 13:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbhAFSoM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 13:44:12 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5C8C061575
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 10:43:31 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id v5so2689481qtv.7
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 10:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JXTEbtSscr05B8RP5AibnnCAg5mK1+GyRlt+y/xSi0c=;
        b=oH6SG7Cksnb1Vzf1WCpJWbpq3MJzvQ7GN4EaUlW2vTSiDI0UAyL3A2/vXbCv6JtMtL
         O5t6SLy6F317pebyUp0gBFmlX19+DS49Y3fuP+bfoOTIk2BrlYOCJwunRaLhNfQWBJn6
         en4G7xSHFv3vnKfcRS7qvzidn7QmpHhKznERDZpEMMz5f39i2PDi4GrFMAfcLiRmVNdv
         XpqNcOLr8oDJa2oe4oaIGDVICew8vtzHcU4P2F4SCvvUkF1g6NY3NpcF2y4LHbt6Atxz
         /ynfRPSLioMSziuQgruuUbyzwYdhf2Tezp0U/Mykj+KNwBY2W8LUQ+ipbdLF43SrsQDZ
         a4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JXTEbtSscr05B8RP5AibnnCAg5mK1+GyRlt+y/xSi0c=;
        b=WC0yhG6t0SY57xkrmQZ75I9Ji6gnIzEIKkfg8JCF0cKlvirGAnDf/2U0Rn4Md0Fr75
         x0MJFvKvaVYY3kTPEqN+DxjRMDkLK1m0WP6TYK1S29VInr7V08BiyXKZngAG0VtIes2O
         cqOPKW5JAT3xVNYAVOOUQJLj7PY64XEISCUdhmHGwB+8M18c83lDKqF6wvaVwLmM2slH
         uLwyz3qDsiv6WnumgeioOdX3KQbROPY4T/OC9YApbMEiFCxGbrFvebwfp6M3CPs/7Xnv
         3A2M3tXh5Wt+aSW/nB59yjLKdqRCgxCnQnVYLSGqC97OosA7AykFQjaoHakvyMdKUaqe
         FpeQ==
X-Gm-Message-State: AOAM531Enc4iCmNTtiPIT6RM6P4SJHnceZbCNVCexIo95uy17B5RlTPz
        NdLRLYeik57lTMJk15efLTumo2BNC1c=
X-Google-Smtp-Source: ABdhPJyyxDGWRAnN/9/TjLGmmoGWgb2UrMaEH2x6mxOR6/83wDfCGqoPemHbu4t9jzu1caqiWxQBIw==
X-Received: by 2002:a05:622a:8b:: with SMTP id o11mr5082461qtw.282.1609958610707;
        Wed, 06 Jan 2021 10:43:30 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id j29sm1523846qtv.11.2021.01.06.10.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 10:43:30 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2] libsepol/cil: Update symtab nprim field when adding or removing datums
Date:   Wed,  6 Jan 2021 13:43:25 -0500
Message-Id: <20210106184326.272726-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This field is suppose to be used to track the number of primary names in
the symtab. It was not being updated or used.

Increment the nprim field when a new datum is added to the symtab and
decrement the field when a datum is removed.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_symtab.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/cil/src/cil_symtab.c b/libsepol/cil/src/cil_symtab.c
index 2970b863..579a888e 100644
--- a/libsepol/cil/src/cil_symtab.c
+++ b/libsepol/cil/src/cil_symtab.c
@@ -92,6 +92,7 @@ int cil_symtab_insert(symtab_t *symtab, hashtab_key_t key, struct cil_symtab_dat
 		datum->name = key;
 		datum->fqn = key;
 		datum->symtab = symtab;
+		symtab->nprim++;
 		cil_list_append(datum->nodes, CIL_NODE, node);
 	} else if (rc == SEPOL_EEXIST) {
 		cil_list_append(datum->nodes, CIL_NODE, node);
@@ -111,6 +112,7 @@ void cil_symtab_remove_datum(struct cil_symtab_datum *datum)
 	}
 
 	hashtab_remove(symtab->table, datum->name, NULL, NULL);
+	symtab->nprim--;
 	datum->symtab = NULL;
 }
 
-- 
2.25.4


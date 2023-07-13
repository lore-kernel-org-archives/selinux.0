Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7501CC00528
	for <selinux@archiver.kernel.org>; Thu, 13 Jul 2023 18:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjGMSIc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jul 2023 14:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjGMSIa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Jul 2023 14:08:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCC826AF
        for <selinux@vger.kernel.org>; Thu, 13 Jul 2023 11:08:29 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9928abc11deso142924366b.1
        for <selinux@vger.kernel.org>; Thu, 13 Jul 2023 11:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689271708; x=1691863708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hxyjIN5Hv7j9NYO3maV/9uRAjdEBeMg6Fe34AL4IiU=;
        b=Rsr4pDZbL4EHf/TT5JS4mRvY48FZPNs57Gg7lODNlGlKZjvXTFvuK9tKRa7y41zmP8
         xjmlxYfDjJQABA5PNpgcpLSE0NmKhayQti1yfk1Tgj8Oyhl9t2gpN4X7WTTgVYZUkBIT
         QOm/CYY1dUu+do23dd4w1xIKmIF20PQjfaxzs8XAgVV99dRhHDj/euNkEFw/e4h2GMFJ
         mHPdVVBVNQH72wYGP1xx7m8i89QbQ5akHBqs+ZrhXwse9mz7+ZlT6BIx2xRjgeGoHjY6
         XOI+nHZiX/EsMMqiQO9aa01Xh4KXUMPAwneP8EPR+RqFF2XeFfWASELYMWPeHa9rKtPQ
         vCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689271708; x=1691863708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hxyjIN5Hv7j9NYO3maV/9uRAjdEBeMg6Fe34AL4IiU=;
        b=hSdPYv7U3WggncLkDpfD81/sUj0GCpSirREiZp9oSJRTdfoQp5QRfhn4s9HACETZtT
         sPFrtw7BGWqjzJrB3R7TeH3Scb4vr8/47NhnT/gcMitCxHthvqKASBE+IaNRt0YK7A3B
         mPK4FRm2azl2vlczNoH0nhjuXK+6yF7ljRyafGs2bdtoPr5gTa21gnvIQUeaGh9hQopr
         Fxg+jppZ7LwlolaWc63yj4pLglb9ukbteYFCYrQPmk2jjvXs+B0UqG2l2tQVykuDwVgu
         xl0RmzfQA8rtr3+4Ye2dK9Oo8rW54QWvemS5Urf5wajgVMsleRuBifsW4Og7rbdrqulk
         LJxQ==
X-Gm-Message-State: ABy/qLbYNV1UQUsdWhQnB5Np1aAWuuvIyrjc6mmT1DkZv3tsUv0LwKf0
        Di+9VBpwJ3QI4AYnvecZhhPsoSC7yvVxtCXY
X-Google-Smtp-Source: APBJJlFufJUwgpgkAgnhWrOiGNiGHU0YVI40xehMete+AipaQwS7Lq3ovlme+l9Oql+w/aiNygla6Q==
X-Received: by 2002:a17:907:3fa9:b0:96f:d780:5734 with SMTP id hr41-20020a1709073fa900b0096fd7805734mr2480937ejc.65.1689271707986;
        Thu, 13 Jul 2023 11:08:27 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-010-190-210.77.10.pool.telefonica.de. [77.10.190.210])
        by smtp.gmail.com with ESMTPSA id q11-20020a170906940b00b00992d70f8078sm4270014ejx.106.2023.07.13.11.08.27
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 11:08:27 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 5/5] libsepol: avtab: check read counts for saturation
Date:   Thu, 13 Jul 2023 20:08:16 +0200
Message-Id: <20230713180816.101924-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713180816.101924-1-cgzones@googlemail.com>
References: <20230713180816.101924-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ensure counts are not set to the maximum value of their type.
Also limit their size during fuzzing to prevent OOM reports.

Reported-by: oss-fuzz (issue 60572)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/avtab.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 9c7daf8e..cb2ca06a 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -461,6 +461,8 @@ static int avtab_read_name_trans(policy_file_t *fp, symtab_t *target)
 	if (rc < 0)
 		return rc;
 	nel = le32_to_cpu(buf32[0]);
+	if (is_saturated(nel))
+		return -1;
 
 	rc = symtab_init(target, nel);
 	if (rc < 0)
@@ -736,7 +738,7 @@ int avtab_read(avtab_t * a, struct policy_file *fp, uint32_t vers)
 		goto bad;
 	}
 	nel = le32_to_cpu(buf[0]);
-	if (!nel) {
+	if (zero_or_saturated(nel)) {
 		ERR(fp->handle, "table is empty");
 		goto bad;
 	}
@@ -909,6 +911,9 @@ static int filename_trans_comp_read_one(avtab_t *a, void *fp)
 	key.target_class = le32_to_cpu(buf[1]);
 
 	ndatum = le32_to_cpu(buf[2]);
+	if (is_saturated(ndatum))
+		goto err;
+
 	for (i = 0; i < ndatum; i++) {
 		rc = ebitmap_read(&stypes, fp);
 		if (rc < 0)
@@ -951,6 +956,8 @@ int avtab_filename_trans_read(void *fp, uint32_t vers, avtab_t *a)
 	if (rc < 0)
 		return rc;
 	nel = le32_to_cpu(*buf);
+	if (is_saturated(nel))
+		return -1;
 
 	if (vers < POLICYDB_VERSION_COMP_FTRANS) {
 		for (i = 0; i < nel; i++) {
-- 
2.40.1


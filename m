Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F9DC433EF
	for <selinux@archiver.kernel.org>; Thu, 31 Mar 2022 14:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbiCaOtv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Mar 2022 10:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbiCaOtv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Mar 2022 10:49:51 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9BE21FF4A
        for <selinux@vger.kernel.org>; Thu, 31 Mar 2022 07:48:03 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b24so28424232edu.10
        for <selinux@vger.kernel.org>; Thu, 31 Mar 2022 07:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DnxeOC/iqC7rz9jn95qEhbz9uT2NqVWBAF5YEROBsUE=;
        b=lrZwlfGA31LjVJPO6dKpIIPwDnsqD3/f8tepasVOZxTu1b/S45UKe7cJO0hmJuwEGp
         X/TvewBiviH9I9NzB7ixtSxXD/PO6oZrAt/qqyAKZjlR4hKenNGNrxX0qqOMwEp1yF69
         SCjYwgp3v/t8JGrpH7hHDfR2o+D4hRLkAOsnJMqDPmt3gkxNnoLqXi+7ie7M2NStKmaG
         ZY+syILHLElEqQQfAk1gp1BNmKO5Qc/wOwwbT/N2eg21D7OB4+87KbWHFoyW5CktS/iC
         ZL1t5Y1fFvLtPD75YJeyhVN71/rcrsDCpcihxdjjj5Kntejn3FcE1G2/Kn+uTHRqssho
         oPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DnxeOC/iqC7rz9jn95qEhbz9uT2NqVWBAF5YEROBsUE=;
        b=PpYRVtDFZCpP7Sln7o90gB4+FBwXJw+9ulGlex53Eaj0m2W4eDLqLqHLi3D8Jyfd15
         UB5oqiVyyg5tPmaKssDAgDIZGoUeb54sthegj2jrTuyJMCFniPAqrslBnmbGvyUrgjjT
         5hR3YD6MsvETEBGx0nc7iBbUz+OamiosQ9UVZ2foL/IxGIs7aJUDWyeEDcXd34J7bZKg
         43XL6xko6h1GBcSTsfxmlMFOQ57rR2GZv0XD358OuvVjiu0a5bIoEfLgFIvLxwZpiTvP
         RV6p2Ahgzp+GSnm2nrqvzC2iyz3LARnEVU7+MT9BoXJTXISj+jb0WoGCISZQfG1gDilL
         LNbQ==
X-Gm-Message-State: AOAM531X54vLkbg3KMGQ3VmPJJ8gY3ZM48ROWFNH2AfCbS50MToWOhlE
        8PSTxcCO/fIEvEa/7rmBgSbkQuvuJjg=
X-Google-Smtp-Source: ABdhPJxp/hQFpU97PUtRmnoAT8g+VvcVnOsyi5eVZAG0pPiAE5jMzEg4wYRINg4zdu8ktkgtBZCgbQ==
X-Received: by 2002:a05:6402:1255:b0:419:3808:3d98 with SMTP id l21-20020a056402125500b0041938083d98mr16891672edw.134.1648738082356;
        Thu, 31 Mar 2022 07:48:02 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-006-065-043.77.6.pool.telefonica.de. [77.6.65.43])
        by smtp.gmail.com with ESMTPSA id r3-20020aa7cb83000000b0041b573e2654sm3163368edt.94.2022.03.31.07.48.01
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 07:48:01 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 3/4] libsepol/cil: post process pirqcon rules
Date:   Thu, 31 Mar 2022 16:47:51 +0200
Message-Id: <20220331144752.31495-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331144752.31495-1-cgzones@googlemail.com>
References: <20220331144752.31495-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_post.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 7f33cd9e..714ce227 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -2434,6 +2434,12 @@ static int cil_post_db(struct cil_db *db)
 		goto exit;
 	}
 
+	rc = __cil_post_process_context_rules(db->pirqcon, cil_post_pirqcon_compare, cil_post_pirqcon_context_compare, db, CIL_PIRQCON, CIL_KEY_IOMEMCON);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "Problems processing pirqcon rules\n");
+		goto exit;
+	}
+
 	rc = __cil_post_process_context_rules(db->iomemcon, cil_post_iomemcon_compare, cil_post_iomemcon_context_compare, db, CIL_IOMEMCON, CIL_KEY_IOMEMCON);
 	if (rc != SEPOL_OK) {
 		cil_log(CIL_ERR, "Problems processing iomemcon rules\n");
-- 
2.35.1


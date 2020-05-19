Return-Path: <SRS0=GWJJ=7B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93DDC433E1
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 14:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC2F20709
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 14:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYkgRAKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgESO37 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 May 2020 10:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbgESO36 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 May 2020 10:29:58 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B56C08C5C0
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 07:29:58 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z18so11284571qto.2
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xL2TIrUlx0CC9V5bcMS/DwAx+VMbFu+oOlX7awkHC+o=;
        b=QYkgRAKpv8ZgNLf7JtJBr79wzfInjgwvoANXGBPb6BqQTigJeRA7mJsKgE4fTgHDFC
         r1naN4rbK/NNJINJP/SNjm6jR7bDlhXf8Zoe3Lz1YhwQ/zcTPvaS0+XQWCZotMCl1aZG
         rAWH+j1m+dSgTXIKoXoiOxv3/FIk0m17iaJLM3mbAs92p0JsS9ew+oJnEya4JdtxZvbN
         v/Fo3wMlfjkJ638mMy7rC06yFaaGMZ2ng1D/1rdMKeIAOJ13Gb9Df+vUMWSa1hVYfTLN
         2/ruGpA34AfHZYgBsfJeS8HaGk+45FVWBC/huTgd/INrONRxv5PQvsM5Re/FcvzekmDR
         6W9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xL2TIrUlx0CC9V5bcMS/DwAx+VMbFu+oOlX7awkHC+o=;
        b=TlbJ7wkaF37j+6yn1lRbiuqiuR50iueECuVsHHN+wbFrF+dhKvUV6vZ1cPh4wgOYLI
         CdWTotCwwKe9ZnheSftIcDXz54C4uKG5Z29GH0OnBqU/coTlwWuYfts91ZgO7U4tBcnl
         s7SyUr6nOTAdY12vU9kJJEtyoKL4xsk1bi1vLCi73iEw3SX7LQG8Q+oeHuA2JFER4Q6C
         mD8L+8DZyzyWlVsgI4MARSIU7zYib/3khuUkq3PJJ4iXCwhdk22IGS7FkZnVxFsHKzPi
         kFXEpzsaJAmMWxEkOU8QGXBBjuIq1/+fT6xs4LWexeljYFpQCmg/DSHrHlTEWL2GIzTs
         KD+w==
X-Gm-Message-State: AOAM533BVmevYUxY7CHAlKFMzIPCKFgkDC7leaAjK79aQO0OPFV4Y+Cm
        5lvYWBL27uX2wdxbqeIRKRJBDPdUId4=
X-Google-Smtp-Source: ABdhPJzlbZbCSLR5PxKjWwmECylH2k5BoJQ6cbWhjUgF9Zy9Zdp2WyxhvbTVQsjbLyu5bQZLop3tDg==
X-Received: by 2002:ac8:23d7:: with SMTP id r23mr22828670qtr.111.1589898596873;
        Tue, 19 May 2020 07:29:56 -0700 (PDT)
Received: from localhost.localdomain (pool-71-166-99-106.bltmmd.east.verizon.net. [71.166.99.106])
        by smtp.gmail.com with ESMTPSA id i41sm12693724qte.15.2020.05.19.07.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 07:29:56 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH v2 1/2] libsepol/cil: Initialize the multiple_decls field of the cil db
Date:   Tue, 19 May 2020 10:29:45 -0400
Message-Id: <20200519142946.76861-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Initialize the multiple_decls field when intializing the structure
cil_db.

Issue reported by: Topi Miettinen <toiwoton@gmail.com>

Fixes: fafe4c212bf6c32c ("libsepol: cil: Add ability to redeclare
       types[attributes]")

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 4a77aa9c..a3c6a293 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -459,6 +459,7 @@ void cil_db_init(struct cil_db **db)
 	(*db)->preserve_tunables = CIL_FALSE;
 	(*db)->handle_unknown = -1;
 	(*db)->mls = -1;
+	(*db)->multiple_decls = CIL_FALSE;
 	(*db)->target_platform = SEPOL_TARGET_SELINUX;
 	(*db)->policy_version = POLICYDB_VERSION_MAX;
 }
-- 
2.25.4


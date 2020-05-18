Return-Path: <SRS0=hs+S=7A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870E6C433E1
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 18:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C6C20829
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 18:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xvwni5ae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbgERSNJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 May 2020 14:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731456AbgERSNE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 May 2020 14:13:04 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5ABC061A0C
        for <selinux@vger.kernel.org>; Mon, 18 May 2020 11:13:04 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id m11so11215009qka.4
        for <selinux@vger.kernel.org>; Mon, 18 May 2020 11:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xL2TIrUlx0CC9V5bcMS/DwAx+VMbFu+oOlX7awkHC+o=;
        b=Xvwni5aew54fTtfmFNNCXytQiK3HisOtJ5HgmbfuYRtGsZwDaalXnkZmyIE8I2RW0T
         F2d5tpdqRf/dYjvxmmmHgYQ78iHZ2re4POJY/q8tJRTOD75gxclmz9qtPrTi8Lbfh34v
         ALMXZsK1m52mWTD6+cTOrq1ZSShGv2DeiwZZj5DBnWER2l46ymgBdbDgCHm8C66b+IbY
         Z7iiChSuZrg7+H8wdyXNkQw43xHm5kiOx8HU55GOHGYG5yVT8NfCSz/w8Uf9INyhF1iY
         UEZ6IcFH2ckH5wpGKLO9nYD65txnmsYNn/iQuPfcfz0Ev643rbXEVs+xNLyBe91ekScn
         XaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xL2TIrUlx0CC9V5bcMS/DwAx+VMbFu+oOlX7awkHC+o=;
        b=KTsRLegI1nWmcbvA0tUbnmRAeE1E/OnjapicDzs0M1hnFnYGt+UH8pCPFHFgAZ7EUH
         B1kKl7uYYU5sI9D44HxUmpdA/81KoiBwe57hCsjYY/qu62Ns6HHTSk0awEiOT4w4My2R
         SGCBiMAHjvhgMiwq8E42EonWSNwjv5WmOZiAz8CpderyFby94F+fmUNsfWsVf8kuOvNn
         y0Le87PUZnNAQxD7YMXidtJsyealKd2o+VrfLKukG8kTb27eV3XPAyloNCC4DM+o5CkA
         SeM1mqrc8WeQoUO8/25R4NuuUbGL3vUl4lenzRgaoQnvC+8QVE+qsUh8V3En0QV0oYN4
         XWjw==
X-Gm-Message-State: AOAM531ZvFRFI9r9exNp0x6vELzcw+x5YU+jDH72A6N9n5HaiUjsptlT
        kTr+0cPMYFL8e6yp3VC+MUFJTkKClHw=
X-Google-Smtp-Source: ABdhPJzSzoHr8uqV6k7Ha7BnzE4bvGTtsoE91qj83Hps8Cd4gx9O261y26OHhaOxbYx2LjwN4fME4A==
X-Received: by 2002:a05:620a:641:: with SMTP id a1mr17264683qka.298.1589825583372;
        Mon, 18 May 2020 11:13:03 -0700 (PDT)
Received: from localhost.localdomain (pool-71-166-99-106.bltmmd.east.verizon.net. [71.166.99.106])
        by smtp.gmail.com with ESMTPSA id i24sm9830808qtm.85.2020.05.18.11.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 11:13:02 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Initialize the multiple_decls field of the cil db
Date:   Mon, 18 May 2020 14:12:51 -0400
Message-Id: <20200518181251.31862-1-jwcart2@gmail.com>
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


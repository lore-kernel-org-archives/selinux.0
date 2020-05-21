Return-Path: <SRS0=ZZHY=7D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530D2C433DF
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 15:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3038D204EA
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 15:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mo+y+S67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgEUPZe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 May 2020 11:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730437AbgEUPZc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 May 2020 11:25:32 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE4CC061A0E
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 08:25:32 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i68so5779043qtb.5
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 08:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XioUBqoLdKBCf+xO282yrwQHVX4FycRp1HUmQOu6O7g=;
        b=mo+y+S67tgkNom76FsOEkrN5bHqfLGsdJe3MOC3Kf3Y/cgwGeHloXEv26buc0rCNLm
         XUSVPOqhc7g8Pp0ZiJPBFd+U3PowRr2lOaaNSztKlIBFrq/YGrAQUMpBa41R+tmcRlF1
         wTB7716fap6Qvn9OrpiqsnZvZm8ps+LDRV0TNwymB2Pbmi/bB6YfblbGoc6udNPVJvRh
         7157EKt9aouXaUVMHtyQzdGFpVHQJt7Ils9hSGIih7oRmQhtei45QyhBe4VfCzzE7dcs
         X0RmNEtvZERzkqce4fQzIqi2qMQif8PIney5ArZD/XXuz3jkGXY+vLRI7L+yqQHL3TJu
         tp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XioUBqoLdKBCf+xO282yrwQHVX4FycRp1HUmQOu6O7g=;
        b=VOH5DRivOYgR6JmVpDzMCVzrMYiumWYt35bRaBbJ91QWK95WnZdllTmhpV4J/ynb0Q
         1tXc8nNXtavLSFVlK9jrWDUKAbWHX+tRrMk2DVon90mVs3X9wnTh6hKaznxCdtWseeoa
         MFWMIPqSFp+gdii9x8pDr47/g2FqNq45feL7xbxVhmxNaw2SQ8Q8cqULpBawL9EyR9qa
         2i6/2I+zrny8OGYr405kBuYM2deTGjN6x55QDEOZaRK5eMCzSsbTjIEPC7Hf7vMdaofA
         hYZZzDWTP4nz3/Dt5KwwlJ8aObI5cx2zu2edRmRC7gRmArGp7iNtQW0UDUzyuAhy4P7L
         TVPg==
X-Gm-Message-State: AOAM533+PMP4jD6qOt+uQCn+OTx/pNQAAWyQV7xWnjtOELqQR+E5lWDC
        W+Ikr9CoCU7TzHkmsqtEdAR+jgSHfiI=
X-Google-Smtp-Source: ABdhPJwY9sQGgsDsbELpq4Eevaxh1f53UI1KiVU7XaWNpCNKwLEf3Vy3NIlFzlnYIEVq2fAcu3qd6w==
X-Received: by 2002:ac8:3873:: with SMTP id r48mr11162230qtb.240.1590074731467;
        Thu, 21 May 2020 08:25:31 -0700 (PDT)
Received: from localhost.localdomain (pool-71-166-99-106.bltmmd.east.verizon.net. [71.166.99.106])
        by smtp.gmail.com with ESMTPSA id z19sm5840135qtz.81.2020.05.21.08.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 08:25:30 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/3] libsepol: Write CIL default MLS rules on separate lines
Date:   Thu, 21 May 2020 11:24:46 -0400
Message-Id: <20200521152448.148333-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When converting a non-MLS kernel binary policy to CIL, write the CIL
default MLS rules (since CIL requires at least one sensitivity,
and sensitivityorder statements) on separate lines.

This improves the readability of the resulting CIL policy.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/kernel_to_cil.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index ede78a20..cca77251 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -777,9 +777,9 @@ exit:
 
 static void write_default_mls_level(FILE *out)
 {
-	sepol_printf(out, "(sensitivity s0)");
-	sepol_printf(out, "(sensitivityorder (s0))");
-	sepol_printf(out, "(level %s (s0))", DEFAULT_LEVEL);
+	sepol_printf(out, "(sensitivity s0)\n");
+	sepol_printf(out, "(sensitivityorder (s0))\n");
+	sepol_printf(out, "(level %s (s0))\n", DEFAULT_LEVEL);
 }
 
 static int map_sensitivity_aliases_to_strs(char *key, void *data, void *args)
-- 
2.25.4


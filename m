Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45278C61DA4
	for <selinux@archiver.kernel.org>; Thu,  9 Mar 2023 21:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjCIVvf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Mar 2023 16:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjCIVv1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Mar 2023 16:51:27 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137B0FCBF8
        for <selinux@vger.kernel.org>; Thu,  9 Mar 2023 13:51:24 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id r5so3747962qtp.4
        for <selinux@vger.kernel.org>; Thu, 09 Mar 2023 13:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678398683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Du8qZb3Y09UKSedGq8cZEDMngsx3l3raY/byiezZIqI=;
        b=EIax6P4K9p63BOrRru6zPtqIZEJXxnJHtlNZbVOqPDAXJfiFr3iTotY49O/Fuzk6xG
         nUMB0rhD8Hj2wRg2wH163QnmdiR8fbUn9SRBP7UrLaMkJ/p9NLs1CLC2ttwugVjgFPHM
         W6/3TrdZEM0pKX+dKPdt0vy7VtvSTksQkZcwkTZTx4kMdhPha0j+c5yMfi1JowdzoRZX
         Qd7GSe3/85YlvKezTX9Y1fd8hDdWjPlvIEyGA/2XGss1ec9H9fzr+t7ipMr+6nqj32Pv
         4SWUB8Qb3Nb6s39TNkFZeBHi13hC8duPIaTa2yKs1xFNxxVgy7/rTW/eNsjieAlrGZoO
         HgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678398683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Du8qZb3Y09UKSedGq8cZEDMngsx3l3raY/byiezZIqI=;
        b=skp3nFY12OMmwclpY0GdCr/55oRvrX+CGLsUuF9Vhe6y4gUXAH/hAfHdGoQgLTzoEv
         XYxf9NuJxKQXkKizO4ko8HTwcHbj5kMn00ITNOFoEOJQmAV/rYQ/fdFfjVChIBi3l0pM
         uzxd9QgG6ye8NtR3Vtxu1gPhRtGvSEj34tmYWj40qzXms3cZYK9hrp1/x2jQWPtUyXMA
         yjsTgIMpYoJgm3sRo2ATx0NLTUsoZTyaasOWS3DI7oSZxAbL/2mt8JVo+ySbCSyao8p0
         N0f9+dUS4KnbjaJzsNRfrV7bj2dtBb3GrAU98e1G4VOUmSfTE+hcTY1lXeEQr1bMgZkV
         DuxQ==
X-Gm-Message-State: AO0yUKXegFPk9Vbg42QG3qk8EdZ4uHDPZ+YX1OPLMJd9T/Z14SoKz2gN
        rcy34Dt8kONYOFZI4SAsrpx1iTlptbg=
X-Google-Smtp-Source: AK7set8ZkzKLPGWZQtJnGYfpOjJF8RGI5uD0Pv2NaUC6OmcLQ1d3ePjkqT6kWYFGuCRFyfaz2UbAwg==
X-Received: by 2002:a05:622a:1c8:b0:3bf:ca4b:909d with SMTP id t8-20020a05622a01c800b003bfca4b909dmr38584886qtw.0.1678398682976;
        Thu, 09 Mar 2023 13:51:22 -0800 (PST)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id m17-20020ae9e011000000b007422fa6376bsm25731qkk.77.2023.03.09.13.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 13:51:22 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 6/9 v2] libsepol: Export the cil_write_post_ast function
Date:   Thu,  9 Mar 2023 16:51:11 -0500
Message-Id: <20230309215114.357831-7-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309215114.357831-1-jwcart2@gmail.com>
References: <20230309215114.357831-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/libsepol.map.in | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index 844924fc..6ad68f0b 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -289,3 +289,8 @@ LIBSEPOL_3.4 {
 	sepol_string_to_security_class;
 	sepol_validate_transition_reason_buffer;
 } LIBSEPOL_3.0;
+
+LIBSEPOL_3.5 {
+  global:
+	cil_write_post_ast;
+} LIBSEPOL_3.4;
-- 
2.39.2


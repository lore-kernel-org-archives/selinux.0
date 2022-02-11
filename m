Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E903BC433F5
	for <selinux@archiver.kernel.org>; Fri, 11 Feb 2022 18:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiBKSrE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Feb 2022 13:47:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiBKSrE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Feb 2022 13:47:04 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7CF337
        for <selinux@vger.kernel.org>; Fri, 11 Feb 2022 10:47:02 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id o10so9093896qkg.0
        for <selinux@vger.kernel.org>; Fri, 11 Feb 2022 10:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQ9dLE4qRCZ8PE+mGm5akTvNPqhS4+bDbb1b5kZNXMQ=;
        b=oCQfmzNaSko79hHOsIlsRz38dWe9Q8UFHZoAacwx7w9FwRMq0/N7XGY2HLq/Jekmbc
         OkubU7HfDtrZMYDmvgonHD1utiAcR4LvqSsWDAsIS0Z6XdjlDulkJJKs9arySVnMWP6L
         f3UHPI5VPzOOy8MctcKikNdGti8agirpq+/9tKWxZPiG3XnEysBgQIm83yx8JJBXB8eG
         J5Fe1R9AxZkQavN8vLW9EZmrb1jvuWkD1pkgF2ngQjki+TFUWzN1MMaNr8USGE8+TxTc
         qEwSbnWcPGrFaMROOZSbjyA1Lo6PDD8hRZPVVithSffKZpeiPfOVwUV9LRcB7sspsjbj
         A/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQ9dLE4qRCZ8PE+mGm5akTvNPqhS4+bDbb1b5kZNXMQ=;
        b=ECDWLBi/h9fB59m8qgGQyy25Wc+wcvR2mXSEWuXmNSzcdrYYDADr+BNUDVj1ZlmpHE
         /GEsaE/h301dh/O3+ZE+7koqvHe7HWcJaLoGS/QUrm9BEg0ChnDBjxoy0upQgIjdarFq
         YeD4joVM/vpOFfu7yZpOgVN1oAUDiMJPRQwLBD8wHsk78N9w+14XAHN16AmAkUWxYv1a
         li7qyzjb+hvNpBw7dLRbm+Ajwlzc/X50LdHigJi2xGUqSVcUYmTOOEvoZ6XS8IPwTgDM
         J8sdtfds35evKj/2mji7FdWPPidwXPg9Agr3e82j+Lf91nvD3r8G+COJDrGllE16tLa1
         DfZQ==
X-Gm-Message-State: AOAM533ZjN9pIYnOZH2Y+7sApj11YX9BVrjQf2zx3UGIPJy+ODrCGZKN
        ZropeWAj9M8ZUca9cVxn6Mn0evhKd4M=
X-Google-Smtp-Source: ABdhPJy1yjCsScotrOSNvwh6wSyWp4F0ZLz8Im9TS1U21JSqIn1A9LUv5QBqU5kUB86qjHVHYKzihA==
X-Received: by 2002:a37:bfc3:: with SMTP id p186mr650299qkf.440.1644605221693;
        Fri, 11 Feb 2022 10:47:01 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id t1sm13668767qtc.48.2022.02.11.10.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 10:47:01 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2] libsepol/cil: Don't add constraint if there are no permissions
Date:   Fri, 11 Feb 2022 13:46:49 -0500
Message-Id: <20220211184650.535016-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since CIL allows permission expressions, it is possible for the
expression to evaluate to no permissions. If this is the case,
then don't add the constraint.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_binary.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 4ac8ce8d..468fb595 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -2823,6 +2823,12 @@ int cil_constrain_to_policydb_helper(policydb_t *pdb, const struct cil_db *db, s
 		goto exit;
 	}
 
+	if (sepol_constrain->permissions == 0) {
+		/* No permissions, so don't insert rule. */
+		free(sepol_constrain);
+		return SEPOL_OK;
+	}
+
 	rc = __cil_constrain_expr_to_sepol_expr(pdb, db, expr, &sepol_expr);
 	if (rc != SEPOL_OK) {
 		goto exit;
-- 
2.34.1


Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E526FC433F5
	for <selinux@archiver.kernel.org>; Wed, 29 Sep 2021 20:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB75861159
	for <selinux@archiver.kernel.org>; Wed, 29 Sep 2021 20:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346709AbhI2U0m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Sep 2021 16:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346361AbhI2U0m (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Sep 2021 16:26:42 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4029C061764
        for <selinux@vger.kernel.org>; Wed, 29 Sep 2021 13:25:00 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id b65so3564318qkc.13
        for <selinux@vger.kernel.org>; Wed, 29 Sep 2021 13:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ugyveUtxMtB5pIitUNl12Ivv6agkSLLpH1Hobn1Osfw=;
        b=VZ9iFgtqOgRGXFWp8VOzfEqCqvZdJs4FRa2Hv+Xg1Z1WMTC9/PQPAOW1TztSHJku/P
         tDEbqyUOQLwtPUrn19WvA6MDrz2G76AWV8k9oNH3llNqEqd/qijKIHXQC6WM2m8W5Od9
         /oPuLecSP+ImGu8pqpQGk/vIBFVhRwOIgh+JkfYyA3VPK6h8F5+Mz2WPP0kyY8u3VbRX
         H/Mfu0RjPAF5j2yb/U3q9OE6N7s1QvB991enOGq4bn5zYBFmF6CJ3PdsHbkKIIKydfZS
         z/NhQUJpNe/pgJMLpLDTKjkAyscIPEtNB7lJVeQMXI5bUETapCxFHuhdCrcrY8hwpH2h
         mS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ugyveUtxMtB5pIitUNl12Ivv6agkSLLpH1Hobn1Osfw=;
        b=u6l/Vujivu+Gzf6ohqhdprnUAywl22DYpLh+S4JfBk8d+BXqtH/bqZ0l3kWQeHjROr
         Bw3dQYdw6UkAOkw/5TFKcOFfBf47veFy5HyH/orrt9wFiCJ6Or0qdj1tpGhNhCyxr60q
         iD2x5IbEl+bRxchKDl3dLmLmOBMNtzQ7VgcOAVPpBwsNCEtV67CW9E7t04Shw73ImHVZ
         w/2n9dTjsCnojZgBphqSGsrXhOXV2K7dhSPcYs5vu6803W15OvZmEpfRJ7QGl0WfVs3n
         oG1/FJ6GQdQE6TAjwrxe7F5HXmSqjXhMZP8CvvAnfOQdfgWeC4RMDT4Ny/ozsxTWsgLA
         AZ/g==
X-Gm-Message-State: AOAM533bvMMvoV2j1SrnKY/fgjkiQtPtxiwWDn+kN87AaPCn4CPusF1g
        /GJraku21jnSV+ijNLGfgsMVTqnzWWo=
X-Google-Smtp-Source: ABdhPJyXbmYrLhnFfm2+QU5DcnOrN5OXmNXS17dgtLy6lCq/SuwEocAJkEXvM5HIaqdMYHWP3yeJ/g==
X-Received: by 2002:a37:5f02:: with SMTP id t2mr1610648qkb.264.1632947099822;
        Wed, 29 Sep 2021 13:24:59 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id c3sm471998qtp.58.2021.09.29.13.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 13:24:59 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Do not skip macros when resolving until later passes
Date:   Wed, 29 Sep 2021 16:24:54 -0400
Message-Id: <20210929202454.136401-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since only tunableifs need to be resolved in a macro before the macro
is copied for each call, macros were being skipped after resolving
tunableifs. Statments not allowed to be in macros would be found during
the pass that resolved tunableifs. Unfortunately, in-statments are
resolved after tunableifs and they can be used to add statements to
macros that are not allowed.

Instead, do not skip macros until after the pass that resolves in-
statements that are to be resolved after block inheritance. This
allows blocks, blockinherits, blockabstracts, and macros that were
added by an in-statement to be found and an error reported.

This bug was found by the secilc-fuzzer.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 2cf94368..e97a9f46 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -3946,7 +3946,7 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 	}
 
 	if (node->flavor == CIL_MACRO) {
-		if (pass != CIL_PASS_TIF) {
+		if (pass > CIL_PASS_IN_AFTER) {
 			*finished = CIL_TREE_SKIP_HEAD;
 			rc = SEPOL_OK;
 			goto exit;
-- 
2.31.1


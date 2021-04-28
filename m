Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7BBC43461
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 20:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F1F6143F
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 20:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241815AbhD1USy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Apr 2021 16:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241817AbhD1USw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Apr 2021 16:18:52 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C449C061573
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 13:18:06 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id l2so13557132qvb.7
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 13:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lK3M6lKCNvW9RdLRqhD0qCMNesnY2d8SLuHbTKLFzhY=;
        b=s70512f2NtBJks+/w3gnYF1nG+GjWmbMI3aFlm2CeFkp8mosA8PerLLu+loRqpRzJB
         P1PrQmpEXmT5uDdrgqa4Hl6n0dcLhMbQRK3+c31eZtyHsNyrB23Ef7E+jUrMgp9XfPAM
         vUka4wUGfV/SVv89OEH7rdgBCwWvVhwJngw8Y8L38L97uC73NbLPmIM1eeoAHraZTsMm
         +rFSuJj1MCzOFhBifGCz17to7+SMzE4eqZiehuY54dlFtnjUifc4sQC4Q/7GiQktHCA5
         l1tDybEU8dV0hPXocFVVi06E47AD5R5nJJNO1SPQvX+RW0ARY23Hw/K+MWjEdb95uXDo
         8euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lK3M6lKCNvW9RdLRqhD0qCMNesnY2d8SLuHbTKLFzhY=;
        b=iAOj/lbtHQD3kon7b90USrxUpQuzP1SFQWg5EcanfzgoDEWCLuZ8oSSszbkFKKe8Kg
         PUINP9HJA14PvOCWeam3KN8T7SJmYD/YIZxc5TnNoQIunWkM1qO+yQI8a9su9lh+1jUa
         Ru+FaYq9H6ShoGXmhuUNapf+zGAPo3Rc2qvxQTQLA3IK8dPL8AsWiV8YiqdecoDcoL1s
         9Xoh5u11/IAlfFl6Dra3DRCyUrk61UFMH8uh4CiA8MfFWRdNvQ2WS2L0JmMNCWDbvjfZ
         lKmbcKBT2Fe9OseU+pD7SDypCwVPhO2xSilJKZ07/3VQMPM7PzC5t/B28ASG9J+M0hCO
         nGXg==
X-Gm-Message-State: AOAM531ezGJLfFtiKJGecmhsgwRf8j2C8qMqOufMbA+f9wjNNJQ2pJ6v
        8coSfK1O+oN8HtwWv1d2X3d6RBFgQ3Zteg==
X-Google-Smtp-Source: ABdhPJwE0a59oTqWZsIKYtrbOEbc4WXeWnXFQBKYaU287m4MDf/foqt4AN/u7FnISs3xn9TF5Xm1GQ==
X-Received: by 2002:a0c:fd8e:: with SMTP id p14mr4716762qvr.23.1619641085488;
        Wed, 28 Apr 2021 13:18:05 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id q126sm616666qkd.48.2021.04.28.13.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 13:18:05 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/5] libsepol/cil: Return an error if a call argument fails to resolve
Date:   Wed, 28 Apr 2021 16:17:53 -0400
Message-Id: <20210428201753.282831-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210428201753.282831-1-jwcart2@gmail.com>
References: <20210428201753.282831-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Return an error if a call argument fails to resolve so that
the resolution phase stops and returns an error.

This problem was found by the secilc-fuzzer.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 34c28fc6..5368ae80 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -3253,6 +3253,7 @@ int cil_resolve_call2(struct cil_tree_node *current, void *extra_args)
 		if (sym_index != CIL_SYM_UNKNOWN) {
 			rc = cil_resolve_name(current, arg->arg_str, sym_index, extra_args, &(arg->arg));
 			if (rc != SEPOL_OK) {
+				cil_tree_log(current, CIL_ERR, "Failed to resolve %s in call argument list", arg->arg_str);
 				goto exit;
 			}
 		}
@@ -3284,7 +3285,7 @@ int cil_resolve_name_call_args(struct cil_call *call, char *name, enum cil_sym_i
 		if (param_index == sym_index) {
 			if (name == arg->param_str) {
 				*datum = arg->arg;
-				rc = SEPOL_OK;
+				rc = *datum ? SEPOL_OK : SEPOL_ERR;
 				goto exit;
 			}
 		}
-- 
2.26.3


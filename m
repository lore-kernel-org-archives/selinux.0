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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB01C433B4
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 20:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F6D16143F
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 20:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbhD1USw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Apr 2021 16:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhD1USu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Apr 2021 16:18:50 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0E6C061573
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 13:18:03 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id z2so27980973qkb.9
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 13:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LEVfIXjfm17908BanwJlYwt1rA/1vdBmbSGySJIefjI=;
        b=I5/ndJkXXgSaLlyyI0vCXZxCaCVrWWNv7xsiNeMqH2I2k/OLt8+i3LGlNrU8elBSl3
         p19wicJOGi4FTOoWiKIhVxhbnqaqmPP5QrqhncQW5VjMVmDqNKoUcvfyzf2WEKxx2nrC
         aP0XVucKuhKFgQkpYFG9uZXUTqAGR6LLtp+d9zNBlaWg6MW6yX7pknRYx/d0rxtIJk7Q
         nhX4TE8hIcNnnjlq+YuuLnckBkJJb0lwuRsXxnsOSjeq+taWjhaYAh6IDJkiSkJxBjSX
         7EqYwmu7V2nU6nLRE5Vimd0PcunWC1zDvpmXDlzEMiC+KdxBzQUAd+skC94wRqRK0zPs
         PNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LEVfIXjfm17908BanwJlYwt1rA/1vdBmbSGySJIefjI=;
        b=DekrnKCrfUlgRuN8LvtlEU6Bkrn93wtdFBhT4gD02GKlt1Imt4ClZsX0Jy1UT+GQ8a
         LjFrUUCVT5G+BYEl3z7g0MFHvMQaBV3QPsud57FLo5aNWkSgzmP8M3fm1eu5XhVd2rSj
         MTUPgyaH22YoLTq1ZFzBhnYaF5opmd937unMFV40KuGueJ62anVVdZEsjYq09Ig4iGLz
         Py7AbsNsFD2kaFK94uGLTqRr3xh/dse35CQZJTmj5DkhbElKIWMexCrIrxFygN3mA3V3
         I2h5KM6zvj3glGo6tj+MqPsMbbRgTpLBHBR5ItmNPEasvkTKF01cqc9CwvWkcSQyIVSZ
         Hvzw==
X-Gm-Message-State: AOAM532Cccb+gI5ddlZ1Z/yMsrS5WsFl3y2wvgPROO0n2ow2VSQcmhCv
        eVAQcCqCBSYO6vF8q7l8qCT7hIcDPapBFQ==
X-Google-Smtp-Source: ABdhPJwsyVwQYXVBX5DoF0hN1fQAajNX05cvQCYNhoIA6lzVhOscoYQmYvYkVH/LyVsXkareAj6ECA==
X-Received: by 2002:a05:620a:11bc:: with SMTP id c28mr22836063qkk.53.1619641082637;
        Wed, 28 Apr 2021 13:18:02 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id q126sm616666qkd.48.2021.04.28.13.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 13:18:02 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/5] libsepol/cil: Check datum in ordered list for expected flavor
Date:   Wed, 28 Apr 2021 16:17:51 -0400
Message-Id: <20210428201753.282831-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210428201753.282831-1-jwcart2@gmail.com>
References: <20210428201753.282831-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The secilc-fuzzer found an out of bounds memory access occurs
when building the binary policy if a map class is included in a
classorder statement.

The order statements in CIL (sidorder, classorder, categoryorder,
and sensitivityorder) are used to specify an ordering for sids,
classes, categories, and sensitivities. When the order statments
are resolved and merged, only in the case of the category order
list is the datum resolved checked to see if it is the expected
flavor.

When resolving the sid, class, and sensitivity order statements,
check that each name resolved to a datum of the expected flavor
and return an error if it does not.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 68909647..b081d45d 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -1488,6 +1488,11 @@ int cil_resolve_classorder(struct cil_tree_node *current, void *extra_args)
 			rc = SEPOL_ERR;
 			goto exit;
 		}
+		if (FLAVOR(datum) != CIL_CLASS) {
+			cil_log(CIL_ERR, "%s is not a class. Only classes are allowed in classorder statements\n", datum->name);
+			rc = SEPOL_ERR;
+			goto exit;
+		}
 		cil_list_append(new, CIL_CLASS, datum);
 	}
 
@@ -1526,6 +1531,12 @@ int cil_resolve_sidorder(struct cil_tree_node *current, void *extra_args)
 			cil_log(CIL_ERR, "Failed to resolve sid %s in sidorder\n", (char *)curr->data);
 			goto exit;
 		}
+		if (FLAVOR(datum) != CIL_SID) {
+			cil_log(CIL_ERR, "%s is not a sid. Only sids are allowed in sidorder statements\n", datum->name);
+			rc = SEPOL_ERR;
+			goto exit;
+		}
+
 		cil_list_append(new, CIL_SID, datum);
 	}
 
@@ -1617,6 +1628,11 @@ int cil_resolve_sensitivityorder(struct cil_tree_node *current, void *extra_args
 			cil_log(CIL_ERR, "Failed to resolve sensitivty %s in sensitivityorder\n", (char *)curr->data);
 			goto exit;
 		}
+		if (FLAVOR(datum) != CIL_SENS) {
+			cil_log(CIL_ERR, "%s is not a sensitivity. Only sensitivities are allowed in sensitivityorder statements\n", datum->name);
+			rc = SEPOL_ERR;
+			goto exit;
+		}
 		cil_list_append(new, CIL_SENS, datum);
 	}
 
-- 
2.26.3


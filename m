Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F6EC47081
	for <selinux@archiver.kernel.org>; Tue,  5 Apr 2022 21:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiDEVls (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389258AbiDEPVM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Apr 2022 11:21:12 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8082CFB97
        for <selinux@vger.kernel.org>; Tue,  5 Apr 2022 06:35:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ot30so16800250ejb.12
        for <selinux@vger.kernel.org>; Tue, 05 Apr 2022 06:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5Qj+J+MJ3CH0fLWAzZg00y3vnDxVPVHwmc7Yhuu+0n0=;
        b=ZKdIJmRhtLe1OEfmnaf4BcaKyFq6zHaLD06GFrIU5eFN/vUSsx2AXYtnmEWO1zAY2G
         R8PJrH4AyFk0vPJFH84QKj+vMnsMd1m+8xDqvbl17q3elACdHfgeXGKMznDTUXObKXNr
         GAtNKMEdcjqzYt4mtocvB22rb2D0shZesqe0CoYLNMpolu9L40o50uxMOAD2mPFZTl3U
         Zw4yqIGYJsDr6k394142H6vLp2SxcxZWMdZBpoIs8nnjYj6rv0ABUoXL33TA0LMRNurS
         CL733sIkWq8Ui8SIQjnFJdnVe5IEkjLTjq1lR3JpJofVhS6bp7wGQCBiY17Yxc1B44rv
         jCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Qj+J+MJ3CH0fLWAzZg00y3vnDxVPVHwmc7Yhuu+0n0=;
        b=Ty1/m4PakNg9fypC9hDCdhrQPEScgOQGah4quZAFwhZk32RCgDUOH02mivGBVVxCBI
         Cb5+gPitpYj2rJ3jE9m/LQd+nXYx/O7suALLtEtoTBr4JFq4ftvm9UtHGy1oAbiSyyTH
         zYDEfHx/jH3UiIIav+KmfvGIkBrAC0m2ltDjEeBZp1j7t78xFy4blmnNiyx5fwXrrK9u
         9xfiO6Q+nENuCnnnJNBFMmkc4fkNVwJ2cLqYGYzRJbHsOmbE7TqJQPYNoJXDacJh75E2
         mRpgDXZfxa8GbSXGbAFlRBu6GTo2g/wuIkDpna4AGKhg1QwsPFwX1rvU30jAN5/YpDF2
         nuLw==
X-Gm-Message-State: AOAM532ANAOur/LOyqAvJjKbG2OrAWWzOCv/+Tv9N8UDKoedZqVbQW8i
        NAkADDh7xRiJLwI9mErsHUwCp6X6IQE=
X-Google-Smtp-Source: ABdhPJx4rN256ya3N0J7+uo7CMKfMdb2aimqjTcWmZAh3D8E0Ggh4R+yhMWp1pRX7C4u6wgq45lirA==
X-Received: by 2002:a17:907:7da8:b0:6e0:5b94:5ed8 with SMTP id oz40-20020a1709077da800b006e05b945ed8mr3485129ejc.312.1649165755792;
        Tue, 05 Apr 2022 06:35:55 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-134-094.77.8.pool.telefonica.de. [77.8.134.94])
        by smtp.gmail.com with ESMTPSA id l25-20020a1709060e1900b006e7fe06664esm1620627eji.106.2022.04.05.06.35.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:35:55 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 4/6] libsepol/cil: comment out unused function __cil_verify_rule
Date:   Tue,  5 Apr 2022 15:35:46 +0200
Message-Id: <20220405133548.51598-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405133548.51598-1-cgzones@googlemail.com>
References: <20220331144752.31495-1-cgzones@googlemail.com>
 <20220405133548.51598-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The function __cil_verify_rule() is currently not used as all call sites
are commented out.  Keep the function for future references.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_verify.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index aecbdc19..4640dc59 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -970,7 +970,8 @@ exit:
 	return rc;
 }
 
-int __cil_verify_rule(struct cil_tree_node *node, struct cil_complex_symtab *symtab)
+/*
+static int __cil_verify_rule(struct cil_tree_node *node, struct cil_complex_symtab *symtab)
 {
 
 	int rc = SEPOL_ERR;
@@ -1016,6 +1017,7 @@ exit:
 	cil_tree_log(node, CIL_ERR, "Invalid rule");
 	return rc;
 }
+*/
 
 static int __cil_verify_booleanif_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, __attribute__((unused)) void *extra_args)
 {
-- 
2.35.1


Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEFDC433F5
	for <selinux@archiver.kernel.org>; Fri,  8 Apr 2022 13:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbiDHNON (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Apr 2022 09:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236551AbiDHNNs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Apr 2022 09:13:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4204F30F
        for <selinux@vger.kernel.org>; Fri,  8 Apr 2022 06:11:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a6so17373458ejk.0
        for <selinux@vger.kernel.org>; Fri, 08 Apr 2022 06:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yQjtNIe5mWRLuBSAzMFxAQ0wrSsTKQiHsI3BK5xHtFM=;
        b=Lr5jAmWClHImazZrETjxF1jI+cjEDcuhA9doN0BxcVZQoZHnlDQw7JFNRM+nUGt69B
         GPxZb7Vs8DFeMNzp0u8GHDlZExJCu9pL4NLF9MWxFPH8cabl71Pl7vjIvTe8DJb91VsZ
         UZWaYV6+P/J4EmLgPUSvtQwgDhfY57p6qI4Vd2pW2Aiku7rNsHbxGIB2QyaHIoI3Ebhz
         yTXE4vKDM/J/ayROOckc9jrrjsDmObJQ7UA9mra9zpj7NKiOJbCyl0/imPZQB3ne5z7s
         NNPI1Yeb1xCEvyws+Cu2VMFSqDhCGdi3kGB8gs28VDvBZfb3caiqdRf9p/TjWTBjQVSL
         4b0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yQjtNIe5mWRLuBSAzMFxAQ0wrSsTKQiHsI3BK5xHtFM=;
        b=z+Nj9viO1ls1xxtIBf8XVuG6kGLOJBQySrGEDEEEJVBMzj8F7h0KMIDXbu/97N5FLH
         TJtDmjkwJFUVhrvgwlHEG9al2J7DuqJBY41jKUC3YP6lggcRCjf4qskYQMINgwoAbYLM
         /+bNg/7BnD5mPs1BkDDq/vGfYCxHfCioUWXttEkL7XrLV6zncqTnHF2Qs2qHSOgxe+Qd
         3mMHyfFBCv4RqylxLxGJwLuGLeSCtEyAaqj31JHjQLe9TtZC727UKMZnK9tZxy/gzYFv
         QZmh6tdaTFpf5lRTZ3TSoACE2ncttq3KJWS8gRvMcKc8uPh9EiJhGWunA0m7zRULRLgK
         VNzw==
X-Gm-Message-State: AOAM531d+TQLe2T/ISS/CQZn6B485ITFJABLFFMO/rN7swFEbQnWfFcD
        f3rcE1Q54AZjjaAFFKQnipJsUvOKO9c=
X-Google-Smtp-Source: ABdhPJzJ0ShpVAZY2wghaMVjT09NuyuK5dVBZM/FJ8ou2ea4CNfXN1dw35A+8EOvRxsYh/Gyu/r6UQ==
X-Received: by 2002:a17:907:9482:b0:6da:a24e:e767 with SMTP id dm2-20020a170907948200b006daa24ee767mr18480624ejc.479.1649423460770;
        Fri, 08 Apr 2022 06:11:00 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-032-209.77.3.pool.telefonica.de. [77.3.32.209])
        by smtp.gmail.com with ESMTPSA id h26-20020a170906111a00b006e778bd4fc8sm6398601eja.38.2022.04.08.06.11.00
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 06:11:00 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 5/5] libsemanage: avoid double fclose
Date:   Fri,  8 Apr 2022 15:10:54 +0200
Message-Id: <20220408131054.7957-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408131054.7957-1-cgzones@googlemail.com>
References: <20220408131054.7957-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The cleanup goto block in `semanage_direct_set_enabled()` closes the
file stream pointer fp if not NULL.  Set the stream to NULL after a
manual fclose(3), even on failure.

    direct_api.c: In function ‘semanage_direct_set_enabled’:
    direct_api.c:2130:25: error: pointer ‘fp’ may be used after ‘fclose’ [-Werror=use-after-free]
     2130 |         if (fp != NULL) fclose(fp);
          |                         ^~~~~~~~~~
    direct_api.c:2092:29: note: call to ‘fclose’ here
     2092 |                         if (fclose(fp) != 0) {
          |                             ^~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/direct_api.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index d5716ce5..7206483a 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -2089,7 +2089,9 @@ static int semanage_direct_set_enabled(semanage_handle_t *sh,
 				goto cleanup;
 			}
 
-			if (fclose(fp) != 0) {
+			ret = fclose(fp);
+			fp = NULL;
+			if (ret != 0) {
 				ERR(sh,
 				    "Unable to close disabled file for module %s",
 				    modkey->name);
@@ -2097,8 +2099,6 @@ static int semanage_direct_set_enabled(semanage_handle_t *sh,
 				goto cleanup;
 			}
 
-			fp = NULL;
-
 			break;
 		case 1: /* enable the module */
 			if (unlink(fn) < 0) {
-- 
2.35.1


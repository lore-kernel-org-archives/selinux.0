Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC048C433EF
	for <selinux@archiver.kernel.org>; Thu, 31 Mar 2022 14:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbiCaOpo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Mar 2022 10:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiCaOpn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Mar 2022 10:45:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287468D6B5
        for <selinux@vger.kernel.org>; Thu, 31 Mar 2022 07:43:56 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dr20so48541362ejc.6
        for <selinux@vger.kernel.org>; Thu, 31 Mar 2022 07:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8PKJoyJsbyRYF3mCLKGMginW5UtSQ9vy2pxrxAZ6Czo=;
        b=dhbInhkhkdcSt/u34YhPQx2gxCBh5Ao1RxuhZc26c4xZruuYxij1hQ9A+AUKk0c30x
         A7zDHLWtx7t5zUf1a7q7YeBXaHwuszU0Aa1qEjoTYDDGICGokt16zf7qWpaCcODE7+Ij
         4MqGM7uqy53gtYQXTDu+kVaTmtiSTWRs6YzHV3rXLFGE905kDXMx2euccwzfcwCmR/yy
         Wr37FocEcrMNSUzolYgiRxTjt+NNnZnjRK69bRsi66PLaNlvzjdetzZD8xkuGTAqocvz
         OqORT78OY434CN35XTO3N4tSLWwuZuIo62oU6rM7tecpZqxgdqq9jX+v6ylS2yMbrm5U
         9+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8PKJoyJsbyRYF3mCLKGMginW5UtSQ9vy2pxrxAZ6Czo=;
        b=Kyq88osVxfRCATjCCIb/8u/KQqRh60wr8g7C9mt7/yTr7xNQFVVFHUcpERT9hnqH5H
         BdFp8izeN6IiNcIAJR31myofHJ83SxURYNgeXSoqJbjV1Q5ewI6QFRGPmthgeNF3C26s
         rh4CqdvUF8eJaKhiyiVN8+01F6gdwgS3uJAEs9c9Puk2zcT8+cE+a7S6+Eu0hnNyhKi9
         ynsl64C60b8euiZXHS0D3TGE4sGLyYPpagrvhSZRo2++4CRh3Bqd48wfPmU0VF8GWJs3
         VNnv3LpmVWZ+Q37RJfcxl+65J63HSqZg8hyz6MjUEp9S8hf4fZ1ueZeuylzyuO464chK
         8CXQ==
X-Gm-Message-State: AOAM532bclSlroX7mGczCL1QLt5EinRZCmvnjlmUX6G0QyX6UxyGcvPM
        tGQp3aRkulR2TKsqLcPFOE3c42AK3a0=
X-Google-Smtp-Source: ABdhPJx7y2MRWIDysjvniemQ1WrU7x90TjulI0aH6WsdJPYLTkSSPyh8cM27XB4sSnzhmCIEWzN65A==
X-Received: by 2002:a17:906:c092:b0:6ce:1018:9f4e with SMTP id f18-20020a170906c09200b006ce10189f4emr5307335ejz.430.1648737834611;
        Thu, 31 Mar 2022 07:43:54 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-006-065-043.77.6.pool.telefonica.de. [77.6.65.43])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090674cd00b006df78d85eabsm9601492ejl.111.2022.03.31.07.43.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 07:43:54 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol/cil: silence GCC 12 array-bounds false positive
Date:   Thu, 31 Mar 2022 16:43:43 +0200
Message-Id: <20220331144343.30689-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

GCC 12 produces an array-bounds warning:

    In file included from ../include/sepol/policydb/context.h:23,
                     from ../include/sepol/policydb/policydb.h:62,
                     from ../cil/src/cil_binary.c:41:
    In function ‘mls_level_init’,
        inlined from ‘mls_level_destroy’ at ../include/sepol/policydb/mls_types.h:99:2,
        inlined from ‘mls_level_destroy’ at ../include/sepol/policydb/mls_types.h:92:20,
        inlined from ‘mls_range_destroy’ at ../include/sepol/policydb/mls_types.h:149:2,
        inlined from ‘cil_rangetransition_to_policydb’ at ../cil/src/cil_binary.c:3231:6:
    ../include/sepol/policydb/mls_types.h:89:9: error: ‘memset’ offset [0, 23] is out of the bounds [0, 0] [-Werror=array-bounds]
       89 |         memset(level, 0, sizeof(mls_level_t));
          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ../include/sepol/policydb/mls_types.h:89:9: error: ‘memset’ offset [0, 23] is out of the bounds [0, 0] [-Werror=array-bounds]
    cc1: all warnings being treated as errors

This is a false positive, by inspecting the code and compiling with -O3
and -flto.

Closes: https://github.com/SELinuxProject/selinux/issues/339

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_binary.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 53017e2d..d5211f69 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -3222,7 +3222,16 @@ int cil_rangetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, st
 					} else {
 						cil_log(CIL_ERR, "Out of memory\n");
 					}
+// TODO: add upper version bound once fixed in upstream GCC
+#if defined(__GNUC__) && (__GNUC__ >= 12)
+# pragma GCC diagnostic push
+# pragma GCC diagnostic ignored "-Warray-bounds"
+# pragma GCC diagnostic ignored "-Wstringop-overflow"
+#endif
 					mls_range_destroy(newdatum);
+#if defined(__GNUC__) && (__GNUC__ >= 12)
+# pragma GCC diagnostic pop
+#endif
 					free(newdatum);
 					free(newkey);
 					if (rc != SEPOL_OK) {
-- 
2.35.1


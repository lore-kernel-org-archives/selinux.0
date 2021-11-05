Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6882C43219
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9238961183
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhKEPs4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbhKEPsw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:52 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA70C061205
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:46:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m14so33821516edd.0
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WJ48X5EYCVnDkQ6/1hzc8CgV5k/cfcCf7jzmlWaCeJk=;
        b=KT3IBvZP9gYtu/sG2oNfnLWJ4pKEdm0WkP0RHyrlWx3T1tMiWVgDfIIGO4oxF2VDzR
         Glid41eNpwao7HPV7hf+O4k+RykDYV7FIpBYAs8ufWAtqm9Gm18GWsHuyKwemK9FBcPe
         wSqoyj/FBK1Ypvs9s/p0xfV2P25RyB7lMp/obEQcW+fEPNmyAKrx7weDFUv6/nSletl4
         80KvImISjFnKpz1XrAb3dgJsD/ej2mLEDsLDin83NtOtdlOZP04r9JYVbQmz536lrqg/
         mffzAUR2tEj6Esui024X0I4jY3B0TWmrs1buohEWaF4jynVBjCpvxFG3xRU/FaMqmSWY
         A7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJ48X5EYCVnDkQ6/1hzc8CgV5k/cfcCf7jzmlWaCeJk=;
        b=t8sbGmgpecSVc2z5ieCDAZAcI4x5pO5Li5z+AzWRej0IArmcIESReYyoY8113U+zlu
         vbpgMzRtCUVV/DM6YKt89UcEsACKjt61MpuwRls2Lanek1BRuEw1mU14QMPBzgUhhJNd
         D5OVxHwzsGh8Hr1JYssTZu+pF3ZP7puvgqm6lGhpj4BOZ8RFsMNb3BrE7j1uklEnM86I
         0rkcRMWmE6JeOgHUX4y6pEAMi2i6UuJHiZywG4vOTMrqbqgQXyJpX/2Vp9q3g7urHPJA
         BXWqtvNeP8lN0mtbJeJeh+I/zR3SLfHRzu/SxeSQdu503Rhk9Mmlh2YiH40yAqBrcc3s
         NNuA==
X-Gm-Message-State: AOAM532stDes/2I0uI2cFso07/tzcIJqjfcnPSSa2krg2q3+QrCEcnB3
        Mw/STn1Y1MMoDkpdrfYbrOf70/Wj2Dk=
X-Google-Smtp-Source: ABdhPJywKtpGwbbcH5YuYdhKsk+Acyx//Jc/tzAPsBZkGmCbYNad122IC/Cb4gs52I21OhDmxfN6HQ==
X-Received: by 2002:a17:906:184a:: with SMTP id w10mr73648918eje.273.1636127169011;
        Fri, 05 Nov 2021 08:46:09 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.46.08
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:46:08 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 37/40] [WIP] libsepol: export policydb_validate
Date:   Fri,  5 Nov 2021 16:45:39 +0100
Message-Id: <20211105154542.38434-38-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105154542.38434-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Export the interface to validate a policydb structure.
It can be used e.g. in compilers to verify they generate valid policies.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/policydb/validate.h | 17 +++++++++++++++++
 libsepol/src/policydb_validate.h           |  4 +---
 2 files changed, 18 insertions(+), 3 deletions(-)
 create mode 100644 libsepol/include/sepol/policydb/validate.h

diff --git a/libsepol/include/sepol/policydb/validate.h b/libsepol/include/sepol/policydb/validate.h
new file mode 100644
index 00000000..eff0779e
--- /dev/null
+++ b/libsepol/include/sepol/policydb/validate.h
@@ -0,0 +1,17 @@
+#ifndef _SEPOL_POLICYDB_VALIDATE_H
+#define _SEPOL_POLICYDB_VALIDATE_H
+
+#include <sepol/handle.h>
+#include <sepol/policydb/policydb.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+int validate_policydb(sepol_handle_t *handle, policydb_t *p);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/libsepol/src/policydb_validate.h b/libsepol/src/policydb_validate.h
index d9f7229b..c2980403 100644
--- a/libsepol/src/policydb_validate.h
+++ b/libsepol/src/policydb_validate.h
@@ -1,7 +1,5 @@
 #include <stdint.h>
 
-#include <sepol/handle.h>
-#include <sepol/policydb/policydb.h>
+#include <sepol/policydb/validate.h>
 
 int value_isvalid(uint32_t value, uint32_t nprim);
-int validate_policydb(sepol_handle_t *handle, policydb_t *p);
-- 
2.33.1


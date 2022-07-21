Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B10CCA488
	for <selinux@archiver.kernel.org>; Thu, 21 Jul 2022 15:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiGUPYx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiGUPYw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Jul 2022 11:24:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278E47B7BA
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:24:51 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id oy13so3791148ejb.1
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D23e2evORQwQTl87LF+PFyms/PEiOJ7GNcQ7WjcFOI8=;
        b=bqMO8lUlgD1I3AoVdAHhHQZODsI7CNe/mNA/AcNBDFpMN1TL5PhVn3d0hV1Un18RVJ
         rGyFfb3gIUUEVCoIaAwRWTy7I79vKtkjDgQtpAWDQhVVo1dd6+3YKqkd56Ju/Cf7IPP/
         cF8374sP7kowN+LZgshq50AyW9A5pQhJ2ptH+URuJKHz0Ks8d279TjmwTuxuG+LaVk/w
         5G3TaYliE9ipgZNuy4D9iqDpAR79vWL8w8v2Hv54can/uIE5btHIfffs/vfo3PtrW0VK
         QvoQbVlBcczF52w2R5UQBLILLq1NRUM02PAeavx+JVBFHdXGeuhx/aDvtFyRo+AUAq0r
         cI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D23e2evORQwQTl87LF+PFyms/PEiOJ7GNcQ7WjcFOI8=;
        b=X6rdPz28uWR2tRjdIzTAGbebDmbkmBg53kj/h2BK6SMMFOdrqY+qGV5v6PTW0IK6zx
         DPWobYKoQmpJaBbUfh2RbaNk/uKW+xRX/DiLFT961FkpoA/HYtXnWz6FNYbG9BE2XsEB
         t6KjlpvwvL2GTaueG7v6V1PM9culJAyG3vSOnFoQwQAIrXBmBvg3voN8tJuiJhSYjulD
         RXIY8QhWqK+Dzw1mHhxrSCJMYfy7xshKBSC2j+8LeOevq7B3Scci5BOl+2AHYy34QDwA
         AV9wwaBvBP3EmWiIAsTXK3HWSWb+ks8ATMnPyzwzqzFrBuUQNNWGgsZdW5VWYL3HuhkN
         nGHg==
X-Gm-Message-State: AJIora87Hm+koT+OMRxdvtlmrSPoP5vmiTQeqvHCWIFZpaZNouqPYD66
        U/CL7O2msbN+jtNpGeqsQngW0HsmQTQ7DQ==
X-Google-Smtp-Source: AGRyM1uUWpwRXs6JRZvoNERR5y4PEYV5M7Sr09l+EsNNiV7qwwETeu7YdtXGDE5oQYQ/i7W9B5GSnw==
X-Received: by 2002:a17:906:98ca:b0:72b:7bb4:4ebc with SMTP id zd10-20020a17090698ca00b0072b7bb44ebcmr40120414ejb.585.1658417089469;
        Thu, 21 Jul 2022 08:24:49 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-209-027.77.0.pool.telefonica.de. [77.0.209.27])
        by smtp.gmail.com with ESMTPSA id d18-20020a056402079200b0043a253973aasm1163486edy.10.2022.07.21.08.24.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:24:48 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 1/5] libsepol: rename validate_policydb to policydb_validate
Date:   Thu, 21 Jul 2022 17:24:40 +0200
Message-Id: <20220721152444.31690-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Most global functions operating on a policy database use policydb as
prefix.

Since this function is not exported there should not be any external
use.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c          | 2 +-
 libsepol/src/policydb_validate.c | 2 +-
 libsepol/src/policydb_validate.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index fc260eb6..8a65df05 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -4570,7 +4570,7 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 		}
 	}
 
-	if (validate_policydb(fp->handle, p))
+	if (policydb_validate(fp->handle, p))
 		goto bad;
 
 	return POLICYDB_SUCCESS;
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 99d4eb7f..e1dad236 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1330,7 +1330,7 @@ static void validate_array_destroy(validate_t flavors[])
 /*
  * Validate policydb
  */
-int validate_policydb(sepol_handle_t *handle, policydb_t *p)
+int policydb_validate(sepol_handle_t *handle, policydb_t *p)
 {
 	validate_t flavors[SYM_NUM] = {};
 
diff --git a/libsepol/src/policydb_validate.h b/libsepol/src/policydb_validate.h
index d9f7229b..b7f9f191 100644
--- a/libsepol/src/policydb_validate.h
+++ b/libsepol/src/policydb_validate.h
@@ -4,4 +4,4 @@
 #include <sepol/policydb/policydb.h>
 
 int value_isvalid(uint32_t value, uint32_t nprim);
-int validate_policydb(sepol_handle_t *handle, policydb_t *p);
+int policydb_validate(sepol_handle_t *handle, policydb_t *p);
-- 
2.36.1


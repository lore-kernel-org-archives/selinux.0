Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703F2C4167B
	for <selinux@archiver.kernel.org>; Thu, 14 Apr 2022 14:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243184AbiDNOnT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347713AbiDNN7a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Apr 2022 09:59:30 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1137BB92B
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 06:51:59 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 3so3894285qkj.5
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 06:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPkcYaoCdXPmt5BfP2hpJt5PFeSvlxU15eONNBphi8w=;
        b=GP1+K1wfUxb3sK8wpBCrzyKGvWB1BjAtMjuTny2FLO2kzlU3ViX0jP+HnnStNGwM/n
         t9PAOjJhT4RcP0UYaD9fIh4WIrsq0+utLs6GXQ6DhtNHK42LnfgDzj9+xIHqvhq1rCpe
         gpUuKHv1fY0cwvOf5haQdoZUML15Ipa1UUz51SU4oA6/ICwtq23pu6eUQDYHfBk2I3/A
         MK3e7iUcqUUiYPED/vOIv6x0QcJZDEOrEWnNJUyt+fFfd2kVQin+XnikMqsFra82aSIq
         GqazghSL/qZ6VYRnMVIDgPloaQt36L6pPhk/1+zIXzeAmuIJwTs/EXpL1nlFh3wHFXCy
         vmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPkcYaoCdXPmt5BfP2hpJt5PFeSvlxU15eONNBphi8w=;
        b=TDtxQK4yh8wa4uCaMpbbLlAXpiIC4yE+QnFjiROKhO/myVOoL177ceGprQDjtUBreu
         yi3vWDMveGdiaO25TeTvRqQiokKr5syCPOpEbRrvviBEUA7omMfqgKO8rCo/bJwFReMb
         oLWE5uZ+KRNo3Qcx4s+Z8YjQxCoQ8lY73QlA2Rd3HeELG/sH+jzU0CQPNP6dlytcT16t
         8hiE0SNYlI7p+8HfyVwgB9jY8ORRyVGv3VfPB4qI+wbJQO8G6ttvDHB/meITX/hw0y2e
         qd/33YD+qJcJik4/MRV2lwpryRZUBFs8o+AoCw4AlfQt0672DKLB+I6dosex2a0gUPmb
         XpUw==
X-Gm-Message-State: AOAM532iVgxIH5/iG5sWR5OomWBpSXuvgfrx+OuRWUf5wYBGVdjI6D14
        PCMiU0yRkxwpDJFE6AoZPC8otSqSNas=
X-Google-Smtp-Source: ABdhPJxDrtvrBEEBpsBGxuLqAYTRngrIVkOjHecW5XcevrBEHM3E9u8DlCNtrXNCMSAYb3Q5d1JbDQ==
X-Received: by 2002:a37:587:0:b0:69c:7c03:52d9 with SMTP id 129-20020a370587000000b0069c7c0352d9mr1443726qkf.520.1649944318779;
        Thu, 14 Apr 2022 06:51:58 -0700 (PDT)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id 14-20020a37090e000000b0069bfe98662csm999748qkj.17.2022.04.14.06.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 06:51:58 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/5] libsepol/test: Include paired headers for prototypes
Date:   Thu, 14 Apr 2022 09:51:38 -0400
Message-Id: <20220414135141.1723610-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220414135141.1723610-1-jwcart2@gmail.com>
References: <20220414135141.1723610-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is needed to use "-Wmissing-prototypes".

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/tests/test-common.c          | 1 +
 libsepol/tests/test-linker-cond-map.c | 1 +
 libsepol/tests/test-linker-roles.c    | 1 +
 libsepol/tests/test-linker-types.c    | 1 +
 4 files changed, 4 insertions(+)

diff --git a/libsepol/tests/test-common.c b/libsepol/tests/test-common.c
index f690635e..8f2807b2 100644
--- a/libsepol/tests/test-common.c
+++ b/libsepol/tests/test-common.c
@@ -26,6 +26,7 @@
 
 #include <CUnit/Basic.h>
 
+#include "test-common.h"
 #include "helpers.h"
 
 void test_sym_presence(policydb_t * p, const char *id, int sym_type, unsigned int scope_type, unsigned int *decls, unsigned int len)
diff --git a/libsepol/tests/test-linker-cond-map.c b/libsepol/tests/test-linker-cond-map.c
index b02e7881..5400c46b 100644
--- a/libsepol/tests/test-linker-cond-map.c
+++ b/libsepol/tests/test-linker-cond-map.c
@@ -18,6 +18,7 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include "test-linker-cond-map.h"
 #include "parse_util.h"
 #include "helpers.h"
 #include "test-common.h"
diff --git a/libsepol/tests/test-linker-roles.c b/libsepol/tests/test-linker-roles.c
index 6843252b..2b17dffd 100644
--- a/libsepol/tests/test-linker-roles.c
+++ b/libsepol/tests/test-linker-roles.c
@@ -18,6 +18,7 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include "test-linker-roles.h"
 #include "parse_util.h"
 #include "helpers.h"
 #include "test-common.h"
diff --git a/libsepol/tests/test-linker-types.c b/libsepol/tests/test-linker-types.c
index b41e08e0..048dd422 100644
--- a/libsepol/tests/test-linker-types.c
+++ b/libsepol/tests/test-linker-types.c
@@ -19,6 +19,7 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include "test-linker-types.h"
 #include "parse_util.h"
 #include "helpers.h"
 #include "test-common.h"
-- 
2.34.1


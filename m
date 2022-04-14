Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09195C433F5
	for <selinux@archiver.kernel.org>; Thu, 14 Apr 2022 14:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbiDNOnQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347714AbiDNN7a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Apr 2022 09:59:30 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1F9BB089
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 06:51:55 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id b17so3988034qvf.12
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 06:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qs300j/btaVZ6AavQKGDKrLd+SW62q9Tdl20lEJvtLw=;
        b=XHE4TvzDxvoa37R0mMaH3Iv97604YYZVAsdgl7nMFpoWEj0znANz1lXahKS2XmwhJW
         6ssn96hnslXvOcmjDd/7pewiJReB0bWf770NPiAL3MBx1xfsXKKJgcybMx9X4Twnh1CA
         /izKhtIwwEsWrNpKDkGjCLsuEr4AQNjJFlBgBMLN75l6Wp/92Gj8LZlAlKZ4zQK3SLDe
         telWej/n81OqWcTan5YidnH4xDeuc+d+wxY4nSc0PaYnAXPUDKDpTjdPLIEu+QOUlztH
         u2wulolBfr9Vt+nOENmGEJnUTFpKGdeCdBfj6oG7qzwDYOW+sj2Sn507+zT6TehyjGm8
         EGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qs300j/btaVZ6AavQKGDKrLd+SW62q9Tdl20lEJvtLw=;
        b=z7YUj1PywanynSW5/fhhDvYlPlxiakE9KQlJnJOOsDDDmO487TUxf5GUrWb/2oJy0E
         1iFJVFnx4TwVGJjMBkxJazpKq2VJGCc1fPz7cZrVixPoUnIyP/trvquXIMMQV8nQ4MKz
         tPxXrJL4GbLAJXeaxm9UgmqdPoV8NHnCg7LHmiSMI7TB2uW6EB+sC8t5Jn/I4G1KfhhE
         TsOp+m50ChpD3XxydrC34vkScdo7LzTcz9sonKgC5jPiSYn5+KRXFP2PblpaET2e/Fj8
         boXezA46BrYmaDNBGQFowwkHpN22whOWzRMeB/T6JD3HbGJfgL+K9JtPakuhXEtjtMLB
         2geg==
X-Gm-Message-State: AOAM531Fw4EEU5y4ZKLDrk7VMAsJomxsmXagglPjOb8ZFnnlCdeTSYCD
        qTULfD5S0l/P9QpSoDZaqoe1/PxWKCg=
X-Google-Smtp-Source: ABdhPJwpCpk0s5oQSPKz+NiRNqVbTkXbJ7HpE3QbZZ9XIiLAWCuydzaZBR7WQiyj4fgfC0X4nawT3w==
X-Received: by 2002:a05:6214:e67:b0:441:6ecc:51ae with SMTP id jz7-20020a0562140e6700b004416ecc51aemr3449661qvb.22.1649944314505;
        Thu, 14 Apr 2022 06:51:54 -0700 (PDT)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id 14-20020a37090e000000b0069bfe98662csm999748qkj.17.2022.04.14.06.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 06:51:54 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/5] libsepol/test Include policydb.h header for policydb_t declaration
Date:   Thu, 14 Apr 2022 09:51:37 -0400
Message-Id: <20220414135141.1723610-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since test-linker-cond-map.h and test-linker-types.h references
policydb_t, include the policydb header file.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/tests/test-linker-cond-map.h | 2 ++
 libsepol/tests/test-linker-types.h    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/libsepol/tests/test-linker-cond-map.h b/libsepol/tests/test-linker-cond-map.h
index 148c6f62..740a722e 100644
--- a/libsepol/tests/test-linker-cond-map.h
+++ b/libsepol/tests/test-linker-cond-map.h
@@ -21,6 +21,8 @@
 #ifndef __TEST_LINKER_COND_MAP_H__
 #define __TEST_LINKER_COND_MAP_H__
 
+#include <sepol/policydb/policydb.h>
+
 extern void base_cond_tests(policydb_t * base);
 extern void module_cond_tests(policydb_t * base);
 
diff --git a/libsepol/tests/test-linker-types.h b/libsepol/tests/test-linker-types.h
index 0c860ebf..acad5e0e 100644
--- a/libsepol/tests/test-linker-types.h
+++ b/libsepol/tests/test-linker-types.h
@@ -21,6 +21,8 @@
 #ifndef __TEST_LINKER_TYPES_H__
 #define __TEST_LINKER_TYPES_H__
 
+#include <sepol/policydb/policydb.h>
+
 extern void base_type_tests(policydb_t * base);
 extern void module_type_tests(policydb_t * base);
 
-- 
2.34.1


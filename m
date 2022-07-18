Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D707C43334
	for <selinux@archiver.kernel.org>; Mon, 18 Jul 2022 10:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbiGRKv1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Jul 2022 06:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiGRKv0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Jul 2022 06:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89BB91FCDA
        for <selinux@vger.kernel.org>; Mon, 18 Jul 2022 03:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658141484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=b5m8edJr/knOD2iKZv2WqZGnxGAG6rf4Scq3GhrtmmA=;
        b=gk0WkF1zoI5cR+cpM9MyZtYB4XyOpYPNAK7IVa5Ja2sTUtP2FHXGY3V4/GbHuUuHT6N4xM
        1YZ4QA+ndZV9mnYIaOf9oDzC4bKkOHN9iZX6x0hokuAihgQhnJeSH5v78SNuNpJc4NDUIm
        rso/DN0MtCMqpcUxJ4m+Teo7je8zimo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-P5ZNW-q_N8S4unhM4F3vvA-1; Mon, 18 Jul 2022 06:51:23 -0400
X-MC-Unique: P5ZNW-q_N8S4unhM4F3vvA-1
Received: by mail-wm1-f72.google.com with SMTP id v123-20020a1cac81000000b003a02a3f0beeso8514456wme.3
        for <selinux@vger.kernel.org>; Mon, 18 Jul 2022 03:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b5m8edJr/knOD2iKZv2WqZGnxGAG6rf4Scq3GhrtmmA=;
        b=ooupFBwonR/IqHwN+3vgH/Drzu05TJuikvrZSBhPqiXMVYHIm4GVQblipG6aNSRi87
         8HKSdKHHzW4iiLdJ3TSm/ot97bnsbogyHqVOWLVKnS3axnteHLwgmNbGO3SNbbiCdr25
         T2V2rsA4HLzDYhbujNbXRfawuzv+ET1eB90+ggH/uquXRypKXjOKmp3FjsVQDcElWAuu
         LPmLfB5mwkFxaI+dPDiVGvqDxKsqCRPkZIMV84RfhFDCcvIleJNv3f/seyHN21qxY/3L
         bsXtDIO/uZs/GIfXAYEBnAsPCBSyuCcyHIwnt4RkLrB9lmmHQOUfmcdCpLExDqVz+xcg
         dAkw==
X-Gm-Message-State: AJIora9JajCd2YF7TetzHv1z1H9X7NsKB9E+0oa+Nu1+2lRxOCRDBO2J
        LuQwFzzugQMIgVv/BuPYe0hZfvNz9cM5JhpXCoirakjrR9X+A9sqmtzKJg1n6hgqc/3qjDwDGIc
        lGHsvM5WckADAZHVYfrkskifp2XRCHd5YqINHlIAh9BTHiTHG9UPSdSpTzp3jBcB6ziKsaA==
X-Received: by 2002:a05:6000:185:b0:21d:7ffc:4916 with SMTP id p5-20020a056000018500b0021d7ffc4916mr22582872wrx.692.1658141481881;
        Mon, 18 Jul 2022 03:51:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u8VGR6sanWSspOPeL2vA3/pjFu3IrwF7F0ZFH0ZF3XXafPtSpI84ePVFWbbBvzXvKspi+nNQ==
X-Received: by 2002:a05:6000:185:b0:21d:7ffc:4916 with SMTP id p5-20020a056000018500b0021d7ffc4916mr22582850wrx.692.1658141481471;
        Mon, 18 Jul 2022 03:51:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003a04722d745sm19469182wmq.23.2022.07.18.03.51.20
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 03:51:21 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/module_load: detect the linker to use for module build
Date:   Mon, 18 Jul 2022 12:51:20 +0200
Message-Id: <20220718105120.674121-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Similar to the compiler, matching the linker used to compile the kernel
is also important for an external kernel module build. Add code to
detect the linker from the kernel config similar to the existing
compiler detection.

Speicifically, this fixes kernel module builds under kernels built with
clang and with LTO enabled.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/module_load/Makefile | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/tests/module_load/Makefile b/tests/module_load/Makefile
index 272872d..0839532 100644
--- a/tests/module_load/Makefile
+++ b/tests/module_load/Makefile
@@ -4,12 +4,15 @@ TARGETS = finit_load init_load
 LDLIBS += -lselinux
 KDIR = /lib/modules/$(shell uname -r)/build
 
-# Make sure to use the same compiler as the kernel was built with.
-# If the compilers don't match, the build will fail on unsupported compiler
+# Make sure to use the same compiler+linker as the kernel was built with.
+# If the compilers/linkers don't match, the build could fail on unsupported
 # flags and even if not, the resulting module would likely fail to load.
-# If the kernel was compiled with neither GCC nor clang (currently the only
-# supported compilers), fall back to the default compiler and hope for the best.
-# In all cases allow the user to override the compiler via the KCC variable.
+# If the kernel was compiled with a compiler other than GCC or clang or a
+# linker other than ld.bfd or ld.lld, fall back to the default compiler/linker
+# and hope for the best.
+# In all cases allow the user to override the compiler via the KCC/KLD
+# variables.
+
 DETECTED_KCC = unknown
 ifeq ($(shell grep -qFx CONFIG_CC_IS_GCC=y $(KDIR)/.config && echo true),true)
 	DETECTED_KCC = gcc
@@ -23,9 +26,22 @@ else
 	KCC ?= $(CC)
 endif
 
+DETECTED_KLD = unknown
+ifeq ($(shell grep -qFx CONFIG_LD_IS_BFD=y $(KDIR)/.config && echo true),true)
+	DETECTED_KLD = ld.bfd
+endif
+ifeq ($(shell grep -qFx CONFIG_LD_IS_LLD=y $(KDIR)/.config && echo true),true)
+	DETECTED_KLD = ld.lld
+endif
+ifneq ($(DETECTED_KLD),unknown)
+	KLD ?= $(DETECTED_KLD)
+else
+	KLD ?= $(LD)
+endif
+
 all: $(TARGETS)
-	$(MAKE) -C $(KDIR) CC=$(KCC) M=$(PWD)
+	$(MAKE) -C $(KDIR) CC=$(KCC) LD=$(KLD) M=$(PWD)
 
 clean:
 	rm -f $(TARGETS)
-	$(MAKE) -C $(KDIR) CC=$(KCC) M=$(PWD) clean
+	$(MAKE) -C $(KDIR) CC=$(KCC) LD=$(KLD) M=$(PWD) clean
-- 
2.36.1


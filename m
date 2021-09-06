Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FBDC433F5
	for <selinux@archiver.kernel.org>; Mon,  6 Sep 2021 10:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF6E60BD3
	for <selinux@archiver.kernel.org>; Mon,  6 Sep 2021 10:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhIFKzq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Sep 2021 06:55:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233893AbhIFKzp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Sep 2021 06:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630925680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CDkol6FDHVv9qx4guuQGsLXsKQVdwPpG05iaeadJP3M=;
        b=OBxMVA6kKDuFwhDg10WTrQOV2JIkGFXgeJ+JUsA4a+fwV5Qa6iPS6fbjUco4vgMYrG0zJk
        f1ggoMgTDRhzarjbzpZICTYdvo8ezZlTZXI/hpdRmOtpiAHEsf8rDDqbnNUIJ0zwxOSUWq
        SlWA4fZW26j0FqijQcQpEDAyEpv9gVc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-48QfucfDOhuTrVGeMUKboQ-1; Mon, 06 Sep 2021 06:54:39 -0400
X-MC-Unique: 48QfucfDOhuTrVGeMUKboQ-1
Received: by mail-wm1-f71.google.com with SMTP id m22-20020a7bcb96000000b002f7b840d9dcso3088018wmi.1
        for <selinux@vger.kernel.org>; Mon, 06 Sep 2021 03:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CDkol6FDHVv9qx4guuQGsLXsKQVdwPpG05iaeadJP3M=;
        b=SoixeJdFczptx8JfsZk261Oswq7om2Yu0Qn6u1Wcj/gx1vITG4+WVRWv24JOH+yv9o
         gwuH/oivbK6Tl9IUWFjMeTkRWtSGLALthnq7ynzLt5msfq82FbPhxfUbDmBSikORai6m
         LH9QnqAngP/7c7ryu5tT9h3U9uJQuByzDSFmQD3BjE09AKJrCU0x46svGaLzWwyo3nLR
         vEm1K7IDvW6UXG0CiH3PtSigtgpLOHuBhkkSutSMUyZ/tnv3Cp/XI3GF7RCUvR3Bznce
         IEAY8mZpgxQ9wnM76MGk8V/Ca1flWQ3mPA8YVPNtpKzWi+Ch1qGms54aqMrf3c4nZL05
         Q+Lg==
X-Gm-Message-State: AOAM531CXRncgonIE6oaK/kYcZFjamO7jABq3oWSD7r939cuT5ApUt8V
        Pnk2fXzHZuS8UYAAUQxqzGCwd+MM7SUCryyzT5gSdcsdKZsPoQ+2oieqUpFvOFjS3OGhTZGFIUV
        NWbtRecmlzFvrM3ISYvgWxX9uDrdkz561ZVRfYuGdobx4YzP2oY42epstp0kuWHlhg6BHMA==
X-Received: by 2002:adf:b78d:: with SMTP id s13mr12924893wre.344.1630925678268;
        Mon, 06 Sep 2021 03:54:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytrvdYyamS4xx993Ols2qjqKFqI6n8cnhpUD19B+OlY8SjEfFM1JSPrtpMhMzL6SCH5+9ovw==
X-Received: by 2002:adf:b78d:: with SMTP id s13mr12924867wre.344.1630925678009;
        Mon, 06 Sep 2021 03:54:38 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id m12sm7461878wrq.29.2021.09.06.03.54.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 03:54:37 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 2/2] tests/module_load: use the right compiler to build kernel modules
Date:   Mon,  6 Sep 2021 12:54:35 +0200
Message-Id: <20210906105435.96417-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210906105435.96417-1-omosnace@redhat.com>
References: <20210906105435.96417-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Kernel modules need to be built with the same compiler as the kernel was
built with. Thus, try to explicitly pass the right compiler (detected
from kernel config) to Make when compiling the modules, so that the
testsuite can be successfully built also on systems with clang-built
kernel, but with GCC as the default compiler.

Note that the rest of the testsuite doesn't currently build with clang,
so just changing CC for the whole testuite is not enough as a
workaround. And even after fixing testsuite to build with clang, it will
be beneficial to be able to use a different compiler to build the
testsuite than the one needed for the kernel modules - for example to
find more bugs by building the test programs with multiple compilers in
CI.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/module_load/Makefile | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/tests/module_load/Makefile b/tests/module_load/Makefile
index ce34241..272872d 100644
--- a/tests/module_load/Makefile
+++ b/tests/module_load/Makefile
@@ -4,9 +4,28 @@ TARGETS = finit_load init_load
 LDLIBS += -lselinux
 KDIR = /lib/modules/$(shell uname -r)/build
 
+# Make sure to use the same compiler as the kernel was built with.
+# If the compilers don't match, the build will fail on unsupported compiler
+# flags and even if not, the resulting module would likely fail to load.
+# If the kernel was compiled with neither GCC nor clang (currently the only
+# supported compilers), fall back to the default compiler and hope for the best.
+# In all cases allow the user to override the compiler via the KCC variable.
+DETECTED_KCC = unknown
+ifeq ($(shell grep -qFx CONFIG_CC_IS_GCC=y $(KDIR)/.config && echo true),true)
+	DETECTED_KCC = gcc
+endif
+ifeq ($(shell grep -qFx CONFIG_CC_IS_CLANG=y $(KDIR)/.config && echo true),true)
+	DETECTED_KCC = clang
+endif
+ifneq ($(DETECTED_KCC),unknown)
+	KCC ?= $(DETECTED_KCC)
+else
+	KCC ?= $(CC)
+endif
+
 all: $(TARGETS)
-	$(MAKE) -C $(KDIR) M=$(PWD)
+	$(MAKE) -C $(KDIR) CC=$(KCC) M=$(PWD)
 
 clean:
 	rm -f $(TARGETS)
-	$(MAKE) -C $(KDIR) M=$(PWD) clean
+	$(MAKE) -C $(KDIR) CC=$(KCC) M=$(PWD) clean
-- 
2.31.1


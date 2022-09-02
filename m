Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28765C6FA81
	for <selinux@archiver.kernel.org>; Fri,  2 Sep 2022 08:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbiIBInJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Sep 2022 04:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbiIBInB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Sep 2022 04:43:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871E9AF0E8
        for <selinux@vger.kernel.org>; Fri,  2 Sep 2022 01:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662108174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DgPczeZ6OvINEzZZnv/1WXPTqSrM4TMnwAvRUQsluhI=;
        b=EQtrSMBvqZFaD8Ck3GT/a8D47sXl2HeGLoi8bMMnK1RqEOg7LHQQfmPue8yUYru4hsBkvH
        sryygAVIsCAcMLE7YoMYuG3TmBthLPzzC9OEskodI105xgQZDxL15Hm2Yg4prwM5BaT/Qi
        ZfUk6yOsTfSlS4Pg+73ufZBuBiBlnKM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-292-n8r9e5EiNhmHsxenhRMR_g-1; Fri, 02 Sep 2022 04:42:50 -0400
X-MC-Unique: n8r9e5EiNhmHsxenhRMR_g-1
Received: by mail-ej1-f71.google.com with SMTP id sh44-20020a1709076eac00b00741a01e2aafso728943ejc.22
        for <selinux@vger.kernel.org>; Fri, 02 Sep 2022 01:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=DgPczeZ6OvINEzZZnv/1WXPTqSrM4TMnwAvRUQsluhI=;
        b=HbECDGl7mO2zhpx8YRADpWoCpOfMUH+SHDu14Nka6eYyzxsN27iKJG9ee/K8tRiX0y
         I9L3/lB1GIXWCNnNnmvBRjp8KZNdWzQk54O9bJ+KdpcUPL331vHhFFmU1Q7AjcrtaWz1
         QiD41AoA0BjK2jm4yoqd0+sMPC13LGV2v0hXAJ9Tfrl+07q/o9OpemgRTpyv/cDPDFFY
         Cj4LI2FfVCqWq/bTX4g/kKTY3vebDcyQlK3E1vr0X89MslTkMYxC84NpIOalMVwvB+5S
         ewioR4m4arTI7MpV6y/QKdBWBMb/kg4NYrkdGVC9aCUYIPp5Zxgp3mbUgr3qk1n7SG3r
         r3vQ==
X-Gm-Message-State: ACgBeo1qDFfX4VUuTLwyF+y+jz2Lp2QKQyaPV/XSVVorqAIP6twl9wfG
        C1Rf7xBQ3Sk/mknaZvtik7V0Ih2R2tawGS87y/yczt4B0YEFF0eNdL6tbGBkx4A14XoC7R6G6Xb
        5uG6MZSsQ/9+axyjdSSeO0PsBG7xp5atyTbTGDz9wkMRATZF013XrvL3m3R0WHdX3Z7HIlw==
X-Received: by 2002:a17:907:3e85:b0:73d:60cc:5d06 with SMTP id hs5-20020a1709073e8500b0073d60cc5d06mr27084315ejc.722.1662108169186;
        Fri, 02 Sep 2022 01:42:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4araYRlPJ47vSIg+XjPRJ3ERTHpLOSBNS9wT58/7OGpRUurwalEiyqDDou2fMdxtvETkFLcA==
X-Received: by 2002:a17:907:3e85:b0:73d:60cc:5d06 with SMTP id hs5-20020a1709073e8500b0073d60cc5d06mr27084300ejc.722.1662108168963;
        Fri, 02 Sep 2022 01:42:48 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b13-20020a17090630cd00b007308812ce89sm864787ejb.168.2022.09.02.01.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 01:42:48 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Dennis Li <denli@redhat.com>
Subject: [PATCH testsuite] tests/Makefile: add missing condition for userfaultfd test
Date:   Fri,  2 Sep 2022 10:42:47 +0200
Message-Id: <20220902084247.1042660-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The commit referenced below disables the test_userfaultfd.te policy when
the anon_inode class is not defined in the system policy, but doesn't
disable the test itself in this situation. Thus, on distros that don't
define the class the test might be run and fail.

Fix this by adding the same condition to tests/Makefile.

Fixes: 2b6ea9d2bc96 ("policy: remove CIL workarounds for missing anon_inode class")
Reported-by: Dennis (Zhuoheng) Li <denli@redhat.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile b/tests/Makefile
index 8abd438..f473111 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -134,10 +134,12 @@ endif
 endif
 
 ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] && echo true),true)
+ifeq ($(shell grep -q anon_inode $(POLDEV)/include/support/all_perms.spt && echo true),true)
 ifeq ($(shell test -e $(INCLUDEDIR)/linux/userfaultfd.h && echo true),true)
 SUBDIRS += userfaultfd
 endif
 endif
+endif
 
 ifeq ($(shell grep -q vsock_socket $(POLDEV)/include/support/all_perms.spt && echo true),true)
 ifeq ($(shell grep -qs VMADDR_CID_LOCAL $(INCLUDEDIR)/linux/vm_sockets.h && echo true),true)
-- 
2.37.2


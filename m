Return-Path: <SRS0=8qmv=EF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5A6C388F9
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 21:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02DED221FA
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 21:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfHxlxRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgJ3VVR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Oct 2020 17:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29587 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727746AbgJ3VVR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Oct 2020 17:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604092875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6R71VDAQ3E7XVp8uRDnlw4FVaRXnIFXl9Xm3R20COKo=;
        b=HfHxlxRZCHlIcEB5WDHHiq3/l/uPhgDy1pw14Hx6fHbQsUrmYaX8WP13Qfa0nf2Fm5jlmO
        5xFGakyenEAbmFEHSYjAekDIQeN/tG2hWNRBAriJ80Rj0Ympvr/zSYvdvIDjjfFOAxsEvj
        +Y6gc7yvm9qa4lF3NEWtFdk3iM4Khcs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-BcvZmgrpOZ2zJaIHK7fEhQ-1; Fri, 30 Oct 2020 17:21:12 -0400
X-MC-Unique: BcvZmgrpOZ2zJaIHK7fEhQ-1
Received: by mail-ed1-f72.google.com with SMTP id ay19so3123085edb.23
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2020 14:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6R71VDAQ3E7XVp8uRDnlw4FVaRXnIFXl9Xm3R20COKo=;
        b=BBTuHId4ngeliONgBsBS/LjIwgiSZPMTNDVeswhRHhiGw7lNdyV64bXqmb9bDnzQnQ
         P4TfptJFxCrVWEPtj2QwNSkCDf6zkc+lNGlYbmEeI+ICG4HUhj3xzN08Acb5ZSivCjCy
         aZKIrnnosK5PKigMvb1GofwDcbkS+4Ze2MdZ9txRwh1ANW06WxqBcwJKYb39824VpMF4
         yOb3yWJ8O/OFDJJGL3rU4Y93aNyGmGVOvZAV68+PyOYlb7a1m99MzLB2mG8x+2e77l03
         sS1Y3aD97gvD7uL+7aaJFp21fJpB/jYc2UkIHlyHVIzPQUy/CdUIwelzT23chcJmGTSG
         eUeQ==
X-Gm-Message-State: AOAM5313ykTPtTfeNG0GNQR/IcKTRkIMnv865+TD5OIcgJwJRiJJ/TM0
        iAyak/9Iu6b+CHmqIzwGKZpOUWEKbMRqT2BGspIttOIlIUL4S+jaJrDI4584Xfnc0VMKoQKT0iJ
        YYMXz3jhE1D3b4/vsYQ==
X-Received: by 2002:a17:906:c20f:: with SMTP id d15mr4356530ejz.341.1604092870734;
        Fri, 30 Oct 2020 14:21:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlBZweYaQZ/rej88dt+1+7JsO67aW2QCuj3l5IzjWjckswLUZhKhU3rf3ceX2q66NzUC38BA==
X-Received: by 2002:a17:906:c20f:: with SMTP id d15mr4356524ejz.341.1604092870540;
        Fri, 30 Oct 2020 14:21:10 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id r24sm3497851eds.67.2020.10.30.14.21.09
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 14:21:09 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] travis: skip kernel update+reboot if it's not necessary
Date:   Fri, 30 Oct 2020 22:21:08 +0100
Message-Id: <20201030212108.112831-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Only do it when we can't install the kernel-modules package for the
running kernel to make the CI run faster. Now that rawhide images are
updating regularly again, it is rarely necessary.

Also don't run `dnf clean all -y` before installing dependencies. There
really is no point and it just slows things down when we do need to
update the kernel.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 travis-ci/run-kvm-test.sh  | 21 ++++++++++++---------
 travis-ci/run-testsuite.sh |  1 -
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/travis-ci/run-kvm-test.sh b/travis-ci/run-kvm-test.sh
index d22c92b..6afbf96 100755
--- a/travis-ci/run-kvm-test.sh
+++ b/travis-ci/run-kvm-test.sh
@@ -121,15 +121,18 @@ fi
 # so forks know where to go.
 #
 
-# First update to the latest kernel.
-ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" \
-    dnf install -y kernel
-
-# Then reboot.
-sudo virsh reboot fedoravm
-sleep 5
-
-while ! nc -w 10 -z "$ipaddy" 22; do sleep 0.5s; done
+# Check if kernel-modules-$(uname -r) can be installed from repos,
+# otherwise update kernel and reboot.
+kernel_avail="$(ssh -tt -o StrictHostKeyChecking=no -q "root@$ipaddy" \
+    sh -c "dnf check-update kernel-modules-\$(uname -r) | wc -l")"
+if [ $kernel_avail -eq 0 ]; then
+    ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" \
+        dnf update -y kernel-core
+
+    sudo virsh reboot fedoravm
+    sleep 5
+    while ! nc -w 10 -z "$ipaddy" 22; do sleep 0.5s; done
+fi
 
 # And run the testsuite.
 project_dir="$(basename "$TRAVIS_BUILD_DIR")"
diff --git a/travis-ci/run-testsuite.sh b/travis-ci/run-testsuite.sh
index 9b5f954..051f9d8 100755
--- a/travis-ci/run-testsuite.sh
+++ b/travis-ci/run-testsuite.sh
@@ -16,7 +16,6 @@ pwd
 # the CI.
 setenforce 0
 
-dnf clean all -y
 dnf install -y \
     --allowerasing \
     --skip-broken \
-- 
2.26.2


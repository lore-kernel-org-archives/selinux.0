Return-Path: <SRS0=8qmv=EF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281FDC00A89
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 21:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F2520A8B
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 21:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nsm4z96F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgJ3VNg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Oct 2020 17:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbgJ3VNf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Oct 2020 17:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604092414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ABvvsdT/obAbdqPDP+KHa2BldpCFD7GxbGL90V11Y80=;
        b=Nsm4z96F16BvWmp0dTbLgCwkCcFTK+woZY/uoix2DNpXNSjZKM+c+mYmAxQV0EyODrW74A
        JzJT6l+R7ZojjqRgW2Fs7BfSi05nauweFrtmGcvrqr+VvV4pkzYIss5vqCBSNiL7e/YNNT
        XHfxumsiW+G6JwoRmQxxIKdYMm1uWRU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-lohF7B6cMyqQ9rZZoWpB3g-1; Fri, 30 Oct 2020 17:13:32 -0400
X-MC-Unique: lohF7B6cMyqQ9rZZoWpB3g-1
Received: by mail-ed1-f72.google.com with SMTP id b68so1101511edf.9
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2020 14:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ABvvsdT/obAbdqPDP+KHa2BldpCFD7GxbGL90V11Y80=;
        b=tWNW0GtNP33TP45jymPYZ3Aevi4ZlDmb4303Mewi6i8999xVgZ+FQvt2Xik+t8CGrD
         eU05+B+kP7T0biETTHCkQPHZUdCkK5AqtF1zu4s+Y/Mma/mQgbh1Gj8EyR8i7wQRNMWk
         GGk5tUOzFuBl0Fndwn36TFyAbea1woh98m12oI/R8BK6vjxl2xAPfDvR4PLDH0ze5VrI
         PbtT8EYZmyf+Yp81T54cpnXSkdAL8aW8Hgk+Lg2LSlfzTEag2E73asxjHUS41IK0vMUB
         XU1wCignSoGWyQSnyUCoKHCQeGa2FMlqyKp0lUoaPLjX5Zwxpy2/YCg/RNc7Qo4d5Uup
         kzGg==
X-Gm-Message-State: AOAM533MBsG1pmKrnp6TT3zMfwd4Va9tDSbzBDdCuIxOcKA9rw31sz8i
        C7emlgkEGkgTxG9j/MX2PxlNI2yNcIIZUsHvUTXErloTg0wb0yWriV/p1DFJ4bvdxPEIB8Ft/wa
        47A1/1osM7dfW07epbQ==
X-Received: by 2002:a50:fe05:: with SMTP id f5mr4786582edt.366.1604092410738;
        Fri, 30 Oct 2020 14:13:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3VfBxZMoJ1KfffdVu2bYfSOEFdSrFMObL63HK3yrnq6jeF72+pYR247e9sglWXjGm3PKcKA==
X-Received: by 2002:a50:fe05:: with SMTP id f5mr4786564edt.366.1604092410535;
        Fri, 30 Oct 2020 14:13:30 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id ld2sm3362773ejb.94.2020.10.30.14.13.28
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 14:13:29 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2] ci: use parallel build
Date:   Fri, 30 Oct 2020 22:13:27 +0100
Message-Id: <20201030211327.111834-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Pass -j$(nproc) to all make invocations to make the CI run a little
faster.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v2: use POSIX $() instead of ``

 .travis.yml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index bd3c9842..8ea6cc74 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -74,7 +74,7 @@ install:
   - tar -C "$TRAVIS_BUILD_DIR" -xvjf "$TRAVIS_BUILD_DIR/refpolicy.tar.bz2"
   # Make refpolicy Makefile use the new toolchain when building modules
   - sed -e "s,^PREFIX :=.*,PREFIX := \$(DESTDIR)/usr," -i "$TRAVIS_BUILD_DIR/refpolicy/support/Makefile.devel"
-  - sudo make -C "$TRAVIS_BUILD_DIR/refpolicy" install-headers
+  - sudo make -j$(nproc) -C "$TRAVIS_BUILD_DIR/refpolicy" install-headers
   - sudo rm -rf "$TRAVIS_BUILD_DIR/refpolicy.tar.bz2" "$TRAVIS_BUILD_DIR/refpolicy"
   - sudo mkdir -p /etc/selinux
   - echo 'SELINUXTYPE=refpolicy' | sudo tee /etc/selinux/config
@@ -129,12 +129,12 @@ before_script:
 
 script:
   # Start by installing everything into $DESTDIR
-  - make install $EXPLICIT_MAKE_VARS -k
-  - make install-pywrap $EXPLICIT_MAKE_VARS -k
-  - make install-rubywrap $EXPLICIT_MAKE_VARS -k
+  - make -j$(nproc) install $EXPLICIT_MAKE_VARS -k
+  - make -j$(nproc) install-pywrap $EXPLICIT_MAKE_VARS -k
+  - make -j$(nproc) install-rubywrap $EXPLICIT_MAKE_VARS -k
 
   # Now that everything is installed, run "make all" to build everything which may have not been built
-  - make all $EXPLICIT_MAKE_VARS -k
+  - make -j$(nproc) all $EXPLICIT_MAKE_VARS -k
 
   # Set up environment variables for the tests
   - . ./scripts/env_use_destdir
-- 
2.26.2


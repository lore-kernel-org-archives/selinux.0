Return-Path: <SRS0=8qmv=EF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45DAC00A89
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 20:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D04F20739
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 20:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJz3D6RI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgJ3UYX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Oct 2020 16:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25470 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725975AbgJ3UYW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Oct 2020 16:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604089461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=q6VFUs2Vw8oiUKrd8FxQZAvLDAMB9wytjE1q62W36PA=;
        b=ZJz3D6RIZzK7s3ZziVaWS4kVn+45BqQlB54BNuJ+h4RTPlSWT+GU90qFKTqnBCnBt9+hpv
        FFTCIri3ZBlpSjXDRRJnNqmSLN98Y5Ulxy1UaOPmumHI/rlBi5H9GI8b/Q2GTQbwaWFtbb
        CVrZc13ulKds00samE1IUBT3u3r+9s8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-NUGBx6v2OtO4irhEe2PMRQ-1; Fri, 30 Oct 2020 16:24:19 -0400
X-MC-Unique: NUGBx6v2OtO4irhEe2PMRQ-1
Received: by mail-ej1-f70.google.com with SMTP id p6so2898164ejj.5
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2020 13:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6VFUs2Vw8oiUKrd8FxQZAvLDAMB9wytjE1q62W36PA=;
        b=BRR1f6pvv1bCyNoZje+xrP6eQvsSGYJlHWP8oFqgrbeb0eT3u3V0fC005wjz/GDNUb
         WH3VgydfLnGjRpF+1QB7R5ZEInv6w+7sjwFXumj2p/SwagIHnLJIWuLfBV2r1EpGvoor
         yiM9gQyluI4EG0Gf8SPuzPg54rVqoh2fPhml6ltE7FSndt7FJ1LzeBC9Sxsr10z6y67Y
         aKls0Jrpc9zerW6yF+onzmDphK5571CtJYNnQztJq/sTEl16GJiY9gNXIenvs70T3ri4
         ij85oK1fCN+YMHroDjMyKc6+VIXIMJBLi0iJM56V5qiZFs23VmZ33lIapI/ixjQf+sGf
         lJ2A==
X-Gm-Message-State: AOAM532z7/oFe+tUmaSE4XOL/THMx6UiPbb36+5hvt8gl31XStoyU468
        UF1hJoG5iLfAZ5XdUVCrw0Qkznvft7JXgJZaGtUyFUxNa2EYcnpGx4khFvvqqX7WUCB/c0xZ7Ga
        77Jplv6X2RRc6IkhbPw==
X-Received: by 2002:a17:907:c23:: with SMTP id ga35mr4161819ejc.36.1604089457886;
        Fri, 30 Oct 2020 13:24:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDfCcJKzBJFBeeogcC9/N4Z2p9wpzWW59rYg35C2LcjXSOzCyIdGZxEQiiG1v0UjqEqKAYcw==
X-Received: by 2002:a17:907:c23:: with SMTP id ga35mr4161810ejc.36.1604089457648;
        Fri, 30 Oct 2020 13:24:17 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id n3sm3533911edq.24.2020.10.30.13.24.16
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 13:24:16 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace] ci: use parallel build
Date:   Fri, 30 Oct 2020 21:24:15 +0100
Message-Id: <20201030202415.106291-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Pass -j`nproc` to all make invocations to make the CI run a little
faster.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .travis.yml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index bd3c9842..2e225dd2 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -74,7 +74,7 @@ install:
   - tar -C "$TRAVIS_BUILD_DIR" -xvjf "$TRAVIS_BUILD_DIR/refpolicy.tar.bz2"
   # Make refpolicy Makefile use the new toolchain when building modules
   - sed -e "s,^PREFIX :=.*,PREFIX := \$(DESTDIR)/usr," -i "$TRAVIS_BUILD_DIR/refpolicy/support/Makefile.devel"
-  - sudo make -C "$TRAVIS_BUILD_DIR/refpolicy" install-headers
+  - sudo make -j`nproc` -C "$TRAVIS_BUILD_DIR/refpolicy" install-headers
   - sudo rm -rf "$TRAVIS_BUILD_DIR/refpolicy.tar.bz2" "$TRAVIS_BUILD_DIR/refpolicy"
   - sudo mkdir -p /etc/selinux
   - echo 'SELINUXTYPE=refpolicy' | sudo tee /etc/selinux/config
@@ -129,12 +129,12 @@ before_script:
 
 script:
   # Start by installing everything into $DESTDIR
-  - make install $EXPLICIT_MAKE_VARS -k
-  - make install-pywrap $EXPLICIT_MAKE_VARS -k
-  - make install-rubywrap $EXPLICIT_MAKE_VARS -k
+  - make -j`nproc` install $EXPLICIT_MAKE_VARS -k
+  - make -j`nproc` install-pywrap $EXPLICIT_MAKE_VARS -k
+  - make -j`nproc` install-rubywrap $EXPLICIT_MAKE_VARS -k
 
   # Now that everything is installed, run "make all" to build everything which may have not been built
-  - make all $EXPLICIT_MAKE_VARS -k
+  - make -j`nproc` all $EXPLICIT_MAKE_VARS -k
 
   # Set up environment variables for the tests
   - . ./scripts/env_use_destdir
-- 
2.26.2


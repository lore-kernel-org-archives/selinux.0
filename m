Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C01C4167B
	for <selinux@archiver.kernel.org>; Thu,  9 Nov 2023 13:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjKINwE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Nov 2023 08:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbjKINwD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Nov 2023 08:52:03 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6C930CD
        for <selinux@vger.kernel.org>; Thu,  9 Nov 2023 05:52:00 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9c773ac9b15so141022566b.2
        for <selinux@vger.kernel.org>; Thu, 09 Nov 2023 05:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699537919; x=1700142719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LFixxeXtTYJPX/sgnEqDWhRfZXDxOfF4YviIgKtDIuc=;
        b=Fe/3nWjECFWQG8sIL3sRuPNJMmDuihI8+U/dQgVfLRpARUeoexU+OkZFq7j8oZMw4H
         9zjdOaXOI6AGjtJ2gd9sp/qq0tQh4KrLDEY/8HbQ2AT7AmVMt49LrrieVUs3jYlW3DKL
         aARyXHGhKJ045dy5Xng9e/lfaveHwa5f0zss/caypR5NE1EcNZJiJU9mjqvTNbPCcrp1
         Z2nmLk5E5lDmJSsFcO2uYrH8iHVBli6tuZBhmwOvj3XO8tXdP7pu5X8aW1a437YvkdUi
         Zt1ZGxB9XZs1H9hQ6fpNsUG0NbcnNJkV3FivG49XXLy0ztYag3PFcb95GcCJMkQRwjcO
         /blA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699537919; x=1700142719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFixxeXtTYJPX/sgnEqDWhRfZXDxOfF4YviIgKtDIuc=;
        b=RI3+iQ0gKbgSJV+T9EcZ+VuRicvcATvVaqESNgQS5d+lxxDydZ1m7iABMWxycBUV2m
         dUb69szjTB9qtl3YI3pHbNDAb/9uuK1zsQoF4QloSPMxsAavtPgAyFiJvFf0PHctiMQF
         2z3LbU0SsfUm/TLuxwWAfH4VxWLZFZHfCYQsMzG4Y0JLzpWcVzrO1jZYjS3GuoNuVMgL
         SqAE1wSO01Gif77QMqYHuuMTfiLIyu5uBflT0lJ9vszu1W13YsOFTtSABSsjU+mSU+4z
         toRLNXkCNd3TFkT45XKNNvAiUkYB1tzIqlKe9vPePOKQTvm3TfTHszkUoJW4nxwQSWMA
         ifbg==
X-Gm-Message-State: AOJu0YxsZ2wTzhUl4bg/fWzKswcLRO7HLWF2qm2QLzUL4FBAte5Jy8ju
        7wKijJYHet/1s6VS6gtO85FAGloaIxw=
X-Google-Smtp-Source: AGHT+IF0XqNth415ylNlEzBSvTzpixnHtz4bXE4ASge4es0JKWTEfRocD6s/KzDsPvkebjJmF88RaQ==
X-Received: by 2002:a17:906:31da:b0:9e5:3a0:8610 with SMTP id f26-20020a17090631da00b009e503a08610mr1202328ejf.30.1699537913574;
        Thu, 09 Nov 2023 05:51:53 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-000-043-071.77.0.pool.telefonica.de. [77.0.43.71])
        by smtp.gmail.com with ESMTPSA id bv15-20020a170906b1cf00b009829d2e892csm2623563ejb.15.2023.11.09.05.51.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:51:53 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/7] Drop Travis CI configuration
Date:   Thu,  9 Nov 2023 14:51:43 +0100
Message-ID: <20231109135148.42688-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109135148.42688-1-cgzones@googlemail.com>
References: <20231109135148.42688-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Travis CI stopped providing free CI services for open-source projects in
2020[1] and the last build happened more than two years ago[2].

[1]: https://www.travis-ci.com/blog/2020-11-02-travis-ci-new-billing/
[2]: https://app.travis-ci.com/github/SELinuxProject/selinux

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 .travis.yml | 14 --------------
 README.md   |  1 -
 2 files changed, 15 deletions(-)
 delete mode 100644 .travis.yml

diff --git a/.travis.yml b/.travis.yml
deleted file mode 100644
index 1c2c7f33..00000000
--- a/.travis.yml
+++ /dev/null
@@ -1,14 +0,0 @@
-# Define the building environment
-language: c
-
-# Use Travis-CI Ubuntu 18.04 Bionic Beaver, "full image" variant
-sudo: required
-dist: bionic
-
-script:
-  - FEDORA_MAJOR=33 FEDORA_MINOR=1.2 scripts/ci/travis-kvm-setup.sh
-
-# Do not spam by email so long as the build succeeds
-notifications:
-  email:
-    on_success: never
diff --git a/README.md b/README.md
index c272ce89..8c475126 100644
--- a/README.md
+++ b/README.md
@@ -116,7 +116,6 @@ This can be done using [./scripts/env_use_destdir](./scripts/env_use_destdir):
     DESTDIR=~/obj ./scripts/env_use_destdir make test
 
 Some tests require the reference policy to be installed (for example in `python/sepolgen`).
-In order to run these ones, instructions similar to the ones in section `install` of [./.travis.yml](./.travis.yml) can be executed.
 
 To install as the default system libraries and binaries
 (overwriting any previously installed ones - dangerous!),
-- 
2.42.0


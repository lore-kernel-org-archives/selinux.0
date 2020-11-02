Return-Path: <SRS0=BHhV=EI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32061C00A89
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 09:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C78662225E
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 09:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LnZj1WuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgKBJnS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Nov 2020 04:43:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728078AbgKBJnS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Nov 2020 04:43:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604310196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iESeUFYG8bN7W32aiONh/ACnGfTnQ3RZl/8DfP0X17U=;
        b=LnZj1WuLE/aZI9Rm0q3/ZyUJSJX/bQL2ABKBtOXvE2c7dkel6IsjVksyQu7MKwAjwfEAG6
        hlIo/MIOuaePll9rQVFCcwsbUZfip+B4Kp34rAwMx5SX1BSbGzorh1EMH9fPDtjgFynerc
        z3Obd9/JUZKkTAkzbm+VywRdiDMUEjc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-Tt8rvMdIOuOJmZZGck6a2A-1; Mon, 02 Nov 2020 04:43:14 -0500
X-MC-Unique: Tt8rvMdIOuOJmZZGck6a2A-1
Received: by mail-ej1-f72.google.com with SMTP id dx19so3497719ejb.7
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2020 01:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iESeUFYG8bN7W32aiONh/ACnGfTnQ3RZl/8DfP0X17U=;
        b=LP8IbtOGbGPCO5UmEafLKNOqTeY0gOiZHFH+Px4Tqw/aAeyzLzPICV8KjLblOwLwYL
         Lw4iJU+huY5N1gZ4eiwRrOnB7xBf2cmRZVaX+RihTuC8x1BWfcAO//pGBjMfuT8tZE7I
         oZI61RGZrmnWHTORoDN1pOShr+gfG3bc6J5BAMu+nwv426xIDfJDgajRUwTETG9jA7hl
         +deOqIYAg4U82fkbn5csCSgDY9Y3AdUVGFwS5wW+COaVYFjFPR+h70a9MPLKhzcsyPxe
         fyt83QuM0iYLcen2a/2MlJ3kOb5iT12lTqgKB3zTdaXie+xc64MggUng1BIeba4JiZnB
         2fhg==
X-Gm-Message-State: AOAM530gcz443KrqowASF33SeMkW9hhKZX4XCELlYw6mTN9RA4tUZBjy
        6B9T7IjMM6myVgvCzfb8ssosGeTVlovUIGIPyEJZsBkd0SCHeVaHqrBNy+E/pwGV50Z1aaMXb5T
        awMaRBAP4hczTKUzCGg==
X-Received: by 2002:a50:d88c:: with SMTP id p12mr14970119edj.352.1604310192457;
        Mon, 02 Nov 2020 01:43:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8tVnMbyPTbohwa4D2t9tNflfHqfaVUP+fsyNlKzopMgSJR23Pf4qYIcK9exPIbLxu6mo/Gw==
X-Received: by 2002:a50:d88c:: with SMTP id p12mr14970109edj.352.1604310192144;
        Mon, 02 Nov 2020 01:43:12 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id pk25sm6170345ejb.16.2020.11.02.01.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 01:43:11 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     William Roberts <bill.c.roberts@gmail.com>
Subject: [PATCH userspace] ci: bump Fedora image version to 33
Date:   Mon,  2 Nov 2020 10:43:10 +0100
Message-Id: <20201102094310.484837-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The testsuite will soon be switching to testing multiple filesystems,
which exposes a bug in F32 image's kernel. Since Fedora 33 has been
released recently and the testsuite runs just fine on it, just bump the
image version to avoid the bug.

This commit also fixes the script to read out the Fedora image version
from environment variables instead of using hard-coded values.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .travis.yml                    |  2 +-
 scripts/ci/travis-kvm-setup.sh | 12 +++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 8ea6cc74..6c0f6241 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -36,7 +36,7 @@ matrix:
       env: PYVER=python3.8 RUBYLIBVER=2.7 LINKER=bfd
   include:
     - compiler: gcc
-      env: TRAVIS_RUN_KVM=true TRAVIS_CLOUD_IMAGE_VERSION="32:1.6"
+      env: TRAVIS_RUN_KVM=true FEDORA_MAJOR=33 FEDORA_MINOR=1.2
       install:
         - skip
       before_script:
diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup.sh
index 2b573417..756fab82 100755
--- a/scripts/ci/travis-kvm-setup.sh
+++ b/scripts/ci/travis-kvm-setup.sh
@@ -7,13 +7,15 @@ TEST_RUNNER="scripts/ci/fedora-test-runner.sh"
 #
 # Variables for controlling the Fedora Image version and download URLs.
 #
-MAJOR_VERSION="32"
-MINOR_VERSION="1.6"
+if [ -z "$FEDORA_MAJOR" ] || [ -z "$FEDORA_MINOR" ]; then
+    echo "$0: FEDORA_MAJOR and FEDORA_MINOR must be set!" 1>&2
+    exit 1
+fi
 
 BASE_URL="https://download.fedoraproject.org/pub/fedora/linux/releases"
-IMAGE_BASE_NAME="Fedora-Cloud-Base-$MAJOR_VERSION-$MINOR_VERSION.x86_64"
-IMAGE_URL="$BASE_URL/$MAJOR_VERSION/Cloud/x86_64/images/$IMAGE_BASE_NAME.raw.xz"
-CHECK_URL="$BASE_URL/$MAJOR_VERSION/Cloud/x86_64/images/Fedora-Cloud-$MAJOR_VERSION-$MINOR_VERSION-x86_64-CHECKSUM"
+IMAGE_BASE_NAME="Fedora-Cloud-Base-$FEDORA_MAJOR-$FEDORA_MINOR.x86_64"
+IMAGE_URL="$BASE_URL/$FEDORA_MAJOR/Cloud/x86_64/images/$IMAGE_BASE_NAME.raw.xz"
+CHECK_URL="$BASE_URL/$FEDORA_MAJOR/Cloud/x86_64/images/Fedora-Cloud-$FEDORA_MAJOR-$FEDORA_MINOR-x86_64-CHECKSUM"
 GPG_URL="https://getfedora.org/static/fedora.gpg"
 
 #
-- 
2.26.2


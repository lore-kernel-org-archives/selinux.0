Return-Path: <SRS0=8FG4=D4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A028C4363A
	for <selinux@archiver.kernel.org>; Wed, 21 Oct 2020 18:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8520208C3
	for <selinux@archiver.kernel.org>; Wed, 21 Oct 2020 18:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YW7awLxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439087AbgJUSdU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Oct 2020 14:33:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50094 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439017AbgJUSdT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Oct 2020 14:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603305198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8MHb6izU/7jzPgI8u4oNDfgfGD/7BvXhH62HQTn4SFw=;
        b=YW7awLxQm69Jg6/uQ2pNG3PExD2rARbulpaEqze7XSf65xeq+3F4vc44K767c4XsycxIaG
        IxCRp0gGIfMwtLoBmZ8mY3/g5J23t+Qxl6JImPR67UnI7DLDyDursqMg4r0DoEIjFzRakM
        cT2A02vzu43srMb2rANkUSMs0odbB/M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-5yzyBrHsPw601v58RowBsA-1; Wed, 21 Oct 2020 14:33:16 -0400
X-MC-Unique: 5yzyBrHsPw601v58RowBsA-1
Received: by mail-wr1-f69.google.com with SMTP id 91so2984419wrk.20
        for <selinux@vger.kernel.org>; Wed, 21 Oct 2020 11:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MHb6izU/7jzPgI8u4oNDfgfGD/7BvXhH62HQTn4SFw=;
        b=cKOZQWRMurXQ/eQ1ao+0g8koDV/K50KxHVYi7UwoPk0pBx07Wt7m8qqq70qLuCSyRn
         C3LWUr4bnPDxJQ/86q4UH7RgIMhz33R3Z2LwwAvq87ImCUnVU21ynn4ykqZ0ayeO40/m
         qXiBrYukEdFGTGaI6nHKJq7JPi4zPyv48LlskP1PuAxeDmeiViu7TVnwUZUDJCoxq7CR
         zr/QZKWN7fgnECSJj15fILDC3NSMO78EBE4JTifRtniIn9PT1COfYwQwORy+wjUzfsA4
         zwjaLCMz1P0BD1mjKYVSQ+yLzGLWgAZgb+4QXK15cSKHERTRhdC8rylkZNlt9xDY7pmk
         0i2A==
X-Gm-Message-State: AOAM532NlFF1PDJYoGhWZh805JO2/H3FLtlDtc4pCIz6U+ziRo9mTuSG
        Kb7B4iVolR4ZJdtEnLxUc2DzPkDwxiYLupdYC9Uv+9pOibra6T1p8+AJXKBpz6QKsnnbCTUJ8v5
        tLGV41LCKAjX64XTFVQ==
X-Received: by 2002:a5d:43c6:: with SMTP id v6mr6147634wrr.20.1603305195139;
        Wed, 21 Oct 2020 11:33:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5a6YpUbRlqFViVToX61GY86mVezVnxHq5XeH4ETH0BTcUijNUpO4ls83tlvYK2ONLfZoBeA==
X-Received: by 2002:a5d:43c6:: with SMTP id v6mr6147622wrr.20.1603305194889;
        Wed, 21 Oct 2020 11:33:14 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id a17sm5430970wra.29.2020.10.21.11.33.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 11:33:14 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] travis: update the kernel and reboot before running the suite
Date:   Wed, 21 Oct 2020 20:33:12 +0200
Message-Id: <20201021183312.380344-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

While the stable release cloud image always ships with a kernel which
has the matching -modules and -devel packages available in the "fedora"
repo, on development releases the nightly images may be behind the
latest repo content and thus may fail to install kernel-modules and
kernel-devel.

Fix it by installing the latest available the kernel and booting it
before running the testsuite. This unfortunately adds around 3-4 minutes
to the Travis build time, but there seems to be no better way to make
the Rawhide test work.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .travis.yml               |  1 +
 travis-ci/run-kvm-test.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 9488807..dcac54d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -17,6 +17,7 @@ addons:
       - bridge-utils
       - libguestfs-tools
       - cpu-checker
+      - netcat
 
 before_install:
   # FYI: known good with HEAD at 8551fc60fc515cd290ba38ee8c758c1f4df52b56
diff --git a/travis-ci/run-kvm-test.sh b/travis-ci/run-kvm-test.sh
index 70fcf08..d22c92b 100755
--- a/travis-ci/run-kvm-test.sh
+++ b/travis-ci/run-kvm-test.sh
@@ -120,5 +120,17 @@ fi
 # our known_hosts. Also, we need to forward the project directory
 # so forks know where to go.
 #
+
+# First update to the latest kernel.
+ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" \
+    dnf install -y kernel
+
+# Then reboot.
+sudo virsh reboot fedoravm
+sleep 5
+
+while ! nc -w 10 -z "$ipaddy" 22; do sleep 0.5s; done
+
+# And run the testsuite.
 project_dir="$(basename "$TRAVIS_BUILD_DIR")"
 ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" "SELINUX_DIR=/root/$project_dir /root/$project_dir/$TEST_RUNNER"
-- 
2.26.2


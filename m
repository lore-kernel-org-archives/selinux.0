Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8879C433DB
	for <selinux@archiver.kernel.org>; Mon, 25 Jan 2021 21:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5B8E22510
	for <selinux@archiver.kernel.org>; Mon, 25 Jan 2021 21:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbhAYVrT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Jan 2021 16:47:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55375 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732654AbhAYVps (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Jan 2021 16:45:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611611062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FtDuJUwy96GbUfCebUHycuFFFfiXXfzWiLjtww3y3uk=;
        b=FoCVRGXfsck4pQsNL6YNEVNhfsXY33hB+ik0Mg3isxbAjc7jHl6dorQjKPvX910h5YQ+Fb
        Lj0Wn+0jLTUPGLnfvqSsyQEpbyzBeBN26/FjXN05LCCtlQFHw5Xw3yXguqLBf6efIXWTYj
        TQDJO/FdrwzJoy60sCQNlrITAQwyhFo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-ciOOjXG2Oda1m-qS31Lglw-1; Mon, 25 Jan 2021 16:44:19 -0500
X-MC-Unique: ciOOjXG2Oda1m-qS31Lglw-1
Received: by mail-ej1-f71.google.com with SMTP id hd8so2805244ejc.22
        for <selinux@vger.kernel.org>; Mon, 25 Jan 2021 13:44:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FtDuJUwy96GbUfCebUHycuFFFfiXXfzWiLjtww3y3uk=;
        b=UyMsW2cFochCti5VUCKkCbCHTSgVuehSBg4jr2DO5X3zglCaYW6i38gW6IGZyPaajH
         eMMh/p9oaCIjAXi7hhAD7myTLC9eyeSkdCpBO6b2Llu9U2EoKR7BQ9/+nm5UKAR8LT48
         wEZrSv05bP6mjEjgZuEgFT0MrtioRB88u21eSM6LkmYFfgmmeoG1jhHFChVZBQsiq96q
         gMEVDZpYllq+sH/NyibJcbyvTqccS3wprPPXpW2SINPCZcK3N7jse+VdWTuWgY/6yerP
         JRbFEJMtSNRWVTi1lCJ776tntbU1behi5DoNhh7yNNlMEq0eZg5KG+MPbRX7sF9dPCTi
         AsVQ==
X-Gm-Message-State: AOAM530i75oNKkceMZnuQrXiGJZztwPmAjo5zc20h02HNyETV9rtn0b2
        p/eigifDx9dh5IB3NmH8gzgykfrvxUyQnQosRqoB326++zLuuanKtq7WOhBOQJiv6CCd9gyyg1z
        ojj4BjzVkH+NLoo33lhWjsyE7YST9FGyXZNYCXWX46EAmbpstmNsTQv+Pf03Sk/vHm6Ue3Q==
X-Received: by 2002:a17:906:9616:: with SMTP id s22mr1609658ejx.270.1611611058138;
        Mon, 25 Jan 2021 13:44:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEWFNT1ftskMuGP2MtrEp9LBD+cd22/53uO0A49dJpTwZMksK/iQsGtjoHw6xyI9RkJzTngQ==
X-Received: by 2002:a17:906:9616:: with SMTP id s22mr1609651ejx.270.1611611057957;
        Mon, 25 Jan 2021 13:44:17 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id z20sm11214834edx.15.2021.01.25.13.44.17
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 13:44:17 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] ci: run testsuite also against the secnext kernel
Date:   Mon, 25 Jan 2021 22:44:16 +0100
Message-Id: <20210125214416.446813-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add another CI job that tests against Paul Moore's kernel-secnext
builds, which contain the latest SELinux patches staged for the next
Linux kernel release.

Since the rawhide image doesn't currently boot under macOS and/or
Virtualbox and/or Vagrant (shrug), use the stable F33 image with rawhide
repo enabled. We will often need at least linux-firmware and glibc from
rawhide anyway, and for verifying new tests for recently developed
features it might be better to have the other userspace dependencies
installed from rawhide, too.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .github/workflows/checks.yml |  8 +++++++-
 Vagrantfile                  | 16 +++++++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/.github/workflows/checks.yml b/.github/workflows/checks.yml
index e1e383f..59f1a47 100644
--- a/.github/workflows/checks.yml
+++ b/.github/workflows/checks.yml
@@ -11,8 +11,14 @@ jobs:
       - run: tools/check-syntax -f && git diff --exit-code
   fedora-test:
     runs-on: macos-latest
+    strategy:
+      matrix:
+        env:
+          - { version: 33, secnext: 0 }
+          - { version: 33, secnext: 1 }
     env:
-      FEDORA_VERSION: 33
+      FEDORA_VERSION: ${{ matrix.env.version }}
+      KERNEL_SECNEXT: ${{ matrix.env.secnext }}
     steps:
       - uses: actions/checkout@v2
       # macOS sometimes allows symlinks to have permissions other than 777,
diff --git a/Vagrantfile b/Vagrantfile
index c305fce..a93c912 100644
--- a/Vagrantfile
+++ b/Vagrantfile
@@ -33,8 +33,18 @@ Vagrant.configure("2") do |config|
     v.memory = 4096
   end
 
+  if ENV['KERNEL_SECNEXT'] == '1'
+    dnf_opts = '--nogpgcheck --releasever rawhide --repofrompath kernel-secnext,https://repo.paul-moore.com/rawhide/x86_64'
+    kernel_pkgs = 'kernel-devel kernel-modules'
+    reboot_cmd = 'reboot'
+  else
+    dnf_opts = ''
+    kernel_pkgs = 'kernel-devel-"$(uname -r)" kernel-modules-"$(uname -r)"'
+    reboot_cmd = ''
+  end
+
   config.vm.provision :shell, inline: <<SCRIPT
-    dnf install -y \
+    dnf install -y #{dnf_opts} \
       --allowerasing \
       --skip-broken \
       make \
@@ -59,7 +69,7 @@ Vagrant.configure("2") do |config|
       e2fsprogs \
       jfsutils \
       dosfstools \
-      kernel-devel-"$(uname -r)" \
-      kernel-modules-"$(uname -r)"
+      #{kernel_pkgs}
+    #{reboot_cmd}
 SCRIPT
 end
-- 
2.29.2


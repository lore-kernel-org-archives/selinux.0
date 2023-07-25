Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC13BC001DE
	for <selinux@archiver.kernel.org>; Tue, 25 Jul 2023 12:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjGYMMX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Jul 2023 08:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGYMMW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Jul 2023 08:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6488EA3
        for <selinux@vger.kernel.org>; Tue, 25 Jul 2023 05:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690287093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pz9abTA0tzxFGmgbJTLGbW5VpiLcREZN7k8Y2lC/nCo=;
        b=FpP2ZotdDucvGzgS9QJHcveFuRoL2sYRhSB3Wg/JA8dzjQHzGcmMd/l+Dih1iALfDjJZ4D
        7s++Qwsr+MvdAVZQGRuGpMMYWZF7CUZqA+i2x4WYnCzCUiXh+6pNMriUMGshinNOCsBZz1
        etA6GTx2kTwqAGxsg6sO0C5/NLRaOTA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-ORTzzH7dODC6zsILZ93bVw-1; Tue, 25 Jul 2023 08:11:32 -0400
X-MC-Unique: ORTzzH7dODC6zsILZ93bVw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fbdf341934so32267855e9.3
        for <selinux@vger.kernel.org>; Tue, 25 Jul 2023 05:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690287090; x=1690891890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pz9abTA0tzxFGmgbJTLGbW5VpiLcREZN7k8Y2lC/nCo=;
        b=BlimGyZCLAJ6CEBOIGfrm3aGn/n3JOGkak7xsSL92oOtiD3BAl92ZiOFduRXDxT9tv
         p2nJcFmrQP+AQce3doz3z3JWDW9qWEZD4tJCyaV/oNZ4pVKjAcvK23UtiI8u/Rjf9J40
         U0aMs8Kf1AM3p9HTq68ReaFOsC6SIQoTPkkW9T4IXm3Q4vTNCNzZdahYFnmpFMh3mI3I
         eQsjiu66exQEwuTJEdlNfT41iwgN3W5lcdmNx7Ig5Rct7kKDfN1Z+MptJXsrrx8E0e9X
         zuW6mXWhWmThD4P4sMb7MMx3am++6pQcf7gUtb6Ymx74LedHIj2Yn1q0444wf2fgjQMh
         PV9A==
X-Gm-Message-State: ABy/qLaiEtBCeJRVe8uB8ye/8b9g0YBozfW0SnTA80gaagpHIdEiFyTd
        UuHjY1X7PLLrShupx5Mefh2F9pU9eN9OgC7pukTBiCQSTRaTQejFaUONYjkdUiuM+WPqryKsGgR
        K09WQAdVOcaJzdMk4040lmPAfAlrI+hbo/jO3JlsjkwJWIpPcUYjQNARC3ffKIhVas54pV6QPBL
        e+MNiD
X-Received: by 2002:a05:600c:204:b0:3f9:b748:ff37 with SMTP id 4-20020a05600c020400b003f9b748ff37mr10800358wmi.20.1690287090582;
        Tue, 25 Jul 2023 05:11:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFoeTbbk4v5k6nGQE43txxdzyu5JrsAppd6eQUkQpuaR0PVMXQL5uFgnKsO2y/oWG998CYorg==
X-Received: by 2002:a05:600c:204:b0:3f9:b748:ff37 with SMTP id 4-20020a05600c020400b003f9b748ff37mr10800341wmi.20.1690287090095;
        Tue, 25 Jul 2023 05:11:30 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n19-20020a7bc5d3000000b003fc02e8ea68sm16036138wmk.13.2023.07.25.05.11.29
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:11:29 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] ci: test also on CentOS Stream 9
Date:   Tue, 25 Jul 2023 14:11:28 +0200
Message-ID: <20230725121128.1243722-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Now that there is an up-to-date CS9 box available in Vagrant [1], we can
test on it in the CI to ensure that the testsuite is compatible with
this distribution.

Note that there may be a few test cases skipped that could in fact be
run on the latest CS9 thanks to backports, but that can be addressed
later.

[1] https://issues.redhat.com/browse/CS-1186

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .github/workflows/checks.yml | 13 +++++++------
 Vagrantfile                  | 23 +++++++++++++++--------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/.github/workflows/checks.yml b/.github/workflows/checks.yml
index 9d9ebd9..e43b793 100644
--- a/.github/workflows/checks.yml
+++ b/.github/workflows/checks.yml
@@ -10,18 +10,19 @@ jobs:
       - uses: actions/checkout@v2
       - run: sudo chown $(id -u):$(id -g) .
       - run: tools/check-syntax -f && git diff --exit-code
-  fedora-test:
+  vm-test:
     runs-on: macos-12
     strategy:
       fail-fast: false
       matrix:
         domain: [unconfined_t, sysadm_t]
         env:
-          - { version: 37, kernel: default }
-          - { version: 38, kernel: default }
-          - { version: 38, kernel: secnext }
+          - { image: fedora/37-cloud-base, kernel: default }
+          - { image: fedora/38-cloud-base, kernel: default }
+          - { image: fedora/38-cloud-base, kernel: secnext }
+          - { image: centos/stream9, kernel: latest }
     env:
-      FEDORA_VERSION: ${{ matrix.env.version }}
+      IMAGE_NAME: ${{ matrix.env.image }}
       KERNEL_TYPE: ${{ matrix.env.kernel }}
       ROOT_DOMAIN: ${{ matrix.domain }}
     steps:
@@ -47,6 +48,6 @@ jobs:
       - name: Run SELinux testsuite
         run: vagrant ssh -- sudo make -C /root/testsuite test
       - name: Check unwanted denials
-        run: vagrant ssh -- '! sudo ausearch -m avc -i </dev/null | grep ${{ matrix.domain }}'
+        run: vagrant ssh -- '! sudo ausearch -m avc -i </dev/null | grep "^type=AVC .*${{ matrix.domain }}"'
       - name: Check .gitignore coverage
         run: test "$(vagrant ssh -- sudo git -C /root/testsuite ls-files -o --exclude-standard | wc -l)" -eq 0
diff --git a/Vagrantfile b/Vagrantfile
index 682b805..c0cc377 100644
--- a/Vagrantfile
+++ b/Vagrantfile
@@ -5,7 +5,7 @@
 #
 # To create a new virtual machine:
 #
-#    FEDORA_VERSION=33 vagrant up
+#    IMAGE_NAME=fedora/34-cloud-base KERNEL_TYPE=default vagrant up
 #
 # To launch tests (for example after modifications have been made):
 #
@@ -20,7 +20,7 @@
 # backwards compatibility). Please don't change it unless you know what
 # you're doing.
 Vagrant.configure("2") do |config|
-  config.vm.box = "fedora/#{ENV['FEDORA_VERSION']}-cloud-base"
+  config.vm.box = "#{ENV['IMAGE_NAME']}"
   config.vm.synced_folder ".", "/vagrant", disabled: true
   config.vm.synced_folder ".", "/root/testsuite", type: "rsync",
     # need to disable '--copy-links', which is in rsync__args by default
@@ -33,16 +33,23 @@ Vagrant.configure("2") do |config|
     v.memory = 4096
   end
 
+  kernel_subpkgs = ['devel', 'modules']
+
+  dnf_opts = ''
+  case ENV['IMAGE_NAME']
+  when /^centos\//
+    dnf_opts << ' --enablerepo crb'
+    kernel_subpkgs << 'modules-extra'
+  end
+
   case ENV['KERNEL_TYPE']
   when 'default'
-    dnf_opts = ''
-    kernel_pkgs = 'kernel-devel-"$(uname -r)" kernel-modules-"$(uname -r)"'
+    kernel_pkgs = kernel_subpkgs.map{|s| "kernel-#{s}-\"$(uname -r)\""}.join(' ')
   when 'latest'
-    dnf_opts = ''
-    kernel_pkgs = 'kernel-devel kernel-modules'
+    kernel_pkgs = kernel_subpkgs.map{|s| "kernel-#{s}"}.join(' ')
   when 'secnext'
-    dnf_opts = '--nogpgcheck --releasever rawhide --repofrompath kernel-secnext,https://repo.paul-moore.com/rawhide/x86_64'
-    kernel_pkgs = 'kernel-devel kernel-modules'
+    dnf_opts << ' --nogpgcheck --releasever rawhide --repofrompath kernel-secnext,https://repo.paul-moore.com/rawhide/x86_64'
+    kernel_pkgs = kernel_subpkgs.map{|s| "kernel-#{s}"}.join(' ')
   else
     print("Invalid KERNEL_TYPE '#{ENV['KERNEL_TYPE']}'")
     abort
-- 
2.41.0


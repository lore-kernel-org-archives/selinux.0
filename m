Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7123C19F2B
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbiG2MDQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbiG2MDO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:03:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5B4C863E0
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DATQCWIR03hU/ccPvSYPy3tgByaOjFMT4pg9Mm9t3a0=;
        b=HkrsECdg7XDJFVgXyruOKdOZTze48fbzbahpU7uyKdVvxvLFKyWFRGoHz0vyln59h41dcm
        uPsshuWKjrAKcGD/G9jkRy+vsnMj/jX4LD0luNGZSpdC/U862tYSG4QGEMa/9O4e3ausQf
        hhKyROG3JyoU3gsAihEnN5qBjyLNlvQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-Ao09-mDrMaG29C04PKAd5Q-1; Fri, 29 Jul 2022 08:03:10 -0400
X-MC-Unique: Ao09-mDrMaG29C04PKAd5Q-1
Received: by mail-wm1-f69.google.com with SMTP id c17-20020a7bc011000000b003a2bfaf8d3dso2131690wmb.0
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=DATQCWIR03hU/ccPvSYPy3tgByaOjFMT4pg9Mm9t3a0=;
        b=0a7PvZ+kFQGISQHi3WbLeqASGVK8Vm8ve0Md++LMW5TnjrNM5Sne+csqSVUYR5RpZO
         PuuMqP4jnZnOFYs7PT3m9EmIRZUxXzPq7oSRhdeRRMyWLqlEKtaxHxAsyy33jOt2R+Sr
         fK9jExB1wGRW2Pqc0F/e1212RvmV6a3Yauj5EvhZiHHDJZnjw0P5TpSLyxud0rnA25J9
         ZI/zmsoCquaxY/X9mY42bHXhD3EiA0u+LPGCAzWZcl33subzF0Shz9nlQPaSz0zmBGxD
         WRijrXu1T1rtH4WmMolg9fgJYSpa1wxAoQV08uxancBYD03a9onfqEF6oAxvfWbYpdQA
         yqTQ==
X-Gm-Message-State: ACgBeo2N0W6ezu0MHadM2vKclKkPf6PNmRwHYOIL/RQOoGoBtx2Xo8hg
        7xIlIiLFTG6yNNm/QruodJ1/zOK6je/PFrUOhiNo9gnYgkJNkUhfZjv/wV/aMOflctjPYChzVQP
        6yolPMPK0X24BGCRnyDDmsdaeC/Obt4PT/uUIAjM4KPBzfA7+Iqp9YN8YmicPeuTi+5HZFw==
X-Received: by 2002:a05:6000:1789:b0:21e:87cd:beba with SMTP id e9-20020a056000178900b0021e87cdbebamr2309754wrg.252.1659096188756;
        Fri, 29 Jul 2022 05:03:08 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6qs9ELY4tw1dw/oOZqfgtljlmCa5fhFtzPsZLPu4Bf5BzcrheUa5czdw5x4BZglbAobrZCZQ==
X-Received: by 2002:a05:6000:1789:b0:21e:87cd:beba with SMTP id e9-20020a056000178900b0021e87cdbebamr2309736wrg.252.1659096188494;
        Fri, 29 Jul 2022 05:03:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.03.07
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:03:07 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 24/24] ci: add sysadm_t to the test matrix
Date:   Fri, 29 Jul 2022 14:02:29 +0200
Message-Id: <20220729120229.207584-25-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
References: <20220729120229.207584-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The testsuite should now be passing under the sysadm user as well, so
test it.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .github/workflows/checks.yml |  4 +++-
 Vagrantfile                  | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/checks.yml b/.github/workflows/checks.yml
index 96843e4..37455ea 100644
--- a/.github/workflows/checks.yml
+++ b/.github/workflows/checks.yml
@@ -15,6 +15,7 @@ jobs:
     strategy:
       fail-fast: false
       matrix:
+        domain: [unconfined_t, sysadm_t]
         env:
           - { version: 35, kernel: default }
           - { version: 36, kernel: default }
@@ -22,6 +23,7 @@ jobs:
     env:
       FEDORA_VERSION: ${{ matrix.env.version }}
       KERNEL_TYPE: ${{ matrix.env.kernel }}
+      ROOT_DOMAIN: ${{ matrix.domain }}
     steps:
       - uses: actions/checkout@v2
       # macOS sometimes allows symlinks to have permissions other than 777,
@@ -39,6 +41,6 @@ jobs:
       - name: Run SELinux testsuite
         run: vagrant ssh -- sudo make -C /root/testsuite test
       - name: Check unwanted denials
-        run: vagrant ssh -- '! sudo ausearch -m avc -i </dev/null | grep unconfined_t'
+        run: vagrant ssh -- '! sudo ausearch -m avc -i </dev/null | grep ${{ matrix.domain }}'
       - name: Check .gitignore coverage
         run: test "$(vagrant ssh -- sudo git -C /root/testsuite ls-files -o --exclude-standard | wc -l)" -eq 0
diff --git a/Vagrantfile b/Vagrantfile
index 783df5d..ec3a492 100644
--- a/Vagrantfile
+++ b/Vagrantfile
@@ -51,6 +51,21 @@ Vagrant.configure("2") do |config|
     abort
   end
 
+  extra_commands = ''
+  case ENV['ROOT_DOMAIN']
+  when 'unconfined_t'
+  when 'sysadm_t'
+    extra_commands = <<EOF
+      semanage boolean --modify --on ssh_sysadm_login
+      semanage login --modify -s sysadm_u root
+      semanage login --add -s sysadm_u -r s0-s0:c0.c1023 vagrant
+EOF
+    reboot_cmd = 'reboot'
+  else
+    print("Invalid ROOT_DOMAIN '#{ENV['ROOT_DOMAIN']}'")
+    abort
+  end
+
   config.vm.provision :shell, inline: <<SCRIPT
     dnf install -y #{dnf_opts} \
       --allowerasing \
@@ -79,6 +94,7 @@ Vagrant.configure("2") do |config|
       jfsutils \
       dosfstools \
       #{kernel_pkgs}
+    #{extra_commands}
     #{reboot_cmd}
 SCRIPT
 end
-- 
2.37.1


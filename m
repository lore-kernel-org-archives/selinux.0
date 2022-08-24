Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EA1C32793
	for <selinux@archiver.kernel.org>; Wed, 24 Aug 2022 11:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbiHXLTu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Aug 2022 07:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236617AbiHXLTs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Aug 2022 07:19:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDD6D61
        for <selinux@vger.kernel.org>; Wed, 24 Aug 2022 04:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661339984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+757l4z4Jq4h65Znfcbh4iHBmAWsm/SyER73HT5HMmE=;
        b=SyZLKJ4K/EUKP7IzvpbIPtEOvDB3cJoBA2nOXdyCuCw0Lv20//Ow7Bw5/p3jJDKIyPfFzu
        YTO1qPN335CymvWrAbzSczsnv0DoSGTqYMrnbPM3rg+F+z5RLkzvgJEKlZYNCN1Ys8ypPL
        DANAQDvo5W3liB0eAzmmN/KrZov5sts=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-64-6CmpaW1NNcO7RuWeCuEnWg-1; Wed, 24 Aug 2022 07:19:43 -0400
X-MC-Unique: 6CmpaW1NNcO7RuWeCuEnWg-1
Received: by mail-ed1-f71.google.com with SMTP id m18-20020a056402511200b00446d4abe6c8so5067708edd.12
        for <selinux@vger.kernel.org>; Wed, 24 Aug 2022 04:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=+757l4z4Jq4h65Znfcbh4iHBmAWsm/SyER73HT5HMmE=;
        b=G8YtVYI/CfTgSqGgBsGjMu46nhfnjNRQt4dAZh3M3BJTYO2dU8OYuilbjDtbpTNAWS
         2XWrDQzXkLMyFC8S0raFOrbOuQ0bmOak59SPubehJwNaLZq8zM/ryBInOLL+9g4sQAbR
         CPkv1rLZmjgSyG0yQkkxIbvezUeenReKnDfpLihMS44UswsNG45chBDncDli2S/0sx/p
         OI9QJ58/6Co0ouuFeF5UmwQhvpROQ9YIDJMFCiGnQk0hkOELJ4EVkb9/XNcRDrW3JLMM
         I0mLfwmr2BPwEqUIN0D9F2KQmo0yMhKHDZPWIKnBH32Op4BLlkaeDd5ToAoLud/Go5LR
         yX2w==
X-Gm-Message-State: ACgBeo1uhst0fNN/CrCbwrp8aqKWi5zHWHR2tIjNiYh6PJ7mtjFAKVdR
        zUhLypHOOI65FaVol1wiw3eibQ1wjYyj+5Pq/gLn3UMhJLEapjkg2+6Q3nZgcK+dL1XTWVsY7A0
        i94BAKp+lkAsOcumADOTXIxZKJRl1VKgUz6QiOVW/OqVkUsZVi5aNjYKWa/4jUKxDB/vO+w==
X-Received: by 2002:a05:6402:2383:b0:446:8dc9:b027 with SMTP id j3-20020a056402238300b004468dc9b027mr7273649eda.122.1661339981826;
        Wed, 24 Aug 2022 04:19:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR46nBGSEhgRnzsSCbUmp6+mGLCioT/Os5qJj6NE7QB5xAyDPtlCslrb4qSgsxX9ZMTSex0/ZA==
X-Received: by 2002:a05:6402:2383:b0:446:8dc9:b027 with SMTP id j3-20020a056402238300b004468dc9b027mr7273631eda.122.1661339981466;
        Wed, 24 Aug 2022 04:19:41 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090665c600b0073d6d1990e2sm1016047ejn.140.2022.08.24.04.19.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 04:19:40 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 1/2] policy: remove CIL workarounds for missing anon_inode class
Date:   Wed, 24 Aug 2022 13:19:37 +0200
Message-Id: <20220824111938.567993-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220824111938.567993-1-omosnace@redhat.com>
References: <20220824111938.567993-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The class has been declared in Fedora policy and refpolicy for quite
some time, so simplify away the workarounds.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/Makefile                  | 15 ++++---
 policy/test_anon_inode_class.cil |  4 --
 policy/test_userfaultfd.cil      | 47 ---------------------
 policy/test_userfaultfd.te       | 72 +++++++++++++++++++++++++-------
 4 files changed, 63 insertions(+), 75 deletions(-)
 delete mode 100644 policy/test_anon_inode_class.cil
 delete mode 100644 policy/test_userfaultfd.cil

diff --git a/policy/Makefile b/policy/Makefile
index 66734c6..b6f2f32 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -37,14 +37,6 @@ endif
 
 ifeq ($(SUPPORTS_CIL),y)
 CIL_TARGETS = test_mlsconstrain.cil test_overlay_defaultrange.cil
-# userfaultfd test policy uses also xperms
-ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] && echo true),true)
-ifneq ($(shell grep -q anon_inode $(POLDEV)/include/support/all_perms.spt && echo true),true)
-CIL_TARGETS += test_anon_inode_class.cil
-endif
-CIL_TARGETS += test_userfaultfd.cil
-TARGETS += test_userfaultfd.te
-endif
 ifeq ($(shell [ $(MAX_KERNEL_POLICY) -ge 32 ] && echo true),true)
 ifeq ($(shell [ $(POL_VERS) -ge 32 ] && echo true),true)
 # If other MLS tests get written this can be moved outside of the glblub test
@@ -159,6 +151,13 @@ endif
 endif
 endif
 
+# userfaultfd test policy uses also xperms
+ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] && echo true),true)
+ifeq ($(shell grep -q anon_inode $(POLDEV)/include/support/all_perms.spt && echo true),true)
+TARGETS += test_userfaultfd.te
+endif
+endif
+
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
 TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te, $(TARGETS))
 endif
diff --git a/policy/test_anon_inode_class.cil b/policy/test_anon_inode_class.cil
deleted file mode 100644
index 3e36599..0000000
--- a/policy/test_anon_inode_class.cil
+++ /dev/null
@@ -1,4 +0,0 @@
-; Define new class anon_inode
-(class anon_inode ())
-(classcommon anon_inode file)
-(classorder (unordered anon_inode))
diff --git a/policy/test_userfaultfd.cil b/policy/test_userfaultfd.cil
deleted file mode 100644
index f6a6791..0000000
--- a/policy/test_userfaultfd.cil
+++ /dev/null
@@ -1,47 +0,0 @@
-; Allow all anonymous inodes
-(typeattributeset cil_gen_require test_notransition_uffd_t)
-(allow test_notransition_uffd_t self (anon_inode (create getattr ioctl read)))
-
-(typeattributeset cil_gen_require uffd_t)
-
-; Allow all operations on UFFD
-(typeattributeset cil_gen_require test_uffd_t)
-(typetransition test_uffd_t test_uffd_t anon_inode "[userfaultfd]" uffd_t)
-(allow test_uffd_t uffd_t (anon_inode (create getattr ioctl read)))
-
-; Don't allow any operation on UFFD
-(typeattributeset cil_gen_require test_nocreate_uffd_t)
-(typetransition test_nocreate_uffd_t test_nocreate_uffd_t anon_inode "[userfaultfd]" uffd_t)
-
-; Don't allow getattr operation on UFFD
-(typeattributeset cil_gen_require test_nogetattr_uffd_t)
-(typetransition test_nogetattr_uffd_t test_nogetattr_uffd_t anon_inode "[userfaultfd]" uffd_t)
-(allow test_nogetattr_uffd_t uffd_t (anon_inode (create)))
-
-; Don't allow any ioctl operation on UFFD
-(typeattributeset cil_gen_require test_noioctl_uffd_t)
-(typetransition test_noioctl_uffd_t test_noioctl_uffd_t anon_inode "[userfaultfd]" uffd_t)
-(allow test_noioctl_uffd_t uffd_t (anon_inode (create getattr)))
-
-; Only allow UFFDIO_API ioctl
-(typeattributeset cil_gen_require test_api_ioctl_uffd_t)
-(typetransition test_api_ioctl_uffd_t test_api_ioctl_uffd_t anon_inode "[userfaultfd]" uffd_t)
-(allow test_api_ioctl_uffd_t uffd_t (anon_inode (create getattr ioctl read)))
-(allowx test_api_ioctl_uffd_t uffd_t (ioctl anon_inode ((0xaa3f))))
-
-; Only allow UFFDIO_API and UFFDIO_REGISTER ioctls
-(typeattributeset cil_gen_require test_register_ioctl_uffd_t)
-(typetransition test_register_ioctl_uffd_t test_register_ioctl_uffd_t anon_inode "[userfaultfd]" uffd_t)
-(allow test_register_ioctl_uffd_t uffd_t (anon_inode (create getattr ioctl read)))
-(allowx test_register_ioctl_uffd_t uffd_t (ioctl anon_inode ((0xaa3f 0xaa00))))
-
-; Only allow UFFDIO_API, UFFDIO_REGISTER and UFFDIO_COPY ioctls, which are most used.
-(typeattributeset cil_gen_require test_copy_ioctl_uffd_t)
-(typetransition test_copy_ioctl_uffd_t test_copy_ioctl_uffd_t anon_inode "[userfaultfd]" uffd_t)
-(allow test_copy_ioctl_uffd_t uffd_t (anon_inode (create getattr ioctl read)))
-(allowx test_copy_ioctl_uffd_t uffd_t (ioctl anon_inode ((0xaa3f 0xaa00 0xaa03))))
-
-; Don't allow read operation on UFFD.
-(typeattributeset cil_gen_require test_noread_uffd_t)
-(typetransition test_noread_uffd_t test_noread_uffd_t anon_inode "[userfaultfd]" uffd_t)
-(allow test_noread_uffd_t uffd_t (anon_inode (create getattr ioctl)))
diff --git a/policy/test_userfaultfd.te b/policy/test_userfaultfd.te
index f5a6613..fe7f9c6 100644
--- a/policy/test_userfaultfd.te
+++ b/policy/test_userfaultfd.te
@@ -7,41 +7,81 @@ attribute test_uffd_domain;
 
 type uffd_t;
 
-define(`userfaultfd_domain_type',`
-	type $1;
-	testsuite_domain_type($1)
-	typeattribute $1 test_uffd_domain;
-')
-
 # Domain for confirming that without transition rule the userfaultfd
 # gets process' context
-userfaultfd_domain_type(test_notransition_uffd_t)
+type test_notransition_uffd_t;
+testsuite_domain_type(test_notransition_uffd_t)
+typeattribute test_notransition_uffd_t test_uffd_domain;
+
+allow test_notransition_uffd_t self:anon_inode { create getattr ioctl read };
 
 # Domain for process that has all the permissions to use userfaultfd
-userfaultfd_domain_type(test_uffd_t)
+type test_uffd_t;
+testsuite_domain_type(test_uffd_t)
+typeattribute test_uffd_t test_uffd_domain;
+
+type_transition test_uffd_t test_uffd_t:anon_inode uffd_t "[userfaultfd]";
+allow test_uffd_t uffd_t:anon_inode { create getattr ioctl read };
 
 # Domain for process that cannot create userfaultfd
-userfaultfd_domain_type(test_nocreate_uffd_t)
+type test_nocreate_uffd_t;
+testsuite_domain_type(test_nocreate_uffd_t)
+typeattribute test_nocreate_uffd_t test_uffd_domain;
+
+type_transition test_nocreate_uffd_t test_nocreate_uffd_t:anon_inode uffd_t "[userfaultfd]";
 
 # Domain for process that cannot get attributed of userfaultfd
-userfaultfd_domain_type(test_nogetattr_uffd_t)
+type test_nogetattr_uffd_t;
+testsuite_domain_type(test_nogetattr_uffd_t)
+typeattribute test_nogetattr_uffd_t test_uffd_domain;
+
+type_transition test_nogetattr_uffd_t test_nogetattr_uffd_t:anon_inode uffd_t "[userfaultfd]";
+allow test_nogetattr_uffd_t uffd_t:anon_inode { create };
 
 # Domain for process which can only use UFFDIO_API ioctl on userfaultfd
-userfaultfd_domain_type(test_api_ioctl_uffd_t)
+type test_api_ioctl_uffd_t;
+testsuite_domain_type(test_api_ioctl_uffd_t)
+typeattribute test_api_ioctl_uffd_t test_uffd_domain;
+
+type_transition test_api_ioctl_uffd_t test_api_ioctl_uffd_t:anon_inode uffd_t "[userfaultfd]";
+allow test_api_ioctl_uffd_t uffd_t:anon_inode { create getattr ioctl read };
+allowxperm test_api_ioctl_uffd_t uffd_t:anon_inode ioctl { 0xaa3f };
 
 # Domain for process which can use UFFDIO_API and UFFDIO_REGISTER ioctls
 # on userfaultfd
-userfaultfd_domain_type(test_register_ioctl_uffd_t)
+type test_register_ioctl_uffd_t;
+testsuite_domain_type(test_register_ioctl_uffd_t)
+typeattribute test_register_ioctl_uffd_t test_uffd_domain;
+
+type_transition test_register_ioctl_uffd_t test_register_ioctl_uffd_t:anon_inode uffd_t "[userfaultfd]";
+allow test_register_ioctl_uffd_t uffd_t:anon_inode { create getattr ioctl read };
+allowxperm test_register_ioctl_uffd_t uffd_t:anon_inode ioctl { 0xaa3f 0xaa00 };
 
 # Domain for process which can use UFFDIO_API, UFFDIO_REGISTER and
 # UFFDIO_COPY ioctls on userfaultfd
-userfaultfd_domain_type(test_copy_ioctl_uffd_t)
+type test_copy_ioctl_uffd_t;
+testsuite_domain_type(test_copy_ioctl_uffd_t)
+typeattribute test_copy_ioctl_uffd_t test_uffd_domain;
+
+type_transition test_copy_ioctl_uffd_t test_copy_ioctl_uffd_t:anon_inode uffd_t "[userfaultfd]";
+allow test_copy_ioctl_uffd_t uffd_t:anon_inode { create getattr ioctl read };
+allowxperm test_copy_ioctl_uffd_t uffd_t:anon_inode ioctl { 0xaa3f 0xaa00 0xaa03 };
 
-# Domain for proces that cannot perform any ioctl operations on userfaultfd
-userfaultfd_domain_type(test_noioctl_uffd_t)
+# Domain for process that cannot perform any ioctl operations on userfaultfd
+type test_noioctl_uffd_t;
+testsuite_domain_type(test_noioctl_uffd_t)
+typeattribute test_noioctl_uffd_t test_uffd_domain;
+
+type_transition test_noioctl_uffd_t test_noioctl_uffd_t:anon_inode uffd_t "[userfaultfd]";
+allow test_noioctl_uffd_t uffd_t:anon_inode { create getattr };
 
 # Domain for process that cannot read from userfaultfd
-userfaultfd_domain_type(test_noread_uffd_t)
+type test_noread_uffd_t;
+testsuite_domain_type(test_noread_uffd_t)
+typeattribute test_noread_uffd_t test_uffd_domain;
+
+type_transition test_noread_uffd_t test_noread_uffd_t:anon_inode uffd_t "[userfaultfd]";
+allow test_noread_uffd_t uffd_t:anon_inode { create getattr ioctl };
 
 # userfaultfd(2) requires CAP_SYS_PTRACE
 allow test_uffd_domain self:capability { sys_ptrace };
-- 
2.37.2


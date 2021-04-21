Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD4AC43461
	for <selinux@archiver.kernel.org>; Wed, 21 Apr 2021 17:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 673A461456
	for <selinux@archiver.kernel.org>; Wed, 21 Apr 2021 17:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244584AbhDURQQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Apr 2021 13:16:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57499 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244676AbhDURQI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Apr 2021 13:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619025335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QrblNtNkcVLchPlCl1+Eivmg6Vmoc7cSJYaPkvwrCAI=;
        b=HXY7pTC4Sd9uRD9sqtqA9TeKemy0G1x9Ymw2UDGUkC+3fnmgifAyKfd+QAVftNU33wxQs/
        RkfLvSGIDb2V3pl4N9uaEaXFDbJYfUVvuIbPp4S5MkltFqz33G0If6+gtB6onAcZRIUbrU
        ZsTEeIL5yhwo+dzGgHWRE8dRJRHMJTw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-2fX_nLyJP22DeGlhRRgfrw-1; Wed, 21 Apr 2021 13:15:33 -0400
X-MC-Unique: 2fX_nLyJP22DeGlhRRgfrw-1
Received: by mail-ed1-f71.google.com with SMTP id c13-20020a05640227cdb0290385526e5de5so5340960ede.21
        for <selinux@vger.kernel.org>; Wed, 21 Apr 2021 10:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QrblNtNkcVLchPlCl1+Eivmg6Vmoc7cSJYaPkvwrCAI=;
        b=YfHZ23rWRMNt5lxWgGb8cDKuZk4KBlG46RihpQCCDTeBXAm5XaQ15BQYLqKvPaa8ru
         vAWmX+gtMinFqxsGUWXkO+JTLmkthu42HH5WNGZBORyDz+imv8UdzUz7Bome6aKVEafA
         77uc/PWzHj1XzxZVWK2dWS5gaEFq1hghvoFzePzE1XbDpBovtbtyM1/jPfJFQr4CNGuX
         DBnP2m4VRXnozNnme0LoSOAkG9DCa5VXu7E1pjTIYiiIa/Uqkxb2kUWmHfKNdICUGVPN
         7NeMs8Q+pfmp2XsNeIGHWTpTt0mUTV/0oifR+jzs5tDDkVsf+byK6Qf2Y33RusuE/m+T
         UQdQ==
X-Gm-Message-State: AOAM532EfDaXmjsJ6mxCjgyASV333jEe0YPOQGJiq3p9BRCPwqFk2IQu
        fgdBls/YlJTw2oq+8lEMN0VGeMcAwYiallUCHvtk3JbYhojAhGUADNZXfjMc5OJRdwIAtToAa3H
        A0M1Dm1DoxCKHfpeMV/PkziKxEMI3dZdbDMlIETOHZpVtOa6ArYZQPb7CcaSxvTaFspgDow==
X-Received: by 2002:a17:906:1a09:: with SMTP id i9mr34167821ejf.213.1619025331497;
        Wed, 21 Apr 2021 10:15:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9I0rUGkxfZ14sT6Ua5F/bySpMBfYRpI7+tob2Uxoeig1O4X4aABX2cPGdZEpWLWfT42mJhw==
X-Received: by 2002:a17:906:1a09:: with SMTP id i9mr34167797ejf.213.1619025331286;
        Wed, 21 Apr 2021 10:15:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id v16sm17477edt.53.2021.04.21.10.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 10:15:30 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Lokesh Gidra <lokeshgidra@google.com>
Subject: [RFC PATCH testsuite] Add extended_anon_inode_class policy capability support
Date:   Wed, 21 Apr 2021 19:15:28 +0200
Message-Id: <20210421171528.785703-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The extended_anon_inode_class policy capability allows to distinguish
different types of anon inodes by class. Add necessary mechanisms to the
userfaultfd test policy so that the test works correctly also when this
capability is enabled by the system policy.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/Makefile                     |   8 +-
 policy/test_anon_inode_extended.cil |   1 +
 policy/test_anon_inode_legacy.cil   |   1 +
 policy/test_userfaultfd.cil         | 127 ++++++++++++++++------------
 4 files changed, 84 insertions(+), 53 deletions(-)
 create mode 100644 policy/test_anon_inode_extended.cil
 create mode 100644 policy/test_anon_inode_legacy.cil

diff --git a/policy/Makefile b/policy/Makefile
index 91364d5..33951a5 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -41,7 +41,13 @@ CIL_TARGETS = test_mlsconstrain.cil test_overlay_defaultrange.cil
 ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] && echo true),true)
 CIL_TARGETS += test_userfaultfd.cil
 TARGETS += test_userfaultfd.te
-endif
+ifeq ($(shell cat $(SELINUXFS)/policy_capabilities/extended_anon_inode_class \
+	2>/dev/null || echo 0),1)
+CIL_TARGETS += test_anon_inode_extended.cil
+else
+CIL_TARGETS += test_anon_inode_legacy.cil
+endif # policy_capabilities/extended_anon_inode_class
+endif # extended permissions
 ifeq ($(shell [ $(MAX_KERNEL_POLICY) -ge 32 ] && echo true),true)
 ifeq ($(shell [ $(POL_VERS) -ge 32 ] && echo true),true)
 # If other MLS tests get written this can be moved outside of the glblub test
diff --git a/policy/test_anon_inode_extended.cil b/policy/test_anon_inode_extended.cil
new file mode 100644
index 0000000..af5b0d2
--- /dev/null
+++ b/policy/test_anon_inode_extended.cil
@@ -0,0 +1 @@
+(tunable extended_anon_inode true)
diff --git a/policy/test_anon_inode_legacy.cil b/policy/test_anon_inode_legacy.cil
new file mode 100644
index 0000000..4c81e91
--- /dev/null
+++ b/policy/test_anon_inode_legacy.cil
@@ -0,0 +1 @@
+(tunable extended_anon_inode false)
diff --git a/policy/test_userfaultfd.cil b/policy/test_userfaultfd.cil
index 18d5f3f..01fe2fa 100644
--- a/policy/test_userfaultfd.cil
+++ b/policy/test_userfaultfd.cil
@@ -1,52 +1,75 @@
-; Define new class anon_inode
-(class anon_inode ())
-(classcommon anon_inode file)
-(classorder (unordered anon_inode))
-
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
+(macro build_uffd_policy ((class uffd_class))
+	; Allow all anonymous inodes
+	(typeattributeset cil_gen_require test_notransition_uffd_t)
+	(allow test_notransition_uffd_t self (uffd_class (create getattr ioctl read)))
+
+	(typeattributeset cil_gen_require uffd_t)
+
+	; Allow all operations on UFFD
+	(typeattributeset cil_gen_require test_uffd_t)
+	(call uffd_transition (test_uffd_t uffd_t))
+	(allow test_uffd_t uffd_t (uffd_class (create getattr ioctl read)))
+
+	; Don't allow any operation on UFFD
+	(typeattributeset cil_gen_require test_nocreate_uffd_t)
+	(call uffd_transition (test_nocreate_uffd_t uffd_t))
+
+	; Don't allow getattr operation on UFFD
+	(typeattributeset cil_gen_require test_nogetattr_uffd_t)
+	(call uffd_transition (test_nogetattr_uffd_t uffd_t))
+	(allow test_nogetattr_uffd_t uffd_t (uffd_class (create)))
+
+	; Don't allow any ioctl operation on UFFD
+	(typeattributeset cil_gen_require test_noioctl_uffd_t)
+	(call uffd_transition (test_noioctl_uffd_t uffd_t))
+	(allow test_noioctl_uffd_t uffd_t (uffd_class (create getattr)))
+
+	; Only allow UFFDIO_API ioctl
+	(typeattributeset cil_gen_require test_api_ioctl_uffd_t)
+	(call uffd_transition (test_api_ioctl_uffd_t uffd_t))
+	(allow test_api_ioctl_uffd_t uffd_t (uffd_class (create getattr ioctl read)))
+	(allowx test_api_ioctl_uffd_t uffd_t (ioctl uffd_class ((0xaa3f))))
+
+	; Only allow UFFDIO_API and UFFDIO_REGISTER ioctls
+	(typeattributeset cil_gen_require test_register_ioctl_uffd_t)
+	(call uffd_transition (test_register_ioctl_uffd_t uffd_t))
+	(allow test_register_ioctl_uffd_t uffd_t (uffd_class (create getattr ioctl read)))
+	(allowx test_register_ioctl_uffd_t uffd_t (ioctl uffd_class ((0xaa3f 0xaa00))))
+
+	; Only allow UFFDIO_API, UFFDIO_REGISTER and UFFDIO_COPY ioctls, which are most used.
+	(typeattributeset cil_gen_require test_copy_ioctl_uffd_t)
+	(call uffd_transition (test_copy_ioctl_uffd_t uffd_t))
+	(allow test_copy_ioctl_uffd_t uffd_t (uffd_class (create getattr ioctl read)))
+	(allowx test_copy_ioctl_uffd_t uffd_t (ioctl uffd_class ((0xaa3f 0xaa00 0xaa03))))
+
+	; Don't allow read operation on UFFD.
+	(typeattributeset cil_gen_require test_noread_uffd_t)
+	(call uffd_transition (test_noread_uffd_t uffd_t))
+	(allow test_noread_uffd_t uffd_t (uffd_class (create getattr ioctl)))
+)
+
+(tunableif extended_anon_inode
+	(true
+		; Extended anon_inode support - use the userfaultfd class
+		(class userfaultfd ())
+		(classcommon userfaultfd file)
+		(classorder (unordered userfaultfd))
+
+		(macro uffd_transition ((type S) (type T))
+			(typetransition S S userfaultfd T)
+		)
+		(call build_uffd_policy (userfaultfd))
+	)
+	(false
+		; Legacy anon_inode support - use the anon_inode class
+		; + named transition
+		(class anon_inode ())
+		(classcommon anon_inode file)
+		(classorder (unordered anon_inode))
+
+		(macro uffd_transition ((type S) (type T))
+			(typetransition S S anon_inode "[userfaultfd]" T)
+		)
+		(call build_uffd_policy (anon_inode))
+	)
+)
-- 
2.30.2


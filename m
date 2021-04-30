Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765B7C433ED
	for <selinux@archiver.kernel.org>; Fri, 30 Apr 2021 09:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4943D61456
	for <selinux@archiver.kernel.org>; Fri, 30 Apr 2021 09:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhD3JMN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Apr 2021 05:12:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22188 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229522AbhD3JMN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Apr 2021 05:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619773885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JG4a+wpzvObAuEp4SKh4VILGIf18YoL3xVa1kMGn9ag=;
        b=WQnkndUu3dcFJdGsPpAVH/ekjpF9EAl3M5aBLbjNFumPZ5Wh8b0plAsoqr9hwn3Bbt1eez
        XHpCNIPHhDl/lXapC9WS9CuGUKZO9iHIEzwkFSyhBo6dj0lGY9xwUEAjdjE0lE+6jwp+v+
        XCG1zvKHyNjyCxeDqbr9uneOtVKOlnk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-Y6zSV5ieMCSqsYlL4gV2dg-1; Fri, 30 Apr 2021 05:11:23 -0400
X-MC-Unique: Y6zSV5ieMCSqsYlL4gV2dg-1
Received: by mail-ed1-f72.google.com with SMTP id o4-20020a0564024384b0290378d45ecf57so30227335edc.12
        for <selinux@vger.kernel.org>; Fri, 30 Apr 2021 02:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JG4a+wpzvObAuEp4SKh4VILGIf18YoL3xVa1kMGn9ag=;
        b=mIcljPphZExTOL2s9HANXBFwB0ybh5oX0iaUrLHkCnVsTgfx67ohm8psN76LNxNJLM
         GMeNQb7k9zA8FoKRdt6nMol2EvsOT7YmOjxagL4bKxw8A/T1wlAtuprWkzZ/oQDrpaFf
         AxpdNXIRDw3jMnCg1/6CWYXq0blY7d+QC0RNnsiaJalURN6+rY+H2AMe88NRf2NOXpu5
         j31fomWcaMJgFYiyULOXP052cfIkAiPedGrQUuOv55SNE680OkD9ZhWp5vGsBp3gP8Mq
         zAP4DNPZUvH23txSQLuXvI7eeiEQTmqa5bL/FnX08RQudQOSiVH/yV9Fo5nZQjKyAWiM
         s0Gw==
X-Gm-Message-State: AOAM532zMNTNwMdLvzG+kGkFa/kD/bJdLMoN07inJ50Xzp+aT4QVYsNp
        eriDw/pIkWlbqMD8/s1IrfmybcM/ueD6NFyDv1++jRHDwnTGPMfUH4Ead3si9uJF6s4GD8rM0f6
        o6JPQyFp+K6QqTDtKeEAKWIe0vRNdaG5o8ZKTWcQ5RWLPZU2F1qzW4LSSyUcdWxU3om0Z2A==
X-Received: by 2002:a17:906:6801:: with SMTP id k1mr3127288ejr.137.1619773881886;
        Fri, 30 Apr 2021 02:11:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlk7pscZd7bREbaaPWvkebd4ha1fza9Ecwe3EyXKBrlmuk35QQ3PZNsEWi9dPfHjxgOdqe+Q==
X-Received: by 2002:a17:906:6801:: with SMTP id k1mr3127268ejr.137.1619773881605;
        Fri, 30 Apr 2021 02:11:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id j20sm1534334ejc.110.2021.04.30.02.11.20
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 02:11:21 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] policy: only define anon_inode class if not defined in system policy
Date:   Fri, 30 Apr 2021 11:11:19 +0200
Message-Id: <20210430091119.607754-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When the system policy already defines this class, loading the test
policy fails with:

Re-declaration of class anon_inode
Previous declaration of class at /var/lib/selinux/targeted/tmp/modules/100/base/cil:1003
Bad class declaration at /var/lib/selinux/targeted/tmp/modules/400/test_userfaultfd/cil:2
/usr/sbin/semodule:  Failed!

Fix this by only including the anon_inode class declarations when it's
not found in the system policy headers.

Fixes: 2ea007924363 ("selinux-testsuite: Add userfaultfd test")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/Makefile                  | 3 +++
 policy/test_anon_inode_class.cil | 4 ++++
 policy/test_userfaultfd.cil      | 5 -----
 3 files changed, 7 insertions(+), 5 deletions(-)
 create mode 100644 policy/test_anon_inode_class.cil

diff --git a/policy/Makefile b/policy/Makefile
index 91364d5..dee55a2 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -39,6 +39,9 @@ ifeq ($(SUPPORTS_CIL),y)
 CIL_TARGETS = test_mlsconstrain.cil test_overlay_defaultrange.cil
 # userfaultfd test policy uses also xperms
 ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] && echo true),true)
+ifneq ($(shell grep -q anon_inode $(POLDEV)/include/support/all_perms.spt && echo true),true)
+CIL_TARGETS += test_anon_inode_class.cil
+endif
 CIL_TARGETS += test_userfaultfd.cil
 TARGETS += test_userfaultfd.te
 endif
diff --git a/policy/test_anon_inode_class.cil b/policy/test_anon_inode_class.cil
new file mode 100644
index 0000000..3e36599
--- /dev/null
+++ b/policy/test_anon_inode_class.cil
@@ -0,0 +1,4 @@
+; Define new class anon_inode
+(class anon_inode ())
+(classcommon anon_inode file)
+(classorder (unordered anon_inode))
diff --git a/policy/test_userfaultfd.cil b/policy/test_userfaultfd.cil
index 18d5f3f..f6a6791 100644
--- a/policy/test_userfaultfd.cil
+++ b/policy/test_userfaultfd.cil
@@ -1,8 +1,3 @@
-; Define new class anon_inode
-(class anon_inode ())
-(classcommon anon_inode file)
-(classorder (unordered anon_inode))
-
 ; Allow all anonymous inodes
 (typeattributeset cil_gen_require test_notransition_uffd_t)
 (allow test_notransition_uffd_t self (anon_inode (create getattr ioctl read)))
-- 
2.30.2


Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73BBC00140
	for <selinux@archiver.kernel.org>; Wed, 24 Aug 2022 11:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiHXLTt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Aug 2022 07:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbiHXLTs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Aug 2022 07:19:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA67CC3F
        for <selinux@vger.kernel.org>; Wed, 24 Aug 2022 04:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661339985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7GrtVYVUd3gAO8oy6EMHnf3XwlfU5vRzOjOD7CnDU8o=;
        b=SZMHmRelRjcOzkqmQ2hGxT7oAfjRKTYBeIv6Jov3Fc+Qi4EQG65NL9wKWRAxj2pJigFge+
        AmGgDtKkAnBsf6jwCCr3TV+L88dtZaIYYvTIPn6FkvatFsg0DRyxR3KiqnEFL7Opcr1fkz
        k66vAX5FDOSLJhJRf8TJVKFquw79oNI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-26-YYoqMNluPBmVkdztHlUTrg-1; Wed, 24 Aug 2022 07:19:43 -0400
X-MC-Unique: YYoqMNluPBmVkdztHlUTrg-1
Received: by mail-ed1-f71.google.com with SMTP id r20-20020a05640251d400b00446e3eee8a1so4891231edd.21
        for <selinux@vger.kernel.org>; Wed, 24 Aug 2022 04:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=7GrtVYVUd3gAO8oy6EMHnf3XwlfU5vRzOjOD7CnDU8o=;
        b=4ZvmuinAiyUoSWVOw86LPrTdWwF/o76D1QMQW+rFihR05l23Pag/yJFMOu58wIFt7G
         ebOxANkqv8eNoRBOQhvX2lD0Wzpn+5wEYPu//+15A1NG6iGXpjko/HwWjneQvyiDcZ8T
         buny10TTj7o1KkIo44kKeSOaiJAfHanyQuQmUGUB07p9XrXNqhyBX2+5ad1uG3wB0XJv
         WeDHpIPkavvGeX0k+3mtI7LL68+oYAwWCQ+I1cjz0Wn6PTb0UAo6vxBKpWxLLlzWl+c8
         I5GOEpEpjjVda7HO8rdZe9GLS4VQTsG2RFPsCZhcaG4/TtO71EYFOxPloPZ+Ioa1HQI/
         3Z4g==
X-Gm-Message-State: ACgBeo35NDL/dbaDlf1JbCRbNmJaSD1KUz2KNlnyOL1j7CXHLE1mtNmg
        vmwKpbI52BKXA8HWzZo8IRnjaBhes2g7wM7mRbCNH0lCMcCl6N0q3z/psNWBfuQvUOEDwDHGmlZ
        aZF7dkBDy4ggvvoVe3NnpTUue+ormmd1ZBFTARcqfyG0WldS4Tla+fKjhSfT5abU2beFF2w==
X-Received: by 2002:a05:6402:5292:b0:446:80b0:4a5d with SMTP id en18-20020a056402529200b0044680b04a5dmr7259741edb.285.1661339982569;
        Wed, 24 Aug 2022 04:19:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5P6sY3WySjT4LIxfjI7DV91cX8T1V1galKbs7HvYl/BPR95BMYcfpj9U9rgdXcrXBns1HD+Q==
X-Received: by 2002:a05:6402:5292:b0:446:80b0:4a5d with SMTP id en18-20020a056402529200b0044680b04a5dmr7259724edb.285.1661339982332;
        Wed, 24 Aug 2022 04:19:42 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090665c600b0073d6d1990e2sm1016047ejn.140.2022.08.24.04.19.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 04:19:41 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 2/2] test_userfaultfd.te: adapt to upcoming Fedora policy changes
Date:   Wed, 24 Aug 2022 13:19:38 +0200
Message-Id: <20220824111938.567993-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220824111938.567993-1-omosnace@redhat.com>
References: <20220824111938.567993-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We plan to add automatic transitions for anon_inodes to the whole domain
attribute, which would conflict with the testsuite's userfaultfd test.
To avoid th conflict, use testsuite_domain_type_minimal() for the
userfaultfd test domains, which doesn't add the types to the domain
attribute.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_userfaultfd.te | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/policy/test_userfaultfd.te b/policy/test_userfaultfd.te
index fe7f9c6..3046349 100644
--- a/policy/test_userfaultfd.te
+++ b/policy/test_userfaultfd.te
@@ -10,14 +10,14 @@ type uffd_t;
 # Domain for confirming that without transition rule the userfaultfd
 # gets process' context
 type test_notransition_uffd_t;
-testsuite_domain_type(test_notransition_uffd_t)
+testsuite_domain_type_minimal(test_notransition_uffd_t)
 typeattribute test_notransition_uffd_t test_uffd_domain;
 
 allow test_notransition_uffd_t self:anon_inode { create getattr ioctl read };
 
 # Domain for process that has all the permissions to use userfaultfd
 type test_uffd_t;
-testsuite_domain_type(test_uffd_t)
+testsuite_domain_type_minimal(test_uffd_t)
 typeattribute test_uffd_t test_uffd_domain;
 
 type_transition test_uffd_t test_uffd_t:anon_inode uffd_t "[userfaultfd]";
@@ -25,14 +25,14 @@ allow test_uffd_t uffd_t:anon_inode { create getattr ioctl read };
 
 # Domain for process that cannot create userfaultfd
 type test_nocreate_uffd_t;
-testsuite_domain_type(test_nocreate_uffd_t)
+testsuite_domain_type_minimal(test_nocreate_uffd_t)
 typeattribute test_nocreate_uffd_t test_uffd_domain;
 
 type_transition test_nocreate_uffd_t test_nocreate_uffd_t:anon_inode uffd_t "[userfaultfd]";
 
 # Domain for process that cannot get attributed of userfaultfd
 type test_nogetattr_uffd_t;
-testsuite_domain_type(test_nogetattr_uffd_t)
+testsuite_domain_type_minimal(test_nogetattr_uffd_t)
 typeattribute test_nogetattr_uffd_t test_uffd_domain;
 
 type_transition test_nogetattr_uffd_t test_nogetattr_uffd_t:anon_inode uffd_t "[userfaultfd]";
@@ -40,7 +40,7 @@ allow test_nogetattr_uffd_t uffd_t:anon_inode { create };
 
 # Domain for process which can only use UFFDIO_API ioctl on userfaultfd
 type test_api_ioctl_uffd_t;
-testsuite_domain_type(test_api_ioctl_uffd_t)
+testsuite_domain_type_minimal(test_api_ioctl_uffd_t)
 typeattribute test_api_ioctl_uffd_t test_uffd_domain;
 
 type_transition test_api_ioctl_uffd_t test_api_ioctl_uffd_t:anon_inode uffd_t "[userfaultfd]";
@@ -50,7 +50,7 @@ allowxperm test_api_ioctl_uffd_t uffd_t:anon_inode ioctl { 0xaa3f };
 # Domain for process which can use UFFDIO_API and UFFDIO_REGISTER ioctls
 # on userfaultfd
 type test_register_ioctl_uffd_t;
-testsuite_domain_type(test_register_ioctl_uffd_t)
+testsuite_domain_type_minimal(test_register_ioctl_uffd_t)
 typeattribute test_register_ioctl_uffd_t test_uffd_domain;
 
 type_transition test_register_ioctl_uffd_t test_register_ioctl_uffd_t:anon_inode uffd_t "[userfaultfd]";
@@ -60,7 +60,7 @@ allowxperm test_register_ioctl_uffd_t uffd_t:anon_inode ioctl { 0xaa3f 0xaa00 };
 # Domain for process which can use UFFDIO_API, UFFDIO_REGISTER and
 # UFFDIO_COPY ioctls on userfaultfd
 type test_copy_ioctl_uffd_t;
-testsuite_domain_type(test_copy_ioctl_uffd_t)
+testsuite_domain_type_minimal(test_copy_ioctl_uffd_t)
 typeattribute test_copy_ioctl_uffd_t test_uffd_domain;
 
 type_transition test_copy_ioctl_uffd_t test_copy_ioctl_uffd_t:anon_inode uffd_t "[userfaultfd]";
@@ -69,7 +69,7 @@ allowxperm test_copy_ioctl_uffd_t uffd_t:anon_inode ioctl { 0xaa3f 0xaa00 0xaa03
 
 # Domain for process that cannot perform any ioctl operations on userfaultfd
 type test_noioctl_uffd_t;
-testsuite_domain_type(test_noioctl_uffd_t)
+testsuite_domain_type_minimal(test_noioctl_uffd_t)
 typeattribute test_noioctl_uffd_t test_uffd_domain;
 
 type_transition test_noioctl_uffd_t test_noioctl_uffd_t:anon_inode uffd_t "[userfaultfd]";
@@ -77,11 +77,13 @@ allow test_noioctl_uffd_t uffd_t:anon_inode { create getattr };
 
 # Domain for process that cannot read from userfaultfd
 type test_noread_uffd_t;
-testsuite_domain_type(test_noread_uffd_t)
+testsuite_domain_type_minimal(test_noread_uffd_t)
 typeattribute test_noread_uffd_t test_uffd_domain;
 
 type_transition test_noread_uffd_t test_noread_uffd_t:anon_inode uffd_t "[userfaultfd]";
 allow test_noread_uffd_t uffd_t:anon_inode { create getattr ioctl };
 
+# testsuite_domain_type_minimal() doesn't allow fork by default
+allow test_uffd_domain self:process { fork };
 # userfaultfd(2) requires CAP_SYS_PTRACE
 allow test_uffd_domain self:capability { sys_ptrace };
-- 
2.37.2


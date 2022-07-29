Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFE2C19F29
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbiG2MDB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiG2MDA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:03:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98C5F863E0
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nmzMdpEjfOAzkgilv+vyVemlaHkoJx1T9GESikwb1uM=;
        b=EIL4OA0qQS4kUTYhvxc4Znl+1xibq9haLJndiiJCYnDey9xJCK19eGh6Hid2mAwEtZOw6J
        5Ca3ZWyL15d/HDkkhIwWh7+s9C3FrrKiNEkjl6SAdUzSNCApF3eOOpmnVTUX/5yVmCR/UX
        N7tonFP2Bdx/Bangp330Po4ZU379RrM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-xfdiYn8gOx6hry3QZ-Xhyw-1; Fri, 29 Jul 2022 08:02:49 -0400
X-MC-Unique: xfdiYn8gOx6hry3QZ-Xhyw-1
Received: by mail-wr1-f72.google.com with SMTP id i17-20020adfaad1000000b0021ecb856a71so1128128wrc.4
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=nmzMdpEjfOAzkgilv+vyVemlaHkoJx1T9GESikwb1uM=;
        b=mHbBsjt6M6aF5ydHIbhya4UObo7oMwFu9lGt/IMXjwMqubfzp2zlJCHXIhHCpbTBBd
         nvEYOcHqUB1CAVKkaLi49BKroM56Llk2Q2f16wcusU8czHrLhEyAAb4/KpGrbm2ijfeb
         UtqJXcgpaSdvx8hjbdpu4lPGftqmN4GhedkYtCsG7M41R1/4GkUsUoye/7Zrvv7rqVAg
         EQjf/mPq1VMxOuZgOhKetpBokilr11iIOMPGNwNN6ebtJXyLBh76Dugbl8updT0kuGN3
         3HNlaBuGBpiCbFh3NjlofzILhJcu721DzbDhpy0mU/Tk/GHpbf6BTvkmbKl0x/JTyBk3
         hEiA==
X-Gm-Message-State: AJIora/DLEqdL85XC3OcMT64ADOuJLGAwYN4VLqPA7XCYDHYYWM9cqlc
        AWaB+/ZA6X6Mtdg0QbVVWgw1pe9sjQQB+3iTZ3K0EJnwYEv46+caNdUehyhNj56mNDywKOAl7Jp
        xpuoOSaxwsVBgtfXwi/8tBf7XsG4YTWI/9GWtt7DRzeoR1+avWnpZ+it/5hhDALOXCDSJdw==
X-Received: by 2002:a05:600c:21d4:b0:3a3:10a0:cc4f with SMTP id x20-20020a05600c21d400b003a310a0cc4fmr2684047wmj.75.1659096168203;
        Fri, 29 Jul 2022 05:02:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uA5Cb8VYuFFGPVEcTB2SmNj8rcZ9v4Q1EYyJj0HLFguTtwkU1X5QpP5J7ci1nry1EgId3AOA==
X-Received: by 2002:a05:600c:21d4:b0:3a3:10a0:cc4f with SMTP id x20-20020a05600c21d400b003a310a0cc4fmr2684025wmj.75.1659096167918;
        Fri, 29 Jul 2022 05:02:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.02.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:02:47 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 10/24] policy: substitute userdom_sysadm_entry_spec_domtrans_to()
Date:   Fri, 29 Jul 2022 14:02:15 +0200
Message-Id: <20220729120229.207584-11-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
References: <20220729120229.207584-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use sysadm_entry_spec_domtrans_to() which is the actual name of the
interface in Fedora policy and refpolicy now.
userdom_sysadm_entry_spec_domtrans_to() has been deprecated.

sysadm_entry_spec_domtrans_to() is available even as far back as RHEL-6
and also in refpolicy, so remove the whole fallback implementation.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_global.te |  2 +-
 policy/test_policy.if | 13 -------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/policy/test_global.te b/policy/test_global.te
index 667c272..aceac48 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -41,7 +41,7 @@ allow testsuite_domain init_t:fd use;
 allow testsuite_domain initrc_t:fd use;
 
 # Allow the test domain to be entered from sysadm_t
-userdom_sysadm_entry_spec_domtrans_to(testsuite_domain)
+sysadm_entry_spec_domtrans_to(testsuite_domain)
 
 # Allow the test domains to access the test directory and files
 # even if they are not root owned.
diff --git a/policy/test_policy.if b/policy/test_policy.if
index 6cef8dd..89ab6f7 100644
--- a/policy/test_policy.if
+++ b/policy/test_policy.if
@@ -17,19 +17,6 @@
 ## </desc>
 #
 
-ifdef(`userdom_sysadm_entry_spec_domtrans_to',`', ` dnl
-interface(`userdom_sysadm_entry_spec_domtrans_to',`
-        gen_require(`
-                type sysadm_t;
-	')
-
-        domain_entry_file_spec_domtrans(sysadm_t, $1)
-        allow $1 sysadm_t:fd use;
-        allow $1 sysadm_t:fifo_file rw_file_perms;
-        allow $1 sysadm_t:process sigchld;
-')
-')
-
 interface(`testsuite_domain_type_common',`
 	gen_require(`
 		attribute testsuite_domain;
-- 
2.37.1


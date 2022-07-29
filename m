Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDC8C19F2D
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiG2MC6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiG2MC5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33AAC863E0
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/g4KdbrfQrpiJaYWhcxsqfMuvp6LnddOW2zQzTFx9Bg=;
        b=QIyqg9ur2bXn2tMz3rPn65ZOJPP8bIeEl1osmTdOy52U+jQkdzH1eqj6pOajW07c2MglAu
        Mp30Z9s8O+hzR1j6pP7rdMgFrOKvhqtZr6wscMxa5M/nb3uoYvE4VVeU9SKxB+xb1udDnG
        4NWl+4yWT/cmi7HN2C3Ibjg7O8c1ZeI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-Aqrd76MvPtKkKQzkXL5NbA-1; Fri, 29 Jul 2022 08:02:55 -0400
X-MC-Unique: Aqrd76MvPtKkKQzkXL5NbA-1
Received: by mail-wr1-f72.google.com with SMTP id t13-20020adfe10d000000b0021bae3def1eso1130648wrz.3
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=/g4KdbrfQrpiJaYWhcxsqfMuvp6LnddOW2zQzTFx9Bg=;
        b=UZ3pbNjaxCuFs8RrPlTN6q+4RGmaoQ61SDXBO3Jc89y5pgt6PB9A5jf3wUIR25zaJR
         XSzOAKEs4m0ZRXPhrcUZFkUoTB+p5T87RQUA2grXAHYlneRt3nXCdae6KFd61KxL80hi
         W3oltLVxG8B4c1pdg9pwG9exZ7GPhgy724/xEz9dN5+EjIXnNukQURJYEjEAuX/Vg790
         LR+j5lsJvEPmhvdSGSnP0W8dJy0FSJg5+w12L/o02qteTYRoTgi1UzYT1nLfRCTAiN4d
         shAA2SU4fuJcr8ijXbrmHZloORHD0sf7zeULFyL/OaAkIWBEsxO7XYBe8uObOxd941ne
         osEw==
X-Gm-Message-State: ACgBeo2GhnhbsmcBazvj51M6wN5r35b9aN0cCU0NjH0Lh/ov0LCrcwu/
        ixNXkP8xNTfD/sk0y7th1uDV0ioaKVG5EemWAIS1Ec2mbmN5Fu6IA+DeAJC57MaaIZnIKCBoXPb
        N/uld89y6hTFv/3i2tiXGvKoAA/7I9jgKLmWA21ogfa/csZ8mcjGv3qpMtT9zLdnpatOIew==
X-Received: by 2002:a5d:5223:0:b0:21e:fc10:b818 with SMTP id i3-20020a5d5223000000b0021efc10b818mr2219543wra.676.1659096173237;
        Fri, 29 Jul 2022 05:02:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6XL/V3Tq4t2XBhT2W4HGpz+hlANmazydhPyvgrUPi/TkCXyLMyNcqrlsPe/IdaoVBOcH8new==
X-Received: by 2002:a5d:5223:0:b0:21e:fc10:b818 with SMTP id i3-20020a5d5223000000b0021efc10b818mr2219517wra.676.1659096172914;
        Fri, 29 Jul 2022 05:02:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.02.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:02:52 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 13/24] test_filesystem.te: remove suspicious rules
Date:   Fri, 29 Jul 2022 14:02:18 +0200
Message-Id: <20220729120229.207584-14-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
References: <20220729120229.207584-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These don't seem to make sense. Get rid of them.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_filesystem.te | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
index 4942e0d..d8c5c51 100644
--- a/policy/test_filesystem.te
+++ b/policy/test_filesystem.te
@@ -126,7 +126,6 @@ fs_getattr_xattr_fs(test_filesystem_may_create_no_associate_t)
 # Create test file
 # neverallow unlabeled_t test_filesystem_may_create_no_associate_t:filesystem { associate };
 allow test_filesystem_may_create_no_associate_t self:file { create relabelfrom relabelto };
-allow test_filesystem_may_create_no_associate_t unconfined_t:file { open read write };
 allow test_filesystem_may_create_no_associate_t unlabeled_t:dir { add_name search write };
 allow test_filesystem_may_create_no_associate_t unlabeled_t:file { create open relabelfrom write };
 
@@ -266,9 +265,6 @@ fs_associate(test_filesystem_inode_setxattr_no_associate_t)
 
 # Create test file
 allow test_filesystem_inode_setxattr_no_associate_t self:file { create relabelfrom relabelto };
-# neverallow unconfined_t test_filesystem_inode_setxattr_no_associate_t:filesystem { associate };
-allow test_filesystem_inode_setxattr_no_associate_t unconfined_t:dir { add_name write };
-allow test_filesystem_inode_setxattr_no_associate_t unconfined_t:file { create relabelfrom relabelto };
 
 ################# Test process { setfscreate } #############
 type test_setfscreatecon_t;
@@ -357,7 +353,6 @@ allow test_filesystem_sb_relabel_no_relabelfrom_t self:filesystem { mount relabe
 allow test_filesystem_sb_relabel_no_relabelfrom_t self:filesystem { mount };
 
 allow test_filesystem_may_create_no_associate_t nfs_t:filesystem { associate };
-allow test_filesystem_may_create_no_associate_t unconfined_t:file { getattr relabelto };
 allow test_filesystem_may_create_no_associate_t test_file_t:dir { add_name };
 allow test_filesystem_may_create_no_associate_t test_file_t:file { create write relabelfrom };
 allow test_filesystem_may_create_no_associate_t test_filesystem_file_t:filesystem { mount unmount relabelto };
@@ -365,7 +360,6 @@ allow test_file_t test_filesystem_may_create_no_associate_t:filesystem { associa
 allow unconfined_t test_filesystem_may_create_no_associate_t:filesystem { getattr mount relabelto unmount };
 # neverallow unconfined_t test_filesystem_may_create_no_associate_t:filesystem { associate };
 
-allow test_filesystem_inode_setxattr_no_associate_t unconfined_t:file { getattr open read write };
 allow test_filesystem_inode_setxattr_no_associate_t nfs_t:filesystem { associate };
 allow test_filesystem_inode_setxattr_no_associate_t test_file_t:dir { add_name };
 allow test_filesystem_inode_setxattr_no_associate_t test_file_t:file { create relabelfrom write };
-- 
2.37.1


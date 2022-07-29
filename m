Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FA3C00144
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbiG2MC4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiG2MCz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:02:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF8C7863DF
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AMpM46hByXSHkPlVjlvwfNHdJ1v64qmFISvJRE+NWD8=;
        b=eyXZDuLsWmPm7gHNxSMfUEVu5X1DL/+I14KzpToOK6y6Wgl0RhjEXtERePqUb5hJNDcF78
        poa5unK0UjXLgbsuSlVKOFUz8Yrq0qUmc24vwzTDDBOyG/rLwvinHInzA3MvI5L+PmqK5Q
        561UVwrihfNJbyrlxalKpzOv4kZVDtg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-LrE6qk16PB6fY8_CelZpSA-1; Fri, 29 Jul 2022 08:02:52 -0400
X-MC-Unique: LrE6qk16PB6fY8_CelZpSA-1
Received: by mail-wr1-f72.google.com with SMTP id w17-20020adfbad1000000b0021f0acd5398so1049038wrg.1
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=AMpM46hByXSHkPlVjlvwfNHdJ1v64qmFISvJRE+NWD8=;
        b=khHeqrV0IuefqTSAlASBSdMl8EI8Q8PLbUL8xovpLJD0M4jGyCYc//yGccuuEK4GZL
         2nRdRH6fJOQxE+EJXy26MXd4SGdCL1hx/+CS902B4f8LOJX0BjVluy7H+xqtLysh25ni
         XkxEMS8bhu0Mn/al2mAWwdO+ORXzQ6ezA++/VWhAzJKkr34lFzZJyzKt2kO2XC0riw/4
         ZfoQIhrJLf3MkyQDet+poOPniWv75DCaXmOuteKdFBpjXTQF+wXJdJQjNBM38M6b3VEu
         EJqbuCyfVnIni3GLNUtp1XfykZzTbkLahG8lb2SPXO0QgUKwIuftVnd50nFqOoaJGMmz
         UtAQ==
X-Gm-Message-State: AJIora9TktsMBsWNFxEYQs+fCpyiX1DsRgyakkSjrw408Gpx1Pg1tG/Q
        iVzB1o8xQotkTe43vijMWQbdR06EuPONqmBiMZ9nlbaliPcgW4tupm1HExfiZzDFiLeGWYppl9L
        WbLEn5/zulQtIz/+oRaNO3r2YdR8Ua1GVkgABQhvEcpX0vYzVvnHpsfyp9FJzImNCKLlf4A==
X-Received: by 2002:a05:600c:3845:b0:3a3:227d:c1c6 with SMTP id s5-20020a05600c384500b003a3227dc1c6mr2653557wmr.9.1659096170331;
        Fri, 29 Jul 2022 05:02:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vuJ/LRn/4vikKE9LM0ulCI+6/MkRBoJ2r7388tQM2zahlI2lI1ttKCdrzMkWmwFPU0zUOwdQ==
X-Received: by 2002:a05:600c:3845:b0:3a3:227d:c1c6 with SMTP id s5-20020a05600c384500b003a3227dc1c6mr2653537wmr.9.1659096170009;
        Fri, 29 Jul 2022 05:02:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.02.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:02:48 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 11/24] test_general.te: move sysadm-related rules into an optional block
Date:   Fri, 29 Jul 2022 14:02:16 +0200
Message-Id: <20220729120229.207584-12-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
References: <20220729120229.207584-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

That should allow running selinux-testsuite with the sysadm module
disabled.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_global.te | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/policy/test_global.te b/policy/test_global.te
index aceac48..3862ee7 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -25,12 +25,21 @@ optional_policy(`
 	dontaudit unconfined_t testsuite_domain:process { noatsecure rlimitinh siginh };
 ')
 
-gen_require(`
-	role sysadm_r;
-')
+optional_policy(`
+	gen_require(`
+		role sysadm_r;
+	')
+
+	# Authorize sysadm_r for the test domains.
+	role sysadm_r types testsuite_domain;
 
-# Authorize sysadm_r for the test domains.
-role sysadm_r types testsuite_domain;
+	# Allow the test domain to be entered from sysadm_t
+	sysadm_entry_spec_domtrans_to(testsuite_domain)
+
+	# Let sysadm_t use runcon to run the test programs in various domains.
+	#allow sysadm_t self:process setexec;
+	#selinux_get_fs_mount(sysadm_t)
+')
 
 # Allow the test domains to access the sysadm terminal.
 # This allows read and write sysadm ttys and ptys.
@@ -40,17 +49,10 @@ term_use_all_terms(testsuite_domain)
 allow testsuite_domain init_t:fd use;
 allow testsuite_domain initrc_t:fd use;
 
-# Allow the test domain to be entered from sysadm_t
-sysadm_entry_spec_domtrans_to(testsuite_domain)
-
 # Allow the test domains to access the test directory and files
 # even if they are not root owned.
 allow testsuite_domain self:capability { dac_override dac_read_search };
 
-# Let sysadm_t use runcon to run the test programs in various domains.
-#allow sysadm_t self:process setexec;
-#selinux_get_fs_mount(sysadm_t)
-
 # Let all test domains read test directories and files and to use test
 # files as entry points.
 miscfiles_read_test_files(testsuite_domain)
-- 
2.37.1


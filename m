Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD48C4338F
	for <selinux@archiver.kernel.org>; Wed,  4 Aug 2021 13:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33AB960F35
	for <selinux@archiver.kernel.org>; Wed,  4 Aug 2021 13:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhHDNJA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Aug 2021 09:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21171 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233389AbhHDNJA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Aug 2021 09:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628082527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cxYTDmFboOx7+lDpIqCKc5zYzqx+166jBX4OCufOErI=;
        b=MNYzh0trtnOQgjG6K/bVE9hheXujNO6zC7YZ9o5zSSZPJfSpKbdc5fw56g4k+hLdl4UgCN
        OZOljDOMVuJlXlPB77/ITwfGPOzcK2ggUWigKkCTbZwa2JNQSGxjRNORbt6RwFqNrsTAoa
        iWA+RcWsPhxFNbaO/iiDHAOj2LkhteU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-kFwc5Co_P3qwjAslrvFOYg-1; Wed, 04 Aug 2021 09:08:46 -0400
X-MC-Unique: kFwc5Co_P3qwjAslrvFOYg-1
Received: by mail-wr1-f70.google.com with SMTP id d10-20020a056000114ab02901537f048363so805446wrx.8
        for <selinux@vger.kernel.org>; Wed, 04 Aug 2021 06:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cxYTDmFboOx7+lDpIqCKc5zYzqx+166jBX4OCufOErI=;
        b=MA4epTuNvDvypri9gJJLg5UK3oajTjEMWjNrxfPJSzZsPe6WWKTu5T3O6tvBbl5el/
         u3MwBQt7cUEMu3E/jgcyQDK5IzJFzb7cAT8OuZmc5ePIiuEIJ9bJ4esObDxMukAp/yr8
         GSk0GdZ1dNX8kg/0rKfVA16eMzm2mAfHSbcs3UMmAcWWjdAAfqZvbkwgRItSmW/LmUAD
         BRAlFKtZO8Pmu143RYh4JFZiJOwJeUwRqhBkx5Kg1gTVZbD3XuYG9/l+8j64EzzrwJ5W
         4O0aDyLn3U6AxoBhlh084U9Zrl9zVRM8AQaXGQAqrSDo9FO0L2T6WYdyNMDv3pX6cMlH
         dZDw==
X-Gm-Message-State: AOAM530LKQlEmOmj/spdfvePV1b2k5zR+tdsSfgZB32VVB0uezDwxhVv
        Y4uF98x93wKNZyNYWs/cBmIL/ik0L8mF0McTq8KOhKVipGAerP6glVDbgjzXZTvyUflYjk4JElM
        o6OYT37N2du745DYejihEVcJtWP+MOkWumti36bsQ+EHw/yzl0TKTzh16ES56qVqra3Q7fQ==
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr9825735wmk.97.1628082524831;
        Wed, 04 Aug 2021 06:08:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxemi4lbfQyBfR1hBXdeNDHkll9Z78pPCUPT86aMDuzzr92l6vxWcgEWs5fhZgXZt7VUBnKUQ==
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr9825702wmk.97.1628082524567;
        Wed, 04 Aug 2021 06:08:44 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i29sm2333790wmb.20.2021.08.04.06.08.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 06:08:43 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/capable_sys: skip test_rawio on BTRFS
Date:   Wed,  4 Aug 2021 15:08:42 +0200
Message-Id: <20210804130842.743651-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

BTRFS doesn't support the FIBMAP ioctl, which is used to test
CAP_SYS_RAWIO. It is already disabled for NFS, so disable that test also
on BTRFS.

Fedora 35 cloud images already have BTRFS volumes instead of ext4 and
this patch is needed to make the testsuite pass there.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/capable_sys/test | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/capable_sys/test b/tests/capable_sys/test
index cd50ebc..a72616d 100755
--- a/tests/capable_sys/test
+++ b/tests/capable_sys/test
@@ -9,10 +9,11 @@ BEGIN {
     $basedir = $0;
     $basedir =~ s|(.*)/[^/]*|$1|;
 
-    $isnfs = `stat -f --print %T $basedir`;
+    $fs          = `stat -f --print %T $basedir`;
+    $test_fibmap = $fs ne "btrfs" and $fs ne "nfs";
 
     $test_count = 7;
-    if ( $isnfs ne "nfs" ) {
+    if ($test_fibmap) {
         $test_count += 1;
     }
 
@@ -26,7 +27,7 @@ system "rm -f $basedir/temp_file 2>&1";
 # Tests for the good domain.
 #
 
-if ( $isnfs ne "nfs" ) {
+if ($test_fibmap) {
 
     # CAP_SYS_RAWIO
     system "touch $basedir/temp_file 2>&1";
-- 
2.31.1


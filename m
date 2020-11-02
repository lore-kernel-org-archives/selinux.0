Return-Path: <SRS0=BHhV=EI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED110C00A89
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 10:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 918612231B
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 10:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2Jfou2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgKBKv0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Nov 2020 05:51:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728005AbgKBKv0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Nov 2020 05:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604314285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ct96vy5EMm+1g8Va51X0/nevCCjYhl9U+iVV5pIusH4=;
        b=d2Jfou2r9XvP925t+KuxuPj3vfwj4+0Rtyasvzr96xsW+MZBw7NR8hl33mwQVV/3ismufa
        ySaC5ryTeg5kNRGd6u1p642UiRzY7KmXsrHdwb91icT6eNwdwtmwdOUYt89z7pHcQ/7O4A
        t3hiZM6xyQxZqvNwjBQZyImMKkDSnZM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-hvCNnk1RP1ypbsduyVgq7A-1; Mon, 02 Nov 2020 05:51:24 -0500
X-MC-Unique: hvCNnk1RP1ypbsduyVgq7A-1
Received: by mail-ej1-f72.google.com with SMTP id nt22so1120141ejb.17
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2020 02:51:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ct96vy5EMm+1g8Va51X0/nevCCjYhl9U+iVV5pIusH4=;
        b=AGHwrZROQrqgs2WUPB+LydkOnorv9IQNQ4uZ9x6nZ7MItsWv+DYxZF7cxMrpkgtN7i
         QjenbSq2/Pq3Zyn1N5VV4+FXs/47e4N8ZI9ZvGexpdE1AXHAtGPuzQ83Yc8yawaYGu23
         UnrTKvfdmqW6mnN0Uc2GzwxEE44uYe8zgWZQwXIIcXnAztpF0rmw+ZZXKxSzRMs6/rU+
         sXGhx1UGI3lIiPHuTJGDU0ecru9g+YwASjwVZbbQmRKaqMCngGBk4RZ07O5FsuBdjg1j
         qUzHO7rWVTKPD8ZSfmucHtClj3ybdrLkU4nzA9ruY/sLsYq7vz6GnQCM33CzFuJDVyYG
         MaZg==
X-Gm-Message-State: AOAM532xjmqzQAW1yAWveAKQUF1wh/JvfZZmemELyEhGQ+FAQui80PXr
        /WLZfqmi2mHjY/9XpuKif/HOC9uiQuMTKPsuNjAbdEN/7jayDRJBFRCKiXp7pVziWQVRhpalEla
        1EyebrLITCafqlXlcLw==
X-Received: by 2002:a17:906:30ca:: with SMTP id b10mr10189573ejb.390.1604314282832;
        Mon, 02 Nov 2020 02:51:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygCEV4GPV6otDkFR38KaDcE0B9l6wTPiEcQ3JUMM2v+fNZjBtKjxsmo3kKJ2S1Rhq4nIfEgg==
X-Received: by 2002:a17:906:30ca:: with SMTP id b10mr10189559ejb.390.1604314282590;
        Mon, 02 Nov 2020 02:51:22 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id 11sm9371262ejy.19.2020.11.02.02.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 02:51:22 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     William Roberts <bill.c.roberts@gmail.com>
Subject: [PATCH testsuite] travis: fix kernel update check
Date:   Mon,  2 Nov 2020 11:51:20 +0100
Message-Id: <20201102105120.492607-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We need to run ssh without -tt to get the correct output and also run
dnf with -q to exclude the repo cache update lines. Also, ssh has
trouble with quoting of arguments, so we need to pipe the command via
stdin.

Moreover, dnf check-update doesn't seem to do what we need here. Rather
use `dnf -q info --avail`, which is also more straightforward to use.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 travis-ci/run-kvm-test.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/travis-ci/run-kvm-test.sh b/travis-ci/run-kvm-test.sh
index 6afbf96..3c19df8 100755
--- a/travis-ci/run-kvm-test.sh
+++ b/travis-ci/run-kvm-test.sh
@@ -123,9 +123,9 @@ fi
 
 # Check if kernel-modules-$(uname -r) can be installed from repos,
 # otherwise update kernel and reboot.
-kernel_avail="$(ssh -tt -o StrictHostKeyChecking=no -q "root@$ipaddy" \
-    sh -c "dnf check-update kernel-modules-\$(uname -r) | wc -l")"
-if [ $kernel_avail -eq 0 ]; then
+if ! echo "dnf -q info --available kernel-modules-\$(uname -r)" | \
+    ssh -o StrictHostKeyChecking=no -q "root@$ipaddy"
+then
     ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" \
         dnf update -y kernel-core
 
-- 
2.26.2


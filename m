Return-Path: <SRS0=qOYA=EG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B290C4742C
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 11:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A7D320724
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 11:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VsCHihDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgJaL4L (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 31 Oct 2020 07:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727060AbgJaL4K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 31 Oct 2020 07:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604145369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EEdhfquk6SyWWkHPzszNFtJfFb9gTGHgZXx6x23uqg0=;
        b=VsCHihDKGJGrmSgBbtJOdGliJmsLz2LbyvCiiWXIphh6YQQYzyc6KtqdvYIr3uuZTfg1/H
        sizajpmrpsvmWY2t1hlNksYu39ueETjsN8otJ0iIItfZIzNLceBtH7YdXOrt/cQadzymLa
        ZIE1+avP4gltdTse83gynShukZepHeE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-dYvHYO6CP_qmgQW23UeFrw-1; Sat, 31 Oct 2020 07:56:07 -0400
X-MC-Unique: dYvHYO6CP_qmgQW23UeFrw-1
Received: by mail-ej1-f72.google.com with SMTP id z18so3237172eji.1
        for <selinux@vger.kernel.org>; Sat, 31 Oct 2020 04:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EEdhfquk6SyWWkHPzszNFtJfFb9gTGHgZXx6x23uqg0=;
        b=ACDrrqJmok0UCXN+aig/7iY9qs0QwtINk4W/ujFDD6oc4G/7D0yalwBh2wJNYxEbOU
         QVIld5uwndOz1FKrO/wGb9rOYiXGz5vnOlcGUpn2PFNgqCbUwEbJViXlefjJc5dwIQZf
         a8Y5nOakEI0pBl2uF7e9g8ZuzL7jBxOyli2kKNBrEmD1DJdrFLrjOg44NncfrtP3JiX9
         rOwhV+6cVzRUxwGCcQFK85WWRwWQ25WeVgAdiyI9g2EF98NmtUmius5AYdGt2acPOXAR
         QXqhAh7VRWld3w2NE63paI7nIWfDbn3LHLErsB2ZPfZbLZgaq9oEXFNhLlBTqCzRpVJT
         VcvA==
X-Gm-Message-State: AOAM533Kutdcf1lecI5pXF7IF70wyUZNVe6ReIVNXHDRpt1sRrk/spQb
        KXbBxNpkwfcE81Z1HkTocGiPjekTiWZuhvxLnIwVapETpR5OVbYHpy6TnfuJBkasZa19QRuUrqD
        DwgCRw7k18+C809BvXQ==
X-Received: by 2002:a17:906:e24a:: with SMTP id gq10mr6705990ejb.552.1604145365855;
        Sat, 31 Oct 2020 04:56:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6UvZ4yGrE/kjSnYPZX0HmCHUoBIb+Fhaj5qdAOj1RS0B+sinX78Gej8qf2kWh/pVie7spxA==
X-Received: by 2002:a17:906:e24a:: with SMTP id gq10mr6705974ejb.552.1604145365692;
        Sat, 31 Oct 2020 04:56:05 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id y14sm4770746edo.69.2020.10.31.04.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 04:56:05 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH testsuite 2/3] tests/filesystem: pipe "yes" to mkfs.* to fix jfs test
Date:   Sat, 31 Oct 2020 12:56:00 +0100
Message-Id: <20201031115601.157591-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201031115601.157591-1-omosnace@redhat.com>
References: <20201031115601.157591-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

mkfs.jfs is reluctant to overwrite the device without the user's
consent, so shout a stream of y's on it to avoid the test getting stuck.
We can't universally pass -q to mkfs.*, because not all mkfs.* tools
support it.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/filesystem/Filesystem.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesystem.pm
index 2365ce8..c14e760 100644
--- a/tests/filesystem/Filesystem.pm
+++ b/tests/filesystem/Filesystem.pm
@@ -133,7 +133,7 @@ sub make_fs {
     attach_dev( $mk_dev, $mk_dir );
 
     print "Make $mk_type filesystem on $mk_dev\n";
-    $result = system("mkfs.$mk_type $mk_dev >& /dev/null");
+    $result = system("yes | mkfs.$mk_type $mk_dev >& /dev/null");
     if ( $result != 0 ) {
         system("losetup -d $mk_dev 2>/dev/null");
         print "mkfs.$mk_type failed to create filesystem on $mk_dev\n";
-- 
2.26.2


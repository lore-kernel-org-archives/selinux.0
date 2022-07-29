Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F96C19F2D
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbiG2MDD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbiG2MDD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:03:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20023863E5
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zc1lKGjGRsBCtJZ/bO+/ZDXit8olBIR9WB+N7ny77AI=;
        b=QPs5FMUBqUpOpqTcfpxRqyuO8TBsI9PGuaC8tELvuedSvQVPcqEl9MROdsRj8dx7vgv0gn
        oYr0bKMJ93ALdeB/gRX/q49AcMSNtVBlBn1cocXpwgqbUgyI5EYt4vzWwfOKiP7JvV9rHy
        uROS/wQ9Sry+5chhyMSZ3BtDo2snPDk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-OQEzQ8PkN7uuALsE5ovY5w-1; Fri, 29 Jul 2022 08:03:00 -0400
X-MC-Unique: OQEzQ8PkN7uuALsE5ovY5w-1
Received: by mail-wr1-f69.google.com with SMTP id j4-20020adfa544000000b0021ebac13bf3so1132545wrb.19
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=zc1lKGjGRsBCtJZ/bO+/ZDXit8olBIR9WB+N7ny77AI=;
        b=A3wp/mzehx3bT3jsrqcMir0Av08qqSJlgfyk62fvcYUTe0A/6iFJkK6dNMEIyneZdQ
         lEUKJPGHd6cbnt7GO0sGcsyFHMGWVz76VQZ7ynSf1IZrj73yiy+Gh/SOE/Ttfu2qraBx
         txtpRxLVGXbjWk7+IK3vR9ctE1LXeQVBgaY1C0eRTzDPiKfApngkkVyFagD8JW58GvvN
         jtWVg85zCQSHU3bq0io0Q3tFdPXtuOhj+/F9yt/+inOYYsROm9A5sNyy0HSMtj4cabqB
         VxpdgjEGMhIRIhnCPUhhhvvce+hqqV2j/4rWnWtC4TlHGPMxLXyEiL+jRbWwstMjts8U
         FLbw==
X-Gm-Message-State: ACgBeo1rLBZaLBRhhDsDYZ/qijgEqysuJyNq6MYo2YZCm8rXb0vRKaHc
        UBipqSz0CjWJ+GDCPXfCsjW8c2xOXHZhj0EnNzHj4vyDld/Bnv/wwT9OtChvm/LyQOIbtvpke+b
        p7J2DY1GpxAprRoYIFKPPiJGmfOw1PoN/ChHmKCccLxaMMBTc3HERSQj0pY4RbPHSD9Snjg==
X-Received: by 2002:a05:6000:3c2:b0:21e:a306:a9db with SMTP id b2-20020a05600003c200b0021ea306a9dbmr2280000wrg.174.1659096178534;
        Fri, 29 Jul 2022 05:02:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6JlgPS55wvKNra0ZBAAl5ZT5QEYqbvO8A0EWeNIwJ+x667mP8ClB1/O0OPEaoouB0NhWxahw==
X-Received: by 2002:a05:6000:3c2:b0:21e:a306:a9db with SMTP id b2-20020a05600003c200b0021ea306a9dbmr2279970wrg.174.1659096178177;
        Fri, 29 Jul 2022 05:02:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.02.56
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:02:57 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 17/24] test_general.te: generalize the dontaudit rule
Date:   Fri, 29 Jul 2022 14:02:22 +0200
Message-Id: <20220729120229.207584-18-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
References: <20220729120229.207584-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The unconfined_t-specific dontaudit rule here is actually also needed
for sysadm_t, so generalize it to the whole testsuite_caller_domain.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_global.te | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/policy/test_global.te b/policy/test_global.te
index 3536fbb..91bddd8 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -28,8 +28,6 @@ optional_policy(`
 	allow testsuite_domain unconfined_t:fd use;
 	allow testsuite_domain unconfined_t:fifo_file { read write ioctl getattr };
 	allow testsuite_domain unconfined_t:process { sigchld };
-	# needed for domains outside domain_type()
-	dontaudit unconfined_t testsuite_domain:process { noatsecure rlimitinh siginh };
 ')
 
 optional_policy(`
@@ -65,6 +63,9 @@ optional_policy(`
 	#selinux_get_fs_mount(sysadm_t)
 ')
 
+# Needed for domains outside domain_type()
+dontaudit testsuite_caller_domain testsuite_domain:process { noatsecure rlimitinh siginh };
+
 # Allow the test domains to access the sysadm terminal.
 # This allows read and write sysadm ttys and ptys.
 term_use_all_terms(testsuite_domain)
-- 
2.37.1


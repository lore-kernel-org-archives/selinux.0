Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6524BC00144
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbiG2MDL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbiG2MDK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC116863E2
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/0v6kgSPND0wGwGMQ1gkLK9NWV1wmbK/hF/O5NZhRTg=;
        b=RrW3UxxqQwrFOHsM3KMsdilgI/W7+LmMSuSz5WMmvFxFSRMoXmcfeccPAOweLv+P8Yhit8
        ZEPCiZNolzIw2XUhEG7+3dqjpUEnYBLpAtUp76Fh0nXcA+PWw57Ocy2i0TiHB4Lj2fBNEt
        gyUNyEHuCH4BF97DDtso2juThQw0xG8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-8AWD11AXOJitksZtZQJfDA-1; Fri, 29 Jul 2022 08:03:07 -0400
X-MC-Unique: 8AWD11AXOJitksZtZQJfDA-1
Received: by mail-wr1-f69.google.com with SMTP id x5-20020adfbb45000000b0021ee56506dfso1150143wrg.11
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=/0v6kgSPND0wGwGMQ1gkLK9NWV1wmbK/hF/O5NZhRTg=;
        b=nX8QcpEaUzK13BnLS3uwdVstgtwRPaU8z1BFoVto7m9HB6RwV3kGv1dKiN3UxzRlzw
         ak3S+xbkO/l0x2CbGnk0e8lZjODKZYgjYuPjqHp6yq3iorsviJlGZbhWl6Y4R5nz0/jx
         Pp8/sUsITxCyVBkFU81E67RZl+5CtRzKuhK2nVzF6Xa2yvtxEqM3jw1jmcAFWFdv/ux3
         taQIpOmAHgVBscug+y2u8eqajS7/czFLPDCdQRzrDS7FrvwHjHRwLrB+/NvRmAENmyIg
         /zBgQWpfgDup6HATae0BsyosJUA22iaQSKYNH1LXYb6y1rCzW/fyl1kDjR0WvHN62Gex
         l1pQ==
X-Gm-Message-State: ACgBeo05GlSecTv6Rmv01WsCX5mNUnJ16yuuyYmKMopNmwzKhFDq2Hn3
        y4FcWJnEHUwdCBoNpR9vF2gBlvfxsy+l+RRrH1LhdW6oCRqO0MZ6nFBWKkf22B0Tn5KXkoss65f
        WAw6wQbBXTiO8Sbi8fGgLy82iGYQYwTdOYNwnk4xpMAdDKNbZHgdlEtDgGCEJyP2sdjWQJA==
X-Received: by 2002:a5d:5c0c:0:b0:21e:7098:1903 with SMTP id cc12-20020a5d5c0c000000b0021e70981903mr2130074wrb.623.1659096185927;
        Fri, 29 Jul 2022 05:03:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR76JzRD6l6Wxlubn7snz8T+pfF0rAQTCBCgPkfgJw2jknBpMl3zju5ytsp/abv2TJLhyqMrPA==
X-Received: by 2002:a5d:5c0c:0:b0:21e:7098:1903 with SMTP id cc12-20020a5d5c0c000000b0021e70981903mr2130054wrb.623.1659096185612;
        Fri, 29 Jul 2022 05:03:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.03.04
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:03:04 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 22/24] policy: give sysadm_t perms needed to run quotacheck(8)
Date:   Fri, 29 Jul 2022 14:02:27 +0200
Message-Id: <20220729120229.207584-23-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
References: <20220729120229.207584-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Unfortunately this is not allowed in the Fedora policy currently, so we
need to work around it.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_global.te | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/policy/test_global.te b/policy/test_global.te
index 7d399e6..2592553 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -58,6 +58,10 @@ optional_policy(`
 	# Allow the test domain to be entered from sysadm_t
 	sysadm_entry_spec_domtrans_to(testsuite_domain)
 
+	# Needed for quotacheck(8) in the filesystem test to succeed
+	fs_remount_xattr_fs(sysadm_t)
+	storage_raw_read_fixed_disk(sysadm_t)
+
 	# Let sysadm_t use runcon to run the test programs in various domains.
 	#allow sysadm_t self:process setexec;
 	#selinux_get_fs_mount(sysadm_t)
-- 
2.37.1


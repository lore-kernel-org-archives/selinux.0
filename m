Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F332C388F9
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 16:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A65C20678
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 16:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BH/zzdme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgKKQXv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Nov 2020 11:23:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726466AbgKKQXv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Nov 2020 11:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605111829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cgKEmuuPB0ql5vuc05K8+EQUCJUZHiliSk1t1EWYMt8=;
        b=BH/zzdmeYQEkOud7hmX1mvcUw1koUuNEsKaJm4/VU4oLBczLoHWiCKxV+/A/e8SQTlSAS6
        EBR2zCvVRPy81YGxjiKDXxCzz9LrcgnfyEBrTEsmK298JwuuZncfWvW9Ta7hLQmPqrwkcG
        aVpPF4ed2IuTVQp8DuEsm0irIcwZAnM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-yOXCm-B1OHiYjjNsUo064Q-1; Wed, 11 Nov 2020 11:23:47 -0500
X-MC-Unique: yOXCm-B1OHiYjjNsUo064Q-1
Received: by mail-wr1-f69.google.com with SMTP id q15so767981wrw.8
        for <selinux@vger.kernel.org>; Wed, 11 Nov 2020 08:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cgKEmuuPB0ql5vuc05K8+EQUCJUZHiliSk1t1EWYMt8=;
        b=GzwaUOl25Y1mj+HMOPcwozX1Q2N6BjI1X4w/hClU2gP9bF8T2CF9hbIbTia8FgNRmA
         RZ+xQjSo8AsHqK1QFx2ewJBPng4XwUI1JgPw+excr8FUndbLvF6f9c+VEEDyGevHeJ+E
         LcFAxlcdqvzzxiafIpnsbvD0VP+lAuMf2RhD1FpUiVwJNGqdRIovKBfNgNB9wqWy3HLG
         agDN2ZViiegXEpJD2LjMbyr90n6LQqyqvVyQvIaFN1RT5oT0NlwMvYRLDmiiMfM3Ax/b
         5Qx2x2PIbbSJwc5VHoXrfCh2nwfXgzgNE3AjVY4yzr0SjXLEQeIeNMNT21rL3eMLewLc
         I2wA==
X-Gm-Message-State: AOAM530OxHB1woPNXBdUa+Kkc25QB5rMHLjkk/QMrOM+/BluYKvsKRhv
        HRuHwY+yz6C8fjQvcc2rDoAA32tRzINlu1ailoMNMjwVngJ3cm/RhasPOCrIuyRyGSt7bOxupAK
        2GF9nbzf/tLerwc2JtluUzRzBXq5zpwcZBudj0Qn5wbmPrxRxwwPWeqd6Nw0LIXG1TzDnKw==
X-Received: by 2002:a1c:8150:: with SMTP id c77mr5232914wmd.26.1605111826075;
        Wed, 11 Nov 2020 08:23:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdqrNcuaqhfSwuQgIGtj/RHxDrJsJbAq0+gDe6kLCMZBooy3EmWJjTjEjPkkVBmkbdLKF5KA==
X-Received: by 2002:a1c:8150:: with SMTP id c77mr5232885wmd.26.1605111825812;
        Wed, 11 Nov 2020 08:23:45 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id h81sm3152934wmf.44.2020.11.11.08.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:23:45 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH userspace v2 1/3] selinux(8): mark up SELINUX values
Date:   Wed, 11 Nov 2020 17:23:38 +0100
Message-Id: <20201111162340.527105-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111162340.527105-1-omosnace@redhat.com>
References: <20201111162340.527105-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Mark up the possible values of SELINUX (disabled, permissive, enforcing)
for better readability.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libselinux/man/man8/selinux.8 | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.8
index 31364271..2afe6d3d 100644
--- a/libselinux/man/man8/selinux.8
+++ b/libselinux/man/man8/selinux.8
@@ -19,18 +19,18 @@ enabled or disabled, and if enabled, whether SELinux operates in
 permissive mode or enforcing mode.  The
 .B SELINUX
 variable may be set to
-any one of disabled, permissive, or enforcing to select one of these
-options.  The disabled option completely disables the SELinux kernel
-and application code, leaving the system running without any SELinux
-protection.  The permissive option enables the SELinux code, but
-causes it to operate in a mode where accesses that would be denied by
-policy are permitted but audited.  The enforcing option enables the
-SELinux code and causes it to enforce access denials as well as
-auditing them.  Permissive mode may yield a different set of denials
-than enforcing mode, both because enforcing mode will prevent an
-operation from proceeding past the first denial and because some
-application code will fall back to a less privileged mode of operation
-if denied access.
+any one of \fIdisabled\fR, \fIpermissive\fR, or \fIenforcing\fR to
+select one of these options.  The \fIdisabled\fR option completely
+disables the SELinux kernel and application code, leaving the system
+running without any SELinux protection.  The \fIpermissive\fR option
+enables the SELinux code, but causes it to operate in a mode where
+accesses that would be denied by policy are permitted but audited.  The
+\fIenforcing\fR option enables the SELinux code and causes it to enforce
+access denials as well as auditing them.  \fIpermissive\fR mode may
+yield a different set of denials than enforcing mode, both because
+enforcing mode will prevent an operation from proceeding past the first
+denial and because some application code will fall back to a less
+privileged mode of operation if denied access.
 
 The
 .I /etc/selinux/config
-- 
2.26.2


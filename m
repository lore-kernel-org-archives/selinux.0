Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A42C5517A
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 16:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC1CA20678
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 16:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqAde7Km"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgKKQXw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Nov 2020 11:23:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34787 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727297AbgKKQXv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Nov 2020 11:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605111830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=slIZxXgTACldZTfkDuw8CyOH6FjxKWP/pS1II7xE2Ho=;
        b=TqAde7KmzuBP9SNHQ7nvWNbMdiV5zKJf6l6rUVePWDOX0M0jog0YH1wsUSYnehcqSXTQco
        St+WVWMlrXTZOG9JzOnq/wJYIZmrWTSYN+WVhohhnnaoFWvrw9vCMbjQiWJ928ez+xtfMc
        lDfRRCNmTN6mYEc5GPlOEqQngD9ymJ8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-XLNCYVTWPxSGmjzKXnly1g-1; Wed, 11 Nov 2020 11:23:49 -0500
X-MC-Unique: XLNCYVTWPxSGmjzKXnly1g-1
Received: by mail-wr1-f70.google.com with SMTP id f4so768807wru.21
        for <selinux@vger.kernel.org>; Wed, 11 Nov 2020 08:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=slIZxXgTACldZTfkDuw8CyOH6FjxKWP/pS1II7xE2Ho=;
        b=W8QPACh7soye9Vvkqc2VoUv0tGdniQYhwtVaRjGptLc6u7YshHvv+M8+qxxQXhQiko
         Xe0O19Em/nhItLOek6n5BzcMYN7RAed5GxB0RQ1Npdr5TzuSSdfPm5dmJnR4rUerCXxq
         KWip7hGpwVOpAVZH1nbF/mV+TDuSfuoBQ++OINid+n01wkjV0mPtiX+bvhxqioeifAAZ
         fJtUoJPeFtjfMPJBAQdyScEaV4et0jAxFALi0sekY6hZRf4Qux5HXGRXYz8hZoIxGH2Y
         Ge+Ne3eCxsh7/OqVhO4vJy0w1Xz4DhG9iU592jGDZhrk1JzA/hp76pS91u+n0MW+A3eR
         lCcA==
X-Gm-Message-State: AOAM531i+nxVzjFd+KS3yY+M5cVRHRFiZ9UOKteijFws9KPBEmR5qaph
        ZHgPHXP7ViG+n6hr8zbZJStNA3TBg/GnJokxgljWwNbEQngcEwezj1iEz1Yuba097lICRmm+Fva
        6FH6VRy+T5h79cuIH0oeHrFNP2sNDYx44DRnCFKFzdfDqcsLOHxVXMv/+ps61an4SaA6Hew==
X-Received: by 2002:a5d:5450:: with SMTP id w16mr4935466wrv.425.1605111827472;
        Wed, 11 Nov 2020 08:23:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpVQLNPzxbMErJHPmJJYDcKUU3F2zvumwlIzVrXI8/Pkvru1vAT6C4MTHQnudcDF7yrleHzg==
X-Received: by 2002:a5d:5450:: with SMTP id w16mr4935449wrv.425.1605111827250;
        Wed, 11 Nov 2020 08:23:47 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id h81sm3152934wmf.44.2020.11.11.08.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:23:46 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH userspace v2 2/3] selinux(8): explain that runtime disable is deprecated
Date:   Wed, 11 Nov 2020 17:23:39 +0100
Message-Id: <20201111162340.527105-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111162340.527105-1-omosnace@redhat.com>
References: <20201111162340.527105-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Update the main SELinux manpage to explain that runtime disable (i.e.
disabling SELinux using SELINUX=Disabled) is deprecated and recommend
disabling SELinux only via the kernel boot parameter.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libselinux/man/man8/selinux.8 | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.8
index 2afe6d3d..0ef01460 100644
--- a/libselinux/man/man8/selinux.8
+++ b/libselinux/man/man8/selinux.8
@@ -20,8 +20,8 @@ permissive mode or enforcing mode.  The
 .B SELINUX
 variable may be set to
 any one of \fIdisabled\fR, \fIpermissive\fR, or \fIenforcing\fR to
-select one of these options.  The \fIdisabled\fR option completely
-disables the SELinux kernel and application code, leaving the system
+select one of these options.  The \fIdisabled\fR disables most of the
+SELinux kernel and application code, leaving the system
 running without any SELinux protection.  The \fIpermissive\fR option
 enables the SELinux code, but causes it to operate in a mode where
 accesses that would be denied by policy are permitted but audited.  The
@@ -32,6 +32,24 @@ enforcing mode will prevent an operation from proceeding past the first
 denial and because some application code will fall back to a less
 privileged mode of operation if denied access.
 
+.B NOTE:
+Disabling SELinux by setting
+.B SELINUX=disabled
+in
+.I /etc/selinux/config
+is deprecated and depending on kernel version and configuration it might
+not lead to SELinux being completely disabled.  Specifically, the
+SELinux hooks will still be executed internally, but the SELinux policy
+will not be loaded and no operation will be denied.  In such state, the
+system will act as if SELinux was disabled, although some operations
+might behave slightly differently.  To properly disable SELinux, it is
+recommended to use the
+.B selinux=0
+kernel boot option instead.  In that case SELinux will be disabled
+regardless of what is set in the
+.I /etc/selinux/config
+file.
+
 The
 .I /etc/selinux/config
 configuration file also controls what policy
-- 
2.26.2


Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA85C388F9
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 16:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 282D220678
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 16:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glCdOIRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgKKQXy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Nov 2020 11:23:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726516AbgKKQXy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Nov 2020 11:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605111833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IEyab9M4LqGgMRrLCGW7jXmPcduqQzF4P3La2WmLZS8=;
        b=glCdOIRJdRrqqAts0IG0vVWt3i1X4Mcinp9q5ViBxIHSBTbKcjNpuASHG+5e7Bhh6ODl6U
        klY49z7US2fmfluyfmBW6LjFxH+aHM2BXYm6j5PULS0QaAMJpsmE6CSD+VnnIsc7gya7/Y
        e09TXtaJdfI6SZqZNO3HA0es1h9fKlo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-Gg936fs4MjCdRQraU81YTA-1; Wed, 11 Nov 2020 11:23:50 -0500
X-MC-Unique: Gg936fs4MjCdRQraU81YTA-1
Received: by mail-wm1-f69.google.com with SMTP id y26so950034wmj.7
        for <selinux@vger.kernel.org>; Wed, 11 Nov 2020 08:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IEyab9M4LqGgMRrLCGW7jXmPcduqQzF4P3La2WmLZS8=;
        b=j8mhKunQ/KRzIxwI16qhZeL6P1h4d8/YRilb6cv2kFJZ4lek/0e67+c5+zi/Zq8Wql
         Qd2lEVnOWhrPfUSzCUp7NhVoFtMbc8thjt5V0jxRJ3uljCcXQu/rM0ayjHXh1GQiBV3q
         kqjcRabzt/R+f5lVMRardY8OurpC1gfrkgldHNxF2IUAZYVcekkwSUln4DJl+n3tHFbB
         zOGt3/AOvNvGNTCnXjRU7jS2k8XeLDJSSAtbnZZBatsqgi6apTYsgoBfso3HaxPqop+O
         oKRNNUqlCgupYChybG63mEJmRgq1iKRu1iRkDNomkJkKtlwGEBamEdaCPRM/kjAZZb9c
         tXZw==
X-Gm-Message-State: AOAM532nJDOX4zL39JPB9qYEpzHz/Zsff3vmzH19IW01ZXGNJwz0JgMs
        CLhFAjsiYIIO6pHhgsxy5wFc1S/Q825kn2x8TXvaipHEdh61XBvXpcsZNyfY8wib3ISk5ZiXJXs
        D3HXzA6el17hLkZUxfevDeheMcS8tYUs1MhBdbh/DQG0FRsWLrWfeeBKuGxfT/EOt65K9WQ==
X-Received: by 2002:a5d:670f:: with SMTP id o15mr14322689wru.204.1605111828833;
        Wed, 11 Nov 2020 08:23:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOUmqbcXYyvMqp1BjS8/vqXMlSdf7cTwdV9sRq/LfxTUKOtLF4952BQQSQJMEbfPmWsL/dxQ==
X-Received: by 2002:a5d:670f:: with SMTP id o15mr14322656wru.204.1605111828538;
        Wed, 11 Nov 2020 08:23:48 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id h81sm3152934wmf.44.2020.11.11.08.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:23:47 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH userspace v2 3/3] selinux_config(5): add a note that runtime disable is deprecated
Date:   Wed, 11 Nov 2020 17:23:40 +0100
Message-Id: <20201111162340.527105-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111162340.527105-1-omosnace@redhat.com>
References: <20201111162340.527105-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

...and refer to selinux(8), which explains it further.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policycoreutils/man/man5/selinux_config.5 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/man/man5/selinux_config.5 b/policycoreutils/man/man5/selinux_config.5
index 1ffade15..8d56a559 100644
--- a/policycoreutils/man/man5/selinux_config.5
+++ b/policycoreutils/man/man5/selinux_config.5
@@ -48,7 +48,7 @@ SELinux security policy is enforced.
 .IP \fIpermissive\fR 4
 SELinux security policy is not enforced but logs the warnings (i.e. the action is allowed to proceed).
 .IP \fIdisabled\fR
-SELinux is disabled and no policy is loaded.
+No SELinux policy is loaded.  This option was used to disable SELinux completely, which is now deprected.  Use the \fBselinux=0\fR kernel boot option instead (see \fBselinux\fR(8)).
 .RE
 .sp
 The entry can be determined using the \fBsestatus\fR(8) command or \fBselinux_getenforcemode\fR(3).
-- 
2.26.2


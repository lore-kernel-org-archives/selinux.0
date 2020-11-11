Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF80C388F9
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 09:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C924A20729
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 09:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBrwEueb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgKKJvp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Nov 2020 04:51:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726460AbgKKJvl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Nov 2020 04:51:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605088300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Yb53kgbwR3vf2d2kG/xMMzBjo8B8CKS3dYYLnjBaII0=;
        b=cBrwEuebTl8L7vuk0yTraeO4huA3c+Rl9RErN+S1Y8eatxjTxYzIJuh9gBR3qIrkYAfw2X
        7W3cZdmNtdtP0h24xxHmlRKxM/k7utOhYr5Np9vraKzVNPUujQj/iNhhSlV2ij3qc6i3i/
        vIjYrEeLfRIJSQT3rs1uFWi8+EU69ac=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-eWYI_OVxNL-_AGb9SDXQuA-1; Wed, 11 Nov 2020 04:51:38 -0500
X-MC-Unique: eWYI_OVxNL-_AGb9SDXQuA-1
Received: by mail-wr1-f71.google.com with SMTP id y2so417898wrl.3
        for <selinux@vger.kernel.org>; Wed, 11 Nov 2020 01:51:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yb53kgbwR3vf2d2kG/xMMzBjo8B8CKS3dYYLnjBaII0=;
        b=RVhTKO1RPpTHCB+C0fmnBUCBZ0KYzW/Uz1/625cOBgFww0J0qS3EZYYPCN4mTFcHlN
         f/xIU2eBLy3/Zd3t6tkRK+VzGu6WOF2V8eiAI8ZCrJ/HjsdH4i9yhzM7eXQ432GwXBml
         eb2BzPnmpZQl0bLLPG0fLwPLFLBsYvPx6PVyGXRJjXGSItdihVpZlEKinChHumYxXltv
         F2lBLRA6pMh2QXWMzAmeUdPyuxsph8D67aSboTsuON9ApmIW8tVQqySlLS6vUPcI7KW0
         uA8xdzGhc120ePNeE2U9WVZaX7jd7wylrvpdvNHOpPLnYx/dSiFAHu9eZXYY+WF63UO7
         +RyA==
X-Gm-Message-State: AOAM5334Xwk6vDjwrg2cjXF3qXL9Su0+pTiIza/6jtRVf/6/Vr2MA+ef
        FtUlR2t5Ntb78SGaQils/Xlcuh2SN0L192Ezg2aJpmNsSUKDf+xN5iKYDA3sgrOx/dq2Ynlrdoy
        xB4myyUyaLElRqoHk+kIN/DQdNZv3Z/H+1klqLbm/fZo/RWimM7UFiMyUqexTLpht4DGBRA==
X-Received: by 2002:a1c:658b:: with SMTP id z133mr2958282wmb.1.1605088297086;
        Wed, 11 Nov 2020 01:51:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzO3gPNIS5+//sU3+97per0Ww4uGOHsIVqCixGT/E5Lu/wx3KoGENT9z9Iv07Rm9BpE4Dv81w==
X-Received: by 2002:a1c:658b:: with SMTP id z133mr2958255wmb.1.1605088296851;
        Wed, 11 Nov 2020 01:51:36 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id i16sm1885830wru.92.2020.11.11.01.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 01:51:36 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH userspace] selinux(8): explain that runtime disable is deprecated
Date:   Wed, 11 Nov 2020 10:51:34 +0100
Message-Id: <20201111095134.481658-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
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
 libselinux/man/man8/selinux.8 | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.8
index 31364271..721a65f4 100644
--- a/libselinux/man/man8/selinux.8
+++ b/libselinux/man/man8/selinux.8
@@ -19,12 +19,12 @@ enabled or disabled, and if enabled, whether SELinux operates in
 permissive mode or enforcing mode.  The
 .B SELINUX
 variable may be set to
-any one of disabled, permissive, or enforcing to select one of these
-options.  The disabled option completely disables the SELinux kernel
+any one of Disabled, Permissive, or Enforcing to select one of these
+options.  The Disabled option completely disables the SELinux kernel
 and application code, leaving the system running without any SELinux
-protection.  The permissive option enables the SELinux code, but
+protection.  The Permissive option enables the SELinux code, but
 causes it to operate in a mode where accesses that would be denied by
-policy are permitted but audited.  The enforcing option enables the
+policy are permitted but audited.  The Enforcing option enables the
 SELinux code and causes it to enforce access denials as well as
 auditing them.  Permissive mode may yield a different set of denials
 than enforcing mode, both because enforcing mode will prevent an
@@ -32,6 +32,24 @@ operation from proceeding past the first denial and because some
 application code will fall back to a less privileged mode of operation
 if denied access.
 
+.B NOTE:
+Disabling SELinux by setting
+.B SELINUX=Disabled
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


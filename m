Return-Path: <SRS0=eE8G=QC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41999C282C7
	for <selinux@archiver.kernel.org>; Sat, 26 Jan 2019 10:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14412217D7
	for <selinux@archiver.kernel.org>; Sat, 26 Jan 2019 10:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfAZKS3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:18:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37562 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZKS3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 26 Jan 2019 05:18:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so12760589wrt.4
        for <selinux@vger.kernel.org>; Sat, 26 Jan 2019 02:18:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4YPoTVRK9MGXOmeP/FF5r2L1jeM1K+FYk0FO+PkMpZA=;
        b=tUL43FPeeYGPSqw3vfokwLecBOsY9Qh94lWektq3aHnACnp+8yfmScMFD2dZPvA0Cy
         uUxCEbFPLHimHwwRNrzl2T+BOWbg3KduXu9SQBMvJcfoiMj6QIOyjrly9AAQm280AFeW
         UqFl/fm2hy2WXaednr1lABTirEIxozc1Sx/Uxc2uCMsbQkVZrtwKUgUt62UeorIlbIbc
         9K0KxTmMS9y/mM0Nqahwx76ioclXNh4oWKO7JuP1GwrRWmcbhGHxbwoBEheKHOHruldH
         bYVnHrbYJx0LoL+wQxfVRxqj+dWFn9wqe1GVPIcOYJTJmKzkAE8xpWotRCvu1Yh3dXg0
         hWBw==
X-Gm-Message-State: AJcUukfIcuKAl0lhRPX2bots4IDrw/fb/thLnLIzaA9VQBJjQ1hCDOqJ
        fHSYrGAwrUa56kk36Fyle5Jpb+8wIaw=
X-Google-Smtp-Source: ALg8bN5dBLocyTA8gDJsfrV+r0eYdD06pjq5NYXaDF8G3ZF88v1dNTnQh8BgnN5EAGCVdmpAPBtiLA==
X-Received: by 2002:adf:e247:: with SMTP id n7mr13969559wri.205.1548497907397;
        Sat, 26 Jan 2019 02:18:27 -0800 (PST)
Received: from p1772.fit.wifi.vutbr.cz ([147.229.117.36])
        by smtp.gmail.com with ESMTPSA id m6sm84102826wrv.24.2019.01.26.02.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 02:18:26 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH] selinux: replace BUG_ONs with WARN_ONs in avc.c
Date:   Sat, 26 Jan 2019 11:18:16 +0100
Message-Id: <20190126101816.1065-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These checks are only guarding against programming errors that could
silently grant too many permissions. These cases are better handled with
WARN_ON(), since it doesn't really help much to crash the machine in
this case.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/avc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 3a27418b20d7..84f108f4100a 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1059,7 +1059,7 @@ int avc_has_extended_perms(struct selinux_state *state,
 	int rc = 0, rc2;
 
 	xp_node = &local_xp_node;
-	BUG_ON(!requested);
+	WARN_ON(!requested);
 
 	rcu_read_lock();
 
@@ -1149,7 +1149,7 @@ inline int avc_has_perm_noaudit(struct selinux_state *state,
 	int rc = 0;
 	u32 denied;
 
-	BUG_ON(!requested);
+	WARN_ON(!requested);
 
 	rcu_read_lock();
 
-- 
2.20.1


Return-Path: <SRS0=nwiU=QE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF07C282C8
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 15:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6F02171F
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 15:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfA1Pnk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:43:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36593 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1Pnk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Jan 2019 10:43:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so14393044wmc.1
        for <selinux@vger.kernel.org>; Mon, 28 Jan 2019 07:43:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VISNA4/yw5xezDd1Bo3JE2Ozv3H2BazzeN1dR2/XcDs=;
        b=TtfXaW/xenyiAexL/yc0na09vAeUnzLB18boMJbhzvqkKvGmQa443kC9ky+erAGDs0
         3DKNy8igQhOtLTdUgexv8ILwHomBVGADqRgfYEKxjr6hg9J/iGOJTamtgLU6Q/NqU7/r
         /PEcocYdRkmTOSnLBNxleIHyhLw2q7LJThGRw6859xwmHgMubv0TiHocRkh+lc+kYL+A
         GynmitbvZpVugDx8Hbgw9RupLx2FzRUFpQcwoSdgTpad+xxvKzuIzAUbwsQNRnbgyyWl
         MfLDhdIE1Yyo9BypZKu9XGuVe4NnTBjjq+DmkRg5fBtcm9G0FVVInm4NNYLiHeq+2acm
         QZew==
X-Gm-Message-State: AJcUukdATGW0Ry2gLrCM7AIshWr2xQxcAS1Fl7Yt8qyt4ysRApdcLWCT
        nl0+PE/i59OCO+M0Z9L4z4pn1BCDDeg=
X-Google-Smtp-Source: ALg8bN7ak0Ln7TzKzuDXlI5eO1/9m5tljR0bTry7Qc20lvldJ6pm+1MsZf2RBJcEln3b/WLHFvPcGA==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr2252471wmg.22.1548690217728;
        Mon, 28 Jan 2019 07:43:37 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h17sm110580127wrt.59.2019.01.28.07.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 07:43:36 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v2] selinux: replace BUG_ONs with WARN_ONs in avc.c
Date:   Mon, 28 Jan 2019 16:43:33 +0100
Message-Id: <20190128154333.31279-1-omosnace@redhat.com>
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
 security/selinux/avc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 3a27418b20d7..33863298a9b5 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1059,7 +1059,8 @@ int avc_has_extended_perms(struct selinux_state *state,
 	int rc = 0, rc2;
 
 	xp_node = &local_xp_node;
-	BUG_ON(!requested);
+	if (WARN_ON(!requested))
+		return -EACCES;
 
 	rcu_read_lock();
 
@@ -1149,7 +1150,8 @@ inline int avc_has_perm_noaudit(struct selinux_state *state,
 	int rc = 0;
 	u32 denied;
 
-	BUG_ON(!requested);
+	if (WARN_ON(!requested))
+		return -EACCES;
 
 	rcu_read_lock();
 
-- 
2.20.1


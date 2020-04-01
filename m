Return-Path: <SRS0=rNkQ=5R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7D1C2D0F0
	for <selinux@archiver.kernel.org>; Wed,  1 Apr 2020 18:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA932071A
	for <selinux@archiver.kernel.org>; Wed,  1 Apr 2020 18:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1YewECH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732884AbgDASJe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:09:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38152 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732858AbgDASJe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Apr 2020 14:09:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id c21so373673pfo.5;
        Wed, 01 Apr 2020 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aFkKkSs4X78D7DIjsX2xwto/fxITviwaQWPXzTmSQc0=;
        b=R1YewECHjkBBwFvVHBdk82P3ylnopPts/H5FJgrAzWEKZ8gYVGG0uWiIAvwQNWUzRs
         BR9bN0sbIdpv+MdeHDsIKCfup5IYzxNG2rkCBvVXz2dTgJfB8E8ewdMcA0jfe64GbnSS
         lCw41EGH7clEMUR+Lk2olVQVxgTtLmtZzQeLuvMw8ad3eq2T0iKuH5LKmGrsj2gw4Qaq
         BrLsIn8aTJ47DW/uSy+D2P6BPXO5dtf7vs4DBAcuzsWGxY5cGDd8Eo2aJcTiAPyUI/5K
         nvtAo5zlD+PgUBhkbNDXb4WPC3+AE05UqApx/G9ufIFMPy4b1HSafVByAi0YNzIiGELT
         byvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=aFkKkSs4X78D7DIjsX2xwto/fxITviwaQWPXzTmSQc0=;
        b=K/8yuXZ3i04mdPjrm6OZ0fQ5k5MXbjsldbpvQbZp0C0pJjhNVBHi/oJaoy4gMNrKz7
         2v7qJAIqttOX8+YSaQpQbvlsoqTdwv6hmIujU9nT/DQZh3qZWUatSFGbOV/Q2oLhruhW
         q6YT9qU6Z9DgRd4FFksdgZUMU2r9ps54W8tdlolz1u3ZRX52nfgI9z0mIBnRR3WmXEyw
         A4owryxI/YwsmJQX9Mm8Ud8nqt/2CstoPhZKc2lHG+I1UyudS39ST3yfrxLq9GV+rKVE
         d3PssYlcVd3KMkLrp0eG40OswThiWKQ2eozH3gCXGH+dkcBW2965AU/YAGbsv5U1RN7z
         11vA==
X-Gm-Message-State: ANhLgQ1zZgn+PTrBCxuTbmeNgCHPCQcqMuYxX+vRWXMIYVd2WdjE4BdJ
        6s+hMDGT14E0ieBbWHsAPiPJk+SB
X-Google-Smtp-Source: ADFU+vsTiwoI45Y8zlr7gMPmxetFDNyUKlypNX7WAFiNXdj3Zm53jvGnsIJvRMZ8TRJ8CcUhCwWjWw==
X-Received: by 2002:a62:de83:: with SMTP id h125mr23999351pfg.161.1585764573401;
        Wed, 01 Apr 2020 11:09:33 -0700 (PDT)
Received: from sultan-box.localdomain (static-198-54-129-52.cust.tzulo.com. [198.54.129.52])
        by smtp.gmail.com with ESMTPSA id mq18sm2290143pjb.6.2020.04.01.11.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 11:09:32 -0700 (PDT)
From:   Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: Fix all those pesky denials breaking my computer
Date:   Wed,  1 Apr 2020 11:09:19 -0700
Message-Id: <20200401180920.4655-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Sultan Alsawaf <sultan@kerneltoast.com>

I'm sure many of you have found yourself in a position where you've
tried to increase the security of your system by enabling SELinux, only
to discover that nothing worked anymore because of those darned 'denial'
messages. It's clearly an overlooked bug in SELinux!

With a bit of investigation, I discovered that the avc_denied() function
would erroneously return a non-zero value when I saw those denial
messages. After slapping in a `return 0;` at the top of that function,
all was well and my machine with SELinux enforcing was working again!

Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
 security/selinux/avc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index d18cb32a242a..b29f19471871 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1010,6 +1010,7 @@ static noinline int avc_denied(struct selinux_state *state,
 			       u8 driver, u8 xperm, unsigned int flags,
 			       struct av_decision *avd)
 {
+	return 0;
 	if (flags & AVC_STRICT)
 		return -EACCES;
 
-- 
2.26.0


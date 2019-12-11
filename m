Return-Path: <SRS0=W72o=2B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A16C43603
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 13:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663DC214AF
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 13:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDNfxiSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfLKNcJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:32:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56116 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfLKNcI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Dec 2019 08:32:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so7086328wmj.5
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2019 05:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C4uUoHNh392R4pRRzAf3E2+qkrnPf0LjzBy28PzVz+c=;
        b=PDNfxiSHkUsb/hU8BbW9X9uiExFT8Q3AD55rwJgj/tMxyEqcwNHZKBScmPHuf4pn5x
         ZtI5SOBq5UFNH5/8Nxba1XJZ5m/QE1ZCpsko02M3600S+flx+bPXAet5cMyk/cGoQhSE
         Dmq7MPhterEaz9iiRl69bMZ3yKOTwck9s3LJOgSG/Ht/TI7RQbacqhGSGy5YkIOZyyRS
         5TPZoj8Ha4hxweT5MD6ClYUPYzt34aCkUooQVJK2wizWhNES+SZ9QZDvZjLwmZCYzURn
         pV8pKqIfvMNpNYCFJlD8fjLxq/v8uzQDqadLlPtgnFHyuB9v5J5Lq5i1+D9+QkxUTZjS
         0PVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C4uUoHNh392R4pRRzAf3E2+qkrnPf0LjzBy28PzVz+c=;
        b=I5CWrsFe+TcYEi7GAl11oYwOiI60yJxbJ/1x504aP8AdUce5Pni1cW4VozluZuG/2P
         glFr8ARQQhMJkGnBhd30QoqfQ0cA1Rop0Yc6iIN3T5VyZX9SE5Q4qajxlU68Hcl5Dp/r
         Qrn0u29Cv08pPN2LyqDUAUduQI4loRdZD/7HEBvOPzkQhnMVIGOUP7cIm3iGDIh6NkKo
         zyIWwcpxaMXT9iwzkLOUT75S+po9RpZdDTt2Bo7paOFogPaquLkrycK+fiDwyjFr1c1i
         cxaEiNdzaGFYcluoWokJH6VkvVj/7K7sJnmF9RKxytCNeK7j48zH8FlAVmG5SpKORs8l
         a8Dg==
X-Gm-Message-State: APjAAAUWdGJ6nD2iet/WY8uPhhwhEryEF87j09YST6J8DXVg/sjFnaAu
        lp+IqjL6AyT/UpaqzQQ7gQ7P8cxg
X-Google-Smtp-Source: APXvYqwz/Wb+uKMrOptz9+q3xKgxfxPo8p9kdHt/Gu3eU6GcpZ1ge6phibKVqmLZ35D/KK2sUlyMrw==
X-Received: by 2002:a1c:1bc3:: with SMTP id b186mr3707525wmb.79.1576071126389;
        Wed, 11 Dec 2019 05:32:06 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id q3sm2234609wmj.38.2019.12.11.05.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 05:32:05 -0800 (PST)
From:   Dominick Grift <dac.override@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dac.override@gmail.com>
Subject: [PATCH] mcstrans: start early and stop late
Date:   Wed, 11 Dec 2019 14:32:01 +0100
Message-Id: <20191211133201.2353261-1-dac.override@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It stopped too early, exposing a bug in sudo selinux_restore_tty():

SELINUX_ERR op=setxattr invalid_context="wheel.id:wheel.role:users.terminals.pty.pty_file:SystemLow"
avc:  denied  { mac_admin } for  pid=859 comm="sudo" capability=33 scontext=wheel.id:wheel.role:sudo.wheel.subj:s0 tcontext=wheel.id:wheel.role:sudo.wheel.subj:s0 tclass=capability2 permissive=0

If we want to be able to reference human readable contexts in SELinuxContext= and nspawn -Z and -L then we need mcstrans ASAP

Signed-off-by: Dominick Grift <dac.override@gmail.com>
---
 mcstrans/src/mcstrans.service | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mcstrans/src/mcstrans.service b/mcstrans/src/mcstrans.service
index 09529432..08a41585 100644
--- a/mcstrans/src/mcstrans.service
+++ b/mcstrans/src/mcstrans.service
@@ -2,6 +2,8 @@
 Description=Translates SELinux MCS/MLS labels to human readable form
 Documentation=man:mcstransd(8)
 ConditionSecurity=selinux
+DefaultDependencies=no
+Before=sysinit.target
 
 [Service]
 ExecStart=/sbin/mcstransd -f
-- 
2.24.0


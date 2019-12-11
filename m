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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F9DC43603
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 13:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1C320836
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 13:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHDsPoLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfLKNob (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:44:31 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:42817 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfLKNob (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Dec 2019 08:44:31 -0500
Received: by mail-wr1-f45.google.com with SMTP id q6so2602177wro.9
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2019 05:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K0Wo30231p8BmKhQj9U3S4TRb0Qep46ALPoRYddtVPY=;
        b=oHDsPoLGKiMA/3QWs4m12wEHx2wxEofUug1mnF2SbUsRrzXtGkcdpU9UPOSouWYozc
         CAn5oDPtd30PenUjBoZw6b0z/wppxnDfpkiZXeHFordI/qleFz9KwttRNMGLsZ1iDqvW
         lPTpxINAUiWGMGjVwyQsE2uQD6iTaqtxUj1hb8Cnf2z+zMqCKt/4SPHYlfHgj6ALxeWb
         E8BMdxeiTYQ/H6SBg2W6gEnhSqZ7kVfoxcTm1r2S00NvqxzwcrP47TDI3bsVO9JTe6IB
         etlWkNXdZbhXh/ARMC1PjVC6jt5PkQe8s9NMZlG13vU7A1Ywr+mr3GMzH2qRmNbif6gX
         GskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K0Wo30231p8BmKhQj9U3S4TRb0Qep46ALPoRYddtVPY=;
        b=eJtnkXsWu8EzUhZ7s0rcU5WdmLUtHW15t58R9QFRY0qzfhk6FABbA1/XqwQjVvAepY
         U7Dmn9cDTY0NrBn8Ado+Ordeaug+/dmg3hq3gpoIMaDMRwSIBHPtW8L7TV3ECKPO9UB3
         a6kdf+pYn8oMjGWwSikiNFtnRxojddLN/+eBE4yYCwoushixOWDZ8XBSw8TEhO7v9aDA
         8BKb5qIOQbW1/rT/MlIjulKJt5QgameHpARUbfyaFZ0zKSa/HnX/SOWFSAUJE4CofIyk
         Dz13cKCkc45+XzCct5fkRpmuGS9F4wWVmMuyQJkFevAW1XQ2tg8rldFixtyGup5JEUgc
         BWsQ==
X-Gm-Message-State: APjAAAUv1K1Q93dFwE5fSOAcG4kvXXIiKBz1M/OV0CltgBAoBcLKcH4m
        5NX12WGlrZirUMG8ipThgoh30prl
X-Google-Smtp-Source: APXvYqyBxE3eWDZ357y2MmxpG4lUEMWnubJ/uTHI3AIzZ64yHsiWAwr3QI89+fuOGBxyQLIlaKkqgw==
X-Received: by 2002:adf:c145:: with SMTP id w5mr3964016wre.205.1576071869102;
        Wed, 11 Dec 2019 05:44:29 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id w13sm2454317wru.38.2019.12.11.05.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 05:44:28 -0800 (PST)
From:   Dominick Grift <dac.override@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dac.override@gmail.com>
Subject: [PATCH v2] mcstrans: start early and stop late
Date:   Wed, 11 Dec 2019 14:44:23 +0100
Message-Id: <20191211134423.2357254-1-dac.override@gmail.com>
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

v2: stop late, but do stop
Signed-off-by: Dominick Grift <dac.override@gmail.com>
---
 mcstrans/src/mcstrans.service | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mcstrans/src/mcstrans.service b/mcstrans/src/mcstrans.service
index 09529432..c13cd09a 100644
--- a/mcstrans/src/mcstrans.service
+++ b/mcstrans/src/mcstrans.service
@@ -2,6 +2,9 @@
 Description=Translates SELinux MCS/MLS labels to human readable form
 Documentation=man:mcstransd(8)
 ConditionSecurity=selinux
+DefaultDependencies=no
+Before=shutdown.target sysinit.target
+Conflicts=shutdown.target
 
 [Service]
 ExecStart=/sbin/mcstransd -f
-- 
2.24.0


Return-Path: <SRS0=HCsx=62=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AA6C54E4A
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 13:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1126206F5
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 13:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qI2lDUDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgELN4L (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 May 2020 09:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgELN4L (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 May 2020 09:56:11 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360EFC061A0C
        for <selinux@vger.kernel.org>; Tue, 12 May 2020 06:56:11 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f83so13568014qke.13
        for <selinux@vger.kernel.org>; Tue, 12 May 2020 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=edYMiWMc0u5l8AQTWz1F2oo9QZXNC3luxzw5hYasO9c=;
        b=qI2lDUDxA5Wot6ak+k5IImZJYRo71TUVAPQGb8/u/bBB5PrNl/qLWr4lrFO8YLF+GT
         SrMoSQqUJXnwMdyLt+Qtl1bOe3jOLucA5Hg3ANr9KFDc62MxT5OwNdU/M/rf4YyVLtmi
         iqOyngTjjoSaxgY0i2ju7nIlWoJS/Tn/0Qd4WyNRmP+1gSCrBbX7YK+54IEKfXdhT1tS
         31VzlVuDR3KlRKuLwgRrDahefAilDOb+So7N70saG0LkW5bPPp5NpL5ATP8YPNKL64Uv
         Ii9i3hVmQptty07lK8TXSPBzo7J6SfOfne2fWASRUwDYHQKJW7VomnIJEDnwquiRFvfG
         La5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=edYMiWMc0u5l8AQTWz1F2oo9QZXNC3luxzw5hYasO9c=;
        b=Xk55tjU5d3hTx1EBba3sHNfqBzZ1lbfM725q31WALp39PlkO+q+o+apy1lUNcbt20C
         LKLgdBGkhq1H9Zajb8rIjNEgb5w3QyprXwoZh2b1KCGukKbm/9HtnQhoVrLI3oN3vcJM
         wAHBH+jz2l2zQ+P2HYESpRIlyuia6Uguocv5qW1xoQeYpC4S2j1HaCaobr1h9u4Vqebb
         9xl+CZKcUH0ob03FBoSn+UAyj7c3XpcAVqkqDf9r7hAllSLE9LBATDM1YmCT4mmZHMcf
         n1x2bjVwXKqlTmt9jrz+kUi7V5pRsTqfDSgShtGvINtjqKT6HNVSBUGodCSNov9twQrP
         zh4g==
X-Gm-Message-State: AGi0PuaMuyMdK4LC70dQ0KqM2zeHlvfVwFtkPqgw81l3RjC2PKwtyo/z
        UkEWUzFggo1mRcAwAaxHCYbn48MS
X-Google-Smtp-Source: APiQypKZqR0meLkr14tZvdMh8QYw6aNHVd8CVaqV2dpwffHxI30saWvcXbcer/xBHPtwd+/5MAjHpQ==
X-Received: by 2002:a37:c8b:: with SMTP id 133mr20454288qkm.418.1589291770303;
        Tue, 12 May 2020 06:56:10 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id p31sm12752507qtf.11.2020.05.12.06.56.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 06:56:09 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 testsuite 07/15] test_policy.if: use term_use_all_ptys() instead of unconfined_devpts_t
Date:   Tue, 12 May 2020 09:56:02 -0400
Message-Id: <20200512135602.32110-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

refpolicy does not define an unconfined_devpts_t type instead
assigning user_devpts_t to unconfined ptys. Switch to using
the refpolicy term_use_all_ptys() interface in the test policy
to provide compatibility across both refpolicy and Fedora.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v5 switches from direct use of ptynode to term_use_all_ptys().

 policy/test_policy.if | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/policy/test_policy.if b/policy/test_policy.if
index cefc8fb..e3c01c8 100644
--- a/policy/test_policy.if
+++ b/policy/test_policy.if
@@ -29,7 +29,6 @@
 interface(`unconfined_runs_test',`
 	gen_require(`
 		type unconfined_t;
-               type unconfined_devpts_t;
 		role unconfined_r;
 	')
 
@@ -38,7 +37,7 @@ interface(`unconfined_runs_test',`
 	role unconfined_r types $1;
       # Report back from the test domain to the caller.
       allow $1 unconfined_t:fd use;
-      allow $1 unconfined_devpts_t:chr_file { read write ioctl getattr };
+      term_use_all_ptys($1)
       allow $1 unconfined_t:fifo_file { read write ioctl getattr };
       allow $1 unconfined_t:process { sigchld };
 
-- 
2.23.3


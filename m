Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C25FC48BE5
	for <selinux@archiver.kernel.org>; Sat, 12 Jun 2021 09:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A1BC611CC
	for <selinux@archiver.kernel.org>; Sat, 12 Jun 2021 09:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhFLJJr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 12 Jun 2021 05:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhFLJJq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 12 Jun 2021 05:09:46 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E3DC061574
        for <selinux@vger.kernel.org>; Sat, 12 Jun 2021 02:07:47 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bp38so12387451lfb.0
        for <selinux@vger.kernel.org>; Sat, 12 Jun 2021 02:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RQsDxX4sWSJ19LQdZpzLswwsUnaYxuQJU9i2a6N6FGc=;
        b=mwUs6XsVoDA4rN/oYB5vrWNzrBwta8XQZ+rWmp4HW6HigD6ncU2IbDPrYN7FK15pJr
         Rbb6tXjHxx0lwbyVPiHZqfeY8AFLrtddQSm6vaiQyTqrH1HNUKP3ub+090hH2WbGEw0/
         Zw03kM75U00Z6D9jMlgVlPookAXmp+TIGyyysSm8c9bW+H9kD+ZZV6OvaAJBBota1f+9
         SBQVN9px1etLHn5GXfW4V+v9BwIDrKZFsIAsKUYC/TkO5ROoe6kLcqfqFXl2X1rNBUtm
         /XkDL4PeXh/kHPLdrUgjkZ/yy2XMd9Lkn/g9HAiUsZ+x9W15fYLh0g8a1ybuL7S2QpFE
         qxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RQsDxX4sWSJ19LQdZpzLswwsUnaYxuQJU9i2a6N6FGc=;
        b=aAqwQcyLCaJNBMGgrZQGHElOmMz6FsbAaEFqX8kjbZwcGmNYB0/8weObo2+XcnVXm4
         1Be9VjrFSOyp8oR08Lzt2jVbjD3FV/uTcwioRJjzM5GfJsXCphXLiP1Na4JGtRSJmQ+8
         8ci2xPTfoY4qthqtVZL3PpEqL+B5MEcmbLlGgPzNpa7pHfU/qmkoE+igv9l3mc6cBxVo
         Q2RyK1H7UUzAHpzyzjSjY+0dAl3a2BRIQdT+qhQ8ATR/fTZ3ww0rl5ao7Zl5SwGxGnZs
         gz8dpQkHv1g+Ay3Llra+ZttKmk9wp2i1Af6sYIsFno7a7dwVDjsGjfm0rvKumqhtaF73
         L1Sg==
X-Gm-Message-State: AOAM531T+p4fUetuqpcXudICdBmjLnrDDTmbT5yeLoIm4FNRnA8CTbEC
        KP7svBjDIKvSNOTgohoBsp3cMtarrlw=
X-Google-Smtp-Source: ABdhPJxCkUCO7k5WXsocskv1C1NwujVU1as/8ooZZtjgvL7AF1QgAv8YSz1rhPcmItOYrfmjbPMcGg==
X-Received: by 2002:ac2:5d69:: with SMTP id h9mr5104333lft.603.1623488865361;
        Sat, 12 Jun 2021 02:07:45 -0700 (PDT)
Received: from localhost.localdomain (88-114-216-93.elisa-laajakaista.fi. [88.114.216.93])
        by smtp.gmail.com with ESMTPSA id n3sm1000973lji.65.2021.06.12.02.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 02:07:43 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH] selinux.8: document how mount flag nosuid affects SELinux
Date:   Sat, 12 Jun 2021 12:07:38 +0300
Message-Id: <20210612090738.22408-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Using mount flag `nosuid` also affects SELinux domain transitions but
this has not been documented well.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 libselinux/man/man8/selinux.8 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.8
index 0ef01460..5842150b 100644
--- a/libselinux/man/man8/selinux.8
+++ b/libselinux/man/man8/selinux.8
@@ -94,6 +94,13 @@ and reboot.
 also has this capability.  The
 .BR restorecon / fixfiles
 commands are also available for relabeling files.
+
+Please note that using mount flag
+.I nosuid
+also disables SELinux domain transitions, unless permission
+.I nosuid_transition
+is used in the policy to allow this, which in turn needs also policy capability
+.IR nnp_nosuid_transition .
 .
 .SH AUTHOR
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
-- 
2.30.2


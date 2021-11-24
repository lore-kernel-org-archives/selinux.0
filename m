Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A379C433EF
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 02:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhKXCnr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 21:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhKXCnr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 21:43:47 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CA1C061574
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 18:40:37 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id p23so1265941iod.7
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 18:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stl-sh.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CBVHOKvEQ/9XRpYriAYl1M71LdpFRo7rldIP5AmzklM=;
        b=lO81MAWdsZH4bnpTYHYqT4AoRISfi05n9Pl3qWLoTqiRptVY+J89NTve0EKLqr4f7C
         pbWEO1Rrb2d0gHk4BW3HSqlSlkbqokPVOpNhyEV8RH6jvynvrNeWBUo1GgX2xDD3COSV
         tALa+VON6WNLeyJ54OvOSWSVxOb3VidV4FEDS2HAsLLIBjnirB41yYG0QRGzfb3KxQQY
         SiyapxDGQ/Tsqi5T4yMB38jnBOMizQWbdAzD7KaXp1ZrOQ2MGGR3QpVStisafflTof6v
         wf9LrsUTnA+qeKmhX6l2YUhL3PTurJB29BBIGilfx56Lmivz8cs/RJgVXBIp8XLswbni
         p/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CBVHOKvEQ/9XRpYriAYl1M71LdpFRo7rldIP5AmzklM=;
        b=ht390y/ekC1s2f5Kt6fOAe9Bk4/wj2zmR5rYJ9HUuJEI+nrVhYpSyigVeoFdExWyZr
         3bHxsm5VVL38YNjMjA8IUCLdVhxg6gqlzDVy8Yo0C2VczXnzGcyl67JZcvzlejkgxgjz
         5vLpiLPRWFscVxev9Wzdf3fsIA22B399XMkezrfIYskWaJtlZK/r9iJL7UM8DkwquTzJ
         gnr3haSHFO604yMaG/MXZj86v8ugP3SE/aLIaOfp6es4LR1KF6PS1F2TpJiGEHhWv1Wm
         cTX3icp2MA/idU3lM3pqaVlkZqnRT4fP2sstOR0oRrFNrR34HhvaS1xfgK0P7fiZFKK0
         6aEA==
X-Gm-Message-State: AOAM530YUh4E5nkKdIFs8iiAtCBC7B0mDwqWsaIRO0NseS2J28yk9q+8
        igZyRUwe49yXI8LCTTXmLE0JCf6KIxNUN8NrkT3dLoxp
X-Google-Smtp-Source: ABdhPJwbe+xsh/WZ2JH5tkgxuzflRhW5svjOYhObohuePYp0C0+8q9CNq/2/PKgL6MnPBtkHqZiptw==
X-Received: by 2002:a02:9586:: with SMTP id b6mr11765922jai.24.1637721636472;
        Tue, 23 Nov 2021 18:40:36 -0800 (PST)
Received: from stl.sh.sh (ip36.ip-51-222-122.net. [51.222.122.36])
        by smtp.gmail.com with ESMTPSA id p14sm8199425iod.38.2021.11.23.18.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 18:40:36 -0800 (PST)
From:   Jacob M Cutright <cutrightjm@stl.sh>
To:     selinux@vger.kernel.org
Cc:     Cutright Jacob <cutrightjm@stl.sh>
Subject: [PATCH] Modified Russian and English man pages to fix typo; REQUIREUSERS -> REQUIRESEUSERS
Date:   Tue, 23 Nov 2021 21:40:29 -0500
Message-Id: <20211124024029.11520-1-cutrightjm@stl.sh>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Cutright Jacob <cutrightjm@stl.sh>

Signed-off-by: Jacob M Cutright <cutrightjm@stl.sh>
---
 policycoreutils/man/man5/selinux_config.5    | 2 +-
 policycoreutils/man/ru/man5/selinux_config.5 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/man/man5/selinux_config.5 b/policycoreutils/man/man5/selinux_config.5
index 58b42a0e..f391befb 100644
--- a/policycoreutils/man/man5/selinux_config.5
+++ b/policycoreutils/man/man5/selinux_config.5
@@ -32,7 +32,7 @@ The \fIconfig\fR file supports the following parameters:
 .br
 \fBSELINUXTYPE = \fIpolicy_name\fR
 .br
-\fBREQUIREUSERS = \fI0\fR | \fI1\fR
+\fBREQUIRESEUSERS = \fI0\fR | \fI1\fR
 .br
 \fBAUTORELABEL = \fI0\fR | \fI1\fR
 .RE
diff --git a/policycoreutils/man/ru/man5/selinux_config.5 b/policycoreutils/man/ru/man5/selinux_config.5
index 40039e57..8c0db9ae 100644
--- a/policycoreutils/man/ru/man5/selinux_config.5
+++ b/policycoreutils/man/ru/man5/selinux_config.5
@@ -34,7 +34,7 @@ config \- файл конфигурации подсистемы SELinux.
 .br
 \fBSELINUXTYPE = \fIpolicy_name\fR
 .br
-\fBREQUIREUSERS = \fI0\fR | \fI1\fR
+\fBREQUIRESEUSERS = \fI0\fR | \fI1\fR
 .br
 \fBAUTORELABEL = \fI0\fR | \fI1\fR
 .RE
-- 
2.27.0


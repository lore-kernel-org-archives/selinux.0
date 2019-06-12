Return-Path: <SRS0=2Cbv=UL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DACC31E46
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9808D2080A
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfFLIMb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:12:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55494 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730479AbfFLIMb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Jun 2019 04:12:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so5515041wmj.5
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 01:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lh8pe+g8ld0Hm1ls8Qdu8kdqHem5Ag3nC11xOporXTQ=;
        b=Gc9ii87xKL6eE3vxIA/p/5OdIk2CrXfIupnUIXAJiUSUC3AlVwpKo5HYyFuMxpBT6g
         dkwdsxWrLeoCtTvLWhvrK55kuhVLzg2CMVyVks77KoDHKDiH+vnOQcwGfqhx/QyDynzS
         FA4XS/3PFJryQKHTr0Qh9BdorC2/pqGoT4f0uACN5tIdiO35YSXF7vwh+BRh9yaBZ2jp
         IoVo6yNO/IknlOptWW4ksU/M0miX9n9Hfeoeab8sYPRZdTkeirEncM5k1eQ/fz2Ib+7q
         +CA36DK0dKFIrgBre3AGezeKRdbo9/FrZoTxo+hSk4+mXHKYjqufeKv1vLL2LrDRs+5j
         MmNw==
X-Gm-Message-State: APjAAAX+Z/P4ZqGDsuKD/FHjYa66G0vOdS673YFiSQ8TJWLu6wX3hYZF
        9MnrDExyOYgQTp3xbEW+DuzjfVrYOIw=
X-Google-Smtp-Source: APXvYqzM/WKbAN0+0J9mby7zo0q7jJ0Wm/yKolxYQk/jheI0aNa6KYaEYYyodkwThMpTtgoAuwW0/A==
X-Received: by 2002:a7b:cb84:: with SMTP id m4mr22414868wmi.50.1560327148674;
        Wed, 12 Jun 2019 01:12:28 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h8sm4764669wmf.12.2019.06.12.01.12.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 01:12:28 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Daniel Walsh <dwalsh@redhat.com>, Kir Kolyshkin <kir@sacred.ru>
Subject: [PATCH] selinux: fix empty write to keycreate file
Date:   Wed, 12 Jun 2019 10:12:26 +0200
Message-Id: <20190612081226.21004-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When sid == 0 (we are resetting keycreate_sid to the default value), we
should skip the KEY__CREATE check.

Before this patch, doing a zero-sized write to /proc/self/keycreate
would check if the current task can create unlabeled keys (which would
usually fail with -EACCESS and generate an AVC). Now it skips the check
and correctly sets the task's keycreate_sid to 0.

Bug report: https://bugzilla.redhat.com/show_bug.cgi?id=1719067

Tested using the reproducer from the report above.

Fixes: 4eb582cf1fbd ("[PATCH] keys: add a way to store the appropriate context for newly-created keys")
Reported-by: Kir Kolyshkin <kir@sacred.ru>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c61787b15f27..f77b314d0575 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6331,11 +6331,12 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	} else if (!strcmp(name, "fscreate")) {
 		tsec->create_sid = sid;
 	} else if (!strcmp(name, "keycreate")) {
-		error = avc_has_perm(&selinux_state,
-				     mysid, sid, SECCLASS_KEY, KEY__CREATE,
-				     NULL);
-		if (error)
-			goto abort_change;
+		if (sid) {
+			error = avc_has_perm(&selinux_state, mysid, sid,
+					     SECCLASS_KEY, KEY__CREATE, NULL);
+			if (error)
+				goto abort_change;
+		}
 		tsec->keycreate_sid = sid;
 	} else if (!strcmp(name, "sockcreate")) {
 		tsec->sockcreate_sid = sid;
-- 
2.20.1


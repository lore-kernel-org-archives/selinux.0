Return-Path: <SRS0=0eMI=VM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A603AC76197
	for <selinux@archiver.kernel.org>; Mon, 15 Jul 2019 14:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74AEC205ED
	for <selinux@archiver.kernel.org>; Mon, 15 Jul 2019 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563202607;
	bh=dgGnbwFxXTx5HzWdRIRw5cR85q3VjmvhoOuYP4ANVqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QZLv332bxP5H2oKgeDQFGUeOUtk8MFQrDzNtbStFbzIicZz1V1AOv7Am6nkxIl9hQ
	 EZXxEEhjGWvN80oQKPs/2tpifri6C4sq2bQrFgkofsHl3E717Jp/kNlh736y0s7ru5
	 ljFV4kkZJcHOTXq/3vDeOVG/xPbezljZ0frTRsRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733303AbfGOOVn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:21:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390342AbfGOOVm (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 15 Jul 2019 10:21:42 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 476AE21530;
        Mon, 15 Jul 2019 14:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200501;
        bh=dgGnbwFxXTx5HzWdRIRw5cR85q3VjmvhoOuYP4ANVqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y83//rDCYe0frUdcVGG9aKtXQ1sgu+DkmeFB/1u432sMulBbrbGpMwlnmi81e86EG
         2Plm+Y19iZHRRfeYaf5GIXgJOVkQuPvJQn9CeZ/DOZQPZ90ncxPbUDalILH1sv0lVQ
         XKjnhaDY/vDJ0ZJXs25iZOod5lvF4M5LLhqD4G34=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Kir Kolyshkin <kir@sacred.ru>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>, selinux@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 064/158] selinux: fix empty write to keycreate file
Date:   Mon, 15 Jul 2019 10:16:35 -0400
Message-Id: <20190715141809.8445-64-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715141809.8445-1-sashal@kernel.org>
References: <20190715141809.8445-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Ondrej Mosnacek <omosnace@redhat.com>

[ Upstream commit 464c258aa45b09f16aa0f05847ed8895873262d9 ]

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
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/hooks.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 70bad15ed7a0..109ab510bdb1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6550,11 +6550,12 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
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


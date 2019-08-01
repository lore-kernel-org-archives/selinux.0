Return-Path: <SRS0=gk/B=V5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6961EC41517
	for <selinux@archiver.kernel.org>; Thu,  1 Aug 2019 14:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49933214DA
	for <selinux@archiver.kernel.org>; Thu,  1 Aug 2019 14:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbfHAOCx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:02:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51074 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730581AbfHAOCw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Aug 2019 10:02:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so64798738wml.0
        for <selinux@vger.kernel.org>; Thu, 01 Aug 2019 07:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q9l8o0YUUYULIRBa/EVzGkj6Ut5sD4tK2q63xppuwv8=;
        b=ieZB/kcfBSeK5fJqRGAQi5VsPZpAWoCuY8W7nzQSbDowR9U1U399/mXxpQ5FDQFTes
         6y6CnwdZYEaPHCThpOo4ShlZUkO5pzJNUsn26iWEjX+T+urtZ307bvdHTMHNZQIqyAAO
         X8uOMIG894pLSAQgD1u9O+D4b8mEgPT/dljNrfzY7KLnkt2O10pEvwaq//DYRvKEXWnb
         QYZI2HKHhWon9qC4iOaomFGGqiwKrIhaKq9di7HKrMusRJfQTZRfEJgTxTVNy9hE27/o
         wVrS+QU+HS4dAvG16ZLPRx8PUFgVZxxc+RskeBtCDO0CdwhieEkZ/5oJy+ibUGdxY6Zs
         mDsQ==
X-Gm-Message-State: APjAAAV1lW/PbGSrvegIEMU+MqIuqOzP8FXt1SkiJAn/8CKfeiB5dZ3R
        W5uqbwGSDr6tEdARpcE+hXNLxzEmQ8g=
X-Google-Smtp-Source: APXvYqzXEb+285MZOoJB+6F3vWCSdWbbUe7nEOtmuU/D3ChtMO2hzcI+kZ/rCC+3PLbqLbag6JyNaQ==
X-Received: by 2002:a1c:f018:: with SMTP id a24mr113136377wmb.66.1564668169963;
        Thu, 01 Aug 2019 07:02:49 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z7sm69909162wrh.67.2019.08.01.07.02.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 07:02:49 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 4/4] selinux: use d_genocide_safe() in selinuxfs
Date:   Thu,  1 Aug 2019 16:02:43 +0200
Message-Id: <20190801140243.24080-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801140243.24080-1-omosnace@redhat.com>
References: <20190801140243.24080-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Letting the following set of commands run long enough on a machine with
at least 3 CPU threads causes soft lockups in the kernel:

    (cd /sys/fs/selinux/; while true; do find >/dev/null 2>&1; done) &
    (cd /sys/fs/selinux/; while true; do find >/dev/null 2>&1; done) &
    (cd /sys/fs/selinux/; while true; do find >/dev/null 2>&1; done) &

    while true; do load_policy; echo -n .; sleep 0.1; done

The problem is that sel_remove_entries() removes the old selinuxfs
entries using d_genocide() + shrink_dcache_parent(), which is not safe
to do on live trees that are still exposed to userspace.

Specifically, it races with dcache_readdir(), which expects that while a
dentry's inode is locked, its (positive) children cannot get unlisted,
because both unlink() and rmdir() lock the parent inode first.

Therefore, use the newly introduced d_genocide_safe() instead of
d_genocide(), which fixes this issue.

Bug tracker links:
 * SELinux GitHub: https://github.com/SELinuxProject/selinux-kernel/issues/42
 * Red Hat Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1510603

Fixes: ad52184b705c ("selinuxfs: don't open-code d_genocide()")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/selinuxfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index e6c7643c3fc0..58d1949e5faf 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1317,7 +1317,7 @@ static const struct file_operations sel_commit_bools_ops = {
 
 static void sel_remove_entries(struct dentry *de)
 {
-	d_genocide(de);
+	d_genocide_safe(de);
 	shrink_dcache_parent(de);
 }
 
-- 
2.21.0


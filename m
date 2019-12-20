Return-Path: <SRS0=yCNt=2K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2712C2D0C0
	for <selinux@archiver.kernel.org>; Fri, 20 Dec 2019 14:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8072465E
	for <selinux@archiver.kernel.org>; Fri, 20 Dec 2019 14:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576852645;
	bh=pR3v+Fh3eBiXXgY0dmnmsCMTsRR48ZYQyo4tV0b7a3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rg+zPHug3o2tarwqZIlpCAZM7CokXMkaBQLdE4xcv+bvCrMepSd+TX92RbQ/Q1URP
	 7YsUZNciaHM2Cq3P2+mBV5j9wIRWuSqQc87J5j3v7MIdGM22xFr0N41ziclm8M60N2
	 FPc36VVycjtg896Zg2kRnvb4rxCp7nd0e4AbhjQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfLTOaX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:30:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbfLTOaW (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 20 Dec 2019 09:30:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17BAB2468A;
        Fri, 20 Dec 2019 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576852222;
        bh=pR3v+Fh3eBiXXgY0dmnmsCMTsRR48ZYQyo4tV0b7a3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n1Hdnpvy9Pi7xGYcT6yanm0DaOszTLf1yoJj8Pyry/P6NhlswKyl7r+6OpcMnAcUY
         T9Ex2/F+dzcwmGEZMPrTK/llduVr1voabpVMDAPE6ICVQrS9jk5gp0U1ldWZoa8k40
         tO6yfMOpAElbHfmBDx7YmsOprPnlKsNUN2YcDaGA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 20/52] afs: Fix SELinux setting security label on /afs
Date:   Fri, 20 Dec 2019 09:29:22 -0500
Message-Id: <20191220142954.9500-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142954.9500-1-sashal@kernel.org>
References: <20191220142954.9500-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit bcbccaf2edcf1b76f73f890e968babef446151a4 ]

Make the AFS dynamic root superblock R/W so that SELinux can set the
security label on it.  Without this, upgrades to, say, the Fedora
filesystem-afs RPM fail if afs is mounted on it because the SELinux label
can't be (re-)applied.

It might be better to make it possible to bypass the R/O check for LSM
label application through setxattr.

Fixes: 4d673da14533 ("afs: Support the AFS dynamic root")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
cc: selinux@vger.kernel.org
cc: linux-security-module@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/afs/super.c b/fs/afs/super.c
index 488641b1a418d..d9a6036b70b9f 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -448,7 +448,6 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
 	/* allocate the root inode and dentry */
 	if (as->dyn_root) {
 		inode = afs_iget_pseudo_dir(sb, true);
-		sb->s_flags	|= SB_RDONLY;
 	} else {
 		sprintf(sb->s_id, "%llu", as->volume->vid);
 		afs_activate_volume(as->volume);
-- 
2.20.1


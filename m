Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C4FC282DD
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 20:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629572187F
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 20:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578430678;
	bh=zehCim+mbE5Zwzd1nUwk8vKFQX8jEI+Gz7yP6WDgERQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FUc5WjsW8PKZtLn4rJ2Pjd4949FKW5xil3HbDrjrBidA36jgTZB9nyLom9vae7tYy
	 FJhGu/qvjKRAL2dEaLkxNPZM9CveqjRTxAxhrDlyMGCMcDS505+5I4DvdpSXNSu2NJ
	 kqLHanhnnl/aJPrTbn5filFpsZBn70Ic3R52H9BQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgAGU5y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:57:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbgAGU5w (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 7 Jan 2020 15:57:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51833208C4;
        Tue,  7 Jan 2020 20:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430671;
        bh=zehCim+mbE5Zwzd1nUwk8vKFQX8jEI+Gz7yP6WDgERQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MmeB0P8UGsW/8I/hrkR/M7TVsRsYnRJcAI0Z/oQmvkJq2souJKO39g5wmmxHlXeUd
         xcI0vW1hMk7oxV7Tw1uWusI66lgfGEsX4sWfcNkUMCd5vQSkMh3tQjs68wlJ3EJmVY
         LfkO3iK5PeCOaATQ8yFTBcoCLEycl2lLI68rRpl8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 020/191] afs: Fix SELinux setting security label on /afs
Date:   Tue,  7 Jan 2020 21:52:20 +0100
Message-Id: <20200107205334.086622523@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 488641b1a418..d9a6036b70b9 100644
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




Return-Path: <SRS0=c9VK=PQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6305C43612
	for <selinux@archiver.kernel.org>; Tue,  8 Jan 2019 19:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C1220827
	for <selinux@archiver.kernel.org>; Tue,  8 Jan 2019 19:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977292;
	bh=fA6b5H6rWIdz0Kis2llTIdCZbguoF05a2MAZDrjAVOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TPVvr66dxeIi0+u+1KI4Fpd81OMIH/ypUEgubVFIgmG5KhfuAaCWs3hd5+r0h9GbF
	 lbRZI2RhFBfqFGbHXsTKkxJkYzgU+SnWG7ohPpnYCR0KoSR53fuTF7pqSSb1Xfgg+g
	 HxYYHmuWK12hYvdiyDNCD31ddgzxuGLAUS3trqHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbfAHTyp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:54:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:38232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730775AbfAHTa2 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 8 Jan 2019 14:30:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A62252176F;
        Tue,  8 Jan 2019 19:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975827;
        bh=fA6b5H6rWIdz0Kis2llTIdCZbguoF05a2MAZDrjAVOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oCtBcCkdBkMriSq8RZhbdpC8xhDRw1Dr08SVXwhdhzqL4ISpUA5sh2AUQcYtVKsHX
         RG++YjoJkZoCYr9Pm284Xg6OksTFxOl6dIPHFJOMmKvoE+NO89pKqZ71FGrWLhmf26
         oqU68WQVe4GmBn5x5/GDc3yDXgyx3JRxzpuNo+6c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>, selinux@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 25/97] selinux: always allow mounting submounts
Date:   Tue,  8 Jan 2019 14:28:34 -0500
Message-Id: <20190108192949.122407-25-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Ondrej Mosnacek <omosnace@redhat.com>

[ Upstream commit 2cbdcb882f97a45f7475c67ac6257bbc16277dfe ]

If a superblock has the MS_SUBMOUNT flag set, we should always allow
mounting it. These mounts are done automatically by the kernel either as
part of mounting some parent mount (e.g. debugfs always mounts tracefs
under "tracing" for compatibility) or they are mounted automatically as
needed on subdirectory accesses (e.g. NFS crossmnt mounts). Since such
automounts are either an implicit consequence of the parent mount (which
is already checked) or they can happen during regular accesses (where it
doesn't make sense to check against the current task's context), the
mount permission check should be skipped for them.

Without this patch, attempts to access contents of an automounted
directory can cause unexpected SELinux denials.

In the current kernel tree, the MS_SUBMOUNT flag is set only via
vfs_submount(), which is called only from the following places:
 - AFS, when automounting special "symlinks" referencing other cells
 - CIFS, when automounting "referrals"
 - NFS, when automounting subtrees
 - debugfs, when automounting tracefs

In all cases the submounts are meant to be transparent to the user and
it makes sense that if mounting the master is allowed, then so should be
the automounts. Note that CAP_SYS_ADMIN capability checking is already
skipped for (SB_KERNMOUNT|SB_SUBMOUNT) in:
 - sget_userns() in fs/super.c:
	if (!(flags & (SB_KERNMOUNT|SB_SUBMOUNT)) &&
	    !(type->fs_flags & FS_USERNS_MOUNT) &&
	    !capable(CAP_SYS_ADMIN))
		return ERR_PTR(-EPERM);
 - sget() in fs/super.c:
        /* Ensure the requestor has permissions over the target filesystem */
        if (!(flags & (SB_KERNMOUNT|SB_SUBMOUNT)) && !ns_capable(user_ns, CAP_SYS_ADMIN))
                return ERR_PTR(-EPERM);

Verified internally on patched RHEL 7.6 with a reproducer using
NFS+httpd and selinux-tesuite.

Fixes: 93faccbbfa95 ("fs: Better permission checking for submounts")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fe251c6f09f1..3c3878f0d2fa 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2934,7 +2934,7 @@ static int selinux_sb_kern_mount(struct super_block *sb, int flags, void *data)
 		return rc;
 
 	/* Allow all mounts performed by the kernel */
-	if (flags & MS_KERNMOUNT)
+	if (flags & (MS_KERNMOUNT | MS_SUBMOUNT))
 		return 0;
 
 	ad.type = LSM_AUDIT_DATA_DENTRY;
-- 
2.19.1


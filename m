Return-Path: <SRS0=c9VK=PQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50336C43613
	for <selinux@archiver.kernel.org>; Tue,  8 Jan 2019 19:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD4E206BB
	for <selinux@archiver.kernel.org>; Tue,  8 Jan 2019 19:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976856;
	bh=0hoNIVo64XE+aPHkFrmc8ZvPslS6uqudaR38VNGcItc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tU2bdmgA9po52hHa8njLBqF6QDk1ZtYTHwCPLI22hlujx3HraWHc1Ox11ncsu/lpj
	 g/5wPzqT87jLk49q/EsBEwB8S0RM9+G0pMjNHupuUSTvyPS+PR2MZWIUVYoUTKpL/O
	 wYiFD4IafqU46UQpH7tqxk9pjE+Bhj9cxtVaCg8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbfAHTrX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:47:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730394AbfAHTcq (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 8 Jan 2019 14:32:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 556342070B;
        Tue,  8 Jan 2019 19:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975966;
        bh=0hoNIVo64XE+aPHkFrmc8ZvPslS6uqudaR38VNGcItc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJNhuyijpTm5+BevSnmib68DewAw1Gu636yUFSZg+BWDtCOSn4jUHExa/+LlXpA8v
         7zDqY1bSjsTKHf07qK0Y1Pv+Cuno+onFSm8WSNG7fZxiTjhKkYWYggniCBqn/+dro/
         5CLTvXNKLLJHKdp0n9KeQg7TmsUymwUV5Uy1nCew=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>, selinux@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 12/53] selinux: always allow mounting submounts
Date:   Tue,  8 Jan 2019 14:31:40 -0500
Message-Id: <20190108193222.123316-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193222.123316-1-sashal@kernel.org>
References: <20190108193222.123316-1-sashal@kernel.org>
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
index f5d304736852..d6b9ed34ceae 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2820,7 +2820,7 @@ static int selinux_sb_kern_mount(struct super_block *sb, int flags, void *data)
 		return rc;
 
 	/* Allow all mounts performed by the kernel */
-	if (flags & MS_KERNMOUNT)
+	if (flags & (MS_KERNMOUNT | MS_SUBMOUNT))
 		return 0;
 
 	ad.type = LSM_AUDIT_DATA_DENTRY;
-- 
2.19.1


Return-Path: <SRS0=p2GP=R6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B11C10F00
	for <selinux@archiver.kernel.org>; Wed, 27 Mar 2019 18:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94D4205C9
	for <selinux@archiver.kernel.org>; Wed, 27 Mar 2019 18:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712390;
	bh=xxATMUAFr8KVA8Og4E6NFJj1OcuDRKZN1nqWzJQ4Ue8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tq0xDp6mLZjyUDZ/4BcaGTVr44Zb5Rs3HK5WHmq+2sZ2V329XSxNRZAmIxd+TL3Vi
	 xtyOscQ/HXdAj35R2rg9aTqsq4FwQALZYsDGhzo2BVm1kimr4DQY7gI4ZP4RhgqVoM
	 8VvB1OAHjmXxvMf7nb1xtehEBDwRJ1tqkZFVO2Ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390911AbfC0SU1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390907AbfC0SU1 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 27 Mar 2019 14:20:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A24F2147C;
        Wed, 27 Mar 2019 18:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710826;
        bh=xxATMUAFr8KVA8Og4E6NFJj1OcuDRKZN1nqWzJQ4Ue8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RCXtCWAsZjzMxMrPbUeTxeWtQrfLKKwhmoBC+d3x3Q4+1PTjcNQ48mGx1ZqNxo+bT
         TQ7652BaQuuh1tpMJEyShQZUhSfSLX2uwuTn32y/qUnIIxowCJJlG5NncFWT22mCGa
         F/TFGVAsCe9SFP6xa8hTwYbaz8X4sjEO5vddnGh4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>, selinux@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 116/123] selinux: do not override context on context mounts
Date:   Wed, 27 Mar 2019 14:16:20 -0400
Message-Id: <20190327181628.15899-116-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Ondrej Mosnacek <omosnace@redhat.com>

[ Upstream commit 53e0c2aa9a59a48e3798ef193d573ade85aa80f5 ]

Ignore all selinux_inode_notifysecctx() calls on mounts with SBLABEL_MNT
flag unset. This is achived by returning -EOPNOTSUPP for this case in
selinux_inode_setsecurtity() (because that function should not be called
in such case anyway) and translating this error to 0 in
selinux_inode_notifysecctx().

This fixes behavior of kernfs-based filesystems when mounted with the
'context=' option. Before this patch, if a node's context had been
explicitly set to a non-default value and later the filesystem has been
remounted with the 'context=' option, then this node would show up as
having the manually-set context and not the mount-specified one.

Steps to reproduce:
    # mount -t cgroup2 cgroup2 /sys/fs/cgroup/unified
    # chcon unconfined_u:object_r:user_home_t:s0 /sys/fs/cgroup/unified/cgroup.stat
    # ls -lZ /sys/fs/cgroup/unified
    total 0
    -r--r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.controllers
    -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.max.depth
    -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.max.descendants
    -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.procs
    -r--r--r--. 1 root root unconfined_u:object_r:user_home_t:s0 0 Dec 13 10:41 cgroup.stat
    -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.subtree_control
    -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.threads
    # umount /sys/fs/cgroup/unified
    # mount -o context=system_u:object_r:tmpfs_t:s0 -t cgroup2 cgroup2 /sys/fs/cgroup/unified

Result before:
    # ls -lZ /sys/fs/cgroup/unified
    total 0
    -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.controllers
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.max.depth
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.max.descendants
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.procs
    -r--r--r--. 1 root root unconfined_u:object_r:user_home_t:s0 0 Dec 13 10:41 cgroup.stat
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.subtree_control
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.threads

Result after:
    # ls -lZ /sys/fs/cgroup/unified
    total 0
    -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.controllers
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.max.depth
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.max.descendants
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.procs
    -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.stat
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.subtree_control
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.threads

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/hooks.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a5d9c0146ac3..b72aa48f6478 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3339,12 +3339,16 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 				     const void *value, size_t size, int flags)
 {
 	struct inode_security_struct *isec = inode_security_novalidate(inode);
+	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
 	u32 newsid;
 	int rc;
 
 	if (strcmp(name, XATTR_SELINUX_SUFFIX))
 		return -EOPNOTSUPP;
 
+	if (!(sbsec->flags & SBLABEL_MNT))
+		return -EOPNOTSUPP;
+
 	if (!value || !size)
 		return -EACCES;
 
@@ -6103,7 +6107,10 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
  */
 static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
-	return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
+	int rc = selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX,
+					   ctx, ctxlen, 0);
+	/* Do not return error when suppressing label (SBLABEL_MNT not set). */
+	return rc == -EOPNOTSUPP ? 0 : rc;
 }
 
 /*
-- 
2.19.1


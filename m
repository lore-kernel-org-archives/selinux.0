Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C66C433F5
	for <selinux@archiver.kernel.org>; Wed, 15 Dec 2021 16:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244446AbhLOQU0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Dec 2021 11:20:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47229 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244718AbhLOQU0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Dec 2021 11:20:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639585225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GqTpt7CoRbg5tNFbJcVHxyXYmD/OXM27BIU1TN/l4z8=;
        b=Rv6XV/zWcjTaItbPk8Rgk//CEGUvNP+2I/OJ2JZDZE+FEvhrsUtDqv/px/NS1lOdJJU/Pn
        ReSOXo89TbdJs8kH3OEN9QDhXa5pnyayWijvSRb05FpaLgS/rhhvmroFofrL77ClToryvz
        p5idZB8kHHHy4kvz0Xv9hDNrbLRIipU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-in14smxnOOWkVYUBQQAC5A-1; Wed, 15 Dec 2021 11:20:17 -0500
X-MC-Unique: in14smxnOOWkVYUBQQAC5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEE928015CD;
        Wed, 15 Dec 2021 16:20:15 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.33.175])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C42B45D95;
        Wed, 15 Dec 2021 16:20:15 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 8254A1A003E; Wed, 15 Dec 2021 11:20:14 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     selinux@vger.kernel.org
Subject: [PATCH] selinux: Fix sleeping function called from invalid context
Date:   Wed, 15 Dec 2021 11:20:14 -0500
Message-Id: <20211215162014.957848-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

selinux_sb_mnt_opts_compat() is called via sget_fc() under the sb_lock
spinlock, so it can't use GFP_KERNEL allocations:

[  868.565200] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:230
[  868.568246] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 4914, name: mount.nfs
[  868.569626] preempt_count: 1, expected: 0
[  868.570215] RCU nest depth: 0, expected: 0
[  868.570809] Preemption disabled at:
[  868.570810] [<0000000000000000>] 0x0
[  868.571848] CPU: 1 PID: 4914 Comm: mount.nfs Kdump: loaded Tainted: G        W         5.16.0-rc5.2585cf9dfa #1
[  868.573273] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-4.fc34 04/01/2014
[  868.574478] Call Trace:
[  868.574844]  <TASK>
[  868.575156]  dump_stack_lvl+0x34/0x44
[  868.575692]  __might_resched.cold+0xd6/0x10f
[  868.576308]  slab_pre_alloc_hook.constprop.0+0x89/0xf0
[  868.577046]  __kmalloc_track_caller+0x72/0x420
[  868.577684]  ? security_context_to_sid_core+0x48/0x2b0
[  868.578569]  kmemdup_nul+0x22/0x50
[  868.579108]  security_context_to_sid_core+0x48/0x2b0
[  868.579854]  ? _nfs4_proc_pathconf+0xff/0x110 [nfsv4]
[  868.580742]  ? nfs_reconfigure+0x80/0x80 [nfs]
[  868.581355]  security_context_str_to_sid+0x36/0x40
[  868.581960]  selinux_sb_mnt_opts_compat+0xb5/0x1e0
[  868.582550]  ? nfs_reconfigure+0x80/0x80 [nfs]
[  868.583098]  security_sb_mnt_opts_compat+0x2a/0x40
[  868.583676]  nfs_compare_super+0x113/0x220 [nfs]
[  868.584249]  ? nfs_try_mount_request+0x210/0x210 [nfs]
[  868.584879]  sget_fc+0xb5/0x2f0
[  868.585267]  nfs_get_tree_common+0x91/0x4a0 [nfs]
[  868.585834]  vfs_get_tree+0x25/0xb0
[  868.586241]  fc_mount+0xe/0x30
[  868.586605]  do_nfs4_mount+0x130/0x380 [nfsv4]
[  868.587160]  nfs4_try_get_tree+0x47/0xb0 [nfsv4]
[  868.587724]  vfs_get_tree+0x25/0xb0
[  868.588193]  do_new_mount+0x176/0x310
[  868.588782]  __x64_sys_mount+0x103/0x140
[  868.589388]  do_syscall_64+0x3b/0x90
[  868.589935]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  868.590699] RIP: 0033:0x7f2b371c6c4e
[  868.591239] Code: 48 8b 0d dd 71 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d aa 71 0e 00 f7 d8 64 89 01 48
[  868.593810] RSP: 002b:00007ffc83775d88 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[  868.594691] RAX: ffffffffffffffda RBX: 00007ffc83775f10 RCX: 00007f2b371c6c4e
[  868.595504] RDX: 0000555d517247a0 RSI: 0000555d51724700 RDI: 0000555d51724540
[  868.596317] RBP: 00007ffc83775f10 R08: 0000555d51726890 R09: 0000555d51726890
[  868.597162] R10: 0000000000000000 R11: 0000000000000246 R12: 0000555d51726890
[  868.598005] R13: 0000000000000003 R14: 0000555d517246e0 R15: 0000555d511ac925
[  868.598826]  </TASK>

Fixes: 69c4a42d72eb ("lsm,selinux: add new hook to compare new mount to an existing mount")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 security/selinux/hooks.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 62d30c0a30c2..534e8a4747f8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -611,10 +611,11 @@ static int bad_option(struct superblock_security_struct *sbsec, char flag,
 	return 0;
 }
 
-static int parse_sid(struct super_block *sb, const char *s, u32 *sid)
+static int __parse_sid(struct super_block *sb, const char *s, u32 *sid,
+		     gfp_t gfp)
 {
 	int rc = security_context_str_to_sid(&selinux_state, s,
-					     sid, GFP_KERNEL);
+					     sid, gfp);
 	if (rc)
 		pr_warn("SELinux: security_context_str_to_sid"
 		       "(%s) failed for (dev %s, type %s) errno=%d\n",
@@ -622,6 +623,11 @@ static int parse_sid(struct super_block *sb, const char *s, u32 *sid)
 	return rc;
 }
 
+static int parse_sid(struct super_block *sb, const char *s, u32 *sid)
+{
+	return __parse_sid(sb, s, sid, GFP_KERNEL);
+}
+
 /*
  * Allow filesystems with binary mount data to explicitly set mount point
  * labeling information.
@@ -2702,14 +2708,14 @@ static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts)
 		return (sbsec->flags & SE_MNTMASK) ? 1 : 0;
 
 	if (opts->fscontext) {
-		rc = parse_sid(sb, opts->fscontext, &sid);
+		rc = __parse_sid(sb, opts->fscontext, &sid, GFP_NOWAIT);
 		if (rc)
 			return 1;
 		if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid, sid))
 			return 1;
 	}
 	if (opts->context) {
-		rc = parse_sid(sb, opts->context, &sid);
+		rc = __parse_sid(sb, opts->context, &sid, GFP_NOWAIT);
 		if (rc)
 			return 1;
 		if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid, sid))
@@ -2719,14 +2725,14 @@ static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts)
 		struct inode_security_struct *root_isec;
 
 		root_isec = backing_inode_security(sb->s_root);
-		rc = parse_sid(sb, opts->rootcontext, &sid);
+		rc = __parse_sid(sb, opts->rootcontext, &sid, GFP_NOWAIT);
 		if (rc)
 			return 1;
 		if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, sid))
 			return 1;
 	}
 	if (opts->defcontext) {
-		rc = parse_sid(sb, opts->defcontext, &sid);
+		rc = __parse_sid(sb, opts->defcontext, &sid, GFP_NOWAIT);
 		if (rc)
 			return 1;
 		if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid, sid))
-- 
2.31.1


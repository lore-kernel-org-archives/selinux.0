Return-Path: <SRS0=DV1m=OW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B799EC67839
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 14:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856072086D
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 14:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856072086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeLMOTY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:19:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37293 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbeLMOTY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Dec 2018 09:19:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so1756173wrt.4
        for <selinux@vger.kernel.org>; Thu, 13 Dec 2018 06:19:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YFhekL8QmWsTx5uZ6jKbGnq66XQoz3PD4UcdxRJoFy8=;
        b=JR4SeQtJnvXZQmHtQwo0SQjwRlsGBIiA0AR/sOOxAoCUtUZ/mV035GhgEe00jLWRYS
         kWcjxqfhc+b114Xff7AamVfBtoBKIkXibije+7CKzKMn6AkKM66KZL6EH05wjihiMdwT
         IxwQcPOGlVfxvH+iZNaDdlj7Nu1SxcGM8XLsvoOLAhFDhoDq1NZaVkuMgc1ijAX4IC7U
         O75nescARB7hQ3bDTkD8Gnid2OrBvcbFPI9bzSqL9U6hbKnk81N4U2m/9nAndk7hKgs0
         bcAH5jEry0Wc6WwM+g3qMh3jMCZGfLvj0IxClsfo5VWIqEwBIa2MOjVamMIq/XtBaDHS
         fANA==
X-Gm-Message-State: AA+aEWaGvgmErd256EA079Lwp4PsNppKVGPUOum3j/yTnF9xH34wGh40
        cRwDXbGF8r6JLerBB5Auy2WBt9pva6A=
X-Google-Smtp-Source: AFSGD/WQ1FEuiPE4dYF2GeN+QD7Dd1iyuSBmzuarTNFkaA/XEqX7bwjSwX6+xaeWgkFLApnwapL03w==
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr20640084wrw.132.1544710761932;
        Thu, 13 Dec 2018 06:19:21 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e16sm2544750wrn.72.2018.12.13.06.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 06:19:21 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH 3/3] selinux: do not override context on context mounts
Date:   Thu, 13 Dec 2018 15:17:39 +0100
Message-Id: <20181213141739.8534-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213141739.8534-1-omosnace@redhat.com>
References: <20181213141739.8534-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ignore all selinux_inode_notifysecctx() calls on mounts with the
SECURITY_FS_USE_MNTPOINT behavior.

This fixes behavior of kernfs-based filesystems when mounted with the
'context=' option. Before this patch, if a node's context had been
explicitly set to a non-default value and later the filesystem has been
remounted with the 'context=' option, then this node would show up as
having a different context.

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
---
 security/selinux/hooks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d6d29ec54eab..0ca5ed30afe1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6620,6 +6620,13 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
  */
 static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
+	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
+
+	/* Do not change context in SECURITY_FS_USE_MNTPOINT case */
+	if ((sbsec->flags & SE_SBINITIALIZED) &&
+	    (sbsec->behavior == SECURITY_FS_USE_MNTPOINT))
+		return 0;
+
 	return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
 }
 
-- 
2.19.2


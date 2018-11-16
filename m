Return-Path: <SRS0=w7Fl=N3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67D9C43441
	for <selinux@archiver.kernel.org>; Fri, 16 Nov 2018 13:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECE02086A
	for <selinux@archiver.kernel.org>; Fri, 16 Nov 2018 13:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECE02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeKPXYb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:24:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33299 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbeKPXYb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Nov 2018 18:24:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id u9-v6so24846566wrr.0
        for <selinux@vger.kernel.org>; Fri, 16 Nov 2018 05:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EgLEGnBzTSjaNNCwc1oVyGnRYXs/af3lhZeRwjoU5P8=;
        b=NEOFIqkYdbTspucE/PDpfiQ6vypaopHOBQcvuCCaPuduLJMLLQGd9evsolkaIX6gVd
         ibbNNYXbAQ+kaGxWiu7weiakMkis6spOlO64VdSBDw1Nwuti0/CEJIkHokrToCa5x96m
         b9YCQFueskaN33CT6+tBAk/j0S8lvzyEUaCJsTcNZGJiTSp3LzfDvWV54iNlbyPIvPxU
         pkcHp3gD6SXZ8HC/EV5edGO+RwrOXfuqm0mbfT0BA02YwS6FjAF59nNDntTHr9ZEO+hH
         Km7LI5kUaTaPhYybKYVfoniX8LDdxQwWHbIN6by/7ON2u3U3IfCv/xIiz/4UktPYyHhl
         L7mQ==
X-Gm-Message-State: AGRZ1gLQ4pCXMg52KzUcAETFzB1zEUrEbBJBiOs7HT8aSV88xFQ4F9yX
        fe/P0WUznGYJHOEiO3wvQB8hQw==
X-Google-Smtp-Source: AJdET5eqHE02g84e0T6IxX7mrC1OQgm7Qo2SAye5am3TSlc3rzbSdvyX5znhBni1ooMeb1hutXGfMA==
X-Received: by 2002:a5d:634f:: with SMTP id b15-v6mr9657625wrw.14.1542373929460;
        Fri, 16 Nov 2018 05:12:09 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o15-v6sm7949335wmc.18.2018.11.16.05.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 05:12:08 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-fsdevel@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH] selinux: always allow mounting submounts
Date:   Fri, 16 Nov 2018 14:12:02 +0100
Message-Id: <20181116131202.26513-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

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
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7ce683259357..7ce012d9ec51 100644
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
2.17.2


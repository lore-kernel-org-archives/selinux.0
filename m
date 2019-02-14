Return-Path: <SRS0=aI9x=QV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F29FC43381
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 09:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093C9222A4
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 09:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406215AbfBNJu3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:50:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39184 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403813AbfBNJu1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Feb 2019 04:50:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id l5so4631030wrw.6
        for <selinux@vger.kernel.org>; Thu, 14 Feb 2019 01:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=skdWrxA3koLGpIYt5n9FhAmN9/+o28C/3rSBAZ5onrU=;
        b=O6nIjqD8g0QgFIX4Dzo9yKRGluNMdWj0AH9gcwDj0t+QR+I9zcUFJL1j1E5RxB2Vs6
         Rs2rWqLTQF23A53FgCMkgOKG6KYPcNsxY8t6xdtBTQ5qW5CdQlrl1dajN9WzxKDKSVe7
         IZNRlHZDzVzb2lhCDqwSfcHp9kUNWh7FdEP+eCLedqNNhfsfBfKpxbzJW5AHCfldNItB
         wfiKvUaL1HqcL16Bm5lcwQXqgi44OcEYtRBEDwOEIJyTGr6A8UCX3lXz964kp0XycIRr
         t0u7s0eG1hQnxlHqFhi60nvnfUpfutjPG3YkdM4Y1xy/trjrCCYsKJWoEGRdqC2surn9
         AuOw==
X-Gm-Message-State: AHQUAuYKEI0tezSEYU/AsHYz7yV/iUCIAnvek6eOcUkvtSo+Cqm5m6nx
        Xly6V2Tq32NbzcvqsauWH+JTgKLZhjM=
X-Google-Smtp-Source: AHgI3IZLx3XlevFowQKNiLOkJQU9GABzd55tdf9nURLAxnr69dF3cp0IJRej9MJbWZT/whZJO6FvWA==
X-Received: by 2002:adf:de83:: with SMTP id w3mr2012510wrl.56.1550137824984;
        Thu, 14 Feb 2019 01:50:24 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g11sm969439wmk.26.2019.02.14.01.50.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 01:50:24 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v6 0/5] Allow initializing the kernfs node's secctx based on its parent
Date:   Thu, 14 Feb 2019 10:50:10 +0100
Message-Id: <20190214095015.16032-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Changes in v6:
- remove copy-pasted duplicate macro definition

v5: https://lore.kernel.org/selinux/20190205110638.30782-1-omosnace@redhat.com/T/
Changes in v5:
- fix misplaced semicolon detected by 0day robot

v4: https://lore.kernel.org/selinux/20190205085915.5183-1-omosnace@redhat.com/T/
Changes in v4:
- reorder and rename hook arguments
- avoid allocating kernfs_iattrs unless needed

v3: https://lore.kernel.org/selinux/20190130114150.27807-1-omosnace@redhat.com/T/
Changes in v3:
- rename the hook to "kernfs_init_security"
- change the hook interface to simply pass pointers to struct iattr and
  struct simple_xattrs of both the new node and its parent
- add full security xattr support to kernfs (and fixup SELinux behavior
  to handle it properly)

v2: https://lore.kernel.org/selinux/20190109162830.8309-1-omosnace@redhat.com/T/
Changes in v2:
- add docstring for the new hook in union security_list_options
- initialize *ctx to NULL and *ctxlen to 0 in case the hook is not
  implemented

v1: https://lore.kernel.org/selinux/20190109091028.24485-1-omosnace@redhat.com/T/

TL;DR:
This series adds a new security hook that allows to initialize the security
context of kernfs properly, taking into account the parent context (and
possibly other attributes). Kernfs nodes require special handling here, since
they are not bound to specific inodes/superblocks, but instead represent the
backing tree structure that is used to build the VFS tree when the kernfs
tree is mounted.

The kernfs nodes initially do not store any security context and rely on
the LSM to assign some default context to inodes created over them. Kernfs
inodes, however, allow setting an explicit context via the *setxattr(2)
syscalls, in which case the context is stored inside the kernfs node's
internal structure.

SELinux (and possibly other LSMs) initialize the context of newly created
FS objects based on the parent object's context (usually the child inherits
the parent's context, unless the policy dictates otherwise). This is done
by hooking the creation of the new inode corresponding to the newly created
file/directory via security_inode_init_security() (most filesystems always
create a fresh inode when a new FS object is created). However, kernfs nodes
can be created "behind the scenes" while the filesystem is not mounted
anywhere and thus no inodes can exist for them yet.

Therefore, to allow maintaining similar behavior for kernfs nodes, a new
LSM hook is needed, which will allow initializing the kernfs node's
security context based on its own attributes and those of the parent's
node.

The main motivation for this change is that the userspace users of cgroupfs
(which is built on kernfs) expect the usual security context inheritance
to work under SELinux (see [1] and [2]). This functionality is required for
better confinement of containers under SELinux.

Patch 1/5 changes SELinux to fetch security context from extended
attributes on kernfs filesystems, falling back to genfs-defined context
if that fails. Without this patch the 2/5 would be a regression for
SELinux (due to the removal of ...notifysecctx() call.

Patch 2/5 implements full security xattr support in kernfs using
simple_xattrs; patch 3/5 adds the new LSM hook; patch 4/5 implements the
new hook in SELinux; and patch 5/5 modifies kernfs to call the new hook
on new node creation.

Testing:
- passed the reproducer from the commit message of the last patch
- passed SELinux testsuite on Fedora 29 (x86_64) when applied on top of
  current Rawhide kernel (5.0.0-0.rc5.git0.1) [3]
  - including the new proposed selinux-testsuite subtest [4] (adapted
    from the reproducer)

[1] https://github.com/SELinuxProject/selinux-kernel/issues/39
[2] https://bugzilla.redhat.com/show_bug.cgi?id=1553803
[3] https://copr.fedorainfracloud.org/coprs/omos/kernel-testing/build/854148/
[4] https://github.com/SELinuxProject/selinux-testsuite/pull/48

Ondrej Mosnacek (5):
  selinux: try security xattr after genfs for kernfs filesystems
  kernfs: use simple_xattrs for security attributes
  LSM: add new hook for kernfs node initialization
  selinux: implement the kernfs_init_security hook
  kernfs: initialize security of newly created nodes

 fs/kernfs/dir.c                     |  64 +++++++-
 fs/kernfs/inode.c                   | 125 +++++++---------
 fs/kernfs/kernfs-internal.h         |   7 +-
 include/linux/lsm_hooks.h           |  22 +++
 include/linux/security.h            |  14 ++
 include/linux/xattr.h               |  15 ++
 security/security.c                 |  10 ++
 security/selinux/hooks.c            | 222 +++++++++++++++++++---------
 security/selinux/include/security.h |   1 +
 9 files changed, 328 insertions(+), 152 deletions(-)

-- 
2.20.1


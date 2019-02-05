Return-Path: <SRS0=HD60=QM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5A0C282D7
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 08:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141A42083B
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 08:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfBEI7c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:59:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34123 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbfBEI7b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Feb 2019 03:59:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id z15so647954wrn.1
        for <selinux@vger.kernel.org>; Tue, 05 Feb 2019 00:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YzaF5xEN/NykgyhWwHEtl45ZnhntT7qxTkQ6YlISyZ8=;
        b=E9naLm4A+boKfy22fKwQ2iHgktZZ1QezjiKN3WRItOcsTOC1Xu2zQfliJkOGfCLMy6
         R74vleuEwOXhDpfC7TitcxdJqHv4PCBh8s80K8sNBtPKm90TMJf8h+72HoyZF7/ANQI+
         JRxHIheECwu4eRzHZJqgglKOtGHIyj4gZItZ8/e5kOUx12fSfjCIdzOJxApw0HGvTGwh
         F3WOY1PDXqZmbc+2zzumsoFknnXFPIRm+sFmTuzGEFjDY5MhwziJ940Xp3WtVTGh+NAd
         7Qndt56JHMimFlpsIP8Qsb0W4+d8108CPqXJX05tEHc5mNaL4KHSc1mdHB9jt2yzZ2QK
         dylw==
X-Gm-Message-State: AHQUAuZKJK3sDWYTKuUBlKiz+r9YgwHTBFGcvuKAIqeLcJC3w/CfDSW0
        shqDalgNsadSBISkNPRAiKuVtJbB4C0=
X-Google-Smtp-Source: AHgI3IZtZ71lotR74bHzMK3o6H57+pKIam0AESdGPwIXMgNz7lkef9oA7njxETNoEArYR37+XPuRww==
X-Received: by 2002:a5d:678b:: with SMTP id v11mr2904766wru.245.1549357169529;
        Tue, 05 Feb 2019 00:59:29 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n82sm12973613wma.42.2019.02.05.00.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 00:59:28 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v4 0/5] Allow initializing the kernfs node's secctx based on its parent
Date:   Tue,  5 Feb 2019 09:59:10 +0100
Message-Id: <20190205085915.5183-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

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
 security/selinux/hooks.c            | 221 +++++++++++++++++++---------
 security/selinux/include/security.h |   1 +
 9 files changed, 328 insertions(+), 151 deletions(-)

-- 
2.20.1


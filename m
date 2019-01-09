Return-Path: <SRS0=7twf=PR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6762C43612
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 09:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF1F214C6
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 09:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbfAIJLJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:11:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41972 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730050AbfAIJLJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jan 2019 04:11:09 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so6808936wrs.8
        for <selinux@vger.kernel.org>; Wed, 09 Jan 2019 01:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0KJqE7LojP0224E+sVOb33KxD6pgrZNcHRwqfwHuNs0=;
        b=icJ9GF1TTUefMKi3VWFUo5zS/bbIjjdJIduZFmPtjNoTdNH6xZUcWWxbfK9Q16sPDp
         vkmmioFlr4r06sKe8ZKFKMtAbvKoZ4k0sUHz0UR48ttcoXyv+YUKu1g5pKghUN9XY7at
         s8553aVuqoefV8aPdr3/f2V8FmlI1uwBmazXCwuE+Uu9L9wSokspVuNBWzjMi4691LiP
         DrjPuS5CFsnSUv2GSbVr/aSsVeGFb66XUgBWhw6sItZ01GpfNlDSkcgUtANZvmJIvRCk
         QJiuPxYznrT8V4mgC1SoPPX/I5hRKM6UYHgDnvF8g4W+UGp+rswnVYTg/vV+wkhRTcbq
         YAjw==
X-Gm-Message-State: AJcUukdY1s23bECuRVPVuWaxCCDEVg3JIfLDHc6pbXCbuoLilCfOqxMv
        KyX+z5L5Cw9UxsNd5Xz4aMgWqd5txVM=
X-Google-Smtp-Source: ALg8bN5SMqm3mY67g8w7zdxK+3X0tFRiLPY6h8eI6g4nyeiHGmihPfVN89gXVYtdB/frYqdOpeXNBw==
X-Received: by 2002:adf:de91:: with SMTP id w17mr4586925wrl.320.1547025066598;
        Wed, 09 Jan 2019 01:11:06 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f137sm11186044wmg.29.2019.01.09.01.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 01:11:05 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH 0/3] Allow initializing the kernfs node's secctx based on its parent
Date:   Wed,  9 Jan 2019 10:10:25 +0100
Message-Id: <20190109091028.24485-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series adds a new security hook that allows to initialize the security
context of kernfs properly, taking into account the parent context. Kernfs
nodes require special handling here, since they are not bound to specific
inodes/superblocks, but instead represent the backing tree structure that
is used to build the VFS tree when the kernfs tree is mounted.

The kernnfs nodes initially do not store any security context and rely on
the LSM to assign some default context to inodes created over them. Kernfs
inodes, however, allow setting an explicit context via the *setxattr(2)
syscalls, in which case the context is stored inside the kernfs node's
metadata.

SELinux (and possibly other LSMs) initialize the context of newly created
FS objects based on the parent object's context (usually the child inherits
the parent's context, unless the policy dictates otherwise). This is done
by hooking the creation of the new inode corresponding to the newly created
file/directory via security_inode_init_security() (most filesystems always
create a fresh inode when a new FS object is created). However, kernfs nodes
can be created "behind the scenes" while the filesystem is not mounted
anywhere and thus no inodes exist.

Therefore, to allow maintaining similar behavior for kernfs nodes, a new LSM
hook is needed, which would allow initializing the kernfs node's security
context based on the context stored in the parent's node (if any).

The main motivation for this change is that the userspace users of cgroupfs
(which is built on kernfs) expect the usual security context inheritance
to work under SELinux (see [1] and [2]). This functionality is required for
better confinement of containers under SELinux.

The first patch adds the new LSM hook; the second patch implements the hook
in SELinux; and the third patch modifies kernfs to use the new hook to
initialize the security context of kernfs nodes whenever its parent node
has a non-default context set.

Note: the patches are based on current selinux/next [3], but they seem to
apply cleanly on top of v5.0-rc1 as well.

Testing:
- passed SELinux testsuite on Fedora 29 (x86_64) when applied on top of
  current Rawhide kernel (5.0.0-0.rc1.git0.1) [4]
- passed the reproducer from the last patch

[1] https://github.com/SELinuxProject/selinux-kernel/issues/39
[2] https://bugzilla.redhat.com/show_bug.cgi?id=1553803
[3] https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/log/?h=selinux-pr-20181224
[4] https://copr.fedorainfracloud.org/coprs/omos/kernel-testing/build/842855/

Ondrej Mosnacek (3):
  LSM: Add new hook for generic node initialization
  selinux: Implement the object_init_security hook
  kernfs: Initialize security of newly created nodes

 fs/kernfs/dir.c             | 49 ++++++++++++++++++++++++++++++++++---
 fs/kernfs/inode.c           |  9 +++----
 fs/kernfs/kernfs-internal.h |  4 +++
 include/linux/lsm_hooks.h   |  5 ++++
 include/linux/security.h    | 12 +++++++++
 security/security.c         |  8 ++++++
 security/selinux/hooks.c    | 41 +++++++++++++++++++++++++++++++
 7 files changed, 120 insertions(+), 8 deletions(-)

-- 
2.20.1


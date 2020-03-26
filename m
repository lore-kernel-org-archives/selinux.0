Return-Path: <SRS0=8enA=5L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA397C43331
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 20:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0C4206E6
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 20:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oQg2HiJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgCZUGp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:06:45 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:52416 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgCZUGp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Mar 2020 16:06:45 -0400
Received: by mail-pg1-f201.google.com with SMTP id j20so5797619pgm.19
        for <selinux@vger.kernel.org>; Thu, 26 Mar 2020 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WqHax6ECl9wbInrMxjIjOM9cZAwTrPkoL2M2jFKPBQE=;
        b=oQg2HiJAJN0uq3CanDGzoJhuUjBYjvhnGM82wp7T8u1ZLdJc0emxPSWGDOVo2hwXyD
         oYhF+R4VmJyHhW9agDvAQwLEQehvPDqs2xMeloGW6iyyNl7BkF+BMNrw6sO8n5tEHSRW
         Bj9P4BPDq3/5vV7bdFky1PCeCR2OwIF62INk4/iglpEogfPbio/6/tuFzLNw2BTLZnIM
         szYZf1bycO6HgHYsEnY0Fz1gYItaYnVEORPALjWBYguN7JqK9Z7cKiRowmRewMd8xCuQ
         6QR0/l8leAZRocfTh5jgbffUm6anAdrZ0D82jPJYwvqKEtPgt/HsDIA4PDCLHV2pVl9e
         5qwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WqHax6ECl9wbInrMxjIjOM9cZAwTrPkoL2M2jFKPBQE=;
        b=GQm1XnQ8dbQXXq6Jo/2rFjEWD4zBmhWVNqoweeVSq3ApEQKiY8KyuOG4RoPiPW9vxU
         d1Q+4Hw/V9lp84e7nkZcj4CajpWv1b0HRSkQJv859k4gp+edm0UB/BA1P19AWKLTy+8Z
         Eln8xi+/S83hTTr5huxkDDZs9oe4sqGeH2ZV6nInvmtiEqmgFFZl5EYiG/KQYaIr/sYo
         fyYlgINXWIowpmsBSIqJtvy2EQ6n0OS242QGXJHgjWzITJIqU7IA2opWFHbZPvTBK/yp
         K7+fekM9JXBS8Gjpc/towls4/x5fP1X9/SFBXa17JP9Rr/T40lgAwReJcbs2rX785EJi
         4YRQ==
X-Gm-Message-State: ANhLgQ17z8gWP2g9gkgHKEhaN9YffY77dFlJdYQPWv93AcV/8YY01zXi
        TdApx680L4OoeL9oDkpzKwW7g6ZQeqw=
X-Google-Smtp-Source: ADFU+vvsk68FMQSxurQFf3aAeMUtjRxGtYQGqNwjBsk1ShThaxSUYG2MrLAemrcldb5fjvyCliNa2Z6slbk=
X-Received: by 2002:a17:90a:e289:: with SMTP id d9mr1801523pjz.172.1585253203623;
 Thu, 26 Mar 2020 13:06:43 -0700 (PDT)
Date:   Thu, 26 Mar 2020 13:06:31 -0700
In-Reply-To: <20200326181456.132742-1-dancol@google.com>
Message-Id: <20200326200634.222009-1-dancol@google.com>
Mime-Version: 1.0
References: <20200326181456.132742-1-dancol@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v4 0/3] SELinux support for anonymous inodes and UFFD
From:   Daniel Colascione <dancol@google.com>
To:     timmurray@google.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, sds@tycho.nsa.gov, lokeshgidra@google.com,
        jmorris@namei.org
Cc:     Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Userfaultfd in unprivileged contexts could be potentially very
useful. We'd like to harden userfaultfd to make such unprivileged use
less risky. This patch series allows SELinux to manage userfaultfd
file descriptors and in the future, other kinds of
anonymous-inode-based file descriptor.  SELinux policy authors can
apply policy types to anonymous inodes by providing name-based
transition rules keyed off the anonymous inode internal name (
"[userfaultfd]" in the case of userfaultfd(2) file descriptors) and
applying policy to the new SIDs thus produced.

Inside the kernel, a pair of new anon_inodes interface,
anon_inode_getfile_secure and anon_inode_getfd_secure, allow callers
to opt into this SELinux management. In this new "secure" mode,
anon_inodes creates new ephemeral inodes for anonymous file objects
instead of reusing the normal anon_inodes singleton dummy inode. A new
LSM hook gives security modules an opportunity to configure and veto
these ephemeral inodes.

This patch series is one of two fork of [1] and is an
alternative to [2].

The primary difference between the two patch series is that this
partch series creates a unique inode for each "secure" anonymous
inode, while the other patch series ([2]) continues using the
singleton dummy anonymous inode and adds a way to attach SELinux
security information directly to file objects.

I prefer the approach in this patch series because 1) it's a smaller
patch than [2], and 2) it produces a more regular security
architecture: in this patch series, secure anonymous inodes aren't
S_PRIVATE and they maintain the SELinux property that the label for a
file is in its inode. We do need an additional inode per anonymous
file, but per-struct-file inode creation doesn't seem to be a problem
for pipes and sockets.

The previous version of this feature ([1]) created a new SELinux
security class for userfaultfd file descriptors. This version adopts
the generic transition-based approach of [2].

This patch series also differs from [2] in that it doesn't affect all
anonymous inodes right away --- instead requiring anon_inodes callers
to opt in --- but this difference isn't one of basic approach. The
important question to resolve is whether we should be creating new
inodes or enhancing per-file data.

Changes from the first version of the patch:

  - Removed some error checks
  - Defined a new anon_inode SELinux class to resolve the
    ambiguity in [3]
  - Inherit sclass as well as descriptor from context inode

Changes from the second version of the patch:

  - Fixed example policy in the commit message to reflect the use of
    the new anon_inode class.

Changes from the third version of the patch:

  - Dropped the fops parameter to the LSM hook
  - Documented hook parameters
  - Fixed incorrect class used for SELinux transition
  - Removed stray UFFD changed early in the series
  - Removed a redundant ERR_PTR(PTR_ERR())

[1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/
[2] https://lore.kernel.org/linux-fsdevel/20200213194157.5877-1-sds@tycho.nsa.gov/
[3] https://lore.kernel.org/lkml/23f725ca-5b5a-5938-fcc8-5bbbfc9ba9bc@tycho.nsa.gov/

Daniel Colascione (3):
  Add a new LSM-supporting anonymous inode interface
  Teach SELinux about anonymous inodes
  Wire UFFD up to SELinux

 fs/anon_inodes.c                    | 196 ++++++++++++++++++++++------
 fs/userfaultfd.c                    |  30 ++++-
 include/linux/anon_inodes.h         |  13 ++
 include/linux/lsm_hooks.h           |  11 ++
 include/linux/security.h            |   3 +
 security/security.c                 |   9 ++
 security/selinux/hooks.c            |  53 ++++++++
 security/selinux/include/classmap.h |   2 +
 8 files changed, 271 insertions(+), 46 deletions(-)

-- 
2.25.1.696.g5e7596f4ac-goog


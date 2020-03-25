Return-Path: <SRS0=pblC=5K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3405AC2D0E7
	for <selinux@archiver.kernel.org>; Wed, 25 Mar 2020 23:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE622073E
	for <selinux@archiver.kernel.org>; Wed, 25 Mar 2020 23:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pErYkr8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgCYXC4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:02:56 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:37336 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbgCYXC4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Mar 2020 19:02:56 -0400
Received: by mail-pf1-f202.google.com with SMTP id n28so3539924pfq.4
        for <selinux@vger.kernel.org>; Wed, 25 Mar 2020 16:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bbByUOh82ool+SbMsA1rd5UPSytjb2ekUWaOBWg/qH4=;
        b=pErYkr8SQ3js+o0QvaCZ2l96awDpkh8EUrjdNxFzM5tLCD4mbraW9JddFtQK0HyshT
         Avi04q5RiTad5YbeGKaK3qQDIhPmHtahpbjhp5ypqqp+ISs/DtHKySkISX00+naohPBc
         fD3TM90efw7F9/2EnWg7pGK8DCYDlEqC0oNDigZIPpWkrmi6AIFt6BNa1XFMFl7CJiAV
         hOVMaSzmXzi4wiklS783i7sQOVKxezXdi9uI4PDANgNCZwRz2ZppnvtKA8qRImOl3799
         C2kTOSxfz7k/WCYqwqQHvko0fPJ2rYwW0Ofl7E40p6/OWTpnb50TopRg525DkYJy2QEP
         maug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bbByUOh82ool+SbMsA1rd5UPSytjb2ekUWaOBWg/qH4=;
        b=WleimNCUmpevRa9MwHZstCR8eGwnSCqWUG0fmBZ2LmEu9D8myBTwo73FOdabGsCHbX
         2N0hWWbr0Hd8S4PON5RD9A/iExkOdPYpf3M9wvnQc8nXPWkvTqwcbpjcMFD8iR3v3dGM
         Qne4cPeHmV2l5dDYxDBosnSyefQtqqlPqMwLjOVVksdXXhpeCOjw3FfGIqhZQzFt54hy
         hbxsuV4xAeK8J7tjlET70/u1BNL88Seo2haKBHtoXVh4qPU7GZD3zY6FmOncPsowLnan
         opyxMPdrw1nz9IMl6+zn/pVFEHEUWBuQ8nR6+0drts6OSVyp18Ii87jp1sCVPenk8dIV
         tfaQ==
X-Gm-Message-State: ANhLgQ2dYw8PpAqnGRaVFFSl+eRu8W7Mm8bxvxQ7PCJeJBQHBDqUUFiD
        QeD0nl2aL0SdTmtUybBmCZ3p1Zcxc0Q=
X-Google-Smtp-Source: ADFU+vtou3JvMD6bdJEzfSY7dZ8y8OPdFIieV20IdIhHvT/Kq/C6dfCeM9T+fChX6v9277hrJ2rP5pCwomI=
X-Received: by 2002:a17:90a:a484:: with SMTP id z4mr6308167pjp.77.1585177373743;
 Wed, 25 Mar 2020 16:02:53 -0700 (PDT)
Date:   Wed, 25 Mar 2020 16:02:43 -0700
In-Reply-To: <20200214032635.75434-1-dancol@google.com>
Message-Id: <20200325230245.184786-1-dancol@google.com>
Mime-Version: 1.0
References: <20200214032635.75434-1-dancol@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v2 0/3] SELinux support for anonymous inodes and UFFD
From:   Daniel Colascione <dancol@google.com>
To:     timmurray@google.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, sds@tycho.nsa.gov, lokeshgidra@google.com
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
 include/linux/lsm_hooks.h           |   9 ++
 include/linux/security.h            |   4 +
 security/security.c                 |  10 ++
 security/selinux/hooks.c            |  54 ++++++++
 security/selinux/include/classmap.h |   2 +
 8 files changed, 272 insertions(+), 46 deletions(-)

-- 
2.25.1.696.g5e7596f4ac-goog


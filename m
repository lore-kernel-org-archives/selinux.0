Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C62FC433DF
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 22:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E88214F1
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 22:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skihW5Fs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgHGWuS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Aug 2020 18:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgHGWuN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Aug 2020 18:50:13 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BABC061A27
        for <selinux@vger.kernel.org>; Fri,  7 Aug 2020 15:50:13 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id a186so2545963qke.1
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2020 15:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DQO/d2NW9ycP8DpTdbgC9T07rqomhGHKBXOmCuHa3fI=;
        b=skihW5FsoS5B78IzyrqqnSUBgOERm/DgSjBN+uMjnt0AZnPktaxaQbH2qQou65YQmU
         qP21JoLind2jMwtpvkUtQldXZyx2lxVWdw0ROo0fDFRei2PlwNCMAdF/NA7atmf1rSDB
         H7kEdhYhgDhiDrf8XmbVr9tEFsAU5rlfePr16DRyDkDz6gSCvwU4V8ZSUUK2oxRzfgsS
         munPXEMVTA90J6c38s3k83pWnxFTpLR9v9nQreC1CwIf7cllzdpDOGRD96jwPxYDm58R
         q6Qtrly3U9bt3QCQAvZaY2pCYItO38lzL923Ms6TFxmvinsPFI0AsgcvV6ABS9gDigIt
         DrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DQO/d2NW9ycP8DpTdbgC9T07rqomhGHKBXOmCuHa3fI=;
        b=CCwC3EMuBKkkHqg24hBJ1t1loXVvg6Rko/YPT4h2WJBH4zniRmNPazPNIfE2+UZioJ
         vL/RzY1Z0WFjKQpUqeYC7VWC+ybK5J9aZ0Kz5EzohnRvphlUDmP4FLQORYYdmJzfnW4y
         +xU7spZgnDyNfTQt4HW9hRY/yOk183mnFZGY5OBB7EHPSaopI/0hXxeB7Qi2UIQfaw+p
         L12bcP+Y4dsYg4gfkE/tavO+OxMZ5GRCamdoKU4x15EtZQP/XzeUhU0vVZibROI4SxLk
         JnMhMmMqE1plt6pnGOMdbUJZqE/B/yNUvwO8E/rEDE5O33fVV6m5i2vj4R0Cdbx2DdQn
         QiTg==
X-Gm-Message-State: AOAM532iM5c9S8I+yDocaYh5lu5/AalPLj1WAJOib2J8dvsBlpeqn+av
        YLTDvWs/bDdeczYK/yiqYbQjgB7U7fp54gE9Lg==
X-Google-Smtp-Source: ABdhPJyG3KGIHkCpGfBzgWcWyqw9H33fn3v9KCn90f9K5GXlgb5Y6RbVNwWjkzPw3a2FniVWsQnK4tgwCbB49VCiMw==
X-Received: by 2002:a0c:e604:: with SMTP id z4mr17234420qvm.222.1596840612573;
 Fri, 07 Aug 2020 15:50:12 -0700 (PDT)
Date:   Fri,  7 Aug 2020 15:49:38 -0700
Message-Id: <20200807224941.3440722-1-lokeshgidra@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v6 0/3] SELinux support for anonymous inodes and UFFD
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        nnk@google.com, jeffv@google.com, kernel-team@android.com
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

Changes from the fourth version of the patch:

  - Removed an unused parameter from an internal function
  - Fixed function documentation

Changes from the fifth version of the patch:

  - Fixed function documentation in fs/anon_inodes.c and
    include/linux/lsm_hooks.h
  - Used anon_inode_getfd_secure() in userfaultfd() syscall and removed
    owner from userfaultfd_ctx.

[1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/
[2] https://lore.kernel.org/linux-fsdevel/20200213194157.5877-1-sds@tycho.nsa.gov/
[3] https://lore.kernel.org/lkml/23f725ca-5b5a-5938-fcc8-5bbbfc9ba9bc@tycho.nsa.gov/

Daniel Colascione (3):
  Add a new LSM-supporting anonymous inode interface
  Teach SELinux about anonymous inodes
  Wire UFFD up to SELinux

 fs/anon_inodes.c                    | 193 ++++++++++++++++++++++------
 fs/userfaultfd.c                    |  23 ++--
 include/linux/anon_inodes.h         |  13 ++
 include/linux/lsm_hook_defs.h       |   2 +
 include/linux/lsm_hooks.h           |   7 +
 include/linux/security.h            |   3 +
 security/security.c                 |   9 ++
 security/selinux/hooks.c            |  53 ++++++++
 security/selinux/include/classmap.h |   2 +
 9 files changed, 255 insertions(+), 50 deletions(-)

-- 
2.28.0.236.gb10cc79966-goog


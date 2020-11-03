Return-Path: <SRS0=PQdl=EJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ED9C2D0A3
	for <selinux@archiver.kernel.org>; Tue,  3 Nov 2020 22:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C1E6223EA
	for <selinux@archiver.kernel.org>; Tue,  3 Nov 2020 22:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQ7gXiGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbgKCWAo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Nov 2020 17:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730208AbgKCWAo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Nov 2020 17:00:44 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1B7C061A48
        for <selinux@vger.kernel.org>; Tue,  3 Nov 2020 14:00:44 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id bb2so11483077plb.8
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2020 14:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=0y7LeAQ9NHAeCjBB9f+BCZL8bpbABLEfm+/TZuUzjwI=;
        b=gQ7gXiGtlpzdQ4+kscZPd6B0pL8bBi4lpKMevAPg+2wnloaslgi4FTTNqIZXll7UUZ
         l7s9sw3rW0Ufwi0Ro7ReevSbVYopKcu6BvuWnPgaHuf4I8kH/N3TrE/130mBHhbfUwlj
         Nmv6hHaR3KEklrSKawD9tSmZUbQhqtklvSSr4SEEc/NtQ03DftfNVaMvk966/1heVZZY
         M4LK2gZ/SoAceWGID16ZoCbLEhgqUzsPE7Bo5N7gnY6ufgpOmf+Qyf2Ds7Jo57qDnoJm
         OPBqRkYTpzV6FINKJjl86jYtEBZooOrsDRZ8zRrDX6fqtT+qMjkMUwzYnkBZk6pknuoS
         aH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=0y7LeAQ9NHAeCjBB9f+BCZL8bpbABLEfm+/TZuUzjwI=;
        b=GhK2XTRWGzpwGYAd8aowAmKN2ZA7qadlEgH5/V2rSEJmlrI2zdSxWKz44p0+oHn7J6
         md6ffejEPESwvQ6PwIASV9S/E6PG5zuG1DrK7qgGg5mjgx8HAOTSMMsa3HNjAL/ZDUCG
         xrUzsI6koEozeMTPtnesGzwm6+y+nC8mGO0kdK/lvx0ES/vQwSD5L8WRulitAphbgBth
         Wi251FboZPoGVyiCwQE/Pn5N/vr5ti1E5gKMg38ikyJT8f4aNQz8d4dQ3aM+DS5CdXNz
         hPLw9t/bgaM85dbSGYguMTrh/XMDaRcpMDQ0wlI8lKpnByU7rtVtI5sNInQMJknctLM0
         pOvQ==
X-Gm-Message-State: AOAM5331Iv55B6H+M+I6vRfE8JJGupGHaEVqMA5wyvXWHEALTx0wAiHu
        a2if0ecgeT1yuFIdtIr8PUOL8uoXZwuRoopsJQ==
X-Google-Smtp-Source: ABdhPJwPlmBzGUIwqmcV3sVySuo3rMF2H/5C9jaRnRcfOgih5bNE4a9ybYXgCV039/rroo4C7O6TUHsdyFOpH2sJpg==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a17:90a:f211:: with SMTP id
 bs17mr1280455pjb.153.1604440843530; Tue, 03 Nov 2020 14:00:43 -0800 (PST)
Date:   Tue,  3 Nov 2020 14:00:17 -0800
Message-Id: <20201103220020.2399003-1-lokeshgidra@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v10 0/3] SELinux support for anonymous inodes and UFFD
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        nnk@google.com, jeffv@google.com, kernel-team@android.com,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
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

With SELinux managed userfaultfd, an admin can control creation and
movement of the file descriptors. In particular, handling of
a userfaultfd descriptor by a different process is essentially a
ptrace access into the process, without any of the corresponding
security_ptrace_access_check() checks. For privacy, the admin may
want to deny such accesses, which is possible with SELinux support.

Inside the kernel, a new anon_inode interface, anon_inode_getfd_secure,
allows callers to opt into this SELinux management. In this new "secure"
mode, anon_inodes create new ephemeral inodes for anonymous file objects
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

Changes from the sixth version of the patch:

  - Removed definition of anon_inode_getfile_secure() as there are no
    callers.
  - Simplified function description of anon_inode_getfd_secure().
  - Elaborated more on the purpose of 'context_inode' in commit message.

Changes from the seventh version of the patch:

  - Fixed error handling in _anon_inode_getfile().
  - Fixed minor comment and indentation related issues.

Changes from the eighth version of the patch:

  - Replaced selinux_state.initialized with selinux_state.initialized

Changes from the ninth version of the patch:

  - Fixed function names in fs/anon_inodes.c
  - Fixed comment of anon_inode_getfd_secure()
  - Fixed name of the patch wherein userfaultfd code uses
    anon_inode_getfd_secure()

[1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/
[2] https://lore.kernel.org/linux-fsdevel/20200213194157.5877-1-sds@tycho.nsa.gov/
[3] https://lore.kernel.org/lkml/23f725ca-5b5a-5938-fcc8-5bbbfc9ba9bc@tycho.nsa.gov/

Daniel Colascione (3):
  Add a new LSM-supporting anonymous inode interface
  Teach SELinux about anonymous inodes
  Use secure anon inodes for userfaultfd

 fs/anon_inodes.c                    | 148 ++++++++++++++++++++--------
 fs/userfaultfd.c                    |  19 ++--
 include/linux/anon_inodes.h         |   8 ++
 include/linux/lsm_hook_defs.h       |   2 +
 include/linux/lsm_hooks.h           |   9 ++
 include/linux/security.h            |  10 ++
 security/security.c                 |   8 ++
 security/selinux/hooks.c            |  53 ++++++++++
 security/selinux/include/classmap.h |   2 +
 9 files changed, 210 insertions(+), 49 deletions(-)

-- 
2.28.0.1011.ga647a8990f-goog


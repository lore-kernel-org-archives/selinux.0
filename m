Return-Path: <SRS0=Dm73=EB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817F3C388F9
	for <selinux@archiver.kernel.org>; Mon, 26 Oct 2020 16:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D56C223B0
	for <selinux@archiver.kernel.org>; Mon, 26 Oct 2020 16:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GBa7YXID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786730AbgJZQ52 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 26 Oct 2020 12:57:28 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33501 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1786710AbgJZQ5X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 26 Oct 2020 12:57:23 -0400
Received: by mail-il1-f195.google.com with SMTP id f16so1438413ilr.0
        for <selinux@vger.kernel.org>; Mon, 26 Oct 2020 09:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o0HlbzC/PMbUoOBDvB5+gaRsmOaPMHvpgw6up7a4aZQ=;
        b=GBa7YXIDiGtb+Nlv2bI3d/omOSevIhtZXCE3FrV/+H8FYa94InqigxYjoxTL2ZkQSC
         30B9g1Y/K8gbpjEsnYDLrRSvP2PbZ221Oeh6zctLkDuFktZhGrZEdNrro6ytt7+vVe7v
         hkaP6yok+KgFS6aM2skIqVY1ViUnWxzvzAqktv7WjGtMyAffAyOzyqWSkfJwF6UjqWHQ
         vxvNxJX4FL67jsXfY2luZnUMO+Hs/wFz8yOUnYkn3LuZk48bpKPgE9Ji3Y+w+tqo/XFy
         h1sr8HK+oSOHprrb3QzJsRIFqserIdqxFIUC5Mn6sYhwferk3qADftvOvr73s6ubj9Js
         Zdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o0HlbzC/PMbUoOBDvB5+gaRsmOaPMHvpgw6up7a4aZQ=;
        b=hGixDVhZqX7kjzSfYif6u2vq3iFkcFK2KECdymTh3fDBGVp4wcr964uU4kqiS1WiTj
         xq5NqlHrYcP2Gn1JzZoRBj0irDItRFVdpl2ImDjj0f7Jn9oeG3ZGXF7C360QA5xgjiGc
         OjD4k8k4mNL/rlbrXzclv2Hd9XGOZSnH+hO4vmQGDea4arxuM3pgyRHprlAxC18ZmKCF
         ulQwZ5y3ibhbR21Kw3ILdJc2brmkzqv7EaNKulT4kz3PrRsRDrcwNPBraSvKV3ZZvqWj
         Ftzz7jbhr0FJ5Ku955q49hRoi77fZfV4m3GGrYp+GS0amWN8iIGGKTuSRi/9lbjvpEsW
         zWrw==
X-Gm-Message-State: AOAM532emmjZxql9ETZN971rup86tmWCoyDY9DdUgvt7DIyj7MqVs+AQ
        lYZesSPFxbzTu8ep7HeK8vmyQbkqAMSi+IBTPA/NzA==
X-Google-Smtp-Source: ABdhPJzTcCzQFsCUeEWDLmb9ob+imX6d8YOW4nsHVzM7OxlhxTHymdjAvsixI9JQvx60k+H/WSh9cH0RCCc03v8JWw4=
X-Received: by 2002:a05:6e02:5c7:: with SMTP id l7mr11810940ils.43.1603731440940;
 Mon, 26 Oct 2020 09:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201011082936.4131726-1-lokeshgidra@google.com>
In-Reply-To: <20201011082936.4131726-1-lokeshgidra@google.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Mon, 26 Oct 2020 09:57:09 -0700
Message-ID: <CA+EESO6YRQKsU21_3hcRi7V30CXbxThfxCu8KEG4hac+DsFCSg@mail.gmail.com>
Subject: Re: [PATCH v10 0/3] SELinux support for anonymous inodes and UFFD
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
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
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Oct 11, 2020 at 1:29 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
>
> Userfaultfd in unprivileged contexts could be potentially very
> useful. We'd like to harden userfaultfd to make such unprivileged use
> less risky. This patch series allows SELinux to manage userfaultfd
> file descriptors and in the future, other kinds of
> anonymous-inode-based file descriptor.  SELinux policy authors can
> apply policy types to anonymous inodes by providing name-based
> transition rules keyed off the anonymous inode internal name (
> "[userfaultfd]" in the case of userfaultfd(2) file descriptors) and
> applying policy to the new SIDs thus produced.
>
> With SELinux managed userfaultfd, an admin can control creation and
> movement of the file descriptors. In particular, handling of
> a userfaultfd descriptor by a different process is essentially a
> ptrace access into the process, without any of the corresponding
> security_ptrace_access_check() checks. For privacy, the admin may
> want to deny such accesses, which is possible with SELinux support.
>
> Inside the kernel, a new anon_inode interface, anon_inode_getfd_secure,
> allows callers to opt into this SELinux management. In this new "secure"
> mode, anon_inodes create new ephemeral inodes for anonymous file objects
> instead of reusing the normal anon_inodes singleton dummy inode. A new
> LSM hook gives security modules an opportunity to configure and veto
> these ephemeral inodes.
>
> This patch series is one of two fork of [1] and is an
> alternative to [2].
>
> The primary difference between the two patch series is that this
> partch series creates a unique inode for each "secure" anonymous
> inode, while the other patch series ([2]) continues using the
> singleton dummy anonymous inode and adds a way to attach SELinux
> security information directly to file objects.
>
> I prefer the approach in this patch series because 1) it's a smaller
> patch than [2], and 2) it produces a more regular security
> architecture: in this patch series, secure anonymous inodes aren't
> S_PRIVATE and they maintain the SELinux property that the label for a
> file is in its inode. We do need an additional inode per anonymous
> file, but per-struct-file inode creation doesn't seem to be a problem
> for pipes and sockets.
>
> The previous version of this feature ([1]) created a new SELinux
> security class for userfaultfd file descriptors. This version adopts
> the generic transition-based approach of [2].
>
> This patch series also differs from [2] in that it doesn't affect all
> anonymous inodes right away --- instead requiring anon_inodes callers
> to opt in --- but this difference isn't one of basic approach. The
> important question to resolve is whether we should be creating new
> inodes or enhancing per-file data.
>
> Changes from the first version of the patch:
>
>   - Removed some error checks
>   - Defined a new anon_inode SELinux class to resolve the
>     ambiguity in [3]
>   - Inherit sclass as well as descriptor from context inode
>
> Changes from the second version of the patch:
>
>   - Fixed example policy in the commit message to reflect the use of
>     the new anon_inode class.
>
> Changes from the third version of the patch:
>
>   - Dropped the fops parameter to the LSM hook
>   - Documented hook parameters
>   - Fixed incorrect class used for SELinux transition
>   - Removed stray UFFD changed early in the series
>   - Removed a redundant ERR_PTR(PTR_ERR())
>
> Changes from the fourth version of the patch:
>
>   - Removed an unused parameter from an internal function
>   - Fixed function documentation
>
> Changes from the fifth version of the patch:
>
>   - Fixed function documentation in fs/anon_inodes.c and
>     include/linux/lsm_hooks.h
>   - Used anon_inode_getfd_secure() in userfaultfd() syscall and removed
>     owner from userfaultfd_ctx.
>
> Changes from the sixth version of the patch:
>
>   - Removed definition of anon_inode_getfile_secure() as there are no
>     callers.
>   - Simplified function description of anon_inode_getfd_secure().
>   - Elaborated more on the purpose of 'context_inode' in commit message.
>
> Changes from the seventh version of the patch:
>
>   - Fixed error handling in _anon_inode_getfile().
>   - Fixed minor comment and indentation related issues.
>
> Changes from the eighth version of the patch:
>
>   - Replaced selinux_state.initialized with selinux_state.initialized
>
> Changes from the ninth version of the patch:
>
>   - Fixed function names in fs/anon_inodes.c
>   - Fixed comment of anon_inode_getfd_secure()
>   - Fixed name of the patch wherein userfaultfd code uses
>     anon_inode_getfd_secure()
>
> [1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/
> [2] https://lore.kernel.org/linux-fsdevel/20200213194157.5877-1-sds@tycho.nsa.gov/
> [3] https://lore.kernel.org/lkml/23f725ca-5b5a-5938-fcc8-5bbbfc9ba9bc@tycho.nsa.gov/
>
> Daniel Colascione (3):
>   Add a new LSM-supporting anonymous inode interface
>   Teach SELinux about anonymous inodes
>   Use secure anon inodes for userfaultfd
>
>  fs/anon_inodes.c                    | 148 ++++++++++++++++++++--------
>  fs/userfaultfd.c                    |  19 ++--
>  include/linux/anon_inodes.h         |   8 ++
>  include/linux/lsm_hook_defs.h       |   2 +
>  include/linux/lsm_hooks.h           |   9 ++
>  include/linux/security.h            |  10 ++
>  security/security.c                 |   8 ++
>  security/selinux/hooks.c            |  53 ++++++++++
>  security/selinux/include/classmap.h |   2 +
>  9 files changed, 210 insertions(+), 49 deletions(-)
>
> --
> 2.28.0.1011.ga647a8990f-goog
>

Any suggestions on how to get VFS folks' (already CC'ed) attention on
this patch series?

In the meantime, I humbly request the SELinux/LSM/UFFD
reviewers/maintainers to provide their reviews.

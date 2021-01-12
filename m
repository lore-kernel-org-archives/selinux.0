Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7332CC433E0
	for <selinux@archiver.kernel.org>; Tue, 12 Jan 2021 17:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB8A2311C
	for <selinux@archiver.kernel.org>; Tue, 12 Jan 2021 17:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391316AbhALRQS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Jan 2021 12:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732317AbhALRQS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Jan 2021 12:16:18 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F08C061575
        for <selinux@vger.kernel.org>; Tue, 12 Jan 2021 09:15:37 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id 6so4600119ejz.5
        for <selinux@vger.kernel.org>; Tue, 12 Jan 2021 09:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tlN+SR1GxJrZealRnBj4IK5rirhuxkSGuR3XMgHjbM8=;
        b=2JSJLgjjYoRmh4WKyhvwd7P5EYDVodgao689juYrDTUOryxHHdbBFMvk6F49hQeANI
         0ncsHC6TWKiQttECpHZrIyibJPz+veA90aIDcBmWL8CoCxSzcbVkT+1W9ZlazKYMz/h2
         1U+NJdpU2NaPSMv/3Vcpq2YAuJEHuqV6eG6jOOiBvDIozHbxI3BklrmCl45uL2220jUW
         ESl6nOXuVqKatMmHbrqSdiXJkN9Pim4J5Ue8lUTHALCuTETNbMgXoLGGXl/x8o30mu7E
         c4TyKsipejVO9TqPCAFj2Ot6gBV0ui2tytc4Nb1V65qr081j32kxNtvVrCJ0L/mppkvw
         eXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tlN+SR1GxJrZealRnBj4IK5rirhuxkSGuR3XMgHjbM8=;
        b=PFgqUFaNzAjClFSaO7gdf88ya4sPL1g7F9+So5v4KhQDp2TSjY7nUjnZ/i0RTEg3/m
         2xBCD58uy5tf42xPgaikyq+El+wUQYvClDYMqnGa/jhx4PhpiNugJnZASO+9tWvVBfhO
         OOvxFkultj/QdnkanH9bshi6o7x4hZy2n21i+ox1//NFSNV07g+XcXPdEfk7c5RcXL1X
         r4tltqTtKx3CzpHf8Qt/5asDRSQPH9UKwfW0gf7QrlM9Yjt6vmUZl34uajbzE6xSU0CO
         7/C+SSFUbduXQm7oW2GnALKcaFIvzgbXJcReKELuttmFQ33zYPh+Hr3V0P/U71Onmp+g
         GXOw==
X-Gm-Message-State: AOAM5304m/jA6pJ+oCACOTQavfAZazQoG0K7y6d4m8s3GVkRWaQiJIFW
        1WpbCXk2I7xJdM2e8CE9indL3VF/3I5oSzImekwq
X-Google-Smtp-Source: ABdhPJzveLbKd2/fd+yW9COqHniIV8xf3qTx7Ia1dcnpsn0rSIKQjLxMysH9YBtmMRiS0RAcwMxpM8nudC4fcrMjxEQ=
X-Received: by 2002:a17:906:1393:: with SMTP id f19mr3814197ejc.431.1610471735707;
 Tue, 12 Jan 2021 09:15:35 -0800 (PST)
MIME-Version: 1.0
References: <20210108222223.952458-1-lokeshgidra@google.com>
In-Reply-To: <20210108222223.952458-1-lokeshgidra@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Jan 2021 12:15:24 -0500
Message-ID: <CAHC9VhSLFUyeo8he4t7rFoHgRHfpB=URoAioF+a3+xjZP8JdSQ@mail.gmail.com>
Subject: Re: [PATCH v15 0/4] SELinux support for anonymous inodes and UFFD
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        jeffv@google.com, kernel-team@android.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 8, 2021 at 5:22 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
>
> Userfaultfd in unprivileged contexts could be potentially very
> useful. We'd like to harden userfaultfd to make such unprivileged use
> less risky. This patch series allows SELinux to manage userfaultfd
> file descriptors and in the future, other kinds of
> anonymous-inode-based file descriptor.

...

> Daniel Colascione (3):
>   fs: add LSM-supporting anon-inode interface
>   selinux: teach SELinux about anonymous inodes
>   userfaultfd: use secure anon inodes for userfaultfd
>
> Lokesh Gidra (1):
>   security: add inode_init_security_anon() LSM hook
>
>  fs/anon_inodes.c                    | 150 ++++++++++++++++++++--------
>  fs/libfs.c                          |   5 -
>  fs/userfaultfd.c                    |  19 ++--
>  include/linux/anon_inodes.h         |   5 +
>  include/linux/lsm_hook_defs.h       |   2 +
>  include/linux/lsm_hooks.h           |   9 ++
>  include/linux/security.h            |  10 ++
>  security/security.c                 |   8 ++
>  security/selinux/hooks.c            |  57 +++++++++++
>  security/selinux/include/classmap.h |   2 +
>  10 files changed, 213 insertions(+), 54 deletions(-)

With several rounds of reviews done and the corresponding SELinux test
suite looking close to being ready I think it makes sense to merge
this via the SELinux tree.  VFS folks, if you have any comments or
objections please let me know soon.  If I don't hear anything within
the next day or two I'll go ahead and merge this for linux-next.

Thanks.

-- 
paul moore
www.paul-moore.com

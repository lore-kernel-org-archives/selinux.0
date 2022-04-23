Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AC3C433EF
	for <selinux@archiver.kernel.org>; Sat, 23 Apr 2022 07:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiDWHzc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 23 Apr 2022 03:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiDWHzc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 23 Apr 2022 03:55:32 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BF21002
        for <selinux@vger.kernel.org>; Sat, 23 Apr 2022 00:52:36 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id r8so11557708oib.5
        for <selinux@vger.kernel.org>; Sat, 23 Apr 2022 00:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yt0wKLEQjrKINi5m0xsiLmYpbTSdZXboXrOsqeV2f+I=;
        b=FXqZWAxbsL4QH5jEd9JY9qbFvlQHWyN7DpVMU32mGuGujEKXhmIwEIyWiSEhf7CVU+
         fpUrpsYeYUowd8CGIj2SzehBXVfWdqm2WYzXFqvXDrQoHbsz2Ve4PMGIvDuKbiEosnQA
         yWQGxW6TUPKn3hMJVMJ0nS4XBGxyDzMTjyszx1+Z0kMKAN9d4hyiK37gVgK/9Ub5HwVn
         fx4F7lkd8aZ0hIA3R7x2ArR7nql16ouTW/IAPcVr9hg6MiVHMF67RSzbL8DxQRe551NH
         UamfbVmKvvCKuWmoZuApR9wHzwcJoPKto93eAWy+cPk9VQ5iB+m9s0t0Ph9h1BaQ2H3D
         K3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yt0wKLEQjrKINi5m0xsiLmYpbTSdZXboXrOsqeV2f+I=;
        b=4PEmj0SN42G6MerriK0qezeOlnmyFvbvT4ht1Po0kpPcQ8MtBFgW5VVaA8Y0onVujM
         ON1JtqJ7ErtHjUkwcnsCHgmbM/0qIGPcLzM+S/td2otRBaUzbWCRfgFvqgtgduDf0nsc
         vaPDq8HG3T3StSVMuQgRXg5YtPj9ht8itA/v3PeYuq3uBVzxSoP6PIi9hLPd9o8xitEk
         af/gemXJ3gE5EYXlaRpgzPTn5L6ftRngkD0eHtxJfFuwwj6VuxZLLNjIxSEBdUg9HB/l
         LsdJ6yv0ylBLY+C1hTOJcPUnu/p4w+7aFIXqDh5uE5p25EVLUsyADh80nf/J4yfKjGp9
         5GJw==
X-Gm-Message-State: AOAM531S0nSeM0CD5hlFg3b5bCCQF4Z6S3LvowpMGzU0XomqGzBr0Cv/
        wb/A4l/gJ9tFZTlIl0mnuaCR+qriz6mC8zdNABciU+VcH+Q=
X-Google-Smtp-Source: ABdhPJx8uCh7Wyu9YUACCAlZZjpVHwT4ErwIx9qj9Ln5xswwdXqYL9eXOU493cXGlgECeLTmOKoruV6Lqw2C/RnHUCA=
X-Received: by 2002:a05:6808:3009:b0:2f9:6119:d676 with SMTP id
 ay9-20020a056808300900b002f96119d676mr4005546oib.205.1650700355505; Sat, 23
 Apr 2022 00:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220422154307.968527-1-omosnace@redhat.com>
In-Reply-To: <20220422154307.968527-1-omosnace@redhat.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Sat, 23 Apr 2022 09:52:24 +0200
Message-ID: <CAJ2a_DeMsOBd6ybsXXmzhwDnejJhvDVoyOucaAUY63zxN2fFcg@mail.gmail.com>
Subject: Re: [PATCH userspace 0/2] Support the 'self' keyword in type transitions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Dominick Grift <dominick.grift@defensec.nl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 22 Apr 2022 at 17:44, Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> With the addition of the anon_inode class in the kernel, 'self'
> transition rules became useful, but haven't been implemented.
>
> This series implements the self keyword support in the CIL & TE
> languages and the module policydb format. The kernel policydb format
> doesn't need any changes, as type transitions are always expanded in the
> kernel policydb.

Since the type transitions are expanded a single usage of

    type_transition domain self iouring_t:anon_inode "[io_uring]";

will result of thousands of filetrans entries in the binary policy.
When using a limited type-attribute

     type_transition iouring_domain self iouring_t:anon_inode "[io_uring]";

what is the benefit of implementing the interface kernel_iouring_domain() as

    typeattribute $1 iouring_domain;

instead of

    type_transition $1 $1 iouring_t:anon_inode "[io_uring]";

?

Wouldn't true policydb support be much more efficient (not only
regarding size but also (lookup) performance)?

> The patches have been tested using the following WIP beakerlib/tmt test:
> https://src.fedoraproject.org/fork/omos/tests/selinux/blob/self-in-tt/f/libsepol/self-keyword-in-type-transitions
>
> Ondrej Mosnacek (2):
>   libsepol/cil: add support for self keyword in type transitions
>   libsepol,checkpolicy: add support for self keyword in type transitions
>
>  checkpolicy/policy_define.c                |  42 +++++-
>  libsepol/cil/src/cil_binary.c              | 168 +++++++++++++++------
>  libsepol/cil/src/cil_resolve_ast.c         |  25 ++-
>  libsepol/include/sepol/policydb/policydb.h |   4 +-
>  libsepol/src/expand.c                      |  69 ++++++---
>  libsepol/src/link.c                        |   1 +
>  libsepol/src/module_to_cil.c               |  30 ++--
>  libsepol/src/policydb.c                    |  33 +++-
>  libsepol/src/write.c                       |  19 ++-
>  secilc/test/policy.cil                     |   3 +
>  10 files changed, 293 insertions(+), 101 deletions(-)
>
> --
> 2.35.1
>

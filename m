Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB791C352A4
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 20:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66E3217F4
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 20:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iObFqh0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgBLUFR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:05:17 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46980 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgBLUFR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Feb 2020 15:05:17 -0500
Received: by mail-ot1-f66.google.com with SMTP id g64so3185361otb.13
        for <selinux@vger.kernel.org>; Wed, 12 Feb 2020 12:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/kjyX5muGQ72/8Ouh0RejnwRnuJLAGJtwzfYASR2iBI=;
        b=iObFqh0MwgmJdVqLjAmup1k9f6GKi9iyDSX5i98EQ+oFmZYsA+NYEuNGZIPUDJDoN6
         1MJ+lzaW53VaP3jgNuai6vgAz6VsauHIpSoyXFZGDvpLvfksgULcouJZ8v0z3teWmA7b
         u9lpmMz3jQZoJpUSKKLuFy3iluae8wLXPD1VdNs8wX/RXLiV9t8NiO5dbKRCsUQAx8pf
         QMjq7CM57Jozd4ncBrPbtyxl/GxFKqQ/NZNlw7+69Rb+8Dw6l+NpWoT7wls5Q6lINCdO
         631s3GBtUVVwqgfNfy+qcuDu4bxyoowthQlEXc+/O9Xv+DbHJI7s8TD8X+FCq0Z3pYqg
         8AFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/kjyX5muGQ72/8Ouh0RejnwRnuJLAGJtwzfYASR2iBI=;
        b=RV8K0mnwyrceZi85TfhQ5DDH3dhIY4QNb4XRvwSabnTOdp8XGSMCYYAspD9moU5BVM
         /tiQ2mAGX/888mHWcvkqNHvSc8MggvPq1sRFUy5x9YXPa5pnsoH9fGBCSUsx3QI73A7y
         +F5D3QCM39E8i4jW+wKqyOvAP26/Vl9WOMmcjygmdyIG5gpm0GpfIVS8e3ROcg7JCO1W
         w6XoVV1zXLyeZ9OcvghI/IMC9Apy81YYnnAYMcvBrSJU81p2DxnajI+HVlJIzTeUzuNx
         p/mlvaWijnURhW/SSJ99nQ+eDR/jIpUXzVBNFe5iOsXdp5fO3jR7nuM+mIHL7fUw3k6z
         nSCg==
X-Gm-Message-State: APjAAAXFHG9J0DZDWFGR0ns7vXOWxbOeKtHTVJLPUoLraHqV7CW463/d
        R/EjSOx+mue/FWA4X3WqmSuv3vEbpb3YoMPYgIBrsw==
X-Google-Smtp-Source: APXvYqxUKGCdfnEC2TtaAhESS1iOD+ffWkDt+ePRPY5e31xLSZmoQ1cPYQtaMXUCk4za5gWmbKRZY4hW7F+6oLDcRgk=
X-Received: by 2002:a9d:34c:: with SMTP id 70mr3416728otv.174.1581537915705;
 Wed, 12 Feb 2020 12:05:15 -0800 (PST)
MIME-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com> <202002112332.BE71455@keescook>
 <CAG48ez0ogRxvCK1aCnviN+nBqp6gmbUD7NjaMKvA7bF=esAc1A@mail.gmail.com>
 <20200212171416.GD1083891@xz-x1> <20200212194100.GA29809@redhat.com>
In-Reply-To: <20200212194100.GA29809@redhat.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 12 Feb 2020 12:04:39 -0800
Message-ID: <CAKOZuevusieaKCt5r-jnQ5ArGfw5Otszq2CAcrqFi6MYxkKwtA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Harden userfaultfd
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Tim Murray <timmurray@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Nick Kralevich <nnk@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 12, 2020 at 11:41 AM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> Hello everyone,
>
> On Wed, Feb 12, 2020 at 12:14:16PM -0500, Peter Xu wrote:
> > Right. AFAICT QEMU uses it far more than disk IOs.  A guest page can
> > be accessed by any kernel component on the destination host during a
> > postcopy procedure.  It can be as simple as when a vcpu writes to a
> > missing guest page which still resides on the source host, then KVM
> > will get a page fault and trap into userfaultfd asking for that page.
> > The same thing happens to other modules like vhost, etc., as long as a
> > missing guest page is touched by a kernel module.
>
> Correct.
>
> How does the android garbage collection work to make sure there cannot
> be kernel faults on the missing memory?

We don't pass pointers to the heap into system calls. (Big primitive
arrays, ByteBuffer, etc. are allocated off the regular heap.)

> If I understood correctly (I didn't have much time to review sorry)
> what's proposed with regard to limiting uffd events from kernel
> faults,

I don't understand what you mean. The purpose of preventing UFFD from
handling kernel faults is exploit mitigation.

> the only use case I know that could deal with it is the
> UFFD_FEATURE_SIGBUS but that's not normal userfaultfd: that's also the
> only feature required from uffd to implement a pure malloc library in
> userland that never takes the mmap sem for writing to implement
> userland mremap/mmap/munmap lib calls (as those will convert to
> UFFDIO_ZEROPAGE and MADV_DONTNEED internally to the lib and there will
> be always a single vma). We just need to extend UFFDIO_ZEROPAGE to map
> the THP zeropage to make this future pure-uffd malloc lib perform
> better.

The key requirement here is the ability to prevent unprivileged
processes from using UFFD to widen kernel exploit windows by
preventing UFFD from taking kernel faults. Forcing unprivileged
processes to use UFFD only with UFFD_FEATURE_SIGBUS would satisfy this
requirement, but it's much less flexible and unnecessarily couples two
features.

> On the other end I'm also planning a mremap_vma_merge userland syscall
> that will merge fragmented vmas.

This is probably a separate discussion, but does that operation really
need to be a system call? Historically, userspace has operated mostly
on page ranges and not VMAs per se, and the kernel has been free to
merge and split VMAs as needed for its internal purposes. This
approach has serious negative side effects (like making munmap
fallible: see [1]), but it is what it is.

[1] https://lore.kernel.org/linux-mm/CAKOZuetOD6MkGPVvYFLj5RXh200FaDyu3sQqZviVRhTFFS3fjA@mail.gmail.com/

> Currently once you have a nice heap all contiguous but with small
> objects and you free the fragments you can't build THP anymore even if
> you make the memory virtually contiguous again by calling mremap. That
> just build up a ton of vmas slowing down the app forever and also
> preventing THP collapsing ever again.

Shouldn't the THP background kthread take care of merging VMAs?

> mremap_vma_merge will require no new kernel feature, but it
> fundamentally must be able to handle kernel faults. If databases
> starts to use that, how can you enable this feature without breaking
> random apps then?

Presumably, those apps wouldn't issue the system call on address
ranges managed with a non-kernel-fault UFFD.

> So it'd be a feature usable only by one user (Android) perhaps? And
> only until you start defragging the vmas of small objects?

We shouldn't be fragmenting at all, either at the memory level or the
VMA level. The GC is a moving collector, and we don't punch holes in
the heap.

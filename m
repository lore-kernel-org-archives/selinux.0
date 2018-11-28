Return-Path: <SRS0=Np7y=OH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3E5C43441
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 16:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E182081C
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 16:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E182081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbeK2DOY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:14:24 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37259 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbeK2DOX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Nov 2018 22:14:23 -0500
Received: by mail-oi1-f195.google.com with SMTP id y23so23029526oia.4
        for <selinux@vger.kernel.org>; Wed, 28 Nov 2018 08:12:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRBEwV4lXH2NqZ3dGXs+t0yBQpOod+4VI41GBdsFZp0=;
        b=CSsAZf2ajX7YPLoi5/y2pmvY79vBXWtnLKwTVAXEw5vBYHM6hY04us3GKjq6DkLE/J
         BiQ2601NHFvFxoCCYiDbvmygbT7Mp1Io9iHPxG0frABya+4FhLS9JOXj7dMCJefIWfgc
         +wt2eq8D5DomWdGlK7Xbcz6GzkdDN3cTQkts5JGISFbk7caBQkrXZReJxtI6KeIsrDIn
         /djjZcQt/shGGDzTDBCHYTB6O6uso8TXo2smj/uODysgp34DhTesMAO0i0yZl1iouZ6X
         76yQ9C92EuOU/HJL6z4jdTqYLu/fYFWvSj6vxS/SqxxGtrmjbM7fuuQhss0dknMcFpqG
         Us/Q==
X-Gm-Message-State: AA+aEWYRoAUtcOTHbWR/O6vBOaxE1I9OkN63MzylUkFFoEsCTzui9F5F
        tWb++QYeysaJQkCyrhArEoiuEDE1+EPmrvt3bvLVcA==
X-Google-Smtp-Source: AFSGD/VXGAKl818U1JfjPn1mt1FQTu+naRm4++rQlqGjL430CnU6Zze6IJcdpKlsn848CVmlEf4SYkAc+C4jS0VADW0=
X-Received: by 2002:aca:5ac5:: with SMTP id o188-v6mr10985031oib.146.1543421531833;
 Wed, 28 Nov 2018 08:12:11 -0800 (PST)
MIME-Version: 1.0
References: <20181116131202.26513-1-omosnace@redhat.com> <CAHC9VhTn9qz77PQ3mboaCsNzK9D8hjYFg9z5sCWr8Yb7W2Pqxg@mail.gmail.com>
 <CAFqZXNsAHnV5RzwtONF0hJRy31qb4c=sajvaEkmEjjky4duEBA@mail.gmail.com>
 <CAFqZXNvSdKYr998v3hEhZu4pRwuQs8Q7qRWPhOAtLAc9__Bs6w@mail.gmail.com>
 <CAHC9VhTvuPvnkfgQhT4+AM3iEz4_p85QgShM_oXmpVtLKuq10Q@mail.gmail.com> <87r2f5fbw7.fsf@xmission.com>
In-Reply-To: <87r2f5fbw7.fsf@xmission.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 28 Nov 2018 17:12:00 +0100
Message-ID: <CAFqZXNsxH2TMU-ZxxfzvqPcwQ9FzUj1N3iS-7AVQ3JZvj2KEYA@mail.gmail.com>
Subject: Re: [PATCH] selinux: always allow mounting submounts
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Eric,

On Wed, Nov 28, 2018 at 4:42 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
>
> > On Wed, Nov 21, 2018 at 10:38 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >> On Wed, Nov 21, 2018 at 1:41 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >> > On Tue, Nov 20, 2018 at 11:09 PM Paul Moore <paul@paul-moore.com> wrote:
> >> > > On Fri, Nov 16, 2018 at 8:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >> > > > If a superblock has the MS_SUBMOUNT flag set, we should always allow
> >> > > > mounting it. These mounts are done automatically by the kernel either as
> >> > > > part of mounting some parent mount (e.g. debugfs always mounts tracefs
> >> > > > under "tracing" for compatibility) or they are mounted automatically as
> >> > > > needed on subdirectory accesses (e.g. NFS crossmnt mounts). Since such
> >> > > > automounts are either an implicit consequence of the parent mount (which
> >> > > > is already checked) or they can happen during regular accesses (where it
> >> > > > doesn't make sense to check against the current task's context), the
> >> > > > mount permission check should be skipped for them.
> >> > > >
> >> > > > Without this patch, attempts to access contents of an automounted
> >> > > > directory can cause unexpected SELinux denials.
> >> > > >
> >> > > > In the current kernel tree, the MS_SUBMOUNT flag is set only via
> >> > > > vfs_submount(), which is called only from the following places:
> >> > > >  - AFS, when automounting special "symlinks" referencing other cells
> >> > > >  - CIFS, when automounting "referrals"
> >> > > >  - NFS, when automounting subtrees
> >> > > >  - debugfs, when automounting tracefs
> >> > > >
> >> > > > In all cases the submounts are meant to be transparent to the user and
> >> > > > it makes sense that if mounting the master is allowed, then so should be
> >> > > > the automounts. Note that CAP_SYS_ADMIN capability checking is already
> >> > > > skipped for (SB_KERNMOUNT|SB_SUBMOUNT) in:
> >> > > >  - sget_userns() in fs/super.c:
> >> > > >         if (!(flags & (SB_KERNMOUNT|SB_SUBMOUNT)) &&
> >> > > >             !(type->fs_flags & FS_USERNS_MOUNT) &&
> >> > > >             !capable(CAP_SYS_ADMIN))
> >> > > >                 return ERR_PTR(-EPERM);
> >> > > >  - sget() in fs/super.c:
> >> > > >         /* Ensure the requestor has permissions over the target filesystem */
> >> > > >         if (!(flags & (SB_KERNMOUNT|SB_SUBMOUNT)) && !ns_capable(user_ns, CAP_SYS_ADMIN))
> >> > > >                 return ERR_PTR(-EPERM);
> >> > > >
> >> > > > Verified internally on patched RHEL 7.6 with a reproducer using
> >> > > > NFS+httpd and selinux-tesuite.
> >> > >
> >> > > I think this all sounds reasonable, but please verify this with an
> >> > > upstream kernel.  Upstream our focus is on the upstream kernel
> >> > > (surprise!), downstream RHEL is your responsibility, not ours :)
> >> >
> >> > I tested on RHEL because that's what I can do most conveniently. I
> >> > don't have a very good workflow/environment for complex testing on
> >> > upstream right now. I don't expect the results to be any different on
> >> > the upstream kernel, but I understand your concern. I have been
> >> > thinking about some patch testing automation using Fedora Rawhide (I
> >> > hope that's close enough to upstream at least :), so I guess it's time
> >> > to get scriptin'...
> >>
> >> I have now tested it on Fedora Rawhide with a scratch kernel with this
> >> patch applied [1] (x86_64 only). I ran the whole selinux-testsuite
> >> with the submount test [2] and everything passed (except for the known
> >> overlay failures and skipped binder test) ...
> >
> > Merged into selinux/next, thanks.
>
>
> A few late comments on this.
>
> The change mentioned in fixes did not remove a SB_KERNMOUNT so I don't
> see how it is a fix for that.  That change just added SB_SUBMOUNT so you
> can test for and detect this situation.  Are you seeing something that I
> am not in that change?

No, you're right that this patch doesn't "fix" that commit in the
usual sense (the bug has pretty much always been there). However, that
commit is the one that introduces the SB_KERNMOUNT flag and thus this
patch can be only applied on trees that have that commit. That's what
I tried to communicate with the "Fixes:" tag. Maybe I abused it a
little, but it is often used to guide backporting so I figured it
would make sense like this.

>
> I expect what we need for the long term is to move sb_kern_mount except
> for the security mount option bits into do_new_mount so security modules
> don't have to perform funny checks because the security hook is in the
> wrong place.
>
> Further as far as I can tell from reading the code every filesystem that
> performs submounts except for nfs is broken.  As no one else calls
> security_sb_clone_mnt_opts.  Instead the normal mnt_opts hooks are
> called with no security mount options.
>
> Which leads me to point that smack doesn't even implement
> sb_clone_mnt_opts so I expect smack gets the security mount options
> wrong.
>
> Is it common to specify the security mount options on filesystems?
> I see the code.  I see what needs to be done to keep them working.
> (Commas in options names ick).  I don't understand how they are used and
> how common they are.
>
> I care because the vfs is in the middle of some work to clean up this
> side of mounting and at the very least I am review changes and spotting
> bugs.  Understanding how the security mount options work from the
> perspective of someone who actually uses them would be a real help.
>
> Eric
--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.

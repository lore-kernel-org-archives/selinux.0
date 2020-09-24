Return-Path: <SRS0=GjD/=DB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F95BC4727D
	for <selinux@archiver.kernel.org>; Thu, 24 Sep 2020 08:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39FEF23787
	for <selinux@archiver.kernel.org>; Thu, 24 Sep 2020 08:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNTuk2HN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbgIXIg2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Sep 2020 04:36:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31967 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727274AbgIXIg2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Sep 2020 04:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600936586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pzQp6I+V1PpgUmUBjnZiaJfAbFSvWuD01LuVIXqzG1g=;
        b=BNTuk2HNxL7MxT4WK1IIb9xY0SkNSQomtGDR83+hduROPtsaxVMtWs6/OKYULhrlaFi0UN
        /tBll8V8F3o4w/WfGoD/24tGcBD73Q562GZA00H0VaXPgPfkPZny0rQGwQyAVObtDVvmLd
        wWLQ2M+c4jzSR7eEBx7TlxUukO+gs9o=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318--jcn7UfsOwS-fbeL14m7DA-1; Thu, 24 Sep 2020 04:36:24 -0400
X-MC-Unique: -jcn7UfsOwS-fbeL14m7DA-1
Received: by mail-lf1-f69.google.com with SMTP id a81so769780lfd.1
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2020 01:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pzQp6I+V1PpgUmUBjnZiaJfAbFSvWuD01LuVIXqzG1g=;
        b=PgkcGR6oQSjsc9vMMl+XPrZGD7E0r9Acc7/O4DvSlRVraJJUE+0ftDmJgYixIxqSRZ
         tAxxXyRPqzI46DRmtJgMp5rmdgKJuww/Mvo7dxBTBAJkO3+nfM28WZ0nT6sUFoZ4r6iJ
         eau10SIgQlmGzyVq7EY4/tSrdCEWiC4IM91ovCLBfRGr3LuVxrBJQh4H8IiC5pgFxt9t
         WrTOjnvHhwGfVItiF8fDG48pBFRo+2/3u3sC9J5LuPxUdhGTQyppVzDBoZ5LErzzEgLA
         hyd8fOIvXvrHVod/cXuCcvnGGWgtqulNmImZQyLTVOcYmI89Fs7cp2QYYLm48UOCVTL/
         oM7Q==
X-Gm-Message-State: AOAM532Bk3Hm1BGq+Akfkab+WaomlPCGMTwdQH8rPc4I+pp1wCUJnPQ7
        4rWWk1+UephLUKkTZns+3qwGIabL+E4cYXfzHctxNLrjPH83nDqJPdTUTx+3wlAreQlDrDucYat
        IkbRz2WmYlG/E2rDm4oTnMi8gK+/IrrFb9A==
X-Received: by 2002:a05:651c:38d:: with SMTP id e13mr1164346ljp.38.1600936582720;
        Thu, 24 Sep 2020 01:36:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQwAN9kTcpiIavNDFX0BP9+BwlR9LIbrRVFkkN1U2LUk5fFl+lGkmoeqOw9fh/MuhTDCVPXdsWMAZcplo/xZU=
X-Received: by 2002:a05:651c:38d:: with SMTP id e13mr1164335ljp.38.1600936582355;
 Thu, 24 Sep 2020 01:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
 <20200921160922.GA23870@lst.de> <20200921163011.GZ3421308@ZenIV.linux.org.uk>
 <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com> <0764629d33d151aee743d0429ac87a5b0c300235.camel@themaw.net>
In-Reply-To: <0764629d33d151aee743d0429ac87a5b0c300235.camel@themaw.net>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 24 Sep 2020 10:36:11 +0200
Message-ID: <CAFqZXNsqD73hptXxBn+g98ngbFd=Sx+CghtwVqM+NC47VFZhVQ@mail.gmail.com>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
To:     Ian Kent <raven@themaw.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        autofs@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Zdenek Pytela <zpytela@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 23, 2020 at 3:55 AM Ian Kent <raven@themaw.net> wrote:
> On Tue, 2020-09-22 at 09:33 +0200, Ondrej Mosnacek wrote:
> > On Mon, Sep 21, 2020 at 6:30 PM Al Viro <viro@zeniv.linux.org.uk>
> > wrote:
> > > On Mon, Sep 21, 2020 at 06:09:22PM +0200, Christoph Hellwig wrote:
> > > > [adding Linus and Al]
> > > >
> > > > On Mon, Sep 21, 2020 at 04:51:35PM +0200, Ondrej Mosnacek wrote:
> > > > > Hi folks,
> > > > >
> > > > > It seems that after commit 13c164b1a186 ("autofs: switch to
> > > > > kernel_write") there is now an extra LSM permission required
> > > > > (for the
> > > > > current task to write to the automount pipe) for processes
> > > > > accessing
> > > > > some yet-to-to-be mounted directory on which an autofs mount is
> > > > > set
> > > > > up. The call chain is:
> > > > > [...]
> > > > > autofs_wait() ->
> > > > > autofs_notify_daemon() ->
> > > > > autofs_write() ->
> > > > > kernel_write() ->
> > > > > rw_verify_area() ->
> > > > > security_file_permission()
> > > > >
> > > > > The bug report that led me to this commit is at [1].
> > > > >
> > > > > Technically, this is a regression for LSM users, since this is
> > > > > a
> > > > > kernel-internal operation and an LSM permission for the current
> > > > > task
> > > > > shouldn't be required. Can this patch be reverted? Perhaps
> > > > > __kernel_{read|write}() could instead be renamed to
> > > > > kernel_*_nocheck()
> > > > > so that the name is more descriptive?
> > > >
> > > > So we obviously should not break existing user space and need to
> > > > fix
> > > > this ASAP.  The trivial "fix" would be to export __kernel_write
> > > > again
> > > > and switch autofs to use it.  The other option would be a FMODE
> > > > flag
> > > > to bypass security checks, only to be set if the callers ensures
> > > > they've been valided (i.e. in autofs_prepare_pipe).
> >
> > IMHO that sounds like an overkill in this scenario. I don't think it
> > makes sense to do the LSM check here (or at least not against the
> > current task's creds), because it is not the current task that wants
> > to communicate with the daemon, it just wants to to access some
> > directory on the system that just happens to be special to the
> > kernel,
> > which needs to do some communication on the side to service this
> > request. So if we do want to do any LSM check here, there should at
> > least be some "bool internal" flag passed to the LSM, signalizing
> > that
> > this is an internal read/write operation that wasn't directly
> > initiated/requested by the current process. SELinux could then either
> > use the kernel secid instead of the current task's secid or skip the
> > check completely in such case.
>
> Perhaps, but see below.
>
> >
> > I'd like Stephen to weigh in on this, but it looks he might be on
> > vacation right now...
> >
> > > > Any opinions?
> > >
> > > Reexport for now.  Incidentally, what is LSM doing rejecting writes
> > > into a pipe?
> >
> > With SELinux at least, what is allowed or denied is defined in the
> > policy. And the policy usually defaults to everything denied and then
> > you add rules to allow what needs (and makes sense) to be allowed.
> > Since until kernel 5.8 random processes didn't need to write to pipes
> > created by the automount daemon, it has never been explicitly allowed
> > and so the automounting now fails. It is in no way obvious that all
> > processes should have the permission to talk to the automount daemon
> > just to traverse the filesystem...
>
> I think you might have misunderstood what lead to this, just a bit.
>
> Previously the __kern_write() function was used for this communication
> and Christoph's patch changed that to use kern_write() instead.
>
> In theory that's a good idea because kern_write() adds some additional
> sanity checks, one being a call to rw_verify_area() which is where the
> security_file_permission() call fails.
>
> So previously any random process could avoid these checks by calling
> __kern_write() so the change to kern_write() is, in theory, that's a
> good thing and simply reverting that hunk in Christoph's patch
> probably isn't the best thing to do.

I understand that and I'm not proposing the revert as a long-term fix.
For a long-term solution I propose using kernel_write() and extending
it to allow the caller to suppress (just) the
security_file_permission() call. Then each caller would have to decide
whether the LSM check makes sense in that situation or not. It seems
safer against future mistakes than leaving it up to the caller to call
security_file_permission() explicitly (I predict that no new user
would even realize that the call might be needed).

>
> But any random process does need to be able to write to the automount
> daemon pipe for trailing path components and the root dentry of autofs
> mounts, depending on case.
>
> So it's true that any write to any autofs dentry probably doesn't
> need to be allowed but I question what that gets us in terms of
> security improvement over allowing pipe writes for automount_t
> labelled pipes in selinux policy since they must be within an autofs
> mounted file system.

The difference is not in security, but in usability. The kernel
communicating with the autofs daemon is an internal detail that
shouldn't need special rules in policy. Even if we want to do any LSM
checking here, the subject should be kernel_t, not the current running
process. The process doesn't have any control on whether the kernel
does the communication and it doesn't control the content of the
communication, so the permission check as it is doesn't make any
sense. People writing the policy should be burdened by low-level
details about how the kernel works internally as little as possible.

>
> But Stephen has a different recommendation (and that appears to
> consider the cause I outlined above) so I'll wait to see what others
> think about the recommendations.

As I said above, I think Stephen's approach is less future-proof. And
it seems that rw_verify_area() has many other callers, most/all of
which probably service actual requests from userspace and we'd need to
retain the security_file_permission() call in those cases.

Let me try to put my proposal into a patch, so we have something
concrete to talk about...

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.


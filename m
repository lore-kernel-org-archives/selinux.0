Return-Path: <SRS0=TLac=DC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0554C4727C
	for <selinux@archiver.kernel.org>; Fri, 25 Sep 2020 13:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F48520878
	for <selinux@archiver.kernel.org>; Fri, 25 Sep 2020 13:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7khhDnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgIYNiT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Sep 2020 09:38:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728641AbgIYNiS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Sep 2020 09:38:18 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601041096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iQnzFWAdeAe6WY95XobLeXkTFapJnpBOtUwG9I4Ug4E=;
        b=c7khhDnQ8pjUqSnST/14PCpuTFOj5bA9aeOlYtK2FgcjzS0LtcAUfyU8/YjcmJ9dSkFbMi
        hvWB9U2Mg1QOKnK26cJvfa4GvpAm7itZnawfgMoS+CE7jYDB7NeN80pwYhJU0Wc23vjM1V
        5aKqElWuxILWGbFlT/wQoO1qBKL5NDg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-9WzMLB9oNFu27sgUBQqosA-1; Fri, 25 Sep 2020 09:38:10 -0400
X-MC-Unique: 9WzMLB9oNFu27sgUBQqosA-1
Received: by mail-lj1-f200.google.com with SMTP id p3so1047608ljc.7
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2020 06:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQnzFWAdeAe6WY95XobLeXkTFapJnpBOtUwG9I4Ug4E=;
        b=dIvA8iKI8NtNlxmPq2DeoUAI6jlNxeMLuc/Zui3TAIPl1BaZ9cdDw6/bO7+6bdv2Rj
         5VaNQYHeWumZL3beG3rczbQJt241VrfDhoXGEZYgPQHhIBSLPvBRm+D+u9zu8ZWKsQxX
         HJCezkdAm1CeGrAJn1Ts1z5BLcYTyp71dNIoBjQKLZ5FmiAw9OSdzyStl35yCO0cMGHJ
         FKahOeOswhbeonFJXJHy4FaO96Qw6U4G4TL9RBJD694JV1eTOI/Dajkp0+Hsf4quqZOW
         ns8Td8Z1q9hmOucoKzULFtvZGDZ+muACC1JshkhnZ3tg6bq/i6ryLnugYd2EbCfzlRYD
         53sA==
X-Gm-Message-State: AOAM530OY5veCLB8fFcBO7/vkltRdd0zfG56qauzOznp2hySgAEDWR/C
        L9VmWlJ+mOMsD0Sf5zk9aDddWL+OdSSND/bk6gzeUeqXdbSvgZlgIhDaUlYwkhAVRp5MlBEcUr9
        gVbbeN8QDBPYqcOVAH3QK79X4cXjfaFkEKQ==
X-Received: by 2002:a19:4a0b:: with SMTP id x11mr1508824lfa.354.1601041089140;
        Fri, 25 Sep 2020 06:38:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxODIfqhG8fjvX9GdIvn/jJUH97N9yYt4N6KOJkpUvJsoeh+xdzPOdX5Hp4c2XiJw0NgkZyuF1VHYFQ0m+JlPs=
X-Received: by 2002:a19:4a0b:: with SMTP id x11mr1508780lfa.354.1601041087307;
 Fri, 25 Sep 2020 06:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
 <20200921160922.GA23870@lst.de> <20200921163011.GZ3421308@ZenIV.linux.org.uk>
 <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com>
 <0764629d33d151aee743d0429ac87a5b0c300235.camel@themaw.net>
 <CAFqZXNsqD73hptXxBn+g98ngbFd=Sx+CghtwVqM+NC47VFZhVQ@mail.gmail.com> <CAEjxPJ4oZvtqUpW0bMzoZwVsi9kDvL5LtouHQZAO7gM7_qyHMg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4oZvtqUpW0bMzoZwVsi9kDvL5LtouHQZAO7gM7_qyHMg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 25 Sep 2020 15:37:56 +0200
Message-ID: <CAFqZXNs0oZ+_RNvwE-e62H2FSS=N4wbvJ+tgk0_dSn=5mbPhcw@mail.gmail.com>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, autofs@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Zdenek Pytela <zpytela@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 24, 2020 at 4:16 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Sep 24, 2020 at 4:36 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Wed, Sep 23, 2020 at 3:55 AM Ian Kent <raven@themaw.net> wrote:
> > > On Tue, 2020-09-22 at 09:33 +0200, Ondrej Mosnacek wrote:
> > > > On Mon, Sep 21, 2020 at 6:30 PM Al Viro <viro@zeniv.linux.org.uk>
> > > > wrote:
> > > > > On Mon, Sep 21, 2020 at 06:09:22PM +0200, Christoph Hellwig wrote:
> > > > > > [adding Linus and Al]
> > > > > >
> > > > > > On Mon, Sep 21, 2020 at 04:51:35PM +0200, Ondrej Mosnacek wrote:
> > > > > > > Hi folks,
> > > > > > >
> > > > > > > It seems that after commit 13c164b1a186 ("autofs: switch to
> > > > > > > kernel_write") there is now an extra LSM permission required
> > > > > > > (for the
> > > > > > > current task to write to the automount pipe) for processes
> > > > > > > accessing
> > > > > > > some yet-to-to-be mounted directory on which an autofs mount is
> > > > > > > set
> > > > > > > up. The call chain is:
> > > > > > > [...]
> > > > > > > autofs_wait() ->
> > > > > > > autofs_notify_daemon() ->
> > > > > > > autofs_write() ->
> > > > > > > kernel_write() ->
> > > > > > > rw_verify_area() ->
> > > > > > > security_file_permission()
> > > > > > >
> > > > > > > The bug report that led me to this commit is at [1].
> > > > > > >
> > > > > > > Technically, this is a regression for LSM users, since this is
> > > > > > > a
> > > > > > > kernel-internal operation and an LSM permission for the current
> > > > > > > task
> > > > > > > shouldn't be required. Can this patch be reverted? Perhaps
> > > > > > > __kernel_{read|write}() could instead be renamed to
> > > > > > > kernel_*_nocheck()
> > > > > > > so that the name is more descriptive?
> > > > > >
> > > > > > So we obviously should not break existing user space and need to
> > > > > > fix
> > > > > > this ASAP.  The trivial "fix" would be to export __kernel_write
> > > > > > again
> > > > > > and switch autofs to use it.  The other option would be a FMODE
> > > > > > flag
> > > > > > to bypass security checks, only to be set if the callers ensures
> > > > > > they've been valided (i.e. in autofs_prepare_pipe).
> > > >
> > > > IMHO that sounds like an overkill in this scenario. I don't think it
> > > > makes sense to do the LSM check here (or at least not against the
> > > > current task's creds), because it is not the current task that wants
> > > > to communicate with the daemon, it just wants to to access some
> > > > directory on the system that just happens to be special to the
> > > > kernel,
> > > > which needs to do some communication on the side to service this
> > > > request. So if we do want to do any LSM check here, there should at
> > > > least be some "bool internal" flag passed to the LSM, signalizing
> > > > that
> > > > this is an internal read/write operation that wasn't directly
> > > > initiated/requested by the current process. SELinux could then either
> > > > use the kernel secid instead of the current task's secid or skip the
> > > > check completely in such case.
> > >
> > > Perhaps, but see below.
> > >
> > > >
> > > > I'd like Stephen to weigh in on this, but it looks he might be on
> > > > vacation right now...
> > > >
> > > > > > Any opinions?
> > > > >
> > > > > Reexport for now.  Incidentally, what is LSM doing rejecting writes
> > > > > into a pipe?
> > > >
> > > > With SELinux at least, what is allowed or denied is defined in the
> > > > policy. And the policy usually defaults to everything denied and then
> > > > you add rules to allow what needs (and makes sense) to be allowed.
> > > > Since until kernel 5.8 random processes didn't need to write to pipes
> > > > created by the automount daemon, it has never been explicitly allowed
> > > > and so the automounting now fails. It is in no way obvious that all
> > > > processes should have the permission to talk to the automount daemon
> > > > just to traverse the filesystem...
> > >
> > > I think you might have misunderstood what lead to this, just a bit.
> > >
> > > Previously the __kern_write() function was used for this communication
> > > and Christoph's patch changed that to use kern_write() instead.
> > >
> > > In theory that's a good idea because kern_write() adds some additional
> > > sanity checks, one being a call to rw_verify_area() which is where the
> > > security_file_permission() call fails.
> > >
> > > So previously any random process could avoid these checks by calling
> > > __kern_write() so the change to kern_write() is, in theory, that's a
> > > good thing and simply reverting that hunk in Christoph's patch
> > > probably isn't the best thing to do.
> >
> > I understand that and I'm not proposing the revert as a long-term fix.
> > For a long-term solution I propose using kernel_write() and extending
> > it to allow the caller to suppress (just) the
> > security_file_permission() call. Then each caller would have to decide
> > whether the LSM check makes sense in that situation or not. It seems
> > safer against future mistakes than leaving it up to the caller to call
> > security_file_permission() explicitly (I predict that no new user
> > would even realize that the call might be needed).
> >
> > >
> > > But any random process does need to be able to write to the automount
> > > daemon pipe for trailing path components and the root dentry of autofs
> > > mounts, depending on case.
> > >
> > > So it's true that any write to any autofs dentry probably doesn't
> > > need to be allowed but I question what that gets us in terms of
> > > security improvement over allowing pipe writes for automount_t
> > > labelled pipes in selinux policy since they must be within an autofs
> > > mounted file system.
> >
> > The difference is not in security, but in usability. The kernel
> > communicating with the autofs daemon is an internal detail that
> > shouldn't need special rules in policy. Even if we want to do any LSM
> > checking here, the subject should be kernel_t, not the current running
> > process. The process doesn't have any control on whether the kernel
> > does the communication and it doesn't control the content of the
> > communication, so the permission check as it is doesn't make any
> > sense. People writing the policy should be burdened by low-level
> > details about how the kernel works internally as little as possible.
> >
> > >
> > > But Stephen has a different recommendation (and that appears to
> > > consider the cause I outlined above) so I'll wait to see what others
> > > think about the recommendations.
> >
> > As I said above, I think Stephen's approach is less future-proof. And
> > it seems that rw_verify_area() has many other callers, most/all of
> > which probably service actual requests from userspace and we'd need to
> > retain the security_file_permission() call in those cases.
> >
> > Let me try to put my proposal into a patch, so we have something
> > concrete to talk about...
>
> Up-thread I thought Linus indicated he didn't really want a flag to
> disable pemission checking due to potential abuse (and I agree).

IIUC he was against adding an FMODE flag, while I was rather
suggesting a new function parameter (I realize it probably wasn't
clear from what I wrote). The latter is less prone to accidents and
any new user would have to set that parameter to *something* and so
would be forced to think about whether he needs an LSM check or not.
Whereas with a separate _nosec()/nolsmcheck()/_whatever() function
they would likely just use the kernel_write() function they already
know and may not even realize that there is some decision to be made.

But that's just my opinion, I would still be happier with a separate
function than reverting to __kernel_write().

> Historically we have taken one of two approaches for these situations:
> 1) Provide a separate interface like kernel_write() for use when we
> don't want permission checking and don't have it call the security
> hook at all.  If you prefer kernel_write_nosec() that's fine but I
> think that's somewhat implicit in the fact that it is a
> kernel-initiated write, not a userspace write (which would hopefully
> go through vfs_write() or similar and end up calling the hook).

Unfortunately not all of the kernel_write() calls seem to be of the
kind that we want to skip the permission checking. One in particular
that caught my attention is this btrfs one:
https://elixir.bootlin.com/linux/v5.9-rc6/source/fs/btrfs/send.c#L561

Basically a userspace process passes some fd via ioctl and kernel then
writes something in it. If we don't do any check here (and BTW we in
fact want the current's creds to apply here), then the process could
pass any open fd and bypass any LSM write permissions to the file
behind that fd. Possibly there are some checks that restrict what can
be passed there (I didn't check), but it would still be fragile to
rely on them.

So I guess we can't just skip the check whenever the kernel_*()
function is called.

> 2) Temporarily override creds to the init_cred or the result of
> prepare_kernel_creds() before calling any credential-checking
> functions and then revert creds afterward.

Most users of kernel_write() seem to also create/open the file
themselves, usually using the current's creds, so this would break
consistency when applied universally. Autofs (and also
bpfilter_send_req()) are special in that they first get the fd from a
userspace process and then write into it from other tasks' syscalls.
Then there are one or two users that create the file using
shmem_kernel_file_setup(), which does use prepare_kernel_creds(), but
the resulting file is marked S_PRIVATE, so all LSM checks are already
skipped for it anyway.

>
> The problem with #2 is that it still requires that the policy allow
> kernel_t (or its equivalent) to be able to write to these pipes, which
> wasn't previously necessary and thus might not be allowed in all
> policies (e.g. Android?).  #1 avoids any need for policy for these
> operations.

Yeah, I'm starting to think checking "kernel creds -> userspace
object" access vectors on purpose doesn't make much sense... you would
pretty much want to always allow that (no point in kernel blocking its
own operations) so just skipping the check in those cases where using
the current's creds doesn't make sense seems to be a better choice.

BTW, I don't have the candidate patch written yet, as I haven't had
time and also need to process new information after having reviewed
the existing callers.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.


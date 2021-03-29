Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8ADC433F7
	for <selinux@archiver.kernel.org>; Mon, 29 Mar 2021 09:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE4161932
	for <selinux@archiver.kernel.org>; Mon, 29 Mar 2021 09:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhC2JEw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Mar 2021 05:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33967 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233500AbhC2JBP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Mar 2021 05:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617008474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OrgmkciYonWeIgpgOtEXpl2RAqGvW2vNKHn+OAB2AZo=;
        b=WgDG94EKYyQea6RDvoS15gpFFfvtDtC+OCV0VKKKwKQ1WNl8wc7bMmbJcM9dcW1TfNZjJn
        YB5GT0RRKjdkF5BLdtrD7D6nc3EG215nC2BHgrB1ONZ66oQHETGjS2xYEj48bJjMO5NtQg
        p4G56qUJuUt4xDuH6mhAaaN6qrG6088=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-byREdal7PIe6RicaalWUfw-1; Mon, 29 Mar 2021 05:00:53 -0400
X-MC-Unique: byREdal7PIe6RicaalWUfw-1
Received: by mail-yb1-f199.google.com with SMTP id w7so16684160ybq.4
        for <selinux@vger.kernel.org>; Mon, 29 Mar 2021 02:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OrgmkciYonWeIgpgOtEXpl2RAqGvW2vNKHn+OAB2AZo=;
        b=gF43Gptkhp0YO/0CLH3YXPNpwWYGSqSB4IUXblSmI0sIK16okLnDzNBKPPl/F9G0qg
         erhT1T1/PszV8oBkk2BS7GCL/qZDd8tes5cK6khXxjrh8SHiUf2sLvnDafczBeUWQh7J
         cYRIm1BZ/zq0+jg7gdJaC5aG96N/TYcHeN6dBUEpM0LsQzR9XEMiatBT9NFAqQIIer02
         JcEakUfYulQTajANuLTpSiqQVmxnO1y3gPKSxJ4rS/9vOrjPkEhYQ8acsm9ATWokEUr1
         NDBBap73SRGsexVVOuBpL7qNmJWiOAynzTmCKides7k0GbOzZbLG99s0BRL7SsFOEbOk
         lemA==
X-Gm-Message-State: AOAM531nQDJp+1/xAhHngLYn6V4KHypcJyvp2R+sERRYa8wVx05vzJAn
        osPMYCreZFOZhN6oNsPspV7l1dioYU5mCwvyLMWwqN+G1MKeazZIaYxFCf/4zkhPV1/xlk1aYMn
        suBuXr17mrMw6mhbGpFqy14wbiaQvF6+kLg==
X-Received: by 2002:a05:6902:100b:: with SMTP id w11mr37538239ybt.436.1617008452468;
        Mon, 29 Mar 2021 02:00:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOZPGnzpufs7d77ci1gXJQAUYaCR92BNk3LQXbgblDCjpbC0xVlSZTGjPKKZDZaWSaAHgVnEfYZrlpRpNdztg=
X-Received: by 2002:a05:6902:100b:: with SMTP id w11mr37538217ybt.436.1617008452252;
 Mon, 29 Mar 2021 02:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210316144823.2188946-1-omosnace@redhat.com> <CAHC9VhRoTjimpKrrQ5f04SE7AOcGv6p5iBgSnoSRgtiUP47rRg@mail.gmail.com>
 <YFEAD9UClhwxErgj@zeniv-ca.linux.org.uk> <CAFqZXNukusUPp+kO7vxPZBt5ehkpH6EUZ5e8XwUq9adOQHdMkQ@mail.gmail.com>
In-Reply-To: <CAFqZXNukusUPp+kO7vxPZBt5ehkpH6EUZ5e8XwUq9adOQHdMkQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 29 Mar 2021 11:00:39 +0200
Message-ID: <CAFqZXNtBrGVrjXAbrn30QSMFP4Gc99fRK23hMujxYu_otzu0yA@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: fix fsconfig(2) LSM mount option handling for btrfs
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Paul Moore <paul@paul-moore.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 18, 2021 at 10:42 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Mar 16, 2021 at 8:25 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Tue, Mar 16, 2021 at 02:21:45PM -0400, Paul Moore wrote:
> > > On Tue, Mar 16, 2021 at 10:48 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > When SELinux security options are passed to btrfs via fsconfig(2) rather
> > > > than via mount(2), the operation aborts with an error. What happens is
> > > > roughly this sequence:
> > > >
> > > > 1. vfs_parse_fs_param() eats away the LSM options and parses them into
> > > >    fc->security.
> > > > 2. legacy_get_tree() finds nothing in ctx->legacy_data, passes this
> > > >    nothing to btrfs.
> > > > [here btrfs calls another layer of vfs_kern_mount(), but let's ignore
> > > >  that for simplicity]
> >
> > Let's not.  This is where the root of the problem actually lies.  Take a look
> > at that sucker:
> >
> >         struct fs_context *fc;
> >         struct vfsmount *mnt;
> >         int ret = 0;
> >
> >         if (!type)
> >                 return ERR_PTR(-EINVAL);
> >
> >         fc = fs_context_for_mount(type, flags);
> >         if (IS_ERR(fc))
> >                 return ERR_CAST(fc);
> >
> >         if (name)
> >                 ret = vfs_parse_fs_string(fc, "source",
> >                                           name, strlen(name));
> >         if (!ret)
> >                 ret = parse_monolithic_mount_data(fc, data);
> >         if (!ret)
> >                 mnt = fc_mount(fc);
> >         else
> >                 mnt = ERR_PTR(ret);
> >
> >         put_fs_context(fc);
> >         return mnt;
> >
> > That's where the problem comes - you've lost the original context's ->security.
> > Note that there's such thing as security_fs_context_dup(), so you can bloody
> > well either
> >         * provide a variant of vfs_kern_mount() that would take 'base' fc to
> > pick security options from or
> >         * do all options parsing on btrfs fc and then do fs_context_for_mount +
> > security_fs_context_dup + copy (parsed) options to whatever private data you
> > use for btrfs_root context + fc_mount + put_fs_context yourself.
> >
> > My preference would be the latter, but I have *not* looked at btrfs mount options
> > handling in any details.
>
> Ack, I'll look into that. I didn't dare to try to touch btrfs mount
> handling (if it was straightforward, someone would've already done it,
> right? :), but it sounds like converting just this one
> vfs_kern_mount() could be relatively easy, would fix the bug, and
> would be an incremental improvement.

After taking a closer look, it seems this won't actually work... The
problem is that since btrfs still uses the legacy mount API, it has no
way to get to fs_context in btrfs_mount() and thus both of your
suggestions aren't really workable (again, without converting btrfs at
least partially to the new API)...

So unless you have other ideas, I'd like to put the original patch
back on the table. Note that the change can be reverted as soon as
btrfs is ported to the fs_context API properly, it's not something
that would need to stick around forever.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


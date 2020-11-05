Return-Path: <SRS0=HUo+=EL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796C7C4741F
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 17:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07464206B6
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 17:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BF3sIuEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbgKERWw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Nov 2020 12:22:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55245 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730447AbgKERWw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Nov 2020 12:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604596970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CI83uqHEVcNctFkTueS55TYoSfMZUl8aA4qxX7cn8E0=;
        b=BF3sIuEu+fw3FTuCUiasiaxQ3tVbsyRFW5T1YhSQ8TXlEGlYJ6VCjpmGzLTuMNWRgkc0yo
        xEBqRJcUhA4lscCGrq+BZY0R1Q89M1oMDq9Y6v2MWipvJyJMznK7f8EqOAhNjoesJS85Wn
        u7f1Xt40xZcPA8RA1fkf3eRJB9B43+0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-iWWmc-DEM0SQ_PGu37Qsrw-1; Thu, 05 Nov 2020 12:22:48 -0500
X-MC-Unique: iWWmc-DEM0SQ_PGu37Qsrw-1
Received: by mail-lf1-f69.google.com with SMTP id y14so897969lfl.7
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2020 09:22:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CI83uqHEVcNctFkTueS55TYoSfMZUl8aA4qxX7cn8E0=;
        b=ujv2eEUvPHfq4am73MRFqlqncFt/9Skwf5oORRjTgWcSu2rZSxHymOl4EhEmmgAgps
         zrtVI97coYgEeGvM0LNcLK4kKf+askxDI1qsfeGjj2aAKrPzRmnnwEVGV/5DHa/RJd0W
         H8P0XllFBRIA/FmNxhxHQpPqqb4y70nH5v1RBhKZ3wxngGBOCmhN48F6dixKN3p621n/
         xLvhZsqmVwNAK9frO5XOjVXWN6GELQTYEoAA3JKrNfD8ATcqpSgbXgYPT75yBzWfLnMX
         sh4JbE6NIx1vWbQDKb5HNkHnWDDHe53DFrP3WFzRSkSgHvhGfkV4GYbv6He3ICtpSMEH
         45Bw==
X-Gm-Message-State: AOAM531IkIOi5/E/89xEsjXR3Bv2TY94BQ8XKNtfaEKeUfQnObyBG41M
        WP98w6bQcpaBh4JraEcm5XVWZrWlePNxHiidm2Dh9skf3JdhN99PGb70jOR1Z8NdW+IvKfxscJh
        lKJzxMPsL2eM7E28MZsS5BH/J3kztWJIADw==
X-Received: by 2002:a05:6512:6c3:: with SMTP id u3mr1527038lff.9.1604596966860;
        Thu, 05 Nov 2020 09:22:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzT3kIduWcwnGt+xRHiRGnOSwWJMTTIEqYeXzOFtWpVxS1BYl//oYv16GoRYqdqhvIR5x/JAo/sg4bLNRDyQ0A=
X-Received: by 2002:a05:6512:6c3:: with SMTP id u3mr1527029lff.9.1604596966610;
 Thu, 05 Nov 2020 09:22:46 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNvT=G4HPiugi6vnnJMGLgv5MsumURQij0cnFjLrnXZ93Q@mail.gmail.com>
 <CAEjxPJ7cwBpLGoTmzGOUJFq5QuFCHG+xydiGYAtk2hV0d8ww3g@mail.gmail.com> <CAHC9VhQZGM2XW5=durZRb-gapsu+bUu_45JegmsOxcGEgThL6g@mail.gmail.com>
In-Reply-To: <CAHC9VhQZGM2XW5=durZRb-gapsu+bUu_45JegmsOxcGEgThL6g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 5 Nov 2020 18:22:35 +0100
Message-ID: <CAFqZXNvgQ5s50JS0_s1wEUONo2nzc2=_rufKxmWqQ=hhz8_T-A@mail.gmail.com>
Subject: Re: Possibly unwanted rootcontext= behavior?
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 5, 2020 at 4:31 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Nov 5, 2020 at 8:51 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Thu, Nov 5, 2020 at 7:44 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Hello everyone,
> > >
> > > while trying to fix the NFS rootcontext= issue, I realized that this
> > > funny thing is possible:
> > >
> > > # mount -o rootcontext=system_u:object_r:lib_t:s0 -t tmpfs tmpfs /mnt
> > > # ls -lZd /mnt
> > > drwxrwxrwt. 2 root root system_u:object_r:lib_t:s0 40 nov  5 07:30 /mnt
> > > # mount
> > > [...]
> > > tmpfs on /mnt type tmpfs
> > > (rw,relatime,rootcontext=system_u:object_r:lib_t:s0,seclabel)
> > > # chcon -t bin_t /mnt
> > > # ls -lZd /mnt
> > > drwxrwxrwt. 2 root root system_u:object_r:bin_t:s0 40 nov  5 07:30 /mnt
> > > # mount
> > > [...]
> > > tmpfs on /mnt type tmpfs
> > > (rw,relatime,rootcontext=system_u:object_r:bin_t:s0,seclabel)
> > >
> > > I.e. if you mount a tree with rootcontext=<oldctx> and then relabel
> > > the root node to <newctx>, the displayed mount options will report
> > > rootcontext=<newctx> instead of rootcontext=<oldctx>. A side effect is
> > > that if you try to mount the same superblock again, it will only
> > > permit you to mount with rootcontext=<newctx>, not with
> > > rootcontext=<oldctx>.
> > >
> > > Is that intended, bad, or "weird, but doesn't matter" behavior?
> >
> > I'd say it is bad.
> >
> > > I have a halfway written patch to disallow altering the root node's
> > > context when mounted with rootcontext=, but I'm not sure if that's the
> > > right thing to do or not.
> >
> > Probably the better fix would be to save the original rootcontext SID
> > as a new field of the
> > superblock security struct and use that both when displaying the mount
> > options and when
> > comparing old and new mount options instead of what happens to be
> > assigned to the root
> > inode at the time.
>
> I worry that would be confusing, allowing the root inode to be
> relabeled yet still showing the old label in the mount options.  It
> would seem that simply blocking a root inode relabel when a
> rootcontext is specified would be the cleanest choice, assuming
> existing systems do not rely on this behavior.
>
> Ondrej, Stephen, any idea how common this is on normal systems?  My
> gut feeling says "not very common", but that is just a guess.

I don't even know what use case it's supposed to solve :) I suppose if
you freshly format some storage drive and you want the root dir to be
labeled immediately after mounting, rootcontext= could be useful. For
such a use case Stephen's approach would make sense (you might still
want to eventually relabel the root dir to something else), but there
are some gotchas... For example, the label is initially set only in
the inode security struct, but not written to the xattrs (I only
looked at the code briefly, I could be wrong here), so you would still
need to manually set the label on the root directory after mounting
for the label to persist. And if you remount the superblock after
changing the label, the internal label will be reset to the old one
(which you are forced to specify in the mount options), but again not
persistently. That's all very unintuitive.

So, IMHO, good ways to fix it are either disallowing changing the
label altogether, or making sure the label is propagated to the xattrs
(if supported) and allowing to remount with a different rootcontext=
option (or with no rootcontext). But that's only if I guessed the use
case correctly.

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.


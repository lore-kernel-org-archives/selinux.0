Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4506C433E0
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 14:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF201229C4
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 14:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbhAEOC0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Jan 2021 09:02:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20563 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbhAEOCZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Jan 2021 09:02:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609855257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IXkDKCKqL4Nexdob4wS0We7ADzLdyMm8KPJMwYLHaNc=;
        b=TKf3S6GpI62YT2ZG5QKh98/dkvve6GNuvYhIJ7MJ/h0blfEsrGAKPj53DKwLwqq1SQxuvh
        KjiD1PjNHoBJKbpgnaIhfz+jU+nplsuGnvT6Vh0zw800CXUN9rXVH9hWBpaFPVFwEDM6v+
        risrGtYY98JkzPbzGp7puwuckfJ3Tb0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-ToU2woGvPB25AWKiMZHHSw-1; Tue, 05 Jan 2021 09:00:56 -0500
X-MC-Unique: ToU2woGvPB25AWKiMZHHSw-1
Received: by mail-lf1-f71.google.com with SMTP id a19so26226453lfd.8
        for <selinux@vger.kernel.org>; Tue, 05 Jan 2021 06:00:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IXkDKCKqL4Nexdob4wS0We7ADzLdyMm8KPJMwYLHaNc=;
        b=EcmOKcxmKfYyIisAZoItI2Nm1B+VZGgNP70di944u4GS/KJssA3fAsffqvbmA4Qvp+
         6GKTwsMwjy4UT9aCu6uZDOx4jh68RPjbz2xMlilR51jKMjqjwdZFHuUSbf8exoRSYXyZ
         JZSS/SVNY2k4oNl8mEBuZLDzklAWOXGX0zgFw5VYf30vivHqNmp5ga1xeu3loWi/Yq8o
         qlxM3w6pdTNoSgFI9dPW8X1AMoMTmdgtUznN8ZmaqhESzQO8/5ghCseYGSRM41BVhYl8
         d3AePImax38fgcGrRXAbmq2rMVryqhTg+eeJvNsNPNU0wkyq/4cxa4il+C+d3wPxE3X1
         2G7w==
X-Gm-Message-State: AOAM532GsKyYtFzBTqSVN3Abr0VnHW8lJ1CtwSEJxLdyp2M3Gi6lNRcT
        rm0BF/bVaC2J3jObIduUVW9uiCjJkNXZtgqhvtA1XExmvRtKugHC8uXBBs0g80oKn2JJJIVReJ0
        GoJKXx/mtI6kNnMzw4tAdfNrvcjXZHmDqrw==
X-Received: by 2002:a2e:85c1:: with SMTP id h1mr33969952ljj.127.1609855249002;
        Tue, 05 Jan 2021 06:00:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOzn5Yp3W1t8OiO+cvTSeKRe00BHjov9uAxGqBCvm/NcvTjZ+zhZ2+OgcTyYfZT/RfM7tGOPRCIKNxnO1FzFM=
X-Received: by 2002:a2e:85c1:: with SMTP id h1mr33969938ljj.127.1609855248696;
 Tue, 05 Jan 2021 06:00:48 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNsGabHBfV36nNAVLJgEzjkBev-O3YZ1vnmXyVoaDdjiHQ@mail.gmail.com>
 <CAP+JOzSWW6HFtN1VSyvKacKeZdtRkBo7TWR7JS4a0ewiopuKww@mail.gmail.com>
 <CAHC9VhSYt86rQJGg9JFD1ubL4N3PNmLg02sACOvRNHr94=41dg@mail.gmail.com>
 <CAP+JOzQ-s9ASgqFt7HVyY1R7JKQ85Ee-=iou0C5xRRvaSZo52Q@mail.gmail.com>
 <CAHC9VhQkSA5VteHfu8TyBp7wqDspoLCOP+sB7vaV4XCQ8vwBeA@mail.gmail.com>
 <CAFqZXNsfomoMTr+uhisdsj75c7ZdXmGCiDZBsDwtLUpkwEA76w@mail.gmail.com>
 <20201210221753.GB185111@redhat.com> <CAFqZXNsstwecRnQu3-Gybdo1xwJRPHmt1=ZYZqnXK-v6MT0kng@mail.gmail.com>
 <20201210223049.GC185111@redhat.com> <CAFqZXNu0_8__73NfNa9tR_iWiaGGqkfvhtOQts7mmnh8v9QWrA@mail.gmail.com>
 <20210104201458.GA74084@redhat.com>
In-Reply-To: <20210104201458.GA74084@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 5 Jan 2021 15:00:31 +0100
Message-ID: <CAFqZXNtSbFBPCTu+aOUt7JKaR_Gk1kAJ0ewgV1Ds8HhpyfafQg@mail.gmail.com>
Subject: Re: virtiofs and its optional xattr support vs. fs_use_xattr
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Zdenek Pytela <zpytela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 4, 2021 at 9:15 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> On Fri, Dec 11, 2020 at 10:15:57AM +0100, Ondrej Mosnacek wrote:
> > On Thu, Dec 10, 2020 at 11:31 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > On Thu, Dec 10, 2020 at 11:24:30PM +0100, Ondrej Mosnacek wrote:
> > > > On Thu, Dec 10, 2020 at 11:17 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > > On Thu, Dec 10, 2020 at 10:29:02AM +0100, Ondrej Mosnacek wrote:
> > > > > > On Thu, Dec 10, 2020 at 3:40 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > > On Wed, Dec 9, 2020 at 10:37 AM James Carter <jwcart2@gmail.com> wrote:
> > > > > > > > On Tue, Dec 8, 2020 at 6:45 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > > > > On Mon, Dec 7, 2020 at 12:17 PM James Carter <jwcart2@gmail.com> wrote:
> > > > > > > > > > On Mon, Dec 7, 2020 at 9:45 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi everyone,
> > > > > > > > > > >
> > > > > > > > > > > In [1] we ran into a problem with the current handling of filesystem
> > > > > > > > > > > labeling rules. Basically, it is only possible to specify either
> > > > > > > > > > > genfscon or fs_use_xattr for a given filesystem, but in the case of
> > > > > > > > > > > virtiofs, certain mounts may support security xattrs, while other ones
> > > > > > > > > > > may not.
> > > > > > > > > > >
> > > > > > > > > > > So we can't use the xattr support by adding fs_use_xattr virtiofs
> > > > > > > > > > > (...); to the policy, because then a non-xattr mount will fail
> > > > > > > > > > > (SELinux does a mount-time check on the root inode to make sure that
> > > > > > > > > > > the xattr handler works), but we also don't want to stay on genfscon,
> > > > > > > > > > > because then we can't relabel files.
> > > > > > > > > > >
> > > > > > > > > > > So my question is how to best address this? One option is to use a
> > > > > > > > > > > similar "hack" as for cgroupfs; i.e. do a kind of mixed genfs-xattr
> > > > > > > > > > > labeling, but that's ugly and requires hard-coding another FS name in
> > > > > > > > > > > the selinux code. The only other alternative I could come up with is
> > > > > > > > > > > to add a new FS labeling statement that would specify some kind of
> > > > > > > > > > > mixed genfscon / fs_use_xattr behavior. That would be a better
> > > > > > > > > > > long-term solution, but leads to more questions on how such statement
> > > > > > > > > > > should actually work... Should it work the cgroupfs way, giving a
> > > > > > > > > > > default label to everything and allowing to set/change labels via
> > > > > > > > > > > xattrs? Or should it rather just detect xattrs support and switch
> > > > > > > > > > > between SECURITY_FS_USE_XATTR and SECURITY_FS_USE_GENFS behavior based
> > > > > > > > > > > on that? In the latter case, should the statement specify two contexts
> > > > > > > > > > > (one for fs_use_xattr and another one for genfscon) or just one for
> > > > > > > > > > > both behaviors?
> > > > > > > > > >
> > > > > > > > > > I don't think adding a new statement is necessary. It seems like
> > > > > > > > > > allowing both fs_use_xattr and genfscon rules for the filesystem in
> > > > > > > > > > policy and then using the fs_use_xattr rule if xattrs are supported
> > > > > > > > > > while falling back to the genfscon rule if they are not would do what
> > > > > > > > > > you need.
> > > > > > > > >
> > > > > > > > > That seems reasonable to me so long as this ambiguity is okay with the
> > > > > > > > > folks who do policy analysis.  Thinking quickly I'm not sure why it
> > > > > > > > > would be a problem, but the thought did occur while I was typing up
> > > > > > > > > this reply ...
> > > > > > > >
> > > > > > > > I don't think that it would cause a problem with policy analysis. I
> > > > > > > > think that you would just assume the genfscon rule is being used,
> > > > > > > > since it is less fine-grained. It wouldn't be much different from how
> > > > > > > > booleans are handled.
> > > > > > >
> > > > > > > Makes sense to me.  Thanks Jim.
> > > > > >
> > > > > > Okay, so I'll look into switching between use_xattr and use_genfs
> > > > > > based on the availability of xattr support and the presence of
> > > > > > corresponding rules in the policy. Thanks everyone for the fruitful
> > > > > > discussion!
> > > > >
> > > > > Hi Ondrej,
> > > > >
> > > > > So this is now purely a policy change and no changes required in kernel?
> > > > > If yes, then the patch Dan Walsh proposed, is that good enough or
> > > > > it needs to be done in a different way.
> > > >
> > > > No, this needs a kernel change in SELinux to interpret the policy
> > > > rules slightly differently *and* basically Dan's patch (modulo the
> > > > typo in the genfscon keyword).
> > >
> > > Ok, thanks. Is this kernel change something you will be able to take
> > > care of. I am afraid that I don't know enough to make this change.
> >
> > Yes, it's already on my todo list ;) But it might take some time as
> > there are a lot of things competing for my attention right now...
>
> Hi Ondrej,
>
> Sorry to bother you on this. Just curious, if you got a chance to make
> progress on this. Will like to solve the issue of SELinux blocking package
> installation on virtiofs in VM based containers.

Hi,

I had a go at it today and I already have a tentative patch. So far
it's passing my initial testing so I should be able to post it to the
list soon.

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.


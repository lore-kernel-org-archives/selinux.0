Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67453C4361B
	for <selinux@archiver.kernel.org>; Wed,  9 Dec 2020 15:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 318E722B39
	for <selinux@archiver.kernel.org>; Wed,  9 Dec 2020 15:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgLIPii (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Dec 2020 10:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgLIPii (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Dec 2020 10:38:38 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC71C0613CF
        for <selinux@vger.kernel.org>; Wed,  9 Dec 2020 07:37:57 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id h18so1725191otq.12
        for <selinux@vger.kernel.org>; Wed, 09 Dec 2020 07:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ni4d4ssPHZqY9Mj7XDFzcu37/MBoB7MklbLckABwRU0=;
        b=bGCzVybW1CDRl8ZvjvlYhWTDIVn9txzgQWKaACbCbduUBa/bTNZ07vHfOvqtUErNV8
         hVghwLn5A/A7mWJt+wvxEhFUN5NWtJ0BuTLfH8qYkcudKNEz0gWD4lyHHIHxLZlsP6FE
         IrT59tLrdP1Nm31J7bXktWZq+fi8U1kc7lDiTfhzU6n0d2a95+v1Y1nnJxz7IogxQ6nN
         RWvjq2iiT+igJ+1HC4txQRVHOd5OlIBNkJiS61HuyQ0PzBs7F2rS65Y9DcV7qiXyyuit
         OIH4Ky0dLOmQuI3KTsQQlK/UVNqHcnoECq2FQFEElbEpJlGD/yTZBkW19sqUENop+aA4
         Z2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ni4d4ssPHZqY9Mj7XDFzcu37/MBoB7MklbLckABwRU0=;
        b=KwDD2aYQauuQMA4NSKPLb4hr7AV+p37GvpDsklfT2K4AqsQJL5WdOcwmtODGdhtTGw
         eZtJBHhOvQYrAtT1KO4jm3h1ZFJfmX39Y4drmuCaJ3FTQLFqxDZNwaGqDx3G2a5MB70n
         Xwiy5/uPAQo5ZzS6BKvpodJLwNfgm+9LkQ2DwXjzMlpRedncTgreDsNbEucw0iQlCO9r
         gMN/mnu9UvEcrC3NeXmdPcDz2c/LTKFv73J0uc+hq/105/FXF5q9hsv/I632ReyqR4VH
         0tmY+XinQdW71fqjlLQKtNDBQVUaKVQTqXyDhe5xM5+SgP3I0tLdoxYvELZqgoVUTDsa
         AiTg==
X-Gm-Message-State: AOAM531GF+SpGOimK0qT2sjwy0KB0u49Z1yIcWd/gNCXAF5qnAgfzmfj
        zl1P8foyR8kiPEfUd/l0mB61WJAJQeDSGUCqgXEcKiDb
X-Google-Smtp-Source: ABdhPJx6sH4HU5oyHb97/WANhrhCEJxJ7gNia93TMEu33wpJey8HcJXmik9W+0eJahMe1/Fj/QWrlk2P0PUlIsG0Eqk=
X-Received: by 2002:a05:6830:1ae4:: with SMTP id c4mr1157413otd.295.1607528277086;
 Wed, 09 Dec 2020 07:37:57 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNsGabHBfV36nNAVLJgEzjkBev-O3YZ1vnmXyVoaDdjiHQ@mail.gmail.com>
 <CAP+JOzSWW6HFtN1VSyvKacKeZdtRkBo7TWR7JS4a0ewiopuKww@mail.gmail.com> <CAHC9VhSYt86rQJGg9JFD1ubL4N3PNmLg02sACOvRNHr94=41dg@mail.gmail.com>
In-Reply-To: <CAHC9VhSYt86rQJGg9JFD1ubL4N3PNmLg02sACOvRNHr94=41dg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 9 Dec 2020 10:37:46 -0500
Message-ID: <CAP+JOzQ-s9ASgqFt7HVyY1R7JKQ85Ee-=iou0C5xRRvaSZo52Q@mail.gmail.com>
Subject: Re: virtiofs and its optional xattr support vs. fs_use_xattr
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Zdenek Pytela <zpytela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 8, 2020 at 6:45 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Dec 7, 2020 at 12:17 PM James Carter <jwcart2@gmail.com> wrote:
> > On Mon, Dec 7, 2020 at 9:45 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Hi everyone,
> > >
> > > In [1] we ran into a problem with the current handling of filesystem
> > > labeling rules. Basically, it is only possible to specify either
> > > genfscon or fs_use_xattr for a given filesystem, but in the case of
> > > virtiofs, certain mounts may support security xattrs, while other ones
> > > may not.
> > >
> > > So we can't use the xattr support by adding fs_use_xattr virtiofs
> > > (...); to the policy, because then a non-xattr mount will fail
> > > (SELinux does a mount-time check on the root inode to make sure that
> > > the xattr handler works), but we also don't want to stay on genfscon,
> > > because then we can't relabel files.
> > >
> > > So my question is how to best address this? One option is to use a
> > > similar "hack" as for cgroupfs; i.e. do a kind of mixed genfs-xattr
> > > labeling, but that's ugly and requires hard-coding another FS name in
> > > the selinux code. The only other alternative I could come up with is
> > > to add a new FS labeling statement that would specify some kind of
> > > mixed genfscon / fs_use_xattr behavior. That would be a better
> > > long-term solution, but leads to more questions on how such statement
> > > should actually work... Should it work the cgroupfs way, giving a
> > > default label to everything and allowing to set/change labels via
> > > xattrs? Or should it rather just detect xattrs support and switch
> > > between SECURITY_FS_USE_XATTR and SECURITY_FS_USE_GENFS behavior based
> > > on that? In the latter case, should the statement specify two contexts
> > > (one for fs_use_xattr and another one for genfscon) or just one for
> > > both behaviors?
> >
> > I don't think adding a new statement is necessary. It seems like
> > allowing both fs_use_xattr and genfscon rules for the filesystem in
> > policy and then using the fs_use_xattr rule if xattrs are supported
> > while falling back to the genfscon rule if they are not would do what
> > you need.
>
> That seems reasonable to me so long as this ambiguity is okay with the
> folks who do policy analysis.  Thinking quickly I'm not sure why it
> would be a problem, but the thought did occur while I was typing up
> this reply ...
>

I don't think that it would cause a problem with policy analysis. I
think that you would just assume the genfscon rule is being used,
since it is less fine-grained. It wouldn't be much different from how
booleans are handled.

Jim

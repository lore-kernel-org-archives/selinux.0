Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6860FC433EF
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 20:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53CEA61050
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 20:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhJLUku (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Oct 2021 16:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234822AbhJLUku (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Oct 2021 16:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634071127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lPXrGW7Wzg5CZO/WUvHvqIECHK6Z+3ytx9wzhk4o/9k=;
        b=fcSbEBB8jkVYnEq3R25iJbb0UJ705znyKcTznYoFad9j1U94Z7dqpN5hxSY0olUN2vdG2v
        sA2x3kR5slwAG0MgC4PkGTQG5DrC6JShpOBfde64kdIZEgZUlHefJqZqN+nOYegNqvDG61
        M/WaZnC4ZAG1kVI9TvJILU//vIDSG0Y=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-9Gm3zNDING-qF698028bWg-1; Tue, 12 Oct 2021 16:38:46 -0400
X-MC-Unique: 9Gm3zNDING-qF698028bWg-1
Received: by mail-yb1-f197.google.com with SMTP id b197-20020a2534ce000000b005b71a4e189eso735938yba.5
        for <selinux@vger.kernel.org>; Tue, 12 Oct 2021 13:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lPXrGW7Wzg5CZO/WUvHvqIECHK6Z+3ytx9wzhk4o/9k=;
        b=msU6M/kk1g2sWSy9mca4h59m+mz/DwmiZrVNoMTCMNxbSi9TBvWPCLnIHBX8BUZFAF
         jCNJiUB2X8Awr5fLSaN6h7PxSoeOygUKS8cycTiLr4PVTUbXAYTemkaXW7sm9QPYk8U/
         FtHbMEsN7i+gbS3MHUq0eEhnbCoOaRrHGeyFKru3DxW3JjbTvK+gT+IEVCrCvz4mcQjy
         5Y2ez7c2Ap1lINyfBIodPuJ9WVbEOUmg+aMMcyhxt9O7ToC6w79HMYELpPItd2w7hA28
         K8PgUnVZCPt28wRzA0W11hZwC7Wd84lZbkJglZD3YCKKgXCBhEkOgkG45KSiuwZIS1bf
         ezUQ==
X-Gm-Message-State: AOAM530d8NZo3yAenwHtCMuAbrdCQkTJ6Mj62yUEfNqQodaj1lVKtFCj
        C2NJJwa1dTkNaor5lcxSHFBcR7NpPfQoyrVG0myuVb2KFrzH9y226i84OE6cUC5yjT1Tx5WrxC+
        Ixzu3sRqpoM8NNdzkD52W5qdDelQKSUoIXQ==
X-Received: by 2002:a25:7452:: with SMTP id p79mr29045966ybc.513.1634071126082;
        Tue, 12 Oct 2021 13:38:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEU5vT4UFfcnZfY5xNAyPOcDFTq1ZFkCTMKD6fioEcrkK5mEiIyzhK7Uicufz2eibyoa+V+DelHPWBrS4wHkA=
X-Received: by 2002:a25:7452:: with SMTP id p79mr29045936ybc.513.1634071125770;
 Tue, 12 Oct 2021 13:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211011133704.1704369-1-brauner@kernel.org> <06b6f249-06e6-f472-c74c-bb3ff6f4b4ee@digikod.net>
 <20211012103830.s7kzijrn25ucjasr@wittgenstein> <CAHC9VhSd32Q_tCctwYB0y4EXGCV8_9QajkNkkc96EwjdFsVkJw@mail.gmail.com>
In-Reply-To: <CAHC9VhSd32Q_tCctwYB0y4EXGCV8_9QajkNkkc96EwjdFsVkJw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 12 Oct 2021 22:38:32 +0200
Message-ID: <CAFqZXNu7OEFVaS-oJH_JhsCWg3aN67Hajbiw8U8Zd+TSMKatOQ@mail.gmail.com>
Subject: Re: [PATCH] security/landlock: use square brackets around "landlock-ruleset"
To:     Paul Moore <paul@paul-moore.com>
Cc:     Chris PeBenito <pebenito@ieee.org>,
        Petr Lautrbach <plautrba@redhat.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <brauner@kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 12, 2021 at 8:12 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Oct 12, 2021 at 6:38 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > On Mon, Oct 11, 2021 at 04:38:55PM +0200, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> > > On 11/10/2021 15:37, Christian Brauner wrote:
> > > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > >
> > > > Make the name of the anon inode fd "[landlock-ruleset]" instead of
> > > > "landlock-ruleset". This is minor but most anon inode fds already
> > > > carry square brackets around their name:
> > > >
> > > >     [eventfd]
> > > >     [eventpoll]
> > > >     [fanotify]
> > > >     [fscontext]
> > > >     [io_uring]
> > > >     [pidfd]
> > > >     [signalfd]
> > > >     [timerfd]
> > > >     [userfaultfd]
> > > >
> > > > For the sake of consistency lets do the same for the landlock-rules=
et anon
> > > > inode fd that comes with landlock. We did the same in
> > > > 1cdc415f1083 ("uapi, fsopen: use square brackets around "fscontext"=
 [ver #2]")
> > > > for the new mount api.
> > >
> > > Before creating "landlock-ruleset" FD, I looked at other anonymous FD
> > > and saw this kind of inconsistency. I don't get why we need to add ex=
tra
> > > characters to names, those brackets seem useless. If it should be par=
t
> >
> > Past inconsistency shouldn't justify future inconsistency. If you have =
a
> > strong opinion about this for landlock I'm not going to push for it.
> > Exchanging more than 2-3 email about something like this seems too much=
.
>
> [NOTE: adding the SELinux list as well as Chris (SELinux refrence
> policy maintainer) and Petr (Fedora/RHEL SELinux)]
>
> Chris and Petr, do either of you currently have any policy that
> references the "landlock-ruleset" anonymous inode?  In other words,
> would adding the brackets around the name cause you any problems?

AFAIU, the anon_inode transitions (the only mechanism where the "file
name" would be exposed to the policy) are done only for inodes created
by anon_inode_getfd_secure(), which is currently only used by
userfaultfd. So you don't even need to ask that question; at this
point it should be safe to change any of the names except
"[userfaultfd]" as far as SELinux policy is concerned.

--=20
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74F7C38145
	for <selinux@archiver.kernel.org>; Thu,  8 Sep 2022 21:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIHVzD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Sep 2022 17:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHVzC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Sep 2022 17:55:02 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68B945988
        for <selinux@vger.kernel.org>; Thu,  8 Sep 2022 14:55:00 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z8so26401835edb.6
        for <selinux@vger.kernel.org>; Thu, 08 Sep 2022 14:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gI4IfYMJNuKYpleQD26KZGeJ3SsALiVd5iEEEXdrgCM=;
        b=VSZcOQFf1vq9VKJKEnjRUjXGoqOVA1wRw8JL2FklR3KGIi+eXZjw0xMq4qws00Cb74
         OY4EqUlwd1UXos7aqZs9aG51fRi0bVrGAUsTm6whItXOhp+V+HTFfj4wVfEtVyD4aKA3
         owRoCv6nEdqcJfhtZmk6s4fBi8yufZxpMwGbUCOcKTRqzbIb8auwV0PNZhY032JBgEry
         sSr/Ekmm8FwjtYiNN2NdOz4FEmfnsFbmTQNsziShlgOT7O0qkwZwyk1kwzJPZ+ncOQHB
         GUCExtDtUsy86xHP1pSrkSVJ7GRqMdbi8Q26Osp9p9TlIgl/lXQbhrSTk4tFmTmIhfvx
         loCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gI4IfYMJNuKYpleQD26KZGeJ3SsALiVd5iEEEXdrgCM=;
        b=fDDw6OFMB7L5yX1nWujvwa+L4mcy7fsVKWNpPx1kgjxnueGoTDMcWY9u2Nu8Sr9qK/
         xrxB1S0Q9VpFpZR+yUKfn0RoWX2MB28YBtotYPfH+BF9tzKiyxSvoqLGH6erYXDhlvld
         6gyso6+roVQL0fuH2ROmy11qbTqnjmspTg0AwLZWpIP20KDUICySHMt4fkRDFwAK0IAJ
         ktPfZs8l4abJ786zctfKKB0wpt0PZh669dr+EUFLTU3cmuNkSBaPbfLIekaByeNCQGUY
         roSIQHWZeAa8YmrktuOAmt6sJ2fFGgysYhbUhtc7bzGskL8Xht8Z756pJn5bCssPNbP9
         SmGg==
X-Gm-Message-State: ACgBeo0toJ+OcFZ2wDNeEK3cFxy29eYEcD7rrBSRq/PKDLsZO+b6VfX0
        kSoC16Qa/TrnLbDaF1rPlltKW38Mt3aJ9ODU2Gaf3G2/
X-Google-Smtp-Source: AA6agR70UIIimNRcFh+gvKyRyGDBuKHRoTdnFcN+VMgBaABL2LTqH6jD77w9Ed9LWPfjZURNpGdNI2zIlesNcJOm7uI=
X-Received: by 2002:a05:6402:b85:b0:44e:dad7:3e24 with SMTP id
 cf5-20020a0564020b8500b0044edad73e24mr9194362edb.264.1662674099196; Thu, 08
 Sep 2022 14:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQE4isJqSmSOozWdKRN1rmt7_6sG_9VsroD-zjfQzWYqEQ@mail.gmail.com>
 <87a67ac398.fsf@defensec.nl> <CAHC9VhTioQVN28CZmcwdcTeZ_WOA77ovXMk0xqdzF+HXeZMCpQ@mail.gmail.com>
 <CAFPpqQGmo8zt4h3aLy7j8rkzZA4cKM8D2DbkVStBre9b17dvdg@mail.gmail.com>
 <CAFPpqQEoAcmpQALgD9S5ZYnd2KVSPOtsBaC67t3VLv9uS3KRbw@mail.gmail.com> <CAFqZXNus2pSv4=oxm-Mj+vz0D2TDNqiG6tf_--CSo5OcExK74Q@mail.gmail.com>
In-Reply-To: <CAFqZXNus2pSv4=oxm-Mj+vz0D2TDNqiG6tf_--CSo5OcExK74Q@mail.gmail.com>
From:   Ted Toth <txtoth@gmail.com>
Date:   Thu, 8 Sep 2022 16:54:48 -0500
Message-ID: <CAFPpqQGNtG9yj5i4mRUvTXx5AveC1a8NoE36T61jrLXD1=2duQ@mail.gmail.com>
Subject: Re: context of socket passed between processes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Dominick Grift <dominick.grift@defensec.nl>,
        SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 8, 2022 at 9:28 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Sep 8, 2022 at 4:15 PM Ted Toth <txtoth@gmail.com> wrote:
> >
> > On Thu, Sep 8, 2022 at 8:43 AM Ted Toth <txtoth@gmail.com> wrote:
> > >
> > > On Wed, Sep 7, 2022 at 5:48 PM Paul Moore <paul@paul-moore.com> wrote:
> > > >
> > > > On Wed, Sep 7, 2022 at 4:56 PM Dominick Grift
> > > > <dominick.grift@defensec.nl> wrote:
> > > > > Ted Toth <txtoth@gmail.com> writes:
> > > > > > systemd uses a helper process (sd-listen) to create sockets and pass
> > > > > > their fds back to its parent. I've patched systemd to call semanage to
> > > > > > get the context for the port if it exists and create a context using
> > > > > > the returned type when calling setsockcreatecon. Everything looks
> > > > > > right i.e. the port type is retrieved, the context is created and
> > > > > > setsockcreatecon is called without errors. However 'netstat -Z' shows
> > > > > > the listening sockets type as init_t and not the type in the
> > > > > > setsockcreatecon call, is this the expected behavior? Can anyone help
> > > > > > me understand why this is happening?
> > > > >
> > > > > It is probably the context of the process listening on the port and not
> > > > > the context of the socket that binds to the port
> > > >
> > > > That's a good point, I would have thought it would have looked at the
> > > > socket itself but perhaps it is the calling process' label.  Actually,
> > > > it might be the fd's label associated with the socket; that would
> > > > explain it.  Someone would need to look at the netstat sources to
> > > > confirm.
> > >
> > > Is there an API to query the context of a socket fd?
> >
> > I wrote a client which connects and calls getpeercon and indeed the
> > context is what was set via setsockcreatecon so that's reassuring.
> > Unfortunately it seems that netstat, ss and lsof don't have a way to
> > query the context of the listening socket :( I'd like to see a
> > getsockcon function (taking an fd as its argument) added to libselinux
> > if it can be written.
>
> There is a way to see a socket's context, though it's a bit obscure:
>
> ls -ZL /proc/<PID>/fd/<FD>

Yes I did that too but it does not show the context set in the
setsockcreatecon call, only the client getpeercon returned the context
set on create.


>
> --
> Ondrej Mosnacek
> Senior Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>

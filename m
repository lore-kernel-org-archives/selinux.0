Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A271C433EF
	for <selinux@archiver.kernel.org>; Wed, 23 Feb 2022 12:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbiBWMNR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Feb 2022 07:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiBWMNR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Feb 2022 07:13:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 620D79A9A9
        for <selinux@vger.kernel.org>; Wed, 23 Feb 2022 04:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645618368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WFaWIFIAWbCZZlUkAh2lkRliBgd1XRdRHOnZNx1Zc70=;
        b=AE9KrSIydw79LaywNSwwATce0lXYpcLNCikAmn3rACf+5Vhwe+m4O6Z2YwpIgb0LH+RD8t
        KArjGbYjDVARh6378deNDXDqlPCaoMRGTD/bWGWlsPC1kHMjNkj8WLxw5iitS7SGkeTsPK
        0OqMPDjSdDJVWFjyi9kOwkZdEEO7++A=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-VvyvcXtXPzWB_bOg7uwKfA-1; Wed, 23 Feb 2022 07:12:47 -0500
X-MC-Unique: VvyvcXtXPzWB_bOg7uwKfA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-2d61f6c1877so169824357b3.15
        for <selinux@vger.kernel.org>; Wed, 23 Feb 2022 04:12:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFaWIFIAWbCZZlUkAh2lkRliBgd1XRdRHOnZNx1Zc70=;
        b=PjO3nrdp43IQ5iYK7LWWXAOjvLfPlUFHDoS2XpY1Q1bb7oRGmpXiknIFN5bNwLUvPR
         o1uEhpuDOKMZitQYum8kq4o47APFKJdBwdYjkI8JOaFOzFJkcYFqVzZUojWWpSn6ALfU
         KUt/YfohJRcO2hAfEtlnmFByD1m2pdbGTOA2szpxsiPTpHpug/3V6W+XwgFINmWhMada
         gro4E9l7+Y/8hxv4EhW7RJ+Y6EDHEIp3EQlxLyKhFXhb+nlJey/z410TOhIb8DfoTVbS
         +MT1TaOW+gPydwCrVTvGEgCwHsypltHUgFJPi6DwRFOrrIGoDoLkyVXa2DWBznqX8vcQ
         Vw4w==
X-Gm-Message-State: AOAM533xNvhoqfPa1YpNiF7Brct8251G1RRVXzZ4NiSp+ACJUfxsZ5Yq
        GdFw0pnarfgcNraMHQHTHw6SD8weHrfBHx4rB7jJL4Z1/CijEiQCZSjSkpFVxLdFgQJUvRoakmG
        8I3s1L/3GFcv9htc24Mgbay7RYLV03U5Y2Q==
X-Received: by 2002:a25:374d:0:b0:611:a6c1:b948 with SMTP id e74-20020a25374d000000b00611a6c1b948mr27535680yba.21.1645618366841;
        Wed, 23 Feb 2022 04:12:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwm3Igy2eJcx5CR9bOCFhm+6tZKKA9klVaCA39zy7HSo6HF0bJv2D07KHeeOqE0LCB39k2IhUNJQEdkKyVUiAA=
X-Received: by 2002:a25:374d:0:b0:611:a6c1:b948 with SMTP id
 e74-20020a25374d000000b00611a6c1b948mr27535619yba.21.1645618365933; Wed, 23
 Feb 2022 04:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20220221131533.74238-1-richard_c_haines@btinternet.com>
 <CAHC9VhQnRQFrM-mTzUQ3UsyVp2JYw1wUh=7yrdjH7-QmHKidAg@mail.gmail.com> <20396305e71619dbee4fa3c612925b57f4bb0a4b.camel@btinternet.com>
In-Reply-To: <20396305e71619dbee4fa3c612925b57f4bb0a4b.camel@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 23 Feb 2022 13:12:36 +0100
Message-ID: <CAFqZXNuf5J35Jb3nmQ6YRrc6C2f5rk-30U0rB4wTMd-+SBQhEQ@mail.gmail.com>
Subject: Re: [PATCH V2] security/selinux: Always allow FIOCLEX and FIONCLEX
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, demiobenour@gmail.com,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org,
        Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 23, 2022 at 12:58 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Tue, 2022-02-22 at 18:28 -0500, Paul Moore wrote:
> > On Mon, Feb 21, 2022 at 8:15 AM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > >
> > > These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which
> > > SELinux
> > > always allows too.  Furthermore, a failed FIOCLEX could result in a
> > > file
> > > descriptor being leaked to a process that should not have access to
> > > it.
> > >
> > > As this patch removes access controls, a policy capability needs to
> > > be
> > > enabled in policy to always allow these ioctls.
> > >
> > > Based-on-patch-by: Demi Marie Obenour <demiobenour@gmail.com>
> > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > ---
> > > V2 Change: Control via a policy capability. See this thread for
> > > discussion:
> > > https://lore.kernel.org/selinux/CAHC9VhQEPxYP_KU56gAGNHKQaxucY8gSsHiUB42PVgADBAccRQ@mail.gmail.com/T/#t
> > >
> > > With this patch and the polcap enabled, the selinux-testsuite will
> > > fail:
> > > ioctl/test at line 47 - Will need a fix.
> > >
> > >  security/selinux/hooks.c                   | 7 +++++++
> > >  security/selinux/include/policycap.h       | 1 +
> > >  security/selinux/include/policycap_names.h | 3 ++-
> > >  security/selinux/include/security.h        | 7 +++++++
> > >  4 files changed, 17 insertions(+), 1 deletion(-)
> >
> > Thanks Richard for putting together the v2 of this patch.
> >
> > As far as the test is concerned, it seems like the quick-n-dirty fix
> > is to simply remove the ioctl(FIOCLEX) test in test_noioctl.c; is
> > everyone okay with that?  At least that is what I'm going to do with
> > my local copy that I use to validate the kernel-secnext builds unless
> > someone has a better patch :)
>
> To fix this I was planning to submit a patch that would change the
> ioctl(FIOCLEX) tests to ioctl(FS_IOC_GETFSLABEL) as that would continue
> to test the xperms.

That one seems to be implemented only by some filesystems. Is there
any more generic one we could use?

>
> >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 5b6895e4f..030c41652 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -3745,6 +3745,13 @@ static int selinux_file_ioctl(struct file
> > > *file, unsigned int cmd,
> > >                                             CAP_OPT_NONE, true);
> > >                 break;
> > >
> > > +       case FIOCLEX:
> > > +       case FIONCLEX:
> > > +               /* Must always succeed if polcap set, else default:
> > > */
> > > +               if (selinux_policycap_ioctl_skip_cloexec())
> > > +                       break;
> > > +               fallthrough;
> > > +
> >
> > The break/fallthrough looks like it might be a little more fragile
> > than necessary, how about something like this:
> >
> >   case FIOCLEX:
> >   case FIONCLEX:
> >     if (!selinux_policycap_ioctl_skip_cloexec())
> >       error = ioctl_has_perm(cred, file, FILE__IOCTL, (u16) cmd);
> >       break;
> >
> > Yes, it does duplicate the default ioctl_has_perm() call, but since
> > we
> > are effectively deprecating this and locking the FIOCLEX/FIONCLEX
> > behavior with this policy capability it seems okay to me (and
> > preferable to relying on the fallthrough).
> >
> > Thoughts?
>
> Yes I did ponder this and in my first attempt I had this before the
> switch():
>
>         /* Must always succeed if polcap set */
>         if (selinux_policycap_ioctl_skip_cloexec() &&
>             (cmd == FIOCLEX || cmd == FIONCLEX))
>                 return 0;
>
>         switch (cmd) {
>         case FIONREAD:
>         case FIBMAP:
>
> but changed to within the switch(), anyway I'm happy to resubmit a
> patch either way.

I agree with Paul's suggestion. Better to duplicate the simple call
than to complicate the code flow.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98C5C433FE
	for <selinux@archiver.kernel.org>; Wed, 23 Feb 2022 21:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241103AbiBWVhd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Feb 2022 16:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242860AbiBWVhc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Feb 2022 16:37:32 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA8942A05
        for <selinux@vger.kernel.org>; Wed, 23 Feb 2022 13:37:00 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z22so219629edd.1
        for <selinux@vger.kernel.org>; Wed, 23 Feb 2022 13:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5a38AcDGlULeizv+EnYpYzbUdgQ8NvBfm031ilv5PP0=;
        b=fBbrdGBqV4P1Iyp4pwMlXbAztmG/njOLjZ2rbrniYRN9oxIh4pgfk6mm5NReO/C4HU
         CEvHB89LVaC936ftMVOTUQHk3TwA66Uik2AROrqdg+ierKDP+AHqjHJA3+D/cVb9APXo
         uH0xvhTt/LhloQ5pOv4ym6qNqOUaQ9rJcv1j5j8/doMsIn37eAzMgsLzUfb9L6TSbo80
         9Q+PkItjssd9WDNbz/qSoSO8/K2XE3Q++126AieLLnY0mKC8y7Zbv6rlwT7I4PKVmoe2
         xF4VrO8mIMKQ9U0yCqrIyvscc58kSKWc9vSqBdJquXZ1Tml07kYn1OcZLNKelXAQFDN7
         aN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5a38AcDGlULeizv+EnYpYzbUdgQ8NvBfm031ilv5PP0=;
        b=6mi4bQCm4Tg56qu73QC1KsM2Cv7lN7LmKfSQqVklHDAXj8eaXMrZQ/TVjiplRVEtCh
         zmkSzVzzDjEfiMSwb4yb62D25rXRPq/N2RRSRBzOrpaRHgAErJz1uHaj8ll6G3Cp9xgl
         zLKMRGL5DtqUFHxCvnJa+TH3ZarQtMssJPRkbXYytrGrZlaACSLdpioOPfbT5LjW8DvR
         AxWdIdWGem5NLW7y/0Gb95Zw/GeCHEKBqaxLNr0mRFWlZ93hU+0AUJ9VjifrVvMl/dKX
         DYYjqUpMMsdMe/fPREQzzA34uQos3sGK1UpaY5QuG0uM9/SUomeZb6KhMFAXM17VM+3K
         d3YQ==
X-Gm-Message-State: AOAM530296Y+VFvUZ4GJqZC+MD2oVVXsWkcAnW8NSBVK/O6WFiKrzVgj
        gd0TraMxpa/4y+SfgGWiQLK9k4J3BJyypjLm5hz2
X-Google-Smtp-Source: ABdhPJw0X+MoNWQ7FDxL3gL75dC/StudsMpEmpggdeA+St1S67D7g9NbXeHDH+g+Se1J4Ppv5218Hb0YjTU0PjKYiD8=
X-Received: by 2002:a50:e004:0:b0:410:a39b:e30c with SMTP id
 e4-20020a50e004000000b00410a39be30cmr1275208edl.198.1645652219317; Wed, 23
 Feb 2022 13:36:59 -0800 (PST)
MIME-Version: 1.0
References: <20220221131533.74238-1-richard_c_haines@btinternet.com>
 <CAHC9VhQnRQFrM-mTzUQ3UsyVp2JYw1wUh=7yrdjH7-QmHKidAg@mail.gmail.com>
 <20396305e71619dbee4fa3c612925b57f4bb0a4b.camel@btinternet.com>
 <CAFqZXNuf5J35Jb3nmQ6YRrc6C2f5rk-30U0rB4wTMd-+SBQhEQ@mail.gmail.com> <2b45951fceea5f535550f8ab3f3d25c3ff12a8c5.camel@btinternet.com>
In-Reply-To: <2b45951fceea5f535550f8ab3f3d25c3ff12a8c5.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 23 Feb 2022 16:36:48 -0500
Message-ID: <CAHC9VhSDavBRxWEp2frY_dkSaxSBHfiCZ1zF2YNNoq6+-+GTjA@mail.gmail.com>
Subject: Re: [PATCH V2] security/selinux: Always allow FIOCLEX and FIONCLEX
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
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

On Wed, Feb 23, 2022 at 7:43 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Wed, 2022-02-23 at 13:12 +0100, Ondrej Mosnacek wrote:
> > On Wed, Feb 23, 2022 at 12:58 PM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > > On Tue, 2022-02-22 at 18:28 -0500, Paul Moore wrote:
> > > > On Mon, Feb 21, 2022 at 8:15 AM Richard Haines
> > > > <richard_c_haines@btinternet.com> wrote:
> > > > >
> > > > > These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which
> > > > > SELinux
> > > > > always allows too.  Furthermore, a failed FIOCLEX could result
> > > > > in a
> > > > > file
> > > > > descriptor being leaked to a process that should not have
> > > > > access to
> > > > > it.
> > > > >
> > > > > As this patch removes access controls, a policy capability
> > > > > needs to
> > > > > be
> > > > > enabled in policy to always allow these ioctls.
> > > > >
> > > > > Based-on-patch-by: Demi Marie Obenour <demiobenour@gmail.com>
> > > > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > > > ---
> > > > > V2 Change: Control via a policy capability. See this thread for
> > > > > discussion:
> > > > > https://lore.kernel.org/selinux/CAHC9VhQEPxYP_KU56gAGNHKQaxucY8gSsHiUB42PVgADBAccRQ@mail.gmail.com/T/#t
> > > > >
> > > > > With this patch and the polcap enabled, the selinux-testsuite
> > > > > will
> > > > > fail:
> > > > > ioctl/test at line 47 - Will need a fix.
> > > > >
> > > > >  security/selinux/hooks.c                   | 7 +++++++
> > > > >  security/selinux/include/policycap.h       | 1 +
> > > > >  security/selinux/include/policycap_names.h | 3 ++-
> > > > >  security/selinux/include/security.h        | 7 +++++++
> > > > >  4 files changed, 17 insertions(+), 1 deletion(-)
> > > >
> > > > Thanks Richard for putting together the v2 of this patch.
> > > >
> > > > As far as the test is concerned, it seems like the quick-n-dirty
> > > > fix
> > > > is to simply remove the ioctl(FIOCLEX) test in test_noioctl.c; is
> > > > everyone okay with that?  At least that is what I'm going to do
> > > > with
> > > > my local copy that I use to validate the kernel-secnext builds
> > > > unless
> > > > someone has a better patch :)
> > >
> > > To fix this I was planning to submit a patch that would change the
> > > ioctl(FIOCLEX) tests to ioctl(FS_IOC_GETFSLABEL) as that would
> > > continue
> > > to test the xperms.
> >
> > That one seems to be implemented only by some filesystems. Is there
> > any more generic one we could use?
>
> What about  FS_IOC_GETFLAGS

Unless I'm mistaken, FIGETBSZ should be largely fs independent.

> > > > > diff --git a/security/selinux/hooks.c
> > > > > b/security/selinux/hooks.c
> > > > > index 5b6895e4f..030c41652 100644
> > > > > --- a/security/selinux/hooks.c
> > > > > +++ b/security/selinux/hooks.c
> > > > > @@ -3745,6 +3745,13 @@ static int selinux_file_ioctl(struct
> > > > > file
> > > > > *file, unsigned int cmd,
> > > > >                                             CAP_OPT_NONE,
> > > > > true);
> > > > >                 break;
> > > > >
> > > > > +       case FIOCLEX:
> > > > > +       case FIONCLEX:
> > > > > +               /* Must always succeed if polcap set, else
> > > > > default:
> > > > > */
> > > > > +               if (selinux_policycap_ioctl_skip_cloexec())
> > > > > +                       break;
> > > > > +               fallthrough;
> > > > > +
> > > >
> > > > The break/fallthrough looks like it might be a little more
> > > > fragile
> > > > than necessary, how about something like this:
> > > >
> > > >   case FIOCLEX:
> > > >   case FIONCLEX:
> > > >     if (!selinux_policycap_ioctl_skip_cloexec())
> > > >       error = ioctl_has_perm(cred, file, FILE__IOCTL, (u16) cmd);
> > > >       break;
> > > >
> > > > Yes, it does duplicate the default ioctl_has_perm() call, but
> > > > since
> > > > we
> > > > are effectively deprecating this and locking the FIOCLEX/FIONCLEX
> > > > behavior with this policy capability it seems okay to me (and
> > > > preferable to relying on the fallthrough).
> > > >
> > > > Thoughts?
> > >
> > > Yes I did ponder this and in my first attempt I had this before the
> > > switch():
> > >
> > >         /* Must always succeed if polcap set */
> > >         if (selinux_policycap_ioctl_skip_cloexec() &&
> > >             (cmd == FIOCLEX || cmd == FIONCLEX))
> > >                 return 0;
> > >
> > >         switch (cmd) {
> > >         case FIONREAD:
> > >         case FIBMAP:
> > >
> > > but changed to within the switch(), anyway I'm happy to resubmit a
> > > patch either way.
> >
> > I agree with Paul's suggestion. Better to duplicate the simple call
> > than to complicate the code flow.
>
> Okay will use Paul's.

Thanks guys.

-- 
paul-moore.com

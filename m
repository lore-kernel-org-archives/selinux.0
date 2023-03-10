Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ACFC6FA99
	for <selinux@archiver.kernel.org>; Fri, 10 Mar 2023 16:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjCJQ4k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Mar 2023 11:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCJQ4V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Mar 2023 11:56:21 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7841C4C6F5
        for <selinux@vger.kernel.org>; Fri, 10 Mar 2023 08:53:51 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id s17so3414138pgv.4
        for <selinux@vger.kernel.org>; Fri, 10 Mar 2023 08:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678467225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9Kr/ULieTL6TnJsL/C2i4tpc4KsUDI1Hns68tq8daE=;
        b=EQsSqc6nS51GS+NGExHjbTbSQv2Vb0xllJ0HNIGc/6rdB0OUjHmymYxjjj/XNP/W0z
         Zu0IWca1HRq4spMLKHlKsLNn4ONxSTStl/6xd5ncGegiINyEV6ucrA3QbM3D+sthcbSJ
         5MuYzKk8LEb1pgKkFgenKx3E5BrvoEbSWFQSsri29J1+AWdy0ztG7VoPdO0qZsDpRvm8
         PnP8JJsB9aMTM881bSL/c4XkwQ7A/RavJNunF1WKuAyGX+uldAZn4QyA5Oi015WhXdg6
         gYjAyFME4mHZjahvphboKTcfuMstlInvmvIpzK41LJ5KLHFCq0DlLsXSXHl4Ey0hvJte
         qVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678467225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9Kr/ULieTL6TnJsL/C2i4tpc4KsUDI1Hns68tq8daE=;
        b=rk2fUOISUq4zTvlmAZ64kdd5amr2wZcQU5OpoxqkXEXrqCIr16Kzs1UfLpfefDnaIZ
         L3lMKMq/s85TJLVC72n+K5CFfh/uWW+Ozc2f5BJ6ekxEWz3m3Q0J85bhXfi3TEYhFcES
         srntfLJ+x3f5cqgSUGb3ZalJUYg8oEsYMA4A4cZzExzrHY1vJ7Fgaz1KbBGEyKsA5LAx
         QDYDJYpNvfiexjlQxLl7Aw+pcDH9JEgZgaXkVDLjzHlKEJXKda+P/d5J2fuYMTu+0BK5
         UEFTmX1h3iRs7hlTdx3sKLq6OzG+vw534YjQvJDrvPbJIjKxF4AsqiJpbFAAtl6KLiVq
         lnZA==
X-Gm-Message-State: AO0yUKWQo/pT3r0Jxyf+6mZf6ZE07k6su60VHT8BTRBghDa2Z9duDAi8
        2TVh1upBesttNg88CGwOCOxjVngRvga8Oaab6LE=
X-Google-Smtp-Source: AK7set+9H8CvCu+bDnc3MO8ImXCZcPASLIbgk78SWG/l9kToglghFk8WVEcQyyyelAEjMs2IlQiS0Og3s6qXdpBSwWc=
X-Received: by 2002:a62:8307:0:b0:5a8:4dc1:5916 with SMTP id
 h7-20020a628307000000b005a84dc15916mr10831420pfe.2.1678467225185; Fri, 10 Mar
 2023 08:53:45 -0800 (PST)
MIME-Version: 1.0
References: <20230309191741.15063-1-stephen.smalley.work@gmail.com>
 <CAHC9VhTCScrPmzrzSVPqF0G==4+qxd=KSeBw7s3T_46rDgKoXQ@mail.gmail.com>
 <CAEjxPJ4R0U7TL3EAjU8_nnbmgoSaO+DN9SoB+PuC1HkOcrfAuw@mail.gmail.com>
 <CAHC9VhQ1-SeA+XS-Y2M5OydM79qu+GA0L770_A0Zf2C6wN80kw@mail.gmail.com>
 <CAEjxPJ57usjUurU0Rkgzcv6evYDeyJrX-msROH6QagYRkOxsug@mail.gmail.com> <CAHC9VhTh5JK_+9NY7FRzG1MYp6ZO9d80ubfhi0dcXKzCJJ0WkQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTh5JK_+9NY7FRzG1MYp6ZO9d80ubfhi0dcXKzCJJ0WkQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 10 Mar 2023 11:53:34 -0500
Message-ID: <CAEjxPJ7eQUPpfSk_AObUCowh4v2qO1jn6Fis+Cx8Y0vcVB7zCw@mail.gmail.com>
Subject: Re: [PATCH] selinux: stop passing selinux_state pointers and their offspring
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, torvalds@linux-foundation.org,
        omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 10, 2023 at 10:11=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Fri, Mar 10, 2023 at 8:47=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Thu, Mar 9, 2023 at 4:15=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Thu, Mar 9, 2023 at 3:55=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > On Thu, Mar 9, 2023 at 3:48=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> > > > > On Thu, Mar 9, 2023 at 2:18=E2=80=AFPM Stephen Smalley
> > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > >
> > > > > > Linus observed that the pervasive passing of selinux_state poin=
ters
> > > > > > introduced by me in commit aa8e712cee93 ("selinux: wrap global =
selinux
> > > > > > state") adds overhead and complexity without providing any
> > > > > > benefit. The original idea was to pave the way for SELinux name=
spaces
> > > > > > but those have not yet been implemented and there isn't current=
ly
> > > > > > a concrete plan to do so. Remove the passing of the selinux_sta=
te
> > > > > > pointers, reverting to direct use of the single global selinux_=
state,
> > > > > > and likewise remove passing of child pointers like the selinux_=
avc.
> > > > > > The selinux_policy pointer remains as it is needed for atomic s=
witching
> > > > > > of policies.
> > > > > >
> > > > > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > > > ---
> > > > > >  security/selinux/avc.c                 | 197 ++++-----
> > > > > >  security/selinux/hooks.c               | 549 ++++++++++-------=
--------
> > > > > >  security/selinux/ibpkey.c              |   2 +-
> > > > > >  security/selinux/ima.c                 |  37 +-
> > > > > >  security/selinux/include/avc.h         |  29 +-
> > > > > >  security/selinux/include/avc_ss.h      |   3 +-
> > > > > >  security/selinux/include/conditional.h |   4 +-
> > > > > >  security/selinux/include/ima.h         |  10 +-
> > > > > >  security/selinux/include/security.h    | 171 +++-----
> > > > > >  security/selinux/netif.c               |   2 +-
> > > > > >  security/selinux/netlabel.c            |  17 +-
> > > > > >  security/selinux/netnode.c             |   4 +-
> > > > > >  security/selinux/netport.c             |   2 +-
> > > > > >  security/selinux/selinuxfs.c           | 208 ++++------
> > > > > >  security/selinux/ss/services.c         | 346 +++++++---------
> > > > > >  security/selinux/ss/services.h         |   1 -
> > > > > >  security/selinux/status.c              |  44 +-
> > > > > >  security/selinux/xfrm.c                |  20 +-
> > > > > >  18 files changed, 651 insertions(+), 995 deletions(-)
> > > > >
> > > > > It looks like this patch was a bit too big for the mailing list; =
I'm
> > > > > trimming my reply to get this discussion on the list.
> > > > >
> > > > > I strongly dislike merging patches that haven't hit the list, but=
 I do
> > > > > recognize that this is a bit of an unusual case.  Have you tried
> > > > > breaking this up into two (three?) patches?  I imagine that shoul=
d be
> > > > > possible, although I worry that the time required to do that woul=
d be
> > > > > prohibitive given the change itself.
> > > > >
> > > > > If that doesn't work, an alternative might be to file a PR agains=
t our
> > > > > kernel subsystem mirror on GitHub and posting a link to the PR he=
re.
> > > > > I don't want to encourage this as a general way of submitting SEL=
inux
> > > > > kernel patches, but I could make an exception here.
> > > > >
> > > > > https://github.com/SELinuxProject/selinux-kernel
> > > >
> > > > I'm open to suggestions but didn't see an obvious way to split it i=
n a
> > > > manner that keeps everything in a working state after each patch.
> > > > checkpatch.pl didn't complain about the size - not sure if that is =
a
> > > > change in policy.
> > >
> > > I'm not sure checkpatch.pl is the right place for that anyway as ever=
y
> > > list could have a different policy.
> > >
> > > FWIW, many years ago I was told to keep the diffstat under a thousand
> > > lines as a general rule.  While I've seen patches go over that limit
> > > and hit various @vger lists, I personally try to keep my patches unde=
r
> > > that 1k limit, and generally that isn't too hard.  This really is a
> > > bit of a special case I think.
> > >
> > > > Created a PR here:
> > > > https://github.com/SELinuxProject/selinux-kernel/pull/64
> > >
> > > Thanks, I'll work from that.
> >
> > For those following along on the mailing list, the kernel test robot
> > reported a problem with the original patch when lockdep is enabled, so
> > I generated a v2 patch and updated the PR (same link above).
>
> That's interesting.  Does that mean that your original patch made it
> to the mailing list but somehow didn't make it to the lore archive?  I
> just (re)checked and there is no record of your patch in the archive
> or the patchwork instance.
>
> How did the kernel test robot get the patch to test?  Does it know to
> go fetch GH PR URLs?

The email from the robot referenced the PR so it appears to be
watching for PRs to certain GH repositories and automatically testing
them.

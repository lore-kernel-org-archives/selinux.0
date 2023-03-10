Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123B0C64EC4
	for <selinux@archiver.kernel.org>; Fri, 10 Mar 2023 15:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjCJPWh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Mar 2023 10:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbjCJPWT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Mar 2023 10:22:19 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151CE1480EB
        for <selinux@vger.kernel.org>; Fri, 10 Mar 2023 07:12:24 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id y19so3223197pgk.5
        for <selinux@vger.kernel.org>; Fri, 10 Mar 2023 07:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678461106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcqzgShJqcoCXYMZgzOxbdpeb1Qvk73+S7EItldnGP0=;
        b=ZaqVZ9EbL+8J27fVzUS3/vtK7g3dJbFfQtEnpWn1ikXxYaiLyjDtaRPgsfbNzIvLSL
         g9pqcSWCyhplZ8saWHfxbGUB3W5s69EAao2z9cVTDn9suCm2pq+jCDrVCNw/LrsLq/Me
         N6krbe2AGaFnFmBMG/OE/GFvW5taHzHEWvpwvq57CJK7+cBhNGUsOtk/owsN9k7GJUY8
         gcUpAQPG2NCsYf318rygyBBBe82jRmD/YJShUXzHkNTtqQyT8+9yP5GytIAQ6g/vMc/Q
         SlzAL3nomSjevak+L7GkycjMR/xooP0JtzoDxDcHxAlMxZMXdpcfzKnsJfaUgXIswYgu
         RVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678461106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcqzgShJqcoCXYMZgzOxbdpeb1Qvk73+S7EItldnGP0=;
        b=K+LxUYO2/EA7RlmhGx2iQNHrpSYroGxzfNqNFEpYU0SFY8auMEe9GD/pbROG0LfeTz
         jYRMXrP+faMOfFQAqFyj3lB8JD+wZ26KRJjcWuaZnxNVA4oog14qB6RcHNxFBHzZr6G8
         TGeFjalPUxH/K0YTJYB3WyI7fDCD6Wnq8XUJQWES4OU+5a7/RykhoiHFU4iVPLCTmPED
         yppQT4G76qvc62yVxtrcl6hHxB17A/GbhlzWAu1TqcyF1eMYyN+vbmX+RzX71+LBmVTL
         PO1fyn++goxf4VJHiZZ5pHfJeCv0VaPflwliMdQ4kLN65LpaQYvd3xSxhm7241CuVqOU
         uwXQ==
X-Gm-Message-State: AO0yUKWGsEZAiidRhHFb1Xzae+Z8dZkjzl8LlxRbtEpd+DHIWWp5PzR8
        Hd8MTQm5WG0FSSwlAj9M6tlzfUHWfZ49UvM3dL3K
X-Google-Smtp-Source: AK7set9zg0E2l+St1zYWZ6mPESPz5nP49rDU1yhlAjndsabjdKB9rDqZZh9wp/oUzaDrMLdoQTOTpXeckzCAZzR2Ijc=
X-Received: by 2002:a62:860d:0:b0:5f4:fe6d:fafa with SMTP id
 x13-20020a62860d000000b005f4fe6dfafamr10616433pfd.0.1678461106261; Fri, 10
 Mar 2023 07:11:46 -0800 (PST)
MIME-Version: 1.0
References: <20230309191741.15063-1-stephen.smalley.work@gmail.com>
 <CAHC9VhTCScrPmzrzSVPqF0G==4+qxd=KSeBw7s3T_46rDgKoXQ@mail.gmail.com>
 <CAEjxPJ4R0U7TL3EAjU8_nnbmgoSaO+DN9SoB+PuC1HkOcrfAuw@mail.gmail.com>
 <CAHC9VhQ1-SeA+XS-Y2M5OydM79qu+GA0L770_A0Zf2C6wN80kw@mail.gmail.com> <CAEjxPJ57usjUurU0Rkgzcv6evYDeyJrX-msROH6QagYRkOxsug@mail.gmail.com>
In-Reply-To: <CAEjxPJ57usjUurU0Rkgzcv6evYDeyJrX-msROH6QagYRkOxsug@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Mar 2023 10:11:35 -0500
Message-ID: <CAHC9VhTh5JK_+9NY7FRzG1MYp6ZO9d80ubfhi0dcXKzCJJ0WkQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: stop passing selinux_state pointers and their offspring
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org, torvalds@linux-foundation.org,
        omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 10, 2023 at 8:47=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Mar 9, 2023 at 4:15=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Thu, Mar 9, 2023 at 3:55=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Thu, Mar 9, 2023 at 3:48=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > > On Thu, Mar 9, 2023 at 2:18=E2=80=AFPM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > Linus observed that the pervasive passing of selinux_state pointe=
rs
> > > > > introduced by me in commit aa8e712cee93 ("selinux: wrap global se=
linux
> > > > > state") adds overhead and complexity without providing any
> > > > > benefit. The original idea was to pave the way for SELinux namesp=
aces
> > > > > but those have not yet been implemented and there isn't currently
> > > > > a concrete plan to do so. Remove the passing of the selinux_state
> > > > > pointers, reverting to direct use of the single global selinux_st=
ate,
> > > > > and likewise remove passing of child pointers like the selinux_av=
c.
> > > > > The selinux_policy pointer remains as it is needed for atomic swi=
tching
> > > > > of policies.
> > > > >
> > > > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > > ---
> > > > >  security/selinux/avc.c                 | 197 ++++-----
> > > > >  security/selinux/hooks.c               | 549 ++++++++++---------=
------
> > > > >  security/selinux/ibpkey.c              |   2 +-
> > > > >  security/selinux/ima.c                 |  37 +-
> > > > >  security/selinux/include/avc.h         |  29 +-
> > > > >  security/selinux/include/avc_ss.h      |   3 +-
> > > > >  security/selinux/include/conditional.h |   4 +-
> > > > >  security/selinux/include/ima.h         |  10 +-
> > > > >  security/selinux/include/security.h    | 171 +++-----
> > > > >  security/selinux/netif.c               |   2 +-
> > > > >  security/selinux/netlabel.c            |  17 +-
> > > > >  security/selinux/netnode.c             |   4 +-
> > > > >  security/selinux/netport.c             |   2 +-
> > > > >  security/selinux/selinuxfs.c           | 208 ++++------
> > > > >  security/selinux/ss/services.c         | 346 +++++++---------
> > > > >  security/selinux/ss/services.h         |   1 -
> > > > >  security/selinux/status.c              |  44 +-
> > > > >  security/selinux/xfrm.c                |  20 +-
> > > > >  18 files changed, 651 insertions(+), 995 deletions(-)
> > > >
> > > > It looks like this patch was a bit too big for the mailing list; I'=
m
> > > > trimming my reply to get this discussion on the list.
> > > >
> > > > I strongly dislike merging patches that haven't hit the list, but I=
 do
> > > > recognize that this is a bit of an unusual case.  Have you tried
> > > > breaking this up into two (three?) patches?  I imagine that should =
be
> > > > possible, although I worry that the time required to do that would =
be
> > > > prohibitive given the change itself.
> > > >
> > > > If that doesn't work, an alternative might be to file a PR against =
our
> > > > kernel subsystem mirror on GitHub and posting a link to the PR here=
.
> > > > I don't want to encourage this as a general way of submitting SELin=
ux
> > > > kernel patches, but I could make an exception here.
> > > >
> > > > https://github.com/SELinuxProject/selinux-kernel
> > >
> > > I'm open to suggestions but didn't see an obvious way to split it in =
a
> > > manner that keeps everything in a working state after each patch.
> > > checkpatch.pl didn't complain about the size - not sure if that is a
> > > change in policy.
> >
> > I'm not sure checkpatch.pl is the right place for that anyway as every
> > list could have a different policy.
> >
> > FWIW, many years ago I was told to keep the diffstat under a thousand
> > lines as a general rule.  While I've seen patches go over that limit
> > and hit various @vger lists, I personally try to keep my patches under
> > that 1k limit, and generally that isn't too hard.  This really is a
> > bit of a special case I think.
> >
> > > Created a PR here:
> > > https://github.com/SELinuxProject/selinux-kernel/pull/64
> >
> > Thanks, I'll work from that.
>
> For those following along on the mailing list, the kernel test robot
> reported a problem with the original patch when lockdep is enabled, so
> I generated a v2 patch and updated the PR (same link above).

That's interesting.  Does that mean that your original patch made it
to the mailing list but somehow didn't make it to the lore archive?  I
just (re)checked and there is no record of your patch in the archive
or the patchwork instance.

How did the kernel test robot get the patch to test?  Does it know to
go fetch GH PR URLs?

--=20
paul-moore.com

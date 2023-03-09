Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6E0C6FD19
	for <selinux@archiver.kernel.org>; Thu,  9 Mar 2023 21:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjCIVPO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Mar 2023 16:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjCIVPN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Mar 2023 16:15:13 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C794FEBF95
        for <selinux@vger.kernel.org>; Thu,  9 Mar 2023 13:15:11 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id i5so3422642pla.2
        for <selinux@vger.kernel.org>; Thu, 09 Mar 2023 13:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678396511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOWR/kxY475Ov5B+hgURV/5vuz1QwLnyapJFdYiDys0=;
        b=aTcakOtlx8m9iTdSJh1WUQG9n9suEuVUBlglYWSZ5ZILWTPXiHIfGi+38DRN9dxR22
         soKrvdlukywUK+htfLkihR6KQr0J4ofYvSAw0pfytl0ewMe5dUivxRwk8KBboam6tOAN
         IDVBzQhqvsDwm3Vr7kNl21BfPAO/8o9Yj0uDYWIsvcSSEhlcXM6YoSV7orr8esyLxY6G
         /UtY72RAb5KfjRL0SxyQkCaXaiKt7tG04O9IrrLiDH4a7WWhSBb4ViJM8wEXjBy89Yyc
         Tjop9NpWW6gpY/pdC0h22iqTq+FG35UAbdsOQbdOFWs7QbECBQ0HipMziWqgccaFT1Fe
         4vNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678396511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOWR/kxY475Ov5B+hgURV/5vuz1QwLnyapJFdYiDys0=;
        b=7fncS6JZPJE/rhVP9t9KzoQt9OFmpK1xsRk8x0t2YZ5QFCBjQRWOzIABdOoRqVd8OH
         laj0PaRPha4tnMSQx5dHxtNdaV3QySrcsI/6ltV5MD3/ZPlPL0OJOAnyocn097SEdB6l
         z1lfh3f3kPbXUqezVz8teHyCYzI+2ug3MU5T+opOKOIrrJRyWCoDzxaIIBVElUQEJxxS
         lXOaFfT3NB0urEMJmaguW1Iyw3U7rPA0Iah3NgPrPfaS8nyD3cKKBJ/4MANJoVTfFX9d
         DVc6hmW6MtV8AIwl79r+Ef5v6SJqofoqOZb9Zgqtqsb48mIW1r29bGxiCUAo4+G1uMXh
         6MSQ==
X-Gm-Message-State: AO0yUKU+APjFXftYGvNpzTDZbdJ9voDxL6j/Iarp4RUmxzkWQessD1f9
        QSmQtwBCYpJKmFUM01KUtaqpCTIycW2CA9pIlWRW
X-Google-Smtp-Source: AK7set+Pf8YyM769hcA7pBXTW5zm8tuSfgT3ot0n+abuwlfq1sFP9DI6KjCncNvHv4tCXq7AlzheigxR5A69OUsiHTQ=
X-Received: by 2002:a17:903:2587:b0:19a:9f86:adab with SMTP id
 jb7-20020a170903258700b0019a9f86adabmr8941372plb.7.1678396511134; Thu, 09 Mar
 2023 13:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20230309191741.15063-1-stephen.smalley.work@gmail.com>
 <CAHC9VhTCScrPmzrzSVPqF0G==4+qxd=KSeBw7s3T_46rDgKoXQ@mail.gmail.com> <CAEjxPJ4R0U7TL3EAjU8_nnbmgoSaO+DN9SoB+PuC1HkOcrfAuw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4R0U7TL3EAjU8_nnbmgoSaO+DN9SoB+PuC1HkOcrfAuw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 Mar 2023 16:15:00 -0500
Message-ID: <CAHC9VhQ1-SeA+XS-Y2M5OydM79qu+GA0L770_A0Zf2C6wN80kw@mail.gmail.com>
Subject: Re: [PATCH] selinux: stop passing selinux_state pointers and their offspring
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org, torvalds@linux-foundation.org,
        omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 9, 2023 at 3:55=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Mar 9, 2023 at 3:48=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > On Thu, Mar 9, 2023 at 2:18=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > Linus observed that the pervasive passing of selinux_state pointers
> > > introduced by me in commit aa8e712cee93 ("selinux: wrap global selinu=
x
> > > state") adds overhead and complexity without providing any
> > > benefit. The original idea was to pave the way for SELinux namespaces
> > > but those have not yet been implemented and there isn't currently
> > > a concrete plan to do so. Remove the passing of the selinux_state
> > > pointers, reverting to direct use of the single global selinux_state,
> > > and likewise remove passing of child pointers like the selinux_avc.
> > > The selinux_policy pointer remains as it is needed for atomic switchi=
ng
> > > of policies.
> > >
> > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > >  security/selinux/avc.c                 | 197 ++++-----
> > >  security/selinux/hooks.c               | 549 ++++++++++-------------=
--
> > >  security/selinux/ibpkey.c              |   2 +-
> > >  security/selinux/ima.c                 |  37 +-
> > >  security/selinux/include/avc.h         |  29 +-
> > >  security/selinux/include/avc_ss.h      |   3 +-
> > >  security/selinux/include/conditional.h |   4 +-
> > >  security/selinux/include/ima.h         |  10 +-
> > >  security/selinux/include/security.h    | 171 +++-----
> > >  security/selinux/netif.c               |   2 +-
> > >  security/selinux/netlabel.c            |  17 +-
> > >  security/selinux/netnode.c             |   4 +-
> > >  security/selinux/netport.c             |   2 +-
> > >  security/selinux/selinuxfs.c           | 208 ++++------
> > >  security/selinux/ss/services.c         | 346 +++++++---------
> > >  security/selinux/ss/services.h         |   1 -
> > >  security/selinux/status.c              |  44 +-
> > >  security/selinux/xfrm.c                |  20 +-
> > >  18 files changed, 651 insertions(+), 995 deletions(-)
> >
> > It looks like this patch was a bit too big for the mailing list; I'm
> > trimming my reply to get this discussion on the list.
> >
> > I strongly dislike merging patches that haven't hit the list, but I do
> > recognize that this is a bit of an unusual case.  Have you tried
> > breaking this up into two (three?) patches?  I imagine that should be
> > possible, although I worry that the time required to do that would be
> > prohibitive given the change itself.
> >
> > If that doesn't work, an alternative might be to file a PR against our
> > kernel subsystem mirror on GitHub and posting a link to the PR here.
> > I don't want to encourage this as a general way of submitting SELinux
> > kernel patches, but I could make an exception here.
> >
> > https://github.com/SELinuxProject/selinux-kernel
>
> I'm open to suggestions but didn't see an obvious way to split it in a
> manner that keeps everything in a working state after each patch.
> checkpatch.pl didn't complain about the size - not sure if that is a
> change in policy.

I'm not sure checkpatch.pl is the right place for that anyway as every
list could have a different policy.

FWIW, many years ago I was told to keep the diffstat under a thousand
lines as a general rule.  While I've seen patches go over that limit
and hit various @vger lists, I personally try to keep my patches under
that 1k limit, and generally that isn't too hard.  This really is a
bit of a special case I think.

> Created a PR here:
> https://github.com/SELinuxProject/selinux-kernel/pull/64

Thanks, I'll work from that.

--=20
paul-moore.com

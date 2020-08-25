Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3BDC433DF
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 17:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3489D207BC
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 17:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5GS8Wol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHYRrb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYRra (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 13:47:30 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F509C061574;
        Tue, 25 Aug 2020 10:47:30 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k2so4522448ots.4;
        Tue, 25 Aug 2020 10:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HyMrtU/7MgkVL+vpZCj4h11Rs4wMfdxZeJcMwtMTVYc=;
        b=o5GS8WolA+iNKEdGSYTsoWISB9AjMa/UcgvsSACzM+DZp3MS/gWAGEQEQ6HuTjsycZ
         HPJRIALpb1jmanyxlzCLJhLEdVWWy6hc70OXPzvUVWtbNc+COzYsN7j4tbn1QkOhAcr9
         6yGjuKbjtZGCDhg0PLKhElkBE7N4LNtLT6z8y2MWtGXg74ZOY94aKe0crF5VWpNGSVT/
         9lBfRc1GhG6lU7vN3mPDYwG5SOZ1iHLEP/KKps6jyTjf2qpXlkW3NbSIe7ekjzxZUC3D
         1prq49KJt/no5lGyUvKqjTwGKNRNhDUcw26YBlJlfr744jjLG7i2Mvfx81HWiMaD/qp/
         WdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HyMrtU/7MgkVL+vpZCj4h11Rs4wMfdxZeJcMwtMTVYc=;
        b=W35qDkE1nJ1kyofWMq6Jjd9KwMKwHoxd69fBhblxA8Vslg7reUGMIwFdThiyTIdwRa
         TZnLBvH0sPEAnIeStRGhLoLmwplwIf4jBzGKlFfONWkY9XbYQi8MmjxbILM14V0pcf0M
         jQO4feKterSE79ziwtpzvSvi0iMwoS/rrt6Ie/32fHKvFpxP3LyisWwC3VBmDVQRVSpa
         dDmyx3fHsRt+shR4iyF1rph1/twyqDTpEoffyYN8uAdffVweMjCk4WDIVF1dRDNm2DwI
         E2TqPhmPkvP6hdsq39aVHf48CgSqK4mbuugEFNQcq7zsnnQExtX2aL6R4YddT2Dfjlc8
         YSqA==
X-Gm-Message-State: AOAM533DRF8tQxoJJaQjx8uRcER/zKZn8vWHMlShMMofVvXcKDxUjmdQ
        8rITB9ZVOGb5IKt2ZtRuYfypjDWatnoNEGb8MwfHh+533As=
X-Google-Smtp-Source: ABdhPJzqPCZxr6cFbmczOdCqC2P0TQWuYE3JripQcX2JbLPXoPXypP0jGHRz7iU5aJNoVUXAz5s6LH+T8wTEm/N0e6c=
X-Received: by 2002:a05:6830:16d8:: with SMTP id l24mr7149154otr.89.1598377649504;
 Tue, 25 Aug 2020 10:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200825152045.1719298-1-omosnace@redhat.com> <20200825152045.1719298-3-omosnace@redhat.com>
 <CAEjxPJ4UYV5OqtumoN9tK5wAQbOjuP0tUKW6dTPgftWxbY+R-w@mail.gmail.com> <CAFqZXNtLn_Tw_t1bnzYJ+cH_Kw8CUjs7kBdHKbMTp5WYBw7Fmw@mail.gmail.com>
In-Reply-To: <CAFqZXNtLn_Tw_t1bnzYJ+cH_Kw8CUjs7kBdHKbMTp5WYBw7Fmw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 25 Aug 2020 13:46:02 -0400
Message-ID: <CAEjxPJ5afetsB26nT+VwiNjTYZyM684qD+9WYdN8NEdiRXk99Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] selinux: remove the 'initialized' flag from selinux_state
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        rcu@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 25, 2020 at 1:21 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Tue, Aug 25, 2020 at 6:07 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Tue, Aug 25, 2020 at 11:20 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > After the RCU conversion, it is possible to simply check the policy
> > > pointer against NULL instead.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> >
> > > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > > index ec4570d6c38f7..d863b23f2a670 100644
> > > --- a/security/selinux/ss/services.c
> > > +++ b/security/selinux/ss/services.c
> > > @@ -2221,20 +2218,19 @@ void selinux_policy_commit(struct selinux_state *state,
> > >         /* Load the policycaps from the new policy */
> > >         security_load_policycaps(state, newpolicy);
> > >
> > > -       if (!selinux_initialized(state)) {
> > > +       if (!oldpolicy) {
> > >                 /*
> > >                  * After first policy load, the security server is
> > >                  * marked as initialized and ready to handle requests and
> > >                  * any objects created prior to policy load are then labeled.
> > >                  */
> > > -               selinux_mark_initialized(state);
> > >                 selinux_complete_init();
> >
> > This isn't quite equivalent. The difference is whether
> > security_load_policycaps() has completed.  Not sure of the
> > implications but could yield different behavior.
>
> Good point... And you just reminded me of my plan to eliminate the
> selinux_state::policycap[] array and replace it with calls to
> security_policycap_supported(). That should have no more race
> conditions than the current code at least... I'll try to splice such a
> patch below this one for the next revision. Or is there some
> compelling reason to keep the array?

Only reason I can see would potentially be performance overhead of
ebitmap_get_bit().  Probably not significant.

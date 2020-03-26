Return-Path: <SRS0=8enA=5L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986CAC43331
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 16:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFD22073E
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 16:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYK12Pni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgCZQ53 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:57:29 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:40837 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZQ53 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Mar 2020 12:57:29 -0400
Received: by mail-ot1-f51.google.com with SMTP id r19so729482otn.7
        for <selinux@vger.kernel.org>; Thu, 26 Mar 2020 09:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ChFnDurC/dF0YghLINJ2jmNbVR+rP0PMG1eStwj1eDo=;
        b=AYK12PniKUrJtBiPU372MH2JUQjHBQDA5VhfY36eQJusJEnwHnecIIm4RbL/kUEHQc
         EjK/zep3a6BnWcgZrfRzwcKPE9Gsf18RfVt9u9jAYP5dUI1AXP0upkh6lnfBXPeARyHP
         5RVFKVaXoe8Fz/Yd9RPDzXGxRl2BFL0jzL/mNhJOPccQOJbI9yg9HAD+mOCqLsIxkCaR
         vjjpcOfQc02ByFAD79n2NZktqulvjBgoubgW+lQzJ6YtHVNb/Jv0dvfAvdWp9f0UCgBA
         1rcHIt+Sg7SLT4/qx/XJNqzBsjFx0lEd34QWKL2iIH24IJlOwH9wcWq7t1nbUcVH2ycw
         56Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ChFnDurC/dF0YghLINJ2jmNbVR+rP0PMG1eStwj1eDo=;
        b=Zlp5j4S8PB9aUcoZVZyJotepNVkyTYwrBqjN954nczrQdEVMUgMQDEG5J7yKrHAUJ4
         ybGOEBI0hqgDbuIXOgMMFeTjBAyGSPAL6G9pPAz69NY2xkbsK7Gs7V0/YTG8VkaSzcVZ
         KdrRAAEzqRjpfLRSD4UM1tyZ7YiXSGrYYpPXbD98WTduxfDJmBKFRZ9OwEbh1XQzihYy
         soC875VjBOV2XpuURIG/as3sgWtscNcf1P/TS5uQDYOQ1n/SCmOnVn1E/nklfxOU0R58
         fetac/tr073Z49VJH1gHE26jwMH3rwp8tBusQs+ZS6qwEsO37tLEaskLyH00+zRfwYi1
         DzQA==
X-Gm-Message-State: ANhLgQ0e4pjO1KmNEtMlCqJrESFj+trZfZuOroc2840elS6XN2S69TVl
        h49rGd+4fv9yK2seTK6qcc++vwS3zUtabpQnhvA=
X-Google-Smtp-Source: ADFU+vsYdMS+0URuUZa0eKkS6Mg0pXB3BgdZv68Gp6o47njUx2C6w2o/+gCwsgsOdwKUhoYlW2Ekny8FJveTSPKkwQ8=
X-Received: by 2002:a05:6830:1f39:: with SMTP id e25mr7083458oth.135.1585241848985;
 Thu, 26 Mar 2020 09:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdr=2ji0=dG2Jc2A=rTcu215ETkeEkBxnp3UMeXzp=VRkA@mail.gmail.com>
 <CAEjxPJ4iQmgz0Po7o1REc5Fb63ci=6WtF8=e6zwD46=1o9x9SQ@mail.gmail.com>
 <CAFftDdrqHVgzNx75g2UfQwwzrp+uEnOmht+Lvp3A1svt3BJn1Q@mail.gmail.com> <CAEjxPJ6UMs+XgBm5ry98c41zKymKxO4QfSW+eyOaUe5xgQ6eaw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6UMs+XgBm5ry98c41zKymKxO4QfSW+eyOaUe5xgQ6eaw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 26 Mar 2020 12:58:30 -0400
Message-ID: <CAEjxPJ7YLp6_cAJ1bVUDy0638FpAy99wvBfEpKJxRkSUsTD-jw@mail.gmail.com>
Subject: Re: PR 193 sitting for uClibC fix
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 26, 2020 at 12:52 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Mar 26, 2020 at 12:46 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > On Thu, Mar 26, 2020 at 11:44 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Thu, Mar 26, 2020 at 12:22 PM William Roberts
> > > <bill.c.roberts@gmail.com> wrote:
> > > >
> > > > This PR:
> > > > https://github.com/SELinuxProject/selinux/pull/193
> > > >
> > > > Has been sitting forever. I looked through the mailing list and didn't
> > > > see any patches hit the list,
> > > > we should either close it, or merge it.
> > > >
> > > > Thoughts? If we need it to hit the list, can I grab it and sign-off on
> > > > it and post it?
> > >
> > > You can't sign-off on someone else's patch without them first signing off on it
> > > or otherwise certifying to you that it falls under clauses (a), (b),
> > > or (c) of the DCO.
> >
> > For some reason I just assumed it had a signed-off line, it doesn't though.
> >
> > > You could create your own patch to achieve the same end, especially
> > > since this one is trivial and seems
> > > to be modeled after an existing commit,
> > > ab0e27003ef245f20512d1808b1dfee662ab8f41, so it
> > > seems like it is relatively safe.
> >
> > I thought about creating it, but it's like how do I create such a trivial patch
> > and not get hit with I copied it.
>
> IANAL, but IIUC when something can only be done one way, it isn't copyrightable.
> Other possible ways to differentiate:
> - libselinux/src/Makefile provides a FTS_LDLIBS ?= definition, which
> was missing from their patch.
> Not sure that matters.
> - Instead of adding it LDLIBS for everything, could just add it where
> needed, similar to PCRE_LDLIBS.

Or you could just ping them on the github issue and ask if they will
at least certify
to the DCO as a github comment (or better, push a revised commit with sign-off)
and then you can take it from there.

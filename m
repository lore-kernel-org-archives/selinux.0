Return-Path: <SRS0=8enA=5L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5685AC43331
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 16:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D2E2073E
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 16:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAlnYYdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgCZQvm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:51:42 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:33418 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbgCZQvm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Mar 2020 12:51:42 -0400
Received: by mail-ot1-f51.google.com with SMTP id 22so6583179otf.0
        for <selinux@vger.kernel.org>; Thu, 26 Mar 2020 09:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3qHdOQm2zhSyZe9JKSbifySWC2xiDyAFA36FCwDnJjY=;
        b=BAlnYYdYv9tfGcpwQv6pqprxcn2AIx9MMUHfpPUPZptUeiDtrenBPYCSWVS+gUPKQh
         9bzOvxoC60DGyd+LOnSmBn9d7NV5IV0tJuLtz0aqBVikHjs2bvfC0PnuynvfZAfKCwgM
         8G2z+UBizzocymxd70nyXQOGZALjm3d/kROGQZGYjJ7pk8DGtEzHedjPUzDrvsMX7q1z
         72mopDl4Q4kKR+XJTcNAIG8TNVMBxoSWw7xa0X8t2usNI25qU4pTj+3MN1BIG/EgnHCz
         79HO+oBjHrDgabQLa1pcwDEm072kx4t0Y11O4975lCQd4RXDvgLKUICpGQbYm4FAAVk8
         jgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3qHdOQm2zhSyZe9JKSbifySWC2xiDyAFA36FCwDnJjY=;
        b=tBrYu2GOUhlKHkiXV5PHNqp1GLGegTH3EEalK4KNUyyEu7+gUm2fGjzad05ZlYhw7p
         qz+jv3vDuRPohU/DkhWBjfQtM+Zv9qXyagse5NuZ2HtzNXiOTnGYwhLKLj4jCs+l7Gwp
         kGIaKRrHANPJqF2y2TNrJ8VWn3JknQYMphnLxaTPxhRKSxrY/rQSSBjAhwBMOLHVWkoX
         HG6TI3tYgIgR5wxKmngz+7iSecMUYCbhZGNotSh3sdRUAubl3T9q+gMkrDk9kgrvRDg2
         vgFyESTqXNyLZ7LeED57F7dicIB4kL74v45sYnI2mxS6ngvGrrpOIrcv+U8pJOgMQUMW
         wPaw==
X-Gm-Message-State: ANhLgQ13D2rm8aT8l9S4Ae/5K7wkEg9LmPrROiO23eEObuRX2L/Bx053
        lZgGqFBsr6pKoKfhJtO3MZcmGQKnWnEBugc4xIk=
X-Google-Smtp-Source: ADFU+vuiG2Mx1HLVVS0ce8IdVs9EUJYZ10xSuBAGEoO9Q5PcsWeomaoRZsrzIDdAQgVbrHy4uJ0YZLJRMxyJisLIdNo=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr431756otl.162.1585241500100;
 Thu, 26 Mar 2020 09:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdr=2ji0=dG2Jc2A=rTcu215ETkeEkBxnp3UMeXzp=VRkA@mail.gmail.com>
 <CAEjxPJ4iQmgz0Po7o1REc5Fb63ci=6WtF8=e6zwD46=1o9x9SQ@mail.gmail.com> <CAFftDdrqHVgzNx75g2UfQwwzrp+uEnOmht+Lvp3A1svt3BJn1Q@mail.gmail.com>
In-Reply-To: <CAFftDdrqHVgzNx75g2UfQwwzrp+uEnOmht+Lvp3A1svt3BJn1Q@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 26 Mar 2020 12:52:42 -0400
Message-ID: <CAEjxPJ6UMs+XgBm5ry98c41zKymKxO4QfSW+eyOaUe5xgQ6eaw@mail.gmail.com>
Subject: Re: PR 193 sitting for uClibC fix
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 26, 2020 at 12:46 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Thu, Mar 26, 2020 at 11:44 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Mar 26, 2020 at 12:22 PM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > >
> > > This PR:
> > > https://github.com/SELinuxProject/selinux/pull/193
> > >
> > > Has been sitting forever. I looked through the mailing list and didn't
> > > see any patches hit the list,
> > > we should either close it, or merge it.
> > >
> > > Thoughts? If we need it to hit the list, can I grab it and sign-off on
> > > it and post it?
> >
> > You can't sign-off on someone else's patch without them first signing off on it
> > or otherwise certifying to you that it falls under clauses (a), (b),
> > or (c) of the DCO.
>
> For some reason I just assumed it had a signed-off line, it doesn't though.
>
> > You could create your own patch to achieve the same end, especially
> > since this one is trivial and seems
> > to be modeled after an existing commit,
> > ab0e27003ef245f20512d1808b1dfee662ab8f41, so it
> > seems like it is relatively safe.
>
> I thought about creating it, but it's like how do I create such a trivial patch
> and not get hit with I copied it.

IANAL, but IIUC when something can only be done one way, it isn't copyrightable.
Other possible ways to differentiate:
- libselinux/src/Makefile provides a FTS_LDLIBS ?= definition, which
was missing from their patch.
Not sure that matters.
- Instead of adding it LDLIBS for everything, could just add it where
needed, similar to PCRE_LDLIBS.

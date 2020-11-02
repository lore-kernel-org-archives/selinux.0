Return-Path: <SRS0=BHhV=EI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E96C00A89
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 14:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F7022453
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 14:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="cKB8qv/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgKBOqB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Nov 2020 09:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKBOqB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Nov 2020 09:46:01 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C2EC0617A6
        for <selinux@vger.kernel.org>; Mon,  2 Nov 2020 06:46:00 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id o18so14628722edq.4
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2020 06:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wngopIJHOfnpNZuCKzLgoJZNwvuVe+kwFEBGpax6XpQ=;
        b=cKB8qv/1meK5EZM2kNSAdnmRV5xhybonu/SMf851ghyOitPPQkKFvA/TSmcw1jUXKW
         m9rDgOXwdlDGpOSBp/Y69PGzd1efIS8GCXtJmbSgdGOmSqUg15uDH4ofCggq0UZBn4PH
         2ZNEHVzeKrKcQAyPzE2AiCSmXEG09pE3Pnh+5xXaZumno4Jd9VoeNvGMRvRUpe3qbGL0
         GFBEhBg6BGgx/3ZXAeuTl3CHAZs68G3IZJrLbRpYFlhGAnM3h6WCRc9DXRuMVabP36Wf
         o9SpFG5XnKQ49az7DszI9hk08PEwWsLpx8FZ2dPUpbsNkGNJnAhbilG6wb00tiuF89He
         b1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wngopIJHOfnpNZuCKzLgoJZNwvuVe+kwFEBGpax6XpQ=;
        b=GeIkUcdUafI2VpSVuDGHcg//JiyspqARnTmJKq3WGMaoy5Xv3brndi8RvccRQ912wB
         wItfRoLp1bAl4CNe+m5fFYbxID+15vRxlqCHkPFeDzjTh8dBny8RJ+VR8EB7fLxLh4Ei
         VvGs4qHRw1VPjyepPngbPQAr0736PrNc5Tv3roWNvQU0Ms5Sg7RyGYAbsp2ucChaiOUN
         ckbOS/216zuWWDO6DZj32T37tAPXGbRQz1qtTTDdBTU5Dj3VprOk9FEcLlEHvK9vNU4p
         cxyBf80g1YawBOuIQfjvl14fclSA1eUXeqFlxIls2KkYKJOXPgGptQtiiDw6uY2HIiYr
         XPRA==
X-Gm-Message-State: AOAM532Scyoh+YqtIwu1M/5YVH1pRLZ7fN2ww8uWDFZ/I5kH99ONOi4U
        GIotFZOXgRODWDlyQrZlMOPL5eRWEt0ecZK5wPQZGFe1Sg==
X-Google-Smtp-Source: ABdhPJwmn9BVBqqXxLo+n8s2v84Cq7y/BwdppJdO0DnTINIGE69t9EA0tvzvNH8ZHvihMzk+KNQ89Y+hl3jvaxpAFcQ=
X-Received: by 2002:a05:6402:2d7:: with SMTP id b23mr16280249edx.196.1604328358630;
 Mon, 02 Nov 2020 06:45:58 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNtWg4+PrjizBcaa9hwQHdq1qQN4RzeqFS_y_8R9KZfMSA@mail.gmail.com>
 <CAHC9VhRMsh5iHbunu0qJyheENm8a+KSnonLLuBynDWbBmOq3Og@mail.gmail.com>
 <20201027163749.GA25212@localhost.localdomain> <CAFqZXNswY13BoABpXGOQq=kOsORRJPY6HEPjDE3ZRXKQhW2vTA@mail.gmail.com>
In-Reply-To: <CAFqZXNswY13BoABpXGOQq=kOsORRJPY6HEPjDE3ZRXKQhW2vTA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 2 Nov 2020 09:45:47 -0500
Message-ID: <CAHC9VhQhKkS7hSfyOyef6c-gjmY-ab_L6mMR0SxAshv7d5Tm8g@mail.gmail.com>
Subject: Re: [Travis/GitHub] Migrating SELinuxProject projects to
 travis-ci.com (vs. travis-ci.org)
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 2, 2020 at 3:04 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Oct 27, 2020 at 5:37 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> > On Mon, Oct 26, 2020 at 07:04:52PM -0400, Paul Moore wrote:
> > > On Mon, Oct 26, 2020 at 9:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > Hello everyone (mainly the maintainers of projects on GH, but to avoid
> > > > a huge cc list, I'm sending this to the ML),
> > > >
> > > > As you may or may not know, Travis is migrating open-source projects
> > > > to their main site [1][2] (to .com from .org, where they have been
> > > > until now). AFAIK, the functionality stays pretty much the same, they
> > > > just want to have open-source and private projects under the same
> > > > infrastructure to unify things.
> > > >
> > > > Recently, they started migrating runners away from the .org site [3],
> > > > resulting in new builds being queued for a very long time. [4]
> > > >
> > > > I tried to migrate some of my forks (selinux-testsuite and selinux) to
> > > > the new site and it went smoothly. The only downside seems to be that
> > > > the build history is not migrated immediately (but it did show up
> > > > after a while). The queue times were indeed resolved after the
> > > > migration.
> > > >
> > > > So, I'd like to propose to start migrating the projects under
> > > > SELinuxProject that use the Travis CI (selinux, refpolicy,
> > > > selinux-testsuite, setools) now, so that we are not affected by the
> > > > lack of workers.
> > > >
> > > > If there are no objections until next week, I'll migrate the
> > > > selinux-testsuite, for a start. The other projects I'll leave for the
> > > > other maintainers, unless they choose to mandate me to do so :)
> > >
> > > Sounds good to me.
> > >
> >
> > Please do it for selinux too. Thank you!
>
> Apparently I would need to be an admin/owner in the SELinuxProject
> group to do anything... So either one of the owners will have to do it
> or make me an owner :)

Done :)

Originally I think the initial list of folks were all added as
"owners", but as we added maintainers to the various projects it seems
the new additions defaulted to "members".  You should be all set as an
owner now Ondrej, and if any of the other current maintainers would
also like to have their roles adjusted feel free to ping me off-list.

-- 
paul moore
www.paul-moore.com

Return-Path: <SRS0=HUo+=EL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E4BC388F9
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 13:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0228420A8B
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 13:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APuP1HHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgKEN1S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Nov 2020 08:27:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730745AbgKEN1P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Nov 2020 08:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604582833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aNy/lM/VUJ//EyXUe8Z4F7LhUDJq5B1cAoJirIjFgY4=;
        b=APuP1HHXTEqPXp1rQmt6sZmE3W7nxYYlmIjQsnc2dbm+1bE+GR+kXt93p86dW/qNP0sCQZ
        OeA9nUcTOiVTFrO0Z+HHN110tEg2lIQRZgxTn322wlI5O3aW7MrX2MQD2diVjzW1Tg1J98
        jsfLPuxGHS5HMlF/WcafJOH5CjLtTfM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-hvlikXkaNqWdUVZKzho1CA-1; Thu, 05 Nov 2020 08:27:09 -0500
X-MC-Unique: hvlikXkaNqWdUVZKzho1CA-1
Received: by mail-lf1-f72.google.com with SMTP id b13so656909lfi.1
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2020 05:27:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNy/lM/VUJ//EyXUe8Z4F7LhUDJq5B1cAoJirIjFgY4=;
        b=K6VBEvpwMVEJqrOoepeePGtYwD1Ga62Ru2r6svPZBva/YfkTglNjFHyjU6OlT8R2lF
         UM7PYbKp/WxgioZYkvhDPb+r3X0R8knV6Ry+Z086yps1jnTkJ5UApD6ZoGHzDeLeadgq
         i5rwZkSEmqwcFECzYOClE3GNvJaUu3A9lsKDn0RJLCScEp2PVwpfXQu62u/7N+TpNC8R
         PL8ukfjtfLSlFgbyE7DUoc2+BQR4BqLZJIrNH2v5Hum3HkBguTUd1LjJ5CMKvb+t4pqt
         v0nF0IHIEfS8ywiKunm+ms0LbEb+C52SVOGAh8qE7dHJLO8x94t0OqKCkfBx/8sdIuLy
         RHoA==
X-Gm-Message-State: AOAM530o+H0yB5MDwBIMuU5yXqkD7eZ42lspmXLE2YZMpZPZFpqndTtZ
        kSaWxln2jzpj28DTPAa5omTUA+JK976quS9FrkFvgQvWxHrvNsJgRDIPqc8fFodO4hbMK+sZtuu
        +jfWlnjBaU+D1o0P9uTwjrky/ti1JyUluIQ==
X-Received: by 2002:a19:c8c1:: with SMTP id y184mr944010lff.598.1604582827736;
        Thu, 05 Nov 2020 05:27:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQ8I4DWpjv22/004HQ9V0Ycp+nvR97ZgSo6/HmQ81I+03Hj6vVOcp/P4U2KOj8G8E11RU7grUSc5XftI7Cclk=
X-Received: by 2002:a19:c8c1:: with SMTP id y184mr944001lff.598.1604582827529;
 Thu, 05 Nov 2020 05:27:07 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNtWg4+PrjizBcaa9hwQHdq1qQN4RzeqFS_y_8R9KZfMSA@mail.gmail.com>
 <CAHC9VhRMsh5iHbunu0qJyheENm8a+KSnonLLuBynDWbBmOq3Og@mail.gmail.com>
 <20201027163749.GA25212@localhost.localdomain> <CAFqZXNswY13BoABpXGOQq=kOsORRJPY6HEPjDE3ZRXKQhW2vTA@mail.gmail.com>
 <CAHC9VhQhKkS7hSfyOyef6c-gjmY-ab_L6mMR0SxAshv7d5Tm8g@mail.gmail.com>
 <CAFqZXNspH6MmB-o0wtJJwj-p0DKKrH-ZjfW2YkF_yQS_gCBwqQ@mail.gmail.com> <75de6395-5554-2fa5-183f-a4d361c290aa@ieee.org>
In-Reply-To: <75de6395-5554-2fa5-183f-a4d361c290aa@ieee.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 5 Nov 2020 14:26:56 +0100
Message-ID: <CAFqZXNvYfUXbpxNkoyfizpycHpbownkFG9sGP=AEtaax_u=sLw@mail.gmail.com>
Subject: Re: [Travis/GitHub] Migrating SELinuxProject projects to
 travis-ci.com (vs. travis-ci.org)
To:     Chris PeBenito <pebenito@ieee.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 5, 2020 at 12:51 PM Chris PeBenito <pebenito@ieee.org> wrote:
> On 11/2/20 10:18 AM, Ondrej Mosnacek wrote:
> > On Mon, Nov 2, 2020 at 3:46 PM Paul Moore <paul@paul-moore.com> wrote:
> >> On Mon, Nov 2, 2020 at 3:04 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >>> On Tue, Oct 27, 2020 at 5:37 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >>>> On Mon, Oct 26, 2020 at 07:04:52PM -0400, Paul Moore wrote:
> >>>>> On Mon, Oct 26, 2020 at 9:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >>>>>> Hello everyone (mainly the maintainers of projects on GH, but to avoid
> >>>>>> a huge cc list, I'm sending this to the ML),
> >>>>>>
> >>>>>> As you may or may not know, Travis is migrating open-source projects
> >>>>>> to their main site [1][2] (to .com from .org, where they have been
> >>>>>> until now). AFAIK, the functionality stays pretty much the same, they
> >>>>>> just want to have open-source and private projects under the same
> >>>>>> infrastructure to unify things.
> >>>>>>
> >>>>>> Recently, they started migrating runners away from the .org site [3],
> >>>>>> resulting in new builds being queued for a very long time. [4]
> >>>>>>
> >>>>>> I tried to migrate some of my forks (selinux-testsuite and selinux) to
> >>>>>> the new site and it went smoothly. The only downside seems to be that
> >>>>>> the build history is not migrated immediately (but it did show up
> >>>>>> after a while). The queue times were indeed resolved after the
> >>>>>> migration.
> >>>>>>
> >>>>>> So, I'd like to propose to start migrating the projects under
> >>>>>> SELinuxProject that use the Travis CI (selinux, refpolicy,
> >>>>>> selinux-testsuite, setools) now, so that we are not affected by the
> >>>>>> lack of workers.
> >>>>>>
> >>>>>> If there are no objections until next week, I'll migrate the
> >>>>>> selinux-testsuite, for a start. The other projects I'll leave for the
> >>>>>> other maintainers, unless they choose to mandate me to do so :)
> >>>>>
> >>>>> Sounds good to me.
> >>>>>
> >>>>
> >>>> Please do it for selinux too. Thank you!
> >>>
> >>> Apparently I would need to be an admin/owner in the SELinuxProject
> >>> group to do anything... So either one of the owners will have to do it
> >>> or make me an owner :)
> >>
> >> Done :)
> >
> > Thanks, I've just migrated selinux and selinux-testsuite:
> > https://travis-ci.com/github/SELinuxProject
> >
> > I can also migrate refpolicy and setools if Chris gives me a thumbs-up.
>
> Sure, go ahead. Thanks Ondrej!

Done. The currently running build is still running on the old server,
future builds should already run on the new one.

Also, you'll want to read Bill's email, which unfortunately doesn't
contain good news :(
https://lore.kernel.org/selinux/CAFftDdo-jFy4anQaVvQqtYgjRvG8w-TNNLOUU5JL11gQF_rCpQ@mail.gmail.com/
(I'm not sure if I didn't make thing worse with the early migration,
since the linked announcement only mentions travis-ci.com, but I'm
sure they'd come for us sooner or later, anyway...)

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.


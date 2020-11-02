Return-Path: <SRS0=BHhV=EI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C86AC00A89
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 08:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F6FB21556
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 08:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8BoMKnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgKBIE2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Nov 2020 03:04:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727806AbgKBIE2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Nov 2020 03:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604304266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SFjB7QWKOrIWBySh28KSSSTldGQ/FjdN9XOvlo6cn4A=;
        b=i8BoMKnZZZ7kU4k5z+oar/Liddlvx1eCWNeLBDDr0W88DgXW3Ku78ozuX9FU6grWeDiXYT
        ndquATBFiq0IiM8Nl7SV7wEPWyIJtxC2cckRbXpMVCTr2LwrLcjWacB3XlsLYHpa+CxLI6
        2z4js3+nEKF0KTcxbDFU8Sy5M7q6AGA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-a21eCj7hPDGQjL-pXPw3dQ-1; Mon, 02 Nov 2020 03:04:23 -0500
X-MC-Unique: a21eCj7hPDGQjL-pXPw3dQ-1
Received: by mail-lj1-f198.google.com with SMTP id r19so5568799ljj.9
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2020 00:04:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SFjB7QWKOrIWBySh28KSSSTldGQ/FjdN9XOvlo6cn4A=;
        b=X56lpaoc9brC+jukpLV41hUHkpsvPpKeICeyGTkPqVcCoxglEwJysbb5jjFJUvEuZs
         T66ctRi7NAzmS+/T/FKRCFbHdBf1iQoJrBPIaMKaIFPQSENglfL/nF9jHF2Qtg9KJVs+
         mzaEqFUTfDiTJ8iEz4PJDgtxBX5F5Snk3LE5TMc8exWp17PDL5RsY/Ioi1lxBBcXqo1l
         oW79oiaIP91OtH2KaLv4paz3fWV9hKdLjOsvXPpFRm6jwHb+4oOhjAxbf44GoFNAYxtI
         0KJ/DFw2gVUH5iyZ/cgPG5LEKtGfQjgcdxMPOd8EMvxJgQ1CckKjobbznwPzCLQiwbIP
         fC2A==
X-Gm-Message-State: AOAM530o9VWKoGwSz7qmceP5FdM/Fb55PH50Kj/dJraQtfm8xc2JaSdV
        p7GLJEdVHYFDObR/2e0JPGOXHCRSG8pPNx2n3F2QU8hQDwIk3lkOxUuG6YGxy6qsVXsW9K+NJXm
        FdqPiOkpOQSIs4fj4f7Pf4ld7EuL4cMzwnQ==
X-Received: by 2002:a2e:b009:: with SMTP id y9mr5756021ljk.372.1604304261653;
        Mon, 02 Nov 2020 00:04:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzWf03qqRY7YGTBc9dPOMUSMIl1HyVNYSuy5LmGntId1mRZiAteQz0z3mD3BMY4s9sOjk21AYcxuP3VSX347w=
X-Received: by 2002:a2e:b009:: with SMTP id y9mr5756010ljk.372.1604304261337;
 Mon, 02 Nov 2020 00:04:21 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNtWg4+PrjizBcaa9hwQHdq1qQN4RzeqFS_y_8R9KZfMSA@mail.gmail.com>
 <CAHC9VhRMsh5iHbunu0qJyheENm8a+KSnonLLuBynDWbBmOq3Og@mail.gmail.com> <20201027163749.GA25212@localhost.localdomain>
In-Reply-To: <20201027163749.GA25212@localhost.localdomain>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 2 Nov 2020 09:04:09 +0100
Message-ID: <CAFqZXNswY13BoABpXGOQq=kOsORRJPY6HEPjDE3ZRXKQhW2vTA@mail.gmail.com>
Subject: Re: [Travis/GitHub] Migrating SELinuxProject projects to
 travis-ci.com (vs. travis-ci.org)
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 27, 2020 at 5:37 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> On Mon, Oct 26, 2020 at 07:04:52PM -0400, Paul Moore wrote:
> > On Mon, Oct 26, 2020 at 9:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > Hello everyone (mainly the maintainers of projects on GH, but to avoid
> > > a huge cc list, I'm sending this to the ML),
> > >
> > > As you may or may not know, Travis is migrating open-source projects
> > > to their main site [1][2] (to .com from .org, where they have been
> > > until now). AFAIK, the functionality stays pretty much the same, they
> > > just want to have open-source and private projects under the same
> > > infrastructure to unify things.
> > >
> > > Recently, they started migrating runners away from the .org site [3],
> > > resulting in new builds being queued for a very long time. [4]
> > >
> > > I tried to migrate some of my forks (selinux-testsuite and selinux) to
> > > the new site and it went smoothly. The only downside seems to be that
> > > the build history is not migrated immediately (but it did show up
> > > after a while). The queue times were indeed resolved after the
> > > migration.
> > >
> > > So, I'd like to propose to start migrating the projects under
> > > SELinuxProject that use the Travis CI (selinux, refpolicy,
> > > selinux-testsuite, setools) now, so that we are not affected by the
> > > lack of workers.
> > >
> > > If there are no objections until next week, I'll migrate the
> > > selinux-testsuite, for a start. The other projects I'll leave for the
> > > other maintainers, unless they choose to mandate me to do so :)
> >
> > Sounds good to me.
> >
>
> Please do it for selinux too. Thank you!

Apparently I would need to be an admin/owner in the SELinuxProject
group to do anything... So either one of the owners will have to do it
or make me an owner :)

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.


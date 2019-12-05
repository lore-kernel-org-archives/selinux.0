Return-Path: <SRS0=K0yT=Z3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9CBC43603
	for <selinux@archiver.kernel.org>; Thu,  5 Dec 2019 11:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52EF20707
	for <selinux@archiver.kernel.org>; Thu,  5 Dec 2019 11:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXSTULeO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfLELrz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Dec 2019 06:47:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30605 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729096AbfLELrz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Dec 2019 06:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575546474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=chwFsbeubzjHSJ81mtEFLRwbt5KooK0OdLtZTlYUR58=;
        b=VXSTULeO6QxIRS8hP21TFwFPb6li0XujIsuwwxq2mse7w3eDvkWv2rK2xduHJ9Qiy9EmW6
        BSM1ucLc0yB+peyqoDV7co2QpWDYQoYujWtLrTwnFlDjt0Fjx5nBs5jqMhRem9NsBmnVd/
        qJWUbkf3MGZdIwr2UeCSMIMqz9fvdCQ=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-UxknF0V6PSiZTmbR8OlKwQ-1; Thu, 05 Dec 2019 06:47:53 -0500
Received: by mail-oi1-f198.google.com with SMTP id y11so1527951oiy.6
        for <selinux@vger.kernel.org>; Thu, 05 Dec 2019 03:47:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8BfNxO/kcge3hbMx8NpfaGHaE7cCw+ugwcJhlXO0/A=;
        b=AIS9oavsyZl+EUCTdN/jTlrvVx48mBNtVEZwJTXGxnBJ/twFWoIuqey/4/VzxdigNm
         T+ZZwomKW7xb4r+4I5QXyJCa4LTqEtLWV53Na76E9S1LXHu15jGWGWI83sh/Bs7nE+Ah
         vpJpnKl4j8g+tYMUBB6MXptQ4bu3EqDEFdonqpZkLrOBCfwTlgg8gug+vpsIlnNdxqVO
         LSctQ+NiagsxY+SfrjM+lLYLKrycFtWrTOaMS+147ovByxCD/cDOcumOUqtS6oTc+vZE
         W2CTo0hfieHhU+a4+XW/Cw+k3EdCmwYVUSgdzbckljYEH9fA/1pqW8ANKMdcjpoiq3pW
         wlkg==
X-Gm-Message-State: APjAAAUdMxb/hcTticI6sU6NfkI33jkM2f/AN51BaqCPm3WPGtYIhvyC
        lRn3pqL56Ek+/DKfMyC7JIhJ0Ez0i7YL2pKicFpNYUE9c4WBWxFVE1rdu3cinkp6qDvnzf/Uqbz
        OuqhjiO/oq9vRTmeXYKewFSZ6tt4TX6IFPg==
X-Received: by 2002:a05:6808:285:: with SMTP id z5mr1069807oic.127.1575546472592;
        Thu, 05 Dec 2019 03:47:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqyk7ASDkRKiytkGLBDW2gc6iBaROV55NyFbBmb5xOf+RClHrxN4psBOeagVCH50wxJU6Nvu47+wJMJv1qBoniM=
X-Received: by 2002:a05:6808:285:: with SMTP id z5mr1069794oic.127.1575546472307;
 Thu, 05 Dec 2019 03:47:52 -0800 (PST)
MIME-Version: 1.0
References: <20191122093306.17335-1-jeffv@google.com> <CAHC9VhQ-piMePyfOeLsrAtgSCG5iWjk9xFbjOvURe3WLD-z89g@mail.gmail.com>
 <CAFqZXNun_-aWx19UKUMfiYuQuttxCgMOoAczBAddDv3yaCZyxw@mail.gmail.com> <CAHC9VhTwct8daQoXFg4JpHkWUhijQFn8D0Tq=VX989mq3TVfvg@mail.gmail.com>
In-Reply-To: <CAHC9VhTwct8daQoXFg4JpHkWUhijQFn8D0Tq=VX989mq3TVfvg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 5 Dec 2019 12:48:07 +0100
Message-ID: <CAFqZXNvQV+syzOE0CGczzTvi9g65AUT8bdsG0YN6NcHzd5GVHQ@mail.gmail.com>
Subject: Re: [PATCH v9] selinux: sidtab: reverse lookup hash table
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jeff Vander Stoep <jeffv@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Jovana Knezevic <jovanak@google.com>
X-MC-Unique: UxknF0V6PSiZTmbR8OlKwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 5, 2019 at 12:52 AM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Dec 4, 2019 at 4:11 AM Ondrej Mosnacek <omosnace@redhat.com> wrot=
e:
> > On Tue, Dec 3, 2019 at 1:33 AM Paul Moore <paul@paul-moore.com> wrote:
> > > Thanks Jeff, as well as everyone else who contributed reviews and fee=
dback.
> > >
> > > I've pulled this into a working branch and I'll be merging it with th=
e
> > > other sidtab patches before posting it to a "next-queue" branch for
> > > review later this week.  When done, I'll send a note to the list, as
> > > well as the relevant patch authors; your help in reviewing the merge
> > > would be greatly appreciated.
> >
> > I tried doing the merge on my own here [1], you can use it as a sanity
> > check if we came to the same/similar result. I based it off your
> > existing next-queue, which contains only Jeff's patch at the time of
> > writing. I only build-tested it so far.
>
> Thanks, that was a good sanity check.  There are some minor diffs from
> what I ended up with, but nothing substantive that I can see.
>
> Although I'll be honest, the merge wasn't as bad as I thought it would
> be; most of the fuzz was simply due shuffling and renaming of data
> structures, which generally isn't too bad.  Although I'm still
> building the kernel to test it, so let's see if that statement still
> holds (although it looks like it passed Stephen's testing). ;)
>
> If you haven't noticed already, the merge currently lives in the
> selinux/next-queue branch; if you notice anything off, feel free to
> send a fixup patch.

It looks OK semantically when compared to my merge. I only see
reordering/comment/whitespace differences.

>
> > Note that there are two whitespace cleanups included in the string
> > cache commit that I intuitively did while resolving the merge
> > conflicts. You might want to move those to the first commit or just
> > ignore them.
>
> When looking at the combined diff between the two sidtab patches and
> comparing it to your merge I did make a few additional small cosmetic
> tweaks.  Assuming the testing goes well, I'll probably go over
> everything one more time to make sure the style looks okay, but today
> I was focusing more on the correctness.

The whitespace misalignment introduced by Jeff's patch is still there
in your branch. Personally, I'd prefer that we fix them now rather
than deferring it to a future patch, because it seems that no one ever
has time to bother sending whitespace fixup patches :) But I'll
understand it if you prefer not to touch it more than necessary, so I
won't fight about this further.

>
> > [1] https://gitlab.com/omos/linux-public/compare/selinux-next...rebase-=
selinux-sidtab-string-cache

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.


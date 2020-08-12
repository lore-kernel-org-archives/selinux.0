Return-Path: <SRS0=FvZo=BW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40370C433E0
	for <selinux@archiver.kernel.org>; Wed, 12 Aug 2020 14:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05A4720781
	for <selinux@archiver.kernel.org>; Wed, 12 Aug 2020 14:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXJz0Xcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgHLO1t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:27:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52005 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726434AbgHLO1t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Aug 2020 10:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597242467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WSyqfB+r6SZveAAxSor2LosERECRlwE8BiMobwHUq8o=;
        b=LXJz0XcpInv6KF4/KhRfBx+Onu9pgFzlxBCmoYRa51WhldADZr8OEhSlNMdX3nZsr9edvN
        OLXXaQgSxnWbtd9fU96Nbj9Ihesu7JoAdOum+7Ix+rEBs2Kb3zo9oagZIR+9g22SLX7qxP
        yngfBAfA1oLfMfEuCZUXzk+FcWOLuLY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-um3AiDzEMASUWaj1yl-6NQ-1; Wed, 12 Aug 2020 10:27:43 -0400
X-MC-Unique: um3AiDzEMASUWaj1yl-6NQ-1
Received: by mail-lj1-f199.google.com with SMTP id f14so283772ljg.23
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2020 07:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSyqfB+r6SZveAAxSor2LosERECRlwE8BiMobwHUq8o=;
        b=DYh01jEsUxz+1ewYbcGE87Bwc2jimYQNdaNmh8QTbhaywLAI7MA7aD0EGcb9O9EiMN
         l+6aW9doub25nqTJxh1Eiv5C2ND03NUSsh6xO4ohZeH5PDmoybkylULlSdo6w6HiNsaZ
         AVD/Y6HYASPHqO0mATCMQxr671vjgHDhN3Dmt6NiA4F/FcWVF7K3g7BLNvNB6fL5ylju
         w/5Zy3XSOU2MaXaIb/OENZ7ZyEFxxESKxkNcDNqozmAqQm9Kg5Odci6IMvbzGJXk+E4f
         aafIiyG4vbwj+h2MrcWaK2WOjNCjKrdv6J2sGmLRf4pJHnix6fEWEnLWHxO3s9usIGE6
         YFlQ==
X-Gm-Message-State: AOAM530/uiACQiVd+QC3uxFf97COjmK5XE/pdTb+cOhrUNfXIZApUoa/
        sw9/xisn9KmS8AmIoIxjcqv38a9SHlEUJf0YHmLRBMeoTQz+13GlEjfL53ASOV7/FuBE+Nz0aNK
        kw0iURAX+cL8O9OHYmRwI5c27vln8UkXhgg==
X-Received: by 2002:a05:651c:217:: with SMTP id y23mr5294709ljn.123.1597242461369;
        Wed, 12 Aug 2020 07:27:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmLxd0etTFavn0V8Nl5oEdglPTCQJT/oxKwe3tAv3UfOe1p6U1a95cpdBW/Qv6kioxXDz0/3R3WwHHy4ESu9s=
X-Received: by 2002:a05:651c:217:: with SMTP id y23mr5294699ljn.123.1597242461091;
 Wed, 12 Aug 2020 07:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200811084555.105374-1-omosnace@redhat.com> <20200811084555.105374-2-omosnace@redhat.com>
 <CAFqZXNsZU+uwnF2zu+cQSV5jzvDsx_u_FFcWWOx6YW0we583MA@mail.gmail.com> <CAHC9VhTGHgZu4pcAVVOUGX4yegyD8uNg85UrjG8Jtzc4=AsDVQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTGHgZu4pcAVVOUGX4yegyD8uNg85UrjG8Jtzc4=AsDVQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 12 Aug 2020 16:27:29 +0200
Message-ID: <CAFqZXNs=Q0+ikxAxnDqj8KeVygiswW0878wg51Q=2T7_v-jq0w@mail.gmail.com>
Subject: Re: [PATCH testsuite v2 1/2] README: add perl-lib as a dependency
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 11, 2020 at 5:11 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Aug 11, 2020 at 5:05 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Tue, Aug 11, 2020 at 10:45 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > The `lib` perl module has been split out of the `perl-interpreter`
> > > package in Fedora 33 into `perl-lib`. It is needed for the filesystem
> > > tests. Add it to the dependencies.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  README.md | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/README.md b/README.md
> > > index ff0a0dc..bfd5b17 100644
> > > --- a/README.md
> > > +++ b/README.md
> > > @@ -45,6 +45,7 @@ similar dependencies):
> > >  * perl-Test  _(test harness used by the testsuite)_
> > >  * perl-Test-Harness _(test harness used by the testsuite)_
> > >  * perl-Test-Simple _(for `Test::More`)_
> > > +* perl-lib _(for `lib`; split out from `perl-interpreter` since Fedora 33)_
> > >  * selinux-policy-devel _(to build the test policy)_
> > >  * gcc _(to build the test programs)_
> > >  * libselinux-devel _(to build some of the test programs)_
> > > @@ -65,6 +66,7 @@ following command:
> > >         # dnf install perl-Test \
> > >                 perl-Test-Harness \
> > >                 perl-Test-Simple \
> > > +               perl-lib \
> >
> > Note that this package doesn't exist on the earlier versions, so the
> > command will now work verbatim only on F33+... I'm not sure if we want
> > to add --skip-broken (might silently skip necessary packages in case
> > of dependency problems in the repos) or just leave it be.
>
> I agree that '--skip-broken' is probably not the best choice for the
> reasons you already mentioned.  I might suggest that if the package is
> not present in all of the supported versions of Fedora we should add a
> note to the README.md explaining that.  Once the older versions become
> unsupported the note can be removed.

There is already a note in the other line added. Or did you have
something different in mind?

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.


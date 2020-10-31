Return-Path: <SRS0=qOYA=EG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47A7C388F7
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 16:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B96206DD
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 16:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hq9+TA8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgJaQ12 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 31 Oct 2020 12:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60431 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbgJaQ11 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 31 Oct 2020 12:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604161646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EMQBBKcs+XCHpW56AROJze800wpxfSScn9rBFhWUXio=;
        b=Hq9+TA8Hy/t5oa0Je7NsEhRKxef0GfgAYQlj1y8kf702bKyjEM5S+502jJqsBQih2v4IaS
        XJPkzPqIDa0ORLRC4beWfMrVSDg9IWeCzsCI6d8OEB2SH/7u0ghPrMVqAuDFz8NQCAuS74
        ucIRAO60ELiegupPGHPF/4L8C/NmfgI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-rJCI0peCO2C1OdM13tgKCg-1; Sat, 31 Oct 2020 12:27:24 -0400
X-MC-Unique: rJCI0peCO2C1OdM13tgKCg-1
Received: by mail-lj1-f200.google.com with SMTP id d5so1524288ljo.17
        for <selinux@vger.kernel.org>; Sat, 31 Oct 2020 09:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMQBBKcs+XCHpW56AROJze800wpxfSScn9rBFhWUXio=;
        b=sRvI6XQjjfgnHClXdmzoZZ8E37Gm7xxOyU3f191qtiiGmkpjf66mVB+n2i5gzqLtK/
         bpRR6calecgpplARgewOj7k/SHoEFI1mr77fn34a6uUCDvctN1w0B67zAnyMqFneMsHT
         qcRWOeQB3ACuYD+5CPVJTXw+pVta8C0+On8XpORCMDIU/2954ocI7ltSDVNrd7eZvX6o
         lzleQvoEMf4QEDbCJ4+3eN/O7d1tyyrLiFWbcZYwQ3Ww7/iGWrwtgMXqmM8C5R8HanY3
         njcMorw9JwFtZ+eXDD15wJqtyJhkRLrGkEP4pdvOKCeT6zzRsUz3EJkPZR1AfKIOfgaJ
         ddKw==
X-Gm-Message-State: AOAM532X2S49kT9A4aYXZRk57QGethYdGwmw8rEdJH921i2ZvVX5VqQQ
        VIgTANW84n8UwCv4n7sZ9a++9A1MmMtzGHqdQMRUdn0apbpejPWgu5x7hTk/xCeLNpfURt4pL3k
        zwCJGL+p8Xw6DwpLW8+/9po/meXmxbTyPZw==
X-Received: by 2002:a19:5c2:: with SMTP id 185mr3127256lff.15.1604161642744;
        Sat, 31 Oct 2020 09:27:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyI/ruC8/PZZ5/N/8sx7VgkVjBwaGZ0H8epGib0ulJ1iw8drQCtMhSyC0BFiSN4O39bAZ6Heo+V/QAXGBOrRhI=
X-Received: by 2002:a19:5c2:: with SMTP id 185mr3127252lff.15.1604161642548;
 Sat, 31 Oct 2020 09:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201030212108.112831-1-omosnace@redhat.com> <CAFftDdr-EoYgkhXQMWemdHKSGJT=S+gQDxfBypmaJPYqvkD-Ew@mail.gmail.com>
 <CAFqZXNsSk=18anyu+_TsBCP4sC2muKUEQfQ5n0ziHj0MOYeqbA@mail.gmail.com> <CAFftDdop31+zibW+7ieKbO05sd54BmN0o=kkaEi8iDuoxcH+Uw@mail.gmail.com>
In-Reply-To: <CAFftDdop31+zibW+7ieKbO05sd54BmN0o=kkaEi8iDuoxcH+Uw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 31 Oct 2020 17:27:11 +0100
Message-ID: <CAFqZXNsag3Xv+uMCzHoDKJgEszz6PXrD9cjPvJuKDP4fEU-7EQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] travis: skip kernel update+reboot if it's not necessary
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Oct 31, 2020 at 2:55 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Sat, Oct 31, 2020 at 5:37 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Fri, Oct 30, 2020 at 11:22 PM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > > On Fri, Oct 30, 2020 at 4:22 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > Only do it when we can't install the kernel-modules package for the
> > > > running kernel to make the CI run faster. Now that rawhide images are
> > > > updating regularly again, it is rarely necessary.
> > > >
> > > > Also don't run `dnf clean all -y` before installing dependencies. There
> > > > really is no point and it just slows things down when we do need to
> > > > update the kernel.
> > > >
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > ---
> > > >  travis-ci/run-kvm-test.sh  | 21 ++++++++++++---------
> > > >  travis-ci/run-testsuite.sh |  1 -
> > > >  2 files changed, 12 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/travis-ci/run-kvm-test.sh b/travis-ci/run-kvm-test.sh
> > > > index d22c92b..6afbf96 100755
> > > > --- a/travis-ci/run-kvm-test.sh
> > > > +++ b/travis-ci/run-kvm-test.sh
> > > > @@ -121,15 +121,18 @@ fi
> > > >  # so forks know where to go.
> > > >  #
> > > >
> > > > -# First update to the latest kernel.
> > > > -ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" \
> > > > -    dnf install -y kernel
> > > > -
> > > > -# Then reboot.
> > > > -sudo virsh reboot fedoravm
> > > > -sleep 5
> > > > -
> > > > -while ! nc -w 10 -z "$ipaddy" 22; do sleep 0.5s; done
> > > > +# Check if kernel-modules-$(uname -r) can be installed from repos,
> > > > +# otherwise update kernel and reboot.
> > > > +kernel_avail="$(ssh -tt -o StrictHostKeyChecking=no -q "root@$ipaddy" \
> > > > +    sh -c "dnf check-update kernel-modules-\$(uname -r) | wc -l")"
> > > > +if [ $kernel_avail -eq 0 ]; then
> > > > +    ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" \
> > > > +        dnf update -y kernel-core
> > > > +
> > > > +    sudo virsh reboot fedoravm
> > > > +    sleep 5
> > > > +    while ! nc -w 10 -z "$ipaddy" 22; do sleep 0.5s; done
> > > > +fi
> > > >
> > > >  # And run the testsuite.
> > > >  project_dir="$(basename "$TRAVIS_BUILD_DIR")"
> > > > diff --git a/travis-ci/run-testsuite.sh b/travis-ci/run-testsuite.sh
> > > > index 9b5f954..051f9d8 100755
> > > > --- a/travis-ci/run-testsuite.sh
> > > > +++ b/travis-ci/run-testsuite.sh
> > > > @@ -16,7 +16,6 @@ pwd
> > > >  # the CI.
> > > >  setenforce 0
> > > >
> > > > -dnf clean all -y
> > > >  dnf install -y \
> > > >      --allowerasing \
> > > >      --skip-broken \
> > > > --
> > > > 2.26.2
> > > >
> > >
> > > Ack
> >
> > Thanks, but I'm not sure if you realized that this is a patch for the
> > testsuite CI, not the userspace one :) Can I still add you ack?
> >
> > Note that userspace CI doesn't need the kernel update + reboot (nor
> > this patch), as it doesn't test on development images.
> >
>
> Well aware, thanks. That ack really means reviewed by and tested by lines.
> I was just being lazy.

Ok, great!

> I've been following the testsuite project closely as selinux now depends on it
> in it's CI. I wouldn't be opposed to being a miantiner for the testsuite either.

Even greater :) Paul, Stephen, do we want to make Bill another
testsuite maintainer? It seems I don't have permission to add people
to the GH team, so one of you would have to do it.

> Thanks for your work on this BTW, glad to see that KVM paradigm
> getting used more.

Yeah, it's cool and it makes maintaining the testsuite so much easier.
But you don't need to thank me, you're the one who started it all :)

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.


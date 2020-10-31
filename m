Return-Path: <SRS0=qOYA=EG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D858CC388F9
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 13:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 935DF20723
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 13:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmrMqSlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgJaNzQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 31 Oct 2020 09:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgJaNzP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 31 Oct 2020 09:55:15 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DA6C0617A6
        for <selinux@vger.kernel.org>; Sat, 31 Oct 2020 06:55:15 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k21so10424966ioa.9
        for <selinux@vger.kernel.org>; Sat, 31 Oct 2020 06:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fTVyH7kIcq8fj3+oSumQceS9FO+UC1ZMOiviX5rPA+c=;
        b=XmrMqSlfJKhr3t64cTOr1nU7zNK+d3yCOrDlEV7HItpQAMhB8CI24AqYsUWBKmUExi
         sKw8vmeuCSy6kiv4X4LeF29cZmzDfdF4MQ1/ghKljyhLkU2wmO+wxLhxf/7KFWIdWIQ4
         b2DRKAxCvtv9DapP/MUnN0owbACsk8fro2tjYp6rJIJ8FERgs/Xi8m9PJGWlFwzuC7Zc
         a3bY/BlgJmaQ1YPWjSAYioJmztWdkz75Gr89+8mIpp9LGLQAsk6e2AItr1MHPOV8jo/U
         3PC2qqZ9T7T5hs1GoCnuGmvTJtKE6jxJQr38sWL8pQR74205Wg7uRHDWZSFUYS/ZjqPx
         iiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fTVyH7kIcq8fj3+oSumQceS9FO+UC1ZMOiviX5rPA+c=;
        b=BgdcpVh5Nr66P6qRVNhHToDe23nNtwPapdFf1ewIHPG3v6hRggs/lXkWNGgkBC+PO0
         Mp1HbAgTlT80eaoYR0RrfWZHGqq/Ejj2eDcCH0Lohzop4PyO4e7Hr4Qq/qhNttBh9bqS
         i2+rt/8FYm44lH3fchJhxlU8Czc/SdYTh6zPGRKN3DwsdWLfuCwW8YmkCDPsjM2kJaO4
         ezF5MjtSAqlYemoTHeLaNHL9bldx7gGkr075wAOfYYdAuh5EJBWkscoLKROlf9Eq8ATy
         3jFkQ/Pt1bHe1wPM7iayNnRFE0BcPLYlVyIGnFXPnPoVFn0R8guQr0ETJySNJiwsLGYY
         y+mA==
X-Gm-Message-State: AOAM531Jagff/qNb96ZTg0pjj//OcA7lCnVtqArVaZSr3Bi6QdinTHjH
        IZjA5A8HPsbn5C/x8GfgRbUQyc0OYfwVDsbud0wtWShz1gI=
X-Google-Smtp-Source: ABdhPJymWol9bCPjv/tzDOwllV7Adqu4cRki73lGT9Le9zK6HLPsrWz42674KO5nVMmU1H8Sm3KVO+a8SvIGL/BsgSI=
X-Received: by 2002:a05:6638:2110:: with SMTP id n16mr5504130jaj.61.1604152514860;
 Sat, 31 Oct 2020 06:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201030212108.112831-1-omosnace@redhat.com> <CAFftDdr-EoYgkhXQMWemdHKSGJT=S+gQDxfBypmaJPYqvkD-Ew@mail.gmail.com>
 <CAFqZXNsSk=18anyu+_TsBCP4sC2muKUEQfQ5n0ziHj0MOYeqbA@mail.gmail.com>
In-Reply-To: <CAFqZXNsSk=18anyu+_TsBCP4sC2muKUEQfQ5n0ziHj0MOYeqbA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Sat, 31 Oct 2020 08:55:03 -0500
Message-ID: <CAFftDdop31+zibW+7ieKbO05sd54BmN0o=kkaEi8iDuoxcH+Uw@mail.gmail.com>
Subject: Re: [PATCH testsuite] travis: skip kernel update+reboot if it's not necessary
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Oct 31, 2020 at 5:37 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, Oct 30, 2020 at 11:22 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> > On Fri, Oct 30, 2020 at 4:22 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Only do it when we can't install the kernel-modules package for the
> > > running kernel to make the CI run faster. Now that rawhide images are
> > > updating regularly again, it is rarely necessary.
> > >
> > > Also don't run `dnf clean all -y` before installing dependencies. There
> > > really is no point and it just slows things down when we do need to
> > > update the kernel.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  travis-ci/run-kvm-test.sh  | 21 ++++++++++++---------
> > >  travis-ci/run-testsuite.sh |  1 -
> > >  2 files changed, 12 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/travis-ci/run-kvm-test.sh b/travis-ci/run-kvm-test.sh
> > > index d22c92b..6afbf96 100755
> > > --- a/travis-ci/run-kvm-test.sh
> > > +++ b/travis-ci/run-kvm-test.sh
> > > @@ -121,15 +121,18 @@ fi
> > >  # so forks know where to go.
> > >  #
> > >
> > > -# First update to the latest kernel.
> > > -ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" \
> > > -    dnf install -y kernel
> > > -
> > > -# Then reboot.
> > > -sudo virsh reboot fedoravm
> > > -sleep 5
> > > -
> > > -while ! nc -w 10 -z "$ipaddy" 22; do sleep 0.5s; done
> > > +# Check if kernel-modules-$(uname -r) can be installed from repos,
> > > +# otherwise update kernel and reboot.
> > > +kernel_avail="$(ssh -tt -o StrictHostKeyChecking=no -q "root@$ipaddy" \
> > > +    sh -c "dnf check-update kernel-modules-\$(uname -r) | wc -l")"
> > > +if [ $kernel_avail -eq 0 ]; then
> > > +    ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" \
> > > +        dnf update -y kernel-core
> > > +
> > > +    sudo virsh reboot fedoravm
> > > +    sleep 5
> > > +    while ! nc -w 10 -z "$ipaddy" 22; do sleep 0.5s; done
> > > +fi
> > >
> > >  # And run the testsuite.
> > >  project_dir="$(basename "$TRAVIS_BUILD_DIR")"
> > > diff --git a/travis-ci/run-testsuite.sh b/travis-ci/run-testsuite.sh
> > > index 9b5f954..051f9d8 100755
> > > --- a/travis-ci/run-testsuite.sh
> > > +++ b/travis-ci/run-testsuite.sh
> > > @@ -16,7 +16,6 @@ pwd
> > >  # the CI.
> > >  setenforce 0
> > >
> > > -dnf clean all -y
> > >  dnf install -y \
> > >      --allowerasing \
> > >      --skip-broken \
> > > --
> > > 2.26.2
> > >
> >
> > Ack
>
> Thanks, but I'm not sure if you realized that this is a patch for the
> testsuite CI, not the userspace one :) Can I still add you ack?
>
> Note that userspace CI doesn't need the kernel update + reboot (nor
> this patch), as it doesn't test on development images.
>

Well aware, thanks. That ack really means reviewed by and tested by lines.
I was just being lazy.

I've been following the testsuite project closely as selinux now depends on it
in it's CI. I wouldn't be opposed to being a miantiner for the testsuite either.

Thanks for your work on this BTW, glad to see that KVM paradigm
getting used more.

Bill

Return-Path: <SRS0=qOYA=EG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E48C388F9
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 10:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2BF7208B6
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 10:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmkjkiYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgJaKhq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 31 Oct 2020 06:37:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60611 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726697AbgJaKhp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 31 Oct 2020 06:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604140664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l/i8JPLANt4McG3xQ/WAzOxtBXQKj1BbmvtK04AIQj0=;
        b=ZmkjkiYHg5bT+OdBbfWVybPMEYyFvmnz1w02yYtakR3t5ex68/RUVbRZb89oa0CbzxP4ky
        rk77qUZpXYPxajQUjJ7+t4czDb/CnXOttpriosCOAP+La/1NSHS0/VpcgatI2aCb3MuW5a
        rPFjCYwKP3dhAtlPXlFG8tbPtWJ6uFs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-N3_xajlhOoyN9NDiZP7YAg-1; Sat, 31 Oct 2020 06:37:41 -0400
X-MC-Unique: N3_xajlhOoyN9NDiZP7YAg-1
Received: by mail-lj1-f198.google.com with SMTP id m11so3737944ljp.21
        for <selinux@vger.kernel.org>; Sat, 31 Oct 2020 03:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l/i8JPLANt4McG3xQ/WAzOxtBXQKj1BbmvtK04AIQj0=;
        b=m1osM5cy7XIk9AhbiaeK61L2j28yI0u4toiIpKWwlByCUT+kZvQsg70jYTUvVi79j0
         133OxJYjQ+bfP1RkWjx+f8z5lM1d9oWXIUAhltH1iBho1QUUCwitu9zpysjTp56lzX4Z
         BfWR2wq133GSuEEAwPtUjdjJPbcE8cKJm8Peu6NI9LaWOSQLbZSW7fTG9la/cBpB7PLn
         lwIAnDe81Xq4M0UdiSxKOiIgjvwKxi3I+XwALt2RTpzVqXpEXXr+RQloIjIcnWDUJrl5
         DtRv1n8/9qg/qXQlPKXSai/zNkbaeAbCmIorJPt1iM2IsyNJC3lRYsbbq1paZjXtAvrc
         7u4A==
X-Gm-Message-State: AOAM533yCcYawyP/E1cedfhncfVNQdaf5RcFD6Lu4YUoRypqUD+y+ZCF
        rvx7nZvJo3jp4pGulgx0iD+sRa8EHUiFMq8kyzgRihEsUwnJET2CH5FxpcNdql/hl3GV6W7Q6nb
        iPJUDaEde6UQxTJ3H2MGEjmL/ELbp02trtw==
X-Received: by 2002:a19:f605:: with SMTP id x5mr2535202lfe.39.1604140659976;
        Sat, 31 Oct 2020 03:37:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4jW4NpgSIETCb+dNYD8uFj4Pq9gbONSDokO8aKviPsc5ywOYWFB5Qq7n4v8XEj+wnn/rGxoBd5xzm9K1Kgn4=
X-Received: by 2002:a19:f605:: with SMTP id x5mr2535196lfe.39.1604140659775;
 Sat, 31 Oct 2020 03:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201030212108.112831-1-omosnace@redhat.com> <CAFftDdr-EoYgkhXQMWemdHKSGJT=S+gQDxfBypmaJPYqvkD-Ew@mail.gmail.com>
In-Reply-To: <CAFftDdr-EoYgkhXQMWemdHKSGJT=S+gQDxfBypmaJPYqvkD-Ew@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 31 Oct 2020 11:37:29 +0100
Message-ID: <CAFqZXNsSk=18anyu+_TsBCP4sC2muKUEQfQ5n0ziHj0MOYeqbA@mail.gmail.com>
Subject: Re: [PATCH testsuite] travis: skip kernel update+reboot if it's not necessary
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 30, 2020 at 11:22 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Fri, Oct 30, 2020 at 4:22 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Only do it when we can't install the kernel-modules package for the
> > running kernel to make the CI run faster. Now that rawhide images are
> > updating regularly again, it is rarely necessary.
> >
> > Also don't run `dnf clean all -y` before installing dependencies. There
> > really is no point and it just slows things down when we do need to
> > update the kernel.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  travis-ci/run-kvm-test.sh  | 21 ++++++++++++---------
> >  travis-ci/run-testsuite.sh |  1 -
> >  2 files changed, 12 insertions(+), 10 deletions(-)
> >
> > diff --git a/travis-ci/run-kvm-test.sh b/travis-ci/run-kvm-test.sh
> > index d22c92b..6afbf96 100755
> > --- a/travis-ci/run-kvm-test.sh
> > +++ b/travis-ci/run-kvm-test.sh
> > @@ -121,15 +121,18 @@ fi
> >  # so forks know where to go.
> >  #
> >
> > -# First update to the latest kernel.
> > -ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" \
> > -    dnf install -y kernel
> > -
> > -# Then reboot.
> > -sudo virsh reboot fedoravm
> > -sleep 5
> > -
> > -while ! nc -w 10 -z "$ipaddy" 22; do sleep 0.5s; done
> > +# Check if kernel-modules-$(uname -r) can be installed from repos,
> > +# otherwise update kernel and reboot.
> > +kernel_avail="$(ssh -tt -o StrictHostKeyChecking=no -q "root@$ipaddy" \
> > +    sh -c "dnf check-update kernel-modules-\$(uname -r) | wc -l")"
> > +if [ $kernel_avail -eq 0 ]; then
> > +    ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" \
> > +        dnf update -y kernel-core
> > +
> > +    sudo virsh reboot fedoravm
> > +    sleep 5
> > +    while ! nc -w 10 -z "$ipaddy" 22; do sleep 0.5s; done
> > +fi
> >
> >  # And run the testsuite.
> >  project_dir="$(basename "$TRAVIS_BUILD_DIR")"
> > diff --git a/travis-ci/run-testsuite.sh b/travis-ci/run-testsuite.sh
> > index 9b5f954..051f9d8 100755
> > --- a/travis-ci/run-testsuite.sh
> > +++ b/travis-ci/run-testsuite.sh
> > @@ -16,7 +16,6 @@ pwd
> >  # the CI.
> >  setenforce 0
> >
> > -dnf clean all -y
> >  dnf install -y \
> >      --allowerasing \
> >      --skip-broken \
> > --
> > 2.26.2
> >
>
> Ack

Thanks, but I'm not sure if you realized that this is a patch for the
testsuite CI, not the userspace one :) Can I still add you ack?

Note that userspace CI doesn't need the kernel update + reboot (nor
this patch), as it doesn't test on development images.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.


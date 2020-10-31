Return-Path: <SRS0=qOYA=EG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41483C388F9
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 16:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0E7420663
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 16:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzKLvo/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgJaQzQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 31 Oct 2020 12:55:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbgJaQzQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 31 Oct 2020 12:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604163315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ho788TxrwmtNnZkOQ4w0TR1umtMWHe193NC9J1JC8t8=;
        b=CzKLvo/9Q4YRBvT2ey/GgB64u/u1s+AleEi/FHjNMvFdOor348kkNAS3dG3shgnNDO+jx+
        yMQIady+Kb4GTZIE1ZqAfdobWL92/ZZ0z48GI14XzaF5M74smxl4DU3kKZ6eh9XliXDQEG
        njY9YVJyZOj64dmQrdatHEu/VCAu4hI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-yp_hvYIKNXOACBrEbdeExw-1; Sat, 31 Oct 2020 12:55:10 -0400
X-MC-Unique: yp_hvYIKNXOACBrEbdeExw-1
Received: by mail-lj1-f197.google.com with SMTP id f14so4009006ljg.18
        for <selinux@vger.kernel.org>; Sat, 31 Oct 2020 09:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ho788TxrwmtNnZkOQ4w0TR1umtMWHe193NC9J1JC8t8=;
        b=UX+Vcf/xWKhLVbMs4qrGyinotPy+ic065U8ewfJ/5FOMWVwN7url1QjFD5wvJY7+yl
         sK59G/0bUJpkE+G0drvPXraCQUbg8iWnHKuBYgFYcd9qXQUAMEjbFlXBxCo25UmRNTqt
         ZvaiaP9XynHsvMcJmT1tpRHBx32Rfd6UAA7jPzw0QKM1R25Epnb4SuEGFPutPiJ1u5fB
         IzUdZu10Tza+KSedwQ3YCeIMoChNz38rCLkrf64Gf5Km4gRgLObxJPkIPAlmCiUX2zxZ
         bPMsQ0uIjaE586UAsUtiCh2GmlOdc8aIC0juTBlli8eFPiooELmp3o2SI5gKEjFxHOX/
         lNsA==
X-Gm-Message-State: AOAM530O4es04O445q4WjkHFdaI58stnwkEAaBiDV7/O7TMSu0gdUhmS
        xQdSTbbbbg0dUkuUnlig6H12R0L41N0AWjxpOK6LhOSGQQRJkpQtFZ8PFFQoyvxGNvBIwBYbGZc
        ly299hFopDynOCOz3Blg0HvPLsvB/bRJluw==
X-Received: by 2002:ac2:51cb:: with SMTP id u11mr2227272lfm.247.1604163308370;
        Sat, 31 Oct 2020 09:55:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKAOlnnYJyDZ4TUNiDlYBQtDU1wwfDWlGWiMZoxjtzeQpG26Ch7iYlRlGKRrg3aCvL3vzqDojHWOtUXfI+oE0=
X-Received: by 2002:ac2:51cb:: with SMTP id u11mr2227266lfm.247.1604163308176;
 Sat, 31 Oct 2020 09:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201030212108.112831-1-omosnace@redhat.com> <CAFftDdr-EoYgkhXQMWemdHKSGJT=S+gQDxfBypmaJPYqvkD-Ew@mail.gmail.com>
In-Reply-To: <CAFftDdr-EoYgkhXQMWemdHKSGJT=S+gQDxfBypmaJPYqvkD-Ew@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 31 Oct 2020 17:54:57 +0100
Message-ID: <CAFqZXNs_R=6PaYWV84tjnSZ8J8dKE2B-Jxjyd38227_Y-4RHgQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] travis: skip kernel update+reboot if it's not necessary
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 30, 2020 at 11:22 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
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

And I just applied this one as well:
https://github.com/SELinuxProject/selinux-testsuite/commit/69d9e8bd648ace3516d6da7e51a2fd6e012538b1

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.


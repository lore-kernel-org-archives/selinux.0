Return-Path: <SRS0=8qmv=EF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0A4C00A89
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 22:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C22D20719
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 22:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dd8yRJlG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgJ3WW2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Oct 2020 18:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgJ3WW1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Oct 2020 18:22:27 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC64BC0613D5
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2020 15:22:27 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c11so7807718iln.9
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2020 15:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P8twOuj0NUsVuDEltg5U/7dGEoyNn3fXxpm9KN1oe2A=;
        b=dd8yRJlGjMVb9EamS+PXhvs6FbwhGgtqWkR2mMIK8YPhUdjMqEX4hwe3QU6jzVSHgj
         PGeeAwsSjxiuYwTYiUsVbESsLXY1rWdmMDh7drc47shWcZc0A9fukvP857qyUxxFpUhw
         CxuifBzwz2Brjb2Je8Tz2Rp2pJvz0YxMB9lS3M/p8Fjn9NaXxRzqvYcKZyNgx68aJ9mA
         uayEjU9mgyBNJYOu0RwexOeILnIv371fMIZDehDvFN9tCM7qb+U0vI87NTiUHHOi+7kR
         rHg7D83POd+9YLrHGiDu7nXQy+5NX0Tiz/OVHXq1X8QRAoNJ0aKsvWDX2ZOZ7VZB5GXT
         RIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8twOuj0NUsVuDEltg5U/7dGEoyNn3fXxpm9KN1oe2A=;
        b=lCXg1tATDnFLhh0xHMlyUaPzwyMVQz4WBcrXX2bNB3xjyFAFtaNhS8F2xZgPtVrdAb
         uJX6q7IYIHs2Ok6rIaurC3QK+I0T4GkIStADMOsfbApFHm9aeGK8cGnzcLMLwtVNbIeV
         ZmjT62YlYOtRL575cccTgJg4u97/QP4QWai0sKVzXpGA5+nnBoID+DIIVN9ozeycGetZ
         0ib3ovv0sULnWyoAnp34n2rYaTPHGEyQbkuJndtjgt8rwZCapIKqHmlvuLKbyHz9J7gc
         7vn2DWHsyLZGbPVXXW47Yak019xQshs6ZJMxS1x+4EGR5QGMGgkOBGljEd5btz8SzI5z
         YXXw==
X-Gm-Message-State: AOAM531ug3fEf3pfKsIVjr063EWZEWh01uHKy917CXOt9G3MgwaQRP3X
        ISHcUz93ze+JtromzudRKpnvP7sYpJnyEwhle5c=
X-Google-Smtp-Source: ABdhPJxTCOBXQKiBDCji2ybWsgSA7K8dzVxMqqQ1i+6ZWklIbY2LGSPMmK6/QO70WW3ozqn6q6lNdu5VCFhnH17JFm4=
X-Received: by 2002:a92:1911:: with SMTP id 17mr3349589ilz.129.1604096546953;
 Fri, 30 Oct 2020 15:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201030212108.112831-1-omosnace@redhat.com>
In-Reply-To: <20201030212108.112831-1-omosnace@redhat.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 30 Oct 2020 17:22:15 -0500
Message-ID: <CAFftDdr-EoYgkhXQMWemdHKSGJT=S+gQDxfBypmaJPYqvkD-Ew@mail.gmail.com>
Subject: Re: [PATCH testsuite] travis: skip kernel update+reboot if it's not necessary
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 30, 2020 at 4:22 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Only do it when we can't install the kernel-modules package for the
> running kernel to make the CI run faster. Now that rawhide images are
> updating regularly again, it is rarely necessary.
>
> Also don't run `dnf clean all -y` before installing dependencies. There
> really is no point and it just slows things down when we do need to
> update the kernel.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  travis-ci/run-kvm-test.sh  | 21 ++++++++++++---------
>  travis-ci/run-testsuite.sh |  1 -
>  2 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/travis-ci/run-kvm-test.sh b/travis-ci/run-kvm-test.sh
> index d22c92b..6afbf96 100755
> --- a/travis-ci/run-kvm-test.sh
> +++ b/travis-ci/run-kvm-test.sh
> @@ -121,15 +121,18 @@ fi
>  # so forks know where to go.
>  #
>
> -# First update to the latest kernel.
> -ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" \
> -    dnf install -y kernel
> -
> -# Then reboot.
> -sudo virsh reboot fedoravm
> -sleep 5
> -
> -while ! nc -w 10 -z "$ipaddy" 22; do sleep 0.5s; done
> +# Check if kernel-modules-$(uname -r) can be installed from repos,
> +# otherwise update kernel and reboot.
> +kernel_avail="$(ssh -tt -o StrictHostKeyChecking=no -q "root@$ipaddy" \
> +    sh -c "dnf check-update kernel-modules-\$(uname -r) | wc -l")"
> +if [ $kernel_avail -eq 0 ]; then
> +    ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" \
> +        dnf update -y kernel-core
> +
> +    sudo virsh reboot fedoravm
> +    sleep 5
> +    while ! nc -w 10 -z "$ipaddy" 22; do sleep 0.5s; done
> +fi
>
>  # And run the testsuite.
>  project_dir="$(basename "$TRAVIS_BUILD_DIR")"
> diff --git a/travis-ci/run-testsuite.sh b/travis-ci/run-testsuite.sh
> index 9b5f954..051f9d8 100755
> --- a/travis-ci/run-testsuite.sh
> +++ b/travis-ci/run-testsuite.sh
> @@ -16,7 +16,6 @@ pwd
>  # the CI.
>  setenforce 0
>
> -dnf clean all -y
>  dnf install -y \
>      --allowerasing \
>      --skip-broken \
> --
> 2.26.2
>

Ack

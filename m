Return-Path: <SRS0=zvjF=D6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED633C4363A
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 14:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F11206DD
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 14:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ct6QCQiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460908AbgJWOyf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Oct 2020 10:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S460715AbgJWOyf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Oct 2020 10:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603464873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bzJx8aY80CbEwaG7cmRgGITRyl5VCcAEJD0k9XaWo1Q=;
        b=Ct6QCQiqojZA85EqcpandtX+WyviV8L/bLxxFL2Ocvv9E6kPEuwA73HXZ8RJ9eMnl6wIBW
        RIRIztXXAnA/z2jnx4xLgCKANWbBMYBGqDHb99sT67gxf5DtUtpd1RKvXb1B5YfL3dU/QL
        SLNrcMtgvX2/tbMkCn+USxPUaXv5ilM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-zORUAfikPmyau12tqzYZJg-1; Fri, 23 Oct 2020 10:54:29 -0400
X-MC-Unique: zORUAfikPmyau12tqzYZJg-1
Received: by mail-lj1-f200.google.com with SMTP id z8so776612ljc.10
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2020 07:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=bzJx8aY80CbEwaG7cmRgGITRyl5VCcAEJD0k9XaWo1Q=;
        b=K05GqkL4S7582DBl5S9xVXXvIgsYr4MqTCBlokL0iPTl/j51hUmbguabkBJ/R2p8OL
         VrxpJpUlae2AfY1hZI/E33SzcI43Ezu6Q4y6zER0DrQwW76upKWxIVJHjZLEzoBS1gp8
         h3JoG2KrZiGfXH6gK4lg/wuY05ERUwY/yEz5/RFKI+eZRLVYqE2dkKa2ACYjJcjKQ3eM
         xYwMNWJHM6u8YujPFr4YlEMfw0u83zfbOLRNov/ljXhNhQxrorMTamIOn4ubaez3Lizr
         62dW8RSDM0l/GR01jJIEGSVBxGlyCYJ0DfQJmm1PE43OSCwNWZrO0rH5GITJjZz5eMxf
         N3lA==
X-Gm-Message-State: AOAM531VjwI7xve52vP0nfkub1dkDcsm9hoAJdQOrRODIGAiSS+MrD3V
        yO+3CxK9KIANcMkNQ9FbjdfI+5grM28lRf6VwlvA+RO2Kxj3h8RR54zJuSV2/oRgLVSGhG8td8t
        VTgkxP+yPuQFCoaPT1hDuaqvPOy7W1C8H1A==
X-Received: by 2002:a2e:b60e:: with SMTP id r14mr1069710ljn.77.1603464866626;
        Fri, 23 Oct 2020 07:54:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOdLLSleZaRDtNzUCSVHLYM/cpCwoVyhj3q7z2Q34cpxIRrekY7b97IiBVOa3pFqbYWMuxjSzBBm8I6044MeM=
X-Received: by 2002:a2e:b60e:: with SMTP id r14mr1069703ljn.77.1603464866405;
 Fri, 23 Oct 2020 07:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201021183312.380344-1-omosnace@redhat.com>
In-Reply-To: <20201021183312.380344-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 23 Oct 2020 16:54:15 +0200
Message-ID: <CAFqZXNtbm9wk1jL=0Z39BjxuVGwan0FSQ2x5N+8Sv-yV5qcBYw@mail.gmail.com>
Subject: Re: [PATCH testsuite] travis: update the kernel and reboot before
 running the suite
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 21, 2020 at 8:33 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> While the stable release cloud image always ships with a kernel which
> has the matching -modules and -devel packages available in the "fedora"
> repo, on development releases the nightly images may be behind the
> latest repo content and thus may fail to install kernel-modules and
> kernel-devel.
>
> Fix it by installing the latest available the kernel and booting it
> before running the testsuite. This unfortunately adds around 3-4 minutes
> to the Travis build time, but there seems to be no better way to make
> the Rawhide test work.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  .travis.yml               |  1 +
>  travis-ci/run-kvm-test.sh | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index 9488807..dcac54d 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -17,6 +17,7 @@ addons:
>        - bridge-utils
>        - libguestfs-tools
>        - cpu-checker
> +      - netcat
>
>  before_install:
>    # FYI: known good with HEAD at 8551fc60fc515cd290ba38ee8c758c1f4df52b56
> diff --git a/travis-ci/run-kvm-test.sh b/travis-ci/run-kvm-test.sh
> index 70fcf08..d22c92b 100755
> --- a/travis-ci/run-kvm-test.sh
> +++ b/travis-ci/run-kvm-test.sh
> @@ -120,5 +120,17 @@ fi
>  # our known_hosts. Also, we need to forward the project directory
>  # so forks know where to go.
>  #
> +
> +# First update to the latest kernel.
> +ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" \
> +    dnf install -y kernel
> +
> +# Then reboot.
> +sudo virsh reboot fedoravm
> +sleep 5
> +
> +while ! nc -w 10 -z "$ipaddy" 22; do sleep 0.5s; done
> +
> +# And run the testsuite.
>  project_dir="$(basename "$TRAVIS_BUILD_DIR")"
>  ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" "SELINUX_DIR=/root/$project_dir /root/$project_dir/$TEST_RUNNER"
> --
> 2.26.2

I went ahead and applied this one as well so that we have a fully
working CI again:
https://github.com/SELinuxProject/selinux-testsuite/commit/596f1f174be32236f80d26c686244f78791b565a

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.


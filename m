Return-Path: <SRS0=XO28=EK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1FBC2D0A3
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 07:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF76920870
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 07:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OftVXscK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgKDHvB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 02:51:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726844AbgKDHvB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 02:51:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604476259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wBUelqYBZCe1X6TdpJAyO2ZtVEqvQC3800jbTRaIr3o=;
        b=OftVXscKnw0Fs+KoOYrFHX5BLjsPzlybeCpSDAYNHY1reMmz/2FtVZl7xkTCRS6jpvLw9B
        DNMWAxSenTK293o6XXdv2n0E3x3SqP8+xSd8Php8HxHx9bbSr2H6LFhb5lgWz5+wDekTdz
        ORV+Ba05JeIdkhyyr8elajcsGxAyKr8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-n3IkfVBWM3WymvlqhrFu0A-1; Wed, 04 Nov 2020 02:50:56 -0500
X-MC-Unique: n3IkfVBWM3WymvlqhrFu0A-1
Received: by mail-lf1-f70.google.com with SMTP id c21so3318747lfd.14
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2020 23:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wBUelqYBZCe1X6TdpJAyO2ZtVEqvQC3800jbTRaIr3o=;
        b=SPET6rBcGOLOU13LZKbm3OhR7tVW54R9VKMqkwcLQ6WaeXoFAChi6eIj5Z3Rs7VtKC
         hHM/2Veg5dPD6C8ZIaFBreqzIJFmqb7LRpVf5of1hO4K9TafG7FSdXxNjyRIwp0KO8Ex
         kJ6aA47xVbYTZfazoG90qaO/Apzj6NdV6u27ns8Uq30V4giDuzGtr5ds22EH3qGkOTZd
         1oZe1Hc4aCo+iuigB4PYnIsm8VOyNa6gU7atruY6o09eCvp7S4OOpBxPBHG/ehguYe8m
         tlvkAd8HnWYFg4a8KjMeC9hVA2dcssJ85R0nqaWINPbzALqjZfCw3fonFD4FdZvNvzpG
         oovg==
X-Gm-Message-State: AOAM533Zjibepb03/RkZ8g5thO4KTlDRyk40AkaUQ0S1WCk6xVUb/4YY
        re6rsO/LJdTFrCiSHCdFo+Uq57WC5SNbUc1Y9LBvnmx8GNRyrD2qqZccfi/8RKlPaD3DUSSc1Rc
        rXNa3CyfY57fz1PShdQrBJcG5jmkQSZz/dg==
X-Received: by 2002:a05:6512:6c3:: with SMTP id u3mr9870111lff.9.1604476254210;
        Tue, 03 Nov 2020 23:50:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwozoq9Gk89VHZeUFkeSTLKuUC5VYp39AzJ0Dgro+Vwn6TL+v+Vv8WdcBYoQVCH0dVl6p+4/umc4SKglKpPSiU=
X-Received: by 2002:a05:6512:6c3:: with SMTP id u3mr9870103lff.9.1604476253998;
 Tue, 03 Nov 2020 23:50:53 -0800 (PST)
MIME-Version: 1.0
References: <20201102105120.492607-1-omosnace@redhat.com>
In-Reply-To: <20201102105120.492607-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 4 Nov 2020 08:50:43 +0100
Message-ID: <CAFqZXNtO=2EhmkC28v2v2u5pXQ00kVRB3=NskU--gCqhmnmYGw@mail.gmail.com>
Subject: Re: [PATCH testsuite] travis: fix kernel update check
To:     SElinux list <selinux@vger.kernel.org>
Cc:     William Roberts <bill.c.roberts@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 2, 2020 at 11:51 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> We need to run ssh without -tt to get the correct output and also run
> dnf with -q to exclude the repo cache update lines. Also, ssh has
> trouble with quoting of arguments, so we need to pipe the command via
> stdin.
>
> Moreover, dnf check-update doesn't seem to do what we need here. Rather
> use `dnf -q info --avail`, which is also more straightforward to use.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  travis-ci/run-kvm-test.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/travis-ci/run-kvm-test.sh b/travis-ci/run-kvm-test.sh
> index 6afbf96..3c19df8 100755
> --- a/travis-ci/run-kvm-test.sh
> +++ b/travis-ci/run-kvm-test.sh
> @@ -123,9 +123,9 @@ fi
>
>  # Check if kernel-modules-$(uname -r) can be installed from repos,
>  # otherwise update kernel and reboot.
> -kernel_avail="$(ssh -tt -o StrictHostKeyChecking=no -q "root@$ipaddy" \
> -    sh -c "dnf check-update kernel-modules-\$(uname -r) | wc -l")"
> -if [ $kernel_avail -eq 0 ]; then
> +if ! echo "dnf -q info --available kernel-modules-\$(uname -r)" | \
> +    ssh -o StrictHostKeyChecking=no -q "root@$ipaddy"
> +then
>      ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" \
>          dnf update -y kernel-core
>
> --
> 2.26.2

Applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/10a0b5dacd2c4108253064bb31f9218782e4403f

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.


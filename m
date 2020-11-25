Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEE7C83010
	for <selinux@archiver.kernel.org>; Wed, 25 Nov 2020 15:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0342D20BED
	for <selinux@archiver.kernel.org>; Wed, 25 Nov 2020 15:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMpk4aOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbgKYPnu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Nov 2020 10:43:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730496AbgKYPnt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Nov 2020 10:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606319027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9y1C1hGTEN8UCNeg/e78c4bhg4ntMjFzYpguhg7XBmE=;
        b=WMpk4aOpuBnepj5PZpjt6D/Noea4QoNFOKjLJ+a+4cJ/gmrVmoNclSvnc3cMTESWGk+/VK
        PhDAUa1jslHB7xODiRNwKcAj5iRkMjj2REnmcP3ION68NEMRS9UYV229Fhr3WTwz+9fyGM
        Hnd+TCvzRnUHlkiiVQARPcZkE3VqS1U=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-MPhMO-s_OjOwPMklGv7vxw-1; Wed, 25 Nov 2020 10:43:44 -0500
X-MC-Unique: MPhMO-s_OjOwPMklGv7vxw-1
Received: by mail-lf1-f69.google.com with SMTP id z19so986085lfg.11
        for <selinux@vger.kernel.org>; Wed, 25 Nov 2020 07:43:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9y1C1hGTEN8UCNeg/e78c4bhg4ntMjFzYpguhg7XBmE=;
        b=qZjqxHBs8KyPM2onoiG6+M/H5ABhOa/knkAP2Zuk3rxV2PSxvU7o/e/HWD9hq6aQeQ
         /4VoakhGEOdfnYfGZSmDMCu0oTRux2HjBDXrdHapIYS4PszvZ4DbH7vMUdANo/3WJIuP
         s7gbHf5aJdh3F84k4sL2AjhAteNBhKhJGLwuFiY7TZR7lRXltCeZffS8UCOW5eGKQR/w
         ZjXOPZ66F2eb5HWujSh8Z3nmgbej824iC4IrHANAbwnTxJduBdcEFiTPPMUpraeQ8lGm
         9T8/ZYgtctJEIs2++YGddmyFaHv8G2+4y+dKDOsBYUukhLU8FTeDg3JK0g3R2oWNF1TD
         kq5Q==
X-Gm-Message-State: AOAM530r2teC35R8/aeS5tnKrha2AVbSl6E/EYfmEaC490I+BNQx4Rdf
        UTeN9FToEFVkMvwWP+ZgtcNG087eIurMho5X487R/4Hum8tLiZRKIoBPfGB1+1Uo33sjWl26hrt
        3hAOAC7f87Ev09koSvvG4sxqjSUUfGcM3Tg==
X-Received: by 2002:a19:ef01:: with SMTP id n1mr1626580lfh.9.1606319022392;
        Wed, 25 Nov 2020 07:43:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy68uL1gamdryiMv/tUgyR4fOnDC7aqtxrwzAgVOc8AYZm0fB4WNY13yCRjPQkXBV/woGGng26zcXHhmLYP5QY=
X-Received: by 2002:a19:ef01:: with SMTP id n1mr1626574lfh.9.1606319022173;
 Wed, 25 Nov 2020 07:43:42 -0800 (PST)
MIME-Version: 1.0
References: <20201124075022.37033-1-nicolas.iooss@m4x.org>
In-Reply-To: <20201124075022.37033-1-nicolas.iooss@m4x.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 25 Nov 2020 16:43:31 +0100
Message-ID: <CAFqZXNsdOg4ogvhvZ8u7VHrT4h3iHbv8cy9C3RiGQNL=LEKHhA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add configuration to build and run tests in GitHub Actions
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 24, 2020 at 8:51 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> Copy the tests that are currently run on Travis CI, in order to no
> longer depends on Travis CI.

s/dependes/depend/, but that can be fixed up when applying.

>
> For more context: Travis-CI is changing its offer, as documented in
> https://docs.travis-ci.com/user/migrate/open-source-repository-migration
> and SELinuxProject moved to https://travis-ci.com
> https://lore.kernel.org/selinux/CAFqZXNspH6MmB-o0wtJJwj-p0DKKrH-ZjfW2YkF_yQS_gCBwqQ@mail.gmail.com/T/#t
>
> Unfortunately the credits for opensource projects are quite limited, and
> require interaction with Travis CI support (which was quite unresponsive
> when I contacted them for other opensource projects I am maintaining).
>
> Create a configuration for Github Actions that duplicates most Travis CI
> checks.
>
> * macOS check has not yet been converted, but GitHub Actions support
>   this platform so this can be done in another patch (and in another
>   configuration in .github/workflows ?).
>
> * KVM support is not available on GitHub Actions so running SELinux
>   testsuite in a Fedora VM is not possible. This is a known issue
>   (https://github.com/actions/virtual-environments/issues/183) and other
>   projects seem to face the same issue (for example
>   https://github.com/opencontainers/runc/issues/2670).

It's not technically impossible, but when I tried to run the testsuite
in a VM without virtualization in GH actions, it was very very slow,
so practically it is infeasible. IIRC when I tried it, it didn't even
install all dependencies after half an hour...

>
> This configuration has been tested on
> https://github.com/fishilico/selinux/actions/runs/380579153
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  .github/workflows/run_tests.yml | 189 ++++++++++++++++++++++++++++++++
>  1 file changed, 189 insertions(+)
>  create mode 100644 .github/workflows/run_tests.yml

LGTM, thank you for doing this!

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.


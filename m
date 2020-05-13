Return-Path: <SRS0=fYOO=63=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F93C433E0
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 15:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C5CC205ED
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 15:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmZamofL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgEMPv6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 May 2020 11:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729467AbgEMPv5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 May 2020 11:51:57 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55B4C061A0C
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 08:51:57 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id o7so21851409oif.2
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 08:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uZyPY2igekukAoA+iue+qpT6H/0/w16pHFIgc3Py/ic=;
        b=pmZamofLe3kyZkTmfhm3svbbZWaR+vm3KEhoDMNDOnrgz9ATFDy53EXsL50vd3IGbw
         lcqqogFsV5L8SSddvy9u7M0TNsqHgeZd7XuEnp+r7WKVBqlY5NJ9Q+pA/guzACdi4KT3
         A+GHYMogSDtSvhEejKqhFEXCd9xkw0AOMzfCzNBYW64vT63J2oJVRcrOy4EudmfMi2A2
         HuQus3SiwtdaErYvVMdt+IgxdK30dIG5LIXUr5KOxkSFlPFGrq1Wki7KL0kXtLDawwBh
         rm2XFAg6Wt5mJf/nk6t3odiuzK356gLs0maMR3LWmi4sbxY8fr01uMeVNEWsQjo9IRny
         ttAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZyPY2igekukAoA+iue+qpT6H/0/w16pHFIgc3Py/ic=;
        b=iOptyiNg3sS+akMHSOrCXXmytHZ7g4tWI3Lr9LSA/YEEBhMYyKksde4iTocDUO9APr
         jy39VgYjgbvX9WldvzV5EHAve1JQ9xm+lga9v8Omd6vbW/YEHCI/W9kuWQCURZ3w1CKm
         OZ3V+lVODa2AlA974sr6+gqxNq6uzSSvQ8RKcLftuxlb6uwEIQ/6BvAs3wc23dwdashk
         jgrnt+eHJfqp3+3aOqTSzaGn8dRul3AyS/FKYNmDRdlXGJ0D4LHePQsMkpjes5tx1byi
         IAG6leEr4A/xe5YRNHhBoKebumLwVfAHt5V3lG6RfDGOBpt8Zr/AvnNDuxCbyNqG3Ftb
         TTuQ==
X-Gm-Message-State: AOAM532aGFSGgnY+U7pUaX+DAEswt9XSw9n1IPoW6nBM/5PmIVLayMl0
        FJl4tJUk45+XtWjPRoSG4PSLyFk6wg+oCLY5XKo=
X-Google-Smtp-Source: ABdhPJy6sb4DENNJBR8zXCxly6n2JcOC0/ReCuMf5f0OuJCBC+1kwKvUpoNVUVloU1D+wUTySqjJHtnf7SEPaTIc/CA=
X-Received: by 2002:aca:210a:: with SMTP id 10mr2760327oiz.92.1589385117077;
 Wed, 13 May 2020 08:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
 <CAFftDdrD-FJ8wBk=XOkvdnkvA5o10w5pJs31H9dEhtW1zU8EHA@mail.gmail.com>
 <CAEjxPJ452zaoFwy++cKqh_Ap2rM1ezEZN83mBhN4ndHHaQ4q5Q@mail.gmail.com>
 <3838641.zh4Wi6GlAV@liv> <cf747e50-ca5b-429f-1af2-afaa16ee29be@debian.org>
 <CAEjxPJ6Uo83L5C9UELy5w_V2wuptSHiHoMMLN4oh75x70-ZzAQ@mail.gmail.com> <CAHC9VhSUHMrMjvG=wigsqVA-0MF0LSmCCC_zyoZYHC2wEnT06A@mail.gmail.com>
In-Reply-To: <CAHC9VhSUHMrMjvG=wigsqVA-0MF0LSmCCC_zyoZYHC2wEnT06A@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 13 May 2020 11:51:46 -0400
Message-ID: <CAEjxPJ72G4bpd6uLy1UikPoU7+tS-Kh2cCO+R75ApoRNCt3_Wg@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
To:     Paul Moore <paul@paul-moore.com>
Cc:     Laurent Bigonville <bigon@debian.org>,
        Russell Coker <russell@coker.com.au>,
        William Roberts <bill.c.roberts@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 7, 2020 at 11:03 PM Paul Moore <paul@paul-moore.com> wrote:
> For a long time now I've wanted to expand my selinux/next kernel
> testing to platforms beyond Fedora.  I believe that it not only helps
> catch problems before the kernel is released, but it also helps ensure
> that the underlying distro has all of the necessary pieces (userspace,
> policy, etc.) in place to support the latest and upcoming kernels.
>
> Unfortunately every time I've looked at the state of SELinux in Debian
> I've run out of time before I got it working well.  I'm not even going
> to get into the Debian package format :/
>
> I would be very happy to see some work go into lowering the bar on
> getting SELinux working on Debian.  My Debian experience is pretty
> limited, but you can sign me up as a very enthusiastic beta-tester,
> just point me at some docs and an ISO :)

FWIW, with the just-merged series, if you follow the new instructions
in the README.md for Debian, you should be able to successfully build
and run the testsuite on Debian stable and unstable (also worked for
me on Ubuntu 20.04 aside from needing to obtain libbpf from upstream
since it isn't packaged for Ubuntu).  The default policy still has
some issues (e.g. don't try to use GNOME in enforcing mode) but if you
can login as an unconfined user and setenforce 1 via text console or
ssh login, you should be able to run the testsuite.

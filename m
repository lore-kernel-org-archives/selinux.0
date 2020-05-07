Return-Path: <SRS0=z4nS=6V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC50C38A24
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 12:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 139AA2063A
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 12:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/V0A6l/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgEGMwM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 May 2020 08:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725969AbgEGMwM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 May 2020 08:52:12 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BF0C05BD43
        for <selinux@vger.kernel.org>; Thu,  7 May 2020 05:52:12 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id c124so4820424oib.13
        for <selinux@vger.kernel.org>; Thu, 07 May 2020 05:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dFFHvv1x8H4C4Q5hE2BvdDCVhKNo/+zN3llE3zxTbHY=;
        b=C/V0A6l/fVYCLg8txUu5vmfILqbkoigr3x58fTD/qX2n6pzdsS9AgUFWWtB1TFJSPM
         bxZQ/58Sg9d+DR9pSUVan96UY79z3gXh6yO2Pz2VD3rIBVSDW2AUSM6dMKxj3Tz5xq0g
         s6rd7eRDQ3cI9/E3LNF223nW3vI8m2jLPtxknls6HlpbPVcHTjymmaEXZMe+pA768BSJ
         WU5wZVkvQw355UURnO12h66dNhMasrxy1cZ7km9JRrS4qYPTFgLnHyAXTbXxeetjr7WN
         ttGHiacNe8O2diQiLL47mQcA8IB3H8BWjXn8UJ+l30ylpzUkNw61p3WDfCZI81HNUSoq
         VmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dFFHvv1x8H4C4Q5hE2BvdDCVhKNo/+zN3llE3zxTbHY=;
        b=W2Md0jZDbdKvzKqA/2lYoGOxt6YSJHLuGwGAiWM/VgBogjoDU3bVJuZvPmDMEqJQac
         S+cNDhohUuBw6hBYWQ4NxM8gybVktDOEwdEsev1n0LZ5rDf8/Q5C1gamQfzYXzi8sLQU
         XCkWhtKoq0EEm9kMFTcqgp25F+6nQ/Vi2YBgUDLp7uyuYsu/+C54IjDatai3CE7oP7b4
         S4uHWRnODoJ/8iszduEm1+SJ4ONWuV4EryzPMxKCdM5jjyzUPrzthPZB8wOSF2SAKnAN
         fSYCPbhpNBGdak6BfqWtC3BiadIJIc/k+So5OtRtyB5CLaO1rD5D2DivcQkLKIkPAaWu
         WsbA==
X-Gm-Message-State: AGi0PuYGPKYs6azYu0yfAQb4UffA5RvaxdfKAWFjcQCcAvCrkJj01hNU
        zOO3ewCmMsUsth5FGUV+G/RjfaK7wguy8hiZ1Lk=
X-Google-Smtp-Source: APiQypKCQPNvICd2/YblWRVT5OqeOh4VTq5ru9qyjELnqGLXO8+kVOjJ2w+XYaw0c61T7x/7zPl2/vDcoKUXXKU66ro=
X-Received: by 2002:aca:4e10:: with SMTP id c16mr6419170oib.140.1588855931657;
 Thu, 07 May 2020 05:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
 <CAFftDdrD-FJ8wBk=XOkvdnkvA5o10w5pJs31H9dEhtW1zU8EHA@mail.gmail.com>
 <CAEjxPJ452zaoFwy++cKqh_Ap2rM1ezEZN83mBhN4ndHHaQ4q5Q@mail.gmail.com>
 <3838641.zh4Wi6GlAV@liv> <cf747e50-ca5b-429f-1af2-afaa16ee29be@debian.org>
In-Reply-To: <cf747e50-ca5b-429f-1af2-afaa16ee29be@debian.org>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 7 May 2020 08:51:59 -0400
Message-ID: <CAEjxPJ6Uo83L5C9UELy5w_V2wuptSHiHoMMLN4oh75x70-ZzAQ@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
To:     Laurent Bigonville <bigon@debian.org>
Cc:     Russell Coker <russell@coker.com.au>,
        William Roberts <bill.c.roberts@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 7, 2020 at 4:46 AM Laurent Bigonville <bigon@debian.org> wrote:
>
> Le 6/05/20 =C3=A0 18:37, Russell Coker a =C3=A9crit :
> > On Thursday, 7 May 2020 1:50:46 AM AEST Stephen Smalley wrote:
> >> on that running instance, but not to specify custom kernel parameters
> >> initially or to reboot the system before proceeding with further
> >> commands (if anyone knows differently, speak up). We'd have to get to
> >> the point where enabling SELinux in Debian is possible without
> >> requiring a reboot at all.  And then we'd have to wait for that
> >> support to find its way into one of the Ubuntu images supported by
> >> travis-ci.  Might be easier to just get travis-ci to support Fedora or
> >> CentOS images in the first place. Regardless, allowing the testsuite
> >> to be run by users of other distributions is worthwhile IMHO.
> > In the past there hasn't been much demand for a smoother installation p=
rocess.
> > If you are setting up a traditional Unix server system the Debian SE Li=
nux
> > installation thing doesn't make things much more difficult.  Past compl=
aints
> > about it have been more about an imagined difficulty of using SE Linux =
and have
> > ended when I showed and wrote about how to do it (one time I showed
> > screenshots of the process in an LCA lightning talk and didn't have pro=
blems
> > with time).
> >
> > I don't think that the people who maintain the Debian installation rela=
ted
> > packages would have a great objection to adding SE Linux features, alth=
ough it
> > might take a bit of time for it to migrate from Debian to Ubuntu.
> >
> > We can make this a priority.
> >
> If people are using preseed installations (kickstart equivalent), I
> think that enabling SELinux in the installer shouldn't be too difficult
> (installing the needed packages, modifying the files and relabeling with
> fixfiles). It's obviously not user friendly, but the question is what's
> the target here.

The visionary end state goal would be to allow one to specify some
kind of option in a travis-ci configuration and get a SELinux-enabled
image on which we could perform travis-ci validation of
selinux-testsuite, selinux userspace, and maybe even the kernel.  I
don't think that is possible in the near term though and will require
changes to travis-ci itself.  At the moment our travis-ci validation
of the testsuite and userspace is limited to building and in the
latter case running some limited tests that do not depend on having
SELinux on the host.

The nearer term goal is to minimize obstacles to using SELinux in
Debian, one of which is the need to install Debian and then install
SELinux as a separate step (with two reboots along the way) rather
than an installer option.  We can't use that approach in travis-ci
AFAICT because we cannot reboot the instance and then proceed with
testing.  If we can tell the installer to include the necessary grub
and pam configurations up front and to label the filesystems during
installation (which can happen even while SELinux is disabled in the
kernel; only requires filesystem xattr support), then we can avoid the
need for any extra reboots post install.

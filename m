Return-Path: <SRS0=piI6=6W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EED8C35280
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 03:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D953F20663
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 03:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="sJ1/baLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgEHDDt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 May 2020 23:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgEHDDt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 May 2020 23:03:49 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA33EC05BD43
        for <selinux@vger.kernel.org>; Thu,  7 May 2020 20:03:48 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id s10so84150edy.9
        for <selinux@vger.kernel.org>; Thu, 07 May 2020 20:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0HYShdA8LbQLj/wgcuEW8uDJTTm+n4uFhsiNeP0USB8=;
        b=sJ1/baLC1nrG1hk3S3g0nBo/If0/2Sg/1s6zq//H+Y4d3Swp78WXTDxaIIZJfFOUtz
         OhY3U9ZL7LiG7+bUmgJr44ON+hV8nSkaMs/FRvsmX4HwSeJatrgWoBrtBv/DBtM4Ch1m
         CUNIVlkNShz4MnTeE2NBnze5/yERLCxLMSYFErTsf793DWKp4iM7JfRsINWV1XuRvSK4
         5y73vf5UwOFzppoODyClo/SnrJGiaEq4miUoq7KMnmGn9BZNCq7M0WYG5eCJ7ZhPoxD3
         2x/5r2wfzbgRKcaKGf5g64qFSVauyUk28M47DqgT/jxSeY4ZS5idQJsE8NLLd0yRYuSk
         Vlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0HYShdA8LbQLj/wgcuEW8uDJTTm+n4uFhsiNeP0USB8=;
        b=OGgzvotT3u8RpggOMwDPO/6kr1M4rxIE8Kf+0pCc47rBU+P+Zjh6nfMyijeQu5IK+O
         g80Sl2w5Rvrh1HxDtV0FclYumACaoibPWjRtIig4nmgGxjzBsVWet9v0GsntY8+ZmqoN
         grkMgbjMs0Qd04mSc+Eb8hSxW1uC+IndKbtuWE/LX9tbWQVEzIGMajmZQc99IMBGHKc5
         BJVrucALTl9cPiEJms83YANpuIh6L2G9AFNWDKrTGY9iRpaC+pAgypF0zYpvutC/19rt
         iFFthhLTl2xLs0v6A29fRKGkHrNCEUrOz3a3gYgU8NaKgDymOvMCGeywNGTCXZ8ctK6S
         umDA==
X-Gm-Message-State: AGi0Pubv2lRTPnxEKMx2/+uMz0mNBD0LCYSkwlkLgjG4xRwpwADPu9rW
        iXQZnYTVdGloq9jjtLLLGk2WmwOv6/fqt8Nruhyg
X-Google-Smtp-Source: APiQypKm+2sPqQylg/A1U8Fp9cSWHxP57HAb0NMk7m1VOI+X++zHqidv+nGpbkMnWqZzUNxtxcXLJJAkur/mXlOvdjw=
X-Received: by 2002:aa7:cb0f:: with SMTP id s15mr408462edt.164.1588907026184;
 Thu, 07 May 2020 20:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
 <CAFftDdrD-FJ8wBk=XOkvdnkvA5o10w5pJs31H9dEhtW1zU8EHA@mail.gmail.com>
 <CAEjxPJ452zaoFwy++cKqh_Ap2rM1ezEZN83mBhN4ndHHaQ4q5Q@mail.gmail.com>
 <3838641.zh4Wi6GlAV@liv> <cf747e50-ca5b-429f-1af2-afaa16ee29be@debian.org> <CAEjxPJ6Uo83L5C9UELy5w_V2wuptSHiHoMMLN4oh75x70-ZzAQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Uo83L5C9UELy5w_V2wuptSHiHoMMLN4oh75x70-ZzAQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 7 May 2020 23:03:34 -0400
Message-ID: <CAHC9VhSUHMrMjvG=wigsqVA-0MF0LSmCCC_zyoZYHC2wEnT06A@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Laurent Bigonville <bigon@debian.org>,
        Russell Coker <russell@coker.com.au>,
        William Roberts <bill.c.roberts@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 7, 2020 at 8:52 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, May 7, 2020 at 4:46 AM Laurent Bigonville <bigon@debian.org> wrot=
e:
> >
> > Le 6/05/20 =C3=A0 18:37, Russell Coker a =C3=A9crit :
> > > On Thursday, 7 May 2020 1:50:46 AM AEST Stephen Smalley wrote:
> > >> on that running instance, but not to specify custom kernel parameter=
s
> > >> initially or to reboot the system before proceeding with further
> > >> commands (if anyone knows differently, speak up). We'd have to get t=
o
> > >> the point where enabling SELinux in Debian is possible without
> > >> requiring a reboot at all.  And then we'd have to wait for that
> > >> support to find its way into one of the Ubuntu images supported by
> > >> travis-ci.  Might be easier to just get travis-ci to support Fedora =
or
> > >> CentOS images in the first place. Regardless, allowing the testsuite
> > >> to be run by users of other distributions is worthwhile IMHO.
> > > In the past there hasn't been much demand for a smoother installation=
 process.
> > > If you are setting up a traditional Unix server system the Debian SE =
Linux
> > > installation thing doesn't make things much more difficult.  Past com=
plaints
> > > about it have been more about an imagined difficulty of using SE Linu=
x and have
> > > ended when I showed and wrote about how to do it (one time I showed
> > > screenshots of the process in an LCA lightning talk and didn't have p=
roblems
> > > with time).
> > >
> > > I don't think that the people who maintain the Debian installation re=
lated
> > > packages would have a great objection to adding SE Linux features, al=
though it
> > > might take a bit of time for it to migrate from Debian to Ubuntu.
> > >
> > > We can make this a priority.
> > >
> > If people are using preseed installations (kickstart equivalent), I
> > think that enabling SELinux in the installer shouldn't be too difficult
> > (installing the needed packages, modifying the files and relabeling wit=
h
> > fixfiles). It's obviously not user friendly, but the question is what's
> > the target here.
>
> The visionary end state goal would be to allow one to specify some
> kind of option in a travis-ci configuration and get a SELinux-enabled
> image on which we could perform travis-ci validation of
> selinux-testsuite, selinux userspace, and maybe even the kernel.  I
> don't think that is possible in the near term though and will require
> changes to travis-ci itself.  At the moment our travis-ci validation
> of the testsuite and userspace is limited to building and in the
> latter case running some limited tests that do not depend on having
> SELinux on the host.
>
> The nearer term goal is to minimize obstacles to using SELinux in
> Debian, one of which is the need to install Debian and then install
> SELinux as a separate step (with two reboots along the way) rather
> than an installer option.  We can't use that approach in travis-ci
> AFAICT because we cannot reboot the instance and then proceed with
> testing.  If we can tell the installer to include the necessary grub
> and pam configurations up front and to label the filesystems during
> installation (which can happen even while SELinux is disabled in the
> kernel; only requires filesystem xattr support), then we can avoid the
> need for any extra reboots post install.

For a long time now I've wanted to expand my selinux/next kernel
testing to platforms beyond Fedora.  I believe that it not only helps
catch problems before the kernel is released, but it also helps ensure
that the underlying distro has all of the necessary pieces (userspace,
policy, etc.) in place to support the latest and upcoming kernels.

Unfortunately every time I've looked at the state of SELinux in Debian
I've run out of time before I got it working well.  I'm not even going
to get into the Debian package format :/

I would be very happy to see some work go into lowering the bar on
getting SELinux working on Debian.  My Debian experience is pretty
limited, but you can sign me up as a very enthusiastic beta-tester,
just point me at some docs and an ISO :)

--=20
paul moore
www.paul-moore.com

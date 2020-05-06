Return-Path: <SRS0=wTGR=6U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A012C28CBC
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 14:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015BE208D5
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 14:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvHTQo2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgEFO5j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 May 2020 10:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgEFO5j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 May 2020 10:57:39 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34289C061A0F
        for <selinux@vger.kernel.org>; Wed,  6 May 2020 07:57:39 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k18so89593ion.0
        for <selinux@vger.kernel.org>; Wed, 06 May 2020 07:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Ef2vZJDWSBNKTVvb36tuJTaHuKo5KpWTHg3CibrIEA=;
        b=jvHTQo2+9Frk/8GVh1HOr2xeFEWgcMpDlADYl9mL741J5RXFou8WV1lrBa/VFS44c1
         FsyXdv2FQFR+65/AyTKNBKwWyRtbGNJ3+o/RffXQOertxNGFipxwVdpPlM052fX/YQl0
         gksC+XxK72VCEzjzZGyps5HdGYnBCvR0dCelo0Gk2SIKKwEKEaAvjzD+mYjO0Pz6isVy
         GmnYwMsesMqfPGC9UM4PyTcy59M9uXT/rFmK57Yf7xHxdF8QeRB0EOZ0MWrgj12u8DCV
         ERc3RbM44/gBCpjYu46fbiZ6m12BIXUnR3nFcf5YIy9D2VpO7loS9OqXNiX85wbyZ+pZ
         6olw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Ef2vZJDWSBNKTVvb36tuJTaHuKo5KpWTHg3CibrIEA=;
        b=jN5IAS70OsJNhaAZP6MI0NRnXpYxwOIQPGa54BrxCmaJRZf+jlGvADiZRqCDhGKid5
         zDHw3JS6q79XddnnvoMUba+6iIe6YNQqjNA6N904YzMhmb2jiSSGsJCGIDzicfYvzOoc
         YbmU+tKfwVPku06K+PVa6+47RsSdFyaf+XyyhL4OYbhIiZkGag3QLRiqGlMnziwybcgF
         lQ/Fp4xG3XAm4t2hjNA4k9AeiqLm+jatAsBemz4eigBhopkdxFDrhKHb6D9OPld8oLzi
         Xi4saTs/odc2I2DFit1w+7m6NkAoqCajwZs8TtoMdtJpfmapYXALo7ZthFV/UqbHlWpt
         cqtg==
X-Gm-Message-State: AGi0PuYH+6PegARd8QhDzBNaqaU5dYBYmzyzaw+NY4mhDGVCQXvwsqe+
        teJ7sfWcxvF8BSa7ho+75L7lfO8txXiw3Tx5xjMbxLW3
X-Google-Smtp-Source: APiQypI39n0pxZfoKDv0TODf308E4XnRA/YPBL76GNMPXkPxKNu3igBluPiM3jWPiUNSfRScZ903A1QJiKbsn1GQVMo=
X-Received: by 2002:a6b:f911:: with SMTP id j17mr8605894iog.139.1588777058380;
 Wed, 06 May 2020 07:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com> <CAEjxPJ7GVYBTKyiQM8_XdnbXk26-Eq_cPAs1zrtK8Aj=FfZd_A@mail.gmail.com>
In-Reply-To: <CAEjxPJ7GVYBTKyiQM8_XdnbXk26-Eq_cPAs1zrtK8Aj=FfZd_A@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 6 May 2020 09:57:27 -0500
Message-ID: <CAFftDdrD-FJ8wBk=XOkvdnkvA5o10w5pJs31H9dEhtW1zU8EHA@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 6, 2020 at 8:45 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, May 5, 2020 at 8:54 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Update the testsuite policy and code so that it builds and
> > runs on Debian unstable and stable successfully (if one has
> > already enabled SELinux on Debian).  Provide the necessary
> > dependencies and instructions in the README.
>
> A few notes for anyone trying to run this on Debian:
>
> 1) There is an open bug in Debian around gdm login shells running in
> the wrong context (initrc_t instead of unconfined_t),
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=874191, due to the
> /sys/fs/selinux/user ERANGE problem breaking pam_selinux for the
> systemd --user instance and the lack of either a policy workaround (as
> previously done in Fedora to limit outbound transitions from init_t to
> only valid cases) or the recent libselinux fix (to stop using
> /sys/fs/selinux/user altogether).  To permit testing without requiring
> my own custom policy or libselinux, I simply ran the tests from a ssh
> login rather than a graphical login.  Non-graphical console login
> probably would have worked too but I didn't try. But I have escalated
> the bug with the Debian SELinux maintainers in hopes of getting that
> fixed.
>
> 2) In Debian unstable, I also had to setsebool -P ssh_sysadm_login=1
> to allow ssh login as unconfined.  I let the Debian SELinux
> maintainers know but it isn't clear they will change the default.
>
> 3) Debian policy package ships with /etc/selinux/config set to
> permissive since the policy often doesn't work cleanly out of the box,
> so I had to manually setenforce 1 before running the testsuite.  This
> btw killed any gdm login sessions as well due to missing execmem and
> other permissions so that's another reason to not do it from a gdm
> login under their current policy.
>
> 4) The Debian stable kernel didn't enable CONFIG_NETLABEL so all of
> the netlabel-dependent inet_socket tests failed on stable.  Debian
> unstable kernel had CONFIG_NETLABEL enabled and they all passed there.
> I didn't consider it worthwhile to build my own Debian stable kernel
> for testing it; I just wanted to ensure that the policy worked, which
> I consider the Debian unstable test to prove.
>
> Interestingly, on Debian unstable, we end up running more tests than
> on Fedora rawhide currently: 64 test scripts with 869 individual tests
> versus 62 test scripts with 824 individual tests.  This is because
> Debian unstable's policy (which is based on a recent snapshot of
> refpolicy) has class and permission definitions for everything in its
> kernel except the lockdown class, versus Fedora which lacks the watch*
> permissions as well as the perf_event and lockdown classes.

This is fantastic, I haven't looked at it fully yet. But I'm assuming this would
be the initial bulk work to get the make check on travis better. So in theory
we can just replicate this on Travis. Is my understanding correct here?
Ideally, we can get to a point where if CI is passing, its already an RC
candidate.

Return-Path: <SRS0=oO2X=WX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB8AC3A5A6
	for <selinux@archiver.kernel.org>; Tue, 27 Aug 2019 17:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454BC206BF
	for <selinux@archiver.kernel.org>; Tue, 27 Aug 2019 17:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="1COEvurp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfH0RYq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Aug 2019 13:24:46 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45565 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0RYq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Aug 2019 13:24:46 -0400
Received: by mail-lf1-f66.google.com with SMTP id o11so6497008lfb.12
        for <selinux@vger.kernel.org>; Tue, 27 Aug 2019 10:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ad0rlor5MGfGSOlkRJBMrrnHr5e679Yzb11amluiugk=;
        b=1COEvurpyqmjhijgoJ2749mFxQKddU4K66iWQ5rNylO6NprPAmSoRPCWz83CgzB2fO
         fa7z5gwenVfk1isTfsx4CY3amtyxwftWiipAMlIG78XSg8B/UaWy1SOotUR6SkEu5mmH
         qJdk5tglmxJDOOjm1BkgUCKYNgJHKXiw72JHPDgpdSV9FFwO3pz089BDMErN/jzaQY44
         wE9VrKyC6s4d7tJWRlISUuqdT2W6+tZJTTHG6BBfZmUjSF/y4/HIuBmb90AhcO0G2/cM
         QBVJofWEeP/ruIT+Sto/9cQUvyjxF1VDzqfIjsGLT1Aei+zQNkvQpjJhEvSoNcgxG04I
         +wCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ad0rlor5MGfGSOlkRJBMrrnHr5e679Yzb11amluiugk=;
        b=PQTK4jq7797vPMK51CTpu17eFaNC25jtEVtXQ7JmnVspeCKjeFgEXXb2qsBpcEdy//
         VdGSZEqynB+dOLo4zlXYp9oP4fuCo8gRfszvJhQ4rDai660G7g8FXeAZC3tRxTs7DBdW
         Es0uP2L7eFl22Esy8fq28h9qtBpPA8W5wsWh8qYUNzondIHJqz/ay3hI7zGxHiP6FPW5
         C26xwOJUo59T4bgk06UF6KFRxauPRHwpMZWDgjSlVZ3+dxjK58tqBtzN3umezBRHEulF
         ptwKvgQQlULv6xSfYJLhRJcaUkJhdQpVD7oxpDqXxZTz+A+Pa1/1qqIaJQYxfxMOy1Ro
         m+qw==
X-Gm-Message-State: APjAAAUl65G7fPVexIPhYAzLXaScbj1szUzb1DlWNfKmQC81zctp3x0w
        6ulwYY+vc6HzqH04R2Yrgvq6bBskzHHsp0A0XXEs4tJYLw==
X-Google-Smtp-Source: APXvYqz2zREnwm7aNr9SW9004n72as6isKSvvajAFcCmQpk32SRMoQ/njOVdKPn6zzgcqPoPWA7peUGmvST6Jm1RoSg=
X-Received: by 2002:ac2:4474:: with SMTP id y20mr5314780lfl.31.1566926683848;
 Tue, 27 Aug 2019 10:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTuYi+W0RukEV4WNrP5X_AFeouaWMsdbgxSL1v04mouWw@mail.gmail.com>
 <CAHC9VhR1ZNyZqGB3Si-z77zLwaTBf-pkQk19rVqofs4P_oVtFg@mail.gmail.com>
In-Reply-To: <CAHC9VhR1ZNyZqGB3Si-z77zLwaTBf-pkQk19rVqofs4P_oVtFg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Aug 2019 13:24:31 -0400
Message-ID: <CAHC9VhSKxgCB_j-eT65tSvqFDbBe_Wu_b+XsvN0Si2eDrEROMQ@mail.gmail.com>
Subject: Re: IB pkey policy problem found via the selinux-testsuite
To:     selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org,
        Lukas Vrabec <lvrabec@redhat.com>,
        Chris PeBenito <pebenito@ieee.org>
Cc:     danielj@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 28, 2019 at 4:58 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Feb 13, 2019 at 4:35 PM Paul Moore <paul@paul-moore.com> wrote:
> > Hello all,
> >
> > On a fully up-to-date Rawhide system you need the following line added
> > to the policy/test_ibpkey.te file to get a clean run of the
> > selinux-testsuite:
> >
> >   allow test_ibpkey_access_t self:capability { ipc_lock };
> >
> > The breakage doesn't appear to be due to a kernel change (previously
> > working kernels now fail), or a Fedora Rawhide policy change (nothing
> > relevant changed since the last clean run), but I did notice that my
> > libibverbs package was updated just prior to the breakage.  I haven't
> > had the time to dig into the library code, but I expect that to be the
> > source of the problem.
>
> Just to be clear, I don't believe this breakage is limited to the test
> suite, I expect any users of the SELinux IB hooks will run into this
> problem.  I believe we need to update the upstream and distro
> policies.

A ping to bring this issue back to the top of the mailing list.

--
paul moore
www.paul-moore.com

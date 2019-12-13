Return-Path: <SRS0=c00g=2D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AE9C50715
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C5524715
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/LXVv9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfLMNzH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:55:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37777 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727569AbfLMNzH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Dec 2019 08:55:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576245306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LbtNdQTzXNH7djNrFSPyc6Qz7lDmmURxMItAvS2HkFA=;
        b=M/LXVv9jeY2mngSGvoIo25zAqe/gbSrPiDuwvG/IsdHc1RaB/PlPpnRej5IAvw2o1FBD5s
        LFjJfHupam5CkMDjVVJOhmmPhzDeZWx5CvyGYM3E0M+Jd0R0ZtO0NpiXmHl8by7Vu0m373
        EWLKv0dU+ypSCaZOr8pOg+CwkIMdjt8=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-pbwFc2xJOdCQ8b4Pf1-f-A-1; Fri, 13 Dec 2019 08:55:03 -0500
X-MC-Unique: pbwFc2xJOdCQ8b4Pf1-f-A-1
Received: by mail-oi1-f197.google.com with SMTP id v130so1295869oif.18
        for <selinux@vger.kernel.org>; Fri, 13 Dec 2019 05:55:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbtNdQTzXNH7djNrFSPyc6Qz7lDmmURxMItAvS2HkFA=;
        b=CuPWIiUhS/d7itSxnR6tQ9HWyapQwivkgnKSu1gt4oZt4zOi10SWg/vupzHMmxyGTj
         CASGAdEBcxJyoCQ87wKeFKTJANjIj4cD/eplAG7wMEATVXEi00hyaQRGdMxDsMytf5hc
         m4XIMUNjvK5jtRvQvH6YNgW8Nwy7xVnDW1ZAOThAUf9NQjsAmYUhIIoMq5O3soWBPcYP
         09gVTetysfchpim8/k4LecFSSY3LjMJccC8LYkUD1T4SphiYQf3EifGHQpbh8xGJwkJ4
         +4vKarMC3C1dOxXvft2NplXiyPMQnNqhuDQaf3x1ayBzLVENYEOOxwbZA6fz8haOfUm7
         xorg==
X-Gm-Message-State: APjAAAUnEzrh8/lD6e6rSpzITn1bJzGgJ4aRBU3UaezY+C0ojF8WDZk1
        +MOg+ZpPQ0e6A7GGSvsvafUH4m+yuJjD9wuAyOm8FPaY1Vv7QRey7KdYJTJlfGmM6JjswJ1iPru
        sjDArF8ZUSn1csHvBO/gnqedWsOcUmaW8Wg==
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr15593146otn.22.1576245302313;
        Fri, 13 Dec 2019 05:55:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqyt64zlQTx3HdzyXefId4FhEFI/cjJZ2tqgs0MS2QjiTfLJvPOj7VVeECwFkFVbBbBRbhhXqs4RRcU+14kKE0o=
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr15593116otn.22.1576245302040;
 Fri, 13 Dec 2019 05:55:02 -0800 (PST)
MIME-Version: 1.0
References: <20191211140833.939845-1-omosnace@redhat.com> <677be2d4-8247-3c2b-ac13-def725cffaeb@tycho.nsa.gov>
 <201912110840.62A4E64BA@keescook> <356c555a-d4ab-84fb-0165-f7672bc1ee63@schaufler-ca.com>
 <2fdb09e7-6668-cb1b-8a2d-1550278ae803@tycho.nsa.gov> <CAFqZXNtjELoG_5GK5c4XpH8Be3NfsKMZdZvrJKPpnTLPKKgZ9A@mail.gmail.com>
 <1f613260-d315-6925-d069-e92b872b8610@tycho.nsa.gov> <CAHC9VhT_CBQN+aFWjpPixi9Ok3Z7bQ-053AHg4pvqVtn-RdVVA@mail.gmail.com>
 <0f0778af-73c2-3c75-30c0-da5eae203032@tycho.nsa.gov> <CAHC9VhT24b6YYTcE-h9pS9HnJ35unW_14EYLcNBBd-xUa=1L9A@mail.gmail.com>
 <83d047ce-0ca0-4152-1da7-32798c500aab@tycho.nsa.gov> <CAHC9VhQG9zZEL53XRdLHdmFJDpg8qAd9p61Xkm5AdSgM=-5eAg@mail.gmail.com>
In-Reply-To: <CAHC9VhQG9zZEL53XRdLHdmFJDpg8qAd9p61Xkm5AdSgM=-5eAg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 13 Dec 2019 14:54:50 +0100
Message-ID: <CAFqZXNsWPZ3mVUjDrgeoU0PadcuzHtQx48ncr4ez2NtK=qtK2Q@mail.gmail.com>
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        SElinux list <selinux@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 12, 2019 at 7:18 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Dec 12, 2019 at 1:10 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 12/12/19 1:09 PM, Paul Moore wrote:
> > > On Thu, Dec 12, 2019 at 12:57 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > >> On 12/12/19 12:54 PM, Paul Moore wrote:
> > >>> ...
> > >>> Just so I'm understanding this thread correctly, the above change
> > >>> (adding enabled checks to each SELinux hook implementation) is only
> > >>> until Fedora can figure out a way to deprecate and remove the runtime
> > >>> disable?
> > >>
> > >> That's my understanding.  In the interim, Android kernels should already
> > >> be disabling CONFIG_SECURITY_SELINUX_DISABLE and other distros may
> > >> choose to disable it as long as they don't care about supporting SELinux
> > >> runtime disable.
> > >
> > > Okay, I just wanted to make sure I wasn't missing something.
> > > Honestly, I'd rather Fedora just go ahead and do whatever it is they
> > > need to do to turn off CONFIG_SECURITY_SELINUX_DISABLE (it sounds like
> > > they have a plan and are working on it), I'm not overly excited about
> > > temporarily cluttering up the code with additional "enabled" checks
> > > when the status quo works, even if it is less than ideal.
> >
> > The status quo is producing kernel crashes, courtesy of LSM stacking
> > changes...
>
> How prevalent are these crashes?

I don't think they are prevalent, we only received one report for RHEL
and it came in ~ 6 months after 8.0 was released, which was the first
release that had the stacking patch. I wasn't able to reproduce it
without adding delays between the hook removals. However, the report
may have some specific configuration where it happens more often due
to just the "right" timing of some events...

>
> This also only happens when disabling SELinux at runtime, yes?
> Something we've advised against for some time now and are working to
> eliminate?  Let's just get rid of the runtime disable *soon*, and if
> we need a stop-gap fix let's just go with the hook reordering since
> that seems to minimize the impact, if not resolve it.
>
> I'm not going to comment on the stacking changes.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.


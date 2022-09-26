Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5CFC32771
	for <selinux@archiver.kernel.org>; Mon, 26 Sep 2022 18:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiIZSO1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 26 Sep 2022 14:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiIZSNs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 26 Sep 2022 14:13:48 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C2413F1C
        for <selinux@vger.kernel.org>; Mon, 26 Sep 2022 11:03:20 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e205so5913200iof.1
        for <selinux@vger.kernel.org>; Mon, 26 Sep 2022 11:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Mzbyizo3Nwtc8a3WAxtxS6k0hBx8va3OMev51GvHHpg=;
        b=ZQgK0edH4AVL5PgPv4C44UeBjddDT3gctcEWYER1PysSVDiOvUk21nSeHSLJyqVla3
         AWTGB+dsQ/gM7ZbhYW2c3pTOqC+7VGnadW5jchbc1mdqfFuQsiFWfvvxqdbKEsfWBQfJ
         TH5MF7q9HCcLO1rk09L2yzOoUY2sksvcroNrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Mzbyizo3Nwtc8a3WAxtxS6k0hBx8va3OMev51GvHHpg=;
        b=SnAmsr30rWmbVEYkdaEclEkLpoG2euy0E3O6NMxrtwIF4h0bZK5lnHnM+1Jv6PcXSu
         hOXY/D6hyx4JKqgCByZCSZG9h7hZbIDNx7G5UZupqmKiz86Y6nTru0CkBRBa4lANBFSR
         crP7PQPAptAfiY0tNfBTtVe5T9Kvyz6DDKSwQ5FW9gM1V4CbHPgDtoS1R5UCMnoIdCQP
         0l9ug744uui9w9XcIwVEiVgdZ/aQ8fGf0EdU7ZbPByOQWjt+SP82ayMCnHm0Cw/tefyP
         2Kp/izcZDwatE3ZMuC8tRUsGweJb4RePIuIfueCltX8QE1rCy+ZPUbuJMGtuZ+mlEqIK
         /6Ng==
X-Gm-Message-State: ACrzQf12OnGQLyrSDsboIdEetYWG1DD2BbC1RFSnFyqaFBT4dEQc5K6K
        EnNcGS5bQULZZrc2QAZxNMPU1m+VXRUB3CBjHAwXs6x992Mtlw==
X-Google-Smtp-Source: AMsMyM75w4EGQuoeMByhsQXEOTOlioGW8fh+xsDx5Oc4kkXTJdqgREqv2KmcTvJPCf5vVOde0o/S2J/JggnpSjgxvI0=
X-Received: by 2002:a6b:e714:0:b0:6a1:35af:82dc with SMTP id
 b20-20020a6be714000000b006a135af82dcmr9588636ioh.205.1664215400281; Mon, 26
 Sep 2022 11:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220921185426.1663357-1-jeffxu@chromium.org> <20220921185426.1663357-2-jeffxu@chromium.org>
 <CAHC9VhS-jv5cpSdq7dxFGYH=z=5grQceNMyjroeL2KHdrVUV6g@mail.gmail.com>
 <CABi2SkXRxomrYn-xUf3B+XswmQjXZUJXmYJECmr_nBfrZWwqkA@mail.gmail.com>
 <CAHC9VhRuUZxdsVQftqWa0zEuNAxk8ur0-TZp5KecJ537hRONRQ@mail.gmail.com> <875yhe6ial.fsf@defensec.nl>
In-Reply-To: <875yhe6ial.fsf@defensec.nl>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Mon, 26 Sep 2022 11:03:09 -0700
Message-ID: <CABi2SkW4P+s-+5X7UGYYp1tUtT350_7UfQx_KYqHAyYe31ORWw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add CONFIG_SECURITY_SELINUX_PERMISSIVE_DONTAUDIT
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        groeck@chromium.org, Luis Hector Chavez <lhchavez@google.com>,
        Luis Hector Chavez <lhchavez@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 23, 2022 at 11:45 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Paul Moore <paul@paul-moore.com> writes:
>
> > On Fri, Sep 23, 2022 at 1:43 PM Jeff Xu <jeffxu@chromium.org> wrote:
> >> On Wed, Sep 21, 2022 at 12:11 PM Paul Moore <paul@paul-moore.com> wrote:
> >> > On Wed, Sep 21, 2022 at 2:54 PM <jeffxu@chromium.org> wrote:
> >> > >
> >> > > From: Jeff Xu <jeffxu@chromium.org>
> >> > >
> >> > > When SECURITY_SELINUX_DEVELOP=y and the system is running in permissive
> >> > > mode, it is useful to disable logging from permissive domain, so audit
> >> > > log does not get spamed.
> >> > >
> >> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> >> > > Signed-off-by: Luis Hector Chavez <lhchavez@google.com>
> >> > > Tested-by: Luis Hector Chavez <lhchavez@chromium.org>
> >> > > Tested-by: Jeff Xu<jeffxu@chromium.org>
> >> > > ---
> >> > >  security/selinux/Kconfig | 10 ++++++++++
> >> > >  security/selinux/avc.c   |  9 +++++++++
> >> > >  2 files changed, 19 insertions(+)
> >> >
> >> > I'm sorry, but I can't accept this into the upstream kernel.
> >> > Permissive mode, both per-domain and system-wide, is not intended to
> >> > be a long term solution.  Permissive mode should really only be used
> >> > as a development tool or emergency "hotfix" with the proper solution
> >> > being either an adjustment of the existing policy (SELinux policy
> >> > booleans, labeling changes, etc.) or the development of a new policy
> >> > module which better fits your use case.
> >>
> >> Thanks for the response.
> >> For a system that wants to control a few daemons, is there a
> >> recommended pattern from selinux ?
>
> That is effectively a "targeted" policy model. You target a selection of
> entities and everything else is "unconfined" (ie not targeteed).
>
> An "unconfined" domain is just a process type that has many allow rules
> associated with it making it effectively similar to an "permissive"
> domain. The difference is that since "unconfined" domains have full
> access there should not be any AVC denials (nothing is blocked by
> SELinux because the policy does not target the entity)
>
> The stock policy enforced in Red Hat based distributions is a "targeted"
> policy model for example. The unconfined_t domain is one of various
> "unconfined" domains (other examples are unconfined_service_t but
> effectively any type could be made unconfined by simply allowing all accesses.
>
> >
> > Guidance on how to write a SELinux policy for an application is a bit
> > beyond what I have time for in this email, but others on this mailing
> > list might be able to help.  There has definitely been a lot written
> > on the subject, both available online and offline.  My suggestion
> > would be to start "small" with a single SELinux domain for the
> > application and a single type for any configuration, data, or log
> > files it might need; get this initial domain working properly and then
> > you can add increasing levels of access control granularity until
> > you've met your security requirements.  If you've never done this
> > before, go slow, the start might be challenging as you get used to the
> > tools, but you can do it :)
> >
> >> I read this blog about unconfined domain (unconfined_t), maybe this is one way ?
> >> https://wiki.gentoo.org/wiki/SELinux/Tutorials/What_is_this_unconfined_thingie_and_tell_me_about_attributes
> >
> > It is important to remember that an unconfined domain is, as the name
> > would imply, effectively unconfined by SELinux.  Perhaps this is what
> > you want, but generally speaking if you are running SELinux it is
> > because you have a need or desire for additional access controls
> > beyond the legacy Linux discretionary access controls.
> >
> >> I have two questions on unconfined domain:
> >> 1> Is unconfined_t domain supported in SECURITY_SELINUX_DEVELOP=n mode ?
> >
> > Yes.  The SECURITY_SELINUX_DEVELOP kernel build configuration only
> > enables the admin to boot the kernel initially in permissive mode
> > and/or determine the SELinux mode using the "enforcing=X" kernel
> > command line option and a sysfs/securityfs tunable under
> > /sys/fs/selinux/enforce.  The unconfined_t domain is defined purely in
> > the SELinux policy and not the kernel; you could write a SELinux
> > policy without it you wanted, or you could grant unconfined_t-like
> > permissions to multiple different domains in your policy.  It's been a
> > while since I played with it, but I believe the SELinux reference
> > policy (refpol) provides a macro interface to define an arbitrary
> > domain with unconfined_t-like permissions.
> >
> >> 2> will unconfined_t domain log also as permissive domain ?
> >
> > The intent of the unconfined_t domain is that there would be no access
> > denials due to SELinux and thus no AVC audit records related to the
> > unconfined_t domain.  It is not permissive in the sense of the SELinux
> > "mode" (enforcing/permissive/disabled), but it is permissive in the
> > sense that it is given a large number of permissions.
>
> --
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> Dominick Grift

Thanks for details about the unconfined_t domain, this is one option.

IMHO: between permissive domain + audit log and unconfined_t, there might
be room for letting each permissive domain decide its own audit logging
strategy. The reasons are:

1> For a system that have many daemons, a lot of those are not actively
worked by devs, relying on tests is not sufficient to discover all possible
legitimate accesses  at runtime, dev won't be comfortable to enable enforced
mode without some bake time in production, this is where permissive + audit log
helps.

2> The set back of "permissive + audit log" is that one daemon might generate
too much log in production, set to unconfined_t is one option, but
then dev revert
the progress made so far with permissive mode.

3> For a system that is on continuous delivery pipeline, during the phase of
development of selinux policy, daemon owner might need permissive + audit log
in testing, but permissive - audit log in production. This is where
the per-domain
audit log can help, it would be even nicer if this can be controlled
at runtime,
similar to sysctl.

Best regards,
Jeff

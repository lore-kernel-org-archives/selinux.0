Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6139EC636D4
	for <selinux@archiver.kernel.org>; Mon, 13 Feb 2023 05:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBMFoo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Feb 2023 00:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBMFol (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Feb 2023 00:44:41 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E27DBE3
        for <selinux@vger.kernel.org>; Sun, 12 Feb 2023 21:44:39 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-15f97c478a8so13976716fac.13
        for <selinux@vger.kernel.org>; Sun, 12 Feb 2023 21:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Mzb9OLk0H5wsqnYAWEPBm2V4Wzgj19nqBPGqD7+h50=;
        b=lkpJCIThn7mPsDI4kJAetTwZ6DdkEiWpPCF8KNsaiC2boFmmwuSm+aH2BQ0uU+x4kd
         1Y3SSVcZcEIDTij/ajEJXQ68rJU5bED3+Rh77kRkZf9BDs68WDCkWNiapKnS/6B5TWtH
         0RUiMbzJ590tcIro9wkVhGpbwSKha95z/QabY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Mzb9OLk0H5wsqnYAWEPBm2V4Wzgj19nqBPGqD7+h50=;
        b=p0SMYXpuNCz9EM3nCtZv2GMq9XfY3cChEG4UOUXntNxGbOBQLdCoSniyBRBv4W+/7h
         tA72qok6RqwOq1te2Dm+Lcup4PKC7MbUNYURvIF1nE6XXxsahKbnZf+atXS11gxwaYAZ
         76yJHHlmTQUQG3LWErkckzgUkBCggRheA6kw2ScTzZNLW5fmT1K9RjOdyyOxud2NpQsO
         MM2lVl5RhXqizsyiuECVOD57CS/Ib9YABGwKy2gvzOI/RdolhrqCglxRMPO8MDux2BMb
         VTzqkR7z+TzdVIHca4irPREgbGtyV2MzaUmyj0iIIZYtclbFg0vFLyXAN76szBGjfGWi
         VaIQ==
X-Gm-Message-State: AO0yUKUN8XjDDOcZstTEWruzwfNRRzZh2M/c3EzJJSuTmiiRLx6XLlzQ
        kiD5PmBX7eEJars3DmWeW/sSMB0DZpDdY4FNfIHnWA==
X-Google-Smtp-Source: AK7set84jiH/k/DY52BPTg8xJNgfhAhjAUHPA4CrLVDfim5cdIdpSq3SJhKjGpldEXl4AmcSMiQ0gy/F/UEYVtNa9ZM=
X-Received: by 2002:a05:6870:15c5:b0:163:319f:d28 with SMTP id
 k5-20020a05687015c500b00163319f0d28mr2961099oad.265.1676267078801; Sun, 12
 Feb 2023 21:44:38 -0800 (PST)
MIME-Version: 1.0
References: <20220921185426.1663357-1-jeffxu@chromium.org> <20220921185426.1663357-2-jeffxu@chromium.org>
 <CAHC9VhS-jv5cpSdq7dxFGYH=z=5grQceNMyjroeL2KHdrVUV6g@mail.gmail.com>
 <CABi2SkXRxomrYn-xUf3B+XswmQjXZUJXmYJECmr_nBfrZWwqkA@mail.gmail.com>
 <CAHC9VhRuUZxdsVQftqWa0zEuNAxk8ur0-TZp5KecJ537hRONRQ@mail.gmail.com> <875yhe6ial.fsf@defensec.nl>
In-Reply-To: <875yhe6ial.fsf@defensec.nl>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Sun, 12 Feb 2023 21:44:27 -0800
Message-ID: <CABi2SkXU+C77PqXnH_OHs9rjsiOQAHMmkDF5H9EYkU=ZG_tNrg@mail.gmail.com>
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
It seems that my system doesn't have unconfined_t, so
I am trying to get an example.

Can I use a wildcard, something like below ?
type unconfined_t
allow unconfined_t *

An example would be appreciated.

Thanks!
-Jeff



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

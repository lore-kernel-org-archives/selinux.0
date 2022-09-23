Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3C9C04A95
	for <selinux@archiver.kernel.org>; Fri, 23 Sep 2022 18:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbiIWSIQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Sep 2022 14:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiIWSHx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Sep 2022 14:07:53 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F112147F37
        for <selinux@vger.kernel.org>; Fri, 23 Sep 2022 11:05:36 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id n83so738282oif.11
        for <selinux@vger.kernel.org>; Fri, 23 Sep 2022 11:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=bpT+eOiJl+cyU9eJqXUypqFlFRt6ud1Md4OM97/rk+w=;
        b=R1GJB+AouAk3pawmDZ0oHCpDvF2g72CrphB9ks9XpPepbQTg+LhSYpQzutk2kWCUPF
         q9d9GM3w3AhoWmAzeb0SAg/G+MVGpoQBC5j59VKqq3f5KCnbeKq/DjYYEvit2nThI/qa
         WOv77a4Su9yqpI/eHfK6SxW+72qlEImdoiKL9rsweB1KYRXZS2Vghkql98hp3fy1h51g
         QX3OJfKC+bWxrPDhgGsamQ1ntytNKZmMY0lIl1Zl+4IVX7x6kORCG52rSh5TG2TtM2Bl
         zx4kbSx9k9J9JHJQaTZXV1KoddU/PgvMXDHeMoR2gvZ28OwvmNG2Qgqn4xiudzHDBwdT
         e5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=bpT+eOiJl+cyU9eJqXUypqFlFRt6ud1Md4OM97/rk+w=;
        b=fOk44tsCspu5CRqbyzmX0pGZ09HZLwla97f7YeBxFlimnFTtOm4Nj0qdi7loupo6LZ
         rFvT8IUI0Yv1/74xg5yPkgTG0t2ArvvmQYvWbNp/cOTbSRBuPATc2l4vUe0Mspwb26p0
         L9TtT1Vj/xWagEEGnkoLLugQnn5GCEBmxVLZ2dJrinEDS4antB1zI4JfYI9xbh0J2F+R
         hq6xckIIh5jFfzOzntGiRfbhhgDLsFF08wxQSUwYiWEs4Bq4I7NGQDmqlPc14qeRP92p
         vVF+CAofNcRyJtMSNsDCooMPXOkLDoLeDEwODe2dMfSQXl6ky1BdUsakpH3rEK96WEtJ
         fSqQ==
X-Gm-Message-State: ACrzQf3jVlXPJ8RB4uCiHPMXg/yhoJGyAmPeph156hbtYOHhB5hE8l9/
        LXgErrI0Fpve2DRQFU1w3RLbWNF2E9aPrt4U8NwA
X-Google-Smtp-Source: AMsMyM4mR82f6R8iww4Osb/fvO7jmXvCZjnpt/uKLpsrrzJMhmC+8prTDqSV8MOeLfQE1+xw29NrA4Ojovbz9PbawEY=
X-Received: by 2002:a05:6808:144b:b0:350:a06a:f8cb with SMTP id
 x11-20020a056808144b00b00350a06af8cbmr9597052oiv.51.1663956300241; Fri, 23
 Sep 2022 11:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220921185426.1663357-1-jeffxu@chromium.org> <20220921185426.1663357-2-jeffxu@chromium.org>
 <CAHC9VhS-jv5cpSdq7dxFGYH=z=5grQceNMyjroeL2KHdrVUV6g@mail.gmail.com> <CABi2SkXRxomrYn-xUf3B+XswmQjXZUJXmYJECmr_nBfrZWwqkA@mail.gmail.com>
In-Reply-To: <CABi2SkXRxomrYn-xUf3B+XswmQjXZUJXmYJECmr_nBfrZWwqkA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 23 Sep 2022 14:04:49 -0400
Message-ID: <CAHC9VhRuUZxdsVQftqWa0zEuNAxk8ur0-TZp5KecJ537hRONRQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add CONFIG_SECURITY_SELINUX_PERMISSIVE_DONTAUDIT
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        jorgelo@chromium.org, groeck@chromium.org,
        Luis Hector Chavez <lhchavez@google.com>,
        Luis Hector Chavez <lhchavez@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 23, 2022 at 1:43 PM Jeff Xu <jeffxu@chromium.org> wrote:
> On Wed, Sep 21, 2022 at 12:11 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Sep 21, 2022 at 2:54 PM <jeffxu@chromium.org> wrote:
> > >
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > When SECURITY_SELINUX_DEVELOP=y and the system is running in permissive
> > > mode, it is useful to disable logging from permissive domain, so audit
> > > log does not get spamed.
> > >
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > Signed-off-by: Luis Hector Chavez <lhchavez@google.com>
> > > Tested-by: Luis Hector Chavez <lhchavez@chromium.org>
> > > Tested-by: Jeff Xu<jeffxu@chromium.org>
> > > ---
> > >  security/selinux/Kconfig | 10 ++++++++++
> > >  security/selinux/avc.c   |  9 +++++++++
> > >  2 files changed, 19 insertions(+)
> >
> > I'm sorry, but I can't accept this into the upstream kernel.
> > Permissive mode, both per-domain and system-wide, is not intended to
> > be a long term solution.  Permissive mode should really only be used
> > as a development tool or emergency "hotfix" with the proper solution
> > being either an adjustment of the existing policy (SELinux policy
> > booleans, labeling changes, etc.) or the development of a new policy
> > module which better fits your use case.
>
> Thanks for the response.
> For a system that wants to control a few daemons, is there a
> recommended pattern from selinux ?

Guidance on how to write a SELinux policy for an application is a bit
beyond what I have time for in this email, but others on this mailing
list might be able to help.  There has definitely been a lot written
on the subject, both available online and offline.  My suggestion
would be to start "small" with a single SELinux domain for the
application and a single type for any configuration, data, or log
files it might need; get this initial domain working properly and then
you can add increasing levels of access control granularity until
you've met your security requirements.  If you've never done this
before, go slow, the start might be challenging as you get used to the
tools, but you can do it :)

> I read this blog about unconfined domain (unconfined_t), maybe this is one way ?
> https://wiki.gentoo.org/wiki/SELinux/Tutorials/What_is_this_unconfined_thingie_and_tell_me_about_attributes

It is important to remember that an unconfined domain is, as the name
would imply, effectively unconfined by SELinux.  Perhaps this is what
you want, but generally speaking if you are running SELinux it is
because you have a need or desire for additional access controls
beyond the legacy Linux discretionary access controls.

> I have two questions on unconfined domain:
> 1> Is unconfined_t domain supported in SECURITY_SELINUX_DEVELOP=n mode ?

Yes.  The SECURITY_SELINUX_DEVELOP kernel build configuration only
enables the admin to boot the kernel initially in permissive mode
and/or determine the SELinux mode using the "enforcing=X" kernel
command line option and a sysfs/securityfs tunable under
/sys/fs/selinux/enforce.  The unconfined_t domain is defined purely in
the SELinux policy and not the kernel; you could write a SELinux
policy without it you wanted, or you could grant unconfined_t-like
permissions to multiple different domains in your policy.  It's been a
while since I played with it, but I believe the SELinux reference
policy (refpol) provides a macro interface to define an arbitrary
domain with unconfined_t-like permissions.

> 2> will unconfined_t domain log also as permissive domain ?

The intent of the unconfined_t domain is that there would be no access
denials due to SELinux and thus no AVC audit records related to the
unconfined_t domain.  It is not permissive in the sense of the SELinux
"mode" (enforcing/permissive/disabled), but it is permissive in the
sense that it is given a large number of permissions.

-- 
paul-moore.com

Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E6AC05027
	for <selinux@archiver.kernel.org>; Fri, 17 Feb 2023 15:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjBQPWR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Feb 2023 10:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBQPWR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Feb 2023 10:22:17 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AA364B1A;
        Fri, 17 Feb 2023 07:22:16 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id s4-20020a17090a764400b002349a303ca5so1614064pjl.4;
        Fri, 17 Feb 2023 07:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1wEOMsasOhS47qE3rNjEQb/LVxoxsXh6436IuIt+VRU=;
        b=nN0QSMXFiGuu4ePHZ6sZmwLNPqPKGbu/t+mzu9GRGknl5DrAbh/rYVsrSfwGheEIke
         txDcui+sde+KCXjH1AGqQ/hm34cbLdQsxm86aPaQaRH2o5zVgvB9VIsFuZo2uxATVYwT
         pH27bqHgX9lxTm7QXdWmiGeN25DigvtYQbAcguLiUB4HDUrtrneWzY/Bx0J1GU8gomQP
         U3x6OxVeuVkyoyDBPH+2kXsZGi+xXOlItxhKpAGMn5aBjuI7eKaT64GQh/k8b3G4jMyc
         TEdW+7naOzXnse1JFF1DQ9KhbmMD9HwvXYTvc7gTANQikNQXfmPlg9M9Sb2Ve6FQSA/K
         EG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wEOMsasOhS47qE3rNjEQb/LVxoxsXh6436IuIt+VRU=;
        b=kpB8XNU1l1ZIjIRnNs5OI5V2RqYbN/nWHcrG1VCBce3MK+uceFAvOUr1WyUYR4yYs4
         tsvqOJuqLc8y/tJJDxKxZm43nzHwJD3T4cd3KpcxqZg+Wd2Wfls3b7w1x3pwYgreWtTe
         J2Gj8wYTLKpapeLutngY36cvnE4r/k1X+JKxjUDUVhsJaFemo81CVIh7MBsE5oPdtiz4
         fX/N/N3P4Fdrz64RLwfKu3DJaPhtGtNtBo5OFzBlfEa2hULiKUaFQ1Gz0FJ9YNnMkEe1
         4ZF/jVlAoht6D2qi8OHcY1PZ2wnTByUM6x6L9I0ts3fwNmJX+lXyn7DzqTFABrcPY5p3
         Mw7g==
X-Gm-Message-State: AO0yUKVSFC6ogosyLLEumxvNJVmp1JjWtnORz6hhM1wxIddOeqfw53jN
        YeyAKFOP9aYmvBNwA7y6NNE7+hqMLM5H9ZAa0e0=
X-Google-Smtp-Source: AK7set9MUraNZP423mBCkcUyajqvPmhITkD0L/HyhJZ6SXYTPF17pP6m1TSpLHeLPoC5Pr0rg/P2L0652Mf2R+5Ajtg=
X-Received: by 2002:a17:90b:2252:b0:233:f6f9:df37 with SMTP id
 hk18-20020a17090b225200b00233f6f9df37mr1422859pjb.138.1676647335819; Fri, 17
 Feb 2023 07:22:15 -0800 (PST)
MIME-Version: 1.0
References: <20220921185426.1663357-1-jeffxu@chromium.org> <20220921185426.1663357-2-jeffxu@chromium.org>
 <CAHC9VhS-jv5cpSdq7dxFGYH=z=5grQceNMyjroeL2KHdrVUV6g@mail.gmail.com>
 <CABi2SkXRxomrYn-xUf3B+XswmQjXZUJXmYJECmr_nBfrZWwqkA@mail.gmail.com>
 <CAHC9VhRuUZxdsVQftqWa0zEuNAxk8ur0-TZp5KecJ537hRONRQ@mail.gmail.com>
 <875yhe6ial.fsf@defensec.nl> <CABi2SkXU+C77PqXnH_OHs9rjsiOQAHMmkDF5H9EYkU=ZG_tNrg@mail.gmail.com>
In-Reply-To: <CABi2SkXU+C77PqXnH_OHs9rjsiOQAHMmkDF5H9EYkU=ZG_tNrg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 17 Feb 2023 10:22:04 -0500
Message-ID: <CAEjxPJ43nNKG4QEKK5W2_K_TGeUjyUywvsqiPipT8Pom5VNMxw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add CONFIG_SECURITY_SELINUX_PERMISSIVE_DONTAUDIT
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        groeck@chromium.org, Luis Hector Chavez <lhchavez@google.com>,
        Luis Hector Chavez <lhchavez@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 13, 2023 at 1:02 AM Jeff Xu <jeffxu@chromium.org> wrote:
>
> On Fri, Sep 23, 2022 at 11:45 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
> >
> > Paul Moore <paul@paul-moore.com> writes:
> >
> > > On Fri, Sep 23, 2022 at 1:43 PM Jeff Xu <jeffxu@chromium.org> wrote:
> > >> On Wed, Sep 21, 2022 at 12:11 PM Paul Moore <paul@paul-moore.com> wrote:
> > >> > On Wed, Sep 21, 2022 at 2:54 PM <jeffxu@chromium.org> wrote:
> > >> > >
> > >> > > From: Jeff Xu <jeffxu@chromium.org>
> > >> > >
> > >> > > When SECURITY_SELINUX_DEVELOP=y and the system is running in permissive
> > >> > > mode, it is useful to disable logging from permissive domain, so audit
> > >> > > log does not get spamed.
> > >> > >
> > >> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > >> > > Signed-off-by: Luis Hector Chavez <lhchavez@google.com>
> > >> > > Tested-by: Luis Hector Chavez <lhchavez@chromium.org>
> > >> > > Tested-by: Jeff Xu<jeffxu@chromium.org>
> > >> > > ---
> > >> > >  security/selinux/Kconfig | 10 ++++++++++
> > >> > >  security/selinux/avc.c   |  9 +++++++++
> > >> > >  2 files changed, 19 insertions(+)
> > >> >
> > >> > I'm sorry, but I can't accept this into the upstream kernel.
> > >> > Permissive mode, both per-domain and system-wide, is not intended to
> > >> > be a long term solution.  Permissive mode should really only be used
> > >> > as a development tool or emergency "hotfix" with the proper solution
> > >> > being either an adjustment of the existing policy (SELinux policy
> > >> > booleans, labeling changes, etc.) or the development of a new policy
> > >> > module which better fits your use case.
> > >>
> > >> Thanks for the response.
> > >> For a system that wants to control a few daemons, is there a
> > >> recommended pattern from selinux ?
> >
> > That is effectively a "targeted" policy model. You target a selection of
> > entities and everything else is "unconfined" (ie not targeteed).
> >
> > An "unconfined" domain is just a process type that has many allow rules
> > associated with it making it effectively similar to an "permissive"
> > domain. The difference is that since "unconfined" domains have full
> > access there should not be any AVC denials (nothing is blocked by
> > SELinux because the policy does not target the entity)
> >
> It seems that my system doesn't have unconfined_t, so
> I am trying to get an example.
>
> Can I use a wildcard, something like below ?
> type unconfined_t
> allow unconfined_t *
>
> An example would be appreciated.

If your policy in Android-based, then the su domain would be the
easiest starting point. It isn't quite what you want (a permissive
domain with dontaudit rules that suppress all denials, only included
in userdebug or eng builds) but if you replace "dontaudit" with allow
everywhere, it would be "unconfined".

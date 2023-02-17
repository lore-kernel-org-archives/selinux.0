Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3469BC05027
	for <selinux@archiver.kernel.org>; Fri, 17 Feb 2023 15:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjBQPZO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Feb 2023 10:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBQPZN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Feb 2023 10:25:13 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CF56EF38;
        Fri, 17 Feb 2023 07:25:12 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id i15so3185924plr.8;
        Fri, 17 Feb 2023 07:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/TuSHwSh6cpq418uBzu/wPjz1VVl5VfqZYSursDKJLs=;
        b=jYYFyR6j6y2Auzp5Hq7jPFPL4qrtLxaMCnayJTgx5MnOBnt05aEqscigSxuAK/TaLj
         AhjCTNs9983HjAKAz92XfFyEXlOJTXs2RXR1tHrYrHeL+yyMXQeshBs7koWycQjOJsbw
         z08A9XlmjzR7JaiTIMTBK4YL99B0SdGnbmMc6mah+kmL+BM/r8txMSu58xa4PMy8jv3r
         vRrx6RYDC4hqOxwFr5Lah1KUer1+cfAU5lFcLwtrf87rLyRn7OaeeDOB0d20O80478Ca
         Uc/rsGp4SRRbl8NPxtkcbYcar5BNFEmxWvoKMYhLWFLuNftD+/cvnNusufiXM7bZlq/n
         LGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/TuSHwSh6cpq418uBzu/wPjz1VVl5VfqZYSursDKJLs=;
        b=cgSGu0PIBG5HpO0JEV+HZgQmBsW9WhNoeq8K2sbpPYawLHoQqADvy0hRgiGjgIdeC2
         WcSHEiO0tCKgk3P8Ep59jN0rOLvjlMOinBZcMQQ6Z2Yprjoib9qWix9jGi3JazjlDry2
         VaElxLO4XI4f9DhOhMOv+1IxtmKCdPEe7GEn0VNeHL/htuZeic0UdCKtSXFzBRGHeXMP
         BWI1SDTNmEE6AvQ34gVzV12dH/FfR+CrFDrpkIuESsvXsvuodVp8QwlKNtuqb2i0NENg
         F01u8Tn/ctJgqHmr0X2qYqI65aVyz9Fg3+5HEsjE1hiUFZV95KM14bYtgH4kTmxF1Z4+
         bO0g==
X-Gm-Message-State: AO0yUKU1crPSjc1wyZj9RcvZQ8uoBSXnhnUIMnNEGbgXFOf4jz5zhIpO
        rwTjM0LdTdG9XgDfZeAv5Nasa4tpivMhtLE9160=
X-Google-Smtp-Source: AK7set9qfhlgbNlQ4lHX7JwIb4Xk4PMZq9SQxACxD/SicuJ1LHVwtMNzlsAcAxzZ+vp3nozVVek+/XW0o2SqQE9KfWw=
X-Received: by 2002:a17:90b:2252:b0:233:f6f9:df37 with SMTP id
 hk18-20020a17090b225200b00233f6f9df37mr1424816pjb.138.1676647511917; Fri, 17
 Feb 2023 07:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20220921185426.1663357-1-jeffxu@chromium.org> <20220921185426.1663357-2-jeffxu@chromium.org>
 <CAHC9VhS-jv5cpSdq7dxFGYH=z=5grQceNMyjroeL2KHdrVUV6g@mail.gmail.com>
 <CABi2SkXRxomrYn-xUf3B+XswmQjXZUJXmYJECmr_nBfrZWwqkA@mail.gmail.com>
 <CAHC9VhRuUZxdsVQftqWa0zEuNAxk8ur0-TZp5KecJ537hRONRQ@mail.gmail.com>
 <875yhe6ial.fsf@defensec.nl> <CABi2SkXU+C77PqXnH_OHs9rjsiOQAHMmkDF5H9EYkU=ZG_tNrg@mail.gmail.com>
 <CAEjxPJ43nNKG4QEKK5W2_K_TGeUjyUywvsqiPipT8Pom5VNMxw@mail.gmail.com>
In-Reply-To: <CAEjxPJ43nNKG4QEKK5W2_K_TGeUjyUywvsqiPipT8Pom5VNMxw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 17 Feb 2023 10:25:00 -0500
Message-ID: <CAEjxPJ5_K7mxCbDGErQdoULA5n7pu1FP0y0cFq-NZAO6aQDiaQ@mail.gmail.com>
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

On Fri, Feb 17, 2023 at 10:22 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Feb 13, 2023 at 1:02 AM Jeff Xu <jeffxu@chromium.org> wrote:
> >
> > On Fri, Sep 23, 2022 at 11:45 AM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> > >
> > > Paul Moore <paul@paul-moore.com> writes:
> > >
> > > > On Fri, Sep 23, 2022 at 1:43 PM Jeff Xu <jeffxu@chromium.org> wrote:
> > > >> On Wed, Sep 21, 2022 at 12:11 PM Paul Moore <paul@paul-moore.com> wrote:
> > > >> > On Wed, Sep 21, 2022 at 2:54 PM <jeffxu@chromium.org> wrote:
> > > >> > >
> > > >> > > From: Jeff Xu <jeffxu@chromium.org>
> > > >> > >
> > > >> > > When SECURITY_SELINUX_DEVELOP=y and the system is running in permissive
> > > >> > > mode, it is useful to disable logging from permissive domain, so audit
> > > >> > > log does not get spamed.
> > > >> > >
> > > >> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > >> > > Signed-off-by: Luis Hector Chavez <lhchavez@google.com>
> > > >> > > Tested-by: Luis Hector Chavez <lhchavez@chromium.org>
> > > >> > > Tested-by: Jeff Xu<jeffxu@chromium.org>
> > > >> > > ---
> > > >> > >  security/selinux/Kconfig | 10 ++++++++++
> > > >> > >  security/selinux/avc.c   |  9 +++++++++
> > > >> > >  2 files changed, 19 insertions(+)
> > > >> >
> > > >> > I'm sorry, but I can't accept this into the upstream kernel.
> > > >> > Permissive mode, both per-domain and system-wide, is not intended to
> > > >> > be a long term solution.  Permissive mode should really only be used
> > > >> > as a development tool or emergency "hotfix" with the proper solution
> > > >> > being either an adjustment of the existing policy (SELinux policy
> > > >> > booleans, labeling changes, etc.) or the development of a new policy
> > > >> > module which better fits your use case.
> > > >>
> > > >> Thanks for the response.
> > > >> For a system that wants to control a few daemons, is there a
> > > >> recommended pattern from selinux ?
> > >
> > > That is effectively a "targeted" policy model. You target a selection of
> > > entities and everything else is "unconfined" (ie not targeteed).
> > >
> > > An "unconfined" domain is just a process type that has many allow rules
> > > associated with it making it effectively similar to an "permissive"
> > > domain. The difference is that since "unconfined" domains have full
> > > access there should not be any AVC denials (nothing is blocked by
> > > SELinux because the policy does not target the entity)
> > >
> > It seems that my system doesn't have unconfined_t, so
> > I am trying to get an example.
> >
> > Can I use a wildcard, something like below ?
> > type unconfined_t
> > allow unconfined_t *
> >
> > An example would be appreciated.
>
> If your policy in Android-based, then the su domain would be the
> easiest starting point. It isn't quite what you want (a permissive
> domain with dontaudit rules that suppress all denials, only included
> in userdebug or eng builds) but if you replace "dontaudit" with allow
> everywhere, it would be "unconfined".

BTW SELinux already has a way to achieve the same end as your kernel
patch without any code changes; there are dontaudit rules in policy
that can silence denials and you just need to write them to cover all
classes/permissions. This is done in the Android su policy.

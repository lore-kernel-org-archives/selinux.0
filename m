Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3E1C43603
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 18:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08422214AF
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 18:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="l6mAR3pP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbfLLSSj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:18:39 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35105 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbfLLSSj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 13:18:39 -0500
Received: by mail-lf1-f66.google.com with SMTP id 15so2432294lfr.2
        for <selinux@vger.kernel.org>; Thu, 12 Dec 2019 10:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ufyhv/3B6D+/oDJQwUlDy3Tm9K3/jCvlvAqmRXp31Rk=;
        b=l6mAR3pPUcLsE4rxn4KIJbroNxmmXnKIq8FI3Ao1NXVXru5hK8vXkE1taF4Gib6ywg
         2PymxgBDEYVqG3dnuyKD7hPsogJ0naz76Fn82rUXZAu5bniqVKvQV+Pr7sFJDtoEWaXK
         +zktzhp1QfINqMWG1Sb8IP8Ql9HudG2DlXx/rSSjDWELAvKoWfib0rcTCauaqAxaZzKW
         4o223+2+yC5S0be6MTrS7mIOY6tXsuKeA21ryz2dOqOPea5QhEQFBAZLn+sZj/4mxp80
         aSe/ozwbXGE5Y2SNvtnGwOMY5vbzQ0J3wwEq9wIFRQpgrCoCnt2/0w0+nA96fEkSfRvY
         g8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ufyhv/3B6D+/oDJQwUlDy3Tm9K3/jCvlvAqmRXp31Rk=;
        b=UTvaZ1VyLEhNliy/m+J127lXEzeeSJTUcNko5rbx90DwpBAau3Tzj73qTuN3vB0qbP
         ItIankiJJVZFWEFaZVFZ6DXvMys5k/bXu0oq0nM70SngAOgSW6gdAZGWBJd8ZvC1HYry
         3VorghX+uiTCJxAWS+5pNQVmfVLssX2YCROHCcicObwqJTaT/JjBRjfDaHRTAZtQHq6L
         QxcC5a1vJtzIBq/grDfmUkUv9hfPtWXQgVh4xseQh/NPRuiPXQrjA0PPxsFECSWFkT46
         A2cA1vbfxwX98850080/9d9NuQT6iqIQRciP8qzVJJsR/8y2jBT2HVs+AjHd8L3OjRNq
         /ZZA==
X-Gm-Message-State: APjAAAVLV1O/du375DmjBSEhV/kiqvsh87nIc5EudLug02KWVYnF88T5
        Dk3lEESWRgvAYu+eHbJ3pjSFP0532GhQT73+L+jQ
X-Google-Smtp-Source: APXvYqwsAkFa7mEMIprLOOAKyEBq8+h0Yx53yfTgZZTjTrbOqnUTsyKiEU5gQK7ylKxTga2e7rFgvAtQac9agTyeLEI=
X-Received: by 2002:a19:4a12:: with SMTP id x18mr6512735lfa.158.1576174716823;
 Thu, 12 Dec 2019 10:18:36 -0800 (PST)
MIME-Version: 1.0
References: <20191211140833.939845-1-omosnace@redhat.com> <677be2d4-8247-3c2b-ac13-def725cffaeb@tycho.nsa.gov>
 <201912110840.62A4E64BA@keescook> <356c555a-d4ab-84fb-0165-f7672bc1ee63@schaufler-ca.com>
 <2fdb09e7-6668-cb1b-8a2d-1550278ae803@tycho.nsa.gov> <CAFqZXNtjELoG_5GK5c4XpH8Be3NfsKMZdZvrJKPpnTLPKKgZ9A@mail.gmail.com>
 <1f613260-d315-6925-d069-e92b872b8610@tycho.nsa.gov> <CAHC9VhT_CBQN+aFWjpPixi9Ok3Z7bQ-053AHg4pvqVtn-RdVVA@mail.gmail.com>
 <0f0778af-73c2-3c75-30c0-da5eae203032@tycho.nsa.gov> <CAHC9VhT24b6YYTcE-h9pS9HnJ35unW_14EYLcNBBd-xUa=1L9A@mail.gmail.com>
 <83d047ce-0ca0-4152-1da7-32798c500aab@tycho.nsa.gov>
In-Reply-To: <83d047ce-0ca0-4152-1da7-32798c500aab@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Dec 2019 13:18:25 -0500
Message-ID: <CAHC9VhQG9zZEL53XRdLHdmFJDpg8qAd9p61Xkm5AdSgM=-5eAg@mail.gmail.com>
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
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

On Thu, Dec 12, 2019 at 1:10 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 12/12/19 1:09 PM, Paul Moore wrote:
> > On Thu, Dec 12, 2019 at 12:57 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> On 12/12/19 12:54 PM, Paul Moore wrote:
> >>> On Thu, Dec 12, 2019 at 8:14 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>>> On 12/12/19 6:49 AM, Ondrej Mosnacek wrote:
> >>>>> On Wed, Dec 11, 2019 at 8:12 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>>>>> On 12/11/19 1:35 PM, Casey Schaufler wrote:
> >>>>>>> On 12/11/2019 8:42 AM, Kees Cook wrote:
> >>>>>>>> On Wed, Dec 11, 2019 at 09:29:10AM -0500, Stephen Smalley wrote:
> >>>>>>>>> On 12/11/19 9:08 AM, Ondrej Mosnacek wrote:
> >>>
> >>> ...
> >>>
> >>>>>> selinux_state.initialized reflects whether a policy has
> >>>>>> been loaded.  With a few exceptions in certain hook functions, it is
> >>>>>> only checked by the security server service functions
> >>>>>> (security/selinux/ss/services.c) prior to accessing the policydb.  So
> >>>>>> there is a lot of SELinux processing that would still occur in that
> >>>>>> situation unless we added if (!selinux_state.initialized) return 0;
> >>>>>> checks to all the hook functions, which would create the same exposure
> >>>>>> and would further break the SELinux-enabled case (we need to perform
> >>>>>> some SELinux processing pre-policy-load to allocate blobs and track what
> >>>>>> tasks and objects require delayed security initialization when policy
> >>>>>> load finally occurs).
> >>>>>
> >>>>> I think what Casey was suggesting is to add another flag that would
> >>>>> switch from "no policy loaded, but we expect it to be loaded
> >>>>> eventually" to "no policy loaded and we don't expect/allow it to be
> >>>>> loaded any more", which is essentially equivalent to checking
> >>>>> selinux_enabled in each hook, which you had already brought up.
> >>>>
> >>>> Yep.  if (!selinux_enabled) return 0; or if (selinux_state.disabled)
> >>>> return 0; under #ifdef CONFIG_SECURITY_SELINUX_DISABLE in every hook
> >>>> might be the best option until it can be removed altogether; avoids
> >>>> impacting the LSM framework or any other security module, preserves the
> >>>> existing functionality, fairly low overhead on the SELinux-disabled case.
> >>>
> >>> Just so I'm understanding this thread correctly, the above change
> >>> (adding enabled checks to each SELinux hook implementation) is only
> >>> until Fedora can figure out a way to deprecate and remove the runtime
> >>> disable?
> >>
> >> That's my understanding.  In the interim, Android kernels should already
> >> be disabling CONFIG_SECURITY_SELINUX_DISABLE and other distros may
> >> choose to disable it as long as they don't care about supporting SELinux
> >> runtime disable.
> >
> > Okay, I just wanted to make sure I wasn't missing something.
> > Honestly, I'd rather Fedora just go ahead and do whatever it is they
> > need to do to turn off CONFIG_SECURITY_SELINUX_DISABLE (it sounds like
> > they have a plan and are working on it), I'm not overly excited about
> > temporarily cluttering up the code with additional "enabled" checks
> > when the status quo works, even if it is less than ideal.
>
> The status quo is producing kernel crashes, courtesy of LSM stacking
> changes...

How prevalent are these crashes?

This also only happens when disabling SELinux at runtime, yes?
Something we've advised against for some time now and are working to
eliminate?  Let's just get rid of the runtime disable *soon*, and if
we need a stop-gap fix let's just go with the hook reordering since
that seems to minimize the impact, if not resolve it.

I'm not going to comment on the stacking changes.

-- 
paul moore
www.paul-moore.com

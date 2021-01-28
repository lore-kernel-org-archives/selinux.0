Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2380AC433E0
	for <selinux@archiver.kernel.org>; Thu, 28 Jan 2021 03:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E48816024A
	for <selinux@archiver.kernel.org>; Thu, 28 Jan 2021 03:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhA1Des (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Jan 2021 22:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhA1Def (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Jan 2021 22:34:35 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5DDC061573
        for <selinux@vger.kernel.org>; Wed, 27 Jan 2021 19:33:54 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id b21so4966233edy.6
        for <selinux@vger.kernel.org>; Wed, 27 Jan 2021 19:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lg0aZvX/Z7DG/BSJJpeI6lt7+vzjbMgpBvQcOOM0A9M=;
        b=rXnNgGYgmLL3oBvQhr7H/Xa47h/d32c0XCMJrctZo7OR3DjiOlLrjZLDQdDLUZNRAq
         JGZPdDvFSFb1AW1thMVEcU1sDUL3WjOyuihQ/LOkPBVXn0gh7OX4RVW6R1SDLN3u/D+p
         SEf+S39VyXR6fqt0G3tzpl8NDjvXaIS/JQZ65IDrJFqn/t6bO7dlursPqlJgnjJnlSzo
         22m9OYuZNgP1mUxgjT1TiXj03I2cFz4WrMK3qJip69Qsrto3+Hryk3/1NDds6edBeWcg
         eWKn0X2PGegK+eGqLP/dN0x5Gtnk8HJPHHvDEKajUmNOe3lJaCLmBcjoCRT48Etn7T2p
         OQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lg0aZvX/Z7DG/BSJJpeI6lt7+vzjbMgpBvQcOOM0A9M=;
        b=miM66qKhEw2f3CF/eFmfyk8oae5YTAQ+euUxicCq6GvPkmqL/UE0VgATuzk6OhAsJt
         G+QbNRGmu/KwSldJ7qRZ3gqW9R5SrlOY+HfiMGFwZgx/cdfWhxg8UFbFkppuJp/UeWlA
         di3YskJjOIrz53ZHanP+XlHPlKQWbt3VymJv4wDq6yaG9r7G//a+loKP3yvcrP7Brbf+
         crvjAKfv7KfyxFnzNBdKF14RzQLZ9+nlG2fyKEc5TYQm/ixKhJE7SP/J40S5grDJ4G35
         Ddx6NDsLtyMaYAvATOOyp5HQtj0wHXDC1BNW9dnrJPqMl5m1msMlgE54HPs+o9mton60
         goyA==
X-Gm-Message-State: AOAM533YfltXazInmlYi4mr6FDodR9vEkedbuAt8UDDu0ZklIJV2x5LK
        AbA4kLEJW2NtIkQWPrD77J2nNEf2M++EIFIsdVww
X-Google-Smtp-Source: ABdhPJxzQzlMQINkQGtgusn8x3KlFXQ/4GU7tlgwwblRaGpA95RboHliLDm1HFhptD2hzonh8LpJDVD0O66OR92ZFQo=
X-Received: by 2002:a05:6402:34e:: with SMTP id r14mr12133430edw.269.1611804832864;
 Wed, 27 Jan 2021 19:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20210121200150.2448-1-nramas@linux.microsoft.com>
 <CAHC9VhT13nhaHY3kJZ6ni4rjUffSG-hD5vOfK-q2KfsVFOtaCg@mail.gmail.com> <c61e3ea5-7412-7e39-4d71-945f906d68a3@linux.microsoft.com>
In-Reply-To: <c61e3ea5-7412-7e39-4d71-945f906d68a3@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 27 Jan 2021 22:33:41 -0500
Message-ID: <CAHC9VhS2j4cAqdPtUHzHcc_ShLAP7cndVurcpcLj9G1cAxSMMQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: measure state and policy capabilities
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jan 24, 2021 at 12:04 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
> On 1/22/21 1:21 PM, Paul Moore wrote:

...

> >> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >> index 644b17ec9e63..879a0d90615d 100644
> >> --- a/security/selinux/hooks.c
> >> +++ b/security/selinux/hooks.c
> >> @@ -7407,6 +7408,10 @@ int selinux_disable(struct selinux_state *state)
> >>
> >>          selinux_mark_disabled(state);
> >>
> >> +       mutex_lock(&state->policy_mutex);
> >> +       selinux_ima_measure_state(state);
> >> +       mutex_unlock(&state->policy_mutex);
> >
> > I'm not sure if this affects your decision to include this action in
> > the measurements, but this function is hopefully going away in the not
> > too distant future as we do away with support for disabling SELinux at
> > runtime.
> >
> > FWIW, I'm not sure it's overly useful anyway; you only get here if you
> > never had any SELinux policy/state configured and you decide to
> > disable SELinux instead of loading a policy.  However, I've got no
> > objection to this code.
>
> If support for disabling SELinux at runtime will be removed, then I
> don't see a reason to trigger a measurement here. I'll remove this
> measurement.

It's currently marked as deprecated, see
Documentation/ABI/obsolete/sysfs-selinux-disable.

-- 
paul moore
www.paul-moore.com

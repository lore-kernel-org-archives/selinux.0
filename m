Return-Path: <SRS0=c00g=2D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E5CC50734
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DB824718
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pp6E/4q1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfLMOHT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Dec 2019 09:07:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42120 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727507AbfLMOHT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Dec 2019 09:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576246036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GtpAAXUngtgYkFw9XBgyXXN6Vxm29LZqTreo7QoTI2E=;
        b=Pp6E/4q18iXe14jdfCmowx9iAVQMKW0AzK/PAtO4Ja1uzhIAQzs9DhmeQ20X63EkU+lXIZ
        eOYtQ0XNB5CZBq1/smy0HQ+0lc6cFoIy1kE7rWlXJ6ENhFbuZ1nR2OEr181o/mnMYjrX7B
        gntXyHKx6vbMAe5uoPyJ6l2E25NKmQo=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-l026GU9PPwCvrRzxDsfKvQ-1; Fri, 13 Dec 2019 09:07:15 -0500
X-MC-Unique: l026GU9PPwCvrRzxDsfKvQ-1
Received: by mail-oi1-f198.google.com with SMTP id n196so1346534oig.6
        for <selinux@vger.kernel.org>; Fri, 13 Dec 2019 06:07:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GtpAAXUngtgYkFw9XBgyXXN6Vxm29LZqTreo7QoTI2E=;
        b=dC8AaJCM/V4d75mV8+pw8gOH7LMEqadmzRy6J26VaclARIiVRKlQuvk+VVUuZkZn9K
         ZQkTsyNqsx3fHprFMT76FPE8J0u/aEvpL/zchOH9Ny4HWul85N7gf/Xr5AkfVPHDNVqo
         MSdCmetdPY3jRLXKkpPK7HH8Qy/pQoSQQdPyq26n4RyxKhnkGbj9XF/Z5hgXqJiQxHFq
         lWaows53rS50+Y/BrfUONyicj6sTDqFPNYOw4Op2rgNeBgqJyVnggQHDBdAKbHoJ6iNq
         fklAarby3kWnC/KtPs+9QCKMfivE7WkmQ2e9311Otg4IW+aAThuJ1Rv/XgoD6nI/uk02
         L1wg==
X-Gm-Message-State: APjAAAW0INnTofjb7po4J/x+HpXaXPapXWrJ94Co+mkYXu7szPH70x4a
        GuRUfRowey7o9bU2CACqr8breuvT7TUB5jhxxA9VGCEOBIb3lwfwyfgWaFiC2XeJgPG+6bD/hU1
        4T1QnI4BRqJk6U18gIV2+Z5ZhOkv/wi6lrA==
X-Received: by 2002:a9d:338:: with SMTP id 53mr14958882otv.197.1576246032869;
        Fri, 13 Dec 2019 06:07:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqzyNzYqVZZhHGRz6383lhTLIASK6qDeUA924SmyaZcYjIC5N/DxCgZjGyUkhnMyRVtRrIloD8XfoTS2etYEik8=
X-Received: by 2002:a9d:338:: with SMTP id 53mr14958748otv.197.1576246031342;
 Fri, 13 Dec 2019 06:07:11 -0800 (PST)
MIME-Version: 1.0
References: <20191211140833.939845-1-omosnace@redhat.com> <677be2d4-8247-3c2b-ac13-def725cffaeb@tycho.nsa.gov>
 <201912110840.62A4E64BA@keescook> <356c555a-d4ab-84fb-0165-f7672bc1ee63@schaufler-ca.com>
 <2fdb09e7-6668-cb1b-8a2d-1550278ae803@tycho.nsa.gov> <CAFqZXNtjELoG_5GK5c4XpH8Be3NfsKMZdZvrJKPpnTLPKKgZ9A@mail.gmail.com>
 <1f613260-d315-6925-d069-e92b872b8610@tycho.nsa.gov> <CAHC9VhT_CBQN+aFWjpPixi9Ok3Z7bQ-053AHg4pvqVtn-RdVVA@mail.gmail.com>
 <0f0778af-73c2-3c75-30c0-da5eae203032@tycho.nsa.gov> <CAHC9VhT24b6YYTcE-h9pS9HnJ35unW_14EYLcNBBd-xUa=1L9A@mail.gmail.com>
 <83d047ce-0ca0-4152-1da7-32798c500aab@tycho.nsa.gov> <CAHC9VhQG9zZEL53XRdLHdmFJDpg8qAd9p61Xkm5AdSgM=-5eAg@mail.gmail.com>
 <83af5f0f-d3ec-7827-92e5-2db0997b9d22@tycho.nsa.gov> <CAHC9VhSqNGxqGQU6QfB3SxHZZdtPh79-4vOrpDXLr9zxT_X4bg@mail.gmail.com>
In-Reply-To: <CAHC9VhSqNGxqGQU6QfB3SxHZZdtPh79-4vOrpDXLr9zxT_X4bg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 13 Dec 2019 15:06:59 +0100
Message-ID: <CAFqZXNv7PUgrU9Qe28e3cHnRAwjKZLVmNrOZggvkE5AB7T9o1Q@mail.gmail.com>
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

On Thu, Dec 12, 2019 at 8:01 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Dec 12, 2019 at 1:48 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 12/12/19 1:18 PM, Paul Moore wrote:
> > > On Thu, Dec 12, 2019 at 1:10 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > >>
> > >> On 12/12/19 1:09 PM, Paul Moore wrote:
> > >>> On Thu, Dec 12, 2019 at 12:57 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > >>>> On 12/12/19 12:54 PM, Paul Moore wrote:
> > >>>>> On Thu, Dec 12, 2019 at 8:14 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > >>>>>> On 12/12/19 6:49 AM, Ondrej Mosnacek wrote:
> > >>>>>>> On Wed, Dec 11, 2019 at 8:12 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > >>>>>>>> On 12/11/19 1:35 PM, Casey Schaufler wrote:
> > >>>>>>>>> On 12/11/2019 8:42 AM, Kees Cook wrote:
> > >>>>>>>>>> On Wed, Dec 11, 2019 at 09:29:10AM -0500, Stephen Smalley wrote:
> > >>>>>>>>>>> On 12/11/19 9:08 AM, Ondrej Mosnacek wrote:
> > >>>>>
> > >>>>> ...
> > >>>>>
> > >>>>>>>> selinux_state.initialized reflects whether a policy has
> > >>>>>>>> been loaded.  With a few exceptions in certain hook functions, it is
> > >>>>>>>> only checked by the security server service functions
> > >>>>>>>> (security/selinux/ss/services.c) prior to accessing the policydb.  So
> > >>>>>>>> there is a lot of SELinux processing that would still occur in that
> > >>>>>>>> situation unless we added if (!selinux_state.initialized) return 0;
> > >>>>>>>> checks to all the hook functions, which would create the same exposure
> > >>>>>>>> and would further break the SELinux-enabled case (we need to perform
> > >>>>>>>> some SELinux processing pre-policy-load to allocate blobs and track what
> > >>>>>>>> tasks and objects require delayed security initialization when policy
> > >>>>>>>> load finally occurs).
> > >>>>>>>
> > >>>>>>> I think what Casey was suggesting is to add another flag that would
> > >>>>>>> switch from "no policy loaded, but we expect it to be loaded
> > >>>>>>> eventually" to "no policy loaded and we don't expect/allow it to be
> > >>>>>>> loaded any more", which is essentially equivalent to checking
> > >>>>>>> selinux_enabled in each hook, which you had already brought up.
> > >>>>>>
> > >>>>>> Yep.  if (!selinux_enabled) return 0; or if (selinux_state.disabled)
> > >>>>>> return 0; under #ifdef CONFIG_SECURITY_SELINUX_DISABLE in every hook
> > >>>>>> might be the best option until it can be removed altogether; avoids
> > >>>>>> impacting the LSM framework or any other security module, preserves the
> > >>>>>> existing functionality, fairly low overhead on the SELinux-disabled case.
> > >>>>>
> > >>>>> Just so I'm understanding this thread correctly, the above change
> > >>>>> (adding enabled checks to each SELinux hook implementation) is only
> > >>>>> until Fedora can figure out a way to deprecate and remove the runtime
> > >>>>> disable?
> > >>>>
> > >>>> That's my understanding.  In the interim, Android kernels should already
> > >>>> be disabling CONFIG_SECURITY_SELINUX_DISABLE and other distros may
> > >>>> choose to disable it as long as they don't care about supporting SELinux
> > >>>> runtime disable.
> > >>>
> > >>> Okay, I just wanted to make sure I wasn't missing something.
> > >>> Honestly, I'd rather Fedora just go ahead and do whatever it is they
> > >>> need to do to turn off CONFIG_SECURITY_SELINUX_DISABLE (it sounds like
> > >>> they have a plan and are working on it), I'm not overly excited about
> > >>> temporarily cluttering up the code with additional "enabled" checks
> > >>> when the status quo works, even if it is less than ideal.
> > >>
> > >> The status quo is producing kernel crashes, courtesy of LSM stacking
> > >> changes...
> > >
> > > How prevalent are these crashes?
> > >
> > > This also only happens when disabling SELinux at runtime, yes?
> > > Something we've advised against for some time now and are working to
> > > eliminate?  Let's just get rid of the runtime disable *soon*, and if
> > > we need a stop-gap fix let's just go with the hook reordering since
> > > that seems to minimize the impact, if not resolve it.
> >
> > Not optimistic given that the original bug was opened 2.5+ years ago,
> > commenters identified fairly significant challenges to removing the
> > support, and no visible progress was ever made.  I suppose the hook
> > reordering will do but seems fragile and hacky.  Whatever.
>
> Based on Ondrej's comments in this thread it sounded as if there was
> some renewed interest in actually eliminating it from Fedora this
> time.  If that's not the case, perhaps it's time to start that effort
> back up, and if we can't ever get away from the runtime disable then
> we can take the step of admitting that everything is terrible and we
> can consider some of the options presented in this thread.

Yes, we are quite determined to do what it takes to remove it. It may
go more smoothly than expected, or it may get unexpectedly
complicated. It's hard to tell at this point.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.


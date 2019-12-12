Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BE0C3F68F
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 18:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD7821556
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 18:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="VTT+HWVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbfLLSJO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:09:14 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33052 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbfLLSJO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 13:09:14 -0500
Received: by mail-lj1-f196.google.com with SMTP id 21so3341492ljr.0
        for <selinux@vger.kernel.org>; Thu, 12 Dec 2019 10:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zcr4gUWUusfrBPLoX/9dzbPOLRPvYN7L3eMRvyRnjYU=;
        b=VTT+HWVlQ71MsjrP5EiBmionYX159aJSsr/f40V0hAR07aewWHOrxigHM+jL8WNk9D
         BE8ZkkOWkhws7SAlkzRgwSu1Gbn/Y/qyzFQGK06ab5WyAOEbKO+u3eqtxc8khE8hU8AS
         eieaVmoFwreFa8FvOctz3QflasY4dp82z0sl6JEMhFgciBFna2xUJh1ZlO4SDtl3U3E0
         kTkUAtvJlfW+V97F7SXzibfUksCEO7tD3eMkj2gTRg1wVckmmRM0vSCmJ5qCJUgiqQLo
         ooP0pTY95bvs8P3/Zd5GUXq2HJ+zjZlr1jekcPC0fnn3pshK9eAHnpsp1Qsw+M/mpcG8
         yZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zcr4gUWUusfrBPLoX/9dzbPOLRPvYN7L3eMRvyRnjYU=;
        b=HPDK3mrxW2t84pe1FNKL+3xEB38S65ppeuEe5vPc9x++nCSxLd8vqs2qlwVrdvDlte
         6hbLRsptmzPT7nk5wOdFdEAQd1MdIlf5Qhk1QqfjvRIJiaAhOaRRqOXke602HT/AySV4
         OnpSyYmUMPmFTx1Bqp5fb98DCglu6Prh/G/kFH5VHc8C5HBonYGDlVR+w5kPXmhuRTcT
         3KKXb2iJeH7qrtUzlijWiBMs8WaXrTmziDa5XQEPsTJ25lototvkQxEw5c+6JOr9P+GL
         RZwr2PIO2OLXcqXskXmbg9Nx9Awiiy5Xv7pFfh7mtc8Kbn6rRX0rSOIEMPWXSOi5+wwJ
         w9JQ==
X-Gm-Message-State: APjAAAXKwSo8Fac3zDccaex7K9fB0/IbvnRGY7jYbbQwHqRXozIVAAv7
        PDyit9DHUGG4Dzjsp0bBzHwm7L5iSynmlSyJK8EL
X-Google-Smtp-Source: APXvYqwAEIHNp7W9/GzxgJL8OxV0cc6wtWzP33/lMvX8QZn1WqJYZJhBzxMKpu1GP8WOfEGbOzw+We4vhwp6Gb9539s=
X-Received: by 2002:a2e:b045:: with SMTP id d5mr6909841ljl.184.1576174152285;
 Thu, 12 Dec 2019 10:09:12 -0800 (PST)
MIME-Version: 1.0
References: <20191211140833.939845-1-omosnace@redhat.com> <677be2d4-8247-3c2b-ac13-def725cffaeb@tycho.nsa.gov>
 <201912110840.62A4E64BA@keescook> <356c555a-d4ab-84fb-0165-f7672bc1ee63@schaufler-ca.com>
 <2fdb09e7-6668-cb1b-8a2d-1550278ae803@tycho.nsa.gov> <CAFqZXNtjELoG_5GK5c4XpH8Be3NfsKMZdZvrJKPpnTLPKKgZ9A@mail.gmail.com>
 <1f613260-d315-6925-d069-e92b872b8610@tycho.nsa.gov> <CAHC9VhT_CBQN+aFWjpPixi9Ok3Z7bQ-053AHg4pvqVtn-RdVVA@mail.gmail.com>
 <0f0778af-73c2-3c75-30c0-da5eae203032@tycho.nsa.gov>
In-Reply-To: <0f0778af-73c2-3c75-30c0-da5eae203032@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Dec 2019 13:09:00 -0500
Message-ID: <CAHC9VhT24b6YYTcE-h9pS9HnJ35unW_14EYLcNBBd-xUa=1L9A@mail.gmail.com>
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
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

On Thu, Dec 12, 2019 at 12:57 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/12/19 12:54 PM, Paul Moore wrote:
> > On Thu, Dec 12, 2019 at 8:14 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> On 12/12/19 6:49 AM, Ondrej Mosnacek wrote:
> >>> On Wed, Dec 11, 2019 at 8:12 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>>> On 12/11/19 1:35 PM, Casey Schaufler wrote:
> >>>>> On 12/11/2019 8:42 AM, Kees Cook wrote:
> >>>>>> On Wed, Dec 11, 2019 at 09:29:10AM -0500, Stephen Smalley wrote:
> >>>>>>> On 12/11/19 9:08 AM, Ondrej Mosnacek wrote:
> >
> > ...
> >
> >>>> selinux_state.initialized reflects whether a policy has
> >>>> been loaded.  With a few exceptions in certain hook functions, it is
> >>>> only checked by the security server service functions
> >>>> (security/selinux/ss/services.c) prior to accessing the policydb.  So
> >>>> there is a lot of SELinux processing that would still occur in that
> >>>> situation unless we added if (!selinux_state.initialized) return 0;
> >>>> checks to all the hook functions, which would create the same exposure
> >>>> and would further break the SELinux-enabled case (we need to perform
> >>>> some SELinux processing pre-policy-load to allocate blobs and track what
> >>>> tasks and objects require delayed security initialization when policy
> >>>> load finally occurs).
> >>>
> >>> I think what Casey was suggesting is to add another flag that would
> >>> switch from "no policy loaded, but we expect it to be loaded
> >>> eventually" to "no policy loaded and we don't expect/allow it to be
> >>> loaded any more", which is essentially equivalent to checking
> >>> selinux_enabled in each hook, which you had already brought up.
> >>
> >> Yep.  if (!selinux_enabled) return 0; or if (selinux_state.disabled)
> >> return 0; under #ifdef CONFIG_SECURITY_SELINUX_DISABLE in every hook
> >> might be the best option until it can be removed altogether; avoids
> >> impacting the LSM framework or any other security module, preserves the
> >> existing functionality, fairly low overhead on the SELinux-disabled case.
> >
> > Just so I'm understanding this thread correctly, the above change
> > (adding enabled checks to each SELinux hook implementation) is only
> > until Fedora can figure out a way to deprecate and remove the runtime
> > disable?
>
> That's my understanding.  In the interim, Android kernels should already
> be disabling CONFIG_SECURITY_SELINUX_DISABLE and other distros may
> choose to disable it as long as they don't care about supporting SELinux
> runtime disable.

Okay, I just wanted to make sure I wasn't missing something.
Honestly, I'd rather Fedora just go ahead and do whatever it is they
need to do to turn off CONFIG_SECURITY_SELINUX_DISABLE (it sounds like
they have a plan and are working on it), I'm not overly excited about
temporarily cluttering up the code with additional "enabled" checks
when the status quo works, even if it is less than ideal.

-- 
paul moore
www.paul-moore.com

Return-Path: <SRS0=c00g=2D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E50C43603
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 23:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F9522527
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 23:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="dFta73b2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLMXXy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:23:54 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45134 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfLMXXy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Dec 2019 18:23:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id d20so422710ljc.12
        for <selinux@vger.kernel.org>; Fri, 13 Dec 2019 15:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6sEma6QewPsDcAV3of38HRDLt0CvEgr7yXVj5mX+1ck=;
        b=dFta73b2M54Q9pbxh2ieNMbCfyi7rNPQh45Gb7D0RyIqTxdSZZH/HEclW52V6rCVTa
         KJv8xIntTINTJBbVBCtNK8cWQWpqjgskIlafpDA/N9gQHSNkYaZQzp+8l9k+WyHDvQvq
         LE4QS2mLQMHrYZL2Vvzx1d4hr1LCVM6sk13te2nwg9VrM9sY5e5h+8yTNVed/BC5bQvM
         rbSDmmUH5Bec34qj64cr1yeU1jVrPKlQwc9Oa2LdSANlcT4M/1pJtiogrEXlsLTPbG5F
         h/nD1YC5vs9O54VgZVpquSc0RFztnq7landfTTKrV4z2a+wMeewLACafayVlvCMQRsvM
         /CRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sEma6QewPsDcAV3of38HRDLt0CvEgr7yXVj5mX+1ck=;
        b=eDinbG8/WmxlEHnAOLsD5s/fNnj3woMn55yfutn0ylkrOVllrz3FDTGqL1S8mSOvBJ
         tHkUn/RbgGt7y/jXeWtgnCmXcj0+Tjv54SBt/guijgpXqZ9Q2m7AygZ+HRjBMmn7upu1
         glSy1iCZI5/7yF7MwWuy/7Ur/MHgi1KyNpyKW7MQ4+6iKW54b/vD634UtGbhVFZ0liJ9
         AotLXZNKO1mYXS0H7kZeu6GoHnO8Fkbr3C6Fhv40yG2lEi+3yPb29/D8usz3LN4fYL5+
         CRkW6qngftaYPJ3cBhs7FSNm+Q4OMIK5oxsQHnIYZYsEmy37F5tYVmlPZ6KLERBpsOiF
         gyPA==
X-Gm-Message-State: APjAAAVrjwwMJgQApTwpP78eK/iEDwxy3B7KuEuPOP/A9ir6k9h60d7z
        GFy17deKGlNKHBsEjULPD62r7nYbVrp2Fros261j
X-Google-Smtp-Source: APXvYqwGMLWGEbtciNh6PajD1f9K2VmEYE1uuUS4NB32RTLzP2Yrfky5m/RWkbG25MBGFsDN4/LvMv1SxZOUuLQpDjM=
X-Received: by 2002:a2e:9d9a:: with SMTP id c26mr11246076ljj.225.1576279431027;
 Fri, 13 Dec 2019 15:23:51 -0800 (PST)
MIME-Version: 1.0
References: <20191211140833.939845-1-omosnace@redhat.com> <677be2d4-8247-3c2b-ac13-def725cffaeb@tycho.nsa.gov>
 <201912110840.62A4E64BA@keescook> <356c555a-d4ab-84fb-0165-f7672bc1ee63@schaufler-ca.com>
 <2fdb09e7-6668-cb1b-8a2d-1550278ae803@tycho.nsa.gov> <CAFqZXNtjELoG_5GK5c4XpH8Be3NfsKMZdZvrJKPpnTLPKKgZ9A@mail.gmail.com>
 <1f613260-d315-6925-d069-e92b872b8610@tycho.nsa.gov> <CAHC9VhT_CBQN+aFWjpPixi9Ok3Z7bQ-053AHg4pvqVtn-RdVVA@mail.gmail.com>
 <0f0778af-73c2-3c75-30c0-da5eae203032@tycho.nsa.gov> <CAHC9VhT24b6YYTcE-h9pS9HnJ35unW_14EYLcNBBd-xUa=1L9A@mail.gmail.com>
 <83d047ce-0ca0-4152-1da7-32798c500aab@tycho.nsa.gov> <CAHC9VhQG9zZEL53XRdLHdmFJDpg8qAd9p61Xkm5AdSgM=-5eAg@mail.gmail.com>
 <83af5f0f-d3ec-7827-92e5-2db0997b9d22@tycho.nsa.gov> <CAHC9VhSqNGxqGQU6QfB3SxHZZdtPh79-4vOrpDXLr9zxT_X4bg@mail.gmail.com>
 <CAFqZXNv7PUgrU9Qe28e3cHnRAwjKZLVmNrOZggvkE5AB7T9o1Q@mail.gmail.com>
In-Reply-To: <CAFqZXNv7PUgrU9Qe28e3cHnRAwjKZLVmNrOZggvkE5AB7T9o1Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 13 Dec 2019 18:23:39 -0500
Message-ID: <CAHC9VhRwPpBAD3vDwTf1q25Qhp-nE_wmPpqdyfsDwpUNS6smrw@mail.gmail.com>
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
To:     Ondrej Mosnacek <omosnace@redhat.com>
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

On Fri, Dec 13, 2019 at 9:07 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Dec 12, 2019 at 8:01 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Dec 12, 2019 at 1:48 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > On 12/12/19 1:18 PM, Paul Moore wrote:
> > > > On Thu, Dec 12, 2019 at 1:10 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > >>
> > > >> On 12/12/19 1:09 PM, Paul Moore wrote:
> > > >>> On Thu, Dec 12, 2019 at 12:57 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > >>>> On 12/12/19 12:54 PM, Paul Moore wrote:
> > > >>>>> On Thu, Dec 12, 2019 at 8:14 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > >>>>>> On 12/12/19 6:49 AM, Ondrej Mosnacek wrote:
> > > >>>>>>> On Wed, Dec 11, 2019 at 8:12 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > >>>>>>>> On 12/11/19 1:35 PM, Casey Schaufler wrote:
> > > >>>>>>>>> On 12/11/2019 8:42 AM, Kees Cook wrote:
> > > >>>>>>>>>> On Wed, Dec 11, 2019 at 09:29:10AM -0500, Stephen Smalley wrote:
> > > >>>>>>>>>>> On 12/11/19 9:08 AM, Ondrej Mosnacek wrote:
> > > >>>>>
> > > >>>>> ...
> > > >>>>>
> > > >>>>>>>> selinux_state.initialized reflects whether a policy has
> > > >>>>>>>> been loaded.  With a few exceptions in certain hook functions, it is
> > > >>>>>>>> only checked by the security server service functions
> > > >>>>>>>> (security/selinux/ss/services.c) prior to accessing the policydb.  So
> > > >>>>>>>> there is a lot of SELinux processing that would still occur in that
> > > >>>>>>>> situation unless we added if (!selinux_state.initialized) return 0;
> > > >>>>>>>> checks to all the hook functions, which would create the same exposure
> > > >>>>>>>> and would further break the SELinux-enabled case (we need to perform
> > > >>>>>>>> some SELinux processing pre-policy-load to allocate blobs and track what
> > > >>>>>>>> tasks and objects require delayed security initialization when policy
> > > >>>>>>>> load finally occurs).
> > > >>>>>>>
> > > >>>>>>> I think what Casey was suggesting is to add another flag that would
> > > >>>>>>> switch from "no policy loaded, but we expect it to be loaded
> > > >>>>>>> eventually" to "no policy loaded and we don't expect/allow it to be
> > > >>>>>>> loaded any more", which is essentially equivalent to checking
> > > >>>>>>> selinux_enabled in each hook, which you had already brought up.
> > > >>>>>>
> > > >>>>>> Yep.  if (!selinux_enabled) return 0; or if (selinux_state.disabled)
> > > >>>>>> return 0; under #ifdef CONFIG_SECURITY_SELINUX_DISABLE in every hook
> > > >>>>>> might be the best option until it can be removed altogether; avoids
> > > >>>>>> impacting the LSM framework or any other security module, preserves the
> > > >>>>>> existing functionality, fairly low overhead on the SELinux-disabled case.
> > > >>>>>
> > > >>>>> Just so I'm understanding this thread correctly, the above change
> > > >>>>> (adding enabled checks to each SELinux hook implementation) is only
> > > >>>>> until Fedora can figure out a way to deprecate and remove the runtime
> > > >>>>> disable?
> > > >>>>
> > > >>>> That's my understanding.  In the interim, Android kernels should already
> > > >>>> be disabling CONFIG_SECURITY_SELINUX_DISABLE and other distros may
> > > >>>> choose to disable it as long as they don't care about supporting SELinux
> > > >>>> runtime disable.
> > > >>>
> > > >>> Okay, I just wanted to make sure I wasn't missing something.
> > > >>> Honestly, I'd rather Fedora just go ahead and do whatever it is they
> > > >>> need to do to turn off CONFIG_SECURITY_SELINUX_DISABLE (it sounds like
> > > >>> they have a plan and are working on it), I'm not overly excited about
> > > >>> temporarily cluttering up the code with additional "enabled" checks
> > > >>> when the status quo works, even if it is less than ideal.
> > > >>
> > > >> The status quo is producing kernel crashes, courtesy of LSM stacking
> > > >> changes...
> > > >
> > > > How prevalent are these crashes?
> > > >
> > > > This also only happens when disabling SELinux at runtime, yes?
> > > > Something we've advised against for some time now and are working to
> > > > eliminate?  Let's just get rid of the runtime disable *soon*, and if
> > > > we need a stop-gap fix let's just go with the hook reordering since
> > > > that seems to minimize the impact, if not resolve it.
> > >
> > > Not optimistic given that the original bug was opened 2.5+ years ago,
> > > commenters identified fairly significant challenges to removing the
> > > support, and no visible progress was ever made.  I suppose the hook
> > > reordering will do but seems fragile and hacky.  Whatever.
> >
> > Based on Ondrej's comments in this thread it sounded as if there was
> > some renewed interest in actually eliminating it from Fedora this
> > time.  If that's not the case, perhaps it's time to start that effort
> > back up, and if we can't ever get away from the runtime disable then
> > we can take the step of admitting that everything is terrible and we
> > can consider some of the options presented in this thread.
>
> Yes, we are quite determined to do what it takes to remove it. It may
> go more smoothly than expected, or it may get unexpectedly
> complicated. It's hard to tell at this point.

That's good to hear, I know it is going to be difficult, but I think
we can all agree it's the right thing to do.  Any idea when you might
have a better idea of the time involved?

Next week I think I'm going to put together a RFC patch that marks
CONFIG_SECURITY_SELINUX_DISABLE as deprecated, and displays a warning
when it is used at runtime.  Later on when we have a better idea of
the removal date, we can start adding delays when it is used to help
get people to migrate to the cmdline approach.

-- 
paul moore
www.paul-moore.com

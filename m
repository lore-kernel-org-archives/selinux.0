Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB98ECAAD3
	for <selinux@archiver.kernel.org>; Wed,  7 Sep 2022 22:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIGW5e (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Sep 2022 18:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIGW5d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Sep 2022 18:57:33 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862529E6A7
        for <selinux@vger.kernel.org>; Wed,  7 Sep 2022 15:57:32 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1279948d93dso19955872fac.10
        for <selinux@vger.kernel.org>; Wed, 07 Sep 2022 15:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hb7Vaq8cNNiYFTB3t0jA9qMsK1mZsMtpmFKxuE29TZ0=;
        b=BuJ6lfwjLLU9HLf8l9aMxInKh7wR/04of7t2Utw97y6Rz/wvj92KaadCnr1qRx9QaC
         j/1nSUcxUEnAIArC5wd2sbgaljh7L7gjlbAYJNPTEuC+koplhEkp/KHK8OntGRE3zz62
         NpLQPpeTEB+Cos6GyzHOcJrrbbmY8nZORAiAzRPOGPWPaJahTBr6P1t5vuSH1gp6lTB+
         bz2fFDrWqRRv2nfYHan/GAVisJAz1mWSF1QZ416/BPzWakZxRCmkbQy696Uj5C4r3oJB
         HKVYdsA3V57+yOpNc/rKkCT0M+2G6fW1HCEYQSgcpkcvOhzC95jmr4xGGjD7zXFQl/up
         F1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hb7Vaq8cNNiYFTB3t0jA9qMsK1mZsMtpmFKxuE29TZ0=;
        b=N1JrwdCmNg9k9QNs8aO27AIAX13+PNpij/8bEzI6ajEwZjCmaWnw+qdXl84B8Mo9KF
         cdf6FtSncFhZe2coVF2zQrZh/egDjfv/2qPn7bMw7p/ihuSypKMsbWZPw7lVHkquRAX9
         rE/BOKI0ZFzVG9m6ooqPzrk6IZ5GBkCs3ULH/HBjaxO4mqi3Sxj6onFz/uuLeLTkGvwU
         JEF3qHkt2K3d5YkG1dRtjC7Q1LYxOdHB9H0DceC4pHNLyVPECenyXzNlxXPqY+2Kouja
         3FCne/677SSAO1TkXKe0oR3wWqmELlo7RMg3CZQLQHVAwLx3E/z0EjrSonw9RXm9ARMH
         m2Pw==
X-Gm-Message-State: ACgBeo2szLU7z2vXgZBvN1VAIq+lVysMD+gAAG4FRZLfq2K00niQt6tY
        oUfPrASezLOhGWQl3hfwY4IjCZWMt2TvW6t2/YSj
X-Google-Smtp-Source: AA6agR66L+vHLXnMaQvpmBtTqWLM/grxTwcIWDSLP0jEuFf3Fi4Esu3ujCdujc1QpaPjffwI2ByPz0z07KFu2KttHrE=
X-Received: by 2002:a05:6870:5808:b0:128:afd5:491f with SMTP id
 r8-20020a056870580800b00128afd5491fmr390641oap.136.1662591451887; Wed, 07 Sep
 2022 15:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com> <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
 <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com> <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
 <269014c6-5ce6-3322-5208-004cb1b40792@canonical.com> <CAHC9VhRrOgDMO9fo632tSL7vCMAy1_x3smaAok-nWdMAUFB8xQ@mail.gmail.com>
 <1958a0d3-c4fb-0661-b516-93f8955cdb95@schaufler-ca.com> <65d21148-6a6d-4c4c-aa39-fafc1740ce24@canonical.com>
In-Reply-To: <65d21148-6a6d-4c4c-aa39-fafc1740ce24@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 7 Sep 2022 18:57:21 -0400
Message-ID: <CAHC9VhRPO+nE7bc9nXVLYbjXDVHz_QTCLn7ns74RMviR7BJ3VA@mail.gmail.com>
Subject: Re: LSM stacking in next for 6.1?
To:     John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 7, 2022 at 1:23 PM John Johansen
<john.johansen@canonical.com> wrote:
> On 9/7/22 09:41, Casey Schaufler wrote:
> > On 9/7/2022 7:41 AM, Paul Moore wrote:
> >> On Tue, Sep 6, 2022 at 8:10 PM John Johansen
> >> <john.johansen@canonical.com> wrote:
> >>> On 9/6/22 16:24, Paul Moore wrote:
> >>>> On Fri, Sep 2, 2022 at 7:14 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>>> On 9/2/2022 2:30 PM, Paul Moore wrote:
> >>>>>> On Tue, Aug 2, 2022 at 8:56 PM Paul Moore <paul@paul-moore.com> wrote:
> >>>>>>> On Tue, Aug 2, 2022 at 8:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> ..
> >>
> >>>> If you are running AppArmor on the host system and SELinux in a
> >>>> container you are likely going to have some *very* bizarre behavior as
> >>>> the SELinux policy you load in the container will apply to the entire
> >>>> system, including processes which started *before* the SELinux policy
> >>>> was loaded.  While I understand the point you are trying to make, I
> >>>> don't believe the example you chose is going to work without a lot of
> >>>> other changes.
> >>> correct but the reverse does work ...
> >> Sure, that doesn't surprise me, but that isn't the example Casey brought up.
> >
> > I said that I'm not sure how they go about doing Android on Ubuntu.
> > I brought it up because I've seen it.
>
> LSM stacking for that use case is necessary but insufficient.

Yes, exactly.  One of my bigger worries about the stacking effort is
that a lot of people have some false assumptions about what it will
actually enable.  Of course that doesn't mean it isn't worth doing,
just that there may be a lot of disappointed people out there.

> At a minimum
> SELinux would need bounding, and realistically some other gymnastics. I
> don't hold out hope of it happening soon if ever. I have told the anbox people
> such.

Most of that is just a matter of writing the code.  Yes, that's going
to be a decent chunk of work, but the idea is relatively
straightforward.  The bit that keeps blocking this in my mind is
handling of the persistent filesystem labels, that's a conceptual
problem we have yet to solve.  The current solution of just creating
more and more (scoped) xattrs isn't going to scale to the level I
believe we are going to need.  I keep toying with the idea of just
punting on it and leaving it up to the container orchestrator to
manage the filesystems; if you want to run a nested SELinux instance
inside a container with dedicated file labels you need your own
filesystem mounted.  Dunno, lots to think about here ...

> At the momement anbox disables SELinux when run in a container
>
> https://github.com/anbox/platform_system_core/commit/71907fc5e7833866be6ae3c120c602974edf8322
>
> there has been work on using a VM instead so that they can have SELinux
> but I am not current on how/when that is used.

That makes much more sense, thanks John.

-- 
paul-moore.com

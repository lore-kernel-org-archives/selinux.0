Return-Path: <SRS0=ib1x=AV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA26C433E4
	for <selinux@archiver.kernel.org>; Fri, 10 Jul 2020 15:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2141F20767
	for <selinux@archiver.kernel.org>; Fri, 10 Jul 2020 15:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpV4PIb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgGJPXM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgGJPXK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jul 2020 11:23:10 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC46C08C5CE
        for <selinux@vger.kernel.org>; Fri, 10 Jul 2020 08:23:10 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id o5so6374980iow.8
        for <selinux@vger.kernel.org>; Fri, 10 Jul 2020 08:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZO7HcJcSdwZQRvbkPa0gICHsKqIyR/s00+M7JsZAs4=;
        b=gpV4PIb5TWTkIoKQqvspDXvZzWPUKZklzrJ3Z9OZ6ngSFWbntMF1WxYcBolj4rled0
         VLGRv1EOoC0l0iqbpJjWXYkjLXY4TcoFgvMba9jKTMmhT7BKKsUESc8C4A20nBFXQnNx
         qWGdYJGw8IFaTxQpaHCGcWk3JQpfxI/sb7WLC3mWlVOVLUX7tJJIwuh0t5KJvblM66iL
         yO5cnaLEosrJe6FRK9ZHwBDuFpmMWW+cOvMz4gMO7DPjFni9Xh/uU5+ULQio5pT3Uq8g
         w249wiVlKNzl7Vmuvipltt8cTPTIhMkD1sJBIkflgOVyPRiOXvt4VJYBtnsvdMbv2izb
         e4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZO7HcJcSdwZQRvbkPa0gICHsKqIyR/s00+M7JsZAs4=;
        b=Kc/xIs6RlLQQ7Hp73q1Ud6OxkczuwFGhYG9HZfcbI3wkWxmSN7HlMdlwRAMb4zOe5f
         5thBTObkwmUxKXdl1JSxnNfL2fbP2L7Qm/iuZNPkNipXdXiFLp6ECcmYJZQhSJmNasCI
         GP1VDfvDj3A/6PZlLiVOCwYnE/Hlmc+H19z177tyrjlp3KPV+rQ3+XtWG7JozNyQ1FMR
         jBVr5S2qlPA7Qc+IrvSRtFr37WHAUKt6s4BIN4UZLP2/d6i8siUpCC6rgR2BMG6WCZbm
         Oi/jyQ+t+fW4Blnidhmpalbm3NwUAkudch8FAiPqXQZq2/CTu828Mxp19BIXTffEsyv7
         guAA==
X-Gm-Message-State: AOAM533kTY2IZqMSbIrbvRCLEKa9p7ieE56etjo+hHxWPgrq2UbbdWjC
        3vwKaYoR5hrp9Eqt24HYfCTrsceHS/mxCO3/1+bRH7UMfMA=
X-Google-Smtp-Source: ABdhPJw2nYdu7Ezp6O9rHjvw+iBb0V/OhkA9x1yyJ2zA2azTBESpLYGGAM08HxMDldWJyy6+ctH0QBJn2bvBU63kZ+A=
X-Received: by 2002:a5d:8f98:: with SMTP id l24mr47550383iol.141.1594394589233;
 Fri, 10 Jul 2020 08:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdpDN+8c2hQ+OoX8z+Fx3s-7-g2sn7ZV+Y=D=NZqqFwr6Q@mail.gmail.com>
 <CAHC9VhQkTgYFQ5ncLDJpOcqynWam3QY7udLQoUYSb3HgkvdboQ@mail.gmail.com> <CAJfZ7=kyieBs6_NPE3k2tyNSydrwmVT7k3kcmd=0Xsi7JoD2Zg@mail.gmail.com>
In-Reply-To: <CAJfZ7=kyieBs6_NPE3k2tyNSydrwmVT7k3kcmd=0Xsi7JoD2Zg@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 10 Jul 2020 10:22:58 -0500
Message-ID: <CAFftDdp=4nB1CfmAQXBbN_BODHMaXaVbLGsh7+mHLt6GpTGMZg@mail.gmail.com>
Subject: Re: travis: any reason we have keep going on make commands
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 10, 2020 at 4:10 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Jul 9, 2020 at 8:00 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Thu, Jul 9, 2020 at 10:33 AM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > > So Nicolas initially created our travis script in commit c9adfe2d2653
> > > and has -k, or keep going, on the make commands. This causes make to
> > > plow ahead and bury the errors in the logs. Stephen noticed this the
> > > other day, and we have been chatting about it out of band and wanted
> > > to pull in the community.
> > >
> > > Are their compelling reasons for keeping this behavior? I am also
> > > concerned that we could get false positives on travis success results.
> >
> > In my opinion the whole point of automated testing is to catch
> > failures early and often.  For that reason I would want the test to
> > fail and stop, both because I find it easier to identify the failure
> > that way and also because I'm not sure I would trust much of the
> > testing that occurred after an error condition.
> >
> Hi,
> There seems to be some confusion:
>
> * "make -k" does not stop the "make" command at the first error and
> allows seeing all the errors when there are several ones. In my humble
> opinion, it makes sense when compiling ("make all") and not when
> running tests ("make test"), and this is actually what is right now in
> Travis-CI. "make -k" returns a failure exit code when an error
> happens.

Ahh I thought it returned to 0. Not sure why I assumed that.

>
> * Travis-CI does not stop the job as soon as a sub-command fails. If I

Depends on the stage:
https://docs.travis-ci.com/user/job-lifecycle/
If before_install, install or before_script returns a non-zero exit
code, the build is errored and stops immediately.
If script returns a non-zero exit code, the build is failed, but
continues to run before being marked as failed.

I put a false command in the script section and it kept plowing ahead
as you foretold.

> understand correctly, this is what really bothers William, and I agree
> this is a behavior that can be improved. According to
> https://github.com/travis-ci/travis-ci/issues/1066, a possible
> solution could be to use "set -e", which could have unexpected
> side-effects in launched commands. It is possible to "emulate set -e"
> by adding exit statements, such as :
>
>     - make install $EXPLICIT_MAKE_VARS -k || exit $?
>     - make install-pywrap $EXPLICIT_MAKE_VARS -k || exit $?
>     - make install-rubywrap $EXPLICIT_MAKE_VARS -k || exit $?
>     # ...
>     - make test $EXPLICIT_MAKE_VARS || exit $?
>
> I have not tested whether this works on Travis-CI, but if it does, it
> would be a nice improvement. I will take a look this week-end.

I think the scripts are more maintainable outside of travis yaml files
as separate build scripts,
for two reasons:
1.  One can just execute the script locally, you can't, AFAIK, do that
with a travis yaml file.
2.  The issue can be avoided as they afford more control. Some other
projects I am a part of we only
     use script and after_failure. The bash scripts are set -e. I also
used this approach for the KVM
     selinux test run.

script:
  - ./.ci/travis.run
after_failure:
  - cat build/test-suite.log

We could adopt like what's above...


>
> Cheers,
> Nicolas
>

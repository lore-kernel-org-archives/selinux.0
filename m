Return-Path: <SRS0=Vtnu=AW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF8AC433E1
	for <selinux@archiver.kernel.org>; Sat, 11 Jul 2020 17:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3223207D4
	for <selinux@archiver.kernel.org>; Sat, 11 Jul 2020 17:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgGKRFd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 11 Jul 2020 13:05:33 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:53432 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbgGKRFd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 11 Jul 2020 13:05:33 -0400
X-Greylist: delayed 506 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Jul 2020 13:05:32 EDT
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9C1DC564C19
        for <selinux@vger.kernel.org>; Sat, 11 Jul 2020 18:57:03 +0200 (CEST)
Received: by mail-oi1-f175.google.com with SMTP id y22so7489739oie.8
        for <selinux@vger.kernel.org>; Sat, 11 Jul 2020 09:57:03 -0700 (PDT)
X-Gm-Message-State: AOAM532fSGGfemcmyOQsZA2DrzsUr0Hmjc6KxM+qc5gk6TMlRgtTaOWN
        +wwe72i1Tve8kGaYjmq26sCjabl0Ystup/pwuwI=
X-Google-Smtp-Source: ABdhPJwoqMmL4b0y84NG3uHnnHRxgXSDX0r0h0PZ8qAp4JWJQZpENm7ZsiWVNekqBj4D/f+mr+I8XJkjEs3N35OjBG8=
X-Received: by 2002:aca:ac10:: with SMTP id v16mr7963987oie.153.1594486622537;
 Sat, 11 Jul 2020 09:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdpDN+8c2hQ+OoX8z+Fx3s-7-g2sn7ZV+Y=D=NZqqFwr6Q@mail.gmail.com>
 <CAHC9VhQkTgYFQ5ncLDJpOcqynWam3QY7udLQoUYSb3HgkvdboQ@mail.gmail.com>
 <CAJfZ7=kyieBs6_NPE3k2tyNSydrwmVT7k3kcmd=0Xsi7JoD2Zg@mail.gmail.com> <CAFftDdp=4nB1CfmAQXBbN_BODHMaXaVbLGsh7+mHLt6GpTGMZg@mail.gmail.com>
In-Reply-To: <CAFftDdp=4nB1CfmAQXBbN_BODHMaXaVbLGsh7+mHLt6GpTGMZg@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 11 Jul 2020 18:56:51 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mUXwwhFXAnztCp-dO=rLfqUZGH4omGKpnqZGnrCdEtRw@mail.gmail.com>
Message-ID: <CAJfZ7=mUXwwhFXAnztCp-dO=rLfqUZGH4omGKpnqZGnrCdEtRw@mail.gmail.com>
Subject: Re: travis: any reason we have keep going on make commands
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jul 11 18:57:04 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 10, 2020 at 5:23 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Fri, Jul 10, 2020 at 4:10 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > On Thu, Jul 9, 2020 at 8:00 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On Thu, Jul 9, 2020 at 10:33 AM William Roberts
> > > <bill.c.roberts@gmail.com> wrote:
> > > > So Nicolas initially created our travis script in commit c9adfe2d2653
> > > > and has -k, or keep going, on the make commands. This causes make to
> > > > plow ahead and bury the errors in the logs. Stephen noticed this the
> > > > other day, and we have been chatting about it out of band and wanted
> > > > to pull in the community.
> > > >
> > > > Are their compelling reasons for keeping this behavior? I am also
> > > > concerned that we could get false positives on travis success results.
> > >
> > > In my opinion the whole point of automated testing is to catch
> > > failures early and often.  For that reason I would want the test to
> > > fail and stop, both because I find it easier to identify the failure
> > > that way and also because I'm not sure I would trust much of the
> > > testing that occurred after an error condition.
> > >
> > Hi,
> > There seems to be some confusion:
> >
> > * "make -k" does not stop the "make" command at the first error and
> > allows seeing all the errors when there are several ones. In my humble
> > opinion, it makes sense when compiling ("make all") and not when
> > running tests ("make test"), and this is actually what is right now in
> > Travis-CI. "make -k" returns a failure exit code when an error
> > happens.
>
> Ahh I thought it returned to 0. Not sure why I assumed that.
>
> >
> > * Travis-CI does not stop the job as soon as a sub-command fails. If I
>
> Depends on the stage:
> https://docs.travis-ci.com/user/job-lifecycle/
> If before_install, install or before_script returns a non-zero exit
> code, the build is errored and stops immediately.
> If script returns a non-zero exit code, the build is failed, but
> continues to run before being marked as failed.
>
> I put a false command in the script section and it kept plowing ahead
> as you foretold.
>
> > understand correctly, this is what really bothers William, and I agree
> > this is a behavior that can be improved. According to
> > https://github.com/travis-ci/travis-ci/issues/1066, a possible
> > solution could be to use "set -e", which could have unexpected
> > side-effects in launched commands. It is possible to "emulate set -e"
> > by adding exit statements, such as :
> >
> >     - make install $EXPLICIT_MAKE_VARS -k || exit $?
> >     - make install-pywrap $EXPLICIT_MAKE_VARS -k || exit $?
> >     - make install-rubywrap $EXPLICIT_MAKE_VARS -k || exit $?
> >     # ...
> >     - make test $EXPLICIT_MAKE_VARS || exit $?
> >
> > I have not tested whether this works on Travis-CI, but if it does, it
> > would be a nice improvement. I will take a look this week-end.
>
> I think the scripts are more maintainable outside of travis yaml files
> as separate build scripts,
> for two reasons:
> 1.  One can just execute the script locally, you can't, AFAIK, do that
> with a travis yaml file.
> 2.  The issue can be avoided as they afford more control. Some other
> projects I am a part of we only
>      use script and after_failure. The bash scripts are set -e. I also
> used this approach for the KVM
>      selinux test run.
>
> script:
>   - ./.ci/travis.run
> after_failure:
>   - cat build/test-suite.log
>
> We could adopt like what's above...

I did not understand the part about using "cat build/test-suite.log",
but otherwise the idea of putting the commands into a dedicated script
file sounds good, as this allows more flexibility. In order to know
which command failed (and fail as soon as a command fails), I suggest
using "set -e -x" in these scripts.

By the way, about the issue with "make", there is another thing from
your initial message that I understood only after sending my first
reply: a consequence of using "make -k" that can be considered
undesirable is the fact that when an error happens, its message can be
drowned among the flow of other messages. I disagree with removing
"-k" because this would only show one error, instead of all the errors
that occur during a build. Nevertheless it is possible to achieve the
best of both alternatives by using constructions such as:

if ! make install $EXPLICIT_MAKE_VARS -k ; then
  echo >&2 "Error in make install $EXPLICIT_MAKE_VARS:"
  make install $EXPLICIT_MAKE_VARS   # This command shows one error,
at the end of the build logs.
  exit 1
fi

Would such constructions be helpful?

Cheers,
Nicolas


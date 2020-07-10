Return-Path: <SRS0=ib1x=AV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA755C433DF
	for <selinux@archiver.kernel.org>; Fri, 10 Jul 2020 09:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB1F207BC
	for <selinux@archiver.kernel.org>; Fri, 10 Jul 2020 09:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgGJJUd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:20:33 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:39763 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgGJJUc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jul 2020 05:20:32 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jul 2020 05:20:31 EDT
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id D71E7565AFB
        for <selinux@vger.kernel.org>; Fri, 10 Jul 2020 11:08:41 +0200 (CEST)
Received: by mail-oi1-f171.google.com with SMTP id k4so4251096oik.2
        for <selinux@vger.kernel.org>; Fri, 10 Jul 2020 02:08:41 -0700 (PDT)
X-Gm-Message-State: AOAM5335MlaUMjt/ruyKIo3n83YWrbXBEUHIGj+yT//jaPVRXw/a0Sp+
        TJdWKDcttuMED1S5fX3I+c2uVsbL+qKRUFDlgRk=
X-Google-Smtp-Source: ABdhPJy9yJtvKgmf47PK2NnyiCRlJdxB+AusY2ZBVuSnuO/5lmHZ6iC1D1mof1R2/23L3ZgS1N3ieWD1zVWFeQITfEY=
X-Received: by 2002:aca:72ca:: with SMTP id p193mr3319297oic.20.1594372119031;
 Fri, 10 Jul 2020 02:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdpDN+8c2hQ+OoX8z+Fx3s-7-g2sn7ZV+Y=D=NZqqFwr6Q@mail.gmail.com>
 <CAHC9VhQkTgYFQ5ncLDJpOcqynWam3QY7udLQoUYSb3HgkvdboQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQkTgYFQ5ncLDJpOcqynWam3QY7udLQoUYSb3HgkvdboQ@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 10 Jul 2020 11:08:28 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kyieBs6_NPE3k2tyNSydrwmVT7k3kcmd=0Xsi7JoD2Zg@mail.gmail.com>
Message-ID: <CAJfZ7=kyieBs6_NPE3k2tyNSydrwmVT7k3kcmd=0Xsi7JoD2Zg@mail.gmail.com>
Subject: Re: travis: any reason we have keep going on make commands
To:     Paul Moore <paul@paul-moore.com>,
        William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Jul 10 11:09:02 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 9, 2020 at 8:00 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Jul 9, 2020 at 10:33 AM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> > So Nicolas initially created our travis script in commit c9adfe2d2653
> > and has -k, or keep going, on the make commands. This causes make to
> > plow ahead and bury the errors in the logs. Stephen noticed this the
> > other day, and we have been chatting about it out of band and wanted
> > to pull in the community.
> >
> > Are their compelling reasons for keeping this behavior? I am also
> > concerned that we could get false positives on travis success results.
>
> In my opinion the whole point of automated testing is to catch
> failures early and often.  For that reason I would want the test to
> fail and stop, both because I find it easier to identify the failure
> that way and also because I'm not sure I would trust much of the
> testing that occurred after an error condition.
>
Hi,
There seems to be some confusion:

* "make -k" does not stop the "make" command at the first error and
allows seeing all the errors when there are several ones. In my humble
opinion, it makes sense when compiling ("make all") and not when
running tests ("make test"), and this is actually what is right now in
Travis-CI. "make -k" returns a failure exit code when an error
happens.

* Travis-CI does not stop the job as soon as a sub-command fails. If I
understand correctly, this is what really bothers William, and I agree
this is a behavior that can be improved. According to
https://github.com/travis-ci/travis-ci/issues/1066, a possible
solution could be to use "set -e", which could have unexpected
side-effects in launched commands. It is possible to "emulate set -e"
by adding exit statements, such as :

    - make install $EXPLICIT_MAKE_VARS -k || exit $?
    - make install-pywrap $EXPLICIT_MAKE_VARS -k || exit $?
    - make install-rubywrap $EXPLICIT_MAKE_VARS -k || exit $?
    # ...
    - make test $EXPLICIT_MAKE_VARS || exit $?

I have not tested whether this works on Travis-CI, but if it does, it
would be a nice improvement. I will take a look this week-end.

Cheers,
Nicolas


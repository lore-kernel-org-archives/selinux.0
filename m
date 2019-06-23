Return-Path: <SRS0=NDoE=UW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A704C43613
	for <selinux@archiver.kernel.org>; Sun, 23 Jun 2019 17:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2F1206BA
	for <selinux@archiver.kernel.org>; Sun, 23 Jun 2019 17:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfFWRKL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 23 Jun 2019 13:10:11 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:51908 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfFWRKL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 23 Jun 2019 13:10:11 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Jun 2019 13:10:10 EDT
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id A415B564705
        for <selinux@vger.kernel.org>; Sun, 23 Jun 2019 19:01:58 +0200 (CEST)
Received: by mail-oi1-f175.google.com with SMTP id 65so8020171oid.13
        for <selinux@vger.kernel.org>; Sun, 23 Jun 2019 10:01:58 -0700 (PDT)
X-Gm-Message-State: APjAAAV1A849YvOfRZEcCwGZNjklAFqnE+djWI5TpKl/MoJCaau+xUSG
        hMZGU2mL9Rrme/UZrv4+yArAvYaM1Fk9y2AnM3Y=
X-Google-Smtp-Source: APXvYqzFlgPHnVDvbUz02dX1MTGkPbeagLRI6QPGXRwlb4RX08WBG/Slk8/omzOxbAMMhJUrtSXt8wCuY0Qc2+dsLK0=
X-Received: by 2002:aca:ba02:: with SMTP id k2mr7859114oif.70.1561309317584;
 Sun, 23 Jun 2019 10:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190619142630.26648-1-sds@tycho.nsa.gov> <CAHC9VhQ1Bo-xpROgZa18MqxJSnTLoYoj6GbQR-pmDy2jSDs1bQ@mail.gmail.com>
 <a11f8817-ac26-ce5c-1b1d-20c310777a03@tycho.nsa.gov> <CAHC9VhQViswrAHWZ6b4a4iAmErrumLLYHeNrZenqXrT+0FxP7w@mail.gmail.com>
In-Reply-To: <CAHC9VhQViswrAHWZ6b4a4iAmErrumLLYHeNrZenqXrT+0FxP7w@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 23 Jun 2019 19:01:45 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==Whcw0mnyMVuOfBD7=z+Qjy7LMOpkAV4SLc74U1v14GA@mail.gmail.com>
Message-ID: <CAJfZ7==Whcw0mnyMVuOfBD7=z+Qjy7LMOpkAV4SLc74U1v14GA@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: fix old python shebang in tests/overlay/access
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Jun 23 19:01:59 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 21, 2019 at 5:45 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Jun 19, 2019 at 12:04 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 6/19/19 10:40 AM, Paul Moore wrote:
> > > On Wed, Jun 19, 2019 at 10:26 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > >>
> > >> /usr/bin/python is no longer installed by default, so this test
> > >> script fails on default installs.
> > >> Best practice guidance appears to be to switch to using
> > >> /usr/bin/python3 instead, per
> > >> https://docs.fedoraproject.org/en-US/packaging-guidelines/Python/
> > >>
> > >> Fixes: #46
> > >> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> > >> ---
> > >>   tests/overlay/access | 2 +-
> > >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > I think it would be better to reference the Python upstream guidance
> > > regarding "python3" instead of the Fedora packaging guidelines.
> > > Keeping things distro agnostic is a good goal whenever possible.
> > >
> > > * https://www.python.org/dev/peps/pep-0394
> >
> > When I looked for guidance in response to the github issue for
> > selinux-testsuite [1], there seemed to be some ambiguity left by pep-0394:
> >
> > 1) It says "One exception to this is scripts that are deliberately
> > written to be source compatible with both Python 2.x and 3.x. Such
> > scripts may continue to use python on their shebang line.".  This leaves
> > open the possibility of staying with "/usr/bin/python" as far as the pep
> > is concerned since the script itself is not version-specific in any way,
> > but doing so is not permitted by the Fedora guidelines and breaks on
> > default installs of Fedora.
>
> [SIDE NOTE: for some reason my mail is acting a bit odd - this got
> buried in a folder and didn't bubble up like normal - my apologies on
> the delay, I didn't see it until I was checking for patches today.]
>
> Yes, I saw that too but considering that we are about six months away
> from python2 going EOL I think it is reasonable to ignore python2 for
> upstream work at this point.
>
> > 2) It doesn't specify whether or not one should use "/usr/bin/env
> > python3" or just "/usr/bin/python3".  The github issue reported had
> > originally suggested the former, but this is also prohibited by the
> > Fedora guidelines.
>
> My initial reaction was that we should "/usr/bin/env" until I saw that
> bit in the Fedora guidelines, which I honestly don't understand.  Does
> anyone with a better understanding of cross-distro userspace know why
> "/usr/bin/env" is bad?

Hello,

As far as I understand, the choice of using /usr/bin/env or not in the
shebang of a script depends on how you want your dependencies to load
on a system:

* Using "/usr/bin/env python3" (or with python or python2) allows
using a virtualenv where all Python dependencies are installed. It
makes it easier for two projects that require conflicting version of
their dependencies to be used together on a system, and it makes it
possible for an unprivileged user to use this script without requiring
an administrator to install dependencies in system-wide directories
(like /usr/lib/python3.7/site-packages/).
* Using "/usr/bin/python3" makes sense when you want the script to use
the dependencies that have been installed system-wide, for example
using packages from your distribution. This way, you kind-of control
which version of the dependencies are used: they are the one that are
packaged by the distribution. This is why it makes sense for Fedora's
guidelines to prefer this other /usr/bin/env.

By the way, I just got back from some holidays and I am reading the
messages from the mailing list after 1-2 months away. Therefore I
might have missed some context in your question that would make my
answer look like I am answering to something else. Sorry about that.

Best,
Nicolas


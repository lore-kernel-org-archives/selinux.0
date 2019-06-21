Return-Path: <SRS0=kEwY=UU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DA8C43613
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 15:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D5120673
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 15:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="b0ATrcWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfFUPpE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:45:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41083 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfFUPpE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jun 2019 11:45:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id s21so6382281lji.8
        for <selinux@vger.kernel.org>; Fri, 21 Jun 2019 08:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6wunovJg8BwXTrkq4m3n2UlWMWuzrWT4H0UoqV1eL1U=;
        b=b0ATrcWxGaE/0VCOltoDkNNDI9oWgM9OV6TE2WA1cfua5Mf5LSlcfVm90fO9aWnGBr
         6DlzAoDZxOucdKhOSTLt0+hU7yWFK5V4GEg8Sq3LbdWLl13e7DJKdniQb7heFDpZU4wf
         RkqRSwNyzQXeTS3YbT+YZSIEXCWxmxO7DvLGzFzHk4hCTcaP5PHo1KdT2Db39++iunci
         X7jHn+KoiygV5/3bjxYoM1K/FCAQyCKVogCMFdIX7sWnqnjnWfUovwWNuwj5m1gLSAd3
         I+aAN4SwSzRYkmnpLIdtmG0VT6RoKDBwZtXLte+NG1TLiTWsVoO1fUqJqNIysBb7i5Vt
         RrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6wunovJg8BwXTrkq4m3n2UlWMWuzrWT4H0UoqV1eL1U=;
        b=e3pj5MJ2rYSKbokZnwRSgOkQgdnobdaUS6p10reann91hc8n4anFXKet9X9IAmVl5U
         JBEGl6eePRtP6X8EBXy8oaAtMsIpkJX6X6EcyC1SFBa+gKBV06ksKHr9QAwfhFZguywa
         lv2eLW0ySJ9bt+JbOzLWSEyViV3QvzLu485HFCBkUcS1MgnGZjI/bb2q9wElXOl5AOmE
         VQNjk0Rk3ymhafT/+lLtUL+fm87IKlAekeuhqeT9TUG/2SOxHjTORF/46fo2xGHeM/uu
         Jo5GhBkDsG5Wy4SuY2Z0PUXm+E0v1uAj214QxHh3mc2rhWJ4Swhk6qDuubt0GN0gJjtk
         XBsg==
X-Gm-Message-State: APjAAAXwb9jd89yo25G1txGvP0eJZ6nOfru2C9ZytKlzHMxdTgaSImLw
        BSJrfV65Wh0hXQt1ROI9kPe93f+bJZDk3mDPX0ux
X-Google-Smtp-Source: APXvYqy3qvTGN7xx3GNDBVPWRDw8QnCTz9dbZ9P1UIubsYv3OyxspynJ7OWkIIOoUDHYXMSHMEAirbYoD0irjINm6SA=
X-Received: by 2002:a2e:9e1a:: with SMTP id e26mr7200997ljk.158.1561131901580;
 Fri, 21 Jun 2019 08:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190619142630.26648-1-sds@tycho.nsa.gov> <CAHC9VhQ1Bo-xpROgZa18MqxJSnTLoYoj6GbQR-pmDy2jSDs1bQ@mail.gmail.com>
 <a11f8817-ac26-ce5c-1b1d-20c310777a03@tycho.nsa.gov>
In-Reply-To: <a11f8817-ac26-ce5c-1b1d-20c310777a03@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Jun 2019 11:44:50 -0400
Message-ID: <CAHC9VhQViswrAHWZ6b4a4iAmErrumLLYHeNrZenqXrT+0FxP7w@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: fix old python shebang in tests/overlay/access
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 19, 2019 at 12:04 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 6/19/19 10:40 AM, Paul Moore wrote:
> > On Wed, Jun 19, 2019 at 10:26 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>
> >> /usr/bin/python is no longer installed by default, so this test
> >> script fails on default installs.
> >> Best practice guidance appears to be to switch to using
> >> /usr/bin/python3 instead, per
> >> https://docs.fedoraproject.org/en-US/packaging-guidelines/Python/
> >>
> >> Fixes: #46
> >> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> >> ---
> >>   tests/overlay/access | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > I think it would be better to reference the Python upstream guidance
> > regarding "python3" instead of the Fedora packaging guidelines.
> > Keeping things distro agnostic is a good goal whenever possible.
> >
> > * https://www.python.org/dev/peps/pep-0394
>
> When I looked for guidance in response to the github issue for
> selinux-testsuite [1], there seemed to be some ambiguity left by pep-0394:
>
> 1) It says "One exception to this is scripts that are deliberately
> written to be source compatible with both Python 2.x and 3.x. Such
> scripts may continue to use python on their shebang line.".  This leaves
> open the possibility of staying with "/usr/bin/python" as far as the pep
> is concerned since the script itself is not version-specific in any way,
> but doing so is not permitted by the Fedora guidelines and breaks on
> default installs of Fedora.

[SIDE NOTE: for some reason my mail is acting a bit odd - this got
buried in a folder and didn't bubble up like normal - my apologies on
the delay, I didn't see it until I was checking for patches today.]

Yes, I saw that too but considering that we are about six months away
from python2 going EOL I think it is reasonable to ignore python2 for
upstream work at this point.

> 2) It doesn't specify whether or not one should use "/usr/bin/env
> python3" or just "/usr/bin/python3".  The github issue reported had
> originally suggested the former, but this is also prohibited by the
> Fedora guidelines.

My initial reaction was that we should "/usr/bin/env" until I saw that
bit in the Fedora guidelines, which I honestly don't understand.  Does
anyone with a better understanding of cross-distro userspace know why
"/usr/bin/env" is bad?

> That's why I went with the Fedora guidelines.  Happy to use whatever but
> at least that particular PEP doesn't clearly motivate the use of
> "/usr/bin/python3" here.
>
> [1] https://github.com/SELinuxProject/selinux-testsuite/issues/46

Fair enough, I'll go ahead and merge it since it does fix a real
problem.  I did make once change to convert the "Fixes: #46" to use
the full URL, e.g. "Fixes: https://github.com..."; I think this helps
provide some necessary context (what if 10yrs from now we aren't on
github, what does "#46" reference?).

This is starting to stretch the topic a bit, but as far as "use
whatever" is concerned, I'd really like to see us keep moving towards
a more distro agnostic approach when it comes to upstream
development/testing/etc.  While SELinux has always had a "special"
relationship with Fedora/RH, we've seen SELinux grow quite a bit over
the years and I think it would be good to start trying to bring other
distros up to the same level as Fedora when it comes to SELinux
support.  I think one easy first step is to start looking beyond the
Fedora guidelines and see what other distros do/recommend.

> >> diff --git a/tests/overlay/access b/tests/overlay/access
> >> index 5a47eb145904..e50d5b402ebd 100755
> >> --- a/tests/overlay/access
> >> +++ b/tests/overlay/access
> >> @@ -1,4 +1,4 @@
> >> -#!/bin/python
> >> +#!/usr/bin/python3
> >>   import os, sys
> >>   try:
> >>           acc=eval("os.%s" % sys.argv[2])
> >> --
> >> 2.20.1
> >
>


-- 
paul moore
www.paul-moore.com

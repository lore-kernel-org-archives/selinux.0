Return-Path: <SRS0=5Yje=BN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805ABC433DF
	for <selinux@archiver.kernel.org>; Mon,  3 Aug 2020 16:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51744207FB
	for <selinux@archiver.kernel.org>; Mon,  3 Aug 2020 16:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9sLDdmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgHCQoC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCQoB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 12:44:01 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F493C06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 09:44:01 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id l17so21447480ilq.13
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 09:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sJNY4GucKnCVe7Sc9HLwx7xwBV83UFtyxYn7fEh/pY8=;
        b=l9sLDdmWYfaYjxNuPUjnzOe6QS6RM94j3I3rb2Vr6rQlsCGtwVcWCu1oNB5HEJdekz
         Lsj2hX/mB6mAAWPju4INwsuCh0x7KEMSPe9B8e12X8QJRmFxSgS1xfXtZbmM7ZEJR1HO
         b5PcIFKymQqc1LxZfxNhnhGRgqdLO1TwPel0Spe5kU3q5ZdHXpv8/McUioRlJH9wBZZK
         Rs/f1jaUOT9EHqFiT2ey0jBZ9vs9dtWaxzEgyUv7MWFun+QT1I+1OY+Ru6yDghlxTzCA
         XYqNp2ndFEMndEklsGnBMrPag9vcGDjK178anDJ3JJjt2GEAjqPASqxH8lRBeV2upvbF
         TEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sJNY4GucKnCVe7Sc9HLwx7xwBV83UFtyxYn7fEh/pY8=;
        b=XXV8iAWib01BM7CAQh0HXsuuCF7J5XPgBVJqK4ayGyJ1tKPpr0KEt+SQG3njf0E97G
         Qh2oZXkAyO/0skhqs+FygiRPnJT6IsCbQdjkvpSa57cQtTe8vnXKgFBFijyr9YadMrpE
         a9n7w8W7xh4JdNW6rIltihG7uRtYlX2WChC6loDGZdyk2OmE76C8jXCffoyrM9OQOm2G
         iRm9aW5qtBjBinjW+8aKzr+ijHAeQosDI0qKN6qmOGVfl/5lgSrDEZOyGByk0843W47w
         VqunCFzcTBNupymYAhzh+LVCVZSYkkpi5I+XnzgOs59Te/EPP+FcAAsPOluPnsW3NaNZ
         is2w==
X-Gm-Message-State: AOAM5335aC5TKP5b+xqETMyeA0S6sWlH9U9sMivdiLRV3aJr6KuJY3hR
        nKNY83qPstQd1RYwfR6CDr5SC7nYqRxH5JwRD5Q=
X-Google-Smtp-Source: ABdhPJy5IgsWMtiJ8ZK5exRCfmBfSHeRU+MOC3iiF9CeeBtrWsZybvi9ibp2sFLdYrpa0kTQm6XF+1cyys5MgBu1e5w=
X-Received: by 2002:a92:aa4b:: with SMTP id j72mr235130ili.141.1596473040778;
 Mon, 03 Aug 2020 09:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNvh9q4qTSN-Fj108JrO8DAfMiDkOzTDHs6n3Pxg+DOtXg@mail.gmail.com>
 <20200803151428.15166-1-william.c.roberts@intel.com> <CAFqZXNtTZio0-9_T9yheg0JmUP-TDa2OsUkgvHrNphGCrjhMVg@mail.gmail.com>
In-Reply-To: <CAFqZXNtTZio0-9_T9yheg0JmUP-TDa2OsUkgvHrNphGCrjhMVg@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 3 Aug 2020 11:43:49 -0500
Message-ID: <CAFftDdpwud0FtuaoUE1ABgYtMwr3+kcF-hww88+eDHdz5oGLSw@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/ci: license as MIT
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        "Roberts, William C" <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 3, 2020 at 11:31 AM Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
>
> On Mon, Aug 3, 2020 at 5:14 PM <bill.c.roberts@gmail.com> wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > License the ci scripts with a permissive, OSI approved license, such as
> > MIT.
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  v1: Apache 2.0
> >  v2: MIT
> >
> >  scripts/ci/LICENSE               | 7 +++++++
> >  scripts/ci/fedora-test-runner.sh | 2 +-
> >  scripts/ci/travis-kvm-setup.sh   | 2 +-
> >  3 files changed, 9 insertions(+), 2 deletions(-)
> >  create mode 100644 scripts/ci/LICENSE
> >
> > diff --git a/scripts/ci/LICENSE b/scripts/ci/LICENSE
> > new file mode 100644
> > index 000000000000..6cd7b7924ef9
> > --- /dev/null
> > +++ b/scripts/ci/LICENSE
> > @@ -0,0 +1,7 @@
> > +Copyright <YEAR> <COPYRIGHT HOLDER>

You don't actually need them. They are often never updated anyways
after the initial. I can just drop that line, wget + git add.

>
> You should probably put an actual year/name here?
>
> > +
> > +Permission is hereby granted, free of charge, to any person obtaining =
a copy of this software and associated documentation files (the "Software")=
, to deal in the Software without restriction, including without limitation=
 the rights to use, copy, modify, merge, publish, distribute, sublicense, a=
nd/or sell copies of the Software, and to permit persons to whom the Softwa=
re is furnished to do so, subject to the following conditions:
> > +
> > +The above copyright notice and this permission notice shall be include=
d in all copies or substantial portions of the Software.
> > +
> > +THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRES=
S OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILIT=
Y, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL =
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER =
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FRO=
M, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS I=
N THE SOFTWARE.
> > diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-=
runner.sh
> > index 569723387f6b..0aaba87c421b 100755
> > --- a/scripts/ci/fedora-test-runner.sh
> > +++ b/scripts/ci/fedora-test-runner.sh
> > @@ -1,5 +1,5 @@
> >  #!/usr/bin/env bash
> > -
> > +# SPDX-License-Identifier: MIT
>
> As I said in the v1 thread, also the individual files should contain a
> copyright line in addition to the SPDX line. See:
> https://matija.suklje.name/how-and-why-to-properly-write-copyright-statem=
ents-in-your-code#why-have-the-copyright-statement

You don't actually need them and they just clutter the code and as a
policy, I don't participate in adding to the problem of these big
blocks
of copyright statements that need to be maintained and grow per
contributor. I can just drop the SPDX identifiers, as the LICENSE file
applies to everything.

With version control, the issues as described by that author are less
of a problem. We can easily
trace from whom, by how and when code was modified for any legal
issues if they were to arise.

We can just keep the LICENSE file, drop the SPDX identifiers and I
would be 100% in-line with that libselinux is currently doing.

>
> >  set -ev
> >
> >  #
> > diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-set=
up.sh
> > index 8d4cfb79f7d7..2b5734178096 100755
> > --- a/scripts/ci/travis-kvm-setup.sh
> > +++ b/scripts/ci/travis-kvm-setup.sh
> > @@ -1,5 +1,5 @@
> >  #!/usr/bin/env bash
> > -
> > +# SPDX-License-Identifier: MIT
> >  set -ev
> >
> >  TEST_RUNNER=3D"scripts/ci/fedora-test-runner.sh"
> > --
> > 2.17.1
> >
>
> --
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel
> Red Hat, Inc.
>

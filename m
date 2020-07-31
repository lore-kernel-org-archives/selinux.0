Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE08C433E0
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 21:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A06C2087C
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 21:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGJ9+BoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgGaVYL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 17:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbgGaVX1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 17:23:27 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3E8C061574
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 14:23:27 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id a5so17784492ioa.13
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F33Y9iw5SDN7AzPZTWHrdUBgMERzUNGJg8vvHYX4+PQ=;
        b=GGJ9+BoWjHmI6isrWsD7fhVL411dFKJy/4EqbmORAkDPTomGPZHA8WQ9ocdbartdnL
         STFSvckzght+ANFasjd6iuB7IIk4N6Ehb4EPh8ivdXaIF3Wac5wG+6vX4jA8Er+oULel
         v06y+G46a+rrz+cEs2+z5skcJWSivWfYhDVFuJPubYRV5fzRXE2xlsYrfuvp2RNz/pLo
         36g3KfgG0b5/hc2+Z7Dol+GjTW3fn3A3QH1G9C2fdOkYBw24y0iN6gbArubqc3cw3vpC
         STo8mth8m0nZkvyWSMQvnYqrgjYVWDFPNzofgwSFIMO30mi0CKqsm3kl9CQWf3Mrckao
         SNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F33Y9iw5SDN7AzPZTWHrdUBgMERzUNGJg8vvHYX4+PQ=;
        b=MiT2axZ7gcUU/7wobEGNsn2Hum4UG6xhupGfZM8kVwvXSKnr3yiaih/mqSgCcTrz9R
         f5nvIogiZni0s7B8sWdMvKEbDFjUszSiNNH9g/K+RAYZYILyhGbZER0CRGAXqbTkap8p
         9MQZWG+SvJoVyEYDes7ra/OKCvQzwq63vMG6SWFkrb6Zjkay10JuZWx+JuIXPccW2mEH
         FECSNQAto+bGBd/xtezDE0sg8xQpmO4+jxDt6a3wFoFbUtGmO5Cz0MRmmor3dE47wtQA
         5QzrYhEVrKjs0WV7l29SFClI7ebnqsIXoadkAzhWfW11uWPIb9Z2+JyH2figJkMgKEx5
         SMiA==
X-Gm-Message-State: AOAM5327DOA7D09KzqJJ300CGcDV9eLE2Dk/6twYIEof0RUv2hgrv5Y2
        7Ui9pyFhQQHQA09yK/1qwDL/XoGW0nrQRTs9vxg9/kYt
X-Google-Smtp-Source: ABdhPJyedwAj4TNwqeP7hr68UAH01F8pidUUgUm+lbFHdBe4X4ICtmJ8CVmxBhuYO0OLxRDSYirv8DtfkLL6GM1uKpc=
X-Received: by 2002:a5e:c30f:: with SMTP id a15mr5616182iok.184.1596230606381;
 Fri, 31 Jul 2020 14:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdo2XOU1iH1Gn1bf8UF7VLHVXF9wuop9SOHj44P4pet-kQ@mail.gmail.com>
 <20200731173309.31528-1-william.c.roberts@intel.com> <CAFqZXNtnzP=F_-n_6VRuEnErqmFex0x0C7z5nP=970-n-4aurw@mail.gmail.com>
In-Reply-To: <CAFqZXNtnzP=F_-n_6VRuEnErqmFex0x0C7z5nP=970-n-4aurw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 31 Jul 2020 16:23:03 -0500
Message-ID: <CAFftDdr6RQLX7odto1uC2SWHTO4ukHD7xHAo1Frr202kab5fiw@mail.gmail.com>
Subject: Re: [PATCH] scripts/ci: license as Apache 2.0
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 31, 2020 at 4:11 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, Jul 31, 2020 at 7:33 PM <bill.c.roberts@gmail.com> wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > License the ci scripts with a permissive, OSI approved license, such as
> > Apache 2.0.
>
> Thanks! On second thought though, I guess any open source license
> would be fine, since the scripts don't "link" with the rest of the
> testsuite (which is GPLv2). So if you prefer some more permissive (or
> shorter... :) license or just public domain, you can probably use
> that, too.

I can do MIT, does that work?

>
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  scripts/ci/LICENSE               | 202 +++++++++++++++++++++++++++++++
> >  scripts/ci/fedora-test-runner.sh |   2 +-
> >  scripts/ci/travis-kvm-setup.sh   |   2 +-
> >  3 files changed, 204 insertions(+), 2 deletions(-)
> >  create mode 100644 scripts/ci/LICENSE
> >
>
> <snip>
>
> > diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
> > index 569723387f6b..8d6a572eb094 100755
> > --- a/scripts/ci/fedora-test-runner.sh
> > +++ b/scripts/ci/fedora-test-runner.sh
> > @@ -1,5 +1,5 @@
> >  #!/usr/bin/env bash
> > -
> > +# SPDX-License-Identifier: Apache-2.0
>
> I think you should also add a copyright line alongside the SPDX header. See:
> https://matija.suklje.name/how-and-why-to-properly-write-copyright-statements-in-your-code#why-have-the-copyright-statement
>
> >  set -ev
> >
> >  #
> > diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup.sh
> > index 8d4cfb79f7d7..275d05299971 100755
> > --- a/scripts/ci/travis-kvm-setup.sh
> > +++ b/scripts/ci/travis-kvm-setup.sh
> > @@ -1,5 +1,5 @@
> >  #!/usr/bin/env bash
> > -
> > +# SPDX-License-Identifier: Apache-2.0
>
> Ditto.
>
> >  set -ev
> >
> >  TEST_RUNNER="scripts/ci/fedora-test-runner.sh"
> > --
> > 2.17.1
> >
>
> --
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel
> Red Hat, Inc.
>

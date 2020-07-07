Return-Path: <SRS0=l4yV=AS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59028C433DF
	for <selinux@archiver.kernel.org>; Tue,  7 Jul 2020 12:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 311FB206F6
	for <selinux@archiver.kernel.org>; Tue,  7 Jul 2020 12:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgGGMi3 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Tue, 7 Jul 2020 08:38:29 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:43973 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGMi3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jul 2020 08:38:29 -0400
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 2F39BFF804;
        Tue,  7 Jul 2020 12:38:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAEjxPJ77YoCyVyg3nxqvTyGQ9tCjTb42MY4=iBD7xvf4Hg7sGg@mail.gmail.com>
References: <20200701150627.1643297-1-antoine.tenart@bootlin.com> <CAEjxPJ77YoCyVyg3nxqvTyGQ9tCjTb42MY4=iBD7xvf4Hg7sGg@mail.gmail.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
From:   Antoine Tenart <antoine.tenart@bootlin.com>
Subject: Re: [PATCH] policycoreutils: setfiles: do not restrict checks against a binary policy
Cc:     SElinux list <selinux@vger.kernel.org>,
        matthew.weber@rockwellcollins.com, thomas.petazzoni@bootlin.com
Message-ID: <159412550586.3168.2908808236021605887@kwain>
Date:   Tue, 07 Jul 2020 14:38:26 +0200
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello Stephen,

Quoting Stephen Smalley (2020-07-07 14:26:59)
> On Wed, Jul 1, 2020 at 11:13 AM Antoine Tenart
> <antoine.tenart@bootlin.com> wrote:
> > diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
> > index ed67b5f12245..4844875cfc6b 100644
> > --- a/policycoreutils/setfiles/setfiles.c
> > +++ b/policycoreutils/setfiles/setfiles.c
> > @@ -48,10 +48,9 @@ static __attribute__((__noreturn__)) void usage(const char *const name)
> >                         name, name);
> >         } else {
> >                 fprintf(stderr,
> > -                       "usage:  %s [-diIDlmnpqvEFW] [-e excludedir] [-r alt_root_path] spec_file pathname...\n"
> > -                       "usage:  %s [-diIDlmnpqvEFW] [-e excludedir] [-r alt_root_path] spec_file -f filename\n"
> > -                       "usage:  %s -s [-diIDlmnpqvFW] spec_file\n"
> > -                       "usage:  %s -c policyfile spec_file\n",
> > +                       "usage:  %s [-diIDlmnpqvEFW] [-e excludedir] [-r alt_root_path] [-c policyfile] spec_file pathname...\n"
> > +                       "usage:  %s [-diIDlmnpqvEFW] [-e excludedir] [-r alt_root_path] [-c policyfile] spec_file -f filename\n"
> > +                       "usage:  %s -s [-diIDlmnpqvFW] spec_file\n",
> >                         name, name, name, name);

> 
> You didn't update the number of name arguments to reflect the format
> string change above.

Sorry for that, I'll fix it for v2!

Thanks,
Antoine

> make[2]: Entering directory
> '/home/travis/build/stephensmalley/selinux/policycoreutils/setfiles'
> clang -O2 -Werror -Wall -Wextra -Wmissing-format-attribute
> -Wmissing-noreturn -Wpointer-arith -Wshadow -Wstrict-prototypes
> -Wundef -Wunused -Wwrite-strings -fno-common
> -I/home/travis/build/stephensmalley/selinux/installdir/usr/include
> -DUSE_AUDIT   -c -o setfiles.o setfiles.c
> setfiles.c:54:22: error: data argument not used by format string
>       [-Werror,-Wformat-extra-args]
>                         name, name, name, name);
>                                                          ^^

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

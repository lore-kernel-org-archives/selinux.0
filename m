Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0D9C43217
	for <selinux@archiver.kernel.org>; Wed,  9 Nov 2022 13:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiKINsB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Nov 2022 08:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKINsA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Nov 2022 08:48:00 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0FD15820
        for <selinux@vger.kernel.org>; Wed,  9 Nov 2022 05:47:58 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g7so25696742lfv.5
        for <selinux@vger.kernel.org>; Wed, 09 Nov 2022 05:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T4EUH6TLKPA80EyhwCR4Onr5V433+qrA6jqeU5r1xdQ=;
        b=UE7QpKKjVHOIot8Or8X9W3bmkJh5aPndnhHdaf/uEDt+Ehdx7Ru5s/IEqoKRL6zSiP
         nORg6az2Rc8Ao6vau7SnuQkFHjdhatXmEQ4Q6mylz/JuXuIFJL2gvJzOC30f+qu5mp4e
         +djjjvQMzwMPgcjUiLECdIKRfLW5z+rjg7CQP17CgbilVctN93HhOvI+pcauZCLHbKkm
         BB56D3GPMJ/VimHQQ35a6YV7WlwcqMKspOkaJ0vLoFTuQqB+Avn1H/4dGKttrnGA4Ast
         TlCLOIEvOFCQ2aaUILdaZdR9cZGqn+DA90RUBrl5e3EPBN016hdxjlRVl2T0HTywV2yc
         VUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4EUH6TLKPA80EyhwCR4Onr5V433+qrA6jqeU5r1xdQ=;
        b=OOzy06z25YTv6GJaDXIbTQvmGfnDghJvG1ZIOYK7eDHWnfz4bWU0s7boJiEmk8AB/T
         SHDzSHiO0VLRBNX47GbVd/xH2dDmImiTy06q5e3TtHWF2rhnn1cH+bnEcM5GoT6HFsc4
         tl6KvxPfnX7wlLbG3oonXq9nLxF0ooKsvmCHkTjk/7baGO53glMbI32Wlnx5ZUi1tMMI
         rUJOtd7qwaEaBj5LdQ7MSDTe1uC/5R5tMXTdaiVVkyTbNNM9kF9dbd7WnXPdxji5Zikq
         OwTK9WkYhfcL2EUnCCGB/dFC8wO86YV1kYKidk/QPK9QPQhBQZtumFuDPhmc2vr/gKf+
         89rQ==
X-Gm-Message-State: ACrzQf093TGUulPHQruUaiCl+eYPp+lt5aG+U6fwMSk5F2nf0WQ0+bRU
        YZQLtbGLuG4r4UFvJhV82e0u1DE9LZNsB3iJXXM=
X-Google-Smtp-Source: AMsMyM63UCFzGrhLydGxLGeQ8zMAFdPygcabSgq74J5qp2TI6vrrcoglmlt/g5NoVNy5wTD+98WgPVYlKh5EhDsFw40=
X-Received: by 2002:a19:7704:0:b0:4a4:5d9d:2f66 with SMTP id
 s4-20020a197704000000b004a45d9d2f66mr23108132lfc.515.1668001676816; Wed, 09
 Nov 2022 05:47:56 -0800 (PST)
MIME-Version: 1.0
References: <20221018203659.2329808-1-vmojzis@redhat.com> <CAP+JOzQBwgOwctaqT6ZQxTLXb5MF=FOhkagjbprqwvc4nEcbYQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQBwgOwctaqT6ZQxTLXb5MF=FOhkagjbprqwvc4nEcbYQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 9 Nov 2022 08:47:45 -0500
Message-ID: <CAP+JOzTvFBrOqsVNLLdH5z-pyvmpMv82GLoY-UAfJw-h8B9Ybw@mail.gmail.com>
Subject: Re: [PATCH] python: Harden tools against "rogue" modules
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 4, 2022 at 4:03 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Oct 18, 2022 at 4:40 PM Vit Mojzis <vmojzis@redhat.com> wrote:
> >
> > Python scripts present in "/usr/sbin" override regular modules.
> > Make sure /usr/sbin is not present in PYTHONPATH.
> >
> > Fixes:
> >   #cat > /usr/sbin/audit.py <<EOF
> >   import sys
> >   print("BAD GUY!", file=sys.stderr)
> >   sys.exit(1)
> >   EOF
> >   #semanage boolean -l
> >   BAD GUY!
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim


> > ---
> >  python/audit2allow/audit2allow    | 2 +-
> >  python/audit2allow/sepolgen-ifgen | 2 +-
> >  python/chcat/chcat                | 2 +-
> >  python/semanage/semanage          | 2 +-
> >  python/sepolicy/sepolicy.py       | 2 +-
> >  5 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/python/audit2allow/audit2allow b/python/audit2allow/audit2allow
> > index 09b06f66..eafeea88 100644
> > --- a/python/audit2allow/audit2allow
> > +++ b/python/audit2allow/audit2allow
> > @@ -1,4 +1,4 @@
> > -#!/usr/bin/python3 -Es
> > +#!/usr/bin/python3 -EsI
> >  # Authors: Karl MacMillan <kmacmillan@mentalrootkit.com>
> >  # Authors: Dan Walsh <dwalsh@redhat.com>
> >  #
> > diff --git a/python/audit2allow/sepolgen-ifgen b/python/audit2allow/sepolgen-ifgen
> > index b7a04c71..f2cc0c32 100644
> > --- a/python/audit2allow/sepolgen-ifgen
> > +++ b/python/audit2allow/sepolgen-ifgen
> > @@ -1,4 +1,4 @@
> > -#!/usr/bin/python3 -Es
> > +#!/usr/bin/python3 -EsI
> >  #
> >  # Authors: Karl MacMillan <kmacmillan@mentalrootkit.com>
> >  #
> > diff --git a/python/chcat/chcat b/python/chcat/chcat
> > index 952cb818..68718ec5 100755
> > --- a/python/chcat/chcat
> > +++ b/python/chcat/chcat
> > @@ -1,4 +1,4 @@
> > -#!/usr/bin/python3 -Es
> > +#!/usr/bin/python3 -EsI
> >  # Copyright (C) 2005 Red Hat
> >  # see file 'COPYING' for use and warranty information
> >  #
> > diff --git a/python/semanage/semanage b/python/semanage/semanage
> > index 10ab3fa6..b21d1484 100644
> > --- a/python/semanage/semanage
> > +++ b/python/semanage/semanage
> > @@ -1,4 +1,4 @@
> > -#!/usr/bin/python3 -Es
> > +#!/usr/bin/python3 -EsI
> >  # Copyright (C) 2012-2013 Red Hat
> >  # AUTHOR: Miroslav Grepl <mgrepl@redhat.com>
> >  # AUTHOR: David Quigley <selinux@davequigley.com>
> > diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
> > index c7a70e09..733d4048 100755
> > --- a/python/sepolicy/sepolicy.py
> > +++ b/python/sepolicy/sepolicy.py
> > @@ -1,4 +1,4 @@
> > -#!/usr/bin/python3 -Es
> > +#!/usr/bin/python3 -EsI
> >  # Copyright (C) 2012 Red Hat
> >  # AUTHOR: Dan Walsh <dwalsh@redhat.com>
> >  # see file 'COPYING' for use and warranty information
> > --
> > 2.37.3
> >

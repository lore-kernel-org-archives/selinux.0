Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDACC433E0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 21:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B732F206D4
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 21:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkjXgTla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgEOVUj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 17:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726183AbgEOVUj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 17:20:39 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056C8C061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 14:20:39 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id e18so4226049iog.9
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 14:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6crtBayhUtzPIqa4MYg/S8hYHH6Svjd7O5MkTFs/G8Q=;
        b=UkjXgTlaKWXlMNyZyT2+kcZZGcmo1I3Y+XFd0nOoMR3EEoNBrXPaqovVbDp3YxgANI
         +AQU5cj8rxu53Zk+57MYGYdbgS66aMAMeyi9/EYn1usDo+O5zisbZ8yrbY63yutVv3z+
         VPR5NE4BPi9nuK+P31XoP6KEtJLz/UVfB4chkrQ+dgcf3VThd4nTQTdRkjHFjnCXUj+n
         Xar8cO+EqCvtXpeZL/DtNoZTjJjsl6PU2aUTfB0Nn3MRsFQWHR9AVrYFs1CcYoX2D1lU
         jHZUkdNXI78N+pBbyFsA7UnKc84lF8gdWa3g2GIIF04SHh6oT2+yuHCfo3Ztxd/XdFI/
         sVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6crtBayhUtzPIqa4MYg/S8hYHH6Svjd7O5MkTFs/G8Q=;
        b=UL1nFmjcBlnSOQ0f9/8/g9sNr0UAzzx8urTygxRmShihV6UQVfmpPUM8LUrbvMIi/K
         yWg5/sCmsCHYQ+VtKkydrV7Rk2/cE3DizsYTo5iV92umrqqaddhk+OP5OSk3A0zIJeiF
         HQ8PM+5pZUNg1XB7+jw+4tClM0/cDjQulb6Ef64SIWCU7ce/y+ov9xua2YK/eOSzxJZg
         XRMuxTQMjmPWDs+1JaB0BUciM+XkekAdL2l0tVrx3eVqeg/G3BAu1QZmeuVxrviqRaak
         1HhLnAe/a3GGIjhRLo2KGXApTshkhbDCwWGHbS842UiUHpipIU0Bkh84aA4foyuMj4Tl
         LzIg==
X-Gm-Message-State: AOAM533InCswdJgUzGRKxz4G9Spf/jAisE8m6XPsCj2ghTFVvPbGesjU
        4lH1g5X+2IWg5e9aaTwxc6lwNSuHRlCfAkpvvCFe1nM/
X-Google-Smtp-Source: ABdhPJxyvvHPyoDrTedM6O6T8yt8Qans4NqvM0ZaS0bR1PXpGYnLaaHBZVI0rmByLSwOJvm7lqZiO/Y0GVLf4FGwzB8=
X-Received: by 2002:a02:bb8a:: with SMTP id g10mr5328360jan.130.1589577638025;
 Fri, 15 May 2020 14:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200515173042.12666-1-william.c.roberts@intel.com>
 <20200515210154.23408-1-william.c.roberts@intel.com> <CAHC9VhSmRjeeujGCxscNuRg_805ObqAM26qyg6SAzNjUxLOxNw@mail.gmail.com>
In-Reply-To: <CAHC9VhSmRjeeujGCxscNuRg_805ObqAM26qyg6SAzNjUxLOxNw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 15 May 2020 16:20:26 -0500
Message-ID: <CAFftDdq331RLTzmQo3qNPDJjbSMWmrW8ch-ZxmXFcz9jDCWr0w@mail.gmail.com>
Subject: Re: [PATCH v2] README: update kernel-devel package in dnf command
To:     Paul Moore <paul@paul-moore.com>
Cc:     William Roberts <william.c.roberts@intel.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 15, 2020 at 4:09 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, May 15, 2020 at 5:02 PM <william.c.roberts@intel.com> wrote:
> >
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > The README.md file in the selinux-testsuite states that kernel-devel
> > package is needed. However, for everything to work you need the
> > kernel-devel package specific to your kernel version.
> > Update the dnf command to include uname -r, so that a copy + paste
> > of the dnf command, results in a system with dependencies filled
> > for recent Fedora distro's like Fedora 32.
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  README.md | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/README.md b/README.md
> > index 1f7e5d92a100..4d5d6d22203a 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -74,7 +74,7 @@ following command:
> >                 attr \
> >                 libbpf-devel \
> >                 keyutils-libs-devel \
> > -               kernel-devel \
> > +               kernel-devel-$(uname -r)
>
> I \
> think \
> you \
> forgot \
> the \
> trailing \
> slash \

fsck \

>
> >                 quota \
> >                 xfsprogs-devel \
> >                 libuuid-devel
> > --
> > 2.17.1
>
> --
> paul moore
> www.paul-moore.com

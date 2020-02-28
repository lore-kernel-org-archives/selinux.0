Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59817C3F2CD
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 13:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A23D2051A
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 13:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjlKwEXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgB1N7Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:59:16 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:42964 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1N7Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 08:59:16 -0500
Received: by mail-il1-f193.google.com with SMTP id x2so2755893ila.9
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 05:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KbgjzTbJgVVanrcVQjS2hVGO3l/VSlXUGGStosnj3eY=;
        b=MjlKwEXIHpPNJk1Tq8PE/IWcwpFBVHxKnydTMB8AYgpaBDbipBwLBKs/0xgWi3NM7n
         MuXOfbx5x4/zCkNKXvLDouIlfWfbabWZYmzOslyOI2WMXQHGIb5AaU2gqFX3LEaeDLJy
         N0NKmTySWOo4kq1qVS5Ik4nKNnXv6c0BMEqvfvcm5QEH1OuKB2yrleWNLWR96iDox2V3
         +uKUahxQUnfFBBDsRjtytUsM1h0oQ0fFLmZxC8j3jnfHE31PTw4NwbgDCFk+aVm2bB0x
         +F3fjCtC5eVuKYNZ/+8u01juKVm7BnEkSDxlSj/k1OiJaaisumpsCECSExs3J01Ug8IM
         Yp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbgjzTbJgVVanrcVQjS2hVGO3l/VSlXUGGStosnj3eY=;
        b=jVnjoB8PqHwASJYrDp0rguolIU1StPLPa3QfJap8ZQjlVgd2TtYRgDOEUochsL1A/5
         L/rPA7Z9G5QoYUA5BouRizlFdDE3shvVFi+ZQdJ/pIUHCR/oPqXgX5PYXFB9IHOUD6+v
         ds7wSHF3Wz2DV7IpkC/6Qb3LSBfOArsfMz1xGVsW79jXS70jqrxpeleEqk2C6Kx+fHTs
         nwS6zqY3CirVvQshgVqtNlKOCLtn/UMEPjw7FAzslVb4cpEa/6lcT5OFQXkpVuqR0sos
         Ll6yvgN4kd3KSDbVZnADHKN7g++C1G47rS7VtC50m99PEhpa8uoKRGNak07Ii0GjwiOS
         veTA==
X-Gm-Message-State: APjAAAUW1b3vV781Z8h9u3l8EnDESo+q1iPsD09uCcv3MLoy3e7nPHTf
        hp2+/uECLOIZ9LH7gK/hpusVkk9pYgn4u/3QpBE=
X-Google-Smtp-Source: APXvYqyGV8Im3F0RSPu51lRjDahxMQbRiyLd55eOWfjxueZC8mODbt9z3gkNXJZYTy5+jIkacManlK0VhnxEN5JGaiU=
X-Received: by 2002:a92:811c:: with SMTP id e28mr4635901ild.22.1582898355508;
 Fri, 28 Feb 2020 05:59:15 -0800 (PST)
MIME-Version: 1.0
References: <20200227230129.31166-1-william.c.roberts@intel.com>
 <20200227230129.31166-3-william.c.roberts@intel.com> <CAEjxPJ7bLsGHQ4-wz19ntft=GYvWMLL5bZd8hAimbu1hzc5+Ew@mail.gmail.com>
In-Reply-To: <CAEjxPJ7bLsGHQ4-wz19ntft=GYvWMLL5bZd8hAimbu1hzc5+Ew@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 28 Feb 2020 07:59:03 -0600
Message-ID: <CAFftDdrNcbOWGa-o3TaeagF1TL7NnFxk2Osm_rembw+HH1wACw@mail.gmail.com>
Subject: Re: [PATCH 2/3] Makefile: add -fno-semantic-interposition
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 28, 2020 at 7:50 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Feb 27, 2020 at 6:01 PM <bill.c.roberts@gmail.com> wrote:
> >
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > Add -fno-semantic-interposition to CFLAGS. This will restore
> > the DSO infrastructures protections to insure internal callers
> > of exported symbols call into libselinux and not something laoding first
> > in the library list.
> >
> > Clang has this enabled by default.
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
>
> I'm fine with this but since Nicolas pointed out the option of using
> -Bsymbolic to
> the linker as an alternative to hidden_def/hidden_proto in
> https://github.com/SELinuxProject/selinux/issues/204#issuecomment-591092288
> I was wondering how they differ.  I guess -Bsymbolic only affects the
> linker while -fno-semantic-interposition
> permits the compiler to further optimize the code.

That's my understanding of the difference as well. -B is only link
time, so the compiler can't
really optimize the calls, but IIUC the compiler can only optimize
whats in the compilation
unit, so it can only optimize call sites for calls within the compilation unit.

-B also only works for elf builds, so we would conditionally need to
modify LDFLAGS based
on host type. The compiler option is just a clang/gcc split, which is
already there. To go
to symbolic we would have to conditionally set that... a tad bit more work :-p

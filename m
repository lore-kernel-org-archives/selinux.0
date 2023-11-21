Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCDBC61D92
	for <selinux@archiver.kernel.org>; Tue, 21 Nov 2023 14:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjKUOKH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Nov 2023 09:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbjKUOKF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Nov 2023 09:10:05 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795F1D79
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 06:10:02 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507bd19eac8so7329229e87.0
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 06:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700575801; x=1701180601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgGfmrg2Yq6wlq7Bd5/MlFhtoGVXUcWXVRuoSId1oHs=;
        b=QKEbdf0JeGCmof7o54oBtY/U0Vymos7T3+qvQ5mjajY6dJyFJ1OLwQUGoQ7yfy0+wu
         Kpj/q9uGSiPQUP6ySiXguVckEUdsZEinscZ94kPJsHHV1/JFW17E4G5lQV7s1THm484x
         8izods2nPmKrnwNhoFIVi8tJYf+8lp805tFmRetfUBDM0XZk/K4yjOCGzk2w9V72wioS
         x3fzcfJ+8DSz5GqxpUz6sxNnBMOL35N22rpctctnbfaC7ogfFFW7AykZQqRGjn/xq3lM
         OoSh7OJ/OED1SJ3kIbgzkU0S7ao/VC44QETC2uvWHrjkKnEC1AXQiF+fsoUdgI1r/Ngc
         zjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700575801; x=1701180601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgGfmrg2Yq6wlq7Bd5/MlFhtoGVXUcWXVRuoSId1oHs=;
        b=R3eB72kWtE8FUzyMQChs0Xls+jeNH5+E64yh12BoEDvbTz45iB8mt/iNx7Ya8CIwwi
         jHeoFTRIOLFyt8rO2fW0ZvKMWdF74IYdBCC4HPSEoeyrCT/jvO8TYUtFxcpW3kx+fOhu
         kPxdoXaIkuzKtjEQUWHDiIPnpN2dUjGHtJs2eyNZP1E2PqfmLvUa3Kp3N5fKfr0n4uGy
         P8zf4zdCD7yx9uH6kyfdaeb7inixKsoBdWEVyiig2/9crRSKMy3Vo4+yu0iYpuSOat+L
         jJI5WN/m1MEW60aTLOkVMFqnc3zrbCnpNr5Y6PLV8g584mDPnr/ACA6NUpmrmZvYMr6d
         fN7A==
X-Gm-Message-State: AOJu0Yw1GnzkYTUGdAVilKhaSHSsY7aXuVwZX1RWjR2vfYvsjFif4+6q
        yK1BuxYhxMaHXARN3WoLHYvKNNgtNU1L0CFUo/s=
X-Google-Smtp-Source: AGHT+IHApOCYZSH7tdnLE6WN68iy7+ogr6SPiVPr7UIvj/e6MEFHwZj8ymQt/5iVOlqj+sqt9aVeSzOAMTll8+QxaRI=
X-Received: by 2002:a19:7019:0:b0:508:1975:5b1d with SMTP id
 h25-20020a197019000000b0050819755b1dmr7227138lfc.3.1700575800450; Tue, 21 Nov
 2023 06:10:00 -0800 (PST)
MIME-Version: 1.0
References: <20231115233207.51845-1-luhuaxin1@huawei.com> <CAP+JOzQUYrXWZjRKxBCdQdVZYsA9kCaXGUwhBCAoCfMfig6dQw@mail.gmail.com>
In-Reply-To: <CAP+JOzQUYrXWZjRKxBCdQdVZYsA9kCaXGUwhBCAoCfMfig6dQw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 21 Nov 2023 09:09:49 -0500
Message-ID: <CAP+JOzQB-Va8nrdpuA1vhWUS+d7Di-aby1Lo1NwDnNOUFCQCXQ@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: add check for category value before printing
To:     luhuaxin1@huawei.com
Cc:     selinux@vger.kernel.org, fangxiuning@huawei.com,
        zhujianwei7@huawei.com, shenyining@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 16, 2023 at 12:56=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Wed, Nov 15, 2023 at 9:04=E2=80=AFPM <luhuaxin1@huawei.com> wrote:
> >
> > From: Huaxin Lu <luhuaxin1@huawei.com>
> >
> > In mls_semantic_level_expand(), there is a explicitly determine
> > whether category is 0, which may cause an potential integer
> > overflow in error branch.
> >
> > Signed-off-by: Huaxin Lu <luhuaxin1@huawei.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/expand.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > index ee5f9185..9ed22bfd 100644
> > --- a/libsepol/src/expand.c
> > +++ b/libsepol/src/expand.c
> > @@ -945,8 +945,8 @@ int mls_semantic_level_expand(mls_semantic_level_t =
* sl, mls_level_t * l,
> >         for (cat =3D sl->cat; cat; cat =3D cat->next) {
> >                 if (!cat->low || cat->low > cat->high) {
> >                         ERR(h, "Category range is not valid %s.%s",
> > -                           p->p_cat_val_to_name[cat->low - 1],
> > -                           p->p_cat_val_to_name[cat->high - 1]);
> > +                           cat->low > 0 ? p->p_cat_val_to_name[cat->lo=
w - 1] : "Invalid",
> > +                           cat->high > 0 ? p->p_cat_val_to_name[cat->h=
igh - 1] : "Invalid");
> >                         return -1;
> >                 }
> >                 for (i =3D cat->low - 1; i < cat->high; i++) {
> > --
> > 2.33.0
> >

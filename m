Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA43C433F5
	for <selinux@archiver.kernel.org>; Thu, 20 Jan 2022 16:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376943AbiATQQQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Jan 2022 11:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376926AbiATQP5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Jan 2022 11:15:57 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E85C061574
        for <selinux@vger.kernel.org>; Thu, 20 Jan 2022 08:15:50 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id z25-20020a0568301db900b005946f536d85so8171978oti.9
        for <selinux@vger.kernel.org>; Thu, 20 Jan 2022 08:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TsJCNFRXbPSb0YY7hChgdV3FzJZYgVbZCk6noqfiPOs=;
        b=YbwT5d2SP8SdsuFrS9Bf46j3ZQRYckLCNY1Qu9rFgmHmx9Tclsv58TAVszZWyCSIvY
         In4M3D4P0qfrWsK2Sdjf65FtaZ8Ra/H0lzGfhnwYph3FBAFrJxRkEdhRxnao7497lU8R
         kofW7aKM734B+8jZl7Jth5evN0SnhLPZaNXHsofKSozT/ru4W60EZFuhqhLs1Tlzli23
         m+sI15tqomSXbGNz1eH8sS2wIP4sovXCoCJOm+9IDN+dyjEQtPmo8NMk+C3QNqYbq09b
         S/IXrQo25rFxCDco12WKF1irLWWm9ic3+F707LV+bT65sKWQWmpm81QTlN7SkZ94bxrI
         oVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TsJCNFRXbPSb0YY7hChgdV3FzJZYgVbZCk6noqfiPOs=;
        b=Le2nl/TMk+EJRgv0oZw2NuegNqgTX+tEHDKPt0M0yrVP+FieGT9bBFuoKvIv2a9PL4
         jybqzVrWkHLcKOJfYBj+hNgiqB3rJG88/DUn/vt69mu/a9pHncB1TmVyfX063cceLDhv
         RBwmieR5xBs0phiVTjTgRvyiDDxe1g+l4cq8zWsno7L+jSkmAm6GV6C+GEkmTIiIXbLw
         juh4cecAu6noUEBmqraTo8zhKe6Bo5Q5xG+DMnjZNIvZcBixZMp9kp4b8DUbsiEFWBS+
         rhOBwlb1pGIsbxI0BcdmGHQ7XFin+Un4I2X+swxipdJ2wBCn4PgxMeJu2HrTNowSPmBR
         klzw==
X-Gm-Message-State: AOAM532osnvG43wMtZfAXCW8SbT+sjull8nhpfNHptrnOijX253JgHlB
        2ui62hZCy4EvnmRXo3sKku5VZpVaA9la6q6GUpRvblCxSHJnEQ==
X-Google-Smtp-Source: ABdhPJyjI2WHTCuYajLtaZrjBx1e+zzSSatElx6hfdHSoR+/0TI/s9dI43yIoTYaAhGdeTFwaSjmRCc5tnm0/kbz5VA=
X-Received: by 2002:a05:6830:24ac:: with SMTP id v12mr23418450ots.117.1642695349510;
 Thu, 20 Jan 2022 08:15:49 -0800 (PST)
MIME-Version: 1.0
References: <20220117150200.24953-1-cgzones@googlemail.com> <CAP+JOzRj5EY20ATmHhk2PsYOTabmBDRuxQKNYZtqgkU7ky-Ozg@mail.gmail.com>
In-Reply-To: <CAP+JOzRj5EY20ATmHhk2PsYOTabmBDRuxQKNYZtqgkU7ky-Ozg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 20 Jan 2022 17:15:38 +0100
Message-ID: <CAJ2a_DdE_4Y=htZTefgb+X1UnXRNjCyb_CfEbcg=_N8u5VAoBw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: reject invalid roles before inverting
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 19 Jan 2022 at 20:18, James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Jan 17, 2022 at 9:34 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Since the role datums have not been validated yet, they might be invali=
d
> > and set to an enormous high value. Inverting such an ebitmap will take
> > excessive amount of memory and time.
> >
> > Found by oss-fuzz (#43709)
> > ---
> >  libsepol/src/expand.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > index 898e6b87..3fc54af6 100644
> > --- a/libsepol/src/expand.c
> > +++ b/libsepol/src/expand.c
> > @@ -2481,6 +2481,10 @@ int role_set_expand(role_set_t * x, ebitmap_t * =
r, policydb_t * out, policydb_t
> >
> >         /* if role is to be complimented, invert the entire bitmap here=
 */
> >         if (x->flags & ROLE_COMP) {
> > +               /* inverting an ebitmap with an invalid highbit will ta=
ke aeons */
> > +               if (ebitmap_length(r) > p->p_roles.nprim)
> > +                       return -1;
> > +
> >                 for (i =3D 0; i < ebitmap_length(r); i++) {
> >                         if (ebitmap_get_bit(r, i)) {
> >                                 if (ebitmap_set_bit(r, i, 0))
> > --
> > 2.34.1
> >
>
> One would think that ebitmap_length() would be the right function, but
> actually it will return the highest position in the bitmap without
> regard to whether it is set or not. Since the ebitmap has 64 bit
> nodes, it will be a multiple of 64.
>
> The function you want to use here is ebitmap_highest_set_bit().

On a second thought: does this inverting even work?

Consider `p->p_roles.nprim` being 42, the highest bit in the current
ebitmap being 32, and thus the length/highbit being 64.
The highest bit 32 is less than 42 so that's fine.
But then the inversion inverts all bits up to `ebitmap_length()`
(=3D64), so now the highest bit is 64, which is bigger than
`p->p_roles.nprim`.
The ebitmap now has a role set that is not defined, some further
operations might fail, and any subsequent validation will fail (e.g.
in `validate_ebitmap()`).
git-blame[1] shows this code was introduced with the initial import
from svn and also the flag ROLE_COMP is otherwise unused (with an
exception in the test binary dismod).
checkpolicy(8) does not accept role complements, e.g. `user sys_user
roles ~sys_role;` or `allow role1 ~role2;` are invalid.

Maybe the inversion would be safe if the upper bound was
`p->p_roles.nprim` not `ebitmap_length()`?


[1]: https://github.com/SELinuxProject/selinux/blame/master/libsepol/src/ex=
pand.c

>
> Thanks,
> Jim

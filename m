Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC76C433F5
	for <selinux@archiver.kernel.org>; Fri,  8 Oct 2021 16:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297886101E
	for <selinux@archiver.kernel.org>; Fri,  8 Oct 2021 16:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhJHQiU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Oct 2021 12:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhJHQiL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Oct 2021 12:38:11 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C565C061570
        for <selinux@vger.kernel.org>; Fri,  8 Oct 2021 09:36:16 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id y207so11315734oia.11
        for <selinux@vger.kernel.org>; Fri, 08 Oct 2021 09:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fAnN9i4RJJa20dB40TaFgL7FzJ9eHbuycOgPHEuEY3A=;
        b=HryOlIVLUVs+A6IJpaWUpAJ6ywU+kr1in6f4GFQCuTDuicMBO2qZ2jskU8d+7/GKKt
         zg8eyPMPxd2OJ8G5Y2m4nyxUOrUmw71aM5YwCR2XdqXgeFyqYKOLQladJsl21htINwe7
         1NAj2xdMwWXQlyyuqj7Gce00voUy01PLE0Hj/39UrVO3q8H/3GQNK8wpqa0EaASkcTlI
         20RjASP7lWbgWmeGx84M5RKYJe3B1xF12+YRKKmVIC/BSyjhL9blul6cVocoVyfmFFwi
         T3cep0BgMzxx+3ORtm3aUw+eHt+HGvdOnm88f9Ff5vqaKbu2B4YZ9SZmGFzswFjTNpGY
         aljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fAnN9i4RJJa20dB40TaFgL7FzJ9eHbuycOgPHEuEY3A=;
        b=wElC/eN5rxxPH5lDs32+n2rZlK8IE5ZCjGhjaQvDTJJvjj2MnSWar7oRi4/UjHkTS3
         qX6E1KKGL8kFu/JkhGh9XIPPZfhUarxi9PbUbtMSLzqceVCBSnpAa8xYhcIJedbySNcp
         ejKGqtWplQghlOuYFPp47HgLpXcHd3YO+ZdzN4P5ebFVvOO1Ou71fOR14o6IhVQmrg7C
         5qjO4kwhA72HLzl4I6LiDIFKYsfGmMsp+EImRdNE4MnM2jd3usx/ENqiaVcYXl5TefXs
         6rKpe5g807yJtk00Dw3M4fLZNRlQpuOevbUi3v+fpS1CvlsfPqS5GSGY5PvTchUDzb+K
         5ltg==
X-Gm-Message-State: AOAM533pZNGrXUfsKj6HghZTnIoW/OTQ5k1tw+ZMV9o7nrRCdrE63N3j
        CGzzeAtydVEkCcEFAjV1NcFQFtPOyyBK/UlH4delDTqz
X-Google-Smtp-Source: ABdhPJzGnmqmWaon/86lxvbFr95kaAUJa8amcjQ4LTVL2kZLbeHhhkQDm2JJEN1DR/Lril+bTi+m9qe+rBSsIhMTt7I=
X-Received: by 2002:a05:6808:545:: with SMTP id i5mr8216021oig.16.1633710975264;
 Fri, 08 Oct 2021 09:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211008144921.377072-1-jwcart2@gmail.com> <CAJ2a_DfvP5GuHqUoe9pmyHgWWcJk1kx9wypJZcXy_PcFG862Qg@mail.gmail.com>
In-Reply-To: <CAJ2a_DfvP5GuHqUoe9pmyHgWWcJk1kx9wypJZcXy_PcFG862Qg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 8 Oct 2021 12:36:04 -0400
Message-ID: <CAP+JOzRsmNVJ5=G+BBQ_auC+3KBcrSNAm=QdpuO0b0cihrcN4w@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix potential undefined shifts
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 8, 2021 at 12:06 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Fri, 8 Oct 2021 at 16:49, James Carter <jwcart2@gmail.com> wrote:
> >
> > The maximum number of permissions in a class is 32. This is so that
> > each permission can be represented by a bit in a uint32_t. In two
> > places while building the binary policy from CIL an expression of the
> > form "1 << x" is used to set the permission bit. Unfortunately, this
> > expression is undefined if x =3D=3D 31 because the 1 is an int and cann=
ot
> > be left shifted by 31.
> >
> > Instead, use 1U << x, because an unsigned can be shifted 31.
> >
> > This bug was found by the secilc-fuzzer.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_binary.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binar=
y.c
> > index ec5f01e5..90af430d 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -1225,7 +1225,7 @@ int __perm_str_to_datum(char *perm_str, class_dat=
um_t *sepol_class, uint32_t *da
> >                         goto exit;
> >                 }
> >         }
> > -       *datum |=3D 1 << (sepol_perm->s.value - 1);
> > +       *datum |=3D 1U << (sepol_perm->s.value - 1);
> >
> >         return SEPOL_OK;
> >
> > @@ -4760,7 +4760,7 @@ static struct cil_list *cil_classperms_from_sepol=
(policydb_t *pdb, uint16_t clas
> >         cil_list_init(&cp->perms, CIL_PERM);
> >         for (i =3D 0; i < sepol_class->permissions.nprim; i++) {
> >                 struct cil_perm *perm;
> > -               if ((data & (1 << i)) =3D=3D 0) continue;
> > +               if ((data & (1U << i)) =3D=3D 0) continue;
> >                 perm =3D perm_value_to_cil[class][i+1];
> >                 if (!perm) goto exit;
> >                 cil_list_append(cp->perms, CIL_PERM, perm);
> > --
> > 2.31.1
> >
>
> There might be more instances (not in libsepol/cil though), as a
> simple `grep -REi "1\s*<<"` shows (false positives removed by hand):
>
> libselinux/src/stringrep.c:                             return
> map_perm(tclass, 1<<i);
> libselinux/src/stringrep.c:                     if ((1<<i) & av)
> libselinux/src/stringrep.c:                     str =3D
> security_av_perm_to_string(tclass, av & (1<<i));
> libselinux/src/stringrep.c:                     str =3D
> security_av_perm_to_string(tclass, av & (1<<i));
> libselinux/src/mapping.c:                       if (tperm & (1<<i)) {
> libselinux/src/mapping.c:                               tperm &=3D ~(1<<i=
);
> libselinux/src/mapping.c:                               tperm |=3D 1<<i;
> libselinux/src/mapping.c:                               result |=3D 1<<i;
> libselinux/src/mapping.c:                               result |=3D 1<<i;
> libselinux/src/mapping.c:                               result |=3D 1<<i;
> libselinux/src/mapping.c:                               result |=3D 1<<i;
> libselinux/src/mapping.c:                               result |=3D 1<<i;
> libselinux/src/mapping.c:                               result |=3D 1<<i;
> libselinux/src/mapping.c:                               result |=3D 1<<i;
> libselinux/src/mapping.c:                       result |=3D 1<<i;
> mcstrans/src/mcscolor.c:                        mask |=3D (1 << i);
> mcstrans/src/mcscolor.c:                if (!(mask & (1 << i)))
> python/audit2allow/sepolgen-ifgen-attr-helper.c:                if (av
> & (1 << i)) {
> checkpolicy/policy_define.c:                    node->permissions |=3D
> (1 << (perdatum->s.value - 1));
> checkpolicy/checkpolicy.c:                                      if
> (avd.allowed & (1 << (i - 1))) {
> libsepol/src/conditional.c:                                 (test &
> (0x1 << j)) ? 1 : 0;
> libsepol/src/conditional.c:
> cn->expr_pre_comp |=3D 0x1 << test;
> libsepol/src/services.c:                *av =3D 0x1 << (perm_datum->s.val=
ue - 1);
> libsepol/src/services.c:                *av =3D 0x1 << (perm_datum->s.val=
ue - 1);
> libsepol/src/avtab.c:   nslot =3D 1 << shift;

Thanks, I just searched for them in the CIL code. I will take a look at the=
se.
Jim

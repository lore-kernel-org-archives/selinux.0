Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FE7C433F5
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 17:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD1B60F3A
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 17:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhJLRyT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Oct 2021 13:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbhJLRyH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Oct 2021 13:54:07 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC53C061771
        for <selinux@vger.kernel.org>; Tue, 12 Oct 2021 10:51:59 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so379124otb.1
        for <selinux@vger.kernel.org>; Tue, 12 Oct 2021 10:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPZvWYoblRxQbHYsgHaLAEErMWnmv98BbWRNHRNprc4=;
        b=Lnq2xfSPTrcOSm14UvmBczrsE4R4LUd7uh6lsP5pjpC/xmVzO4Yr25SmSGaZENCAQh
         jYK3ianp+LEmhgiHN6hzedBiQLfrVLaJ9SvgQBhCwa1sPL9fD9xorX+VO3NqIItOa8bV
         qrtNDydZoAliomoUefQ/N+pvS6pRn95+JDSufWGWny905l1f90IQw5NL60Submt4GxsA
         jPzZhDLyhkNrzvZK7h0IvA9VoIndiJjoZ/0JhJl3PYDW1MFWt8DeCBMToNbHutj/BY+A
         HyEQ3gtDU7B04kCSz1J2ICWjJRHASiPzhBnf/H7FLfRBBfnEc6PhedP0Rh75LSaKM/xD
         stjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPZvWYoblRxQbHYsgHaLAEErMWnmv98BbWRNHRNprc4=;
        b=UQCwresbDyaIrZzDX9igqTBaAZqOwNVCrbqz3FM3l1Y1RCO45E13yFeCa11Hbf15Fi
         +VhndGQ2hBxR6oR326wnEM158toAf042P82MzYv8C7oFw7/Gu+VOS+g5DoLoEd57OFT8
         CAH5gLOMabXT7ZuiGyNwSv7885tcjWhJ+Y76JCMQVMLHWvPo+bLsKtXVdjDaV00Wj1Ey
         dVIajzvRmfxY7dVAZPTncIpXMTrxDsy8zi2WwvfzOao1yw+LEEcKqbMnNu/uXY3BRyZo
         DWUrynQjovpAOaJlTgnbun8awaek5KzoQfjq9pinwcOFTXrGSAGEZeD1wMkey0qNhNhF
         5xFQ==
X-Gm-Message-State: AOAM533ZxFRIGxYKzEonekMdTedCXN0i77Q9ryHML/ZY125ui4Ytl9TF
        aWHQf4mioOrvHG0A1X9HldELnwKXUHHLcVlqVO1xY3X3
X-Google-Smtp-Source: ABdhPJy6Jno87tfK9OL/k1Z77wnJ319st6AD1UKkxxva6OXg/JQnDwX5wMSEoN1heRfYS/KC4hjQ22bzB9PALTCAlSw=
X-Received: by 2002:a05:6830:1acc:: with SMTP id r12mr27587753otc.154.1634061118814;
 Tue, 12 Oct 2021 10:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211008211031.393884-1-jwcart2@gmail.com> <20211008211031.393884-2-jwcart2@gmail.com>
 <CAJfZ7==x_JoFDf+XYz8jjMESzS609L0XomuaXM=3i3e_iEcuNw@mail.gmail.com>
In-Reply-To: <CAJfZ7==x_JoFDf+XYz8jjMESzS609L0XomuaXM=3i3e_iEcuNw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 12 Oct 2021 13:51:48 -0400
Message-ID: <CAP+JOzTBQJZSMPDHKJZ6XoRbkJWQ8Hhb-E9La21rH0pKv5+4ug@mail.gmail.com>
Subject: Re: [PATCH 2/4] libsepol/cil: Fix potential undefined shifts
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Oct 10, 2021 at 4:40 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Fri, Oct 8, 2021 at 11:10 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > An expression of the form "1 << x" is undefined if x == 31 because
> > the "1" is an int and cannot be left shifted by 31.
> >
> > Instead, use "UINT32_C(1) << x" which will be an unsigned int of
> > at least 32 bits.
> >
> > This bug was found by the secilc-fuzzer.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_binary.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> > index ec5f01e5..34dc63c7 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -1225,7 +1225,7 @@ int __perm_str_to_datum(char *perm_str, class_datum_t *sepol_class, uint32_t *da
> >                         goto exit;
> >                 }
> >         }
> > -       *datum |= 1 << (sepol_perm->s.value - 1);
> > +       *datum |= UINT32_C(1) << (sepol_perm->s.value - 1);
> >
> >         return SEPOL_OK;
> >
> > @@ -1523,7 +1523,7 @@ int cil_avrule_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_
> >  /* index of the u32 containing the permission */
> >  #define XPERM_IDX(x) (x >> 5)
> >  /* set bits 0 through x-1 within the u32 */
> > -#define XPERM_SETBITS(x) ((1U << (x & 0x1f)) - 1)
> > +#define XPERM_SETBITS(x) (UINT32_C(1) << (x & 0x1f)) - 1)
>
> There is a missing parenthesis here: "UINT32_C(1)" -> "(UINT32_C(1)"
>
> Other than this, the 4 patches look good to me:
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

I fixed the missing parenthesis and merged these patches.
Thanks,
Jim

> Thanks!
> Nicolas
>
> >  /* low value for this u32 */
> >  #define XPERM_LOW(x) (x << 5)
> >  /* high value for this u32 */
> > @@ -4760,7 +4760,7 @@ static struct cil_list *cil_classperms_from_sepol(policydb_t *pdb, uint16_t clas
> >         cil_list_init(&cp->perms, CIL_PERM);
> >         for (i = 0; i < sepol_class->permissions.nprim; i++) {
> >                 struct cil_perm *perm;
> > -               if ((data & (1 << i)) == 0) continue;
> > +               if ((data & (UINT32_C(1) << i)) == 0) continue;
> >                 perm = perm_value_to_cil[class][i+1];
> >                 if (!perm) goto exit;
> >                 cil_list_append(cp->perms, CIL_PERM, perm);
> > --
> > 2.31.1
> >
>

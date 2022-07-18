Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F523C433EF
	for <selinux@archiver.kernel.org>; Mon, 18 Jul 2022 20:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiGRUrk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Jul 2022 16:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGRUrk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Jul 2022 16:47:40 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92E37669
        for <selinux@vger.kernel.org>; Mon, 18 Jul 2022 13:47:39 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-10c0e6dd55eso27053565fac.7
        for <selinux@vger.kernel.org>; Mon, 18 Jul 2022 13:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zCGU3b7+ljmZ+twjZ4faSKDlhSWlR9ECAkKO0js9Knw=;
        b=RS/qHACbt0WdSqfvot8bh6u+ncGGkMxqOxaJHJhr5hx+OdclKiS5IZ5E7OpQx/GVDL
         R2oIvLyWCTntFFyZOi7x1cUGffM22kjuPJikh1MpvMo9vAgFnedgPcPMXZVhgsPA73eV
         +aOl00T8I1ADYV4VHSSQJoJLUPe91VFhh9VXYia3vNefFhqSID2udcJecbiYB32RxyMQ
         dX5nwDbQu/1ekl8mpSU8AzMoXbEhe50Urciy4rDHnhD7lNHuWGPROdrE6uoc6XfNVMAo
         VuEmkS0WL1Qr28F5XBF5uEe4j/6lojOpa9XV4QAkbQHtM6CPUAB7dRuHt9y6OhFKpYfE
         96uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zCGU3b7+ljmZ+twjZ4faSKDlhSWlR9ECAkKO0js9Knw=;
        b=XixgOhwsiEPdnKL4TpipZuKkpZKWUhkkSpClw/XGhBsHoBZ8Dmgf/1iH7GlcbR6xAk
         GDlhFh7wdCTZelnCrfQ8e2PvG2EtMfUFUwmwPqttA85q7E04mRCty7Ln+wtAxHvmKU5n
         fZxOj46+rCxu6DpkQv6cMfZTjrxMDiXadHnIKbEqtcuer8rgkzj+1W0fmZQ+2vKRScF2
         XiL02FRA9wUbl/TP9T5S53zkRgV0q324wxiTafq2lYq4O27O7hFIuoHjKD7zhnhA0YlW
         T6epzUStl64WMZTiN8ttKaLfD4q4omVj0tXuD/HSzDDcCXSkSXry8Dply9RFPtbgliso
         4qyQ==
X-Gm-Message-State: AJIora+YG50D2eTElAzSCh2J1CvPx51iy4V28rOVLmDz6sVp23/Io0QY
        uXcpxtH21WpbuJkSH/yemhPdhIqREId1q7+CUuwJGtFW
X-Google-Smtp-Source: AGRyM1sb4jeqGaMV9Lb7rsgMq6Wt+sD+dvw5f1tYSBAErEqAyp0zH9kdKWxFvshKpqJjXQkIjOmEFNBWyMBO8wi9n7k=
X-Received: by 2002:a05:6870:b017:b0:10c:ce5a:ac4 with SMTP id
 y23-20020a056870b01700b0010cce5a0ac4mr15883732oae.182.1658177259070; Mon, 18
 Jul 2022 13:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220712160858.22677-1-cgzones@googlemail.com> <20220712160858.22677-5-cgzones@googlemail.com>
In-Reply-To: <20220712160858.22677-5-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 18 Jul 2022 16:47:28 -0400
Message-ID: <CAP+JOzRPUkLV1zJ=bzyQ4Zou5DiKxtxF2_UiBoF1r8FQ1Lz3aA@mail.gmail.com>
Subject: Re: [PATCH 5/7] libsepol: optimize ebitmap_and
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 12, 2022 at 12:09 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Iterate on nodes instead of single bits to save node resolution for each
> single bit.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/ebitmap.c | 42 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 7 deletions(-)
>
> diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> index 6a63e559..c3d706e9 100644
> --- a/libsepol/src/ebitmap.c
> +++ b/libsepol/src/ebitmap.c
> @@ -74,15 +74,43 @@ int ebitmap_union(ebitmap_t * dst, const ebitmap_t * =
e1)
>
>  int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2=
)
>  {
> -       unsigned int i, length =3D min(ebitmap_length(e1), ebitmap_length=
(e2));
> +       const ebitmap_node_t *n1, *n2;
> +       ebitmap_node_t *new, *prev =3D NULL;
> +
>         ebitmap_init(dst);
> -       for (i=3D0; i < length; i++) {
> -               if (ebitmap_get_bit(e1, i) && ebitmap_get_bit(e2, i)) {
> -                       int rc =3D ebitmap_set_bit(dst, i, 1);
> -                       if (rc < 0)
> -                               return rc;
> -               }
> +
> +       n1 =3D e1->node;
> +       n2 =3D e2->node;
> +       while (n1 && n2) {
> +               if (n1->startbit =3D=3D n2->startbit) {
> +                       if (n1->map & n2->map) {
> +                               new =3D malloc(sizeof(ebitmap_node_t));
> +                               if (!new) {
> +                                       ebitmap_destroy(dst);
> +                                       return -ENOMEM;
> +                               }
> +                               new->startbit =3D n1->startbit;
> +                               new->map =3D n1->map & n2->map;
> +                               new->next =3D NULL;
> +
> +                               if (prev)
> +                                       prev->next =3D new;
> +                               else
> +                                       dst->node =3D new;
> +                               prev =3D new;
> +                       }
> +
> +                       n1 =3D n1->next;
> +                       n2 =3D n2->next;
> +               } else if (n1->startbit > n2->startbit)
> +                       n2 =3D n2->next;
> +               else
> +                       n1 =3D n1->next;

I would like to see braces around the last two clauses.

Thanks,
Jim

>         }
> +
> +       if (prev)
> +               dst->highbit =3D prev->startbit + MAPSIZE;
> +
>         return 0;
>  }
>
> --
> 2.36.1
>

Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C51C00140
	for <selinux@archiver.kernel.org>; Mon,  8 Aug 2022 15:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiHHPEQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Aug 2022 11:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiHHPEP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Aug 2022 11:04:15 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC730B855
        for <selinux@vger.kernel.org>; Mon,  8 Aug 2022 08:04:14 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id o184so794152oif.13
        for <selinux@vger.kernel.org>; Mon, 08 Aug 2022 08:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=t+dz9QO6CsfcNDBj2wvtyWZuh5etLW1GgyPSxHTVVDU=;
        b=GpIh6zeT61RHddRyqewj5BdzzGlpFoUUp2ZuKAW1umiQiAnyyo64pHjDaH7NDusI9K
         TI08hh2te6avBUdS3Wz+yhCV9iYZqiRKwkxEAblqA3AV1yISGp9os9B+/06spLLYinQj
         1Ra3THfS26OyUhM8RC8owiEc6Mwch9Ep3T3E5qJtKBL9mo7Prwp6r8UZz4NjC6jfUCCB
         1ADFUKxRXqfBVV/NlE9EonjJfVjd/nAFgTbXoE0pGUq0KZSGJYtBVyAF+A/O9SPl99/t
         +vym5iQZDXww1eV2aySNEXFlqkdayh1FPQ+OwfxsPCZsSopAJVrkyoqekOhJIKpeQVa2
         Cqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=t+dz9QO6CsfcNDBj2wvtyWZuh5etLW1GgyPSxHTVVDU=;
        b=7qyduDbbis/0THl1fJr6mNLK0qp50DHzsbOFeIF4uEtMRmlpWNqCd6zf0WwubygNOI
         i6G4pswUBeymPqCtz+GNODsT/dAbgB+2foR3ruReU+HIGJBw24XYlwji9ARH1gApeR/C
         0PIIX6miAIh7hvY1CdMFxuHhP9OXE96NNH/chCHp+6g7u8UKnTvDZuI5qTIaFfeK1bIM
         WF2/Oa642Cyd1p6RNh1/cpLRd+6TbQd6K0UbXXgzcGPGoMfirUG/gy/Yhuat9TGvY16U
         mp6yTyTQ4kOCITfFw+PGWuTpScdjU8gG01CXeQq7IktsLijEPPb1xmpP3/YVAORT5RQP
         kxQg==
X-Gm-Message-State: ACgBeo0hquXC2/peKBg1yaihlt1HPmSJrPmQzluGnl5lglswZb1qhVO3
        QFJrj4oXz19QyEO+nfTXBLRuNXXuDpLYYMV8WyM=
X-Google-Smtp-Source: AA6agR61W2t922eHadv05CPmzqocggyA64jFtSAiATlFTgZThMFYA36C+C3W7d+VnLWKVeM/NxineCA0eOHiLCRolhw=
X-Received: by 2002:a05:6808:2091:b0:342:c50e:a2ef with SMTP id
 s17-20020a056808209100b00342c50ea2efmr5679282oiw.182.1659971053914; Mon, 08
 Aug 2022 08:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220721150515.19843-1-cgzones@googlemail.com> <20220721150515.19843-2-cgzones@googlemail.com>
In-Reply-To: <20220721150515.19843-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 8 Aug 2022 11:04:03 -0400
Message-ID: <CAP+JOzTyEgSO5PNyzBEnXChaeH_nQ-QmPdoqyC2np+xwU0QQtg@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] libsepol: add ebitmap iterator wrapper with startnode
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 21, 2022 at 11:11 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Similar like ebitmap_for_each_bit() iterates over all bits of an ebitmap
> add ebitmap_for_each_bit_starting() iterating over all bits starting
> from a specific node and bit, which can be from an outer iteration.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2:
>    * use _after suffix
>    * reorder parameters
> ---
>  libsepol/include/sepol/policydb/ebitmap.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include=
/sepol/policydb/ebitmap.h
> index 81d0c7a6..4696805f 100644
> --- a/libsepol/include/sepol/policydb/ebitmap.h
> +++ b/libsepol/include/sepol/policydb/ebitmap.h
> @@ -80,6 +80,13 @@ static inline int ebitmap_node_get_bit(const ebitmap_n=
ode_t * n, unsigned int bi
>  #define ebitmap_for_each_positive_bit(e, n, bit) \
>         ebitmap_for_each_bit(e, n, bit) if (ebitmap_node_get_bit(n, bit))=
 \
>
> +#define ebitmap_for_each_bit_after(e, n, bit, startnode, startbit) \
> +       n =3D startnode; \
> +       for (bit =3D ebitmap_next(&n, startbit); bit < ebitmap_length(e);=
 bit =3D ebitmap_next(&n, bit)) \
> +

It would be better to only use one statement:

for (n =3D startnode, bit =3D ebitmap_next(&n, startbit); ...

Thanks,
Jim


> +#define ebitmap_for_each_positive_bit_after(e, n, bit, startnode, startb=
it) \
> +       ebitmap_for_each_bit_after(e, n, bit, startnode, startbit) if (eb=
itmap_node_get_bit(n, bit)) \
> +
>  extern int ebitmap_cmp(const ebitmap_t * e1, const ebitmap_t * e2);
>  extern int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebitm=
ap_t * e2);
>  extern int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1);
> --
> 2.36.1
>

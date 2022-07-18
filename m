Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487ABC43334
	for <selinux@archiver.kernel.org>; Mon, 18 Jul 2022 20:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbiGRUoY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Jul 2022 16:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiGRUoL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Jul 2022 16:44:11 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D399C2659
        for <selinux@vger.kernel.org>; Mon, 18 Jul 2022 13:44:09 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10bd4812c29so27026799fac.11
        for <selinux@vger.kernel.org>; Mon, 18 Jul 2022 13:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MoPnUe/4QL9H+jAx/wb530GIMdJp4adjzwsea8OfLS8=;
        b=WjPs+H4h6jMyUIKpuZZ9qbKLqoQPSV7QIkw4iDGicITT45hkY5NvPAd/oro7lsNgtA
         EOh44OxJrIlhWU2pQRCjYUbHCnx4OTQkXCRXJAckI3OlqLoTTJNjNbbSlg9ZOybDhmVc
         NffThLGAjjXor35ORcQqCAhckCV2i3FvrE2NTDclRjpoMxrH8/d9A9mFYk6fwBP/ilDW
         FSG7A8m1yruMonEdcTCYsFy0i5ilXynA+3pFZjS7aKKHiVIFmS3apJtAS1BjRN3xgPtf
         wczMPlwDd1BcUJTsml3CAqXddhM3oTt1DiIrCCkP8oQtsjuphblBPPmapZ9QdMenDktl
         UBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MoPnUe/4QL9H+jAx/wb530GIMdJp4adjzwsea8OfLS8=;
        b=dF3ZmTxT97Y5N+oomx4aiOA+RC1+odYWHZx373ggDuMrQragqHb0DPNjYbx1sdFord
         hir02ZLTc1AXiU05YanoDm91i2kCzOHEnbl392K96ugKSm/gQNfzsYpleDQwIq1uQUHY
         IqBsIdTzzHifNmh/a6oQKVZgxqcHKXw37kmGt/OCP5IwROviblCzdKFntbGQ+c/GjzLK
         FLtq95vv7vt+C1ZyPtAq1X9ltZhQRPBgyWmKjkY18M7uYpZmRVSwupnQY9T1W9eyQpD2
         HQv4t1El1wOFikcvwI9w3pGigt8ry0PXzKNt6f/Mzmxg/33ZAeAeJtnLUZgvnFa8Vsps
         +kbA==
X-Gm-Message-State: AJIora9IA1UBShtI4CrRtNvaA93L9a5y5griCGMP+Ip5Y0wbrIVXrQkJ
        Z7YDlcxg5KxyBtyZlHzKoU7ii5C1Vw0fjS/qHJwhOl8p
X-Google-Smtp-Source: AGRyM1uc02HZzX9Q90U+sk8wEwtWKQDtlhggkwuL8BECU9F1k3DG2rnROoU9vSTecQq36l4ib9NBtqlshvEb+cbX1dY=
X-Received: by 2002:a05:6808:1496:b0:33a:6d79:1e0c with SMTP id
 e22-20020a056808149600b0033a6d791e0cmr4847454oiw.182.1658177049166; Mon, 18
 Jul 2022 13:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220712160858.22677-1-cgzones@googlemail.com> <20220712160858.22677-2-cgzones@googlemail.com>
In-Reply-To: <20220712160858.22677-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 18 Jul 2022 16:43:58 -0400
Message-ID: <CAP+JOzSaD2yqstwEsseuHjh3XvDR7WRXJ2AH_oyHq4XWtT7tnQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] libsepol: add ebitmap_init_range
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
> Add an initializer for ebitmaps that sets all bits in a given range to
> save node traversals for each bit to set, compared to calling
> ebitmap_init() followed by iterating ebitmap_set_bit().
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/include/sepol/policydb/ebitmap.h |  1 +
>  libsepol/src/ebitmap.c                    | 49 +++++++++++++++++++++++
>  libsepol/tests/test-ebitmap.c             | 32 +++++++++++++++
>  3 files changed, 82 insertions(+)
>
> diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include=
/sepol/policydb/ebitmap.h
> index 81d0c7a6..85b7ccfb 100644
> --- a/libsepol/include/sepol/policydb/ebitmap.h
> +++ b/libsepol/include/sepol/policydb/ebitmap.h
> @@ -94,6 +94,7 @@ extern int ebitmap_contains(const ebitmap_t * e1, const=
 ebitmap_t * e2);
>  extern int ebitmap_match_any(const ebitmap_t *e1, const ebitmap_t *e2);
>  extern int ebitmap_get_bit(const ebitmap_t * e, unsigned int bit);
>  extern int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value);
> +extern int ebitmap_init_range(ebitmap_t * e, unsigned int minbit, unsign=
ed int maxbit);
>  extern unsigned int ebitmap_highest_set_bit(const ebitmap_t * e);
>  extern void ebitmap_destroy(ebitmap_t * e);
>  extern int ebitmap_read(ebitmap_t * e, void *fp);
> diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> index bd98c0f8..fb20e994 100644
> --- a/libsepol/src/ebitmap.c
> +++ b/libsepol/src/ebitmap.c
> @@ -349,6 +349,55 @@ int ebitmap_set_bit(ebitmap_t * e, unsigned int bit,=
 int value)
>         return 0;
>  }
>
> +int ebitmap_init_range(ebitmap_t * e, unsigned int minbit, unsigned int =
maxbit)
> +{
> +       ebitmap_node_t *new, *prev =3D NULL;
> +       uint32_t minstartbit =3D minbit & ~(MAPSIZE - 1);
> +       uint32_t maxstartbit =3D maxbit & ~(MAPSIZE - 1);
> +       uint32_t minhighbit =3D minstartbit + MAPSIZE;
> +       uint32_t maxhighbit =3D maxstartbit + MAPSIZE;
> +       uint32_t startbit;
> +       MAPTYPE mask;
> +
> +       ebitmap_init(e);
> +
> +       if (minbit > maxbit)
> +               return -EINVAL;
> +
> +       if (minhighbit =3D=3D 0 || maxhighbit =3D=3D 0)
> +               return -EOVERFLOW;
> +
> +       for (startbit =3D minstartbit; startbit <=3D maxstartbit; startbi=
t +=3D MAPSIZE) {
> +               new =3D malloc(sizeof(ebitmap_node_t));
> +               if (!new)
> +                       return -ENOMEM;
> +
> +               new->next =3D NULL;
> +               new->startbit =3D startbit;
> +
> +               if (startbit !=3D minstartbit && startbit !=3D maxstartbi=
t)
> +                       new->map =3D ~((MAPTYPE)0);
> +               else if (startbit !=3D maxstartbit)
> +                       new->map =3D ~((MAPTYPE)0) << (minbit - startbit)=
;
> +               else if (startbit !=3D minstartbit)
> +                       new->map =3D ~((MAPTYPE)0) >> (MAPSIZE - (maxbit =
- startbit + 1));
> +               else {
> +                       mask =3D ~((MAPTYPE)0) >> (MAPSIZE - (maxbit - mi=
nbit + 1));
> +                       new->map =3D (mask << (minbit - startbit));
> +               }
> +

I view braces in if-else statements as all or nothing. If you need
them for one clause, then use them for all clauses.

Everything else about this patch looks good.

Thanks,
Jim


> +               if (prev)
> +                       prev->next =3D new;
> +               else
> +                       e->node =3D new;
> +               prev =3D new;
> +       }
> +
> +       e->highbit =3D maxhighbit;
> +
> +       return 0;
> +}
> +
>  unsigned int ebitmap_highest_set_bit(const ebitmap_t * e)
>  {
>         const ebitmap_node_t *n;
> diff --git a/libsepol/tests/test-ebitmap.c b/libsepol/tests/test-ebitmap.=
c
> index a21f18c0..1a49aa5f 100644
> --- a/libsepol/tests/test-ebitmap.c
> +++ b/libsepol/tests/test-ebitmap.c
> @@ -135,6 +135,37 @@ static void test_ebitmap_set_and_get(void)
>         ebitmap_destroy(&e);
>  }
>
> +static void test_ebitmap_init_range(void)
> +{
> +       ebitmap_t e1, e2, e3, e4, e5, e6;
> +
> +       CU_ASSERT_EQUAL(ebitmap_init_range(&e1, 0, 0), 0);
> +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e1), 1);
> +
> +       CU_ASSERT_EQUAL(ebitmap_init_range(&e2, 0, 5), 0);
> +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e2), 5);
> +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e2), 6);
> +
> +       CU_ASSERT_EQUAL(ebitmap_init_range(&e3, 20, 100), 0);
> +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e3), 100);
> +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e3), 81);
> +
> +       CU_ASSERT_EQUAL(ebitmap_init_range(&e4, 100, 400), 0);
> +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e4), 400);
> +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e4), 301);
> +
> +       CU_ASSERT_EQUAL(ebitmap_init_range(&e5, 10, 5), -EINVAL);
> +       CU_ASSERT_EQUAL(ebitmap_init_range(&e6, 0, UINT32_MAX), -EOVERFLO=
W);
> +
> +       ebitmap_destroy(&e6);
> +       ebitmap_destroy(&e5);
> +       ebitmap_destroy(&e4);
> +       ebitmap_destroy(&e3);
> +       ebitmap_destroy(&e2);
> +       ebitmap_destroy(&e1);
> +}
> +
>  static void test_ebitmap_or(void)
>  {
>         ebitmap_t e1, e2, e3, e4;
> @@ -701,6 +732,7 @@ int ebitmap_add_tests(CU_pSuite suite)
>         ADD_TEST(ebitmap_init_destroy);
>         ADD_TEST(ebitmap_cmp);
>         ADD_TEST(ebitmap_set_and_get);
> +       ADD_TEST(ebitmap_init_range);
>         ADD_TEST(ebitmap_or);
>         ADD_TEST(ebitmap_and);
>         ADD_TEST(ebitmap_xor);
> --
> 2.36.1
>

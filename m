Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F3AC433EF
	for <selinux@archiver.kernel.org>; Wed, 20 Jul 2022 19:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiGTTvr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Jul 2022 15:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiGTTvq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Jul 2022 15:51:46 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567025C37C
        for <selinux@vger.kernel.org>; Wed, 20 Jul 2022 12:51:44 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10c0430e27dso37556604fac.4
        for <selinux@vger.kernel.org>; Wed, 20 Jul 2022 12:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YGChqBIOFjXxFIEs9YlLFVoHVcGtf2hcGSQT8dFV5/s=;
        b=UuBpOF56cMP+/acHf49/nDO0ErviuGO7i+dVRm2WELmMWfmTgr02BfALKoJKcVDGnv
         Mvp0zkuNEDdVZBbTgY9DATVqbJHns03FXjXtZLXB8c/OaDjsPSj1D9SrlBDokEdmgvwS
         pqG7nHN5kAmXNpdgEVSWxyw/4N/5kuqQCg8alLDmojoTJ2wRr/HE5BUrcUltmQoFh2hy
         kqqkeUbYV/v9ttAke/S7ZgciXZyrtqUpTEHc/AfSdfbaU6dM8PqIqdbqXnNYyBwMqmSe
         EHq/W8XRcO2aa+hJ53yS6XamJYSmXT/ffd8/sZKY6RthPW3DegTPP+mt5sHZjV72iQoX
         wbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YGChqBIOFjXxFIEs9YlLFVoHVcGtf2hcGSQT8dFV5/s=;
        b=JtwQSxPUp8+fp1M/8J9SafM3Rci403K0t+/uAV6poq0Xba9IvcapSOgHB15d7z8hwi
         SSh97vvIislN6MUPeLIAkqspIOrr4pP0Of/QxggxgCXj2RTlzgQbjENVUYdiF26Auy5K
         MVkjDR0VUUuTBIp6Gqkga9WG4X2rupQpi7ElLJtqpd6LWklcKe4LJYcmuWFnNkZsbrcQ
         lYUyhfgx8Bgwaobww408l9yurG/OycgJ5dT1ZrdqgRODW/ZOZZxkGawRcb64DjQdJcxT
         oXBYU/6mX622tO/lLF7uK1MFWVXbVphmViaPg2UcQroDOC0AiJIGNz9qFtUxc8gWZc1R
         /ckA==
X-Gm-Message-State: AJIora9h0EuelJ6E062u8gevh9nzrECA1BHxjTjRGIXqOYX2iw7r6uq6
        tQN4NUfDZVJmMQ1HhjDE7W4sICWTe3LwRZ08YDFTY5BGj+w=
X-Google-Smtp-Source: AGRyM1sueUHK6pnoiIx8mhSmVveo1JtBX3eOTUes566+fsneRCBt0Jwpiv0nuFDCCVs/fza7mBHpHYXCBn0poD+TyhY=
X-Received: by 2002:a05:6870:c0c5:b0:10d:5f5c:9ab1 with SMTP id
 e5-20020a056870c0c500b0010d5f5c9ab1mr3543007oad.156.1658346703472; Wed, 20
 Jul 2022 12:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220719153045.70041-1-cgzones@googlemail.com>
In-Reply-To: <20220719153045.70041-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 20 Jul 2022 15:51:32 -0400
Message-ID: <CAP+JOzQ2P8dpPo+8uNu52Lt-5xSSYdew-6k15CGETCsGxK12Fg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] libsepol/tests: add ebitmap tests
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 19, 2022 at 11:34 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Preparation for several ebitmap related optimizations.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For this series:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2:
>   - add more tests for multi node ebitmaps and for bits set at node
>     bounds
>   - test ebitmap_for_each_bit()
> ---
>  libsepol/tests/libsepol-tests.c |    2 +
>  libsepol/tests/test-ebitmap.c   | 1048 +++++++++++++++++++++++++++++++
>  libsepol/tests/test-ebitmap.h   |   10 +
>  3 files changed, 1060 insertions(+)
>  create mode 100644 libsepol/tests/test-ebitmap.c
>  create mode 100644 libsepol/tests/test-ebitmap.h
>
> diff --git a/libsepol/tests/libsepol-tests.c b/libsepol/tests/libsepol-te=
sts.c
> index dc8fd5ce..5ae6bedc 100644
> --- a/libsepol/tests/libsepol-tests.c
> +++ b/libsepol/tests/libsepol-tests.c
> @@ -19,6 +19,7 @@
>   */
>
>  #include "test-cond.h"
> +#include "test-ebitmap.h"
>  #include "test-linker.h"
>  #include "test-expander.h"
>  #include "test-deps.h"
> @@ -64,6 +65,7 @@ static bool do_tests(int interactive, int verbose)
>         if (CUE_SUCCESS !=3D CU_initialize_registry())
>                 return CU_get_error();
>
> +       DECLARE_SUITE(ebitmap);
>         DECLARE_SUITE(cond);
>         DECLARE_SUITE(linker);
>         DECLARE_SUITE(expander);
> diff --git a/libsepol/tests/test-ebitmap.c b/libsepol/tests/test-ebitmap.=
c
> new file mode 100644
> index 00000000..fad5bd75
> --- /dev/null
> +++ b/libsepol/tests/test-ebitmap.c
> @@ -0,0 +1,1048 @@
> +#include "test-ebitmap.h"
> +
> +#include <stdlib.h>
> +#include <time.h>
> +
> +#include <sepol/debug.h>
> +#include <sepol/policydb/ebitmap.h>
> +
> +#define RANDOM_ROUNDS 10
> +
> +
> +static int ebitmap_init_random(ebitmap_t *e, unsigned int length, int se=
t_chance)
> +{
> +       unsigned int i;
> +       int rc;
> +
> +       if (set_chance <=3D 0 || set_chance > 100)
> +               return -EINVAL;
> +
> +       ebitmap_init(e);
> +
> +       for (i =3D 0; i < length; i++) {
> +               if ((random() % 100) < set_chance) {
> +                       rc =3D ebitmap_set_bit(e, i, 1);
> +                       if (rc)
> +                               return rc;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static void test_ebitmap_init_destroy(void)
> +{
> +       ebitmap_t e;
> +
> +       /* verify idempotence */
> +       ebitmap_init(&e);
> +       ebitmap_init(&e);
> +       ebitmap_init(&e);
> +
> +       CU_ASSERT(ebitmap_is_empty(&e));
> +       CU_ASSERT_PTR_NULL(ebitmap_startnode(&e));
> +
> +       /* verify idempotence */
> +       ebitmap_destroy(&e);
> +       ebitmap_destroy(&e);
> +       ebitmap_destroy(&e);
> +
> +       CU_ASSERT(ebitmap_is_empty(&e));
> +       CU_ASSERT_PTR_NULL(ebitmap_startnode(&e));
> +}
> +
> +static void test_ebitmap_cmp(void)
> +{
> +       ebitmap_t e1, e2;
> +
> +       ebitmap_init(&e1);
> +       ebitmap_init(&e2);
> +
> +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
> +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 10, 1), 0);
> +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 63, 1), 0);
> +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 63, 1), 0);
> +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 64, 1), 0);
> +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 64, 1), 0);
> +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1022, 1), 0);
> +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 1022, 1), 0);
> +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1023, 1), 0);
> +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 1023, 1), 0);
> +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1024, 1), 0);
> +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 1024, 1), 0);
> +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1025, 1), 0);
> +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 1025, 1), 0);
> +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 255, 1), 0);
> +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 255, 1), 0);
> +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 256, 1), 0);
> +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 256, 1), 0);
> +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 639, 1), 0);
> +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 639, 1), 0);
> +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 640, 1), 0);
> +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 640, 1), 0);
> +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 900, 1), 0);
> +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 900, 1), 0);
> +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> +
> +       ebitmap_destroy(&e2);
> +
> +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> +
> +       ebitmap_destroy(&e1);
> +
> +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> +}
> +
> +static void test_ebitmap_set_and_get(void)
> +{
> +       ebitmap_t e;
> +
> +       ebitmap_init(&e);
> +
> +       CU_ASSERT(ebitmap_is_empty(&e));
> +       CU_ASSERT_TRUE(ebitmap_is_empty(&e));
> +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 0);
> +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 0);
> +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 10), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, UINT32_MAX, 1), -EINVAL);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 10, 0), 0);
> +       CU_ASSERT(ebitmap_is_empty(&e));
> +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 0);
> +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 0);
> +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 10), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 10, 1), 0);
> +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 1);
> +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 10);
> +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 10), 1);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 100, 1), 0);
> +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 2);
> +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 100);
> +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 100), 1);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 50, 1), 0);
> +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 3);
> +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 100);
> +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 50), 1);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 1023, 1), 0);
> +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 4);
> +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1023);
> +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 1023), 1);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 1024, 1), 0);
> +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 5);
> +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1024);
> +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 1024), 1);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 1050, 1), 0);
> +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 6);
> +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1050);
> +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 1050), 1);
> +
> +       {
> +               ebitmap_node_t *n;
> +               unsigned int bit, count;
> +
> +               /* iterate all allocated bits */
> +               count =3D 0;
> +               ebitmap_for_each_bit(&e, n, bit) {
> +                       CU_ASSERT(                bit <   64  ||
> +                                 (64   <=3D bit && bit <  128) ||
> +                                 (960  <=3D bit && bit < 1024) ||
> +                                 (1024 <=3D bit && bit < 1088));
> +                       count++;
> +               }
> +               CU_ASSERT_EQUAL(count, 4 * 64);
> +
> +               count =3D 0;
> +               ebitmap_for_each_positive_bit(&e, n, bit) {
> +                       CU_ASSERT(bit =3D=3D 10 ||
> +                                 bit =3D=3D 50 ||
> +                                 bit =3D=3D 100 ||
> +                                 bit =3D=3D 1023 ||
> +                                 bit =3D=3D 1024 ||
> +                                 bit =3D=3D 1050);
> +                       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, bit), 1);
> +                       count++;
> +               }
> +               CU_ASSERT_EQUAL(count, 6);
> +       }
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 1024, 0), 0);
> +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 5);
> +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1050);
> +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 1024), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 1050, 0), 0);
> +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 4);
> +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1023);
> +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 1050), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 100, 0), 0);
> +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 3);
> +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1023);
> +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 100), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 10, 0), 0);
> +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 2);
> +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1023);
> +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 10), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 50, 0), 0);
> +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 1);
> +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1023);
> +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 50), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 1023, 0), 0);
> +       CU_ASSERT_TRUE(ebitmap_is_empty(&e));
> +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 0);
> +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 0);
> +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 1023), 0);
> +
> +       ebitmap_destroy(&e);
> +}
> +
> +static void test_ebitmap_or(void)
> +{
> +       ebitmap_t e1, e2, e3, e4;
> +
> +       ebitmap_init(&e1);
> +       ebitmap_init(&e2);
> +       ebitmap_init(&e3);
> +       ebitmap_init(&e4);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 100, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 101, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 318, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 319, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 383, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 384, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 449, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1013, 1), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 11, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 101, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 430, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 665, 1), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 10, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 11, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 100, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 101, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 318, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 319, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 383, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 384, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 430, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 449, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 665, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 1013, 1), 0);
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_or(&dst, &e1, &e1), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e1));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_or(&dst, &e2, &e2), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e2));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_or(&dst, &e1, &e2), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e3));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_or(&dst, &e3, &e3), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e3));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_or(&dst, &e3, &e4), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e3));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_or(&dst, &e4, &e4), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e4));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       ebitmap_destroy(&e4);
> +       ebitmap_destroy(&e3);
> +       ebitmap_destroy(&e2);
> +       ebitmap_destroy(&e1);
> +}
> +
> +static void test_ebitmap_and(void)
> +{
> +       {
> +               ebitmap_t e1, e2, e12, e3, e4;
> +
> +               ebitmap_init(&e1);
> +               ebitmap_init(&e2);
> +               ebitmap_init(&e12);
> +               ebitmap_init(&e3);
> +               ebitmap_init(&e4);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 100, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 101, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 318, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 319, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 383, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 384, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 449, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1013, 1), 0);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 11, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 101, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 319, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 665, 1), 0);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 101, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 319, 1), 0);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 10, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 11, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 100, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 101, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 318, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 319, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 383, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 384, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 430, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 449, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 665, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 1013, 1), 0);
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_and(&dst, &e1, &e1), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e1));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_and(&dst, &e2, &e2), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e2));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_and(&dst, &e1, &e2), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e12));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_and(&dst, &e3, &e3), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e3));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_and(&dst, &e1, &e3), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e1));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_and(&dst, &e2, &e3), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e2));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_and(&dst, &e4, &e4), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e4));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_and(&dst, &e3, &e4), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e4));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               ebitmap_destroy(&e4);
> +               ebitmap_destroy(&e3);
> +               ebitmap_destroy(&e12);
> +               ebitmap_destroy(&e2);
> +               ebitmap_destroy(&e1);
> +       }
> +
> +       {
> +               ebitmap_t e5;
> +               ebitmap_t e6;
> +               ebitmap_t e56;
> +               ebitmap_t dst;
> +
> +               ebitmap_init(&e5);
> +               ebitmap_init(&e6);
> +               ebitmap_init(&e56);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 63, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 191, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 192, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 318, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 319, 1), 0);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 64, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 192, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 319, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 320, 1), 0);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 192, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 319, 1), 0);
> +
> +               CU_ASSERT_EQUAL(ebitmap_and(&dst, &e5, &e6), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e56));
> +
> +               ebitmap_destroy(&dst);
> +               ebitmap_destroy(&e56);
> +               ebitmap_destroy(&e6);
> +               ebitmap_destroy(&e5);
> +       }
> +}
> +
> +static void test_ebitmap_xor(void)
> +{
> +       {
> +               ebitmap_t e1, e2, e3, e4;
> +
> +               ebitmap_init(&e1);
> +               ebitmap_init(&e2);
> +               ebitmap_init(&e3);
> +               ebitmap_init(&e4);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 5, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 1, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 3, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 6, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 9, 1), 0);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 3, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 5, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 6, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 9, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 10, 1), 0);
> +
> +               {
> +                       ebitmap_t dst1, dst2;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_xor(&dst1, &e1, &e1), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst1, &e4));
> +                       CU_ASSERT_EQUAL(ebitmap_xor(&dst2, &dst1, &e1), 0=
);
> +                       CU_ASSERT(ebitmap_cmp(&dst2, &e1));
> +
> +                       ebitmap_destroy(&dst2);
> +                       ebitmap_destroy(&dst1);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e2, &e2), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e4));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e3, &e3), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e4));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e4, &e4), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e4));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e1, &e2), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e3));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e2, &e4), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e2));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               ebitmap_destroy(&e4);
> +               ebitmap_destroy(&e3);
> +               ebitmap_destroy(&e2);
> +               ebitmap_destroy(&e1);
> +       }
> +
> +       {
> +               ebitmap_t e5;
> +               ebitmap_t e6;
> +               ebitmap_t e56;
> +               ebitmap_t dst;
> +
> +               ebitmap_init(&e5);
> +               ebitmap_init(&e6);
> +               ebitmap_init(&e56);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 63, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 191, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 192, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 318, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 319, 1), 0);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 64, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 192, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 319, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 320, 1), 0);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 63, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 64, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 191, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 318, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 320, 1), 0);
> +
> +               CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e5, &e6), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e56));
> +
> +               ebitmap_destroy(&dst);
> +               ebitmap_destroy(&e56);
> +               ebitmap_destroy(&e6);
> +               ebitmap_destroy(&e5);
> +       }
> +}
> +
> +static void test_ebitmap_not(void)
> +{
> +       {
> +               ebitmap_t e1, e2, e3, e4;
> +
> +               ebitmap_init(&e1);
> +               ebitmap_init(&e2);
> +               ebitmap_init(&e3);
> +               ebitmap_init(&e4);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 0, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 5, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 2, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 3, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 4, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 6, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 7, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 8, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 9, 1), 0);
> +
> +               {
> +                       ebitmap_t dst1, dst2;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_not(&dst1, &e3, 10), 0);
> +                       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&dst1), 9=
);
> +                       CU_ASSERT_EQUAL(ebitmap_cardinality(&dst1), 10);
> +
> +                       CU_ASSERT_EQUAL(ebitmap_not(&dst2, &dst1, 10), 0)=
;
> +                       CU_ASSERT(ebitmap_cmp(&dst2, &e3));
> +
> +                       ebitmap_destroy(&dst2);
> +                       ebitmap_destroy(&dst1);
> +               }
> +
> +               {
> +                       ebitmap_t dst1, dst2;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_not(&dst1, &e1, 11), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst1, &e2));
> +                       CU_ASSERT_EQUAL(ebitmap_not(&dst2, &dst1, 11), 0)=
;
> +                       CU_ASSERT(ebitmap_cmp(&dst2, &e1));
> +
> +                       ebitmap_destroy(&dst2);
> +                       ebitmap_destroy(&dst1);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_not(&dst, &e1, 8), 0);
> +                       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&dst), 7)=
;
> +                       CU_ASSERT_EQUAL(ebitmap_cardinality(&dst), 5);
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_not(&dst, &e1, 12), 0);
> +                       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&dst), 11=
);
> +                       CU_ASSERT_EQUAL(ebitmap_cardinality(&dst), 8);
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               ebitmap_destroy(&e3);
> +               ebitmap_destroy(&e2);
> +               ebitmap_destroy(&e1);
> +       }
> +
> +       {
> +               ebitmap_t e5;
> +               ebitmap_t e5not;
> +               ebitmap_node_t *n;
> +               unsigned int bit;
> +
> +               ebitmap_init(&e5);
> +               ebitmap_init(&e5not);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 63, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 191, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 192, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 318, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 319, 1), 0);
> +
> +               for (bit =3D 0; bit < 317; bit++)
> +                       CU_ASSERT_EQUAL(ebitmap_set_bit(&e5not, bit, 1), =
0);
> +               ebitmap_for_each_positive_bit(&e5, n, bit)
> +                       CU_ASSERT_EQUAL(ebitmap_set_bit(&e5not, bit, 0), =
0);
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_not(&dst, &e5, 317), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e5not));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_not(&dst, &e5, 318), 0);
> +                       CU_ASSERT_FALSE(ebitmap_cmp(&dst, &e5not));
> +
> +                       CU_ASSERT_EQUAL(ebitmap_set_bit(&e5not, 317, 1), =
0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e5not));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_not(&dst, &e5, 319), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e5not));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               ebitmap_destroy(&e5not);
> +               ebitmap_destroy(&e5);
> +       }
> +}
> +
> +static void test_ebitmap_andnot(void)
> +{
> +       {
> +               ebitmap_t e1, e2, e12, e3, e4;
> +
> +               ebitmap_init(&e1);
> +               ebitmap_init(&e2);
> +               ebitmap_init(&e12);
> +               ebitmap_init(&e3);
> +               ebitmap_init(&e4);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 100, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 101, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 430, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1013, 1), 0);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 11, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 101, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 665, 1), 0);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 10, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 100, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 430, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 1013, 1), 0);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 10, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 11, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 100, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 101, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 430, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 665, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 1013, 1), 0);
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e1, &e1, 10=
24), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e4));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e2, &e2, 10=
24), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e4));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e1, &e2, 10=
24), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e12));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e3, &e3, 10=
24), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e4));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e1, &e3, 10=
24), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e4));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e2, &e12, 1=
024), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e2));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e4, &e4, 10=
24), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e4));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e3, &e4, 10=
24), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e3));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               ebitmap_destroy(&e4);
> +               ebitmap_destroy(&e3);
> +               ebitmap_destroy(&e12);
> +               ebitmap_destroy(&e2);
> +               ebitmap_destroy(&e1);
> +       }
> +
> +       {
> +               ebitmap_t e5;
> +               ebitmap_t e6;
> +               ebitmap_t e56;
> +
> +               ebitmap_init(&e5);
> +               ebitmap_init(&e6);
> +               ebitmap_init(&e56);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 63, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 191, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 192, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 318, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 319, 1), 0);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 64, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 192, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 319, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 320, 1), 0);
> +
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 63, 1), 0);
> +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 191, 1), 0);
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e5, &e6, 31=
7), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e56));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e5, &e6, 31=
8), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e56));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e5, &e6, 31=
9), 0);
> +                       CU_ASSERT_FALSE(ebitmap_cmp(&dst, &e56));
> +
> +                       CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 318, 1), 0)=
;
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e56));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               {
> +                       ebitmap_t dst;
> +
> +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e5, &e6, 32=
0), 0);
> +                       CU_ASSERT(ebitmap_cmp(&dst, &e56));
> +
> +                       ebitmap_destroy(&dst);
> +               }
> +
> +               ebitmap_destroy(&e56);
> +               ebitmap_destroy(&e6);
> +               ebitmap_destroy(&e5);
> +       }
> +}
> +
> +static void test_ebitmap__random_impl(unsigned int length, int set_chanc=
e)
> +{
> +       ebitmap_t e1, e2, dst_cpy, dst_or, dst_and, dst_xor1, dst_xor2, d=
st_not1, dst_not2, dst_andnot;
> +       unsigned int i;
> +
> +       CU_ASSERT_EQUAL(ebitmap_init_random(&e1, length, set_chance), 0);
> +       CU_ASSERT_EQUAL(ebitmap_init_random(&e2, length, set_chance), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_cpy(&dst_cpy, &e1), 0);
> +       CU_ASSERT(ebitmap_cmp(&dst_cpy, &e1));
> +
> +       CU_ASSERT_EQUAL(ebitmap_or(&dst_or, &e1, &e2), 0);
> +       for (i =3D 0; i < length; i++)
> +               CU_ASSERT_EQUAL(ebitmap_get_bit(&dst_or, i), ebitmap_get_=
bit(&e1, i) | ebitmap_get_bit(&e2, i));
> +
> +       CU_ASSERT_EQUAL(ebitmap_and(&dst_and, &e1, &e2), 0);
> +       for (i =3D 0; i < length; i++)
> +               CU_ASSERT_EQUAL(ebitmap_get_bit(&dst_and, i), ebitmap_get=
_bit(&e1, i) & ebitmap_get_bit(&e2, i));
> +
> +       CU_ASSERT_EQUAL(ebitmap_xor(&dst_xor1, &e1, &e2), 0);
> +       for (i =3D 0; i < length; i++)
> +               CU_ASSERT_EQUAL(ebitmap_get_bit(&dst_xor1, i), ebitmap_ge=
t_bit(&e1, i) ^ ebitmap_get_bit(&e2, i));
> +       CU_ASSERT_EQUAL(ebitmap_xor(&dst_xor2, &dst_xor1, &e2), 0);
> +       CU_ASSERT(ebitmap_cmp(&dst_xor2, &e1));
> +
> +       CU_ASSERT_EQUAL(ebitmap_not(&dst_not1, &e1, length), 0);
> +       for (i =3D 0; i < length; i++)
> +               CU_ASSERT_EQUAL(ebitmap_get_bit(&dst_not1, i), !ebitmap_g=
et_bit(&e1, i));
> +       CU_ASSERT_EQUAL(ebitmap_not(&dst_not2, &dst_not1, length), 0);
> +       CU_ASSERT(ebitmap_cmp(&dst_not2, &e1));
> +
> +       CU_ASSERT_EQUAL(ebitmap_andnot(&dst_andnot, &e1, &e2, length), 0)=
;
> +       for (i =3D 0; i < length; i++)
> +               CU_ASSERT_EQUAL(ebitmap_get_bit(&dst_andnot, i), ebitmap_=
get_bit(&e1, i) & !ebitmap_get_bit(&e2, i));
> +
> +       ebitmap_destroy(&dst_andnot);
> +       ebitmap_destroy(&dst_not2);
> +       ebitmap_destroy(&dst_not1);
> +       ebitmap_destroy(&dst_xor2);
> +       ebitmap_destroy(&dst_xor1);
> +       ebitmap_destroy(&dst_and);
> +       ebitmap_destroy(&dst_or);
> +       ebitmap_destroy(&dst_cpy);
> +       ebitmap_destroy(&e2);
> +       ebitmap_destroy(&e1);
> +}
> +
> +static void test_ebitmap__random(void)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < RANDOM_ROUNDS; i++)
> +               test_ebitmap__random_impl(5, 10);
> +
> +       for (i =3D 0; i < RANDOM_ROUNDS; i++)
> +               test_ebitmap__random_impl(5, 90);
> +
> +       for (i =3D 0; i < RANDOM_ROUNDS; i++)
> +               test_ebitmap__random_impl(1024, 50);
> +
> +       for (i =3D 0; i < RANDOM_ROUNDS; i++)
> +               test_ebitmap__random_impl(8000, 5);
> +
> +       for (i =3D 0; i < RANDOM_ROUNDS; i++)
> +               test_ebitmap__random_impl(8000, 95);
> +}
> +
> +/*
> + * External hooks
> + */
> +
> +int ebitmap_test_init(void)
> +{
> +       srandom(time(NULL));
> +
> +       /* silence ebitmap_set_bit() failure message */
> +       sepol_debug(0);
> +
> +       return 0;
> +}
> +
> +int ebitmap_test_cleanup(void)
> +{
> +       return 0;
> +}
> +
> +#define ADD_TEST(name) \
> +       do { \
> +               if (NULL =3D=3D CU_add_test(suite, #name, test_##name)) {=
 \
> +                       return CU_get_error(); \
> +               } \
> +       } while (0)
> +
> +int ebitmap_add_tests(CU_pSuite suite)
> +{
> +       ADD_TEST(ebitmap_init_destroy);
> +       ADD_TEST(ebitmap_cmp);
> +       ADD_TEST(ebitmap_set_and_get);
> +       ADD_TEST(ebitmap_or);
> +       ADD_TEST(ebitmap_and);
> +       ADD_TEST(ebitmap_xor);
> +       ADD_TEST(ebitmap_not);
> +       ADD_TEST(ebitmap_andnot);
> +       ADD_TEST(ebitmap__random);
> +       return 0;
> +}
> diff --git a/libsepol/tests/test-ebitmap.h b/libsepol/tests/test-ebitmap.=
h
> new file mode 100644
> index 00000000..952a0421
> --- /dev/null
> +++ b/libsepol/tests/test-ebitmap.h
> @@ -0,0 +1,10 @@
> +#ifndef TEST_EBITMAP_H__
> +#define TEST_EBITMAP_H__
> +
> +#include <CUnit/Basic.h>
> +
> +int ebitmap_test_init(void);
> +int ebitmap_test_cleanup(void);
> +int ebitmap_add_tests(CU_pSuite suite);
> +
> +#endif  /* TEST_EBITMAP_H__ */
> --
> 2.36.1
>

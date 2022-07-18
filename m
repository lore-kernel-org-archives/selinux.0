Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD4FC43334
	for <selinux@archiver.kernel.org>; Mon, 18 Jul 2022 20:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbiGRUjc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Jul 2022 16:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiGRUjb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Jul 2022 16:39:31 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4925B1D9
        for <selinux@vger.kernel.org>; Mon, 18 Jul 2022 13:39:29 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10c8e8d973eso27026642fac.5
        for <selinux@vger.kernel.org>; Mon, 18 Jul 2022 13:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gMWAfcBsSOOBOsLA6/wygE3XP5zb0c1w5C1C4FpFgSE=;
        b=PYm3YFtVLD/CurixkT8fwzjs3Rw9RaVfoVTrPd8Ms8flWAhCQl6yocnEddZO/FGoCr
         SIrD2aPizSaRuyEYzUMdFeV+H6zyXv7jQiLGrbszIOccy38fKEZYZ9+djx45Tz2gAQnm
         Qm6jvOvbTbIFhGTAkRJrbRTlmlLIPNkUdbT++NIacbe92dyeltPjRS4yVXpqnuZ/Rpvi
         eT09LFcsCTwVfz9aPzaGF47OryoZdb+K4JrXvZo8EPU3eUErQLK7bM4FPizDTy6KRp6r
         VWz3FhLwA8xibJllHox1KP8w7dqrcDzEZbkrBam3cEbFhWZZv6SGt/MP3QLbpmQOsZ8n
         YdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gMWAfcBsSOOBOsLA6/wygE3XP5zb0c1w5C1C4FpFgSE=;
        b=HNHB7rXvuL1azBm1ml2CTE2Q5xdr/ch0RRRWUclNkJv9Y2EwqZ3iZs0mM9muRX+hJi
         QNusBfLQKyFrazTtavjxRO4AK2ncbHXfDPrWEE4n+RmnQw3I0G5OiNWPpZfnOEwx0Tjl
         3sFfIybEwhBYYWkngLi/JZW0G0TkhdQJ+t4EjsdiiOcRBmMVB7GDlZIU98hCDW93nV+0
         hnlDbhRp07IleMUpjG/6n6dEmGWUUSkXaWqSzERO3ne9JMdUQCYmQqQV1aD+GYoJv+kS
         5D1hVZzKtI3MohZkxqnb8EWYFX7juT9ZdpH5BbS2tDP35ZZ/IoYFehWiPv3llyE4UIXj
         heJg==
X-Gm-Message-State: AJIora8lSPrab4y9SQqX07mLVWa6DinUlL9AnYzjYvkW4EfhdgXlgEz8
        0yjHAvV+HRQWxGU+kF9JNdLX1kwQdMmWQiRg4zRUhQD8
X-Google-Smtp-Source: AGRyM1tRtjAjUsdlFFlsKFCgtWCxHA0AMSey7sdjMW4U1w5JIqpoYO30DzG6o1VUnApsy/6RfyCdkw1wW/G/InH++hs=
X-Received: by 2002:a54:4788:0:b0:33a:6311:a734 with SMTP id
 o8-20020a544788000000b0033a6311a734mr5944401oic.156.1658176769183; Mon, 18
 Jul 2022 13:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220712160858.22677-1-cgzones@googlemail.com>
In-Reply-To: <20220712160858.22677-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 18 Jul 2022 16:39:18 -0400
Message-ID: <CAP+JOzRa4KRMQCcr5jx8fn+f7uUwjEYgMiPibgPTNpXhF19xzA@mail.gmail.com>
Subject: Re: [PATCH 1/7] libsepol/tests: add ebitmap tests
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
> Preparation for several ebitmap related optimizations.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/tests/libsepol-tests.c |   2 +
>  libsepol/tests/test-ebitmap.c   | 711 ++++++++++++++++++++++++++++++++
>  libsepol/tests/test-ebitmap.h   |  10 +
>  3 files changed, 723 insertions(+)
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
> index 00000000..a21f18c0
> --- /dev/null
> +++ b/libsepol/tests/test-ebitmap.c
> @@ -0,0 +1,711 @@
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
> +       ebitmap_init(&e);
> +       ebitmap_init(&e);
> +       ebitmap_init(&e);
> +

I am not sure what we are testing here. ebitmap_init() is just doing a mems=
et.

> +       CU_ASSERT(ebitmap_is_empty(&e));
> +       CU_ASSERT_PTR_NULL(ebitmap_startnode(&e));
> +
> +       ebitmap_destroy(&e);
> +       ebitmap_destroy(&e);
> +       ebitmap_destroy(&e);
> +

I don't know what we are testing here either.

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
> +
> +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 10, 1), 0);
> +
> +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> +

For all the tests we should test with values that will require more
that one ebitmap_node_t and test bits that are going to be at the
boundaries of the nodes (l0, 63, 64, 127, ...) and some bits in
between.

> +       ebitmap_destroy(&e2);
> +       ebitmap_destroy(&e1);
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

This is at least using more than one ebitmap_node_t, but I would still
like to make sure we are handling the edge cases properly.

> +       {
> +               ebitmap_node_t *n;
> +               unsigned int bit;
> +
> +               ebitmap_for_each_positive_bit(&e, n, bit) {
> +                       CU_ASSERT(bit =3D=3D 10 || bit =3D=3D 50 || bit =
=3D=3D 100);
> +               }
> +       }
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 100, 0), 0);
> +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 2);
> +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 50);
> +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 100), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 10, 0), 0);
> +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 1);
> +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 50);
> +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 10), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 50, 0), 0);
> +       CU_ASSERT_TRUE(ebitmap_is_empty(&e));
> +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 0);
> +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 0);
> +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 50), 0);
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
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 430, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1013, 1), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 11, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 101, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 665, 1), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 10, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 11, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 100, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 101, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 430, 1), 0);
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
> +       ebitmap_t e1, e2, e12, e3, e4;
> +
> +       ebitmap_init(&e1);
> +       ebitmap_init(&e2);
> +       ebitmap_init(&e12);
> +       ebitmap_init(&e3);
> +       ebitmap_init(&e4);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 100, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 101, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 430, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1013, 1), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 11, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 101, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 665, 1), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 101, 1), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 10, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 11, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 100, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 101, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 430, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 665, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 1013, 1), 0);
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_and(&dst, &e1, &e1), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e1));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_and(&dst, &e2, &e2), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e2));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_and(&dst, &e1, &e2), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e12));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_and(&dst, &e3, &e3), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e3));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_and(&dst, &e1, &e3), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e1));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_and(&dst, &e2, &e3), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e2));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_and(&dst, &e4, &e4), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e4));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_and(&dst, &e3, &e4), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e4));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       ebitmap_destroy(&e4);
> +       ebitmap_destroy(&e3);
> +       ebitmap_destroy(&e12);
> +       ebitmap_destroy(&e2);
> +       ebitmap_destroy(&e1);
> +}
> +
> +static void test_ebitmap_xor(void)
> +{
> +       ebitmap_t e1, e2, e3, e4;
> +
> +       ebitmap_init(&e1);
> +       ebitmap_init(&e2);
> +       ebitmap_init(&e3);
> +       ebitmap_init(&e4);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 5, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 1, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 3, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 6, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 9, 1), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 3, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 5, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 6, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 9, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 10, 1), 0);
> +

I would like to see bits > 64 being tested to test the case with more
than one ebitmap_node_t.

> +       {
> +               ebitmap_t dst1, dst2;
> +
> +               CU_ASSERT_EQUAL(ebitmap_xor(&dst1, &e1, &e1), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst1, &e4));
> +               CU_ASSERT_EQUAL(ebitmap_xor(&dst2, &dst1, &e1), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst2, &e1));
> +
> +               ebitmap_destroy(&dst2);
> +               ebitmap_destroy(&dst1);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e2, &e2), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e4));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e3, &e3), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e4));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e4, &e4), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e4));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e1, &e2), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e3));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e2, &e4), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e2));
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
> +static void test_ebitmap_not(void)
> +{
> +       ebitmap_t e1, e2, e3, e4;
> +
> +       ebitmap_init(&e1);
> +       ebitmap_init(&e2);
> +       ebitmap_init(&e3);
> +       ebitmap_init(&e4);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 0, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 5, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 2, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 3, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 4, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 6, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 7, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 8, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 9, 1), 0);
> +

Same here.

Tests are a nice and needed addition.

Thanks,
Jim


> +       {
> +               ebitmap_t dst1, dst2;
> +
> +               CU_ASSERT_EQUAL(ebitmap_not(&dst1, &e3, 10), 0);
> +               CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&dst1), 9);
> +               CU_ASSERT_EQUAL(ebitmap_cardinality(&dst1), 10);
> +
> +               CU_ASSERT_EQUAL(ebitmap_not(&dst2, &dst1, 10), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst2, &e3));
> +
> +               ebitmap_destroy(&dst2);
> +               ebitmap_destroy(&dst1);
> +       }
> +
> +       {
> +               ebitmap_t dst1, dst2;
> +
> +               CU_ASSERT_EQUAL(ebitmap_not(&dst1, &e1, 11), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst1, &e2));
> +               CU_ASSERT_EQUAL(ebitmap_not(&dst2, &dst1, 11), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst2, &e1));
> +
> +               ebitmap_destroy(&dst2);
> +               ebitmap_destroy(&dst1);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_not(&dst, &e1, 8), 0);
> +               CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&dst), 7);
> +               CU_ASSERT_EQUAL(ebitmap_cardinality(&dst), 5);
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_not(&dst, &e1, 12), 0);
> +               CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&dst), 11);
> +               CU_ASSERT_EQUAL(ebitmap_cardinality(&dst), 8);
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       ebitmap_destroy(&e3);
> +       ebitmap_destroy(&e2);
> +       ebitmap_destroy(&e1);
> +}
> +
> +static void test_ebitmap_andnot(void)
> +{
> +       ebitmap_t e1, e2, e12, e3, e4;
> +
> +       ebitmap_init(&e1);
> +       ebitmap_init(&e2);
> +       ebitmap_init(&e12);
> +       ebitmap_init(&e3);
> +       ebitmap_init(&e4);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 100, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 101, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 430, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1013, 1), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 11, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 101, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 665, 1), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 10, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 100, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 430, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 1013, 1), 0);
> +
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 10, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 11, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 100, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 101, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 430, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 665, 1), 0);
> +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 1013, 1), 0);
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e1, &e1, 1024), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e4));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e2, &e2, 1024), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e4));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e1, &e2, 1024), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e12));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e3, &e3, 1024), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e4));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e1, &e3, 1024), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e4));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e2, &e12, 1024), 0)=
;
> +               CU_ASSERT(ebitmap_cmp(&dst, &e2));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e4, &e4, 1024), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e4));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       {
> +               ebitmap_t dst;
> +
> +               CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e3, &e4, 1024), 0);
> +               CU_ASSERT(ebitmap_cmp(&dst, &e3));
> +
> +               ebitmap_destroy(&dst);
> +       }
> +
> +       ebitmap_destroy(&e4);
> +       ebitmap_destroy(&e3);
> +       ebitmap_destroy(&e12);
> +       ebitmap_destroy(&e2);
> +       ebitmap_destroy(&e1);
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

Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F50C19F2D
	for <selinux@archiver.kernel.org>; Tue,  9 Aug 2022 15:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243301AbiHIPTn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Aug 2022 11:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiHIPTl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Aug 2022 11:19:41 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033E111803
        for <selinux@vger.kernel.org>; Tue,  9 Aug 2022 08:19:39 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id d63-20020a4a5242000000b0044880019622so368956oob.13
        for <selinux@vger.kernel.org>; Tue, 09 Aug 2022 08:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=tzgIYSLj46+eKBAqQOEzdJsqw9Ys4pAlJzwMpGLaZvE=;
        b=GqLvnZJMx6INAoGExevq0cLNhwxT0BWtqQZ5uAX1NzCxSF4t6i7P8kO0LEZZXplV0Z
         nf56ysJHSKFAu9efvBcg1g6mRYdVhAESbA8MMx1/IbmVWA0AARuMYxIJr7fQQ3nBYyxk
         +u+N7wtdsi72lc8SJhKHwoKWdprYRQYicAegvwkcqs20V9rfcGNXeMg3iZet3KxbnXxV
         0NEcFSCh0iNgnvUocUI64njwLdRlSO2Ht7/QjLRPxuGVUXLWAUp1V5gx0SldS7e3AHKo
         uml76rNHC7u76lNeyt8TvJxX+fZqJIuXdNgegxjPC9tG+ssT8Sv5FE3K8Rt+w8rvUbRR
         d+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=tzgIYSLj46+eKBAqQOEzdJsqw9Ys4pAlJzwMpGLaZvE=;
        b=PpljBR0l9OJE1Y6HyOXvHreRYUUYBoPZpx/7U3+xOBtReZN0eN/wC8f1kXyV1liAcI
         t8Scj+JgajWyMfeglNntBZqaAJuOkDKw8QgBlF0roTDoR9XWPy7h2cAAS6a+4K9FIE6g
         nOaIiNcPf5aqZ4uHETHkL0WnLZukRtxQFumv6ilOhHs4j2ceL+2Z15JYDy/00GywXl55
         CKmnjCqrmf/FLhGQjLn/juipqLMdMuK7t4YWKMGYjaX1I2Qk0hwS+rRur3ol1CUwycmd
         cFfHuBPhEI+UsbxwZkURZVn07jsDsbalrb/0TdRqeO5Upndknu5qP6ifeXSL97w8vEEJ
         LjuA==
X-Gm-Message-State: ACgBeo0RlpdUIEdoAVAhS42xjZlG79IV0kh/USomR0jrKsdq6bMZTYrE
        N/jFa3k4bQBjKGU+mpmBo/GDvFdWIEEqeQ+VYDBkkUKc
X-Google-Smtp-Source: AA6agR5EqE+qu2yrrk+ZqY6rMR6opoCyzMm7dXQixcRI39V4pkR1u1FYZQS7ob9gRt/VoBkuv65PObZ5t+BtwwWAS+w=
X-Received: by 2002:a4a:9731:0:b0:35e:fd1a:d452 with SMTP id
 u46-20020a4a9731000000b0035efd1ad452mr8346187ooi.8.1660058378106; Tue, 09 Aug
 2022 08:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220719153045.70041-1-cgzones@googlemail.com> <CAP+JOzQ2P8dpPo+8uNu52Lt-5xSSYdew-6k15CGETCsGxK12Fg@mail.gmail.com>
In-Reply-To: <CAP+JOzQ2P8dpPo+8uNu52Lt-5xSSYdew-6k15CGETCsGxK12Fg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 9 Aug 2022 11:19:27 -0400
Message-ID: <CAP+JOzQ6BfooP9YPyyXDYG+0P-wbFQhbyM274Eb3_HjQcDiLEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] libsepol/tests: add ebitmap tests
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 20, 2022 at 3:51 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Jul 19, 2022 at 11:34 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Preparation for several ebitmap related optimizations.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For this series:
> Acked-by: James Carter <jwcart2@gmail.com>
>

This series has been merged.
Thanks,
Jim

> > ---
> > v2:
> >   - add more tests for multi node ebitmaps and for bits set at node
> >     bounds
> >   - test ebitmap_for_each_bit()
> > ---
> >  libsepol/tests/libsepol-tests.c |    2 +
> >  libsepol/tests/test-ebitmap.c   | 1048 +++++++++++++++++++++++++++++++
> >  libsepol/tests/test-ebitmap.h   |   10 +
> >  3 files changed, 1060 insertions(+)
> >  create mode 100644 libsepol/tests/test-ebitmap.c
> >  create mode 100644 libsepol/tests/test-ebitmap.h
> >
> > diff --git a/libsepol/tests/libsepol-tests.c b/libsepol/tests/libsepol-=
tests.c
> > index dc8fd5ce..5ae6bedc 100644
> > --- a/libsepol/tests/libsepol-tests.c
> > +++ b/libsepol/tests/libsepol-tests.c
> > @@ -19,6 +19,7 @@
> >   */
> >
> >  #include "test-cond.h"
> > +#include "test-ebitmap.h"
> >  #include "test-linker.h"
> >  #include "test-expander.h"
> >  #include "test-deps.h"
> > @@ -64,6 +65,7 @@ static bool do_tests(int interactive, int verbose)
> >         if (CUE_SUCCESS !=3D CU_initialize_registry())
> >                 return CU_get_error();
> >
> > +       DECLARE_SUITE(ebitmap);
> >         DECLARE_SUITE(cond);
> >         DECLARE_SUITE(linker);
> >         DECLARE_SUITE(expander);
> > diff --git a/libsepol/tests/test-ebitmap.c b/libsepol/tests/test-ebitma=
p.c
> > new file mode 100644
> > index 00000000..fad5bd75
> > --- /dev/null
> > +++ b/libsepol/tests/test-ebitmap.c
> > @@ -0,0 +1,1048 @@
> > +#include "test-ebitmap.h"
> > +
> > +#include <stdlib.h>
> > +#include <time.h>
> > +
> > +#include <sepol/debug.h>
> > +#include <sepol/policydb/ebitmap.h>
> > +
> > +#define RANDOM_ROUNDS 10
> > +
> > +
> > +static int ebitmap_init_random(ebitmap_t *e, unsigned int length, int =
set_chance)
> > +{
> > +       unsigned int i;
> > +       int rc;
> > +
> > +       if (set_chance <=3D 0 || set_chance > 100)
> > +               return -EINVAL;
> > +
> > +       ebitmap_init(e);
> > +
> > +       for (i =3D 0; i < length; i++) {
> > +               if ((random() % 100) < set_chance) {
> > +                       rc =3D ebitmap_set_bit(e, i, 1);
> > +                       if (rc)
> > +                               return rc;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void test_ebitmap_init_destroy(void)
> > +{
> > +       ebitmap_t e;
> > +
> > +       /* verify idempotence */
> > +       ebitmap_init(&e);
> > +       ebitmap_init(&e);
> > +       ebitmap_init(&e);
> > +
> > +       CU_ASSERT(ebitmap_is_empty(&e));
> > +       CU_ASSERT_PTR_NULL(ebitmap_startnode(&e));
> > +
> > +       /* verify idempotence */
> > +       ebitmap_destroy(&e);
> > +       ebitmap_destroy(&e);
> > +       ebitmap_destroy(&e);
> > +
> > +       CU_ASSERT(ebitmap_is_empty(&e));
> > +       CU_ASSERT_PTR_NULL(ebitmap_startnode(&e));
> > +}
> > +
> > +static void test_ebitmap_cmp(void)
> > +{
> > +       ebitmap_t e1, e2;
> > +
> > +       ebitmap_init(&e1);
> > +       ebitmap_init(&e2);
> > +
> > +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
> > +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 10, 1), 0);
> > +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 63, 1), 0);
> > +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 63, 1), 0);
> > +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 64, 1), 0);
> > +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 64, 1), 0);
> > +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1022, 1), 0);
> > +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 1022, 1), 0);
> > +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1023, 1), 0);
> > +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 1023, 1), 0);
> > +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1024, 1), 0);
> > +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 1024, 1), 0);
> > +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1025, 1), 0);
> > +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 1025, 1), 0);
> > +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 255, 1), 0);
> > +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 255, 1), 0);
> > +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 256, 1), 0);
> > +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 256, 1), 0);
> > +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 639, 1), 0);
> > +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 639, 1), 0);
> > +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 640, 1), 0);
> > +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 640, 1), 0);
> > +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 900, 1), 0);
> > +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 900, 1), 0);
> > +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> > +
> > +       ebitmap_destroy(&e2);
> > +
> > +       CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
> > +
> > +       ebitmap_destroy(&e1);
> > +
> > +       CU_ASSERT(ebitmap_cmp(&e1, &e2));
> > +}
> > +
> > +static void test_ebitmap_set_and_get(void)
> > +{
> > +       ebitmap_t e;
> > +
> > +       ebitmap_init(&e);
> > +
> > +       CU_ASSERT(ebitmap_is_empty(&e));
> > +       CU_ASSERT_TRUE(ebitmap_is_empty(&e));
> > +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 10), 0);
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, UINT32_MAX, 1), -EINVAL);
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 10, 0), 0);
> > +       CU_ASSERT(ebitmap_is_empty(&e));
> > +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 10), 0);
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 10, 1), 0);
> > +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> > +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 1);
> > +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 10);
> > +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 10), 1);
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 100, 1), 0);
> > +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> > +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 2);
> > +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 100);
> > +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 100), 1);
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 50, 1), 0);
> > +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> > +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 3);
> > +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 100);
> > +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 50), 1);
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 1023, 1), 0);
> > +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> > +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 4);
> > +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1023);
> > +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 1023), 1);
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 1024, 1), 0);
> > +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> > +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 5);
> > +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1024);
> > +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 1024), 1);
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 1050, 1), 0);
> > +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> > +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 6);
> > +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1050);
> > +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 1050), 1);
> > +
> > +       {
> > +               ebitmap_node_t *n;
> > +               unsigned int bit, count;
> > +
> > +               /* iterate all allocated bits */
> > +               count =3D 0;
> > +               ebitmap_for_each_bit(&e, n, bit) {
> > +                       CU_ASSERT(                bit <   64  ||
> > +                                 (64   <=3D bit && bit <  128) ||
> > +                                 (960  <=3D bit && bit < 1024) ||
> > +                                 (1024 <=3D bit && bit < 1088));
> > +                       count++;
> > +               }
> > +               CU_ASSERT_EQUAL(count, 4 * 64);
> > +
> > +               count =3D 0;
> > +               ebitmap_for_each_positive_bit(&e, n, bit) {
> > +                       CU_ASSERT(bit =3D=3D 10 ||
> > +                                 bit =3D=3D 50 ||
> > +                                 bit =3D=3D 100 ||
> > +                                 bit =3D=3D 1023 ||
> > +                                 bit =3D=3D 1024 ||
> > +                                 bit =3D=3D 1050);
> > +                       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, bit), 1);
> > +                       count++;
> > +               }
> > +               CU_ASSERT_EQUAL(count, 6);
> > +       }
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 1024, 0), 0);
> > +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> > +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 5);
> > +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1050);
> > +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 1024), 0);
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 1050, 0), 0);
> > +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> > +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 4);
> > +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1023);
> > +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 1050), 0);
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 100, 0), 0);
> > +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> > +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 3);
> > +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1023);
> > +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 100), 0);
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 10, 0), 0);
> > +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> > +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 2);
> > +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1023);
> > +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 10), 0);
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 50, 0), 0);
> > +       CU_ASSERT_FALSE(ebitmap_is_empty(&e));
> > +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 1);
> > +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1023);
> > +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 50), 0);
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 1023, 0), 0);
> > +       CU_ASSERT_TRUE(ebitmap_is_empty(&e));
> > +       CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 1023), 0);
> > +
> > +       ebitmap_destroy(&e);
> > +}
> > +
> > +static void test_ebitmap_or(void)
> > +{
> > +       ebitmap_t e1, e2, e3, e4;
> > +
> > +       ebitmap_init(&e1);
> > +       ebitmap_init(&e2);
> > +       ebitmap_init(&e3);
> > +       ebitmap_init(&e4);
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 100, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 101, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 318, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 319, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 383, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 384, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 449, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1013, 1), 0);
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 11, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 101, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 430, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 665, 1), 0);
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 10, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 11, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 100, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 101, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 318, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 319, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 383, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 384, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 430, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 449, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 665, 1), 0);
> > +       CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 1013, 1), 0);
> > +
> > +       {
> > +               ebitmap_t dst;
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_or(&dst, &e1, &e1), 0);
> > +               CU_ASSERT(ebitmap_cmp(&dst, &e1));
> > +
> > +               ebitmap_destroy(&dst);
> > +       }
> > +
> > +       {
> > +               ebitmap_t dst;
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_or(&dst, &e2, &e2), 0);
> > +               CU_ASSERT(ebitmap_cmp(&dst, &e2));
> > +
> > +               ebitmap_destroy(&dst);
> > +       }
> > +
> > +       {
> > +               ebitmap_t dst;
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_or(&dst, &e1, &e2), 0);
> > +               CU_ASSERT(ebitmap_cmp(&dst, &e3));
> > +
> > +               ebitmap_destroy(&dst);
> > +       }
> > +
> > +       {
> > +               ebitmap_t dst;
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_or(&dst, &e3, &e3), 0);
> > +               CU_ASSERT(ebitmap_cmp(&dst, &e3));
> > +
> > +               ebitmap_destroy(&dst);
> > +       }
> > +
> > +       {
> > +               ebitmap_t dst;
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_or(&dst, &e3, &e4), 0);
> > +               CU_ASSERT(ebitmap_cmp(&dst, &e3));
> > +
> > +               ebitmap_destroy(&dst);
> > +       }
> > +
> > +       {
> > +               ebitmap_t dst;
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_or(&dst, &e4, &e4), 0);
> > +               CU_ASSERT(ebitmap_cmp(&dst, &e4));
> > +
> > +               ebitmap_destroy(&dst);
> > +       }
> > +
> > +       ebitmap_destroy(&e4);
> > +       ebitmap_destroy(&e3);
> > +       ebitmap_destroy(&e2);
> > +       ebitmap_destroy(&e1);
> > +}
> > +
> > +static void test_ebitmap_and(void)
> > +{
> > +       {
> > +               ebitmap_t e1, e2, e12, e3, e4;
> > +
> > +               ebitmap_init(&e1);
> > +               ebitmap_init(&e2);
> > +               ebitmap_init(&e12);
> > +               ebitmap_init(&e3);
> > +               ebitmap_init(&e4);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 100, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 101, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 318, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 319, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 383, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 384, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 449, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1013, 1), 0);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 11, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 101, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 319, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 665, 1), 0);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 101, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 319, 1), 0);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 10, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 11, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 100, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 101, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 318, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 319, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 383, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 384, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 430, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 449, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 665, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 1013, 1), 0);
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_and(&dst, &e1, &e1), 0)=
;
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e1));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_and(&dst, &e2, &e2), 0)=
;
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e2));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_and(&dst, &e1, &e2), 0)=
;
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e12));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_and(&dst, &e3, &e3), 0)=
;
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e3));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_and(&dst, &e1, &e3), 0)=
;
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e1));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_and(&dst, &e2, &e3), 0)=
;
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e2));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_and(&dst, &e4, &e4), 0)=
;
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e4));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_and(&dst, &e3, &e4), 0)=
;
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e4));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               ebitmap_destroy(&e4);
> > +               ebitmap_destroy(&e3);
> > +               ebitmap_destroy(&e12);
> > +               ebitmap_destroy(&e2);
> > +               ebitmap_destroy(&e1);
> > +       }
> > +
> > +       {
> > +               ebitmap_t e5;
> > +               ebitmap_t e6;
> > +               ebitmap_t e56;
> > +               ebitmap_t dst;
> > +
> > +               ebitmap_init(&e5);
> > +               ebitmap_init(&e6);
> > +               ebitmap_init(&e56);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 63, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 191, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 192, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 318, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 319, 1), 0);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 64, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 192, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 319, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 320, 1), 0);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 192, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 319, 1), 0);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_and(&dst, &e5, &e6), 0);
> > +               CU_ASSERT(ebitmap_cmp(&dst, &e56));
> > +
> > +               ebitmap_destroy(&dst);
> > +               ebitmap_destroy(&e56);
> > +               ebitmap_destroy(&e6);
> > +               ebitmap_destroy(&e5);
> > +       }
> > +}
> > +
> > +static void test_ebitmap_xor(void)
> > +{
> > +       {
> > +               ebitmap_t e1, e2, e3, e4;
> > +
> > +               ebitmap_init(&e1);
> > +               ebitmap_init(&e2);
> > +               ebitmap_init(&e3);
> > +               ebitmap_init(&e4);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 5, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 1, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 3, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 6, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 9, 1), 0);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 3, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 5, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 6, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 9, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 10, 1), 0);
> > +
> > +               {
> > +                       ebitmap_t dst1, dst2;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_xor(&dst1, &e1, &e1), 0=
);
> > +                       CU_ASSERT(ebitmap_cmp(&dst1, &e4));
> > +                       CU_ASSERT_EQUAL(ebitmap_xor(&dst2, &dst1, &e1),=
 0);
> > +                       CU_ASSERT(ebitmap_cmp(&dst2, &e1));
> > +
> > +                       ebitmap_destroy(&dst2);
> > +                       ebitmap_destroy(&dst1);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e2, &e2), 0)=
;
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e4));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e3, &e3), 0)=
;
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e4));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e4, &e4), 0)=
;
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e4));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e1, &e2), 0)=
;
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e3));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e2, &e4), 0)=
;
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e2));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               ebitmap_destroy(&e4);
> > +               ebitmap_destroy(&e3);
> > +               ebitmap_destroy(&e2);
> > +               ebitmap_destroy(&e1);
> > +       }
> > +
> > +       {
> > +               ebitmap_t e5;
> > +               ebitmap_t e6;
> > +               ebitmap_t e56;
> > +               ebitmap_t dst;
> > +
> > +               ebitmap_init(&e5);
> > +               ebitmap_init(&e6);
> > +               ebitmap_init(&e56);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 63, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 191, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 192, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 318, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 319, 1), 0);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 64, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 192, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 319, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 320, 1), 0);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 63, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 64, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 191, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 318, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 320, 1), 0);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e5, &e6), 0);
> > +               CU_ASSERT(ebitmap_cmp(&dst, &e56));
> > +
> > +               ebitmap_destroy(&dst);
> > +               ebitmap_destroy(&e56);
> > +               ebitmap_destroy(&e6);
> > +               ebitmap_destroy(&e5);
> > +       }
> > +}
> > +
> > +static void test_ebitmap_not(void)
> > +{
> > +       {
> > +               ebitmap_t e1, e2, e3, e4;
> > +
> > +               ebitmap_init(&e1);
> > +               ebitmap_init(&e2);
> > +               ebitmap_init(&e3);
> > +               ebitmap_init(&e4);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 0, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 5, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 2, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 3, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 4, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 6, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 7, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 8, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 9, 1), 0);
> > +
> > +               {
> > +                       ebitmap_t dst1, dst2;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_not(&dst1, &e3, 10), 0)=
;
> > +                       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&dst1),=
 9);
> > +                       CU_ASSERT_EQUAL(ebitmap_cardinality(&dst1), 10)=
;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_not(&dst2, &dst1, 10), =
0);
> > +                       CU_ASSERT(ebitmap_cmp(&dst2, &e3));
> > +
> > +                       ebitmap_destroy(&dst2);
> > +                       ebitmap_destroy(&dst1);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst1, dst2;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_not(&dst1, &e1, 11), 0)=
;
> > +                       CU_ASSERT(ebitmap_cmp(&dst1, &e2));
> > +                       CU_ASSERT_EQUAL(ebitmap_not(&dst2, &dst1, 11), =
0);
> > +                       CU_ASSERT(ebitmap_cmp(&dst2, &e1));
> > +
> > +                       ebitmap_destroy(&dst2);
> > +                       ebitmap_destroy(&dst1);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_not(&dst, &e1, 8), 0);
> > +                       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&dst), =
7);
> > +                       CU_ASSERT_EQUAL(ebitmap_cardinality(&dst), 5);
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_not(&dst, &e1, 12), 0);
> > +                       CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&dst), =
11);
> > +                       CU_ASSERT_EQUAL(ebitmap_cardinality(&dst), 8);
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               ebitmap_destroy(&e3);
> > +               ebitmap_destroy(&e2);
> > +               ebitmap_destroy(&e1);
> > +       }
> > +
> > +       {
> > +               ebitmap_t e5;
> > +               ebitmap_t e5not;
> > +               ebitmap_node_t *n;
> > +               unsigned int bit;
> > +
> > +               ebitmap_init(&e5);
> > +               ebitmap_init(&e5not);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 63, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 191, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 192, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 318, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 319, 1), 0);
> > +
> > +               for (bit =3D 0; bit < 317; bit++)
> > +                       CU_ASSERT_EQUAL(ebitmap_set_bit(&e5not, bit, 1)=
, 0);
> > +               ebitmap_for_each_positive_bit(&e5, n, bit)
> > +                       CU_ASSERT_EQUAL(ebitmap_set_bit(&e5not, bit, 0)=
, 0);
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_not(&dst, &e5, 317), 0)=
;
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e5not));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_not(&dst, &e5, 318), 0)=
;
> > +                       CU_ASSERT_FALSE(ebitmap_cmp(&dst, &e5not));
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_set_bit(&e5not, 317, 1)=
, 0);
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e5not));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_not(&dst, &e5, 319), 0)=
;
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e5not));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               ebitmap_destroy(&e5not);
> > +               ebitmap_destroy(&e5);
> > +       }
> > +}
> > +
> > +static void test_ebitmap_andnot(void)
> > +{
> > +       {
> > +               ebitmap_t e1, e2, e12, e3, e4;
> > +
> > +               ebitmap_init(&e1);
> > +               ebitmap_init(&e2);
> > +               ebitmap_init(&e12);
> > +               ebitmap_init(&e3);
> > +               ebitmap_init(&e4);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 100, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 101, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 430, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1013, 1), 0);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 11, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 101, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 665, 1), 0);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 10, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 100, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 430, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 1013, 1), 0);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 10, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 11, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 100, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 101, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 430, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 665, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 1013, 1), 0);
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e1, &e1, =
1024), 0);
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e4));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e2, &e2, =
1024), 0);
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e4));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e1, &e2, =
1024), 0);
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e12));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e3, &e3, =
1024), 0);
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e4));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e1, &e3, =
1024), 0);
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e4));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e2, &e12,=
 1024), 0);
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e2));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e4, &e4, =
1024), 0);
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e4));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e3, &e4, =
1024), 0);
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e3));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               ebitmap_destroy(&e4);
> > +               ebitmap_destroy(&e3);
> > +               ebitmap_destroy(&e12);
> > +               ebitmap_destroy(&e2);
> > +               ebitmap_destroy(&e1);
> > +       }
> > +
> > +       {
> > +               ebitmap_t e5;
> > +               ebitmap_t e6;
> > +               ebitmap_t e56;
> > +
> > +               ebitmap_init(&e5);
> > +               ebitmap_init(&e6);
> > +               ebitmap_init(&e56);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 63, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 191, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 192, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 318, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 319, 1), 0);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 64, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 192, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 319, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 320, 1), 0);
> > +
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 63, 1), 0);
> > +               CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 191, 1), 0);
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e5, &e6, =
317), 0);
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e56));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e5, &e6, =
318), 0);
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e56));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e5, &e6, =
319), 0);
> > +                       CU_ASSERT_FALSE(ebitmap_cmp(&dst, &e56));
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 318, 1), =
0);
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e56));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               {
> > +                       ebitmap_t dst;
> > +
> > +                       CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e5, &e6, =
320), 0);
> > +                       CU_ASSERT(ebitmap_cmp(&dst, &e56));
> > +
> > +                       ebitmap_destroy(&dst);
> > +               }
> > +
> > +               ebitmap_destroy(&e56);
> > +               ebitmap_destroy(&e6);
> > +               ebitmap_destroy(&e5);
> > +       }
> > +}
> > +
> > +static void test_ebitmap__random_impl(unsigned int length, int set_cha=
nce)
> > +{
> > +       ebitmap_t e1, e2, dst_cpy, dst_or, dst_and, dst_xor1, dst_xor2,=
 dst_not1, dst_not2, dst_andnot;
> > +       unsigned int i;
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_init_random(&e1, length, set_chance), 0=
);
> > +       CU_ASSERT_EQUAL(ebitmap_init_random(&e2, length, set_chance), 0=
);
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_cpy(&dst_cpy, &e1), 0);
> > +       CU_ASSERT(ebitmap_cmp(&dst_cpy, &e1));
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_or(&dst_or, &e1, &e2), 0);
> > +       for (i =3D 0; i < length; i++)
> > +               CU_ASSERT_EQUAL(ebitmap_get_bit(&dst_or, i), ebitmap_ge=
t_bit(&e1, i) | ebitmap_get_bit(&e2, i));
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_and(&dst_and, &e1, &e2), 0);
> > +       for (i =3D 0; i < length; i++)
> > +               CU_ASSERT_EQUAL(ebitmap_get_bit(&dst_and, i), ebitmap_g=
et_bit(&e1, i) & ebitmap_get_bit(&e2, i));
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_xor(&dst_xor1, &e1, &e2), 0);
> > +       for (i =3D 0; i < length; i++)
> > +               CU_ASSERT_EQUAL(ebitmap_get_bit(&dst_xor1, i), ebitmap_=
get_bit(&e1, i) ^ ebitmap_get_bit(&e2, i));
> > +       CU_ASSERT_EQUAL(ebitmap_xor(&dst_xor2, &dst_xor1, &e2), 0);
> > +       CU_ASSERT(ebitmap_cmp(&dst_xor2, &e1));
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_not(&dst_not1, &e1, length), 0);
> > +       for (i =3D 0; i < length; i++)
> > +               CU_ASSERT_EQUAL(ebitmap_get_bit(&dst_not1, i), !ebitmap=
_get_bit(&e1, i));
> > +       CU_ASSERT_EQUAL(ebitmap_not(&dst_not2, &dst_not1, length), 0);
> > +       CU_ASSERT(ebitmap_cmp(&dst_not2, &e1));
> > +
> > +       CU_ASSERT_EQUAL(ebitmap_andnot(&dst_andnot, &e1, &e2, length), =
0);
> > +       for (i =3D 0; i < length; i++)
> > +               CU_ASSERT_EQUAL(ebitmap_get_bit(&dst_andnot, i), ebitma=
p_get_bit(&e1, i) & !ebitmap_get_bit(&e2, i));
> > +
> > +       ebitmap_destroy(&dst_andnot);
> > +       ebitmap_destroy(&dst_not2);
> > +       ebitmap_destroy(&dst_not1);
> > +       ebitmap_destroy(&dst_xor2);
> > +       ebitmap_destroy(&dst_xor1);
> > +       ebitmap_destroy(&dst_and);
> > +       ebitmap_destroy(&dst_or);
> > +       ebitmap_destroy(&dst_cpy);
> > +       ebitmap_destroy(&e2);
> > +       ebitmap_destroy(&e1);
> > +}
> > +
> > +static void test_ebitmap__random(void)
> > +{
> > +       unsigned int i;
> > +
> > +       for (i =3D 0; i < RANDOM_ROUNDS; i++)
> > +               test_ebitmap__random_impl(5, 10);
> > +
> > +       for (i =3D 0; i < RANDOM_ROUNDS; i++)
> > +               test_ebitmap__random_impl(5, 90);
> > +
> > +       for (i =3D 0; i < RANDOM_ROUNDS; i++)
> > +               test_ebitmap__random_impl(1024, 50);
> > +
> > +       for (i =3D 0; i < RANDOM_ROUNDS; i++)
> > +               test_ebitmap__random_impl(8000, 5);
> > +
> > +       for (i =3D 0; i < RANDOM_ROUNDS; i++)
> > +               test_ebitmap__random_impl(8000, 95);
> > +}
> > +
> > +/*
> > + * External hooks
> > + */
> > +
> > +int ebitmap_test_init(void)
> > +{
> > +       srandom(time(NULL));
> > +
> > +       /* silence ebitmap_set_bit() failure message */
> > +       sepol_debug(0);
> > +
> > +       return 0;
> > +}
> > +
> > +int ebitmap_test_cleanup(void)
> > +{
> > +       return 0;
> > +}
> > +
> > +#define ADD_TEST(name) \
> > +       do { \
> > +               if (NULL =3D=3D CU_add_test(suite, #name, test_##name))=
 { \
> > +                       return CU_get_error(); \
> > +               } \
> > +       } while (0)
> > +
> > +int ebitmap_add_tests(CU_pSuite suite)
> > +{
> > +       ADD_TEST(ebitmap_init_destroy);
> > +       ADD_TEST(ebitmap_cmp);
> > +       ADD_TEST(ebitmap_set_and_get);
> > +       ADD_TEST(ebitmap_or);
> > +       ADD_TEST(ebitmap_and);
> > +       ADD_TEST(ebitmap_xor);
> > +       ADD_TEST(ebitmap_not);
> > +       ADD_TEST(ebitmap_andnot);
> > +       ADD_TEST(ebitmap__random);
> > +       return 0;
> > +}
> > diff --git a/libsepol/tests/test-ebitmap.h b/libsepol/tests/test-ebitma=
p.h
> > new file mode 100644
> > index 00000000..952a0421
> > --- /dev/null
> > +++ b/libsepol/tests/test-ebitmap.h
> > @@ -0,0 +1,10 @@
> > +#ifndef TEST_EBITMAP_H__
> > +#define TEST_EBITMAP_H__
> > +
> > +#include <CUnit/Basic.h>
> > +
> > +int ebitmap_test_init(void);
> > +int ebitmap_test_cleanup(void);
> > +int ebitmap_add_tests(CU_pSuite suite);
> > +
> > +#endif  /* TEST_EBITMAP_H__ */
> > --
> > 2.36.1
> >

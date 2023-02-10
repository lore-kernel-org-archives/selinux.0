Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2002C05027
	for <selinux@archiver.kernel.org>; Fri, 10 Feb 2023 14:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjBJOJb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Feb 2023 09:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjBJOJ3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Feb 2023 09:09:29 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A0D7072D
        for <selinux@vger.kernel.org>; Fri, 10 Feb 2023 06:09:27 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id l8so5722928vsm.11
        for <selinux@vger.kernel.org>; Fri, 10 Feb 2023 06:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1676038167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geu/HGsoD2aNHYruaqukW5d2os+BVLuvBpDmjQYDINA=;
        b=YT9BLtjdJZZqEEb+AsVbvQnGzdfo5vPaup7jx8YWUAD7palTrFWHmItSiNYiyCRWbW
         5Ml2M8V/U4//NFfLQYkZWs20lPc41XtKKo66nkvyhjNbhNh2nDC+tDb4dyxZL05youHr
         dvNNnUv29oscaxUpRhluGvVl4voL+C5akkDd6qvKqqPan/0n0vP6hFLzqkrCuhloKPKr
         jhQsB83qyyom0y87NxC941X/ar1MbAZuV9/srzh8kDL26QR149CwBhZr1Oo3DlIwFxRl
         4dLJ/9N4zxd25ZTk4ZOUiWS/rkQjMvxyS67DlyRvt+xVz0pDkJ8q0g5t9s09Fjso8zs1
         H5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676038167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geu/HGsoD2aNHYruaqukW5d2os+BVLuvBpDmjQYDINA=;
        b=q2nvoMe/1gVpqUsZ56t9c0jzBdLtret8l4T1XEYJffsos4YgO1adTTtdo+2iSULfkI
         9HOJ/OTHrmQ3CyM8u2B0UtcFBY017q/UymwY8OD51DpScbKd7Zp20R9PHAB9rcVtxaEx
         4fGthT/EQUyMmeKxvw3xHx5aUGI9KiTDEWS0dKR4hX62Pks18li22jqZNpIrYTCMuaRn
         IqQYvzB6U7rju9641gwlzCuaXuU/o8519Brkq+Ke8nBZ03pZ6eRIrYpZ6mq6dR6mpQbP
         vxk2/sf0GuYLKBkcQJgDC1spZCmlcExzpGouRFJ9R91y3ST+ejUrbWsyAL9TKa/OAot4
         2G2A==
X-Gm-Message-State: AO0yUKVnCZALIefOShzP/ndi8ygJmVaXis8iF7YeDW2mc3RAlxyxXqpg
        GrFu5nz3dcWjX3GyO0Qv9fmcgTanO6ctXzxSv+Dblh2a/phSj5zuNsA=
X-Google-Smtp-Source: AK7set9R2NkQ9bTdt+1o0+WGR3th3cV+JZio9QOBBUe41o1mZa6L5soe/Be+qgxq8UudivrJinXtCSeCB9hUioc+rvw=
X-Received: by 2002:a67:a402:0:b0:3d3:e956:1303 with SMTP id
 n2-20020a67a402000000b003d3e9561303mr3497116vse.71.1676038166678; Fri, 10 Feb
 2023 06:09:26 -0800 (PST)
MIME-Version: 1.0
References: <20230209114253.120485-1-wanghuizhao1@huawei.com> <20230209114253.120485-3-wanghuizhao1@huawei.com>
In-Reply-To: <20230209114253.120485-3-wanghuizhao1@huawei.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 10 Feb 2023 15:09:15 +0100
Message-ID: <CAJ2a_DckQ8whu-yRO227Ef7U-gfD98t674tsoBcTiL94oJakMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: performance optimization for duplicate detection
To:     wanghuizhao <wanghuizhao1@huawei.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 9 Feb 2023 at 12:54, wanghuizhao <wanghuizhao1@huawei.com> wrote:
>
> When semodule -i some.pp to install a module package, duplicate items are
> detected for the module. The detection function is nodups_specs in
> libselinux/src/label_file.c. The algorithm complexity of implementing
> this function is O(N^2). In scenarios where N is very large, the efficien=
cy
> is very low.
>
> To solve this problem, I propose to use the hash table to detect duplicat=
es.
> The algorithm complexity of new implementing is O(N). The execution effic=
iency
> will be greatly improved.
>
> Comparison between the execution time of the nodups_specs function.
>
> Old double-layer loop implementation O(N^2):
>
> semodule -i myapp1.pp
> nodups_specs data->nspec: 5002
> nodups_specs start: 11785.242s
> nodups_specs end:   11785.588s
> nodups_specs consumes:  0.346s
>
> semodule -i myapp2.pp
> nodups_specs data->nspec: 10002
> nodups_specs start: 11804.280s
> nodups_specs end:   11806.546s
> nodups_specs consumes:  2.266s
>
> semodule -i myapp3.pp
> nodups_specs data->nspec: 20002
> nodups_specs start: 11819.106s
> nodups_specs end:   11830.892s
> nodups_specs consumes: 11.786s
>
> New hash table implementation O(N):
>
> semodule -i myapp1.pp
> nodups_specs data->nspec: 5002
> nodups_specs start: 11785.588s
> nodups_specs end:   11785.590s
> nodups_specs consumes:  0.002s
>
> semodule -i myapp2.pp
> nodups_specs data->nspec: 10002
> nodups_specs start: 11806.546s
> nodups_specs end:   11806.552s
> nodups_specs consumes:  0.006s
>
> semodule -i myapp3.pp
> nodups_specs data->nspec: 20002
> nodups_specs start: 11830.892s
> nodups_specs end:   11830.905s
> nodups_specs consumes:  0.013s
>
> Signed-off-by: wanghuizhao <wanghuizhao1@huawei.com>
> ---
>  libselinux/src/label_file.c | 112 ++++++++++++++++++++++++++++++++++----=
------
>  libselinux/src/label_file.h |   5 ++
>  2 files changed, 93 insertions(+), 24 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 74ae9b9f..e4a85043 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -19,6 +19,7 @@
>  #include <sys/types.h>
>  #include <sys/stat.h>
>
> +#include "hashtab.h"
>  #include "callbacks.h"
>  #include "label_internal.h"
>  #include "label_file.h"
> @@ -57,40 +58,103 @@ static int find_stem_from_file(struct saved_data *da=
ta, const char *key)
>  }
>
>  /*
> + * hash calculation and key comparison of hash table
> + */
> +
> +static unsigned int symhash(hashtab_t h, const_hashtab_key_t key)
> +{
> +       const struct chkdups_key *k =3D (const struct chkdups_key *)key;
> +       const char *p =3D NULL;
> +       size_t size;
> +       unsigned int val =3D 0;
> +
> +       size =3D strlen(k->regex);
> +       for (p =3D k->regex; ((size_t) (p - k->regex)) < size; p++)
> +               val =3D
> +                       (val << 4 | (val >> (8 * sizeof(unsigned int) - 4=
)) +
> +                       k->mode) ^ (*p);

label_file.c: In function =E2=80=98symhash=E2=80=99:
label_file.c:74:77: error: suggest parentheses around arithmetic in
operand of =E2=80=98|=E2=80=99 [-Werror=3Dparentheses]
   74 |                         (val << 4 | (val >> (8 *
sizeof(unsigned int) - 4)) +
      |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
   75 |                         k->mode) ^ (*p);
      |                         ~~~~~~~

> +       return val % h->size;
> +}
> +
> +static int symcmp(hashtab_t h
> +                 __attribute__ ((unused)), const_hashtab_key_t key1,
> +                 const_hashtab_key_t key2)
> +{
> +       const struct chkdups_key *a =3D (const struct chkdups_key *)key1;
> +       const struct chkdups_key *b =3D (const struct chkdups_key *)key2;
> +
> +       return strcmp(a->regex, b->regex) || (a->mode && b->mode && a->mo=
de !=3D b->mode);
> +}
> +
> +/*
>   * Warn about duplicate specifications.
>   */
>  static int nodups_specs(struct saved_data *data, const char *path)
>  {
> -       int rc =3D 0;
> -       unsigned int ii, jj;
> +       int rc =3D 0, ret =3D 0;
> +       unsigned int ii;
>         struct spec *curr_spec, *spec_arr =3D data->spec_arr;
> +       struct chkdups_key *new =3D NULL;
> +       unsigned int hashtab_len =3D (data->nspec / 10) ? data->nspec / 1=
0 : 1;
> +       hashtab_ptr_t cur, temp;
>
> +       hashtab_t hash_table =3D hashtab_create(symhash, symcmp, data->ns=
pec);
> +       if (hash_table =3D=3D NULL) {
> +               rc =3D -1;
> +               COMPAT_LOG(SELINUX_ERROR, "%s: hashtab create failed.\n",=
 path);
> +               return rc;
> +       }
>         for (ii =3D 0; ii < data->nspec; ii++) {
> -               curr_spec =3D &spec_arr[ii];
> -               for (jj =3D ii + 1; jj < data->nspec; jj++) {
> -                       if ((!strcmp(spec_arr[jj].regex_str,
> -                               curr_spec->regex_str))
> -                           && (!spec_arr[jj].mode || !curr_spec->mode
> -                               || spec_arr[jj].mode =3D=3D curr_spec->mo=
de)) {
> -                               rc =3D -1;
> -                               errno =3D EINVAL;
> -                               if (strcmp(spec_arr[jj].lr.ctx_raw,
> -                                           curr_spec->lr.ctx_raw)) {
> -                                       COMPAT_LOG
> -                                               (SELINUX_ERROR,
> -                                                "%s: Multiple different =
specifications for %s  (%s and %s).\n",
> -                                                path, curr_spec->regex_s=
tr,
> -                                                spec_arr[jj].lr.ctx_raw,
> -                                                curr_spec->lr.ctx_raw);
> -                               } else {
> -                                       COMPAT_LOG
> -                                               (SELINUX_ERROR,
> -                                                "%s: Multiple same speci=
fications for %s.\n",
> -                                                path, curr_spec->regex_s=
tr);
> -                               }
> +               new =3D (struct chkdups_key *)malloc(sizeof(struct chkdup=
s_key));

oom check missing

> +               new->regex =3D spec_arr[ii].regex_str;
> +               new->mode =3D spec_arr[ii].mode;
> +               ret =3D hashtab_insert(hash_table, (hashtab_key_t)new, &s=
pec_arr[ii]);
> +               if (ret =3D=3D HASHTAB_SUCCESS)
> +                       continue;
> +               if (ret =3D=3D HASHTAB_PRESENT) {
> +                       curr_spec =3D
> +                               (struct spec *)hashtab_search(hash_table,=
 (hashtab_key_t)new);
> +                       rc =3D -1;
> +                       errno =3D EINVAL;
> +                       if (strcmp(spec_arr[ii].lr.ctx_raw, curr_spec->lr=
.ctx_raw)) {
> +                               COMPAT_LOG
> +                                       (SELINUX_ERROR,
> +                                        "%s: Multiple different specific=
ations for %s  (%s and %s).\n",
> +                                        path, curr_spec->regex_str,
> +                                        spec_arr[ii].lr.ctx_raw,
> +                                        curr_spec->lr.ctx_raw);
> +                       } else {
> +                               COMPAT_LOG
> +                                       (SELINUX_ERROR,
> +                                        "%s: Multiple same specification=
s for %s.\n",
> +                                        path, curr_spec->regex_str);
>                         }

`new` leaking

>                 }
> +               if (ret =3D=3D HASHTAB_OVERFLOW) {
> +                       rc =3D -1;
> +                       COMPAT_LOG
> +                               (SELINUX_ERROR,
> +                               "%s: hashtab happen memory error.\n",
> +                               path);
> +                       break;

`new` leaking

> +               }
> +       }
> +
> +       for (ii =3D 0; ii < hashtab_len; ii++) {
> +               cur =3D hash_table->htable[ii];
> +               while (cur !=3D NULL) {
> +                       temp =3D cur;
> +                       cur =3D cur->next;
> +                       free(temp->key);
> +                       free(temp);
> +               }
> +               hash_table->htable[ii] =3D NULL;
>         }

The common way of destroying hash-tables is hashtab_destroy().
Since the keys need to be free'd as well `hashtab_map(hash_table,
key_destroy, NULL)` with a custom key_destroy function can be used.
(To avoid iterating the hash-table twice hashtab_destroy() could be
modified to take an optional key destroy callback.)

> +
> +       free(hash_table->htable);
> +       hash_table->htable =3D NULL;
> +       free(hash_table);
> +
>         return rc;
>  }
>
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 190bc175..ad79319e 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -35,6 +35,11 @@
>  /* Required selinux_restorecon and selabel_get_digests_all_partial_match=
es() */
>  #define RESTORECON_PARTIAL_MATCH_DIGEST  "security.sehash"
>
> +struct chkdups_key {
> +       char *regex;
> +       unsigned int mode;
> +};

Why declare in the header and not in the source file?

> +
>  struct selabel_sub {
>         char *src;
>         int slen;
> --
> 2.12.3
>

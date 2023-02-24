Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CAEC61DA3
	for <selinux@archiver.kernel.org>; Fri, 24 Feb 2023 12:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBXMAq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Feb 2023 07:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBXMAp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Feb 2023 07:00:45 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D57016ADF
        for <selinux@vger.kernel.org>; Fri, 24 Feb 2023 04:00:43 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id o2so7756644vss.8
        for <selinux@vger.kernel.org>; Fri, 24 Feb 2023 04:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGXnK/36fOjk09RFHRLge3UD7BO6mLu6jPE5mg6B/u4=;
        b=dlmdMxBr8Qx6JML/3P81egECyVHq6o9Y53SXpo/dK8YwOGFV09Hu5hZwaILxHoTAmJ
         AeywngZPEgO1eGgSShO+SvOAAnNe2gtpne79yB1m74eI9g59W2zrzYqUEXzyU2C+QUQR
         51bJSYzfcqfNVFhzsLBq4IIrRinPDlqECl1TyPtUxp/HsygiaIFrsVHVeX+up2ZxxMsT
         FS8O9qW46URV2Iry1VrY75zBnRkKW/tJOMIafOLkTXW33Qp2ffvDZ0JoRI7OlBBwStFR
         tiM6DabBLB6l74PL0ujVwxhQtkNcQ3Xm+dec5IRYNyF0QONGVK93rE9EaMTos2P092rF
         t5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGXnK/36fOjk09RFHRLge3UD7BO6mLu6jPE5mg6B/u4=;
        b=hr4aost5W98J6wdDNRmW0mKEPToDB9nybYzxCzXF0/ajxxvjBxgSffQCgH7hFZrkFo
         5YiaLq1vGwQydTBB2R7eChMzHHfZPttCJFnUyHpOrvapk7cYIP07KRlL1KP2YKp5VYbw
         EAMpChMzwUhqfs7tEE6SlordMZCy8eHc9Js+hTtsRKfwHJs89cmgCfgfu9U50BO9xwZs
         diGxMvF7ug1dHvVAyAjgdWogOgrYbGrvcogozrn7zYpfEtg182CqsJX4Bdd3acXyiZ82
         gUiq8/Os/BIQEeuZ++6fZ6x37+kqZ2HrM6aJLgk79PK6fy3Dot8ytUZCXSkM3qy/OMiB
         1NmA==
X-Gm-Message-State: AO0yUKVb9+jH5Upte97hZBLLG6xmzmyEOWesua8ukoqYQVOojMi+HZeU
        E5YG0lkCRUmiib4/TkkO9ooBJ4sirox49GImN8TBVGrrErIA1Zn7pg8=
X-Google-Smtp-Source: AK7set+fEUTavGNQK89epKbdjeJAVUMym0p0ol+W/vB4U3Qn69N27JAhAa44C5DEm2CGGmbiu38ybAsBjS0W0JYY2g4=
X-Received: by 2002:a67:fbd2:0:b0:411:fff6:3cc4 with SMTP id
 o18-20020a67fbd2000000b00411fff63cc4mr2273114vsr.3.1677240041861; Fri, 24 Feb
 2023 04:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20230209114253.120485-1-wanghuizhao1@huawei.com>
 <20230217084458.40597-1-wanghuizhao1@huawei.com> <20230217084458.40597-4-wanghuizhao1@huawei.com>
In-Reply-To: <20230217084458.40597-4-wanghuizhao1@huawei.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 24 Feb 2023 13:00:30 +0100
Message-ID: <CAJ2a_DeQaPZV+GRTFM+HOHUkyTBe=hLdD5pJxOryJ+X2_y1zNw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] libselinux: performance optimization for duplicate detection
To:     wanghuizhao <wanghuizhao1@huawei.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 17 Feb 2023 at 09:45, wanghuizhao <wanghuizhao1@huawei.com> wrote:
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

Isn't the new complexity O(N * log(N)) due to the hashtable insertion
of O(log(N))?

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
>  libselinux/src/label_file.c | 118 +++++++++++++++++++++++++++++++++++---=
------
>  1 file changed, 94 insertions(+), 24 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 74ae9b9f..eebf9665 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -19,10 +19,17 @@
>  #include <sys/types.h>
>  #include <sys/stat.h>
>
> +#include "hashtab.h"
>  #include "callbacks.h"
>  #include "label_internal.h"
>  #include "label_file.h"
>
> +
> +struct chkdups_key {
> +       char *regex;
> +       unsigned int mode;
> +};
> +
>  /*
>   * Internals, mostly moved over from matchpathcon.c
>   */
> @@ -57,40 +64,103 @@ static int find_stem_from_file(struct saved_data *da=
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
> +                       ((val << 4) | ((val >> (8 * sizeof(unsigned int) =
- 4)) +
> +                       k->mode)) ^ (*p);

v1 added k->mode after the bit-wise or (probably changed by the added
parenthesis due to the compiler warning).
Using

     (((val << 4) | (val >> (8 * sizeof(unsigned int) - 4))) + k->mode) ^ (=
*p);

gives a slightly better spread (tested against refpolicy (master)):

    nodups_spec:  6062 entries and 606/606 buckets used, longest chain leng=
th 21
vs
    nodups_spec:  6062 entries and 606/606 buckets used, longest chain leng=
th 20

And for a adjusted hashtable size (see below):

    nodups_spec:  6062 entries and 3807/6062 buckets used, longest
chain length 6
vs
    nodups_spec:  6062 entries and 3815/6062 buckets used, longest
chain length 6

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
> +static int destroy_chkdups_key(hashtab_key_t key)
> +{
> +       free(key);
> +
> +       return 0;
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
>
> +       hashtab_t hash_table =3D hashtab_create(symhash, symcmp, hashtab_=
len);

v1 used a hashtable size of `data->nspec`, instead of its tenth.
Since the hashtable implementation from newrole does not contain a
resize feature, like the one from libsepol, the size will be fixed for
its lifetime.
Using `data.>nspec` gives slightly better (but probably negligible) perform=
ance:

    Benchmark 1: DESTDIR=3D~/Downloads/destdir/
./scripts/env_use_destdir ~/Downloads/destdir/sbin/setfiles -c
../refpolicy/tmp/policy.bin ../refpolicy/tmp/all_mods.fc
     Time (mean =C2=B1 =CF=83):     340.4 ms =C2=B1  14.4 ms    [User: 280.=
6 ms,
System: 59.7 ms]
     Range (min =E2=80=A6 max):   328.1 ms =E2=80=A6 386.0 ms    30 runs
vs
    Benchmark 1: DESTDIR=3D~/Downloads/destdir/
./scripts/env_use_destdir ~/Downloads/destdir/sbin/setfiles -c
../refpolicy/tmp/policy.bin ../refpolicy/tmp/all_mods.fc
     Time (mean =C2=B1 =CF=83):     334.7 ms =C2=B1   5.9 ms    [User: 279.=
6 ms,
System: 55.0 ms]
     Range (min =E2=80=A6 max):   327.5 ms =E2=80=A6 362.1 ms    30 runs

Since your policy contains much more file context definitions, could
you run some benchmarks yourself?

> +       if (!hash_table) {
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
> +               if (!new) {
> +                       rc =3D -1;
> +                       COMPAT_LOG(SELINUX_ERROR, "%s: hashtab key create=
 failed.\n", path);
> +                       return rc;
> +               }
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
> +                       free(new);
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
>                 }
> +               if (ret =3D=3D HASHTAB_OVERFLOW) {
> +                       rc =3D -1;
> +                       free(new);
> +                       COMPAT_LOG
> +                               (SELINUX_ERROR,
> +                               "%s: hashtab happen memory error.\n",
> +                               path);
> +                       break;
> +               }
>         }
> +
> +       hashtab_destroy_key(hash_table, destroy_chkdups_key);
> +
>         return rc;
>  }
>
> --
> 2.12.3
>

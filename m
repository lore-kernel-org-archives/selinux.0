Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BCD186608
	for <selinux@vger.kernel.org>; Thu,  5 Sep 2024 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563091; cv=none; b=Vtyk7sX4cdDwszFEHCgJ8xauKaycxhm17Tc0v9BmjhvWTWyRhw2JbjmPE13W+e/uOAJbiVVR01uZ5VSBRu8NdyzL1LuIfV4+pe2aMzC7XDQ3jGXubrVtPjbExxldCQcZAavuY3wxDzovqJVVerHSeESVhuwr/kj5DmR5w1VbeSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563091; c=relaxed/simple;
	bh=txNxohyYqNZlXDZeRZCbJuZdnEQkxpn1vX1YPrKv+TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6PN8kcIi7K2aS7sGcRENUKThYDkrFJvZtDfAEze3SXUcqvlgI7UlkV0rZuSGtZ6t829LEkBU0G0zFO9S87ZgYv1spyg8HtMxgLPgzdsX2jlhjYGaYrJmLzgT+2WE1PKlwc18bomKxAkKi+cCOcwS9pvlBjo+8bfoHpdgQ983cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTzYCLn+; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTzYCLn+"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3df04a2420aso698258b6e.1
        for <selinux@vger.kernel.org>; Thu, 05 Sep 2024 12:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725563089; x=1726167889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2JXS6Bpdrv7EnYbQHjGSwa7aIe802qHvGe3dZ6c9T8=;
        b=HTzYCLn+5uWsJYn5lNmKrXbMI82YQiZ5gw6cLXNODUMKyvXurZcVCxdy1wVsIBRBnL
         iUSnKucqZrMvdLpjCUxUeZyKZvCb8tdhfu+q3pkwQcXwCfY6BKAv7csAJL8JSZcgmwaj
         DKYmu8/mhEO/jw1g4qEqADOhDxe57zXF32+Sug4V1xYI4quooSdwXhsi4FzyYsgkn0KD
         ejd4BoxUU+F4mT8pqFnLcgkao7giBdqo1////dxFblHfw40N5aJVKkb+oLoP/gXeVTMI
         KyMDpOMc4+W2T33xfIACnUFIxbmJFe1TxluZNZFspxaKEiQMZe407Zi/LtFj4bvkCB5z
         2LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725563089; x=1726167889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2JXS6Bpdrv7EnYbQHjGSwa7aIe802qHvGe3dZ6c9T8=;
        b=TYP/0JpY/lqkaIpfP62InOWlzNKFzSzFQM6f7OotmTTdn1p6pIamdZPUxzXlVKkDDZ
         HhgS6h7lhm/mO4DSbNlFN/Lph2JkUTlmYvxmpQIZCK8T+Lp2JTUs4UloX4cnnQwGxhpw
         /l0daIt9qw68+jhuCoqqoqHpLnBirRXWy3HP51TYHA7VUOD2JdRiLEICmYCeqAxRIGQu
         MVHEsB3ge18J4nAbTCa+sh2YzJvHKLMv1QpgScTrlVzPDZ8kIXWi4ojmA0mXbt+Ujygn
         xlm8NcpzTkHsIro1ESzupqVV8IqcsOqbMcgqTWck9VoaMAZURk5YJMx8/ePmb25qU7rS
         t5CA==
X-Forwarded-Encrypted: i=1; AJvYcCWG10so0I2tq68e3xle9KJJdJ0oa2TP0OhlewHlEoHV9d97zPQ/glO/epwGNSVSEo2Lh6J6gJgu@vger.kernel.org
X-Gm-Message-State: AOJu0YwWkXydfYvJmXwH5as3Lt0XUyrW7v5747gfsv/IrOf5Aw7j6Odp
	Jg7n/rkZkb1uGUCOztSFbmoAFY76oOQ1MMVxiekKYKcALOnjIyokL9Rov/2tuHqbOpTQiUrKLFu
	bpxKdqxwDI3AvC8y/9L7fut+B/Jg07Q==
X-Google-Smtp-Source: AGHT+IHQ8/AzarCxKo6Spka+Q60mQ5uhXqEHF1UTlsmLTjDGAYiyDLUtPd+808O+0G9Vfdy9P0/je09bh51WGlZcMCs=
X-Received: by 2002:a05:6808:14d1:b0:3da:a6ce:f046 with SMTP id
 5614622812f47-3e029f2cc80mr418861b6e.38.1725563088740; Thu, 05 Sep 2024
 12:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826041044.1753994-1-tweek@google.com> <CAP+JOzQcuXtc-nQD3XLgki1=5p9-fm0-egPAh+uFXKJQSg3Syg@mail.gmail.com>
In-Reply-To: <CAP+JOzQcuXtc-nQD3XLgki1=5p9-fm0-egPAh+uFXKJQSg3Syg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 5 Sep 2024 15:04:37 -0400
Message-ID: <CAP+JOzQXH=TOcQgSQ0Jkn0WeEfuHOKaxgGf=EJdOipPNH3Ca3g@mail.gmail.com>
Subject: Re: [PATCH] libselinux: rename hashtab functions
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: paul@paul-moore.com, jeffv@google.com, selinux@vger.kernel.org, 
	wanghuizhao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 11:12=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Mon, Aug 26, 2024 at 12:11=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@go=
ogle.com> wrote:
> >
> > In commit d95bc8b75539 ("libselinux: migrating hashtab from
> > policycoreutils") and commit 4a420508a98c ("libselinux: adapting hashta=
b
> > to libselinux"), the hashtab implementation was copied to libselinux.
> > Since the same functions exist in libsepol (e.g., hashtab_create,
> > hashtab_destroy, etc), a compilation error is raised when both librarie=
s
> > are included statically.
> >
> > Prefix the libselinux internal implementation with "selinux_".
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Jim

> > ---
> >  libselinux/src/hashtab.c    | 16 ++++++++--------
> >  libselinux/src/hashtab.h    | 16 ++++++++--------
> >  libselinux/src/label_file.c | 10 +++++-----
> >  3 files changed, 21 insertions(+), 21 deletions(-)
> >
> > diff --git a/libselinux/src/hashtab.c b/libselinux/src/hashtab.c
> > index 7452613b..0c6641ed 100644
> > --- a/libselinux/src/hashtab.c
> > +++ b/libselinux/src/hashtab.c
> > @@ -11,7 +11,7 @@
> >  #include <string.h>
> >  #include "hashtab.h"
> >
> > -hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
> > +hashtab_t selinux_hashtab_create(unsigned int (*hash_value) (hashtab_t=
 h,
> >                                                      const_hashtab_key_=
t key),
> >                          int (*keycmp) (hashtab_t h,
> >                                         const_hashtab_key_t key1,
> > @@ -42,7 +42,7 @@ hashtab_t hashtab_create(unsigned int (*hash_value) (=
hashtab_t h,
> >         return p;
> >  }
> >
> > -int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t dat=
um)
> > +int selinux_hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_dat=
um_t datum)
> >  {
> >         unsigned int hvalue;
> >         hashtab_ptr_t prev, cur, newnode;
> > @@ -79,7 +79,7 @@ int hashtab_insert(hashtab_t h, hashtab_key_t key, ha=
shtab_datum_t datum)
> >         return HASHTAB_SUCCESS;
> >  }
> >
> > -int hashtab_remove(hashtab_t h, hashtab_key_t key,
> > +int selinux_hashtab_remove(hashtab_t h, hashtab_key_t key,
> >                    void (*destroy) (hashtab_key_t k,
> >                                     hashtab_datum_t d, void *args), voi=
d *args)
> >  {
> > @@ -112,7 +112,7 @@ int hashtab_remove(hashtab_t h, hashtab_key_t key,
> >         return HASHTAB_SUCCESS;
> >  }
> >
> > -hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t key)
> > +hashtab_datum_t selinux_hashtab_search(hashtab_t h, const_hashtab_key_=
t key)
> >  {
> >
> >         unsigned int hvalue;
> > @@ -132,7 +132,7 @@ hashtab_datum_t hashtab_search(hashtab_t h, const_h=
ashtab_key_t key)
> >         return cur->datum;
> >  }
> >
> > -void hashtab_destroy(hashtab_t h)
> > +void selinux_hashtab_destroy(hashtab_t h)
> >  {
> >         unsigned int i;
> >         hashtab_ptr_t cur, temp;
> > @@ -156,7 +156,7 @@ void hashtab_destroy(hashtab_t h)
> >         free(h);
> >  }
> >
> > -void hashtab_destroy_key(hashtab_t h,
> > +void selinux_hashtab_destroy_key(hashtab_t h,
> >                 int (*destroy_key) (hashtab_key_t k))
> >  {
> >         unsigned int i;
> > @@ -182,7 +182,7 @@ void hashtab_destroy_key(hashtab_t h,
> >         free(h);
> >  }
> >
> > -int hashtab_map(hashtab_t h,
> > +int selinux_hashtab_map(hashtab_t h,
> >                 int (*apply) (hashtab_key_t k,
> >                               hashtab_datum_t d, void *args), void *arg=
s)
> >  {
> > @@ -205,7 +205,7 @@ int hashtab_map(hashtab_t h,
> >         return HASHTAB_SUCCESS;
> >  }
> >
> > -void hashtab_hash_eval(hashtab_t h, char *tag)
> > +void selinux_hashtab_hash_eval(hashtab_t h, char *tag)
> >  {
> >         unsigned int i;
> >         int chain_len, slots_used, max_chain_len;
> > diff --git a/libselinux/src/hashtab.h b/libselinux/src/hashtab.h
> > index f10fc0af..6fbf5fb4 100644
> > --- a/libselinux/src/hashtab.h
> > +++ b/libselinux/src/hashtab.h
> > @@ -52,7 +52,7 @@ typedef hashtab_val_t *hashtab_t;
> >     Returns NULL if insufficient space is available or
> >     the new hash table otherwise.
> >   */
> > -extern hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t =
h,
> > +extern hashtab_t selinux_hashtab_create(unsigned int (*hash_value) (ha=
shtab_t h,
> >                                                             const_hasht=
ab_key_t
> >                                                             key),
> >                                 int (*keycmp) (hashtab_t h,
> > @@ -66,7 +66,7 @@ extern hashtab_t hashtab_create(unsigned int (*hash_v=
alue) (hashtab_t h,
> >     HASHTAB_PRESENT  if there is already an entry with the same key or
> >     HASHTAB_SUCCESS otherwise.
> >   */
> > -extern int hashtab_insert(hashtab_t h, hashtab_key_t k, hashtab_datum_=
t d);
> > +extern int selinux_hashtab_insert(hashtab_t h, hashtab_key_t k, hashta=
b_datum_t d);
> >
> >  /*
> >     Removes the entry with the specified key from the hash table.
> > @@ -76,7 +76,7 @@ extern int hashtab_insert(hashtab_t h, hashtab_key_t =
k, hashtab_datum_t d);
> >     Returns HASHTAB_MISSING if no entry has the specified key or
> >     HASHTAB_SUCCESS otherwise.
> >   */
> > -extern int hashtab_remove(hashtab_t h, hashtab_key_t k,
> > +extern int selinux_hashtab_remove(hashtab_t h, hashtab_key_t k,
> >                           void (*destroy) (hashtab_key_t k,
> >                                            hashtab_datum_t d,
> >                                            void *args), void *args);
> > @@ -87,13 +87,13 @@ extern int hashtab_remove(hashtab_t h, hashtab_key_=
t k,
> >     Returns NULL if no entry has the specified key or
> >     the datum of the entry otherwise.
> >   */
> > -extern hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t=
 k);
> > +extern hashtab_datum_t selinux_hashtab_search(hashtab_t h, const_hasht=
ab_key_t k);
> >
> >  /*
> >     Destroys the specified hash table.
> >   */
> > -extern void hashtab_destroy(hashtab_t h);
> > -extern void hashtab_destroy_key(hashtab_t h,
> > +extern void selinux_hashtab_destroy(hashtab_t h);
> > +extern void selinux_hashtab_destroy_key(hashtab_t h,
> >                         int (*destroy_key) (hashtab_key_t k));
> >
> >  /*
> > @@ -107,11 +107,11 @@ extern void hashtab_destroy_key(hashtab_t h,
> >     iterating through the hash table and will propagate the error
> >     return to its caller.
> >   */
> > -extern int hashtab_map(hashtab_t h,
> > +extern int selinux_hashtab_map(hashtab_t h,
> >                        int (*apply) (hashtab_key_t k,
> >                                      hashtab_datum_t d,
> >                                      void *args), void *args);
> >
> > -extern void hashtab_hash_eval(hashtab_t h, char *tag);
> > +extern void selinux_hashtab_hash_eval(hashtab_t h, char *tag);
> >
> >  #endif
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index 59c9f2ef..2fad0c93 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -111,7 +111,7 @@ static int nodups_specs(struct saved_data *data, co=
nst char *path)
> >         struct chkdups_key *new =3D NULL;
> >         unsigned int hashtab_len =3D (data->nspec / SHRINK_MULTIS) ? da=
ta->nspec / SHRINK_MULTIS : 1;
> >
> > -       hashtab_t hash_table =3D hashtab_create(symhash, symcmp, hashta=
b_len);
> > +       hashtab_t hash_table =3D selinux_hashtab_create(symhash, symcmp=
, hashtab_len);
> >         if (!hash_table) {
> >                 rc =3D -1;
> >                 COMPAT_LOG(SELINUX_ERROR, "%s: hashtab create failed.\n=
", path);
> > @@ -121,18 +121,18 @@ static int nodups_specs(struct saved_data *data, =
const char *path)
> >                 new =3D (struct chkdups_key *)malloc(sizeof(struct chkd=
ups_key));
> >                 if (!new) {
> >                         rc =3D -1;
> > -                       hashtab_destroy_key(hash_table, destroy_chkdups=
_key);
> > +                       selinux_hashtab_destroy_key(hash_table, destroy=
_chkdups_key);
> >                         COMPAT_LOG(SELINUX_ERROR, "%s: hashtab key crea=
te failed.\n", path);
> >                         return rc;
> >                 }
> >                 new->regex =3D spec_arr[ii].regex_str;
> >                 new->mode =3D spec_arr[ii].mode;
> > -               ret =3D hashtab_insert(hash_table, (hashtab_key_t)new, =
&spec_arr[ii]);
> > +               ret =3D selinux_hashtab_insert(hash_table, (hashtab_key=
_t)new, &spec_arr[ii]);
> >                 if (ret =3D=3D HASHTAB_SUCCESS)
> >                         continue;
> >                 if (ret =3D=3D HASHTAB_PRESENT) {
> >                         curr_spec =3D
> > -                               (struct spec *)hashtab_search(hash_tabl=
e, (hashtab_key_t)new);
> > +                               (struct spec *)selinux_hashtab_search(h=
ash_table, (hashtab_key_t)new);
> >                         rc =3D -1;
> >                         errno =3D EINVAL;
> >                         free(new);
> > @@ -161,7 +161,7 @@ static int nodups_specs(struct saved_data *data, co=
nst char *path)
> >                 }
> >         }
> >
> > -       hashtab_destroy_key(hash_table, destroy_chkdups_key);
> > +       selinux_hashtab_destroy_key(hash_table, destroy_chkdups_key);
> >
> >         return rc;
> >  }
> > --
> > 2.46.0.295.g3b9ea8a38a-goog
> >

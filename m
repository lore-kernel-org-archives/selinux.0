Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BDB7346C
	for <selinux@vger.kernel.org>; Fri, 30 Aug 2024 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725030747; cv=none; b=ba3wLiDyyuEN7bUI+nzruE9AdkXTh5vw5s5/gHP+6jbBgdWbcFo+EEAaT52MsCGuQYPZmto4b98/G2HY72nAJLO9Zhp6AOZEuPtjiESAiuSzuTGn+Ino+poWN4ILYY6H9gQ8unBoRe9pMUL0YGcxP5vTgEHdcggArXlN2pQwQqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725030747; c=relaxed/simple;
	bh=oMrdde0gNIAdu3N8nZexvf7RH6rlAklGABkj2lBRRwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPEkDyS5vGtuANA+moS2NzrbzmZvncgaCOleMu2m3YQQuY5kqr6ZYEey0OimY3B59WRXFAloFASwYrDlQCdd9LM/6bg9KqquMy+Ltdr8axN0nmwZS++bX8i3TAk9Wru+bb9bMdpy5Scm/rSoxF3wZHSxlY52ybc6xQQSim7Oa/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZp9MfJJ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZp9MfJJ"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a816a9007cso47787685a.0
        for <selinux@vger.kernel.org>; Fri, 30 Aug 2024 08:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725030743; x=1725635543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SH6iK6cP++XszBL75js6ta4hgQMf1VqeLdm9qXun96c=;
        b=FZp9MfJJ0gZgZr1WOxP+sSn7tRCdjXhap4f9ISfNIte1Yk/xIgY7sXe887SI/2rUcK
         wqB737q2uvJ9VS+R61z4gIyd4PXPsHR7MWF4/nF7sN5IdGCa64vJKQsUqx119d1PKYBA
         bQa99GUMEnXeGsY/zj5vrSFtlPmrWmFRf59dJ7mxo8V43+YLxKp4ILrULa4bDoZeXkpO
         UiohKULosQEB9XyycBTPtQBWXQ0dplv+ONMPenZOgB5gfYHnVkdyh2J+knyhGKW1PkX6
         YHghso6trxHx/UqI69h79l/p8OCnPFDAs+vn4C2Afbj8jAEP2cjnmTQTGfqJtu9h+f5l
         xENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725030743; x=1725635543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SH6iK6cP++XszBL75js6ta4hgQMf1VqeLdm9qXun96c=;
        b=VuHfjnBqoDn8PvxAlEnK3zFfYn/6ubDkhoNDpMwlK+gez7NOrslcAFPxJnALTyhuyw
         ZrRch3E9LD+fXW4S4MYC2B5SJcvZ7rh/15sn15YH+iUls5CxUvPQv/DlALGyk3hSPKKi
         biawAknoOXhYWgATflUsUs87gYeb15KzsmZTGwpx5IZ7pMx9jPlFSaYMpvP4QYrfUD47
         ctEmZ+VZ1r/t5h/vRf53g3UnHtay+rGmp02NnQ3OmxuPIyWukbdgNLEtMS4/K/V0eMwa
         3ugEsw1X2v0thN0bUfUrc9aBzOjDDbyYff1nnZlPv9PWzgLwept2O5ihHM/L6t8NRwGy
         Nxng==
X-Forwarded-Encrypted: i=1; AJvYcCWysnW1y2Pwxk+mw7WvaDoaoqZH9m1XoLqD654tQT6GJWlebMWwoI3/r/QJxCzLc8jd4h32lRp7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw88QhCqjrv2IxgRHQ40wfwOSJr+A0f0HFvARBGjTB1j8vn3J2a
	1QfMcN8CAgPJ8qVTiTJK6JinMxalu+X/WlyaBhXfAOXohilbZkR4SU2co8e773DLdWEwhDX1Y8r
	3DWhsb8ci7nLeMaDu4IhDt/v6SLfUaBC+
X-Google-Smtp-Source: AGHT+IFJSrofoZ9KozvOD2i00+8F5O+69nN0IF3z3wb4SYNWrUaXRnSakU9YdlJf0WfReTa/7QRtT2G4B3Mza5OidcI=
X-Received: by 2002:a05:620a:3715:b0:7a6:75e6:3c21 with SMTP id
 af79cd13be357-7a804b8cdbamr841976185a.1.1725030742937; Fri, 30 Aug 2024
 08:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826041044.1753994-1-tweek@google.com>
In-Reply-To: <20240826041044.1753994-1-tweek@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 30 Aug 2024 11:12:11 -0400
Message-ID: <CAP+JOzQcuXtc-nQD3XLgki1=5p9-fm0-egPAh+uFXKJQSg3Syg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: rename hashtab functions
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: paul@paul-moore.com, jeffv@google.com, selinux@vger.kernel.org, 
	wanghuizhao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 12:11=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
>
> In commit d95bc8b75539 ("libselinux: migrating hashtab from
> policycoreutils") and commit 4a420508a98c ("libselinux: adapting hashtab
> to libselinux"), the hashtab implementation was copied to libselinux.
> Since the same functions exist in libsepol (e.g., hashtab_create,
> hashtab_destroy, etc), a compilation error is raised when both libraries
> are included statically.
>
> Prefix the libselinux internal implementation with "selinux_".
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/hashtab.c    | 16 ++++++++--------
>  libselinux/src/hashtab.h    | 16 ++++++++--------
>  libselinux/src/label_file.c | 10 +++++-----
>  3 files changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/libselinux/src/hashtab.c b/libselinux/src/hashtab.c
> index 7452613b..0c6641ed 100644
> --- a/libselinux/src/hashtab.c
> +++ b/libselinux/src/hashtab.c
> @@ -11,7 +11,7 @@
>  #include <string.h>
>  #include "hashtab.h"
>
> -hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
> +hashtab_t selinux_hashtab_create(unsigned int (*hash_value) (hashtab_t h=
,
>                                                      const_hashtab_key_t =
key),
>                          int (*keycmp) (hashtab_t h,
>                                         const_hashtab_key_t key1,
> @@ -42,7 +42,7 @@ hashtab_t hashtab_create(unsigned int (*hash_value) (ha=
shtab_t h,
>         return p;
>  }
>
> -int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum=
)
> +int selinux_hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum=
_t datum)
>  {
>         unsigned int hvalue;
>         hashtab_ptr_t prev, cur, newnode;
> @@ -79,7 +79,7 @@ int hashtab_insert(hashtab_t h, hashtab_key_t key, hash=
tab_datum_t datum)
>         return HASHTAB_SUCCESS;
>  }
>
> -int hashtab_remove(hashtab_t h, hashtab_key_t key,
> +int selinux_hashtab_remove(hashtab_t h, hashtab_key_t key,
>                    void (*destroy) (hashtab_key_t k,
>                                     hashtab_datum_t d, void *args), void =
*args)
>  {
> @@ -112,7 +112,7 @@ int hashtab_remove(hashtab_t h, hashtab_key_t key,
>         return HASHTAB_SUCCESS;
>  }
>
> -hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t key)
> +hashtab_datum_t selinux_hashtab_search(hashtab_t h, const_hashtab_key_t =
key)
>  {
>
>         unsigned int hvalue;
> @@ -132,7 +132,7 @@ hashtab_datum_t hashtab_search(hashtab_t h, const_has=
htab_key_t key)
>         return cur->datum;
>  }
>
> -void hashtab_destroy(hashtab_t h)
> +void selinux_hashtab_destroy(hashtab_t h)
>  {
>         unsigned int i;
>         hashtab_ptr_t cur, temp;
> @@ -156,7 +156,7 @@ void hashtab_destroy(hashtab_t h)
>         free(h);
>  }
>
> -void hashtab_destroy_key(hashtab_t h,
> +void selinux_hashtab_destroy_key(hashtab_t h,
>                 int (*destroy_key) (hashtab_key_t k))
>  {
>         unsigned int i;
> @@ -182,7 +182,7 @@ void hashtab_destroy_key(hashtab_t h,
>         free(h);
>  }
>
> -int hashtab_map(hashtab_t h,
> +int selinux_hashtab_map(hashtab_t h,
>                 int (*apply) (hashtab_key_t k,
>                               hashtab_datum_t d, void *args), void *args)
>  {
> @@ -205,7 +205,7 @@ int hashtab_map(hashtab_t h,
>         return HASHTAB_SUCCESS;
>  }
>
> -void hashtab_hash_eval(hashtab_t h, char *tag)
> +void selinux_hashtab_hash_eval(hashtab_t h, char *tag)
>  {
>         unsigned int i;
>         int chain_len, slots_used, max_chain_len;
> diff --git a/libselinux/src/hashtab.h b/libselinux/src/hashtab.h
> index f10fc0af..6fbf5fb4 100644
> --- a/libselinux/src/hashtab.h
> +++ b/libselinux/src/hashtab.h
> @@ -52,7 +52,7 @@ typedef hashtab_val_t *hashtab_t;
>     Returns NULL if insufficient space is available or
>     the new hash table otherwise.
>   */
> -extern hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
> +extern hashtab_t selinux_hashtab_create(unsigned int (*hash_value) (hash=
tab_t h,
>                                                             const_hashtab=
_key_t
>                                                             key),
>                                 int (*keycmp) (hashtab_t h,
> @@ -66,7 +66,7 @@ extern hashtab_t hashtab_create(unsigned int (*hash_val=
ue) (hashtab_t h,
>     HASHTAB_PRESENT  if there is already an entry with the same key or
>     HASHTAB_SUCCESS otherwise.
>   */
> -extern int hashtab_insert(hashtab_t h, hashtab_key_t k, hashtab_datum_t =
d);
> +extern int selinux_hashtab_insert(hashtab_t h, hashtab_key_t k, hashtab_=
datum_t d);
>
>  /*
>     Removes the entry with the specified key from the hash table.
> @@ -76,7 +76,7 @@ extern int hashtab_insert(hashtab_t h, hashtab_key_t k,=
 hashtab_datum_t d);
>     Returns HASHTAB_MISSING if no entry has the specified key or
>     HASHTAB_SUCCESS otherwise.
>   */
> -extern int hashtab_remove(hashtab_t h, hashtab_key_t k,
> +extern int selinux_hashtab_remove(hashtab_t h, hashtab_key_t k,
>                           void (*destroy) (hashtab_key_t k,
>                                            hashtab_datum_t d,
>                                            void *args), void *args);
> @@ -87,13 +87,13 @@ extern int hashtab_remove(hashtab_t h, hashtab_key_t =
k,
>     Returns NULL if no entry has the specified key or
>     the datum of the entry otherwise.
>   */
> -extern hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t k=
);
> +extern hashtab_datum_t selinux_hashtab_search(hashtab_t h, const_hashtab=
_key_t k);
>
>  /*
>     Destroys the specified hash table.
>   */
> -extern void hashtab_destroy(hashtab_t h);
> -extern void hashtab_destroy_key(hashtab_t h,
> +extern void selinux_hashtab_destroy(hashtab_t h);
> +extern void selinux_hashtab_destroy_key(hashtab_t h,
>                         int (*destroy_key) (hashtab_key_t k));
>
>  /*
> @@ -107,11 +107,11 @@ extern void hashtab_destroy_key(hashtab_t h,
>     iterating through the hash table and will propagate the error
>     return to its caller.
>   */
> -extern int hashtab_map(hashtab_t h,
> +extern int selinux_hashtab_map(hashtab_t h,
>                        int (*apply) (hashtab_key_t k,
>                                      hashtab_datum_t d,
>                                      void *args), void *args);
>
> -extern void hashtab_hash_eval(hashtab_t h, char *tag);
> +extern void selinux_hashtab_hash_eval(hashtab_t h, char *tag);
>
>  #endif
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 59c9f2ef..2fad0c93 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -111,7 +111,7 @@ static int nodups_specs(struct saved_data *data, cons=
t char *path)
>         struct chkdups_key *new =3D NULL;
>         unsigned int hashtab_len =3D (data->nspec / SHRINK_MULTIS) ? data=
->nspec / SHRINK_MULTIS : 1;
>
> -       hashtab_t hash_table =3D hashtab_create(symhash, symcmp, hashtab_=
len);
> +       hashtab_t hash_table =3D selinux_hashtab_create(symhash, symcmp, =
hashtab_len);
>         if (!hash_table) {
>                 rc =3D -1;
>                 COMPAT_LOG(SELINUX_ERROR, "%s: hashtab create failed.\n",=
 path);
> @@ -121,18 +121,18 @@ static int nodups_specs(struct saved_data *data, co=
nst char *path)
>                 new =3D (struct chkdups_key *)malloc(sizeof(struct chkdup=
s_key));
>                 if (!new) {
>                         rc =3D -1;
> -                       hashtab_destroy_key(hash_table, destroy_chkdups_k=
ey);
> +                       selinux_hashtab_destroy_key(hash_table, destroy_c=
hkdups_key);
>                         COMPAT_LOG(SELINUX_ERROR, "%s: hashtab key create=
 failed.\n", path);
>                         return rc;
>                 }
>                 new->regex =3D spec_arr[ii].regex_str;
>                 new->mode =3D spec_arr[ii].mode;
> -               ret =3D hashtab_insert(hash_table, (hashtab_key_t)new, &s=
pec_arr[ii]);
> +               ret =3D selinux_hashtab_insert(hash_table, (hashtab_key_t=
)new, &spec_arr[ii]);
>                 if (ret =3D=3D HASHTAB_SUCCESS)
>                         continue;
>                 if (ret =3D=3D HASHTAB_PRESENT) {
>                         curr_spec =3D
> -                               (struct spec *)hashtab_search(hash_table,=
 (hashtab_key_t)new);
> +                               (struct spec *)selinux_hashtab_search(has=
h_table, (hashtab_key_t)new);
>                         rc =3D -1;
>                         errno =3D EINVAL;
>                         free(new);
> @@ -161,7 +161,7 @@ static int nodups_specs(struct saved_data *data, cons=
t char *path)
>                 }
>         }
>
> -       hashtab_destroy_key(hash_table, destroy_chkdups_key);
> +       selinux_hashtab_destroy_key(hash_table, destroy_chkdups_key);
>
>         return rc;
>  }
> --
> 2.46.0.295.g3b9ea8a38a-goog
>

Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852A61D9A6D
	for <selinux@vger.kernel.org>; Mon,  2 Dec 2024 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733170719; cv=none; b=REeKamgI9wx0XLJQ5T60DFzpeyyrGclz9bgWCjsM47JiViVGhq+Svn5BZYcQjFD0hh2nrp25rGysCmQRi0PhkTs0uVtPQ0CuMJR8fTH3sBD3344ARDEOh7dRtbcRCPR8ctnCcHpQiFZs9W77anoze/y2kzGwJko8+SXv5RuseWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733170719; c=relaxed/simple;
	bh=INikbO4xpmTk3mm9pq1EqCDGsZLhC6Sxbk4ML/4rcF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uh8JrQLLImQ31k4rIqOiu16hyNoynQo2jn1FfAMCvmRNpxk2fwBqa5GKTdhWFJTDp7FP0CyRv07Jw9jTNEZhcG3tLKZ72UC22qnHc6TSFZykGk/1NC2rckMzY0CydeBqaBodA02Z+6AFArfkvGMqBlHFeEyju5CrjFOmiHTJjbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhpUflYr; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhpUflYr"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3e916196023so2612711b6e.3
        for <selinux@vger.kernel.org>; Mon, 02 Dec 2024 12:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733170716; x=1733775516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwPcPGtSLI0Hz913oc1Yd8WBoOxKtO6pYsMJ4r06C88=;
        b=NhpUflYrFEyyRj3ffAC5abyZafqbduCCZIbrDwvaze2kX5QwBSKlKS73XrZt+F37vx
         hmhIXDI/+vSOnDkBs8a3xfzBVHCQnENQG4AVffzJZx04Lf6pppKQPL4RpWrEDciOsh54
         IpiAM3Zqh6Ncb35HKC/hxye2Q+zQ+Fr2xmLYLnm4eaVjWZRdCZOPJ0dmV4FWz7Uoxwfn
         E69c85Ce9RPEY+Cf3MnsGBFuD3Z6swQXFLBbpBB9lLKnriz6WXpNvxUNqb9rfOTzRQ8e
         riT9bAgGyDvhLU+Ln4BOIwgvUYutECg6HvPblWSEFFUdVF7m6iDu9taRUO7xvvSoMVHe
         afwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733170716; x=1733775516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwPcPGtSLI0Hz913oc1Yd8WBoOxKtO6pYsMJ4r06C88=;
        b=Et/vK/RM0bf9U6tq2YlVgyi5RBFcudiETb7rq3OIg8XNLO3Kd2f27SXFy5NcHAh4Lv
         pSdDWcOBYNOvWo+pWKrfJWs0+RAN7EZQJDdJhY0ssEdbpq8mniDmB+dWHbbmGfr686by
         AQ9+VA+EF6254g8MG6fpdJuMfAeZV1n2V988Vo2yPgJiHIf4kK/HrYkBOvo72YEz3xvF
         QT2Qvf3T/osNHqvNXNA82K/WkxXCVhLGfgSvkMdFZhwIKSLxaiwgybczIqGvptQpMP9M
         wQmPUwZKIlmXdsgSSVnVZWG7mERB48ZXZmHBEnLE31T1dKDPPcd5eTcqWtFR2vbp6fJc
         Xv/Q==
X-Gm-Message-State: AOJu0YzYFjpxkR75RGpT2FicWXz5WXsa6bbHJcb9mZZWQ3wc9AcxUjd4
	RiI50+p8LoNIVEVIEawpfizHMowc3/mEYlWkraq1lCvUit/EnABQbljymZOw21OoSvRYF6zHiAk
	Dq22AWsZKmbyDiFN72PSEfvrd2T0=
X-Gm-Gg: ASbGncsug9EZC7ccY0xuXDEsGl7dEAPaGQ32ag73PiaW8se322JW46Q1bLs/URF5gEH
	95KGybNNzwbbXh0TMhw7I5N0zJApkC4M=
X-Google-Smtp-Source: AGHT+IHghkT4nRU0Xa47TDNvSY+CjX5l0Qnrv2V6KJkCkRNCJMzk63lqFwI7R+FHNnafSpnydeJcFQHeM42+VfNn6fk=
X-Received: by 2002:a05:6359:4ca8:b0:1c3:94:8ffa with SMTP id
 e5c5f4694b2df-1cab169cdcbmr863593255d.22.1733170716416; Mon, 02 Dec 2024
 12:18:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126102621.20253-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241126102621.20253-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 2 Dec 2024 15:18:25 -0500
Message-ID: <CAP+JOzSe-wfPdCXv4OKQ7eaXeH+qP7zDK=LiWp9HAjDW1uNG1Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] libselinux: avoid memory allocation in common file
 label lookup
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 5:45=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Remove a memory allocation during a common file label lookup,
> e.g. requested by restorecon(8)/setfiles(8), by using a local stack
> buffer for a potential lookup result.
>
> Additional minor optimization tweaks.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these three patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2: drop claim about this being the sole memory allocation, since
>     applying a substitution path allocates as well
> ---
>  libselinux/src/label_file.c       | 103 +++++++++++++++++-------------
>  libselinux/src/selinux_internal.h |   8 +++
>  2 files changed, 68 insertions(+), 43 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 189a5ed2..4e212aa4 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -1467,12 +1467,30 @@ FUZZ_EXTERN void free_lookup_result(struct lookup=
_result *result)
>         }
>  }
>
> -static struct lookup_result *lookup_check_node(struct spec_node *node, c=
onst char *key, uint8_t file_kind, bool partial, bool find_all)
> +/**
> + * lookup_check_node() - Try to find a file context definition in the gi=
ven node or parents.
> + * @node:      The deepest specification node to match against. Parent n=
odes are successively
> + *             searched on no match or when finding all matches.
> + * @key:       The absolute file path to look up.
> + * @file_kind: The kind of the file to look up (translated from file typ=
e into LABEL_FILE_KIND_*).
> + * @partial:   Whether to partially match the given file path or complet=
ely.
> + * @find_all:  Whether to find all file context definitions or just the =
most specific.
> + * @buf:       A pre-allocated buffer for a potential result to avoid al=
locating it on the heap or
> + *             NULL. Mututal exclusive with @find_all.
> + *
> + * Return: A pointer to a file context definition if a match was found. =
If @find_all was specified
> + *         its a linked list of all results. If @buf was specified it is=
 returned on a match found.
> + *         NULL is returned in case of no match found.
> + */
> +static struct lookup_result *lookup_check_node(struct spec_node *node, c=
onst char *key, uint8_t file_kind,
> +                                              bool partial, bool find_al=
l, struct lookup_result *buf)
>  {
>         struct lookup_result *result =3D NULL;
>         struct lookup_result **next =3D &result;
>         size_t key_len =3D strlen(key);
>
> +       assert(!(find_all && buf !=3D NULL));
> +
>         for (struct spec_node *n =3D node; n; n =3D n->parent) {
>
>                 uint32_t literal_idx =3D search_literal_spec(n->literal_s=
pecs, n->literal_specs_num, key, key_len, partial);
> @@ -1495,10 +1513,14 @@ static struct lookup_result *lookup_check_node(st=
ruct spec_node *node, const cha
>                                                 return NULL;
>                                         }
>
> -                                       r =3D malloc(sizeof(*r));
> -                                       if (!r) {
> -                                               free_lookup_result(result=
);
> -                                               return NULL;
> +                                       if (likely(buf)) {
> +                                               r =3D buf;
> +                                       } else {
> +                                               r =3D malloc(sizeof(*r));
> +                                               if (!r) {
> +                                                       free_lookup_resul=
t(result);
> +                                                       return NULL;
> +                                               }
>                                         }
>
>                                         *r =3D (struct lookup_result) {
> @@ -1510,11 +1532,11 @@ static struct lookup_result *lookup_check_node(st=
ruct spec_node *node, const cha
>                                                 .next =3D NULL,
>                                         };
>
> +                                       if (likely(!find_all))
> +                                               return r;
> +
>                                         *next =3D r;
>                                         next =3D &r->next;
> -
> -                                       if (!find_all)
> -                                               return result;
>                                 }
>
>                                 literal_idx++;
> @@ -1556,10 +1578,14 @@ static struct lookup_result *lookup_check_node(st=
ruct spec_node *node, const cha
>                                         return NULL;
>                                 }
>
> -                               r =3D malloc(sizeof(*r));
> -                               if (!r) {
> -                                       free_lookup_result(result);
> -                                       return NULL;
> +                               if (likely(buf)) {
> +                                       r =3D buf;
> +                               } else {
> +                                       r =3D malloc(sizeof(*r));
> +                                       if (!r) {
> +                                               free_lookup_result(result=
);
> +                                               return NULL;
> +                                       }
>                                 }
>
>                                 *r =3D (struct lookup_result) {
> @@ -1571,12 +1597,12 @@ static struct lookup_result *lookup_check_node(st=
ruct spec_node *node, const cha
>                                         .next =3D NULL,
>                                 };
>
> +                               if (likely(!find_all))
> +                                       return r;
> +
>                                 *next =3D r;
>                                 next =3D &r->next;
>
> -                               if (!find_all)
> -                                       return result;
> -
>                                 continue;
>                         }
>
> @@ -1692,7 +1718,8 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct=
 selabel_handle *rec,
>                                  const char *key,
>                                  int type,
>                                  bool partial,
> -                                bool find_all)
> +                                bool find_all,
> +                                struct lookup_result *buf)
>  {
>         struct saved_data *data =3D (struct saved_data *)rec->data;
>         struct lookup_result *result =3D NULL;
> @@ -1704,18 +1731,18 @@ FUZZ_EXTERN struct lookup_result *lookup_all(stru=
ct selabel_handle *rec,
>         unsigned int sofar =3D 0;
>         char *sub =3D NULL;
>
> -       if (!key) {
> +       if (unlikely(!key)) {
>                 errno =3D EINVAL;
>                 goto finish;
>         }
>
> -       if (!data->num_specs) {
> +       if (unlikely(!data->num_specs)) {
>                 errno =3D ENOENT;
>                 goto finish;
>         }
>
>         /* Remove duplicate slashes */
> -       if ((next_slash =3D strstr(key, "//"))) {
> +       if (unlikely(next_slash =3D strstr(key, "//"))) {
>                 clean_key =3D (char *) malloc(strlen(key) + 1);
>                 if (!clean_key)
>                         goto finish;
> @@ -1732,12 +1759,12 @@ FUZZ_EXTERN struct lookup_result *lookup_all(stru=
ct selabel_handle *rec,
>
>         /* remove trailing slash */
>         len =3D strlen(key);
> -       if (len =3D=3D 0) {
> +       if (unlikely(len =3D=3D 0)) {
>                 errno =3D EINVAL;
>                 goto finish;
>         }
>
> -       if (len > 1 && key[len - 1] =3D=3D '/') {
> +       if (unlikely(len > 1 && key[len - 1] =3D=3D '/')) {
>                 /* reuse clean_key from above if available */
>                 if (!clean_key) {
>                         clean_key =3D (char *) malloc(len);
> @@ -1757,7 +1784,7 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct=
 selabel_handle *rec,
>
>         node =3D lookup_find_deepest_node(data->root, key);
>
> -       result =3D lookup_check_node(node, key, file_kind, partial, find_=
all);
> +       result =3D lookup_check_node(node, key, file_kind, partial, find_=
all, buf);
>
>  finish:
>         free(clean_key);
> @@ -1768,14 +1795,9 @@ finish:
>  static struct lookup_result *lookup_common(struct selabel_handle *rec,
>                                            const char *key,
>                                            int type,
> -                                          bool partial) {
> -       struct lookup_result *result =3D lookup_all(rec, key, type, parti=
al, false);
> -       if (!result)
> -               return NULL;
> -
> -       free_lookup_result(result->next);
> -       result->next =3D NULL;
> -       return result;
> +                                          bool partial,
> +                                          struct lookup_result *buf) {
> +       return lookup_all(rec, key, type, partial, false, buf);
>  }
>
>  /*
> @@ -1835,7 +1857,7 @@ static bool hash_all_partial_matches(struct selabel=
_handle *rec, const char *key
>  {
>         assert(digest);
>
> -       struct lookup_result *matches =3D lookup_all(rec, key, 0, true, t=
rue);
> +       struct lookup_result *matches =3D lookup_all(rec, key, 0, true, t=
rue, NULL);
>         if (!matches) {
>                 return false;
>         }
> @@ -1864,25 +1886,20 @@ static bool hash_all_partial_matches(struct selab=
el_handle *rec, const char *key
>  static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
>                                          const char *key, int type)
>  {
> -       struct lookup_result *result;
> -       struct selabel_lookup_rec *lookup_result;
> +       struct lookup_result buf, *result;
>
> -       result =3D lookup_common(rec, key, type, false);
> +       result =3D lookup_common(rec, key, type, false, &buf);
>         if (!result)
>                 return NULL;
>
> -       lookup_result =3D result->lr;
> -       free_lookup_result(result);
> -       return lookup_result;
> +       return result->lr;
>  }
>
>  static bool partial_match(struct selabel_handle *rec, const char *key)
>  {
> -       struct lookup_result *result =3D lookup_common(rec, key, 0, true)=
;
> -       bool ret =3D result;
> +       struct lookup_result buf;
>
> -       free_lookup_result(result);
> -       return ret;
> +       return !!lookup_common(rec, key, 0, true, &buf);
>  }
>
>  static struct selabel_lookup_rec *lookup_best_match(struct selabel_handl=
e *rec,
> @@ -1904,7 +1921,7 @@ static struct selabel_lookup_rec *lookup_best_match=
(struct selabel_handle *rec,
>         results =3D calloc(n+1, sizeof(*results));
>         if (!results)
>                 return NULL;
> -       results[0] =3D lookup_common(rec, key, type, false);
> +       results[0] =3D lookup_common(rec, key, type, false, NULL);
>         if (results[0]) {
>                 if (!results[0]->has_meta_chars) {
>                         /* exact match on key */
> @@ -1915,7 +1932,7 @@ static struct selabel_lookup_rec *lookup_best_match=
(struct selabel_handle *rec,
>                 prefix_len =3D results[0]->prefix_len;
>         }
>         for (i =3D 1; i <=3D n; i++) {
> -               results[i] =3D lookup_common(rec, aliases[i-1], type, fal=
se);
> +               results[i] =3D lookup_common(rec, aliases[i-1], type, fal=
se, NULL);
>                 if (results[i]) {
>                         if (!results[i]->has_meta_chars) {
>                                 /* exact match on alias */
> diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_i=
nternal.h
> index 372837dd..964b8418 100644
> --- a/libselinux/src/selinux_internal.h
> +++ b/libselinux/src/selinux_internal.h
> @@ -142,4 +142,12 @@ static inline void fclose_errno_safe(FILE *stream)
>         errno =3D saved_errno;
>  }
>
> +#ifdef __GNUC__
> +# define likely(x)                     __builtin_expect(!!(x), 1)
> +# define unlikely(x)                   __builtin_expect(!!(x), 0)
> +#else
> +# define likely(x)                     (x)
> +# define unlikely(x)                   (x)
> +#endif /* __GNUC__ */
> +
>  #endif /* SELINUX_INTERNAL_H_ */
> --
> 2.45.2
>
>

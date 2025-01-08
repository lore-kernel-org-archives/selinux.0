Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2501A01C6
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736373071; cv=none; b=aOad77AM9RdG1aLQo0KpV5J8+xvQHddI5KYeCKdSTorRFXlQb3q9I2fpT6bJVsV8gUuqeyQClO8+4uwIo71qaqUG5RLw7tWiwtj4hKS78zcEnFzXd7c9xXo3+vhfLpoBrbISYl0FA9Tbisu+xV26xrIt/n+ZML7g6eJZF6Mtb6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736373071; c=relaxed/simple;
	bh=yndmgXAorJEjcyera5sWNqjn9jlblSWp9De13zUI5Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1F/7CuphQDs4GU8aAHEHRhoAE6DsmBQLa8kQfvaaoigD6Xu49yvXueIj19oDDKmGcliReW07BFGHEEn7g8sK3gMwre6EoxI4l+Tte5qVJVVtajqIlHC8Gk5Q+Wd9UyJOX3NDkyNK8gJhD7IqSQG9RhbDiWVzLplRRc7gGaIf4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTr4TU5W; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTr4TU5W"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-51bb020339fso99980e0c.0
        for <selinux@vger.kernel.org>; Wed, 08 Jan 2025 13:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736373069; x=1736977869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9traGDPUM/1pLB9rDHSSsjOnNI9d8uOCrJXmLmQ+Fs=;
        b=UTr4TU5WbY8aJiU+0AxB7Tg3oL+Faq4sd7kKVRqbU9pqIu8lrUMMhmO/7Gz4Tj3pQV
         qhzuAaPUeK/qX5vJZAuwTjIKJUm6GOlC5i9rdyP/waabxkXuZGnQMVTlLcUdG3ZlD+0b
         KRRdRPK33Xvx4AJdpcQs1Zo8yxpxmoGJCxH6i3qXQFZ+56UmBHDGCz3w6FxBj3vDommM
         8SMfaXIOz+/ciH3HeEgnjZ7YOcFlZmVqqpiSWB7MaOau8OWn94Jvgio0MeNoeC8IrodA
         ZB3RA/9bf9v8J0Y1kLLha85v2b582rBqu5YwQkK/v4aoxiMEzZTYPeMDxIk+JL746z6V
         Mi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736373069; x=1736977869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9traGDPUM/1pLB9rDHSSsjOnNI9d8uOCrJXmLmQ+Fs=;
        b=SmSrnOMHwrgpOR16wlksNOAJdgTM2sztXsImg48crN71V2OXt5Q4Xdhs8zrzn2WB4k
         HJTHFg9igJBClBuvCppBa9wsTVyIf6kXt5uW8edX3OcmPeH8msOJOUDIXfu6/pp3fGaK
         wE+gKGc7FVhWjrBPEYxZQQ5iPiOS2HUA9SxgiGP7fDVCWOcRSb7IRgvBtXRSKIx5M44h
         sKEYr3TWEIflKVaYu/6opNYxkJFEcTh5ym0UfVNF3M0G0P0qWOKXpd6U/0hvgJYP9UNL
         DHrkyXzdsGIWoUIV2xahsl6PgA2YcN9g44XUoaebGGOxa/uEEEwvl7UJ/N5+IdKomnIr
         forA==
X-Gm-Message-State: AOJu0Yx+uEw97MELiewpwP5TPsXbkPK0jW6WEmlyJ0C82klfg0pHpr4F
	ubcH7gnWjaBto1nw3T0ByxBheXiADgbR+iUbeMSqlXsKfWYwwwaBSvuGrxD+W/Jn807rwJBzQqe
	5TU413sNUCqNpf7jhTWVheq/aogSFOg6/
X-Gm-Gg: ASbGnctYvayE8Q9vP9oWsA+m8N3o1yhwqfeuYFrROy5egss6bZjy/vyYO7Ttgml5HAj
	A/qUw9sAkDfyc5MKPAKHaRAjWEfxwVUsQwtQtWQ==
X-Google-Smtp-Source: AGHT+IHbLDem8WIIM4i95x2vEXlwSy1A/NRkpq/qxEV4vo7utHaoM/4ize/m2RmIQ6qAwH49KC2wEs3+X2rrCVaqwl0=
X-Received: by 2002:a05:6122:3d03:b0:519:fcf2:ef51 with SMTP id
 71dfb90a1353d-51c6c46d008mr3826126e0c.5.1736373068751; Wed, 08 Jan 2025
 13:51:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230140323.58852-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241230140323.58852-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 8 Jan 2025 16:50:58 -0500
X-Gm-Features: AbW1kvbKnsEq8lQzmzG4fjr6t60YTXyJ3TAgtRc7oRmM9CknnqiOlkmnhysXVvc
Message-ID: <CAP+JOzTgnFxVxbUiTTh9gxL4kvX8Mg0wF5BO7npBogjvSOmLwQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: avoid quadratic complexity for many regex
 specs validation
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 9:03=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> In the degenerate case of many regular expression specifications in a
> single node switch to a n*log(n) algorithm (with allocation) instead of
> the default n^2 (without allocation) one.
>
> See 2c7b71db ("libselinux: performance optimization for duplicate detecti=
on")
> for a predecessor.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/label_file.c | 85 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 82 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 56e20949..b1884e80 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -102,6 +102,38 @@ void sort_spec_node(struct spec_node *node, struct s=
pec_node *parent)
>                 sort_spec_node(&node->children[i], node);
>  }
>
> +static inline int compare_regex_spec(const void *p1, const void *p2)
> +{
> +       const struct regex_spec *r1 =3D p1;
> +       const struct regex_spec *r2 =3D p2;
> +       size_t regex_len1, regex_len2;
> +       int ret;
> +
> +       /* Order from high prefix length to low */
> +       ret =3D (r1->prefix_len < r2->prefix_len) - (r1->prefix_len > r2-=
>prefix_len);
> +       if (ret)
> +               return ret;
> +
> +       /* Order from long total regex length to short */
> +       regex_len1 =3D strlen(r1->regex_str);
> +       regex_len2 =3D strlen(r2->regex_str);
> +       ret =3D (regex_len1 < regex_len2) - (regex_len1 > regex_len2);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Order for no-duplicates check.
> +        * Use reverse alphabetically order to retain the Fedora ordering=
 of
> +        * `/usr/(.* /)?lib(/.*)?` before `/usr/(.* /)?bin(/.*)?`.
> +        */
> +       ret =3D strcmp(r1->regex_str, r2->regex_str);
> +       if (ret)
> +               return -ret;
> +
> +       /* Order wildcard mode (0) last */
> +       return (r1->file_kind < r2->file_kind) - (r1->file_kind > r2->fil=
e_kind);
> +}
> +

This function was just deleted when the fix was applied to restore
regex spec ordering. I am a little worried about breaking that
ordering again.

I am also wondering if this is addressing an actual problem. A quick
test on my system shows a max value for node->regex_specs_num of 347
and only eight instances of it being more than 100.

Thanks,
Jim

>  /*
>   * Warn about duplicate specifications.
>   */
> @@ -143,10 +175,18 @@ static int nodups_spec_node(const struct spec_node =
*node, const char *path)
>         }
>
>         if (node->regex_specs_num > 1) {
> -               for (uint32_t i =3D 0; i < node->regex_specs_num - 1; i++=
) {
> -                       for (uint32_t j =3D i; j < node->regex_specs_num =
- 1; j++) {
> +               if (node->regex_specs_num > 512) {
> +                       uint32_t num =3D node->regex_specs_num;
> +                       struct regex_spec *copy =3D malloc(num * sizeof(s=
truct regex_spec));
> +                       if (!copy)
> +                               goto default_algo;
> +
> +                       memcpy(copy, node->regex_specs, num * sizeof(stru=
ct regex_spec));
> +                       qsort(copy, num, sizeof(struct regex_spec), compa=
re_regex_spec);
> +
> +                       for (uint32_t i =3D 0; i < node->regex_specs_num =
- 1; i++) {
>                                 const struct regex_spec *node1 =3D &node-=
>regex_specs[i];
> -                               const struct regex_spec *node2 =3D &node-=
>regex_specs[j + 1];
> +                               const struct regex_spec *node2 =3D &node-=
>regex_specs[i + 1];
>
>                                 if (node1->prefix_len !=3D node2->prefix_=
len)
>                                         continue;
> @@ -177,6 +217,45 @@ static int nodups_spec_node(const struct spec_node *=
node, const char *path)
>                                                         node1->regex_str)=
;
>                                 }
>                         }
> +
> +                       free(copy);
> +               } else {
> +                       default_algo:
> +                       for (uint32_t i =3D 0; i < node->regex_specs_num =
- 1; i++) {
> +                               for (uint32_t j =3D i; j < node->regex_sp=
ecs_num - 1; j++) {
> +                                       const struct regex_spec *node1 =
=3D &node->regex_specs[i];
> +                                       const struct regex_spec *node2 =
=3D &node->regex_specs[j + 1];
> +
> +                                       if (node1->prefix_len !=3D node2-=
>prefix_len)
> +                                               continue;
> +
> +                                       if (strcmp(node1->regex_str, node=
2->regex_str) !=3D 0)
> +                                               continue;
> +
> +                                       if (node1->file_kind !=3D LABEL_F=
ILE_KIND_ALL && node2->file_kind !=3D LABEL_FILE_KIND_ALL && node1->file_ki=
nd !=3D node2->file_kind)
> +                                               continue;
> +
> +                                       rc =3D -1;
> +                                       errno =3D EINVAL;
> +                                       if (strcmp(node1->lr.ctx_raw, nod=
e2->lr.ctx_raw) !=3D 0) {
> +                                               COMPAT_LOG
> +                                                       (SELINUX_ERROR,
> +                                                               "%s: Mult=
iple different specifications for %s %s  (%s and %s).\n",
> +                                                               path,
> +                                                               file_kind=
_to_string(node1->file_kind),
> +                                                               node1->re=
gex_str,
> +                                                               node1->lr=
.ctx_raw,
> +                                                               node2->lr=
.ctx_raw);
> +                                       } else {
> +                                               COMPAT_LOG
> +                                                       (SELINUX_ERROR,
> +                                                               "%s: Mult=
iple same specifications for %s %s.\n",
> +                                                               path,
> +                                                               file_kind=
_to_string(node1->file_kind),
> +                                                               node1->re=
gex_str);
> +                                       }
> +                               }
> +                       }
>                 }
>         }
>
> --
> 2.45.2
>
>

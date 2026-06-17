Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B376328B5E
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781726889; cv=pass; b=AJWd3mXnG5NZi7/STkN8Lt0861bINyRnFfW+ogUbkriXa+vwN+uLaJPG0qm2K5Wfnu1aUTxDGlwqHvRUoYueB5O/vGWWWMHuRlwcW+Pyy9k162qOl6CDyhjCuOMFbm0HiM4Q056CchOwiN8SOFb6faZ0bhh6ScHJ7vmqrm/3xWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781726889; c=relaxed/simple;
	bh=mhujiWiFTgS892h6mXIwQ83nfZFSnp6nVShwX0XM+ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0PpGkgBFqWEfEwMLkt/OSgF+1HTqb2H2ZrN0wxvNe26SHj1uqiTFEOd5JtQIRIJpDMmIhstFjHy1hmAd0xzg8qKXjbKh05D1mHIM3CMooWAkk8gO5HobphbnlkU7K3cZWOt+6k0fI1Xv7QpYG6bqJE5F8nr7OsimVujpG+DqcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nlj5vtVL; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nlj5vtVL"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c88973b6965so359766a12.1
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 13:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781726887; cv=none;
        d=google.com; s=arc-20240605;
        b=djs13D0/SCHeKeXabpm95zj/o4wdhflQCJ21jhLMI8paP5Utkj73swgF8zbEtb/oMt
         UNUspTBIRdmG4Z3V1n/gHoc+V1jAD47pflyfIgragXeDKiskw1kGtxDBIZvrLMqdR87e
         Bzt3tJunr5V5qAOLihNA4Y5DqtbHU+cid0NPvhrz0x7+XJi9P8up2O7SwAAgw0zH+0UX
         l4VETKwPNDMaxnbxoWFT4VUCJl4GVbetuWSycy/7v6hLpNQmu9ZrkauCURkWKbTl8oDq
         XK5vMvHkXquZqkb9TddHwzhNGGy/F3jNy6zfKSXatjmj3H0XmA/oEIEiIeK55C2ZfsJY
         dMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sKSmbSmjq812moXvKn6IBwXUZsl5eEMwrDmofbceF3c=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=KRSKzw98Q0hlA3K0GdlZFycKhE5Vd8k27gbw9WYzq7H2pFH1yZPlV9i7Ws6Oq6zDJr
         ZHZ8OdQhybm504HLeaPusEWN8I2+I1OGRNfs0B2bsxzLkpQGgMNmLw5nbiCsfELkiaGv
         ANhYoCF8XeJeUzc+w3y5ZGp0YqSCOA40lBadlqOo7mh84sar1J9i/bbocxLlYJHudUUt
         lf3X6V+C04Ug4O4s47LLNRpOp4kOur6JmrVIYHOSgPikw+eAgKJleN/mOFvtu/HTLHhe
         1BO8yJhpPg3D0989kRHUgY9xE47Em+DW479MfjkFKfTiFtC7A3AOaKUC+JTNvX1HiaR/
         gKNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781726887; x=1782331687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKSmbSmjq812moXvKn6IBwXUZsl5eEMwrDmofbceF3c=;
        b=Nlj5vtVLGKqev6W+sGIkPY3To24ZETGHBvxajIDgYkwN1/pyxMgfemK1HyaobhYrCg
         hXSjB50lbk5stmweCTpjfvTe+MPWga4Xq8Aef229RAsoxw6mfWDCMVv49LXy93v8Nw+t
         RxhglNmDmge1hsd6VqVAfLU6lzRlRW0cbe8jsyUX4CCxwgodFrPV5C4AXlVO1W09RDDr
         eRleVjfWohM4SPccmOzDnXeb+ObdbckOLBVzUnbMGhUvpG7EyUaqB6uzqdbuGa6G7Bdm
         COScxU56xYAkwTbfUDvYkM3diY8jzs5knRelBS/ijFyRQ/Gay9tnK4Ms45diS8F4ac5S
         fGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781726887; x=1782331687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sKSmbSmjq812moXvKn6IBwXUZsl5eEMwrDmofbceF3c=;
        b=h+E1OeT5UgCuzVZda9jUZrr5bM8aAQB3tz8M6VfEsMPUyL8bpS9eFOuwBnNyqa2N59
         311HXHvDRydaVDfZjKAJasON5HCOonH0gAIf+5tU4zVSMn2xbmMNc10pQDsbQdl2lUjE
         pCJnSzDW4r65O8xKgOyw+aFE9Ahofa+SaByQ9zQlLxO5BCM4+axhF0uAaK8XN0x6eXlj
         H7SfWcmcM5mGztTDRXcB4JXZcMce4G7zkktqY50pxF9opMnItWAglv5/qoaPNM8vX4ow
         XiSaQOYXU1cNdTwEbnMMMlQSva1bVuDBJB9chRUmUwsysYTjiKQyWHSIgEtvpsHyHGZb
         83iA==
X-Gm-Message-State: AOJu0Yzuln1/VmNEETNl31L8JtIc2CJDNe84x/zY/gDos1TFHB+iY+Vh
	K5s72z46Hc7AKKs4BZ3c9Kuq0V0Oj2OqYgHtHgDmjjv3EmCz5zp/e4Zr/CMF2fSWluFjloY8D+7
	HEcwevZzbFsN2DBdTTCNG2XbsXM2WeocQztDM
X-Gm-Gg: AfdE7cnhiam4ni2W+VNY6QnKlnft2KMl9Msbtv4nlHGdLcxHkIaR9WLA2/5EnGbD7XG
	hU8yHYQHMQ2zjB9044D+u3u0pB3MkWvYeeXLc23DuewE8JBRHr921ZxSRXR+f/lZ4jdQqWr6CnY
	qbKJfDWS1ZKl6s0nvKynsJHt8x1oRsmiBOvXGkRohEj6QBZCntY/LkuGuAXgOfDovAUU2xprLmw
	eWvR9Wz8zgsszCNhs3bUUXQX8QqnXxqtQPdoMyxX/4J0uJlj9x9bOZnl2Q53TXXL5Qq+adE
X-Received: by 2002:a17:903:11cd:b0:2c6:b429:f111 with SMTP id
 d9443c01a7336-2c6e01ae026mr6889155ad.29.1781726887559; Wed, 17 Jun 2026
 13:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617195645.96604-1-jwcart2@gmail.com> <20260617195645.96604-2-jwcart2@gmail.com>
In-Reply-To: <20260617195645.96604-2-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 17 Jun 2026 16:07:56 -0400
X-Gm-Features: AVVi8CetrSN9S0txv6FNiS4T_AIq9broJsOnXxj-b19sy4oLiRT9t7_2BuZwDsI
Message-ID: <CAEjxPJ5f7PLSN=ORTBVGeJZ242sUecddHXbue1_CHDXSznWf_g@mail.gmail.com>
Subject: Re: [PATCH 2/4 v2] libsemanage: Add checks when growing lists to
 prevent wrapping
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 3:57=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> A common idiom to grow a list or buffer is to use "len *=3D 2", but
> it is possible for the multiplication to wrap on overflow. This
> would result in the new len being smaller than the old len and
> could lead to problems.
>
> Add checks to prevent doing the multiplication if it would wrap.
> The multiplication can always be done if len <=3D MAX / 2 and
> should not be done if len > MAX / 2.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Could also use __builtin_mul_overflow() used elsewhere, but
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsemanage/src/direct_api.c    |  6 +++++-
>  libsemanage/src/genhomedircon.c | 10 +++++-----
>  2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index 9572dbf0..54803515 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -588,7 +588,11 @@ static int read_from_pipe_to_data(semanage_handle_t =
*sh, size_t initial_len,
>                 data_read_len +=3D read_len;
>                 if (data_read_len =3D=3D max_len) {
>                         char *tmp;
> -
> +                       if (max_len > SIZE_MAX / 2) {
> +                               ERR(sh, "Too much data");
> +                               free(data_read);
> +                               return -1;
> +                       }
>                         max_len *=3D 2;
>                         tmp =3D realloc(data_read, max_len);
>                         if (tmp =3D=3D NULL) {
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedir=
con.c
> index ce7ea167..8dc2cb56 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -1090,7 +1090,7 @@ retry:
>                 goto cleanup;
>
>         retval =3D getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
> -       if (retval =3D=3D ERANGE && rbuflen < LONG_MAX / 2) {
> +       if (retval =3D=3D ERANGE && rbuflen <=3D LONG_MAX / 2) {
>                 free(rbuf);
>                 rbuflen *=3D 2;
>                 goto retry;
> @@ -1171,11 +1171,11 @@ static int get_group_users(genhomedircon_settings=
_t *s,
>                                     &group)) !=3D 0 &&
>                errno =3D=3D ERANGE) {
>                 char *new_grbuf;
> -               grbuflen *=3D 2;
> -               if (grbuflen < 0)
> -                       /* the member list could exceed 2Gb on a system w=
ith a 32-bit CPU (where
> -                        * sizeof(long) =3D 4) - if this ever happened, t=
he loop would become infinite. */
> +               if (grbuflen > LONG_MAX / 2) {
> +                       ERR(s->h_semanage, "Member list too long");
>                         goto cleanup;
> +               }
> +               grbuflen *=3D 2;
>                 new_grbuf =3D realloc(grbuf, grbuflen);
>                 if (new_grbuf =3D=3D NULL)
>                         goto cleanup;
> --
> 2.54.0
>
>

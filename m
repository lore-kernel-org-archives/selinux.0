Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E222D060D
	for <selinux@vger.kernel.org>; Thu, 25 Jun 2026 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392834; cv=pass; b=Ca2dKeBwULajd1Q4q1D592MFjCQ3eqa6bcxNdsmJ3p1CE+lEOUdzBbYxyafdYoVqjMCJHQ8X7bIkrG29vRPDQK6+z/fIwju2BOtR9mumoEy7ZPcbWjXgFav/vqk9bAnEAQZdZra513ozVZoYBnyfXnA7rHJEoWqAGnzZy1VRH5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392834; c=relaxed/simple;
	bh=6ju5IBcIc3LUp28l/jdozJ8yBE+0JvsXywAKsyfw1Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gh+d/t6xNekBhrWAM9N/E+FZBwmtk/NP5jgwd2qFI+epvphOjdYkKGLLPqLHVQL87+W7SKXXswgXRBWNfemXKZ9cM3w6Vfdjjsqg760UdyZHYmh0lLFcMysv7S3+2vkNyh5YXgJweXXKoZADF0Nf0G7Y120RC3alBYMLCsIGTCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oEoWXhjb; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEoWXhjb"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84592b55832so1441659b3a.3
        for <selinux@vger.kernel.org>; Thu, 25 Jun 2026 06:07:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782392833; cv=none;
        d=google.com; s=arc-20260327;
        b=TlH76WcW6DQNTbuItk/Ss8C02Y2TjaEOKOxtzilu89PuucgICapEjQ/oI6s5UiF6X4
         sd3JIK7pXqygZbeAaw3oW4jav0CgtHwMrr2MFD0ERcGCO4YjYVS7uKr71H0wKPPNnPI9
         3JXxDx+AudgZC+OOSLj9dkOkoHUgpkt+Z8yFeUful5cppOWyZp7O5inA3cwPtPE5ucB5
         cYqe4s86589FrV3ckfdlk0z4Tkvylxc4+JsRZNa/OjhOV4LLcYQleezmhuY3aDE2V85t
         HV4+GI7/w6tkzx+ZKMUnvaPW+bHoYkZEC3xRStCyT2+gqT5JRCNmJapmxo36OQCwqaaB
         U+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IPh7PEOGUBlvY63Fl1AG00Ogx5T91FMNAsKp5VRtx38=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=U2p7qu7I/TFu6W0FCVwJdUV6X2HjnNDFbFajYmxVy8aTX0+KZGmwwvyfHKdUv5oDPA
         5LZc070q7YO1wwNLMlT+DxHntODkBJq7G73P8Vlc2rHthjm69GnhrAuDrB7MYY5KKemM
         AqIab6mTWLrPLHJTgKrNh1iI0OpiVIiqYOGQmUUdCX+rI2o+CTEecTEsAnPNVHuXoXwM
         jEHtQ4MaQ8/yGzG2KBKn2heWEeGtEOZwoy6Ku1eUlK+O/H6S7GWW+1DG2p4XXZMphMvn
         FhNoYCP6EQVi+hUe1T7IiKklLku2A/zauSC6TfWIAWc8r1Xs+9ABjYQq3T/4qnmHIOpe
         EXnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782392833; x=1782997633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPh7PEOGUBlvY63Fl1AG00Ogx5T91FMNAsKp5VRtx38=;
        b=oEoWXhjb6pWo/znXj2pnnntVWZAeyz3o8Ouk4ynC72tQz+7eZxCqIRyNFLpgNhFdNg
         Pchl3olHrUmt24RfTWkSSmtCZHq/PqQzs7ooO+HaVy/Rkea5Hq4CZwWadcu2McVWTRMS
         he9soelhESLU+lpfXlhztvqCOaJm3QpBIUoFUOa+HEA41BmjhO/uuEI0xMFMVYEkWTrE
         jU6vWqPzwc3JpaJXaB6P12GgmfllmsRwgkhhzoNfDG5nWkU5dUZCFCgBudyKmQIvkmWP
         tQlvqFld4FgsrkBW6OuyJ6tyy7JxG6zpp5jCOCXSQADOX6TTMudkQFZchxRfBiBoI25+
         GTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782392833; x=1782997633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IPh7PEOGUBlvY63Fl1AG00Ogx5T91FMNAsKp5VRtx38=;
        b=tQQlBm+yTVfEiQVa5K2eXAnhQGOVEgR4T3LWYyetIlpXs1Ns8ijjqdcgWFfVNGfisS
         0eKhtCy96UI5Xi7MddHRq3rraUvyUGDMOJAvXlry2tvxABTriIp8JqX9JEI5I/oeXQKL
         qf7IrMgIsndXVzlU8y0asKvTruEr+UgcYSezXFxfvjGXQB3/DYB6IjoTbDAPdZeJ8YsK
         oEM+F+ys79Er17CqieYE9ZDQVxvpEqKYtxO2DoOALNavKWUKCxh7otz63QpDTDZI9sI+
         aDxk5nvzq/mahkVii+hqisOUl7OfFcdpELt3G9g+wt1vlOpR/S9AtXGWqwrIWCsacHlG
         fyuQ==
X-Gm-Message-State: AOJu0YyyEro1cocyVrWV/AZ+jVTsOUQVPdXMv426pabluzhqF77TIv9t
	Gi4PYxywYz1DGum6Jo5ddtjwpnwh3KvBKOJF+0IxhSKxoPm1xVSZcuFRGNfCKOB8SWJY7Qj6wtj
	5XCqVyXK5b0HA/p6jPjBTE4tHgdqwTOo=
X-Gm-Gg: AfdE7cnSebKwGLhqaF0YCywqK9v7mF9r7ss7Af4YH1Y4dobHPPzBy4+CQUIdKTE7Nja
	gTum4SDRMiM+4ZcmiYjPZTlqqVc+FVUmX5Gfl9iQTGAcYdNF9hOHgekv+k3QrtmrHX2Ueb9kCoF
	1vo4cR1Rdaw7nospI1KPZJIgejNit9YveHz2PN/HXu6pJdjX4wN8KEqd2oq8oG5hdumOB6urRxz
	iXTmJFe7rBDEhCtUp91aoTMNyR5GWDVhbXADJKZ4NuPos58bOYf0H7nbRHSSGMwjSwh6eAg
X-Received: by 2002:a05:6a00:4f89:b0:845:4928:8655 with SMTP id
 d2e1a72fcca58-845b3b07276mr3130732b3a.39.1782392832925; Thu, 25 Jun 2026
 06:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624143600.11282-1-jwcart2@gmail.com> <20260624143600.11282-5-jwcart2@gmail.com>
In-Reply-To: <20260624143600.11282-5-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 25 Jun 2026 09:07:01 -0400
X-Gm-Features: AVVi8CfEw_r6DgvoRfzQAn23t_A3mwyD1ditUIZpMu6fkUKpwy6Md0RlLoQn6uU
Message-ID: <CAEjxPJ6g302cQCUQUKS5bQ9gofcCj-BfWv2iiUxk5MOuYuRixg@mail.gmail.com>
Subject: Re: [PATCH 5/6 v6] libsepol: Add overflow checks to strs_* family of functions
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 10:36=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> The strs_* family of functions provide convenient functions for
> handling an array of strings which is used in kernel_to_conf and
> kernel_to_cil. It uses the common idiom of "*=3D 2" to grow the
> array without any checks for overflow. There is also the function
> strs_add_at_index() which can cause multiple iterations of the
> "*=3D 2" idiom.
>
> Use the __builtin_mul_overflow() function that will do the
> multiplication while checking for overflow.
>
> In addition, the function strs_len_items() adds up the lengths
> of all the strings in the array which can overflow.
>
> Use the __builtin_add_overflow() function that will do the addition
> while checking for overflow.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Ack'ing this now but waiting until after 3.11 to merge.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v6: Now actually multiplying new_size by 2, so the loop will end
>     Added a check that len > 0 before subtracting 1
>     Checked the patch with Google Gemini
>
>  libsepol/src/kernel_to_common.c | 29 ++++++++++++++++++++++-------
>  libsepol/src/kernel_to_conf.c   | 12 +++++++++++-
>  2 files changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_com=
mon.c
> index adb7b661..c7b6d73a 100644
> --- a/libsepol/src/kernel_to_common.c
> +++ b/libsepol/src/kernel_to_common.c
> @@ -117,13 +117,18 @@ int strs_add(struct strs *strs, char *s)
>         if (strs->num + 1 > strs->size) {
>                 char **new;
>                 size_t i =3D strs->size;
> -               strs->size *=3D 2;
> -               new =3D reallocarray(strs->list, strs->size, sizeof(char =
*));
> +               size_t new_size;
> +               if (__builtin_mul_overflow(strs->size, 2, &new_size)) {
> +                       ERR(NULL, "Overflow");
> +                       return -1;
> +               }
> +               new =3D reallocarray(strs->list, new_size, sizeof(char *)=
);
>                 if (!new) {
>                         ERR(NULL, "Out of memory");
>                         return -1;
>                 }
>                 strs->list =3D new;
> +               strs->size =3D new_size;
>                 memset(&strs->list[i], 0, sizeof(char *) * (strs->size - =
i));
>         }
>
> @@ -172,15 +177,20 @@ int strs_add_at_index(struct strs *strs, char *s, s=
ize_t index)
>         if (index >=3D strs->size) {
>                 char **new;
>                 size_t i =3D strs->size;
> -               while (index >=3D strs->size) {
> -                       strs->size *=3D 2;
> +               size_t new_size =3D strs->size;
> +               while (index >=3D new_size) {
> +                       if (__builtin_mul_overflow(new_size, 2, &new_size=
)) {
> +                               ERR(NULL, "Overflow");
> +                               return -1;
> +                       }
>                 }
> -               new =3D reallocarray(strs->list, strs->size, sizeof(char =
*));
> +               new =3D reallocarray(strs->list, new_size, sizeof(char *)=
);
>                 if (!new) {
>                         ERR(NULL, "Out of memory");
>                         return -1;
>                 }
>                 strs->list =3D new;
> +               strs->size =3D new_size;
>                 memset(&strs->list[i], 0, sizeof(char *) * (strs->size - =
i));
>         }
>
> @@ -229,7 +239,9 @@ size_t strs_len_items(const struct strs *strs)
>         for (i =3D 0; i < strs->num; i++) {
>                 if (!strs->list[i])
>                         continue;
> -               len +=3D strlen(strs->list[i]);
> +               if (__builtin_add_overflow(len, strlen(strs->list[i]), &l=
en)) {
> +                       return SIZE_MAX;
> +               }
>         }
>
>         return len;
> @@ -248,7 +260,10 @@ char *strs_to_str(const struct strs *strs)
>         }
>
>         /* strs->num added because either ' ' or '\0' follows each item *=
/
> -       len =3D strs_len_items(strs) + strs->num;
> +       if (__builtin_add_overflow(strs_len_items(strs), strs->num, &len)=
) {
> +               ERR(NULL, "Overflow");
> +               goto exit;
> +       }
>         str =3D malloc(len);
>         if (!str) {
>                 ERR(NULL, "Out of memory");
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index 3e6bcb33..89425d36 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -1663,7 +1663,17 @@ static char *attr_strs_to_str(struct strs *strs)
>         }
>
>         /* 2*strs->num - 1 because ", " follows all but last attr (follow=
ed by '\0') */
> -       len =3D strs_len_items(strs) + 2 * strs->num - 1;
> +       if (__builtin_mul_overflow(strs->num, 2, &len)) {
> +               ERR(NULL, "Overflow");
> +               goto exit;
> +       }
> +       if (len > 0) {
> +               len -=3D 1;
> +       }
> +       if (__builtin_add_overflow(len, strs_len_items(strs), &len)) {
> +               ERR(NULL, "Overflow");
> +               goto exit;
> +       }
>         str =3D malloc(len);
>         if (!str) {
>                 ERR(NULL, "Out of memory");
> --
> 2.54.0
>

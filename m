Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FDF13E41A
	for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 20:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729628890; cv=none; b=nkoadmORKycizZ/rgyS9po1wl64NiTM/6jp7jaQp530z6u/octSTbOAJIa62xqSPNzAXUp5oqEdUhhl2cgNGIDunK7ljQ/IcPkfW5Y7e/4JcMJjKv0meQu7s18AV/YNlzx/kvXsc+1mO/ezuvEhAazlm5k/B0ct0+Z0uyOILsVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729628890; c=relaxed/simple;
	bh=7Hxk7O4gBxAUUX0j2yTNjBBJVmW4I7j2ny/nYQJAlYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpRQ7bYeGK/AiFB+vbrYFMcgpofsDtPtLcJpsDppnpU7emPa2VP1R2viwk80fiQK+mQN56CpELjg1HEgsJfqKk3wasTVsk4woUwUbO3gHjQW50MdJXnjl2UMb44gDpDFI3F3Q7AeTmh2R41l5n8RkyvpdiUwA6BL9Ac842QW+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6IxKTPd; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6IxKTPd"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-84fc0209e87so1969672241.1
        for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 13:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729628888; x=1730233688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0M1kS++TYC11LLOvL7XqjtAuE5qmMkETPoZEBj1tgE=;
        b=h6IxKTPdg8gxDbhmccK2XT8Y/eFEAQ+4Gc2BjGzkcp+vzSw5CgfsrRfJDcJmExaaWq
         thmGqPJjcruvP0rf0JqHTFOYIhNI5YcEIIz1yHBmJJnJiby9yHgLXb39ZGAbTn2MFDlZ
         02tgjkgN5KIunHJbLlM2HZJzo/0kcjt/iaX5CKfku76yH2h5DV+eFEfMuQc5yhkg2hDi
         u89tkuYQ7wZ+Fp8BdgKNVfXnRgzkTC8DHxvlwCEphbEiljBKtxaEfa68D6SakY2i8Ntu
         yPz1tGOsxvdlVpBaZKCYSEjv4kNijhI0qAr5Eel+uTJmoVbBhqekiXcjg5zQZ8NkRbJh
         qgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729628888; x=1730233688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0M1kS++TYC11LLOvL7XqjtAuE5qmMkETPoZEBj1tgE=;
        b=iDVUGeWxFjR8QemgRBvoTHwpb2OM4V5gtnlOzuS8e5Eh5pQ3k3XVyV/VVHRu3T08DU
         Smrgw9YMa2NpVBL4hIo2K4pXljaIPd8FRQDWRAxRuiw9epM9A5GcVQKqdHBkrRWwb5A4
         rMiq3HEjt76K2+UzHOEX0zza9XrwnNbpEX2PeLbh5GNtI4zXxcBrFgHh+x3EhRN7/iS8
         d+7E2WcTtbHOVMjwlXEedXzFpTPQDCCkkcDCWxoif2lYDid0OGZXgSACWUZfZ+ttOvcJ
         gYGnjtwymfmiv1IhEAhkXyODVJk/WVzQ5C0eKGg12MAYNIhUXHmF0LXS9iziEzngTMg7
         b1Fg==
X-Gm-Message-State: AOJu0Yzv84JBBQwHQeHCeU21t+4c8JaZY+KvGRYfRoFRluyJr5W8sMUg
	/sfDifG3bADJTwgNcc4pLNs8jPfC8JrJz8bnqNXb8pP35mxBotOT40+85Vl0ZSjifPYtqKyzvYZ
	lcCgNi37W2G57uikOokf/qB7nG+4=
X-Google-Smtp-Source: AGHT+IFQotEGQZ+AcA1G5tfIRmFOKOnLAJLv17a9SlfkPn6NHI5Zn0hcnqhKTMSyhUM2hHkuqwuLuC1c0yhzVsTvLHc=
X-Received: by 2002:a05:6102:4415:b0:4a4:8651:3c46 with SMTP id
 ada2fe7eead31-4a751c9268dmr405887137.18.1729628888039; Tue, 22 Oct 2024
 13:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022090314.173002-1-vmojzis@redhat.com> <20241022090314.173002-4-vmojzis@redhat.com>
In-Reply-To: <20241022090314.173002-4-vmojzis@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 22 Oct 2024 16:27:57 -0400
Message-ID: <CAP+JOzSs3i0bTUAuxzssgirFV41s2wfrpkBFx-s9EU38Sp2BDQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] libsepol: Initialize "strs" on declaration
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 5:09=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
> The value of "strs" was not always initialized before being used by
> strs_destroy.
>
> Fixes:
> Error: UNINIT (CWE-457):
> libsepol-3.7/src/kernel_to_cil.c:1439:2: var_decl: Declaring variable "st=
rs" without initializer.
> libsepol-3.7/src/kernel_to_cil.c:1487:2: uninit_use_in_call: Using uninit=
ialized value "strs" when calling "strs_destroy".
>  \# 1485|
>  \# 1486|   exit:
>  \# 1487|->     strs_destroy(&strs);
>  \# 1488|
>  \# 1489|       if (rc !=3D 0) {
>
> Error: UNINIT (CWE-457):
> libsepol-3.7/src/kernel_to_conf.c:1422:2: var_decl: Declaring variable "s=
trs" without initializer.
> libsepol-3.7/src/kernel_to_conf.c:1461:2: uninit_use_in_call: Using unini=
tialized value "strs" when calling "strs_destroy".
>  \# 1459|
>  \# 1460|   exit:
>  \# 1461|->     strs_destroy(&strs);
>  \# 1462|
>  \# 1463|       if (rc !=3D 0) {
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/kernel_to_cil.c  | 2 +-
>  libsepol/src/kernel_to_conf.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 7243b3c0..2d563e7d 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -1436,7 +1436,7 @@ static int map_type_aliases_to_strs(char *key, void=
 *data, void *args)
>  static int write_type_alias_rules_to_cil(FILE *out, struct policydb *pdb=
)
>  {
>         type_datum_t *alias;
> -       struct strs *strs;
> +       struct strs *strs =3D NULL;
>         char *name;
>         char *type;
>         unsigned i, num =3D 0;
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index ca91ffae..661546af 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -1419,7 +1419,7 @@ static int map_type_aliases_to_strs(char *key, void=
 *data, void *args)
>  static int write_type_alias_rules_to_conf(FILE *out, struct policydb *pd=
b)
>  {
>         type_datum_t *alias;
> -       struct strs *strs;
> +       struct strs *strs =3D NULL;
>         char *name;
>         char *type;
>         unsigned i, num =3D 0;
> --
> 2.47.0
>
>

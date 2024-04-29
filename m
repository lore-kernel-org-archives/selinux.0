Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C131B94D
	for <selinux@vger.kernel.org>; Mon, 29 Apr 2024 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422995; cv=none; b=QvZ8xGDCXP9VN5SKxQuPX1LEtZKZBYNmawHWt2ENdBvqblJDHglctIBlqs6/E5GkVCdKWauR5F/TmfgQi3/J/W2GaF0l4oTYZ+cfPXdBQX7HZsa3M9DR4NgX8ysv/tkYCrqTIcrQQub7LwRkTk0osU1VWuVKXi4TDfb0e797SDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422995; c=relaxed/simple;
	bh=sf9KNJS3tRvpEGhtnVka46oNDbCjqSWABDI8pgJnMZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOrkkrAGCOX4pD5ooCh2+VtETiylBdGkk/uXSICqivps6Ovo9AofY7z9/F5l1P4XQAlcHtwbN8OWapDThoXZm8a3IhHiDOZfVKQSTu/tB4/VmXr9yDoE+RjURHBO0bTW8u3pK2aocxKFskP/q9rH9vBqB3omP7yQmcPmWmC2/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRHrDU+E; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRHrDU+E"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e0b2ddc54fso11974321fa.0
        for <selinux@vger.kernel.org>; Mon, 29 Apr 2024 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714422992; x=1715027792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=004i2mJ6zgdDZtyp9mJavMoR3wug3KJpK9VSXshpOOc=;
        b=HRHrDU+EHey7+XrQv503HOk0gun1u7kGPnKkFfdOVte81ujO9fu2dVITqF7qBR/w8m
         fiO+fdBMr0h0qSnqpFXK+L6l3n2186CSZFNRDQZWulXGfzIkonJZ2IJYG3N964WiN9PY
         rQTdJ42P+XFR5M4e44eXELT5RytbjvRxKEYaCaPT0S/ut62mJpV2nK13rl0Ew3EThBhA
         yrVumtZ+kK7tK/MYBjfMJVV3880CZDUb+T7uBafMC/GRzNBfqkwDsw5peJ3hr3sNMNoc
         X+CdI0ceUKBc1lxoJ1aoY4rwHG4u5qhv00LI8BpultMLf6qdK/3Yv5rod5yW9f2z0W0C
         JqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714422992; x=1715027792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=004i2mJ6zgdDZtyp9mJavMoR3wug3KJpK9VSXshpOOc=;
        b=N8d+QQZZpZdDgcGh1eneGx5/1gO8tkID5jILeC7dwcPFzjAXWiGGXLr6susJkuIDlf
         b14Dif2wUCSQMKta+xFqjxqXXQM/p3JO3QyFMLnQcAipq8glmGvRGgnUdV3n7o3R3yF4
         k+RQeYXLtunUyO3VJwJ29/Kb9Vf3+3c+MZsfJF1wTLlytDbfc2ms+SptalA8zhkniozm
         a99ND6DzDltCEqsCeRD16sUtsXn+hnljcKhpG8ffg3m6ADjqOJjoa0C5Rg0eze27aLi3
         fIDO15X+/Ndm9t8WSd0rpIQ3tlQzqCVWJ9o+urhZkU+23eZNqYYNQ0fVXCsDhGAXZOW1
         fMBg==
X-Gm-Message-State: AOJu0YyeSBuar2ELZQ1KyVvxw38LhuE9m0PdsEgTRoe0jDofWf1La53l
	d2MCJgOTQ0sPqMgo2KKNtI137pHOjRfWAdGOXGJdN0OYGN3ZtR48v060lOILH+Tnj/9hjOkL0RH
	F5zeLjUZKCNhZXWzqLkQvfwhLEHT5Vw==
X-Google-Smtp-Source: AGHT+IFTF26k5YC+rzcM0z/EUBWbQW4CWyetOf0phNXz2nOtESu4698Czo5TF+n1XgUf+3mX+s2DSi+gbfe6VNYNXjY=
X-Received: by 2002:a2e:a36f:0:b0:2df:7889:6738 with SMTP id
 i15-20020a2ea36f000000b002df78896738mr6193318ljn.24.1714422991838; Mon, 29
 Apr 2024 13:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429163901.65239-1-cgoettsche@seltendoof.de> <20240429163901.65239-2-cgoettsche@seltendoof.de>
In-Reply-To: <20240429163901.65239-2-cgoettsche@seltendoof.de>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 29 Apr 2024 15:36:20 -0500
Message-ID: <CAFftDdp4_Ynpy3CEQ5pNx6dR5pGb1gzAKmFFPx0eFKo5q3v9Hg@mail.gmail.com>
Subject: Re: [PATCH 2/3] libselinux: avoid pointer dereference before check
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 11:40=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Since commit 5876aca0 ("libselinux: free data on selabel open failure")
> the close handler of label backends must support partial initialized
> state, e.g. ->data being NULL.  Thus checks for NULL were added, but in
> two cases the pointers in question were already dereferenced before.
>
> Reorder the dereference after the NULL-checks.
>
> Fixes: 5876aca0 ("libselinux: free data on selabel open failure")
> Reported-by: Cppcheck
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/label_media.c | 4 +++-
>  libselinux/src/label_x.c     | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
> index 94a58062..852aeada 100644
> --- a/libselinux/src/label_media.c
> +++ b/libselinux/src/label_media.c
> @@ -164,12 +164,14 @@ finish:
>  static void close(struct selabel_handle *rec)
>  {
>         struct saved_data *data =3D (struct saved_data *)rec->data;
> -       struct spec *spec, *spec_arr =3D data->spec_arr;
> +       struct spec *spec, *spec_arr;
>         unsigned int i;
>
>         if (!data)
>                 return;
>
> +       spec_arr =3D data->spec_arr;
> +
>         for (i =3D 0; i < data->nspec; i++) {
>                 spec =3D &spec_arr[i];
>                 free(spec->key);
> diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
> index f994eefa..a8decc7a 100644
> --- a/libselinux/src/label_x.c
> +++ b/libselinux/src/label_x.c
> @@ -191,12 +191,14 @@ finish:
>  static void close(struct selabel_handle *rec)
>  {
>         struct saved_data *data =3D (struct saved_data *)rec->data;
> -       struct spec *spec, *spec_arr =3D data->spec_arr;
> +       struct spec *spec, *spec_arr;
>         unsigned int i;
>
>         if (!data)
>                 return;
>
> +       spec_arr =3D data->spec_arr;
> +
>         for (i =3D 0; i < data->nspec; i++) {
>                 spec =3D &spec_arr[i];
>                 free(spec->key);
> --
> 2.43.0
>
>

LGTM, ack.

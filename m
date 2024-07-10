Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D915C195F28
	for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720635879; cv=none; b=eHgxd1bPDLBOtfE36fep8/8WuthjaZsMR9kIybvLQ3kLQ6qV4KI+uhEe3zsFLTBOiH2/jhn1liBgmxnXjlOYVF5LkfhlkwVuM8T8OMt+CMlquiCODjK26Gd/kX7gSbnaB6HorN8Q04ZOICize4UA+AqaEE1gRVFZif11e9qd9ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720635879; c=relaxed/simple;
	bh=jxZBZom7a9WJiu8/6ivgmLSY4YBJUCgAx3zS1703g+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DU3r7OmQGXjVXfGmDHjvT8TwCB4wa8BAIQUCoCwMyeDVocLAdThxp1f/lH8fwj0bPK1PwfPBLKFvuCRJGldVBJtuoJenUeeNcshruDg4h2SGQBT9/6zkvP8TDsaEd30+qxpBSwyeb2w9Xb/KN142bcUe+eDGZ4O8XDaMAkJXXfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioevB11O; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioevB11O"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-48ff70394fbso2002263137.3
        for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 11:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720635876; x=1721240676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8cyIOU9gyibQwzl+AdVp0GjyWCg99Ttrt5AHF4P2cE=;
        b=ioevB11OdvfOuq5H+IQUs2j7NWbrm3RGsGhiGFZOouOGUJs4m2PL+fgxatwWGxg8aH
         AbPOm5rfJo0ZTCnznb2QnR++Pk5mqAr9ceacQBWvMf2i0d6Y8YNgpzURyVsg9JBLf1cD
         xVQ4ARXQ4w49We5rkhmjSU++IgJv2W2i/wiGIL80COn2zZ76L8mELrEebhoWnKFq/qao
         EwuLT+3j/X6PZ+OzarP1xLr/5wdIsDWPaI+8DKvHG3m/8yRfTcd2bRjluLnhz9lIMouj
         mK33fPr99ra0+G/DZ1lwIRedd5lo217lbStDErwt30+rsssEWduztfXbiClq2rED+zYC
         FAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720635876; x=1721240676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8cyIOU9gyibQwzl+AdVp0GjyWCg99Ttrt5AHF4P2cE=;
        b=tg9e7PnlTlWX3ozdPqmUfZaVX+xIDFrtuawTSDAKXd8HDY+50AM3Wc/l8BXjnvs/HO
         s1QVzKjMBikjPmPyQQsVoBuJEo4szKmvBsf9SS1DmQ74WZnHm0MHmVTy4T/HQ2OFlOqx
         Z5QERnjrGPV5q1kruTvMEKr2oDkri0ohgtrsBJieQEfHhfFw3wNflGPPDBrMGTur7tFL
         9Neo8Ie9TysCFDxITzEljIsFRoV/ntqUy1WG5A1//OAEYazxVagNffgbn8DbJX5TWH7c
         b4QmpD3FU5vx8hx4O46TdVwg26gugkj99mYwRPJcOL/0TohsOZGmOC448Jx1+2xRjQsO
         anUg==
X-Gm-Message-State: AOJu0YzISp0tqvD9v+N4iE+LPmfKRy47RQejIk0vO5bEL6Q4uqEp1VGf
	9ZTNlFTRVHfFVC8IqAPiv8QtRvnkK8bktw/yyobJ/0HWJVZA6u7se6ULD541QDO5MgeQU70lf+w
	/PtmvotTWod50tWb+IyGKEs7k3VU=
X-Google-Smtp-Source: AGHT+IFAKcTi0kHGVMjUiI6z9kJ9MCXjtiNXqAGpRdffvA3QYnvRficjuveUw0RLA8gHtLCtmBjiCHBkC6mACLP5VD0=
X-Received: by 2002:a05:6102:c54:b0:48f:e49e:ef1a with SMTP id
 ada2fe7eead31-49032134dfcmr7274813137.15.1720635876570; Wed, 10 Jul 2024
 11:24:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709192346.913107-1-lautrbach@redhat.com>
In-Reply-To: <20240709192346.913107-1-lautrbach@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 10 Jul 2024 14:24:25 -0400
Message-ID: <CAP+JOzQCu0srfss921Ew42oHxsaqRYGiTs56_h9j2Yfw0cYGjg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: set free'd data to NULL
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 3:24=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> Fixes segfault in selabel_open() on systems with SELinux disabled and wit=
hout any
> SELinux policy installed introduced by commit 5876aca0484f ("libselinux: =
free
> data on selabel open failure"):
>
>     $ sestatus
>     SELinux status:                 disabled
>
>     $ cat /etc/selinux/config
>     cat: /etc/selinux/config: No such file or directory
>
>     $ matchpathcon /abc
>     [1]    907999 segmentation fault (core dumped)  matchpathcon /abc
>

I was able to recreate the problem and verify that this fixes it.
Acked-by: James Carter <jwcart2@gmail.com>

> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> ---
>  libselinux/src/label_backends_android.c | 1 +
>  libselinux/src/label_file.c             | 1 +
>  libselinux/src/label_media.c            | 1 +
>  libselinux/src/label_x.c                | 1 +
>  4 files changed, 4 insertions(+)
>
> diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/lab=
el_backends_android.c
> index 49a87686de4c..5bad24f20d73 100644
> --- a/libselinux/src/label_backends_android.c
> +++ b/libselinux/src/label_backends_android.c
> @@ -260,6 +260,7 @@ static void closef(struct selabel_handle *rec)
>                 free(data->spec_arr);
>
>         free(data);
> +       rec->data =3D NULL;
>  }
>
>  static struct selabel_lookup_rec *property_lookup(struct selabel_handle =
*rec,
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 2732972e61cf..59c9f2ef3442 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -942,6 +942,7 @@ static void closef(struct selabel_handle *rec)
>                 free(last_area);
>         }
>         free(data);
> +       rec->data =3D NULL;
>  }
>
>  // Finds all the matches of |key| in the given context. Returns the resu=
lt in
> diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
> index 852aeada8ff4..bae065c12a55 100644
> --- a/libselinux/src/label_media.c
> +++ b/libselinux/src/label_media.c
> @@ -183,6 +183,7 @@ static void close(struct selabel_handle *rec)
>             free(spec_arr);
>
>         free(data);
> +       rec->data =3D NULL;
>  }
>
>  static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
> diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
> index a8decc7a0093..ddae4f6c22b6 100644
> --- a/libselinux/src/label_x.c
> +++ b/libselinux/src/label_x.c
> @@ -210,6 +210,7 @@ static void close(struct selabel_handle *rec)
>             free(spec_arr);
>
>         free(data);
> +       rec->data =3D NULL;
>  }
>
>  static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
> --
> 2.45.2
>
>

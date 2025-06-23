Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917FB26FA62
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691097; cv=none; b=gPbtXuIb5Ax/l/fCm/o8j3QyYfqwWZsTEfH9xQ5mnrM7gdAAi48gF2PxCHAzRrAGcRmvKevbuC5Y0rH9NKVpNanof2771Hayd+kXJ8GTn8ruJIJ7NivhXou5s7ryZ+ugX2ohT9OXz3o2UVosgsvlscsfRYz7VB5NNgcbjiuufUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691097; c=relaxed/simple;
	bh=6KnhyQABL/h9aeY6yr5tg+vbniBA2+RkD5jXAsjI/tA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhTBxtL8ZpbMzvEKFsEHPLign4V5DFSRtNkSky+4S1X4MvYPwJIJK9AlHG2Nemn/Cjr98rEgLMI6Zy1nM12c62ja8wYeVLh9nRHFavT4+ws/+He2xfL3kRSNacI4yy9pfpk6h20yjvzlNAa0THyyZYi+R+FHgWwsdcyMjhjMlr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUgzUTrU; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUgzUTrU"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2d09d495c6cso1084091fac.3
        for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 08:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750691094; x=1751295894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aloMm+uDKP16yeHZcP1K4f7rLsOO9YwzIBBzSSI3nc0=;
        b=YUgzUTrU7p72LIXhCqYOKUN0hn64f+k8vChcG2vLHi7S23UIlCFtF/aqsV19GVDvwO
         9q/xXf0CFs2NXe60sgEcpOhTv8ayOjEbewv0FudNfTHG1W5O4JBDs0aW+AA3casIVqcL
         7ufvSoWIQTW9qWcKHIN5pdb1JNzqe6ELogh4Z8F3ZC/gIrccQ5ppzV0DxHk38VB/ZD03
         XSWZJkfEHoZEX1EP3Ozwp3iWsvzJz+1W14Kf2QGh1jFXUut+cPAPD4xY6IeitNSDUusp
         0PbQn9ZYFGZHZXNQOXEziKWVMzmPzNWs9AH/1+O3xyHhdTEE495fcRUW3o3QQZm+mPM7
         cSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750691094; x=1751295894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aloMm+uDKP16yeHZcP1K4f7rLsOO9YwzIBBzSSI3nc0=;
        b=glYwImRxFRvwbwPNv51G8n3CL8Afc8A71sQjuAQ6oO1HyvARmgXVCDRw3WeYku7d2Q
         CmBC3htDuj3Fhhd3efT9+SFYdl9qIjg446/w7DOmofr7HsRdVMmOF4ALqi0kROmU5BVM
         5qSx4EK0uj/c27x2ER2OAava5ZVPKoC5FIHqn7Z09FNfdD2+9+9i4mW1STxqwL7YWhVx
         SVWSdcCQEwm+WF/n3oIXCOkarHhYmRhoohPQ6mk+9tG545UumgzCNzFebuzmq0a2ZZCZ
         3/jMH3Fm+iCoKBP8h50CdsXzL7cLwO+6Od9/Q+CPIGbFmQwpsRcAvN6RPp8NqMAidIum
         FgHQ==
X-Gm-Message-State: AOJu0Ywnn0BiuZsZwEjX7TpC1AwlgoE9wMtVeZ+ak+fBpDBR4S4Nh5Qw
	bHEO1qtiBCxbT5+hEDueiRcd3coJfUkCU8TqIY4qRI0SBHtVhlTk300SdkKTyuWtnsPPRMXisBs
	/2CP3WwPhIxQjFQsBS2ya/zCmVuRL8S0=
X-Gm-Gg: ASbGnct3dHKzAmD5J5VstZX6IBQGUUrewmVwUbplAEQywYCKE/J9/Wsx11BJcivE+BT
	7I7W1YIocJum0jmw2MZHE2b+5BlfPR9jH8840+Tn+OZPa5ZhbJo/brkZcU7eBDlsnSz2PtQSjzq
	Zc3hYo8bGcUPsa8RFneiK4/ypBaPG0MbCfhCFuzqu8OO4=
X-Google-Smtp-Source: AGHT+IFtSYmjA1O3jurkBcYGGi2GsfnLMX3XxMVrkVzTteQ3lJZidESKW82c2w2esHXEGe9ptYvPFbTvB/nIUhaBAs4=
X-Received: by 2002:a05:6871:a90a:b0:2c2:2f08:5e5b with SMTP id
 586e51a60fabf-2eeda5652a8mr8965069fac.13.1750691094219; Mon, 23 Jun 2025
 08:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616152534.26053-1-cgoettsche@seltendoof.de> <20250616152534.26053-5-cgoettsche@seltendoof.de>
In-Reply-To: <20250616152534.26053-5-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 23 Jun 2025 11:04:42 -0400
X-Gm-Features: Ac12FXxFHe6j-ofrgtm15ikxXnP1ao7N6CxcsIToxZYC9YvGNQs_D_JQbk7KK6A
Message-ID: <CAP+JOzSJXKnNu3bHBuo4DRNFiVYauzjtfZw1xBu0CxEOsn_TZA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] libsepol: update sort order for netifcon definitions
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 11:33=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Order netifcon definitions with a wildcard interface name last in object
> contexts, so the kernel tries to match literal names first.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these five patches.
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_post.c     | 36 ++++++++++++++++++++++++++++++---
>  libsepol/src/kernel_to_common.c | 36 ++++++++++++++++++++++++++++++---
>  2 files changed, 66 insertions(+), 6 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index d63a5496..70e5b734 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -316,10 +316,40 @@ int cil_post_genfscon_compare(const void *a, const =
void *b)
>
>  int cil_post_netifcon_compare(const void *a, const void *b)
>  {
> -       struct cil_netifcon *anetifcon =3D *(struct cil_netifcon**)a;
> -       struct cil_netifcon *bnetifcon =3D *(struct cil_netifcon**)b;
> +       /* keep in sync with kernel_to_common.c:netif_data_cmp() */
> +       const struct cil_netifcon *anetifcon =3D *(struct cil_netifcon**)=
a;
> +       const struct cil_netifcon *bnetifcon =3D *(struct cil_netifcon**)=
b;
> +       const char *a_name =3D anetifcon->interface_str;
> +       const char *b_name =3D bnetifcon->interface_str;
> +       size_t a_stem =3D strcspn(a_name, "*?");
> +       size_t b_stem =3D strcspn(b_name, "*?");
> +       size_t a_len =3D strlen(a_name);
> +       size_t b_len =3D strlen(b_name);
> +       int a_iswildcard =3D a_stem !=3D a_len;
> +       int b_iswildcard =3D b_stem !=3D b_len;
> +       int rc;
> +
> +       /* order non-wildcards first */
> +       rc =3D spaceship_cmp(a_iswildcard, b_iswildcard);
> +       if (rc)
> +               return rc;
> +
> +       /* order non-wildcards alphabetically */
> +       if (!a_iswildcard)
> +               return strcmp(a_name, b_name);
> +
> +       /* order by decreasing stem length */
> +       rc =3D spaceship_cmp(a_stem, b_stem);
> +       if (rc)
> +               return -rc;
> +
> +       /* order '?' (0x3f) before '*' (0x2A) */
> +       rc =3D spaceship_cmp(a_name[a_stem], b_name[b_stem]);
> +       if (rc)
> +               return -rc;
>
> -       return  strcmp(anetifcon->interface_str, bnetifcon->interface_str=
);
> +       /* order alphabetically */
> +       return strcmp(a_name, b_name);
>  }
>
>  int cil_post_ibendportcon_compare(const void *a, const void *b)
> diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_com=
mon.c
> index 44f0be23..e4338ec6 100644
> --- a/libsepol/src/kernel_to_common.c
> +++ b/libsepol/src/kernel_to_common.c
> @@ -441,10 +441,40 @@ static int portcon_data_cmp(const void *a, const vo=
id *b)
>
>  static int netif_data_cmp(const void *a, const void *b)
>  {
> -       struct ocontext *const *aa =3D a;
> -       struct ocontext *const *bb =3D b;
> +       /* keep in sync with cil_post.c:cil_post_netifcon_compare() */
> +       const struct ocontext *const *aa =3D a;
> +       const struct ocontext *const *bb =3D b;
> +       const char *a_name =3D (*aa)->u.name;
> +       const char *b_name =3D (*bb)->u.name;
> +       size_t a_stem =3D strcspn(a_name, "*?");
> +       size_t b_stem =3D strcspn(b_name, "*?");
> +       size_t a_len =3D strlen(a_name);
> +       size_t b_len =3D strlen(b_name);
> +       int a_iswildcard =3D a_stem !=3D a_len;
> +       int b_iswildcard =3D b_stem !=3D b_len;
> +       int rc;
>
> -       return strcmp((*aa)->u.name, (*bb)->u.name);
> +       /* order non-wildcards first */
> +       rc =3D spaceship_cmp(a_iswildcard, b_iswildcard);
> +       if (rc)
> +               return rc;
> +
> +       /* order non-wildcards alphabetically */
> +       if (!a_iswildcard)
> +               return strcmp(a_name, b_name);
> +
> +       /* order by decreasing stem length */
> +       rc =3D spaceship_cmp(a_stem, b_stem);
> +       if (rc)
> +               return -rc;
> +
> +       /* order '?' (0x3f) before '*' (0x2A) */
> +       rc =3D spaceship_cmp(a_name[a_stem], b_name[b_stem]);
> +       if (rc)
> +               return -rc;
> +
> +       /* order alphabetically */
> +       return strcmp(a_name, b_name);
>  }
>
>  static int node_data_cmp(const void *a, const void *b)
> --
> 2.49.0
>
>

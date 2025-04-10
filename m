Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB6328D841
	for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312500; cv=none; b=Sd1Qorq2tpNGv1cE1fssHmDy90/nSnpXR7EV9y51ibes+KWgLKbENJki1pjKpikFL4tGVswHBj2AOWFw8Zr9vatfRwe5mSqL8nHe2ty7yMOjwMR34j+3zBTIjbiZz3nSMq2nQXVQxSiMmUNba4WFjZwYJJz/bqMnvuWt/uqQ1DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312500; c=relaxed/simple;
	bh=+Oh3TL+l1bJtuKAehWYdbm5zFOUdDJ1mpb7L625e37E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWyLQvXEciaCRZV7v2AOZdudTDVWrJqaRBHhkIfvN4hfal5sY/4Edeuv9eLMTmox75EIRT5u6wmdM3kFzIAdpZQR4lFZUGKu/w7RVH3QzmpgW6vEYopI8bU6RSYWDy6w600NIKZvx0pbekFMVmZ+JryoiojuUl6AnxxGN06ExQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5UpkxcP; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5UpkxcP"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86f9c719d63so492401241.1
        for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 12:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744312498; x=1744917298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsYJbemmLm/SldWdnmefH/3efkYqCRTxTX4+zqCjuyc=;
        b=H5UpkxcPcvClhOLSHBj8ZCMlW1MYU5+34u6H2T9s/s65b9UNwMVq/gFJwAvTdaBr2m
         FUg2clRtkKpH+Sipc1WG+hD2358s6uycxMiFihJxR6zsqVtzQovcgDpV8tQLsgWjFjzs
         15KL2vZl7Fb+KQ2d6lnsV/5MwW/pJesUveHrDuiISxtDcuKvr/MsEYu0UptPsLFT0L+z
         7XtRsSOAuYtMvJOAREjX/uYEJZHy7EjhfWutmSApZudw+BvMbjKE5A3MQVIi2gB1UZ4i
         G1Peq2jlWnWP7TGzXRGfkbpT3DRkR5fg1/JaBZ54h4LtCuFN3aLNhWBgfcEU+zxDkByF
         9JGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744312498; x=1744917298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsYJbemmLm/SldWdnmefH/3efkYqCRTxTX4+zqCjuyc=;
        b=j/7HNtEmjfPRMQKh7oO4IZny7BCQan27Oajak0xvfZBIlcS+QY1hvkj944Z4ZF/j7J
         U2yePDjf6vEMk4rGRAiDZFKSNwCpz/gMnDQztOZB9VMlnrkZV7MRxN0ZBIhGUqVtIDqu
         wPyn0UzTQWTjn8p4ayCxceAoMThxmVii2y+KRgNOWZXQAGEhAlud11MfvDWiX5+cJLz2
         qVmKCWAkWvgzczgbydiurGrsvmiUTqdkh9DAEKap5fW72u+X1axuKff2qnF8UXq85cZD
         xFxK1sygE6bL7U8A3Pl0exYfTh7+z8MkJrZ6ucljK7FGPHD+bOVf72XHNRTH9R94W1zM
         2SQA==
X-Gm-Message-State: AOJu0YyoaoWjccojAKlJu0NJwPraFqyc+8r6VAef1QeYUlZrsbMTS76B
	fs4H/vovRJlmwQ0Vd73XlgDQH3ZgsRwFIBVbgYFxCMszl1D1qKd/nS16bXLguAXTvAZ44QeBdxQ
	QDvh1Hj/5YLPlK1tXxVjHAkrlU4h+3A==
X-Gm-Gg: ASbGncsk3vNY58m9i1QVyCDD9xHahX2gte3nfK64QUE6mKb381DQ5hxFhhauJBg9EpM
	wh4sJOldaNzmRqZO50qo76PgCeOLOeu5/gLNn8fSxDAtgR0unJ7L8eSHa0gb8YsQW5oCXQPqoPW
	Sy39hX6jOY3xPGuRoPDis=
X-Google-Smtp-Source: AGHT+IFl1RT5m8WpUZFDIXVOdTA94/ufrqnt1753YweYDwoKHAoMnOFIZk98376Wbxv1lKmg5UHuHk6z1Vnf367+Nbw=
X-Received: by 2002:a05:6102:1612:b0:4c3:6393:83f4 with SMTP id
 ada2fe7eead31-4c9d61ef59cmr3960461137.2.1744312497872; Thu, 10 Apr 2025
 12:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410021820.3874574-1-inseob@google.com> <20250410021820.3874574-4-inseob@google.com>
In-Reply-To: <20250410021820.3874574-4-inseob@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 10 Apr 2025 15:14:46 -0400
X-Gm-Features: ATxdqUGWIfQuEZKwzMbosb4-bUSuNcwuD5LLDnebQmQNYGGyqg4Yp7cYnUVl4q0
Message-ID: <CAP+JOzQqgz4RsYSC7R-4maibH8rDuB=aHzVBbRsUOgKCYY+7-Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] checkmodule: Support line markers for allow rules
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, tweek@google.com, jeffv@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 10:18=E2=80=AFPM Inseob Kim <inseob@google.com> wrot=
e:
>
> Using line markers for allow rules helps debugging, especially
> neverallow failure reports. But unconditionally printing them can bloat
> output cil files, so this commit adds an option to do that.
>
> Signed-off-by: Inseob Kim <inseob@google.com>
> ---
>  checkpolicy/checkmodule.8 |  5 +++++
>  checkpolicy/checkmodule.c | 18 ++++++++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/checkpolicy/checkmodule.8 b/checkpolicy/checkmodule.8
> index 93c9b537..b642718c 100644
> --- a/checkpolicy/checkmodule.8
> +++ b/checkpolicy/checkmodule.8
> @@ -46,6 +46,11 @@ Enable the MLS/MCS support when checking and compiling=
 the policy module.
>  .B \-N,\-\-disable-neverallow
>  Do not check neverallow rules.
>  .TP
> +.B \-L,\-\-line-marker-for-allow
> +Output line markers for allow rules, in addition to neverallow rules. Th=
is option increases the size
> +of the output CIL policy file, but the additional line markers helps deb=
ugging, especially
> +neverallow failure reports. Can only be used when writing CIL policy fil=
e.

Same thing applies here as well.

Everything else looks ok.

Thanks,
Jim

> +.TP
>  .B \-V,\-\-version
>  Show policy versions created by this program.
>  .TP
> diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
> index 2d6f2399..c9ff80cc 100644
> --- a/checkpolicy/checkmodule.c
> +++ b/checkpolicy/checkmodule.c
> @@ -119,7 +119,7 @@ static int write_binary_policy(policydb_t * p, FILE *=
outfp, unsigned int policy_
>
>  static __attribute__((__noreturn__)) void usage(const char *progname)
>  {
> -       printf("usage:  %s [-h] [-V] [-b] [-C] [-E] [-U handle_unknown] [=
-m] [-M] [-N] [-o FILE] [-c VERSION] [INPUT]\n", progname);
> +       printf("usage:  %s [-h] [-V] [-b] [-C] [-E] [-U handle_unknown] [=
-m] [-M] [-N] [-L] [-o FILE] [-c VERSION] [INPUT]\n", progname);
>         printf("Build base and policy modules.\n");
>         printf("Options:\n");
>         printf("  INPUT      build module from INPUT (else read from \"%s=
\")\n",
> @@ -136,6 +136,7 @@ static __attribute__((__noreturn__)) void usage(const=
 char *progname)
>         printf("  -m         build a policy module instead of a base modu=
le\n");
>         printf("  -M         enable MLS policy\n");
>         printf("  -N         do not check neverallow rules\n");
> +       printf("  -L         output line markers for allow rules\n");
>         printf("  -o FILE    write module to FILE (else just check syntax=
)\n");
>         printf("  -c VERSION build a policy module targeting a modular po=
licy version (%d-%d)\n",
>                MOD_POLICYDB_VERSION_MIN, MOD_POLICYDB_VERSION_MAX);
> @@ -146,6 +147,7 @@ int main(int argc, char **argv)
>  {
>         const char *file =3D txtfile, *outfile =3D NULL;
>         unsigned int binary =3D 0, cil =3D 0, disable_neverallow =3D 0;
> +       unsigned int line_marker_for_allow =3D 0;
>         unsigned int policy_type =3D POLICY_BASE;
>         unsigned int policyvers =3D MOD_POLICYDB_VERSION_MAX;
>         int ch;
> @@ -159,12 +161,13 @@ int main(int argc, char **argv)
>                 {"handle-unknown", required_argument, NULL, 'U'},
>                 {"mls", no_argument, NULL, 'M'},
>                 {"disable-neverallow", no_argument, NULL, 'N'},
> +               {"line-marker-for-allow", no_argument, NULL, 'L'},
>                 {"cil", no_argument, NULL, 'C'},
>                 {"werror", no_argument, NULL, 'E'},
>                 {NULL, 0, NULL, 0}
>         };
>
> -       while ((ch =3D getopt_long(argc, argv, "ho:bVEU:mMNCc:", long_opt=
ions, NULL)) !=3D -1) {
> +       while ((ch =3D getopt_long(argc, argv, "ho:bVEU:mMNCc:L", long_op=
tions, NULL)) !=3D -1) {
>                 switch (ch) {
>                 case 'h':
>                         usage(argv[0]);
> @@ -231,6 +234,9 @@ int main(int argc, char **argv)
>                         policyvers =3D n;
>                         break;
>                 }
> +               case 'L':
> +                       line_marker_for_allow =3D 1;
> +                       break;
>                 default:
>                         usage(argv[0]);
>                 }
> @@ -252,6 +258,11 @@ int main(int argc, char **argv)
>                 exit(1);
>         }
>
> +       if (line_marker_for_allow && !cil) {
> +               fprintf(stderr, "%s:  -L must be used along with -C.\n", =
argv[0]);
> +               exit(1);
> +       }
> +
>         if (optind !=3D argc) {
>                 file =3D argv[optind++];
>                 if (optind !=3D argc)
> @@ -347,6 +358,9 @@ int main(int argc, char **argv)
>                                 exit(1);
>                         }
>                 } else {
> +                       if (line_marker_for_allow) {
> +                               modpolicydb.line_marker_avrules |=3D AVRU=
LE_ALLOWED | AVRULE_XPERMS_ALLOWED;
> +                       }
>                         if (sepol_module_policydb_to_cil(outfp, &modpolic=
ydb, 0) !=3D 0) {
>                                 fprintf(stderr, "%s:  error writing %s\n"=
, argv[0], outfile);
>                                 exit(1);
> --
> 2.49.0.504.g3bcea36a83-goog
>
>

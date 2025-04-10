Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC96F28EA73
	for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312433; cv=none; b=WVDVBfHK9n0qhDuEALnRLgrqqmrv88Q9Bi7gEGaO9AKc3k1T7u+WDQ7CZ32/wv42CdXjGcvcNCT978RLn5XRyv7kr8L+Y/eQC0rS2RoUuAx/4FH+AMWVyadPNFhkQM6zYjRg34PqfHqdAzoioTNTmzLDxm5/+uiwnQ4tAljgYgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312433; c=relaxed/simple;
	bh=dI7uRmRV/uKAGiQfeElmgrJaPMyNMDXBHgMDJljHLVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sA8MeH+qRz5zFBA39zq7Ygmjhn+z1GYj/b3G364vwvv83fL7QJU4/dJuYRWqHOf1ZdM3trtGzPEoqNS4/7TDmTpcVf6g/lX1psjPVV+fexi4xDdfhAHzGmhjOVRDFHObCXWiqQ+WumNkUzxEzJ9gJ5lOKH9C0IJk0zz6RqZHPSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORbaXt2S; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORbaXt2S"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86fbc8717fcso466113241.2
        for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 12:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744312430; x=1744917230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ey3Htbb4vx7JWly7p5pXqnh9pI6eaJrM6/u0eXKLBMA=;
        b=ORbaXt2S8hgR+Mw52pQ6w+KHL3yIpJTBouN6iE1KSn8iODD8lQc3WFjSwjFWUxewqO
         IZayJ50R4mrUZMHkiXrZn6XsNGMNqzaRUXB72uyPv43bYm6ZS775Fzv8gHYBh4bS9d6T
         NW46o5toeBvGEjZpf9v5bKtd6Mrd/Ypw8Z0xBqC7NDirdAN15ULcRZ4jkCaUG02emrMi
         KcfVHZQUcFu7Qq25TZ/ShKt4Ygf5nYTfhij6cSGVpkEMjjewRQaQzWo/AUUMO+2/F74j
         iEm/eqA4s4lsCUFJuBg3++U9M5iYR6AJrBtiVwQ2BiddUjksdFkGCaeT9N7zYq7YPxEI
         Iw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744312430; x=1744917230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ey3Htbb4vx7JWly7p5pXqnh9pI6eaJrM6/u0eXKLBMA=;
        b=bVo340JJuEWXTr18mIzUQsO8r5uYLFFfdOyxFTGF1neAxjxUU/AOJrqa+4Y7dgUn0w
         rU9kimuLxzFC5KOmpa5fWwyFRvmNj9ROMcmYsU4fprM/3l24APRWtIvTVkQeg2sCuEEV
         UMONfC0wmuXxrkajCL58x8EbLfYx+enl12JCFH5HZUz789YDLCa6edZ6nM5j6tmsIyh0
         K5CU/0TffWigRV50wFGzFbUoWiz5hVJxrrwa2hQwQDOWCBxgv6mj051AQvl2ibarLsG7
         39a5OW6Pzp1/e93jOv6m4gDlvNTi2Xyt+ibdGl1SmmeAsF/+iKBbbmT5VAOZZD0Q1+zI
         xn9Q==
X-Gm-Message-State: AOJu0YxeCPOiSK7b1No6Ihdk98y7JghTAN8+CDxpLs8L2t165B4rBdco
	Ut4zj9FlHoHOA3Jgv7ZqJFRkdGvEuh9r+iPV9aa8HjJogGkWp+kzlQtHGuiMfRJhjPRW8OukvYa
	MDiGqK5uDK63LixpIExlUqXSneoY=
X-Gm-Gg: ASbGncsrj36Xy7WTk8EbPoU5MS4Y8dV+ZryH8HL9aGBQi8U8upBZ7hTdeF9GbcvRqmO
	9jG3NIizxn5tvqnt1ACp+uNRmpMvIPGg5goize+nR4+8LGeijtWOva0bK7ZC5SwCtRHTnynFKre
	teeAfHlJgNqMlKqZ0NxEs=
X-Google-Smtp-Source: AGHT+IHZi6Zi7aHABU6lLCu49DikF2wxwNTBfLtg5HAkqQNfJV1bsUcZB2LYb3b3c3VrN1oWQkyUlUiAm+QlUxB7vjk=
X-Received: by 2002:a05:6102:1622:b0:4c3:6a7e:c9f3 with SMTP id
 ada2fe7eead31-4c9d348c0a0mr3892712137.3.1744312430586; Thu, 10 Apr 2025
 12:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410021820.3874574-1-inseob@google.com> <20250410021820.3874574-3-inseob@google.com>
In-Reply-To: <20250410021820.3874574-3-inseob@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 10 Apr 2025 15:13:39 -0400
X-Gm-Features: ATxdqUFBEFPxjpby0EDigZ5WXVrHwMNXNaSKot9cYj4iNJ2X5IMdO_zMlyi4S7Y
Message-ID: <CAP+JOzTKjMjxgW0tirwnMdr4E-_rFTdi4ZxDHDEOdavszDvwmQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] checkpolicy: Support line markers for allow rules
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, tweek@google.com, jeffv@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 10:20=E2=80=AFPM Inseob Kim <inseob@google.com> wrot=
e:
>
> Using line markers for allow rules helps debugging, especially
> neverallow failure reports. But unconditionally printing them can bloat
> output cil files, so this commit adds an option to do that.
>
> Signed-off-by: Inseob Kim <inseob@google.com>
>
> Changes since v1:
> - Updated the checkpolicy.8 man page for the new flag
> ---
>  checkpolicy/checkpolicy.8 |  5 +++++
>  checkpolicy/checkpolicy.c | 17 +++++++++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
> index 81a3647d..b30d6ed6 100644
> --- a/checkpolicy/checkpolicy.8
> +++ b/checkpolicy/checkpolicy.8
> @@ -41,6 +41,11 @@ Enable the MLS policy when checking and compiling the =
policy.
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

"writing a CIL" instead of "writing CIL"

You also need to update the man page's SYNOPSIS like the usage below.

Thanks,
Jim


> +.TP
>  .B \-c policyvers
>  Specify the policy version, defaults to the latest.
>  .TP
> diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> index ede2b6ad..b808e4d0 100644
> --- a/checkpolicy/checkpolicy.c
> +++ b/checkpolicy/checkpolicy.c
> @@ -107,7 +107,7 @@ static __attribute__((__noreturn__)) void usage(const=
 char *progname)
>         printf
>             ("usage:  %s [-b[F]] [-C] [-d] [-U handle_unknown (allow,deny=
,reject)] [-M] "
>              "[-N] [-c policyvers (%d-%d)] [-o output_file|-] [-S] [-O] "
> -            "[-t target_platform (selinux,xen)] [-E] [-V] [input_file]\n=
",
> +            "[-t target_platform (selinux,xen)] [-E] [-V] [-L] [input_fi=
le]\n",
>              progname, POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
>         exit(1);
>  }
> @@ -390,6 +390,7 @@ int main(int argc, char **argv)
>         unsigned int i;
>         unsigned int protocol, port;
>         unsigned int binary =3D 0, debug =3D 0, sort =3D 0, cil =3D 0, co=
nf =3D 0, optimize =3D 0, disable_neverallow =3D 0;
> +       unsigned int line_marker_for_allow =3D 0;
>         struct val_to_name v;
>         int ret, ch, fd, target =3D SEPOL_TARGET_SELINUX;
>         unsigned int policyvers =3D 0;
> @@ -418,11 +419,12 @@ int main(int argc, char **argv)
>                 {"sort", no_argument, NULL, 'S'},
>                 {"optimize", no_argument, NULL, 'O'},
>                 {"werror", no_argument, NULL, 'E'},
> +               {"line-marker-for-allow", no_argument, NULL, 'L'},
>                 {"help", no_argument, NULL, 'h'},
>                 {NULL, 0, NULL, 0}
>         };
>
> -       while ((ch =3D getopt_long(argc, argv, "o:t:dbU:MNCFSVc:OEh", lon=
g_options, NULL)) !=3D -1) {
> +       while ((ch =3D getopt_long(argc, argv, "o:t:dbU:MNCFSVc:OELh", lo=
ng_options, NULL)) !=3D -1) {
>                 switch (ch) {
>                 case 'o':
>                         outfile =3D optarg;
> @@ -506,6 +508,9 @@ int main(int argc, char **argv)
>                 case 'E':
>                          werror =3D 1;
>                          break;
> +               case 'L':
> +                       line_marker_for_allow =3D 1;
> +                       break;
>                 case 'h':
>                 default:
>                         usage(argv[0]);
> @@ -535,6 +540,11 @@ int main(int argc, char **argv)
>                 exit(1);
>         }
>
> +       if (line_marker_for_allow && !cil) {
> +               fprintf(stderr, "Must convert to CIL for line markers to =
be printed\n");
> +               exit(1);
> +       }
> +
>         if (binary) {
>                 fd =3D open(file, O_RDONLY);
>                 if (fd < 0) {
> @@ -690,6 +700,9 @@ int main(int argc, char **argv)
>                                 exit(1);
>                         }
>                 } else {
> +                       if (line_marker_for_allow) {
> +                               policydbp->line_marker_avrules |=3D AVRUL=
E_ALLOWED | AVRULE_XPERMS_ALLOWED;
> +                       }
>                         if (binary) {
>                                 ret =3D sepol_kernel_policydb_to_cil(outf=
p, policydbp);
>                         } else {
> --
> 2.49.0.504.g3bcea36a83-goog
>
>

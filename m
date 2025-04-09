Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8CA1DB34B
	for <selinux@vger.kernel.org>; Wed,  9 Apr 2025 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744227415; cv=none; b=Gfjuq167OR11+Y87RMq6JEIRHVil9YRtsTUlTxKSu9PxM+fFyE0DnR+IazbWvAMQyxjH8Dex+EoFEnzdGQIyDsiYrqPuHhXkdDOOdSRW9g2KJ3ucw4aEegzcf/DYZQeIi4vjhJu60o56ck/SliamqDLCDkNSIIIcfQu5gS7tqvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744227415; c=relaxed/simple;
	bh=ylUDrX96PyxwIsahIN8dG0bixNLtopiXtFfiag7hklg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiTdZJtPQSI6BcIdTh34PWSmubNoe1WTlvbNx0CaUyoEklK6VAwhQ3XgKqJXKPSftEqX75AsH5wpp74/ybxsHmxzNPdSD6UQUqolAF7HKaM61zVvYYYUBctSVn50Gfu9m+5qlZtZEz4IcsBapXwjwkpYaHUwIpqIVUkTswVxqtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bq1WVlF0; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bq1WVlF0"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86b9d1f729eso3238298241.3
        for <selinux@vger.kernel.org>; Wed, 09 Apr 2025 12:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744227412; x=1744832212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BGGo6LqijS6fqkZTyK4nBiwkhs7q5qFaJbRKCNSovw=;
        b=bq1WVlF0l63nPDci8O7tb3+xd65k9p8hs3YVAVcLsrCdZVy0VLZSrn1hiujGR6p9XB
         kRhvU/6Yilghp+sCviMp5Zu7vpaLCtJ8TIlQmNIvO6d7xwhjVyQGWmeV8CAkBrw/AFSx
         t9z2hEV85gPYd8jIffJC0UpWm0S2RjKkUC+G/3mfcmcV77JoPd8Glz3dXgjGk3u5MunZ
         A/Wx9PPPa8hgfVw7k7p8ACSUIO9wQEE8zWAJ7Kcbjm/ph1ewvoMTyy9wdEYZDE6ae6ti
         SVVLTYKB2QWdwN6raPVyXZeLtLKP3IvCiPCVXm0vsNQ8GpwFthi1KXleoRsMUaA8efoX
         vaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744227412; x=1744832212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BGGo6LqijS6fqkZTyK4nBiwkhs7q5qFaJbRKCNSovw=;
        b=NGQL2lryti4caG104KiGeqX/BbeAU46rlPIL6MOFAtlDbF7vWwKJb4Is6aVKcfBw02
         PIc4NeffEa0tvwZOa07JMTxVqlnSIrr7MAmCkuMcWN46VK/wGHLw6RQ8jOe5dkXaNNGr
         aX6PwvvxX6KpcxHJQ1/Pl6IA5elYzVcBinOG7jv27+77SB+wyWusVHul+Vx40qo5FjvX
         ynnDOV+R3obkxVl0a1PtQTNv5te6RnUcnNis9GBjV9+6sa/ltpFnD158O7Q3y4CMs6Vc
         9/J3ih7SuvSlKdpQLhDUhiJimtc6V/GxJO/YV5oOTyChCTP5Dj49mU17AnwLJnStv+pN
         XjwQ==
X-Gm-Message-State: AOJu0YwwvQ88E8C99qy80tAN5P4SEK4V8F3YWuIuilAvkiI4OXHX0KQ+
	2eVigqevP+Q8HcZT/8ZInB0j44d1VuOZxMLzk+TPaF+Xvf72bFSlzffYlwjRyecfdiuLM1NRK44
	4fkcNdmYOTVibcEBiT1m4GNzgQP4=
X-Gm-Gg: ASbGncu1SFu+rBKp02zEPo1K1PMg99lWyuH+/GHW6nKV8nS636N/43i9dQ8E9aXxbeP
	TysKfiWogBUhL7bQTMfdGE298zIajL66ltjHzv1Gi40q4kgx8CAToavjMm74+8iWp7LHpw6FQGI
	G8c/JpxilvunRtRVGSTR8=
X-Google-Smtp-Source: AGHT+IGkysI8TgccgThl7ANcb3PaORIpE3AVpfUkmC5f6Bajhm25MRA9acBgWzp8wBV4JzE6LJZmHY8iTkYd/CaKHu0=
X-Received: by 2002:a05:6102:504b:b0:4bb:eb4a:fa03 with SMTP id
 ada2fe7eead31-4c9d3619c3cmr205150137.23.1744227412241; Wed, 09 Apr 2025
 12:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404120824.4146584-1-inseob@google.com> <20250404120824.4146584-3-inseob@google.com>
In-Reply-To: <20250404120824.4146584-3-inseob@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 9 Apr 2025 15:36:41 -0400
X-Gm-Features: ATxdqUE-7429veXu3swjfsCUjtIQ0--N-9aixNy2UGDT0OjQH4QGGY2MRle4-mI
Message-ID: <CAP+JOzTCsOz2W80BFdeATqc3cypJ7RSQ3BAkT+E6ow_-WdnUbQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] checkpolicy: Support line markers for allow rules
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, tweek@google.com, jeffv@google.com, 
	nnk@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 8:08=E2=80=AFAM Inseob Kim <inseob@google.com> wrote=
:
>
> Using line markers for allow rules helps debugging, especially
> neverallow failure reports. But unconditionally printing them can bloat
> output cil files, so this commit adds an option to do that.
>
> Signed-off-by: Inseob Kim <inseob@google.com>
> ---
>  checkpolicy/checkpolicy.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
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

The first two patches look good to me. The only thing here is I would
like to see the same option for checkmodule and please update the man
pages.

Thanks,
Jim

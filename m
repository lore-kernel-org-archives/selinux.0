Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDFE8480
	for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856470; cv=none; b=kiwDwUnfqz2wtrnOzIaMA3AfQj8FJxLNsENREVIFValOGSBUNryy5jbTmCnAm8P2owhHba/gIki6z8zBp1XhMVCKNVIPevJZsqHPKd2kKIsO5bhiucpcysbCkf+ZNYB+tdZHlSB+bda7OW2O8shTi/D0Kmhue3nuZH/8dm+KHyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856470; c=relaxed/simple;
	bh=I7aNasNOb1HKILUcz4HUOVhfMty1t2PFyQZCnwX7CNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGiI+ogb0B7ukimc/J5ixvVNnR6Ky5jU3Dw3sjAG65Z77Wa8s3qkziDuRab4tUOFTNq8KHIYTQRc5nmkxrqUDTol5H5X6zp6bgfLuqdjPirZIN5U2R3Jkxr0zdXnNwKMXLtCgfpbYocrDYmD4hdJJkG9S3xcQ8B59CQJYoe53eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNgxLjEq; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNgxLjEq"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7d2940ad0e1so2759475241.1
        for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 12:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707856467; x=1708461267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bP/gdmXdQUuHgNshn/9S598+DNk6faA7LdMK/sAqT6k=;
        b=SNgxLjEqGlV1pGByscYX1/KLo0fMglLP7roq9taMssud51HOMBeZOFDuOcWGuCbPkE
         xYUKkvVdBfyuy4jjbKrYPEjwutm3JyXk1gO9+BWsaaq6ltQ1f9Lsi7B0ZrCU9rdAaiKy
         VZuAHO/I0zQBTfGKxHm9OFpHHZjrwG4Bf6/8ngcMRyQoCaNspbDVtO2+JiXCob3cuJjA
         RKfjDfd/yq/SGA/ZUlg9zwZmJv6d9hlHK2kBf7Eev7fK6UIK9LItPObxwOFBe7qy3pej
         habOSczKF80C+ZmjT7Tuu599x6yOtrJZHXOEUqmpvCyKgJ8+kZ+KPbdBlZ5wnA/INUps
         dqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707856467; x=1708461267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bP/gdmXdQUuHgNshn/9S598+DNk6faA7LdMK/sAqT6k=;
        b=TfF8DxAAO7lrqyTH2D+8P/kdjH03bC9G++02fPDdjQRaqR2VZkogmd41j27kmJMTI3
         bp793LF1lLyyhckRzAq1KsH0tYG+f7MotVtjC0HsMy9yPcG1Xehd7BR71BRcz17/gMvJ
         t+0nY3rtiRAFKpPj8ZFLh59+dE0VwCjCwUC/ugy2LoVezCF+LYdg3ICvYat6QsmbB5sv
         qun7B9sq24Xh0+oVdR+LFvPkX3i/Z2CIk971dvN4TXDWdy/6xSyuY+EcXYNmvxfxgwB5
         UsRzODvpRvF80BvddNjZxa7v7XgXVGJaD5ZQGrIRelR6Ka9XUm7HlHL73U71SgjRnj0z
         QtVA==
X-Gm-Message-State: AOJu0YxoG6RKmLe9doXNEOO8hkbNnHZUHbmJorxWQRkJ1oxvdqvZqalJ
	6be0ISBWooi8+OV3w3ppWpxsGpmGUUAl6YIFID9Zt6dL1yFaOVX27Gy+4aLgcawUjsrmXaaux2o
	c0FjDdAAjSw3JTfRfizIJ9NBfhGLzpWrV2WM=
X-Google-Smtp-Source: AGHT+IFLQ9ICFWXlmPc1Mehd9FC2ijN9MjoeC0whNUFjhJ8zfDrjAMM1vEMqPozMFuDCnu8ZIBD7vaR6Dj8tw7p4bG4=
X-Received: by 2002:a05:6102:236d:b0:46d:246e:93d3 with SMTP id
 o13-20020a056102236d00b0046d246e93d3mr514100vsa.17.1707856467367; Tue, 13 Feb
 2024 12:34:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com> <20240122135507.63506-2-cgzones@googlemail.com>
In-Reply-To: <20240122135507.63506-2-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 13 Feb 2024 15:34:16 -0500
Message-ID: <CAP+JOzQa7g-r1d9ogf2u3C8ht4Uf8x0HLLnFDtHWUSYuqKojoQ@mail.gmail.com>
Subject: Re: [PATCH 02/15] checkpolicy: cleanup resources on parse error
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 9:02=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Close the input file and free all memory by the queue and lexer on a
> syntax or parse error.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/parse_util.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/checkpolicy/parse_util.c b/checkpolicy/parse_util.c
> index f2d1e04d..eda814e1 100644
> --- a/checkpolicy/parse_util.c
> +++ b/checkpolicy/parse_util.c
> @@ -26,6 +26,7 @@ extern FILE *yyin;
>  extern void init_parser(int);
>  extern int yyparse(void);
>  extern void yyrestart(FILE *);
> +extern int yylex_destroy(void);
>  extern queue_t id_queue;
>  extern unsigned int policydb_errors;
>  extern policydb_t *policydbp;
> @@ -34,6 +35,8 @@ extern void set_source_file(const char *name);
>
>  int read_source_policy(policydb_t * p, const char *file, const char *pro=
gname)
>  {
> +       int rc =3D -1;
> +
>         yyin =3D fopen(file, "r");
>         if (!yyin) {
>                 fprintf(stderr, "%s:  unable to open %s:  %s\n", progname=
, file, strerror(errno));
> @@ -41,21 +44,26 @@ int read_source_policy(policydb_t * p, const char *fi=
le, const char *progname)
>         }
>         set_source_file(file);
>
> -       if ((id_queue =3D queue_create()) =3D=3D NULL) {
> +       id_queue =3D queue_create();
> +       if (id_queue =3D=3D NULL) {
>                 fprintf(stderr, "%s: out of memory!\n", progname);
> -               return -1;
> +               goto cleanup;
>         }
>
> +       mlspol =3D p->mls;
>         policydbp =3D p;
>         policydbp->name =3D strdup(file);
> -       mlspol =3D p->mls;
> +       if (!policydbp->name) {
> +               fprintf(stderr, "%s: out of memory!\n", progname);
> +               goto cleanup;
> +       }
>
>         init_parser(1);
>         if (yyparse() || policydb_errors) {
>                 fprintf(stderr,
>                         "%s:  error(s) encountered while parsing configur=
ation\n",
>                         progname);
> -               return -1;
> +               goto cleanup;
>         }
>         rewind(yyin);
>         init_parser(2);
> @@ -65,11 +73,15 @@ int read_source_policy(policydb_t * p, const char *fi=
le, const char *progname)
>                 fprintf(stderr,
>                         "%s:  error(s) encountered while parsing configur=
ation\n",
>                         progname);
> -               return -1;
> +               goto cleanup;
>         }
> -       queue_destroy(id_queue);
>
> +       rc =3D 0;
> +
> +cleanup:
> +       queue_destroy(id_queue);
>         fclose(yyin);
> +       yylex_destroy();
>
> -       return 0;
> +       return rc;
>  }
> --
> 2.43.0
>
>

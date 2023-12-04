Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPuYDZs2"
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90CDAC
	for <selinux@vger.kernel.org>; Mon,  4 Dec 2023 11:25:06 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50be03cc8a3so3889162e87.1
        for <selinux@vger.kernel.org>; Mon, 04 Dec 2023 11:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701717905; x=1702322705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kG2hQ9E9jqDFUR5mBDnJjapcwWQ/Bnq/H9Ht8BXha8=;
        b=KPuYDZs2uu5UVcxH7oeVgucc+YwAhJzBVgQunH2dUSJA4gWGEfObFPsmW3IzCE/rfO
         aJWKDKpRBT+7ZIyTGSGDuNNyNCI0Kziv1A89WGxsKB1UhUYsK56m1rwZ2Dqaqk4rYd3P
         UYIyOAFsOfuOUfwd3BBvu0SrnvS5CVramPqCEqeRfcZO54zixlqVeDM2qxEuwltGFK34
         T86DMD7l/PREDNkBGGWxQX+1AxQOFaVDeug6KGWcHrKknrLqB18GbeAee9B+irH5q+M/
         /sj8XvR1O7ZUOc7z7XTVKWtPsevxltbwsE+jWNyCMKY2RUGykW0sFoNhZfoUDnJHvo3T
         Da0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701717905; x=1702322705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kG2hQ9E9jqDFUR5mBDnJjapcwWQ/Bnq/H9Ht8BXha8=;
        b=V9CQCwa+7mq2haC32YybL5LEjUYpzP3oVDQFC5yXWAtz/l9EUupaRXK05mhib0lF37
         WaCa6XJC7pJDJ7jfN3EOE0Zg5q4BLWdGVQPz1gXD7g56CH2hen7MiNykrU4HYrr4zNvY
         9mu+eFIP+mtAurb5sYXBHLpZbcsZAzhBuEzHI5f4vxCFoxgwGW0jU6ooGH9svf3B3ns/
         r8PcAirj97ofb8pZGqrrkGdkAJmRZRD36F8ZkQR+cAOLEXAj7mvUMM11IHmCBkoEpN2x
         q8qFH76i0x9O/UbigfIK8PTJYmN2+BRqnMP+VZ7e5KZNze2dIAn7gn46dKB05MOtDbpx
         rjhA==
X-Gm-Message-State: AOJu0Yy0Dwi/senQp//HiB5bwawt6uOJYtsQhYTVV+9cvtaq9zW/DR/a
	GW/0IIKefhbQyi+9SS/pzORQ1Qw+eDvKoDjz7pk=
X-Google-Smtp-Source: AGHT+IHo0RNkUnYhw6w9lcABCx07q20pNIGd61enWluCOGPHzNGWgl0ejlNLgvejCxI56m15F04H6Femtxfng5sEY2c=
X-Received: by 2002:ac2:4e84:0:b0:50b:f305:867a with SMTP id
 o4-20020ac24e84000000b0050bf305867amr1186069lfr.138.1701717904649; Mon, 04
 Dec 2023 11:25:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204161655.1349063-1-slyich@gmail.com>
In-Reply-To: <20231204161655.1349063-1-slyich@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 Dec 2023 14:24:53 -0500
Message-ID: <CAP+JOzRLtgvOjFYveZ6F9_Z8j0Jv4oWh2qM1WCdPnzL6i1hqiw@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: fix src/genhomedircon.c build on `gcc-14` (`-Werror=alloc-size`)
To: Sergei Trofimovich <slyich@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 11:17=E2=80=AFAM Sergei Trofimovich <slyich@gmail.co=
m> wrote:
>
> `gcc-14` added a new `-Walloc-size` warning that makes sure that size of
> an individual element matches size of a pointed type:
>
>     https://gcc.gnu.org/PR71219
>
> `libsemanage` triggers it on `calloc()` calls where member size is used
> as `1` (instead of member count):
>
>     genhomedircon.c: In function 'ignore_setup':
>     genhomedircon.c:152:21:
>       error: allocation of insufficient size '1' for type 'ignoredir_t'
>         {aka 'struct IgnoreDir'} with size '16' [-Werror=3Dalloc-size]
>       152 |                 ptr =3D calloc(sizeof(ignoredir_t),1);
>           |                     ^
>
> Signed-off-by: Sergei Trofimovich <slyich@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/genhomedircon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedir=
con.c
> index 8f8774d3..66585987 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -149,7 +149,7 @@ static int ignore_setup(char *ignoredirs) {
>
>         tok =3D strtok(ignoredirs, ";");
>         while(tok) {
> -               ptr =3D calloc(sizeof(ignoredir_t),1);
> +               ptr =3D calloc(1, sizeof(ignoredir_t));
>                 if (!ptr)
>                         goto err;
>                 ptr->dir =3D strdup(tok);
> --
> 2.42.0
>
>

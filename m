Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A12C9D
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759765519; cv=none; b=hVF7gDVaew9EcgodSn4kTbwEDpX5Dt3NyhdfFlHTKivppG6g3RR9IjzR+vJ4uNoslGxlNqXzvYxcZ0FbPeuPdrQ/1b30fRtyLlvwgxoxRM/kQH87Pn+vTxUfPHs/nnQE7cwustGKWbSJLC4Sf2BjGOXWbzwpMsof1qOV4APA6MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759765519; c=relaxed/simple;
	bh=hdsJFDsqdMsshfNndEJcIIa8Wbt0uRXbhmTspGUolTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXjiKs/BbKHgQuMZppwCu1eTKpDuVguY8koxFBOT8nFOSclrKBDNDz3LuAQHZ0EvXKrjrWOKewIjpdeq9rlqGjB4eXHmxcGIb/GM0FeZoHOG80OMwLmrodEwE/w9QP3d/j8oLqUA+D+oQDYMwHKXH7D8eR7bk+xEcr9vxjTge8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kI9SeE3a; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kI9SeE3a"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3306d93e562so5590202a91.1
        for <selinux@vger.kernel.org>; Mon, 06 Oct 2025 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759765516; x=1760370316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgQL61rOpZmTPEXJ2/fczW62Z+Lxb+IJnKp0A0AJ/pg=;
        b=kI9SeE3aFo2yUCLWmpkkWfqT2rRU5yLO2LBMMiV/uVoOt0Gqp04DqJl3qIt7BT/UxI
         uFr0htBa3SZyED06O/A3iUH7W22aL9k4Y6Qkz7aslXFvrJ+Se/8l7XP+IfWas4Fq6E8z
         ZlrwtNWj5qZci7yPWc/7mLH7zMuDb10bEuBE93Lw32HnSrvwM+xGKdtjsEqss0hpxspN
         w0kjZJ9wQARfhl9a4TkKKTThleQRBSK4nztAdDOIzmwo9rzpB+B0q5NNSneoGDogWv5s
         55qyl8xAMms9XerP5oU30J15CI12OtUO0g2L37NQV7bxho4MQuJY0qnVUqLYu2CXsezT
         sVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759765516; x=1760370316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgQL61rOpZmTPEXJ2/fczW62Z+Lxb+IJnKp0A0AJ/pg=;
        b=c0FLsoG/d/ywChpBAjjqG4bAUUKV56yixLUAp4Zv72K8dVOJI+iXmRCGprhTqiCD8S
         7Nc+fQwuHcMoKRosfeNSQZlfqhWepafYulcflXlPqy3iHS383Kl4ixHIST30yPDgwexx
         7y5G/vCBvw/4R/uodIvn/bdt5uxbrrdH3+fdyYPgkGA+VSMG+Z5TO0ViwZZXJQMVcCNq
         Xl46sp8pQGDFxwmabZr4qQ4xNUPY1zA+Ryusmj0Mk7hVn/7LhIsijbUCpfI8MHoa7naR
         j00Emd2GbQ0lKc3EwXvLo9dm0Fyd6Vv7xuYXmyyCQ+BSat5z7iw9w4XdYvlZUc9mf08U
         N+vw==
X-Gm-Message-State: AOJu0YwOKbP/vTjCrFNsMa45UwNRsMxWuzK2Ee8deyi1GUdR/L4TSB58
	2kU/JR7Sa18ILCBFXLZQYhLO2wMufpMbebLbC+HfBt4l+7iN6MYDwOyZSHN313nVSFt+jvyEoYx
	GDBOwZrUXyUKC5AER49nsPmTd0JWZsf0=
X-Gm-Gg: ASbGncueyNWlr/TQMvsBsQxCph5n+p6sD5N3zImu5UfBU8colJbR+MxcEdQ7YZ5NkRF
	ZY8Iy7MfthESsamfHRKYoRFfgtKzHsQO2on7GB9giQBJcubPUiEUwNx0syePcI69Hrf3yI09aPA
	NOnOwOfHC6HcnWEMF5Xm8onEv5kCrRQI30MU5NfE1LA6ykeoQJzYGPjy9ntjUApCfTzsVdXGnho
	U/cUwyjtizrz444E2evbU8ncGUi/jdS9nyprKeEuQ==
X-Google-Smtp-Source: AGHT+IH5xayJGifksIeE1zAePvfRFDQIeVp2MiSIgctKfqgvna++iEvcZP7NevK64oqFECG/sCqc4zIwX83GfV+V/VM=
X-Received: by 2002:a17:90b:1d06:b0:329:d8d2:3602 with SMTP id
 98e67ed59e1d1-339c27a2b9fmr17725481a91.17.1759765516070; Mon, 06 Oct 2025
 08:45:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ60msaQXmD3kWOPoLb-=Fx1WK2TdGObpg+Vq40-yJEfTw@mail.gmail.com>
 <20250801174527.1203687-1-nvraxn@gmail.com>
In-Reply-To: <20250801174527.1203687-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 Oct 2025 11:45:03 -0400
X-Gm-Features: AS18NWB5Pr-KmRekxoN-qYNvxkjCRDplbeG3F2dgSylW8hOdJSd3vKXanlg6dZ4
Message-ID: <CAEjxPJ46APV=OOBEqBLORJ3eHEC10P=eH1=SS3fK6BCGwpxu7g@mail.gmail.com>
Subject: Re: [PATCH v3] libselinux: refactor selinux_check_securetty_context
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 1:45=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wrot=
e:
>
> Invert the checks for fp and con.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  .../src/selinux_check_securetty_context.c     | 69 ++++++++++---------
>  1 file changed, 36 insertions(+), 33 deletions(-)
>
> diff --git a/libselinux/src/selinux_check_securetty_context.c b/libselinu=
x/src/selinux_check_securetty_context.c
> index 7609752e..bf61f53d 100644
> --- a/libselinux/src/selinux_check_securetty_context.c
> +++ b/libselinux/src/selinux_check_securetty_context.c
> @@ -8,45 +8,48 @@
>
>  int selinux_check_securetty_context(const char * tty_context)
>  {
> +       FILE *fp =3D fopen(selinux_securetty_types_path(), "re");
> +       if (!fp)
> +               return -1;
> +
> +       context_t con =3D context_new(tty_context);
> +       if (!con) {
> +               fclose(fp);
> +               return -1;
> +       }
> +
> +       const char *type =3D context_type_get(con);
> +
>         char *line =3D NULL;
>         char *start, *end =3D NULL;
>         size_t line_len =3D 0;
> -       ssize_t len;
>         int found =3D -1;
> -       FILE *fp;
> -       fp =3D fopen(selinux_securetty_types_path(), "re");
> -       if (fp) {
> -               context_t con =3D context_new(tty_context);
> -               if (con) {
> -                       const char *type =3D context_type_get(con);
> -                       while ((len =3D getline(&line, &line_len, fp)) !=
=3D -1) {
> -
> -                               if (line[len - 1] =3D=3D '\n')
> -                                       line[len - 1] =3D 0;
> -
> -                               /* Skip leading whitespace. */
> -                               start =3D line;
> -                               while (*start && isspace((unsigned char)*=
start))
> -                                       start++;
> -                               if (!(*start))
> -                                       continue;
> -
> -                               end =3D start;
> -                               while (*end && !isspace((unsigned char)*e=
nd))
> -                                       end++;
> -                               if (*end)
> -                                       *end++ =3D 0;
> -                               if (!strcmp(type, start)) {
> -                                       found =3D 0;
> -                                       break;
> -                               }
> -                       }
> -                       free(line);
> -                       context_free(con);
> +       ssize_t len;
> +       while ((len =3D getline(&line, &line_len, fp)) !=3D -1) {
> +               if (line[len - 1] =3D=3D '\n')
> +                       line[len - 1] =3D 0;
> +
> +               /* Skip leading whitespace. */
> +               start =3D line;
> +               while (*start && isspace((unsigned char)*start))
> +                       start++;
> +               if (!(*start))
> +                       continue;
> +
> +               end =3D start;
> +               while (*end && !isspace((unsigned char)*end))
> +                       end++;
> +               if (*end)
> +                       *end++ =3D 0;
> +               if (!strcmp(type, start)) {
> +                       found =3D 0;
> +                       break;
>                 }
> -               fclose(fp);
>         }
>
> +       free(line);
> +       context_free(con);
> +       fclose(fp);
> +
>         return found;
>  }
> -
> --
> 2.50.1
>

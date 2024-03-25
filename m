Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614D917995
	for <selinux@vger.kernel.org>; Mon, 25 Mar 2024 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393846; cv=none; b=i38ji/JsmCHdyY9unsNES4BGjRdJ8w7yCclDP3/Uc7qz87Lv6f12EvKKzIX9M33BcKIZwgFlkmRAgetnW7wktw9+PllEsQ9XXQMJiPJM/79q63l/BfeYlIazn7/nt/48VwS/lA3TlDzPOE3goMPZquzqoiZExJIeP65H+njUHk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393846; c=relaxed/simple;
	bh=akQ+B57kuL66X+I4wJDGCezQZcVoaQpDxb3BAHre4zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4IEm71oL6qKXvR8xQSMXofGksFeMAVJ2AZ2+sZd7KpBfZBmodLbeQhMNABToHAF2vMP0RfGyqwIFjT8F2sFcwzmYIDcI7/CWQLIB6Bxuv4H9r+ckJi2VLVjXHKy8+a2FKb39b73NJI8ycxjSGx2A2PX36HqypILLgM7s53LgQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8APqD4U; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8APqD4U"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso4679079276.3
        for <selinux@vger.kernel.org>; Mon, 25 Mar 2024 12:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711393843; x=1711998643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Akym7T65Onf87BFHyqI8mLMqokFfKJIIxC9/lMs0ktw=;
        b=k8APqD4UQ5U/rqU7pp28qR6/Cmg993lKSeYk1x79ed3YeBwixpbM13dehLq+jRLgBx
         NzFheViA4/q0RAkmAvefwsXpG8lMYrcYPeTWTDZ6zpXrt7cAYkfGG8I6XXgjFaov3rTZ
         42Cg+vs+k81WjK+W1t2HeZG7BD8UbdDqIZZ30ZP6KPuCqoiY6h49lWh/roch6PGifCLT
         7Jfwkp5FZlwPQHaTFUx54O+XFhd++yPo2hIYKPrxYqbxzdCe3R1c1hzo/DNVZM7FHvD9
         EVIaSYD1gdexaEM64g6X5mGXkdlalTfnpGx17hS37e3MoSfFO/uizaJVMr/SecXHtUMQ
         okLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711393843; x=1711998643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Akym7T65Onf87BFHyqI8mLMqokFfKJIIxC9/lMs0ktw=;
        b=rkFeYsCpu/B2mrzu0hI2IxXg1NkiGWoYFvMNK9ZvbvTaJxpg+Me8bpWzflJ+ehangt
         VzzZc6+HPSJK16Jh8IBfHsu20J0ccO1dkNddEEU30J1zs2Ev6tML2TZ5aos+qJnD0xF4
         dl4P/zJt/gauE3QLlF+u3Shv4jTJdJ/wv6k9qr8wlyNGcwgWO9AcNTGaPsBUUB4qtP9U
         Zvz1ItCVK2OBpVC59xmykrr7AY0bm99Z+MeRks2cklXbEs/fmz3+eadlVACvuVmMNKXi
         +XcTdOo8aNhAWPqUrD4cqr6xD/T2ueMdSOoEZ5CdI5vRo3XES2Fph7cetTNnfClbxHLA
         SC4g==
X-Gm-Message-State: AOJu0YwKD6aI60AJ26RXvHiWDxYvipDw/LyOHl20Hpcz8mq3iBPtRSPJ
	f/4HaWQ6MP/4G/wbMhcwmbZ995mgmnA8I6tcWwhzsfHO1+niR2WlFfyeMTsHZ4FYnAyjgv49LqI
	/hRtWWVl3F9OCArrV1J1xynimlN4=
X-Google-Smtp-Source: AGHT+IFMWpWjSkFCYlo0IJEO+aG8nQ/081ZEsYpdu/0Iu9WDZCNd3owCGhaDRzdrbl5xs69urF4rZbKSncT2xXVXRrY=
X-Received: by 2002:a25:2e0a:0:b0:dc6:2152:3889 with SMTP id
 u10-20020a252e0a000000b00dc621523889mr5711660ybu.7.1711393843326; Mon, 25 Mar
 2024 12:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322145019.60220-1-cgzones@googlemail.com>
In-Reply-To: <20240322145019.60220-1-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 25 Mar 2024 15:10:32 -0400
Message-ID: <CAP+JOzSdKAkRSHqN9jd=f8Thj3a316yRheExf4od90N3iQ4TTg@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: avoid logs in get_ordered_context_list()
 without policy
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 10:59=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> If no policy has been loaded yet and thus the current context is still
> "kernel" avoid logging failures in get_ordered_context_list(), like:
>
>     get_ordered_context_list:  error in processing configuration file /et=
c/selinux/debian/contexts/users/root
>     get_ordered_context_list:  error in processing configuration file /et=
c/selinux/debian/contexts/default_contexts
>
> Move the context parsing from get_context_user() to its caller
> get_ordered_context_list(), so an invalid context is not treated as an
> get_context_user() failure and not logged.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2:
>   - move the context parsing from get_context_user() to its caller
>   - add Signed-off-by
> ---
>  libselinux/src/get_context_list.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_conte=
xt_list.c
> index 7e23be05..0ad24654 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c
> @@ -130,7 +130,7 @@ static int is_in_reachable(char **reachable, const ch=
ar *usercon_str)
>  }
>
>  static int get_context_user(FILE * fp,
> -                            const char * fromcon,
> +                            context_t fromcon,
>                              const char * user,
>                              char ***reachable,
>                              unsigned int *nreachable)
> @@ -146,7 +146,6 @@ static int get_context_user(FILE * fp,
>         char **new_reachable =3D NULL;
>         char *usercon_str;
>         const char *usercon_str2;
> -       context_t con;
>         context_t usercon;
>
>         int rc;
> @@ -155,14 +154,10 @@ static int get_context_user(FILE * fp,
>
>         /* Extract the role and type of the fromcon for matching.
>            User identity and MLS range can be variable. */
> -       con =3D context_new(fromcon);
> -       if (!con)
> -               return -1;
> -       fromrole =3D context_role_get(con);
> -       fromtype =3D context_type_get(con);
> -       fromlevel =3D context_range_get(con);
> +       fromrole =3D context_role_get(fromcon);
> +       fromtype =3D context_type_get(fromcon);
> +       fromlevel =3D context_range_get(fromcon);
>         if (!fromrole || !fromtype) {
> -               context_free(con);
>                 return -1;
>         }
>
> @@ -296,7 +291,6 @@ static int get_context_user(FILE * fp,
>         rc =3D 0;
>
>        out:
> -       context_free(con);
>         free(line);
>         return rc;
>  }
> @@ -418,6 +412,7 @@ int get_ordered_context_list(const char *user,
>         char *fname =3D NULL;
>         size_t fname_len;
>         const char *user_contexts_path =3D selinux_user_contexts_path();
> +       context_t con =3D NULL;
>
>         if (!fromcon) {
>                 /* Get the current context and use it for the starting co=
ntext */
> @@ -427,6 +422,10 @@ int get_ordered_context_list(const char *user,
>                 fromcon =3D backup_fromcon;
>         }
>
> +       con =3D context_new(fromcon);
> +       if (!con)
> +               goto failsafe;
> +
>         /* Determine the ordering to apply from the optional per-user con=
fig
>            and from the global config. */
>         fname_len =3D strlen(user_contexts_path) + strlen(user) + 2;
> @@ -437,7 +436,7 @@ int get_ordered_context_list(const char *user,
>         fp =3D fopen(fname, "re");
>         if (fp) {
>                 __fsetlocking(fp, FSETLOCKING_BYCALLER);
> -               rc =3D get_context_user(fp, fromcon, user, &reachable, &n=
reachable);
> +               rc =3D get_context_user(fp, con, user, &reachable, &nreac=
hable);
>
>                 fclose(fp);
>                 if (rc < 0 && errno !=3D ENOENT) {
> @@ -451,7 +450,7 @@ int get_ordered_context_list(const char *user,
>         fp =3D fopen(selinux_default_context_path(), "re");
>         if (fp) {
>                 __fsetlocking(fp, FSETLOCKING_BYCALLER);
> -               rc =3D get_context_user(fp, fromcon, user, &reachable, &n=
reachable);
> +               rc =3D get_context_user(fp, con, user, &reachable, &nreac=
hable);
>                 fclose(fp);
>                 if (rc < 0 && errno !=3D ENOENT) {
>                         selinux_log(SELINUX_ERROR,
> @@ -472,6 +471,7 @@ int get_ordered_context_list(const char *user,
>         else
>                 freeconary(reachable);
>
> +       context_free(con);
>         freecon(backup_fromcon);
>
>         return rc;
> --
> 2.43.0
>
>

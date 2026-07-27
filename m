Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CD9246770
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159016; cv=pass; b=P0YUu8ib9brl2FTyKXp5uiZM4cH0t/ym0cTcFGTE3EJR4bVlpP5MeUAboT+GiRy5VuR8T/67wMJfG+19klLw3Uhf2QfzQo/k+iMV5IYkQDg6YnsxSOni3QNGDW7fw/BAarCqkO1LfSNK6pm13pfuUwuzu5Y/Rzs4UFXpprnI1Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159016; c=relaxed/simple;
	bh=ni2lUmY0rmOts+PJarEjWr8fTKDJjw67NxD4cWWSuXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nf/1SShBTxu279DdZldkRr10XobLQIi+OzdcgcvyS4yvsDVR+IWc/JHQjGGTzueNf8y+rNAPHgfh8wIyNuRNzuE2m7JqS+onFodIK7MbrDcJ8hHGYRRlxoSh7s9m10aayCSVAbDdXqBRaz7zNr4qUswZWIfuG7BPjUaH+AgmRmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aG0pS0pu; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aG0pS0pu"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-45133d2974fso2272486fac.1
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 06:30:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785159012; cv=none;
        d=google.com; s=arc-20260327;
        b=YrWFoG8S9plwZkazDitAJZuO3Et3hXmgmhOpFpl+L4uEsx+gLMlz0TnDpYAwiw8EII
         YErXtDNe7ixnM8c9WyBaPDcgEyEVmJ3aUbUQxHP+uFgBntgcesnoGiXy/1NGyn8lO/yd
         G5eQ4vZcduC67L8hvxPiDqR5w2/1qh5lptXMILOdznVojJScub4tjSFV47ueyTV9BPPW
         NYOQdfBg4ojTC+lg854c0dd16de5U9MwtPlRwvLUcFk8lT7Uaylz5uCymUl96rjjVNyr
         h1f6ZFNZ7mZ6bOFlp7AN2+tavwpwzndJZSXH0PpZEAIyqeuKA4LKJ57MzIbKOH9t5/mK
         3vVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WTL9AWiPCgDZ4UYtURt9A4WzWtgj4qOOX6PmRXzUGDY=;
        fh=mMDxYY5wtlIekXoYIfjt6lvMWgTaMUwdwgsYDQ6qy3A=;
        b=IWmM4RHNG95GjGva9UL8WN0GwVs3/mE/tgluMim07rYs1/mwLS9fDkjFviWUm+4+x4
         GPWHeIFk6wzahK0sG1OqvKQmjdQGfTNymb/NHbHF69IIETQw1DT7IchiM4y2AGVL7Uqn
         wzozuCtiSu5pSFx5ssz4bNPqY2mSWbZcW6cYRbAQcxFWTbR3l6P/aAS0IEy7eyRtjwyO
         43UA/2JlteZ7cFYibVWBdRX7jKXbo0c+uMpaV9fc060R3RvMo72aAKkX0tKPUU9HNGnz
         TGpvpUIR459qnmzV7sdkImWIMZ5FW6xOSTixiIBtJ2Sl+yJzVUWivzmaa7t+XumewI/f
         yd8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785159012; x=1785763812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WTL9AWiPCgDZ4UYtURt9A4WzWtgj4qOOX6PmRXzUGDY=;
        b=aG0pS0puoruxSz4mVMMaOtvUvAGMqfsbetFNb7BSE2XIB1U8VCjHF/Dy2zf5P3IGVg
         hf+xz+peQnrvpMrzHQZWpRrdKAG03mIBEGREKMTx2w53mnnUTR0imlo2tMkP5IKMc6FF
         Nrl/XEse+NUPSo226R+H65uX5CE4MAzMUmwUwXGYpYfWuMWTwTQYUCwNpJeekjmXMCyc
         yDqf2wuXMYeKCT9NL3BrysF6EBf7gAzSE3/s5HE+aw/u9LbEi34SpuPCpGRvUfmtP9Ec
         DOGJtqkJdhCpPxIP+UdVdrxhO12Bl5+9hkiKE5BbyRnMLgDjWlsO1PDXSy7cIJVHubpm
         OR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785159012; x=1785763812;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WTL9AWiPCgDZ4UYtURt9A4WzWtgj4qOOX6PmRXzUGDY=;
        b=p+Im+S5v1arc00/qcPseg/SE39B3IJCo6LcgmJrws6cfowvnmoo7pn+YN/06RJNnpu
         Z6TpssEmpZ0uCX9MevNE0rEXtRwt3uvT9PcRD5/7SHRgeby3Ovd1vh0FUjdTYZhos5OV
         bjBhbnNOyRX7y/6C+dbM7Ad13/1mGAnQi1aOnXS7fGW2+Rq/EqF3lpsIADoT+XVeerFp
         JksiW3F02xjBVScX9VfPOS1XdVmiwb9EZV6Aja9ZY1TErJhRoDn76F32ttUJNq5QyayF
         9OjAaIrHFE9qbWmroiZtKvXbN5i+XHaSr3bt5jZZxyHhx0jRwdNDgyamGzz15Q609R/v
         YC+Q==
X-Gm-Message-State: AOJu0YxI46OcdHbxB8ugKjBR1HkXCdGg7/4Cw3CQbM8R9xlymzsLo/en
	Q1YLYqzSh20VAkFXm2yB2Shobcqn0zWmrWu9L9Jy0s5LaKhOoCxRPxFRSAKtVr7iD4ZQ3y0hEzX
	wiRmKfqgIcGt35+NvFsaHb0RnJQAlCWU=
X-Gm-Gg: AR+sD12iQpYGDhvbkJN5jYeQEyD1cDnqkdkdMWQcrO/WF8o5nwCB8xFA9aGjeiV5qde
	n3DJAlEDRpiV8ipZjDgJrpIbobPKwpKzAJOXX/bxDRCloKTZpHRi15c3xDg8GeRI+4niZqiZ4Hw
	47d33hF5jVp9aMDePhB0nESJ+egT2u36yxkgmapy+m4LFsQSpHsKN47hyA0gOQV2WAQcbNFauzT
	URlT+8KNErRnhPIkHVvn5sZc2jHW1KQBHbri52/LnlcJrPwV+NIc/ObPMM7KA==
X-Received: by 2002:a05:6870:a116:b0:447:2ca4:918 with SMTP id
 586e51a60fabf-457f278c8ebmr7193290fac.33.1785159011650; Mon, 27 Jul 2026
 06:30:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727013929.2457799-1-tweek@google.com>
In-Reply-To: <20260727013929.2457799-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Jul 2026 09:30:00 -0400
X-Gm-Features: AUfX_myHIc7tdbRUfi1Au_N2z7JSe73-1DOc5pzvoz5k2PTB409mK4n5yGPipDM
Message-ID: <CAEjxPJ5vH0qm8_RduSnOX2EU_2fz-zAoCPNLsETdXf5X+NUOfA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] libselinux: support multiple spec_files
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 9:39=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
>
> Update the existing backends to potentially allocate multiple
> spec_files. This commit simply adds a level of indirection but does not
> change any current behaviour. It will facilitate the gradual migration
> of backends to multiple context files.
>
> In selabel_fini(), compat_validate() is updated to use the first
> spec_file only, for legacy validation error reporting. selabel_open() is
> already performing context validation if requested against individual
> file paths (see insert_spec).
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

You can keep Acked-by/Reviewed-by/Tested-by when the patch is unchanged.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> No changes since v2
>
>  libselinux/src/label.c          | 10 ++++++++--
>  libselinux/src/label_db.c       | 11 +++++++++--
>  libselinux/src/label_file.c     |  8 ++++++--
>  libselinux/src/label_internal.h |  5 +++--
>  libselinux/src/label_media.c    |  8 +++++++-
>  libselinux/src/label_x.c        |  8 +++++++-
>  6 files changed, 40 insertions(+), 10 deletions(-)
>
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index 991b9769..4a97d3bc 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -162,7 +162,7 @@ static int selabel_fini(const struct selabel_handle *=
rec,
>         char *ctx_trans;
>         int rc;
>
> -       if (compat_validate(rec, lr, rec->spec_file, lr->lineno))
> +       if (compat_validate(rec, lr, rec->spec_files[0], lr->lineno))
>                 return -1;
>
>         if (!translating)
> @@ -398,11 +398,17 @@ int selabel_digest(struct selabel_handle *rec, unsi=
gned char **digest,
>
>  void selabel_close(struct selabel_handle *rec)
>  {
> +       size_t i;
> +
>         if (rec->digest)
>                 selabel_digest_fini(rec->digest);
>         if (rec->func_close)
>                 rec->func_close(rec);
> -       free(rec->spec_file);
> +       if (rec->spec_files) {
> +               for (i =3D 0; i < rec->spec_files_len; i++)
> +                       free(rec->spec_files[i]);
> +               free(rec->spec_files);
> +       }
>         free(rec);
>  }
>
> diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
> index bafa9328..53731470 100644
> --- a/libselinux/src/label_db.c
> +++ b/libselinux/src/label_db.c
> @@ -302,12 +302,19 @@ static catalog_t *db_init(const struct selinux_opt =
*opts, unsigned nopts,
>                 errno =3D EINVAL;
>                 return NULL;
>         }
> -       rec->spec_file =3D strdup(path);
> -       if (!rec->spec_file) {
> +       rec->spec_files =3D calloc(1, sizeof(*rec->spec_files));
> +       if (!rec->spec_files) {
>                 free(catalog);
>                 fclose(filp);
>                 return NULL;
>         }
> +       rec->spec_files[0] =3D strdup(path);
> +       if (!rec->spec_files[0]) {
> +               free(catalog);
> +               fclose(filp);
> +               return NULL;
> +       }
> +       rec->spec_files_len =3D 1;
>
>         /*
>          * Parse for each lines
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 0c0499eb..d91e1462 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -1549,9 +1549,13 @@ static int init(struct selabel_handle *rec, const =
struct selinux_opt *opts,
>                 goto finish;
>         }
>
> -       rec->spec_file =3D strdup(path);
> -       if (!rec->spec_file)
> +       rec->spec_files =3D calloc(1, sizeof(*rec->spec_files));
> +       if (!rec->spec_files)
>                 goto finish;
> +       rec->spec_files[0] =3D strdup(path);
> +       if (!rec->spec_files[0])
> +               goto finish;
> +       rec->spec_files_len =3D 1;
>
>         /*
>          * The do detailed validation of the input and fill the spec arra=
y
> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_inter=
nal.h
> index 4ff39d96..d54053df 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -96,10 +96,11 @@ struct selabel_handle {
>         void *data;
>
>         /*
> -        * The main spec file used. Note for file contexts the local and/=
or
> +        * The spec files used. Note for file contexts the local and/or
>          * homedirs could also have been used to resolve a context.
>          */
> -       char *spec_file;
> +       size_t spec_files_len;
> +       char **spec_files;
>
>         /* ptr to SHA1 hash information if SELABEL_OPT_DIGEST set */
>         struct selabel_digest *digest;
> diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
> index 957fcfd3..f315abc3 100644
> --- a/libselinux/src/label_media.c
> +++ b/libselinux/src/label_media.c
> @@ -109,7 +109,13 @@ static int init(struct selabel_handle *rec, const st=
ruct selinux_opt *opts,
>                 errno =3D EINVAL;
>                 goto finish;
>         }
> -       rec->spec_file =3D strdup(path);
> +       rec->spec_files =3D calloc(1, sizeof(*rec->spec_files));
> +       if (!rec->spec_files)
> +               goto finish;
> +       rec->spec_files[0] =3D strdup(path);
> +       if (!rec->spec_files[0])
> +               goto finish;
> +       rec->spec_files_len =3D 1;
>
>         /*
>          * Perform two passes over the specification file.
> diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
> index 0c525bfc..b528a019 100644
> --- a/libselinux/src/label_x.c
> +++ b/libselinux/src/label_x.c
> @@ -139,7 +139,13 @@ static int init(struct selabel_handle *rec, const st=
ruct selinux_opt *opts,
>                 errno =3D EINVAL;
>                 goto finish;
>         }
> -       rec->spec_file =3D strdup(path);
> +       rec->spec_files =3D calloc(1, sizeof(*rec->spec_files));
> +       if (!rec->spec_files)
> +               goto finish;
> +       rec->spec_files[0] =3D strdup(path);
> +       if (!rec->spec_files[0])
> +               goto finish;
> +       rec->spec_files_len =3D 1;
>
>         /*
>          * Perform two passes over the specification file.
> --
> 2.55.0.229.g6434b31f56-goog
>

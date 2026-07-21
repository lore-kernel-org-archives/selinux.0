Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9E53845D8
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646540; cv=pass; b=KyUJ0RxOF8zDJzV16Esc2iOFfKahYt90m+aGjupj6H1GMfw4YCdTroc4+sd8qUDdW+8IggRkptLgSBdmOVIM9GOtvtocbdHFsHHgl2F9STEUbMFahRo5hX0E3BoDNwuJPd/FbpQVYkqKe8CMfWso5ZMBKhy5yJ21+YjxLSsRoSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646540; c=relaxed/simple;
	bh=e37Ady7XeXhHUYWxsr3GtjRkyMutG+8HdSaqU9Y4kM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Esmwcrp64OLLGg8UMdSNYr+/6rMugFleZ3TZW/rPn/Mg5dG+VdO88VLTkC6Ji1HK39rGPtMPjfebgxrdB3L5SlL1DEcHY810oYRYiiapTx//FxWyaxvijzkqLtzhjV8QS1uO23WCjhVlrxdDP+ymZFybrG3G4V6pasPsEAdpG3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYdvlkaa; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYdvlkaa"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2caced6038eso69160645ad.0
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 08:08:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784646538; cv=none;
        d=google.com; s=arc-20260327;
        b=lfpsd7OoU+pnQe0QcmZCgVWQdoS4ZPbJ0LOy2kZLpwl4cw+13RKFlIXvToETT7efA4
         WSztHRf1lzusc06Hjw+gqYiRLvEHZvPqsBUhGt84ODett/Z88jqJQYD4IftW3v179liU
         FvRviywDewPTySg1xvuEVh9EEQnK0qUvvK5ebKyI/Dici28qMBdtmzUEt3ALXORFRW8I
         GJ6zpPUHArWImRbcoSGQ3fNAR9ZW25Lcztb/5Xq0EP0DESadkO60MnGnVUxkJqe42VUn
         UUIfJhE9kD7uEleiCFfNSfXsHaVtmy3oR5mcGYPNn/8KEEpl4sbkRYTS5eriV2dkeX4r
         Xqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bsfPWUVznHpq39lhOG8PWBj3hPMglCphbSmKf990Vjo=;
        fh=mMDxYY5wtlIekXoYIfjt6lvMWgTaMUwdwgsYDQ6qy3A=;
        b=XIKIS+9NwRpAeyEVquP0zWddgR2NDbvHxY8rEORodO5pSB1QvjqnBihPAZbnhia9VK
         wRg1UfF3nGm6ktt2OBIRHktSXfs/LCJujLZ1ycPTWq+wBem7tVGujHpAqQuaImlM2AhG
         ogHKKFaqsDkrBD41kZz7MVTYbGoQyH1LFicyKzQCoDwxP/fINNHaEIKk8CYybOM4pFXs
         BBTAx/M9fgj8ek0bIEy9S+qDG9fg84N7hoAGrcShhR7IzDBa8bHSWejvBleOi0G94c6d
         4PY9MWkS/LcAH5sNTeJhS+NDZ6JBQTNyVDCt2J9mNcJEq9odP+uFllciB45t0C8v3/nH
         FKGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784646538; x=1785251338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bsfPWUVznHpq39lhOG8PWBj3hPMglCphbSmKf990Vjo=;
        b=BYdvlkaaSu5EiLzPNrWF2fBoP2n/MbdOk+WchCxo7GRmMCsqMyQZd4E3qYkPsFd2LT
         mGmEVYvUDSgWzWrOY6ySpYL6MYZOHqj8e9VZz8xdUD2qeOrrD2VuSqPlm21eip2hi8Xt
         VXpaq7cbGIwh0Ux+OXrLPhIXzElFKX6aBuBEa9kaaG8yhmRyUYZDTHBm0PFQuwZfDhEg
         bxFL3dYlkDaAYnQugAiO4u/LDbcxMmVp8MBDbHXnvxpiil4zaxJpp6i/Ne+j8TTFVqml
         27w6LZwGvczYdXJnozSCobzY2b13oAM/khp08+nnmmGSxGXKbN26U38mAXD43+k3ia0+
         ocZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784646538; x=1785251338;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bsfPWUVznHpq39lhOG8PWBj3hPMglCphbSmKf990Vjo=;
        b=oEnil14Tn6aJMWe8A1qQsJzIDUVSqAdWZ3yN37I8Fjg4lSiEsBjmHbWxqiUSw6zb8V
         LDacGEf8Q1rwDX4X+TLqxvQR87Rj2vrzp7dcdCB2nwdwTeXcYAsdr6zBUeH3E23KO6dL
         0NWEHzQ3kXJyVe7KjJvn3FR7/2/YfnVvhfhu/im4mStELU8f9JjrUzuVfytDfujNAaCw
         /zyiGGWKR+7gTYejcBz5n7b4JnOsGYckDUhK+5WofSn/LVzQO/UK8I7xrUMn3BWzMru4
         1+goTYJPP850uXZPkmLCcH5QeAibvd4jIjA12sA6SylbXjtwkWLJkhzsTNZxSaLVxXuL
         QZiQ==
X-Gm-Message-State: AOJu0Yx9zfS/NqK0lK3kIYFfe0JRyFAleNoyy91Fr7LfncTiVsobMTyR
	97Bjp7VTOs0wnWuFUlVJs4poDvbOlzenbaOJJUk63ozx8xMdAWDoZB7fep8oAIo0uf1X3tdzsr/
	0UT+avljj8znyahzpE7/Le0C/Jh2/h1o=
X-Gm-Gg: AR+sD106wbj2Or+8Qk40w/Yr1dS8SuTTfoa2Gs2lotVcFpaOuY3FqxLQ4uqSwl366EC
	9BmYckAbUw6P2ef6sRCDmT5rRS4xp+QZOUsohFvy4WM5UiAM5d96NYOeBlzHIBSpH/9uYyVLc5n
	9XRxxqiH0SvlR0Q9I48vYW/sOvR9o4VIS0GnEW2/K+FGIXj4zjgsnFmja2rwqwameHa8xkt1Vo6
	v+qfZ0aaLfgYYXrR/1v1sepLnuqO2+QVKIfA03yb/xiGfegijv0tOSspSxdbQ==
X-Received: by 2002:a17:902:d50e:b0:2c9:d8c5:d55d with SMTP id
 d9443c01a7336-2cf8ddaa575mr62905ad.16.1784646537913; Tue, 21 Jul 2026
 08:08:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721021127.1313453-1-tweek@google.com>
In-Reply-To: <20260721021127.1313453-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 11:08:45 -0400
X-Gm-Features: AUfX_mzozpPsg-rumXvoc1DLnRhKBMp2oRfD6ipsN-CoHuAPHQmrSOYtQU23bEs
Message-ID: <CAEjxPJ4rpm0v2NPEyw+9+OUcsVgW6Q-ut5D8KXey+_Jbj2AKTw@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: support multiple spec_files
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 10:11=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
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
> ---
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
> index bafa9328..59a291e8 100644
> --- a/libselinux/src/label_db.c
> +++ b/libselinux/src/label_db.c
> @@ -302,12 +302,19 @@ static catalog_t *db_init(const struct selinux_opt =
*opts, unsigned nopts,
>                 errno =3D EINVAL;
>                 return NULL;
>         }
> -       rec->spec_file =3D strdup(path);
> -       if (!rec->spec_file) {
> +       rec->spec_files =3D calloc(1, sizeof(path));

Here and below, any particular reason you didn't use
sizeof(*rec->spec_files) instead of sizeof(path)?
It's not wrong, just not what I usually see.

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
> index 0c0499eb..eb2e66da 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -1549,9 +1549,13 @@ static int init(struct selabel_handle *rec, const =
struct selinux_opt *opts,
>                 goto finish;
>         }
>
> -       rec->spec_file =3D strdup(path);
> -       if (!rec->spec_file)
> +       rec->spec_files =3D calloc(1, sizeof(path));
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
> index 957fcfd3..35f3cc16 100644
> --- a/libselinux/src/label_media.c
> +++ b/libselinux/src/label_media.c
> @@ -109,7 +109,13 @@ static int init(struct selabel_handle *rec, const st=
ruct selinux_opt *opts,
>                 errno =3D EINVAL;
>                 goto finish;
>         }
> -       rec->spec_file =3D strdup(path);
> +       rec->spec_files =3D calloc(1, sizeof(path));
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
> index 0c525bfc..33a64a6a 100644
> --- a/libselinux/src/label_x.c
> +++ b/libselinux/src/label_x.c
> @@ -139,7 +139,13 @@ static int init(struct selabel_handle *rec, const st=
ruct selinux_opt *opts,
>                 errno =3D EINVAL;
>                 goto finish;
>         }
> -       rec->spec_file =3D strdup(path);
> +       rec->spec_files =3D calloc(1, sizeof(path));
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

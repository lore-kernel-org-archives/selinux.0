Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C508C4DC54F
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647295; cv=pass; b=GqQ7BCOSdiPT85fKvdPeTJxuj1qqzAbQpIHkgpnFA0IC4HZ8+DI0rYut+iMTGE0eZ6Ji/aWawwUVcf5du0Ayv7cWyw/mSyb3LBrcJvOAnTwKHJmpP1Cz1ZtG7Qu7IXv0pfRMvCGGneUdfP9ITaM2Nk0e5KqCorcxqB0mw7U3OQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647295; c=relaxed/simple;
	bh=6SC2XNPMxUZFqx4jfY4RCgZws0bdRwJ1miCwmDkptd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPypPIzDyFU1bknC8fKO0qzFosVC1ss/2wQrBrRQ7mR0YD00fSi+94DAXAChfWg70iWSG02j0+FqDD4p2RZMQWGG8iYclkWZwMnXr32dpJrSJS4fdpBsDlAE5pnOPr7r1Q9EHcLre9LntTgtxSOL5qV0cp9VEWHlGcD9gb3p5JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VK/Xdu6O; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK/Xdu6O"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84864086bfeso12188151b3a.1
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 08:21:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784647293; cv=none;
        d=google.com; s=arc-20260327;
        b=ef7IidFmrW6I5cp+uUrSNoa2UnU5Agl2iTjP8qD+FlNnaqfgkRnw5puxL0S5+iYdmc
         SgQZOVN0NyJ8Ggg9vOIr0jTxfEr/dqrYRBuO73YBu3ihW6f77pyl4cFz9QQ3ESVm4OZK
         hu7Hrmu9JwNwLPzXQMIOSB22rsGZFkHTZlfJYQ5uUlZryIo46auKNnZkxUntcS6XkhcD
         yUZUvat44OfCQZXIbMf5K6ObDjzrkxxxgZ5yOEP5rtPESHdnxiTrDlqY5tRDiknM73pU
         ENRRh8auxo+g+9YzknApWb3jp42nzXKMnCukeNV4G+YoeYPGJVeoKwBnMkFiw9D697eV
         7IFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=44qAkjoqtxnL0pjQAibLestcERLzYLK7ESDSUQUEBcQ=;
        fh=mMDxYY5wtlIekXoYIfjt6lvMWgTaMUwdwgsYDQ6qy3A=;
        b=lynGVeHsqSYh71i2OcGi48UTyGRfE80ZBPycOzlrD5VCpOoOQlj2gFRGvcD6kRXGI5
         FVwQOsC3asSLgMQKhjxFBtJB1sZfpZM8fmrLjXPD/xvkYsijfTmOFDw5+JKzHXsB4MEe
         edBxN8eCMEp6LQca36/UUpj6ODXfHEs6bzbeMIYEJ5iOM8Tdb1YqmO6C5uS6hJk7TGO0
         fPmN2kL+P6w9cxHb9EosTr0Gk/4GxxiYM6UyVM3Xwzf+2EtxhPnw5FwabQIIqyTTWX8t
         DG2OANlXwv6F1nF/RE74FHifGAy28/OfBQknZ+RCJCxunNQ0DRvVYnTSUh9twPJfbylc
         bpgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784647293; x=1785252093; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=44qAkjoqtxnL0pjQAibLestcERLzYLK7ESDSUQUEBcQ=;
        b=VK/Xdu6ODOUO8ELYxS5QhWiY2+mkRgRzkBBH7CvvGMpeRTs5P5A2AN09SOKXinQGIO
         ZerjWGG90ymxYu8qo+MirF1NaaXEjiyYOHSmBTkMguXW4bLOtbmkkar+KbusratSukcz
         AnDOqr7+HqLr8ccwIJoYyiJ8z7pJd3eexmMSMjmcSjPft+alF1NWH10ocA6WCfUFfqEd
         BXxez7UBjUS84ubIBCfyZD9tMWgssmOEM1amjRIc70F/OFqro8loJdatp1PXaaU2OyjO
         4UjblqwYlh75g1NEMb6Lt9bCjsavG2eBKzwFpNqy4OXjmk8K2vRskuNuZSJ9kq4mPvs0
         8EdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784647293; x=1785252093;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=44qAkjoqtxnL0pjQAibLestcERLzYLK7ESDSUQUEBcQ=;
        b=WU5ZmlwkmXCGRBunstafYbPNci15hZmVTDY8zyanXXpVEG+x+izpibVFCT4hqkGhqc
         /H4716CZICA2Pi4U+FqI6hXgz4p1sgaMqEK7TMLDODfeaRBjmSKbiOya20w+kNNF5JOR
         ghUSZUQ9QXpyjk1knNBL0I9GDEtcKvuJsrNawhxYN1D3a2FecNx6Et6IzkSVHWbLisUT
         h1X9bAWaR754KwZvuJXbFS1fvWuIuqZdaRuVbJqr4LtXc/fysqDTPKRchswPHhmVGkQ1
         m7017BT8oLShtPxTYaqLGRi+SNAqKfNndEs/IqvOo5oxfHK7bWct4yBCZKJPylQsy/ZN
         Xu4w==
X-Gm-Message-State: AOJu0YxuBPY5P4HcmEFMjIPUqqcRoIoJIWdLOqmPPaMzeN7yJOc7tGEa
	E3s6X86PYQmGP1bwa6LU43VZkSJcnT0I13lhNabt6ghCqdto3lijBFwyl6LyxTuHFhWEH6nDpDH
	SJqM6MAPVrfGAsTfCygYERPnXGAy45DNE/A==
X-Gm-Gg: AR+sD12LD72ficQ4WKejnXPvVUlkPcUvltcvS4o8iGI51rtww6+VambBT0pz5phXi94
	xsC96i9jl29DWt0xoKI3JjIkyEAKHAL2rE2tJgkPVrbh5kz1lNdCbMeRX1SHiqkUGmBYb8QxNZQ
	ctnkz8k08fRAjMUb98lq6jKLRP3fuPAkrk0znUR9iiTKKm5nc0n4Vk8MpCWzpt+YKNedLt8ya3i
	2jjP48FIrMJ0YC/F6IclqHhUqWBuuKBvNa0xk2E50SXGSAwA4I/tfbo0PYmZQ==
X-Received: by 2002:a05:6a00:94d3:b0:848:67ca:c03 with SMTP id
 d2e1a72fcca58-84c294bbb07mr18948514b3a.58.1784647292852; Tue, 21 Jul 2026
 08:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721021127.1313453-1-tweek@google.com> <20260721021127.1313453-2-tweek@google.com>
In-Reply-To: <20260721021127.1313453-2-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 11:21:21 -0400
X-Gm-Features: AUfX_myv1-IclOaberxvHnzbJYm8_HvOrowlKHCxMm5ykHnAlEm6rQ5DH9yDxFI
Message-ID: <CAEjxPJ5pG_QaFZPgj5_3hKPhF6+xMYfwLnjpXSuR_RA=WmkJzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: support multiple contexts for the file backend
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 10:11=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
>
> Update the file labeling backend to support specifying multiple
> SELABEL_OPT_PATH options in selabel_open().
>
> All provided paths are stored in rec->spec_files and processed during
> initialization. Derived files, such as substitutions (.subs, .subs_dist)
> and auxiliary contexts (.homedirs, .local), continue to be based on the
> first path (or default selinux_file_context_path()) when enabled.
>
> Duplicate checking logic is refactored into a helper function
> report_dups(). A duplicate with the same specification result is not
> fatal anymore, but a warning is still logged.
>
> Additionally, duplicate validation is moved after all files (including
> .homedirs and .local) are loaded and sorted. For single file context setu=
ps,
> the only difference in behavior is that duplicate validation now extends =
to
> fc.homedirs and fc.local.
>
> A similar multiple files setup has been used in Android for 9+ years.
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> ---
>  libselinux/src/label_file.c | 216 ++++++++++++++++++++++--------------
>  1 file changed, 132 insertions(+), 84 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index eb2e66da..902c9a25 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -1484,22 +1503,27 @@ static int init(struct selabel_handle *rec, const=
 struct selinux_opt *opts,
>                 unsigned n)
>  {
>         struct saved_data *data =3D rec->data;
> -       const char *path =3D NULL;
> +       size_t num_paths =3D 0, i;
> +       char **paths =3D NULL;
>         const char *prefix =3D NULL;
> -       int status =3D -1, baseonly =3D 0;
> +       int status =3D -1;
> +       bool baseonly =3D false, path_provided =3D false;
>
>         /* Process arguments */
> -       while (n) {
> -               n--;
> -               switch (opts[n].type) {
> +       i =3D n;
> +       while (i--) {
> +               switch (opts[i].type) {
>                 case SELABEL_OPT_PATH:
> -                       path =3D opts[n].value;
> +                       if (opts[i].value) {
> +                               num_paths++;
> +                               path_provided =3D true;
> +                       }

Here we count only non-NULL values, counting from the end.

>                         break;
>                 case SELABEL_OPT_SUBSET:
> -                       prefix =3D opts[n].value;
> +                       prefix =3D opts[i].value;
>                         break;
>                 case SELABEL_OPT_BASEONLY:
> -                       baseonly =3D !!opts[n].value;
> +                       baseonly =3D !!opts[i].value;
>                         break;
>                 case SELABEL_OPT_UNUSED:
>                 case SELABEL_OPT_VALIDATE:
> @@ -1511,10 +1535,44 @@ static int init(struct selabel_handle *rec, const=
 struct selinux_opt *opts,
>                 }
>         }
>
> +       /* If no paths were provided, we will use the default path or fai=
l, depending on the target. */
> +       if (!path_provided) {
> +#if !defined(BUILD_HOST) && !defined(ANDROID)
> +               num_paths =3D 1;
> +#else
> +               selinux_log(SELINUX_ERROR,
> +                           "No path given to file labeling backend\n");
> +               goto finish;
> +#endif

Do we really need/want differing behavior here for different build configs?
Effectively it means a different user-visible API?

> +       }
> +
> +       /* Allocate the paths */
> +       paths =3D calloc(num_paths, sizeof(*paths));
> +       if (paths =3D=3D NULL) {
> +               goto finish;
> +       }
> +       rec->spec_files =3D paths;
> +       rec->spec_files_len =3D num_paths;
> +
> +       if (path_provided) {
> +               for (i =3D 0; i < n; i++) {
> +                       switch (opts[i].type) {
> +                       case SELABEL_OPT_PATH:
> +                               *paths =3D strdup(opts[i].value);
> +                               if (*paths =3D=3D NULL)
> +                                       goto finish;
> +                               paths++;
> +                               break;

Here we would end up calling strdup(NULL) if any of the opts[i].value are N=
ULL
instead of skipping them as above.

> +                       default:
> +                               break;
> +                       }
> +               }
> +       }
> +
>  #if !defined(BUILD_HOST) && !defined(ANDROID)
>         char subs_file[PATH_MAX + 1];
>         /* Process local and distribution substitution files */
> -       if (!path) {
> +       if (!path_provided) {
>                 status =3D selabel_subs_init(
>                         selinux_file_context_subs_dist_path(), rec->diges=
t,
>                         &data->dist_subs, &data->dist_subs_num,
> @@ -1526,66 +1584,56 @@ static int init(struct selabel_handle *rec, const=
 struct selinux_opt *opts,
>                                            &data->subs_num, &data->subs_a=
lloc);
>                 if (status)
>                         goto finish;
> -               path =3D selinux_file_context_path();
> +               rec->spec_files[0] =3D strdup(selinux_file_context_path()=
);
> +               if (rec->spec_files[0] =3D=3D NULL)
> +                       goto finish;
>         } else {
> -               snprintf(subs_file, sizeof(subs_file), "%s.subs_dist", pa=
th);
> +               snprintf(subs_file, sizeof(subs_file), "%s.subs_dist",
> +                        rec->spec_files[0]);
>                 status =3D selabel_subs_init(subs_file, rec->digest,
>                                            &data->dist_subs,
>                                            &data->dist_subs_num,
>                                            &data->dist_subs_alloc);
>                 if (status)
>                         goto finish;
> -               snprintf(subs_file, sizeof(subs_file), "%s.subs", path);
> +               snprintf(subs_file, sizeof(subs_file), "%s.subs",
> +                        rec->spec_files[0]);
>                 status =3D selabel_subs_init(subs_file, rec->digest, &dat=
a->subs,
>                                            &data->subs_num, &data->subs_a=
lloc);
>                 if (status)
>                         goto finish;
>         }
> -
>  #endif
>
> -       if (!path) {
> -               errno =3D EINVAL;
> -               goto finish;
> -       }
> -
> -       rec->spec_files =3D calloc(1, sizeof(path));
> -       if (!rec->spec_files)
> -               goto finish;
> -       rec->spec_files[0] =3D strdup(path);
> -       if (!rec->spec_files[0])
> -               goto finish;
> -       rec->spec_files_len =3D 1;
> -
>         /*
> -        * The do detailed validation of the input and fill the spec arra=
y
> +        * Process each input file.
>          */
> -       status =3D process_file(path, NULL, rec, prefix, rec->digest, 0);
> -       if (status)
> -               goto finish;
> -
> -       if (rec->validating) {
> -               sort_specs(data);
> -
> -               status =3D nodups_spec_node(data->root, path);
> +       for (i =3D 0; i < num_paths; i++) {
> +               status =3D process_file(rec->spec_files[i], NULL, rec, pr=
efix,
> +                                     rec->digest, i);
>                 if (status)
>                         goto finish;
>         }
>
>         if (!baseonly) {
> -               status =3D process_file(path, "homedirs", rec, prefix,
> -                                     rec->digest, 1);
> +               status =3D process_file(rec->spec_files[0], "homedirs", r=
ec,
> +                                     prefix, rec->digest, num_paths + 1)=
;
>                 if (status && errno !=3D ENOENT)
>                         goto finish;
>
> -               status =3D process_file(path, "local", rec, prefix, rec->=
digest,
> -                                     2);
> +               status =3D process_file(rec->spec_files[0], "local", rec,=
 prefix,
> +                                     rec->digest, num_paths + 2);
>                 if (status && errno !=3D ENOENT)
>                         goto finish;
>         }
>
> -       if (!rec->validating || !baseonly)
> -               sort_specs(data);
> +       sort_specs(data);
> +
> +       if (rec->validating) {
> +               status =3D nodups_spec_node(rec, data->root);
> +               if (status)
> +                       goto finish;
> +       }
>
>         digest_gen_hash(rec->digest);
>
> --
> 2.55.0.229.g6434b31f56-goog
>

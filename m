Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519F46D550
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648729; cv=pass; b=kFvf+JJqhW4M/O15W/qMTdcs+SvhFOBQq+KoYSjQuv4BVni4S83i1PswLIQyA6Af3rC9npGQjeomDuZ+3xEGB5HBiC8lp79J+aEhxdArwbJi1AnzxcJXPeK9wBHZgpFzMEPSyNnojW+0QRUDQ6VgcGwCrjertg7Pphz0XSf+UXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648729; c=relaxed/simple;
	bh=ASN9dc5IM5vUdXNTDQqDwIYr5ppZ6+/1wiAbX99lEjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9JcPrCpeDHx3AC8tHElt+w/hcomoNBNgKmxQRb60HwFROjSBh7HRP6GndnI6/kI0QCf9XLCKn3mL1T94VJ/zrCsSIO7VztjTw5d3AyMqmVaUtZIGd+omefsmzOi0Nq46d8c+xVzL5WUTn7oZKya30NpVMq+jwTydWfc9wfT1jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o2gXwaJc; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2gXwaJc"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84874b52eabso10801026b3a.0
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 08:45:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784648725; cv=none;
        d=google.com; s=arc-20260327;
        b=TH/R0cFML3qDYeZfVerAM4HYCQJj9WYmefH8w7bqj5PyTz8YnPGUOjfGp1SCWc76Ol
         ZxyRZQMHGSMG7pVfsGa4Rnt/DypjTnchmS5M3revjTnYyxM0j1m/lozHGR1xxXOa0OxT
         jGlUE0M8o//PFU4SWRWvGU9kTNd0NYDNm58s0oLH15V7Dy8POUNzs3hfVQbl64dWVXrJ
         A8otr9RIDBz8Q5RweK/wtT6bf0EAZOcrbYe/2ePrW0Fkhh9auWKjeEFlPjAp13hN9NTc
         7/bOJ2FT1ME7UHGiynrGSpvO8CuGAfodJI4eE5KePjVmjpNkf1txylCGGluDkTI+WNL/
         GXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WzqoJEdmPSQ3L19UWpGeXgtU3mjxvpC0rfvoIrLIwZQ=;
        fh=mMDxYY5wtlIekXoYIfjt6lvMWgTaMUwdwgsYDQ6qy3A=;
        b=bqANDCkRcZXQCtFr92aodL1JQo2P10aNg4dpM0QmN5jbYQZMRB6ysmt6dd7YawRqAh
         PpMzkgbfFxdjwz76ICPdHZuPkWnWMb6jr7Uh472P/+y826hVMtt2h1ZiQDwBp6dq6t7o
         Y2mjAQihUOwu8MnaeKfPs+cmXhNJ6kAWWYuGfcmTmtQcR1msQjwervS1zFovuw57K3TI
         tMOUzwLRkUjclIyPYnZVY9Q15CFlZC9G/ompvgZE5ZyhKdGoSQanAh218uC9KCkN5sXo
         w0BMAKwcswNlJQcnnVL3Yko1LZkgDjBUXnkcRNzNGRr005LM3v9Vd9k9YNdhB+gqTKPm
         gW8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784648725; x=1785253525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WzqoJEdmPSQ3L19UWpGeXgtU3mjxvpC0rfvoIrLIwZQ=;
        b=o2gXwaJcpAqVQtbmTcsxTRv5bh7m0r9kOyM0+Ub+rEfAZryp7zqXyuz3WugaM46ov4
         UWzrw5l3Kp5n9zIZiqH3MShiblE9BSs338WLZeFyDFK+yWAvVGcDJrOoIog4YVSjmXcr
         Y8G2ITAODFvJIn/LvrPLWwEacvatBTXX2qoedgWBhGSL3cPuGmVxbUmR66OjNICoDBFu
         GmCrQ9W2MhH+7Z+tOPfxJfN8sV5IM47UbJby+r6bLHqRSKNt6swwo75+/wuXsx5wUGbW
         tzrUAbLG6+V5AOJyd+ACo59wLoxBT13xrnclgErEzvhG21uihGZ6EIfPBqmD6c18kQfr
         u7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784648725; x=1785253525;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WzqoJEdmPSQ3L19UWpGeXgtU3mjxvpC0rfvoIrLIwZQ=;
        b=ZNyehZBrK19yxi/pTxjdjDJaYvPAvIiBOva/AYgPM0173ABCjGrpG+RPUXqcTIVui+
         HKzug7CO3Ve+KOUfotwdv7k6jGGDZ5fmCvXSAQOB8b5L4LiJS05QIxp24sXpoCGMvguE
         +S6XT2KwNAAhY2TtBceae4dyDzhAGvBM+3rGcQDQuIDNHIAwY4wgPXZ30jF7ftagNM4N
         ix3hWFYLXgdBhubCDop4Q5CNCYeYTbQ5QwiyoNrV2wlMDZoWNtxSZ/2RutboNMV/fwVv
         pB7uVzLOO+osrdw1hz08uZP8G+mLf9yxydmB9CacgF7+83GaxbEuRht6UzkWbYmVg5A9
         bODQ==
X-Gm-Message-State: AOJu0YwfTtvoSrGcJg7sDG1+jtsOg43QkBcdzztQdEdSMfBqcTbB1yhu
	fJPbpzHU8aNNKDUDuG725DBO8lO+RjlxssI5GL23nIveQZizE8XT90mBIzrmI6UfWth9qskk61v
	ANegO5iVnvSoA6V0BZ/IvD02BCSk/VlQ=
X-Gm-Gg: AR+sD10igK1jDVwJ4XXxEBRIlmUqsgRonT7jMUVitUA18pXRZZAZbRDr+PRt7vWe3wo
	Ysi05omny1jOS02+ZFVz6NlRMXcpiVV+YTtOYPevewH4ikXbAkT5eAeT15cBDi+b0io+B30z3qy
	nVv6SVY3Z+eDyWbryvToHGUelOlFgyzIFkHitHFnlv9u2mGKXA9NKxXPkemTYl2lH+EY5UkJMTS
	MOBWlEE9D+ubMOlJ78+QYE2A47JBWXVCkVLQunLW0PgehNmZNgzJ67O7xAbPA==
X-Received: by 2002:a05:6a00:3920:b0:848:8715:c2d9 with SMTP id
 d2e1a72fcca58-84c29273709mr19256352b3a.2.1784648725264; Tue, 21 Jul 2026
 08:45:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721021127.1313453-1-tweek@google.com> <20260721021127.1313453-2-tweek@google.com>
In-Reply-To: <20260721021127.1313453-2-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 11:45:13 -0400
X-Gm-Features: AUfX_myDq4XZMcYsRAQ-0QSLMiicPfxNfDLTFHO2zqdoa7OIPfwiuZLRbPtClLs
Message-ID: <CAEjxPJ6zcYW7_mGPhnTNV5oq-8uxsmDJxnXFoZjxyYYg7ce76A@mail.gmail.com>
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

process_file() last argument is uint8_t; i and num_paths are size_t.
Need to cap the max num_paths somewhere or change the type.

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

Ditto.

>                 if (status && errno !=3D ENOENT)
>                         goto finish;
>
> -               status =3D process_file(path, "local", rec, prefix, rec->=
digest,
> -                                     2);
> +               status =3D process_file(rec->spec_files[0], "local", rec,=
 prefix,
> +                                     rec->digest, num_paths + 2);

Ditto

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

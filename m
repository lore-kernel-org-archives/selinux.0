Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CD413B797
	for <selinux@vger.kernel.org>; Wed, 30 Jul 2025 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753894497; cv=none; b=A7Xfv+jwGpRUs+h4LkHKB46VZhicF/k6oVmfNIrJ7QkI6yctV1EX6RfX0J9Nnpw2N63VDH9fW2lxfiUp+nUh2zchkh0/DKKMN2tJL4rnKUceMjddcksr/WE1+EhFvzvfi21PsHx98ETM+0YH4zyoL02EIarlbCiVjvg6fem9eso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753894497; c=relaxed/simple;
	bh=JSN1s/VFXUcbS3KsbWZnSb/gt6XZ/T/LDoW7pqVbZzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0S5rA+iZ6xFM7G0+bPsplYgwizt6Xhazhuqet0gGzg1VN6hqyYfXhyrilbLEf3gAEabGCW6Ie/VKt4zbuWwa3lkaS1/6HmFIzkF6aoC9l9uCRsBBQvQ3Nn3viFHo3qChaFL0ThHiY7mLVXEPt1t3JUh+IbYZMZWGRJ1PzvWX54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHyl8umB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHyl8umB"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31ecd40352fso88811a91.2
        for <selinux@vger.kernel.org>; Wed, 30 Jul 2025 09:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753894496; x=1754499296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlnZFTXn9HWuZyiSaB9crkHUThbZJh7Ty7jJJtaXm1g=;
        b=lHyl8umB04gAumZGjQUmuQWEzrrSxQjfJy2PwAkvuJB4lc+G9L+Kcym99g7QZMuuel
         OdGXTw08CY8S/Tzg+5iYFyYHqCAKsY9mnBTfy8tDkmBjPASTqV+7hZnx1FK//4aiXjS+
         aRI7tyPifvQFjssDLy0ihOimoWaNRM+lq1ewC0R2Q3SwJe6e1VErV6m8iqjXW9ge/qS2
         rUmx9TFXisV92MZNu6MEZIGxXSbOqtSIRwO0bfbJ931PVKg+cLpm5t7w+QvuJ+8O9Yfd
         00c9zl3YWHGXp/DBFiGbOJCXG9XTxnkmYquplXqzH2RzeW8SRn0bSFL3w1BiK9vPDhwS
         eMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753894496; x=1754499296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlnZFTXn9HWuZyiSaB9crkHUThbZJh7Ty7jJJtaXm1g=;
        b=KstAMziG6A5fP4yYieukfkwGxQnJOC3LLZ5Sb4SGPGEbFE+SKeOo9jvgnWddS3Rpvv
         /kSDHihvbIE7qWjGB5FITfHGt7M9UBivzGpGCwvM2HiHLB/iP4bA9YU1uhwO2eH3ofdl
         Tkc9tKPZoVC9qlfi1B/kdjs7dOY4IFVDKj01p5YFeiiaNhoTmyYYYucOXB+jAw3sX3Ii
         kO+ICvXTVAEeJ66A5Y0cO0GW6A/mCkjVn8/UcTfniI234C19hZIZOwLB5Zh1L0xLAVlA
         ppkJIEmTJUbRxJU1TGnnopbhYp88WjJ/cuxq7K7Waqr9XiW4UOiidsVi482VnMQLUV03
         CdPg==
X-Gm-Message-State: AOJu0Yy4+KJGOhVkLoVwVf4bE/abBB5MNT78qXw2eL8SxI6JFlIvIgV+
	8d7BUW0XBgeNPutLWroQi2cAYM7RtOC1AglW21c78ZXWHZ69nA27RG6dUE0QpWOIgTKLshuu59j
	CRIliTJbuvMqbXjBZZtuKknXuYCjuPVbV5A==
X-Gm-Gg: ASbGncsZOH+t4C1SEgd8lPmX/+7eDSbMpbl2vHzm2ZE2aWb6BKZbzOhmBpG2lK2H4Kw
	G6qU14gbwnys4Yi7RxO8ivFZ+bFiAN7goDavHAf5pYJbpcDfvGP4KJlN85R8mkSFBtopxKDEAUg
	9qvGNX2e+OX6k+ujM4GZ5ShZ6Wujx9gv1P9hBzfSzx19nHjv0lgQXZ+pQ7C7PPgYnpOHVhTjVO4
	atcQY4=
X-Google-Smtp-Source: AGHT+IE/ktryhbGICVyW0r4FHTkdnqgCUgbo0EMyt1wZI7XAP/3Fxo2yi9WCWQ02wzPSOatg2hlt3qfVj94uxW4uLMw=
X-Received: by 2002:a17:90b:3e84:b0:311:e8cc:424c with SMTP id
 98e67ed59e1d1-31f5ea4c967mr5475692a91.25.1753894495577; Wed, 30 Jul 2025
 09:54:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730150723.974292-1-nvraxn@gmail.com>
In-Reply-To: <20250730150723.974292-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 30 Jul 2025 12:54:44 -0400
X-Gm-Features: Ac12FXzbs6G-IKA3qF6-f09zQFeYXHqF2m91bMOT-kYYVUuHgaWH1JhJwYS8Ycc
Message-ID: <CAEjxPJ78Ynm52M14_Jm48vkLi2MpXBVoQCbyGavauhwkeHf52A@mail.gmail.com>
Subject: Re: [PATCH] libselinux: load_policy: log using selinux_log instead of fprintf
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 11:08=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wr=
ote:
>
> This allows consumers to override our logging to stderr using the
> callback based mechanism selinux_log provides.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/load_policy.c | 37 ++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
> index f67e5538..8e737a23 100644
> --- a/libselinux/src/load_policy.c
> +++ b/libselinux/src/load_policy.c
> @@ -16,6 +16,7 @@
>  #include <sepol/policydb.h>
>  #endif
>  #include <dlfcn.h>
> +#include "callbacks.h"
>  #include "policy.h"
>  #include <limits.h>
>
> @@ -136,25 +137,25 @@ int selinux_mkload_policy(int preservebools __attri=
bute__((unused)))
>                 fd =3D open(path, O_RDONLY | O_CLOEXEC);
>         }
>         if (fd < 0) {
> -               fprintf(stderr,
> -                       "SELinux:  Could not open policy file <=3D %s.%d:=
  %m\n",
> -                       selinux_binary_policy_path(), maxvers);
> +               selinux_log(SELINUX_ERROR,
> +                           "SELinux:  Could not open policy file <=3D %s=
.%d:  %m\n",
> +                           selinux_binary_policy_path(), maxvers);
>                 goto dlclose;
>         }
>
>         if (fstat(fd, &sb) < 0) {
> -               fprintf(stderr,
> -                       "SELinux:  Could not stat policy file %s:  %m\n",
> -                       path);
> +               selinux_log(SELINUX_ERROR,
> +                           "SELinux:  Could not stat policy file %s:  %m=
\n",
> +                           path);
>                 goto close;
>         }
>
>         size =3D sb.st_size;
>         data =3D map =3D mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
>         if (map =3D=3D MAP_FAILED) {
> -               fprintf(stderr,
> -                       "SELinux:  Could not map policy file %s:  %m\n",
> -                       path);
> +               selinux_log(SELINUX_ERROR,
> +                           "SELinux:  Could not map policy file %s:  %m\=
n",
> +                           path);
>                 goto close;
>         }
>
> @@ -175,9 +176,9 @@ int selinux_mkload_policy(int preservebools __attribu=
te__((unused)))
>                 if (policydb_set_vers(policydb, kernvers) ||
>                     policydb_to_image(NULL, policydb, &data, &size)) {
>                         /* Downgrade failed, keep searching. */
> -                       fprintf(stderr,
> -                               "SELinux:  Could not downgrade policy fil=
e %s, searching for an older version.\n",
> -                               path);
> +                       selinux_log(SELINUX_ERROR,
> +                                   "SELinux:  Could not downgrade policy=
 file %s, searching for an older version.\n",
> +                                   path);
>                         policy_file_free(pf);
>                         policydb_free(policydb);
>                         munmap(map, sb.st_size);
> @@ -192,9 +193,9 @@ int selinux_mkload_policy(int preservebools __attribu=
te__((unused)))
>         rc =3D security_load_policy(data, size);
>
>         if (rc)
> -               fprintf(stderr,
> -                       "SELinux:  Could not load policy file %s:  %m\n",
> -                       path);
> +               selinux_log(SELINUX_ERROR,
> +                           "SELinux:  Could not load policy file %s:  %m=
\n",
> +                           path);
>
>        unmap:
>         if (data !=3D map)
> @@ -205,7 +206,7 @@ int selinux_mkload_policy(int preservebools __attribu=
te__((unused)))
>        dlclose:
>  #ifdef SHARED
>         if (errormsg)
> -               fprintf(stderr, "libselinux:  %s\n", errormsg);
> +               selinux_log(SELINUX_ERROR, "libselinux:  %s\n", errormsg)=
;
>         if (libsepolh)
>                 dlclose(libsepolh);
>  #endif
> @@ -317,7 +318,7 @@ int selinux_init_load_policy(int *enforce)
>                         *enforce =3D 0;
>                 } else {
>                         /* Only emit this error if selinux was not disabl=
ed */
> -                       fprintf(stderr, "Mount failed for selinuxfs on %s=
:  %m\n", SELINUXMNT);
> +                       selinux_log(SELINUX_ERROR, "Mount failed for seli=
nuxfs on %s:  %m\n", SELINUXMNT);
>                 }
>
>                 if (rc =3D=3D 0)
> @@ -365,7 +366,7 @@ int selinux_init_load_policy(int *enforce)
>         if (orig_enforce !=3D *enforce) {
>                 rc =3D security_setenforce(*enforce);
>                 if (rc < 0) {
> -                       fprintf(stderr, "SELinux:  Unable to switch to %s=
 mode:  %m\n", (*enforce ? "enforcing" : "permissive"));
> +                       selinux_log(SELINUX_ERROR, "SELinux:  Unable to s=
witch to %s mode:  %m\n", (*enforce ? "enforcing" : "permissive"));
>                         if (*enforce)
>                                 goto noload;
>                 }
> --
> 2.50.1
>
>

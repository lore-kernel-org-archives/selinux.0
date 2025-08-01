Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84F42737F2
	for <selinux@vger.kernel.org>; Fri,  1 Aug 2025 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754072813; cv=none; b=BbfrNWkCiBfSV3nq1CWz+uxNXBR/osH2A6qpOjEICJFOiR1UPlqvMPnWTT7JwHtFIQjcO1WRgzGwAwBfHXwtvdiMUTqYMnizQQr5FYF2OBvsNkTg6XkVTIlC1XgEACO+6XyTVl0jOG0vGFAVxkookML+T52rsc/pe0E+YyNcTgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754072813; c=relaxed/simple;
	bh=sJGT3AtNp4PD1hsbejFtPv3IKW/QNvqhjAGokH3Qa5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ds1hbMqt1xA+Skr3q9ejgH/lOIwnDYJ32A9+kBYkrxfHGv6kkY7P+dVnXvx9TP1jihazEdCmQ5tRDJsd6qXhKJ4PYWXc2hS/ZTp5n/V8MOgvNU9Jm4qKYSomcyEpINOF2BZaRjqyvZuHSfujQ4dxr3SNSTxauE+l04/2Fu4Al2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYH3QIaY; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYH3QIaY"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31eb40b050bso1816139a91.0
        for <selinux@vger.kernel.org>; Fri, 01 Aug 2025 11:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754072811; x=1754677611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KwVpKXYsA1yD/pNq3lBn/UI1G3/1JveeLVjNg/mrhs=;
        b=HYH3QIaYyJ4b6kHjjuH8XuwLu61nS2CRoFfhyNQXIbqjWUTO2X4yxq66A7FESfbmf6
         HR9/TQA9m3jd6KYybrV3Wt7Ko5qhLWSB+I7NHtRdHL/77k24CfXxwxs9eLS9CDz5k0z0
         Hz+Fx45SxnxWklwmUplKjzvr4VgZiHckUcLt16m7VbVIu73wyJT7GrGhfCSQJaGBVhwP
         ay6EOGUKN1JM189mkgZeNA50f8bWc2zrXF6oDAoGI9T1jkMu2L72A0vyzf6xrijN6LM9
         gXiplSBC30Zargl5lV4hP0ZgnOFN4/ieC28EjRpWOgs3I5cquja6M8mdj3F7T9uda2mv
         0TgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754072811; x=1754677611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KwVpKXYsA1yD/pNq3lBn/UI1G3/1JveeLVjNg/mrhs=;
        b=UIqRQ/5czCmfixp3//apdTZv5vY/0iCV7jbVuTpaIn1byiOEtQ8mwOKdBMSpdaey6/
         UIxKZe18CiVcexrk1ksptZguIC42LJGYkragp0xIkCMK/4bsNePfpRcbsPinwNyo5+T2
         +UVhqWdU1VJfJr6mabOTI1k7GVeGbb/QIudklISdvcVO84CnLPffvTX8DMc+iw1f9qNv
         KelmTOnT+Z+3nEpquEoio6QHKqum6bj/yKNMbIuS8WkqHGIUdgcW1w/tla8gfOLkPa+p
         Jdff9lDExpYCapfrjCGOLAw8Eg6j+FitVI/dkBeFrZ8+9bsUhVDfmornFOCXDhhl16W5
         P6Rw==
X-Gm-Message-State: AOJu0YymAeKnDdYk/cPuCldrXukNqUg799xc+kaKyhZfsupKGQGELSC6
	hN0ENZ0BvmAFFlrUtiFkJJ3EIEev28jOhws1waZG/8R07PfZKKkjBRXmjFauDJffdfGTsH/v3pS
	8uflH1VQQaVh1I22OcMUt5bMwS2SMOPmf7w==
X-Gm-Gg: ASbGnctL0DFuCf2ecsf+RaMgz+XAMX7dRsuYtlL4YDSiYGFjWZoNLiDW9EkCP699pOy
	4uWbMCeFKaeTuY7/+627KmHr2HVKTJMyS6yBFU2z7nTCtPiPhsfIpRZd1Uq+7IKJCR97rArYnwM
	cU8JS46gnRr+yFXw9dEAXycqEB9lWk40o2vS4xZCce3Kpn80rak2M14uxfLQPypy8/30t23Dp/d
	Yj++6w=
X-Google-Smtp-Source: AGHT+IGJJIqEibERtwBBgd696Q24DWdpgAkO6lZODABQw02JWPB4Cl5VQHHhXmcOsAyTlsqNCO8Mf97a0I8j6KHFJmg=
X-Received: by 2002:a17:90b:268e:b0:312:f2ee:a895 with SMTP id
 98e67ed59e1d1-321162e37a6mr852401a91.31.1754072810876; Fri, 01 Aug 2025
 11:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801143300.1189741-1-nvraxn@gmail.com>
In-Reply-To: <20250801143300.1189741-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 1 Aug 2025 14:26:39 -0400
X-Gm-Features: Ac12FXxXfBo6BabnNBYfN6yzugc68vrb6_sGpPbvSbOzveSNIvwockztreqgt8g
Message-ID: <CAEjxPJ5RyF4ohqgrvCaPGJoEcXBCL3mY4U9CDhZEJfn3cNC_=Q@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: refactor semanage_user_roles
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 10:33=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> Reduce the levels of nesting by early returning on errors.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> ---
>  libsemanage/src/seusers_local.c | 76 +++++++++++++++++++--------------
>  1 file changed, 45 insertions(+), 31 deletions(-)
>
> diff --git a/libsemanage/src/seusers_local.c b/libsemanage/src/seusers_lo=
cal.c
> index eb3f82bc..282d56fa 100644
> --- a/libsemanage/src/seusers_local.c
> +++ b/libsemanage/src/seusers_local.c
> @@ -18,39 +18,53 @@ typedef struct semanage_seuser record_t;
>  #include "string.h"
>  #include <stdlib.h>
>
> -static char *semanage_user_roles(semanage_handle_t * handle, const char =
*sename) {
> +static char *semanage_user_roles(semanage_handle_t * handle, const char =
* sename) {
>         char *roles =3D NULL;
> -       unsigned int num_roles;
> -       size_t i;
> -       size_t size =3D 0;
> -       const char **roles_arr;
> +       const char **roles_arr =3D NULL;
>         semanage_user_key_t *key =3D NULL;
> -       semanage_user_t * user;
> -       if (semanage_user_key_create(handle, sename, &key) >=3D 0) {
> -               if (semanage_user_query(handle, key, &user) >=3D 0) {
> -                       if (semanage_user_get_roles(handle,
> -                                                   user,
> -                                                   &roles_arr,
> -                                                   &num_roles) >=3D 0) {
> -                               for (i =3D 0; i<num_roles; i++) {
> -                                       size +=3D (strlen(roles_arr[i]) +=
 1);
> -                               }
> -                               if (num_roles =3D=3D 0) {
> -                                       roles =3D strdup("");
> -                               } else {
> -                                       roles =3D malloc(size);
> -                                       if (roles) {
> -                                               strcpy(roles,roles_arr[0]=
);
> -                                               for (i =3D 1; i<num_roles=
; i++) {
> -                                                       strcat(roles,",")=
;
> -                                                       strcat(roles,role=
s_arr[i]);
> -                                               }
> -                                       }
> -                               }
> -                               free(roles_arr);
> -                       }
> -                       semanage_user_free(user);
> -               }
> +       semanage_user_t *user =3D NULL;
> +
> +       if (semanage_user_key_create(handle, sename, &key) < 0) {
> +               goto cleanup;
> +       }

Here and below, no need for { } around a single statement body.

> +
> +       if (semanage_user_query(handle, key, &user) < 0) {
> +               goto cleanup;
> +       }
> +
> +       unsigned int num_roles =3D 0;
> +       if (semanage_user_get_roles(handle, user, &roles_arr, &num_roles)=
 < 0) {
> +               goto cleanup;
> +       }
> +
> +       if (num_roles =3D=3D 0) {
> +               roles =3D strdup("");
> +               goto cleanup;
> +       }
> +
> +       size_t size =3D 0;
> +       for (size_t i =3D 0; i < num_roles; i++) {
> +               size +=3D (strlen(roles_arr[i]) + 1);
> +       }
> +
> +       roles =3D malloc(size);
> +       if (!roles) {
> +               goto cleanup;
> +       }
> +
> +       strcpy(roles, roles_arr[0]);
> +
> +       for (size_t i =3D 1; i < num_roles; i++) {
> +               strcat(roles, ",");
> +               strcat(roles, roles_arr[i]);
> +       }
> +
> +cleanup:
> +       free(roles_arr);
> +       if (user) {
> +               semanage_user_free(user);
> +       }

Here and below, looks like it is valid to call with a NULL user/key so
no need to test for non-NULL.

> +       if (key) {
>                 semanage_user_key_free(key);
>         }
>         return roles;
> --
> 2.50.1
>
>

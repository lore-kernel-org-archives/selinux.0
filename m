Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FCF286425
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903249; cv=pass; b=fj7VzP2iFG6U86RGGopmF/bYfhXVQLmdcakhPK/Fo4D1G1HlwOWS0aHbnvsueLRmRN73ZuyQGQ/lmWEC2nN+Ujyj9LN6uly62vp2jjNB37OZOTwhEMJgr0vKRgSr6HPIgOwMKb37priBoIpkurTiFvPcjHxJ0sNxsosuwTy+gbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903249; c=relaxed/simple;
	bh=+Wx+xBFeKZ4KI5awhPi56Td4cKxYKKDQQVvbaIImvgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHNHwb1jvdDQFv2E58uOd+mFBE+SpeIOvNOise0T/oZBsyXHOV2qE5pkHfV0Ccd4th/n2sr07ehoZ3pXLJTLbN+JyiCickFoWXl7I6vby5uKGgzyv0/Pv5IIvoJF4G3pCMrlG9+/NpKst14wWXs+O+zfzMLEmKKjxEGu0/D0BCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DG4ZUKwu; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG4ZUKwu"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-44cd237446cso234164fac.1
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 07:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784903246; cv=none;
        d=google.com; s=arc-20260327;
        b=reSIKvfwxkVTgYgQVv4BC/KcPBHC7RMKFOpzSuun7P9WEXjNdAfz8g/qJ4Plhlhdoa
         nyR82huMNRY7eXNoEPWwKWrYBujuicpkcvxQuo/mpizxKdAksvDtaTQmUg7R9CU4ci3L
         DFNtN0a4/SMwaS7QW1gpn1af9kd/QSd6L92e11IvAHRUIi0UstQHedO4SfWY71QD9Sdp
         49HvbcJRx0jegG5UIOfSdMS3z8/TfPeQih0vN9HpTXGssGKfGTqekbwycLrfLkrNT8FE
         DE6ATcKTJuNmKzUkKieKWFazr2VGF6Abab3QrQDevEXlcy8Ja5gzLwAktbmsP8suHqm2
         w76g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bt5aqS49lOFIbeVIZuPBOToz8hl51P1L0nhjZaSKyFM=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=DcYfkBYFBz7R1I2ejZjG1/ru4A3uTqhkzYBzUk+KHkuRddY+TBsTHrP7YacrxM6O96
         hSYSjo9pg/BNd4k02iLb93LJVJgTUbkc1HRjcFUv2tY2pK5/RoPOeMT4BcSu4uh6jH2q
         VpYL5gjVwduw5V3tpu7OrQGBIbSLq0LvGBNLTmpGXvfOePNJpUAcJQSipSuuEv+dXFVB
         rXVR7NvskLDRHvQOQmUcsoWobdgRm4mrF4eWOEORbJ7HK3dmv/Yuy/nq/jIeqEbjNIEV
         wUuVaD1c4PXqm9nQSeo7c1E83v9/LwlqhXK0p7SgICIP019HpzbI6zGIacq5meMDEucU
         fPXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784903246; x=1785508046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bt5aqS49lOFIbeVIZuPBOToz8hl51P1L0nhjZaSKyFM=;
        b=DG4ZUKwut/omiB2Cf1OlVZZ37txj4Oefv1DtdlwL4INySFde6iIvnAhIcI0RspEdyU
         whNVUube4gPMePNxUdldpRKaRuQbAdmuCXdrvk41i7qzGyQ6x9FlsbiFAbB/dEtkzJwg
         dwI4EoxD1CKqwzmIrkzEYslL22UUaAQ8f8je8BTjW+5OGCo71xlMEuiuUFg46WeXAEoP
         wYOBBXyN4LajCVIUWBdOd+wfwkrxARJL7Pak5Sz3dlLCSsrB+5nzJ2YVzK/pAGNXOdGm
         gWDkJ6raALRkEuysDGwUbtB4oOuY0DG9cUsLYB1tnxEOEu1yHJxbzyeVgB3JWNQy20Ks
         exqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784903246; x=1785508046;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bt5aqS49lOFIbeVIZuPBOToz8hl51P1L0nhjZaSKyFM=;
        b=k4n0QcR/scVMxR0UkaKPcbBt+esmoZFRhcTSWUM5bJ7sJPidD1Qjp6RGdOphZjv+u7
         0fScdO0DSHNyUgADoVjjTiE70LK4ZveuxNz8qetoJEgBVfsAs2S7zp2O+1l8OPAjAKZt
         CcD1+xQytFnNmrxOTBSQbX6yBHKU5Rg8oLt+d9OTkJfG+oG0zAbhpcgTHwRPsQuYCZbT
         WtCWIPA7FohquqSyMV/EGQ+KysMEWMB33bpkU9EAWgSDNQ+SGIs12cvCw1J+XxZoCldl
         kFHp3X5BlM6x/EimzcskN/0W0XGne9kLh/vlCopgb8XPL5xZAfojAWcDGs6vfdO8xT7p
         3Nxw==
X-Gm-Message-State: AOJu0YyppdkiRF8lR0WiWan1cR9pPhoyDH0k2efPG35SRpChblLm0HK3
	Z1j9DprPFwdZDtJqvAueMJJ66M7OG5zvelntWPAztjG0h2z+I2Xu0VXB5h9vAzJbK1O5eljf5m9
	tBMcFBWZF/E3RvW/BsoY69tRFVZRFDSMYSw==
X-Gm-Gg: AR+sD1002w3dLyq9gqLNzMn9FA4PZ8vhs2zs6x7xS4s3XHpSUDSKVXsErrQ1hvLfDnk
	s4xQeq6q97IsZs6U35YCbpcRODAbpu3Ds6ONG2fcXIN65mZGP6VaslCf1n6UljeyXICLQK+CywG
	IParX6Z1VxTWWYnsD0gGiyhn7sLFX4lLEYhtO2FF0HpOh8ajQznP1Hg4J1n28zG4F6CCu1I93JN
	RbsyL3Z2/gkE7QAy+byzSqE78cd2ADswQpp5kr4+kBeh2ypj9VrDpE7mQxsjA==
X-Received: by 2002:a05:6870:4188:b0:447:2e66:ab17 with SMTP id
 586e51a60fabf-457a0bcba5emr4544954fac.11.1784903246497; Fri, 24 Jul 2026
 07:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722144918.73394-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260722144918.73394-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 10:27:15 -0400
X-Gm-Features: AUfX_mxBc--Swo6zHwPsk5gs2E7i3MfNSPohSYoDlx8kD38iFxU2737tnEVUa_E
Message-ID: <CAEjxPJ5AhCXDA4W=xxPoJY8H9bZ2V370LCCM4cQYy=JNvZUoEg@mail.gmail.com>
Subject: Re: [PATCH v3] libsemanage: block on store lock by default
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 10:49=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> semanage_get_lock() polls the store lock once per second and gives up
> after sh->timeout seconds, which is hard-coded to 5 with no
> configuration setting to control it. A single semodule transaction on
> a real policy routinely takes more than 5 seconds, so any overlap
> makes the second caller fail. This makes rpm scriptlets, ansible,
> or other scripted usage of semodule fragile.
>
> Change the default timeout to -1 (wait indefinitely) and in that case
> use a blocking flock() instead of polling. Try a non-blocking flock()
> first for the common case where the lock is not held and if it is
> held, inform the user so they know why it may be taking longer than
> normal. Retain the timeout logic in case we decide to re-introduce
> other configurable settings in the future.
>
> Several other minor cleanups are included as well, e.g. there is no
> need to pass O_TRUNC for the lock file, and there is no need to set
> O_CLOEXEC a second time via fcntl() since open() already passed it.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/181
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v3 fixes the description (s/requires/makes/).

Merged.

>
>  libsemanage/src/handle.c         |  2 +-
>  libsemanage/src/semanage_store.c | 81 +++++++++++++++-----------------
>  2 files changed, 39 insertions(+), 44 deletions(-)
>
> diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
> index 77d0ed8a..1ff86e60 100644
> --- a/libsemanage/src/handle.c
> +++ b/libsemanage/src/handle.c
> @@ -37,7 +37,7 @@
>  #include "semanage_conf.h"
>  #include "semanage_store.h"
>
> -#define SEMANAGE_COMMIT_READ_WAIT 5
> +#define SEMANAGE_COMMIT_READ_WAIT -1
>
>  static char *private_semanage_root =3D NULL;
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_=
store.c
> index f14ebe97..f6ca1afb 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -50,6 +50,7 @@ typedef struct dbase_policydb dbase_t;
>  #include <stdio_ext.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include <time.h>
>  #include <unistd.h>
>  #include <sys/file.h>
>  #include <sys/stat.h>
> @@ -1944,61 +1945,55 @@ static int semanage_get_lock(semanage_handle_t *s=
h, const char *lock_name,
>                              const char *lock_file)
>  {
>         int fd;
> -       struct timeval origtime, curtime;
> -       int got_lock =3D 0;
> +       int left;
>
> -       if ((fd =3D open(lock_file, O_RDWR | O_CREAT | O_TRUNC | O_CLOEXE=
C,
> +       if ((fd =3D open(lock_file, O_RDWR | O_CREAT | O_CLOEXEC,
>                        S_IRUSR | S_IWUSR)) =3D=3D -1) {
>                 ERR(sh, "Could not open direct %s at %s.", lock_name,
>                     lock_file);
>                 return -1;
>         }
> -       if (fcntl(fd, F_SETFD, FD_CLOEXEC) < 0) {
> -               ERR(sh, "Could not set close-on-exec for %s at %s.", lock=
_name,
> -                   lock_file);
> -               close(fd);
> -               return -1;
> -       }
> +
> +       if (flock(fd, LOCK_EX | LOCK_NB) =3D=3D 0)
> +               return fd;
> +       if (errno !=3D EAGAIN && errno !=3D EWOULDBLOCK)
> +               goto err;
>
>         if (sh->timeout =3D=3D 0) {
> -               /* return immediately */
> -               origtime.tv_sec =3D 0;
> -       } else {
> -               origtime.tv_sec =3D sh->timeout;
> -       }
> -       origtime.tv_usec =3D 0;
> -       do {
> -               curtime.tv_sec =3D 1;
> -               curtime.tv_usec =3D 0;
> -               if (flock(fd, LOCK_EX | LOCK_NB) =3D=3D 0) {
> -                       got_lock =3D 1;
> -                       break;
> -               } else if (errno !=3D EAGAIN) {
> -                       ERR(sh, "Error obtaining direct %s at %s.", lock_=
name,
> -                           lock_file);
> -                       close(fd);
> -                       return -1;
> -               }
> -               if (origtime.tv_sec > 0 || sh->timeout =3D=3D -1) {
> -                       if (select(0, NULL, NULL, NULL, &curtime) =3D=3D =
-1) {
> -                               if (errno =3D=3D EINTR) {
> -                                       continue;
> -                               }
> -                               ERR(sh,
> -                                   "Error while waiting to get direct %s=
 at %s.",
> -                                   lock_name, lock_file);
> -                               close(fd);
> -                               return -1;
> -                       }
> -                       origtime.tv_sec--;
> -               }
> -       } while (origtime.tv_sec > 0 || sh->timeout =3D=3D -1);
> -       if (!got_lock) {
>                 ERR(sh, "Could not get direct %s at %s.", lock_name, lock=
_file);
>                 close(fd);
>                 return -1;
>         }
> -       return fd;
> +
> +       INFO(sh, "Waiting for semanage %s at %s (held by another process)=
.",
> +            lock_name, lock_file);
> +
> +       if (sh->timeout < 0) {
> +               while (flock(fd, LOCK_EX) !=3D 0) {
> +                       if (errno !=3D EINTR)
> +                               goto err;
> +               }
> +               return fd;
> +       }
> +
> +       for (left =3D sh->timeout; left > 0; left--) {
> +               const struct timespec ts =3D { 1, 0 };
> +
> +               nanosleep(&ts, NULL);
> +               if (flock(fd, LOCK_EX | LOCK_NB) =3D=3D 0)
> +                       return fd;
> +               if (errno !=3D EAGAIN && errno !=3D EWOULDBLOCK)
> +                       goto err;
> +       }
> +
> +       ERR(sh, "Could not get direct %s at %s after %d seconds.", lock_n=
ame,
> +           lock_file, sh->timeout);
> +       close(fd);
> +       return -1;
> +err:
> +       ERR(sh, "Error obtaining direct %s at %s.", lock_name, lock_file)=
;
> +       close(fd);
> +       return -1;
>  }
>
>  /* Locking for the module store for transactions.  This is very basic
> --
> 2.55.0
>

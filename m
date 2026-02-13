Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A2C17ADE0
	for <selinux@vger.kernel.org>; Fri, 13 Feb 2026 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770996384; cv=pass; b=MLR4nJRde9nwAZ2aa6lDWrG8KKFlwUwgJV/ZVghGfr4B7DidW/oJjMf5u7qBtzfzjFfEivzBiE6Jm/jvVKIFd5altXu3zQDzTiRX035xTonosPIeAoX4pE/LbctCurztCeUJhiw279vgl+MKIS9cuHqgRqgxXdu2+LeOjj1GhDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770996384; c=relaxed/simple;
	bh=lHAibJwCR3ROVj1G3YEx5JjwR1DAABVokI1OcLW3E+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYJh/8sJdTENtMd2klzWNa1rRLIEz7CokNEgA8r0fXr4IsbPfGnIEctopCDuhpcWojpUFDCxTfXyjmKmquQV7z6wwntBZEKAuZKlmtt200dAdkfEsJL2jNJi0w624Vh+mWhG9wb6uvKNBS3poD3fQTcYn+fbCOL2cGFyWxljZ8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSEYSSYQ; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSEYSSYQ"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59e6b736b84so860462e87.1
        for <selinux@vger.kernel.org>; Fri, 13 Feb 2026 07:26:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770996381; cv=none;
        d=google.com; s=arc-20240605;
        b=C1pRYVcMT36DBEFl7OOpeO9HS5EZtX4WEQuXE0qYcEoyWA1DO+4AyWA/0cApmJ2fNp
         t9JhVlES9E59ZWPq/n53gZfuvXd7NFz3jUYHlwMBMaDp9qd938//Ra0sosl+1B6raXWn
         iUBJfParaUR9ejDeGdRcxZoegHtWNr1uQdS0MNMK5feJU0D2J122oXKOpkQFvet6yGnq
         RPhjC1PIf85TuwtdBAkEWZIRmefuC7fQnlgP1BbGyNf9orexX+xLT8H+woWhlaCs5JmS
         XBL9PiOpbntSYjFIfJQFUtdQvzSzHIvPBj59GSNahdxWLKaH6ucXqU6VzKHGvL8QX+da
         +s2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CvSVc1XKPzRtRHtm5mJrlmxpnb7osDM86Eav0MUbsxU=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=jcf8wfqEDEL6hcFUIDPyqxPHt6TbB+5Smkha001g+7XNzUaAh33GnbarwTdmqExOt5
         crxPjbtNxIkfR9U1VcvrlzWIFCurkbJcSF/W2L4uJ1waiSuXLYuYB86sgRrUoj+B5ycZ
         CO512kYi5u+0FcbVABs7oLx9HdepffDv/BMqlqRjgeFr4CdvC7J4iRjO00GsXEL2EHua
         RNRyo4i+B93xPA8nyR3dhvfkF8ugC+EnTrffuoCWWZNRalw2z9H33FzeGn42YRhduxJv
         XFTt9ufF2/sA9ftz1JRy8Q54LCh/0bPHnn0TuY7ICRbeRwlLrL87uhcPSc1zMr6ditDB
         j/YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770996381; x=1771601181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvSVc1XKPzRtRHtm5mJrlmxpnb7osDM86Eav0MUbsxU=;
        b=DSEYSSYQIFJmNoLOWtLcTYQYa7FVFw23M6ii+fkAaR8AkRn4COmoP/r7P/xyIc9jqT
         LWqOSt8sunNjqceaKPkigirE6TQYw8oYg9NocfqKvbuqm9+MSDB6i8vdLATGx0JeKhNw
         qZHQKbposbtdEbTzOyBljvVOrYCqBXLpJPJDzAde0WHZqsyF4NKUGzN2+OxVke0KwwQ5
         04VpWyCEoaLNUMazHGKEnd74VScKYAhwPLew8RGnV8yKKKqj7XE4mE5+LQcdJE+p1qPN
         /KRnaLU/2nwptiBczpolFpjK06xp4g4mDf/c/qJAfmm44KBWv23IjYbswC53FDND54FC
         miJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770996381; x=1771601181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CvSVc1XKPzRtRHtm5mJrlmxpnb7osDM86Eav0MUbsxU=;
        b=MIVqTObBDlj81fEgxkjF24F22himOz6haKVIMAyeU0WoJra87boHq5Y8hT1Berkwtj
         0P5mNid+xYV5Uf+1JXt7V7iHDPoXTimjLx9y5cypmykAX2GDH1IAskEmqMTCImiVo16d
         2cHNXJkiHeMahFouGHTT57ZYa5L0Zrl70WPAr82XsDvAC5WBZP9054D4tmUTukBjt7+x
         pzSBdSkThn0W6tYAJD0YaFAJDj33AKxIsYWo/2q59/4XImTjXiWL//iBb5seb3vYa46W
         7HBTOF7FMSWdEKu9g6Yk3zI+NilEsbNISj9BstxbA/JSkCfp6esCC3J6OU4GXkSU14F0
         Rfpg==
X-Gm-Message-State: AOJu0YzuP7A8fj7mhIz716/AW/KZE2AePQUeMZdenqSn4OdYjfz8vqnq
	ECQJW6m6flxbLttZat45mWcosec10CoPW3cSuLDpncrna3uT1rkQlgPrPPLqFM+zVHNIE0TzrQC
	z1t+0auv8GQJUPgWSpmxJ2MOo+SWozfc=
X-Gm-Gg: AZuq6aIPBf9QZQb/rIJ0OviShHq3z5+HVa0C3w3RywBwvpsIyvraLmQOK6KQtVhWjdl
	cZWhNvvLceyZ6FEghDAVRhbrxVdvjXP0/HZM7f9RNc96jzlB6OiJ172JahsFGMVn8orysX9Npaf
	dy+WUJoJ3hZAC1/kPe8N8rg+YFjA44kscbTzR+tqR+KM8jopuG6K7AWXfBu2mLEGxEo4ok5cVlO
	2NDK/+hUr8YAkcb9LpX+OSBSUuw3qGm6in28SlC86U6jF/R1IxL3BHxofRVd3+HqMOQ0hj3LAKI
	GiuOTEcljXFlTVQ=
X-Received: by 2002:a05:6512:b12:b0:59d:fac0:3a14 with SMTP id
 2adb3069b0e04-59f69c6240amr813201e87.28.1770996381074; Fri, 13 Feb 2026
 07:26:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202143554.97209-1-cgoettsche@seltendoof.de> <20260202143554.97209-3-cgoettsche@seltendoof.de>
In-Reply-To: <20260202143554.97209-3-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 13 Feb 2026 10:26:10 -0500
X-Gm-Features: AZwV_QhfvgEsoHAwrodQBvLBUg2SHtlWKAwBeWYsDW5S6aNgiYnn6Q7zIKN3Ids
Message-ID: <CAP+JOzRedj2Fd5jt74cVpro7Soo8dTmDHneCSFOMPH1v9VhT3A@mail.gmail.com>
Subject: Re: [PATCH 4/4] libselinux: improve restorecon progress locking
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 3:21=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Use an atomic counter to avoid acquiring the synchronizing mutex for
> each file.  Only acquire when actually writing to stdout.
>
> Also reset the scanned file count at startup in case the calling process
> calls selinux_restorecon(3) multiple times during its lifetime.
>
> Suggested-by: Copilot
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/selinux_restorecon.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index b1f6f672..a512a669 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -17,6 +17,7 @@
>  #include <fts.h>
>  #include <inttypes.h>
>  #include <limits.h>
> +#include <stdatomic.h>

Again, musl doesn't support C11 atomics, so we can't make the switch yet.

Thanks,
Jim

>  #include <stdint.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> @@ -39,8 +40,6 @@
>  #include "label_file.h"
>  #include "sha1.h"
>
> -#define STAR_COUNT 1024
> -
>  static struct selabel_handle *fc_sehandle =3D NULL;
>  static bool selabel_no_digest;
>  static char *rootpath =3D NULL;
> @@ -58,8 +57,8 @@ static bool ignore_mounts;
>  static uint64_t exclude_non_seclabel_mounts(void);
>  static int exclude_count =3D 0;
>  static struct edir *exclude_lst =3D NULL;
> -static uint64_t fc_count =3D 0;  /* Number of files processed so far */
> -static uint64_t efile_count;   /* Estimated total number of files */
> +static atomic_uint_fast64_t fc_count =3D 0;      /* Number of files proc=
essed so far */
> +static uint64_t efile_count;                   /* Estimated total number=
 of files */
>  static pthread_mutex_t progress_mutex =3D PTHREAD_MUTEX_INITIALIZER;
>
>  /* Store information on directories with xattr's. */
> @@ -687,19 +686,24 @@ static int restorecon_sb(const char *pathname, cons=
t struct stat *sb,
>         }
>
>         if (flags->progress) {
> -               __pthread_mutex_lock(&progress_mutex);
> -               fc_count++;
> -               if (fc_count % STAR_COUNT =3D=3D 0) {
> +               uint64_t fc_count_local;
> +               const unsigned STAR_COUNT =3D 1024;
> +
> +               fc_count_local =3D atomic_fetch_add_explicit(&fc_count, 1=
, memory_order_relaxed);
> +               fc_count_local++;
> +
> +               if (fc_count_local % STAR_COUNT =3D=3D 0) {
> +                       __pthread_mutex_lock(&progress_mutex);
>                         if (flags->mass_relabel && efile_count > 0) {
> -                               float pc =3D (fc_count < efile_count) ? (=
100.0 *
> -                                            fc_count / efile_count) : 10=
0;
> +                               float pc =3D (fc_count_local < efile_coun=
t) ? (100.0 *
> +                                            fc_count_local / efile_count=
) : 100;
>                                 fprintf(stdout, "\r%-.1f%%", (double)pc);
>                         } else {
> -                               fprintf(stdout, "\r%" PRIu64 "k", fc_coun=
t / STAR_COUNT);
> +                               fprintf(stdout, "\r%" PRIu64 "k", fc_coun=
t_local / STAR_COUNT);
>                         }
>                         fflush(stdout);
> +                       __pthread_mutex_unlock(&progress_mutex);
>                 }
> -               __pthread_mutex_unlock(&progress_mutex);
>         }
>
>         if (flags->add_assoc) {
> @@ -1111,6 +1115,8 @@ static int selinux_restorecon_common(const char *pa=
thname_orig,
>         int fts_flags, error;
>         struct dir_hash_node *current =3D NULL;
>
> +       fc_count =3D 0;
> +
>         if (state.flags.verbose && state.flags.progress)
>                 state.flags.verbose =3D false;
>
> --
> 2.51.0
>
>

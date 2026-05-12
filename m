Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4416E33CEA7
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600281; cv=pass; b=NzUZkYQTAGE4LtT14H8ebt0QrmQxy4t07Q2DEbaaiLg04VxWQJ5RooWr/nteBY/WS2mlVdMi+OThh9JeH8EfC/5YmZJlUCC0lmU7w+MvxpFbnO2pW0Kq9LkXzEyM6EjmIeUF6aLoPlcg46v1ZopnlSxKZMXiCWdYcrvxH96L2zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600281; c=relaxed/simple;
	bh=7ATkNBP/+rAI4Nbg2k1TichKuIIm8mqrwvPiJ+ApP8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqZPT/B2L76zHF7QOvev5gb47jX3llPRcjEsmZCMa6I9rqDmJf8gX1PdMirG0WCJlpSOkbvaR3fOMYtM0XlDCmvvWVs5cugH3Dt0jkMtb6zsIz4x5p0aeeOUc2Ow9ucNY1h0siyw5RGlxEB+cPYXwwfo1Eq6PyNP3bTFaOgBDL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InrW7oYl; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InrW7oYl"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso56759875ad.0
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 08:38:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778600279; cv=none;
        d=google.com; s=arc-20240605;
        b=KQzO3Oz9ldt7FgqcbccD/vRzD34Wv8fKZ6z7MyB4rtKoapqBbMLnlU02oLp3ynpCxQ
         tKRS/lj6JqbamBIXSwGbNSDpMo+XXuACs748l8p7QXTZ7VNBSXV1uXImcdGrj9T8O9FO
         o7NQvWtZd/3Y9geJ3tOjlGbaHDCJ58Xy4+x/UDYgcDeBZtbAO35Km+PI8WKBcB0zymCS
         3JiEkT7kp6aQZUwyZih531eCDTjr1JJaYQM7jM8zLQf2VUIGGEiocXBL6M+WoAB2K7oF
         HEhO9o21jHNtN8ADNAmt3pWFZLr4fEuYsMCHwjkIyCtPN2ZdYtW4yZl7zLiExRUrMg9s
         x91w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z6eJzTDq44W1j6V3csIu47+ShxM0e5Yw+Wf4gN3nVx8=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=HpGVmjAykX/7ot27auNpCh3zJQJSiQgpHgFtRZ8xLm4q15ZmInkW14efTcQ2SMhmyn
         9hiyuckBubPFUELsBNSPHwLJwD6mzojsrv8V2Vf7UVckd5tatNqX97fSIKOAOYkHSvlv
         UGDpl7LIjsK2YK5IkCFZOK4FpXDiWPg8iN4JNVpW9c3+n0uEO0NbwofM+GIQlTEm30e/
         qKLPHnEb+EdMUAvee0h2XsUunJPi7YP3k7sVueXK75YkrzJGtAgPm8JoH/IEHRAIwBT9
         bZvjRa3KP93y94ExSZrnPhvnbuhdQ7zXGuNTCAf7oSab1qJOJcdEDc7mnq/vGeqOqLKF
         2gcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778600279; x=1779205079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6eJzTDq44W1j6V3csIu47+ShxM0e5Yw+Wf4gN3nVx8=;
        b=InrW7oYl3SBmiAdYEhaqmSKhsupJZ4K1sDCauwo9VkINNaoQbSYdkBnPZEzwZaEs8+
         a1k3YLcfZAYAdI2Go7+lsFMfF8yS6QTGelOAURXfCaoNLOHBMJjGkJdXgBHpf8fTeajL
         8vHZEpteY/2qzOkRWTIkxRMc4NuRVApYd9q9nVZ6/BC5KXRV0lmuaWMw2ZI9fcj7RTqQ
         ApChYxS9mRk6GS0i4mYOiPqb33t0n9Ury3Lv7w3qbI1FhziZ5etwd7vb3wniM3KzGzVx
         sdjXoCcMhg2ajoNt6es/PFdKhyxEG3AY1ldheVVIhS83OIB1NlZvhf4z7DvSVp9N0NZM
         Njyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778600279; x=1779205079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z6eJzTDq44W1j6V3csIu47+ShxM0e5Yw+Wf4gN3nVx8=;
        b=AFwB/EFL/QavrYFq5+oq7iS2oh7sM+jNrkYcxD9jqhLSelxARRGRptAM9UtzCL3FBn
         iQl3RiH2/vdRfutsvUQkC9GM8/D+uSMWg4ebAbtIQ0/1EUdJbrBASs24nqIycif2FM3z
         lwi8WcFxxoxPFsxa77uifH3KePE7cBND6DyMQ7OdfeVZq8/8RRfOwwEwHnEQDsxB4KQ5
         4AqcDTLgbF+W5rBJQkzbAPy5lw2pwiQYwS3oyz+HSKKaDvLeZvJsrtbv8FnU/F2c+RO3
         xrqUYt92mfl8Q8Cp2K7SvlAUwF5yKLYnakQfwoUYUHSmh4mg7/rCeUCmi/MrN2MhQTp6
         A0gw==
X-Gm-Message-State: AOJu0YyXkdjkgG1nozMGnNv8WnC1gixaC7OsvQMzyNixYn5zgsXEycOA
	LgF0fa0T++EUg1E7Feaa88Px5jZyrwvEYu0UXFOmLyBulPUaX3P0EqC+Kg6qzrp/+PKGx7+B007
	EdDkRryw3jHVBCeiO2hLhILhGM6RtoRsR17pP
X-Gm-Gg: Acq92OGixRj26OF+5nDxVFPvyYPhSCXXYdPYqfkjgnNNBw2/942C7DhWEhI0DEElOv+
	xuvjOztq0wBDNCDUeaYQRQzgMkxPrXobxOJtvwjnRPsrJaJzU8IqVhAfwz8ScPpdRz7PAX+BajZ
	8327PF7gqf3uMIorEgsPGG7PmgK+2yFhL2NtACJr+QvckegF1JDbb/cEBawMiToFsFJ08YNgDbi
	PEz3Y9lAPNteWJ406d+jJ8tEaXeDs7gUu5ouSdIrSIqsmRWvreL9gwIweoDKY6YJweCZnDMLJyZ
	AVbn+ksDHPvN0wwtXg==
X-Received: by 2002:a17:902:e986:b0:2ba:df8c:11d3 with SMTP id
 d9443c01a7336-2badf8c1b77mr172875515ad.32.1778600279428; Tue, 12 May 2026
 08:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427162452.132118-1-lautrbach@redhat.com> <20260427162452.132118-2-lautrbach@redhat.com>
In-Reply-To: <20260427162452.132118-2-lautrbach@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 12 May 2026 11:37:47 -0400
X-Gm-Features: AVHnY4IsZzTDcM0fbQx7t0v2n6MwScPyGdNaIikBFY5TtBZFzPWL-0UZk9jxc_8
Message-ID: <CAEjxPJ6mM1q42daOh3BXOoxUEv3R9KX9c1rMamnQknMd1MxwGg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_2=2F3=5D_libsemanage=3A_Do_not_discard_=E2=80=98const?=
	=?UTF-8?Q?=E2=80=99_qualifier?=
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 12:26=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
>
> Fixes build errors like the bellow with glibc-2.43
>
>     utilities.c: In function =E2=80=98semanage_str_replace=E2=80=99:
>     utilities.c:248:16: error: assignment discards =E2=80=98const=E2=80=
=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
>       248 |         for (p =3D strstr(src, search); p !=3D NULL; p =3D st=
rstr(p + slen, search)) {
>           |                ^
>     utilities.c:265:16: error: assignment discards =E2=80=98const=E2=80=
=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
>       265 |         for (p =3D strstr(src, search); p !=3D NULL; p =3D st=
rstr(psrc, search)) {
>           |                ^
>     utilities.c:265:52: error: assignment discards =E2=80=98const=E2=80=
=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
>       265 |         for (p =3D strstr(src, search); p !=3D NULL; p =3D st=
rstr(psrc, search)) {
>           |                                                    ^
>     utilities.c: In function =E2=80=98semanage_basename=E2=80=99:
>     utilities.c:358:19: error: initialization discards =E2=80=98const=E2=
=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
>       358 |         char *p =3D strrchr(filename, '/');
>       |                   ^~~~~~~
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>


> ---
>  libsemanage/src/direct_api.c | 2 +-
>  libsemanage/src/utilities.c  | 8 ++++----
>  libsemanage/src/utilities.h  | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index 8f909a3bbf55..424360a68354 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -1755,7 +1755,7 @@ static int semanage_direct_install_file(semanage_ha=
ndle_t * sh,
>
>         int retval =3D -1;
>         char *path =3D NULL;
> -       const char *filename;
> +       char *filename;
>         const char *lang_ext =3D NULL;
>         char *module_name =3D NULL;
>         char *separator;
> diff --git a/libsemanage/src/utilities.c b/libsemanage/src/utilities.c
> index 004ffb627d06..90cc4a3ce990 100644
> --- a/libsemanage/src/utilities.c
> +++ b/libsemanage/src/utilities.c
> @@ -234,8 +234,8 @@ char *semanage_str_replace(const char *search, const =
char *replace,
>                            const char *src, size_t lim)
>  {
>         size_t count =3D 0, slen, rlen, newsize;
> -       char *p, *pres, *result;
> -       const char *psrc;
> +       char *pres, *result;
> +       const char *p, *psrc;
>
>         slen =3D strlen(search);
>         rlen =3D strlen(replace);
> @@ -353,8 +353,8 @@ int write_full(int fd, const void *buf, size_t len)
>  #ifdef __GNUC__
>  __attribute__((nonnull))
>  #endif
> -char *semanage_basename(const char *filename)
> +const char *semanage_basename(const char *filename)
>  {
> -       char *p =3D strrchr(filename, '/');
> +       const char *p =3D strrchr(filename, '/');
>         return p ? p + 1 : (char *)filename;
>  }
> diff --git a/libsemanage/src/utilities.h b/libsemanage/src/utilities.h
> index 7481077aaedb..18abc7e628ad 100644
> --- a/libsemanage/src/utilities.h
> +++ b/libsemanage/src/utilities.h
> @@ -167,6 +167,6 @@ int write_full(int fd, const void *buf, size_t len) W=
ARN_UNUSED;
>  #ifdef __GNUC__
>  __attribute__((nonnull))
>  #endif
> -char *semanage_basename(const char *filename);
> +const char *semanage_basename(const char *filename);
>
>  #endif
> --
> 2.54.0
>
>

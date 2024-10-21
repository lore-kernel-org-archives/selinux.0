Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A663146A66
	for <selinux@vger.kernel.org>; Mon, 21 Oct 2024 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539027; cv=none; b=QLGHOctoDmptoMaplQnUG1RyharTYaJob/dH2KJ8epXYW6axy40zGohLVtUelApYoZmLjftvHwBLM8mecgtHkCxx0ykEILQDlPhsjVc8+Cy9DpiX8ieDrhOqw3xITFeESidVHHQEx8aUGMKcknUmu4beovAEDmRxRZDD1JxeBl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539027; c=relaxed/simple;
	bh=hVwMeF/n5WFV90EprINyMONEJg1nDPnsWC2/x2t63o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ql/NoUBsuk/R4/c6L9Ij+xm2561iOZdwRq15/3RQtZgTYyQvhR0LWjndJsqD5XMvWkQ4BNW5PyTnUFtuftpDHcqP5CFyB/eme6QaEcr1wHR0hUDps2x42hB5PqwrEYwlvO8ELG4vmILByAXjsWWyWRQmeeMlKXsEgFlbVYI3EXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWLNwT8b; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWLNwT8b"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-84fc0209e87so1592887241.1
        for <selinux@vger.kernel.org>; Mon, 21 Oct 2024 12:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729539024; x=1730143824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Buj5xIptUlrEgOxtN1BLFDlOi3OS+shoZPmN3w6WgHc=;
        b=WWLNwT8bL2rekjhNv6hWlglL9DITvktAfPEhqpyjrx7OrRVqfNxAbzBJB6k2sj5nyr
         1u3CzwlhXoIG5NdTNkcAKAzX/s+2Ufe4Ng3uqBZFT8ZxRIMIU360DdRwg+4x724OFIN1
         nnWzwsLMDesfUehomZUos6LRDUl9b6Ndh4jWi7DabUYNE1v+Z8Q/iatbz6yIR5PzRPlq
         pGgX+m/h2lCZZlGH1MpRB3ulzOUrxEPIZCxOAm1DRjrrJbAdkX9kUDrrOpIb+ZTYX7vK
         5cIfHDw27DHtp3tw83V2mGrrnPjDtrv8PTfRCf9Qp1Y+0m0u+/Jc7zTv1r9YD/zdclhT
         mA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729539024; x=1730143824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Buj5xIptUlrEgOxtN1BLFDlOi3OS+shoZPmN3w6WgHc=;
        b=EGsKlGFWOBEpWsy33xODp7Ob/73NYm3B+WZoBaEKrzLGTiy/qjGq2Pb9620e+gIqmx
         HrisCcBV/rGcVBmQjUWyb+AKZQa824Ounc6lqWy+PSmXq++vJryyeygBkyNKJaZWPaf3
         ueTvQc9lKFatZNlRXV3VFN7gaDOr+11a1CNyljzSNre0K4f46zIs6i1SWe9FpmPGV0SD
         xPkt3HWTX2gVpqvm3eLyZB1n59T6RBXTSSz2X1iAUPSwFHYM5na8SmU2nrQR+t2VBi/W
         MMnQ8OcMAM905apHMEtaKGAZh7ykJO4ojoqw+ZbL4QtCAnNOD9a+IFTYgHeMYJi49uOx
         9YHA==
X-Gm-Message-State: AOJu0YxPOBuQsRrBjIGjVb0JnHlSus1wxodLzgmvSkY6GFGt8JD2d7JG
	F0Lq/RnZHNwkLMHSVIoskzESPPQeSVicV5G0bES6hwSyi4TTddKzf9+Kg63VA6UbmrJKW4LPb5v
	BcSxaAAGmXHVuSdNvk3YSvU4qG8dKfCKO
X-Google-Smtp-Source: AGHT+IFYBzL6v/sTNDCuUJBPoqd0d2KAOpkNSwArDlYNsmQs0yKu2enuUmMVncaCae+WsxByqYWrzQeWu6MVVV0UKHc=
X-Received: by 2002:a05:6102:374f:b0:4a4:9363:b84c with SMTP id
 ada2fe7eead31-4a742d0e72amr105889137.6.1729539023823; Mon, 21 Oct 2024
 12:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018151300.445618-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241018151300.445618-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 21 Oct 2024 15:30:13 -0400
Message-ID: <CAP+JOzRwYeawhhALJpcHftegkp_f_Ni=Vz8zhZs7Dftm8fV1hA@mail.gmail.com>
Subject: Re: [PATCH 1/4] libselinux: avoid errno modification by fclose(3)
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 11:13=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> In case fclose(3) might modify the global variable errno, use a wrapper
> retaining the errno value.  In the affected cases the success of
> fclose(3) itself is not important, since the underlying descriptor is
> only read from.
>
> Reported-by: clang-analyzer
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these four patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/get_context_list.c |  4 ++--
>  libselinux/src/label_file.c       |  4 ++--
>  libselinux/src/selinux_internal.h | 11 +++++++++++
>  3 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_conte=
xt_list.c
> index 0ad24654..222b54c1 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c
> @@ -438,7 +438,7 @@ int get_ordered_context_list(const char *user,
>                 __fsetlocking(fp, FSETLOCKING_BYCALLER);
>                 rc =3D get_context_user(fp, con, user, &reachable, &nreac=
hable);
>
> -               fclose(fp);
> +               fclose_errno_safe(fp);
>                 if (rc < 0 && errno !=3D ENOENT) {
>                         selinux_log(SELINUX_ERROR,
>                                 "%s:  error in processing configuration f=
ile %s\n",
> @@ -451,7 +451,7 @@ int get_ordered_context_list(const char *user,
>         if (fp) {
>                 __fsetlocking(fp, FSETLOCKING_BYCALLER);
>                 rc =3D get_context_user(fp, con, user, &reachable, &nreac=
hable);
> -               fclose(fp);
> +               fclose_errno_safe(fp);
>                 if (rc < 0 && errno !=3D ENOENT) {
>                         selinux_log(SELINUX_ERROR,
>                                 "%s:  error in processing configuration f=
ile %s\n",
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 2fad0c93..40628e2c 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -628,7 +628,7 @@ static int process_file(const char *path, const char =
*suffix,
>
>                 rc =3D fcontext_is_binary(fp);
>                 if (rc < 0) {
> -                       (void) fclose(fp);
> +                       fclose_errno_safe(fp);
>                         return -1;
>                 }
>
> @@ -639,7 +639,7 @@ static int process_file(const char *path, const char =
*suffix,
>                         rc =3D digest_add_specfile(digest, fp, NULL, sb.s=
t_size,
>                                 found_path);
>
> -               fclose(fp);
> +               fclose_errno_safe(fp);
>
>                 if (!rc)
>                         return 0;
> diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_i=
nternal.h
> index 450a42c2..372837dd 100644
> --- a/libselinux/src/selinux_internal.h
> +++ b/libselinux/src/selinux_internal.h
> @@ -2,7 +2,9 @@
>  #define SELINUX_INTERNAL_H_
>
>  #include <selinux/selinux.h>
> +#include <errno.h>
>  #include <pthread.h>
> +#include <stdio.h>
>
>
>  extern int require_seusers ;
> @@ -131,4 +133,13 @@ void *reallocarray(void *ptr, size_t nmemb, size_t s=
ize);
>  #define IGNORE_DEPRECATED_DECLARATION_END
>  #endif
>
> +static inline void fclose_errno_safe(FILE *stream)
> +{
> +       int saved_errno;
> +
> +       saved_errno =3D errno;
> +       (void) fclose(stream);
> +       errno =3D saved_errno;
> +}
> +
>  #endif /* SELINUX_INTERNAL_H_ */
> --
> 2.45.2
>
>

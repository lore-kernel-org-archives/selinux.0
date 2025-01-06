Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAD112F399
	for <selinux@vger.kernel.org>; Mon,  6 Jan 2025 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176079; cv=none; b=B9xrtpmhCb9QzGWGnMLdj3yBdqKitoLxyykIDWIgdpsKEs7XnO9gy0d7dk9NrzycO/VY9zCNZTwqC+YcWJ6lTKabEqqZ4mcoNxc0QknvYtS3d5UkTpUUQQgf1RGodvFk9WMJuUPyu/BrY7070NjfNkgOfKWOhTAw5DWxDwn/og8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176079; c=relaxed/simple;
	bh=x3T++d4rKJQ3XKXESJBm+zgYA7ALYnC8IuFrnN1cyXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjDg5zTWZVMr0wIBUEQs9VpLKpZ4nhOBCg6L1dvPBBgBKlLTd6rzpkO6C0V+ZuiqODB1ZQW68iGqx51q6Szk99z2tv3Rba3iGh9XwP3tPjxq8TRdlc56Tf3svCSdzvjPwlONJP3teejhFWGbQrM7Fhkd1hzL8buGT/mR7QkEA2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2aJ9p41; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2aJ9p41"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6f8524f23so1584482085a.2
        for <selinux@vger.kernel.org>; Mon, 06 Jan 2025 07:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736176076; x=1736780876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KwD5INIVkLZIXvsctWJRYcj/Z9jUrKP6jACpo/bYSU=;
        b=h2aJ9p41+1gtxki12YrzJ7LbNXwIauByktaEe/XqZDy1R5YzbI7W5g/6H/ISGuPkA1
         sHo14HYKGjEESsFBQmPZZpiNbpUT48638a5yMCrlE43YYJDudWk9rwHjCTYoqWAue3fK
         6KhFi66O0yKCYd0HHv4Z1JA1Y4CrAAs9hQNQzHzH7+gccbkl7WRjh3ESK5gOy45DgMTV
         T4al5EzcNE6kBNuiwXm7ECfDtq06Pjqp8Rs7QxIhxOZ7K/xn/HeLfDRgQY7xvBuTLNlE
         tG9xmM9EBbb1u0Q6LaLtryw/zDpT+ukO+vgSjh0z4HRnRzUmtjGEayUDmeMhiKr+9hRH
         x2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736176076; x=1736780876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KwD5INIVkLZIXvsctWJRYcj/Z9jUrKP6jACpo/bYSU=;
        b=ToIfuD3MLZtkWb7p2B3dqXNu5mTPs5JyBOB1j23D8ge8bbJmJJsFeYFMxfw/0WPngP
         qafwQLnFaFCLl4gH0gYJlEnV9P2K75nJwgQpMnR+Dk10Ck9088K9PYcwVMiYEduX9u1l
         ++/ERefs6W5dUJtDpSBa7zGXrRWBAi+ZRy5k+zkAtj559vNQpnLBMK2Owqq1Knd9hZGP
         VRd9FiZ7BERSPVxKaeIV/R9/ZaCUgHpkDQEGCfmyf7chRVQ/80T5bRpMVUzbLtdeYIMU
         rox/kmJXZ30gbzcFssC9p45qP6/Klgz5WHg9oGWxLSbc9G+LBoGeYU2ScDZhbmfIAFvL
         99LQ==
X-Gm-Message-State: AOJu0YxHEt+ub0V2HukF0HzhuzTMZ/uK8Csx+CqcPhjMGhmmW3O7f4xe
	vj78osDMridKTuPgoBEqi4ePHeTJLaOnqf3Kwfcb7p1rciLWsSXWVlOnGa7RQKzoMQXRWu1kyIm
	CxWjS8SlpQznqk5VmyUgim7ntpd2oo5mc
X-Gm-Gg: ASbGncvc2U35UY1KeIuvPeVqAnY4J9imnLEQGfgc9dh8Ozy1i/Xen+kKPz6/u6Ij1el
	LzL+CzKu8QXi3mwnfpZOtfJXE+3g9P5v+d+t2kw==
X-Google-Smtp-Source: AGHT+IH+zq+T90dZICyUvtoal1FlQDsHzlPVLccUSzEs1VB6Wt7hHHmCCXVBtpJQrk71Y2be5YyqrgZGWyZVJTIvs24=
X-Received: by 2002:a05:620a:240f:b0:7b6:e8d4:9b82 with SMTP id
 af79cd13be357-7b9ba7c1e3cmr8547809085a.33.1736176075724; Mon, 06 Jan 2025
 07:07:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217212752.23866-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241217212752.23866-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 6 Jan 2025 10:07:45 -0500
X-Gm-Features: AbW1kvZ1YyzmDKBHLvvNDZQ8JZdxpzlOIrSOA2JSgMysajSJC0uIlZ4xMc04Qxo
Message-ID: <CAP+JOzRTuWzAO2SBmHD8EbDXTn3Qjwmk0kkTmoiavUdL_my3DQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux/fuzz: readjust load_mmap() update
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 12:04=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Update the fuzzers for the input number parameter addition.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/fuzz/selabel_file_compiled-fuzzer.c | 6 +++---
>  libselinux/fuzz/selabel_file_text-fuzzer.c     | 2 +-
>  libselinux/src/label_file.h                    | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/libselinux/fuzz/selabel_file_compiled-fuzzer.c b/libselinux/=
fuzz/selabel_file_compiled-fuzzer.c
> index d1249a76..09fbddd1 100644
> --- a/libselinux/fuzz/selabel_file_compiled-fuzzer.c
> +++ b/libselinux/fuzz/selabel_file_compiled-fuzzer.c
> @@ -195,7 +195,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_=
t size)
>                 goto cleanup;
>
>         errno =3D 0;
> -       rc =3D load_mmap(fp, fcontext_data1_len, &rec, MEMFD_FILE_NAME);
> +       rc =3D load_mmap(fp, fcontext_data1_len, &rec, MEMFD_FILE_NAME, 0=
);
>         if (rc) {
>                 assert(errno !=3D 0);
>                 goto cleanup;
> @@ -208,7 +208,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_=
t size)
>                 goto cleanup;
>
>         errno =3D 0;
> -       rc =3D load_mmap(fp, fcontext_data2_len, &rec, MEMFD_FILE_NAME);
> +       rc =3D load_mmap(fp, fcontext_data2_len, &rec, MEMFD_FILE_NAME, 1=
);
>         if (rc) {
>                 assert(errno !=3D 0);
>                 goto cleanup;
> @@ -221,7 +221,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_=
t size)
>                 goto cleanup;
>
>         errno =3D 0;
> -       rc =3D load_mmap(fp, fcontext_data3_len, &rec, MEMFD_FILE_NAME);
> +       rc =3D load_mmap(fp, fcontext_data3_len, &rec, MEMFD_FILE_NAME, 2=
);
>         if (rc) {
>                 assert(errno !=3D 0);
>                 goto cleanup;
> diff --git a/libselinux/fuzz/selabel_file_text-fuzzer.c b/libselinux/fuzz=
/selabel_file_text-fuzzer.c
> index ed67ea25..1f8942dd 100644
> --- a/libselinux/fuzz/selabel_file_text-fuzzer.c
> +++ b/libselinux/fuzz/selabel_file_text-fuzzer.c
> @@ -167,7 +167,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_=
t size)
>                 goto cleanup;
>
>         errno =3D 0;
> -       rc =3D process_text_file(fp, /*prefix=3D*/ NULL, &rec, MEMFD_FILE=
_NAME);
> +       rc =3D process_text_file(fp, /*prefix=3D*/ NULL, &rec, MEMFD_FILE=
_NAME, 0);
>         if (rc) {
>                 assert(errno !=3D 0);
>                 goto cleanup;
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 597b756e..60ebbb47 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -60,7 +60,7 @@ struct lookup_result {
>         struct lookup_result *next;
>  };
>  #ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
> -extern int load_mmap(FILE *fp, const size_t len, struct selabel_handle *=
rec, const char *path);
> +extern int load_mmap(FILE *fp, const size_t len, struct selabel_handle *=
rec, const char *path, uint8_t inputno);
>  extern int process_text_file(FILE *fp, const char *prefix, struct selabe=
l_handle *rec, const char *path, uint8_t inputno);
>  extern void free_lookup_result(struct lookup_result *result);
>  extern struct lookup_result *lookup_all(struct selabel_handle *rec, cons=
t char *key, int type, bool partial, bool find_all, struct lookup_result *b=
uf);
> --
> 2.45.2
>
>

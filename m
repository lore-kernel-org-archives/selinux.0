Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6001A0BF1
	for <selinux@vger.kernel.org>; Mon, 30 Dec 2024 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735559369; cv=none; b=XjNnAd3b/RR3EMCRRdeZ42+qGOUl3IvSLN6DetLV/MHIx0uPWRs5YvUZpCfLDqMedwTRnwySlmNcMFDTrgjefG0/LUSE2gOlXC1YpN5WYiy5wN+rA4hrHeDzUZZ84nCkyD5oYmj4cjgNQwDw0EBX2kGqy/bLetiFOdQrbiOmzyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735559369; c=relaxed/simple;
	bh=yPHckcGt5AQbY4O1EoBubWHnyFJIr31nRjEqRdnoG+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEonX7dm8WB5C51L0gNA3Wr3OPgT4PGQPR3lkLlOEvoszSzKi768E/NftX7xJpT6PczqraHYSYWeSUoeC0ecOTNFFtftIu4L1ucKBDA+R5Q17FD3++UPRODBEiIPA3im6efiUMgh2ySrAg9YxzCYOlbdoKdgOm9WWRSt8D/nu5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=UYSTflNo; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UYSTflNo"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso11886493276.3
        for <selinux@vger.kernel.org>; Mon, 30 Dec 2024 03:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1735559365; x=1736164165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bw3IhXFBATGqJtlSQ0dGdrxGqYlLXu8zgwem7qJDXX4=;
        b=UYSTflNoRR9zyWCLwJ7G0KtGHOqJ2S02tsOd2PnZShghWveNkNB/LwVEyIyhoz2KAH
         j7FcHbp+HerhEYKIC9h1g1lreDNA2QAzqhzES8ofgmvHdFKtcv2WtBRZWe+whpa1qjiW
         zfePqiPC93p3mHHSQFD6SBAbRJXl4BPyWolmBK2u+q8NqkuTbWR+YVj+3GSGtiljEfKV
         x+G3VHHj56xc6/YY7AaIj9axjQu6WQxpjyQpqyQtJf36+gLPT3yVm5NVA7NveXHXVz2j
         xJLnWU8fIZ4itfF0db90tcCHmr9T8A3cvfWLckJm7727KQNAAyhhLu36rT9ZEZMAoIUR
         RXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735559365; x=1736164165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bw3IhXFBATGqJtlSQ0dGdrxGqYlLXu8zgwem7qJDXX4=;
        b=s3jaBZ2DkbbjxoAVtQxJJs/5pqUUAJ2I/X4L/n9odwgXvgmt/ZMMVqObTSGx1vLe3v
         25n6t5dDT9FFJrRFXDDTzbRBQ9HT9lcUyiwa7oqtU4QKJEuuTvXtUZM8GCwz3HWUelC3
         QWPpMH4/gf+/5Z7MoLRo+uWKDsTWCYOMwPRC3wD05zR2vFY29FW3RSo2C6FSLsP32ia2
         8+FJ73JNPS/fFn6x0hu6SCyiwsTrwFQwk0rQP8qxAyXEs+QgykLodCYriEcb1QzUeAl+
         eJSK7P0ve28L7AKZCLSXgl9Hr9/N2cCWuWe1GOmwClOW4NAj4ttFr/N0Mi0jCDabH8d/
         BFnQ==
X-Gm-Message-State: AOJu0Yx4/q4nO1+ar0PNcPeXdE0SrAb/Rwi6VnU0uSGycTDfSQc+t6Cu
	LplPJdAKvyBXB4yYit1sdf2N1xkzEd6z7kDC7VTs4GixUDKMcgHn8hTRJUV4grOfdIxKFtQgZm0
	jF13xGi/FqqQ9Qb0aPQdiriAGE6E=
X-Gm-Gg: ASbGncvTMuwzJg/Nl4WBM7n4z/G1J8AzhPcAJoa5uDyArM7/aT5MyVngIpAPsSYl08H
	A9gJdpQYSqexJjVkXre6X65Rzgy+vutY5aAM=
X-Google-Smtp-Source: AGHT+IHTmg+VGxBz+QeJAgoqhcEsc8xZq81zthQpCbnRbAsOh6iKxdmC3Ec7aIl8ITeWJ2q3hj/d2GKybGD2nv3qs94=
X-Received: by 2002:a05:690c:6005:b0:6e2:ada7:ab3e with SMTP id
 00721157ae682-6f3f821a3femr231820397b3.30.1735559365145; Mon, 30 Dec 2024
 03:49:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217212752.23866-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241217212752.23866-1-cgoettsche@seltendoof.de>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 30 Dec 2024 12:49:14 +0100
Message-ID: <CAJ2a_Dd+jLPdJUYqSpCepbUfC-fKCajYU+NBD6+LydB=ejDgRA@mail.gmail.com>
Subject: Re: [PATCH] libselinux/fuzz: readjust load_mmap() update
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Dec 2024 at 09:06, Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Update the fuzzers for the input number parameter addition.

Hi Jim,

could you please have a brief look at this patch and maybe merge it,
so the fuzzer can get some runtime before the 3.8 release.

Best regards,
       Christian G=C3=B6ttsche

>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
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

Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7281C5490
	for <selinux@vger.kernel.org>; Fri,  6 Dec 2024 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733517649; cv=none; b=o0dsJjEAOevvX2OhlMJykalp+T5kBPai58Sy9ulxCnfHSm9J6JIKIHr4PGrTmgL55UeXbHXjzLE4/hRoawKJj85vYJLOcTRkjK84jVtr92S5ntvuX/sUmjBpXLDa4uEBMMuvP6d8W3J3YmEHir4JG53AQs/Rfk7hBEgbebYquz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733517649; c=relaxed/simple;
	bh=fJT1dlAMaK9lMq13nlht4e/BvXcgNx3hLW60hYH3v8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbJToMM6bbwLLmZPd6ORf17dRLIBq/p1Nut7uNt67j1gyrSxq9D8PDPeiwf5n903HvF+PdTgeYElPytnl76WbQOByYS6+sx/6DBYpirh55sed8Q+i/o5YplOwgWNODiRgZzzM7DHTkmrveLc38X+mWFdqyp0oqdcKrGKgSSMnyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjuqsy+f; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjuqsy+f"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-85c5adbca8eso74898241.0
        for <selinux@vger.kernel.org>; Fri, 06 Dec 2024 12:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733517646; x=1734122446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwsBdr0A3pueEAWYZ1C1f+m+UnF2jxrx8j5afc/rqP0=;
        b=gjuqsy+fAcqiOQ2eJy1EKikWkp1+UAZRk8/m5lPb3IMU6OH8TZgudun5N+Ry+TINBq
         UOfiyDddZwcjewy1RjKNjxg1BRHOJiXtUX0+cGgs7GA8YkEZVxNt1s0YQx3vc6Lxkx4k
         Jd/L+vxJ300DW4bKqy/qTqRBnVgLE5e+uSkYCaasw3faBR08Oj1naPlebe/+NB8vZ/7U
         NK+4RkrQeenu+zTqfjr1JYoTT+QnOpHV/bvsfcEeXwfCervpmJe4uB4vwuuGx5xQi+wG
         NAStQz68jefB0sOk0hasubNq+uPOZADeNlQuDDlDbn6QwnNi1j1h5bjmkhWa91ILpQOt
         mNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733517646; x=1734122446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwsBdr0A3pueEAWYZ1C1f+m+UnF2jxrx8j5afc/rqP0=;
        b=mZMGPeNimXAkFECkGLFakPASL0Vj5ZwCncnCVpjw6J8E6YalzDWhTnEtygRpugtBrW
         TdnHuRyscjXW14Ug5hBfUz/RiPfvgpufP5IccDXUTRiGrpaw8qnyo3w203oTMIspB1Fg
         3p64XTFDb9gXvvJrU4JufWQIciXdZJgB4omDvEoN0+0aW4iqA1m2tiJTW5xGufELpSd+
         QL43Vms0G1qPafh1q86wR2kA3uCL4TF1vD0w/Mkq7zhTGPTOcMVSucW2TykqAJjkJcNi
         JWySdjcRGpSlFWlZCYQgE73VxnazVsX+9gkogByr9VZy+b1MepLfG9F2Up/VqXBReDE1
         cUZw==
X-Gm-Message-State: AOJu0YyQWndhYbnzHHbkdx0PGUxHYVrjb21/XHGs02mesKre0TAWrI0R
	6/nwIWVdpNtpOq+BCbpAQqzFfqFXkZ53g8Q2YCNVIMijcXvYRSNoSTwFFCvwTp9/gvVcqcWrCCo
	yjcDMs4FjuVukyheJMATVno6RMo3dDXLd
X-Gm-Gg: ASbGncvLY/qUtOMyNbeC0VyPM4Uq8C5La/mKh8Fhu8f4WFnqHvZY8RqKjHYU0WFMNpe
	byp2RBRRjLpSpBDNLJ+HBqz6r16KJDV8=
X-Google-Smtp-Source: AGHT+IGh2y+oXjuaZ+sX2Mc5Lyyvc5HYvxtuR0L+O4Clir83YzbfBSS1HK+mBXkQfr+ASlhWKJNri+L0VjIycSeKLVY=
X-Received: by 2002:a05:6102:54a6:b0:4af:bda1:8109 with SMTP id
 ada2fe7eead31-4afcaad6f62mr5844120137.21.1733517646317; Fri, 06 Dec 2024
 12:40:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205193005.20532-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241205193005.20532-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 6 Dec 2024 15:40:35 -0500
Message-ID: <CAP+JOzRpOOJ4WcJ7dpNYRTdgOP7zSDS4Vieeb_DDugigj-+DAg@mail.gmail.com>
Subject: Re: [PATCH] libselinux/fuzz: update for lookup_all() change
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 2:40=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Commit 89dd0b23 ("libselinux: avoid memory allocation in common file
> label lookup") added an additional parameter to lookup_all() for an
> optional buffer the return value might be placed into.  Update the
> fuzzing related code accordingly.
>
> Fixes: 89dd0b23 ("libselinux: avoid memory allocation in common file labe=
l lookup")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/fuzz/selabel_file_compiled-fuzzer.c | 2 +-
>  libselinux/fuzz/selabel_file_text-fuzzer.c     | 2 +-
>  libselinux/src/label_file.h                    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/fuzz/selabel_file_compiled-fuzzer.c b/libselinux/=
fuzz/selabel_file_compiled-fuzzer.c
> index cf0710ad..d1249a76 100644
> --- a/libselinux/fuzz/selabel_file_compiled-fuzzer.c
> +++ b/libselinux/fuzz/selabel_file_compiled-fuzzer.c
> @@ -232,7 +232,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_=
t size)
>         assert(cmp(&rec, &rec) =3D=3D SELABEL_EQUAL);
>
>         errno =3D 0;
> -       result =3D lookup_all(&rec, key, mode, partial, find_all);
> +       result =3D lookup_all(&rec, key, mode, partial, find_all, NULL);
>
>         if (!result)
>                 assert(errno !=3D 0);
> diff --git a/libselinux/fuzz/selabel_file_text-fuzzer.c b/libselinux/fuzz=
/selabel_file_text-fuzzer.c
> index 5d851de1..ed67ea25 100644
> --- a/libselinux/fuzz/selabel_file_text-fuzzer.c
> +++ b/libselinux/fuzz/selabel_file_text-fuzzer.c
> @@ -178,7 +178,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_=
t size)
>         assert(cmp(&rec, &rec) =3D=3D SELABEL_EQUAL);
>
>         errno =3D 0;
> -       result =3D lookup_all(&rec, key, mode, partial, find_all);
> +       result =3D lookup_all(&rec, key, mode, partial, find_all, NULL);
>
>         if (!result)
>                 assert(errno !=3D 0);
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index c7fe3a48..562c3da6 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -63,7 +63,7 @@ struct lookup_result {
>  extern int load_mmap(FILE *fp, const size_t len, struct selabel_handle *=
rec, const char *path);
>  extern int process_text_file(FILE *fp, const char *prefix, struct selabe=
l_handle *rec, const char *path);
>  extern void free_lookup_result(struct lookup_result *result);
> -extern struct lookup_result *lookup_all(struct selabel_handle *rec, cons=
t char *key, int type, bool partial, bool find_all);
> +extern struct lookup_result *lookup_all(struct selabel_handle *rec, cons=
t char *key, int type, bool partial, bool find_all, struct lookup_result *b=
uf);
>  extern enum selabel_cmp_result cmp(const struct selabel_handle *h1, cons=
t struct selabel_handle *h2);
>  #endif  /* FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION */
>
> --
> 2.45.2
>
>

Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3108D537FF
	for <selinux@vger.kernel.org>; Wed,  2 Apr 2025 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743623012; cv=none; b=pM/X4jr7cplHc2KwcisKHwWXwcpCF5AJlPZCs+Y8wq88dVyty5mDFravXeysqWciGzSoUXBshfEiWfp/dUVJ+ZZqObjYZp2+bUp20rK011LfvrWNxWo0S+RizfL3kAFqPn2HsBntAIOfWBn32Kk2WFxlXzc+FSEADx5AjIKt7p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743623012; c=relaxed/simple;
	bh=dFVRwEZzpfWizzH3lCuG1L27+zNoIr5g84h/iujGx6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcBkcNmWp1izqTNWIQASGvfd4iw6MNsTPxl/uFJkxf0m/FKb0K6TuTrkhK/eUpMjcVqy0aS6Y+Joyc8gxral/noS+lwkZ5n8lk9J+a+Eirllst2RRs1A0Fn3aDLWEjiL2KVOfvNVwYv0n/oT71DozeyPSTHFUriOoxcsAbC5MmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ra8SLQFM; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ra8SLQFM"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-51eb1818d4fso228297e0c.1
        for <selinux@vger.kernel.org>; Wed, 02 Apr 2025 12:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743623010; x=1744227810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLCr2vfUAn3k7u7MHohVOmphEoeFD/uvv7W6QCpQZ3E=;
        b=Ra8SLQFMWS1WTkg1AI0zyb69SkxPd6mK8oznOoPg3OY+1yr9IotokPZ4r3gplXrXpa
         sRhz/oUbJOZoPsGMCLgaoqS5tWAgzdSytVYzWxBpDLPBPfJbXJktMqKwBWuTpF8H49Y2
         XAUVim9U+/9VNvsmm8NVVxWVBQSRkaPT9O3V6af1fJOleZMqhpB/eahyYhJ85Squ9TSA
         1qkJwxdW4q+Qh/1nJ1suwef7kC7FAZpCMKAdHq4uVDTReetlPLo9u7HIn9Rz1jmWnOS6
         9lBZl6n8BLDgMvRah4V4GT0lc+b87jmzYI4t6mrF3nkjH+QuNh0KIprwoXgsZCUcMNUx
         PTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743623010; x=1744227810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLCr2vfUAn3k7u7MHohVOmphEoeFD/uvv7W6QCpQZ3E=;
        b=ptfpVc86fHuxy+TbBhtOtHObV74lhor10PsjJsKfxwIcy1eAXIvSvA1mYD6dZjnu/Y
         +NdKnsghKWx2X3cJsMt0mOCmiD0+sTSV3sug7qQHDCmXtH0kGwmfsPau8Txc5jaWhGGb
         7Hs3PusiAu1lpN7cOehYaLp8vrhldTrY8wPN1WEx/dgaVvp+INOuWXLJwprIx8SIaQYx
         NTtVlc/G32MLo3LYiFZy5pkV0NWuNqpDEv+zXQdRovjlcYxwFHSE4983gxY7Xdag0usB
         Vmkv8NaLKBVMYTBwW+GZfmqIoMPzwAMOMBaKJfcFx6LME540mBximu+q3USf4nsDJfbq
         y42A==
X-Gm-Message-State: AOJu0Yw+0Y2q4FHGNK2+vdpn5ZjrLEQBVbu62G5pi5IEDVK8vcmgmXka
	Bwyd9XDHLUSt27AQDRwY6cdmawlddUkvMe8dA5TjhHeYwN/+nNJm2n3aeGqNinPfzFjrakUPN1z
	bVPSknLaaSNHfV3J3X/So/XWyLZw=
X-Gm-Gg: ASbGncvmerJSZlF5uHA1911d3C2n/an5grJIgPmbHZWzvaaFHP6rQwH41RJdbeok/Sh
	VtjTZhqiVXhtxBThqkccbkUw0c5VKMhlzYqTHkgRZz9czOWeKirfktqEalAOr4jp5soMr6odlcs
	y1hqCXhdeA9JvD3/02MKTZTNg=
X-Google-Smtp-Source: AGHT+IH6U5oeY+8o6JWJYAAPg6gYYpZ1hew2/GmT7yyIjBU/hTixKL1qSmi8qNMVG5JOVKaaOXl39ktIDLtpbh9zzZQ=
X-Received: by 2002:a05:6102:4403:b0:4c1:806a:3b44 with SMTP id
 ada2fe7eead31-4c6d383aa8emr16013289137.2.1743623009870; Wed, 02 Apr 2025
 12:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402010146.898864-1-inseob@google.com>
In-Reply-To: <20250402010146.898864-1-inseob@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 2 Apr 2025 15:43:14 -0400
X-Gm-Features: ATxdqUESQIYeaZQDFOpNqjGI2OohpiBdFtH-GW0MbVQmXWA9nHsxiUT81MAAPgk
Message-ID: <CAP+JOzS-ickvHYEPokm3oTSqyEbJrbhZseHPR5N1Oda2po1btw@mail.gmail.com>
Subject: Re: [PATCH RESEND] libsepol: Print line markers also for allow rules
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, tweek@google.com, jeffv@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 9:04=E2=80=AFPM Inseob Kim <inseob@google.com> wrote=
:
>
> Currently, only line markers for neverallow rules are printed. This
> makes people difficult to debug a neverallow failure with cil files
> generated by checkpolicy.
>
> This change additionally prints line markers for allow and allowxperm
> statements to make debugging easier.
>
> Signed-off-by: Inseob Kim <inseob@google.com>
> ---
>  libsepol/src/module_to_cil.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index ae9a2b5d..76fe4739 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -1196,7 +1196,7 @@ static int avrule_list_to_cil(int indent, struct po=
licydb *pdb, struct avrule *a
>         struct type_set *ts;
>
>         for (avrule =3D avrule_list; avrule !=3D NULL; avrule =3D avrule-=
>next) {
> -               if ((avrule->specified & (AVRULE_NEVERALLOW|AVRULE_XPERMS=
_NEVERALLOW)) &&
> +               if ((avrule->specified & (AVRULE_ALLOWED|AVRULE_XPERMS_AL=
LOWED|AVRULE_NEVERALLOW|AVRULE_XPERMS_NEVERALLOW)) &&
>                     avrule->source_filename) {
>                         cil_println(0, ";;* lmx %lu %s\n",avrule->source_=
line, avrule->source_filename);
>                 }

The problem is that currently line marks (which are converted to
<src_info> rules when parsed) cannot be in booleanif statements, but
allow rules can be, so this can create cil files that will not
compile.
I suspect that that restriction was not intentional and can be
relaxed, but I don't remember.

The other issue is that this will produce a lot of line marks for any
real policy. A lot of line marks. It would be nice if this behavior
could be made optional.

Jim


> @@ -1264,7 +1264,7 @@ static int avrule_list_to_cil(int indent, struct po=
licydb *pdb, struct avrule *a
>                 names_destroy(&snames, &num_snames);
>                 names_destroy(&tnames, &num_tnames);
>
> -               if ((avrule->specified & (AVRULE_NEVERALLOW|AVRULE_XPERMS=
_NEVERALLOW)) &&
> +               if ((avrule->specified & (AVRULE_ALLOWED|AVRULE_XPERMS_AL=
LOWED|AVRULE_NEVERALLOW|AVRULE_XPERMS_NEVERALLOW)) &&
>                     avrule->source_filename) {
>                         cil_println(0, ";;* lme\n");
>                 }
> --
> 2.49.0.rc1.451.g8f38331e32-goog
>
>

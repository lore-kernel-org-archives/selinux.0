Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729041A786
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433137; cv=pass; b=uksFoOdP2Gqfx9jOhZBX8CAaHMxExZlmejWVcAzFFg6nnXY1UjNW1nLdAcO4W2HqBiWsmbfTpBh12LYsHoA5Rs+5PZhshLWwzCPo2JVNxOOlIdE8SR0AMOSv+N3K4PJBJGl3+WLmDxYbBLfa9dYlmmFGhlVHO6S5odJKxexbjA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433137; c=relaxed/simple;
	bh=84/Fp34G0a5YKqmoodNd7k7f6rqUtt9RHFZF9DnfkSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jC+7ClOtCyHB9k1FphuX4Wc3GVgO0QAGVoDA/mHMbDJYkzphp/CIjJXE1SPMkYZtYtXAJ/6BpThGPhGfUR/RmYzsvjGLU+uEJOq1huxbRDQPAoDQmfJfJX5PBPRW9atnEvStX4M+bxFTZcFdL/fKUCUyKlFMh3OVEZY5N3dYRVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3jO8UsA; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3jO8UsA"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39b27812c96so35604731fa.0
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2026 07:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783433134; cv=none;
        d=google.com; s=arc-20260327;
        b=MTFfNyKU+4JAFxYUB65gz0ES23ZvdFolJlzizI9IXjM64ygTB19k+6MwDTShS0G32/
         5Q1nDKP1OnNay/xnHzOeJIhw2LcVUQvJmPFcGSSTfB2kkh+73v/F3tFgUQUUFEU51O0p
         Y64dTZspDq5phUU/cfh0CghbSWQZLqGq6aFZs6hF1Nij2QOgNcLQi60TLJk40971Ag+I
         jmkZFToJOBNchDql4StcHlNv4mN6Db/PIvWyPgzmbTybZ5he7y/2HvfQk6JxFPaWUaEb
         n7/3v490JsJLxlBbgyumgLWM6wg5wbcJ/vj4Woyd1w8yyHsT3wmxr/07zdzmEbs/Zwnt
         Cwzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8rTiOLmL5hXOfYFlcl+FsaLFmghOIb6nTqIzfRwbRYw=;
        fh=8UTe8aaXoMulMWhQ5IJNfPVhC5R8CDXWkorWGY9dqxI=;
        b=sB65UcBHkILGpiCwG14KH6KwgbICd9+cJ/iUYSZ3gLWLeawdBNwMvghOamIvQzJdoX
         9WGhr6FlHrty7nXdXOrjQMYWTqC5qAJoxgsXkOP9vtICGuGST84Y8dSrUpbsbEhRyk4j
         d1bBLsN6baTknkOTIxAP8YlSMr1VAEtn4EJW0Gr3/q+v59WwyIsbQH55iRl0DoiOZ8AH
         lTw88mUhWLQB+GLTRV9B6HyewK3U3Kxr1ITnl/dfzak+Ll/aiKHXEm5kjcpg1+XWvqRf
         nQ3w3YsKyCjqkCOuhhpRW3IF5RjgBQtm/e6U+FoqAHw2JCcftxhUJH9EDdH60P9LPn7a
         959Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783433134; x=1784037934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rTiOLmL5hXOfYFlcl+FsaLFmghOIb6nTqIzfRwbRYw=;
        b=E3jO8UsAi2+JhCr7xZ7rVEQazTnFQjlttKnbPL1jRUgeWf9S/fDFh5xyN1teZ6nSmB
         JeBhX7Zopdq9g/xhR3v1cgZn6WOO/7sVGeDGHpNx0iPieoTz8GuiSzDQZ65Ency3QCSn
         kGNcSEmlBG9hd4tRalqcnGJPP9JkkbjUaZGPIURhUEqzvcUo+WexV9aWZN7pFAaagA/A
         2WUIFoju3dsXLa99hvCBRwaBQq7h9aU46t9nDvkBW8mt6XDCwNJdch2Q7IFiNZJhDbtZ
         njfyzlgeC5aPSdBwkRBAgVt3Zil2wBTe1v6duul3SGjirgPiCuX+DptTUSaJec06jwjy
         A7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783433134; x=1784037934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8rTiOLmL5hXOfYFlcl+FsaLFmghOIb6nTqIzfRwbRYw=;
        b=FOKan5HpNRDgzGlTrYJqLBUf0sF4Lsx8MNCONl4ZWZm1dlLRGbKzdaYFt9a2W5rbko
         P0gESwEfOQ9yVLhF2GLmxx/MqMOtowKYxsT0d9liN2HxXy+erElgbWBryuOgmDk4uOmp
         gWexP/W0aC14zHB/fmR7Lj8gxD/txQxrn53SP/SGZ8pExEexBP749/97j4AxGxXcpLxs
         CVnrB5mS9fEln/sc7kGPeSj6OZDhmYqaapdODv+yhKMs4gYIn5DyBtK6xelQprG1nm66
         xJo+hBLGynXLwfj8N1MS6Yt2SRQPF5b/BnhFMWniFC/+kStiflb2kMtEHmYGBq2glgY6
         NY7g==
X-Gm-Message-State: AOJu0YwwExGx1XbW0h99ajH50nlKvD1/AgpbivDZ1nzwspIBBCshC/yG
	RSHtjOw12F8aiWsoNSj3CEL8YSDA84quvyjaY4dzGxMZkXtbYFuCjOrp8FEErvcTYbbh6CChNZU
	IU1aa8Eb9f2G69V9z7XuqPMlYMRM9iYM=
X-Gm-Gg: AfdE7clRWeI6k0J9QvfwYbjrUTw3dGIKV8OlELwIVNdmGKZMVt2PBG6I9TZEPuXwPEO
	jvY1hrYba0DalvGblbJCrUvAhZvpLazCyJr3RMEgEC9fYqbUlXtOqEQHfz2+5chmVnabua92HUA
	MUOCYa/3JKHe9ormV4gjkCbk5Pa3U/34yASNP5vcaBJoCFovA1ESaoq0dtvECA9FNqyrGY/PNgY
	Tq1lGLA+Uvj0UDF6H7iP3rMPeX8/1SSwi9wCzWwSOm5/LURMRmQhbuBjlQUB5nbT7dZTA==
X-Received: by 2002:a2e:96ce:0:b0:39a:fc4b:ac15 with SMTP id
 38308e7fff4ca-39c5fff4047mr9938801fa.26.1783433133705; Tue, 07 Jul 2026
 07:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707121931.1175225-4-cahu@suse.de>
In-Reply-To: <20260707121931.1175225-4-cahu@suse.de>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 7 Jul 2026 10:05:21 -0400
X-Gm-Features: AVVi8CdM8GBYGzHc6X5M88dqimUkET4ftTBkzWD0HCtrW98dFOfRuRrErNWscZY
Message-ID: <CAP+JOzTW=-B++YZ9EgXQW7aCDWvE2e51dDsr89NkYinh2mThgw@mail.gmail.com>
Subject: Re: [PATCH] Fix double-free in secilcheck
To: Cathy Hu <cahu@suse.de>
Cc: selinux@vger.kernel.org, selinux@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 8:21=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
>
> If the file size of the cil file is zero, fclose was called twice.
>
> Fixes:
> ```
> localhost:~ # touch ~/.empty.cil
> localhost:~ # secilcheck  /etc/selinux/targeted/policy/policy.35 ./empty.=
cil
> free(): double free detected in tcache 2
> Aborted                    (core dumped) secilcheck /etc/selinux/targeted=
/policy/policy.35 ./empty.cil
> ```
>
> Signed-off-by: Cathy Hu <cahu@suse.de>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  secilc/secilcheck.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/secilc/secilcheck.c b/secilc/secilcheck.c
> index ee141bc0..b7c32bc6 100644
> --- a/secilc/secilcheck.c
> +++ b/secilc/secilcheck.c
> @@ -155,7 +155,6 @@ static int add_cil_file(const char *filename, struct =
cil_db *cdb)
>         file_size =3D filedata.st_size;
>
>         if (!file_size) {
> -               fclose(file);
>                 rc =3D 0;
>                 goto exit;
>         }
> --
> 2.54.0
>
>

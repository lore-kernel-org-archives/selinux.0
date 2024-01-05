Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF620B03
	for <selinux@vger.kernel.org>; Fri,  5 Jan 2024 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAq0G38/"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ccec119587so23199041fa.0
        for <selinux@vger.kernel.org>; Fri, 05 Jan 2024 11:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704482151; x=1705086951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQ4Zg61gLkx/TOPlb0fl4T0Y0ooecs9ZRhEQPVwrDqw=;
        b=jAq0G38/JGiYUb5YswjZlmeuPNVFJBgBOzNLXh2wBiC/p+xdbVmtRyd0Ka1SCjVHB7
         TZaWfQgDcHPU9AXVKmqmxcs89CSQZBJF+GwPlFAvZSeVAx9QGRVM7e48PwpKVXVLSWqN
         71e3DJAw8rh07MBsxIk6UR/uyefKedbyDTy0ZtC0uYXex9iN1dDgcb74SjYaeSYiHLab
         m+cMlrIs0IriNBa7uTjBX6N3mZTEUS+DphpcO//7c+F9Mmx4FQGU49zTB3uMe+yBndez
         NSEE6Kc63v44L9GFCucC/TR5jTDNxywj1nBWWjzUwupFCHs0z7PuxxNk+ZjaPQbw+znh
         w9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704482151; x=1705086951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQ4Zg61gLkx/TOPlb0fl4T0Y0ooecs9ZRhEQPVwrDqw=;
        b=ZecZgU/fpbsb+GL1vjl8kM41PX0myJRJn9Bp52If+1n41IpPT7A1Ue7r3e4HaFgabI
         gxP+uKn/204OSGOwyBC+5KDgKHOSBxqlaNdljb4glc498YZ66bO9Ef7W7g0YLKSD/waa
         F5DQfiD7bGgV7ES3a97rfwTwSz8M3sMfH+AVXRscLInymYGvSdBKs/HrSOstuSFMGDUA
         7Opzihsx5lYXBYnQa9/iHqI1+WQkQFXLW1rhlvESoc+NoyOGkUMsWLv/yCNkKwrQJR4d
         dtoObTEyKKkjEkdHfBSUCR9zYuufyxP7ZSh7Xy6/AGsPNywVJ2Zm7wOyKYJRslm22KUF
         qiPA==
X-Gm-Message-State: AOJu0Yx4J/ZLOC4zS7DbETOQdutvxQcMWYSqRsO8egpyxELxz+GbdBX2
	y/iKXNB4NewHDh3PEzLrUZTceTxYlXE3IamMxSaHgwiSIX4=
X-Google-Smtp-Source: AGHT+IHDKxA123m9tWAkm1isf3ac1IM4sV9Ao1jirXS3XWja9pX5uem4OH9XbGHCEjlSTytxrPI/lDSUFjKP4jjgEjY=
X-Received: by 2002:a05:651c:b2a:b0:2cc:c794:57c2 with SMTP id
 b42-20020a05651c0b2a00b002ccc79457c2mr1864010ljr.14.1704482151400; Fri, 05
 Jan 2024 11:15:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219160943.334370-1-cgzones@googlemail.com>
In-Reply-To: <20231219160943.334370-1-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jan 2024 14:15:40 -0500
Message-ID: <CAP+JOzQ3cCwAkrT4n1D694uoZkxh0RAuoN30tEtH7jX_PhxU6w@mail.gmail.com>
Subject: Re: [PATCH 01/11] libselinux/man: mention errno for regex compilation failure
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 11:10=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Selabel lookups might fail with errno set to EINVAL in the unlikely case
> a regular expression from the file context definition failed to compile.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these 11 patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/man/man3/selabel_lookup.3            | 3 ++-
>  libselinux/man/man3/selabel_lookup_best_match.3 | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/man/man3/selabel_lookup.3 b/libselinux/man/man3/s=
elabel_lookup.3
> index 4e47c3ec..e20345e6 100644
> --- a/libselinux/man/man3/selabel_lookup.3
> +++ b/libselinux/man/man3/selabel_lookup.3
> @@ -64,7 +64,8 @@ The
>  .I key
>  and/or
>  .I type
> -inputs are invalid, or the context being returned failed validation.
> +inputs are invalid, or the context being returned failed validation, or =
a
> +regular expression in the database failed to compile.
>  .TP
>  .B ENOMEM
>  An attempt to allocate memory failed.
> diff --git a/libselinux/man/man3/selabel_lookup_best_match.3 b/libselinux=
/man/man3/selabel_lookup_best_match.3
> index ef2efb4a..985a8600 100644
> --- a/libselinux/man/man3/selabel_lookup_best_match.3
> +++ b/libselinux/man/man3/selabel_lookup_best_match.3
> @@ -78,7 +78,8 @@ The
>  .I key
>  and/or
>  .I type
> -inputs are invalid, or the context being returned failed validation.
> +inputs are invalid, or the context being returned failed validation, or =
a
> +regular expression in the database failed to compile.
>  .TP
>  .B ENOMEM
>  An attempt to allocate memory failed.
> --
> 2.43.0
>
>

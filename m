Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841381DE4C3
	for <selinux@vger.kernel.org>; Mon,  2 Dec 2024 20:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172095; cv=none; b=iSneHgzpSiFT/vn2uGRsWZ9fACtaiaN5ixF3QPfZdvC/zTrcH6cO0eZyFXSjHpr8Hasl4MFAbdeFbWwrcc4t8jmeA9AiI03EFFQtrrPGDxc56htfZ/jigNAa6/qKifACNT9VXyfqtcxfT4aGlLcMkpnhQlRAqVs4hP4vVronI3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172095; c=relaxed/simple;
	bh=IDHYVukraxaf9GgOXCFStm9tNviudaQGmvNfy/eGkGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iy6OHJxPvzb90W/fHELtgJKry5xjmxW28o99ZQNMQBfYmMRlbs3VXDF1ylZm4MVyAsNn5hvdVkERnxd9ZjiEmypCO3iugPwX31DrI8UJsgjdxQ/T/JiAsGKuSmwsxtdx5zontMtQRlGrGjnmXMrzDBEqFxfQ0Xxb30/DJSXyx6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLK5OvzO; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLK5OvzO"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-29aea31a833so2481555fac.0
        for <selinux@vger.kernel.org>; Mon, 02 Dec 2024 12:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733172092; x=1733776892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jkG6Rv9aIbAJvlTN3rWIZqe6w2mA5mxqdSA8wwvcaA=;
        b=iLK5OvzO/JRmyDtZOilX0yKkdOwvGitGKd3dYR0xqDBZ/mt72X03ztiOi2vd26Ll4M
         c3y9c7kngjKBVXyC+TjGKvKjEpuCdRWZE1XGa0C8pETSNcn25uHW5py8/gNwLUQfLg8q
         JRkrd7WJ+4HrqNNLA+Ok8b0dJc5wHuUExjdy+l4qcB+LfQeLBPPEo5+dZqn0SxTtb9Z/
         2dgc9HsaOHutypvcre5n+YWznQrLglm8jnIu1ngf1GnfbcLwGD4wr6FPe3ok0U6H0+pD
         oZRDPpR11cQBQNJ68pzkzOREQJ+zT1c5UiAoJEXStJlkmpByVE1iomSupcjUJOtUNnkp
         YPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733172092; x=1733776892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jkG6Rv9aIbAJvlTN3rWIZqe6w2mA5mxqdSA8wwvcaA=;
        b=nJPsLghtxbtwWsH2Sv1V0eNmibLLEwaK5TO1k3hcTkqSzwC6HfLiDWri/RSojWrkpn
         8a+yIuBG+8rZBjTFG4dUorodRzJNyfnsR/stils7+OuiPpBW4ws2YFlLQZFchvwk/YSq
         LA63jZvbGiAUOGW0kPuWZEqTJdEGy96xU0ZKfrHCsrI4hJ1HnYqo7uEpMhQpN21aFTIW
         4SqrXlpZxxNQrPDyaJ5T9cgKKaVEYQu+C/I3VzFqNfvyxi8sVOlngCJkIFxJtxWk1NoG
         UUFypyzDAfGSK+LSkUZN+es2OMkDtONPeW4LnqO20OZD43ggypK/8EKzNnsMcIzEPeGa
         vvcQ==
X-Gm-Message-State: AOJu0YxJ0SvVLyztaxVUSjR21ytF4NASIUXGm98wXjlCu1UlNyPtgMqS
	epmhVy3Kyj3yFfMnVbeUQQLF5sByrgOhHU/GfRSKB3JdHoqk/aT5RZ1pTG9VVdT5MbdCpQYHdoi
	UFmLGQYMEgHSTRAO7sF9eI06G3hlW3gqs
X-Gm-Gg: ASbGncuFANrdyhbcJOUqKoeiWDmxo3U4M9P5zu5IJBGHrCST48Lzl4p871LDrbLiyls
	cmxwzs7lqXJMgY3c4Q+skAKad9ggTqmc=
X-Google-Smtp-Source: AGHT+IHJUQLtkVpJ0J9M0V8m4mMIxzHsi1NGGCnMHD6DEhCsS3jjykmgjq9WKE7ECS5ERuLPgKNiIMUAE3Kohp0msgc=
X-Received: by 2002:a05:6358:5bcc:b0:1c6:1d18:7c43 with SMTP id
 e5c5f4694b2df-1caeaa8bda8mr5617355d.2.1733172092550; Mon, 02 Dec 2024
 12:41:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128153239.16472-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241128153239.16472-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 2 Dec 2024 15:41:22 -0500
Message-ID: <CAP+JOzT5NMOeSWA8FXnCPYjvwvTKcCz0A9hSOXBOAGU4qcsCwA@mail.gmail.com>
Subject: Re: [PATCH] libselinux/utils: use correct error handling
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 6:31=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Instead of returning directly goto the err label, which prints a message
> and closes the opened file stream.
>
> Found by clang-analyzer.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/utils/sefcontext_compile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sef=
context_compile.c
> index 23d31274..5d7ab301 100644
> --- a/libselinux/utils/sefcontext_compile.c
> +++ b/libselinux/utils/sefcontext_compile.c
> @@ -471,7 +471,7 @@ static int write_binary_file(const struct saved_data =
*data, const struct sidtab
>         /* write context table */
>         rc =3D write_sidtab(bin_file, stab);
>         if (rc)
> -               return rc;
> +               goto err;
>
>         rc =3D write_spec_node(bin_file, do_write_precompregex, data->roo=
t, stab);
>         if (rc)
> --
> 2.45.2
>
>

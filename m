Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404D720899C
	for <selinux@vger.kernel.org>; Wed,  4 Dec 2024 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322685; cv=none; b=tkMTCPsvE6zBSm/MdNlv8kL3HRbFkeFHBxi0OzPvb60xt2mnPBasmvbjR7ugyFZp+s6qzNTJi2XvUE3fgxZfS6zkBQlRLn0QUVSG57eNVoiiJCW0fi+7PwSw+KO8EreLXUAigrXiBhCkiy2Ryj9FUG5z814eC7qhZMTpyCkYa7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322685; c=relaxed/simple;
	bh=2nZdML3EXUK1xCR3h0RayMSQakNp+9jNVmZdJOIcUxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKV7HdNK91qVpbgpVDFdC6sTJIrOYHtRsYL4qQXk+jIJNBb8yL4X9d3lM2ak6mEo9HxZ2ICWlEUu3+begz+HmjqnvEjPGY2AJL+c9/N3XytSYHZbqsW12Qz3qTyJgZ/inKpU44mQ6SDFj3NK5Fw/EPVDxTVdPrIkpOK0dV5ONuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eH/tophF; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eH/tophF"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ea52520327so3757860b6e.1
        for <selinux@vger.kernel.org>; Wed, 04 Dec 2024 06:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733322683; x=1733927483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEw0zkc5tJ0uQawYioO0xkagkeFmTTEaQksDB54TgUY=;
        b=eH/tophFxjyf9CJb2BkDXMMECMVtqZ7bNWnCVe7Dgwj9yWs+9uhkGSnZ+5Rmagawfq
         BFVD0sScKx6Zvilg+u9pJS/DN2oq5iquawQWNLUQKCO/D52ILlHiR333PbAMEYvj4gkD
         7I2XvE1iTD7PhPVMxawUBO/Pu90sEr1DQVDCn2wUJSNlG4KRmj82D48cjO6nrazXt9lZ
         fxf4ykrUIkVhZ9p5pn1tU4ngH+DvTAbp6s0+kk34lTympWlLBKtnY4Ge4zZbsezbTSll
         nWK5AiaDt0G+IpUKS1YqtWdkJv/CEqQBchRBEhWsXsbD2ed0Bbx0e0VSAnRl5FcezoFi
         /ZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733322683; x=1733927483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEw0zkc5tJ0uQawYioO0xkagkeFmTTEaQksDB54TgUY=;
        b=G7pk+woTtES05gDAw01RcW6ctPTSeHzuR1q2MA0Aiun5kSepPvXFJHUmrN+WcV3Phr
         69Fwk6PYCf+kh19Ghnm6oknuFd5I6YORzoIZaqDs/oaBP1svZ6zeDdf7ksP8AjxmNuuw
         isl93vC3YT3vigP2s9ApWB0/PZmWPM6gGb5anGCwd4f65Vn605oOjY1bjyYlTYt9W7nO
         rgF656ewJBDuxpIY4xBt4p5M4GH6gv9HfynVCflzZtLOx/zrTClkD4Zu/xBZGelNmhi6
         eIkyyFGJBIJCgoSp7uwxi5p8ZJRNF/B70/UbKlZH4vIPFPF4+E2emsKf/vFFSn8UaR70
         Fp8Q==
X-Gm-Message-State: AOJu0YxTF/SdE6J/PxkeAAEe6m+Ze/mXHBLNmNztsDKGPJIjMznLf7ts
	tRRXuAgy5HHQN1e4p1wmnwFyoGEMmL7DeYqz849f4+kIWmEY7eF3E3Bs34bsb92RUrMrgdDDhpM
	ZJIq9WGJqgxP+u4/ppi+psKhYicUh+g==
X-Gm-Gg: ASbGncsZwUgWlRqLbL5sdNfF/GfrrMM1BIYPNQaYv8uTV2C9bua8qk0WTSfALEmcL74
	ByoxvfjK/abSYeF7/avKESKUzPUM4bo8=
X-Google-Smtp-Source: AGHT+IH3iOF7QAY+bn6WJXd3KPxYAt4o7yPiefYeNAmPrPxAvijWeYgAub5Lig36V/V/xZRiYLjrk4tYtYkmtSz1Sjc=
X-Received: by 2002:a05:6359:4119:b0:1c3:94:8ff2 with SMTP id
 e5c5f4694b2df-1caeab871e4mr490892455d.19.1733322681543; Wed, 04 Dec 2024
 06:31:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128153239.16472-1-cgoettsche@seltendoof.de> <CAP+JOzT5NMOeSWA8FXnCPYjvwvTKcCz0A9hSOXBOAGU4qcsCwA@mail.gmail.com>
In-Reply-To: <CAP+JOzT5NMOeSWA8FXnCPYjvwvTKcCz0A9hSOXBOAGU4qcsCwA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 4 Dec 2024 09:31:10 -0500
Message-ID: <CAP+JOzRYQ3fHeYcN+SUxtW84kMLmW4U8KgCWt1DVoVHZRD74QQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux/utils: use correct error handling
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 3:41=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Fri, Nov 29, 2024 at 6:31=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Instead of returning directly goto the err label, which prints a messag=
e
> > and closes the opened file stream.
> >
> > Found by clang-analyzer.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/utils/sefcontext_compile.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/s=
efcontext_compile.c
> > index 23d31274..5d7ab301 100644
> > --- a/libselinux/utils/sefcontext_compile.c
> > +++ b/libselinux/utils/sefcontext_compile.c
> > @@ -471,7 +471,7 @@ static int write_binary_file(const struct saved_dat=
a *data, const struct sidtab
> >         /* write context table */
> >         rc =3D write_sidtab(bin_file, stab);
> >         if (rc)
> > -               return rc;
> > +               goto err;
> >
> >         rc =3D write_spec_node(bin_file, do_write_precompregex, data->r=
oot, stab);
> >         if (rc)
> > --
> > 2.45.2
> >
> >

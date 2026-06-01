Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA47D13A3F7
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335377; cv=pass; b=PKspXSs9Vw//ZuMoI1IzniDVxpg/IZ2KE+a+KsW9wBJtB+7yae1UwTcSkjNovt0KAL/O1nQPwEW4Ixe5sW8eVmIVjB+Ptd1tIOxn60q7N1TYtVLqlpJ1pyh7/wG2FrVWQ1Hb+pa7Rw6Y4PO7bWC1rNWlLqGo25ZQfZQYlsjDuIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335377; c=relaxed/simple;
	bh=OESchCVvXKZFzdvgfjw/QeQvDf5EjIX/CW1ElPqloJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANKpSEcN792aKYNlk4F8eO0DdpaT3uK0r78qxrn/S4KQxIYI/j9sbTPRtW1Tlv+3L2cELO+8vR2rf1EGF4HZhDUJyyDZG5QMJF+C3OYfDVx8ot1Ngn7jOJeEEHf4b6AsQ2jCr4u7/y60ockUoDBtXJ84/VG+HAJxJ8xTZB0O2xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5KGIkb+; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5KGIkb+"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-395f24a5f2cso86292511fa.2
        for <selinux@vger.kernel.org>; Mon, 01 Jun 2026 10:36:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780335374; cv=none;
        d=google.com; s=arc-20240605;
        b=BLvUaU10Hbw0jPnOfbgUc8Bn7gR7FTu8znRJABh+eaJkG8q3t8B8A8hEtCC08vdwUj
         YE6dYTcZhHe3p4RZxpTHxbQ1CGLFwIYSZF7UuoZv26IOqkoqxaMBWxix/Int+c7YpN2b
         96bosTk0BqNCzwIvfQ0lRPNdvdWOVu7KsNqiiP60LLSsdnwm9v7ibQbpms0HYcHk7UsQ
         t9FNxRtdol5kFgU3H9bpYSO2Sjm6AfQkZimL3zljpWFb8aVSDnG8uHVxfv3yo1KpP69x
         G0YiiD/rTDjIZk0EFd+h8302VI2FZ3eNFMNjpwRTr8ULo1GQitM3E9ovGCkJQO2w+sP5
         InSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W0ewXs98dd+1NtliIM+W8Uod0Tz14M18sLKDrC78Nbk=;
        fh=+D6xJ6BB9J6NyoJZZl71KoOEMrrFPGwz9kIyEgHHWvo=;
        b=exWVM8rcAQfKRnJ6STa0hH4GrRVkz0V8x/+up9kuCpwc4uCFWgmjV3c8fSWS5j3Qzv
         vHTJHpDOQF0/YBFWeYoCtPVWhFzc02HgNlqExIjoSB5d5ZTgxeErfZ8hrU3DAxnEqQpT
         heHMWmCgnkfu3Ti1wBj4Qfi3W5ph8oz3dKx/g+2tK3PUzeRzIjMKmGbms2Sc75Dp/hQ1
         f98fAV92DgqsGHwouMgKchM3IslVrg/a0+yGY9ElVR3VBLj8EtFJ1tmgTN5AYhUHZ0MP
         q/JEer2U6Tehdqxy/3GJfGCbznK4r2in0/6Gm5kQ6j25N8WUgs0Pdurns/aSA5EkRKHP
         iA/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780335374; x=1780940174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0ewXs98dd+1NtliIM+W8Uod0Tz14M18sLKDrC78Nbk=;
        b=R5KGIkb+AouNBfBkZRpOzfXt/4weO2Ie9xRf6SsJKZ6Bj1vCO1XK6DWiFbAgtwh02P
         JTb1JCvmlQDpQ7Fy/O+FLbljJ1IbQTIX7R9Nkptsi9DqMsqoelUdLXh8XeQY2uXEDOa2
         EEFosCX5B97lnhoSL1jcp/Tfmn1ktYyhSA3Gs1Ulo16+XERIzbKhltZQoGV9tFxb5X+m
         BZnFTAzq7qsvHDLnXioyyAHA48oJgJfrJypJkBuKdGt4hAZNuDzSxCX9yd7SADgOsKx6
         /PasLpF6UQZ7pAmbTudy4JlPG0trV9WWkTFY5xSnBaCjHM1pxTGDqWwU2nedeCvwtJeS
         0dyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780335374; x=1780940174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W0ewXs98dd+1NtliIM+W8Uod0Tz14M18sLKDrC78Nbk=;
        b=m7Fx6+i2zBu1ayhIUTQ1inqaU2ZjRxtGjHCtAvdoV2bYFKoFPTaU/v9ekkmmUF0Slg
         4jfrePxQtEg541OTjvBotrxUF4jueLuIY+SIY/xpA5zle2jxqHAJmaD80mXts58k9+oF
         VYxO7QeKaPDOMlR4y7LfleMI7OGwQAdi1SKNexyJiGdVMdggQySLacDm1w+9hb9Axsky
         XMNydny6+LUxlcMLP1bEdz3bMqhidA54vc07povz1Qbtk+W1I8zpuGmgtY3KfCtf/K4g
         K5/k2RHvwtAWZ4NoFi0NBgpClpNVNZQbAIFVZ3ec20HuCjjnTctT3LyAFkLcCdyzydhm
         pvlg==
X-Gm-Message-State: AOJu0YwgNKn99tlrAfQmNA28Jfc0RB+I6OXwA/F8HuT6mX35aNIcgjCl
	29sbJqbxM4GxgjqVJW3qgi7bpLt9fN7zKGtssFX4KDATbhn39YwKMgOyQPwGJwZ6QrPySVS6SCQ
	VJ7vkLYbBie1FnPaomoQB7zSQYD2bEyA=
X-Gm-Gg: Acq92OGjQVDTcJD+uwqDmUXupLzuy5K0lulZiV6tHUbZ7J5uI4wO1ueXlcsmsTEV9u8
	JXLTc7UukGTjuXHUhCQB3PLRgrNAcIdO8iwDrf5IsWN2IesVycrCNpM2rtTteFCc43faNvHN4I4
	FjmMXy73gWDerVYmrCQx4H8e6OqXpLETkiimmM96gndU7u9ZRf0oVBhZheFvo6luDTN4T/djFHH
	fNZlTX/R9i3m3vUp4/vITlhw1JzYvBCB4BgA7Llaq4UAylVtLgc8x05yXawmZEGorkCBnwJJiCR
	z2k5GmIu/NUBClmQwa1nrUse3Q==
X-Received: by 2002:a05:651c:211e:b0:396:7fa2:e07b with SMTP id
 38308e7fff4ca-3967fa2f03bmr17927001fa.27.1780335373782; Mon, 01 Jun 2026
 10:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531054519.650723-2-nvraxn@posteo.uk>
In-Reply-To: <20260531054519.650723-2-nvraxn@posteo.uk>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 1 Jun 2026 13:36:02 -0400
X-Gm-Features: AVHnY4I5fdSyZ9PqFtuX82l-GDFDUfrK2Xq5M0R77ruwuX6B0wwaq7HPkYRmIkQ
Message-ID: <CAP+JOzQcj47Px69QqLnNeaggvLkK=P254ALzDiLFQ9+hebBSXQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: cil_policy: check at least one perm exists in a classperm
To: Rahul Sandhu <nvraxn@posteo.uk>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 1:45=E2=80=AFAM Rahul Sandhu <nvraxn@posteo.uk> wro=
te:
>
> Kernel policy language does not support an empty list of permissions,
> { }. CIL expressions may collapse to nothing, so ensure that we only
> emit a permission list if at least one permission exists.
>
> Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_policy.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.=
c
> index ca73bd28..e618ab13 100644
> --- a/libsepol/cil/src/cil_policy.c
> +++ b/libsepol/cil/src/cil_policy.c
> @@ -653,6 +653,12 @@ static void cil_classperms_to_string(struct cil_clas=
sperms *classperms, struct c
>         size_t len =3D 0;
>         char *new, *curr;
>
> +       /* cil classperms are expressions, and hence may collapse to none=
. As an empty
> +          list of permissions, { }, is not valid in kernel policy langua=
ge, make sure
> +          we only emit something if at least one permission exists.  */
> +       if (cil_list_is_empty(classperms->perms))
> +               return;
> +
>         len +=3D strlen(DATUM(classperms->class)->fqn) + 1;
>         cil_list_for_each(i1, classperms->perms) {
>                 len +=3D strlen(DATUM(i1->data)->fqn) + 1;
> --
> 2.54.0
>

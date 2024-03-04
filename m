Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03E27993C
	for <selinux@vger.kernel.org>; Mon,  4 Mar 2024 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579581; cv=none; b=J4zXhqsrwKUTCRpM+LZ6BkKgPUBvSjA3wW1Oo4Bbt2zfSAqrktf090xCXfcRoYKi5v+1G5Wl9WHHWUUYb8aCibTyicuJjlg9aUlijbU08Cv370BvRnfJA9jQMXdZzn1IDz/zYKRPO1MC2crmFrceXCrFSTDA/867gvlmYj4JvOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579581; c=relaxed/simple;
	bh=Josw5AJ2vbKsMQ7E5MEhlocPOJHNSnp8Y21xccNBWpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkMkhpbOzT6ZSGH8XFFAJcLG1aZWRqQprkc4LTi48kr+DamgZ9PROMSpJFRw1WsaLv/VRcPlkt6pDNvGGouObt+MZdQTx16a64GTC+Tfy7X88Y58BGivonV8yjKlHu6YcMj6RsdS/SFWJnB8PZ9lUV8rIZJPSM4zz597NRSfTKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fktTw+Ps; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fktTw+Ps"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-47299367f78so650902137.0
        for <selinux@vger.kernel.org>; Mon, 04 Mar 2024 11:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709579579; x=1710184379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5HTnAY6AKGqpXI1d7OOY6BxqXAaC/ynfGqETua4aNY=;
        b=fktTw+PshtMQJP0j8jFxdo5GgGI7Ia97h9CwyU01p0IlkTI++8xp4C+FeoP0uxk1Fc
         2X6M+lAeGYjg3AfUOxiCoh4UL6g1LEcngeEX3hYx4C970lsFr31rRHo4YqMb62T4kUeP
         nNJPtchMKzpKO58Zo2Lt05NSbwHr05kd8dNsgrkagjoh18eCSrIxhUVSExHiFhEZY+DJ
         CVFwzGwasbWnVtsr7WjIMkO1i6FxHO/SBvA4fzvM8i146MHanYGjOEpDj57C1l0rtRtF
         rSD2RMzfrgO5CoUHOf5K6yC/sCY7wxsJKngLt7oIaftd7TUWmkwNupPAlbEdCb2YuIpj
         TsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579579; x=1710184379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5HTnAY6AKGqpXI1d7OOY6BxqXAaC/ynfGqETua4aNY=;
        b=ckFjkHxQTB5Kv71W/jMt7ahfu4bAZj0BI1OFEyj0MpMn7rJ3MTjpeFsU0Y6w/q0+xB
         AKQ7R+PwR/fa+G4qLAoXKJ9IWdYWfNG+53WpN1fmiOkLIy82DGTHzpFu5AYkz4Ky23Et
         tNMfEAN1OVlYYDKQRTUBXs1vgO53LM/7alPM2lehTfzr2Uw35aY73vj3b4OI5NZ6oXyj
         eAJSDFZQISSHepYup1+Dzr1SHuT7MxiMZwjqmqbieO5qG5/O9zKCmvX8G1z2oYuWY8yg
         6zBpyOowBDCfrWWuLog0Q09auVj5AG/Bn4CQbKHZin3eDm90xH7b3G7QQLw16XZKO9gS
         tjeQ==
X-Gm-Message-State: AOJu0Yw99UUF005JplASRlrH9I0NYuk8EJFTl4Bpg7e2BNHuQ//zIWtc
	Z5gsZDBya5C/uiw6IVdeeLevFDgN+xmTMAcpXk3fSgGpXfRQnffVrI9fkOkNW57POx4p8VPkX0U
	83Tryis1zTbwDsnxtzSo6yEzhw5o=
X-Google-Smtp-Source: AGHT+IEoPZl6z1seHv9Paf+DJyPmKEzYhPKfmbcLBMBbHP9YoGMcKRCUo6gc0pOo5mjwUlTyISXULM8o2YgfqW9Bgs4=
X-Received: by 2002:a05:6102:3a7a:b0:472:7490:778d with SMTP id
 bf26-20020a0561023a7a00b004727490778dmr7123205vsb.4.1709579578857; Mon, 04
 Mar 2024 11:12:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131125623.45758-1-cgzones@googlemail.com> <CAP+JOzT+xzAxFaGBcrGK_ye1SPnLb_DvJtr7B2L25F2mfDrsSQ@mail.gmail.com>
In-Reply-To: <CAP+JOzT+xzAxFaGBcrGK_ye1SPnLb_DvJtr7B2L25F2mfDrsSQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 Mar 2024 14:12:47 -0500
Message-ID: <CAP+JOzS5eZOOpRfNKNfQFa8-GBd-PnBLJhvzZBdDDVOwTKqpaw@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: ensure transitivity in compare functions
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 10:14=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Wed, Jan 31, 2024 at 8:06=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Ensure comparison functions used by qsort(3) fulfill transitivity, sinc=
e
> > otherwise the resulting array might not be sorted correctly or worse[1]
> > in case of integer overflows.
> >
> > [1]: https://www.qualys.com/2024/01/30/qsort.txt
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these three patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>
These three patches have been merged.
Thanks,
Jim

> > ---
> >  libsepol/src/kernel_to_common.c | 2 +-
> >  libsepol/src/module_to_cil.c    | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_c=
ommon.c
> > index 2422eed0..44f0be23 100644
> > --- a/libsepol/src/kernel_to_common.c
> > +++ b/libsepol/src/kernel_to_common.c
> > @@ -503,7 +503,7 @@ static int ibendport_data_cmp(const void *a, const =
void *b)
> >         if (rc)
> >                 return rc;
> >
> > -       return (*aa)->u.ibendport.port - (*bb)->u.ibendport.port;
> > +       return spaceship_cmp((*aa)->u.ibendport.port, (*bb)->u.ibendpor=
t.port);
> >  }
> >
> >  static int pirq_data_cmp(const void *a, const void *b)
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.=
c
> > index ee22dbbd..c8dae562 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -1680,7 +1680,7 @@ static int class_perm_cmp(const void *a, const vo=
id *b)
> >         const struct class_perm_datum *aa =3D a;
> >         const struct class_perm_datum *bb =3D b;
> >
> > -       return aa->val - bb->val;
> > +       return spaceship_cmp(aa->val, bb->val);
> >  }
> >
> >  static int common_to_cil(char *key, void *data, void *UNUSED(arg))
> > --
> > 2.43.0
> >
> >

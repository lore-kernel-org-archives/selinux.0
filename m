Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91992156F53
	for <selinux@vger.kernel.org>; Thu,  5 Sep 2024 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563121; cv=none; b=d74WQ2h6Onr9mV4Y7HzqPRpKuDkdVLk9KLSNvl85NisKQ2O+cPWBfczUpEZOckTRxMlciSgO93tkrM5aNNVfPXkZRQJkC91XxHhpbWvJwvUWj1OWwoozdZxQ+lD01AdY85uVzFOTvyQBgEKrQtUSbRDjQe+eLu2+TYRJEtINn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563121; c=relaxed/simple;
	bh=QWy/ZuKawWJKTdG8YpoWXAsMEo/nc8tXvC8YGqwGpPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=q+xSNssY54UViQzNunrDSB89FKY6fJL8Q3VPS/Knf3Oidv5sslNGmwd7BwBtXs4ireIeTO0emJBGRVOVbG1HZyUFtOvoQOc3xZoMXH11dSePNZp/xmXaikJiTEzjP5fu6ElCrNoKJaKcvXSs7yjz0iPy5V0QuQgjRd79sGDevys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiUnWP36; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiUnWP36"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-70f645a30dcso897840a34.3
        for <selinux@vger.kernel.org>; Thu, 05 Sep 2024 12:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725563118; x=1726167918; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tU4h8biovQsr2yDpssqAjCKwzFmMJUlRh5pRTze+N4c=;
        b=jiUnWP36P+fUhUeJwFUlsMSczqXlePGMsVKrYzgZf3IeqyBO/dPOo5nDigla2zvC+G
         7VQBXKLGZXQzs0+P9dEKyGUJTb711TPtsLZ2vW1L/kPGyfSi1elBBoZK3B5aQmeDYEui
         3JBMQfdByio9sOIfkiXvNQU9BHT87G3KFoH/n4cHyD5iIiH+17+9j7jtTTx5jr+R4Dpu
         0PFrwsGolN412Ym8245k0MRFPfUfwm2ytkDW0XOLPR38pWMI3Ek6EBUyeXm1P/HCBtF5
         I9zMUuWAmGD2B+BI7QhveApG27eIm6q/Qz6gbSJzh/2cd20lY3w1ct2JVpWKOErcmPA6
         H87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725563118; x=1726167918;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tU4h8biovQsr2yDpssqAjCKwzFmMJUlRh5pRTze+N4c=;
        b=wK/stDH5MZ9DYUR2Xp9aOHd0Ys/57/GQ1ZIewFb3ydhso4rdKOdHz6uy6bI9XzX+Dx
         yhhexhDBaOzdhIc73QfZkCmY0KkVc6vFVvHApw16Z1MEiHSn8Pov6h1GnnIBi1cCevg5
         kzo9mkVFe8A/L3wR8fRzTngzzi/wS2HbDHlkIxEQ0MiBoLAKPgbzAfPImg30lpDbKtEk
         N+lsn558PmtHA4bHN0sHGA9X87IZ3gfOQfiur1Y4fI4VDBDusCmf/OShRUblY9lp1as1
         cyRvmHV2UHCsgCjmdRb2w4tk+aI5ZtIuxf9DCEEP//wBcFdPqqkR1j49Tahu3JwV7g9Y
         M9Ug==
X-Gm-Message-State: AOJu0YyaSJjqV+XqO5Wu/QaTwedfDvTtHM5kGoqTI1n9IsY5fjEk4aPI
	t4KIaUWUG66LokeogqkTXeRdOlwobW6K0sDx5lZj60g9SkaBpOMpR5yYE95B688+rejNQTQdB1d
	modV3mZc7o0avaO97078YWm+igvH0MQ==
X-Google-Smtp-Source: AGHT+IFtI/ptjIBdVj9zrFUBglC28AdRD4Fr3A0FBT2fzWmnF7GEYQsUQ9BoIpQcwx6efQ4jJtAvuDo6UmBkX12gjWU=
X-Received: by 2002:a05:6808:3385:b0:3d9:3538:8cff with SMTP id
 5614622812f47-3e029cfdfaamr335310b6e.8.1725563118378; Thu, 05 Sep 2024
 12:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812165633.49121-1-jwcart2@gmail.com> <CAP+JOzQmwxD5oO9VESSAbwYFSofMd0HiOoUBdv+E1=Ks9Xi_aA@mail.gmail.com>
In-Reply-To: <CAP+JOzQmwxD5oO9VESSAbwYFSofMd0HiOoUBdv+E1=Ks9Xi_aA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 5 Sep 2024 15:05:07 -0400
Message-ID: <CAP+JOzQpFAzqABg-XNyND_8SR2OmsCa9Xq2TDizyK4Awvi-FRQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Allow dotted names in aliasactual rules
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 3:37=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Mon, Aug 12, 2024 at 12:56=E2=80=AFPM James Carter <jwcart2@gmail.com>=
 wrote:
> >
> > The function cil_gen_alias() is used to declare type, sensitivity,
> > and category aliases and the function cil_gen_aliasactual() is used
> > to assign an alias to the actual declared name.
> >
> > Commit e55621c03 ("libsepol/cil: Add notself and other support to CIL")
> > added "notself" and "other" as reserved words. Previously, a check
> > was made in cil_gen_aliasactual() to ensure that the "self" reserved
> > word was not used. With the notself patch this function was upgraded
> > to call cil_verify_name() to verify that the other reserved words
> > were not used as well. This change prevents the use of dotted names
> > to refer to alias or actual names that are declared in blocks.
> >
> > The check for a reserved word being used is not needed because that
> > check will be done for both the alias and the actual name when they
> > are declared.
> >
> > Remove the call to cil_verify_name() and allow dotted names in
> > aliasactual rules.
> >
> > Reported-by: Dominick Grift <dominick.grift@defensec.nl>
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> I plan on merging this soon.
> Jim
>

This patch has been merged.
Jim

> > ---
> >  libsepol/cil/src/cil_build_ast.c | 10 ----------
> >  1 file changed, 10 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_bu=
ild_ast.c
> > index 56dac891..6884f12c 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -3174,16 +3174,6 @@ int cil_gen_aliasactual(struct cil_db *db, struc=
t cil_tree_node *parse_current,
> >                 goto exit;
> >         }
> >
> > -       rc =3D cil_verify_name(db, parse_current->next->data, flavor);
> > -       if (rc !=3D SEPOL_OK) {
> > -               goto exit;
> > -       }
> > -
> > -       rc =3D cil_verify_name(db, parse_current->next->next->data, fla=
vor);
> > -       if (rc !=3D SEPOL_OK) {
> > -               goto exit;
> > -       }
> > -
> >         cil_aliasactual_init(&aliasactual);
> >
> >         aliasactual->alias_str =3D parse_current->next->data;
> > --
> > 2.46.0
> >

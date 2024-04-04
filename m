Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B768F17BA8
	for <selinux@vger.kernel.org>; Thu,  4 Apr 2024 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247758; cv=none; b=lNrKrcLavjXIJCe3mOdQACZhOhRsRd7LW7ObvIOk3zopy/DzwjLXOmMW2yPFoX9s0DpuqvrPD/wgSKslFQX4NPK1wTJ/ptOA9Xv+8Sm5cLOdzmeAofwfd+is9424AUN+WXj6c2Uwus3HeYnWm+i3BflEJ6m6Vv1GtmmBdoT8u7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247758; c=relaxed/simple;
	bh=g3molthBz959+JPVnH6KuCw0WSzG8X0xkWKzC9giW7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ade7uutT/cp/EwzcBviEUnxxS2p44yG6aZVRSz/TljAwAAsKp90CoqfWMXuz9+zZANwIwEOOk05Nz4E3H8lqVEA6RaHdfAxjYUnPNE1m5Vf4xb8DCsk0wraVg8Y2+oNIGzzOgLGR4qJzsWvx6NMdIgN1hY8gFePoU8bf65kDpyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bA5d26O5; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bA5d26O5"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-617bea532f0so6751027b3.3
        for <selinux@vger.kernel.org>; Thu, 04 Apr 2024 09:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712247755; x=1712852555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFUw+/ZFj4K5S0ysjY469oHSy1ToVn8j1pZk16GQPs4=;
        b=bA5d26O5LGMUFk6IUwm0ZVNKsrW+fMEa9e3RGTJlT2Lg8G/npLvVW18q/hTgit+tSS
         IhAwm5ehtxxbtw6e24DdPWg9lo87Y++tjV994AkMBHnfo2T+lx6U27OBwhfCiUhPMdOB
         ve2XoYFOoAdbQQZDk6NFFggp6aMoW8FZlLVO0yAihEDmxXz1GXhoswizQYl5hsaMbO8G
         GtLGI10l7uLEF+FRdzLaSk6yZY02iWAwsXNuRsy3zeo4DHFM3K+wzqQSJsrwDwsWBweE
         4zH1rpGfjS5Q/EFOoAAjAoBBEigjozWk/NVxpxL0258D9MJ+VsqmVAQ1avdn5IBktqrc
         HCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712247755; x=1712852555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFUw+/ZFj4K5S0ysjY469oHSy1ToVn8j1pZk16GQPs4=;
        b=i08MWm5BUNkbwqL7wwburlfU2FJ7k/2BDRS03zSKdI+N3IhfScsRtErNfH3ainUVSZ
         rqsRMO6Ki62QVxVNGiw4lcJJ0oYUjcT4GLGLNaDWQFwbZodghDGIUIb8pcgP1bw/NlR2
         GUYGfKjFkk9Ia86QCFoQ11tur31FvkzR/dXOV5DKhDg97WF6cAhlbATVi+0M80xw03et
         G89HFJAmknTP7fqHfVYWwBXwx9uZbCQ+XmTkEEjdVbSp2mbq86QZmc3gNeeVAN02CwCc
         6fbmj2b4pmAeuP9FGVnNjBqchZKsb4QCXcRheluflj6LUbJGgbvrftQx9fsDvRUP/YPV
         DiOg==
X-Gm-Message-State: AOJu0YznVrCbu6GC5vdmiZaNQnRCHg5djZi5u2Dla94/vEd83anZ8Rdv
	pGWo7Fj37aeMjy4uvtuE+kZCdONz3acWSVxROmFUeydxAEUjhekCCPVPXsO+jKKi839hmZrT/ev
	xH4c/+MPw26Daz77qrPTSISVAJgSgE4yK
X-Google-Smtp-Source: AGHT+IG4IxSTKRCLOjEo/igpSd+nQXMLnZgLJdMo912bkNUMUXXyzau4qiIt1ovEXfYJBik2IcKjGktS2kyrCW3CsuE=
X-Received: by 2002:a0d:ca02:0:b0:615:8174:61a2 with SMTP id
 m2-20020a0dca02000000b00615817461a2mr3054393ywd.8.1712247755593; Thu, 04 Apr
 2024 09:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401150942.549026-1-jwcart2@gmail.com>
In-Reply-To: <20240401150942.549026-1-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 4 Apr 2024 12:22:20 -0400
Message-ID: <CAP+JOzS6VPLp0i-dKma8A73-F7XwhPdARCz_DEhQa1gEh5jhEA@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Check common perms when verifiying "all"
To: selinux@vger.kernel.org
Cc: bcressey@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 11:09=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Commit e81c466 "Fix class permission verification in CIL", added a
> check for the use of "all" in a permission expression for a class
> that had no permissions. Unfortunately, that change did not take
> into account a class that had common permissions, so a class that
> has no permmissions of its own, but inherits permissions from a
> common, will fail the verification check.
>
> If the class inherits from a common, then add those permissions to
> the permmission list when verifying the permission expression.
>
> Example/
> (common co1 (cop1))
> (class cl1 ())
> (classcommon cl1 co1)
> (classorder (CLASS cl1))
>
> (classpermission cp1)
> (classpermissionset cp1 (cl1 (all)))
>
> (classmap cm1 (cmp1))
> (classmapping cm1 cmp1 (cl1 (all)))
>
> Previously, both the classpermissionset and the classmapping rules
> would fail verification, but now they pass as expected.
>
> Patch originally from Ben Cressey <bcressey@amazon.com>, I have
> expanded the explanation.
>
> Reported-by: Ben Cressey <bcressey@amazon.com>
> Signed-off-by: James Carter <jwcart2@gmail.com>

This has been merged.
Jim

> ---
>  libsepol/cil/src/cil_verify.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.=
c
> index 0c6d50a1..4ef2cbab 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -1842,6 +1842,9 @@ static int __cil_verify_perms(struct cil_class *cla=
ss, struct cil_list *perms, s
>                                 int count2 =3D 0;
>                                 cil_list_init(&perm_list, CIL_MAP_PERM);
>                                 cil_symtab_map(&class->perms, __add_perm_=
to_list, perm_list);
> +                               if (class->common !=3D NULL) {
> +                                       cil_symtab_map(&class->common->pe=
rms, __add_perm_to_list, perm_list);
> +                               }
>                                 cil_list_for_each(j, perm_list) {
>                                         count2++;
>                                         struct cil_perm *perm =3D j->data=
;
> --
> 2.44.0
>

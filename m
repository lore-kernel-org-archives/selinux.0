Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1454F219A8A
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680821; cv=pass; b=lkXwtEsnmRGEjE/0xioesWFcaGWcrJ0PakyxiuD88Wp8Id+jfCgjfJyA6URZXufnYC2Kkfbu14oBrwd0nvtqXRU8K8cqWtKe9wGzg5lYLh5g2C33FkpItLMA/qgPGNpz6USTJSGu66UJ0hwdrlZZsfjGcPDoBjfVYAhWyVYvrXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680821; c=relaxed/simple;
	bh=QvXGYwgQ3VL0tAMWqQLR0b5DABtV6xdiDV0qL3tBH5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUAqpIGBjLz2exgDu/CGQ21f2LAiTiQZs0sjeFJleNbmL7tNYtdG2B7K9OfvLNuVq4xZJUCIrpJyHpSsbBTc9YAP39NlKFl7bOUkEYAvfUoRqUN8FJO9+qNt1hvfHXwW3F5uisIK0m4k08MQ5ujhB8Od8yThi73tYvFEKPs9AmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bETqsYsm; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bETqsYsm"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38eab6cf7d8so50110081fa.1
        for <selinux@vger.kernel.org>; Wed, 13 May 2026 07:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778680815; cv=none;
        d=google.com; s=arc-20240605;
        b=BvD2XnYrDzJrWO+p5e916HZt5IbsCJdpPj5OrahOJ4wvsulFofsZwuLPpvUqoJG/T/
         MC0nC4Pxv1ztp6Zi09oTRw5lJ7i63jzOsLn3N0Kyp/lFrFuo5QP+ilD8817psTKIPDkH
         ODhEIxppl/eNHbfI8SfALHdrA9Ro4meyCsPMP6rZlXZN9/G3VAi4url4EgpM1D8zjZ/b
         ArlYVewR+lXY7TRmeGCvyiEqoOcH6Q5Ga7D/hP/2uKQXMWA3+be4iNAjZdiYV0a55oR/
         BCXU2eGerQ7JzWYOqXRPSXWPKQ+7wEvSmh60IhTN5CRd+TG38kXu48joiFLraglr77dX
         elIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z9xRQ5ABKLD0ypZo+RTUB0ixsgcyKOkan8PAmwWtd1k=;
        fh=sVsJCIfdneSLica9tUmnd3pgcYWv7uivzEEV5Gbn8OA=;
        b=ZEchMMnvj340X0FcKo/LQX6+jKHc8O9feEC41IRZTrO4wq5J+Oricj1IATxW3dNXrN
         lb5roTyqCqf0UxIyl9VZSD3yKlLFytfmuh3F1R+cJtHxr+7o+hQ+AOh5N/Tt2vRy3dNl
         qE6m83ApNfYNc6H8UJFM27OM3PfvG3WM54wcz+q5mXopvy8ZaCB1cCNL6eSCaOzJHHXY
         i3+xBFtHFY8CJKGigeFnA0Ul0ChLt6GFwMXLYRSUTi246bGHM1AgVjc4CaSMxitQKQph
         KuPxmAAjylOoiWpH3WciXkiAqhr0LkAJicziKzcFI57RuNPVPY8gfD665x40yoBBfLIj
         e3ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778680815; x=1779285615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9xRQ5ABKLD0ypZo+RTUB0ixsgcyKOkan8PAmwWtd1k=;
        b=bETqsYsmTEujSCEAqu25aAPxgXEeBB2CxBkiTJmC5U4zt632T6BEDwZzj0vmiKF4Y5
         n9e5TUm4QWtXC9rn3TJsmPKr+h5B0RJ8Saa643GoKhyMqutJ5CRyPg3EVPQRkUET5A4n
         46GDOh17zoInnsjPi3XOXTynuQiP9ovmjPXLbPltQsZ/Z4HoTU3tC1HfNC+fLLHsn28l
         pDWYRzNejMQz3xnP/ICKYtsmhcgEDd5ixGsSUBUf6y1IsmXIpU+37sA5ph8PxZDaQqtC
         bK888gVYY6QTpxBdYUp4MLveOieFwj8jbg+CBjTd+cOg75hnOJHm44yOOTUxsP/WNZQY
         tI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680815; x=1779285615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z9xRQ5ABKLD0ypZo+RTUB0ixsgcyKOkan8PAmwWtd1k=;
        b=JODVKvWDvShfpob5ZwdelIwbE0YaB6qcQMEkzgb+oTeEoY4k0wZeGdCJMg1RwXjOj8
         GcLyOTGI7V8CaI+iEywlrKEnwaUubF5pNGqpKxE6DatN5EGlgKNvNWSDC0TKGqjHiJoN
         jaBTcW+Li32wn42ZTqDtY2opJXkSvb0p+OgopSHH3yLjiRQCfeimnz5FUHlhfOQh8wEt
         PBKkVdPnsYZYvv2T3R2ApOoxFd/PZb8Tt0pqLTBU+T5l6BRnGomv8nMq31e/nDdC/lGA
         zGbjjmCdnwsYxZ5IHMLdZvZ5Dp/f74jaoDWuexJhfuWJp9vYZ96VrjZhTNRQknxcY+st
         lAyA==
X-Gm-Message-State: AOJu0YwZ8TAdiv2CY/4s98olD/hTEPqkHSUnCM1eDy7LY+CGfjufaGnr
	T9f4z35d/EsO643FkM0X5ljy/d6Uo2lhlID5MBnvNMNIRkHbHnHXcnSCpJsuCG5Mq2FqL/GolmS
	62hS4B681THFig0Uk2zTaht0GavmJJRRvsQ==
X-Gm-Gg: Acq92OEKwIAvDPCMVl/neqzsghwUcawjl3XZFJobRvugNz42xi1DjWevodmcqwqyhtl
	VvwFQQvKzVucopZuzLD1tgE8vWdL0ZwS1B0yOAUtLwCZMDDUUNhJj0fThFxyjlv2iPoiPdq6dCV
	YwIOSm6OBJfS+YSomKwwT/eilMfJRglRu3LjOlgV9h6BaagOJ1M796CsZphgQgJU0eYxcLIylwz
	XAb8LaViqNpDsbMFQNWjJKKsmtsgNSaIJz+4F4jqQtOn8R8qm2Kt9wo3vi//sYpQDGPy5xCC+lX
	oTE/
X-Received: by 2002:a05:6512:4009:b0:5a8:e340:487 with SMTP id
 2adb3069b0e04-5a8ef93488dmr1114508e87.9.1778680815380; Wed, 13 May 2026
 07:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429134558.109817-1-jwcart2@gmail.com>
In-Reply-To: <20260429134558.109817-1-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 13 May 2026 10:00:04 -0400
X-Gm-Features: AVHnY4LzvzaAW59as9c2EywD1a-j_id6Mr8mIANISMbJgbqPDYeVS0xKff6c4Zs
Message-ID: <CAP+JOzR1msAk2eg_EwvU2k+-vYvmnpPYXGitG39TDEUJVxJaDQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Change log level of "Failed to resolve" message
To: selinux@vger.kernel.org
Cc: lautrbach@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 9:46=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Commit bd56ae44 "libsepol: When resolving names check if a block
> is abstract" added a log message to report that a name failed to
> resolve. This message was given a log level of CIL_ERR, which means
> that it is always displayed. This can lead to a large number of log
> messages when a policy has many unresolved name look-ups because of
> optional blocks referring to policy that is not loaded.
>
> Instead, make the log level CIL_INFO which will cause the message
> to be generated only when the user requests higher log level
> messages to be displayed.
>
> Reported-by: Petr Lautrbach <lautrbach@redhat.com>
> Signed-off-by: James Carter <jwcart2@gmail.com>

This patch has been merged.
Jim

> ---
>  libsepol/cil/src/cil_resolve_ast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_re=
solve_ast.c
> index b0965f1d..048b3aaa 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -4407,7 +4407,7 @@ int cil_resolve_name_keep_aliases(struct cil_tree_n=
ode *ast_node, char *name, en
>
>  exit:
>         if (rc !=3D SEPOL_OK) {
> -               cil_tree_log(ast_node, CIL_ERR, "Failed to resolve %s", n=
ame);
> +               cil_tree_log(ast_node, CIL_INFO, "Failed to resolve %s", =
name);
>                 *datum =3D NULL;
>         }
>
> --
> 2.53.0
>

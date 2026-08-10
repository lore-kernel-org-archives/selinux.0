Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27E73E1701
	for <selinux@vger.kernel.org>; Mon, 10 Aug 2026 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366765; cv=pass; b=UT/+seP9HfjRlHSinTTECG6rB7AT5nBUqWONQnJtASJTmSyolkb3uRuJvhFi1dKbfvxCM4ag757ya+7XrARN/ajreQSLEhNIiC/sSmPsS9SI/h8XzU76c+PdwnTdGimy3CVgBDjeMTJZKzc+AVBOVtTtCRr9y86LjyY+ZMP/riU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366765; c=relaxed/simple;
	bh=gsxLfADuBnu+bmgJ3Udh1+tpszGbcklqoCPmyt5c7FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nujJuOY/SzuqmhPqv2MjkNP5jze9z1H+WSujCBP9+ZnN54ALehwkc0RcHys/6M0rxwDXVWWPT3JhZGqj7fuw1/VXf85DuqdrR0KdExU8ke8i6oE3mByEuwoSUkP2My5cg+0hjteE8hozxW6bvOZP6eNkB64V68wcOSTvNuTqUDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZU1qSpSV; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZU1qSpSV"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-455ca262ccbso1030612fac.1
        for <selinux@vger.kernel.org>; Mon, 10 Aug 2026 05:59:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786366762; cv=none;
        d=google.com; s=arc-20260327;
        b=jVp+xQKmK82JsgGkggr62AZksOcT4bU4aw8lQuroa4kvQc1hpMrdV9p9yDyXu5PJgv
         biyflS5kq+TaINA0NIr4Kc61gbKhWvEgwM06Zexo2EfeEXcXnRJOGKzSemLyhCbSMLez
         entG0i9gbKwJzZX7cP387DkF3QLkpdRaXfuwJCkWFmSrrfQzajQXS1K4tS5XyvbzFaAZ
         R/WvTeMWHEZ7Rk2l+Y/poBSryIbpz+uFfoKiCHx53Vkw1ksq5fIgZ0iAKY3/xWshpkD7
         kYmwaZRA4ifWwjrRdlzmDNV8s1PH7OivOtgvgofgR//upKj68ubOG9PRRbjFz96eOceE
         x8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gsxLfADuBnu+bmgJ3Udh1+tpszGbcklqoCPmyt5c7FU=;
        fh=wY5cFNIrFxocNXn8dhXLjCWtx2mX+LDI2hsGzEtklkU=;
        b=mZmOAHa8R+shhNwLuW4Zd8gl+dq7o2RKG2aQh48hNEm3buyLdKRE72Pe/tegBYqYMs
         es3BDQTCIYWDXPNaoGh9PYIb/IKoU6szk0k9VNkSe9lmdJOxYKZxI/pd2/bNsIPUdUlJ
         JppddCwTP8nbIFEuEq4D/slCykkX+tv07XmC9OO6ebV8aB9mgENJOshSUoGuTmHYXBu3
         TSkZBKNTzoso0pwo6AStBA9GudowBEbSDuO8noD7P3SFUhxg+RnSaN5IUm9O9WoZW+Tf
         qNhZIpDlBByHh4kAVSpsU2iv/Imoe+2ixa8Mrmc+YwP1Q/nGEM0Fd/5zOzgohn0pWfII
         PZsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786366762; x=1786971562; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gsxLfADuBnu+bmgJ3Udh1+tpszGbcklqoCPmyt5c7FU=;
        b=ZU1qSpSVr3HrPSiI4pGUY7NtO5bxLwufHzB+32sJslsziS8T6BdQ8GdyY5iyqpvdMM
         v3TKL7X9pGjQ/sFLOZMHO/B8UnQ0legHYj6WRIVLXx6KiIoxwhrxi4FgOF9OQ//33lVZ
         MQ0TAhvfTF7ngTTP0Qy1Hh3jJKBShO4sgrpY7VF0zvW33tdetHSxLWE/8r1rcqjBhLhT
         JXnLn0zb0KUpKmrmrbdHfITM6qFZHY6z+hUz2ltkwGFPJPdZEnC3QvRFvDgG3FEJOYwC
         AlXE4Vhs73RIRLrWp+D+W8Zp0HpGFZQE4TStRAQbe9ci1Olf0ByaIVznMP0/MDEia29q
         dv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786366762; x=1786971562;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gsxLfADuBnu+bmgJ3Udh1+tpszGbcklqoCPmyt5c7FU=;
        b=AjWmNev6qroUwvLtUNyvxsIyiWDXEyA8z2DPzrpvFKQ30SPw+OFwJFM7N8iFk4om9i
         AF/zlUqrYulEqonRxjdcT6zCvB4nrgE5Y0LmVsprHe1D1jnEuwhu15AP4jFI2ce+CcvF
         jpafePKS7aCZhhKhAj40+7IwcpRYv5SLYGua5ZK3cymknAHYznuPO0TLuyma+lFJFS4t
         q2bFshuQJPSUrisIFGtMKul2OjvurDfEaRkVxvqyqbpLzUXFSeOC/lTadNJWmisNS/oF
         YjBCQQ5winIJZ/3LxOpnLuPqNH67A/JP0cUOARTSTARIrfFmn5AUsxyYEtgfitduj8Yf
         30ng==
X-Gm-Message-State: AOJu0YzUzy9dJ5RsQEP8IeEkIV1pTAJo2qhw7GYtdCUGxOJrv9jhA//T
	zwPt31h1jCZTusj6juDVviAaic147brxrNhBgXhMNTc4QqQmtWzvRt/4VQkwaXj+17ysa3nVi68
	/LDSXi2Nu6QgrYVX43W2rMuQnNcuOf29ryieV
X-Gm-Gg: AR+sD13bWpj1lzMLI95RpY3nTjOTQ5vs6ZrvgS9CFGKRShpSKvGTrbEIizr70gMdQqi
	CA5pVHs24j/90BBmoSwlgUuhqBWS6zuDV9D02oAyuNoej6wZ5x6BXNUdFUN6AHWKrMKlRLmFzDG
	n/iyI8WWvEyzucjynozS6SuUqrY3uMjDok44LYA2iXXt/yr+O2rAkoumg132B7QNFCjjtyERbkO
	/saKKQ6+nohqVrObogzGRjy0nbRWGNavzj6WxrQW6pm4VcwmCte/y7i+02gYyY2yrOKAYv9tigU
	2KLyxnZanm6umH4ifZWSM0ICg7HHl02FMh/CrIaGI13l
X-Received: by 2002:a05:6870:911f:b0:457:70b0:b286 with SMTP id
 586e51a60fabf-45e060f9374mr627301fac.18.1786366762679; Mon, 10 Aug 2026
 05:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807193542.21108-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260807193542.21108-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 10 Aug 2026 08:59:11 -0400
X-Gm-Features: AUfX_my-oCKw5BDwA36m1nIckjsmg8QNVea1rVxOkJZkS5CQvNz_qdgCHzlvyHQ
Message-ID: <CAEjxPJ7OoqhGWuWQ5Wxn3DK27zA1myvg_kuwOHxwDYO12nHb5w@mail.gmail.com>
Subject: Re: [PATCH] README.md: document the minimum kernel policy version
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 3:35=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Document the minimum kernel policy version supported by libsepol. This
> is independent of the minimum kernel version for libselinux and other
> runtime components.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This is now merged. On further review, we could in fact bump the
minimum supported kernel policy version to 26 (Linux v3.0) or anything
up through version 30 (Linux v4.3, Xen 4.6) without causing any
breakage for still-supported versions of Linux, Xen, and
libsepol/checkpolicy/secilc. I'll defer that though to a future
change.

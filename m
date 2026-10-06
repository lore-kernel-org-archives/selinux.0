Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6863145560F
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291284; cv=pass; b=m/OQyBdOODBvUkeAJHVUmY28u6sicI5kpXCGOpEOH+VCaJr8ye4jzjVM2WH3eafG3lwxga7DgEfpFzuCtfFBOd0TEDGqheMtUm1090h25xoWWnNa68RFNcNfhKuxMcFnIElGTlHOQPKTRqPpeC7i0GgVvkukDLuwoWqMPoIzJYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291284; c=relaxed/simple;
	bh=0i/bWbo+5T8cil6x/TfECnJHbRgOmGtAxcsFaKYJIAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jto+wHhxQ7y7wN8A5pR5AWcqigP5v4VTZL/3j5F7ptwtFFLEdtk8ig0uciRR/kC/gydJ5VU8YnPNmDru8XUelZ79O1dMxE9bndRRAZIynpr7P6D2SYKW6t4mvHSgGn21MxqpzzIBA1J6PMuDgyC5YrJBa81nOaFnkNgclJ7yUQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rG2cmzzH; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rG2cmzzH"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66c7e3a2332so1976978d50.2
        for <selinux@vger.kernel.org>; Tue, 06 Oct 2026 05:54:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791291279; cv=none;
        d=google.com; s=arc-20260327;
        b=lIfJ0b1fm/1VXVs26+09DsYn6PN7YNM/lYBCjF1XQfZB3Q4bxhJxeq7DCEkHt+mF1z
         mgoisBLvYszfsn3LT9/a9HqCAk6gAg37A9OePnmEHYi7ImzusHAA50knp9YhEfMfHFAP
         qaOu4p9jVMD+GP0s1Y145oMh4/cG/QczW6rF13KIcaqRYZupI+R16i5+IrJ1fOAFReNw
         HXGQfNqWoscmXKbtKkGcGDDXt91g7Z5I+2EwNIxF1/iCxbz7VQ7+oIfN9r0/o/64w3JO
         z30PYGDmwxjUAAtncZqY4rIFLAn45YCowithTuUJPszUmBPPt9ngXIrtsqPH9i6cdYA6
         RjHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0i/bWbo+5T8cil6x/TfECnJHbRgOmGtAxcsFaKYJIAw=;
        fh=E95boLTiTkq8XsjKw8GK1wyz25DmW0RgNCvDUxEAbME=;
        b=G+qe2ZFbZgUXPt780G+EYieri6IDYjtMPdFDGQdcQKWuvRHOYxFRe1+lBq8o6uHIKx
         nWzEFSaQ6W6e0j8wWfa2dzktJS6vZTOvYJFAalD5criAJnWkw+bCGQX8exORW8ojl1pE
         r+xu8KPsYda3+BBvWomcU1504JEVI0Ds8cxULX9kLtxxWVbfk8m4Z6U8b8E6zmn62FBF
         8Ob35ypRyVEiybDDUUDXu0YfxGdVZZN3EgkUz5ljJVVHEOzk/vzxPnNziBb+OQUGQCIc
         hzQf+9aG5Vtc/EYYAlB/D6ODPee36ZwIqK+0EyiiCyjCjeCLzQys6fCrWFPffls8YKja
         s+EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791291279; x=1791896079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0i/bWbo+5T8cil6x/TfECnJHbRgOmGtAxcsFaKYJIAw=;
        b=rG2cmzzHwM0uLsxzESR591k61XSLrM4JW+vANIMce8OxYlia+kkNXLe7eohAcrm95w
         hKAZ3i5wKZg/b4I+ZVrA4zhsgwi5/Keomuyzh6RuOpz8cLuvcQP8rGOtTGHurm4Zpbko
         XRJaE9+90L7Xmjf5lwOQZqKgpLbDAZ94DXhrVY1JVgXDxsK6MPdZQaAZ3EY1tfkULSAt
         kNIBeWcfp6cUULLbbIukjT/4/XFkn9JdzknQrqLQxu/Y31fOVRygG88v7cqondsUIGse
         fPnY/nUpHtLkj/Xj9ljuyi0Dx39sjYhqttHvEfMjl5WvUcRcTCgJCXI8tWfz8WPeumxv
         uZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791291279; x=1791896079;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0i/bWbo+5T8cil6x/TfECnJHbRgOmGtAxcsFaKYJIAw=;
        b=iEkPzjnsk6BXRCAEt/zWv7zeJDQlP/6iGfIhW3TqB3kyImALeIAP+3tH+F3ULwviO8
         a/KjBJKzwb0uhQTR8TzhvoD18TE8Dr8rVxB4vY/MMlCakQis5y9GlHdEhvM0cfsPkYjK
         LrMb1x/o3jvtyNcnflfzc+mnV0UiavjtvB8iRgS1AzEllXxIyHfubemhCZaow2WmNe1Y
         0rdfUa67GIRPEF+0BXY/bCJ2NzOlOcSJbqRCAfJSU/Leo9XFSgEOYlXw+wHUbpSujNvG
         oRG8JjkWctZ0GXTTsjitpE0lQUHJr223IEwcIvKF0J/ywGqLPVYkyuXbpl4BRQNVqHm3
         4mTQ==
X-Gm-Message-State: AFq9FYKUzCiH7FVbGanMjEh4xP3e+ueSuPKqbTnLSLxViVtgvDRNGJ39
	+2wY019JMPqVGGzwdUNpjKryww16nfs+QZknWM1pAP+K+lyKP9cYm1swhgigLAOYsff5yDzM4DS
	64N/bCOlih5J7gOi21dtVduGU3h3xMxa1j77F
X-Gm-Gg: AYBFou0+PS1sdMGc9/UIlsbZH5fPyUHGBlqXC111wfVlZ47gtnBVB2BsU122wcEL/rm
	EyFdOsYX0KySji4HJhIIqX1JHa3p90qEsDUX8DkNMTaf5985GfqqTsMlP+getKaea0QtPSEmFLi
	I7JC6Mev6KzUQC1dwiOntyyDATmeYDmiSOmr7nFjvv9DsXTyHUh1bNXLO6YooB6ym34bd/na/cU
	cWaS9vpmPqtTIF1wPj3vAC5yNGcPwUkXA1cqBktdboNxUcxlAggWt/wsUaP3m9ZqhU5dJqSrCFh
	7j9Rz9zdX0RXiekgirTwDed59aYUVKFj7hePvo8KFY/OWxDfLM8ab2qF/mhXlTdeFQ==
X-Received: by 2002:a05:690e:1441:b0:671:2f4f:b2dc with SMTP id
 956f58d0204a3-678fcf60692mr424919d50.84.1791291278771; Tue, 06 Oct 2026
 05:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005185343.2782019-1-bgrech@redhat.com>
In-Reply-To: <20261005185343.2782019-1-bgrech@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 6 Oct 2026 08:54:27 -0400
X-Gm-Features: AclHuK-VSgXRRoYWbw8y2RZXS2FpQ_o2U1ZUXTjSE7ImM1F4oPGjKnmZfevzSMc
Message-ID: <CAEjxPJ5_ScD4Pxr0djXtow7S-mJaTDLydti1PA=XapOrqFOrxQ@mail.gmail.com>
Subject: Re: [PATCH] tests/io_uring: check io_uring_disabled before probing
To: Brian Grech <bgrech@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 2:53=E2=80=AFPM Brian Grech <bgrech@redhat.com> wrot=
e:
>
> With kernel.io_uring_disabled =3D=3D 2, the unconfined probe also fails
> (io_uring_setup() -> EPERM), so the probe's generic skip_all fires
> before the sysctl-specific elsif is ever reached, giving a less
> specific skip message than possible.
>
> Check the sysctl first so the more specific message is used when it
> applies.
>
> Fixes: c3911c7 ("tests: skip io_uring when unsupported or disabled")
> Signed-off-by: Brian Grech <bgrech@redhat.com>

Nit: We conventionally use 12-char commit hashes like the Linux
kernel, but I can fix that on merge.
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

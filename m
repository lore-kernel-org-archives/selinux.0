Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E452E3710
	for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 02:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753323277; cv=none; b=LLE2KerowUyXGa318Wk1f+hxvyV3rS/QxwX8a5hIB2ytZx4/aTgkvj7+aBGx8XW8S63a4PV+JMYiqhfk8vABc+0CUOKSOW9UjuNyX+ASujfoJjbytkqq8AnYXlX4JVfqEcPlSkLbra6PimlrmA5PCDBrj2WwAA6iZSvKd+XxP8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753323277; c=relaxed/simple;
	bh=+e64xbNtb5wtFJ4daFRvY+EmLJfoQXxo60RzoekjTVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bF6lczpWLFK8N4ZEacZrx6Uc88Zzwn8W0AIvq98ow78Fgu1js50Led7aEeYiLKIxEzXyEt64ogXDPc8r5VMuKNMyYvzMvKptYr2eXHLHzzVK+UWE/9xmHdBRYM83GfwKxKQSw7ytwSY/mi6RUNpmeoB7x+d5BObpVIMIPcai7Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AeuEjWci; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AeuEjWci"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e8dd5602497so382137276.0
        for <selinux@vger.kernel.org>; Wed, 23 Jul 2025 19:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753323274; x=1753928074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oyaxbTVIE1qfI2IXsReOJiGj/VIIyNJNhXOdOAruP8=;
        b=AeuEjWciLCLiR4CDBbr7XiOR46TMakApJpC4AOnRexplkVGYwf9ROd1tRYao6BQs/K
         8O3hX8+8v+T+AMFHD+d9q3NuospdjT0N+rSFTzmSl2YQ4gbDI4Joyf+m9FFqf9PHUfTs
         kZ8RJTkfkp8PaWp2RgGWrbIImQON3vpWc8YLLtFxq7AIVKh5t/yp9ZEABT56InngfS/g
         dJClXE7/gDSp+dGCYdpDIka5dGmVN/goy5GCyA/QooqyIYzOrUkBhf5lQftsk/y/6za2
         4/WvrFRcAfVenaaWQZupA9Os2Sym6ADtS+lecwkOQMrF9Ypshd76UF74tmN+QlkA8WHQ
         Cf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753323274; x=1753928074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oyaxbTVIE1qfI2IXsReOJiGj/VIIyNJNhXOdOAruP8=;
        b=Zh5vGRKepW1VIbLqlTnIVSMfTP+dkUKOG5m9OLxjcgNQlh5mfw6T7bE7nSo4m31r9E
         sMoI8lGxhnTwqL2pYbVYUVrVDKKnXiN/4bPuVWuYiQwFqOpuTTl6MZko+7IgmwSvPvA8
         yn8KOROembGMwvWMZC1GV5SZ2+8sMgFYw02lLM6ePQu/wMs8ggXJMnhSLXcNHzfgdCZx
         UIY6bE8tUtxMw9TjaHoUXcBWFKoQa0LCZhvYCZvAWbp1sasELCMp/7XhJA/QX1xWgMLD
         uq5F/COsIy6SzGKGsvsK+6HznoEapofPuUNICnnLU7QO8A027+gv+EruRk7XngOEJpmr
         g74Q==
X-Gm-Message-State: AOJu0Yxj1/ndS0juPwdbAce3QPR0CF8lYaXfVhznwtiCQ8DQQSPrFJlc
	mGLlyQ9kmiiIbXQegfnd2VAsqF/XxJPcStR2Q6LcPlWPwfrpNIu7RPPf4HhZ4UjJIANZE4whzUJ
	a6UKDD8OXPHmQmRwdCHVAZOs313EXhWy+s/ftO0m0
X-Gm-Gg: ASbGnct/tAwDbOh/PkJ9WGh2hK9Jk9qcCmViD0NKOY03NTSSlv51vsBKcPVJx84jgsz
	ieRNVRbWYNCjCyYc731M9D9qNwOVefap/TIJGvgyS+N5g7dJhlL8VwVDI/VMoAOnU26NiAWUszk
	xhA8ttQe3epam3F5TiLRhHoA9cMD/vejPsh8mm1ByhRj5cM2cWtZTAs8F+uTOqOpuEX+CtKueae
	uvVFes=
X-Google-Smtp-Source: AGHT+IFyIId5sI67X0GpwBeScBi6i2xdeQndiJMOPFDXWrD+lQI5LoruWwk2XUKzbj+0RkY3xzrX7q4XkSlGqNNFsq8=
X-Received: by 2002:a05:6902:3402:b0:e8b:e92c:58af with SMTP id
 3f1490d57ef6-e8dc5b09e5emr6466274276.48.1753323274544; Wed, 23 Jul 2025
 19:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723182550.1065144-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250723182550.1065144-2-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 23 Jul 2025 22:14:23 -0400
X-Gm-Features: Ac12FXwAwqrzOlqoY3NqEU_T60vfN6wsXqXkn9N64cvMp1ws4xcFaXydIhJpF4Y
Message-ID: <CAHC9VhSUbZrbV06hzzu5kNwrgojjYVYaUL_Yto+stWD1C=XZ5A@mail.gmail.com>
Subject: Re: [PATCH userspace] SECURITY.md: add my email address and GPG key fingerprint
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 2:27=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> This key can be downloaded from https://github.com/stephensmalley.gpg
> or
> https://keyserver.ubuntu.com/pks/lookup?op=3Dget&search=3D0x578c4211832f0=
a7ea2c5a7c221a46e603f744ecf
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  SECURITY.md | 2 ++
>  1 file changed, 2 insertions(+)

I have verified that the GPG key identified by the fingerprint in the
patch belongs to Stephen.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

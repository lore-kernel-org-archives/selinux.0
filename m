Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C2216FF44
	for <selinux@vger.kernel.org>; Fri,  1 Aug 2025 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754072911; cv=none; b=VWTxn/7GHp+7iW25evlEByp7i3htffTSJ6yfw+OphGLRSRbzeHcu8ToiPZ/PMWn/5H/hcpN9P91naKXVUc3Zbgmu95tJ4buugYtVKHuFMLNTI5fvHL4QgH3QEAyRZFTfG79VDh+AAsZSIkjjE9SkQgRcMra+uAnicUbqfIKxh2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754072911; c=relaxed/simple;
	bh=Se7RiHpdkWPlAnZvn5y8yOpernsrhytGxlENPsib8jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TATH7kgUDjEa+16vTaSrPOPyBE5w5ve0fvWhte1jWqINSxhsoqPLWZVL0vO1qZQmPxhhlgNoqmaEa9n2Of07ddCGKbOt1JA/otzWXM1pGOoUw980zQ4Ut8QWO967EhLSPSaVTq5kQq6DuqnyO7D0ePbceuEdQIQg9nzSzOU8qtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaN/398f; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaN/398f"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31eb75f4ce1so2174414a91.3
        for <selinux@vger.kernel.org>; Fri, 01 Aug 2025 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754072909; x=1754677709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+Cs1wWJbHyYZGI7ALAqo3xzdz/9esnKln9lPV3zNeE=;
        b=BaN/398fOturUx/U3Gt3y3AE4uikAzhwV7AdthPOLaOasSIuaW/oksWCjoyBn5s6J1
         JPaTmxb9KdZ8ZZ6QPVucT1NOQIIvklyUTYq6fubPm+ZkTi+8ECjpoiI9LWg9R0RNZSEv
         TtACdcjzd2wlg2Cl9hgNR91Smxq75uc1lgIvXjtYKqaVP28MHmXE/dubTIj29iXDfINR
         73yRxT5Ce3kLU/8Oo32jo4N7hvxEj9ZWAottKDaUkvJxXdbCV0nrkk60wDDYy8l1ZF8G
         68qMMXkPgIr1YPXAl9zB3CIOCnj4uQ0xFJpri3jlpI8dvvvL8Nwrtodi+Ti+ly2GPGwE
         kkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754072909; x=1754677709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+Cs1wWJbHyYZGI7ALAqo3xzdz/9esnKln9lPV3zNeE=;
        b=MVqXQgqeeA6vFBbxSaF4mYwFFYxHXIh0dil413DjXxI3r8aWYptLO2GZvIGgHCwR25
         T+JljD2XOCN/5kCN6ksnQyDDvEcgiPWm3vXVm9FHssKzmOfp8fzZQXiWrDh0yVgoSBe7
         DLbCIrXT0jkITVKy0mWmrz55eeir+WGlNgb2cczuQBW/iNxz7FDACC95AsqZv5Bg4uZW
         0ZtI8Eemkyl9dpC48XMy3OzFJgvIFFm/jnGspwpE3/YWRoJ3TyA1Ae5xJAAnD25dXTYf
         WEsESmEXZprPmINVRnG2mhdvD4VhIwF5LuY6sdYW1YD81Ql2IZHeDhIH6db7x7X6DtSd
         fs3A==
X-Gm-Message-State: AOJu0YyX4Fv+W9Fh8gFvedGUlrBQ3h7d90y+GIcqTP2URBeR/RWTm6n1
	l3hav50RWvzqKgjUYtgcAHpo2wdFi12+uUmb90+BfPygrnKGIf7lFiIlos5fbi1EqOkuJG/KIsZ
	VbIHklHH62ObJBES9D5EISNuho1cc6CE=
X-Gm-Gg: ASbGncsESA0Q2eEixlif+iTHAwfKuBAONp+OezVVp6iNpHLllBCkFNR4ARIOvbiUYCD
	VmqBIQwDJg6YhmBNZa01/wFk0ahUJMusnmMmw+4q1bJ9f0gE2RJKC1N/yTbK0do65kMfuuMv8Bm
	7lo/WpOjHUe2HspvWFaFAfJ6MDBfsOfpGJLhdynlsZjs1lMRGuTU//XKrKlL63AR8IASeFU7Ftt
	a4gQ58=
X-Google-Smtp-Source: AGHT+IEAi4loZeU2WtWJqCtrUhAKJGGCcR8aWhrVfbAg6rkd7kFaDJPmnyVbUev8eSg7yB7Z1JEa/14GYNRHTRKbalI=
X-Received: by 2002:a17:90b:4b43:b0:31c:bfb9:fca0 with SMTP id
 98e67ed59e1d1-321161ea32bmr944431a91.4.1754072908506; Fri, 01 Aug 2025
 11:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DBRAEESRVT8A.2W2FHL146DBLX@gmail.com>
In-Reply-To: <DBRAEESRVT8A.2W2FHL146DBLX@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 1 Aug 2025 14:28:17 -0400
X-Gm-Features: Ac12FXyIdG4MbhK5v6iSpNtWi69wpfyeEqAj4xuqj8yfhRIRZXnpufjUykr39fg
Message-ID: <CAEjxPJ5KspE2imGEwx9EQJ131qdjufWg6Y5r=Rtu1ogde=9R7g@mail.gmail.com>
Subject: Re: [PATCH] libselinux: refactor selinux_check_securetty_context
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 2:02=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wrot=
e:
>
> > Unfortunately not. It would be good to specify one at some point and
> > start applying it.
>
> Ah okay, and yea sounds reasonable.
>
> > The selinux-testsuite has a tools/check-syntax script for checking
> > (and optionally fixing) coding style; we could either duplicate that
> > for the userspace or come up with something else.
>
> Maybe we could consider clang-format?  My understanding is that Linux
> has also adopted it, and our code style doesn't seem too far off, so
> that could probably be tweaked without too much work.  Also has the
> advantage of a lot of tooling and editors supporting/integrating with
> it.

I would be fine with that, and with using the Linux kernel's config
for it. Other SELinux userspace maintainers are free to speak up if
they disagree.

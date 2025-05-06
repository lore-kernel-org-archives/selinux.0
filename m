Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7F81C84B8
	for <selinux@vger.kernel.org>; Tue,  6 May 2025 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560081; cv=none; b=tj9NagR9RZ2iTEVGqXnL2QRWPETBWnGtZf0qZol1yMIaxdF9Q9+pUImvMc2ry955JEoObIFARfdqVdiw6AwEj0W0vFhR3E10pR4y/j3x9AIvMoA3XrL+4Oq11wvzPPiTNxf1SPBV6kqfK7cH4D6jS9IgNn3AFhStyOrghhraMak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560081; c=relaxed/simple;
	bh=XWZQQUfj10YH3I3hZwzwrkKZPNR6mlXeHwJzDHYND2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WV8Emy69Q9GQg0S8YOIlDyTORSp5cHKYtKbvSsy7FSizUXqcDVi8dUgpwC0f1Z1mjrsoLwt4ECHasoDoFZTrKa8ly6FB275rYl0cP3tq7xFJ9VT0hg53gjSnZvO0eBfb7Fy0jWKbY4QF8dxmGsIZ20gr/j+E2Ejgsqfkoh0ZthU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uch8C1DI; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uch8C1DI"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86feb84877aso1437317241.3
        for <selinux@vger.kernel.org>; Tue, 06 May 2025 12:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746560078; x=1747164878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftVrbM3FT18CLYZt1ry5Tzh/naN9/6uBeyj6OEbzONA=;
        b=Uch8C1DIiHpiS8jT44lg++8q8qJZX3I5rnQVzf5c/jzC7oXK9TfHiiT7k/wCUj6Php
         iHwTWzjy+6mTmAl7KEYTqfJzgDeL/gOKUBYMVCHyGqeRG+FRtxX3U/d2faG3rzafqDaE
         OH1A48wc7VOzDpRp/CopI3VsR/p8Q0jksIGjdO7iiIftKa96CUCRf6lU9zJyGIsF7q9h
         J++RzhnBsCtVMEKu0I4NClb7iTOxHTrePWOmBV2mnp0+9129lPjZs2WlvrpyR8S1G2zO
         pJ28BrwqmZnsl8IORvlCMOs3EseQ473S+kR3cxObO7xMr/1m6gMBDSpT5hFR9l4nIVMk
         aa1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746560078; x=1747164878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftVrbM3FT18CLYZt1ry5Tzh/naN9/6uBeyj6OEbzONA=;
        b=Ss0cSyMp61vXFlRev8v6AIPA+i6LCzgwPMTbwsWm6FjQQphbgyJr2w43sMEJvKIXss
         0ksS2QCwCLQdsatTiaCwF9xZ2OX2e1WbFa5yhGAAyFY4AFzCKex8tWQ4AXntOnT7cwC2
         lViJWMQ8d1K2a1qA9SuIYZJrfAAGunX7QKIPkui7wQhJ1LuF4Gid2NDmNRN76eC+WlVx
         7ZhTWCQf86XgNfdlf8k5yMud5qdz0WXAds1Nnou54STWZzA8YoD/Lmsei58Yc3m91gEQ
         vK7x7HqTjoEZ8phRkK1I0xUSUxpWF12Lt7CDhRzUdtVS55HJ4YwqkAMNtmDO6YPHZzE1
         Iacw==
X-Gm-Message-State: AOJu0YwRrNR4tyIzAyWpdqMq1hQ0GZOH5AKk/EPpC+GlXQy96sxF/OgO
	na32+fNP/JuXmT+8yRIFv0AeTBTYc99XtXVdQxc4193CPthDiTFQkfKTmpgl9Zu8xFMkEzIYl5T
	M27hMXrZLKzzF11NRm/tqZC5w8ko=
X-Gm-Gg: ASbGncu/wm+jhdWZ9BlXUaF7nevtbr3BHfgQ+Zf54HRW04vdpp/PB7F5ZOL6DrjRV8X
	BAkxrLLwaVIT0BTl2nmdn94hWNECilwE+eAJ5oiAFRCZg6vkFtLOHxpYVgfgQPo7W1t2Cnd+eFe
	Uy1UpYxBK/SZpV9IK4krM=
X-Google-Smtp-Source: AGHT+IF2pctsJ2xKBRT9Ib5/xq1x6voX93EYm41TiBEqoWirQAXdelMH1rvWMBb5wbyqQJ1z6L3K94wsIS7nsv4KdU8=
X-Received: by 2002:a05:6102:3ca8:b0:4c4:dead:59a3 with SMTP id
 ada2fe7eead31-4dc73797a19mr827067137.2.1746560078257; Tue, 06 May 2025
 12:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501195915.820343-1-robimarko@gmail.com> <CAP+JOzS-ThMWqJfTLAvSc0xG7XB--FT0G5-evpMm14h2hPFpoA@mail.gmail.com>
In-Reply-To: <CAP+JOzS-ThMWqJfTLAvSc0xG7XB--FT0G5-evpMm14h2hPFpoA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 6 May 2025 15:34:26 -0400
X-Gm-Features: ATxdqUEnKcC2dB0RP-ASnuwJzfinT6slwzIMyI0mInoB2-bxr75rvcqSYMAteLk
Message-ID: <CAP+JOzS_h46CxVFf6ZUjTu8ZgiX06ZipcfpVdkO9yJjhVAb0+g@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: run_init: define _GNU_SOURCE
To: Robert Marko <robimarko@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 3:29=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Thu, May 1, 2025 at 3:59=E2=80=AFPM Robert Marko <robimarko@gmail.com>=
 wrote:
> >
> > Trying to compile run_init with musl will fail with:
> > run_init.c: In function 'authenticate_via_shadow_passwd':
> > run_init.c:206:40: error: implicit declaration of function 'getpass' [-=
Wimplicit-function-declaration]
> >   206 |         if (!(unencrypted_password_s =3D getpass(PASSWORD_PROMP=
T))) {
> >
> > This is because getpass in musl is guarded only for _GNU_SOURCE, so
> > define _GNU_SOURCE for run_init.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  policycoreutils/run_init/run_init.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/policycoreutils/run_init/run_init.c b/policycoreutils/run_=
init/run_init.c
> > index ce499781..4531a8ba 100644
> > --- a/policycoreutils/run_init/run_init.c
> > +++ b/policycoreutils/run_init/run_init.c
> > @@ -37,6 +37,8 @@
> >   *
> >   *********************************************************************=
****/
> >
> > +#define _GNU_SOURCE
> > +
> >  #include <stdio.h>
> >  #include <stdlib.h>            /* for malloc(), realloc(), free() */
> >  #include <pwd.h>               /* for getpwuid() */
> > --
> > 2.49.0
> >
> >

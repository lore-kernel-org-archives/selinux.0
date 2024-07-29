Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BC714601E
	for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254267; cv=none; b=f4orfL2W7EBkNo0Hekq22zV93796IjC5zbWuUQJbK7K27zp+0a5cO/Ocn/uPZ40G0PtJfA5v3nJbE7OY2xHiSIVgU3LMh5T9wr3uoYN7FYOv0Sb8cqlNzxyl86VAOxRdYHX+1g61ObYEPmdGmPEwxgt/RcO06C7YeqTDNWsRrfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254267; c=relaxed/simple;
	bh=MZkoewQmaGgBez8yh5EzZFFIyshZZ32ltHOUaYLG5Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKzII5JxeSz/lRU+sPnuziA67lJRa5Wy6Cyc5wm6i8uxrGmxONMkq9DouK6yzmuS9+23m6jiMALhW6qCX+t7qF12BFQEsav3UgCKRhgYkUDHkovm8oUa3VK0SesKylB7L5RCbWWEXKl5ay1+a5x1tiDfHz3kKJojm6t45562vT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5+wEG4k; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5+wEG4k"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cf213128a1so1784058a91.2
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 04:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722254266; x=1722859066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BY8q/u7xcBnAvxVBJJegbxttgPBJS1MGbUwK1r1Tr9Y=;
        b=d5+wEG4kOHM78AgXrKrbOIEeQL+C4ryRX9/Cpf1KO9eFqcETaIS90qeIWfHqOb1sLu
         7QXQqYksplSxwpZzKwTexOGPb2KDFkTEt8xVJJqUtZzM3pywrE8kTACZIxh/9KAF+b7t
         i2erEaNH8Y+0M3fe5G7B2efoBRBFZ1Ux+3IgbBpOHmOOsgI5XtFog8BObLfuWKrFNVY3
         ob9qzqPUYIG3nkzbJOuqIBtFvdukwjiRlc3cT+kHayKvb2ezJDS8flzV9EOeYXH8HiaU
         O4K01YzmX+TzlwcDezlapgX9rGsRAkzQPQ29HFhyazF1CmsOBzgfKD/3xE0SO+DDjerO
         Lirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722254266; x=1722859066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BY8q/u7xcBnAvxVBJJegbxttgPBJS1MGbUwK1r1Tr9Y=;
        b=vkKYzOnR2dgGHrE/2inhyNbm8JjM2UYlpwPdypJQGDVQSkYR6Fk/SJXrFJnFS2ZiXX
         XEEFzGPwBOtKD3m/hLoufhnnrgW7M+Tiux7o85KaD8Oy7LfP9HpL941OCfnahoRU6uhS
         mYZ09o2xaD92Aae6CMHwqTaUJfOTop5QsrBqVgN7r0kVPkBp6f3GYYwIrwlGwivvk2br
         e50yVlH4ye3xHCmT/+igrsupTpflb7PJEOt3JctiWHFXhAd96B+Ju3iTpYUp1H47p0E3
         hiJQoymTPgmquv08jr6b1j5cUVSPoQCrnPrb3cfW3/9IKHc+J90Ypwp6/GdZvOElVvrk
         KUnw==
X-Gm-Message-State: AOJu0YyWwft+gvzYRW9RqMCoBmdnRVi7rvKKBj8v3p4uUwMTPrHBE6Az
	qSAgc/dUrdCM3/lCFLrzbPPZgJTUH66HWIxV7z1imEQg2kA4wpaDNgkTmg+BMGfxlSvoxj0xLCZ
	rqaQSELgGSDfJOlabHUfp5EUzDV0=
X-Google-Smtp-Source: AGHT+IFZpclw8/50wnMePKVZONY/SPpS/rbW/8xiyVBVtd33x9pLZbcvL0mu/Dh2MOn573HwF/nY4Pwo8sSPEnCFXW0=
X-Received: by 2002:a17:90b:4b12:b0:2c8:a8e:c1cd with SMTP id
 98e67ed59e1d1-2cf7e1c6650mr4611345a91.11.1722254265655; Mon, 29 Jul 2024
 04:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4hUc67Ra7vE7z1znGfx=8UqCSFY_OouJ0_mOQW4-qx1Q@mail.gmail.com>
 <20240726160725.1598159-1-vmojzis@redhat.com> <CAEjxPJ5BJ7q1xqgcqfUU_50V5N0eXRFCk6cnD=+4tB6GDd45hg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5BJ7q1xqgcqfUU_50V5N0eXRFCk6cnD=+4tB6GDd45hg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 29 Jul 2024 07:57:34 -0400
Message-ID: <CAEjxPJ5j=Ls=zS5dW-9Lk_1uTCwrnsWyo=ok5cQO5XW5Cj6u1g@mail.gmail.com>
Subject: Re: [PATCH] libselinux/restorecon: Include <selinux/label.h>
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 1:24=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jul 26, 2024 at 12:10=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> =
wrote:
> >
> > restorecon.h uses types defined in label.h, so it needs to include
> > label.h (or code using restorecon.h also needs to include label.h,
> > which is not practical).
> >
> > Fixes:
> >   $ make DESTDIR=3D~/obj install > make.out
> > In file included from semanage_store.c:39:
> > /home/sdsmall/obj/usr/include/selinux/restorecon.h:137:52: error:
> > =E2=80=98struct selabel_handle=E2=80=99 declared inside parameter list =
will not be
> > visible outside of this definition or declaration [-Werror]
> >   137 | extern void selinux_restorecon_set_sehandle(struct
> > selabel_handle *hndl);
> >       |                                                    ^~~~~~~~~~~~=
~~
> > cc1: all warnings being treated as errors
> > make[2]: *** [Makefile:111: semanage_store.o] Error 1
> > make[1]: *** [Makefile:15: install] Error 2
> > make: *** [Makefile:40: install] Error 1
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This patch has been applied to main.

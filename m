Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E42F50B2
	for <selinux@vger.kernel.org>; Wed,  2 Jul 2025 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477701; cv=none; b=njIYRmitqKOVLVdwQGAuc4g0HyVuwfO+C3hFi0O3IDEK3D7gnjl/jiBjlua9Dm73MbEp4/wvzwGIeUVs4Wj3k+x5LuSLMv9tGGDqgtghQO/nF5rU+/v3vooL8jgKlfWzQonWZMCzhrYenA5ABC2/i/g4hOFoq0D0ac9h7jOXoZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477701; c=relaxed/simple;
	bh=ArOzVkiXw1pFjZy4SfBDjPPBjx8KUkusPolzZAARclY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIxxXFmHZYM4AhYM8tcBFK2e+TuwM6ESwlhbXfXNn2iA9rZj3PvtC9o9KhaMa5uk+JVdZ1e9kkpV9ZiWOBWrSaqZo3+AB87pcpfbNlKOdrClLs6GH5/FKtni/aUHjn66XCbKEEZbRWcVoJMA+ez1thHVsLu5v4oOn0i2VgzsUYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoO+EX0X; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoO+EX0X"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5314d78e74fso1312686e0c.3
        for <selinux@vger.kernel.org>; Wed, 02 Jul 2025 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751477697; x=1752082497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAH0O84KUg8UedTTXtuJ3aIvsLed894PWgteRSrBVac=;
        b=PoO+EX0XLt2+Bsau4MzbFvpvefIu2lE3no8riuJ7jSsESyRMjB5XdmWEGjxzMyFy7E
         H28Q/gAui7V0J868Lg2CLNvI5H+ECj8r1PMUC5Ncj5Ge/N3hIYB9BabTtmFV23QKPJb/
         t1mBXkBsRsyMyxLH6SgaTPvq+mnGOUiz4qJQysJG7mHIVafWEFkX+cK6QQjBqNJBtBQY
         M/e25ogJ6ESnr1C6WuiEn+KxiIBRnwQ63M93KvnKRdgsdq4PAU5FmraDTiDjfhosYk6l
         f7Q/rq7OU/ViVJcd0nQIrkoZ3nBSm6HHyQ9tBeQyquNFCTP+UUuuQ1HB0zKRVeYBa/yG
         iGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751477697; x=1752082497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAH0O84KUg8UedTTXtuJ3aIvsLed894PWgteRSrBVac=;
        b=qBsjSolrBKFlwQN6CsiAoX6BzwdBZjKt/z2v6NDyVGFnwrXueS1HqM/ZZGWSV6oNst
         /cPlxfz7eKM+FtVDm7hdhHpgGFeFl0ob04/PMn081xOFSBe1/5cbYrWuF2px88KcAKEE
         ID8fpv6ZwrkgQ6PrilAPrgNwoamBVW6n5IsUDIrToYbYpGGUkjGWDWNZCPc1SQ8NSLDF
         wefQM0VDvdbCw97pNqtFaafThNFf+BxDH2h7B5cJ5BP2F7O+SXFEeVI6L/QK1qqO7IQm
         uK25YLeddNVuFdNrHJzLXpklabWk0wAZffgKh6Vw9bEqs5Zw6MBxN4Xa7rtCs0ssy65K
         0jIg==
X-Gm-Message-State: AOJu0Yzz+46oN4uEulzBWVHao+Xw6TZoSvqtnubB7X74rHCLleU+V70I
	OswFmxX9ckW/NNDg7i+lRP/jAbnXkCvNT2ebsxrb1orUsyc+mE9zCk8sEfZC0w2PhyP0KBAHrsA
	TL55kWlqGqfPK3Y0dc3XI09EsNeiWBYw=
X-Gm-Gg: ASbGncvjc6KA81T1m7WzLwV48lhwFztoirAFr45wKtn4HhwuvdeAoaQAlquDkCVTbo8
	l1n6gRdjVGDQwAoSY6XpEow9EgFe2cdNvfQlvnJdeQ09znseI+d+zso+k2qyF/Ov6Y5tvwFiqo5
	adxZAstD1u61KEQse2IOhsBZdhBVgA2+Wb4Daf0kcn
X-Google-Smtp-Source: AGHT+IG1ezDrPWukiSqlAaH5a1tThBIvdk6x/Yav3XggMlWGFOUgRDHIml3MbYI/xnpkbzDPWjyOueINlL/7YIGXChc=
X-Received: by 2002:a05:6122:2390:b0:531:2afc:462a with SMTP id
 71dfb90a1353d-534580afb84mr3393145e0c.3.1751477696960; Wed, 02 Jul 2025
 10:34:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630092117.21728-1-lautrbach@redhat.com> <CAP+JOzQ4AGEmm-rF5NA+2MdkKK-M-wLOZUJF4tZTSLn39eLaUg@mail.gmail.com>
In-Reply-To: <CAP+JOzQ4AGEmm-rF5NA+2MdkKK-M-wLOZUJF4tZTSLn39eLaUg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 2 Jul 2025 13:34:45 -0400
X-Gm-Features: Ac12FXzODV8awlg_Rs-p7074R-4Weg52XX10omZNAVk6Q0_G69OxgYGZCGjpb-M
Message-ID: <CAP+JOzQCMM1o==P=fknUj7p7QoSAcBmhLo-XT=2OG_tpLuLWvA@mail.gmail.com>
Subject: Re: [PATCH] sepolicy: use multiprocessing 'fork' method
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 1:42=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Mon, Jun 30, 2025 at 5:34=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
> >
> > 'fork' was the default starting method in Python before 3.14 and it's
> > necessary for this code to work correctly
> >
> > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2374569
> >
> >     sh-5.2# sepolicy manpage -a -p /builddir/build/BUILD/selinux-policy=
-41.43-build/BUILDROOT/usr/share/man/man8/ -w -r /builddir/build/BUILD/seli=
nux-policy-41.43-build/BUILDROOT
> >     ValueError: No SELinux Policy installed
> >     Exception ignored while calling deallocator <function Pool.__del__ =
at 0x7f36f9d333d0>:
> >     Traceback (most recent call last):
> >       File "/usr/lib64/python3.14/multiprocessing/pool.py", line 271, i=
n __del__
> >         self._change_notifier.put(None)
> >       File "/usr/lib64/python3.14/multiprocessing/queues.py", line 397,=
 in put
> >         self._writer.send_bytes(obj)
> >       File "/usr/lib64/python3.14/multiprocessing/connection.py", line =
206, in send_bytes
> >         self._send_bytes(m[offset:offset + size])
> >       File "/usr/lib64/python3.14/multiprocessing/connection.py", line =
444, in _send_bytes
> >         self._send(header + buf)
> >       File "/usr/lib64/python3.14/multiprocessing/connection.py", line =
400, in _send
> >         n =3D write(self._handle, buf)
> >     BrokenPipeError: [Errno 32] Broken pipe
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  python/sepolicy/sepolicy.py | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
> > index 82ff6af2bc2d..febb2fc103ed 100755
> > --- a/python/sepolicy/sepolicy.py
> > +++ b/python/sepolicy/sepolicy.py
> > @@ -25,7 +25,7 @@ import os
> >  import sys
> >  import selinux
> >  import sepolicy
> > -from multiprocessing import Pool
> > +import multiprocessing
> >  from sepolicy import get_os_version, get_conditionals, get_conditional=
s_format_text
> >  import argparse
> >  PROGNAME =3D "selinux-python"
> > @@ -350,7 +350,8 @@ def manpage(args):
> >
> >      manpage_domains =3D set()
> >      manpage_roles =3D set()
> > -    p =3D Pool()
> > +    multiprocessing.set_start_method('fork')
> > +    p =3D multiprocessing.Pool()
> >      async_results =3D []
> >      for domain in test_domains:
> >          async_results.append(p.apply_async(manpage_work, [domain, path=
, args.root, args.source_files, args.web]))
> > --
> > 2.50.0
> >
> >

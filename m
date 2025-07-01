Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0093596B
	for <selinux@vger.kernel.org>; Tue,  1 Jul 2025 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751391751; cv=none; b=ENYx6HIHLwkK/+D6+O2xUunWn+PQ3Vd0xF49piULffX/q2Wvx674oajvVe4TqIVv8iBZyqHrKFFznf+VuGXPlpk8YCYapQfyo9/zzFr1eUbZCTA5S0hZsUFMYpziJl/r557ziSaLjjL7SBQYHRiYbjyAHbM5jHQMeMne5WNBFro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751391751; c=relaxed/simple;
	bh=2JWX0Z44McGA1svitRt02QuU+MD2pnM6viIANRcRFQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mowKluD+fO4ZTpJDv4hoDWkqoE/SUP79scefZ5EQULYxLCpNo2d3KWYaHEWy3qNfabfhD8c8NDOJQRYgxyYuWb50tn9RaQE5vFdW3U0CeLSXCSH3fW1EIw0+qpLS3KP40Dsdvx+INPkLDtWfqEKqUc+RAJhxErjztQjrJoXBt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJJ6NSH+; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJJ6NSH+"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4e7f4adaedaso973596137.3
        for <selinux@vger.kernel.org>; Tue, 01 Jul 2025 10:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751391748; x=1751996548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8S8wpfO9ytiQ6heQ+KYuubld4T9cSsf61VDBpSH2Lc=;
        b=HJJ6NSH+1nPmZK+u3rbRfq9KWfP9hmroDk6Y4ZuSujpsHXq+rzxrldM41pM0m8QgUp
         SzPuMEzhm/9YHiykAPGPZv368DzGF4avGCl38WNZduNn9+UBsa7Lg7gbXiUB89gU2VRK
         tU4zodZF3n3VOmn3pa3iuPvtV6VHniIeDJsefUG/vd04mWqIBxMdoxqz51SqJF/aqTra
         tQ9hS1MxiM+1P4hfrejlt6j9d0q1Dp8GuBcjfxlsbIVMDQXCp9cK1/mTaAJwk9Y6Y0E4
         RSSqTdMJ4kbVDI9hJtwx7vxoOtPE0f5PwEaTGaj4D2C2Zc95617rUO4ol64E3HJncWQg
         SweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751391748; x=1751996548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8S8wpfO9ytiQ6heQ+KYuubld4T9cSsf61VDBpSH2Lc=;
        b=KBIkW6FKa8NLw9cZ9ob2WsojguznabKnBB16dg/NrsbXC89B0sPK925Ba7Tq6MBh4R
         mZlk5lOowd8SCCfFFqQy0ya8KT+MBlkcPSlwJ9SuqA1qquDfJAzLeWu7mLiNI2lGWP4I
         Tadpz+7rzPVYFLlm1T7cTpITn8b59kVZoJp/wAEZ72yy+1P5rZlZ4Rttq30wAU7firuz
         z0uODPwMpilSNzrTYNlOGePh/TzN03/mlZTX80tjqA+Ww0AyW9MPdZ8IwSah/9iHLiEj
         b51ujb61XfvPfCWSGEN2yE3k29fSzHIVEboIKx+UcDkp/WGlDfW8icqC3tTComb4+RT5
         jyGw==
X-Gm-Message-State: AOJu0YxXnOwogibkQx5gP30f3NyCcA5j3aDIEMa8Cy+bnTva8WBcMne/
	KH4xMZFHtv7JkuP0M3xIlpwalI516owBU2B8tl4yl4exw2I2k3tCy4rvs1v0pA5bN8yY0tTiJbV
	IPtSYWewUOwffWCla3SbyOj5gxKGHfnc=
X-Gm-Gg: ASbGnctJiJOGdeYnwEhvCLGIBD4L9z5CrW7VhWOsZsEGQ0ls6Uo7B6W5Nv4mTCcVP+l
	aemdZNn/XKlLFyOfMBHVxEvktmlAXar+lx7kI5d6sZqYEiudAOzbtL9XA9MYTs3HNJHXWMKOmYx
	sTBrLspWLQWLaSFrn8ohUW6ZcFa+PvmCvLcd3u3+SQ
X-Google-Smtp-Source: AGHT+IE1IdVUs6bWpE1ZydZPU/Fmtl+qonBIt4ORBmRcHjwAfoNiZx6Gt11eowo9JrWhJf62oMAsGG9VbcgwTDuJ9eU=
X-Received: by 2002:a05:6102:4a84:b0:4e5:9323:d2b9 with SMTP id
 ada2fe7eead31-4ee4f4cf9cemr12918441137.2.1751391748456; Tue, 01 Jul 2025
 10:42:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630092117.21728-1-lautrbach@redhat.com>
In-Reply-To: <20250630092117.21728-1-lautrbach@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 1 Jul 2025 13:42:17 -0400
X-Gm-Features: Ac12FXxf5SZQGbhn6_yy309G9gVByRth9PoeDBzDfmYsrXT9WhWdD7lHLyS4iXU
Message-ID: <CAP+JOzQ4AGEmm-rF5NA+2MdkKK-M-wLOZUJF4tZTSLn39eLaUg@mail.gmail.com>
Subject: Re: [PATCH] sepolicy: use multiprocessing 'fork' method
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 5:34=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> 'fork' was the default starting method in Python before 3.14 and it's
> necessary for this code to work correctly
>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2374569
>
>     sh-5.2# sepolicy manpage -a -p /builddir/build/BUILD/selinux-policy-4=
1.43-build/BUILDROOT/usr/share/man/man8/ -w -r /builddir/build/BUILD/selinu=
x-policy-41.43-build/BUILDROOT
>     ValueError: No SELinux Policy installed
>     Exception ignored while calling deallocator <function Pool.__del__ at=
 0x7f36f9d333d0>:
>     Traceback (most recent call last):
>       File "/usr/lib64/python3.14/multiprocessing/pool.py", line 271, in =
__del__
>         self._change_notifier.put(None)
>       File "/usr/lib64/python3.14/multiprocessing/queues.py", line 397, i=
n put
>         self._writer.send_bytes(obj)
>       File "/usr/lib64/python3.14/multiprocessing/connection.py", line 20=
6, in send_bytes
>         self._send_bytes(m[offset:offset + size])
>       File "/usr/lib64/python3.14/multiprocessing/connection.py", line 44=
4, in _send_bytes
>         self._send(header + buf)
>       File "/usr/lib64/python3.14/multiprocessing/connection.py", line 40=
0, in _send
>         n =3D write(self._handle, buf)
>     BrokenPipeError: [Errno 32] Broken pipe
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  python/sepolicy/sepolicy.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
> index 82ff6af2bc2d..febb2fc103ed 100755
> --- a/python/sepolicy/sepolicy.py
> +++ b/python/sepolicy/sepolicy.py
> @@ -25,7 +25,7 @@ import os
>  import sys
>  import selinux
>  import sepolicy
> -from multiprocessing import Pool
> +import multiprocessing
>  from sepolicy import get_os_version, get_conditionals, get_conditionals_=
format_text
>  import argparse
>  PROGNAME =3D "selinux-python"
> @@ -350,7 +350,8 @@ def manpage(args):
>
>      manpage_domains =3D set()
>      manpage_roles =3D set()
> -    p =3D Pool()
> +    multiprocessing.set_start_method('fork')
> +    p =3D multiprocessing.Pool()
>      async_results =3D []
>      for domain in test_domains:
>          async_results.append(p.apply_async(manpage_work, [domain, path, =
args.root, args.source_files, args.web]))
> --
> 2.50.0
>
>

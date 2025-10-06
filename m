Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F2D2D6E7C
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759763189; cv=none; b=QYWn+JxXt2Vjrws0ijHE7jffGiBR3nxRf9uX/IVW/JknaCicWj9oDT2sN82JJ2qdwShSfZHV6N0kodZbjmQeiZKbkI1L7+URvgV7eyUF2TdSnQhriWXyyVOSO5iDQsYwP1+JwyZMx5qJs+Khv4Kp604cZAyPyzVpy0mhrdHebRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759763189; c=relaxed/simple;
	bh=lJHbkh5A12zWmxjF0K/3iX5NnCg3rdCZCfXP9jdeMsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGVBkRhskhnYcIOzATwldwqyWhEZR5qDD4xOV/RA11LPO/NV9asNynCZrtkxPfDwtb2EsVQVUgW8KUCHNNhp+D3t6FQBhC9/DCk7KfAXRFmOUms68arqKM706K4yu5aE57DI+fPAM2w74vD9QZrEGo1zgO4+qJVvRX5yQpTCwu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T01vsa/2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T01vsa/2"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso5036239a91.0
        for <selinux@vger.kernel.org>; Mon, 06 Oct 2025 08:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759763187; x=1760367987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fq7cdt9ZifINX9wwkiJBck29zwXup5uR5rW5avuOJyc=;
        b=T01vsa/2LE+tI1qxA86fFpKHaDVgI08/Xb3yMmPjeqEIgtC/sDF8gMn4FnQvIpAVh7
         KdQ9gO2KehDmQgzLhwEaXdJ5sz+RSbxtsGQfynQ+4wOdn5fY5JVT3sVrFfRqC/TpwRO8
         LSAPpp30uEPqquurcNr4Sjs5s3LDpLYqx2ccOEgQVK6JYR92bEjKMpvQwx7DgGmBsAkk
         2t9voCNRbH5ggvaEuGPdSPTofsG+yjQstO8Pfx9pMBpOO8jwnmQEmlyQsg9vEwBk7MIj
         E0j8o7gx90FoYdEPtMkJw2HiOzKKCAEWscU+CZFUL5QzfyRxdwVWL8jP/RvQ5HWLOWxx
         x+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759763187; x=1760367987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fq7cdt9ZifINX9wwkiJBck29zwXup5uR5rW5avuOJyc=;
        b=AMmVv5nSF94tj8/8c+bZyRyk/Z0BlVJOs8Cp3N/SZMMMIo1DNP0PYCpWLG+V/+8mp1
         /5tDRfjvJsUo16YG7qZ0EmTgGwCOfnpdZ9FrEH3JlOqvDI3Mp0bNmysOMm8oZLEmY8Rq
         EdVr5e+sfs7AMRkQMxacSdYVbFzzHkr0SHQ6Hl1uUY+f96yUDvfqUKK3kOuMINT3VKnt
         E+CcqFochBYC9S/kj/xkUWTepZg0lmursdZsXaSlVlT4C/xOn49YxMaOEBAscvFB58vU
         6Fj+c40FS1muZW8OdyRTQ6Yb/FKNAkpXw5hNVQjkbFsm89unkxfAuOoQH3D9/YPFK646
         oQzA==
X-Forwarded-Encrypted: i=1; AJvYcCVbG8zFSSPMv/zUWZ8bNeTyJIR4v8IDoke2xHF+IhxXu3LKqmXg5DHdJZ+U/ULPdiEPPEhyYW3i@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/V347uGHRSkXoz9U41/eaAMHFR0w573x5Vbf8yswsog8o0cQS
	V6DjaJwz3BNOxHOfNH/ds9K+DXXaiB8dS6gut+/HO+mndDdZhCzOBEd5SF9j2nVWdZurAdspFhV
	XZrZimALncGm8XRYQlkmp/DxOwIDqVAc=
X-Gm-Gg: ASbGncvbV5dtnnV2SBDiTiqK9jDqs4hwu6LRO8xpWPiPsS7Yv1Qbzhh69aKreS1skNO
	s1pf+j0pb0wSVPpa6pLkjqMylaWb4fArU1eyZlDPdze99wIbJ2AV7X/XNMhhvRyIBE9KeT45i/Q
	IudcneG2N6Mu2hx709ZEGsepFKk0j7ZGhvPUUNiGJH3rCC/3dpwcxFsI3yIwyuNkrT1++N3ebcq
	y7jqulqbaXOpj3Cz5a1UIKLlDFU8E4up6DY8sEtMVWwjF+xIK8a
X-Google-Smtp-Source: AGHT+IEHkw9MPqHcA5SKu0QHKTwycngFaQaqS3XxJjPoDvWlNzGNMRoeNdQibYdcKhNTsO76Dxf/0kWy8D06owfUj/g=
X-Received: by 2002:a17:90b:1b46:b0:330:6c04:a72b with SMTP id
 98e67ed59e1d1-339c27409e7mr15358707a91.3.1759763186353; Mon, 06 Oct 2025
 08:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731102224.1045166-1-nvraxn@gmail.com> <CAP+JOzTBrgKgzf2M4VRXXG_1=wSd-Zf-xGrp7J6w=o34+adGCg@mail.gmail.com>
In-Reply-To: <CAP+JOzTBrgKgzf2M4VRXXG_1=wSd-Zf-xGrp7J6w=o34+adGCg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 Oct 2025 11:06:15 -0400
X-Gm-Features: AS18NWCHevIHIxVXZpPVFyjENRnHXHMlmI5CD4rpRxr_LgQoHRoDM5X2H00cB08
Message-ID: <CAEjxPJ7VV9bvTQq4BDeynCuLaWe3ER0YRwTnXAwcre4KKk1U+w@mail.gmail.com>
Subject: Re: [PATCH] python: fix flake8 F824 error
To: James Carter <jwcart2@gmail.com>
Cc: Rahul Sandhu <nvraxn@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 11:45=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Thu, Jul 31, 2025 at 6:34=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> w=
rote:
> >
> > This fixes failing CI[1].  From the flake8 documentation[2]:
> >
> > > global name / nonlocal name is unused: name is never assigned in scop=
e
> >
> > Meaning that a global only needs to be defined with the global keyword
> > in scope when it's being assigned to; not when it's being read.
> >
> > [1] https://github.com/SELinuxProject/selinux/actions/runs/16623315767/=
job/47032933729
> > [2] https://flake8.pycqa.org/en/latest/user/error-codes.html
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.

>
> > ---
> >  mcstrans/share/util/mlstrans-test         | 4 ++--
> >  python/semanage/seobject.py               | 1 -
> >  python/sepolgen/src/sepolgen/refparser.py | 2 +-
> >  python/sepolicy/sepolicy/__init__.py      | 3 ---
> >  4 files changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/mcstrans/share/util/mlstrans-test b/mcstrans/share/util/ml=
strans-test
> > index df34e0e6..8fa0c379 100644
> > --- a/mcstrans/share/util/mlstrans-test
> > +++ b/mcstrans/share/util/mlstrans-test
> > @@ -8,7 +8,7 @@ errors =3D 0
> >
> >
> >  def untrans(trans, val):
> > -    global errors, verbose
> > +    global errors
> >      (rc, raw) =3D selinux.selinux_trans_to_raw_context(trans)
> >      if raw !=3D val:
> >          print("untrans: '%s' -> '%s' !=3D '%s' FAILED" % (trans, raw, =
val))
> > @@ -19,7 +19,7 @@ def untrans(trans, val):
> >
> >
> >  def trans(raw, val):
> > -    global errors, verbose
> > +    global errors
> >      (rc, trans) =3D selinux.selinux_raw_to_trans_context(raw)
> >      if trans !=3D val:
> >          print("trans: '%s' -> '%s' !=3D '%s' FAILED" % (raw, trans, va=
l))
> > diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> > index 10963e81..b41efd59 100644
> > --- a/python/semanage/seobject.py
> > +++ b/python/semanage/seobject.py
> > @@ -244,7 +244,6 @@ class semanageRecords:
> >      args =3D None
> >
> >      def __init__(self, args =3D None):
> > -        global handle
> >          if args:
> >              # legacy code - args was store originally
> >              if isinstance(args, str):
> > diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolge=
n/src/sepolgen/refparser.py
> > index c8a3eb54..01a322ca 100644
> > --- a/python/sepolgen/src/sepolgen/refparser.py
> > +++ b/python/sepolgen/src/sepolgen/refparser.py
> > @@ -1038,7 +1038,7 @@ def p_quoted_filename(p):
> >  #
> >
> >  def p_error(tok):
> > -    global error, parse_file, success, parser
> > +    global error, success
> >      error =3D "%s: Syntax error on line %d %s [type=3D%s]" % (parse_fi=
le, tok.lineno, tok.value, tok.type)
> >      print(error)
> >      success =3D False
> > diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sep=
olicy/__init__.py
> > index 2d526c94..3b87a869 100644
> > --- a/python/sepolicy/sepolicy/__init__.py
> > +++ b/python/sepolicy/sepolicy/__init__.py
> > @@ -195,7 +195,6 @@ def init_policy():
> >      policy(policy_file)
> >
> >  def info(setype, name=3DNone):
> > -    global _pol
> >      if not _pol:
> >          init_policy()
> >
> > @@ -354,7 +353,6 @@ def _setools_rule_to_dict(rule):
> >
> >
> >  def search(types, seinfo=3DNone):
> > -    global _pol
> >      if not _pol:
> >          init_policy()
> >      if not seinfo:
> > @@ -936,7 +934,6 @@ def get_all_roles():
> >      if roles:
> >          return roles
> >
> > -    global _pol
> >      if not _pol:
> >          init_policy()
> >
> > --
> > 2.50.1
> >
> >
>

Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2ED435EFE
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902775; cv=pass; b=hlQS0QIYrnHrS1pHYY1pakmDG7LfxXymUvQ/5X35gh6hyh8+5Y5S5V0f4fhrNBF4wwfUQhDrUnetFBkS+IunvBsv1CmkDXNtQUlM3S2AKSAZQlhzmdhql5q8dLI3lxN5ulgmeDAx34mqXOoF+2hHr91alsbzyrSDRRqb/QvnxY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902775; c=relaxed/simple;
	bh=vIDV9Lln3PXjvGKif0cXQkqy90TwrlhktLb1tk576dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEC/stDNLkc+UNcuzEhqw4ZfY7fqjf2KuqUhNoezmSFxtP3Ek6IGbv28wMp7WTqIKAi/3dEDTkz+eJpMz6BlWzDD/AxkdE7pjRJiWdWvETK8v+h1O2qU7ojCZWUtpz2W8xJnyjQtcIKjrJzE+nK+zDe7c+QodxLhzN44tZyqk00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcvjfp/+; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcvjfp/+"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-44cedfaab6bso128929fac.3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 07:19:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784902773; cv=none;
        d=google.com; s=arc-20260327;
        b=Ox4QXJMucAjGdzbuA91x76S/Ex86eFyU2huPlMN1mH2DPRNUsD4SOrRcMgMhEu+30v
         Bam/pJaTpmLU27A1hlDliP+oobXUP6TIpwnbmImq9WyeE/XV2ydWuEPNjbT9nqtLryjY
         8j9UXgERUPjsZ4xlfRr6nN7PpNc/WgrPPDZ7sYqjvhY3JnYMwKh/C2FfWP/Ole0nXeWK
         NfHdqWCn7cevPEnow9xhsk/5S9FMaYrVcCoNNqAs3K6cxnXql/mq86GPfA226c9uLY6c
         JmVeDRhbVa3dAsvvzLhyisIDSGS7PEwwPT/FM4EhIQhA2k9UyIWkLlHb6B1Wb/oQIOsa
         jPcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fgyeMgJlmyxI1H3XGdIpsXUXGWKDZFTq6UgFy52KWtk=;
        fh=S5wxpk3pG7MFU7YHMJ3Ymnn6cB3pS1/Aa/gbpiVu6iU=;
        b=qipt+Hudm3IiT4zEZgQG8WNMlO+/ZRVuUdCeu+4ovDTdbXTQGLuMbpvqkLikiLbJmG
         q/PZAdqVbDWd5I13rV5Olh155YcasIYJIOcxXYpWHA815gEUD5kDl11I3wDdLrZaKpnC
         EnpnoH42E5aNUxqoUq/assKV3PjqeJz5gsGMM9l+o1dLxNbRcQIINxog9QsOxYWyNuXx
         SeJsjYaLSYkYrrgb/4asD2EC6y/BXlm3fXYYWzRaLwHC9x2u+gCXwjRffpBsEicqzna3
         hIRxJjnPZr1eAR2YzCoZrcMUI4Xz+getOegHEDJWTx3xyObRxLYfOz6WJqitCJACm07q
         /vfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784902773; x=1785507573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fgyeMgJlmyxI1H3XGdIpsXUXGWKDZFTq6UgFy52KWtk=;
        b=bcvjfp/+Cby9bVqan1A3+E3dFh867DjpBAo3a6KdooDPzb/ARGWfbZ/JiPuR/CydJp
         mTu5DpvNa5yFg5snfmh9qeUeC+3E9CQsdPlPnuO7dIYfBoRfaDYNQoV5SubKDrNp5vw2
         F2A9XScfvo8otF8PIDdOzgBkS2H1zYbimnowRPwrCCtVq5i4BocdjyrztiIuji5Ft1ER
         hiXZ1XPqwDFKM7qSyBDZUJ6jP/td2te0SBLEyMxw78RG9HyEuXv7M1juxyZPBqFRhtFd
         QJuxbfn86YextYdcgxDydAc6IUBNxE11Nfx2yPkcNHvlwdDwlM6Nc8OHQWPfKw9ROChz
         w6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784902773; x=1785507573;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fgyeMgJlmyxI1H3XGdIpsXUXGWKDZFTq6UgFy52KWtk=;
        b=ZqMelWd26G2mpfiXD/VCvYQY0qCEyQjuvxfjb1+3486negtMH51wnw6ZWiVR97BMuV
         c9FwdMJrOP3IC6mDv2ynX/BU4riFHC2YpXwTkWgjJBxRctLJ72iw2AhTaPr1a+Z6yPnt
         B6hBFDWIx9RBwGtKlkfKcwfc3Q/tbULs2OzLkq0W0x73iZUTklqPrgmR6uBWVsw0WV+3
         qWgOQ3UCt+DfnXYtXq1ERmrBsyaRuC+MJIWwIOIk+Pq4PCLCi/3/rb6KDuEPA2CjrdkF
         evjb2JTGYUUUGYRhVvXEXy5OZSDQg57AeYBjA9AHj0ohCYRNDjLKLNNw6Dp4uO/dsbXl
         olwA==
X-Gm-Message-State: AOJu0Yx32FiyAYCVMaVX4Pd3LuEiWG4Wf1vgg6NFt0eIkc8KzpKapQfp
	QTMjZGfYxKjcL6OkAZXOrUvaIi/dZL6sK7IuOTvdf22ExZihD6vWSJY8NSGNpjsF5AiOoGVF0pj
	zWWSEZWWYoRZVhD064fMG6G3pMqrShJFMyw==
X-Gm-Gg: AR+sD13p0xGYx/MayEkJA523j7aj6aUIzi2pEt7tBIB0cnw+9J5A+XjFI8mqhZf3tqv
	rbPYrRivZ/TbyoUitfO1gaeRCfUpXoXYzfan8E6o9imv8gedKgZzJ76uGMWvU2VInVc/ewAzd2e
	yunTEfGo972nbtBNGrWPzCO5F23/tni7vNyPV/o5ymOk+1I27PusOVaNS6Nop5orzPk9KlikUAX
	N+BKXLh5TF7WGgeW/aYTfgx7VvS17bw/E6iSeWGb+qcTkSNy/LGzBKmmzekEQ==
X-Received: by 2002:a05:6870:1692:b0:457:8166:ba36 with SMTP id
 586e51a60fabf-457a10d78f6mr4352488fac.29.1784902772798; Fri, 24 Jul 2026
 07:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720195247.49762-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260720195247.49762-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 10:19:21 -0400
X-Gm-Features: AUfX_mxDrI0ZjWZajbfBCEZrqKZay49sYcMrUOQ92mUH0QL7yOt3Po4vho5krXc
Message-ID: <CAEjxPJ6RJQAymiPCF5OTr2cT86PeNbwzs9ZA=+OnEb3AWD=UrQ@mail.gmail.com>
Subject: Re: [PATCH v2] python/sepolgen: port policygen.py to setools 4 API
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	pebenito@ieee.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 3:53=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> policygen.py still called seinfo() and sesearch(), the setools 3
> python bindings that were removed years ago. The calls only survived
> because they sat inside a bare "try/except: pass", so the "source type
> can write to..."  hint in audit2allow output has been silently dead.
>
> Replace them with the setools 4 equivalents:
> - SELinuxPolicy().lookup_typeattr("domain").expand() for the
> domain attribute member set.
> - TERuleQuery(ruletype=3D[allow], source=3D..., tclass=3D[...], perms=3D.=
..,
> perms_subset=3DTrue) for the allow rule search, expanding rule.target
> so attribute targets are resolved to concrete types
>
> While here, cache the loaded policy on the PolicyGenerator instance so
> it is not reparsed for every access vector, drop the wildcard import,
> narrow the bare except to setools exceptions, and dedupe/sort the
> resulting type list for stable output.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/332
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  python/sepolgen/src/sepolgen/policygen.py | 41 ++++++++++++++---------
>  1 file changed, 25 insertions(+), 16 deletions(-)
>
> diff --git a/python/sepolgen/src/sepolgen/policygen.py b/python/sepolgen/=
src/sepolgen/policygen.py
> index 7715bed5..a5af521a 100644
> --- a/python/sepolgen/src/sepolgen/policygen.py
> +++ b/python/sepolgen/src/sepolgen/policygen.py
> @@ -26,9 +26,9 @@ import textwrap
>
>  import selinux.audit2why as audit2why
>  try:
> -    from setools import *
> -except:
> -    pass
> +    import setools
> +except ImportError:
> +    setools =3D None
>
>  from . import refpolicy
>  from . import objectmodel
> @@ -85,6 +85,7 @@ class PolicyGenerator:
>          self.dontaudit =3D False
>          self.xperms =3D False
>
> +        self.policy =3D None
>          self.domains =3D None
>          self.gen_cil =3D False
>          self.comment_start =3D '#'
> @@ -206,23 +207,31 @@ class PolicyGenerator:
>                  rule.comment +=3D "\n%s" % self.comment_start
>                  rule.comment +=3D "\tPossible cause is the source %s and=
 target %s are different." % reason
>
> -        try:
> -            if ( av.type =3D=3D audit2why.TERULE and
> -                 "write" in av.perms and
> -                 ( "dir" in av.obj_class or "open" in av.perms )):
> -                if not self.domains:
> -                    self.domains =3D seinfo(ATTRIBUTE, name=3D"domain")[=
0]["types"]
> -                types=3D[]
> -
> -                for i in [x[TCONTEXT] for x in sesearch([ALLOW], {SCONTE=
XT: av.src_type, CLASS: av.obj_class, PERMS: av.perms})]:
> -                    if i not in self.domains:
> -                        types.append(i)
> +        if ( setools and
> +             av.type =3D=3D audit2why.TERULE and
> +             "write" in av.perms and
> +             ( "dir" in av.obj_class or "open" in av.perms )):
> +            try:
> +                if not self.policy:
> +                    self.policy =3D setools.SELinuxPolicy()
> +                    self.domains =3D set(str(t) for t in
> +                                       self.policy.lookup_typeattr("doma=
in").expand())
> +                q =3D setools.TERuleQuery(self.policy,
> +                                        ruletype=3D[setools.TERuletype.a=
llow],
> +                                        source=3Dav.src_type,
> +                                        tclass=3D[av.obj_class],
> +                                        perms=3Dav.perms, perms_subset=
=3DTrue)
> +                types =3D set()
> +                for r in q.results():
> +                    types.update(str(t) for t in r.target.expand())
> +                types -=3D self.domains
> +                types =3D sorted(types)
>                  if len(types) =3D=3D 1:
>                      rule.comment +=3D "\n%s!!!! The source type '%s' can=
 write to a '%s' of the following type:\n%s %s\n" % (self.comment_start, av=
.src_type, av.obj_class, self.comment_start, ", ".join(types))
>                  elif len(types) >=3D 1:
>                      rule.comment +=3D "\n%s!!!! The source type '%s' can=
 write to a '%s' of the following types:\n%s %s\n" % (self.comment_start, a=
v.src_type, av.obj_class, self.comment_start, ", ".join(types))
> -        except:
> -            pass
> +            except setools.exception.SEToolsException:
> +                pass
>
>          self.module.children.append(rule)
>
> --
> 2.55.0
>

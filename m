Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BDE2EA726
	for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255401; cv=none; b=RF+7pT9Jse3x9gdpbWBvNLrPu5WiAIugGXx/D7J8LpaW76b32fzchamlGpUV/QYo4fndvwJGDIDIt4WDuvQrJPZiNsesGmjT/3AQow65Iu0Fo3gXuPgcwTvb/vCfHoD2+HWUYDONNgtHWpprP4wExci6BHVtCv/q5IbWnJ/Jd8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255401; c=relaxed/simple;
	bh=IgdHeMiy7KnT4nvb2NZAFz1I7Biyw2zEdjizci1nahI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J33WhzLZ41NjEmqpv1CJKAFcUh58xjc6GTTw0CGM8kzx931gjOh5QqIXuIFGtFogwr3Fg+MuiEffF41s6MQ+sUJvIL5gWCPY71vzLy7lwX+HihrFHSMZo92RleBUbKERkG1VU1ZwDhXJ+bm+KESuS/eBwN7+khqEatp0PbjZehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7SToRkL; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7SToRkL"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b2c2c762a89so5708426a12.0
        for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 07:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750255399; x=1750860199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lV8AGu9a3uFNzrnglP/qP/+o0piJUpbksGcOK0cHCco=;
        b=K7SToRkLJuWedLXjzBeV+dVlycuUEGn/t91UKHdDCtwBIUpfrDq8Vd9utcu++MBTfA
         97/TGWWwnA4zO3n5WafjreJD5BG7VED8KxmWW5VfsqfoNK3LLW2KljplgGyfiLdbu0nS
         9zdu3ZIbQpGGNeg+a7dZ/QMYFlE/Wr70QPxCUpnCRr8fwqwhwMSYqi0r1s/eeGjGhgeO
         h+TttVtuN2l4H1ZSNVoiXtdGlj+0eAq/fDe5OWdmwZj0lOIgQzNgBpNZuBOs0rfxXh/n
         0IQQKD1ilXgUtKWbIFnrkPoy0paWaZZW1Q91R8OPT7DFZCwgXPUolRrX8BtlmsBxLctP
         IUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750255399; x=1750860199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lV8AGu9a3uFNzrnglP/qP/+o0piJUpbksGcOK0cHCco=;
        b=jF/n1kZ8gsYz6XQeKQTbc36ZZNBvcAvmvEdpDeFLGNSLH7Elk1WMLefQnu0lQoW0lG
         M7mWp4Tf72DbDYsYE4xvjiyiPATB5n/w11iXKL5toNAPhxKFZYXmXVktlK0pJDr+L4dQ
         MZqJdlUUIHg5WjKoq1z3iLawGmFW20zuRJGRK/4+T37iuISTJ2D1MwsgD+WHH68GXxQj
         jvnGs39AXPyziJJnfETC+LqTX9DFm7dn22eclJQT9OhvlRopRCveu7Vxa0QEKrp5bjs2
         bfTLTEcGDWb2ouSXtKaeZ783daeH7Qpzy+HkhJu/JECTNc1/ki2N9J/mRsk94rWvL4UH
         9GlA==
X-Gm-Message-State: AOJu0Yxcam9LakiBF2AfULeFgQ2bycLjAbQGnMRClY1pkXVD1Xw1ssEP
	tNYo5ZYLU9tNo0DSLjywbW5BFGUzqbAJZcO9ePKv4Vc11Ki6epjzUfVYmAvHNtOcFLY8BZ229iE
	xjj2Q5IRsfrGdo4YYLEK9FaQ7Cp9CfeY=
X-Gm-Gg: ASbGncuoOzVuzEZGd1emLE+JW5cjz/Z24nQGZhzHilAD/VMeoIIdSsZi/GUjgnp7O18
	viQsKxKyaSNe3eXhr4/b9Sxfw5dAw061fhKO9FTf660eR2NVt82Q+OzXu92Omtu5xf3tUNDJnH6
	fcgDrow6M+gmpKvIHYzwKtcNJaNEKmuAgzRIaYqqizkpniWw880yXwWQ==
X-Google-Smtp-Source: AGHT+IF2aWv1ZQn9/zzmgaBeyJ8sz8KcENgzTE1Uuys5p1+ZNOJiuo/VOitNlgxu5DGLBPCNepYyYXNQK5WinnXCIpA=
X-Received: by 2002:a05:6a21:b90:b0:1ee:b8bc:3d2e with SMTP id
 adf61e73a8af0-21fbd4715aamr30177033637.8.1750255399244; Wed, 18 Jun 2025
 07:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612081208.1721183-1-omosnace@redhat.com> <CAEjxPJ43XpL49FZmb6Ds7CD71mZffNMKSiOfpesh2Lgw1eah4Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ43XpL49FZmb6Ds7CD71mZffNMKSiOfpesh2Lgw1eah4Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 18 Jun 2025 10:03:07 -0400
X-Gm-Features: AX0GCFvws1f1rxoSVtqpgeRCZ_NHJTGZ3Aq5SV7nrigjZM4gdDvM-52w1RcFKOc
Message-ID: <CAEjxPJ6+xbt9oKTJbGdJJ_seB=ZFRzeT2KHoEHM9ay1FY4_9Qg@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: properly detect IPSEC support
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 12:18=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jun 12, 2025 at 4:12=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> >
> > Check if XFRM itself is supported by the kernel when deciding whether t=
o
> > run the IPSEC tests, so that the testsuite can be run on kernels with
> > CONFIG_XFRM_USER unset, too.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Feel free to merge it yourself. BTW would appreciate your input on the
> patch/discussion for inet_socket iptables-legacy vs nft issue.

I went ahead and merged your patch since it has been a few days.
Also, if there are no objections, I plan to merge my recent
selinux-testsuite patches for the README.md iptables-nft change and
the nfs undefined label change soon.

>
>
> > ---
> >  tests/inet_socket/test | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/inet_socket/test b/tests/inet_socket/test
> > index ae06ae7..4cc3852 100755
> > --- a/tests/inet_socket/test
> > +++ b/tests/inet_socket/test
> > @@ -25,7 +25,9 @@ BEGIN {
> >      }
> >
> >      $test_ipsec =3D 0;
> > -    if ( system("ip xfrm policy help 2>&1 | grep -q ctx") eq 0 ) {
> > +    if (    system("ip xfrm policy help 2>&1 | grep -q ctx") eq 0
> > +        and system("ip xfrm policy list &>/dev/null") eq 0 )
> > +    {
> >          $test_count +=3D 4;
> >          $test_ipsec =3D 1;
> >      }
> > --
> > 2.49.0
> >
> >

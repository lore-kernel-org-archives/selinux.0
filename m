Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FD84F0542
	for <selinux@vger.kernel.org>; Fri,  4 Sep 2026 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534716; cv=pass; b=j/+plFeHZ8FVz/Vi9Gy2QsHreroxt8lhwm6UB1HCCcsN8419/xshJiUTHCS/iUI8QdChIKQ+Blvh279zb+sEbhAIwezxrTlnpBQVEcR7MPs7xoIp3/0wt/U9YOQdt9sAVUsW/XQHJuda+0Zbha9VM56RrxZmpQA9TXp233asfpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534716; c=relaxed/simple;
	bh=oEjYlRJ74vAU6PfFD6ugknYC9azxgRkAQuBDPcFDkhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u28aND1AxXM5WAj9kIPJHS+7CiZwZhV5v4KT0yRjKvqln+u7w/xCSvbaPnbsNm9caShOS83z/NxnrxtSfa3mknFVYRbBen/TdpLlIqQ0/Cn0tXXfYThLaEkRox9mPB6Drv+6rQgsgeKv9uAmawvtF614w4lgmYanjJrPKWkAmG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y49CL/Oe; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y49CL/Oe"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-46a4870536fso908560fac.3
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2026 08:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788534713; cv=none;
        d=google.com; s=arc-20260327;
        b=gLgTs7vc8X4NI10pkOVTYr4UtmVrFoC18Pgdcfq2OQhZ8UZwVSIacgCtQAqK3zsD95
         HBVKbRMsO38suxE9sbGJLTb/TMMSzwjY6zZk3LsCzmQiKqHdTBNT2XqS+4HA0aI+vwhc
         iszqO6MDgKoP8yM60QjtjH51lxK4Zvgddq/QMKEa10PZoCh2n6F5uochRP+s70VsUwAQ
         Y+InRnhJgM+fwhMSNoH28IjTzUo0OmyT6xeA7GpJvhWuyJt6+CH9C1QQsn5ENyiYQPKu
         O8BvV/O1toxsJhFIxqKXrw97aNmej4N5I8SYbsDsGsEkqJX4EO9WPZHu1TkOKcVsooR5
         uD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L3YhTe2Z5d0fL67Sri1X8bt0OFBpm40BZElE5qsfhEM=;
        fh=iAq7qKxro4/OOCnSCCs3fI9TXz+OagbPgaX+3+JVEpg=;
        b=BbhBdGlgUS676MFXCrElHwsoS1Lj+o39HOKfw5u9R0OG2R61AnmfIJYFbBDUmtVS/W
         ENzdS4xdAboBwbNk2P0Jg2xB9mKmpjH+gqTZOSWu6OKjcvT9IEbFYledYOdL428eFwde
         4tD1D0RYCpJA8v12TCKYPOotHnhYDVu8hXv2sop7aB25jNUFGxDSjxwYok3lLVFZeTfp
         TijmZyg8QNQE83Pnz32CKJEpE39Ziu8kQm3rz+FV5yVJbQgR+N/Wn2/ViQTeP+LY7lPt
         1ecBQuxM9KW4GAE0hIPc+yOfOIw0PGkekufcZKDOnNzWTIYirfI9r3eZZA8VPkLphoJe
         RXKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788534713; x=1789139513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L3YhTe2Z5d0fL67Sri1X8bt0OFBpm40BZElE5qsfhEM=;
        b=Y49CL/OeRj++qmq+rZ2trXLfJ0vdOwwFy0Lq3DnJQekH9AfbPIdxthK5JdZ85j4RgG
         4IK27mqVdeXsf584c8tJRT/25UJuEyUALPiy0a9tidsWFpNZYqxXcihncd1vBSm4hAiQ
         Rr6ITCOPa5gAJJU2Cm6PMsiyVtDnZfMPWZmK6H1lYIQUuzpFLorlMnfhqLYq2EooqK6i
         pLKMPETWUJRP6UxaXaRKv48mmLelcpmjpbed3gkGmVMqoEaJyWLtBUvV6KnM1hwqtzcf
         MFCdAqaCR8Lnq/OxipR7GKbuKf3S82z9fE/wOKpcMqDOWKeip2/lxcfa8GRw3C+WNMeT
         mRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534713; x=1789139513;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L3YhTe2Z5d0fL67Sri1X8bt0OFBpm40BZElE5qsfhEM=;
        b=KD9HqPh/dLw52YFsmus7N1G20n/mxvqxD+OUmh+AYJ3Dk5psVMRyaQev4Yokk0ZgXO
         2zE+tIg0Iu2UN9Ps4uM2iGFRfv0Poh9SU6mlIibkBSYAw3wggS956NL16ZLQGOUm0mxr
         H0FVv+kw5aABccibHZj26/11kCl5PoiGVxOTRkM6RbcJ9znd2UFDPRG8JsMwiJrLG1CR
         s0rblw6YhEWrDtCiJvUgXQ3zlxiYCaSIDOCUXr7RAtFFJCNYaMZx9IjZWG0RodEszQpp
         7tSlwEIWz/sy/6GmeRFvx8xWggz4kxLUpL2imDFYstD/xmfKHwsA7MzHUmGJgIBD55Jj
         yz6Q==
X-Forwarded-Encrypted: i=1; AKwUvBwwOOb9tPKzz1J9pfoPv5reTWRP77RweVR0n2Kt+r/hjmQa254bG0UgvDkq4tejZRAgbtiQIWPc@vger.kernel.org
X-Gm-Message-State: AFuF++nIqWJ+h9n3q9Jv1K744bVQ492z8iz7eMeeBkUXage8cCvdVFrw
	VO+hE3fvwFECJzMrCY4FGFlWTVlTHXxXBi4uGloDzXT/sXrOhma/2G/lALwjbyzBM0dnUGr5dSe
	6uYAOLry1wsTSBmhT6wteNajKB+oxsgc=
X-Gm-Gg: AYBFou0xdDt/qhRhI7D/ZoyNJ2aRL0xCQBm9ED9lHcOb9XP1YKNU4RIfzf/FII3H710
	TkG7Xdd2UpcSHFeyYDqoEd0N9QnfngFTGzdHEJoKM9cWZX0+4L4Rg4okcgAiPZgBJLineQnyOy2
	ptoAFdDlVpAjHFsdDeBQosFCRxNpSXXCMf0IwtuaL/81Ek/lq8GzgYc8oGQu+A0sWJE8FADlL/l
	MWFLyDp1agercNYh3AU4cd1mDsReHdJfe6pbTyxIotr1L1txhtsddbCfCKn6+Jo9WPklBfo4N/C
	cKgaN9DObu5TRVbeINKZXrr3wK2MVS3u0IAfTdF8tlwa
X-Received: by 2002:a05:6870:d624:b0:475:a153:2dcf with SMTP id
 586e51a60fabf-475a1537ddfmr3371845fac.37.1788534712862; Fri, 04 Sep 2026
 08:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903155837.516393-1-omosnacek@gmail.com> <87ik4l18wm.fsf@redhat.com>
 <CAEjxPJ5Rtvp8MOuaxUPduJ6Mi6NEW1OzOdyxTtBx_tfr-gwN3w@mail.gmail.com>
In-Reply-To: <CAEjxPJ5Rtvp8MOuaxUPduJ6Mi6NEW1OzOdyxTtBx_tfr-gwN3w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 4 Sep 2026 11:11:42 -0400
X-Gm-Features: AcwNN1Vz2w4iC3On9MhxC2Gug7zN1om4yNaN8JUxOGiuM8AsH8JxrUJECnZeGQ0
Message-ID: <CAEjxPJ7XBcsH=b0hmLCGn4otziDrSt7TE=_5St2H+ETODY=Mnw@mail.gmail.com>
Subject: Re: [PATCH userspace] SECURITY.md: update Ondrej's email address and
 add GPG fingerprint
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 9:33=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Sep 4, 2026 at 9:15=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
> >
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA512
> >
> > Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com> writes:
> >
> > > I'm going to use my personal email for upstream contributions from no=
w
> > > on. Update SECURITY.md to reflect this.
> > >
> > > Also add my GPG fingerpint. The key is not yet signed by other patrie=
s,
> > > but I've been using it to sign my git commits for a while now. It can=
 be
> > > also found at:
> > > * https://github.com/WOnder93.gpg
> > > * https://gitlab.com/omos.gpg
> > > * https://keyserver.ubuntu.com/pks/lookup?search=3DCEEE4E9CF1676119&f=
ingerprint=3Don&op=3Dindex
> > >
> > > Link: https://lore.kernel.org/selinux/CAFqZXNvOGbzy8-ZnJtKi94jfu2H173=
Tz7VYpK8KuseMQS-9tNA@mail.gmail.com/
> > > Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> > > ---
> > >  SECURITY.md | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/SECURITY.md b/SECURITY.md
> > > index 52ab863c..1f255c81 100644
> > > --- a/SECURITY.md
> > > +++ b/SECURITY.md
> > > @@ -40,7 +40,8 @@ window.
> > >    *  (GPG fingerprint) 578C 4211 832F 0A7E A2C5  A7C2 21A4 6E60 3F74=
 4ECF
> > >  * Jason Zaman, perfinion@gentoo.org
> > >    *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B=
 0EAF
> > > -* Ondrej Mosnacek, omosnace@redhat.com
> > > +* Ondrej Mosn=C3=A1=C4=8Dek, omosnacek@gmail.com
> > > +  *  (GPG fingerprint) 9F17 354B 2928 339C 5130  906D CEEE 4E9C F167=
 6119
> > >
> >
> > I hereby verify that this is Ondrej's key
> >
> > Petr Lautrbach
> > -----BEGIN PGP SIGNATURE-----
> >
> > iQIzBAEBCgAdFiEEcgDrLD9eSIRjwM6ezcroySfGvjEFAmqavYQACgkQzcroySfG
> > vjG7tg/+KTaC0uj3MQz4henqElcCjNsuhPhmQ/8mVGyzRGvCr3UaH1OBazvmM7Fb
> > 88vaDkV3A95ZLYZRk7X/aANlYB44f4I1ncIew9H+bOISaehCTO86xQXs0z8qNSol
> > 2bduHbDT22wWDvgxqhGnc9UEd7dPwLvf/jQ3lLabavfslK+G0PKxSaoBVX8Yz1ZH
> > /J1z5AxnIGIl5UQpYoIzXsmwK/fIcvGZ8q0+XPLEi7pz9fzpS+QE8Jp04U/QSdKo
> > 1TN9RtsLgCXIvlcXbEZjpBLBxI3lW1bLnq2tJlfj5YtT7RnI4TSzwaZ8HC5TsDU/
> > qhUEXzMAUmKcOvfvZJ8b6w/ehbN3BkcDyUDtdMEZXLyzZjNoJttOa0FoW9nfwoeU
> > wnLS7hTVdNnkVui1VWuq9GWtqhbgp6+KDYtBbE7GHzzvycMBJOIZakgwaOsc7pvQ
> > +vddPu75XwnzyJmC3/kEnGUsOyHyPfwJZ4/+Etos48KZHOE/2I6skmoRXhGasAe/
> > 9NTL1vM5eKWhZWZV2QMAgkgoB7oulPC+EZXKiBrE13uTACibUCKO/ZC1+XLlIIDE
> > kvUQEgfhct2WTunr/DBquqU/4AojIsNZdOa3SVAez+viFWf29v40edtKGVRUTZG9
> > dx0J1hK5KP92kErl4am8G088DHAnU5jeXbtrB8gGTmmhRqXxTIs=3D
> > =3D/OCL
> > -----END PGP SIGNATURE-----
>
> Thanks, for reference, something mangled the email which prevented
> directly verifying your signature - AI helped me by suggesting this:
> python3 -c "import quopri, sys;
> sys.stdout.buffer.write(quopri.decodestring(sys.stdin.buffer.read()))"
> < email.txt | gpg --verify
>
> So with that done,
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

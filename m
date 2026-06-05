Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA5B30D403
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665262; cv=pass; b=jpYsZtYLMLnKP9w5hpcuO0rZ7vl0TaC5+XWkuFrK4WyncwRCcIkZBnk0xSQ7S6YQuULc9VtsnVi1D7b5SQYkkp0hmxTasHTHUf2RUZNr9e5szbRN/Ni+47vkviHERXd8rPNZkuofqvUZ9QaAclBaGqqBi/arRnnU4Z1VEpHUBis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665262; c=relaxed/simple;
	bh=/m6B9We65v0NZ+99yjW0ybaIJr2Di2VwnQBcFJqCAHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7Xq1vW/c6am6CEqOatwdjZSKQx5MNf4LGObMv6QG+pZm3OfDmD0zi08SG7Mx2xoEkly+ln/9Dpn0WSqHm+f4sxyEbB4qNVbX242+2jx6C0j8QYdlE+D0UKlqo/evKdWtJ0iKmCUvJ5Nz0PiGPBnmowC/bpxKVyztrsvlFy4hFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHHZhdxI; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHHZhdxI"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-395f24a5f2cso18048581fa.2
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 06:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780665259; cv=none;
        d=google.com; s=arc-20240605;
        b=TWL0E8dt2zNZT8gLkvYU8FrAQufilsB45HWmOiAkHp2ubpiEOArqwoe9t6X0bvSn/U
         bdg9PWZ0Vlu9rr5WINgX+ZcmtKdR9k80pKygqL8NXZ3YvgpunqzIWhaz2itKoYgF/UhS
         sSxkv8Loise0z7bZlB5VbdoucuJIAk0isPhDUSsJQgiPapkYsaHoov6BBug4MA5vLcee
         PzS73JSOR5BpPOVtHDE0A2NjZTQMVym/VkypWbzQLFl/fq7km9Kxug1PDKKfOOhH5o8N
         rFQ9Q/YtBrQ4U10CTWTOPPNHJXltDkTDwhSt2lzbaguMfyl4jXhKNbNlklwN5vvRyUvu
         ktiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=czI+o7EJpN8r7eUSPgJvyBNRVeyeir3Qxq8xH2nEJ/Y=;
        fh=CD34+7COpyg1MOm8BL7sbg73nhzRt79WttgfqUzA93c=;
        b=ADB6th7TdLw05NCBn2YcCAq5TvrFmr2TJoAbOLqvLBfGDt0NQawbBiNjBFaSovb/Zs
         NypFJli5kK59TgtHRQScDpuG7lpgWSPqxCJan0zb+iUcdeH+0yKrbcbtZ8k8dXVFMHUG
         fnE9ylDEO/FT7+YNbhmCbJdmKJaPVUv/228PpvJ/p214sSkFpTM/NRqq2Tb3Oi5tikCO
         qunCJtdHBSzo3oyZYn5R56Iial4vDOkgPXEePkr+avhTelR7C8bMHZnYFH/q+6f+5ga1
         LtznHlcewL6ACAz9Uz4rAv2BTEAtr/QGYO8ZjP4qNySotU2UvVka0dx+sNmZ/KVEpN+Z
         zvNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780665259; x=1781270059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czI+o7EJpN8r7eUSPgJvyBNRVeyeir3Qxq8xH2nEJ/Y=;
        b=ZHHZhdxIrucUI3Q+yOJhC0H9TB9Amy3GL6h9H1kGKU6V7r9IwN/vrfPK1vLtvPPD11
         Pz1kvGJvzHqhgBfljrb2aop+/fKpRENa/DMzUeLwa0lwgYA4epAdE4klx7lZ7ytjGCH5
         IJBGk99ErgvU4Yhg9AS9P5ZXEJ3bpXxtIl728xk40Gl0xFNxIEktiQoKXWuteqz2jVd0
         1qM+W/4OT7+UtCz3tchq/0VnTfy906+ze7N+M/m15aKhRWaINk6iKAbRmnKKkVX9THhH
         lN79gsixwe4H5+aOInw8G4M0ni+CFhRGqarL+dxwzG5XnrFbR+3FTgkgBTOiWmLpLa16
         QlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780665259; x=1781270059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=czI+o7EJpN8r7eUSPgJvyBNRVeyeir3Qxq8xH2nEJ/Y=;
        b=ovTA0+iDjfMTpc1yKHcS3bnfWdDVFWyB2E6K9EAFjFl1uurqN1ptylK9ggJxtU5Qnq
         Xxyjyutd20ZmRy0NieqVOTRLTC0hnycyZoUZL6a1BjM5AIl/CwEhwbekselxU/MI8WKJ
         gO/ysjnJTk/CPbPvccMNH7QCzEqbindI9Xv1kWTz6AJEXyAD1PisanAej5o/5W21JazM
         elxYiYlsTi00fi+pbRXIne5/5wLcNkvflqO3x4Z48uETZexkIgqH5UVYl7yYhReXJ02z
         P9joZUMuvsByivwenoSQzDeaYiCfC78j3B6M5sfFPswZeF3SugX8ceW6754RMoS+jPQ/
         SGbw==
X-Forwarded-Encrypted: i=1; AFNElJ9LH2aConyERRv9pHg0Vu3phAB/Nx1pgzORmiMGgk7yEV+noMTlg2SQZBB0fGbLbWqeIXNKhD0X@vger.kernel.org
X-Gm-Message-State: AOJu0YzAd9wln+SNKsI1NIkICfS21V5ojYoU4vfPsF/Oj0pd0AoH0Fyq
	OiCdC3jaov04vb8jQ2jiNuRZb1ZQwFWzkL5BPgI6mSZ9Asesk6GNDtl9pSdJ+0Or8d8eWw/TPCV
	8L0qG815VxJ48lYPfOymkgEeCq4OKRnY=
X-Gm-Gg: Acq92OG4AYKe5YEGEPtybjOQO2bpKvxBp/RiLafe78S0v0B8iX6Qmmt8HnAyIgrCKWC
	fACAxCx8UaI74b+p4WS9uvolN2O2QFaG7rkmPaeIMUJ9H3zC+e1MaxJyBQwMbd1ZE1jRBoC3tZN
	Jvg2DVqjhZ7P2Lv3gXFSJC67+uwA/RCOoluaB148K0VsbO/HJrblZ7summPoCWTwAqa5KFsis1S
	flkhKVFqQMxdJAc+523QXivaTYiYsyPekmbXaOhV46DeXMdVsYLzQRy8jNUkFlzyID9xlHszvbm
	n+aBKVTJYCEhkPQ=
X-Received: by 2002:a2e:ab07:0:b0:38b:e464:f047 with SMTP id
 38308e7fff4ca-396d090d84fmr10542541fa.12.1780665258794; Fri, 05 Jun 2026
 06:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605112614.2397757-1-lautrbach@redhat.com> <CAEjxPJ50c=904ijMzHxA_5csB4u81WUkgPxEb_+wUimct0cpDA@mail.gmail.com>
In-Reply-To: <CAEjxPJ50c=904ijMzHxA_5csB4u81WUkgPxEb_+wUimct0cpDA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 09:14:07 -0400
X-Gm-Features: AVVi8Cf42e4GHjbtAogiyIzOJqL9CjM4Cz8wIS0IUhYwnER17vejy0kegORKFIM
Message-ID: <CAP+JOzSxn+1bWJh6SOm_Bt5mhVZqeXjtGSxSi7b4F=XvpR0FPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ci: install necessary build python module
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 7:59=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jun 5, 2026 at 7:33=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>

Merged.
Jim

> > ---
> > v2 - add python3-build dependency also to tf testsuite
> >
> >  .github/workflows/run_tests.yml | 2 +-
> >  tmt/plans.fmf                   | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_te=
sts.yml
> > index ed60921acfb7..82c44fccb521 100644
> > --- a/.github/workflows/run_tests.yml
> > +++ b/.github/workflows/run_tests.yml
> > @@ -71,7 +71,7 @@ jobs:
> >              swig \
> >              xmlto
> >
> > -        pip install flake8 setuptools
> > +        pip install flake8 setuptools build wheel
> >
> >      - name: Install Clang
> >        if: ${{ matrix.compiler =3D=3D 'clang' }}
> > diff --git a/tmt/plans.fmf b/tmt/plans.fmf
> > index 89f041f2630a..8f9f96f46290 100644
> > --- a/tmt/plans.fmf
> > +++ b/tmt/plans.fmf
> > @@ -30,6 +30,7 @@
> >              - python3-pip
> >              - python3-setuptools
> >              - python3-wheel
> > +            - python3-build
> >              - swig
> >              - xmlto
> >            test: |
> > --
> > 2.54.0
> >
> >
>

Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D60F26CE39
	for <selinux@vger.kernel.org>; Mon, 28 Jul 2025 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712690; cv=none; b=nS+54PGYpH++jRpANR/ULbavrHeeuWRecf1ZfWp9DkRaQ2VLfhKGPfXC0ItEettP59K7z4HCMmRyR7mM0Ef1pQqTlhY23CSHfGs6RIFleaar11rktN6T8/p97DQFBL8z/iH5EU6iNSsYRsX38HyqD6tagHh7LpBZGo0jct1S/F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712690; c=relaxed/simple;
	bh=oDrzRE42nXQsDquvl2IaG27fuKVOkvy9OljPRmmoJ0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5DmZ71JcliHGZnL455d6/xwzIJBbDr5FRB4ZViPcEyhJDT/9iz+HPWmYDrHSdIa1zOORSkVLBHz+J5gejOjdQZCq2ZeE9ZnmjsWrJj+ceT/99LHxrfFRDfVC/049u3wYPzULwL/RXu8r8bCDcTWFNJvhmBxfipS1QNq0CwOp0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdTM9JYj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdTM9JYj"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2402bbb4bf3so11819195ad.2
        for <selinux@vger.kernel.org>; Mon, 28 Jul 2025 07:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753712688; x=1754317488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2UDk+JeuyrMHKR9uhtTwmehfhwkuiE5Eoc1XI+bwjE=;
        b=FdTM9JYjBV9fvJyEUmx5F0dgtymHbiNmd9IGm9tDitF45zY+v/IdHV3eUS+/t3PUXo
         xaBkldb+c9nmSShTnPvfDSSse54Hj/QOP2EHSbMGtynnPL0YACqPqyBSfV8ZaQAzEBmV
         djEzNrgFfdgLqqOsI25HNo4Go326q//BpmbbMcvktmwCWMajsoKm6PE7yyM03/4yvlCD
         lhurq+96WVCntSNYNEgDydwqEeBOSAr3Mb4LZuNjY446EMozoXFLlKwtPcearNEb04xB
         4nrGx7cVvmb08udmYr+pwDbXJt6zhtEnp90yw7xom/TCwLIg4TI/iRZiD+nYehS9iEuL
         7XPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753712688; x=1754317488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2UDk+JeuyrMHKR9uhtTwmehfhwkuiE5Eoc1XI+bwjE=;
        b=MU6jA+vpV82uxQME0DUnxyQygpOBO+z/SN4Fkb7oGZKgWaC/JufC1VC+xmcniLKywQ
         94SjSS38+bLfXecnbjgDhYBzyMzoSx05xh3M5IVQRMlmD10FjIxPhzZVULv/fNUVQXQE
         eiOIkAwdiFD5L8i9TCm/TEj3QJpJ0jsE77nWT5N69LQ1jfmc9DJanWLrbIpyO9O3EBwt
         cB6HqD0v46Gm5jcGE7z837SrUz2230ApmGERYaT9h+x28kWS8BxlCh/Gfo8rtnmnrlwE
         MzdgYNIQsfhjIFUFExmUvt2VjmOoSmfX/0Wt9bjyMeByXXfRCfDCpOyKnhcdhUZQ7peB
         cplw==
X-Gm-Message-State: AOJu0Yz9nl0N7clGHBVFFhaXezNJ868cdNb5yX8GgH5haJNrQkgZoPYD
	AjXjscQoO0OWOAHd36JwRbIq8DDOT93wOEaXfUEhxZtsbf0sTACquxQthGucwZhDvfYmRhStsft
	Fcw1N85Dj0XYHag8hL9gj2ZhcjgoHzWoqJQ==
X-Gm-Gg: ASbGncuuvHa4CUMRYFXQOwjORU4cb+hcSOlumhREMV3/sOqUZ30NDFJdPU2tVhllSlp
	T3XjNYsokV0TCHeFhs1CphIdYuvglMhIS+Z3+qsWhUwlmHewsB5ooUyxDl50iWn/4pERFQ6o9uS
	tEum94ynIuLbU+RFG5LPhxGV7qtg0ddT9jHGAeJlXJSu9bx7dAHZNCHRoFwBrDUdv0jkIKZ+vSE
	trQa48=
X-Google-Smtp-Source: AGHT+IGJXP7vVJpUpXwYaye4aaBCaMJUNceAR4DdjeaoobE470esLQqfPrO0sgNajzCPmOASAahRwYNl76mAf1LsdIc=
X-Received: by 2002:a17:902:e84d:b0:240:5549:7094 with SMTP id
 d9443c01a7336-240554973c7mr10161195ad.18.1753712684889; Mon, 28 Jul 2025
 07:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724084044.23390-1-lautrbach@redhat.com> <CAEjxPJ5+2r+nrSv4w757=Ue6gj0XX0WtOKSyp3-UUfQ2rzksQA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5+2r+nrSv4w757=Ue6gj0XX0WtOKSyp3-UUfQ2rzksQA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 28 Jul 2025 10:24:33 -0400
X-Gm-Features: Ac12FXxbDmjJqf1bj3zzOMo0mB1qPB5Oy5iqv-HPXa4-9JEPLRNN2LiW3hfjlSY
Message-ID: <CAEjxPJ4EzkmxRZ082x=9_fykhrEaaRt4ZLpTHqT2V7XNvvD6tA@mail.gmail.com>
Subject: Re: [PATCH] Update CONTRIBUTING.md
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 10:11=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 24, 2025 at 4:52=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
> >
> > This is based on
> > https://github.com/SELinuxProject/selinux/wiki/Contributing with
> > preserved "Developer Certificate of Origin" part
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.

>
> > ---
> >  CONTRIBUTING.md | 51 +++++++++++++++++++++++++++++++------------------
> >  1 file changed, 32 insertions(+), 19 deletions(-)
> >
> > diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
> > index 575410bf8c3d..c501cf842dcd 100644
> > --- a/CONTRIBUTING.md
> > +++ b/CONTRIBUTING.md
> > @@ -4,18 +4,31 @@ Contributing to the SELinux userspace project is a si=
milar process to
> >  other open source projects. Bug reports, new features to the existing
> >  code, additional tools, or updated documentation are all welcome.
> >
> > -You can find a list of open issues where you might contribute to the S=
ELinux kernel code at
> > -https://github.com/SELinuxProject/selinux-kernel/issues or to the SELi=
nux userspace code at
> > -https://github.com/SELinuxProject/selinux/issues.
> > +You can find a list of open issues to the SELinux userspace code at
> > +https://github.com/SELinuxProject/selinux/issues
> >
> > -See the SELinux userspace
> > -[wiki page](https://github.com/selinuxproject/selinux/wiki) for more
> > -information on mailing lists, documentation, and other resources.
> > +See the SELinux kernel [Getting Started](https://github.com/selinuxpro=
ject/selinux-kernel/wiki/Getting-Started)
> > +guide if you want to contribute to SELinux kernel development instead.
> > +
> > +## Mailing list
> > +
> > +SELinux has a public mailing list for developers, subscribe by sending=
 an email to
> > +[selinux+subscribe@vger.kernel.org](mailto:selinux+subscribe@vger.kern=
el.org).
> > +It is generally wise to read relevant postings to the list before begi=
nning any
> > +area of new work. Searchable mailing list archives are available exter=
nally at
> > +https://lore.kernel.org/selinux/ . Patches for SELinux are tracked via
> > +https://patchwork.kernel.org/project/selinux/list/ .
> > +
> > +## IRC
> > +
> > +An unofficial SELinux IRC channel is
> > +[\#selinux](https://web.libera.chat/?channel=3D#selinux) on [Libera.Ch=
at](https://libera.chat/).
> >
> >  ## Reporting Bugs
> >
> > -All bugs and patches should be submitted to the [SELinux mailing
> > -list](https://lore.kernel.org/selinux) at selinux@vger.kernel.org.
> > +All bugs and patches should be submitted to the
> > +[SELinux mailing list](https://lore.kernel.org/selinux) at
> > +[selinux@vger.kernel.org](mailto:selinux@vger.kernel.org).
> >
> >  When reporting bugs please include versions of SELinux related librari=
es and
> >  tools (libsepol, libselinux, libsemanage, checkpolicy). If you are
> > @@ -23,17 +36,20 @@ using a custom policy please include it as well.
> >
> >  ## Compiling
> >
> > -See README.md for instructions on how to compile and test this project=
.
> > +There are a number of dependencies required to build the userspace
> > +tools/libraries. Consult the [README.md](https://github.com/SELinuxPro=
ject/selinux/blob/main/README.md)
> > +for the current list of dependencies and how to build the userspace co=
de.
> >
> >  ## Contributing Code
> >
> > -After obtaining the code of the repository (see below), create a patch
> > -against the repository, and post that patch to the [SELinux mailing
> > -list](https://lore.kernel.org/selinux) at selinux@vger.kernel.org. Whe=
n preparing
> > -patches, please follow these guidelines:
> > +After cloning the code of the repository (see below), create a patch a=
gainst the
> > +repository, and post that patch to the
> > +[SELinux mailing list](https://lore.kernel.org/selinux) at
> > +[selinux@vger.kernel.org](mailto:selinux@vger.kernel.org).
> > +When preparing patches, please follow these guidelines:
> >
> > --   Patches should apply with -p1
> > --   Must apply against HEAD of the master branch
> > +-   Patches should apply with git am
> > +-   Must apply against HEAD of the main branch
> >  -   Separate large patches into logical patches
> >  -   Patch descriptions must end with your "Signed-off-by" line. This m=
eans your
> >      code meets the Developer's certificate of origin, see below.
> > @@ -43,10 +59,7 @@ design on the mailing list prior to submitting the p=
atch.
> >
> >  ## Development Repository
> >
> > -Git is a modern source code management system. For more information
> > -about Git please see the Git website.
> > -
> > -To get an anonymous checkout of the SELinux userland repository you ca=
n
> > +To get a copy of the SELinux userland repository you can
> >  run:
> >
> >      $ git clone https://github.com/SELinuxProject/selinux.git
> > --
> > 2.50.1
> >
> >

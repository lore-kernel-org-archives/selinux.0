Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F2E17E
	for <selinux@vger.kernel.org>; Fri, 20 Jun 2025 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421173; cv=none; b=eji3tdLL3oERfV+5oz3xOalAo/VSDuCEqa9EA2f2jrau1jGOTaV87lIpq4be2h8WloUfoRJhcR4hkSWwxHyuejckdOHLMsgZj+4rHZ5D/xKFLZZTotiCTZuTgz2rb3iDHB6KUFCw6HwKiO95EDnIm0L98vcWa4Dz2uT96NE0kX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421173; c=relaxed/simple;
	bh=UQwiNU//Kksni4dRuXcYNh5dlKDCXk9HMLPifglGi4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QB17g5D/zj1N8642GGD7KPqatW4u0WXsl1viakhnyyjI6jJv1YzcyrFLG5mjvt6tUaNqXQVoLQfUJdLIgC3fbpQ9Rjf66rGutpc1QQjZeCMR4sBmfrRuk2i5XZ9Sf+rJQ1QTOidPn98LuW8+XOEbl6TjCbZXQFjf44oju/VI1gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0jToi7C; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0jToi7C"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af51596da56so1455057a12.0
        for <selinux@vger.kernel.org>; Fri, 20 Jun 2025 05:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750421171; x=1751025971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJiSvk11113N+nTOV5TFrN8lD1y5GjJ1UzSQdDTxzc4=;
        b=a0jToi7CAf9YQ+hJXBMgQs8u/IsosYVdi9AdH0MRzfIiJAXsIEyWrlxIln657CFI+A
         Gjg8gXYQysfdbogCBt2RGtYn6Nrklung11LapG3dXU/nirnXjzB60sLjM4Owga1a37Z6
         bMpQawciBaAlNle/0/QHEvLOvBEXfbWOuCJi/o0DsbQ14V+g0wRSiYekMWr7IidhtmG8
         kmx2qDyoWeKu6Gzs2IfUWcsfLsLP5Y1bVikauAuJYoD80Ankw47kzSzf+LJD5kJaVRP4
         3e4XnzL6DUE77Zs3HljYMj7byc0yKIj/8F8R6J6Ha8IAdZo4AMKuNI7I2XHD4sp2F9H3
         s6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750421171; x=1751025971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJiSvk11113N+nTOV5TFrN8lD1y5GjJ1UzSQdDTxzc4=;
        b=iLrnXZMvskap7qAdY1sO2mJpPVZPBhgAJLVyh3a2+0TJMCF8hRGJmCnTEOE/BuvZjq
         z7KZzLhrxjg86QPMuNIBcO7rOxDf8pO2pSFRsH3LBY98hJDpPnFo91mXYOYoxZuGENEq
         zu5fTjDOHmqPe4YV9tOxowofkC/CMu6F8EMoBkguhyAH6baHLTxiko0l7G9/HvuipYFz
         6F2WKyTxl5Y8Cr/GW1GYSfj+Hru6gTs1ISY1JVfjuImlHiY2rwFXt/VaSzZQX1eTLoYC
         AGBhXFMEAygtjuOIfWITO3KaLCZdVTe5AcghXY6r2Ck1HU2UMHpTTKNpW4bscS5U/XIM
         YJDA==
X-Gm-Message-State: AOJu0Yyz8R+QrSAIb8uepy6bcnEHjiV4n8yR7YiQ9T5J3qfzv6kYlTGY
	rvlAyPJCyHFoO0rLP9XK4l1EacxfH04rg5mpOODOk+AIFYO3CyD3e+4M7tPB/iei70e6d9z0mYI
	0T/Scxvz9N0imCnsHedOZbhLGALpcAA3F8g==
X-Gm-Gg: ASbGncu8cRI6BwLfybs3s/7hFaRrMVCVl8Wv8FU3zcyzkbiPVHxA6TdBp7tuDap6ZHt
	qd3bDwRqAopqjqbN6gLPX7ShBTmY5YR70s+zO4RqqimcemeKQVzO9NORyCM/AEVGSuexD+Cp5hg
	RNQaBN9BqeFa/tw+qxw+nZSDskzv4cyPxjq8Ih/XD3hpA=
X-Google-Smtp-Source: AGHT+IHaLgspxdPMvuKJjSxjXspEhlCup1285uO+fbhQKUh3Sc45kUL8PKRCOSLsUk8Wd4p9A1XfyF7bOOzJ+w6QqD4=
X-Received: by 2002:a17:90b:4a83:b0:311:af8c:51cd with SMTP id
 98e67ed59e1d1-3159d8c80eemr5670933a91.18.1750421170472; Fri, 20 Jun 2025
 05:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617143906.22706-2-stephen.smalley.work@gmail.com> <2de6d4fbc8b5eae256c4dd3a718b08bc@paul-moore.com>
In-Reply-To: <2de6d4fbc8b5eae256c4dd3a718b08bc@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 20 Jun 2025 08:05:57 -0400
X-Gm-Features: AX0GCFv79d-5Q-zT1vwKHER-jtyNNO09GaFqMDwb40TSBee4FDI6Or9Nypgov_E
Message-ID: <CAEjxPJ5CL0yt5pVnja6axPEpgf+PWn_J9vL9hbv3h-c7q-at2w@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation/admin-guide/LSM/SELinux.rst: add links
 to resources
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 3:12=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Jun 17, 2025 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> >
> > Add links to the SELinux kernel subsystem README.md file, the
> > SELinux kernel wiki, and the SELinux userspace wiki to the
> > SELinux guide.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > v2 adds a link to the SELinux userspace wiki as well.
> >
> >  Documentation/admin-guide/LSM/SELinux.rst | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
>
> I'm going to merge this into selinux/dev, but I applied some tweaks
> as there were some odd inconsistencies in the patch, more below.
>
> > diff --git a/Documentation/admin-guide/LSM/SELinux.rst b/Documentation/=
admin-guide/LSM/SELinux.rst
> > index 520a1c2c6fd2..22b9f91b220d 100644
> > --- a/Documentation/admin-guide/LSM/SELinux.rst
> > +++ b/Documentation/admin-guide/LSM/SELinux.rst
> > @@ -2,6 +2,17 @@
> >  SELinux
> >  =3D=3D=3D=3D=3D=3D=3D
> >
> > +Information about the SELinux kernel subsystem can be found at the
> > +following links:
> > +
> > +       https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux=
.git/tree/README.md
> > +
> > +       https://github.com/selinuxproject/selinux-kernel/wiki
> > +
> > +Information about the SELinux userspace can be found at
>
> I added a colon to the end of the line above, "... found at:", to match
> the style used previously in the file.
>
> > +
> > +         https://github.com/SELinuxProject/selinux/wiki
> > +
>
> I'm not sure if you were using an odd editor, but the horizontal white
> space before the URLs was odd, including a varying combination of tabs
> and spaces.  I changed the whitespace to just a single tab to match the
> rest of the file, but if your spacing was intentional please let me know
> and I'll back out my changes.

Sorry about that - I am going to blame emacs ;)

>
> >  If you want to use SELinux, chances are you will want
> >  to use the distro-provided policies, or install the
> >  latest reference policy release from
> > --
> > 2.49.0
>
> --
> paul-moore.com

Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF681AD3F1
	for <selinux@vger.kernel.org>; Thu, 29 Aug 2024 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942122; cv=none; b=h33nWx7JXLCtSztxPY5NO45RuuwsQR3g5vVgtvc5PJhd/lql6A3r543E3gM7+whL6Em9t3EjCVUUoNO/A7XvIPOFTtjf9tEd3MT7IY7+lV3kgQsgP6Sh6ZLRw0AkYuME0OTuWQVo6WsgUa8QvxsyIPXx2PK3WHwBp7a3eeTSUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942122; c=relaxed/simple;
	bh=cSuNhWU5hC5dr0hPWuugnzGw4Duhg9YbH31LJCjze2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNXARxTgsklg3egTK5BJLUWYR0sAXcx5pWUH8JMiCvEr3ulXW2eWYCepBLmYGsAl4o8lcvar2TQWGWTRwXT1KeL1Hf9Cg11V02wqcgQHHM/q7EwPmYQmMvwKxN3CrzaidJjP9p8E4xedRwn2cBtM2cEBEKxmmZyEIGHY09tf8zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fxHWaL0c; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fxHWaL0c"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6bada443ffeso6608767b3.0
        for <selinux@vger.kernel.org>; Thu, 29 Aug 2024 07:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724942119; x=1725546919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fq+keI6zaLzl7rsxWPn/Yxu76rS3UHFr18WFTEtcQpE=;
        b=fxHWaL0cHNNVa1SGk1tz0KXj7qvqhEOJgzdN5WpTVRvkcRYfjgw2Q/gAhIVqgXA8Li
         jOBKCsqiBpO0TsccRhYQER90bUILbotYMP6nPfrzWQqdmg6Zh9vdrGTzrhRvXrwqJiZr
         QVw5jA90mKBCzGYR72jXBb0ndfOgTC+bNgsBMj6WLmPAb+K6RsgWXP3J79JFzKTPoUaV
         oHct6maQWaXemXq4QUAbislFXZB+SLTRtMFjFfdCNCq6ksET+DEVQkY8MIYCuUgwlkaU
         nkf/xEJ8C4IhYGpy8aExN/qAvq+GRvTDTzlMksh5juBQhRQT2O8ytbXyPata5+qmU1ld
         yJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942119; x=1725546919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fq+keI6zaLzl7rsxWPn/Yxu76rS3UHFr18WFTEtcQpE=;
        b=t3XVqjIwPj78tcSx3GnkJkm3GGhE9eF5dAlPekBdpSbKX0x0M199EICgwRBSetri53
         fTgj6/r8sE9ZBqvrzyFW+pD+4w7K5sE/R/CQWciVXxwZvzvzhB2MDn9dpy5iOEoyaSPK
         zNbx27DbHdlO++eZNtGItQwZ/eRN2gH9PxkTc24hwkBoC0wBDFm/cNkLkCKSTAEcF1V3
         2FQKbt8Yl1HDv4jttm9n9lwcXdI5sBsX3OC9kPSloScM9p+QAW2mPdlRH3fg9RjNqIHd
         8h6Ge/9OBKT5ZLWX2S4c79Nro6TMMMOGDu0X7iz3OQYiv++Ti/hk/Pt7qs4o1+eBhreZ
         9+9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVok20ENhQevOk1fxYnFPqNP4FtRurT3ENKTBWwsf+RTXgmkm/qsWCWz/hGKceS9+qD3i5xRCDB@vger.kernel.org
X-Gm-Message-State: AOJu0YwaF+igl/YbF9JPhlUPJEiVK1/a7PbVrlaJvMwYuL8J4ksVtM1C
	YvFC84w39qYJRcrfXloh7U0mJYEnFIcij2+te636uY9wL0SqfFBsuILQ77uV09vFbmpl+ELZUYL
	nVm9XyFr22d1XU3dXSNaV0pbQilWQ8uQxMqab
X-Google-Smtp-Source: AGHT+IFqDwZKTc9DE4EkZapoF+w0eQA7Z/rTqjjyY/vDlv/AMMNl+1RVBKpVQRF/rtFZMcsAkb8Fkp5Y6HgQN4+PAcE=
X-Received: by 2002:a05:690c:62c3:b0:64b:b7e:3313 with SMTP id
 00721157ae682-6d2edd5e6admr19188067b3.13.1724942119363; Thu, 29 Aug 2024
 07:35:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827145518.469490-1-omosnace@redhat.com> <CAEjxPJ5LXdzRXrLZH1FCJ31h6qCD6WFaUTkoaOyad5Qsdk8rMw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5LXdzRXrLZH1FCJ31h6qCD6WFaUTkoaOyad5Qsdk8rMw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 29 Aug 2024 10:35:08 -0400
Message-ID: <CAHC9VhQv=ZTEZfrthzGZLGVTpMKCFaAxGz12-+49WZ3o135q0A@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/key_socket: skip the test if
 CONFIG_NET_KEY is not enabled
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 9:37=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Aug 27, 2024 at 11:09=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat=
.com> wrote:
> >
> > RHEL/CentOS Stream 10+ and Fedora ELN will have CONFIG_NET_KEY disabled
> > [1]. Make the test skip itself when it detects that PF_KEY is not
> > supported so that the testsuite can still pass out-of-the-box on these
> > platforms.
> >
> > [1] https://gitlab.com/cki-project/kernel-ark/-/commit/99d6d1c86fe1bb1d=
f5c0b80f4717826c2330e291
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Wondering if we should drop NET_KEY from the testsuite defconfig too then=
.

If we have a test for it, it seems like it might be worthwhile keeping
it as long as the upstream kernel still supports PF_KEY.  I'm not sure
if Fedora plans to disable CONFIG_NET_KEY, but as of kernel
v6.11.0-0.rc5.20240827xxx CONFIG_NET_KEY is still enabled as a module.
Even if Fedora does disable it in their build I can enable it in my
testing, I already do that now for a few things.

--
paul-moore.com

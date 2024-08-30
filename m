Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E3F482DD
	for <selinux@vger.kernel.org>; Fri, 30 Aug 2024 06:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724999053; cv=none; b=ZXYvJVzg+71Qmq9Pks0zpZDSrDDqFoz0KMi33St9LMDPkfcEUCfNyorrpL7eh4wonCUtMAc85CyEREwD8/aVOqlt1msQpEhGnBa4FTi6WhZYeCgEGk90p4zz6oB04Qt/AocJcLQsd83fUu8X0Kwvbi8qqgIMf9mNqPJaz2KBw70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724999053; c=relaxed/simple;
	bh=BbIzwlbNeB8wu1zOzLNfganYR5No9idn1qf/9thrmIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OovHWJQCVSdCDniygDDonobZwmCgebvxgFCImHgt9wexNqTBr8utYjgZ9PMFFlEO/u8MZ1hnUKnFiGwcrIRnYdILeJewDJ6Mlmg46C4sM6wnzOHXvX0nIE5NAB7/p/LOeLtfW7u6edVfssSqJRRVIarFNw8xNUCvKz0IqufJnBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BlzppppH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlzppppH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724999050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zi3iQ9l6/OW/Dj3YBTh8V3Q+/z65dJx3/KugztDDOCs=;
	b=BlzppppHOKBjZCYw8ZendPfN+roX2xmaN/kUwJ9loCIhvbldH/Yrs/MjYLx2UdfgCR+iAh
	aN8LxeLnI0V2qRVSSDie3XPZBU+opZAp/17x1zaytAteIe5GaVLU2SSGK7seB86u9kUzwW
	XTwc44wZ2vNOkZZ6Rk7d+nXZm3PQ39A=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-TbNiJaZhMCSr_fmvJnDzXg-1; Fri, 30 Aug 2024 02:24:08 -0400
X-MC-Unique: TbNiJaZhMCSr_fmvJnDzXg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d3c9a5c673so1486387a91.1
        for <selinux@vger.kernel.org>; Thu, 29 Aug 2024 23:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724999047; x=1725603847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zi3iQ9l6/OW/Dj3YBTh8V3Q+/z65dJx3/KugztDDOCs=;
        b=iWFoJ8tlAbEBPlmwJDA0N8VzVLmkH2Vn4fipEziK7CfnWVngKPEw5S8hGN8Fxb2a/P
         JpVKK0nbprAeTL5RiYoTZXLpDn/koVvkSe8fqCQTLo3Ya0/jhrbo0/TF17iEMziheFxm
         d49QoJGLHmG1sNI8InU12V4Pjn78lLi7F+5Z3XPZlzDT+HCSNvp/zDlSAqRkJLLqxjmL
         2pRHLxxyED6y0xNQxH8De1IIJKhF8a9CNJFve3UD1RW3MpnyuM/g+0AvuA5+1wyXtbJk
         EbotA0qt20SpV6Cz3DQA28NMg1DaZAgvIGwToC+R1Lp4V2wZ4L8E1G1tsYZid7QJg7Mp
         AKYg==
X-Forwarded-Encrypted: i=1; AJvYcCUEAnxuIdEz1abZb29qjka+vLh36ipZ1bc7IbeE5trtwKVbEsg9moFFShc5NulYmBmEtBDqc0zf@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8dl0rzzhps5BjYyACrngG5BL9PaH2fPve9IKIcYur0xn4bnbu
	5ISmJhG+BJ+3qCkDyuhsP7YLfnPWXlKZW7Gq++8KnIyUkfp6jZG3GH1GD7gmCOIAU9hFQfOhBVX
	gy73CvOJePPXq8eTa/CWuJFQoMkZNdUAVL2z2DxlUiquw6otnxA6QZpDjqrUjgWAF1yc7JPQLk/
	NXm/Dd0tyal2SzN5cEVAM7Mm4rJb7mgIWiOeDuDSEF
X-Received: by 2002:a17:90b:3449:b0:2c7:c7e6:eb89 with SMTP id 98e67ed59e1d1-2d8561ce61bmr5536018a91.23.1724999047462;
        Thu, 29 Aug 2024 23:24:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5lClYe8P+oD5LPFyhaenNlo4vaRmKATlXsOXXjOoJ5/z1IotG6HPXO8dCrb8e7QloPdmnaMBgzJAM0tDUerI=
X-Received: by 2002:a17:90b:3449:b0:2c7:c7e6:eb89 with SMTP id
 98e67ed59e1d1-2d8561ce61bmr5536010a91.23.1724999047089; Thu, 29 Aug 2024
 23:24:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827145518.469490-1-omosnace@redhat.com> <CAEjxPJ5LXdzRXrLZH1FCJ31h6qCD6WFaUTkoaOyad5Qsdk8rMw@mail.gmail.com>
 <CAHC9VhQv=ZTEZfrthzGZLGVTpMKCFaAxGz12-+49WZ3o135q0A@mail.gmail.com>
In-Reply-To: <CAHC9VhQv=ZTEZfrthzGZLGVTpMKCFaAxGz12-+49WZ3o135q0A@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 30 Aug 2024 08:23:55 +0200
Message-ID: <CAFqZXNu19Rv9AoWikVVA3rSPHnQaZw=Wsvnw3EET2-J+=1L66Q@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/key_socket: skip the test if
 CONFIG_NET_KEY is not enabled
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 4:35=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Aug 29, 2024 at 9:37=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Aug 27, 2024 at 11:09=E2=80=AFAM Ondrej Mosnacek <omosnace@redh=
at.com> wrote:
> > >
> > > RHEL/CentOS Stream 10+ and Fedora ELN will have CONFIG_NET_KEY disabl=
ed
> > > [1]. Make the test skip itself when it detects that PF_KEY is not
> > > supported so that the testsuite can still pass out-of-the-box on thes=
e
> > > platforms.
> > >
> > > [1] https://gitlab.com/cki-project/kernel-ark/-/commit/99d6d1c86fe1bb=
1df5c0b80f4717826c2330e291
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Wondering if we should drop NET_KEY from the testsuite defconfig too th=
en.
>
> If we have a test for it, it seems like it might be worthwhile keeping
> it as long as the upstream kernel still supports PF_KEY.  I'm not sure
> if Fedora plans to disable CONFIG_NET_KEY, but as of kernel
> v6.11.0-0.rc5.20240827xxx CONFIG_NET_KEY is still enabled as a module.
> Even if Fedora does disable it in their build I can enable it in my
> testing, I already do that now for a few things.

No, Fedora doesn't have any plans to disable it as far as I know.
Fedora doesn't have any contractual obligation for maintenance and
mostly just tracks the upstream kernel, so there is little motivation
to disable functionality because of the lack of maintenance upstream.
("If it works, why risk breaking users? And if it doesn't, then
upstream should be the one to remove it." seems to be the general
philosophy in such cases.)

I agree with keeping it in defconfig - after all, CONFIG_ANDROID=3Dy is
also there, even though it isn't strictly required (and so are other
configs).

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


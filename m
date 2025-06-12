Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A236221DB9
	for <selinux@vger.kernel.org>; Thu, 12 Jun 2025 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744262; cv=none; b=eCT+33i5oSxvEzOp3JNgN83rh7uxW6D5O8NsELWArInrdiLzuxIhf0rzKBW8enQNms3DythC7rLF3OE59vn7BXjcPsXhLZUWNeP77lFuc+hnJB84wIBLD4MQiRU7XiDYW4RmacyOmYdihVPypmgDbjP6O9SvfsNWwRUa2mQBH1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744262; c=relaxed/simple;
	bh=bg4aNy2o+hxLMwvbmxo+MN8BQrkrtQS3tzkOSUOJUzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HD8py0ZVP66gb2nZ20TQxJfGf+MAtYyzevjRT29CCFALOtb+S4QzQ1y391hTmdxIUuhPGNvZqQ9Snlq5/VOlC9tm5TCtAuIUCbqj0LsLcinfUxOyaCIANFZVyCe7ZdyxrZTTADw2Uw20YAZNwNf72JLA5EgDUYrkHa/Anadwhkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UWC5UzL2; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UWC5UzL2"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70e5d953c0bso12615787b3.1
        for <selinux@vger.kernel.org>; Thu, 12 Jun 2025 09:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749744259; x=1750349059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiHMBh3gNNtIzjgxE3TSs3lcaO800T3i7rHstZGDsX4=;
        b=UWC5UzL2T87m6NegA42ojcxmYI50lqlbIJKnNiq7KmnvfUmeovBknKuidrTD8tidQf
         2w7/uDEUrafi1WANiP2AXnwtNJo9ZqbAG/2aY1ycEQsFKn23D8ClQ/c8GJuk9y5dx5iN
         7lQtU2TVSEHXMNLBUVW7/EkSKcTiYr0mb0FycdV/XBoJrMIc2Mxj0GhBDM8cHbh1nTUv
         gp62Hl3Y7Htf7UpR/JLR8wu3eQ1FG984Ai3AyTjjoAnT1FiyGDX8ho/X0ZHsIJnjtgx3
         6pmL+NrwBGML6LfNnOmi5bNXMh741gyHWKqPwdlw+ouOE1Isuoj5m5eBuJ0ocUrvTB6z
         dO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749744259; x=1750349059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZiHMBh3gNNtIzjgxE3TSs3lcaO800T3i7rHstZGDsX4=;
        b=QsMKwre/sH6b/sPkTwmG5IbjC+Wg55avWk9x1HdIYLL0El1PbJJSD+Y8G13SBjkwBo
         NbVmJZKBVYIaMIfJ4MyT+IltJaeS7BMq8SnGJW2rz8pMoXDq3IzF5G1b85kS01XQLSNr
         QrduFF4UCDd+e6VVh7j0RbuzcLLJqMTDKEOsjnSdXohbeaAuc8d5oVYoNNUONqQ1gQHi
         HLIxdf0QTI1VwLysMZYsbgAqWP91IX74Ne05bVjdgQ4g5/D0nPcmJV1rUDxgpwWt3CVS
         Fya59ZBs+97P0P9mQdwgMSRFDESs8IPx0+qbaNvnCpShapSjdTVsUdwrj6a9dUeiPdLL
         4HOQ==
X-Gm-Message-State: AOJu0YwKgKkdzp5d8hGECiy19Xw38uTc4ByX4AtkV0vx0vVokaDzxfvu
	Ja+AYSRcBkOy40871P6T1ErivVkk+k8Op38SU9EmK4H78aajRFUGwCukpvFMFMoZmiwg3vlbhhd
	uPTchdrPCMthcxWbUXO3YfGAO24JT6JCVgz4P2snq
X-Gm-Gg: ASbGnctXoJ3t1ih27hNH7ECh3f7SMW4sYT/X8E0n1PznSWRMQXA0L92u3XvzOIG/Vu7
	f+faMkxgPxuiPYj44l/HHDXfYAepgjkht3Kn7wcBa1HhjVsSitrpGSJKOi5kJ+i5QCuGOJRsYP+
	8ezXogmmg8hhkfP9CN4dzSg3ba4Qpab73c+XIfXtYQ0io=
X-Google-Smtp-Source: AGHT+IGBmeRlQyjhEww0vvfSaxtBwvnloIHwg7pnyWap+vYBJ0XmswcjrGcbBWxz5tJt3ZMIvDryqXPXBQK35TIlXSs=
X-Received: by 2002:a05:690c:ec4:b0:710:f39f:a2bc with SMTP id
 00721157ae682-7114ec48eddmr57519157b3.8.1749744259248; Thu, 12 Jun 2025
 09:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611183234.10255-2-stephen.smalley.work@gmail.com>
 <CAHC9VhR5CZSHKo41C4PdXbeJ3OuZUQ3ue1cbk9kjkHA6thjH6A@mail.gmail.com>
 <CAEjxPJ7JAJ2aypxVyjw4KKAvGBvUVK6eCzbXF3Wd8huTSPiSFw@mail.gmail.com>
 <CAEjxPJ7YixhZOmHVq92EBVoXO5ZO9__YXhhyD7iAWMkQNV-xsA@mail.gmail.com>
 <CAHC9VhTunOdxp2v=27sAxTjQc558nwnQCT=86WR5TNP3ihSdfQ@mail.gmail.com>
 <CAEjxPJ4MS4S+O3vj+mMuKkCVx53hnt91=2ZNPiP4eY9fKDyO8Q@mail.gmail.com>
 <CAHC9VhQ88CSgJqJcwiysvPPGfqsYcvrmLm+gkh5po-Rda_P6zw@mail.gmail.com> <CAEjxPJ5kQWtgJ6ofNGCyUQgDf-v3fNKoevRtprNfeZK6JKWNNQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5kQWtgJ6ofNGCyUQgDf-v3fNKoevRtprNfeZK6JKWNNQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 12 Jun 2025 12:04:09 -0400
X-Gm-Features: AX0GCFusVSs2chn7Ju7zUvyR_UdXB18tfwzXIQkC0vFrjQUGVQZOi-o_hkihjaU
Message-ID: <CAHC9VhT4ZwZQ-spX8K-nQmDp_qRSmN0FrAcBsDZOiHpNHQN2Qw@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: invoke ip{6}tables-legacy
 when appropriate
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 10:19=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Jun 12, 2025 at 9:32=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, Jun 12, 2025 at 8:25=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Wed, Jun 11, 2025 at 4:43=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> >
> > ...
> >
> > > > I just ran the selinux-testsuite again on my Rawhide system and did=
n't
> > > > see any failures in the inet_socket tests ...
> > > >
> > > > % make test
> > > > ...
> > > > All tests successful.
> > > > Files=3D78, Tests=3D1427, 241 wallclock secs ( 0.35 usr  0.11 sys +=
  5.90 cusr 17.75
> > > > csys =3D 24.11 CPU)
> > > > Result: PASS
> > > >
> > > > The kernel-secnext testing doesn't show any failures either, althou=
gh
> > > > I likely applied the same fix to that test VM as well.
> > > >
> > > > https://groups.google.com/g/kernel-secnext/c/w-oPYY1-HLo
> > >
> > > $ sudo alternatives --set iptables /usr/bin/iptables-nft
> > > $ sudo make test
> > > ...
> > > inet_socket/tcp/test ........ 23/34 Warning: Extension tcp revision 0
> > > not supported, missing kernel module?
> > > Warning: Extension state revision 0 not supported, missing kernel mod=
ule?
> > > iptables v1.8.11 (nf_tables):  RULE_APPEND failed (No such file or
> > > directory): rule in chain INPUT
> > > Warning: Extension SECMARK revision 0 not supported, missing kernel m=
odule?
> > > <repeats for each invocation of iptables-nft>
> > > ...
> > > Result: FAIL
> > >
> > > $ sudo alternatives --set iptables /usr/bin/iptables-legacy
> > > $ sudo make test
> > > ...
> > > Result: PASS
> >
> > Odd.  I wonder if there is a kernel build/config difference?  Can you
> > try a kernel-secnext build?
> >
> > https://repo.paul-moore.com
>
> Is there a .config file I can grab from somewhere? Generally I just
> use the Fedora kernel config merged with the testsuite defconfig for
> testing, although sometimes I prune it via localmodconfig.

I don't manage the Kconfig separately, I have a patch that is applied
on top of the Rawhide build which adds a few items, but it isn't a
full .config file.

If you grab the RPM, you could extract the Kconfig as a file that is
normally installed under /boot, that would be a full .config.

--=20
paul-moore.com

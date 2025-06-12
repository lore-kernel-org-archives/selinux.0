Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4797D185E4A
	for <selinux@vger.kernel.org>; Thu, 12 Jun 2025 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737977; cv=none; b=QI32K5c/rolDCWM+ppyMHK26Kw3Jr2DchZP8LhZ5O9y9zf/HOJRMR/Fod7dLJZuv592FOMtkZBKoqafnuR1GwygzOwsEjUjgj93315vUwQfC5DIK/XXmWIjPHbUkelFCcNufjM5LgrCElLEwvjVp9DPun/r4c048pIfstI3i5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737977; c=relaxed/simple;
	bh=9b8nFpTOoQMgMapVmQo9KTlSTlZSdTMgKntakGtPWEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EaL44Jm6p9VxCSOQ3hoMCLh0EFV8Z9IYwuIlvnGgUKSBGU0VaxPM/IPPtPUkqeHrqd4iLVfjX1hYXq6Cv+Ke2abA+fdHq8Z5Btp/Qc0UihNP/zquRdnVqo4gkJhzHHBkKBAlrahrhR8L8SQ2AMPBxjWerNRThfhSo96DTTHlM1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXXmZDcP; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXXmZDcP"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so2060204b3a.0
        for <selinux@vger.kernel.org>; Thu, 12 Jun 2025 07:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749737974; x=1750342774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4L0qgwan5i0/x6OsY3z73EWpxQ4y1wYvvkrMneGIv0=;
        b=RXXmZDcPfULLk/9irQIqi1fDoRSdPQN1kRoukttdheQnbXxU0EEzrLusl9qflWjxRq
         5D6IAdqKoFRlN8nf4b/ptoE9MdJ9Lobl0N6J/7Sh0UiiKWRNfoRj0mmlZznu+AufKtTF
         m1oTmfup2gsBTwbrqpDf9hbRH0buwkRhYYE+D2WUPWKK++Uaz88ozvwCmQTXStPAnJlc
         7B44r5FihSbAvlZE3AE/3sq8E90M26d+bB42HCY5RR3NvvW1+NX6msvcz3t+IJuPpHIP
         NBMD9Eoo0wwzgYy+hl1fEbokRMhJJl2HOer7SH68fG9Q8mFuCI8W6ZPKcRAY/1s5SdBJ
         D3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749737974; x=1750342774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4L0qgwan5i0/x6OsY3z73EWpxQ4y1wYvvkrMneGIv0=;
        b=h5StaRWOjl/rSUmDM7rSHVN/M3KBMrpiJiLo88r7IUWbWh1H3wA+UqWMdQiBX5CtCC
         qqsrDsdY+spDUzEWbQbNkh4WpF2O3lmH+tBEmaMOUMjHH8R1vYR8WsoiEoBZcnTXmRke
         kQoeWbP1b6VBNXqkrITszR1SOmXNEaPu8cb6HAtujsq5FoF3kNla+TV2GVX/B2/YdK2M
         DhhKaLR5ZakpwZn+GQCoMwxZv5fTgudUvzZhoHb1VUMHfUCxrV35U5XrDFzFWCtQBDWu
         l7bh6iHAu2q3Yn6rMpawbv1hafYXkQjhbP7MnOMStzz8pjcD5ecsWDnXJh4jiLPk1NWP
         GdUQ==
X-Gm-Message-State: AOJu0YysoZw9PmvHr0gjM7GdTLv4Ep9q8NLAY7Xh8VSLteiwt+N/LAsj
	2chx5mvqsl85dOx2bmQ/H3XJf+gDNkVOllNsixxFAYkpo61URMT8cBxHIFV/HF2xQts//elD/Z/
	mJ7YanlP9ixey5BblU2TtiTO2+FBokZ7WlA==
X-Gm-Gg: ASbGncsnTFUkKanhD0AZqUmYw5KBYzTVSztNYP7abvOzJzb5K3mhCM10BCl5zwz28DB
	7m+bXGdsModLWT8W8q2flo/0vYZf0hlBTCANijSYNb00fWLbU5mD7LUPLLUI3+6TiL2NCEjZHil
	kZZsIiYBlVbhzU8B2ZElmf9CYkOJIKZZKAqOv0xqW+AQeAl61jshv69w==
X-Google-Smtp-Source: AGHT+IE1nOAcIzouseqv6blDCCaaaQ5yeMF247T0yIyKJjdVy/ETvQfzHqZ4DZaD9jBzP+3vlpJgIxAcX3JHwyvd/QE=
X-Received: by 2002:a05:6a21:9209:b0:215:dacf:5746 with SMTP id
 adf61e73a8af0-21f990d595bmr4919997637.19.1749737974244; Thu, 12 Jun 2025
 07:19:34 -0700 (PDT)
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
 <CAEjxPJ4MS4S+O3vj+mMuKkCVx53hnt91=2ZNPiP4eY9fKDyO8Q@mail.gmail.com> <CAHC9VhQ88CSgJqJcwiysvPPGfqsYcvrmLm+gkh5po-Rda_P6zw@mail.gmail.com>
In-Reply-To: <CAHC9VhQ88CSgJqJcwiysvPPGfqsYcvrmLm+gkh5po-Rda_P6zw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 12 Jun 2025 10:19:22 -0400
X-Gm-Features: AX0GCFu7a6_UJeGumorn0KvP1dB2v5YAMVhUkf65g4wlM_VLcLj_K73iAarpkh0
Message-ID: <CAEjxPJ5kQWtgJ6ofNGCyUQgDf-v3fNKoevRtprNfeZK6JKWNNQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: invoke ip{6}tables-legacy
 when appropriate
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 9:32=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Jun 12, 2025 at 8:25=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Jun 11, 2025 at 4:43=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
>
> ...
>
> > > I just ran the selinux-testsuite again on my Rawhide system and didn'=
t
> > > see any failures in the inet_socket tests ...
> > >
> > > % make test
> > > ...
> > > All tests successful.
> > > Files=3D78, Tests=3D1427, 241 wallclock secs ( 0.35 usr  0.11 sys +  =
5.90 cusr 17.75
> > > csys =3D 24.11 CPU)
> > > Result: PASS
> > >
> > > The kernel-secnext testing doesn't show any failures either, although
> > > I likely applied the same fix to that test VM as well.
> > >
> > > https://groups.google.com/g/kernel-secnext/c/w-oPYY1-HLo
> >
> > $ sudo alternatives --set iptables /usr/bin/iptables-nft
> > $ sudo make test
> > ...
> > inet_socket/tcp/test ........ 23/34 Warning: Extension tcp revision 0
> > not supported, missing kernel module?
> > Warning: Extension state revision 0 not supported, missing kernel modul=
e?
> > iptables v1.8.11 (nf_tables):  RULE_APPEND failed (No such file or
> > directory): rule in chain INPUT
> > Warning: Extension SECMARK revision 0 not supported, missing kernel mod=
ule?
> > <repeats for each invocation of iptables-nft>
> > ...
> > Result: FAIL
> >
> > $ sudo alternatives --set iptables /usr/bin/iptables-legacy
> > $ sudo make test
> > ...
> > Result: PASS
>
> Odd.  I wonder if there is a kernel build/config difference?  Can you
> try a kernel-secnext build?
>
> https://repo.paul-moore.com

Is there a .config file I can grab from somewhere? Generally I just
use the Fedora kernel config merged with the testsuite defconfig for
testing, although sometimes I prune it via localmodconfig.

Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CA723BD05
	for <selinux@vger.kernel.org>; Tue,  5 Aug 2025 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403472; cv=none; b=VanYXsNy/LM1+7PSZD12ndnKk1BZTsg13wq52BgKs1ruFe1a/sDlENzFSlKbUSdMIg8QJWcGBr5r0W9swAEH5inG1e/R4bbGzo8JtUQWgroCmtF/DiMxrDnwwkEe3yHv3mn8TdJ1zGeJgwmonL2Efk705q/pLQR5GEN1VVSXDOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403472; c=relaxed/simple;
	bh=QLokgKEwVvTJadidTJI4pxuBGBY7MrocvZMv3v2S1ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oaosRqAPQFfMwPrZmuHGgpWHCl1AUMGxSVza3whmmQApX+9kzr9AZJalvndPzTjdI8E5bYLN1So0EaRvUiYnwp8iesyK2cs8O+7NkiAdYXxgTY/fs3eKjUj3+IaJrUMcZNq9l4SgKBs60lOum+6RMUcPXjXTg90t0UdIO8KToSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYI3w6I9; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYI3w6I9"
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-55b8bf653dfso5784191e87.0
        for <selinux@vger.kernel.org>; Tue, 05 Aug 2025 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754403469; x=1755008269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BalBV17oOSTg3cSxsWFW7IV+9LQhfpAT6Cj/WX75Nrg=;
        b=eYI3w6I98fTl2XFSWzQrmL6Nu41BJQeuriZJTYPH4W5OxKwxOxZLiCe5qVf7TuhkXr
         ZnlsbAHurQ50Fm1T4CtV6SRG/OaQOC2+qrKe7OSyB8JfBfSd9W5F6G0m2OLPyIfQCUgE
         hYtRwqN+licVRFdiuG3vvp5KW8b1oo7lDARfWqdlprG31EUsVSsaedWskcvOPFb2Woew
         VZh6s/vTbV4OYIOPG2x/VBDKmS8pAc9b+POpDYQAR00w4uCwSXJ2WsqctynyuosACCER
         VJSLNSNQOXXawRTe630cnCGlBuOjDjxEZFcAFz1JuptI9oRP8t/QRfPTdDNxDNbhQSF8
         zvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754403469; x=1755008269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BalBV17oOSTg3cSxsWFW7IV+9LQhfpAT6Cj/WX75Nrg=;
        b=q1FdQ666wti2LKKxPeNR/6iRWBenGixZS4JhcrMR6zV7h5npQqEMb6m7E39lqD5StR
         h94YKPJA1xugD6b4/C4fmW7NEqXVOXA7y+eg839XycXyuSOhQy9EKzqVIT9lUEtdivOM
         wSo17S6LrFj0V6IV0AJHukGvM53VxLrpd+gJ4bzmd7ZWWuOo2oPl/YKe6grnGZEfIhEa
         2gbYO78Kujo0nooLxGk+fJsAfxUoMwFHqulCus/RkHyzuYJFWVXNRue4q5xZykxBWUtd
         oHhLdn5edb8FNeqEmvybSg9vIi9mU+6c9AzfXEQK0oQ6jQb3PgQT57n9u2pZRWoaoBsc
         N5Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWK6KVmVhuM+bc5n7tvlWd2X8dm9PXbVfkIMG8RSBiD+c2LXoK+k+YLiAx/cCxWLxaNy+R1Pl60@vger.kernel.org
X-Gm-Message-State: AOJu0YyPt1OIMxPJ0eqBgJhrHTzYBaZrS8cLl6TMWfkRlxKDWg24jK1n
	nOmm6+vrGmuu6F1llT1VuzZVkQywE+vck5KG9LWRyvQegx20P8I8H2EjjjjN9VDu4py27wn7H6F
	qmli9oeNJ1HeYCMXPjf+u0a0SSALJuRA=
X-Gm-Gg: ASbGncvKucfyG3F6IqHlGyrSeidDUDfuBsF+T0HTV0obBbH8sNmkgBi16EMQf1QNaY4
	ArCMf9IOA5L4a6MFz1AOr7q1910vzYPdHo0VoHXhPBNTxteG/3p8WgJwTIsPU0A5RcejxV+q/lG
	y4C5sjxiXFt63vxFdg6iYY6WA9iNAktZr+pYGXz9UFjhiPM73WhDW3OONTwSAizbB+Y5ElnuHb2
	RUCimRDXPuOSZw8lg==
X-Google-Smtp-Source: AGHT+IEfVbPObBNAbObMmPGkZsWWcZtFthlnEnVEuUvIDhAr+2pGmpoK/EOUsiljXV+SBLvv7RHCxkTE1vTiJMyytY0=
X-Received: by 2002:a05:6512:10cb:b0:553:cf7d:72a0 with SMTP id
 2adb3069b0e04-55b97a6604dmr3177443e87.5.1754403468536; Tue, 05 Aug 2025
 07:17:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801154637.143931-1-danieldurning.work@gmail.com>
 <CAEjxPJ799AYzKGMJr5vmcP+b_ikPncy-vwaKZudRMRokwyuXMQ@mail.gmail.com>
 <CAEjxPJ7d=LJ=Rxyiy6TpjEETVhkAkKxJci0Hog1v+55V8jvpdw@mail.gmail.com>
 <1986fe81af8.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <CAEjxPJ6wM2Jv6J7Vdmk8H4GYXGgoeQFqZfRK3EZkv=9MgOdAXQ@mail.gmail.com> <CAHC9VhSmgVM07r=ogDq69gxhVUSMvTh73h6db1dcYiX8XuTdBg@mail.gmail.com>
In-Reply-To: <CAHC9VhSmgVM07r=ogDq69gxhVUSMvTh73h6db1dcYiX8XuTdBg@mail.gmail.com>
From: Daniel Durning <danieldurning.work@gmail.com>
Date: Tue, 5 Aug 2025 10:17:37 -0400
X-Gm-Features: Ac12FXxfQttVCGcVAh53vslnyTFK2vX-_sWU8TouUf0Hc9XYcUY8e24RdfmsnYw
Message-ID: <CAKrb_fEe8UmSMXpv2qHNiSMxhJz-msztxeDqzp0n1MckY3BRSw@mail.gmail.com>
Subject: Re: [PATCH] selinux: implement bpf_token_cmd and bpf_token_capable hooks
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, ericsu@linux.microsoft.com, 
	selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 4:13=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Mon, Aug 4, 2025 at 8:18=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Eric - note that Daniel also posted a patch for the selinux-testsuite
> > to exercise these hooks and checks based on the Linux kernel self-test
> > for bpf tokens, see
> > https://lore.kernel.org/selinux/CAEjxPJ7DBDnZEFvgpe58K4B+4kZdOqUGMHvGC2=
vKt-4Zget=3DHg@mail.gmail.com/T/#t
>
> FWIW, I believe Eric has some basic tests too, although I will admit
> to losing track of that aspect, as we have had several months of
> setbacks lately due to package building, email, etc.
>
> > Paul - it would be good to avoid such duplication of effort in the
> > future, maybe we should be tracking such things in the GitHub project?
>
> Yes, it's unfortunate when we see duplicated work, but thankfully it
> happens very rarely in our case.  We can track things on GitHub, but
> with development happening largely on the mailing list I'm skeptical
> about how successful that will end up being.  Our GH related efforts
> have been very mixed thus far.  Another option might simply be to tell
> people to announce a development effort on the mailing list, although
> I can see that having problems too.
>
> If there are some positives, it may be that both Daniel and Eric's
> work are still in the early stages, so there is likely room for the
> two of them to cooperate together on a solution.  Daniel, Eric, what
> do you think about that?

I would be happy to work with Eric on a solution. Looking forward to
seeing his patch once it gets posted.

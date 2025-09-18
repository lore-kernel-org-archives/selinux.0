Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7634D515
	for <selinux@vger.kernel.org>; Thu, 18 Sep 2025 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203050; cv=none; b=oDf3tmX9Ad4rBtcPjmAPZuexFyxVxT28kxqlSCT7qhOU/Z4VDo1zi5iDrWXnpbzpjOVvwf7A/JIj50bKX/RMJZHTOpt+vZ+EdbEymU++x7Ff6rtYZm1q8ghsAuyTpzLTFsZQqa/eF/nl9YxrI3gSxiW6K5wZSx1sWPoyZxlYczk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203050; c=relaxed/simple;
	bh=jJ/nH3R4vfm5UynRdZRlZBhvErbMnDhmhvStz9GLd2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFfjQk6Z/NnsOrlV1oyuW4RwP5lp47bPJ2DaU7mcFZQaJKKjhcyR6tUHmhFYoBRGJhIBvDQ2j6PFqHid1R3+Q+ORO4+U8baKS/Ffg+fb/5DGV37+SyAS3/eqLqV2/y6RASByC9fJkJrE2Hyp+SwyboUEAngeRXHjgGKeQ+OwY6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5aNDfGx; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5aNDfGx"
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-5688ac2f39dso1233417e87.3
        for <selinux@vger.kernel.org>; Thu, 18 Sep 2025 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758203047; x=1758807847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSf4rnEwm4KFPzcxqKTv8DvMEOR3211BztR9VjYPt78=;
        b=F5aNDfGxU0Zg4gHexuZK5LbHEuRNgVXJXuYwMSfvNmcI3upL500qG0ChPX3RsEh4aU
         3ZRKDB1+aPYzzJHIbdP5oX9d2moKAGniH7YKIEAYy9TwMKK3WOct7xqxeRPOwu5sb+XH
         7DEbBFuVDz7BETWcA7cUbbysXq5WEkwO6B5CM4iLENjB1sZ60aUqtWd7m+EcH5V/2BIK
         bru7iG4L812Ztk5qf3HMoYi4Eu5aOZZd/SJgFiAslK6UaQQIRFCMh/mHAZl6Vov3r2pB
         VZsod3CiwFiLi/nI2O9xg15mmMClx+SVJN7qKnRq+Iw99UCi2hBy9pxsDyZki0WVjgQT
         piZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758203047; x=1758807847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSf4rnEwm4KFPzcxqKTv8DvMEOR3211BztR9VjYPt78=;
        b=qt6y6eZkyshXhAjoS6a7IofyH7K91rB38V6CABVDmr7RoORZ35Z7v881qHw1lPqyVF
         I6faApLuoHEl0AxdQTZyqPbr5544s3Dr/JQbo93P65iNHKuXk6rSb0eLHelkFwrIDxNR
         gKnUxejhYl+BCp0OuufrktHGmDKxbPf8BoF5aOaNlUPyd1JQ6ctAdpgE7//EXgdPwYfM
         OyuPnWswuRgbsab1+bBOKTNC5wr/9LeQnQSmYOwvw1iJtp968PF2p4+2YMMB9+TU8XaM
         x0AM47PmqH4/nadYbdqMZ0L9Q1rcE4VgUpdOogsFPTAaWMPPvPH7FvcihD+uYYrL3YRu
         lyUA==
X-Forwarded-Encrypted: i=1; AJvYcCU+Gr3O6tVmyt0wXsPIt3wYAiSnUbdW+EuAc5tBYkxWhI8Yqubvd7uW6Zwb9zF4yX76TXFx6NyB@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/OWgOEUafscfbQgKYpNh7Ky11iYHfdstHYU889uoWl32JXZZ
	Nz4ND7UmVEVdWYFvyFIhHkNAh4QnYGZk4oXd9az1EfvcOVI4+3J+nfLpqsG2mScWFnZ82iKAHqh
	AM7R4qJYlwUZhGlJdmTUaycriZxHtEKk=
X-Gm-Gg: ASbGnctiuUiP7AQHXSROpvAMtt6w6zPHK/3YHluWDp9/QOsf5VSe4LDI8RfX/sUpsLb
	lE3vUB/GosZ6X3d88+SCxbVyuKhl7F8zBUXkM1f3xQ+azcOaGpp7C7SNv6684UxQoDfoUMFZeMd
	hfO9nQEHZqJ2vL8yUrbYkDCh0MrTEZO4ZtSsJETUO32ht3aY9CGvdWGDMkcKpoR0x9BxrKmDcN+
	qFlQU/wu4xEaLMFgWX722VL/39PsEJ2nLci
X-Google-Smtp-Source: AGHT+IFFosJQo2zlquk5veQTe8Tiy08ynnmEezsX5ireFY9GX3Q4lJrmzdQhbR82ROx+yUwkBaenv4S0TZ5SmllYKGg=
X-Received: by 2002:a05:6512:159f:b0:579:8bbb:d628 with SMTP id
 2adb3069b0e04-5798bbbde46mr318496e87.7.1758203046564; Thu, 18 Sep 2025
 06:44:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915175456.1991-1-ericsu@linux.microsoft.com> <CAEjxPJ5OgpfxiMrCVEn52P_-QPPAOn4rW2GA9XTP3JwP8UHArg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5OgpfxiMrCVEn52P_-QPPAOn4rW2GA9XTP3JwP8UHArg@mail.gmail.com>
From: Daniel Durning <danieldurning.work@gmail.com>
Date: Thu, 18 Sep 2025 09:43:54 -0400
X-Gm-Features: AS18NWBQAlqnsxUxc3Awt2anx1ck67iTOMhCtAyxqZfplVCkGiUcJ52dV-nnGoE
Message-ID: <CAKrb_fF++MB07EXvtrp61vZXK0npM8gnur5gdD0h24LY4Lt2+A@mail.gmail.com>
Subject: Re: [PATCH testsuite v6] tests/bpf: Add tests for SELinux BPF token
 access control
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Eric Suen <ericsu@linux.microsoft.com>, selinux@vger.kernel.org, 
	paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 3:01=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Sep 15, 2025 at 1:55=E2=80=AFPM Eric Suen <ericsu@linux.microsoft=
.com> wrote:
> >
> > This patch adds new tests to verify the SELinux support for BPF token
> > access control, as introduced in the corresponding kernel patch:
> >   https://lore.kernel.org/selinux/20250816201420.197-1-ericsu@linux.mic=
rosoft.com/
> >
> > Note that new tests require changes in libsepol which is covered in
> >   https://lore.kernel.org/selinux/20250808183506.665-1-ericsu@linux.mic=
rosoft.com/
> >
> > Four new tests are added to cover both positive and negative scenarios,
> > ensuring that the SELinux policy enforcement on BPF token usage behaves
> > as expected.
> >   - Successful map_create and prog_load when SELinux permissions are
> >     granted.
> >   - Enforcement of SELinux policy restrictions when access is denied.
> >
> > For testing purposes, you can update the base policy by manually
> > modifying your base module and tweaking /usr/share/selinux/devel as
> > follows:
> >   sudo semodule -c -E base
> >   sudo sed -i.orig "s/map_create/map_create map_create_as/" base.cil
> >   sudo sed -i "s/prog_load/prog_load prog_load_as/" base.cil
> >   sudo semodule -i base.cil
> >   echo "(policycap bpf_token_perms)" > bpf_token_perms.cil
> >   sudo semodule -i bpf_token_perms.cil
> >   sudo cp /usr/share/selinux/devel/include/support/all_perms.spt \
> >       /usr/share/selinux/devel/include/support/all_perms.spt.orig
> >   sudo sed -i "s/map_create/map_create map_create_as/" \
> >       /usr/share/selinux/devel/include/support/all_perms.spt
> >   sudo sed -i "s/prog_load/prog_load prog_load_as/" \
> >       /usr/share/selinux/devel/include/support/all_perms.spt
> >
> > When finished testing, you can semodule -r base bpf_token_perms to
> > undo the two module changes and restore your all_perms.spt file from
> > the saved .orig file.
> >
> > Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> > Tested-by: Daniel Durning <danieldurning.work@gmail.com>
> > Reviewed-by: Daniel Durning <danieldurning.work@gmail.com>
>
> You aren't supposed to keep Acked-by, Tested-by, or Reviewed-by lines
> from others if you make any changes to the patch itself since they
> haven't necessarily reviewed or tested the updated version of the
> patch. That said, would recommend waiting and seeing if Daniel
> re-affirms his tags for you rather than re-submitting without them.

Everything still looks fine to me, so my tags can stay.

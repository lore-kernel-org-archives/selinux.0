Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F4B233923
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 01:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779931727; cv=pass; b=JUPUTh8NV1zhoy7aSKMzP3pbiUZf76sZ5zux3dJZmmR8zP9XKHxQz7t3OMblELrL3un4bB8wYE/zr2XdHUqV6QPtxn9G8gh8HX3WkGTW/YGOXJH5P6Z+6IQ35NjeHfD43Tn3N9tCq1u/Xr5pvOdBsiSL+fA+tIE40Dr3n13BgEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779931727; c=relaxed/simple;
	bh=RY6aBJt2G6CcchtMq3LK5zA/ft61g6jdsDU7al94cOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZsQlxAWaqaRSFeiixV9PbmqGlDcisZd4JFmJRBnvBwRCnN2sJypykJfTy9wg7JZNy/SVZpaM2lD999ZqeyNxDPgLLJ1H1h7orLo0J+iNFei9Wfgd0l1tOf1qixJTOFjv9KJSx7Zz+xUqEB9MKojbN7WFAo7qt4ApC671o7jXBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CtgfUc+v; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CtgfUc+v"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50e61648f10so1861cf.1
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 18:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779931725; cv=none;
        d=google.com; s=arc-20240605;
        b=fE+7tuzJLBQgYKaW0mxMrRVdZ44Zz30Z2Lvo1d8pKGqOocwbtu3fbQ0uuEhTBV9Z4N
         0cgq6fzOSDD/nkAJhtWPlozooUbakkFXPNs55YSxYTe6+hW4T7lkDMqXClM13Rnt1HRs
         WmV+W15VB8NgloGML6HQkkRaFyI0PJsEGl9MYpstT7aD7LcFA0pkDcgUXsGiYr7pQEE4
         4I7OxyiTwEqm8UijQoSd2WFwk4uxZnMPpeFo0XYQzhEg9Inmxa8WoClEF1uBGwopSe6p
         XasNDmBRMIpbP4/WRae/Z2RsHlXwmneTGYPj4EZZwChgds2HLRVQFyFGUWDftc/W+ufD
         5Gjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RY6aBJt2G6CcchtMq3LK5zA/ft61g6jdsDU7al94cOo=;
        fh=51eq6nW+1NP0Dc6N2ksHVmT1b4IvEmyIQu+KBQeAYDQ=;
        b=MoG1GUFEQlACJNalWeYeL8Gy8oN5LdzyuacegwUknPXdAIV1N4jwQSfdBHJBIEe31G
         ay3TQLn6tHmRg/nTGoAcwrRkSCSgQM/AZLfDI6SIJotcfCzmvSZTrfP/Q/7uqEFHxvUW
         OQ/YLPGjJhydoo5IGpq8pGFFteJRsw7DEg7slkCWxc1y8mWPQOKrAZMC/t+IsKSCmc9/
         POmwiSIkKbCQlGx8IwC2YoGM+Fbr3kg87zho/woVs9tJP0OZfrj/284nkAdxWv4f+UgT
         QOcQNDe8Nw5zaFA5BC1/cn33k6enPXnLNXFfXqPoqMQiOOIB4SHWZP77dXK0vi1ocXfC
         0wyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779931725; x=1780536525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RY6aBJt2G6CcchtMq3LK5zA/ft61g6jdsDU7al94cOo=;
        b=CtgfUc+vR5huNIf+8KMlDLbkXDIE7/cdFIcv11KOdr0pvBkwaj/WTP18nzSP1luJCr
         rbg9V0J+DmczCOsWD6pW74NGuDqrc5+SPBJzohhABxhW5Q76CyQk18UIVsdI+EBPmjRq
         TAAQ+zUDTzy+HM72Z8mMLd2SIkh5566H0izG+ynBMX/sJe7bm6eI2I2XdtPsqlJdBgc8
         24MR+NJCuO/DuCBY6GlOjj4VsYPFT6oHj1SPnTZIpM8JIAeoRPytfRlylB2GliJn4t9L
         /c1cHm/pkW22bNts4NvsDrjGW/HEKFMj3uldEeZCiTjmdppP80ehkVKMkTqLQkznd1T9
         iRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779931725; x=1780536525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RY6aBJt2G6CcchtMq3LK5zA/ft61g6jdsDU7al94cOo=;
        b=LIw74zHK7GUufErq8h77MMBgvN9AXLEUcq/iwdhs/XwJ9J327cWcoq8yUhhpmj/RK6
         tlgmMIm7Jda+tItiSdvSG1HhU5Fi9nsSh2tBKghI/3+Hr0ww1Q50P5dzIfvFm/UNravU
         nW8s9jWoYQ1c9l8bjLcquAnDQXmO7Fp66152+zRm9LkfY9yWkTePRLnxAqNKaKVLVRCm
         XSZS4qP598X/Ba7jEzoZrH4AMzJ9ZitZqZneIEUKjdeTYOYrAIDAQAH+Zx/Lq3bk48/f
         pGVPuBj5WH4ZiYTNzLUHa3V7qVKwBIVXaACrapnJrPqkE6xDW51phbMdteIktxt33AF1
         tG1w==
X-Forwarded-Encrypted: i=1; AFNElJ9g+Hb/sNiN9reMwt3+cp9NV0Gso2/17mq3VEXRbuixGjQ4spbfMrghmJh6odbcwhZl3OkyZyP3@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgp80IlcY6P5wNg9OEtlq2URugfDGKaAGzJn1BNuhaEi32Cnhr
	9RzC68sDVl7g7aAjPh0h9CPuby9DaiEd/s+zo67990PbT/4valEyJhvjjsqs+xiAjxnKMjCysKi
	PweHjuANxOs+qGdQ6UDTG3d3v7cakZaxHA1oLMF+q
X-Gm-Gg: Acq92OGKhrqyCxWDC6zLqScHmMd7fNaaX+/Zj1uSmj3bgzAitchbKS6d/aM7mvN1UgE
	df93b7Mm0m6QgsfdNv/jX8NyOsqgZv/Nsu9offJZvNEmKKTq4bAnUYgm2zEk3vD0acwVTg70Tcp
	QwkrMpI7E0/ovs9Td7G8v8wLDGc6KBmB7m1Yn1hhMUYBoBXlzELJcFJY0vhyzrav50EopZyWrBE
	Rij3VkAnxnO+AVPSUDH2Mz80EY1oGzPUR6JpjK3jZr6KQ0B2Qcnf3CI0yxPhhsh5BIrNZH1Hm0t
	XTfAjvwzP2a6pWCbC2O8zMW7KM+MhRZ6apeUnhbHvd2A6feSQh7PsYuL3AgFZirZGFMaHJQWLr8
	rDg==
X-Received: by 2002:a05:622a:4e0d:b0:509:174d:3224 with SMTP id
 d75a77b69052e-51720c44557mr544041cf.11.1779931724086; Wed, 27 May 2026
 18:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4bb+sBUPPVYbwkay7w6k1NJx_6adiLVbHnYa5vjb5SUA@mail.gmail.com>
 <CAEjxPJ5OLy3NVut1PW_vAVwR+qUBTv+oq2Ngt3R_Rk=Hx2FgXw@mail.gmail.com>
 <87mrxmnrz5.fsf@redhat.com> <CAEjxPJ7y-q=sFpd51ci5OvH9Qvf5-jx-7oTWOrrrhKSvF2YMng@mail.gmail.com>
In-Reply-To: <CAEjxPJ7y-q=sFpd51ci5OvH9Qvf5-jx-7oTWOrrrhKSvF2YMng@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Thu, 28 May 2026 11:28:25 +1000
X-Gm-Features: AVHnY4KXqBXAUyL_LGzQiUCL5pJfy7dxcCuvMN99iqfCP8dg7ogCvDxS6CFBUuU
Message-ID: <CA+zpnLfiKSYh4eupRRK5T=ES4jNHAWHSZHZQFkmHoBxqz+5pug@mail.gmail.com>
Subject: Re: Minimum kernel version for SELinux userspace
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Petr Lautrbach <plautrba@redhat.com>, SElinux list <selinux@vger.kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	James Carter <jwcart2@gmail.com>, Jason Zaman <perfinion@gentoo.org>, 
	Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 5:48=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, May 26, 2026 at 10:52=E2=80=AFAM Petr Lautrbach <plautrba@redhat.=
com> wrote:
> >
> > Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> >
> > > On Thu, May 21, 2026 at 3:33=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > >>
> > >> There are newer kernel APIs we could leverage to further improve the
> > >> SELinux userspace, but doing so would require setting a minimum kern=
el
> > >> version for new SELinux userspace releases. Not sure we've done that
> > >> previously.
> > >>
> > >> In particular, I'd like to be able to use some or all of the followi=
ng:
> > >> open_tree() + move_mount(): v5.2
> > >> openat2(RESOLVE_*): v5.6
> > >> mount_setattr(): v5.12
> > >>
> > >> The question is what if any of these can we assume to be the minimum
> > >> kernel version going forward?
> > >> - kernel.org LTS kernels span 5.10 through 6.18 currently.
> > >> - Android common kernels track LTS kernels.
> > >> - RHEL 9 kernel was 5.14-based.
> > >> - Ubuntu 22.04 kernel was 5.15-based.
> > >> - Debian 12 kernel was 6.1-based.
> > >>
> > >> I would guess we could set the minimum kernel version to v5.12 and u=
se
> > >> all of these interfaces, at least in code not used by Android.
> > >> Thoughts?
> > >
> > > As further context, I'm only looking at open_tree(), move_mount(), an=
d
> > > mount_setattr() for sandbox/seunshare.c and at openat2(RESOLVE_*) for
> > > sandbox/seunshare.c, restorecond/watch.c, and
> > > libselinux/src/selinux_restorecon.c. None of these are used today by
> > > Android AFAIK, although selinux_restorecon() was based on
> > > selinux_android_restorecon() and might be re-unified with it some day=
.
> > >
> > > It would likely also be helpful to understand whether it is worth
> > > further rewriting of sandbox/seunshare.c or if it is likely to be
> > > obsoleted/replaced in the near term.
> >
> > We don't have any specific plan other than support it in existing
> > version for release RHELs
> >
> > For future, I'd say that using bwrap could make things much easier.
> > And I would not mind to move sandbox out of SELinuxProject/selinux to i=
ts
> > own repository like SELinuxProject/sandbox.
>
> Ok, do you have an opinion on setting a minimum kernel version for
> future SELinux userspace releases (not 3.11, but say 3.12 and later)
> so we can start using some or all of these interfaces without
> requiring backward-compatibility fallbacks?
>

The most up-to-date documentation for this discussion is the
compatibility matrix [1]. It matches the kernel versions we support to
their Android versions. Since we only pull in the latest libselinux
for the latest Android version, you can focus on the top row. As you
mentioned, this aligns with the LTS versions. Currently, Android 17
will be the last release to support 5.10. The next version will be
5.15.

To your question, it depends when you expect 3.12 to be released. 5.15
would be a safe bet right now.

[1] https://source.android.com/docs/core/architecture/kernel/android-common=
#compatibility-matrix

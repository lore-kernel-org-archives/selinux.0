Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D853375C0
	for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036415; cv=none; b=fFwRFNZM1YYQMmVTaf2d+p3iGEq86i55zdoZDLz+ewiR1pmBQNMPrQ1za5q5qs1Adgg13/Po6DdE3XD5M3FlOfyxGMq3R/2AZLj6dvAY1vDZQtnMUTxGPKhrDyTlc0n//jgbsDevx8Nyo8YD0wPCyCHTM2JtVFrV1pnkZPOXgHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036415; c=relaxed/simple;
	bh=Noq6g2x6GF3ios5lNzKv7l1qQ14O4NrJfERhAA5BjKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuYyTw2bymlLV9Vx/oQOVaJbBA9c/lCm7iGJGM2L0JBBL8pIVbhJ3bhs427CpF3dRMPVYqlgA9yRjEfw0ltfFOunCMQ2ILGTe2D3Mv8RtMkcVeF20XGJQTjGiDtbHlKAaYc61aXr91TCsW3OmSBwztjEpJPGi8LmvOQajKdWMnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VnJ0vCRi; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VnJ0vCRi"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-61ff7638f4eso2100583eaf.2
        for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 08:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758036412; x=1758641212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCQn1+qgmwmQoE79zxmLidjuTy26gWnilkFHndViNWU=;
        b=VnJ0vCRicTn3JgwZupH1IF0F5j+ZDy1FosuYOaWdUPj0E3Qg7bHCiXxWklf7XIVCrN
         AdiabKRXMBHBPwpBB5x5vdl2IbluezYrTGF5YfJ9YrEMdbErGe5EvorwDFHtxMFHZvkG
         VzagQ/fQLvblcS3BrybCDM8M+VKqgBRqAiAzAmT0ExXmMpPaM9oK82nIFIEsQrmjEyx5
         HfgZbqM0MKWhRWJRV8oX9FS0aWeDCU/drrIbtdf974ZIsXyB4d5b4+z2DJywTAafnWzZ
         T98uRhHrous5sp7XfQLLcwnIdhNIpicir7zE5LUMPpEjViO2SKdbaoUeidscdyBYq/Ah
         ioBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758036412; x=1758641212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCQn1+qgmwmQoE79zxmLidjuTy26gWnilkFHndViNWU=;
        b=kztKK3OwMqx3mPjgWzc+8vUy99ehBzRyKjI6CppgphMizrpoKuKStTigNnjnnZ2FX4
         p8kS7H1dvoByDXv85KZYR2N4OklESfNIhUOHwQc3cSOU1X87zw79+M5xLFzGlrx+pLnj
         vBY9jr5DD+YMHEJbQuEwYTSA8kJXx4a1W4SCqXPZ65SuBEqmVNq0ZR26SBQeoD4Eopjb
         w9fjjh5a+vkl28HxKxbePc+TveyeeBlZTszP8oSUMePTik4neErY7sRu9yR3lOZfFoB2
         yjWMaJRv750xqHggLv4lGtDbSYbhMHHsL/U8SOp+GSxJe6TqHuxGzSxHSmpKhfyvGEfq
         l+4A==
X-Forwarded-Encrypted: i=1; AJvYcCViOKVbrG0jUKAdFWF5Wc3z9GP42a+sE2Pbai54mZVKCn9SdHu912ivoRl1iOvHxkkRzOQhY4L/@vger.kernel.org
X-Gm-Message-State: AOJu0YxZHhLFLMFBlGkziLR415Thxu3/wjtftxPQBQmGPV8slrP+IdFu
	OfD0tRh2OsLBqOJnWku1UjCdHf4BwLkPi3imE0HN1XZ7S73JdbyzEgS6O78w/Z5Nt1GfJC7y/4v
	DlVEcl+wMqRCsxq3bruFbQRb+16TEdOhLWhQuixdg
X-Gm-Gg: ASbGncvNzUR+Kv1xG1obvZ4s+a59dGe+dNJ+HU3OYWIfahkDIIbSmkOzDHDQ+hsNEh2
	h42lJWc358zq/vbACkWMsEPY6bLUQ39JOSqGyx5KTqGM5KTJ7BNnT/LQUfsl/7HuzZVOSjSA5nb
	EqD2sV4M9bMqoVmhWEzDqKbIMaS1LtXPK14t6jFbMSaOMLWSLs/zP9CzvBpWfR25cAidjqskJjC
	uHg61M=
X-Google-Smtp-Source: AGHT+IEHQRX/QKtURM3ZBFKblim/ENLeZ5c+QD7UiDxNTE8WpHlGzNMOx/Q1hdBXqdyzU+cMTKCcGQ1RSf0ttX8oRA8=
X-Received: by 2002:a05:6870:70a7:b0:31d:8b26:f600 with SMTP id
 586e51a60fabf-32e54a8475emr6916168fac.20.1758036411638; Tue, 16 Sep 2025
 08:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826031824.1227551-1-tweek@google.com> <6afc91a9f5caef96b2ca335b6d143670@paul-moore.com>
 <92255d5e-7e0a-6ca3-3169-114ae7f6247f@google.com>
In-Reply-To: <92255d5e-7e0a-6ca3-3169-114ae7f6247f@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 16 Sep 2025 11:26:38 -0400
X-Gm-Features: AS18NWCuUiv9oyKOG1eHUS0O1Z1zJo100aKng26KHQ-sy3cd16UuRWkNtSHwhJw
Message-ID: <CAHC9VhQejS05C8AExkh32GidBdzXjauKPP6T_3eSGZDEwfwDuA@mail.gmail.com>
Subject: Re: [PATCH] memfd,selinux: call security_inode_init_security_anon
To: Hugh Dickins <hughd@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: James Morris <jmorris@namei.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 1:07=E2=80=AFAM Hugh Dickins <hughd@google.com> wro=
te:
> On Wed, 3 Sep 2025, Paul Moore wrote:
> > On Aug 25, 2025 "=3D?UTF-8?q?Thi=3DC3=3DA9baud=3D20Weksteen?=3D" <tweek=
@google.com> wrote:
> > >
> > > Prior to this change, no security hooks were called at the creation o=
f a
> > > memfd file. It means that, for SELinux as an example, it will receive
> > > the default type of the filesystem that backs the in-memory inode. In
> > > most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it wil=
l
> > > be hugetlbfs. Both can be considered implementation details of memfd.
> > >
> > > It also means that it is not possible to differentiate between a file
> > > coming from memfd_create and a file coming from a standard tmpfs moun=
t
> > > point.
> > >
> > > Additionally, no permission is validated at creation, which differs f=
rom
> > > the similar memfd_secret syscall.
> > >
> > > Call security_inode_init_security_anon during creation. This ensures
> > > that the file is setup similarly to other anonymous inodes. On SELinu=
x,
> > > it means that the file will receive the security context of its task.
> > >
> > > The ability to limit fexecve on memfd has been of interest to avoid
> > > potential pitfalls where /proc/self/exe or similar would be executed
> > > [1][2]. Reuse the "execute_no_trans" and "entrypoint" access vectors,
> > > similarly to the file class. These access vectors may not make sense =
for
> > > the existing "anon_inode" class. Therefore, define and assign a new
> > > class "memfd_file" to support such access vectors.
> > >
> > > Guard these changes behind a new policy capability named "memfd_class=
".
> > >
> > > [1] https://crbug.com/1305267
> > > [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@google=
.com/
> > >
> > > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

...

> > Hugh, Baolin, and shmem/mm folks, are you okay with the changes above? =
If
> > so it would be nice to get an ACK from one of you.
>
> So far as I can tell, seems okay to me:
> Acked-by: Hugh Dickins <hughd@google.com>
>
> If I'd responded earlier (sorry), I would have asked for it just to use
> &QSTR("[memfd]") directly in the call, rather than indirecting through
> unnecessary #define MEMFD_ANON_NAME "[memfd]"; never mind, that's all.
>
> Please do take this, along with the rest, through your security tree:
> mm.git contains no conflicting change to mm/memfd.c at present.

Thanks Hugh, it turns out we ended up having a discussion on the
SELinux side (proper return values for error conditions) and I'm going
to hold off on this until after the upcoming merge window to give time
for that discussion to run its course.  The good news is that gives
Thi=C3=A9baud an opportunity to do the qstr fixup you wanted.

Thi=C3=A9baud, are you okay with making the change Hugh has requested?

--=20
paul-moore.com

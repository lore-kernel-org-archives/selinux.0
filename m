Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871C244C7C
	for <selinux@vger.kernel.org>; Fri, 30 Aug 2024 06:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724999441; cv=none; b=Iu2CkiQsw4Ahs7PgHUyT4eyuLMICMaaj10xYdrSfux1aD6v7ihjvDBiVgE2dzrxT9qwylrjJhDGkJA+N1A4n/3twDXINpD/6axJUhwsh7XWzmzk1oR7IEjlc89ZlFe356oG1FzKzdhyKZPAj2KWW9jiRMKnmUxAXeiZuabXwBdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724999441; c=relaxed/simple;
	bh=mhPeM4HUqKLR3j8MFZDAUM336y4d6vtcV7wje3UDhF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASZ7dcDXdt+cHrVWAzPwUIvHuXUOOwFK3UF0XvNq2oCM/tzxjkhulfab9nzUI2jQ7qiYHJvRVji6qQoj8kexs8u7jTfVFsm8h+VGJ+aBuOGjyx6wjmO9e43n9NHM/ag9cjMN0QTieysl4PMTk+hA0WJoe2B8s90IyZamT38VbE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AeU3xJ7n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AeU3xJ7n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724999438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5SxP2Kk8WTBF0TTea1HtzOqv5hcJ8ko7siS3M9/8Kk=;
	b=AeU3xJ7nhJK02xo+jMWeVPHzcAVwpFH1fhEE1pv8oeGMCeyx3bwwU/hgaF9TuLwxcF9GxB
	5cGKvgI3i5flNAI4fOiDcxL7AKPJFbleBe2wXFskXZB8KAeYxMyfAheiwLAElEkT8NAYcL
	ohYixf/6CUU4m13qmYg4kBX3p+tN9L8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-1LJE9hoaPT-KSHgUkYOoGw-1; Fri, 30 Aug 2024 02:30:36 -0400
X-MC-Unique: 1LJE9hoaPT-KSHgUkYOoGw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d432914cc7so1420519a91.0
        for <selinux@vger.kernel.org>; Thu, 29 Aug 2024 23:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724999436; x=1725604236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5SxP2Kk8WTBF0TTea1HtzOqv5hcJ8ko7siS3M9/8Kk=;
        b=kEx/mGL7n4YevUW3g2fmafhgGidyuePfe3srozLN3lSCFSSHtudNilfhYtoEujG/L2
         eqqTiNPGPLoVzUzqgW6595L31UdcvP0yB/N8JOpsr/EP/Zk0j8hM4QQ/o4IBAP44CiWN
         zaIPkv98YQWKVJbrDJwkC6pR63c+6Ix0gwP+WNl9FBCwfL2hKeb//ag1ir8HeqC8M749
         ONZvLWdavvgnjsRGPP/BanvPUzGaKKqmKYv1M5S1N2YZZCe7RHdY9Bz4KaygxzKIOlE8
         +tWun2tJhcC6fGy8vcHRvz36z7og0ZNtA0vs7gp0zLN7teRZJgyJ2YZEF1jbLVr6+EUY
         3s8A==
X-Forwarded-Encrypted: i=1; AJvYcCUgNlHWghrXnahb2HQnIA7CWE0bqz+xIdZNG7YJEf/EpJ06n6V74ch3TEIOds4GjPA0NzZt7o4t@vger.kernel.org
X-Gm-Message-State: AOJu0YwSTTWcEETWDp/IHOV1PEVi6ICA5Ue7TmMutV5/szQ1OE4jrlNn
	8ucC2afUmXRAYn+9h7M1cv1UihA8BHxvpDYzPv7WcNvZmei7OgmKjtRPBDg3ow36V8Nem2wxPpF
	fKQLKpFqnNvkait5PxEW4BNskvKH3MOrJTAEA7pB0Ye7VHRjgXfV+4c52ep8rKGlgD6IYdr8pNT
	gDVKXuIuFZzEgwmzf2tSkXoMpRmB/JzA==
X-Received: by 2002:a17:90b:1c03:b0:2ab:8324:1b47 with SMTP id 98e67ed59e1d1-2d86b00d063mr2124937a91.15.1724999435635;
        Thu, 29 Aug 2024 23:30:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiIVQR2Y5ziLzNiuI4jVjKylBZI0Z98BRpNbarVUJZUN/NKKVFSPkEEOaHTRrsSY/fkpvZLSg4RhxNJVK2DdQ=
X-Received: by 2002:a17:90b:1c03:b0:2ab:8324:1b47 with SMTP id
 98e67ed59e1d1-2d86b00d063mr2124901a91.15.1724999435117; Thu, 29 Aug 2024
 23:30:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827145518.469490-1-omosnace@redhat.com> <CAEjxPJ5LXdzRXrLZH1FCJ31h6qCD6WFaUTkoaOyad5Qsdk8rMw@mail.gmail.com>
 <CAHC9VhQv=ZTEZfrthzGZLGVTpMKCFaAxGz12-+49WZ3o135q0A@mail.gmail.com> <CAFqZXNu19Rv9AoWikVVA3rSPHnQaZw=Wsvnw3EET2-J+=1L66Q@mail.gmail.com>
In-Reply-To: <CAFqZXNu19Rv9AoWikVVA3rSPHnQaZw=Wsvnw3EET2-J+=1L66Q@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 30 Aug 2024 08:30:24 +0200
Message-ID: <CAFqZXNvRy7HG2zVZn7wyYDHjvHR9Wa0meH20tw_wbUzH99QAMQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/key_socket: skip the test if
 CONFIG_NET_KEY is not enabled
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 8:23=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> On Thu, Aug 29, 2024 at 4:35=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Thu, Aug 29, 2024 at 9:37=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Tue, Aug 27, 2024 at 11:09=E2=80=AFAM Ondrej Mosnacek <omosnace@re=
dhat.com> wrote:
> > > >
> > > > RHEL/CentOS Stream 10+ and Fedora ELN will have CONFIG_NET_KEY disa=
bled
> > > > [1]. Make the test skip itself when it detects that PF_KEY is not
> > > > supported so that the testsuite can still pass out-of-the-box on th=
ese
> > > > platforms.
> > > >
> > > > [1] https://gitlab.com/cki-project/kernel-ark/-/commit/99d6d1c86fe1=
bb1df5c0b80f4717826c2330e291
> > > >
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > >
> > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > >
> > > Wondering if we should drop NET_KEY from the testsuite defconfig too =
then.
> >
> > If we have a test for it, it seems like it might be worthwhile keeping
> > it as long as the upstream kernel still supports PF_KEY.  I'm not sure
> > if Fedora plans to disable CONFIG_NET_KEY, but as of kernel
> > v6.11.0-0.rc5.20240827xxx CONFIG_NET_KEY is still enabled as a module.
> > Even if Fedora does disable it in their build I can enable it in my
> > testing, I already do that now for a few things.
>
> No, Fedora doesn't have any plans to disable it as far as I know.
> Fedora doesn't have any contractual obligation for maintenance and
> mostly just tracks the upstream kernel, so there is little motivation
> to disable functionality because of the lack of maintenance upstream.
> ("If it works, why risk breaking users? And if it doesn't, then
> upstream should be the one to remove it." seems to be the general
> philosophy in such cases.)
>
> I agree with keeping it in defconfig - after all, CONFIG_ANDROID=3Dy is
> also there, even though it isn't strictly required (and so are other
> configs).

Now applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/a9e631f0f1d5b117=
56a62679e8da073b3cc85b13

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


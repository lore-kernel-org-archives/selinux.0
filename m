Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7522E19CC0C
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 19:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759867170; cv=none; b=uza/2j3uZoRBs2c4jvfrQND1rCUwkV/BB88mdDJZPfYCWNmY8TV5N92+Aoj+TiU8B8gE2XkSrqQUF6Hp34ZJNtvx6O+IlX9G7gLjSJ3F+NI+utpbzO1FxKInWnz/e9sESMCWe5qF/tLqbSJk9OPdg+79aqEZ/d2cq2+xc9OkBZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759867170; c=relaxed/simple;
	bh=VNoBhWGf2z4MEJDad2V0PXqEjy0cAwrOlAXVqCZvA20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ba/gqOc7EpFRoyOChi6de3lwW0XenVDi58cxTFGXuivU3a463oJabKZmLZrttfEgmHCf0GF2qnowLABYYUsaoig+7ZV2nZxxIoNx/7poWed8sCMa+nccIBWNg7vw6Hu3+7/YRVF2M6tgfxn9/FeFGHcloMNk/VDgvAUAn2rVlYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VF9MHnZY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VF9MHnZY"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so8754781a91.1
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 12:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1759867168; x=1760471968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Otzliy8lh5JzyEXKACk7L39OCLat5c75iFSwzoBo2kI=;
        b=VF9MHnZYSnKFr/DaB/eeeFSuUwT+Uh2bFqGsfbblLIpIqSzida91hhfkMsTyysVyLO
         tIUKPsJ3iWjEoolt3Tebd1h7XdfU4Z21M70/ySUeslfiowvSF8FyGGYBD+K48EAK4wj8
         N9TnQ/qEvwenadVi+xdKQpDe0aKeX9Ao0xdrzba8H1D8dUtcRviYodGXwagaFr674VCz
         HJFTA7qZ9qWTs8fMpl/ugUekKfzJZz7JPZF/MXSmEJu8YPQrWFh5ROBsCRY6MaZ2MJMv
         j6yKoi8CoUuaJ3+kY4cWMaDXrWG4z3ksV6ynZtERBqCTPSEE50sAdvU0/Do3mwV69vnw
         8Hug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759867168; x=1760471968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Otzliy8lh5JzyEXKACk7L39OCLat5c75iFSwzoBo2kI=;
        b=FiX1JaiNasp9yDc8ZCj9CutfZ996ULXsS+tbkxNHfehVAcoS0Ph9K8wHesY5ef1LK1
         eL/isHB7MZyQ198IqiEPKF+N97gQcw+u8/KXBaSfPb2+Rw9Bwu4FOHeRARvqieF4LLPh
         k0peuYrnMA1T0eVESvG/QYwIznXJ+zVUix6tbEjPbq3W6vMmB0kjBnjMJEVpijih2DNF
         CmbbK1o1ZRDDBhqVCrituywJg6uuE16JknAXSUS4pdE+f0Ciq1g6RBMlKIMgCtfAUzKp
         TBKf0/mp7VZzhJIcno/k93B5pV6Vz2U7BZsQ1m6o9G6GVXWJj5a4J1ziNyv5IMqy1Lbb
         s3WQ==
X-Gm-Message-State: AOJu0YwrO02h/3ur6ut7+2JpuuHGkTGfglDAUqq8t5bmkxClAM4G31a7
	DDxSJndPWPWtx3i+kma/JVvJIZKrtl8t7uD9wZQa449BR9+PYFFdMo7dYYoTXqvJFqoRPBaLWKv
	w3fgeaw753KYTHA5oqVm71PIMpTOyoVixPr1MW3jtIwJyuJ9O2Dk=
X-Gm-Gg: ASbGncuDKCB6rC4vok6048UZa3VWCXEFb9pX4DiUoU4gYC0T2ecSn9Z67JZQyQFJ4nc
	05DS+bINckDbisjYaE+9dwzv3NrWkvbw5p2TbwJWbQpaFbx3alqzNCKaJwwHpw9Y6QnTAwIj9BE
	nDivm9rMY+E/WO6p5zWDFGrhvcolUJdy1/DSdW+RKakMbG0qsDITjZ+U08nlkVAiotiSmSZeNus
	4S1Tzr9pTQKbwMoDQj9jbvUB6nij7A=
X-Google-Smtp-Source: AGHT+IGWP0lCnj26KKQPCcXpLFLqUncYpwDHXidh3gCDa3Pqqym3X2V09iSQBZgd/50QPK4wq7c04NVXbVmgzX8/0j8=
X-Received: by 2002:a17:90b:1652:b0:32e:9281:7c7b with SMTP id
 98e67ed59e1d1-33b510f8404mr826165a91.3.1759867166745; Tue, 07 Oct 2025
 12:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007183552.74330-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ6gFMPFj-9im_EeencH2B4d6CfCa0TQs=5XZG4O7vBvew@mail.gmail.com>
 <CAEjxPJ6FtXxkqQEPUPMDkX+4aKV_u+oWzYRnnS9AUOOtEr_3eQ@mail.gmail.com>
 <CAHC9VhQ=Fegv_+_hZ=aBqgHLYmuT39JBZeY0+_JbsmgS4V5gCg@mail.gmail.com> <CAEjxPJ4pWWs9dDzWNV5h5+r9QOz8cXfArhvRR+zG6pxGi32oKQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4pWWs9dDzWNV5h5+r9QOz8cXfArhvRR+zG6pxGi32oKQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 Oct 2025 15:59:14 -0400
X-Gm-Features: AS18NWB99pnKowJoqQOx1XRx5MVB7RGXv0VywrezLZYfRfBwDLYg56C-SAokbLc
Message-ID: <CAHC9VhRKA6QFOYrhpVM_f7bNBX+wy5xmGa468X8DLLPs+3AGWQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux-testsuite: Add btrfs support for filesystem tests
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com, 
	Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 3:50=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Oct 7, 2025 at 3:33=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Oct 7, 2025 at 3:14=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Tue, Oct 7, 2025 at 2:46=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > On Tue, Oct 7, 2025 at 2:37=E2=80=AFPM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:

...

> > > > > diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Fi=
lesystem.pm
> > > > > index f169464..7ea9031 100644
> > > > > --- a/tests/filesystem/Filesystem.pm
> > > > > +++ b/tests/filesystem/Filesystem.pm
> > > > > @@ -123,6 +123,9 @@ sub attach_dev {
> > > > >  sub make_fs {
> > > > >      my ( $mk_type, $mk_dev, $mk_dir, $mk_opts ) =3D @_;
> > > > >      my $mk_size =3D 16;
> > > > > +    if ( $mk_type eq "btrfs" ) {
> > > > > +        $mk_size =3D 300;
> > >
> > > Looks like I could drop this down to 109 if we care. 109M =3D=3D 1142=
94784
> > > bytes is the smallest supported size reported by mkfs.btrfs. I don't
> > > know how stable that value remains across different versions or how i=
t
> > > was derived.
> >
> > I'd be worried about tests failing at some point in the future if they
> > are running right at the limit.  Did you find 300 to be problematic in
> > some way, e.g. excessively slow?
>
> No, it wasn't excessively slow as far as I noticed - no more so than usua=
l.
> 300M is the min size for xfs so I just reused it here.

As long as it's not a problem, I've got no real preference.  If there
is some way to simplify the test code by adopting a common lowest
acceptable fs fize that would probably be worthwhile, but I wouldn't
bother too much with that.

Ultimately this is up to Ondrej if/when he sees this patch again.

> > Assuming the exact number is arbitrary, as long as the minimum is met,
> > we could always make it a little smaller while keeping it to a power
> > of two, e.g. 128.
>
> Yep, can make it that too if desired.

--=20
paul-moore.com

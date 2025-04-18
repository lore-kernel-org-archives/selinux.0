Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D722F208A7
	for <selinux@vger.kernel.org>; Fri, 18 Apr 2025 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745003137; cv=none; b=fOOAMGCalJUYSallrFcuYjtJxiR0SJ9gQwfbchLOjyPpxxdSsczsUW+yKQbImuPd/6fdCt3RDWaMjLT/SJoPiU4heSuL2JodxXMAkV9h03ACbkX4i/8Z5VaQNWpMKmazNWbftLVLSqVX042GX677yWEU2lR5P+0PS027baOTET0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745003137; c=relaxed/simple;
	bh=SGVaIaioD63LiIubYgHndhQdnCbmBS1yrLmgcdsKziY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBQak6e/BprK1PiVx3NQZW/6ltIdNEaup6Corq8p1Su3iLFCJXzkOjTfb4VcObnpOOSX7qRq2DZbjQMUVRX6wa18aAWLH2mTcKO7tF6GybjxTUnjbykeM0g5KQyD+S17EAGffivTYOjd1XADA/0o8W/sEVPvFDMM7yniUyL+v4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtyBcsTI; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtyBcsTI"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5a88b34a6so205932885a.3
        for <selinux@vger.kernel.org>; Fri, 18 Apr 2025 12:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745003135; x=1745607935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj43Ih/12D+a+qWanbRJfTqhv9lsAkpvQb/ZAzZC7rU=;
        b=DtyBcsTI54duASKihIWsAa4afXewfGWqctjHIZ9k3XXCHLauQmK+5mVQEmSd9oAViN
         MVTuaBMBDv7lYKzux3dQbQzJe/Qlo9OO0OWxP0LVRh0vov1Ck3r6qEnMSF+CXCXxp1vS
         mZDMg0rQjoHm/rMrbJqaIkC5wHaGAkBI5IoWtNYyrFKeay3DDr8nRjoLSXRnVIkL1erd
         978Jwb/fJkjtZvZYZxGX5bdZT5ldhZrwJuG9KmwoympeQ19sdqw9BkrwhEqqVcx2xLOV
         lHDQAAxHrwlehAEqeZX6/IJ7tIkIf+FspIzOFrktiUZCyMKmF/DZkE/OUyIBWaHXzhx4
         20EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745003135; x=1745607935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sj43Ih/12D+a+qWanbRJfTqhv9lsAkpvQb/ZAzZC7rU=;
        b=enqa3+ykIOnw/AqjKsZ5BM8JKzKGeS9P+OXM/6CNWdOZ7UGyoJYzH/4JTELSagqKt5
         Bl79tlPG17W4GNYZSKfB7kSrCaFNt45U0hGcSu+KIDGHtbLUOjHc8AinIyFiDLpN6sla
         bfy8bJ0LIvnoYJTepUwFBJKAWZgPZQJk8vdIxwJCGJUb53GWInjWC6Iavpg7eY/R4i3r
         9tTWzFsk6tn8OkAqdeBWIHInNDVtSNhXs665k9RpvMw2awl8K9C75pH38NTVA3/2Uu9M
         ue3Ep4vLF9uMWK8wMLKaDWYVQXZGxHXw8ZIyTPVRIDcsVhZrX2ouQgqKC4LbmhBrejnc
         GfkA==
X-Forwarded-Encrypted: i=1; AJvYcCWDh0WKFXWJ9msOPXYHLWn6iec81m3cMu5KonFNt9V/gFs+cBJ7xisfjqPLd8ZdULm9qGCzg7MQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzLG4woMYYe5E0zyFHec4rJCsdloH+c1rkIrHZefE1rr7KK9xC5
	ExS8UujeO38FgmXLLEKeIIspz0SiOm0HK9BOhVYj4XVcRFYO1KnYmErr4nONA17fSHLD+UdZaZ2
	hQ+JXqJafAtcZdufP9tiXjml4fPM=
X-Gm-Gg: ASbGncvOlDCF77i2BblsoUsmFtUW4MaX0zMCnzyr+nSyBUQdd549NUp1heUW0tE/oxo
	qZ+F6BZ262WfIqga7OFuGij6m4zUClr6XJwVTpOdrLRX1P2uEfzqmyffsoG1QuTiq0MdyKb0XDH
	Kt7lWKWlS4U4kHMxOSKNs=
X-Google-Smtp-Source: AGHT+IGlAt+66rg7ozrj8oZpfsPPDFS8hZ+IjTFcwD23BB+XDhCpuf1uaWjigLEqkadaK3q0eUZhk9r/pnEh0rzsvhY=
X-Received: by 2002:a05:620a:4711:b0:7c5:7a1f:4d89 with SMTP id
 af79cd13be357-7c92804d553mr716204885a.54.1745003134647; Fri, 18 Apr 2025
 12:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878qnzzxi8.fsf@redhat.com> <CAJ2a_Dd0zcqbGT7K=G=8zNkatKKWsegEkEjvadgJcqudNgdxDg@mail.gmail.com>
In-Reply-To: <CAJ2a_Dd0zcqbGT7K=G=8zNkatKKWsegEkEjvadgJcqudNgdxDg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 18 Apr 2025 15:05:23 -0400
X-Gm-Features: ATxdqUHoW0WYaLA2aZm02QmMVywllJxtLwfzjKrtJu6nTQJ4SXrRKzjt7HtUqtw
Message-ID: <CAP+JOzQt9EEomdaZbZcah0S9bUYrhpbEv0ioXSVUa0bg55382Q@mail.gmail.com>
Subject: Re: Regression in selabel_lookup after "rework selabel_file database"
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 3:36=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Wed, 16 Apr 2025 at 22:01, Petr Lautrbach <lautrbach@redhat.com> wrote=
:
> >
> > Hi,
> >
> > we have a report [1] that in specific cases local fcontext modification=
s
> > are not considered or correctly resolved in `selabel_lookup`:
> >
> >     [root@default-0 selinux]# matchpathcon /usr/bin/cloud-init
> >     /usr/bin/cloud-init     system_u:object_r:cloud_init_exec_t:s0
> >     [root@default-0 selinux]# semanage fcontext -a -t bin_t /usr/bin/cl=
oud-init
> >     [root@default-0 selinux]# semanage fcontext -l -C
> >     SELinux fcontext                                   type            =
   Context
> >
> >     /usr/bin/cloud-init                                all files       =
   system_u:object_r:bin_t:s0
> >     [root@default-0 selinux]# matchpathcon /usr/bin/cloud-init
> >     /usr/bin/cloud-init     system_u:object_r:cloud_init_exec_t:s0
> >
> >
> > The bad commit seems to be 92306daf5219e73f6 ("libselinux: rework selab=
el_file(5) database")
>
> Should be resolved by
> https://lore.kernel.org/selinux/20250417190812.41263-1-cgoettsche@seltend=
oof.de/T/#u
>
> Note that depending on the original file context defintion in order to
> take priority one might need to specify the file type (i.e. add the
> semanage arguments `-f f`).
>

No, it should work like it did before.

After testing, it seems like the bug only occurs when neither the path
in the policy nor the path in the fcontext has a regex in it. If
either, or both do, then it works as expected.

Jim

> > Please take a look.
> >
> > [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D2360183
> >
> > Thanks,
> >
> > Petr
> >
>

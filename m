Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5011D3650
	for <selinux@vger.kernel.org>; Fri,  6 Sep 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639790; cv=none; b=Q//6ImJwfEQtEPaxu4fohIQtWsKarTW5Yror0r1XgiqqHo3BZwpAJWmiecKlIurMtz9Jva+xdUSy1h2Hk6Cp2yKQpbQsEpP5Og9h/ShvUFHoo9O+g/DLjGTu9KtMTtX84W8zwp/hnHHv7vDjh/EWvamgXMlNf5inxTWGoEcSlYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639790; c=relaxed/simple;
	bh=40noikkgwgjvZu0egu485IE5IdMG5DgP4k2kBd9w9dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOc9SK3Ni2PGgr4vtMbweS2qBU5jSwKkTcIjJ2ieGhydDQsr99QFQDtlJolJ5FyBHHU0b7iJK1wfeiyyZwnnAiGccss5fmo2rV3brk8gZYDkTjcDHBSHRB/U8rgrEIrYFBe3BQhKzc00cu4Yp0P7QseJRWHwonFGXjztlZw3Bu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XfBVfar5; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XfBVfar5"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so2592642276.2
        for <selinux@vger.kernel.org>; Fri, 06 Sep 2024 09:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725639788; x=1726244588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKmJdeK5l8HCJZ+0iG3dq8C9nlCLW1c2QlS0zqdSjSM=;
        b=XfBVfar5p0EhLAtGYenITvpg/0VgN8ICxuyFbSsKbCQ9cWRnWwpzIDQMCGew9LCqOP
         7WKiLQn0Cinq2NKGrSVOypwtswMsVLu5vWeDhnRgxfEvr5tXSwHl/kiwqs8n66toei1m
         Os24bmrSnoRjmQ4IcC5LFNgLmgDY4oL5j96/Mw7uc+fAzdaBeSBB04Sekqopu4pZlpeq
         vWxTFoQuCFMMZ124T08nyEIaMVcJV1BTVdzVIgVjQDLdjoGUU/y1iMmGj1+9Yf72f5Lr
         M4aDjTqCqLuDJtcQnJFzRBcEdYwIKgTCA1j7kzo0MikksCGTO4Yxcz9CNymdr4v+nB0g
         rWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725639788; x=1726244588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKmJdeK5l8HCJZ+0iG3dq8C9nlCLW1c2QlS0zqdSjSM=;
        b=Vwe4T4ZA4wvIJn1Ve4MGx6hjz/2DsrRQi/Dq11jEfJ3eGzi1jWGSv8PMO893C94tHI
         AmMa77ofs0fPebLmRFRGz2bBCZ4JaW/4mF3h1HZj/DQYYMdznmVgXkIN6SBeRhdru6tO
         A/hY3xpCiEHQ69IgI72TCVG0hJPy2YBJBqc+KVW7Pvd2NKkeN2YR9b4Jw7qIfOWvDXCs
         9Nzg3Sq1uH7I511LjX5ObeBgXzjNUmOQhl3uM/SBRDzCtU1jvQoJ4fQYhcQ71ALVkmh3
         tESVbZLI3oQ49wmkA1AZC/qa4lNxhPnDZlNh04B1UlQ+6KHqfT7Jyp2EbKw5nW5OlgtR
         ZCOw==
X-Forwarded-Encrypted: i=1; AJvYcCUjpAHuNgepXRooOVWeuIwbK96ZWxdukU72cFGCPAOoggSWSmOpz0J4ohSt0ClmaBZ3NwQnJEv6@vger.kernel.org
X-Gm-Message-State: AOJu0YyL3POx/QIMND89kc7vAO4YLt9rr15ySy75UJZEmLZjikjt284d
	q/o62VHnauKVHp1p8coGqdxbyT2F6Zut2jnVcN8lO8ObgLXpeTVAmUjxtwxtEgItamkwsSKJ0PZ
	PnCa/ESl5iGZMBbTUmh1p5O0ZaO+YBZ0ZguntzZ1CSD66Zwu3UA==
X-Google-Smtp-Source: AGHT+IFjaGdACs19oTC4yytm/ikdewa05abv7XzNeodR/ljk3q04pbH+08kpay58gWBD6ntmd+2aJErvq8luT4pS0+M=
X-Received: by 2002:a05:690c:7503:b0:646:7b75:5c2c with SMTP id
 00721157ae682-6db44dd0f0fmr37479567b3.16.1725639788168; Fri, 06 Sep 2024
 09:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809122007.1220219-3-masahiroy@kernel.org>
 <3447459d08dd7ebb58972129cddf1c44@paul-moore.com> <CAK7LNAS4Q1_4T2vafu6wTYsmFsY1h+TA8irqDAqwfoSyw7X=Rw@mail.gmail.com>
 <CAHC9VhSz+kwYOnkfWPHOmoKCRfOjm3_L5xMLeSGVNxq5g=ikww@mail.gmail.com> <CAK7LNARj7mx9ZkucABBKujEmwggqZvn+8PZ1e-_ofaa43pfz0Q@mail.gmail.com>
In-Reply-To: <CAK7LNARj7mx9ZkucABBKujEmwggqZvn+8PZ1e-_ofaa43pfz0Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Sep 2024 12:22:57 -0400
Message-ID: <CAHC9VhRhUPTwg2-wsLzGGpbhG_4sH9K5o6Z5D_aLiiO98LgaJQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux: move genheaders to security/selinux/
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 12:06=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
> On Sat, Sep 7, 2024 at 12:37=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Fri, Sep 6, 2024 at 11:19=E2=80=AFAM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > > On Tue, Aug 27, 2024 at 6:22=E2=80=AFAM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Aug  9, 2024 Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > >
> > > > > This tool is only used in security/selinux/Makefile.
> > > > >
> > > > > There is no reason to keep it under scripts/.
> > > > >
> > > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > > ---
> > > > >  scripts/remove-stale-files                                 | 3 +=
++
> > > > >  scripts/selinux/Makefile                                   | 2 +=
-
> > > > >  scripts/selinux/genheaders/.gitignore                      | 2 -=
-
> > > > >  scripts/selinux/genheaders/Makefile                        | 3 -=
--
> > > > >  security/selinux/.gitignore                                | 1 +
> > > > >  security/selinux/Makefile                                  | 7 +=
++++--
> > > > >  .../selinux/genheaders =3D> security/selinux}/genheaders.c   | 0
> > > > >  7 files changed, 10 insertions(+), 8 deletions(-)
> > > > >  delete mode 100644 scripts/selinux/genheaders/.gitignore
> > > > >  delete mode 100644 scripts/selinux/genheaders/Makefile
> > > > >  rename {scripts/selinux/genheaders =3D> security/selinux}/genhea=
ders.c (100%)
> > > >
> > > > As long as there is no harm in keeping genheaders under scripts/sel=
inux,
> > > > and based on your cover letter it would appear that there is no pro=
blem
> > > > with the current location, I would prefer to keep it where it curre=
ntly
> > > > lives.
> > >
> > > 'make clean' is meant to clean up the tree, but keep
> > > build artifacts necessary for building external modules.
> > >
> > > See the help message:
> > >
> > >   clean           - Remove most generated files but keep the config a=
nd
> > >                     enough build support to build external modules
> > >
> > > 'make clean' does not clean up under scripts/
> > > because tools located scripts/ are used in tree-wide
> > > and often used for external modules as well.
> > >
> > > So, scripts/selinux/genheaders/genheaders is left over.
> > >
> > > genheaders is locally used in security/selinux/.
> > >
> > > 'make clean' will properly clean up security/selinux/genheaders.
> >
> > Your last sentence is confusing and doesn't align with the rest of
> > your email, please clarify.
>
> I do not understand what was unclear.

Near the start of your email you stated: "'make clean' does not clean
up under scripts/".  However you ended your email with "'make clean'
will properly clean up security/selinux/genheaders" which seems
contradictory to your initial statement; I was guessing that you were
implying that moving the genheaders script will allow `make clean` to
work properly, but you explicitly included the old/existing location
of security/selinux/genheaders directory in your comment which didn't
support that guess.

Your latest reply makes it a bit more clear.

--=20
paul-moore.com

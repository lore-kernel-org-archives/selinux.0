Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F481279347;
	Fri,  8 Aug 2025 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754656905; cv=none; b=Jqq6vnjm4VHhZhPQKui6dwon4GT8aLQokRta/4rcd+UvbOkCobOxDnPVCt/V7qW2G4ssBja2CX5axu1knxVKXuPauh4ye/3+937y30Ddj0jTc2SnqoPDJEnZ/xhvvyo6fpEfzZ5GdkLFST5iKfB9AupJfeY/ngTw/TDnjpYSsWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754656905; c=relaxed/simple;
	bh=HdzVk0sRs1hfJAGR8ce7QPQ1gaUVGEyGGMSbY9Wz/So=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7YESMJTuxFBiCZqtoL16M3nAB7XACbwh5gTc50PA/VUIUHHn/xjNOZRnqOby4pvgbf0TqYNnpI4f0vVZz+zkwWZe4c8NIcvfkV+mrt3FVXQAPlW0QGnUw5RJCuUtB1ZI2U4mClCl/OyRKdzyAREERyhmB5lJJBKA0u2sf3JIiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkIg22jS; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkIg22jS"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-30b776f0805so1279151fac.3;
        Fri, 08 Aug 2025 05:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754656902; x=1755261702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wm962l4XMmikvrSw+fo+wnrnWEx42TpR3Pz1UEbFsc0=;
        b=UkIg22jSUv/MUEyWm2yYpPT2iGNw4cHuq25xfJM3gFnjnrZ+Fo05vRb5MZVbKaD7iu
         rK15ZhcBAHPLd+HpTPn+dilVjZ7WEoMEMVS+w4MybeSAX5NIJk5KX12YP+Wu473nADVC
         +JD63z0sMnny1KwRDziodD84hlQXPakbvce/tFfKXxPsldpPDpkdyce2jtSt+8NledEs
         qdh+Ui5RXQRwwXSp/TXl54ftgpmxY6p6mzS4oVWWVEeAqmbMqsjIIuL9tJuoIgqBuAyz
         BHdEkHBRXzFBiDYZq8TdKZJcusKF+g+yqpyr5shozTufQ8ZCSyfNZMjaCQn9xkeJvyim
         w0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754656902; x=1755261702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wm962l4XMmikvrSw+fo+wnrnWEx42TpR3Pz1UEbFsc0=;
        b=sXqKckJUNMM67LMOXbpGklalO5TV7yJVQlAe/N1YoQXY0vvAgLuE8VoxEo65Z+WBiB
         OyO1oy7WY0feOfU2VqjsETyEod3/w7VySsS/it88qGNp5feO3NWVA15Pjjmr5wpuIgo7
         mPBgrqwrYxM+vGZGBiI7uKcRIK+YMmjeFX1UDEqbF5sddIrniDXyrDe501VbzRc/Oma2
         mnDrcmnfHPzj6T9eelM+tHpwiYiYpISED0JuC8vlqOsMd+rVSZSxo7s0UCGMeDN1sEvX
         JmB2GxsBl05EsO1e2dI8n6jcJckmhZwaWpz4g/J7MEwOdRFWGJFTaRDgnJR3RMjStHIK
         uiBg==
X-Forwarded-Encrypted: i=1; AJvYcCViJoKZyNjepo+f5zOuWBvHLyKbQEncZ5NkBHH8JZwqAxm+AJOqRZxA64/OzkP7p3srz02WfwHW3Id5a58=@vger.kernel.org, AJvYcCVnpc87uPgIj5KoiasDWlYkZ/Gao2Rb2aHkY7xotBe3hUEhOusFyKMZPRi9nxP0q5FiojOTnw0Sv8/sFz8CfRRZcatqiVsp@vger.kernel.org, AJvYcCWa2GHgMSrSwbIq7fLSAUTgFb1pJIFjgNrCfxobXwQAkUVbc+223dFWKShLyLJD9FzEBzcHPIvmiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzF02Ow7Rl0c8DPX8qgQyd9FcYvhkx0GAPxcORNIau9T+auNMaP
	9Hb1m75j8/cdia4UA6BV17Efl5vcdKgtZL3IUap/XDkZsMqZxxA4/AYcRsuqSxmJtGdukiQWQed
	QLiCbPecHu/8S0Qj+RrqQ63a7E39r8FWl6A==
X-Gm-Gg: ASbGnct3w/BX94aACeTMkHlCU4jOpmbbVof8TcRsrbaHafCo+C4M1InX/x9Ilh0UHQ6
	u47UMTh3LLa9Wd5UX84YIMlBhMvfxWAiNxoNIHQRhccpBIoVJzsn+0IEXh3iiFC0l2yVUyCiKJP
	2otoIkIN23zzf35NEIpBreVhVc5KYwcPMQkI7udIVczyJz2vcD34UjdH6Ki+9BiqP1oq3P6pNZd
	ly22YE=
X-Google-Smtp-Source: AGHT+IEaLTDY8U3TRkb4mzdqbFU8UST2E6N94tTZ8Cgm+xd6Qf+F/OaX8zHIyeCoKUworOd09J5g8AjXg3P6JY1HEzA=
X-Received: by 2002:a05:6871:8305:b0:2bc:918c:ee04 with SMTP id
 586e51a60fabf-30c20f1f6abmr1753177fac.14.1754656902389; Fri, 08 Aug 2025
 05:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807075745.756415-1-tweek@google.com> <CAEjxPJ5nC7s=+Os4+9XjkzhGTyaNVrCyJgx+rz5n3baRFWVrzA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5nC7s=+Os4+9XjkzhGTyaNVrCyJgx+rz5n3baRFWVrzA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 8 Aug 2025 08:41:30 -0400
X-Gm-Features: Ac12FXx4T5Ny6vv7inWyXxkPjgMQd5DsU4kscH8wrKgPRMz-OuJJd5ai2Hte8OA
Message-ID: <CAEjxPJ7JFHs1w71qeOFYSAmReZsghAz3+XVJrTKH=v=P822yxQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] memfd: call security_inode_init_security_anon
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Hugh Dickins <hughd@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 7:57=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 7, 2025 at 3:57=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
> >
> > Prior to this change, no security hooks were called at the creation of =
a
> > memfd file. It means that, for SELinux as an example, it will receive
> > the default type of the filesystem that backs the in-memory inode. In
> > most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it will
> > be hugetlbfs. Both can be considered implementation details of memfd.
> >
> > It also means that it is not possible to differentiate between a file
> > coming from memfd_create and a file coming from a standard tmpfs mount
> > point.
> >
> > Additionally, no permission is validated at creation, which differs fro=
m
> > the similar memfd_secret syscall.
> >
> > Call security_inode_init_security_anon during creation. This ensures
> > that the file is setup similarly to other anonymous inodes. On SELinux,
> > it means that the file will receive the security context of its task.
> >
> > The ability to limit fexecve on memfd has been of interest to avoid
> > potential pitfalls where /proc/self/exe or similar would be executed
> > [1][2]. Reuse the "execute_no_trans" and "entrypoint" access vectors,
> > similarly to the file class. These access vectors may not make sense fo=
r
> > the existing "anon_inode" class. Therefore, define and assign a new
> > class "memfd_file" to support such access vectors.
>
> To provide backward compatibility, I would anticipate that you will
> need to define a new SELinux policy capability and make this change
> conditional on it being enabled, see:
> https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#add=
ing-a-new-selinux-policy-capability
> for instructions and links to examples.
>
> Otherwise, see below.
>
> >
> > [1] https://crbug.com/1305267
> > [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@google.c=
om/
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > ---
> >  mm/memfd.c                          | 16 ++++++++++++++--
> >  security/selinux/hooks.c            | 15 +++++++++++----
> >  security/selinux/include/classmap.h |  2 ++
> >  3 files changed, 27 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/memfd.c b/mm/memfd.c
> > index bbe679895ef6..13bff0e91816 100644
> > --- a/mm/memfd.c
> > +++ b/mm/memfd.c
> > @@ -433,6 +433,9 @@ static struct file *alloc_file(const char *name, un=
signed int flags)
> >  {
> >         unsigned int *file_seals;
> >         struct file *file;
> > +       struct inode *inode;
> > +       int err =3D 0;
> > +       const char *anon_name =3D "[memfd]";
> >
> >         if (flags & MFD_HUGETLB) {
> >                 file =3D hugetlb_file_setup(name, 0, VM_NORESERVE,
> > @@ -444,12 +447,21 @@ static struct file *alloc_file(const char *name, =
unsigned int flags)
> >         }
> >         if (IS_ERR(file))
> >                 return file;
> > +
> > +       inode =3D file_inode(file);
> > +       err =3D security_inode_init_security_anon(inode,
> > +                       LSM_ANON_INODE_MEMFD,
> > +                       &QSTR(anon_name), NULL);
>
> Since the anon_name already indicates that this is a memfd, so can't
> you already distinguish these via name-based type_transition rules?
> Why do we need the enum argument?

On second thought, I see that you are distinguishing not just the
security context/type but also the security class, but the question
remains: can't you compare the name to make this determination?

>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 8d36d5ebb6e5..49742930e706 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2367,8 +2367,8 @@ static int selinux_bprm_creds_for_exec(struct lin=
ux_binprm *bprm)
> >         ad.u.file =3D bprm->file;
> >
> >         if (new_tsec->sid =3D=3D old_tsec->sid) {
> > -               rc =3D avc_has_perm(old_tsec->sid, isec->sid,
> > -                                 SECCLASS_FILE, FILE__EXECUTE_NO_TRANS=
, &ad);
> > +               rc =3D avc_has_perm(old_tsec->sid, isec->sid, isec->scl=
ass,
> > +                                 FILE__EXECUTE_NO_TRANS, &ad);
>
> Here and below I am a little concerned that we could end up reaching
> this code on an inode with an isec->sclass that does not define the
> execute_no_trans and entrypoint permissions. We should do something to
> make that never happens, or check for it and always deny in that case.
>
> >                 if (rc)
> >                         return rc;
> >         } else {
> > @@ -2378,8 +2378,8 @@ static int selinux_bprm_creds_for_exec(struct lin=
ux_binprm *bprm)
> >                 if (rc)
> >                         return rc;
> >
> > -               rc =3D avc_has_perm(new_tsec->sid, isec->sid,
> > -                                 SECCLASS_FILE, FILE__ENTRYPOINT, &ad)=
;
> > +               rc =3D avc_has_perm(new_tsec->sid, isec->sid, isec->scl=
ass,
> > +                                 FILE__ENTRYPOINT, &ad);
> >                 if (rc)
> >                         return rc;
> >
> > @@ -2997,6 +2997,13 @@ static int selinux_inode_init_security_anon(stru=
ct inode *inode,
> >
> >                 isec->sclass =3D context_isec->sclass;
> >                 isec->sid =3D context_isec->sid;
> > +       } else if (type =3D=3D LSM_ANON_INODE_MEMFD) {
> > +               isec->sclass =3D SECCLASS_MEMFD_FILE;
> > +               rc =3D security_transition_sid(
> > +                       sid, sid,
> > +                       isec->sclass, name, &isec->sid);
>
> Again, name-based type_transitions ought to be able to distinguish
> memfd based on the name argument IIUC.

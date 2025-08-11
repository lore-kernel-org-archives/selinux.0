Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6C42D837F;
	Mon, 11 Aug 2025 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917748; cv=none; b=O3+md3eR4chhY/rPCxb4IAp9FOXDTDhXdnzaoi6Zf25giGPnOAtqaHu2ipFm5c1EdSnpv3D8ZJJCWd6WBeuXzTQHx9T7r8XefYtkBnhpob/yhaqpPHfUddoav7HizgSNGps2rq2HAYwCxk6xOpjy//JZil8oiHUaaEFS0Q/4/5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917748; c=relaxed/simple;
	bh=eBgBRJVoS7DYSj9feWbTy0rKg0r6zcKv6B/FUANB2bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1YsN5jfii9pU0CuVKj9IlJFVvJxTsAU1cJa9NxJjkK2Z+hE27nDz+4o3znjbGCaeu2aY4ryCUYdcwSoLmdxCTlyN2mWWApTMEeT+tHDsSNienAuAth0++JE1WCcKSPThs89nCYd0coOYeVK4BUYOjc8xSvqTCkKbKnNE8K7S1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsfCLNtw; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsfCLNtw"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-321a5d6d301so847974a91.3;
        Mon, 11 Aug 2025 06:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754917746; x=1755522546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ogNKkFUnl/KTIW6622rNeCrp5ddWTYKEpkW/T/1M24=;
        b=RsfCLNtwL0cMVdXL6TWcCHO4O4F8w79rko4RCKfik3I/ZgHmBUUuBnvla23H2cwSEw
         YTDP03dg4/QPgqevnPTPvhRjRXsl55mWY8oIPgMANFGbB2rkdUWvzNzXvFTlgZjcA1Dx
         woVeFcmEmkqrFnoziU7aZx9pN9ydBezXVamjds1dhb791f6H+3Yqda9TGxTEeB8UhECK
         UDNcAkSUyLkLnqkQlIwAR5cxYhKKzjGYaZO/GC+Dlw0BjNjA0g//uqLw93KWDPtN6KFq
         Xqoj5nKqHmqkJMwmsO6tcRxgVE/P/qih0COULR/SeW6u3Et0g3d4r5lC9LgjHMVJFyb7
         lr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754917746; x=1755522546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ogNKkFUnl/KTIW6622rNeCrp5ddWTYKEpkW/T/1M24=;
        b=sZAVoavnd/+PXVsquqDNjauZoP5KcaSMl/P0aCkrDCN/jr636uBsQFne6uVontESpy
         xZYztl0sc7ewTSfpSKIMf6oi3T2C33WGk3R3nx1ODsXyih46qFvjdRLV7lvVzjGkwmP6
         Uag46mrrCU3kgK4B+c6gFjW01c0LhSeFV+G4nTIjVDktSGavroWIB5/L+SSJJNu7D8sK
         JxyypaOtPqysQfEFKce7AcxjTeTooMqKO7PbHmPt96OeJoYompSauchn7gscr30MuNfF
         fPBsFFBUbgEPc0CSiiTNk8z+ttW3LfuP43PvoZj3Ib09cpHaGosmKKsMdnoI8jI3inWl
         WpPA==
X-Forwarded-Encrypted: i=1; AJvYcCU87f95g7q9AUKDfSkey1NW5T7pxO/46ZI6z9moqeb4jDyfE53gn0NWOp/uKDOKJV4/HYGPImZ+j+ZhutI=@vger.kernel.org, AJvYcCVSdzJmNHwHofTTrJZivZgEoxr+4hDFHa6IkMf9YTMedaHG+gFoFEeJaR4qxlqRPQfoqnHYu1Lkgw==@vger.kernel.org, AJvYcCXOLor6Gbgmpgm6uqbDG5ba6RdqshRMNiwd8f3xnxPlp2QZ3V+s5rTcU68aSoEZRJd9ns80kICuYKQKHe1KMgDzvayH1+SS@vger.kernel.org
X-Gm-Message-State: AOJu0YwEz81jxnwdM+RmluN0Lk6vV9wT08mtP/vVL4h4DwxwbCofdel2
	InDe/zht98p9lPwgnKZjYON3iCmrLWuV6daZD5Nq7HeGtyErGVOTPFAQOKVFUEzqrFvR5sgYBmS
	g2NIvRnLrpeirKxeiWYzkvyqveA8YV4E=
X-Gm-Gg: ASbGnct8qRPywN1HO2JjFqHC0L8vb+3Uiyxba/sE7N4UqnzuMVthCXLtKhZ6vN0vW70
	UHem8FOEjQewL4kSxxoIZolX6+6EmFNN2KHDAzPoleddzbovqG47aJKpJ3ugeh4TnIYGLRNBD39
	DYBplVGY3nW+YQFDRp7lwsNGz89TRF85cTCTPGtBn3uIIr7C9HSdW37g5l2d9sgAAGsx4P658cd
	1IvJTQ=
X-Google-Smtp-Source: AGHT+IGPBhTDMG2k2oThC8/6k3S12XhowfoSS6hgtZCLwN6Z15Ejq3oLTPWY6Osc+OLrV8Qd6iD3c9GF91YK69BusRY=
X-Received: by 2002:a17:90b:2ec4:b0:311:df4b:4b7a with SMTP id
 98e67ed59e1d1-32183c45f65mr18288999a91.29.1754917745440; Mon, 11 Aug 2025
 06:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807075745.756415-1-tweek@google.com> <CAEjxPJ5nC7s=+Os4+9XjkzhGTyaNVrCyJgx+rz5n3baRFWVrzA@mail.gmail.com>
 <CAEjxPJ7JFHs1w71qeOFYSAmReZsghAz3+XVJrTKH=v=P822yxQ@mail.gmail.com> <CA+zpnLeaKkXAdxUuA5kNbKwrGVX+UCf+VFLK0XbtrbovvPGUWQ@mail.gmail.com>
In-Reply-To: <CA+zpnLeaKkXAdxUuA5kNbKwrGVX+UCf+VFLK0XbtrbovvPGUWQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 11 Aug 2025 09:08:53 -0400
X-Gm-Features: Ac12FXz7TJ3NbuWNt1BCQDFngT_zpEroMpbufMYABI6NkRQtA7S0T7RfK3qIg50
Message-ID: <CAEjxPJ5otOTmP44QcYXpqcAyg1JU+CTPmS6UgPugnQbFJ_9=dw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] memfd: call security_inode_init_security_anon
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Hugh Dickins <hughd@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 1:34=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
>
> On Fri, Aug 8, 2025 at 10:41=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Aug 8, 2025 at 7:57=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
>
> Thanks for the review Stephen.
>
> > >
> > > On Thu, Aug 7, 2025 at 3:57=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@=
google.com> wrote:
> > > >
> > > > Prior to this change, no security hooks were called at the creation=
 of a
> > > > memfd file. It means that, for SELinux as an example, it will recei=
ve
> > > > the default type of the filesystem that backs the in-memory inode. =
In
> > > > most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it w=
ill
> > > > be hugetlbfs. Both can be considered implementation details of memf=
d.
> > > >
> > > > It also means that it is not possible to differentiate between a fi=
le
> > > > coming from memfd_create and a file coming from a standard tmpfs mo=
unt
> > > > point.
> > > >
> > > > Additionally, no permission is validated at creation, which differs=
 from
> > > > the similar memfd_secret syscall.
> > > >
> > > > Call security_inode_init_security_anon during creation. This ensure=
s
> > > > that the file is setup similarly to other anonymous inodes. On SELi=
nux,
> > > > it means that the file will receive the security context of its tas=
k.
> > > >
> > > > The ability to limit fexecve on memfd has been of interest to avoid
> > > > potential pitfalls where /proc/self/exe or similar would be execute=
d
> > > > [1][2]. Reuse the "execute_no_trans" and "entrypoint" access vector=
s,
> > > > similarly to the file class. These access vectors may not make sens=
e for
> > > > the existing "anon_inode" class. Therefore, define and assign a new
> > > > class "memfd_file" to support such access vectors.
> > >
> > > To provide backward compatibility, I would anticipate that you will
> > > need to define a new SELinux policy capability and make this change
> > > conditional on it being enabled, see:
> > > https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started=
#adding-a-new-selinux-policy-capability
> > > for instructions and links to examples.
> > >
>
> I agree. Thanks, I'll add this to the next patchset.
>
> > > Otherwise, see below.
> > >
> > > >
> > > > [1] https://crbug.com/1305267
> > > > [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@goog=
le.com/
> > > >
> > > > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > > > ---
> > > >  mm/memfd.c                          | 16 ++++++++++++++--
> > > >  security/selinux/hooks.c            | 15 +++++++++++----
> > > >  security/selinux/include/classmap.h |  2 ++
> > > >  3 files changed, 27 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/mm/memfd.c b/mm/memfd.c
> > > > index bbe679895ef6..13bff0e91816 100644
> > > > --- a/mm/memfd.c
> > > > +++ b/mm/memfd.c
> > > > @@ -433,6 +433,9 @@ static struct file *alloc_file(const char *name=
, unsigned int flags)
> > > >  {
> > > >         unsigned int *file_seals;
> > > >         struct file *file;
> > > > +       struct inode *inode;
> > > > +       int err =3D 0;
> > > > +       const char *anon_name =3D "[memfd]";
> > > >
> > > >         if (flags & MFD_HUGETLB) {
> > > >                 file =3D hugetlb_file_setup(name, 0, VM_NORESERVE,
> > > > @@ -444,12 +447,21 @@ static struct file *alloc_file(const char *na=
me, unsigned int flags)
> > > >         }
> > > >         if (IS_ERR(file))
> > > >                 return file;
> > > > +
> > > > +       inode =3D file_inode(file);
> > > > +       err =3D security_inode_init_security_anon(inode,
> > > > +                       LSM_ANON_INODE_MEMFD,
> > > > +                       &QSTR(anon_name), NULL);
> > >
> > > Since the anon_name already indicates that this is a memfd, so can't
> > > you already distinguish these via name-based type_transition rules?
> > > Why do we need the enum argument?
> >
> > On second thought, I see that you are distinguishing not just the
> > security context/type but also the security class, but the question
> > remains: can't you compare the name to make this determination?
> >
>
> I definitely can. My initial thought was that a string comparison
> would not be adequate here (performance-wise), but I guess calls to
> this method are infrequent enough that a strncmp would work here?

Open to data showing otherwise, but would think that a fixed-size
small string comparison would be in the noise here.

>
> On the option of just relying on name-based type transitions, this has
> an impact on the size of the policy: for Android, the transition from
> ashmem to memfd means that virtually all domains will rely on such a
> file. It means that we would need to define a type transition and a
> new type for all our domains. (This is an argument on top of the need
> for execute_no_trans, as I described in the commit message).
>
> > >
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index 8d36d5ebb6e5..49742930e706 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -2367,8 +2367,8 @@ static int selinux_bprm_creds_for_exec(struct=
 linux_binprm *bprm)
> > > >         ad.u.file =3D bprm->file;
> > > >
> > > >         if (new_tsec->sid =3D=3D old_tsec->sid) {
> > > > -               rc =3D avc_has_perm(old_tsec->sid, isec->sid,
> > > > -                                 SECCLASS_FILE, FILE__EXECUTE_NO_T=
RANS, &ad);
> > > > +               rc =3D avc_has_perm(old_tsec->sid, isec->sid, isec-=
>sclass,
> > > > +                                 FILE__EXECUTE_NO_TRANS, &ad);
> > >
> > > Here and below I am a little concerned that we could end up reaching
> > > this code on an inode with an isec->sclass that does not define the
> > > execute_no_trans and entrypoint permissions. We should do something t=
o
> > > make that never happens, or check for it and always deny in that case=
.
>
> I agree. I can add a condition to make sure only these 2 classes (file
> or memfd_file) are used here.
>
> > >
> > > >                 if (rc)
> > > >                         return rc;
> > > >         } else {
> > > > @@ -2378,8 +2378,8 @@ static int selinux_bprm_creds_for_exec(struct=
 linux_binprm *bprm)
> > > >                 if (rc)
> > > >                         return rc;
> > > >
> > > > -               rc =3D avc_has_perm(new_tsec->sid, isec->sid,
> > > > -                                 SECCLASS_FILE, FILE__ENTRYPOINT, =
&ad);
> > > > +               rc =3D avc_has_perm(new_tsec->sid, isec->sid, isec-=
>sclass,
> > > > +                                 FILE__ENTRYPOINT, &ad);
> > > >                 if (rc)
> > > >                         return rc;
> > > >
> > > > @@ -2997,6 +2997,13 @@ static int selinux_inode_init_security_anon(=
struct inode *inode,
> > > >
> > > >                 isec->sclass =3D context_isec->sclass;
> > > >                 isec->sid =3D context_isec->sid;
> > > > +       } else if (type =3D=3D LSM_ANON_INODE_MEMFD) {
> > > > +               isec->sclass =3D SECCLASS_MEMFD_FILE;
> > > > +               rc =3D security_transition_sid(
> > > > +                       sid, sid,
> > > > +                       isec->sclass, name, &isec->sid);
> > >
> > > Again, name-based type_transitions ought to be able to distinguish
> > > memfd based on the name argument IIUC.

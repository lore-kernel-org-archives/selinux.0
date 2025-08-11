Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462CA263F54
	for <selinux@vger.kernel.org>; Mon, 11 Aug 2025 05:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890469; cv=none; b=QfjP4+u7s5DYveocOJZ+G75mn4AToBf3t8UhT0uG0G+LZYUCTQEdfEhF4wZeDRZhY+9SOqXJjK7O8w9RxecZBM4UIU3zXPVZV6j1eEEa1tvEa44RhuIa3HmcfO6qHBK0+z7PNWajdKwh+q3IRwOOxr48a8PIaZJE7H0Uh8azmJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890469; c=relaxed/simple;
	bh=Gr+Djs1XEcEpUlsX/sPfYPFa8BYBIATqniA4vomsC9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sg6Vh6eEb/KCHSNDHRYpXcUN3UKl+rl6NS61O5Nff3hgZ1UXFw2ixXifTg2nrluZ2Sn3F62nbSyhI6AM/RPbAthdAt3BV2WzLRT4EeaTIRn/1GYxLjn3dlIRVH2rP4Xj7rLh/JnplAcjY0UPHZPvf9zwVhEDbribH7SDQ9xP2Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pshLVlZ+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pshLVlZ+"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55cd07a28e0so2374e87.0
        for <selinux@vger.kernel.org>; Sun, 10 Aug 2025 22:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754890465; x=1755495265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0NLTfruXmHFEfu48dn6MG+T5on146VVfsN7rRynb7U=;
        b=pshLVlZ+Jd90rBOnWJaRbgCqQcnI+EVbXzTXCJBCLZdI28XGfeygn84UPBy5EP4JDL
         lWseGjRo6KByyLtfXLCLKjNg1pKuDVDqKBxfMH70AV6DFQBmN/M97I2ie7F44Fg4emOY
         1viRIXaA0MAj5zZIPGRAs8TYtziVJnSBL3voudGaQIzkENgLjOSUEuAI2UtdhN521l/1
         ajS+66q3DH+BFpJP74YRg/BcQI8y1DaV1XAwKhsrxAqJoK6+aoQcpE2vp9RVTvfThx8w
         JDVjBgYUX4bG6C9qJQ5URjsxNCl/Pu1r8pKTVPXrgPvlreDri95paezv923LzHXpaV9h
         0Dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754890465; x=1755495265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0NLTfruXmHFEfu48dn6MG+T5on146VVfsN7rRynb7U=;
        b=OcGj0lgCoTFFcjGu4Ty6b0N49P2rKcqQqtDllcKYvRJo5loPbmXyZjZ+Mgw5D/jo8m
         8hjDhKZ/4rVQhvzdayVx9HQ+8IHZscl77ENqv+aenkeINmvReC+TZOmRqdwGS8xAqA0O
         2e2GwBbC6dwRcSf6KAIdVkTC+x6v9BuYYj0aqVc1S1Kc1C3OX8z+dparPzQM8JdV72Ed
         XzJKmfBQCm+sBqgLQNDvAQArf69hXxIlZTRNOqnMKhnpSMny/BVg0Va5+0MZtqx2S/1N
         tl/DKYiatvlAZj2P2/rnE6qL4Of1sAuiNyStReVD/b0m0mGYCAqLg/6lsdWK9Pw1TlnW
         /j/A==
X-Forwarded-Encrypted: i=1; AJvYcCU276SaC/vt89LVTij/kO+tFWEsWLkUZ5TsbYIuU89HJnPtOqfBSdx4VDzmH43j7y274CeXCPXj@vger.kernel.org
X-Gm-Message-State: AOJu0YxOtIfjN1neUDzT6RvItKnDW/TNrs+L02wJMo5jPFDD0fgr7HZy
	cIvh92qvuMvB7nTILTzf6SdP+JilJ5vzYxbZNnjQN0jtDGi3DVqnDtuiVxISUIrc8uUVEUUV2KB
	EOlX2Pn8S8r4iU54z+J5ADtaCkO2QF6MjC/EqRCIV
X-Gm-Gg: ASbGnct9O7Oi+FmznAg8kYrG1yqxxDxzsM0GiPPOi7CAoUJhq/XMD0++wAGQeD0R/Sm
	bPFZ3R+YX6Iy70ObRFVA6C19hi05zZtf2ayulxQj80hQW66rCk1KXpmGs9oEQ5G8VjIVnUpAtp7
	q0SqZe2IPZ8Ygse6sHl8gkCYgF/N+aAH0ag1k6JcV0NANOLQMy/Cmeh9kvvABS29g5YzM2VJris
	GM1qBjCcFkex7mR0WIyAWu0K0xeaO1LpSU5YY/ttWF2JA==
X-Google-Smtp-Source: AGHT+IEXRQxfrYSLj14KkzGh4T1mxzBL1DB9q7JmZuwsFc9cetT9nQdVJgVM6xZs31QG7TdG60Yga4f1u2AyXuVhrMs=
X-Received: by 2002:a05:6512:638c:10b0:55b:7c73:c5f0 with SMTP id
 2adb3069b0e04-55cc818ac40mr173919e87.2.1754890465238; Sun, 10 Aug 2025
 22:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807075745.756415-1-tweek@google.com> <CAEjxPJ5nC7s=+Os4+9XjkzhGTyaNVrCyJgx+rz5n3baRFWVrzA@mail.gmail.com>
 <CAEjxPJ7JFHs1w71qeOFYSAmReZsghAz3+XVJrTKH=v=P822yxQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7JFHs1w71qeOFYSAmReZsghAz3+XVJrTKH=v=P822yxQ@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Mon, 11 Aug 2025 15:34:07 +1000
X-Gm-Features: Ac12FXy9F5Nea7bUFZ3FcZm8TiMAClwaLR5q7_3zirh_BsAwmL7bNpDZ3dnr-tA
Message-ID: <CA+zpnLeaKkXAdxUuA5kNbKwrGVX+UCf+VFLK0XbtrbovvPGUWQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] memfd: call security_inode_init_security_anon
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Hugh Dickins <hughd@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 10:41=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Aug 8, 2025 at 7:57=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:

Thanks for the review Stephen.

> >
> > On Thu, Aug 7, 2025 at 3:57=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@go=
ogle.com> wrote:
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
> >
> > To provide backward compatibility, I would anticipate that you will
> > need to define a new SELinux policy capability and make this change
> > conditional on it being enabled, see:
> > https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#a=
dding-a-new-selinux-policy-capability
> > for instructions and links to examples.
> >

I agree. Thanks, I'll add this to the next patchset.

> > Otherwise, see below.
> >
> > >
> > > [1] https://crbug.com/1305267
> > > [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@google=
.com/
> > >
> > > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > > ---
> > >  mm/memfd.c                          | 16 ++++++++++++++--
> > >  security/selinux/hooks.c            | 15 +++++++++++----
> > >  security/selinux/include/classmap.h |  2 ++
> > >  3 files changed, 27 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/mm/memfd.c b/mm/memfd.c
> > > index bbe679895ef6..13bff0e91816 100644
> > > --- a/mm/memfd.c
> > > +++ b/mm/memfd.c
> > > @@ -433,6 +433,9 @@ static struct file *alloc_file(const char *name, =
unsigned int flags)
> > >  {
> > >         unsigned int *file_seals;
> > >         struct file *file;
> > > +       struct inode *inode;
> > > +       int err =3D 0;
> > > +       const char *anon_name =3D "[memfd]";
> > >
> > >         if (flags & MFD_HUGETLB) {
> > >                 file =3D hugetlb_file_setup(name, 0, VM_NORESERVE,
> > > @@ -444,12 +447,21 @@ static struct file *alloc_file(const char *name=
, unsigned int flags)
> > >         }
> > >         if (IS_ERR(file))
> > >                 return file;
> > > +
> > > +       inode =3D file_inode(file);
> > > +       err =3D security_inode_init_security_anon(inode,
> > > +                       LSM_ANON_INODE_MEMFD,
> > > +                       &QSTR(anon_name), NULL);
> >
> > Since the anon_name already indicates that this is a memfd, so can't
> > you already distinguish these via name-based type_transition rules?
> > Why do we need the enum argument?
>
> On second thought, I see that you are distinguishing not just the
> security context/type but also the security class, but the question
> remains: can't you compare the name to make this determination?
>

I definitely can. My initial thought was that a string comparison
would not be adequate here (performance-wise), but I guess calls to
this method are infrequent enough that a strncmp would work here?

On the option of just relying on name-based type transitions, this has
an impact on the size of the policy: for Android, the transition from
ashmem to memfd means that virtually all domains will rely on such a
file. It means that we would need to define a type transition and a
new type for all our domains. (This is an argument on top of the need
for execute_no_trans, as I described in the commit message).

> >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 8d36d5ebb6e5..49742930e706 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -2367,8 +2367,8 @@ static int selinux_bprm_creds_for_exec(struct l=
inux_binprm *bprm)
> > >         ad.u.file =3D bprm->file;
> > >
> > >         if (new_tsec->sid =3D=3D old_tsec->sid) {
> > > -               rc =3D avc_has_perm(old_tsec->sid, isec->sid,
> > > -                                 SECCLASS_FILE, FILE__EXECUTE_NO_TRA=
NS, &ad);
> > > +               rc =3D avc_has_perm(old_tsec->sid, isec->sid, isec->s=
class,
> > > +                                 FILE__EXECUTE_NO_TRANS, &ad);
> >
> > Here and below I am a little concerned that we could end up reaching
> > this code on an inode with an isec->sclass that does not define the
> > execute_no_trans and entrypoint permissions. We should do something to
> > make that never happens, or check for it and always deny in that case.

I agree. I can add a condition to make sure only these 2 classes (file
or memfd_file) are used here.

> >
> > >                 if (rc)
> > >                         return rc;
> > >         } else {
> > > @@ -2378,8 +2378,8 @@ static int selinux_bprm_creds_for_exec(struct l=
inux_binprm *bprm)
> > >                 if (rc)
> > >                         return rc;
> > >
> > > -               rc =3D avc_has_perm(new_tsec->sid, isec->sid,
> > > -                                 SECCLASS_FILE, FILE__ENTRYPOINT, &a=
d);
> > > +               rc =3D avc_has_perm(new_tsec->sid, isec->sid, isec->s=
class,
> > > +                                 FILE__ENTRYPOINT, &ad);
> > >                 if (rc)
> > >                         return rc;
> > >
> > > @@ -2997,6 +2997,13 @@ static int selinux_inode_init_security_anon(st=
ruct inode *inode,
> > >
> > >                 isec->sclass =3D context_isec->sclass;
> > >                 isec->sid =3D context_isec->sid;
> > > +       } else if (type =3D=3D LSM_ANON_INODE_MEMFD) {
> > > +               isec->sclass =3D SECCLASS_MEMFD_FILE;
> > > +               rc =3D security_transition_sid(
> > > +                       sid, sid,
> > > +                       isec->sclass, name, &isec->sid);
> >
> > Again, name-based type_transitions ought to be able to distinguish
> > memfd based on the name argument IIUC.

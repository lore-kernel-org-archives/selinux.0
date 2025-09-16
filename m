Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383DF1F30BB
	for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 05:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757999271; cv=none; b=ROuLNiHKwt818Noban+JBI/GnkGrAYFXMIFtpYeIBh4cGQCD/SgOrz4A0FEWOQQiznQj3N/wOx3PJBTdmQrK17LZzc0o9ueSvtgaQxuqJrYZpcOh97PoE3gLSELiWRCpiw21Jmv8jUQiraKQ1U4NoOUVqcJXKIGzq4BXxi5mQ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757999271; c=relaxed/simple;
	bh=daFiBDhD3aJ48E9jadgGLfvb3skhIggquyhgw7ndih0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Lnher0p43YDB1uXO7DRUcYL/nww7mBm8Cc5T0JL0JlKwmXAPThfl6P3eNXTv0JeaI423N8/tZTo7moDt6q791ervu+Hs43+rQ/x+Q1Yelokl9QdWQU/g6MRPz2t5yqdPmqwtK5xsEY01yDD+6InUJ7LYfOeghOpJTOCX/0/y1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PRNtdPEd; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PRNtdPEd"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7728815e639so3441338b3a.1
        for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 22:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757999269; x=1758604069; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+qmsLaQYfIFnfOnViE0APxpYe9wnZszmNaZLIS/hLg=;
        b=PRNtdPEd8WpWwECsDkJSaBeYDQ53h7kcQdDAyyh+kjM3SSzeSHc1WF6mURj18sE6cU
         5dYChqCLaMMeaZ4Q3plt26FJV2zkACH3lb0GW4saCbzj3Ny/qyedYrRZqgG7CgNLcVCn
         TcSiBxWuGiJ7F8mx0cSeSQHQexnbeHeXwZWcxFhcvcANuoNZtHMZV6RqwU/dv6PDfDlY
         V//9dhyQdxZ/9drEs+RN6Q7vUHamW3TO0TUZhiC3fR4vnMvWS/E5C+EL2uQsFh5eEgGh
         lN9MCxKA2kowdLdX7Ufgg1YBAWfSc8CO4+A832+amZuMZXZiirn+nzexrT8qMAW7sEP9
         WxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757999269; x=1758604069;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+qmsLaQYfIFnfOnViE0APxpYe9wnZszmNaZLIS/hLg=;
        b=UE0qXknwro+VPmT0J12ZudQ7486vVUtEfdo766A3OO1oD5CnOwxwUqfQjHFR49ylEm
         ZO8T42c5cfFauqXs7E4Rlx2FgYbYUJeEZprmf+Ps+t0aM4Y22fTJpwoyOVuwRU2XDMBu
         /LJlk9fKbBFwYVF6d7Mt2Cu7xAl6/5Hm1CBCYudFyMuYTqCtLEgH+/KG15aAio8QBfxO
         4AEqZWN0vQIxff0abLw8dE6om1FZheGk1iDil07j31+cfki3L3uy7q4Sbq6iOoz9WcEr
         htmLzX7HscohLL3KCThVrkwvvEBJvop6xpyuyZR3twHB2aaqGltLYel5uo8f9zoyKwt7
         qeXg==
X-Forwarded-Encrypted: i=1; AJvYcCVqJHJhpSKmDsv90NBjplVESyC9pNlt77Z0ZxnVojMmUoGeazlRV6cfN1J+HGpRJIypyRZcHGHy@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc7I8U3TdPLWVfjVwcJBoxgRDfVWhhUEz0Jqb+fBtfNOozImjo
	KC0ZpzhzF2nRbwzqGVg/EoO6twlTgCTyuc6QQ+roL7oUyEtcOt47bChVAEz1kjUY8w==
X-Gm-Gg: ASbGncsHFu2QIvRor9e4qPNhWCvXBdAZuMyY+QnFkeq6UINf3yfTO/f8PKWVV93JLXs
	G0Ks25ChsS1X2zXACUNki6oxUvFBk/fl278WQ10N+OddyjCK93pC4tF315K6t77xvYqjhBNGx8P
	vxLYL5Voro+ym+WMJHsGjjeN4Ndrvuci9fA97V//42ZN6V8XLg2IK7QESUP9cBlDdDqDg5yaJ1b
	cpvxOgmNuQWakQBFgEnzVoAEch/5SCtiTENVzwiHQrNdI0ibSS6Ca2MNWNWY/HnXciMDeGMlAsc
	sBpxw3DeL8r9FuYSqbX20BWUdwssIiyrG1AIMxDpFhIMpxfHEMT3dXP8oYi1KL1AkjGb5Eg1DQ2
	bcrmCv40dNA6dUGI+H6AWbo4hvIp3YNZxmISWf0f88zfVsTtcszlXxOpRkftk9nBsxqJw7N0D7q
	igO7opdnnXgWEWJBnxpbtvVpLP
X-Google-Smtp-Source: AGHT+IE67V0/Q7PMyxtMDe4Dx+1Y/Qbj1MBm0zEQYVlSQIpIVrmBipbiYSmuQN2+gYdoKBRHHyil8Q==
X-Received: by 2002:a05:6a00:a88f:b0:776:139d:cccb with SMTP id d2e1a72fcca58-776139dcdf7mr17285388b3a.28.1757999269172;
        Mon, 15 Sep 2025 22:07:49 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a47310sm14496490b3a.27.2025.09.15.22.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 22:07:48 -0700 (PDT)
Date: Mon, 15 Sep 2025 22:06:52 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Paul Moore <paul@paul-moore.com>
cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
    James Morris <jmorris@namei.org>, 
    Stephen Smalley <stephen.smalley.work@gmail.com>, 
    Hugh Dickins <hughd@google.com>, Jeff Vander Stoep <jeffv@google.com>, 
    Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
    linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH] memfd,selinux: call security_inode_init_security_anon
In-Reply-To: <6afc91a9f5caef96b2ca335b6d143670@paul-moore.com>
Message-ID: <92255d5e-7e0a-6ca3-3169-114ae7f6247f@google.com>
References: <20250826031824.1227551-1-tweek@google.com> <6afc91a9f5caef96b2ca335b6d143670@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-1767593222-1757999268=:21221"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-1767593222-1757999268=:21221
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 3 Sep 2025, Paul Moore wrote:
> On Aug 25, 2025 "=3D?UTF-8?q?Thi=3DC3=3DA9baud=3D20Weksteen?=3D" <tweek@g=
oogle.com> wrote:
> >=20
> > Prior to this change, no security hooks were called at the creation of =
a
> > memfd file. It means that, for SELinux as an example, it will receive
> > the default type of the filesystem that backs the in-memory inode. In
> > most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it will
> > be hugetlbfs. Both can be considered implementation details of memfd.
> >=20
> > It also means that it is not possible to differentiate between a file
> > coming from memfd_create and a file coming from a standard tmpfs mount
> > point.
> >=20
> > Additionally, no permission is validated at creation, which differs fro=
m
> > the similar memfd_secret syscall.
> >=20
> > Call security_inode_init_security_anon during creation. This ensures
> > that the file is setup similarly to other anonymous inodes. On SELinux,
> > it means that the file will receive the security context of its task.
> >=20
> > The ability to limit fexecve on memfd has been of interest to avoid
> > potential pitfalls where /proc/self/exe or similar would be executed
> > [1][2]. Reuse the "execute_no_trans" and "entrypoint" access vectors,
> > similarly to the file class. These access vectors may not make sense fo=
r
> > the existing "anon_inode" class. Therefore, define and assign a new
> > class "memfd_file" to support such access vectors.
> >=20
> > Guard these changes behind a new policy capability named "memfd_class".
> >=20
> > [1] https://crbug.com/1305267
> > [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@google.c=
om/
> >=20
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > Changes since RFC:
> > - Remove enum argument, simply compare the anon inode name
> > - Introduce a policy capability for compatility
> > - Add validation of class in selinux_bprm_creds_for_exec
> >=20
> >  include/linux/memfd.h                      |  2 ++
> >  mm/memfd.c                                 | 14 +++++++++--
> >  security/selinux/hooks.c                   | 27 ++++++++++++++++++----
> >  security/selinux/include/classmap.h        |  2 ++
> >  security/selinux/include/policycap.h       |  1 +
> >  security/selinux/include/policycap_names.h |  1 +
> >  security/selinux/include/security.h        |  5 ++++
> >  7 files changed, 46 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/include/linux/memfd.h b/include/linux/memfd.h
> > index 6f606d9573c3..cc74de3dbcfe 100644
> > --- a/include/linux/memfd.h
> > +++ b/include/linux/memfd.h
> > @@ -4,6 +4,8 @@
> > =20
> >  #include <linux/file.h>
> > =20
> > +#define MEMFD_ANON_NAME "[memfd]"
> > +
> >  #ifdef CONFIG_MEMFD_CREATE
> >  extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned =
int arg);
> >  struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx);
> > diff --git a/mm/memfd.c b/mm/memfd.c
> > index bbe679895ef6..63b439eb402a 100644
> > --- a/mm/memfd.c
> > +++ b/mm/memfd.c
> > @@ -433,6 +433,8 @@ static struct file *alloc_file(const char *name, un=
signed int flags)
> >  {
> >  =09unsigned int *file_seals;
> >  =09struct file *file;
> > +=09struct inode *inode;
> > +=09int err =3D 0;
> > =20
> >  =09if (flags & MFD_HUGETLB) {
> >  =09=09file =3D hugetlb_file_setup(name, 0, VM_NORESERVE,
> > @@ -444,12 +446,20 @@ static struct file *alloc_file(const char *name, =
unsigned int flags)
> >  =09}
> >  =09if (IS_ERR(file))
> >  =09=09return file;
> > +
> > +=09inode =3D file_inode(file);
> > +=09err =3D security_inode_init_security_anon(inode,
> > +=09=09=09&QSTR(MEMFD_ANON_NAME), NULL);
> > +=09if (err) {
> > +=09=09fput(file);
> > +=09=09file =3D ERR_PTR(err);
> > +=09=09return file;
> > +=09}
> > +
> >  =09file->f_mode |=3D FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
> >  =09file->f_flags |=3D O_LARGEFILE;
> > =20
> >  =09if (flags & MFD_NOEXEC_SEAL) {
> > -=09=09struct inode *inode =3D file_inode(file);
> > -
> >  =09=09inode->i_mode &=3D ~0111;
> >  =09=09file_seals =3D memfd_file_seals_ptr(file);
> >  =09=09if (file_seals) {
>=20
> Hugh, Baolin, and shmem/mm folks, are you okay with the changes above? If
> so it would be nice to get an ACK from one of you.

So far as I can tell, seems okay to me:
Acked-by: Hugh Dickins <hughd@google.com>

If I'd responded earlier (sorry), I would have asked for it just to use
&QSTR("[memfd]") directly in the call, rather than indirecting through
unnecessary #define MEMFD_ANON_NAME "[memfd]"; never mind, that's all.

Please do take this, along with the rest, through your security tree:
mm.git contains no conflicting change to mm/memfd.c at present.

Thanks,
Hugh

>=20
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index c95a5874bf7d..429b2269b35a 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -93,6 +93,7 @@
> >  #include <linux/fanotify.h>
> >  #include <linux/io_uring/cmd.h>
> >  #include <uapi/linux/lsm.h>
> > +#include <linux/memfd.h>
> > =20
> >  #include "avc.h"
> >  #include "objsec.h"
> > @@ -2366,9 +2367,12 @@ static int selinux_bprm_creds_for_exec(struct li=
nux_binprm *bprm)
> >  =09ad.type =3D LSM_AUDIT_DATA_FILE;
> >  =09ad.u.file =3D bprm->file;
> > =20
> > +=09if (isec->sclass !=3D SECCLASS_FILE && isec->sclass !=3D SECCLASS_M=
EMFD_FILE)
> > +=09=09return -EPERM;
>=20
> In the interest of failing fast, this should probably be moved up in the
> function to just after where @isec is set.  There are also a number of
> checks that happen prior to this placement, but after the isec assignment=
=2E
> While I don't think any of those checks should be an issue, I'd rather
> not to have to worry about those and just fail the non-FILE/MEMFD_FILE
> case as soon as we can in selinux_bprm_creds_for_exec().
>=20
> >  =09if (new_tsec->sid =3D=3D old_tsec->sid) {
> > -=09=09rc =3D avc_has_perm(old_tsec->sid, isec->sid,
> > -=09=09=09=09  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
> > +=09=09rc =3D avc_has_perm(old_tsec->sid, isec->sid, isec->sclass,
> > +=09=09=09=09  FILE__EXECUTE_NO_TRANS, &ad);
> >  =09=09if (rc)
> >  =09=09=09return rc;
> >  =09} else {
> > @@ -2378,8 +2382,8 @@ static int selinux_bprm_creds_for_exec(struct lin=
ux_binprm *bprm)
> >  =09=09if (rc)
> >  =09=09=09return rc;
> > =20
> > -=09=09rc =3D avc_has_perm(new_tsec->sid, isec->sid,
> > -=09=09=09=09  SECCLASS_FILE, FILE__ENTRYPOINT, &ad);
> > +=09=09rc =3D avc_has_perm(new_tsec->sid, isec->sid, isec->sclass,
> > +=09=09=09=09  FILE__ENTRYPOINT, &ad);
> >  =09=09if (rc)
> >  =09=09=09return rc;
> > =20
> > @@ -2974,10 +2978,18 @@ static int selinux_inode_init_security_anon(str=
uct inode *inode,
> >  =09struct common_audit_data ad;
> >  =09struct inode_security_struct *isec;
> >  =09int rc;
> > +=09bool is_memfd =3D false;
> > =20
> >  =09if (unlikely(!selinux_initialized()))
> >  =09=09return 0;
> > =20
> > +=09if (name !=3D NULL && name->name !=3D NULL &&
> > +=09    !strcmp(name->name, MEMFD_ANON_NAME)) {
> > +=09=09if (!selinux_policycap_memfd_class())
> > +=09=09=09return 0;
> > +=09=09is_memfd =3D true;
> > +=09}
> > +
> >  =09isec =3D selinux_inode(inode);
> > =20
> >  =09/*
> > @@ -2996,6 +3008,13 @@ static int selinux_inode_init_security_anon(stru=
ct inode *inode,
> > =20
> >  =09=09isec->sclass =3D context_isec->sclass;
> >  =09=09isec->sid =3D context_isec->sid;
> > +=09} else if (is_memfd) {
> > +=09=09isec->sclass =3D SECCLASS_MEMFD_FILE;
> > +=09=09rc =3D security_transition_sid(
> > +=09=09=09sid, sid,
> > +=09=09=09isec->sclass, name, &isec->sid);
> > +=09=09if (rc)
> > +=09=09=09return rc;
> >  =09} else {
> >  =09=09isec->sclass =3D SECCLASS_ANON_INODE;
> >  =09=09rc =3D security_transition_sid(
>=20
> We're duplicating the security_transition_sid() call which seems less
> than ideal, how about something like this?
>=20
>   if (context_inode) {
>     /* ... existing stuff ... */
>   } else {
>     if (is_memfd)
>       isec->sclass =3D SECCLASS_MEMFD_FILE;
>     else
>       isec->sclass =3D SECCLASS_ANON_INODE;
>     rc =3D security_transition_sid(...);
>     if (rc)
>       return rc;
>   }
>=20
> --
> paul-moore.com
---1463770367-1767593222-1757999268=:21221--

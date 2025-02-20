Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BA91FECCD
	for <selinux@vger.kernel.org>; Thu, 20 Feb 2025 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074051; cv=none; b=gkyCCUf7CBJaLNS1BFb9EJ9+ofeNMPfxTv4/dKEUpabLH9ah9D/oRuKR3GA3fypKGfQ6qTi7KeIroSjiliYDqip5FPp/Wh0nxAWVYdAAp5BJ91gZkUWhjVZPcPSMRnJCX5JBo/4OGAtkWlbYF2xCU7D3O+SSKDZxvDVEAsO434g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074051; c=relaxed/simple;
	bh=v9o39KN4rf7J0rFTCHfTh5J71196URRoypu2r0Y2nUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pqYuzgFyLNGeetMe12DepUMwgXWTKxVgq7bYNoVROXXJdMkgq+YCP0Sl7zybWE7dvnBFZui1gwKCQ6TMmaFa9XViZ6gThFBgAs1v8oKJUfgfjD484loGFUQHj2DVgYzgYFdvOAUILO9obBQE9PrbhVY11An4c776VaCDB8t4RZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GCU/qqwr; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GCU/qqwr"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6fb2a0e4125so8643177b3.1
        for <selinux@vger.kernel.org>; Thu, 20 Feb 2025 09:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740074047; x=1740678847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1HtEq2i29q2cCGod66wbAEwSCdOwa+YaZodXQk7MLA=;
        b=GCU/qqwr4ul3h2OA//qtA3Kg4HvKFJcc/I7Jpn7HUjvxUD/Z8pfsU24JR2YX/m+wLo
         m4GDKc1AKm5wQlC84gG7KfZpB4T23bqcpMFSRaIkoQOA3ylfjBwQGTwqkiO2SfUjd/Br
         JtC3+Bq2rvVy3CN3SQ3xAVIMcq/7Y5cvpyeGp8bmEf+2Ga9bPwDdJcjoglw27crknkrW
         l2dVg86ssi5I73ii6at15dvVlvwzLMTYVcywcHXluEb2bjWYDs8Ik0B4Mc2exrpXGTa+
         3t6jOLn5YAck5s38mmywQ4decwEscoGWei4hsR5/Ge8b3CGooQbIMUMVhKrUCdi8lt03
         BzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740074047; x=1740678847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1HtEq2i29q2cCGod66wbAEwSCdOwa+YaZodXQk7MLA=;
        b=Epu1RmSSgJ3LVWwY7KYhoiQcs5J62X/dY24lTYA25vbcSvpKedWJ/hkowEnPl2o59t
         k5AP/+Sdi4+FALdNB1evKKZmC2ZSfphZRn7QLEpHPYPS6BaDnUyslGKw4drQwWarBgau
         pvoyVQ3QYQmumrZ+hykCT4yKg6WgoNJe1eNvPbtQWvIYDICtoypg4FXQ5HUNcO6YMekd
         sZAGezGohXqDJmi+oVU5UoaBlB+7Jj1+98bTNxdmpMdKhZTnn5JfKNL/uoX3t+zKi7UA
         6xt3W3GL3Rv2P19j/5M7K0JrucwmPbv+92//INdXciNjcn42VF7C+EChhGjTbsfMAVbr
         ZJOA==
X-Forwarded-Encrypted: i=1; AJvYcCUKqMBU8Cm5l1xyM7q7almQgObYzX5+gvwM+WW0gnlc76jdkyhssyNg9BMzrq4gX1NKIEBzVBkb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/KTA7YJMJvgdKdrYL9wHbeq8ZOHQoiKjXpmKGhxSg2nTZru5b
	XrVLOyZALwAuTeMr7aaZnb4DjTsSX/+AJVcH+QA0GzGC7SF8aDoC5zC8wsZdyBuoLWROHx1XbZW
	Llkjz7l/ebknuixh9Ag9vOzTkfMTja/fVVTKM
X-Gm-Gg: ASbGncskn9YrP4vOqQN6GnnBgdvyOit5QS3nrdtY+APfZ8GUNi04GTPl31lCZ7xBmDK
	lMWuZqeId8ZpRiPBruyyjtwsOrX242UXIxEaw6F8rKwH/1F8PPCmGidxhaKZHGnTkLb2+GY0o
X-Google-Smtp-Source: AGHT+IHrPz3tW5dtSDxUsese0JE02d7KHywEHhvtKWjvvLDIJZskZ/lBY77itdhauU3533DejxGGJ4lZEYLYaXcdqdA=
X-Received: by 2002:a05:690c:360b:b0:6ef:6d61:c254 with SMTP id
 00721157ae682-6fb58355946mr175779697b3.38.1740074046600; Thu, 20 Feb 2025
 09:54:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023212158.18718-1-casey@schaufler-ca.com>
 <20241023212158.18718-5-casey@schaufler-ca.com> <CAEjxPJ56H_Y-ObgNHrCggDK28NOARZ0CDmLDRvY5qgzu=YgE=A@mail.gmail.com>
 <CAHC9VhSSpLx=ku7ZJ7qVxHHyOZZPQWs_hoxVRZpTfhOJ=T2X9w@mail.gmail.com>
In-Reply-To: <CAHC9VhSSpLx=ku7ZJ7qVxHHyOZZPQWs_hoxVRZpTfhOJ=T2X9w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 20 Feb 2025 12:53:54 -0500
X-Gm-Features: AWEUYZkT0XtBSwseF0EpgbYRnzcGcXTRcWyfKrtkB2GGxStsTDHjaiFMHWD25CU
Message-ID: <CAHC9VhQUUOqh3j9mK5eaVOc6H7JXsjH8vajgrDOoOGOBTszWQw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] LSM: lsm_context in security_dentry_init_security
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 12:40=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> On Thu, Feb 20, 2025 at 11:43=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Oct 23, 2024 at 5:23=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> > >
> > > Replace the (secctx,seclen) pointer pair with a single lsm_context
> > > pointer to allow return of the LSM identifier along with the context
> > > and context length. This allows security_release_secctx() to know how
> > > to release the context. Callers have been modified to use or save the
> > > returned data from the new structure.
> > >
> > > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > > Cc: ceph-devel@vger.kernel.org
> > > Cc: linux-nfs@vger.kernel.org
> > > ---
> > >  fs/ceph/super.h               |  3 +--
> > >  fs/ceph/xattr.c               | 16 ++++++----------
> > >  fs/fuse/dir.c                 | 35 ++++++++++++++++++---------------=
--
> > >  fs/nfs/nfs4proc.c             | 20 ++++++++++++--------
> > >  include/linux/lsm_hook_defs.h |  2 +-
> > >  include/linux/security.h      | 26 +++-----------------------
> > >  security/security.c           |  9 ++++-----
> > >  security/selinux/hooks.c      |  9 +++++----
> > >  8 files changed, 50 insertions(+), 70 deletions(-)
> > >
> >
> > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > index 76776d716744..0b116ef3a752 100644
> > > --- a/fs/nfs/nfs4proc.c
> > > +++ b/fs/nfs/nfs4proc.c
> > > @@ -114,6 +114,7 @@ static inline struct nfs4_label *
> > >  nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
> > >         struct iattr *sattr, struct nfs4_label *label)
> > >  {
> > > +       struct lsm_context shim;
> > >         int err;
> > >
> > >         if (label =3D=3D NULL)
> > > @@ -128,21 +129,24 @@ nfs4_label_init_security(struct inode *dir, str=
uct dentry *dentry,
> > >         label->label =3D NULL;
> > >
> > >         err =3D security_dentry_init_security(dentry, sattr->ia_mode,
> > > -                               &dentry->d_name, NULL,
> > > -                               (void **)&label->label, &label->len);
> > > -       if (err =3D=3D 0)
> > > -               return label;
> > > +                               &dentry->d_name, NULL, &shim);
> > > +       if (err)
> > > +               return NULL;
> > >
> > > -       return NULL;
> > > +       label->label =3D shim.context;
> > > +       label->len =3D shim.len;
> > > +       return label;
> > >  }
> > >  static inline void
> > >  nfs4_label_release_security(struct nfs4_label *label)
> > >  {
> > > -       struct lsm_context scaff; /* scaffolding */
> > > +       struct lsm_context shim;
> > >
> > >         if (label) {
> > > -               lsmcontext_init(&scaff, label->label, label->len, 0);
> > > -               security_release_secctx(&scaff);
> > > +               shim.context =3D label->label;
> > > +               shim.len =3D label->len;
> > > +               shim.id =3D LSM_ID_UNDEF;
> >
> > Is there a patch that follows this one to fix this? Otherwise, setting
> > this to UNDEF causes SELinux to NOT free the context, which produces a
> > memory leak for every NFS inode security context. Reported by kmemleak
> > when running the selinux-testsuite NFS tests.
>
> I don't recall seeing anything related to this, but patches are
> definitely welcome.

Looking at this quickly, this is an interesting problem as I don't
believe we have enough context in nfs4_label_release_security() to
correctly set the shim.id value.  If there is a positive, it is that
lsm_context is really still just a string wrapped up with some
metadata, e.g. length/ID, so we kfree()'ing shim.context is going to
be okay-ish, at least for the foreseeable future.

I can think of two ways to fix this, but I'd love to hear other ideas too.

1. Handle the LSM_ID_UNDEF case directly in security_release_secctx()
and skip any individual LSM processing.

2. Define a new LSM_ID_ANY value and update all of the LSMs to also
process the ANY case as well as their own.

I'm not finding either option very exciting, but option #2 looks
particularly ugly, so I think I'd prefer to see someone draft a patch
for option #1 assuming nothing better is presented.

--=20
paul-moore.com

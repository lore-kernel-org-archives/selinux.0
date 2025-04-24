Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A0F1FECBA
	for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745483495; cv=none; b=MPQYjYdTIeYrZtU6MMD8XUeGiWnnBJUgjRoHTEKDzHt8lgv1vM+K6NDsfneu32Y+tpz2XR8FmDNG4CoyC+broDp8h+NYHYU/dUqKeiENwOg4GdQ4Ct6e6iX24IToQWnihoJ/WC5jJIh6lEG0lEORJyIGoavTjvjUkyHfEAa/Xz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745483495; c=relaxed/simple;
	bh=4ozhKsoUuuDuD9qn+wh5JI1ABC5Lxm7tGXJ0CaulFFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/mwrl/0yp2s1UTY0Ggm9BJehcyyMjSaNyfNa6vzlq8tyyeqVnypoAGtDPGatwYMsPAxLNlY9AIbwi4IDXcKQxU8XS/5sPhuJnRk9ReghCxUTRbioafaqapfo0/PXD7dxFyJuR1PtTc8nS5qSA7kOVWelLTjfqIOgliW91kQD3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNdBcB8N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNdBcB8N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745483492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ezulh7H93TruHkxDVgBGBVzQ8blA4YXlyPIcOVG3ii8=;
	b=ZNdBcB8NxZ3ze3JepT8FmrX8eLoGMdotDqL8Kjh3FkYy1WSkC255fBUNV/W6VhacIp3tUc
	dpbejgH1o4lM7sVHcpxAFaBHm4ozcXjobzY5LMWdNj2iOJOcVz2vtDCNTzMGqTMo8Uk3wt
	KMFPmYHtVZ6vy77NwZpYDBtkf3oE1Ao=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-6incVQwCPnSeEeSf28J37Q-1; Thu, 24 Apr 2025 04:31:30 -0400
X-MC-Unique: 6incVQwCPnSeEeSf28J37Q-1
X-Mimecast-MFC-AGG-ID: 6incVQwCPnSeEeSf28J37Q_1745483490
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so781800a91.0
        for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 01:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745483489; x=1746088289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ezulh7H93TruHkxDVgBGBVzQ8blA4YXlyPIcOVG3ii8=;
        b=Zdts1VMvum3AKOwjPrqbhZgCE+mq4+D9nvBRWd5juhgGheywZfZDDOdn88wGWtLmBi
         PtInz+05xkF6v6zfaCxYQ51QD2MD9DsTmi5cOfzJ8m1t5mRQI7l4oiHkeyJQGBYSsj5f
         lC9Pn/29mWLUKOaMWV/JSmP7RKml6oEKgk6wYzgfaMZjfmDzyFlmlk6Hu1rB4GjlZK8P
         f0e7OhDTPvdn4SilIC4OM446JvjDSqWTIKPb+dbNw1QlOJBIvRiqX3o/oUAApo1lhON9
         qm8F879VNllnHYT6pAlnZpLcnq3sp6a8tvZ7pf37yRHlwymdq7ZsfyCN2lIjKd2JD6Bk
         y0eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf5YQNqCJLzajx6WYzfevHSzJRm9znKDE4cxUlGO1e/CriJI8d+unR1YRFsWMxOu3+brKavziq@vger.kernel.org
X-Gm-Message-State: AOJu0YzwEXwk5Kp5lYx9XzuEvBLteTRa0QHpuORU+gTNAGPkhOYVcjni
	FYl+fek1jtfhy7BLHONojZ7Pm3zdMmxtkf2bS3coF9Ow3ayYhqdxAr1IDFIPzmKJaQGgbG+zOo1
	S0rFVhdowpge4pNgnNgsni5svDptAOQnOv9fBkXxXoYyNJRNa/65OMGJjc+XOuOpAF0NXaPyhAC
	BA6Zg3eJz6X1ay6LJUcG9I2a+6LMoCBQ==
X-Gm-Gg: ASbGncvmzAIFCLzVNMfJBLKNnBdFuY+9kUuVpHVX0f9I9WoGfVwVL6RO2aO+dRB4Nl7
	N+KcQtmks3wzWHzMFgWbUtMG2pe992Tc0/XiOPOeAwgMzRoK6RJvOYc22W/PPW8IEw7U=
X-Received: by 2002:a17:90a:d64e:b0:2ee:aa28:79aa with SMTP id 98e67ed59e1d1-309ed24bc48mr2686015a91.6.1745483489411;
        Thu, 24 Apr 2025 01:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkCxukb1OePENhPTRG85WH0Mq2GlaOhU1VIEfP4idetHgT/gLlry3+D+w2lfle+VCQ+Upcy8KLJ2sQtOTMRPQ=
X-Received: by 2002:a17:90a:d64e:b0:2ee:aa28:79aa with SMTP id
 98e67ed59e1d1-309ed24bc48mr2685990a91.6.1745483488987; Thu, 24 Apr 2025
 01:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423175728.3185-2-stephen.smalley.work@gmail.com> <CAHC9VhR6gjRpR5-DDiSrnrSOa66Cjr7XyKRJSnsuLcNHi9UD2A@mail.gmail.com>
In-Reply-To: <CAHC9VhR6gjRpR5-DDiSrnrSOa66Cjr7XyKRJSnsuLcNHi9UD2A@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 24 Apr 2025 10:31:18 +0200
X-Gm-Features: ATxdqUEFY_H0EE7L2Xfm8LEAk1ti0DudEdoOHpTek-KUhVBbJHR3EAh4A4zw6HI
Message-ID: <CAFqZXNu8H8YQOtJ--V7q5HS=moCGaEfEQXERB13A3vrB5BZPgw@mail.gmail.com>
Subject: Re: [RFC PATCH] shmem: fix listxattr to include security.* xattrs
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	nvraxn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 12:32=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Wed, Apr 23, 2025 at 2:00=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > The vfs has a fallback to obtain the security.* xattrs from the
> > LSM when the filesystem does not implement its own listxattr, but
> > shmem/tmpfs has its own handlers. Consequently, it fails to include
> > the security.* xattr unless explicitly set by userspace, which confuses
> > ls from coreutils.
> >
> > Before:
> > $ getfattr -m.* /run/initramfs
> > <no output>
> >
> > After:
> > $ getfattr -m.* /run/initramfs
> > security.selinux
> >
> > Link: https://lore.kernel.org/selinux/CAFqZXNtF8wDyQajPCdGn=3DiOawX4y77=
ph0EcfcqcUUj+T87FKyA@mail.gmail.com/
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > NB This only handles shmem/tmpfs inodes, not sysfs or others.
>
> I believe applying a similar change to kernfs_iop_listxattr() should
> solve the problem for sysfs as well as a few others.
>
> We could also look at moving the security_inode_listsecurity() call
> into simple_xattr_list(), but I'm not sure what other implications
> that may have.
>
> FWIW, if we need to modify security_inode_listsecurity() it shouldn't
> be that hard, only SELinux and Smack provide callbacks and both are
> trivial.  In fact, there might be some value in adjusting the LSM hook
> to better match xattr_list_one() (even if the LSM supplies multiple
> xattrs), and then leverage xattr_list_one() (multiple times if
> necessary for a LSM) inside the LSM's callback.  That doesn't solve
> our problem, but it simplifies the LSM code and moves the buffer
> manipulation back into the VFS code.
>
> > It also doesn't handle the case where some xattrs are set on the inode
> > but not the security.* xattrs. Not sure if that's possible currently.
>
> Good question, I'm not certain either, but my guess is that if the
> filesystem has implemented its own listxattr code and omitted the
> security.* xattr listing, it makes use of xattrs for something other
> than SELinux/LSM.

Of course it does. At the very least user.* attrs are supported:
# touch /tmp/test
# stat -f -c %T /tmp/test
tmpfs
# setfattr -n user.test -v hello /tmp/test
# getfattr -d /tmp/test
getfattr: Removing leading '/' from absolute path names
# file: tmp/test
user.test=3D"hello"

We need to make sure that the correct size is returned from
listxattr(..., NULL, 0) regardless of what xattrs are stored in the
inode.

> > It would be problematic not to mention ugly to check for the presence
> > of a security.* in the buffer after the simple_xattr_list() call
> > since the buffer/size can be NULL/0 to just query for the buffer size.
>
> Sigh.  Yeah.
>
> If we know the filesystem is not persistent and we don't have to worry
> about other system boots, offline edits, etc. it might almost be
> easier to have simple_xattr_list() skip security.* xattrs (it already
> does this for trusted.* xattrs) and rely on
> security_inode_listsecurity() to supply the security.* xattr names.

We should preserve the ability to see and read/modify these xattrs
even when the corresponding LSM is disabled, so the skipping should be
conditional on security_ismaclabel() or similar. But yes, this looks
like the only viable way to go to me.

> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 99327c30507c4..49256ca11400c 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -4372,7 +4372,11 @@ static const struct xattr_handler * const shmem_=
xattr_handlers[] =3D {
> >  static ssize_t shmem_listxattr(struct dentry *dentry, char *buffer, si=
ze_t size)
> >  {
> >         struct shmem_inode_info *info =3D SHMEM_I(d_inode(dentry));
> > -       return simple_xattr_list(d_inode(dentry), &info->xattrs, buffer=
, size);
> > +       ssize_t sz =3D simple_xattr_list(d_inode(dentry), &info->xattrs=
, buffer,
> > +                               size);
> > +       if (sz =3D=3D 0)
> > +               sz =3D security_inode_listsecurity(d_inode(dentry), buf=
fer, size);
> > +       return sz;
> >  }
> >  #endif /* CONFIG_TMPFS_XATTR */
> >
> > --
> > 2.47.1
>
> --
> paul-moore.com
>

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


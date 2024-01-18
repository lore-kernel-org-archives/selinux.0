Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B46131734
	for <selinux@vger.kernel.org>; Thu, 18 Jan 2024 20:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705610835; cv=none; b=OeO/FNJQNjA4HVnye7sn0zlywsTuM4tMxz3FV11PskI+6FtM5pEgApdJLzzoUhbB1lWE4Z0APaeOes6hGv5zOtrHpwulBC9ty0G+kgXcmPKIaHX7GTpV0L5DbVPAnxf7X3Wy+l0k3yT0FflHsHr7eDvQv5dO9BrZnspIWR0aabg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705610835; c=relaxed/simple;
	bh=UfEodJeNaTwH4UMDk1Cw2F1AcAt4yD29THjCgOhg45I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DU66julHRPr8qtZTycNKpu40cAEJkz41JsMfvK+LzcQo1x8A/Uq794Tk+JX32xabekfajR0SdPIFuA/CY6g4LKWBTUYcTSQJW92GBQgU7re4jjK9BblswGWrNgDmZCK1m3QatiYKpRPQxX6dWPsP7oXqcYipH/K8lFsm05e4MrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeX+3K4J; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeX+3K4J"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d6ff29293dso400185ad.0
        for <selinux@vger.kernel.org>; Thu, 18 Jan 2024 12:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705610834; x=1706215634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6OB6pPG8IWyN+ydei12D612u+26njdDQ6ASytuVdYg=;
        b=VeX+3K4JvSYAA05UGRGw7aEaWgga/74vM3CaEPZCuoBPshcnO+GmNjxRbCXe2Sdrog
         f7icGPnURjdwXa20uWTinKxEbtVLurOjQUvNEg51D/WiJyaHmC8+QkLYuwI7FfSZjyrz
         TJJPNcWQRzORn0qoWXTVRGX1MYW+fmvvZKLAQxLrahjVoy7xKULG9+EiipLFp757uqTi
         kq9DY6Ml44KhsBoYV1RDcUObbKv3FntO0xRMI46MVi7RKfXBeA8f5/FQMrJA+Abr3n1D
         K5gAEPK90WzYNqNRJc5RU7BFTwVyCfbadiCGPh67aE8Fh26mxwgavfmMSyp5CCeUycbu
         oHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705610834; x=1706215634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6OB6pPG8IWyN+ydei12D612u+26njdDQ6ASytuVdYg=;
        b=Tl/vLDlxO4DfRv3gvQQP/dm0HGqS4CqDFPH/ddGrlHtnCNJOXT4ZL1Wehm/wXZlW/s
         uwiV/X5MbZnh9K/XrPixUbr3EAWTnugXyvzHW9QUCdwjnWeBLtbd30x9HNrKyAP/A79H
         GFqVkAmE1YIhH1kCLigwhykewv6xd87sEpd9kZpsKJ4WUD3yzzl2l0QAuZgdIYCyXJsI
         oh2k7oP9jMqH2iqLFw1+9Fm+YG+aj1/134Bu17JJ6i37OCerAaWLu9dlrQ9piW+igNd1
         j9nlGVkK1l2J70BUSCGcEBrnXXTV4q742lG41NuIJUYV+fFdQbVzcZJvgL4dsjL3p9eH
         mJ9A==
X-Gm-Message-State: AOJu0Yza9odkpuQ11/irvPhfFK/DtW+qJ2Tgr1qqyFwJi5zTsfx9h5Sk
	MINgvKj9UJjDuf1sVPtNVZ3OLIuYYmT5bcZeUJTtkxH61ItWgw0+3UTI8K3zyIhwlbNTn1b6oX+
	lYGGCdHiTVc3A6tocZnusUH8fTUrUgaF4aMw=
X-Google-Smtp-Source: AGHT+IFoT5m98Sa0cnQBxMaVDmO6kZpQCAEWm9t0vx1LIzz5XB+aQktSC+6VA0DYSSozpvwus/fldpBzcD5wt3mphH0=
X-Received: by 2002:a17:90a:9b88:b0:28f:ee9f:dc71 with SMTP id
 g8-20020a17090a9b8800b0028fee9fdc71mr1363679pjp.78.1705610833631; Thu, 18 Jan
 2024 12:47:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALbthtcf4m5vPK7xLZhzk8W_7ETkNPeR3bnaM06BtzuQy8w-jQ@mail.gmail.com>
 <CAEjxPJ7ZB3PtVjvJf9u-C7JGNpGv53O9TGu7o5EadMHy2hHE5w@mail.gmail.com> <CAHC9VhTpG=x-9Mm5b6xKtYoAswhtWA43FJqrwRHYbr3XwSPYeg@mail.gmail.com>
In-Reply-To: <CAHC9VhTpG=x-9Mm5b6xKtYoAswhtWA43FJqrwRHYbr3XwSPYeg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 18 Jan 2024 15:47:02 -0500
Message-ID: <CAEjxPJ4LOY5C3sd-oM8L_8fKC5QhrreBN7=GXR1uyYv_hphNVQ@mail.gmail.com>
Subject: Re: Race in security/selinux/hooks.c on isec->sclass and isec->sid usage
To: Paul Moore <paul@paul-moore.com>
Cc: Gabriel Ryan <gabe@cs.columbia.edu>, omosnace@redhat.com, selinux@vger.kernel.org, 
	dpquiql@davequigley.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 3:19=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Jan 18, 2024 at 12:02=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Jan 18, 2024 at 11:26=E2=80=AFAM Gabriel Ryan <gabe@cs.columbia=
.edu> wrote:
> > >
> > > We found a race in selinux for kernel v6.6 using a prototype race
> > > testing tool based on modified KCSAN we are developing. We are
> > > reporting the race because it appears to be a potential bug. The race
> > > occurs on isec->sclass and isec->sid, which are set in
> > >
> > > security/selinux/hooks.c:3329-3330 selinux_inode_post_setxattr
> > >
> > >         isec->sclass =3D inode_mode_to_security_class(inode->i_mode);
> > >         isec->sid =3D newsid;
> > >
> > > Where isec->lock is held when isec->sclass and isec->sid are set abov=
e
> > > but not held when they are read in the following 3 locations:
> > >
> > > security/selinux/hooks.c:1671 inode_has_perm
> > > security/selinux/hooks.c:3125 selinux_inode_permission
> > > security/selinux/hooks.c:3690 ioctl_has_perm
> > >
> > >
> > > This seems like it could lead to undefined behavior if multiple
> > > threads are reading the isec struct and updating it concurrently,
> > > (e.g., reading an old isec->sid value but new isec->sclass value).
> > >
> > > In some other cases in security/selinux/hooks.c, isec->lock is held
> > > when isec->sclass and isec->sid are accessed, such as in
> > > security/selinux/hooks.c:4942-4945 selinux_socket_accept. Therefore,
> > > extending the isec->lock to cover when sclass and sid are read from
> > > the isec struct in these three locations might be a suitable fix.
> >
> > isec->sclass should only really need to be set once when isec is first
> > initialized after mode format bits have been set.
> > Not sure why it is getting assigned again in post_setxattr.
>
> There is similar odd behavior in selinux_inode_setsecurity().  Looking
> at the other places in hooks.c where we are setting isec->sclass, I'm
> wondering if this is a copy-n-paste from one of the other places that
> does have a need for it.  The pattern of "lock, set the sclass and
> SID, mark the inode as initialized, unlock"  occurs in at least three
> places that I can see in a quick search.

git blame indicates that the setting of isec->sclass was added to
inode_post_setxattr() and inode_setsecurity() by commit
aa9c2669626ca7e5e5ba ("NFS: Client implementation of Labeled-NFS").
Not sure why - do NFS inodes get initialized in some manner that skips
the usual setting?

It's fine to set it in inode_doinit_with_dentry() when initializing
the inode security blob for existing inodes and in
selinux_inode_init_security() for newly created ones - no other thread
can be reading it at that point. selinux_task_to_inode() is a special
case for /proc inodes.  selinux_socket_post_create() and
selinux_socket_accept() should set it before the socket can be
accessed by userspace or via an incoming packet.

>
> > In general, handling of isec->sid needs an overall cleanup but putting
> > that within isec->lock would be a big hammer.
>
> Yes, that would be an absolute last resort.
>
> I agree that our approach towards inode_security_struct in general
> could use some attention, I would encourage anyone who is interested
> in cleaning things up to do so.
>
> > Proper use of READ_ONCE/WRITE_ONCE or smp_load_acquire/store_release
> > may suffice.
>
> My guess is that READ_ONCE()/WRITE_ONCE() should be sufficient as I
> don't believe we are overly concerned about strict synchronization
> between cpus, but I will admit that I'm far from an expert on memory
> ordering issues.  If someone believes another approach is needed
> please do speak up.
>
> --
> paul-moore.com

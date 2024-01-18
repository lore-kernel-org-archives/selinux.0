Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2E62EAF9
	for <selinux@vger.kernel.org>; Thu, 18 Jan 2024 21:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705614756; cv=none; b=nUy+tXg6h7RVbdvW5t4L+jDrjFEcjHqnkICDWW14or4yG2us8hYmhYyzvX9EwvluFSMS1t/yMjpHQ0Ywa9f4jxuFYcGpqOU8HS0ghZP6zIWFpp4pgcZS8SJ5jYYtmK6Zn0tOYoX5/DVW6wzZWnE+VTKN//qXM165lzgv2IatJrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705614756; c=relaxed/simple;
	bh=/CqRryZaZU/6rlzsXseIPu+Hheahn0SockIDercIkQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYMMBohnqbmXPlniEgOr2PyXv86cYji4KLaVRzEVcqdeNA0+5HEHOTPUKGcdHCKnIlNzb6YHL/vxbbpaolm0/4BRrs+4uFIVBcafbdC+RY/GtKE7eLtcCIh6B9hFdHHuvD5O1lRWcSpEAqA0Uf5exV5Jti50xGigQAnI5qlc18Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bkRBw+iM; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bkRBw+iM"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc25099b084so152709276.0
        for <selinux@vger.kernel.org>; Thu, 18 Jan 2024 13:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1705614753; x=1706219553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8HIGjxYwN5XuNpb9IkPXEAI9fVQmusKMEeJ58NSSCc=;
        b=bkRBw+iM3azD/6/65yZ4P8sTwuyAJek38E0G1QRw/yddvwGYA6LNXAP046IiO+RcYA
         z4yiTT/UdwdMnJF9CSFp/JgHOVN+IlMYIEk06KgMhqB39wh2GS8wC78Wdl5ll7u0S1ZK
         sz3pslk7GyoKtXEC4aKr7e8Ye62F2jifCBl8XYZtqXVyVFCDlniIcUt8Fi2bgoG1nKUC
         yHBUttXIAoIcp3Ab1l757QCmzg4nUzUko+dwFClM/RbIvqPc2gLVhsELB2Vbrqon0jvu
         7Uws+SW4lU2xnfkp9WjC3O4b/56fa9E8OwMsUNta4STOxR6cNGIy2jC5xXUGJpJzd8Fs
         VXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705614753; x=1706219553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8HIGjxYwN5XuNpb9IkPXEAI9fVQmusKMEeJ58NSSCc=;
        b=rSWN3Bdts1AidJiMSYeNWhqoxzxQHYokYK0jULzQdnahBY+YqFL5DmCxYztndjhRaI
         2Xi2nOH5fLRJPceG/hJLFxvEJfAj/J5xpYiP7pNpEPBCje+bbVCd2ILlzNyVlX0K/dQZ
         YOsy3XhCSHUEaAQA0hC/tyIBuuQMftWhN2AT/kL5S1/ORqHKSSCJs/MEUjCrE/Zn7H3G
         8OCSFc107Pi9bOiuCN8P7YSXxYK8sJlwjWO5B6kRszJf5ersnV6yOqLPVNdBmCm0DQ2C
         4yu1SX1Yj913JXgpc9ReDL4hdUnVaaLCETpA1zAo1QL9P/lAcpFWtbb+m++efCnqfBeG
         PLoA==
X-Gm-Message-State: AOJu0YwjDmbqP3OijUoexH0H1YZxRNgOe61J3riKXq6lliCpy6tlahxA
	gt1wuQgP+x6gEth6UgRC7WMuYI1q260G4uHUxllbXJ/mqvcBZvu/GLjOUXGcMZndOeup6ck0kqC
	xrRlq8uVk30vrU0S80gFeeawJwO1AgzTDH1nV
X-Google-Smtp-Source: AGHT+IEWstVKyZ9KEZGhtqgWiFDwufv9KWd2iUCJSmxDdl/hcgVgblS2X8NvWfu3nflYR3J4f7ej6neasXONUG1Dkkw=
X-Received: by 2002:a25:abb1:0:b0:dbe:6985:66fd with SMTP id
 v46-20020a25abb1000000b00dbe698566fdmr1246548ybi.119.1705614753378; Thu, 18
 Jan 2024 13:52:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALbthtcf4m5vPK7xLZhzk8W_7ETkNPeR3bnaM06BtzuQy8w-jQ@mail.gmail.com>
 <CAEjxPJ7ZB3PtVjvJf9u-C7JGNpGv53O9TGu7o5EadMHy2hHE5w@mail.gmail.com>
 <CAHC9VhTpG=x-9Mm5b6xKtYoAswhtWA43FJqrwRHYbr3XwSPYeg@mail.gmail.com> <CAEjxPJ4LOY5C3sd-oM8L_8fKC5QhrreBN7=GXR1uyYv_hphNVQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4LOY5C3sd-oM8L_8fKC5QhrreBN7=GXR1uyYv_hphNVQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 18 Jan 2024 16:52:22 -0500
Message-ID: <CAHC9VhSnbU_0WEFVrgm2rakNg3aeCs2OE1of0BavgOTmJWwnAQ@mail.gmail.com>
Subject: Re: Race in security/selinux/hooks.c on isec->sclass and isec->sid usage
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Gabriel Ryan <gabe@cs.columbia.edu>, omosnace@redhat.com, selinux@vger.kernel.org, 
	dpquiql@davequigley.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 3:47=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Jan 18, 2024 at 3:19=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, Jan 18, 2024 at 12:02=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Thu, Jan 18, 2024 at 11:26=E2=80=AFAM Gabriel Ryan <gabe@cs.columb=
ia.edu> wrote:
> > > >
> > > > We found a race in selinux for kernel v6.6 using a prototype race
> > > > testing tool based on modified KCSAN we are developing. We are
> > > > reporting the race because it appears to be a potential bug. The ra=
ce
> > > > occurs on isec->sclass and isec->sid, which are set in
> > > >
> > > > security/selinux/hooks.c:3329-3330 selinux_inode_post_setxattr
> > > >
> > > >         isec->sclass =3D inode_mode_to_security_class(inode->i_mode=
);
> > > >         isec->sid =3D newsid;
> > > >
> > > > Where isec->lock is held when isec->sclass and isec->sid are set ab=
ove
> > > > but not held when they are read in the following 3 locations:
> > > >
> > > > security/selinux/hooks.c:1671 inode_has_perm
> > > > security/selinux/hooks.c:3125 selinux_inode_permission
> > > > security/selinux/hooks.c:3690 ioctl_has_perm
> > > >
> > > >
> > > > This seems like it could lead to undefined behavior if multiple
> > > > threads are reading the isec struct and updating it concurrently,
> > > > (e.g., reading an old isec->sid value but new isec->sclass value).
> > > >
> > > > In some other cases in security/selinux/hooks.c, isec->lock is held
> > > > when isec->sclass and isec->sid are accessed, such as in
> > > > security/selinux/hooks.c:4942-4945 selinux_socket_accept. Therefore=
,
> > > > extending the isec->lock to cover when sclass and sid are read from
> > > > the isec struct in these three locations might be a suitable fix.
> > >
> > > isec->sclass should only really need to be set once when isec is firs=
t
> > > initialized after mode format bits have been set.
> > > Not sure why it is getting assigned again in post_setxattr.
> >
> > There is similar odd behavior in selinux_inode_setsecurity().  Looking
> > at the other places in hooks.c where we are setting isec->sclass, I'm
> > wondering if this is a copy-n-paste from one of the other places that
> > does have a need for it.  The pattern of "lock, set the sclass and
> > SID, mark the inode as initialized, unlock"  occurs in at least three
> > places that I can see in a quick search.
>
> git blame indicates that the setting of isec->sclass was added to
> inode_post_setxattr() and inode_setsecurity() by commit
> aa9c2669626ca7e5e5ba ("NFS: Client implementation of Labeled-NFS").
> Not sure why - do NFS inodes get initialized in some manner that skips
> the usual setting?

I don't know, but I wouldn't be surprised, we've definitely had to do
some NFS-specific things over the years.

> It's fine to set it in inode_doinit_with_dentry() when initializing
> the inode security blob for existing inodes and in
> selinux_inode_init_security() for newly created ones - no other thread
> can be reading it at that point.

Yes, when I said "odd behavior" I was trying to get at the original
discussion that it doesn't make much sense there, regardless of the
safety.  I can potentially see a need for it as-is in
inode_doinit_with_dentry() but I haven't chased down all the call
chains as that would take a while, and like you say, it should be
safe.

> selinux_task_to_inode() is a special case for /proc inodes.

Yes, I believe that needs to stay.

> selinux_socket_post_create() and
> selinux_socket_accept() should set it before the socket can be
> accessed by userspace or via an incoming packet.

Agreed. (it looks okay there as-is)

--
paul-moore.com

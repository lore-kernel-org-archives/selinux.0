Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5562701CF
	for <selinux@vger.kernel.org>; Thu, 19 Mar 2026 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945061; cv=pass; b=j3eWPPKePMusgGJoePzQsSQ6NKBG6r0itXRrMhDA+PbM8T/8EAT6cjYj5MAr4HPy3BQ+eG8xbMYI19FXjcExDDG8i/WLgr8DD/IAlZLDwLgDOk6xa75f14o2hAYA7GZ0kri8K3jU2+d2GTX98cA8yV5cL43jgEEEosm3IHMeANY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945061; c=relaxed/simple;
	bh=XDXiDxThcJliysAkHl5an+e0+DrYLc2/sF3Jz2IJVXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4eiwRnz7oQjiiKiYIBqLGS569VKbooN9iHSDyXxq1ePp6iC1/ozQOyiSGEeWgqjzo+I4nPVZO3EQ9kbOCK6XGo32qTqkmbjtJN1rY5xhLr0YiHQyLy29CxeqpobZHXkjls1ZeK5XMHa8uIfIke3AGBizKKKBaBNtOB/AaM6qRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcSz+E/w; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcSz+E/w"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so176217466b.2
        for <selinux@vger.kernel.org>; Thu, 19 Mar 2026 11:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773945058; cv=none;
        d=google.com; s=arc-20240605;
        b=K6o8e95anbEJ6gO2oo2fCDCC1Upu5V5+5ifGRi8OCoXYiY3vVaQiwJ5p3gcwciGHhd
         oPR+NwK84UVytQqfiehdnbqHqb6D36mAQf31f/JxsLfJlR2iYUMB33U9QzgAUpRsweLB
         wYPLHzizLLi51kHnRqWSHUsWgJCmHAHBF68MmJJpVCR+p4VWZ76YvhTkCvOi1NNV2k/T
         VpZg9t2JreokcvFULOwIODq9KTmMWZCPJ2TFGGo269qNQt73q6WXXxCfz84bRxJuWpLZ
         zUl50zDuZhjYoZ9AYQ+NC7Rxe5FHu+ch/Jl8GqG1MGspPqjheO1pYFQedJsfV2UTsd1b
         GQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FJV4dFXvSmt1MChF30a7mY59ejZaZEAqv6m7VOg5tb8=;
        fh=gWDEF9puyonbfQMcPzzcq71k2ehBlpsoF8TX6VNFgPY=;
        b=RG7VAVhg5U7TwJ7sGl5R1lakkRG3ODOB35Zxlr+2Tvxq7ffSzRNvvq9uIExH6jUzb7
         pyOuj72lPuzgtkdJIL8VJ/Na6F73ce1ceq88l0WMl8+45P/J/C9UtSXiIn7DIMJQGUFE
         knliHhONtuTmGXUbKvE3ZR0K5puG9NGD06FgMO5iSQEFjtL2MBdG3i3E/v2WJnvg4Tuz
         FaDHpDDjEESDojNbjKa68oALOSP1a6PqQwg0nrfjzkjrayzwMWeXv08iYFFr6cQ2nfqv
         EEE5gLuuuEpQlJ1plgSbsizmryTHiTKcRfCePoCxCCaqWj49MBq9Q8EwJZOBkZjoaiiV
         hkJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773945058; x=1774549858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJV4dFXvSmt1MChF30a7mY59ejZaZEAqv6m7VOg5tb8=;
        b=LcSz+E/waUBYWjrBULqICHmRq3sGno9OwdMcFklTglWFJAnfzjhBHoyzPO8OvBD1g0
         gmLsSGj/SJV0JyuM4YSYSqhy6IGjJQ7S0IBuyHcMSFJ97TH93VFPWNibfo/7i81T5nNI
         FRXvIUGI1XconIdavPnjdxn0JeBlvfRKXvsae6DUrTFxZU0B1eO8QbAJjzkzGpypOo4X
         g14i1xPf7MjCHoQcJRHHNZYZyEF6vLGM4J0ej6/U4vbfvhS/TKp49DhpLsfmRSjNUVFU
         QAT2JyDDlwtVxmHc/30JYZKye4h5gwJAt3Gtv9hUgDQrFQ3gT2LLqrvwb6TyGKauSrRg
         wb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773945058; x=1774549858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FJV4dFXvSmt1MChF30a7mY59ejZaZEAqv6m7VOg5tb8=;
        b=E0LZ3vIMsC6bt5mN83YjoIFhuC1KNlo1dOv3gWS86+j4tI2A8ibgpNcnxUUzADwwg6
         24v6dN/4xWVdCNWAuoWOfLc6lktk7sTOMuR5eTfuo8PntsCR6CnF6L4dzTIPuLv9qXfl
         HcUGYxx6N6TkNuMxI+DgbyYFi0/XVq5VyTuFI1oMhEDSBfEYGU9gf46l/oSnBDlpNYeW
         kffhqShy5rtkT1JCBbRMR2TZmrz4oeeMKa4a1oc16Ggs5IoJx+ecpOGBCDWSw4+/aavs
         g+L5s2F83XEmzXhSiYUHy6LpcD6sUKaq3uerN+jaZsTRxsQsZTi3Xe51Qel7Cfn8qfUy
         kWeg==
X-Forwarded-Encrypted: i=1; AJvYcCWEbKtWGqKPvQGIpJOTpez9ASUdsgOTV8e4USObxw5fXBouViTo5KKeKPiFcB+rq3xEtZZ8Uc41@vger.kernel.org
X-Gm-Message-State: AOJu0YykthIO/KFPBolO+mUuTPRh/D1z5XkmCQVwPfZ/zterPRgqW6QW
	nplXdh+/6YIFYGo6oOlS7p8aDIvN0NLinI/3NmVhidUyVG3NJXsTREMrN2Z03SmiWJIt6ORB9yf
	7E/8klivgxVfvQQRC/BZjGpxI3BlQbAU=
X-Gm-Gg: ATEYQzyAGdYcdK2EGjo0GmG5M3qcYJEKr7KhIVX2o29LVbS7TSVQsSkUHpGhDoWMtRe
	UbPUiWbF/ly6wV5Nyind7EwKcKfqvjnEiNnRkUmC9FLpdZxzJ738xRxkK9TXNzkp4jlrYOtZWs7
	rdgE7YEpUCVGa2kHp/FB7jbQPc5pydUZp+OpAmtxJAF8LPlnh3i8uhpTaweblc4sSXg6eSaXGWz
	fXGi2i3qFSwMghk2GE3De6RA4X5Rt01Uj7WeOaoXOh3PkpZt7+sBFXucDcO+Q0i8+bKzfIsGJLh
	D4U0NfWt8KMCSbTdO/bv8Ye2Iinun4dPG9F41tx0Gw==
X-Received: by 2002:a17:906:c802:b0:b93:a3db:a68c with SMTP id
 a640c23a62f3a-b982f3e0617mr18697866b.40.1773945058029; Thu, 19 Mar 2026
 11:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319124616.1544415-1-amir73il@gmail.com> <20260319-unentbehrlich-reitturnier-f78d9fb01230@brauner>
 <CAOQ4uxiS1uM=mn4q6CQfganba1XcqyXYmXfQceWdfUVRFK_Pvg@mail.gmail.com> <CAHC9VhQDXHh_=X-OKD9oN8fapVXBwLakNp4rEHLUL0cQ1RSteA@mail.gmail.com>
In-Reply-To: <CAHC9VhQDXHh_=X-OKD9oN8fapVXBwLakNp4rEHLUL0cQ1RSteA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Mar 2026 19:30:46 +0100
X-Gm-Features: AaiRm52lvBNmAkQT7DVWo0zF8FRRxYDmyiueu4eOodN3UFl0EjhqJc-Pr5qKv7g
Message-ID: <CAOQ4uxinSLXKWjMgwyA2A_UU5e+6ZjbdsFUY-+f9DMfQcxH0qA@mail.gmail.com>
Subject: Re: [PATCH] fs: allow vfs code to open an O_PATH file with negative dentry
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, 
	syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 4:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Mar 19, 2026 at 10:50=E2=80=AFAM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> > On Thu, Mar 19, 2026 at 2:13=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > > On Thu, Mar 19, 2026 at 01:46:16PM +0100, Amir Goldstein wrote:
> > > > The fields f_mapping, f_wb_err, f_sb_err are irrelevant for O_PATH =
file.
> > > > Skip setting them for O_PATH file, so that the O_PATH file could be
> > > > opened with a negative dentry.
> > > >
> > > > This is not something that a user should be able to do, but vfs cod=
e,
> > > > such as ovl_tmpfile() can use this to open a backing O_PATH tmpfile
> > > > before instantiating the dentry.
> > > >
> > > > Reported-by: syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >
> > > > Christian,
> > > >
> > > > This patch fixes the syzbot report [1] that the
> > > > backing_file_user_path_file() patch [2] introduces.
> > > >
> > > > This is not the only possible fix, but it is the cleanest one IMO.
> > > > There is a small risk in introducing a state of an O_PATH file with
> > > > NULL f_inode, but I (and the bots that I asked) did not find any
> > > > obvious risk in this state.
> > > >
> > > > Note that specifically, the user path inode is accessed via d_inode=
()
> > > > and not via file_inode(), which makes this safe for file_user_inode=
()
> > > > callers.
> > > >
> > > > BTW, I missed this regression with the original patch because I
> > > > only ran the quick overlayfs sanity test.
> > > >
> > > > Now I ran a full quick fstest cycle and verified that the O_TMPFILE
> > > > test case is covered and that the bug is detected.
> > > >
> > > > WDYT?
> > > >
> > > > Thanks,
> > > > Amir.
> > > >
> > > > [1] https://syzkaller.appspot.com/bug?extid=3Df34aab278bf5d664e2be
> > > > [2] https://lore.kernel.org/linux-fsdevel/20260318131258.1457101-1-=
amir73il@gmail.com/
> > > >
> > > >  fs/open.c | 7 ++++---
> > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/fs/open.c b/fs/open.c
> > > > index 91f1139591abe..2004a8c0d9c97 100644
> > > > --- a/fs/open.c
> > > > +++ b/fs/open.c
> > > > @@ -893,9 +893,6 @@ static int do_dentry_open(struct file *f,
> > > >
> > > >       path_get(&f->f_path);
> > > >       f->f_inode =3D inode;
> > > > -     f->f_mapping =3D inode->i_mapping;
> > > > -     f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> > > > -     f->f_sb_err =3D file_sample_sb_err(f);
> > > >
> > > >       if (unlikely(f->f_flags & O_PATH)) {
> > > >               f->f_mode =3D FMODE_PATH | FMODE_OPENED;
> > > > @@ -904,6 +901,10 @@ static int do_dentry_open(struct file *f,
> > > >               return 0;
> > > >       }
> > > >
> > > > +     f->f_mapping =3D inode->i_mapping;
> > > > +     f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> > > > +     f->f_sb_err =3D file_sample_sb_err(f);
> > > > +
> > > >       if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) =3D=3D FMODE_REA=
D) {
> > > >               i_readcount_inc(inode);
> > > >       } else if (f->f_mode & FMODE_WRITE && !special_file(inode->i_=
mode)) {
> > >
> > > I think this is really ugly and I'm really unhappy that we should adj=
ust
> > > initialization of generic vfs code for this. My preference is to push
> > > the pain into the backing file stuff. And my ultimate preference is f=
or
> > > this backing file stuff to be removed again for a simple struct path.
> > > We're working around some more fundamental cleanup here imho.
> >
> > Fair enough, we can rip the entire thing from vfs if you don't like it.
> > The user path file can be opened and stored internally by selinux
> > without adding all the associated risks in vfs.
> >
> > Paul,
> >
> > Please see compile tested code at:
> > https://github.com/amir73il/linux/commits/user_path_file/
>
> No.  Definitely no.  Ignoring the fact that there is no reason we
> should pushing this into the LSM, doing it in this way means it is
> very likely that each LSM wanting to provide mmap/mprotect controls on
> overlayfs will have to create a new O_PATH file.  No.
>
> ... and let me preemptively comment that this doesn't belong in the
> LSM framework either.
>
> As Christian already mentioned, this really needs to be addressed in
> the backing file code, please do it there.
>

OK, will give it another try.

Thanks,
Amir.

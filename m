Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B5E1CD2C
	for <selinux@vger.kernel.org>; Fri, 20 Mar 2026 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774008931; cv=pass; b=d6ONHctUecF5INPcXV+y9FSDJicwZUUqaye/P3I32RMlzS05rbW7ede3vUiyitLO6a7OVFRDlU/a/m7r5GSxOP+b/Lrgg58hPJISBOLiYTZK+E85gIjHJvL6X1wP1fU29EV1Ui3eA2BbzEXo86yTOXS6YIBX+125tO9qxS7eBME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774008931; c=relaxed/simple;
	bh=izlGddYzHIX3u/F5VuyEk/1zjiht7pRMDL5Lijk+cYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTp/5d/dYN0qWo/vaPfQM9jqFcqTUUqfZJuklqp5NyOHYJQoMkCcIScpIQJO8AmqSoFEJ3lDGq7EirwphtS4KsRNn5uEYlMYpyb3+33xxJLscbuftnd8Funxnup+fEQFSTS2VWw+cRSpOPwbGV2MRAW7qAfkLUuu524d/NTf+rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESlHZn9/; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESlHZn9/"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9825ba7f9dso165848066b.0
        for <selinux@vger.kernel.org>; Fri, 20 Mar 2026 05:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774008927; cv=none;
        d=google.com; s=arc-20240605;
        b=PUnD2gi4j2eWSJ6EFSsmGRQ2duBibJNewNH4+cgXNsgDpqB+54J/rl3ZyJcwzERM51
         CiKncctfdAjaFvCC2OjgWr8a56W98AqWlc2Hqh5YmsJKZB2NC0vhuN2YbNd5aPkW8Ypm
         qf9cFO6c8LZCom9bCJ9S7OiM6H/wW4eFvGZxke74BuQfvSOOm92AwoeZyhpFnWs5/5So
         5CkXrEyhS1CrU4f9LAB+XUxSO0+bgtTAzSS3i1ZDpehzpCsSe/HSZUNBJ0dbWFXBvJ0S
         ZPFf9jWlOKi4B9JaxvufQev3C8DIb4XInqzMJZs+BtoM89olI5K8k+i+RiTHlEvM5url
         Wfyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WBpgvBLWMC/0BhjOb7jBuNoEBM9BBGEAVw/zBHqxLZw=;
        fh=z9o+A01rRj03d0nPdNk8Br/H2+l0akUeQ25wGP2wYQk=;
        b=esebRsHmsTjWJZGbdN5kSrvKeu11vpIKYlXHYevJ1p9G/ch9+8D6pf4zr+gb8/wT1l
         DaVUwW2V/e92+kSV0w8Tc0SXx4oXpg73JhxvWRH1eRSXCT/3tt/iChIoqIGgDi99uRel
         sRwgyAXsxaI5tUwpzR0c88wU059UicPNUrbppHZUX7tNHkETZjZHdzFQShxL6ftSfU6t
         CBZZ4rKBlDvofjEqRJMdqFIvZs9lwh06JaDutIIWeJZSySYr/YXzZqJBgmmhKgXYCJQN
         PegPWUJtBtvY5STa+3t8mj5L6IpbX0cEidiNqiGttFsGFf68bMHeIwynI8jiXIsrarnc
         ZRyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774008927; x=1774613727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBpgvBLWMC/0BhjOb7jBuNoEBM9BBGEAVw/zBHqxLZw=;
        b=ESlHZn9/ydl4opGMk8RGdey2V4X91ombcGW8WPRXud/oEEiKm5L3BLjElFcCwgm6Dm
         8WtHa2JdU+WkM5acYtOi7/q/vPq8YwS9aGNZZLY3pEctwjhG8N5+oApX71uhqmDPWkgm
         9GdoLDBnPJNLtfM/nlaPcAq/Zs3A2rcMFdz07rFajTn/HvCTgE8stMVdjWV7Sdl5cnHA
         ROM89i9fYxxbFMdsfhjDUS1hEgu3t/IHlkDWQgtQdub4bQzvdwMDoLZB6HyrvMSWBobt
         qSbtcTaLd+Ic/A6cPtsUwNmt5EE2g5cOOTVsZ9CIxrbUUeyABYjh9bKjAz29/RN8Q1L8
         F0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774008927; x=1774613727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WBpgvBLWMC/0BhjOb7jBuNoEBM9BBGEAVw/zBHqxLZw=;
        b=DBFLRoOn5SGhtPU0V083IinaGtBmdXwwzg6d3tmRs8vKP49uXfUDAgtqYAe1fsRKCM
         yJ0C6u7d54U85ta4/rBOVAIG6OZNGrOYgSqUlAz9SQVxX0nyXxLoLMHu6iuvZOJ/2U+N
         cBmIlezYbaBAjSPGnLJumKGcwamGz3xuNj7w2j8bpXMyBKQHFhd1/2nC0BZElZmFA4jY
         VjW/0zlHwFiR761vYObABEhZcGTO7WvKSF9TEhODz0rxzJs9BuPIPKSYV1H7bCYC2MFF
         2I25wYfwXAXhX50ikoSXipGEU1pIdmKpNz5Y+IuRl3p6iGTSC6h2oazsqu9JEONJ/h1+
         iDOg==
X-Forwarded-Encrypted: i=1; AJvYcCXhvcca/7uIph0q7mnCf4XF1rJxadr7ovTU5pa4EAn3HqBXcOqbPwADzgZ1yxGFkovhUNfFzTvO@vger.kernel.org
X-Gm-Message-State: AOJu0YymzsLt7s+DZypV/HLWGeaWQ7u/TVd+IQ+sGbnUCTLxCuZL50Dh
	7ewVstqCzIZJolBvMGgNk7696gjEeqV8qzZ4jxQZPtY4T/KTahUq08VXpFWAGy1nFTlX3sZwgJl
	UlBdOa9N/T2oLiZaOdN3HnBssAQ89WLk=
X-Gm-Gg: ATEYQzxP0+cH+S0HZafOp4tPKIwLbS9LyxcDz0iPkelnvv3fTYMnHHcZwve/LcGXcP/
	fw8Hp94xnw7FQhdVFqgGbbRgd4pnwBhkm5wtVT1UXZVCoGkb5Acz9lGNUHK5FS4aciaymArSCfO
	WOj9JA+oeWQ02uEwmXUxu9RR60+95OcLO/RsyrGBs5bPc9FoRL4C8Y8uQ/Qaf/kZK9Indk5BxBB
	Kt+BnskuCDWU2A/YuZnJF5uolLEpxXE4IYiuqaTa6zPBTeOWkZ9nRtJqFFLq/UzaGSnexLhxVvi
	xQl8U1cz9ossfdRqoWhDt4zPf2xwQyAmh78wh3dkcA==
X-Received: by 2002:a17:906:37cb:b0:b97:f2cc:8c3e with SMTP id
 a640c23a62f3a-b982f39b197mr137796766b.10.1774008926368; Fri, 20 Mar 2026
 05:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319124616.1544415-1-amir73il@gmail.com> <20260319-unentbehrlich-reitturnier-f78d9fb01230@brauner>
 <CAOQ4uxiS1uM=mn4q6CQfganba1XcqyXYmXfQceWdfUVRFK_Pvg@mail.gmail.com>
 <CAHC9VhQDXHh_=X-OKD9oN8fapVXBwLakNp4rEHLUL0cQ1RSteA@mail.gmail.com> <CAOQ4uxinSLXKWjMgwyA2A_UU5e+6ZjbdsFUY-+f9DMfQcxH0qA@mail.gmail.com>
In-Reply-To: <CAOQ4uxinSLXKWjMgwyA2A_UU5e+6ZjbdsFUY-+f9DMfQcxH0qA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Mar 2026 13:15:13 +0100
X-Gm-Features: AaiRm52styHcNjJqwA19Qyu0kuu9684XRXZIH06BjgsInXNVqvN-rIFPkHHA9M4
Message-ID: <CAOQ4uxjQzsFy2cS2Q9pL+NPBryHzoQdrjs4QdUNBpM_7GzukPA@mail.gmail.com>
Subject: Re: [PATCH] fs: allow vfs code to open an O_PATH file with negative dentry
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
	Gao Xiang <xiang@kernel.org>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 7:30=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, Mar 19, 2026 at 4:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Thu, Mar 19, 2026 at 10:50=E2=80=AFAM Amir Goldstein <amir73il@gmail=
.com> wrote:
> > > On Thu, Mar 19, 2026 at 2:13=E2=80=AFPM Christian Brauner <brauner@ke=
rnel.org> wrote:
> > > > On Thu, Mar 19, 2026 at 01:46:16PM +0100, Amir Goldstein wrote:
> > > > > The fields f_mapping, f_wb_err, f_sb_err are irrelevant for O_PAT=
H file.
> > > > > Skip setting them for O_PATH file, so that the O_PATH file could =
be
> > > > > opened with a negative dentry.
> > > > >
> > > > > This is not something that a user should be able to do, but vfs c=
ode,
> > > > > such as ovl_tmpfile() can use this to open a backing O_PATH tmpfi=
le
> > > > > before instantiating the dentry.
> > > > >
> > > > > Reported-by: syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.co=
m
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > ---
> > > > >
> > > > > Christian,
> > > > >
> > > > > This patch fixes the syzbot report [1] that the
> > > > > backing_file_user_path_file() patch [2] introduces.
> > > > >
> > > > > This is not the only possible fix, but it is the cleanest one IMO=
.
> > > > > There is a small risk in introducing a state of an O_PATH file wi=
th
> > > > > NULL f_inode, but I (and the bots that I asked) did not find any
> > > > > obvious risk in this state.
> > > > >
> > > > > Note that specifically, the user path inode is accessed via d_ino=
de()
> > > > > and not via file_inode(), which makes this safe for file_user_ino=
de()
> > > > > callers.
> > > > >
> > > > > BTW, I missed this regression with the original patch because I
> > > > > only ran the quick overlayfs sanity test.
> > > > >
> > > > > Now I ran a full quick fstest cycle and verified that the O_TMPFI=
LE
> > > > > test case is covered and that the bug is detected.
> > > > >
> > > > > WDYT?
> > > > >
> > > > > Thanks,
> > > > > Amir.
> > > > >
> > > > > [1] https://syzkaller.appspot.com/bug?extid=3Df34aab278bf5d664e2b=
e
> > > > > [2] https://lore.kernel.org/linux-fsdevel/20260318131258.1457101-=
1-amir73il@gmail.com/
> > > > >
> > > > >  fs/open.c | 7 ++++---
> > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/fs/open.c b/fs/open.c
> > > > > index 91f1139591abe..2004a8c0d9c97 100644
> > > > > --- a/fs/open.c
> > > > > +++ b/fs/open.c
> > > > > @@ -893,9 +893,6 @@ static int do_dentry_open(struct file *f,
> > > > >
> > > > >       path_get(&f->f_path);
> > > > >       f->f_inode =3D inode;
> > > > > -     f->f_mapping =3D inode->i_mapping;
> > > > > -     f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> > > > > -     f->f_sb_err =3D file_sample_sb_err(f);
> > > > >
> > > > >       if (unlikely(f->f_flags & O_PATH)) {
> > > > >               f->f_mode =3D FMODE_PATH | FMODE_OPENED;
> > > > > @@ -904,6 +901,10 @@ static int do_dentry_open(struct file *f,
> > > > >               return 0;
> > > > >       }
> > > > >
> > > > > +     f->f_mapping =3D inode->i_mapping;
> > > > > +     f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> > > > > +     f->f_sb_err =3D file_sample_sb_err(f);
> > > > > +
> > > > >       if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) =3D=3D FMODE_R=
EAD) {
> > > > >               i_readcount_inc(inode);
> > > > >       } else if (f->f_mode & FMODE_WRITE && !special_file(inode->=
i_mode)) {
> > > >
> > > > I think this is really ugly and I'm really unhappy that we should a=
djust
> > > > initialization of generic vfs code for this. My preference is to pu=
sh
> > > > the pain into the backing file stuff. And my ultimate preference is=
 for
> > > > this backing file stuff to be removed again for a simple struct pat=
h.
> > > > We're working around some more fundamental cleanup here imho.
> > >
> > > Fair enough, we can rip the entire thing from vfs if you don't like i=
t.
> > > The user path file can be opened and stored internally by selinux
> > > without adding all the associated risks in vfs.
> > >
> > > Paul,
> > >
> > > Please see compile tested code at:
> > > https://github.com/amir73il/linux/commits/user_path_file/
> >
> > No.  Definitely no.  Ignoring the fact that there is no reason we
> > should pushing this into the LSM, doing it in this way means it is
> > very likely that each LSM wanting to provide mmap/mprotect controls on
> > overlayfs will have to create a new O_PATH file.  No.
> >
> > ... and let me preemptively comment that this doesn't belong in the
> > LSM framework either.
> >
> > As Christian already mentioned, this really needs to be addressed in
> > the backing file code, please do it there.
> >
>
> OK, will give it another try.
>

Christian,

I pushed another version of the syzbot ovl O_TMPFILE crash fix to:

https://github.com/amir73il/linux/commits/user_path_file/

In a nutshell, created a helper kernel_path_file_open()
instead of modifying do_dentry_open(), with a bit more magic in
ovl_tmpfile().

It's not super pretty, but at least it does not touch any non-backing_file
code paths, so maybe you will be ok with it.

Thanks,
Amir.

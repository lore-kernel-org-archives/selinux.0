Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CA53148DC
	for <selinux@vger.kernel.org>; Thu, 19 Mar 2026 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945883; cv=pass; b=TterKmLPZuVSsSljMig7qoLirXfNKS2S9Km3JtrKBN7/y/iQid2gnvJ0rfK03I+JjJ0bxL5wanIvWG/QejCgxNH0W5cDU+q5dO9RcbgOazNKxvZtc7KvnDcFiDgY8kFRW707qAdwcqX5Shu7RWva29+cb0WXVOgEQA+yA1S7AYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945883; c=relaxed/simple;
	bh=uiCScWR+3uywURMbmYz4JIe2t6y1lUqRrJAsT5gXGhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9mk2nmkV/F4jsiFaowFaRUvMoa2SaEBZE+2JCjZZh5pKxMYmiAodaFH4HzzLb4fW1tvnzoHSNupm0pQkM0Yn5EdnrWIr5B9DXfzRRlZJ0P4fN1CmbeNlhCNNEBoe2yfQd2SpdQ808jsn+JvEwb8GobiwmlHg6FIXKH317MjkIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TjyUaHIz; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TjyUaHIz"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35a07c4b17dso581056a91.2
        for <selinux@vger.kernel.org>; Thu, 19 Mar 2026 11:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773945882; cv=none;
        d=google.com; s=arc-20240605;
        b=U+0OZZ14j+q4gTTVGQxQjV1AI7tW1rJ5/wOYMS5CfH+gtht45dUf+ZEDMf8J+Vby0b
         SIrqshxCqQfJPHT+oJ1adWHt4VhN91lWaRb9wOCM1Zet2/ZD3KXNWgdlu0INuh8KV/db
         Uhsy5U+r4fAsfCwUgODaHftFtDXn1NSw0sq5wqamhve9TDx2gBSYKyOHvZx7b0JMR3JD
         gxHetWKimc7iAGIn1yirxBpoO7rH6pc2j4Pv27WVfSdtdHEXTvA8tfmNq1qkXM5EvQy9
         ZZ6RTmP/NYGX5gEYYT4J9WNwCg9cP9xZGpt97An3e6/jAAgY7d0r5crFitlcA6uijTv0
         aL0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3LpRx2Ah23pGDXkHY7jaWEi08gxAWhSArXDD9NIs44I=;
        fh=N/ocdlLCrx+F6cqNhZ6+15ZQ1AX7whxW6HkkTzvi5gY=;
        b=dtMwtF6Pqehe2vZwkYBNdUTYH7T6iuWd6G+Lo55yvK06jBrPVabYWu20dPmuatTk/S
         Dq/iyazCBAje8ai++MaiJN+1zVfsG79UR7pusE5wKHTM3yvDOVet3IHXcoa/ZlcvB2YJ
         Lfi5nqs2dYaDtdaSO6H1zQO/Z1h40Qcyhh9umphxL7W9RbmIdsJoDdYA8ttzf/RkNNBf
         sRw6Z9q867OIBGScExT3C9jLunsitxBZlTsgz9K+ReivjOBJozlBPkvipNrHxFxX+KdY
         fS12EiUurlS0WpYNNASp8C4zi2IipCQkb6uZwkEwze1zhyK6oFEhow+XahxeNhM3fHtr
         p1Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773945882; x=1774550682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LpRx2Ah23pGDXkHY7jaWEi08gxAWhSArXDD9NIs44I=;
        b=TjyUaHIzmYG68QqM5p5GbP6rkqxVgWOuQrOEEVjjStrbOJagQocfIPRjeVPrQbdjS7
         +mWKYqh4xTPF8reGAEST7QyQLIhKpN4kkk1fxVnaYDxAke8u2OcQgE0oQgj5KsKBlyc7
         IY6QmrnzhEXTxEZ2JlE14Wc0ZFdJ6C8+tq7VmHCcQTTVKKk/Z8pVKsMODNutlPGC+wke
         aXSnYr/5XJSb7Ewg1FkDDzJZknz2LlE3B06n5k7xCiY2plmZ2yE27HrU1pd2l+C64fI0
         pHyfUXaSivMCSQ+PiE4tP1wyQGxr22Hk5VEUZIhxcJLoDBO3U0E0hQ4lyVaZ291fdeYF
         HIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773945882; x=1774550682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3LpRx2Ah23pGDXkHY7jaWEi08gxAWhSArXDD9NIs44I=;
        b=h10ZjnFzERSOvkUaC+eTlUJ56D7mI89XEe+gYDq2obSDbt3hpH6QlfJ5btVMyFK0MD
         z6jHnRfBPmnSJCsPD2zPVM9cD509xruTYv16PKUUJNXij4pIKEwViT8LVavP+wCELWTI
         RdEVQj/DFFMqfBX9HguJRFCX91L5yXrc3JL6hwziT0nqw+WgGOoriNGfYoDHcMYiC99d
         KLWYTnKeurgBwd4mRQjhpTxTw8TU09ZQs0K2Pz66NYkPhPD24+toT03Y5OZyVQeDSYZf
         4VNiYIJXVDIrdPnE+jSzTCG8cnbd3a0nsbsXRTvccJ7HTIhFgxYxSDm3Eivil/ye9WY0
         8+Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWNvizMOXBaTVGXBlRu+s27cK9Yl6T4w7Mr/UbplIp8HttnxKrdB6wM4iv6GcYChJXDMfjht0y4@vger.kernel.org
X-Gm-Message-State: AOJu0YwiSEOLBkI/UZdio1xv/hRAbaEV7WI73vKUrSgYgYEPlugJ1DW+
	XLffyC+gtnyYxiWt/jyuvRCGj2GkfKoQBnH61JmcLb2ck7Q8CVhEPTrScV5UoiJNb7ezBAYCHdx
	lzpsdGewlH+O8vnndHzCmHl5OzStzsn3hZr97+qMJ
X-Gm-Gg: ATEYQzxYjrMRxrlzjOruDZ+u4TRgDrgSaTSG18vv7ZAtU22qTiBLDXcpSTiQCct+qUj
	mG3ezMV7aKyh0HOPERvD3gwTXS8FqP+9lI2f/8iZaJjYT2C1z65cmqqRMe20so/8BNBREz4NwvK
	lPC9bf1cH7Y+wbCAelZfVtqxbmoqE1DB4W4kogbyhcqiAlBlOTgt7AdSOSRx0NtZgVJJO9FymFq
	5K67sK5VeXymHtXJJenkeF19wJzrDEbguYHUjluXB+FdiN2WgclVbWSM2ovPBDEZTaj889+/GlU
	IIngco2aHK8OB2q5jA==
X-Received: by 2002:a17:90b:3d85:b0:35b:91e1:e110 with SMTP id
 98e67ed59e1d1-35bd2cb726cmr153296a91.20.1773945881632; Thu, 19 Mar 2026
 11:44:41 -0700 (PDT)
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
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Mar 2026 14:44:30 -0400
X-Gm-Features: AaiRm50mWSepRO31-IrCKePpEwYDJfx_2t8PZ8Bwv853YChliBvO2jCDu0_F2bc
Message-ID: <CAHC9VhQbT1jPXN-nqmoNS4DGkYGWrVkO9-C1k-9zjYU9cRDi0A@mail.gmail.com>
Subject: Re: [PATCH] fs: allow vfs code to open an O_PATH file with negative dentry
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, 
	syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 2:30=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> On Thu, Mar 19, 2026 at 4:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
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
>
> OK, will give it another try.

Thanks, please let me know if there is anything I can do to help, e.g.
testing, etc.

--=20
paul-moore.com

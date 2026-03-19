Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E42730EF9B
	for <selinux@vger.kernel.org>; Thu, 19 Mar 2026 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931864; cv=pass; b=tHWt0G6FZZH9yI6IbawKE4pTxxsxc2JFIHTYcYwkgzPf7sPZCqORGSYCWls+Z22A3vuNIMOyxAxjis7QRBsiKgSnqtpTq7ZpODFpcK5bk0MULS0XE/0dSQDIEkGhSYm4kxbQuUJ8jmxnSWweX3/TTBVfwlAyz1nBDwfuA0IpPnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931864; c=relaxed/simple;
	bh=H6hSfyl/3hQMznCb6ljYtpusInK9NAqhtfiVbDB/PnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BlScf+E3mIlrlj5DZvUwN8DaO2oDhGbcsbypJG/zy5QxTp2h/Hn8+rDn9VTSMD9W+bni+BpznmkAEqmRqJ0cXhBZhhyMsdwZ8i1q1UFagOwvO1waZJe0VJhRoQnIbA570D9RzLD8lzTLQ7FJroJ25CkZdbbsdwG50nj5Ciis2HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wg5Te2FI; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wg5Te2FI"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b980c65b97aso129681466b.0
        for <selinux@vger.kernel.org>; Thu, 19 Mar 2026 07:50:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773931856; cv=none;
        d=google.com; s=arc-20240605;
        b=JXBjyYthzy54R+F9o0rHdWd9JQigDC5l3FijCK/yH2oifdUVTWtX7uVjSzYGO2LmHY
         +hHVdf/AKjdOZen3nFivrbwoMbFhnEtRG2zXAl5Tooun7zXdh77YKWrsAXboZdIET9Lx
         Zvfp+OaWCGGvEK7IHuZ1XIWTZh9Io/3IW2Pco9rHsrttvmoagCjXVHNDJ1jSULVy4hD5
         a7W9DTi1MHOn1vrJJvLAhu7pIIon2nFs0IlcZcp77VYk1TnrXx/WLWA29FU6JOGfFEfo
         TJYmqbbOw0PRTgDPHu4j2nEMMRNZw2Vdz9kVVt55VOH5NbJMhnvSt3vgrGj5ms7FT3FL
         rLIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8PNv+R9h7HIF0XPTxmdIQBKpHP0M3+R/vRZNH6LP2zQ=;
        fh=JGvuzSi42DiO/PR3sHcQGrKi85xErn+WURBL8LKsmo8=;
        b=I8DPoKOfrsiGN1n+7mBTdADHlBXmu3H1fS6w8WJL3o6YJzFl2cIrDbg6c/WXWSdDSb
         B4AIZooWd2pYFwP5XwPkromDwk6IJuV5TyUD0eCCp4fDXkYtYCiwIIOQt91sHYhet7JN
         a9/mjCtMWd0ixq1KuhF2YF6M14v5GNWcOE6s5LQOm33nIzUHBt8ZP6vCT1vzJjtKN7tk
         zHWj9fI1s7MT+sjPFLi0hqSMyObNQ8i4wDjLc2wtpfn6O9E/xWbywcFczvK1AceHI1WK
         tl0W6NE/hjDjb7rptHkHNA5g3/mcJ5uFGncUHpJ1zTgMH/5T0/4NVbWHa1WIR5ln6vDd
         RBTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773931856; x=1774536656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PNv+R9h7HIF0XPTxmdIQBKpHP0M3+R/vRZNH6LP2zQ=;
        b=Wg5Te2FIL+Zl2jNxs/ZAhXPzndGtbGUHGjqvngec5teIxWvdWKMQyQf6nJ0fgvvMh6
         tIqApBZdWMl288cehQz+j9P9XRMyhKag1+3x/WkGdOy0aQE8/s2QB7SMPW5r0qb6cvPf
         pJyu0JNh9Ho6ylPDJiXLaZvtSnf/7QEuE745zQbrNYJMuvCcNR/IJ6VCBWFvjgPuvQq1
         ggu5XDiJV4zwF8Q4wFM2CiZBySHQXmd/IUEIVBZNHI4hFRIJAN3hZHBD6UQqY89IDmH5
         pp5Ph/clzdpsMOX9bcYFKgQojKLwmRYAlKevMF5+b0evAxOQXjKzovWVWIo+UCJudabz
         kfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773931856; x=1774536656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8PNv+R9h7HIF0XPTxmdIQBKpHP0M3+R/vRZNH6LP2zQ=;
        b=Jiuw0YKf4WHREfGK3a45hPCVMSfOdRQidYL2m3PY/cVxYMpkybztnDVjsBovOSMwk2
         L3Y/YIoREoWTRRehL1r1Uqz+DtrkUk4lb5L3TskApy3axCMQRREM2ud4gGT8Q2SSg315
         Y4l6wV8YJPAjZl92Z5eW+FKEFcILkn2zvV4VHwdyUsKvoP1KXyF/CqKYPsjWFX5U/k2U
         SRwe3AumDpJitU4u/SXCNXsAYve9KSLMKhrZUtcQ5nUqdfPX5KcRmKVA/bTd6Mx3YG4J
         LNj7VBK7AvMuBfEvuB0TE01Z2nuwIHX9OdFpQH4c8F8sH97D6PgxDIyPyYsm0gsfjxhi
         5uAA==
X-Forwarded-Encrypted: i=1; AJvYcCVSPVcyucLSc6JKGS/0xxRHw/RMdb8IRhy6j44qwReB5xIQp4TEuKe/xxELBNztbpzfnT2Hlvw0@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf6cvTWdNbKKdajwTg7OkAnzfYVPqy5ZPiyHh0GVxz5ojZA9Tr
	zt/KLMWjt3ugNap9JJ3E0q8MFF35D0yILIPjpbJe5dWBEzOvF1Woj05HYJk4AHujCxxVYQSIX08
	MOOm0tjirIqzySBCZ/bS+dpr9wsDLCgs=
X-Gm-Gg: ATEYQzzVfBVetL9dvBCDnqMALk12xkUjqqGzPPCbXehcW70AjGsAqeMXJ4K+hHqEuwD
	6ALnIOwExuQmjnVsWc3Z8C8nLCofW7RbgnBzSG3d8UEU52nhRFRzw4ACIruhj3HfgeNt+SYXKsq
	19nDfMVoER91NGy0vxCQCYTvzfpQEqayilOQhQprrom+tzMYgAjVFcqdYzZtn8T+aQJBcoiqnPX
	x90jyowp78UglgBLObPG0Nb0xXobrzFns7PdIOPDbfS6IyboW9puSEeZ54jyWdpAYi/e6nyQ3hc
	rsY8s9Rx0KbHW5AEPae7cc30YYCDBqnJa1ft2CuCMkV8sAnNPunn
X-Received: by 2002:a17:907:1b06:b0:b97:aea3:86dc with SMTP id
 a640c23a62f3a-b97f48e0c86mr555307866b.15.1773931856096; Thu, 19 Mar 2026
 07:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319124616.1544415-1-amir73il@gmail.com> <20260319-unentbehrlich-reitturnier-f78d9fb01230@brauner>
In-Reply-To: <20260319-unentbehrlich-reitturnier-f78d9fb01230@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Mar 2026 15:50:44 +0100
X-Gm-Features: AaiRm50Tod8HscrjlQUl55658cqI4Ii7lNI4-xMEI5BRod0xGVsfCDlxh5_S6TI
Message-ID: <CAOQ4uxiS1uM=mn4q6CQfganba1XcqyXYmXfQceWdfUVRFK_Pvg@mail.gmail.com>
Subject: Re: [PATCH] fs: allow vfs code to open an O_PATH file with negative dentry
To: Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
	Gao Xiang <xiang@kernel.org>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 2:13=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Mar 19, 2026 at 01:46:16PM +0100, Amir Goldstein wrote:
> > The fields f_mapping, f_wb_err, f_sb_err are irrelevant for O_PATH file=
.
> > Skip setting them for O_PATH file, so that the O_PATH file could be
> > opened with a negative dentry.
> >
> > This is not something that a user should be able to do, but vfs code,
> > such as ovl_tmpfile() can use this to open a backing O_PATH tmpfile
> > before instantiating the dentry.
> >
> > Reported-by: syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Christian,
> >
> > This patch fixes the syzbot report [1] that the
> > backing_file_user_path_file() patch [2] introduces.
> >
> > This is not the only possible fix, but it is the cleanest one IMO.
> > There is a small risk in introducing a state of an O_PATH file with
> > NULL f_inode, but I (and the bots that I asked) did not find any
> > obvious risk in this state.
> >
> > Note that specifically, the user path inode is accessed via d_inode()
> > and not via file_inode(), which makes this safe for file_user_inode()
> > callers.
> >
> > BTW, I missed this regression with the original patch because I
> > only ran the quick overlayfs sanity test.
> >
> > Now I ran a full quick fstest cycle and verified that the O_TMPFILE
> > test case is covered and that the bug is detected.
> >
> > WDYT?
> >
> > Thanks,
> > Amir.
> >
> > [1] https://syzkaller.appspot.com/bug?extid=3Df34aab278bf5d664e2be
> > [2] https://lore.kernel.org/linux-fsdevel/20260318131258.1457101-1-amir=
73il@gmail.com/
> >
> >  fs/open.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/open.c b/fs/open.c
> > index 91f1139591abe..2004a8c0d9c97 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -893,9 +893,6 @@ static int do_dentry_open(struct file *f,
> >
> >       path_get(&f->f_path);
> >       f->f_inode =3D inode;
> > -     f->f_mapping =3D inode->i_mapping;
> > -     f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> > -     f->f_sb_err =3D file_sample_sb_err(f);
> >
> >       if (unlikely(f->f_flags & O_PATH)) {
> >               f->f_mode =3D FMODE_PATH | FMODE_OPENED;
> > @@ -904,6 +901,10 @@ static int do_dentry_open(struct file *f,
> >               return 0;
> >       }
> >
> > +     f->f_mapping =3D inode->i_mapping;
> > +     f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> > +     f->f_sb_err =3D file_sample_sb_err(f);
> > +
> >       if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) =3D=3D FMODE_READ) {
> >               i_readcount_inc(inode);
> >       } else if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode=
)) {
>
> I think this is really ugly and I'm really unhappy that we should adjust
> initialization of generic vfs code for this. My preference is to push
> the pain into the backing file stuff. And my ultimate preference is for
> this backing file stuff to be removed again for a simple struct path.
> We're working around some more fundamental cleanup here imho.

Fair enough, we can rip the entire thing from vfs if you don't like it.
The user path file can be opened and stored internally by selinux
without adding all the associated risks in vfs.

Paul,

Please see compile tested code at:
https://github.com/amir73il/linux/commits/user_path_file/

Feel free to use my patch as is or reorder/squash/rebase as you see fit.
Feel free to attribute my contribution any way you see fit, just pls cc me =
for
review when you post v2.

Thanks,
Amir.

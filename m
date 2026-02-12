Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4871A3451CE
	for <selinux@vger.kernel.org>; Thu, 12 Feb 2026 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770904789; cv=pass; b=i0FdilcG6/WQPtq1bh4VVukDRTvWg0eZR2v75MH2lAJQcU1ukdJ32OyE1/FmRYvDHt/hWINxNwPvUS29SYj2RngxfaBOP2i4du//GoxfU8OUA8DwhVRYKJY9Wzm+7znqQPnIn3as2CtfRE/WHPUBg0JhgIeY86+LOWVy0mLKCIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770904789; c=relaxed/simple;
	bh=IqCZ4Mizx77EA39MKx3svqkTnUf5Q4CHAXyUHMO0TAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pwychg8HeOzFFoRyuSHlVKuZCRXDdsxtANufqzKun1/+941U8hlgnBASg0zzBTMI6t7gPyBDco40f9OJk3/XI3SIgKeG9sF/gytvaGmWdkUbDsRCbkp4ziYzGJo3SDlk52pD7oRKTxWdysn+o5EdM3Nh8TEPTF0WVSFI5el/12s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KX4u5Tm9; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX4u5Tm9"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-352e3d18fa7so4417737a91.1
        for <selinux@vger.kernel.org>; Thu, 12 Feb 2026 05:59:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770904788; cv=none;
        d=google.com; s=arc-20240605;
        b=Vd5FLM1p8gjAlJKL0szWYaX4EmPFStigNOBU8Mfy1jTb3X/ci1bTy49zfkuVk2Ybu2
         MnYD8tFUYuoTwEZkK2bv1UlBW0bsfwZFBuO6wvUSYsB4vjUdR5+VJuqubInYmzFUlfHR
         NE4zKQ1Z7g5MmGocMAXstXnH6kw/8bkCnm1cpLbxyrwnDoufZV/WFU3f6xP3UA3vUega
         wX/f8DHgihvopj6cZuHun+48NBNePz00JpgdsBvAycrBIk/EqDcIbu/wY9I2+z7MKhbK
         EbKPIMfd2/RnS9fk8o1dPcmIh5a2UupQkCUSxatuZ1t2WyErrGMO9B2ISvNH86Ng5bU+
         D7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xxGkfO4jfhyRAPyQr9O4TZiMU+0MvJk8e6aMPtFiBUA=;
        fh=zf4NyQ+bW52Ej1xQR1BXDeZfxd0vBxCoiyXAdQbD9To=;
        b=aPCALHjwIpROINW7gKO8/3igKQTiXRlXvN6DRoBOyga0zoOn0DdPFO29U0/RhCr/te
         Ln8vWEKvCs3L01t7XS6P4RqMrs3LGMjyF7Y10XzZtwBY1k1EJJnw6aL0sR2kbDqwRs0b
         Hn865nHCzk+KjIwdH1ri9Bwxph/CL+UZoaHecI9wywon3UYfTVdSdi3QNRtWwkbtK4y8
         mxpVc1X4zvkeNAY0JIhS4dwyE0YCMMxb5jMLt5UU6bYQD20ANyHrXVKmXACqIxmKmuyw
         5N+Kl8Osyi1H4uiTstl9S4QpD9Y7YKwDHx0pXqqYbY8ep0qVMqjkALDLocARrzX5Q3YS
         XhSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770904788; x=1771509588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxGkfO4jfhyRAPyQr9O4TZiMU+0MvJk8e6aMPtFiBUA=;
        b=KX4u5Tm9A9GoyN6H8zgZ93bKviM+dn+lKIgWb1Dlnu36yQSmFgwLAXpFDkHjZbgoAg
         ZUYuwAqzh5HmUKi3e5jQmLO6qjgPk2aViVHdzwlFcoXaJPr5jeJ7LtfnRB+z0wWyem6E
         0JNvmkQ/2vGarB/b2P3cdJD7tKAnsoPU8Zu7R11d8TBKjQppJ95I6C/09a5pdmMsJrJZ
         A2VaTi5aY3nfiyo3qeVqPBl66liMPTTbzPt+UQDF2WP3pCFs76m7tCJSBwZ1QpDbIA6r
         RBIcHBL2t69TAgxl4SH4BMhkwRHiSqVUP2+LZZOq2dbnXyfs1VNnZ84dQGWfV+07SEjY
         B2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770904788; x=1771509588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xxGkfO4jfhyRAPyQr9O4TZiMU+0MvJk8e6aMPtFiBUA=;
        b=iWPbUeSF1VwfyH3jcAWGBtsBKsbitfnd7DQJMalnCVXT67R9quSHDgC6TXRgMv1Zji
         GIInH+DkH6lGhI7si4KQOmTg2GbDMWsDEE8tRVXrO+AYUf3c+n3ibG0NdPuWAG1aplRA
         BHxciM/ZWwnf8R1C+uf36EP1N32jrCGHZged8sIkxs+rkRVBcBO7PPObH3sfxnCOyaeC
         41hGIXweVX63nSQiEYHHHOvUKdUo+PF+pNtWDIYkADtbHc+sNB2u8nW9or21eUR/aIZo
         WBH12aSIhMyIPUzWXM8qb9mIlp0bDGoVq9rohYNjr8RYggas5f/o3bbZLJZ8MJprRNSy
         88Gg==
X-Gm-Message-State: AOJu0YwuPa64+pIgeARO0vvLkK4By+bv1FB3lw1P7yJ3Wd1Rf4Cqw5xb
	rj1YSq6+RHmbT4ksi6ObnAQU1P6PCHAILMKO+2zvDJsRNzLtzhiWNR84J3x7VXA5ugtnaKoof67
	kao90OcmRHVCU/v+whISqli+9SSqdRKg=
X-Gm-Gg: AZuq6aKJljCQ1nhFD74gwDQloNsk+i4nlrD7J6lEXWyKtXsfZuQMkEztdnkRRcjqWpN
	i6E64hH2iMbvn4bBjPHtd9J0gUOPEFXCKHQxvGTM+T899yHGSpSjU4eLYKAkKreUqIVua7Qj3CL
	RXLHwBR78RU1T9jKh63dJKryabrXAzJn6+JVQBB5RN2o0TafMBm5lqa4mn5fKIErsPNrHlQnlnQ
	XfORVszTNTIyzab2wUSUfT06t4wCe93aLF07p6f0dxwTDJIkSNp0TJ7FZUopjvOzKJKCciTj0Eq
	2kVb5xI=
X-Received: by 2002:a17:90b:1e44:b0:356:2eff:deff with SMTP id
 98e67ed59e1d1-3568f314a5emr2512120a91.15.1770904787559; Thu, 12 Feb 2026
 05:59:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130171140.90966-1-cgoettsche@seltendoof.de>
 <CAEjxPJ7GTB9=-rZOkKe1uiq3G4pdSzPKVcSpYBH9hrhufDq0=A@mail.gmail.com> <CAJ2a_Dc6OWGTz+SONHZphoFt+Z=mTqWuvZHgufxqCyyr8Ywubg@mail.gmail.com>
In-Reply-To: <CAJ2a_Dc6OWGTz+SONHZphoFt+Z=mTqWuvZHgufxqCyyr8Ywubg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 12 Feb 2026 08:59:36 -0500
X-Gm-Features: AZwV_QjtpaHsD-OcEiw8Ha8XU7ZY79whDEcZVKvYD7QpyC6__IAS97v4pUnvkao
Message-ID: <CAEjxPJ5SgaESJ_NyKfHHLd_zo1hHtYvQ9DW7sv_jZgn+=zgWcA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: prevent truncation of status map
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 31, 2026 at 12:20=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Fri, 30 Jan 2026 at 22:08, Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Jan 30, 2026 at 12:11=E2=80=AFPM Christian G=C3=B6ttsche
> > <cgoettsche@seltendoof.de> wrote:
> > >
> > > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >
> > > Currently the SELinux status map can be truncated, given the necessar=
y
> > > permissions, leading to foreign user space processes getting a bus er=
ror
> > > (SIGBUS) while concurrently making use of the status map.
> > > For example systemd can be killed that way, see [1].
> > >
> > > Override the setattr inode handler and check for O_TRUNC in the open
> > > handler to prevent truncations.
> > >
> > > Link [1]: https://github.com/systemd/systemd/issues/37349
> > > Closes: https://github.com/SELinuxProject/selinux/issues/475
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > This issue can't be limited to just the status node, so if we care
> > about preventing this, we ought to do it for them all.
> > When would we want to allow truncation of _any_ selinuxfs file?
>
> Probably not, but - at least to my quick overview - the status map is
> the only file-object backed up by real memory and the only file
> commonly mapped by userspace.

/sys/fs/selinux/policy would be another one.

I would expect this to be an issue for other pseudo filesystems using
libfs, so would ask on linux-fsdevel and cc the VFS maintainers on
whether there is a general solution for this problem.

>
> >
> > > ---
> > >  security/selinux/selinuxfs.c | 43 ++++++++++++++++++++++++++++++++++=
--
> > >  1 file changed, 41 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxf=
s.c
> > > index 896acad1f5f7..df079a35a02d 100644
> > > --- a/security/selinux/selinuxfs.c
> > > +++ b/security/selinux/selinuxfs.c
> > > @@ -214,10 +214,30 @@ static const struct file_operations sel_handle_=
unknown_ops =3D {
> > >         .llseek         =3D generic_file_llseek,
> > >  };
> > >
> > > +static int sel_setattr_handle_status(struct mnt_idmap *idmap,
> > > +                                    struct dentry *dentry,
> > > +                                    struct iattr *iattr)
> > > +{
> > > +       /* Prevent truncation to avoid raising SIGBUS */
> > > +       if (iattr->ia_valid & ATTR_SIZE)
> > > +               return -EINVAL;
> > > +
> > > +       return simple_setattr(idmap, dentry, iattr);
> > > +}
> > > +
> > > +static const struct inode_operations sel_handle_status_iops =3D {
> > > +       .setattr        =3D sel_setattr_handle_status,
> > > +};
> > > +
> > >  static int sel_open_handle_status(struct inode *inode, struct file *=
filp)
> > >  {
> > > -       struct page    *status =3D selinux_kernel_status_page();
> > > +       struct page *status;
> > >
> > > +       /* Prevent truncation to avoid raising SIGBUS */
> > > +       if (filp->f_flags & O_TRUNC)
> > > +               return -EINVAL;
> > > +
> > > +       status =3D selinux_kernel_status_page();
> > >         if (!status)
> > >                 return -ENOMEM;
> > >
> > > @@ -1980,7 +2000,6 @@ static int sel_fill_super(struct super_block *s=
b, struct fs_context *fc)
> > >                 [SEL_CHECKREQPROT] =3D {"checkreqprot", &sel_checkreq=
prot_ops, S_IRUGO|S_IWUSR},
> > >                 [SEL_REJECT_UNKNOWN] =3D {"reject_unknown", &sel_hand=
le_unknown_ops, S_IRUGO},
> > >                 [SEL_DENY_UNKNOWN] =3D {"deny_unknown", &sel_handle_u=
nknown_ops, S_IRUGO},
> > > -               [SEL_STATUS] =3D {"status", &sel_handle_status_ops, S=
_IRUGO},
> > >                 [SEL_POLICY] =3D {"policy", &sel_policy_ops, S_IRUGO}=
,
> > >                 [SEL_VALIDATE_TRANS] =3D {"validatetrans", &sel_trans=
ition_ops,
> > >                                         S_IWUGO},
> > > @@ -1995,6 +2014,26 @@ static int sel_fill_super(struct super_block *=
sb, struct fs_context *fc)
> > >         if (ret)
> > >                 goto err;
> > >
> > > +       /* Create "status" separately to assign a custom inode_operat=
ions */
> > > +       {
> > > +               ret =3D -ENOMEM;
> > > +
> > > +               dentry =3D d_alloc_name(sb->s_root, "status");
> > > +               if (!dentry)
> > > +                       goto err;
> > > +               inode =3D new_inode(sb);
> > > +               if (!inode) {
> > > +                       dput(dentry);
> > > +                       goto err;
> > > +               }
> > > +               inode->i_mode =3D S_IFREG | 0444;
> > > +               simple_inode_init_ts(inode);
> > > +               inode->i_fop =3D &sel_handle_status_ops;
> > > +               inode->i_op =3D &sel_handle_status_iops;
> > > +               inode->i_ino =3D SEL_STATUS;
> > > +               d_add(dentry, inode);
> > > +       }
> > > +
> > >         fsi =3D sb->s_fs_info;
> > >         fsi->bool_dir =3D sel_make_dir(sb->s_root, BOOL_DIR_NAME, &fs=
i->last_ino);
> > >         if (IS_ERR(fsi->bool_dir)) {
> > > --
> > > 2.51.0
> > >

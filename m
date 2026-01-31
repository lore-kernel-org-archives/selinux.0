Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6776930F957
	for <selinux@vger.kernel.org>; Sat, 31 Jan 2026 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769880045; cv=pass; b=m/c4Du9zSUCtW9mKtDSi/ORo5FB5mYjnxlcA3xr43D7q82w7jeHTyZTe5Qko0xWajk7mgvam90vr7JhIlcjZ5CNHkQKUxOdyMG5DngmButbyAr+oRhC5Sg4mcNd+JX48RZAqccVw5OCT3M7oAVOg6mrBAQsZ2yXVx10/ttQPenk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769880045; c=relaxed/simple;
	bh=IuOdbt/SWNU0NxkqhNIhUORbwpDk2hGiaRiFcMYrDJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giaP7CDpMl+nL7a4ziHp/JqltTUA0wLOK/VLp4oFx4BCTMYBmt8gIWmiG0IHvvMxrY6EUBIhJ/u/7FFvH1fQNXf8nhgX34q5ohdkR+Xl9GpKOJKKzEmwgNWC6HqN3ESq7rdYPv8ySI9IInRB7Ng65Tdw0fak2T4gJftD5RhovcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=PZL51LxP; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PZL51LxP"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6481bd173c0so2762627d50.2
        for <selinux@vger.kernel.org>; Sat, 31 Jan 2026 09:20:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769880043; cv=none;
        d=google.com; s=arc-20240605;
        b=flNfQWONp6PLdZQIf/f6lj3hTjsJI7dtoyZaNrgOA9OSgNy/EYJEaTf/ao9gdBayp9
         x435ASF8xFToSrTgfV/TLDHw97FQVonjr+DwTRDEtzzqzOSOuRzKyq29aeGA2IMNxpIW
         OWgbXxQ4z82sUqzVJlm0/fnvSexdd0IVcSA4J3aomgqDbjQ8Pz3HA/40okrunYy1xGsy
         3VzPJjHiV+klk4Ri+WArJ8XEFzq91qBjMlsZxDuHi2/6BUq+vPu/eddh0naRjHXd0Aar
         8DCDriEWYg6cgIv9f5a/3XWkVN3BOdtASrJKe5QXBse949YWicjs4Hvns23UdXOMlIa+
         zYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/evgr1yg/S4AL9vkDNjb/QYCD+xGcg7cl5w7K0n6axQ=;
        fh=PkcZWdIcZ81Ewm9knZxjpZf89vc9T9q3qCRFSok3Df8=;
        b=NLpTTzop+pSvo1Fcsmxc7zvYJ8SwPqq6nxk2o08T9rMi687C78D6PqiQqJIjbeJJzU
         vEaz438kHBfBu4ToU/IX+5tozH5l6obSGwIhOJVX6i7WJCxKZKNHbLHi6fP023Of6ap6
         ZFbdGm1c2lC+dWpnkbwK6T80YhGyAxNZPY60MExWWsBvm3ZAFac2OpD0soXad3wwaVEj
         w/Sg3w6rSS2RfDPZPo3slXGMHPtnJ30EWh0Ay2bHGYdb+pconXNnlGOzIy53fyvVkHXJ
         6XbeWoN5MMYdhPquXY/T1iQPkFwnGkfbvSVCanuxgcbRSilTKDIE88IUrK2ZuDyTIoJF
         Y+1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1769880043; x=1770484843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/evgr1yg/S4AL9vkDNjb/QYCD+xGcg7cl5w7K0n6axQ=;
        b=PZL51LxPiEHBnVghX1bpkIvmqkiS4ovWrasblVlX1rwjvJsceiLKRo0+X49OEnwrzm
         3OcjmE+NBuc0g6k//hFWkA5+EtKLMfyI75MPdKtzEOR0FIp/qegKlHalhOMZAFgzph1Z
         YuunKvgq7FhmXTYT/US86OLysg7eKHsqKXPiDTQYkZvl6OI0Di7hEDcObuvEw0Sqiy5u
         pgsLWLpTunrDSaAK47rM+EQzE9bBeob5ewyUFzfiL95c3zZJZSBi5D4Ci9bwuZdsUKA0
         5/BmUs9ljg3niIAxzcCLqOCr954kWHNF0ozFaA4xtJwhOeRX7HEiVVkPtkrJUGQ3pi9F
         v/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769880043; x=1770484843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/evgr1yg/S4AL9vkDNjb/QYCD+xGcg7cl5w7K0n6axQ=;
        b=hn+EpO43lyAwmNr4LypxsjJa5Ud4Z4142N8BwIsKRy8m27Ymeyrov0vdCiu7Dnps+g
         mac9LxCe6uA76d0B+1sFo548/bunRbIr5JyHVsg5CZz19PI9EO0qcBbx8cv5PrydmAGh
         x97pousL2IyruotmYUlg0CywrKkdClWUAPP+6KZogEa+sxcg4GygRfPVJE9ZRGQbpQ2O
         468Ncm9O5Dctqp5cNUtDZ78rStJ7Tfe0NolxleHF583JQiafmxlUyx+eQfijY2+zhZKe
         N6/16qzc/rTcNUS+zRak5677Jg9MRUdqoUcN2P6EzXysWhvDF4ZP7DYiqyR5aqjxER67
         Tw0Q==
X-Gm-Message-State: AOJu0YxWml3TlnwddX7KmlC2qzAF/aLBDlwhYV2b45kaAh8ze09YyQet
	KXsnRqHhUZUNShIzGA6hCuTrGjmy7bZmDDoZ0noIFefAYKp6Keix/f0NLjtKIM9FN0SFg5IMsi8
	wzS7Ld1SXdiF3gmvDXa4C/7JVJd0IhVdyLag6
X-Gm-Gg: AZuq6aLjwKd2MmoVS/wd/uEfPJ8+Nx6bTabDBIqumUMK/hs8SM7MNVVk5kwVDMK2Get
	BS+h69Yy7SGCVnJGrJIeTJWYMFrIqyX/bSGVRicSb5MCewJ48aSz0kTag+tcW8WzEmr5O+xJXuN
	fuLZshXbn/LaJOmDiIrVHGHtv2d5M/fYAmPLhnySDo0XBgm0dTcDWJYXSaUMLg4McbRGyNOZTrL
	udSdYvFB/NX4+caFQ0f6dNkS1ks26pxLZR7qURenMuY24958yIDzAcQwpc0lQKAdb0=
X-Received: by 2002:a05:690e:4107:b0:647:2160:143 with SMTP id
 956f58d0204a3-649a8525a4dmr4974220d50.90.1769880043460; Sat, 31 Jan 2026
 09:20:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130171140.90966-1-cgoettsche@seltendoof.de> <CAEjxPJ7GTB9=-rZOkKe1uiq3G4pdSzPKVcSpYBH9hrhufDq0=A@mail.gmail.com>
In-Reply-To: <CAEjxPJ7GTB9=-rZOkKe1uiq3G4pdSzPKVcSpYBH9hrhufDq0=A@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Sat, 31 Jan 2026 18:20:31 +0100
X-Gm-Features: AZwV_Qj4cTXCNnQN0ZNiayvJ_STfbzvXMAQ6SDfITNbno7ycP-c6vATAc4zATAE
Message-ID: <CAJ2a_Dc6OWGTz+SONHZphoFt+Z=mTqWuvZHgufxqCyyr8Ywubg@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: prevent truncation of status map
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Jan 2026 at 22:08, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jan 30, 2026 at 12:11=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Currently the SELinux status map can be truncated, given the necessary
> > permissions, leading to foreign user space processes getting a bus erro=
r
> > (SIGBUS) while concurrently making use of the status map.
> > For example systemd can be killed that way, see [1].
> >
> > Override the setattr inode handler and check for O_TRUNC in the open
> > handler to prevent truncations.
> >
> > Link [1]: https://github.com/systemd/systemd/issues/37349
> > Closes: https://github.com/SELinuxProject/selinux/issues/475
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> This issue can't be limited to just the status node, so if we care
> about preventing this, we ought to do it for them all.
> When would we want to allow truncation of _any_ selinuxfs file?

Probably not, but - at least to my quick overview - the status map is
the only file-object backed up by real memory and the only file
commonly mapped by userspace.

>
> > ---
> >  security/selinux/selinuxfs.c | 43 ++++++++++++++++++++++++++++++++++--
> >  1 file changed, 41 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.=
c
> > index 896acad1f5f7..df079a35a02d 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -214,10 +214,30 @@ static const struct file_operations sel_handle_un=
known_ops =3D {
> >         .llseek         =3D generic_file_llseek,
> >  };
> >
> > +static int sel_setattr_handle_status(struct mnt_idmap *idmap,
> > +                                    struct dentry *dentry,
> > +                                    struct iattr *iattr)
> > +{
> > +       /* Prevent truncation to avoid raising SIGBUS */
> > +       if (iattr->ia_valid & ATTR_SIZE)
> > +               return -EINVAL;
> > +
> > +       return simple_setattr(idmap, dentry, iattr);
> > +}
> > +
> > +static const struct inode_operations sel_handle_status_iops =3D {
> > +       .setattr        =3D sel_setattr_handle_status,
> > +};
> > +
> >  static int sel_open_handle_status(struct inode *inode, struct file *fi=
lp)
> >  {
> > -       struct page    *status =3D selinux_kernel_status_page();
> > +       struct page *status;
> >
> > +       /* Prevent truncation to avoid raising SIGBUS */
> > +       if (filp->f_flags & O_TRUNC)
> > +               return -EINVAL;
> > +
> > +       status =3D selinux_kernel_status_page();
> >         if (!status)
> >                 return -ENOMEM;
> >
> > @@ -1980,7 +2000,6 @@ static int sel_fill_super(struct super_block *sb,=
 struct fs_context *fc)
> >                 [SEL_CHECKREQPROT] =3D {"checkreqprot", &sel_checkreqpr=
ot_ops, S_IRUGO|S_IWUSR},
> >                 [SEL_REJECT_UNKNOWN] =3D {"reject_unknown", &sel_handle=
_unknown_ops, S_IRUGO},
> >                 [SEL_DENY_UNKNOWN] =3D {"deny_unknown", &sel_handle_unk=
nown_ops, S_IRUGO},
> > -               [SEL_STATUS] =3D {"status", &sel_handle_status_ops, S_I=
RUGO},
> >                 [SEL_POLICY] =3D {"policy", &sel_policy_ops, S_IRUGO},
> >                 [SEL_VALIDATE_TRANS] =3D {"validatetrans", &sel_transit=
ion_ops,
> >                                         S_IWUGO},
> > @@ -1995,6 +2014,26 @@ static int sel_fill_super(struct super_block *sb=
, struct fs_context *fc)
> >         if (ret)
> >                 goto err;
> >
> > +       /* Create "status" separately to assign a custom inode_operatio=
ns */
> > +       {
> > +               ret =3D -ENOMEM;
> > +
> > +               dentry =3D d_alloc_name(sb->s_root, "status");
> > +               if (!dentry)
> > +                       goto err;
> > +               inode =3D new_inode(sb);
> > +               if (!inode) {
> > +                       dput(dentry);
> > +                       goto err;
> > +               }
> > +               inode->i_mode =3D S_IFREG | 0444;
> > +               simple_inode_init_ts(inode);
> > +               inode->i_fop =3D &sel_handle_status_ops;
> > +               inode->i_op =3D &sel_handle_status_iops;
> > +               inode->i_ino =3D SEL_STATUS;
> > +               d_add(dentry, inode);
> > +       }
> > +
> >         fsi =3D sb->s_fs_info;
> >         fsi->bool_dir =3D sel_make_dir(sb->s_root, BOOL_DIR_NAME, &fsi-=
>last_ino);
> >         if (IS_ERR(fsi->bool_dir)) {
> > --
> > 2.51.0
> >

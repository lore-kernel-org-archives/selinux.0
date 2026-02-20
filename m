Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CCC189B84
	for <selinux@vger.kernel.org>; Fri, 20 Feb 2026 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771629220; cv=pass; b=KwW9p5OsVXtOwdsd+VaQvFvqG3gQJRCM2YwOMXXQJTi1Adf85RYIHhKrWriKP3kOaiamf+BOv8rjubcHm10lyoY9/g0pLfrC+dPs4Aa9evYxWv3PxfdwQYRbn9zxlbsxCTRVcNUOXxBO2tnGwzkrbbIYAgkdwonQf8YhCfxmDoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771629220; c=relaxed/simple;
	bh=8TyeUjWUBsvVvs0xB0Sjl9ta8Ea1dP8hIsN5OQehrms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fub+LDLiSNfbfescwnOXH7P4C8UTgUSZ48ppNWe+YkBpHHgQUJK+5duS05m8LWRyhEwKcJ1Rfi4IB280/91fnfHoTqROYPQyPSx4nNVONvKHcsttIpw3kpufJLDWr9Vj2VceRY1jAwrODh1eRbMVLVNQqZTHDDK+sBAS42E+790=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FfKeMzzs; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FfKeMzzs"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c648bc907ebso1434128a12.3
        for <selinux@vger.kernel.org>; Fri, 20 Feb 2026 15:13:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771629218; cv=none;
        d=google.com; s=arc-20240605;
        b=JNRn5cGVwTlPrejrviNc1qDaq4QIyNAhMPHno7OyrYB0Hi29Z4fwkjH0F62+QOoF3L
         Fhshl9DZD19nLB9YXUuF2iNBu5RZqxE1eTFgWxF0K9zWJKJuICruDltAihs/q1Z00j4s
         uhUQNesTh8hPNoueD9fXlA9sAKpmrXYwPqxiUuEOQaJsVh6eY94XoC4AyZDlvh0Pf9me
         YO/J8vvJkQmwhxep4/2nTYttu/hT/DMXO5/FT9GfFOkiZ3R9KyY2EtS9Dgm2ZklaELFW
         Thxqa4WQ1FqC+oQxmRsoL04EeRvUhGyEz5YsQbUNqb/FdIZyPR9hQIk0Go3S08O8jMj9
         mHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nGcrSV6uZdEkBWLqKB8+5vB2QHnqtHACt2PC7ynbF8Q=;
        fh=HlRVsSPisoSqhx4cBXuIPfGr5fdEPl5adWy5mM9+kpA=;
        b=jl47XuniLj1KHmaDJKEh43ohYin92yeNbsq1IFbtgUEsN5EvrSvj2rKK0/rhILBEFe
         Pjju4gg1nk3RqdkKIqkmVlqwQVboDJwNOBl0biirYZ69+cBXCz2nCNSlVcs8rY+VD54t
         z7cBya50gcbCOwLMSOcvK/G3M/lQByZCGabV+dEIhd6eJgDqsuFLfzNQ1fjSEX/0ysd0
         hFLWuUj8EAUqK6N41IDJyi6D9ESTAn94Z8NF/sVX7TgU9MZDTFGmuTWZLHSkYdsln0D0
         tdkofD7EBGly6FzMrMhYZFvjAVnsVxKNxhy02ymMujK9VwGDLHanvPgSTYP3u6wEM9VG
         7YCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771629218; x=1772234018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGcrSV6uZdEkBWLqKB8+5vB2QHnqtHACt2PC7ynbF8Q=;
        b=FfKeMzzsUidcHTMIWzE1ALB2yQTdX8sVaiSQIu+wQSRpjR5rUBC75JFaLKjW1T4kBf
         59rX6rZE1RwfM7CPezsaql6CHo/i2MH4W4mvElxEIeRh8D/fyoC7VKCikZQqfNA/xFC+
         yt8cx7Ch3IKhJsILtyG3q9nRP7Z3GYVPLs2ypx/ljQhnJqpPPo1AX5mDeh+OFH26JoBU
         N4ZZTsJlXkAEDIzJbfyB/dv91kZCbGktichpyxNQ5X7LwxAgmU5sLgeT7w5p0aKV+H9j
         0o0EFR88yNa3Fobm4PhQBRH7ze2gMU7RRZWD8ZmJOOfxdXo6lf0NTwOYzw7xH3qrS+W6
         Ni2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771629218; x=1772234018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nGcrSV6uZdEkBWLqKB8+5vB2QHnqtHACt2PC7ynbF8Q=;
        b=PQBiByWid7i5je3ylDneW0YSobk4j8KjL093D1gpoD+utSfrogpvhrHHEt7RIo8YvN
         kAUgypzliOgz2DCGFjgKsEOObXDXU4sUHeKR8Eunom9GFvTauw5W9vlXsX/eEu4gydp4
         1mrCCy8yHU9RUpPMQGWEhciNb1a6G1WtFDwhbWJaiy55+D930KKxVDZ/GQn/ERoCXKlo
         RsRBrhNp0FK51uCiM3K5q0Ip7v/hWnX8cVZkPXuvyY0JGHHeoHBnYguXuSdIIL5c99DW
         hK4aCAXeKezb+kKNNgZwttbhuUe9Kfjr7h+x05z2ywnfVbTZn1b1fUDbWrXF6Qw0YwPG
         Uifg==
X-Gm-Message-State: AOJu0YykqbtW/c0L/sZb41WcCLVHlAtQl6Ja67IfGBIFkk4BsmIs5nHi
	s45fxL46sLErkjhS3UKitvVewb/NqeLe3HDwLzVWWiy2xBbXetfzz73PsFXzrmriktQ7x25tGsE
	beY+YhCEqZ/W5XAPqKcXuHFjC0hpupEubwQLbfeES+Yn0imSiF/I=
X-Gm-Gg: AZuq6aJ+wXyr+sfvyDU81+FsbgF0QYsX1y+zAwwjO3hcWcw4nAfNKRjVxpD1KEMy4vA
	9kOxsiqX2N0qM8BQIFXeV+/PQcRgqTYqUNIHdNqm+0pAic15tl6SLriq7i4aLfRxTFtyHN7PTPK
	L+kUNYwNeH4ETiIcVJGDqGXUuRstiom1phSqEVIqZz4Yf+GCqcIHR5AjjaDUVaPPx6atYzBaiOO
	qOLM96XrTsP8XiEUUrbx1gaqr/L1gh+/7SKImRr5ntV2R91NSgx5bnQF213+j53SDDMEGCfpd5D
	1Oe/zso=
X-Received: by 2002:a17:90b:52cf:b0:353:883:affc with SMTP id
 98e67ed59e1d1-358ae8c1c02mr1155214a91.18.1771629218380; Fri, 20 Feb 2026
 15:13:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130171140.90966-1-cgoettsche@seltendoof.de>
 <5893d15993a809a3b1b80deb0c27bf1e@paul-moore.com> <CAJ2a_Dddd=u9zGB0KB2-YeAbteByVa__4+S21mYxcPJi0DFm3g@mail.gmail.com>
In-Reply-To: <CAJ2a_Dddd=u9zGB0KB2-YeAbteByVa__4+S21mYxcPJi0DFm3g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Feb 2026 18:13:26 -0500
X-Gm-Features: AaiRm51eX-U3hDrBFzShcv0bgudCn6oy16DyMVCLMaMSmwmKykh_tUBjHw5VaPc
Message-ID: <CAHC9VhRu-bhodSjzmDDZmZebHwCa6C8OUNWd0NtdJoeUJPVS3A@mail.gmail.com>
Subject: Re: [PATCH RFC] selinux: prevent truncation of status map
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 31, 2026 at 12:18=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Fri, 30 Jan 2026 at 21:46, Paul Moore <paul@paul-moore.com> wrote:
> > On Jan 30, 2026 =3D?UTF-8?q?Christian=3D20G=3DC3=3DB6ttsche?=3D <cgoett=
sche@seltendoof.de> wrote:
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
> > >
> > > Closes: https://github.com/SELinuxProject/selinux/issues/475
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
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
> > >       .llseek         =3D generic_file_llseek,
> > >  };
> > >
> > > +static int sel_setattr_handle_status(struct mnt_idmap *idmap,
> > > +                                  struct dentry *dentry,
> > > +                                  struct iattr *iattr)
> > > +{
> > > +     /* Prevent truncation to avoid raising SIGBUS */
> > > +     if (iattr->ia_valid & ATTR_SIZE)
> > > +             return -EINVAL;
> >
> > Do we want this as -EINVAL or -EPERM?  However, see my comments below
> > about how to handle the ATTR_SIZE case.
>
> I did not choose EPERM because it is not a matter of missing
> permissions of the caller.
> The status page should just not support truncation and EINVAL seemed
> more natural than ENOTSUP.

Okay, I can understand that argument.

> > > @@ -1995,6 +2014,26 @@ static int sel_fill_super(struct super_block *=
sb, struct fs_context *fc)
> > >       if (ret)
> > >               goto err;
> > >
> > > +     /* Create "status" separately to assign a custom inode_operatio=
ns */
> > > +     {
> > > +             ret =3D -ENOMEM;
> > > +
> > > +             dentry =3D d_alloc_name(sb->s_root, "status");
> > > +             if (!dentry)
> > > +                     goto err;
> > > +             inode =3D new_inode(sb);
> > > +             if (!inode) {
> > > +                     dput(dentry);
> > > +                     goto err;
> > > +             }
> > > +             inode->i_mode =3D S_IFREG | 0444;
> > > +             simple_inode_init_ts(inode);
> > > +             inode->i_fop =3D &sel_handle_status_ops;
> > > +             inode->i_op =3D &sel_handle_status_iops;
> > > +             inode->i_ino =3D SEL_STATUS;
> > > +             d_add(dentry, inode);
> > > +     }
> >
> > I worry a little about duplicating and open coding the per-file loop fr=
om
> > simple_fill_super(), I can see things slowly getting out of sync and ba=
d
> > things happening.  Unfortunately, I don't see anything in libfs that wo=
uld
> > allow us to supply our own inode_operations either.
>
> We could ask the FS people if they would be fine with the following patch=
:

We probably need to give them another week or so to look at your
proposal and reply.   I'm very curious to hear what they have to say
on the issue.

> > What do you think about using selinux_inode_setattr() as shown below,
> > would this work?
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index feda34b18d83..8e4374f22a18 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -106,6 +106,7 @@
> >  #include "netlabel.h"
> >  #include "audit.h"
> >  #include "avc_ss.h"
> > +#include "selinuxfs.h"
> >
> >  #define SELINUX_INODE_INIT_XATTRS 1
> >
> > @@ -3291,6 +3292,12 @@ static int selinux_inode_setattr(struct mnt_idma=
p *idmap, struct dentry *dentry,
> >                         return 0;
> >         }
> >
> > +       if (inode->i_sb->s_magic =3D=3D SELINUX_MAGIC) {
> > +               int rc =3D selinuxfs_inode_setattr(idmap, inode, iattr)=
;
> > +               if (rc)
> > +                       return rc;
> > +       }
> > +
>
> I don't like that approach, since up to now selinux_inode_setattr() is
> only for SELinux permission checking and this would add some behavior
> modification into it.

I disagree with that characterization, but I'm not in love with that
solution either; special-casing specific filesystems always feels ugly
to me.  Let's see what vfs folks have to say about your proposal.

--=20
paul-moore.com

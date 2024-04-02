Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA965BAE4
	for <selinux@vger.kernel.org>; Tue,  2 Apr 2024 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052278; cv=none; b=ur8wpQCtZ6EDL+qNCQRbUuz208uXv//pz/BDPA2hTpIoUajezSm9J+7omcCfVi6lY5CYJSME2x97uSzyQSsXWm35zOaXy+EuEc6Yho/NqvK46IPX58z6aw5CdzMCpvCACXWpR0N8ZohVN33lRYh7ifk6wNlbXLX6xDrwD0Wcx+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052278; c=relaxed/simple;
	bh=4WsAmb2/FIx3KClU05I+7/iVMXriMEsNzKDpUnqnDuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AvN0rT2kv9OQEIYcGMzfi9Dw5b3uiPzuYxrONjw9LIyzo7xPTtPuvyh2eWECxRI0MyBKoVLYZj+Kla79ri3ghqTLS6mxyiGFfntGF6Lkh8/DMkdSIXleGjtpcEvkVj9Rp+VaNwH7rT7amU9Cx67e6vubPGsINrqrVZhdXqAxV3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=YCS/UND1; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YCS/UND1"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso4798123276.3
        for <selinux@vger.kernel.org>; Tue, 02 Apr 2024 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1712052276; x=1712657076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V66lZbHjUlb5EWgEJPW1R4TV5KrfTXnB0WKLqfxcFu4=;
        b=YCS/UND1AhucxUz23rv7z9rChd9C/GgksTXcPhKqPMaOfA0kxVnh/wtsfLltCKKfp2
         LacbbJmkZ9MEeen+MCGdAAjKTbTgcH+c1gaH62fJnSTvyEgxEcDBimtQAGD/CCM/zKRQ
         YrDULkKIjU7P7YknxSQaugVdrnqJSpDdMFcg56Fq4iTsIFw+Onnq23PymzyqVoEaHNFM
         R2Dc006ZlruHfM22BMpuPl8h4q84qX48Vip8SK/JelJlkOIHHwbcW0dh4taQzeVmFpoC
         Z4LOqVQ/6GhXfjWgDCUwSnDpbY0iacsZQVwyW3CtWIHHS9ikFf93xwZDh2e7mhBG3S6o
         lKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712052276; x=1712657076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V66lZbHjUlb5EWgEJPW1R4TV5KrfTXnB0WKLqfxcFu4=;
        b=rk9P2pEIb15iPkIjtbVkr8eibyZTWfFVpA8LnApvFDrS7qxZGRQthUelBsX+gg6j3N
         +RuYRjwfKJ+VfxkPuK14xEimSH07NRWA+IU4m7QXLeK5hOeGDOBDRi+L++eFSq+/KzvN
         A7ks9zND5FmzmVk/2oJFwb3SiLtAKIS3JTBuByCIPsoufH51VEVoLHFvCJ6k/pMhQ3n0
         u17Jq5VO68g3/xoqCjSvNOu2nHuAipajAMGAXC39kpckEf5vIgvQNc7QMwpv0FGThrA2
         SdDxwfndvgWUAJ5mgMwC97LqQ+awMB+bw5mnETZCN1T0ewZI7aWJDb1zUCzKqZvlUS9P
         QEMw==
X-Gm-Message-State: AOJu0YyfV4yd/l2+3EVsQj+ejgCjjvTPEy92OnSZCSgHCPoGu73Wawzp
	A1dLmRdTeVpIoUSsEJFaamWZHOERKjiWSa2MrYf0tpqejbL4rJSPMfkpneo1T+qnEb4rIm7fB0X
	FaM9IQEVY71cwRD/0HmeHYEPBx91bClmeBBMqeQ==
X-Google-Smtp-Source: AGHT+IH7YZrJpge6t/InGB70K16zOg09Qp9M8tdpE3ADf20BJWU6t5ruVbVgaC0J7NrLzhmL0umfb7ynS6nUrkq11u4=
X-Received: by 2002:a25:7a86:0:b0:dcc:f8e5:c8c8 with SMTP id
 v128-20020a257a86000000b00dccf8e5c8c8mr9689335ybc.45.1712052275503; Tue, 02
 Apr 2024 03:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328191658.210221-1-cgoettsche@seltendoof.de> <c5bd8689343995e38ff90368013dd80c@paul-moore.com>
In-Reply-To: <c5bd8689343995e38ff90368013dd80c@paul-moore.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Tue, 2 Apr 2024 12:04:24 +0200
Message-ID: <CAJ2a_DesuceB5Mfoq-_380kBgCM64gQBM4rDVOn6g=J3mUgZ-Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: avoid dereference of garbage after mount failure
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Apr 2024 at 04:05, Paul Moore <paul@paul-moore.com> wrote:
>
> On Mar 28, 2024 =3D?UTF-8?q?Christian=3D20G=3DC3=3DB6ttsche?=3D <cgoettsc=
he@seltendoof.de> wrote:
> >
> > In case kern_mount() fails and returns an error pointer return in the
> > error branch instead of continuing and dereferencing the error pointer.
> >
> > While on it drop the never read static variable selinuxfs_mount.
> >
> > Fixes: 0619f0f5e36f ("selinux: wrap selinuxfs state")
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  security/selinux/selinuxfs.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.=
c
> > index d18581d741e8..7e9aa5d151b4 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -2125,7 +2125,6 @@ static struct file_system_type sel_fs_type =3D {
> >       .kill_sb        =3D sel_kill_sb,
> >  };
> >
> > -static struct vfsmount *selinuxfs_mount __ro_after_init;
> >  struct path selinux_null __ro_after_init;
> >
> >  static int __init init_sel_fs(void)
> > @@ -2147,18 +2146,21 @@ static int __init init_sel_fs(void)
> >               return err;
> >       }
> >
> > -     selinux_null.mnt =3D selinuxfs_mount =3D kern_mount(&sel_fs_type)=
;
> > -     if (IS_ERR(selinuxfs_mount)) {
> > +     selinux_null.mnt =3D kern_mount(&sel_fs_type);
> > +     if (IS_ERR(selinux_null.mnt)) {
> >               pr_err("selinuxfs:  could not mount!\n");
> > -             err =3D PTR_ERR(selinuxfs_mount);
> > -             selinuxfs_mount =3D NULL;
> > +             err =3D PTR_ERR(selinux_null.mnt);
> > +             selinux_null.mnt =3D NULL;
> > +             return err;
> >       }
> > +
> >       selinux_null.dentry =3D d_hash_and_lookup(selinux_null.mnt->mnt_r=
oot,
> >                                               &null_name);
> >       if (IS_ERR(selinux_null.dentry)) {
> >               pr_err("selinuxfs:  could not lookup null!\n");
> >               err =3D PTR_ERR(selinux_null.dentry);
> >               selinux_null.dentry =3D NULL;
> > +             return err;
>
> Casey's correct in that we probably don't need this, but it does harden
> the source a bit against future changes so it isn't entirely a bad
> thing.  If nothing else, some new kernel dev will get excited writing a
> oneliner several years from now that removes the redundant return; I'm
> getting exited about the patch just thinking about it.

I put this seemingly superfluous return statement, due an additional
patch which adds code in between the end of this branch and the final
return statement.
We could change the final return to always return 0, since all errors
are now handled on their own, to make things more obvious.

> Anyway, thanks for noticing this and submitting a patch Christian,
> beyond the above nitpick, everything looks good to me.  I'm going to
> merge this into selinux/stable-6.9 with a stable marking and assuming
> all goes well I'll send this up to Linus in a few days.
>
> Thanks!
>
> >       }
> >
> >       return err;
> > --
> > 2.43.0
>
> --
> paul-moore.com

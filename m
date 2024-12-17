Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5907714885B
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467219; cv=none; b=UiSe7FC7GtzhYFmz+r/p9pxyeHTR+8QAaHUunBvIPCHlq2cPLZmG2OWLhAM0UXQ2nU5kF2ngVT4NPDZuaxRu3y7LForYcPpdhKn9yamwTZYypljgQczN5CEQfrEC9cH2P5X4AQiBPoHQYalussG0Ra0lRvGPVhQwhHWwC5KnbQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467219; c=relaxed/simple;
	bh=WURXjxpxxHD5vWxRXdjnulFfeTfRoVrDmSqst7e5d/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDSnyM6u0rg2elQm8ImjT5Ew1LbjkyN6bxePbNubC7idjFmOACOC/EJlG4pvCmKFg5U/1Fk1BGOtawYxnGeQGDOkkZbQPF/IVkiQ8ReWN8kJ15kj0GKJIOoMeiNmVBSiL79HHIjDOcRcEIjBFS9/v2IXm+ye2itNpcjg2PtSl9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIUrGP4X; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIUrGP4X"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-85baea70afeso1208872241.2
        for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 12:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734467216; x=1735072016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOGZVsS1u6o0rXuuKwgqvr3DOLUAyNsTm6a2QBTBnEM=;
        b=XIUrGP4XT3tIKNKa2m53Wj4tSQd4J5jNcw1BElFLh0AeulxQvY3bYoAhIHAUtOl/1n
         /jJUEiTXPWHtrLJUGR/JrGL0a/9CN9FVDHrVV8ZU5v7wbjkEsj8Pc3gNVEnsxhWQi9mR
         5ASP8VuV+fqBL/iZkTwVJvJRmsOCokt5ZnPrV8sMgEab9VghFBaxsO9aisI2mvBdcpLr
         QFSadCMC2tkTMEMxA0rFzzKVf9jv1I6HXknqmSYU1x6IAQFRRDjZPGab9f+a1WnlY5m0
         kDmwCB8CXvspMHq8JivbPjfxy+IquarOX4H0UQ3jqTvIBGLrObg/pWjZobvoL+bswo2K
         Tkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734467216; x=1735072016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOGZVsS1u6o0rXuuKwgqvr3DOLUAyNsTm6a2QBTBnEM=;
        b=hKFy+iaFSjIEpdpNjHfduXJGK+Ih1RKI1x16EOSRLgHDmISqfJ/FTPld3F9pc/b7XO
         21uNt0/NlYI391LehFxAZrpQddwMx/i1uFPpx6c00cM8gwTPUgu9Vp687onc1GKtUOGw
         s8Nmp41bH7cUQNhyIMrkRsID0UhZK3h962F52APTHUy3lfD146bJo34mzjsnkh+s9rUU
         +k5DViZW9697vbNflDhZumDCl5YRZhpO3MRrF1+vYZt/1xypzeMbWLxeEkHuOOk5FNZY
         w9sPRynrLiXS7PQnGAK3ZFRq076zMDAZErhq651i4U0YEOJhpAbvWNKSc3i0klJalo0q
         HjYg==
X-Gm-Message-State: AOJu0YwqM44QKlWMM45hXxgr9DEzIwhDZ90/ckSnHqLIi3LIaen7K+tx
	7SSDcCoJBByqhLxQm2trvtbD7whfCaJR1YluLJMScpxDfwbZrZej3dPRr4zyGsl5dRUf1ybWCue
	MOimscAnQpQUZrUcFqH05LcaBG40=
X-Gm-Gg: ASbGncuodNPOmJqgtxqamG2jN0nShsVE5krjXc+cnXJaWjo2Qti2tHuzrQnncIMtfXs
	ktjZC7FV7cUD4CwR8WMSPBIGdrvuBaUNRBJ61Qg==
X-Google-Smtp-Source: AGHT+IGBfiW4exMx0j5R8xsHDUnQdRG+RC2MY1xv6M0K0SP19jwygCAjmUBwXtti0k64D0rfzBMhQBotWFlLZPwZTgE=
X-Received: by 2002:a05:6102:418e:b0:4b1:1b24:7241 with SMTP id
 ada2fe7eead31-4b2ae7824f7mr336007137.15.1734467216110; Tue, 17 Dec 2024
 12:26:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212185416.2187747-1-vmojzis@redhat.com> <CAP+JOzQ=pzzFmtCQRTP+3YqFsVjwwV9t3r2uGFF40o58cetzaA@mail.gmail.com>
In-Reply-To: <CAP+JOzQ=pzzFmtCQRTP+3YqFsVjwwV9t3r2uGFF40o58cetzaA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 17 Dec 2024 15:26:45 -0500
Message-ID: <CAP+JOzRU1nGp-fEmAGaVcMUthptycFq2nDPNFYtfbJ6pyyMSuQ@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: Mute error messages from selinux_restorecon
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 2:27=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Dec 12, 2024 at 1:58=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> w=
rote:
> >
> > Mute error messages produced by selinux_restorecon when rebuilding the
> > policy store to avoid error messages in containers, image mode, etc.
> >
> > Fixes:
> >  #podman build --security-opt=3Dlabel=3Ddisable --cap-add=3Dall --devic=
e /dev/fuse -t quay.io/jlebon/fedora-bootc:tier-x . --build-arg MANIFEST=3D=
fedora-tier-x.yaml --from quay.io/fedora/fedora:rawhide
> > ...
> > Could not set context for /etc/selinux/targeted/tmp/modules/100/rtas/la=
ng_ext:  Operation not supported
> > Could not set context for /etc/selinux/targeted/tmp/modules/100/rtas:  =
Operation not supported
> > Could not set context for /etc/selinux/targeted/tmp/modules/100/rtkit/c=
il:  Operation not supported
> > Could not set context for /etc/selinux/targeted/tmp/modules/100/rtkit/h=
ll:  Operation not supported
> > ...
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2326348
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> > I feel like this is probably not the best solution, so feel free to
> > suggest a better way.
>
> I feel that it is fine in this case. It is limited and there is
> already a comment saying that we can ignore errors here.
> Thanks,
> Jim
>
> > The logs are all the more annoying because there is so many at once and
> > they clog up the logs and terminals so I am wonering about removing
> > the ERR after a failed fchown as well.
> >
> >  libsemanage/src/semanage_store.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanag=
e_store.c
> > index e44efc16..2ca2e900 100644
> > --- a/libsemanage/src/semanage_store.c
> > +++ b/libsemanage/src/semanage_store.c
> > @@ -3000,15 +3000,29 @@ int semanage_nc_sort(semanage_handle_t * sh, co=
nst char *buf, size_t buf_len,
> >         return 0;
> >  }
> >
> > +/* log_callback muting all logs */
> > +static int __attribute__ ((format(printf, 2, 3)))
> > +log_callback_mute(__attribute__((unused)) int type, __attribute__((unu=
sed)) const char *fmt, ...)
> > +{
> > +       return 0;
> > +}
> > +
> >  /* Make sure the file context and ownership of files in the policy
> >   * store does not change */
> >  void semanage_setfiles(semanage_handle_t * sh, const char *path){
> >         struct stat sb;
> >         int fd;
> > +       union selinux_callback cb_orig =3D selinux_get_callback(SELINUX=
_CB_LOG);
> > +       union selinux_callback cb =3D { .func_log =3D log_callback_mute=
 };
> > +
> > +       /* Mute all logs */
> > +       selinux_set_callback(SELINUX_CB_LOG, cb);
> > +
> >         /* Fix the user and role portions of the context, ignore errors
> >          * since this is not a critical operation */
> >         selinux_restorecon(path, SELINUX_RESTORECON_SET_SPECFILE_CTX | =
SELINUX_RESTORECON_IGNORE_NOENTRY);
> > -
> > +       /* restore log_logging */
> > +       selinux_set_callback(SELINUX_CB_LOG, cb_orig);
> >         /* Make sure "path" is owned by root */
> >         if ((geteuid() !=3D 0 || getegid() !=3D 0) &&
> >             ((fd =3D open(path, O_RDONLY | O_CLOEXEC)) !=3D -1)){
> > --
> > 2.47.0
> >
> >

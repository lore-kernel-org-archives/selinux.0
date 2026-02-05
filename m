Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA113BFE36
	for <selinux@vger.kernel.org>; Thu,  5 Feb 2026 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296696; cv=pass; b=OXLrcBIgbzA2mCf9CqjCWa5h4SuSOImQi8QUltElL7CGTJ3KyvmBEnTREYOrbMmym8DXKs8yADhnHyDEgtZLJGA6uUvM2FkK2mD1KzPRr43caf+dtmmQZ6Efo6PSri61GCmb8+bebTdUWXEpJPDLM5pIAGWahKfiIuZKL24Kt1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296696; c=relaxed/simple;
	bh=N2c1RM0b4ERNHu8Wc50fN3R9BsKRWCfa11p9n8FFco4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eok5C+7ffALHn+vK+LUNGzMJRcGbFUsSdo8UJSz/5WlLjcetqaE39uZ2E8AjMbOUSW36BYagf0Tp7/ckuc6BjOTKz9NnXc4kpJJ36qwDziz0PgMXD8f6DPkaWCTdiYDU3u4dlsRRg+M6hksM/7RcLsV7WhE3FujonheQYhSOjSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFj/Wgov; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFj/Wgov"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-432d2c96215so755461f8f.3
        for <selinux@vger.kernel.org>; Thu, 05 Feb 2026 05:04:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770296694; cv=none;
        d=google.com; s=arc-20240605;
        b=Qf57qV7SolnlY3Rz+o8lO94pTW9Lpl89tv2J/139yUpgXvE3Xx21YqjIxSY6RLJIo7
         IMJVoMKSD8LVsj6atSdCTaGXwpvaAKXs1iePxFVcM1HVqxHkddjBbK6l8RWXBY9QwcJE
         a1fDvktt8RgAjv/zHGkVkOEpJF+/9ZNMtKpM843k406UhA0UCjUo+azp2yz9PRliRora
         8NCVDmxTG53aIPG+szP9BJJpWiPiu3FMGWu8IBtmSG9xTAFmFaFH6fLzrqTd3E27XT6O
         s3d1A7E59YmKAjql3AQA/OvWl7Ao9BMMR77zD5RVr27vEUratDvtHcp0H6zBELs/jbws
         2s4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5QIFMxkl9qDrU626LjrUWWxNqKmOaBddIPVVlA8pXoo=;
        fh=zu08bYvYTZ7pouIC/a14uXYFM0HO8KBFSt2+9+J935U=;
        b=k02XE2JL0sSzahrgEmGfUdhMdn28Rajoir2P758374n+/PUYICPAXqykhFabv5w6lY
         TXxVCk0jKO3rAsoEeV/m+h7hyLwT983OPsW79VFkVePJSiTnI6Bj/1PBNJe2/Tjdlm/w
         iQqsvtUJC3NXEv5X9yoNJeCqqeE1FaM9KNf/3aWZb66goeVzmojt1jAYTTd8baGn8nHb
         3GxdAaeyWjcNqJ+gjiphG7zcUXuMLW887WqP5yt4zr+hfzh09j3JRJJ4LSxrCzNTvado
         PZz66ms0flMaJFw6oKx5RsrQI0VKeRnKiQpMJLNiKtiRBNYGd8r6TRcBCbDHgi6A2eH6
         YD0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770296694; x=1770901494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QIFMxkl9qDrU626LjrUWWxNqKmOaBddIPVVlA8pXoo=;
        b=eFj/Wgovw5nx28AuntEcmYhTLWrcShD+FEPlxv8t7bORKwNp4fZgpa1A8jYpx19B7V
         zpkQAXJ4K4F1Rv7pM72BhwnMUSRonxs65fpBhDO4SGuX0qAlWPM8t4D5sePSeStUIeFr
         q/hMmt72lMyU9ipFKtciig6U6q4SzUh9UN7CUoRKLW2gH8q1i1KthFAMEUcimBVmwnkX
         fbv53HjAq8YAWe/nohi9dOQlYvBcBwPjRxIto8GV/ST/gaM13N9HphSRgAZAg+w0Rq6K
         YgOePfLA4Z3vgrxDj4Z5paCLoAaxyEGqvGJgUxqAYNThBSY9LBmewV+08tHdpfqS5uF6
         B8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770296694; x=1770901494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5QIFMxkl9qDrU626LjrUWWxNqKmOaBddIPVVlA8pXoo=;
        b=F9XSL7KtNyfzJUGjUL+PonObJ/IG/rqRopBQACE5rP2hlmhbxLYka9wJtSqBNXJ5MG
         ssRvIxhFn4jaH0ECQHeHLN/iwQZ7ofCXQX1c3S3RPrEkKpH4N1glPNJPeZiua4ok2uHo
         3XpWvP2aLJ8R67TR4Xkt4LG6J3LNhfuaX+BPzcP0P+ISaB1/UHba1L/O93XsjJAn7jun
         68PVnKROewkLhdRP4meZZ/wnyDs27Rr024H5if9w6oF7mh5OcguU6DoW6dJRjyNV1FW/
         ffu0+kNGpjo7673LuOlefQL1zwRimKJID5fHjQTYXW8ZfspWaff9YOuFkLV9X6w+Egbs
         DE+g==
X-Forwarded-Encrypted: i=1; AJvYcCUJnkhE2BuDrdUebLtei+4zAXpaU+WOOBZirr1NFjsNhQr+jAx9trETrXimdv6grn11fKvc1hKL@vger.kernel.org
X-Gm-Message-State: AOJu0YxwsxCmp4ti9r+GLfFqDEkRvY+v+DmkgYvWyDgSCaGpiA5bZ8BO
	LH4z4oOBX+VO3+eTUfWsfS7Ph3PCC6YDcC8hWYG5QFzoeFrZnLXcZRsvbVdBzlv61U8iH9RaUfv
	Nse1YSnX/LLIYeqOFjjmw4rCcmP4OlFs=
X-Gm-Gg: AZuq6aKn+qQQHy+6xCR+HxnguFzF9ixS5ki8CtyXc5HhenPM/s7ZA34OV6svdtBWEpe
	WPQbw70iCMHjgnM9TwvBa01mR8O9x99JwbNJgCeGfrOoEmkAbjf66T7QgfezoIacKzJUokrw6m5
	cIIhZazFVmFk4IPbSpfUuumMB21WjIWrFzF5UN1qGU+g9DqZwfLPBhhAjd8ax9mJuqKWinwpebS
	go+yepDb1kgrHrubrDTODnZHThs0/LpxBZy6EcMUa9uT4QF4K+eC5px2nEgL9r+1eUZD5NHkWfI
	9QH3Y9sTJVnC8gpq2GA/cUMSis/qug==
X-Received: by 2002:a05:6000:1acb:b0:432:5bac:3915 with SMTP id
 ffacd0b85a97d-43618053bc4mr9962281f8f.39.1770296693827; Thu, 05 Feb 2026
 05:04:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-9-neilb@ownmail.net>
 <5d273a008fc51a2fded785efbe30e5bd2a89b985.camel@kernel.org>
In-Reply-To: <5d273a008fc51a2fded785efbe30e5bd2a89b985.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Feb 2026 14:04:42 +0100
X-Gm-Features: AZwV_QhEkTNuUX-zP-udJB3TTtiGdaNYEr11QFKjoqWXaHOUCtxdu5bQUZv0f1A
Message-ID: <CAOQ4uxh_Ugyy9=Vx_XOzWMTdhqVx6kAu43q+F+afhNF_Zv_9TA@mail.gmail.com>
Subject: Re: [PATCH 08/13] ovl: Simplify ovl_lookup_real_one()
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 1:38=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Wed, 2026-02-04 at 15:57 +1100, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >
> > The primary purpose of this patch is to remove the locking from
> > ovl_lookup_real_one() as part of centralising all locking of directorie=
s
> > for name operations.
> >
> > The locking here isn't needed.  By performing consistency tests after
> > the lookup we can be sure that the result of the lookup was valid at
> > least for a moment, which is all the original code promised.
> >
> > lookup_noperm_unlocked() is used for the lookup and it will take the
> > lock if needed only where it is needed.
> >
> > Also:
> >  - don't take a reference to real->d_parent.  The parent is
> >    only use for a pointer comparison, and no reference is needed for
> >    that.
> >  - Several "if" statements have a "goto" followed by "else" - the
> >    else isn't needed: the following statement can directly follow
> >    the "if" as a new statement
> >  - Use a consistent pattern of setting "err" before performing a test
> >    and possibly going to "fail".
> >  - remove the "out" label (now that we don't need to dput(parent) or
> >    unlock) and simply return from fail:.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/overlayfs/export.c | 61 ++++++++++++++++++-------------------------
> >  1 file changed, 26 insertions(+), 35 deletions(-)
> >
> > diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> > index 83f80fdb1567..dcd28ffc4705 100644
> > --- a/fs/overlayfs/export.c
> > +++ b/fs/overlayfs/export.c
> > @@ -359,59 +359,50 @@ static struct dentry *ovl_lookup_real_one(struct =
dentry *connected,
> >                                         struct dentry *real,
> >                                         const struct ovl_layer *layer)
> >  {
> > -     struct inode *dir =3D d_inode(connected);
> > -     struct dentry *this, *parent =3D NULL;
> > +     struct dentry *this;
> >       struct name_snapshot name;
> >       int err;
> >
> >       /*
> > -      * Lookup child overlay dentry by real name. The dir mutex protec=
ts us
> > -      * from racing with overlay rename. If the overlay dentry that is=
 above
> > -      * real has already been moved to a parent that is not under the
> > -      * connected overlay dir, we return -ECHILD and restart the looku=
p of
> > -      * connected real path from the top.
> > +      * @connected is a directory in the overlay and @real is an objec=
t
> > +      * on @layer which is expected to be a child of @connected.
> > +      * The goal is to return a dentry from the overlay which correspo=
nds

As the header comment already says:
"...return a connected overlay dentry whose real dentry is @real"

The wording "corresponds to @real" reduces clarity IMO.

> > +      * to @real.  This is done by looking up the name from @real in
> > +      * @connected and checking that the result meets expectations.
> > +      *
> > +      * Return %-ECHILD if the parent of @real no-longer corresponds t=
o
> > +      * @connected, and %-ESTALE if the dentry found by lookup doesn't
> > +      * correspond to @real.
> >        */

I dislike kernel-doc inside code comments.
I think this is actively discouraged and I haven't found a single example
of this style in fs code.

If you want to keep this format, please lift the comment to function
header comment - it is anyway a very generic comment that explains the
function in general.

> > -     inode_lock_nested(dir, I_MUTEX_PARENT);
> > -     err =3D -ECHILD;
> > -     parent =3D dget_parent(real);
> > -     if (ovl_dentry_real_at(connected, layer->idx) !=3D parent)
> > -             goto fail;
> >
> > -     /*
> > -      * We also need to take a snapshot of real dentry name to protect=
 us
> > -      * from racing with underlying layer rename. In this case, we don=
't
> > -      * care about returning ESTALE, only from dereferencing a free na=
me
> > -      * pointer because we hold no lock on the real dentry.
> > -      */
> >       take_dentry_name_snapshot(&name, real);
> > -     /*
> > -      * No idmap handling here: it's an internal lookup.
> > -      */
> > -     this =3D lookup_noperm(&name.name, connected);
> > +     this =3D lookup_noperm_unlocked(&name.name, connected);
> >       release_dentry_name_snapshot(&name);
> > +
> > +     err =3D -ECHILD;
> > +     if (ovl_dentry_real_at(connected, layer->idx) !=3D real->d_parent=
)
> > +             goto fail;
> > +
> >       err =3D PTR_ERR(this);
> > -     if (IS_ERR(this)) {
> > +     if (IS_ERR(this))
> >               goto fail;
> > -     } else if (!this || !this->d_inode) {
> > -             dput(this);
> > -             err =3D -ENOENT;
> > +
> > +     err =3D -ENOENT;
> > +     if (!this || !this->d_inode)
> >               goto fail;
> > -     } else if (ovl_dentry_real_at(this, layer->idx) !=3D real) {
> > -             dput(this);
> > -             err =3D -ESTALE;
> > +
> > +     err =3D -ESTALE;
> > +     if (ovl_dentry_real_at(this, layer->idx) !=3D real)
> >               goto fail;
> > -     }
> >
> > -out:
> > -     dput(parent);
> > -     inode_unlock(dir);
> >       return this;
> >
> >  fail:
> >       pr_warn_ratelimited("failed to lookup one by real (%pd2, layer=3D=
%d, connected=3D%pd2, err=3D%i)\n",
> >                           real, layer->idx, connected, err);
> > -     this =3D ERR_PTR(err);
> > -     goto out;
> > +     if (!IS_ERR(this))
> > +             dput(this);
> > +     return ERR_PTR(err);
> >  }
> >
> >  static struct dentry *ovl_lookup_real(struct super_block *sb,
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Otherwise, it looks fine.

Thanks,
Amir.

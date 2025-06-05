Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6B28E17
	for <selinux@vger.kernel.org>; Thu,  5 Jun 2025 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749160278; cv=none; b=bRk6Hprmc6+TZtvP3mdJN30vj4yefwN/WKTyeuL/FBmEmmjvJPXdx7e35EEFAgtdgMXB7hToE5+1Jozs/ju9WmD6JNNYf54LQCRCl96F9aBOid/SqFo4yWA73QY05+m0lMUGOpKe0oV58ujhT4gw+DQX+VjIXj8weNJmMdpK2uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749160278; c=relaxed/simple;
	bh=755S9h4e3lhJ7G6Amq1GHJNIb3T3WttwHIsYDZsZMa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7IhJjV0gd4hubEjKA9S5o6kX6bnEYVII6DEFQX+xwOnM761sjAl7jhe7QsIVCUwvJgTCza/oQunRG+NxwB3rD7ImfVml8CXoi94AfOSbaP4AzF0ehmdvwm1Sx+60ZlZxTUDZ4HKRLtgoGHeiU/u7u9XzjOoOYBwlWNy1afmnaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Sr3oS6Gd; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Sr3oS6Gd"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e740a09eae0so1489310276.1
        for <selinux@vger.kernel.org>; Thu, 05 Jun 2025 14:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749160275; x=1749765075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q73clLkN9MkZDXUIYnVM17RaAmlbhc3zBqb9kmZ99dU=;
        b=Sr3oS6GdEGYwsE2mi0S60CgNYia4G4b0ul2nB281p+/nMSQfB3n8EZ4dgxfPR/f7LB
         Jx2O/CGEgNAPGxokX1CdblB3WRb0q+Yi7MDicT2g5CCr3aFRo+dBiwooSe19L9NtJkTk
         DYibl+RIxvrZ4Cow9NjwH4s8HF6NnfUg6kTBFZW2krQdLtg71Oe+sOFVy0QZt3E4Ijo2
         Rvpw2oIe2I1nyzwm4EIpJ/+IKJuAkMj8FL90mJ3YFA61G7dNsswSa89nJrTmT927KMR8
         oHsGaFefU7/KEHEA5HUCvXbjqO4Lxno7Iv3fo8WAndI73ASstq+fRBt0O5e7xms8wIFL
         17SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749160275; x=1749765075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q73clLkN9MkZDXUIYnVM17RaAmlbhc3zBqb9kmZ99dU=;
        b=WY61Vaf44t5vyH/m884w97n7B7SrRldhkKwy8cTbh5iECeLTq9Aj/sP93d9LSTx60M
         wAECQCio6DAYqR6hgMXG3yQFQWqjMldiSCzhDM0NyyhrYP+61U1T8JyTL2hSPfGRHJOD
         TpK8ib5QWi1QpiAksEqLSpkQx4xnLd+b+5K/ucYU0/7CUhyNFy9MdojoYNHamQ088W7Z
         lwVHc8pyJ2VEyksyVM7zT23uWuan3NQOrdlP9amNfX3knixFcALmch9KNv7A4/+oQywz
         mFKN6Wvhn2VvsmBbHQnjppQg2xAEVCaJ+Fd6qum+6PH1J7laIWNyfssy3+yEZQbO2Dnn
         Myhw==
X-Forwarded-Encrypted: i=1; AJvYcCVS9BNGo7t9Pru2uvUCGdSENN1vCAkwSwGaGDJpE3txj9ogeMzrlVDXEWGuLw7td5P3Vy3nkIJr@vger.kernel.org
X-Gm-Message-State: AOJu0YyiJsc/EhBBc7W9LN5BVV1xK2IO2gI6DruBP6U0UgIjF92jTdHB
	uR+99x9gulQ20ak4zZ3kOSaLQAMbrwRpSwmz9IuF/NMHHJGuK24vf8DiRiZ3+2g2nXr6Ie+SG7P
	KJGw8L3c/6IWbzwZFdnLpjx/1IFNCCvMdd791qW+V
X-Gm-Gg: ASbGncvADDXK4kc8YnfirXDLtMH/WQcWg+1kgmSOk+k66ZbdDjbPjUJwhqNq05UGbXL
	Rgfp3BX970oC3M2SiyAOov6edfurecJBam7k4QsQ7MIPgYiPLibexF0bxn9OCBeABRXzr5bwETj
	jcDMujEG3BrE2sta99lPG99E1aze03uITS0uDSQ0nXdA8=
X-Google-Smtp-Source: AGHT+IH8rWmL3NURj++utqdkH+5GRnHoJxWmeuuvsdqQh8WxSx0oAPFT99bO6nYMRzPjhD6n87qofS6a5Gelido0y7s=
X-Received: by 2002:a05:6902:2b06:b0:e81:9cbd:d184 with SMTP id
 3f1490d57ef6-e81a2562ab9mr2014351276.47.1749160274822; Thu, 05 Jun 2025
 14:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605164852.2016-1-stephen.smalley.work@gmail.com> <CAHC9VhQ-f-n+0g29MpBB3_om-e=vDqSC3h+Vn_XzpK2zpqamdQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQ-f-n+0g29MpBB3_om-e=vDqSC3h+Vn_XzpK2zpqamdQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Jun 2025 17:51:04 -0400
X-Gm-Features: AX0GCFtSaj5dP0qo5NwUElUF5HvPHPlbkWWjHsO-9fmw1SjRtP1N3S6_O6Cdmgs
Message-ID: <CAHC9VhRUqpubkuFFVCfiMN4jDiEhXQvJ91vHjrM5d9e4bEopaw@mail.gmail.com>
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list()
To: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	collin.funk1@gmail.com, eggert@cs.ucla.edu, bug-gnulib@gnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 5:40=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Thu, Jun 5, 2025 at 12:49=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > commit 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always
> > include security.* xattrs") failed to reset err after the call to
> > security_inode_listsecurity(), which returns the length of the
> > returned xattr name. This results in simple_xattr_list() incorrectly
> > returning this length even if a POSIX acl is also set on the inode.
> >
> > Reported-by: Collin Funk <collin.funk1@gmail.com>
> > Closes: https://lore.kernel.org/selinux/8734ceal7q.fsf@gmail.com/
> > Reported-by: Paul Eggert <eggert@cs.ucla.edu>
> > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2369561
> > Fixes: 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always inclu=
de security.* xattrs")
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  fs/xattr.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Resending this as it appears that Stephen's original posting had a
typo in the VFS mailing list.  The original post can be found in the
SELinux archives:

https://lore.kernel.org/selinux/20250605164852.2016-1-stephen.smalley.work@=
gmail.com/

> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index 8ec5b0204bfd..600ae97969cf 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -1479,6 +1479,7 @@ ssize_t simple_xattr_list(struct inode *inode, st=
ruct simple_xattrs *xattrs,
> >                 buffer +=3D err;
> >         }
> >         remaining_size -=3D err;
> > +       err =3D 0;
> >
> >         read_lock(&xattrs->lock);
> >         for (rbp =3D rb_first(&xattrs->rb_root); rbp; rbp =3D rb_next(r=
bp)) {
> > --
> > 2.49.0

--=20
paul-moore.com

Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664FB3328E1
	for <selinux@vger.kernel.org>; Mon, 23 Feb 2026 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867918; cv=pass; b=BTgtpoJegT9hPXtutpsCqZ1JGjL7UxEpEp0M7o/AgcjgHNsDxtdlTA0lEfT1l/1xf1okmSPhEzGRqCOsb7OMy7E7gFOyYWxNRvq4LiQReWgcR/KskZbLeE6IMy6riqmv4Z55zxArlg3b9vEnZSoVsIQsYd6lS6ijH+tsG68rnZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867918; c=relaxed/simple;
	bh=hK/0jeoKCkucbRZSvX1AYVctVojQdWNjxRFJpKPT85c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grjlGxhE+g1KnfZY499G6l+kmFyHsHlCjW10e/t38CshGHoyh5bk7jlCXeH/CrLHU3ECXOfKWsVRBszIBzNIwjSZS/kLB4j9OarSJU4xmpjXVw9dc/kSem3qdbDjdAtrmt8ek+SOvfzzYuWsqBumCNo1lUxCCcKPPShzwhVmlB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F+M8ReRS; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F+M8ReRS"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-354a7b089bbso2628270a91.2
        for <selinux@vger.kernel.org>; Mon, 23 Feb 2026 09:31:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771867915; cv=none;
        d=google.com; s=arc-20240605;
        b=fJGeNI1Ew5ZTL0lzJkAJmL34M6bpnsXiiPcaDwNzcn9NhcigvoAaYg97u63nhmrPlu
         scolLWJn7WvgVxuHyuRIWQfyXGsEOmdMIRXTC9wBVMmvMjq1eS/RNBjW8dClfAKAS3z3
         TYrXyfeYIlnPPpnu4EhZdwxD0Gsq0tPri7/efIUypoarhk62FlVU7gT/AiNv5j+ShI1e
         lmpYv6fzwJEq5UxSqPV2ss/p8YjjBi7f4Sot4BZaZ06EvexvBkdnmoP73ueDU9k7Dz04
         jlQIATU7QDZRqgLiooiQzyfu5ie9bK2XYgMFhSSKlfgbz4fHkA8EkXo6tQ9F29FTBy85
         HbYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6UKo5s8UZQoKFDeeGaREA8NHzO9NWVOgEQkt9hAvBaw=;
        fh=/FF2rFqtTEW4zC+J/0E6h0DmcS+846lDbqPdySvvnw4=;
        b=QCbSOD/GE1NWrNJP5w0CzTWLmJLDVw1xRlVwMb/qAXpA7ac575ygALVZdaHYYlYJSr
         DOeyKTBPH54PGAJOIEtk93fLTcbFQyKF+0NLXma5jR1RgjCakfwA6Gz8sAzCkU1gZjGy
         03715u+nvgui8WNvrPAv4Ai1Nc+LAiXADkh70uiTnkEtmBxo6x2tzjAEjLE5ep3giV33
         5zh0YDlnrAz0ln9xenkkRwDBLC7jd5Jm3B5qwjVUxSrLjnRginZRibiaYMvNBFv7rSU5
         Xp673SwwEJ1JaXCdAjQU0JXhgpBf3KfRr6ytSBVobrZi2hjp8ybffwt6JlKJfqiAq8gb
         rwlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771867915; x=1772472715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UKo5s8UZQoKFDeeGaREA8NHzO9NWVOgEQkt9hAvBaw=;
        b=F+M8ReRSjHBcODwL6YMsB62k5KM9tS8sOWzeJ5+cgWNwRgCriw3XQa/eD8Yx/Hni30
         IdB+LiB/ApJjquQB5KcxVEI5HLkLWuZ1vTpKyL0E0HUfvIQZRWdXowU9+z67g7Gwx52C
         +oyHQZzV3WLMrQboFAG7U9dC2B2apXVJrFgLqbBoeCt8vO8eZLDHjMm8iii0dsQnf5WW
         Z+IHssdjgGYFzkGRQY1XVAsJ4gq0CVWEFyPOg2QbuYKPHrO7FhEUN0jl57qhGgMjZ2bq
         zTkZ+QXwpKHtOYw10dJFzE57zltv532RD2Y3Hk+vJDyanvg3sI0G/4PpvFt2TNvnCaPd
         NKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867915; x=1772472715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6UKo5s8UZQoKFDeeGaREA8NHzO9NWVOgEQkt9hAvBaw=;
        b=RPK9ivV5Yf3JfhZZCm77f9UjigiHZmUyv8w82fD5j9ouE9XQqvRj5qqSxlPYwLjq7v
         0cJR+Njjl4jJkQpMt7+/FH7Yk9ypKPwUuyKKKQiIx+pvLL9QfxQPxU6CF6JhoGwDmIJx
         SkkEyJUaN0tgsMo0qiRvXgqk5Fr5LC8Yqm+YmUOibDIiRPC9zE/r3f2B/6U3KodUUxuX
         4pCWqdtMetUNhRtYKFluDBWAdz+UQZEP1CFG+/WijRpnXB3apHnkJYO/qFP8R222AX0g
         arTH1U0UvDy3JVGZM5S3tY0afWHHYZzNN1QX9Xq8/95VjIO3MYD93fA2rlSsj8iyMWHb
         +gvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvYu7CvQku8rdDGZPo+t/7MpwiqBOhhcFPReUUOVq8ZJsl5Hm3Xjb1SASEDfyrWGL4PrDqzXzw@vger.kernel.org
X-Gm-Message-State: AOJu0Yxas/P4RJY+iXkVireus94FQctpmk7jCowX8Qcm8kSN5pC8GF4e
	rJPSVNpPGFzp4j5fmt4c7BbazAwilBW0SGaVcoUe+zxptefSiTvcg6hzYDLFkLuTSbCuse6DTIP
	zDk8kSMNHyn7pr4DkR6ChkFLv/b70HG4ARxtKml7o
X-Gm-Gg: ATEYQzxmmkTYA4vCgU30XnX010kipidaSXMxXIk7yYT4jicCMj0Vew4wtpLSUAXHqPQ
	6cZWbWULfD8TRWjPOcbW5kK5iEkLyIiYXvfdTEkXRKHAmxuc77kXsqQ8ZjYJ8K4JSlvorAS6lBu
	LSRgBQejPxoXbUa0IyBHEUo7gSSCRgYkslNjD5jG4Ir8DrxBPCcndohZcZj570dPiH6BkAvd+5i
	MKiMGbR+Ukyk/pVr0cGE55SOLvdfxNzuin/69a93tEkzQ7TPiqToBaSWuRKTDDhY+NkmYUFldSi
	nSeiwCo=
X-Received: by 2002:a17:90b:2543:b0:352:b674:2592 with SMTP id
 98e67ed59e1d1-358ae7c3605mr8357173a91.7.1771867914678; Mon, 23 Feb 2026
 09:31:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223011210.3853517-1-neilb@ownmail.net> <20260223011210.3853517-7-neilb@ownmail.net>
 <20260223132533.136328-1-clm@meta.com>
In-Reply-To: <20260223132533.136328-1-clm@meta.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Feb 2026 12:31:40 -0500
X-Gm-Features: AaiRm52jwDH7iM8Njra-WDPg6xnZ2flvbCTBnLCHZ5MkdIrvbyo0z9crRKbktmQ
Message-ID: <CAHC9VhSVjLNeTdxHmwYsGX75Z4FOAP+26=PjVdFxpmEkTrPvxA@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] selinux: Use simple_start_creating() / simple_done_creating()
To: Chris Mason <clm@meta.com>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 8:26=E2=80=AFAM Chris Mason <clm@meta.com> wrote:
> NeilBrown <neilb@ownmail.net> wrote:
> > From: NeilBrown <neil@brown.name>
> >
> > Instead of explicitly locking the parent and performing a lookup in
> > selinux, use simple_start_creating(), and then use
> > simple_done_creating() to unlock.
> >
>
> Hi everyone,
>
> Amir suggested I run these through, and this commit was flagged:
>
> commit bc981629767980bbaee2ca3c7348b5a648665a9d
> Author: NeilBrown <neil@brown.name>
>
> selinux: Use simple_start_creating() / simple_done_creating()
>
> Instead of explicitly locking the parent and performing a lookup in
> selinux, use simple_start_creating(), and then use
> simple_done_creating() to unlock.
>
> This extends the region that the directory is locked for, and also
> performs a lookup. The lock extension is of no real consequence.
> The lookup uses simple_lookup() and so always succeeds. Thus when
> d_make_persistent() is called the dentry will already be hashed.
> d_make_persistent() handles this case.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Paul Moore <paul@paul-moore.com>
>
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.=
c
> > index 3245cc531555b..7d4f90e5b12a0 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -1931,15 +1931,16 @@ static const struct inode_operations swapover_d=
ir_inode_operations =3D {
> >  static struct dentry *sel_make_swapover_dir(struct super_block *sb,
> >                                               unsigned long *ino)
> >  {
> > -     struct dentry *dentry =3D d_alloc_name(sb->s_root, ".swapover");
> > +     struct dentry *dentry;
> >       struct inode *inode;
> >
> > -     if (!dentry)
> > +     inode =3D sel_make_inode(sb, S_IFDIR);
> > +     if (!inode)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     inode =3D sel_make_inode(sb, S_IFDIR);
> > -     if (!inode) {
> > -             dput(dentry);
> > +     dentry =3D simple_start_creating(sb->s_root, ".swapover");
> > +     if (!dentry) {
> > +             iput(inode);
> >               return ERR_PTR(-ENOMEM);
> >       }
>
> Can this cause a kernel crash when simple_start_creating() fails?
>
> The function simple_start_creating() returns ERR_PTR on failure, not
> NULL. The check `if (!dentry)` only catches NULL values. When
> simple_start_creating() fails and returns an ERR_PTR value like
> ERR_PTR(-ENOMEM), this value is non-NULL and the error check is bypassed.
>
> Execution would continue to d_make_persistent(dentry, inode), which
> attempts to lock dentry->d_lock, dereferencing the ERR_PTR value and
> causing a kernel crash.
>
> The old code used d_alloc_name() which returns NULL on error. The new
> code uses simple_start_creating() which returns ERR_PTR on error, but
> the error checking pattern wasn't updated to match.
>
> Should the check be `if (IS_ERR(dentry))` instead, and return dentry
> rather than ERR_PTR(-ENOMEM) to preserve the actual error code?

Good catch Chris, yes, please change this Neil and feel free to preserve my=
 ACK.

--=20
paul-moore.com

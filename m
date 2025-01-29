Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E5242049;
	Wed, 29 Jan 2025 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738160356; cv=none; b=RWPViLJp86pnTVV/wCq7/rWk3hns6ODOlJ0AZK6xL/BewN98oZOOaYq+DHa/Qp1KNN5e+J9yMJUna+JmORGp0D0q6pQ00HChsFDOiH0DWyYBJYL97lqYO33gOIU9oOPzE9wkquJD8CgaQ0vQAPT0QMUKc5Hv8tj22v2KmvzuwzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738160356; c=relaxed/simple;
	bh=7Sksnz7JdzWJhmlmOBKpvOtSsesbsDM3yRlGV+3lxZ0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=K6A+pL6rh0AbSJqR0lYWH7CLUMdxBFq2XAOsVuPoAhS2dfwKQ/zQtK62yD7EQi9sv+0XLzJgGq/9XUVbz9zgcAH11wtyjEAbz1wcDigyaQgXhw9JZ6etDQJZ07kyjH/yVbevtsxqg9ylF6Em00/jVjfNGQUeLH0GUaWvUI4UFwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYIQ69HY; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYIQ69HY"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6e9db19c8so659910885a.3;
        Wed, 29 Jan 2025 06:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738160353; x=1738765153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogf45atl+UAIqWr57SvK8Fb3CsosPUeQCrCCnYgCYes=;
        b=JYIQ69HY9QDIZI18kUy32bpg2yJJy6t3dmmdJP+jmJPg5mmiX7R9YC8wwovCXdCE/L
         L0cKFfGmyDy85xlQsAuTk+oFOnVkKw8YXEGxucT2D3s0AtkvXNVQqz9IEXmATA/mkbS3
         sPKYBYEhzKYsDQLwByBE6V7Abe9piH/gIGQK2VEehZL03kaLVL3ISfAynQm/TamfI5Tw
         /QxXzA2B+3fv36vrIw6S5te/JJgN0KQQugcVfCsqUv5NQ4ioopWMn4+Ki/r+74kCs+HO
         WIbuNel3oSBlVIV7QJpod031i+s7Nzt7c0xdvT3F5VTpcvoGS4EGE1WW/DJFAAKUBtI3
         8btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738160353; x=1738765153;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ogf45atl+UAIqWr57SvK8Fb3CsosPUeQCrCCnYgCYes=;
        b=bCSkOWzrF5lNM14Nq9eVTTW043ldRyP89wwi6EtP5+Qi6v3+Emx5SkjuKrvsh7/1h5
         IxtG6PGRiebNlBW/0+lAV3NSL/hDpoqO2IZvCvzkwuO23DdMVIqvUkTtLaICTbMRTFbZ
         PeKiP53xq67+awkFU6YlDtCAQEQu1McGGoZ2NzJj1s+OXkhwYWlaoK9KAKbK6xYoJgc0
         fuAq0rbZtfSRhUWJpl07RrybaizxntNdJrIVk+BKmtIV0yrIiKON3Z4PgQzPeoMyBqgS
         Da0llRHg1yExOvaN/PoiJCGlUGutWAZUe58xzDSVMFg758iQV3bNig7xDt/LyqIIPG0z
         R35Q==
X-Forwarded-Encrypted: i=1; AJvYcCW88MrfWQtIvtzDH2M3pm23uw66ktTpwOchqqwhhUgLFSjBkvUfKeO4EuSQRAfTLCDNUPSTl3zt@vger.kernel.org, AJvYcCWqYlTFgh2iekEGFYt0w14uMd5+2az+MSYrKC8qfUKjvKgyX5tKB5+qtNjqJwKgVJYUodcq5HJxug==@vger.kernel.org, AJvYcCXBHGI7Vu0J1n+u7IedwcF+fRmm6666JMBBTCIweBDqoES5IUyUANf9Y0JRm+UP8CMfxoTuDDyB7fPqp+dz5t1XxR/xnbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDyYVyYz0X+VzjdqPyNOf8hSLvGpzONw6/2shqvp+IyFJB9mt1
	JAkXs7sHXgdvKqQ0ax2+GP6MA0jza9IhpSPsBdW0aRDMaMqt8Jr0
X-Gm-Gg: ASbGncvmixdVUrJfNXRa+s/1HNGC0sR2VeOxiyTn4UIlhEA/cjxT5Ofs+6OxZojyX1C
	3h7sP+4jDM+SvBc2hFHR26tae96A8Xw2UGmfvMrNo5D/mEMoSLK0XBXaW8Xux/pGRkorZM0jux/
	+Emif05c6zkxVYMp5GCIr/ktFQy/ca+bo0BeVg7gMh9yD9ttafvYr6vJun97RgJgDa7LDYyN3dj
	wPalic7+2Fb12tTS7yPd1zfaX/diatnv9gCS6OJZ70axOrwmiRdysZZHVYU82pXD33peOU7rs+B
	q2ylcRiWEKIqtOcT5/fEJNxF457tqwPBaXQ/qcrAhlhFp3dDZ43xNPV+3/bT43MoB68zOdfSTg=
	=
X-Google-Smtp-Source: AGHT+IET7kO3LQmH+yIVlole/I/qyM56ffX61xi9FU/5wsHiAb+3eqOzmqruvZICyHZWXSuUefNJDg==
X-Received: by 2002:a05:620a:469e:b0:7b6:7a7b:1a4 with SMTP id af79cd13be357-7bffcd12d16mr535546785a.27.1738160353243;
        Wed, 29 Jan 2025 06:19:13 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae7dce2sm626829285a.10.2025.01.29.06.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 06:19:12 -0800 (PST)
Date: Wed, 29 Jan 2025 09:19:12 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ondrej Mosnacek <omosnace@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: stsp <stsp2@yandex.ru>, 
 Willem de Bruijn <willemb@google.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 network dev <netdev@vger.kernel.org>, 
 Linux Security Module list <linux-security-module@vger.kernel.org>, 
 SElinux list <selinux@vger.kernel.org>
Message-ID: <679a38e035975_132e0829490@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAFqZXNscJnX2VF-TyZaEC5nBtUUXdWPM2ejXTWBL8=5UyakssA@mail.gmail.com>
References: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
 <e8b6c6f9-9647-4ab6-8bbb-ccc94b04ade4@yandex.ru>
 <67979d24d21bc_3f1a29434@willemb.c.googlers.com.notmuch>
 <CAFqZXNscJnX2VF-TyZaEC5nBtUUXdWPM2ejXTWBL8=5UyakssA@mail.gmail.com>
Subject: Re: Possible mistake in commit 3ca459eaba1b ("tun: fix group
 permission check")
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ondrej Mosnacek wrote:
> On Mon, Jan 27, 2025 at 3:50=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > stsp wrote:
> > > 27.01.2025 12:10, Ondrej Mosnacek =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > > Hello,
> > > >
> > > > It looks like the commit in $SUBJ may have introduced an unintend=
ed
> > > > change in behavior. According to the commit message, the intent w=
as to
> > > > require just one of {user, group} to match instead of both, which=

> > > > sounds reasonable, but the commit also changes the behavior for w=
hen
> > > > neither of tun->owner and tun->group is set. Before the commit th=
e
> > > > access was always allowed, while after the commit CAP_NET_ADMIN i=
s
> > > > required in this case.
> > > >
> > > > I'm asking because the tun_tap subtest of selinux-testuite [1] st=
arted
> > > > to fail after this commit (it assumed CAP_NET_ADMIN was not neede=
d),
> > > > so I'm trying to figure out if we need to change the test or if i=
t
> > > > needs to be fixed in the kernel.
> > > >
> > > > Thanks,
> > > >
> > > > [1] https://github.com/SELinuxProject/selinux-testsuite/
> > > >
> > > Hi, IMHO having the persistent
> > > TAP device inaccessible by anyone
> > > but the CAP_NET_ADMIN is rather
> > > useless, so the compatibility should
> > > be restored on the kernel side.
> > > I'd raise the questions about adding
> > > the CAP_NET_ADMIN checks into
> > > TUNSETOWNER and/or TUNSETPERSIST,
> > > but this particular change to TUNSETIFF,
> > > at least on my side, was unintentional.
> > >
> > > Sorry about that. :(
> >
> > Thanks for the report Ondrej.
> >
> > Agreed that we need to reinstate this. I suggest this explicit
> > extra branch after the more likely cases:
> >
> >         @@ -585,6 +585,9 @@ static inline bool tun_capable(struct tun=
_struct *tun)
> >                         return 1;
> >                 if (gid_valid(tun->group) && in_egroup_p(tun->group))=

> >                         return 1;
> >         +       if (!uid_valid(tun->owner) && !gid_valid(tun->group))=

> >         +               return 1;
> >         +
> >                 return 0;
> >          }
> =

> That could work, but the semantics become a bit weird, actually: When
> you set both uid and gid, one of them needs to match. If you unset
> uid/gid, you get a stricter condition (gid/uid must match). And if you
> then also unset the other one, you suddenly get a less strict
> condition than the first two - nothing has to match. Might be
> acceptable, but it may confuse people unless well documented.
> =

> Also there is another smaller issue in the new code that I forgot to
> mention - with LSMs (such as SELinux) the ns_capable() call will
> produce an audit record when the capability is denied by an LSM. These
> audit records are meant to indicate that the permission was needed but
> denied and that the policy was either breached or needs to be
> adjusted. Therefore, the ns_capable() call should ideally only happen
> after the user/group checks so that only accesses that actually
> wouldn't succeed without the capability yield an audit record.
> =

> So I would suggest this version:
> =

> static inline bool tun_capable(struct tun_struct *tun)
> {
>     const struct cred *cred =3D current_cred();
>     struct net *net =3D dev_net(tun->dev);
> =

>     if (uid_valid(tun->owner) && uid_eq(cred->euid, tun->owner))
>         return 1;
>     if (gid_valid(tun->group) && in_egroup_p(tun->group))
>         return 1;
>     if (!uid_valid(tun->owner) && !gid_valid(tun->group))
>         return 1;
>     return ns_capable(net->user_ns, CAP_NET_ADMIN);
> }

The conversation got a bit in the weeds. Which is helpful to
understand how exactly this is being used.

But in short, this patch LGTM.

Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485081B4159;
	Tue, 28 Jan 2025 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738076671; cv=none; b=YHmvbCL2sEeXMnSDoyKIU6bz8yznTzgpiFwbOZZalawNTPkXfiT489x6wheL5Cyizm2uxz40XvrH9qTp5/rgkmN2CuQw9jgc6Rsal2G+5GMyKqFEgZtvEVUKVikTh6mZEDbYVSU5dKedXIbbauV2/D7gYRAr1DRdm8H3Mazc8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738076671; c=relaxed/simple;
	bh=BG50g8Dxwewc6NTA4uGnAnCRjwxyPVrmOaMneGiCKjo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FpsQ9AAQlAxv5KMgoNiP3DIBzAq44K5XNxYxMjUDKhSg1qQofD9NXeJGr7izKAYJ/6pRXb+64vW2A/2FwkyF0y/bBd1WZsj3Mg9/iErGhLsahenMjFkADFOrZe569tYFcUq8B2Bd1jCRJ7QijgPw5ZKqkbPIZb8v3D5zIEQzVSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUUx3+2a; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUUx3+2a"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b8618be68bso554908985a.3;
        Tue, 28 Jan 2025 07:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738076669; x=1738681469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGB2ywVgwZKvqhNWmwKN2lR7K6Sb/8MtlbD/h+nPQZc=;
        b=dUUx3+2aEDucRjPHO3o8lp6wjOkfYh57/QUaDMTdD1OOFNaYLdVc9xbuTIzPZ7tEVr
         Nag3uDJd+apWj9Lp1X+H7guKl0OPo1gNw+ECwp6hziIDL+mhWMoLcyO4k21Av02NTNvO
         vYajf7j+iqLaq1ReocGJMm03BDCqVhJuf1k28zjGKvztyP5gFviWj5cTzqLuQ9QFQmRb
         5PnySgmuV1zU9VoCYwrzbhEVDK8BPR+S28q3mSuRPzipV1xlnYn6jvnRTp+P7mRR4+9p
         h+MfzZosf3pnory1hbMBPtP7S0h0GoDMMiRDOJzDWd30+s483S4hb4BSmLMxKvHRyJWG
         63aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738076669; x=1738681469;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vGB2ywVgwZKvqhNWmwKN2lR7K6Sb/8MtlbD/h+nPQZc=;
        b=uyk02WCxt9plnDsP/j65gwb2f693bsPUY0yAcxdlgoKiMkFCZvj49RWWs4gdygycqL
         y0mtqNtHzne7x+9/54DAxEc2kf6mrO/aD0vdOp9dgUUwixtGyVLWZZJdqnyqrH5qFbGa
         V+MbBt2MF4w8zT4Le3F6lPCioFGFrLC0QbtSSeLz3Y+bZQzeVAII6hnHnVTTe1tS6K90
         dq3UjOEMwr1Y5yIf03IAQ/pJ2bazs1+dPqFrRX+VQWkk8fkGJTF6spUQUuFqKWzxw88H
         tBS00dGZ076Jdim7XYEcJfEY1MUfDkm3fNgr0BH3rln0gJq40LTqgG97S2i+23b18tvm
         cL5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUl44Zhjp1HhYHd4Ajq0RwKwCbXGHlM8qSS4AjGDd3u9lfEzf44/c2luAsXKJ6XLvD0yHd0UTMh@vger.kernel.org, AJvYcCWG6/vRkE5InBEb+0vPgYCcfAPGZ9by96lU1MpjmTb58/m3VSsBtie2RdxJosZHHVpouz1KP2EO4g==@vger.kernel.org, AJvYcCXaGXu7GMwCagb1+ddTriNT+JDabxLgCY/0tq/zQQmYMpl5SNlYXHa3K/Ux8TaRP2IwxmsCPtThvDcWFrTn8Y4KHDyvdmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2CpJFlaLoOwCSyBvkDP28tYGCnoDLcVQNwFkpVMeN1j5DcKs9
	DR1TKqdIHNwg1jfS3ddq63GW32i317NQCSR8PGAWumGTqEX2uUHOL3DMhg==
X-Gm-Gg: ASbGncvejabWF6Kcnb4pKRqFnJovFv28rn6dnIClwGcBjGxAcFQldp/lpZkIyZ6dfpp
	+imejTe8Ig3oqUEtWTBwKdTX69QnB4i/vL9jn/UWYTjttmLw2JLNQahFrmF5KhkbvaV2Q2gqhxb
	f9fWLBRv4+KiyDoWmkQCT0ATOXO6wwVgjMAB23EqKF+wAG3uAj7keELF4E8AplJM9xZLOI754fT
	qoh5NC1HMa2upJLrEda57OO5lrY3XoglwgXVu2LLEDxuY+lINNNj5CJvVjzEBCA6++oFVpvORs2
	8UowthSQTpLea4ElGEelTLmqkEpuWiEC6vVf5GfDPSlVT5sAe+JKI07PO9Cwf95quoGJYmk/4g=
	=
X-Google-Smtp-Source: AGHT+IE3rV0pPvgbs1ZViZXuz4cti2VZtxFozOK5sf1zUJLl1yEqf9u+gJUYtFCV4etGkMg41DaZTA==
X-Received: by 2002:a05:620a:838e:b0:7b6:c540:9531 with SMTP id af79cd13be357-7be6321bca4mr7741886085a.18.1738076668488;
        Tue, 28 Jan 2025 07:04:28 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-864a9b1afacsm2320055241.15.2025.01.28.07.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 07:04:27 -0800 (PST)
Date: Tue, 28 Jan 2025 10:04:27 -0500
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
Message-ID: <6798f1fb5e1ba_987d9294dc@willemb.c.googlers.com.notmuch>
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
> uid/gid, you get a stricter condition (gid/uid must match).

I don't follow this point.

Judging from the history, the intent was that

- if user is set, then it must match.
- if group is set, then it must match.

And I think the group constraint was added with the idea that no one
would try to use both constraints at the same time.

The referenced patch intended to (only) relax the condition when both
are set after all.

> And if you
> then also unset the other one, you suddenly get a less strict
> condition than the first two - nothing has to match. Might be
> acceptable, but it may confuse people unless well documented.

I find that ownership is optional and must be set explicitly through
TUNSETOWNER and TUNSETGROUP quite surprising too.

But this is only reverting to long established behavior.

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

Improvement makes sense, thanks.

One more point, based on the problem description in the referenced
patch:

    Currently tun checks the group permission even if the user have match=
ed.
    Besides going against the usual permission semantic, this has a
    very interesting implication: if the tun group is not among the
    supplementary groups of the tun user, then effectively no one can
    access the tun device.

The intent was to skip the group check if the user matches. Not
necessarily the reverse.

To minimize the impact of the patch, perhaps it can still always deny
if tun->owner is set and does not match. That keeps the group check
iff the owner is not explicitly set as well.
 =

> -- =

> Ondrej Mosnacek
> Senior Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
> =




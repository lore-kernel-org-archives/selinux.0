Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBDA193402;
	Tue, 28 Jan 2025 22:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738105177; cv=none; b=Hm5/L0CUniw/BaAfR18qec+5TqLSHBiz5UhkbpEJ1F+9qrOXulRqqU30gaXMcWJWA8SvW5KGGemPPhJpxRDbhe3+lPZymDPf6uxQWW9jAIRuqPzz895aq8lQdwfiL+nh1nO71wSISMJfBGVNrAcWavsVJ1ptwMTaGIQX7d/2nlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738105177; c=relaxed/simple;
	bh=zfkcybfngaj0Ecg4WGGGpIGMkGQUkL+GJCvEkUahP6U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lREuwogfXlZrh9gY3vfh4qVZMmkpRi63vPOLUNeNjS8xvgWUVgUbO0J6lt+l2jE3fjUTQ6bDahdoqPAg5OgiDa5ZQRshAXChB2Lz1hmu2z8cGO9YEX5LpITGLuRL+hNLOWvo1IfcAJoNcdgAbswBcSfEbq7s0bu1ZYdmbMPcZNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJ87Od6w; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJ87Od6w"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7be3d681e74so557499685a.0;
        Tue, 28 Jan 2025 14:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738105174; x=1738709974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlUhzh1vAkoJJDwjc5wMYu0SSkfNiXZepvV9vpAC7Iw=;
        b=ZJ87Od6w6j6Tu3PfjYo+lFTSj5U4q8czXN7OrLMLCrlY+wQxFdQNaVSXyXiNVTFIKv
         cziwv4jBN3lRcx3U5Sfs1b2qAhpEb7Qt3uOvwohLbKZiu14DFED+O2DRogfXI029fte2
         1eym/FuUqUeQahnRcODIERhum2wJeTHF/J3UqIu/VpNpqWvwUTc1/hYpo5gA0uZ240RF
         wQc5biVWPLlW7BIUw2sF2Htu+ym7L5CHRpENmcQqNig5YdfhrAWHbhB7OHQBex6fp3QD
         7/zO2AY0SKy6m3DHeAiI8Hmz8fbKHS1fuGmv3BHyvK+YzBP8mx3ky8ellMhB0LU+7TJe
         9Ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738105174; x=1738709974;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KlUhzh1vAkoJJDwjc5wMYu0SSkfNiXZepvV9vpAC7Iw=;
        b=UCRRu6BZLVg/e/pILKijj1nPfhC6r0zzHLF50bXSaULaup53L6l3MiozEhsXnFolYK
         wxyolNXfTFbWFVka17L4zy2QTlw04BeiicMmhqM/Odv46I1CQE827UXLcYUO8W5uwYeI
         klC3DEszFxjyCPJVaC0uyW7XozfBJR0C13YhjbiRkxkUFLRq5U0bBdYLVgjBqeZnwfPh
         zfyD1v5NJtYvKjAX+Ve59RYL0FS+aX3zSVa255pco4nNmmirCACLqL6Jy2r1fhkEh8jJ
         rxvRtXl57aXQTPlmwco3OB23eI1yTdgCOXzDXhVEf+Tpz7c5nnPVieeJjQn9UWYzhVSO
         RIog==
X-Forwarded-Encrypted: i=1; AJvYcCUyA3weuNzxMy7moBuzc+pT/pbjjV1eOSM+v7+PRsK7Bmhz57uq9eob79n+pgukHYX5m3LlDAlVHVv/LODfYaanBafA2dc=@vger.kernel.org, AJvYcCVTvRO1eu8hVGy963fBvlwxYyPfxaZ+FzNxjtbovKE78VPZeLhy6uculOx6jfyzd2PDhUHUcwyB@vger.kernel.org, AJvYcCXKvNloLZ7zrNwklDvXR8eFY4IwfGq04m3klLNHVjSzxWLdJRVlWQwS+hp5SX8r1hy4zuxIcbSrUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBi+gBvnI8DKFU1QWLDp/iosPX2/djB0PMAO11Yr6arZlC1g5N
	61r6p9EhW+2TqY0Lah13AX5yIJn2nV17SAY06dKIHK4aJtmb1DIo
X-Gm-Gg: ASbGnctTjv1o+3l3ICVbFBHC6fdj9SiVE4L0JeWIei7CVatlEKWZ6c2kiexcKonuCba
	u9yOxHEsuLch4pNw2OOpNRL0olqnXgXPfPeKdAMt+ksYdZZ3TW1TY0ds1YuEeJk/khtXg6Hh4wy
	V7P+aIWvhH/gr6ZoSytykb72v8Jd54hfmwcOuMB5rW91vQOWyK+pTu+5QsnAsuSoQoKzVIVyPTB
	cWIQZSt1TXZiFrL1q99jNHDONCJ5WjTIuLRqwUbZJCqy8hUtmcJdZejCe8Wr28bamJh8y8kGIAV
	vweDDql9rZbmC532Z2m6Gzrc9YIkv4l9tgMQikNS6KNV1VV1gw8UasIum224NV8=
X-Google-Smtp-Source: AGHT+IFanmbd/MTyn1ZZFSURf3w89NQnsv3Vzjf5Ubxr32GgGRRl6ui8bfsFDokAwoTnomNNK2uh7w==
X-Received: by 2002:a05:620a:d8a:b0:7b6:e9ba:2853 with SMTP id af79cd13be357-7bffcd958f2mr102413185a.35.1738105173831;
        Tue, 28 Jan 2025 14:59:33 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae8a67csm565048485a.29.2025.01.28.14.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 14:59:33 -0800 (PST)
Date: Tue, 28 Jan 2025 17:59:32 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: stsp <stsp2@yandex.ru>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 network dev <netdev@vger.kernel.org>, 
 Linux Security Module list <linux-security-module@vger.kernel.org>, 
 SElinux list <selinux@vger.kernel.org>
Message-ID: <67996154e30ce_d9324294c4@willemb.c.googlers.com.notmuch>
In-Reply-To: <c4413e16-d04f-4370-8edc-e4db21cc25f6@yandex.ru>
References: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
 <e8b6c6f9-9647-4ab6-8bbb-ccc94b04ade4@yandex.ru>
 <67979d24d21bc_3f1a29434@willemb.c.googlers.com.notmuch>
 <CAFqZXNscJnX2VF-TyZaEC5nBtUUXdWPM2ejXTWBL8=5UyakssA@mail.gmail.com>
 <6798f1fb5e1ba_987d9294dc@willemb.c.googlers.com.notmuch>
 <c4413e16-d04f-4370-8edc-e4db21cc25f6@yandex.ru>
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

stsp wrote:
> 28.01.2025 18:04, Willem de Bruijn =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Ondrej Mosnacek wrote:
> >> On Mon, Jan 27, 2025 at 3:50=E2=80=AFPM Willem de Bruijn
> >> <willemdebruijn.kernel@gmail.com> wrote:
> >>> stsp wrote:
> >>>> 27.01.2025 12:10, Ondrej Mosnacek =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>>> Hello,
> >>>>>
> >>>>> It looks like the commit in $SUBJ may have introduced an unintend=
ed
> >>>>> change in behavior. According to the commit message, the intent w=
as to
> >>>>> require just one of {user, group} to match instead of both, which=

> >>>>> sounds reasonable, but the commit also changes the behavior for w=
hen
> >>>>> neither of tun->owner and tun->group is set. Before the commit th=
e
> >>>>> access was always allowed, while after the commit CAP_NET_ADMIN i=
s
> >>>>> required in this case.
> >>>>>
> >>>>> I'm asking because the tun_tap subtest of selinux-testuite [1] st=
arted
> >>>>> to fail after this commit (it assumed CAP_NET_ADMIN was not neede=
d),
> >>>>> so I'm trying to figure out if we need to change the test or if i=
t
> >>>>> needs to be fixed in the kernel.
> >>>>>
> >>>>> Thanks,
> >>>>>
> >>>>> [1] https://github.com/SELinuxProject/selinux-testsuite/
> >>>>>
> >>>> Hi, IMHO having the persistent
> >>>> TAP device inaccessible by anyone
> >>>> but the CAP_NET_ADMIN is rather
> >>>> useless, so the compatibility should
> >>>> be restored on the kernel side.
> >>>> I'd raise the questions about adding
> >>>> the CAP_NET_ADMIN checks into
> >>>> TUNSETOWNER and/or TUNSETPERSIST,
> >>>> but this particular change to TUNSETIFF,
> >>>> at least on my side, was unintentional.
> >>>>
> >>>> Sorry about that. :(
> >>> Thanks for the report Ondrej.
> >>>
> >>> Agreed that we need to reinstate this. I suggest this explicit
> >>> extra branch after the more likely cases:
> >>>
> >>>          @@ -585,6 +585,9 @@ static inline bool tun_capable(struct =
tun_struct *tun)
> >>>                          return 1;
> >>>                  if (gid_valid(tun->group) && in_egroup_p(tun->grou=
p))
> >>>                          return 1;
> >>>          +       if (!uid_valid(tun->owner) && !gid_valid(tun->grou=
p))
> >>>          +               return 1;
> >>>          +
> >>>                  return 0;
> >>>           }
> >> That could work, but the semantics become a bit weird, actually: Whe=
n
> >> you set both uid and gid, one of them needs to match. If you unset
> >> uid/gid, you get a stricter condition (gid/uid must match).
> > I don't follow this point.
> >
> > Judging from the history, the intent was that
> >
> > - if user is set, then it must match.
> > - if group is set, then it must match.
> >
> > And I think the group constraint was added with the idea that no one
> > would try to use both constraints at the same time.
> >
> > The referenced patch intended to (only) relax the condition when both=

> > are set after all.
> >
> >> And if you
> >> then also unset the other one, you suddenly get a less strict
> >> condition than the first two - nothing has to match. Might be
> >> acceptable, but it may confuse people unless well documented.
> > I find that ownership is optional and must be set explicitly through
> > TUNSETOWNER and TUNSETGROUP quite surprising too.
> >
> > But this is only reverting to long established behavior.
> >
> >> Also there is another smaller issue in the new code that I forgot to=

> >> mention - with LSMs (such as SELinux) the ns_capable() call will
> >> produce an audit record when the capability is denied by an LSM. The=
se
> >> audit records are meant to indicate that the permission was needed b=
ut
> >> denied and that the policy was either breached or needs to be
> >> adjusted. Therefore, the ns_capable() call should ideally only happe=
n
> >> after the user/group checks so that only accesses that actually
> >> wouldn't succeed without the capability yield an audit record.
> >>
> >> So I would suggest this version:
> >>
> >> static inline bool tun_capable(struct tun_struct *tun)
> >> {
> >>      const struct cred *cred =3D current_cred();
> >>      struct net *net =3D dev_net(tun->dev);
> >>
> >>      if (uid_valid(tun->owner) && uid_eq(cred->euid, tun->owner))
> >>          return 1;
> >>      if (gid_valid(tun->group) && in_egroup_p(tun->group))
> >>          return 1;
> >>      if (!uid_valid(tun->owner) && !gid_valid(tun->group))
> >>          return 1;
> >>      return ns_capable(net->user_ns, CAP_NET_ADMIN);
> >> }
> > Improvement makes sense, thanks.
> >
> > One more point, based on the problem description in the referenced
> > patch:
> >
> >      Currently tun checks the group permission even if the user have =
matched.
> >      Besides going against the usual permission semantic, this has a
> >      very interesting implication: if the tun group is not among the
> >      supplementary groups of the tun user, then effectively no one ca=
n
> >      access the tun device.
> >
> > The intent was to skip the group check if the user matches. Not
> > necessarily the reverse.
> >
> > To minimize the impact of the patch, perhaps it can still always deny=

> > if tun->owner is set and does not match. That keeps the group check
> > iff the owner is not explicitly set as well.
> =

> Doesn't this mean, if the user
> is set then group is completely
> ignored?

Yes

> By doing that you indeed avoid
> the problem of "completely
> inaccessible tap". However, that
> breaks my setup, as I really
> intended to provide tap to the
> owner and the unrelated group.
> This is because, eg when setting
> a CI job, you can add the needed
> user to the needed group, but
> you also need to re-login, which
> is not always possible. :(

Could you leave tun->owner unset?

> Also completely ignoring group
> when the user is set, is somewhat
> questionable. At the very least,
> perhaps then you need to explicitly
> clear the group when the user
> is set, to avoid the confusion.
> Having "either user or group"
> sounds like a sensible semantic,
> but its a different semantic.

True. I think that would have satisfied the intent of adding the
group check at the time, and would have avoided this situation.

But we indeed cannot retroactively restrict allowed behavior.
As that will break users.

Conversely, it might be that an existing user out there depends on
the prior behavior that only a process that matches both user and
group can use the device. Which might be reason for reverting the
patch entirely.





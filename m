Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2D334F46E
	for <selinux@vger.kernel.org>; Sun, 22 Feb 2026 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771769985; cv=pass; b=e8epPNSGk/WPRB1PopGod+WIUAMHMlYHf+6d14aTHp9ttiplSETEZcrJEvg1BBiX1XwhFmV3iA5JeOuMd/7SrNSmwQ23FuSPaC7qYY7uqvxgKhiClrUHGP+KCHxtDqs6VsNYdSQe9cZhNoeGp64MEuANynCxIrM7ZqWDl2gq7A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771769985; c=relaxed/simple;
	bh=ln+l2+kKkFDBmSOGuUA2y37XlX40B6GZOr01SweZv58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+j90i9R3kwBGK8rk3UIOTNTcAj3l32EkB5dwXZWR1l6wuI/uNfPq7O1fmID5VGy6MaWDjlF5N/UbZ/wilxJucpUMq+pjRmMx64nDsHXqrpcmqxEgzpyLLDXajQ0bG2wQ9KnUtThk3oe1yOw6J3AJ+MlHchebkfidFlxNMCteZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Nx8KjheQ; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Nx8KjheQ"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-824ba8f0acaso2040172b3a.1
        for <selinux@vger.kernel.org>; Sun, 22 Feb 2026 06:19:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771769982; cv=none;
        d=google.com; s=arc-20240605;
        b=JP4PE1aXaTm6Aln7NHy+moj/uaIAcubasIoHqwoxlpJnXWUPZ1BdrTqVdXF5uRqMTo
         WUscJrxfxOTRLhNeZOtgOqO3KPn0Wobw6HLcJPGYuqnH4uheuqXBX4VYckkY+EYgpftR
         tJryCkTSnS/WYpInMV+LDh3CPAvoIWfRZm/iXgW6JD/unqYLeziSB3BhMXeY3aJbq6J7
         HLikWAyoD9+ttpl4R1YpraA2BEixFl2GXPTNTLJwSArw1gwH4r5hqfQqeH5qpGzTosHH
         82W8fknW8TXUTq3rIxb7Jz03Hhuy3U+C0pmY6h5Ymkkguk5CVr3BWyYLtkrbLWmLwYfH
         cWig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X8lBMrpe1LcWoNp46tVs1SnCv/oupmsi0daofTsKyx8=;
        fh=1CPDUPnUI7A7H1z4FULLrnJv0xDt3pdf1a60z/V7/Fk=;
        b=FrBlN+QnxdEd7ApxSWVc946Fvsf3C1U7/VRWcEdCfoTVl1jVZ7Ro1oF/3AxXexNaK5
         EQGGSpF6zp+peUzff767OBK8sB8a9qOwRWREndgpXnvf2iRtluT0UgAmQP3N70ZcfeaL
         twgRhBA6EXVaTQg2d/YR/Voarfpn4OIw6kG70xGfD2x7RPAKYHbiCNXn6U7/KwvgIDP8
         V1lRtdAzZELsDpEwkolz3ZfaGZLt0ykOB3blwm/gW01XaOxBxebHmEnVW4D7RR4zFcxH
         b+eUfi5hxzEP8cZwz60tEAsX8cLutj6g3GC06bamamzDk+T+JXzfOZXCOIoa57+67zkv
         cXBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771769982; x=1772374782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8lBMrpe1LcWoNp46tVs1SnCv/oupmsi0daofTsKyx8=;
        b=Nx8KjheQqYFoKeSsWjSjDkljl7DeLxDbijMH0TCbUekr4yIocKBCavivrkgn95uFed
         XuSYjq8Pcd+5CapXKZGXMujHyPS8CM2XMsK1VFq/NEU9BlgNRr0AX30vP4yE32dv7A5Y
         Hbv2Gia3NHVN7Dbg7SLniPYX1r0AX1nZqO/QynXl0UmultKmwbPnGnBn1UVWQBCgarfe
         8XAXggaIceD/wiAeYgSlFc6fVQeagqwn9JRq9mELPGKgvBWXjAAEHwqVz4J9E4ZYYqaN
         3M/u7GK2xgYQYx/5yhpHJ3oZznFZe7PrOTMXiMph7pHCPiT63E99Qjf7j/+JE40HxrtR
         KZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771769982; x=1772374782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X8lBMrpe1LcWoNp46tVs1SnCv/oupmsi0daofTsKyx8=;
        b=qODmGCYeoApP7BOeO1xDjXpXP5S7YqO93uvu58Q8KXSxe03FYFYhnanhoOp/AmR/eZ
         z2y/305kxJqvw+ef7uAuKetojOgi7Ak+j+HMwe35wlXsbcVjl10+FkWQMabfUWlU9u4M
         g5t/AbG0/GPlHPmJdZMaWarVpvgx2f3876b30+gTOh1JaTDpNPgZE5+p72BVcpDU0jHY
         W/gLH0eyG+9T4PErdz5Jwc0KA0zH8/TzBHbQMQcm6nEETGnbltX561NHrj4Jmk/GPIv6
         PEreaBbBO4b281cTtMjPk8nq9z9Tc+gL6Cyhs0LofwmnKFhe7XInvcmvBLdF79UZxQaK
         Q1tw==
X-Forwarded-Encrypted: i=1; AJvYcCUb/SripSyDQ6EvjcdMnQm8U6C4ZEToHNHCR3st5QunG3Xa9tqLG5pCoQ/PcHHhLR3ZftPbXYe6@vger.kernel.org
X-Gm-Message-State: AOJu0YyxSPic8lsOWC8Tg+2LnoKyc8mznzMHLK0WSUrHeUNBB4Ba3aHc
	ALza9H7BbY3VBs8PQ8OpPl1275HEr3tiT6a5QTzIlzHtWCxx3IOc+Zj9UglDdSeYNxVQIzpNkhG
	wS0t2e79SPDXi4hABk2CUqiU/r7YlUJCpwb+gZ89msIrKT6NN8ko=
X-Gm-Gg: AZuq6aIjJ30ho2aAilI06Sb9l+wTQOhw+rIMEGHbITdUBUQyFqcQ5MJzX6N8j7xEMLh
	VKxhKBP7CRivxe4qLvHMKAUf1bKXPB8t0fmkRy55aphQ3by/pn3f9PKaZI/d4RRCpEMAH2DnWAT
	xmc9iv5PfU8Ao51OTNG6hzlXsOViL70NSOHAfnvkpBvZ/GW9zb6wzjPDkOIsCBscx7gdMigREaY
	BFv/748UwhWE2En91u+9JR8Qi+mP48gFJg6RYuUpV/mtzBsBUghPsKwCf3v+RrtG4fi1xvffIhg
	8jg7riU=
X-Received: by 2002:a05:6a21:6003:b0:38d:ebc4:b552 with SMTP id
 adf61e73a8af0-39545ed5054mr4712151637.27.1771769982592; Sun, 22 Feb 2026
 06:19:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-6-neilb@ownmail.net>
 <CAHC9VhThChVk1Dk+f-KANGj7Tu7zzHCiA==taeQ+=nQaH6a7sg@mail.gmail.com> <177171292163.8396.10671162503209732019@noble.neil.brown.name>
In-Reply-To: <177171292163.8396.10671162503209732019@noble.neil.brown.name>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 22 Feb 2026 09:19:30 -0500
X-Gm-Features: AaiRm50aSxTeiNBHciBrrBXQYNf54mJgxuioR2fz7pTB6PQcKrI6Gq_TY-UauFU
Message-ID: <CAHC9VhTv+K44q7+5d17jS8h9fJY_JfQVUw5NPNvPzjkHDpqp=g@mail.gmail.com>
Subject: Re: [PATCH 05/13] selinux: Use simple_start_creating() / simple_done_creating()
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2026 at 5:28=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote=
:
> On Sat, 21 Feb 2026, Paul Moore wrote:
> > On Wed, Feb 4, 2026 at 12:08=E2=80=AFAM NeilBrown <neilb@ownmail.net> w=
rote:
> > >
> > > From: NeilBrown <neil@brown.name>
> > >
> > > Instead of explicitly locking the parent and performing a lookup in
> > > selinux, use simple_start_creating(), and then use
> > > simple_done_creating() to unlock.
> > >
> > > This extends the region that the directory is locked for, and also
> > > performs a lookup.
> > > The lock extension is of no real consequence.
> > > The lookup uses simple_lookup() and so always succeeds.  Thus when
> > > d_make_persistent() is called the dentry will already be hashed.
> > > d_make_persistent() handles this case.
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  security/selinux/selinuxfs.c | 15 +++++++--------
> > >  1 file changed, 7 insertions(+), 8 deletions(-)
> >
> > Unless I'm missing something, there is no reason why I couldn't take
> > just this patch into the SELinux tree once the merge window closes,
> > yes?
>
> Yes - but ...
>
> Once this series lands (hopefully soon - I will resend after -rc1 is
> out) I have another batch which depends on the new start_creating etc
> API being used everywhere ...

Okay, thanks for letting me know.  I was curious about something like
that based on the cover letter, but the timing wasn't clear.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

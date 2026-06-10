Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289432FF65F
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103240; cv=pass; b=nA0GiG849w4vVeigMxuftHWmHExJuqKqh9sIhCxLnyPJlUI7vN9T8I2z/7b+rwsZlj1I+BRo7TjDBxdG8TkjJKFZG6jn2432wXva7x8cgrfOaEBbDzIzQJD58QZ3HPIdCGef8VULhSC7qqu1vD94BCyXFmyMyGE3M10xW6xxooA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103240; c=relaxed/simple;
	bh=6UEj5hM1nf1pKDvc+p8uQw2RVL7VT5tPmc+3Hj0c+U8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNzsPt8yvgvqn9ytf1i90AlsAYhITZTuqrS+gtwynELgJIwtpW+m7rVetJHflIzT+iSKEweXSI6MwUH91Eb6ZcMr2Xh3SnemuxtYGeK88G3EGMVn4N1uguXHavbYMaw21MoBau9HrQNmzJHVnDIiXQ3xi0IwfOtD8mLZL4qzPjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8HjbLdt; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8HjbLdt"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39666ac91a2so71519671fa.1
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 07:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781103237; cv=none;
        d=google.com; s=arc-20240605;
        b=KynK5+wHlLcIBbLYR3Xe1SYYB7E0MfOZ+2fEAK5ZGTEYfnB+HqTIAaZYFyjiGm1DgY
         pls9rl/jqGTD/p03rJMjN+2dgcFqodiNj3U/aBIxTwWtjtvMJqyYLaS4k1GJF071yYj5
         SLcMjKcNm65JtWEj7DOK7SVbX7qKBfNYGr4I8APS9AKjnxSf1cf4s4jOBG+H0qoeYUG5
         Mt3bW6xqB86pJpqnsIk71Uy0yep2IwgcXSVgiLakj7DIIsORNLmcmTKYu+beH3E25Xgw
         fjMQf+P1FD99qudeZpLsIC0d+MO4KsvJtkHf3wylK48Jw0IchU+WRf0ClMhPjQbyedXn
         JNqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x/Dau6hZLBnR6zT/w5IPJ8Um3FI/9FRtnnpJ+MAl2Tc=;
        fh=4/f+0l4aNvJPXLUTqqQgyT/r8iDEsnKgK/u70kMYgIA=;
        b=aWAO4RdJzlibSgqrupU6H5R07RubzwoJT9Tyt5Hkoa+UuMVEg3EHTSr2f1lVgKBOtw
         8N3HaHHviB8OJKNv6yZV4H29Z5xH5m//0NKYqDwjxpP0vb+a3J9UfCe4ozUnKYNUQnoz
         uZuR/f5aLf8/l9CcaBTeRGwE9wAcGazACsPR1dlyj2vndCiYwHfvRrhZR6ZMGE/bO3h3
         OvzyVlTDOPTvO9PkU5RjX5/LqDkf70QeRJVzwXeKgGcokt9ltvePq5MFffgzU388oGRV
         Mgo+7EMyBVnVG5zaw4eeaaHUNRgedptAKnIE2DG3iG3SAACD5hKQ3L9wyQiUo9yCk0o8
         jlmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781103237; x=1781708037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/Dau6hZLBnR6zT/w5IPJ8Um3FI/9FRtnnpJ+MAl2Tc=;
        b=M8HjbLdt1/pjE/e928JqYhi6rf/pRc6tM1eeHTaA4NsJmEexZAcwJjND3LSozzpI3J
         1I1tFizl/LGV5OrS214kVLFjuZgkQCCf6SN2X0KYL9Qwh3cJDSRPLRuGXWaQkTsNieMF
         oPEp3AR7C3aWZCINUWM2z7HM6KO35T2q2uefpvZQ4tZaFQ4tJG3bFB6dmV6UgwtSAVaR
         ZF+OqyV2m9Ek3c06V9UO8cv/R3v1MZyrCmuF2RExgBzCqeFrZYXr9MIHaVHy2t7K6mdF
         ND+aTQavYLfWn6cFH5w80PCHqx6iVgbUc0kfO9lIJ/89QGgZW6+PrS6iK+P1eFzlJQqA
         FQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781103237; x=1781708037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x/Dau6hZLBnR6zT/w5IPJ8Um3FI/9FRtnnpJ+MAl2Tc=;
        b=eIPN4QlrK8aC1twPew04OAU6jw6Mk40n3o+CqB1me2G0FM8qeuYLi9Cin+W1IOmCBj
         m0FVSqmLUFIKx3EyFUEOOurKTWzQJKJrKTufM1tyfDRpTEFCXtbw6Psq9LCXqGvj9eh8
         WqexUdyrDX4i0MSaaiXnEk6xHZOgZsNwuZSEZk9cvdeLQcK22rDNxoGSaudbh46Y1YPQ
         vGWGzohySP8Leogm4Ri166If4xybgxl8tDOTD+gD9LYrkiPFMJHUBTaxi9kALVFa2asG
         63Jk6G/rB0SXmwXma8/N2HvF9AX1jD0M58H39ZoVvCANmlKjbIR6Z9D7V2RCkS1Txmme
         kPeA==
X-Forwarded-Encrypted: i=1; AFNElJ/Yt12ZVkMIXOMxXydVXje0pccy6P9WxJ+sxZNr5n8aCf41R+p0ThWprw4tXN2wS5PF0pq94k89@vger.kernel.org
X-Gm-Message-State: AOJu0YwPg1VvYtiJkN89fijPJ0+p1SyKDizIJAW1q/SL1bfiH0M8ti1T
	HgH1zbVZuNbKz2kRMgdN6L5Mq7NimDd3/37bsscZwn6nJwecUhHd8nUt9MimtHpNkNDuhZpRDBr
	D7+ZkZhoA1NlYvOL0X9ltrbA4NsI47nKhcQ==
X-Gm-Gg: Acq92OGda3gX+yYarOu4zohx3mFBXYierp5pOzTVR+9odff9ZC7JFFcKQAIyt+ffZVE
	ZKNB0DjaFjxe1tv0IUl6d4cU22zTs8yAD9I+C72VhP/BS+rMsYSjCsfFdwNIpwAfb5dbqP4XNMN
	9nHjuINpPzQa9VyfBtPUme+3ibTBQ5CtNC5moxbE6l7ncPvksy1IHp3zS8q5bCxgfe17OrL+vQM
	j40Dj2mcUHSGKukpE2t/rX1UV8WKXGWUHamlSumpaQVLfEOZTaQPvRuRzrcGx8WRkgXhDGwRu6Q
	X2ngmXTkV5SBj6c=
X-Received: by 2002:a05:651c:b2a:b0:396:8cb0:d264 with SMTP id
 38308e7fff4ca-396d290717amr57200531fa.8.1781103237138; Wed, 10 Jun 2026
 07:53:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609162427.47578-1-rfrohl@suse.com> <CAEjxPJ4XJROiL2BZqtaVo4YQxpJig0i8mr+yRiWPArv6usYUMw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4XJROiL2BZqtaVo4YQxpJig0i8mr+yRiWPArv6usYUMw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 10 Jun 2026 10:53:45 -0400
X-Gm-Features: AVVi8Cez3xG4-d7Xil9KCbohACFcqlG2qO7j_6E7jErYKrEEave1mTzO3EByBgI
Message-ID: <CAP+JOzR_RcGPufgXM6bT+rFf2ALj4-TeqwRtrEiwhkD0_RWnSA@mail.gmail.com>
Subject: Re: [PATCH] sandbox/sandbox: fix saving file changes
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Robert Frohl <rfrohl@suse.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 2:15=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jun 9, 2026 at 12:37=E2=80=AFPM Robert Frohl <rfrohl@suse.com> wr=
ote:
> >
> > Fixes the following backtrace on saving files:
> >
> >   $ sandbox -M -H sandbox_home/ -T sandbox_tmp/ /usr/bin/vim sandbox_ho=
me/cmd
> >   [edit file and save]
> >   Traceback (most recent call last):
> >     File "/usr/bin/sandbox", line 565, in <module>
> >       rc =3D sandbox.main()
> >     File "/usr/bin/sandbox", line 553, in main
> >       return self.__execute()
> >              ~~~~~~~~~~~~~~^^
> >     File "/usr/bin/sandbox", line 530, in __execute
> >       savefile(dest, i, self.__options.X_ind)
> >       ~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >     File "/usr/bin/sandbox", line 133, in savefile
> >       ans =3D input(_("Do you want to save changes to '%s' (y/N): ") % =
orig)
> >             ^^^^^
> >   UnboundLocalError: cannot access local variable 'input' where it is n=
ot associated with a value
> >
> > Signed-off-by: Robert Frohl <rfrohl@suse.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  sandbox/sandbox | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/sandbox/sandbox b/sandbox/sandbox
> > index e3fd6119..4e7d56fd 100644
> > --- a/sandbox/sandbox
> > +++ b/sandbox/sandbox
> > @@ -126,10 +126,6 @@ def savefile(new, orig, X_ind):
> >          if rc =3D=3D Gtk.ResponseType.YES:
> >              copy =3D True
> >      else:
> > -        try:
> > -            input =3D raw_input
> > -        except NameError:
> > -            pass
> >          ans =3D input(_("Do you want to save changes to '%s' (y/N): ")=
 % orig)
> >          if re.match(_("[yY]"), ans):
> >              copy =3D True
> > --
> > 2.53.0
> >
> >
>

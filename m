Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4D7276052
	for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521781; cv=none; b=Bwah9XavtgoECqZABPEYE2qdJGMgwvtv1wCdv6Gj90H8v7sJyibBZ8Q79b+5/cWII+6N7fDP6SVv+Rs5afhKTU8F3C7ps3vSAWnHNc/IyA9uKUWk/s2X35WxpmAZxrz8lBxOENivcnRvW4pvFFOwIrWwxLwaSsLoItd3531RC4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521781; c=relaxed/simple;
	bh=br5Q3ZOORUvzLvVUeC2V0x60iWj/aHykRZ2wfb+cZpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HU1AdrFweUgiOghEFMMyy5yoYPJ2xZ007Blu6niLfj1aWEmZ4Na5foL7vIcae4P7Pxn4Ml4cx98Ktf1PgUB7ouRqw7Gnc+GzdBXcIZsLYkY74YVXyCVsRUQF8j8e51AiJSPMXz/vSFm68VJ4phtjk70sP4D5oFbm8VQ7IdO0Ibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBmE1Vk5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBmE1Vk5"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2570bf605b1so38789805ad.2
        for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 09:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757521779; x=1758126579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUVEMaBunBmRUf/lZq79XJYgto9ifDRdsFnQDHK57io=;
        b=NBmE1Vk5Elvmt9zCO11NUlQ1m3NP3XR9d+giRksez+sT3cHAJ8onq5xVIvjojXO3xi
         7MYNaO95QNSHGflv+uN5uz0nEwHH3SCzkbpHu5yyx7ZdqVyjA0I8T2aMg4k9g9N9AGH8
         tQSI3tov2l85lAgkagmkC3tGhCqB1VTi71up50yENaQg/Sct9ExRB5+BUeUO7ljQ7Fzx
         HusPDompHo9NjIbHW3UZHCylLeoMD3if+KQDtA/ibE6iX7VrnNpRrcyZu5spY+4+sS5z
         7ZlkdmiZKsDam69HyZYvvB4IkqiCAvl0MlqQpWIlbMwBWHeL1dJaFoftgyKVWTHp2tFo
         ObEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757521779; x=1758126579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUVEMaBunBmRUf/lZq79XJYgto9ifDRdsFnQDHK57io=;
        b=UWjAB73m0gZksnLhBCmUj6Ky0uDc8XOS3kLUjCTsW8bEHmZI1Szb1qa87J3BInnfnf
         lrw7oW2zCyrJBPWJULRQcww+FcxEjfHZB05+arNqF8FvCe1jEnN6YWW0XclTfMnr/pL7
         EpPkgFlrrrw+4C8Dw4sVPoe7ALe32CjHjgXZL6WCRY0Ls9jhlCEkeiRjyDtrVgaUJ973
         NWhBphEPYxQybtiWXieyp/3JAEl+rqwuHDl0jfcjPYz+fApQGysp2b4KoVz0qWMQORAY
         0IcFvu5Puu19uP6c5Ht8vriJ4OGHjC5GknaaSWdCW+MjAukYiO+LmCekit7nWiAamD7W
         EcJw==
X-Forwarded-Encrypted: i=1; AJvYcCVCZomQx4DZ/59719V6OIkgAKGFGVUaZPJ2z7NZxetwm4Yiwuh4Dk39P83pD1tCd29fzYFvcNcE@vger.kernel.org
X-Gm-Message-State: AOJu0YwugOxw/9zaHDQ3cvwbYXPy8w5Bfh8lOwYcBMyYMy6v6kqGPj/e
	WuOgpHwsSHGjkP9Qk6lgF5uCLHZrtHrTNoRlZMja/l4EeQZmLS6+pyYJPSwp++vPRQ4Z3tGJDB0
	H8kIn3rNbyU0kHYY3ydQFZa4GC/5M6QPUlg==
X-Gm-Gg: ASbGncsoWsOcquLn/S52Gp9gnmrBJf42CpOzSZ3ijvbGmvDoFefLfX3edokiNDCbut0
	Ru2Ka/QFZoidDl9GOFA+Mix0XssK4s1IyXzbqB5hnwDHkPUnp5GQBzGaJW03uwcNnrOibzPJ7wG
	yHRqrWmiMJaiY/R2YkoCnD6eMCGx/A1+0mgATfdQDC07dwdDtAgT2drZrbT7FijGHqthwGbIp79
	5pU4QHZxti1FuaoRQ==
X-Google-Smtp-Source: AGHT+IGdZ+53fC3kIjZ1n2iQh8QNTRg3vp5Pi5wR7q3tq/+vY82c65HKDA7dQ8O6AwIWLsQ8olPoATLSATet8/2VQCg=
X-Received: by 2002:a17:902:e806:b0:24c:d6c6:c656 with SMTP id
 d9443c01a7336-2516ce60e49mr201741735ad.4.1757521778798; Wed, 10 Sep 2025
 09:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909213020.343501-2-paul@paul-moore.com> <CAEjxPJ73qtdeTcv40gdj2tPJOSRC0VzGqEmHCZv6CwNz4AZdTQ@mail.gmail.com>
 <CAHC9VhSg6jsO8kET1qMUNUkHuWJ9e8UJb=Q75VmCv0kEzwk0Fg@mail.gmail.com>
 <CAEjxPJ7-1MdtcXaeTwH7Z-uPV2Mt++5NTGRWx6u58xKieH-G4w@mail.gmail.com>
 <CAEjxPJ72F9PsdWo_XBL5XDABYwZFJh5-TSt1bp3toLwgoLchkQ@mail.gmail.com> <CAHC9VhTXR42Ogr-aS6OLHTZfW2vwBLtAcSqW7hJ4-0FMZfC2Kg@mail.gmail.com>
In-Reply-To: <CAHC9VhTXR42Ogr-aS6OLHTZfW2vwBLtAcSqW7hJ4-0FMZfC2Kg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 10 Sep 2025 12:29:27 -0400
X-Gm-Features: Ac12FXzFOUPBZyRikXVT--RGNxMaydiBTqeUfmMKrT-EZRr7C1DPATm_TzLHkVQ
Message-ID: <CAEjxPJ4387JPN+JOQ7g=Z6CCXYR-mk+6tr_VeyprxNJtCy1TWw@mail.gmail.com>
Subject: Re: [PATCH] selinux: adjust the !file/memfd_file error handling on execute
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 12:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Wed, Sep 10, 2025 at 12:06=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Sep 10, 2025 at 12:03=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Wed, Sep 10, 2025 at 11:57=E2=80=AFAM Paul Moore <paul@paul-moore.=
com> wrote:
> > > >
> > > > On Wed, Sep 10, 2025 at 10:05=E2=80=AFAM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > On Tue, Sep 9, 2025 at 5:30=E2=80=AFPM Paul Moore <paul@paul-moor=
e.com> wrote:
> > > > > >
> > > > > > A prior commit, see the 'Fixes:' tag below, added support for a=
 new
> > > > > > object class, memfd_file.  As part of that change, support for =
the
> > > > > > new object class was added to selinux_bprm_creds_for_exec() to
> > > > > > facilitate execution of memfd_file objects using fexecvc(2), or
> > > > > > similar.  This patch adjusts some of the sanity checking added =
in that
> > > > > > commit to avoid a "silent denial" in the case of a kernel bug a=
s well
> > > > > > as return -EACCES instead of -EPERM so that we can more easily
> > > > > > distinguish between a permission denial and a fault in the code=
.
> > > > >
> > > > > Technically, this doesn't make it easier to distinguish because w=
e
> > > > > usually return -EACCES from avc_has_perm() and friends, but retur=
n
> > > > > -EPERM for capability denials and in certain other cases (not alw=
ays
> > > > > clear why, arguably a bug unless we were just replicating the err=
or
> > > > > number for some existing check that also returned -EPERM).
> > > >
> > > > It's awfully fuzzy from my perspective.
> > > >
> > > > > My
> > > > > suggestion to use -EACCES was because that is more consistent wit=
h how
> > > > > we report denials outside of capability checks.
> > > > > To actually test this, would need an updated libsepol patch that =
deals
> > > > > with the fact that the policy capability number changed on merge,=
 or
> > > > > re-basing the original patch on top. Otherwise,
> > > > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > >
> > > > To be honest, this isn't the sort of discussion I like to see for
> > > > patches that are merged in the -rc5 time frame, if we're merging st=
uff
> > > > at this point in the dev cycle we should be past uncertainty like
> > > > this.  I'm obviously not going to merge this patch and I'm going to
> > > > drop Thi=C3=A9baud's patch from selinux/dev too so we can sort this=
 out.
> > >
> > > Not sure it warrants reverting Thiebaud's patch. I was fine ack'ing
> > > that as is. I just thought we might want to follow up with something
> > > to improve the error handling here, which can be done anytime IMHO.
> >
> > And if we revert his kernel patch, I'll have to likewise revert the
> > libsepol patch, and the policy capability number might change yet
> > again before it lands.
>
> Yep.

Bummer. Me and my big mouth. Apologies to all.
Revert coming up...
On a different note, taking a quick look at POSIX.1 definitions of
EPERM and EACCES makes me think we got it all wrong originally and
should have been returning EPERM most places (except for file access
checks, maybe). But changing the existing ones now could create havoc
for userspace.

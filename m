Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B5A18C33B
	for <selinux@vger.kernel.org>; Tue, 18 Mar 2025 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742300672; cv=none; b=JHItF7/sGcfkj8JZeT+3nMFjxtElKSjcKOzwEV4ZPQaKBeS3Wnpm/kLmCnPCspJNvcWv274ivykGetslBhuzRZoCTYRLVrGgpkckZn6LWCkhtHAoOSQVbacDk5Fn33E0Hs5/byjR7BFWNIWyZ/upeBR/Bcui+lFnX8KxEVX9vbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742300672; c=relaxed/simple;
	bh=gG/anreUhIhbwJ2C/JEED2i2FMzgGgdw7Rj2+DdFEbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gh8dhh7rSqGI4w/3ECVYrhUwwmsK7D84NUM4BJm5r+thrj86UB4G0TBnuq/6Q3P3Qlee39zIIyNvm93BzWaOhVUMrS/zsvIXx4Z+3txCj+6pwu9UMRCDPYeD3UkEo0iL6MAwJRknCvyI/smz8LiBJrM5mi0EGRv/t1xBP5326iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBt3t1rD; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBt3t1rD"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-300f92661fcso5049624a91.3
        for <selinux@vger.kernel.org>; Tue, 18 Mar 2025 05:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742300670; x=1742905470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gG/anreUhIhbwJ2C/JEED2i2FMzgGgdw7Rj2+DdFEbw=;
        b=SBt3t1rDvVJ+APaXDlNQ61temzzpiUsQ/Hh5VNqGFFhhZARGb15Nr9Zwp2SU9lHLeH
         nyD/rJk4nq40MRzxGvxAZtAmd5F7saH7b/DLtRVwcm21toPfEXqdgWgHTGMo8pNgfn+K
         luU0gvjR/bk4OzC4eOh20e66CVv477ZKnSk64BGCrsNOPCcZJSftBIhB5f5pAQy9SUXE
         synFvFi+uf5LGLx9mQ2wZ0AHacxv+PUsaon5plGRUzHZ691YRdK63WP0nEhUvM34YFVs
         24DajbU9NUvhLDuqk+yRoHIG6uYISp45kTccC+ZvngWv7cvH30QxZRIbDw/ibNNK8+a5
         nWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742300670; x=1742905470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gG/anreUhIhbwJ2C/JEED2i2FMzgGgdw7Rj2+DdFEbw=;
        b=OqTvT2M2iUJM0w5A8bh/Tuq0Eyc91maskI+03EUhyuo34KRRp8V+DrjO68RyRGttUY
         Z7FmRS60XY7YhoxsQ6LhdYm/rbZuOKI4GUq2iEZ4Vdt/u9ShuPJjkS62bGDtYzUg6FHT
         F7O3KlVRJw78QbX3N3RIdiiNGdjhjy/6P+Eeq9Uy7iYn+F4UTb6W7RZ3EMxXavKdXrPV
         GbWFNnj8ydhiMBJZtOImagNHC24zPQq3q+dakzLGPBS4lms9mRAuh/ZsCSTgHKkb2GL8
         j6OzROl5iPiWSA1oTEMBu+sljrjNbFgDUDRNBqgLcDsGkAo+62dwfiKZ6jMxfXA2tM3O
         Y/pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIY4UaR2kF0tm3jMWEAednZUQDQoXWJT2nwg+L7n/Kf/JFfl7rOy7Af8g76trUnLcELw9FIahS@vger.kernel.org
X-Gm-Message-State: AOJu0YyznyOldqxfQz+ILAA7/mayb20tzYffMIFn7X6gdTL8IyztXRvf
	rG4hulkkjW37XTtHjKGyhjsdUkWwXW4YIe9WsXmgztZyCwVmY8BEjXOyOx6l85GIqTwKFzjFTAS
	c+dyMKrg29/CRbsPH+pEO3BqF7Ss=
X-Gm-Gg: ASbGncu0grXLmBqbX+oehXef8jczoXY2+gheBaFPseqgYRwTvV0JbeEqS3if9TLmcSH
	0uLCz7dkfADfgtZeZg91cJBlp1/Tj6Udo5ZaAxcX0SG+9CupricFhhbVJ1Clc7+8sGIobh48xiQ
	Jpz1eo+inm/2pFKaUdqF904rkHyg==
X-Google-Smtp-Source: AGHT+IE/DVqE5fnEt8iA34VsmDWG8VZ8IKicgfA8t2qwElWPoTryyDRDRoTBs7Jr3ajRj1YQsUiAnksTUV5pRSnF2hE=
X-Received: by 2002:a17:90b:1a91:b0:2ff:5a9d:9390 with SMTP id
 98e67ed59e1d1-301a5b12f10mr2560369a91.8.1742300669886; Tue, 18 Mar 2025
 05:24:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <98f87fd6-6d3e-4539-ad8f-1a0dc09aa890@suse.de> <87senb7mt4.fsf@redhat.com>
 <8ca3a1ed-0f53-4da9-a86b-75699f306f8c@suse.de> <87plif7egm.fsf@redhat.com>
In-Reply-To: <87plif7egm.fsf@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 18 Mar 2025 08:24:18 -0400
X-Gm-Features: AQ5f1JpFtMDyKxzyNT13dfwjPzsvUKlC1GZX5WwKquZH0i7QuOtTsmeGmDhtPbM
Message-ID: <CAEjxPJ4DZs_1dPuO87UPpuvQL-PEq6zq9KA64SQvzsT1Mq8CqQ@mail.gmail.com>
Subject: Re: Question regarding restorecon and btrfs read-only snapshots
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: Cathy Hu <cahu@suse.de>, selinux@vger.kernel.org, fvogt@suse.com, selinux@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 1:32=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Cathy Hu <cahu@suse.de> writes:
>
> > On 17.03.25 15:29, Petr Lautrbach wrote:
> >>
> >> You could use `-e <directory>` to exclude read only subdirectories.
> >>
> >
> > Yes that is possible, but also requires a manual change by the user to =
set
> > this up together with the snapshot (same as telling them to add <<none>=
>),
> > which we would like to avoid.
>
> Your -relabel.service's are generated and so can be restorecon options
> there.
>
> Fedora uses fixfiles -
> https://github.com/SELinuxProject/selinux/blob/main/policycoreutils/scrip=
ts/fixfiles
> - which detects ro filesystems and skip them.

We already have logic in libselinux/src/selinux_restorecon.c to
exclude filesystems that lack seclabel support; should we augment this
to also exclude read-only filesystems to avoid the need to work around
this in all callers?

>
>
>
> > Is there a reason why these r-o subvolumes are not skipped by default?
> > Could they be skipped without a problem and it is just missing the impl=
ementation?
> >
> > Thanks :)
> >
> > Kind regards,
> > Cathy
> >

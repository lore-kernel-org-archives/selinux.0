Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286AF140E5F
	for <selinux@vger.kernel.org>; Fri, 22 Aug 2025 02:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755828579; cv=none; b=NtlV9oG/gTP4NkFNY28xHalZHM7qAfsUmJGAt+6fonKyS996OE+Na9EeCrkVL38WIsIUUsJhDShok/eeqg4dsNzAiR1PpGcAhkCurxuymY9O5U6+riLa+SQTOOonf7CBLKwYOp4GASriPIgckjd4ZV25+RAb2K9e79VZ+FV+RJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755828579; c=relaxed/simple;
	bh=U42Sc+Kk9sXu03rV6dfo35zreD1MTPPg+P9rUoVcfG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tw5IKbgxald5v+8ipjlnrHDs6Vs+/smb+903dfArCt7Wi6vGwJ4fvbh+789A2xqPa5xPU0EfEuLZ3DSbqJ4HLFUfg7RaIImzvWykINClADGkooRj9HZg99+3P0WHi2FVqWwVA9h3tIQSYm5ccbCTmt0bfLEk1NLQvMmkYBtcl+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TszoqEC/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TszoqEC/"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e434a0118so2150651b3a.0
        for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 19:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755828577; x=1756433377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLP8iKRr+ohSFMsq/mB16HGu0FINjmHne4DCLR47GiA=;
        b=TszoqEC/Fc9VBkv+4xt15Z0ectpygPIcrRmtKby+YojJQsfj0rEMSvQEIbvYMAK7pB
         1Jp9E+cCOOZTJsgEfOhrIqURP96s0N8bGqcyC2cFiC08liOLWxBGtrVcCsy3MMqYWXZh
         FCTBmcvdaXfg0r+FZcDpMtBGm/4AgZIWekTzD7mzU293tztkSufrGbzPfpJ9ZQftlkAL
         sCiYJJgxDvKnthr3FU3OsILS1vdyYcBARTkZhrNHSi0bOGKbKnsoBWBpwl1rST0Gg02U
         +0AbCfbWm0FWG2n5d34Ncv80cmFAmArGp8VoJaRj6g37Wmz4F8aFtIao+mhNieii1WAD
         nDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755828577; x=1756433377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLP8iKRr+ohSFMsq/mB16HGu0FINjmHne4DCLR47GiA=;
        b=PBLQwEsNhA2GbEuSRuNX5nuFj9pkt/QWd0kWIGVLLWB4xJZU2lN+fWvW+o26RP7HNY
         WfOAwASwfeav3eqYV+j7Im52DBL/t8btbXu9b61QU6VKSI0XG+BQuqFVmbLMDm3EIDPv
         emzaH4WKzi8LYYT5HWvNWzF0pPb2LCg5zqawagxk5LKaaXzR140WiI+2waO3ewuogy0x
         g+vtrY+r22pjpo7PyFNdjcLBAG3eqfdrGAZQDUlE2z75jHp3rvaNHCT8tlWtwQ6b+IEp
         yXYzzpD0P0Y3Amox9e7vOSIMA+PlzzdOHjfnAuUfY84xEhSZn3FfoV0H73OQHrAtecQC
         MeGw==
X-Forwarded-Encrypted: i=1; AJvYcCUPQnqckWmufV3CQdHkf/KcTiGEM8Aei5Il8TmvjUmQKPkFbfIiYbvv7ah+/Uw7UmPs8YyAdKwZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4sWfP14a1uujM1jcN/f2X2D0LYfl9S2NCZ3xJAAczxAVuc3vo
	y9XKQ51yeOOP7CFkaWy7Pre9zkvoQZwqfDq5y+SOzLB50LCVGM/PQYALdRY0sRiGhOGqIK66Rpp
	ZWm8GwFDNU5knt1WV68D+EN+lcrK0/ybAbOe2p9MT
X-Gm-Gg: ASbGncsdNIEFb5HcG8aQLW+nb05vsd3QgT/cLwUkILXNNMSmiVJ6J4H00xmRrUc0BS9
	l1eJqd9Wl8oYhrTzinvGyhekFB3dOP3Vg6tUjbRqjrJ0J6TjIZ01vkqPpW3D7//5lflVHTvlTNF
	Uy6HTSolSxhhv0aj/QDCC+y9gPJ32dBUfOXgYZ2rrWa6a+OHv9I4RZQSeuumi1USzhJwLHP5k1l
	HDVlB4=
X-Google-Smtp-Source: AGHT+IEcl0zQPWPOL2ThXaF277kZWC8q5RjBCXk3kMOCqG4g9sY/ljFwTT2yo/j5P5ezk8JiEPirfpibmS38bGcONxo=
X-Received: by 2002:a05:6a20:7489:b0:243:15b9:778c with SMTP id
 adf61e73a8af0-24340e6cb77mr1881334637.48.1755828577324; Thu, 21 Aug 2025
 19:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
 <CAHC9VhSubXA4tAUoz7T==UvfrM_DXS6nF5s0tJZ1HrrVizMgZA@mail.gmail.com>
 <20250820.ieNg1quoRouz@digikod.net> <CAHC9VhS3c257ywxADRzPYE-DsXSwRp8P2RhAfdDnXJHOX5bXTQ@mail.gmail.com>
 <20250821.Ree4Liedeita@digikod.net>
In-Reply-To: <20250821.Ree4Liedeita@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 21 Aug 2025 22:09:25 -0400
X-Gm-Features: Ac12FXzHbfRH1s6Tzr7AcXsiKbn9LpN9T2Gbw1X6nzUUC3lAAJW1biVNyduCR2k
Message-ID: <CAHC9VhQC9Yn3W1mU_=iOtctGeSLe9FvJnDRYBO-o1AfACVDNUQ@mail.gmail.com>
Subject: Re: LSM namespacing API
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	=?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 5:56=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Wed, Aug 20, 2025 at 04:47:15PM -0400, Paul Moore wrote:
> > On Wed, Aug 20, 2025 at 10:44=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@=
digikod.net> wrote:
> > > On Tue, Aug 19, 2025 at 02:51:00PM -0400, Paul Moore wrote:
> > > > On Tue, Aug 19, 2025 at 1:47=E2=80=AFPM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> >
> > ...
> >
> > > > Since we have an existing LSM namespace combination, with processes
> > > > running inside of it, it might be sufficient to simply support movi=
ng
> > > > into an existing LSM namespace set with setns(2) using only a pidfd
> > > > and a new CLONE_LSMNS flag (or similar, upstream might want this as
> > > > CLONE_NEWLSM).  This would simply set the LSM namespace set for the
> > >
> > > Bike shedding but, I would prefer CLONE_NEWSEC or something without L=
SM
> > > because the goal is not to add a new LSM but a new "security" namespa=
ce.
> >
> > I disagree with your statement about the goal.  In fact I would argue
> > that one of the goals is to explicitly *not* create a generic
> > "security" namespace.  Defining a single, LSM-wide namespace, is
> > already an almost impossible task, extending it to become a generic
> > "security" namespace seems maddening.
>
> I didn't suggest a generic "security" namespace that would include
> non-LSM access checks, just using the name "security" instead of "LSM",
> but never mind.
>
> > > > setns(2) caller to match that of the target pidfd.  We still wouldn=
't
> > > > want to support CLONE_LSMNS/CLONE_NEWLSM for clone*().
> > >
> > > Why making clone*() support this flag would be an issue?
> >
> > With the understanding that I'm not going to support a single LSM-wide
> > namespace (see my previous comments), we would need multiple flags for
>
> I'm confused about the goal of this thread...  When I read namespace I
> think about the user space interface that enables to tie a set of
> processes to ambient kernel objects.  I'm not suggesting to force all
> LSM to handle namespaces, but to have a unified user space interface
> (i.e. namespace flag, file descriptor...) that can be used by user space
> to request a new "context" that may or may not be used by running LSMs.

The goal of this thread is to hopefully define a set of APIs that
allow userspace to create new LSM namespace sets, and join existing
LSM namespace sets.  We're not necessarily focused on any individual
LSM namespace concepts, beyond ensuring that the API provides enough
flexibility for the different concepts to be implemented.

> > clone*(), one for each LSM that wanted to implement a namespace.
>
> My understanding of this proposal was to create a LSM-wide namespace,
> and one of the reason was to avoid one namespace per LSM.

As I stated in my original email, perhaps not clearly enough, and
several times in the past, I have no interest in supporting a single
LSM-wide namespace at this point in time.  Any LSM namespaces must be
done at the individual LSM layer, although I am supportive of an API
at the LSM framework layer to both help facilitate the individual LSM
namespaces and provide a better userspace interface.

--=20
paul-moore.com

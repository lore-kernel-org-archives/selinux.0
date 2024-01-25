Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461826E2DB
	for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198370; cv=none; b=FQ8VlTWfWAmZW4OMNVcTwMyLVge6qEAZEoR322cZumQ270cxkvVlhYrkC00KqErJW/bq1HI1w+I9SxSH57Pg/0WB5YHy6tj3K82CTCengLAkP8+WJns8JHLyG5SrQMIYoPIacwey3QmpA5M4qym3lB8Zxp9BUSP1YuvQzyIBQdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198370; c=relaxed/simple;
	bh=JLYjQAW8uN3mo3cpDE3fT3XB64Zoal/PShd+3aJ5up0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvfePTESdjh9kK+IlrS0z6fSEiczdyyRWE6uhLRJ/3CSvS7gxiRHdOvuORcHx13uahpk972dPcVlpcbiFRyRdQ6nGuEaz1xvWCF3mSZtshH5L4yoYFxr7dAjnfFMbxWdEPsPAbOe4vFCfDpu/gq2dS4Wa5l9bXdSKa+NDHjAwWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2zxz+FJ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2zxz+FJ"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c66b093b86so638903a12.0
        for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 07:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706198368; x=1706803168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLYjQAW8uN3mo3cpDE3fT3XB64Zoal/PShd+3aJ5up0=;
        b=X2zxz+FJr5ZuRHuuhFlJE29+2BjH2QzlD4mJX9GBrnA1d4XsiTW/guP5UTF/crbNtd
         hLdmf0Wpn3AGLIuVm+C5MOA6jLP30Gv0ddHZdoX2TIGWTV63/zHMQKR/CbaJVU1jcWW1
         BLTdWo07ZLC5ZgOv475WglXn2cmWaiAC4MK0X+ZYkD3RBcTw2jQhGzPAa1QyW7aHapGe
         ZrEGTE8SNF94ZwB6qWjRLPTm2B7z321fDAGfTteDyKM1XThbEAOJROQelKf2DIa3abas
         STWbCUxrIMnDZ2eIc3TYSUggmkE5mLX5TnUCA6jYW10zkrI36wUbuVwml06y14nkPt5n
         3SGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706198368; x=1706803168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLYjQAW8uN3mo3cpDE3fT3XB64Zoal/PShd+3aJ5up0=;
        b=j2bs8Fbd/LE5FSUeDBWw4jFVSSKQUbdh+Xs7iix/LZp2UP3WvtycXGzT8elJbcOuNZ
         dBxYDM1YEHNf46DkSiE2BKLE78kLONfIy0Bk8qOAwPjIPtdEQWLlITIfGRWf5+WR9sV/
         LvP/H4sGzr/lDX3M6I3QNGkkg9e1U0u0gVwFdazakSMgkYR1CVgDkxvaIbHRcBmWo1qd
         MXOe9JHI2dXXiJ/MXvrAsd756cU9KRcBn0ZXPKaA+lrbWnzcWCIK59R0TclGvlAhUTn/
         xDmAGiTTXJJSwSgKd9Zit6nlhzsptfPjjtuV89cwx9dYdv+D1xvWe0VLDM9eHExjgMLl
         a8pg==
X-Gm-Message-State: AOJu0YxHObbr6tgcXjbnHohZO5HHhA5+fwA19WbBi1WZ5D8gkjxjvuSZ
	cNiFly6B2W8pHjDRrfn8BhBYQjS3XSZ5GmXFwrikOeDG1uQm67gN4B7DSryqMxsbOXjizXO1uzw
	RSku+ygHz9pbMpdHaQ9FrQebwR9I=
X-Google-Smtp-Source: AGHT+IFJySUTftS4lzlC6sVBx0ColEZgj+iVh+H1+Ol5ZHRMac3h2rsO1+NRZV5aGD0Ne3fv/kBDBQfI9QvC875rxGQ=
X-Received: by 2002:a05:6a20:7293:b0:19c:68c1:d580 with SMTP id
 o19-20020a056a20729300b0019c68c1d580mr1538889pzk.45.1706198368603; Thu, 25
 Jan 2024 07:59:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90jYPwRQRAqXxmOKD4Q@mail.gmail.com>
 <CAEjxPJ46kPOA3N7PAgqWs-z74siF7bMoGSU254dYReQwFCNoXA@mail.gmail.com>
 <CAHC9VhQKXtdA4YS7=fB9ffGTDnd7qPkCZVCTO3fvaQWjzwUT=Q@mail.gmail.com>
 <CAEjxPJ4czKz+4SfTo6g3s6ztSRbfyOv_GBkgp=k38nGDFssRiw@mail.gmail.com>
 <CAEjxPJ5_SQDmR9b-+0woBLg25omtERSLBKawTV9AqLpZAHFvcg@mail.gmail.com>
 <CAHC9VhT_zOjJpg-JOaJQ4s9ybArfq2Ez_OiFAk0siPiqEC0KiQ@mail.gmail.com>
 <CAFqZXNvSn-Ct04ghSxiceKkRBgfyUeWJc3J0tjnU-Mm8mfPtAg@mail.gmail.com>
 <CAHC9VhQ4hopKwh6y=M2kZfgM=cdcWvqAbGAD9HMRhDDj88R_xw@mail.gmail.com> <CAEjxPJ4LvVr8w3bPLXrB7Aw=RS=CVnVwH0q7egQTP+F1Qzq1jw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4LvVr8w3bPLXrB7Aw=RS=CVnVwH0q7egQTP+F1Qzq1jw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 25 Jan 2024 10:59:17 -0500
Message-ID: <CAEjxPJ4FxSe2RqLbnN0brsj32LspZ2Gh6r4GPWixv==X3X0oag@mail.gmail.com>
Subject: Re: selinux-testsuite nfs tests?
To: Paul Moore <paul@paul-moore.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 10:49=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jan 25, 2024 at 10:16=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > On Thu, Jan 25, 2024 at 10:15=E2=80=AFAM Ondrej Mosnacek <omosnace@redh=
at.com> wrote:
> > > On Thu, Jan 25, 2024 at 3:52=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > >
> > > > Ondrej, are you able to post a fix for this?
> > >
> > > Yes, I'm on it. I already have a candidate fix, but my kernel buildin=
g
> > > infra is currently acting up, so it might take a while before I'm abl=
e
> > > to test & post it.
> >
> > Great, no worries if it takes a little longer, I just wanted to see if
> > you were able to put together a fix or if I needed to do it.
>
> FYSA, reverting that change does restore basic labeling of NFS files
> but ./tools/nfs.sh is still failing later, or rather hanging during
> the Unix socket tests on a NFS mount. Not sure why yet.

So as a side-bar is anyone running ./tools/nfs.sh on a regular basis
or has it been wired up into the automated testing by anyone? If not
and if we can get it back to a clean state, that would be good to do.

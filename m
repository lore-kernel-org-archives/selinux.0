Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FDD7319E
	for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198328; cv=none; b=fDqHO9NF2c7svvc54UmN/UVnzcWP81b7jftx+5nN5Mphm5rAmZVtM8zNSpaKfdGKKHCVH9qXRoeH9kaXNJXG4M3DZtd0BDq9W51eFodurdYkuoQBl9FuDLkcwwdq3u3g6LCd6bPUcuKpeYGicpkysTpmHeHa07QNgpSxrgth7/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198328; c=relaxed/simple;
	bh=BNyJMWhnmHoU0qD9gW8F38gVGWyTktThlbbM4C3BJ0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urBMuvM5Pswy2agvQSZEP4d8ZNvg4poihrExiMHL+qIwzXEWfEpuVmHQH3P/vya0NzF/Cf4keCvWKleOre++xo+gbOwJuZwXid6yy34NVnPEh3BGVhVFmkMXijrhyABWyIGxaHgXdUdh0iI6UniD3XEhf4rEM0GuTMZUddIRbUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WCU8ErCO; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WCU8ErCO"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5ff7dc53ce0so52313787b3.1
        for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 07:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706198325; x=1706803125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNyJMWhnmHoU0qD9gW8F38gVGWyTktThlbbM4C3BJ0o=;
        b=WCU8ErCOa4NJw7xrzzEQywQYNwjLkRu319yqEU7QRUE6NzdmRwdfL+np1udGvtsQfL
         oauhqKNBnMiuV4W/n7BO8I/bY9SZISGZ6UBhUxPlidVWNPDkm60ngBr5LghxiAeUmzII
         MMprJWpSeEB2VSLBT1wjdueSOfJfZoKK5F5POSLNJajFkPvfcPFfQIPouMxU79tdPahD
         M+O2QGTKfKZHDRPNa2ntxy72p5RKy4oXaSHmeJwAVX9orgvlHyfcdoENtdg5ojA3oeUD
         ERrvwD1DiRqV8akWuWtt0WVj6OVhw7S7bsIfwVCEKbIsH/VZfu9qWzfjXjCjsw354Q1C
         6BdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706198325; x=1706803125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNyJMWhnmHoU0qD9gW8F38gVGWyTktThlbbM4C3BJ0o=;
        b=BzxEpjl0Hwaw+Slfp5sP43OX5gyuxiqOVRiMO9RYS1Mii8udPDLY7/8WIJsqvJ2W8w
         6eGrHKOzo8fViOt8l43lf6fMk6FUOUY63u1if9o+rQUiRrITzb0pYvJEbTXBjmski//X
         92/OTda2Mo82tVLrHXBmdTp6+FDkOEluuu3v9sh3+PxjcJ8tDPO/rKD++Yb4gdYm0TWZ
         Zd5CtlG/fYXrw7cp1COXrp6A8iHbuhu6V85FTo8SBG4i5DEr6jzZtFfa91R9QJN5Xjhu
         EtMGg7vxj40i6B82sF6FWlJL2dv3kagRTyS8TombthR/t5Al4QH0FhvdYgqAIqVPjZzr
         N8xQ==
X-Gm-Message-State: AOJu0YyNgiF+vLiANe1mJskp+RhIQw5F432kn/yQFdB1UuCrXRPht796
	EPP58d6NTG+eTbDhF0w7xPJFGpOOkX9OVwGhNJDWKe46MvDtZwdLOh6QyoK1zq/hxXvWs5pFCEd
	fV0iMHf1sggZbD/7Yb2Gx2Tln5uG1Eu6COS5M
X-Google-Smtp-Source: AGHT+IHi9xOcEw3umN0u1glNrPV4qYvVZkQz8kWFvq7aHgGCJV72NjIwpPeYoC+xt3CcmELwbIVVkJBUhKi9wtSWzd8=
X-Received: by 2002:a25:268e:0:b0:dc6:551:84cd with SMTP id
 m136-20020a25268e000000b00dc6055184cdmr10004ybm.23.1706198325412; Thu, 25 Jan
 2024 07:58:45 -0800 (PST)
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
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 Jan 2024 10:58:34 -0500
Message-ID: <CAHC9VhQaHCh7JsdRUD4285jGnGgG9URsq6ZD51QtyxFbH4zZwg@mail.gmail.com>
Subject: Re: selinux-testsuite nfs tests?
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 10:50=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Jan 25, 2024 at 10:16=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
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
> FYSA ...

I'll admit to having to google that ;)

> ... reverting that change does restore basic labeling of NFS files
> but ./tools/nfs.sh is still failing later, or rather hanging during
> the Unix socket tests on a NFS mount. Not sure why yet.

Since we know what the problem is, and while we haven't seen it yet, I
think we mostly know what Ondrej's patch is going to look like
(assuming no testing surprises), I don't see a need to do a revert.

Independent of that, we should figure out if we need to do any
additional work to restore labeled NFS.

--=20
paul-moore.com

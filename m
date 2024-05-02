Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CD117A93F
	for <selinux@vger.kernel.org>; Thu,  2 May 2024 19:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714677506; cv=none; b=YFHgD56hlNpvCHuFN3nZzHtNwYB7iq+Gq6MKw1MfStfr3Ytx5XrLgZeEGT2ttjgh5lTISTVUg7Kc0Q6ge1vdCSa1XdnMCzszNsQimooMY5XU6wwobfNDD7GGu+4UoKrQBdaaEjtXC1kx2s97bY6ZkOPgIBIpv7apa/ogU86zD1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714677506; c=relaxed/simple;
	bh=Fnk5jzZAXekmfUvaw16/NO8l13HxJrYwkKjVo4a9IeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dRCjexHQIX2uL6Gkn8p6bTjCtyI38au65G5ytEFTBgapGHVJW2e/IVfiyhYp/aoBgK3SCXTDQlGvlOxLQTvCeVunRl4VQNyfDcVJUfw9jYW7G9nLaUh986RHlMvDBHdG7xugr8NW0L/Fwf3VDeerTfv3/pBlJ4Vs1cBzKE6qFVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQrApy72; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQrApy72"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed5109d924so7141678b3a.0
        for <selinux@vger.kernel.org>; Thu, 02 May 2024 12:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714677504; x=1715282304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAB5qC4KZOmHewkmbSqDiUCG0bWqrGvmB4ATHPl5eIE=;
        b=TQrApy72HNQXQb9Wgd5Q+lj4YLPpydtAAgAeGD+fG1boEYs71KRAI5ZHeVR5uhnrNY
         3PlvvnzuLSrZZnLjagVn5E79Fz+zgyxTmLU0IhjHB8Y7p/QQlMYULILeuy2twnf6DXSb
         Ojfpd4GjPSVcyy+L6bUXZNcVUm6gEBVv+bDvwy21QvFCACsuLZF8PZUFoJeDzuWU/2yU
         JRTaTQK3cIEZyQEGwUtw/0A/ik1VweUghg+G9uDGNXMWS3pYAkuz7dKvTgmQy7SFDMF0
         wTaNj+lKm4ZYfjlCtKyhFiKKPyKAr5Deq7SKiqzZy5SezSmPa1ziYf6nVhxw91/7/5yE
         T/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714677504; x=1715282304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAB5qC4KZOmHewkmbSqDiUCG0bWqrGvmB4ATHPl5eIE=;
        b=UFRsNg7lQCD4WtrJ2tTdW0BIb3zHhvFU5L1v2Qc1wr9FHlM2DBtlU0vclX+dWuN5aj
         hptm0v6NOmP2L7kwMjfyYSYicRVRR3Y5n1rjKkXeoJbc3ulskiw7Hh1wR66yEtz183Be
         nS/4v1EUozJaJRwqwrOtF4Bt2sHPV0e+RoJa3tNEpUz5rDKTKq8HIc1OOx1sZ6a7yhwu
         HWMri9xSBEPzgaJQe46xv8IGtCsTZXsrCHtiw+/IiC6SQgPELX2OA1HyNDd0ipcJQHUj
         WiBV0I02JmTaYOHUobfPPuP19gf9lejRk4zls4iwoG88TAC1DK03FIYLqHU61Wb1+pn7
         Og0w==
X-Forwarded-Encrypted: i=1; AJvYcCXD6C8UlAltFpyuYhB3f22YALi1brwlz9/6PKIB1RiCTtoBsi1HYjIkwmRDIzmQc/b1XYXHiM0OfnK+Hsi2GfV0ameUzr+LJQ==
X-Gm-Message-State: AOJu0Yw1N77CYQB60hWnUaIuXkxg3LGtdVewARRqcYUNJG0MkJP0fuoT
	cyx06Kaj9O8UyLiJMJcAIEcKHZAC6idgfNW2VAqSN5lF8/OmM5WkyeW5rO96IGrl4HkcRMwUUeA
	5KDdcS/BGIBcz+rtmTZGVm8fVNL8=
X-Google-Smtp-Source: AGHT+IG+mCBvA2eNsxPu3tDYA60wqoZ+xQvt09TWYnmdfPdwZKQqdGmRVjB/M+Ae5tPA2wpES45hUfxFAjVUm2CUQAg=
X-Received: by 2002:a05:6a20:1055:b0:1a7:79b2:ff1b with SMTP id
 gt21-20020a056a20105500b001a779b2ff1bmr682367pzc.27.1714677503737; Thu, 02
 May 2024 12:18:23 -0700 (PDT)
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
 <CAHC9VhQ4hopKwh6y=M2kZfgM=cdcWvqAbGAD9HMRhDDj88R_xw@mail.gmail.com>
 <CAEjxPJ4LvVr8w3bPLXrB7Aw=RS=CVnVwH0q7egQTP+F1Qzq1jw@mail.gmail.com>
 <CAEjxPJ4FxSe2RqLbnN0brsj32LspZ2Gh6r4GPWixv==X3X0oag@mail.gmail.com>
 <CAHC9VhRTfUO_b+dfWRNtFBPUCnk5iRCkCfT4PcNBt+b856t-iw@mail.gmail.com> <CAFqZXNuqHKAJUdZ-3VL64Be0hp8jPjztk2NaUv4+XFcgUe23CQ@mail.gmail.com>
In-Reply-To: <CAFqZXNuqHKAJUdZ-3VL64Be0hp8jPjztk2NaUv4+XFcgUe23CQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 2 May 2024 15:18:12 -0400
Message-ID: <CAEjxPJ7LJR9Xv7fzPxNYToRniDXAdUo3dqNN5OTVUYyy3ct+dQ@mail.gmail.com>
Subject: Re: selinux-testsuite nfs tests?
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 5:12=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> On Thu, Jan 25, 2024 at 5:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Thu, Jan 25, 2024 at 10:59=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > So as a side-bar is anyone running ./tools/nfs.sh on a regular basis
> > > or has it been wired up into the automated testing by anyone? If not
> > > and if we can get it back to a clean state, that would be good to do.
> >
> > I am not as part of my kernel-secnext testing, I should, but I haven't
> > had the time to configure that as part of the test run.  Building and
> > testing on Debian in addition to Fedora is still higher on my
> > kernel-secnext todo list, and I haven't made much progress there.
> >
> > I believe the IBM/RH folks are doing regular testing, perhaps they
> > have something in place?
>
> We don't currently run the NFS-backed selinux-testsuite,
> unfortunately. Looking at my unmerged branches, I can see I tried to
> add it over 2 years ago, but the note I had left for myself says
> "doesn't work yet due to NFS bug", so presumably it wasn't passing
> even back then.

I finally tracked down the source of one bug (not setting the label on
new files properly) and sent a patch for that. Several of the other
failures were introduced by the use of fifos for synchronization;
apparently fifos on NFS aren't expected to work and hence unix_socket
and other tests that rely on those won't work there.

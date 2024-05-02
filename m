Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6891D15FD17
	for <selinux@vger.kernel.org>; Thu,  2 May 2024 19:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714679469; cv=none; b=KQLN2n7wkR6yMuI9V5FHDEySH7g4u/g7fheyXZvku80ZOE4B0XDVuKNvPGWVozyNeDbpF3NhoES4Fr4xl8TYKgU3q694E/ypGWM0VJ9rga7koCuP6mwj50FA1s2etefqCHnHkzqjVaBL2nVOSIuHmIWLhbbDvqHe5AL4pIQ1L0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714679469; c=relaxed/simple;
	bh=E4rCgQ7L5VNfgLMPXgSDb4qd2N3O2il29djqvK5vXyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=re61nLafOX1knoqEL/uRhjFBw1E9Eb2QAqY2xRljd3SpYeVwRmLpNlIUgvje3e3F18g8xsfALSJJI9cCPeD1D/zyLFakbJjwU8BhCcy+QGqcKG2sfd0yDq5uXUHTUXCM58nIMiwGeiXwTYtEfpuFduh+4biCjqlNfLKUivTuEos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNFMdaCK; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNFMdaCK"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce2aada130so5865928a12.1
        for <selinux@vger.kernel.org>; Thu, 02 May 2024 12:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714679466; x=1715284266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pd3IYjvFv7AIksIBgd+vunFjz27XjTImpbv4h8gtuSo=;
        b=XNFMdaCKuk+wW4WDJkE+4xCjjeuEcvtM158351xDpZjdfT6V2eLj6ilOIFLh6r8dMh
         vfgZH2zbRkcOu1ZqIrStQMxZg4oBJUKAbNTFIdYYsUwmpR2I1GHdayk7WbDv6weeooip
         gmFMrA3HUXNx6N+nYUH5aDaV3lThtBwKksU1F1yrQfgJDxe9ckAhueXMS/zdQqk8v+Wo
         By4Ek2CXGFhTNFcl1wocPPxfUcveEIMmmSSW65S1bYnRrbFNjf8Hy94AdAiTky3xX6uX
         s7rKpBO3vALk7eznuZJc0mvoU95aDPIs0HxN85yiFUxi/8uYFxuhqEmEzpC6AdVRse84
         jDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714679466; x=1715284266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pd3IYjvFv7AIksIBgd+vunFjz27XjTImpbv4h8gtuSo=;
        b=FtyxkhLz9+23T9bNAsjaP3PXbLesaQFAnqPnVkx/MS5JzLS2KhmxlrnFXPrlaLHgxa
         kM6I/+S0ILERaIrLMdjUYnJYzFuFKud3Kb0fNIMMjudofmSJT72WnszAR5eorT0R3Mxs
         Z65nY5hPwgEfSP3cd7vTJcnn+8OTMESO9rFpCilqRGo649yVI87h2tk2ibaza8UroZjs
         g8mpiI5OC/g264ybKvFSF+21bYJXTTM9Xy4kS/1/9dU1Ms527ndeY5xRoYbkr7f/5/nG
         04E3IbxIPNcozVgRmnW2el9lQjkNcPdVz7o/8Vt2Zp7W/OpakyaM898QKJjNew91QvbE
         1d2A==
X-Forwarded-Encrypted: i=1; AJvYcCWZ70y3ZEZ7dHD+7lZwA27FJDXJK75dwLxKNeCxFWmB01J4yOm5uSjQMQPz5qkT4QxKKgjAbX06K0sGH+AZIX8Ni/En4uJtoQ==
X-Gm-Message-State: AOJu0Yw5ZnAMl3cWFfqd3ku+5+tjr5gD3XIEkhDdNJWUj8QN9OeMMLKz
	tHLc71hUK7yXdC1NQc1YpFYHbGFUXcWoqwJDdDy/CTqX0w7LUavlF5nVn5IAru35HHRqXpGQmgE
	CH/d0G8Fx/BzerAE4mJZg/IY1wSk=
X-Google-Smtp-Source: AGHT+IEOLPChVY9ApxEJvzrGOJQ2BFB+j3dgsilC8EknoJ+1vtZMFmiUiVq9g5aihkpHE6gxsoJf2tDSoZ7CobfGA70=
X-Received: by 2002:a17:90a:b898:b0:2b1:616f:c1a7 with SMTP id
 o24-20020a17090ab89800b002b1616fc1a7mr781232pjr.32.1714679466604; Thu, 02 May
 2024 12:51:06 -0700 (PDT)
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
 <CAHC9VhRTfUO_b+dfWRNtFBPUCnk5iRCkCfT4PcNBt+b856t-iw@mail.gmail.com>
 <CAFqZXNuqHKAJUdZ-3VL64Be0hp8jPjztk2NaUv4+XFcgUe23CQ@mail.gmail.com> <CAEjxPJ7LJR9Xv7fzPxNYToRniDXAdUo3dqNN5OTVUYyy3ct+dQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7LJR9Xv7fzPxNYToRniDXAdUo3dqNN5OTVUYyy3ct+dQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 2 May 2024 15:50:54 -0400
Message-ID: <CAEjxPJ4YJsKcXQREL9i66-i9fzmsxLwH23eFqMs+pbXuxYK54g@mail.gmail.com>
Subject: Re: selinux-testsuite nfs tests?
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 3:18=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jan 26, 2024 at 5:12=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> >
> > On Thu, Jan 25, 2024 at 5:09=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > On Thu, Jan 25, 2024 at 10:59=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > So as a side-bar is anyone running ./tools/nfs.sh on a regular basi=
s
> > > > or has it been wired up into the automated testing by anyone? If no=
t
> > > > and if we can get it back to a clean state, that would be good to d=
o.
> > >
> > > I am not as part of my kernel-secnext testing, I should, but I haven'=
t
> > > had the time to configure that as part of the test run.  Building and
> > > testing on Debian in addition to Fedora is still higher on my
> > > kernel-secnext todo list, and I haven't made much progress there.
> > >
> > > I believe the IBM/RH folks are doing regular testing, perhaps they
> > > have something in place?
> >
> > We don't currently run the NFS-backed selinux-testsuite,
> > unfortunately. Looking at my unmerged branches, I can see I tried to
> > add it over 2 years ago, but the note I had left for myself says
> > "doesn't work yet due to NFS bug", so presumably it wasn't passing
> > even back then.
>
> I finally tracked down the source of one bug (not setting the label on
> new files properly) and sent a patch for that. Several of the other
> failures were introduced by the use of fifos for synchronization;
> apparently fifos on NFS aren't expected to work and hence unix_socket
> and other tests that rely on those won't work there.

Actually, it seems that I misinterpreted earlier test results. With my
patch applied on top of nfs-next, the entire ./tools/nfs.sh run
passes, including unix_socket and friends. Huzzah! Can we get this
wired up into automated regression testing to keep it that way?

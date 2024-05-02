Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D446415E5B7
	for <selinux@vger.kernel.org>; Thu,  2 May 2024 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714679691; cv=none; b=MDmrqDZK02T449AYGtLvEfHjVuT59eIG2WtF3Pzj3xm8RLFJKfosbrhKSi4Bb/vgz6+8gtOTfW+tQ9kP3eoVXCeQIcNW8DlsLj1dalHuobsnaCsNgwwN53HkCvwIKaO9/Uja9JJWYE4hJmTZadpDRdBNrMq2ft1TepU0B0T4y78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714679691; c=relaxed/simple;
	bh=5pgUpqR3hyRMbHCdQINrSFiOXutWb2+59iVdKx+/xV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLgHyUAx0+349Fb1wyTVJOPahlHFjuJ8zkm0Ex/gKeBDPtmzbd81q8mAPfL2u2VNLVEGbqgiZFU61kpGq+S68kvzbyr2Sq70VCq3YMCiGpHsWckJ+9R1fczDU7VattBASz3NExIcRrvAZzL5ly0QVHRdiTf25Dic682sTDpoBiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWXpeO8S; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWXpeO8S"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b27eec1eb1so2456186a91.0
        for <selinux@vger.kernel.org>; Thu, 02 May 2024 12:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714679689; x=1715284489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCMp38uQSxCX4S+sStXbmQRXGDxX3UcQ8SNQxBc/Qd8=;
        b=VWXpeO8S+rD+jIrWCZMCrrv42zqqPGjpm5UHJug4m4gzmJrUUnrNoaQxOKhF0aFGqH
         qtCuAbHBlade+4yGeJ+jbQdnOgP0gx7k8UIsJi3oHMKFNdOancIz0r9KO9JoCvFIvEKU
         AVoGMwDqBU/hCyc6i+8Bq2JqYCyMP5QDx3H5wTRrPRYlOLvZa8H97sV8SCtXYFBC/km/
         WyGLKh9tc4LcoG1yGCGQdiFVESP8qzmzY1+U3i19fa50mA9dO5eNr7FYkSDzwOBYaIGq
         NxW8Amvhje9EE+UWs+A4jQaXXUQWGtE1/8luvJyWx51PrT2wuLg/D+YIRnQ5fGfKQPF5
         3+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714679689; x=1715284489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCMp38uQSxCX4S+sStXbmQRXGDxX3UcQ8SNQxBc/Qd8=;
        b=cmpVGLOym6cfF3hC6sGTa1F8hzRLCrWrbkbmAZh7V8UoIMrTILF428Kjgtl8uplchj
         W9m2HyXDYdwjkWGIrSmodlaMI2NBIZUKCYcHj/WvKrTvvE6ufyjvZiAdIKkemdAM75lJ
         F0ZhGVuEwOp2ZAComZ4zp4HmcqHayXd1K8Gy76ozn+VOnoVU5D0kY6tQu8LDEKz2CXWw
         I2BW3h7zmF7ZQuKMQLtrstahTkapAWk3b2VXBWalcuihMEoffeIvB1qvVb3cPWAPZ8ZT
         TTn1l0qzl8Duj8voC86QQAPOJy14YNa8qPfJF0YdrYuGToijxwXb3hemi8NMsFMphV/a
         iKyg==
X-Forwarded-Encrypted: i=1; AJvYcCXvj8AMyxEj1DzuNG7evTEe2l14OZuURAHE3M5QdWyjJxt89dgG5UuAIJI2wvCKmTbbbZSE2oqCC6w/3dBi8ozpfMeZexqoSg==
X-Gm-Message-State: AOJu0YxkWnuo0RfhhmWYwVPJDYF8BD39CpAC550FOe/mTyI7om139gB8
	ZaiUJ6j6eDEP9umW41O5BAEgWQMt4wIBp7AubtVzr5WQ0N4rwEIhC6eX264pRUfNokvcLhb9Bqf
	n0FVpxSGy39clNXiPaPReq6DkdKQ=
X-Google-Smtp-Source: AGHT+IE6yLCwyuImq6REs+lcRLS2l0/uW5OxjNSg5/A5rrDmrZVQ03tA9MeIv0sKMLrGAcP+Yz6zl3x5RssrXYSQeKw=
X-Received: by 2002:a17:90a:cb13:b0:2b2:d001:db41 with SMTP id
 z19-20020a17090acb1300b002b2d001db41mr773309pjt.40.1714679688953; Thu, 02 May
 2024 12:54:48 -0700 (PDT)
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
 <CAFqZXNuqHKAJUdZ-3VL64Be0hp8jPjztk2NaUv4+XFcgUe23CQ@mail.gmail.com>
 <CAEjxPJ7LJR9Xv7fzPxNYToRniDXAdUo3dqNN5OTVUYyy3ct+dQ@mail.gmail.com> <CAEjxPJ4YJsKcXQREL9i66-i9fzmsxLwH23eFqMs+pbXuxYK54g@mail.gmail.com>
In-Reply-To: <CAEjxPJ4YJsKcXQREL9i66-i9fzmsxLwH23eFqMs+pbXuxYK54g@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 2 May 2024 15:54:37 -0400
Message-ID: <CAEjxPJ7BD9rHAiCCtf6Dxhxm=1gbVioFLXSbL7fcqXDnvpkbww@mail.gmail.com>
Subject: Re: selinux-testsuite nfs tests?
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 3:50=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, May 2, 2024 at 3:18=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Jan 26, 2024 at 5:12=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > >
> > > On Thu, Jan 25, 2024 at 5:09=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > >
> > > > On Thu, Jan 25, 2024 at 10:59=E2=80=AFAM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > So as a side-bar is anyone running ./tools/nfs.sh on a regular ba=
sis
> > > > > or has it been wired up into the automated testing by anyone? If =
not
> > > > > and if we can get it back to a clean state, that would be good to=
 do.
> > > >
> > > > I am not as part of my kernel-secnext testing, I should, but I have=
n't
> > > > had the time to configure that as part of the test run.  Building a=
nd
> > > > testing on Debian in addition to Fedora is still higher on my
> > > > kernel-secnext todo list, and I haven't made much progress there.
> > > >
> > > > I believe the IBM/RH folks are doing regular testing, perhaps they
> > > > have something in place?
> > >
> > > We don't currently run the NFS-backed selinux-testsuite,
> > > unfortunately. Looking at my unmerged branches, I can see I tried to
> > > add it over 2 years ago, but the note I had left for myself says
> > > "doesn't work yet due to NFS bug", so presumably it wasn't passing
> > > even back then.
> >
> > I finally tracked down the source of one bug (not setting the label on
> > new files properly) and sent a patch for that. Several of the other
> > failures were introduced by the use of fifos for synchronization;
> > apparently fifos on NFS aren't expected to work and hence unix_socket
> > and other tests that rely on those won't work there.
>
> Actually, it seems that I misinterpreted earlier test results. With my
> patch applied on top of nfs-next, the entire ./tools/nfs.sh run
> passes, including unix_socket and friends. Huzzah! Can we get this
> wired up into automated regression testing to keep it that way?

Sorry, sent too soon. It does pass running the entire
selinux-testsuite on a NFS mount with security labeling enabled, but
then starts hitting some failures during the later context mount
tests. Likely bears further investigation.

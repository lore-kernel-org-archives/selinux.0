Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF8D83CDA
	for <selinux@vger.kernel.org>; Thu, 23 May 2024 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716494402; cv=none; b=YPyXmXHXocAuv5JyNykFwgA0UwUX+N4w+OmqfUNjtmvbFjX7tf+jYo529nPiPnDc1Qv3z+BMazNEil+1op0G5NB/dEq+eiV8t6X9MiAuuWtUMg9rO8pHCOikynpg/Wc9qeQCzYFbgyhgDTVkJGpFK/hutDTi2/AgGGJtnnJu+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716494402; c=relaxed/simple;
	bh=RGBYkEp4xaQ+LzXIhS1kTFRY0WISYS9wuwHu1roUNIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rz744f3pBG4KvNmgxZyZIITBWnTNNTd0EJbV65zaxoTHZnC2zEEYij+UZhofWd0fqYO4c16m2t3FXNDefGJWoNANRDbj2sxrbAMKDUZ4f99bLU1phg1NmwNwdQitgAqy62rVtwHzF8MlEh33ge5tYAW9naS/yLEv3VcIq//fKnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dQvEG3ql; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dQvEG3ql"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-df4e1366da6so2531566276.1
        for <selinux@vger.kernel.org>; Thu, 23 May 2024 13:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1716494399; x=1717099199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+hHNb98Lkvnd3filq6+n9WOG+F0hacI7U/zXA4Kod4=;
        b=dQvEG3qlSNz7a9xzktHlVnWD3yR5W7GAuqnVw5e+wh58wvi0Q1x3Gezv1hg/O3w2aJ
         hDHpX7T/2RtuQdcCE9ialp8FZtOPEiPoyHV+bB6dJ5+jGAOzAxrZxXuhaX/MY7Ya15fg
         smw5qqBAdJEpwyAuLjy97zSPAQYUdezZMCIQngmhC2+Bl0gPRMdSmnPfBcgDdesQdSXi
         +4QtkyWLnHxkN4mpSEaKXpHotLPRVkPJZ40GKDClgo0QETPa2eQWWFplynu+X169qmP4
         Z00GPEGywOACLBViRJjikLwAiEtdrtqhXeoXVnRPBZkckpcIwt3+JGqUH7FeFUi4+1jz
         Wo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716494399; x=1717099199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+hHNb98Lkvnd3filq6+n9WOG+F0hacI7U/zXA4Kod4=;
        b=t0A2G1IuzuYzfXM3OwsZ+uT2OEbZQtnflJdc+ZM1v0kJjcH17quQufF4xLo0K4Uvlx
         jkUjb/0BySBCJHkKb9epNjErh1Vx2EWGywgkUIpYmbKD9g10SfYygyFiNb6PYXFTTgke
         MZRpS64JKZBedMR8OwJ4Ke7p4xeVPmzyv1wiUman3MkzqZOT29XWHfi6QhxNKig/iHE5
         7CHRYtAYXou/F+Mx9g0V51Eh54PLEttwbUtCSTItpK7+rMKdWYiHgZGSJqhTAHTBmVpx
         +uyc4ws4I1yBGjVPqhcSILenIQ91Zse4g09wXeBMLpV9iBZGYcMzcJ/nBnRQ1ZlnWIOV
         +Paw==
X-Gm-Message-State: AOJu0YzT4xizcEV86murxbXX/yDx/3CtctdL3ENOkT7xuMxMZ6aTFqug
	kh9oqoJSk0Xpp3mwQx+5hRiPV0bRkE7obhi4wwnoNZnt9jrm4kM1DdB7nqeDkG+TypK4Jhe83VS
	ZaT5gsT/YxtWChWtf6o5K1w4pdtvL2H4tAWob
X-Google-Smtp-Source: AGHT+IFrygnslz8dw8I5ujRelqytsd+MfQtkqFoPdsIZ3KJ0A3TbSG/L8ei3XWLr8fKsgxqR/BTezcDT+Wy3xXa3rys=
X-Received: by 2002:a5b:42:0:b0:dee:5ff0:e91f with SMTP id 3f1490d57ef6-df7721ad3f1mr278273276.30.1716494399458;
 Thu, 23 May 2024 12:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506174948.26314-1-stephen.smalley.work@gmail.com>
 <20240506174948.26314-2-stephen.smalley.work@gmail.com> <CAEjxPJ6dsy-E98gmfGioYa8aVEZGLC230ZNVyCZL7f9=5Ev35g@mail.gmail.com>
 <CAEjxPJ78Ak9Nc1Mgc=6=4bYcp48AxgCSjcHC+iaeag2ME6G75Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ78Ak9Nc1Mgc=6=4bYcp48AxgCSjcHC+iaeag2ME6G75Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 May 2024 15:59:48 -0400
Message-ID: <CAHC9VhRfnc5aV1UCEYHfZVw9K69SwNDHHVfJ=5-Znx87QX4-6A@mail.gmail.com>
Subject: Re: [PATCH 2/2 testsuite] tools/nfs.sh: comment out the fscontext=
 tests for now
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 8:59=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, May 15, 2024 at 10:54=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, May 6, 2024 at 1:51=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > These tests currently fail on mount(2) calls due to the directory bei=
ng
> > > unlabeled at the point where search access is checked. Until we can r=
esolve
> > > the underlying issue, comment out these tests to allow the NFS tests =
to
> > > be run.
> >
> > With these two patches, I can run the nfs.sh script to completion with
> > all tests passing on not only the latest kernel w/ the fix but also
> > Linux v5.14 with no changes. So it is unclear to me that the tests
> > being disabled by these two patches ever worked...
>
> Last call - any objections to me applying these two patches?

Do we have any hope of resolving the issues anytime soon?  It might be
nice to see an in-depth discussion/brain-dump of the issues in the
commit description so that someone looking at this at a later date has
some hope of understanding the problem.

--=20
paul-moore.com

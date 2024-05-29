Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E011F941
	for <selinux@vger.kernel.org>; Wed, 29 May 2024 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991647; cv=none; b=FbitsckYWsKKel4M+rlRh0RO0mIJFHn5K63sqYS9RKNimGnQ9e5u17RVXdZohG3i+hov8ulMjZdCERdZfLMrwu7KxUjkrGtLOwi7wfAxopRyvlcrRMl9lfObJdHaCPDmoz5KPgMUW0AKVAja5Re12geJ7h6IDgi1eMbqpz/0HbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991647; c=relaxed/simple;
	bh=jDLFPpmRRkzYzZHXr2J62/fh27zSqywqOqwws92TpQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gdrt1wo8gufhExBJ5h+wxutI5Vn590TV1RvxBD9lzypY/A9R9uAkQ0MoVU6rWU0cWzNLst68mfEuOMJle5ZnocQKdL7C72rmx/MVlx3j6bClStVRKPTyqK2yEQA/6vxQxWsp2ZsrpEvkaBrNm/z0eE9WQ0xO4j3TQa0WR++5z5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsbMMt8u; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsbMMt8u"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7022bfbb329so6030b3a.0
        for <selinux@vger.kernel.org>; Wed, 29 May 2024 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716991645; x=1717596445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PP1lpviTHKL7YKeaPCZbXkvqirK7AwEM/TpLx4nqnM=;
        b=CsbMMt8uMBZGkVVIqf3fkgEHA9Z1vq59rEMojlg2D+yNTuwDPUkNb3fr7TReFX4RSG
         P332pVTqbHLk4/lEay2/OCmMDm6LXmE//t45m4BRfX4TkX5jKRmgogDyWScglCXXC1X0
         tCPgzatTKnTcbB5iG03ngFSdBfHoSDbHnoTxxpN5hVkZPyay8B0errFVKV5JSHufAYB3
         Dj6YMICsrvXFjEfcDkQ0+WsNhQGU8hKYekcphKZiwSdd01uBFDmfNo30UI8zEO5XuKAw
         WWPz0cL9fIF9Rl1C1+rrA+uDKFl79vts/1E/eSlp9K8EK0xUezDE4huCJkiN4jpBbyld
         /n8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716991645; x=1717596445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PP1lpviTHKL7YKeaPCZbXkvqirK7AwEM/TpLx4nqnM=;
        b=OIYXM2zDJ0SmTmf2BXfkS7nEECJStD7OxmvLT83dTy/v9Vdw2YaxnrYJnH6SjwkriU
         Qw1QYrULjrpEeevy73WnF22CCpobiglmHM7GbcMqWSILj0htS6zg9hG59WBJxGcpl9OP
         eubOa52DE5ZMWoLJ2uVslACEvvkIg3XA04w44CI+djLHhAbfMOQswtHoR/keyvqnlFTY
         9ADFpepOPSjiZJfEANZJU0py3DAYXlCf4WWmF5PQJrjF0EXtbRzHAENx1A3KVDz0RsW5
         8EHh75TNhiZje3zPOmHEwmdeiG4riHX5qMmJDyuX+cFJGsAro6diofvHz6x4s3MGNeFU
         9/XQ==
X-Gm-Message-State: AOJu0Yzav4awKAIvAOAnVgowicdmofcHv2O0eFrEgLoCtLu1lMipN5ir
	2d7r0vvZHDmPaYt/Xk+k1d2tr6u29/3qr8zvgbeC/YpMTqonnrsRvAPO0IKtX06ts6CjCRYYqzG
	u3TvqDJXv7PNUIZvVgYNGf2VdGywIJO0o
X-Google-Smtp-Source: AGHT+IGDXEJb3+tl50ZffATL7Ibiva8Awy9Qle1UjDXztfc7OXZCoh7YidKJpXqseMZt7D2BS27MeiGRqOvZMIVfWPY=
X-Received: by 2002:a17:90a:db03:b0:2bf:82ad:6b26 with SMTP id
 98e67ed59e1d1-2c02ec3f60amr3298848a91.17.1716991644711; Wed, 29 May 2024
 07:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506174948.26314-1-stephen.smalley.work@gmail.com>
 <20240506174948.26314-2-stephen.smalley.work@gmail.com> <CAEjxPJ6dsy-E98gmfGioYa8aVEZGLC230ZNVyCZL7f9=5Ev35g@mail.gmail.com>
 <CAEjxPJ78Ak9Nc1Mgc=6=4bYcp48AxgCSjcHC+iaeag2ME6G75Q@mail.gmail.com>
 <CAHC9VhRfnc5aV1UCEYHfZVw9K69SwNDHHVfJ=5-Znx87QX4-6A@mail.gmail.com>
 <CAEjxPJ5cXmbbmUGuFM=rhd83sO11Kpk_Cjz77HZBu+ePXaeLFg@mail.gmail.com> <CAEjxPJ6HoSvB-rL55wOXPuJ0P33Rci-AznbQ_tg8aMAn=st8CA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6HoSvB-rL55wOXPuJ0P33Rci-AznbQ_tg8aMAn=st8CA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 May 2024 10:07:12 -0400
Message-ID: <CAEjxPJ5QmNZwSgSBAATq+0poqeVbLSxYwENGTvXnhikjQZ-mKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 testsuite] tools/nfs.sh: comment out the fscontext=
 tests for now
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 10:46=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, May 24, 2024 at 8:24=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, May 23, 2024 at 4:00=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > On Thu, May 23, 2024 at 8:59=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > On Wed, May 15, 2024 at 10:54=E2=80=AFAM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > On Mon, May 6, 2024 at 1:51=E2=80=AFPM Stephen Smalley
> > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > >
> > > > > > These tests currently fail on mount(2) calls due to the directo=
ry being
> > > > > > unlabeled at the point where search access is checked. Until we=
 can resolve
> > > > > > the underlying issue, comment out these tests to allow the NFS =
tests to
> > > > > > be run.
> > > > >
> > > > > With these two patches, I can run the nfs.sh script to completion=
 with
> > > > > all tests passing on not only the latest kernel w/ the fix but al=
so
> > > > > Linux v5.14 with no changes. So it is unclear to me that the test=
s
> > > > > being disabled by these two patches ever worked...
> > > >
> > > > Last call - any objections to me applying these two patches?
> > >
> > > Do we have any hope of resolving the issues anytime soon?  It might b=
e
> > > nice to see an in-depth discussion/brain-dump of the issues in the
> > > commit description so that someone looking at this at a later date ha=
s
> > > some hope of understanding the problem.
> >
> > I already put what I knew into the commit messages, unless I missed som=
ething.
> > I am not sure the tests I am commenting out ever worked, and Ondrej
> > said earlier that he never enabled the NFS tests as part of his
> > automated testing because they still weren't working fully last he
> > tried. Meanwhile, we've had two separate regressions in labeled NFS
> > since that time, one from Neil Brown's patches and one from Ondrej's
> > patches, and only just discovered the one long after it was
> > introduced. Hence, to me the value of getting the tests running so we
> > can turn them on in automated testing far outweighs any benefit we get
> > from retaining these tests that may have never worked at all.
>
> Also, FWIW, with these two patches applied to the testsuite, current
> linus/master passes all remaining NFS tests.

Sent a v2 of the patches with further details and output included.

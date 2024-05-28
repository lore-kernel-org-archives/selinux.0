Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B396716D4D0
	for <selinux@vger.kernel.org>; Tue, 28 May 2024 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907607; cv=none; b=B/9eCLfJGEafZ5SKbrlU6rz9husMfw5tnI5UL+gQRwypXCK46Fa4jT0qXoO7O3Kj9UhT0gHUpQeC2y9BgEST0EGaNBEoJsiaFyTi83/+seg2o+/EqEceFFBk942a3vzrHAtfMkDLsBrIf9+r2YtsXqEDzxyFJUpOxT7zN9Kk6es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907607; c=relaxed/simple;
	bh=lMBMtqYnISfl/1/LgQnaoH7oWjt5B2VJXUZ+vcMX3vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BtfaYvh5mQXABoGbbNtzluyDjqidDrdVPHfx2+MxFg2njR7tBYQUt9ZeCvLDt4nGLXFUwpx8UUhViKPXUPsB2suA0OuXreQICM+fbjd6K7yYg8OCTZnguKov99TSsjj9ak9JyeFj1BDFOn2r206uuOmPy0/8FXL4psD2cM//+uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfE1WJXL; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfE1WJXL"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6818811cb8aso601518a12.0
        for <selinux@vger.kernel.org>; Tue, 28 May 2024 07:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716907605; x=1717512405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=016AUnP8pJ8Ej44ZDrPDkGF7KdxOeenV5eHAYCbwf2M=;
        b=CfE1WJXL409djX0nzF+pVaNFUIblUzpaoIOUl1NX/svIdwdncpSk/EQKJWJMyGmnvz
         ajTI4vZvJebFgBnMJ05+ZNqNbQQLIgQYm8yrxkNpbXV9hMlsBSalBhHnrMlpIrr6R+tX
         SK7ebWIIEXk4JD07xfhQ8a8nwfted6QFav2F37fVaBXhMONw44F9tUGCeyLanfBpP7BE
         krIhQsh18i9Z3mh5aLOoiw1zxHozeCincndp+nyV8k3h8JoTFHA7FxKkS5jvvIAExEhw
         4zdIf/tjpHupE+ecghWEyrgHfEOjNm5KMXdjx9B2IJJp74yr3MqBlTRv4Zlzy2yaA38c
         UWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716907605; x=1717512405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=016AUnP8pJ8Ej44ZDrPDkGF7KdxOeenV5eHAYCbwf2M=;
        b=oY3KdLRmG5GVDwGyOQxHevuQHiY0P54DW1EmycQqw74wZAk8vG5cJS91w5zJbKoHB/
         L+WU36USg3TnCAwEMTYxWqlhEl13y87frJ4+o0WXZs2zl2FTjQV57CiiPre0apgRFI3q
         jSweMQ51gykxM59UdQy0GUMfj2tzS+xyG45vTp4JEvailccof2TFtIvzTfDrNUMiJnqs
         RfBGrL1C3qzLZTSZy6YTiWmrFj8+PK2C00+3OnkPvJNtxesUzsjWAxAwIJ2aCEKs6kFS
         5RYjypZ1dH7DWtlQfNuQG9QsZ8xv1F0/dAuzwXiHuV7gHzLIsnkbGUwtjO5qH8v7vMVQ
         ZarA==
X-Gm-Message-State: AOJu0YzX6VkbYPAcp+HSP/B6pv10QqoUKrZJMNKKJ/bxt+k5rz5tLD+s
	KaKgjdOfxou9ixe7p4uLuh4r8pL+0b9LcpbFLlPz9atJbFT2w4mzDnCh0VimMt4z9XfO0IFSr1w
	fEXsYAmn8hejTM9d0Tz0+WC+S7Iw=
X-Google-Smtp-Source: AGHT+IEPDkNv83ca2jKneTCrey3Tl8VO2tjiIRv8K9hulokpt3tjMeVJgAuT7NfZ4Kfcx4hw6rzCc88OLl4YGVTGDz4=
X-Received: by 2002:a17:90b:4b4e:b0:2be:b9:da18 with SMTP id
 98e67ed59e1d1-2bf5e13707cmr11663584a91.2.1716907604806; Tue, 28 May 2024
 07:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506174948.26314-1-stephen.smalley.work@gmail.com>
 <20240506174948.26314-2-stephen.smalley.work@gmail.com> <CAEjxPJ6dsy-E98gmfGioYa8aVEZGLC230ZNVyCZL7f9=5Ev35g@mail.gmail.com>
 <CAEjxPJ78Ak9Nc1Mgc=6=4bYcp48AxgCSjcHC+iaeag2ME6G75Q@mail.gmail.com>
 <CAHC9VhRfnc5aV1UCEYHfZVw9K69SwNDHHVfJ=5-Znx87QX4-6A@mail.gmail.com> <CAEjxPJ5cXmbbmUGuFM=rhd83sO11Kpk_Cjz77HZBu+ePXaeLFg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5cXmbbmUGuFM=rhd83sO11Kpk_Cjz77HZBu+ePXaeLFg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 28 May 2024 10:46:32 -0400
Message-ID: <CAEjxPJ6HoSvB-rL55wOXPuJ0P33Rci-AznbQ_tg8aMAn=st8CA@mail.gmail.com>
Subject: Re: [PATCH 2/2 testsuite] tools/nfs.sh: comment out the fscontext=
 tests for now
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 8:24=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, May 23, 2024 at 4:00=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Thu, May 23, 2024 at 8:59=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Wed, May 15, 2024 at 10:54=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Mon, May 6, 2024 at 1:51=E2=80=AFPM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > These tests currently fail on mount(2) calls due to the directory=
 being
> > > > > unlabeled at the point where search access is checked. Until we c=
an resolve
> > > > > the underlying issue, comment out these tests to allow the NFS te=
sts to
> > > > > be run.
> > > >
> > > > With these two patches, I can run the nfs.sh script to completion w=
ith
> > > > all tests passing on not only the latest kernel w/ the fix but also
> > > > Linux v5.14 with no changes. So it is unclear to me that the tests
> > > > being disabled by these two patches ever worked...
> > >
> > > Last call - any objections to me applying these two patches?
> >
> > Do we have any hope of resolving the issues anytime soon?  It might be
> > nice to see an in-depth discussion/brain-dump of the issues in the
> > commit description so that someone looking at this at a later date has
> > some hope of understanding the problem.
>
> I already put what I knew into the commit messages, unless I missed somet=
hing.
> I am not sure the tests I am commenting out ever worked, and Ondrej
> said earlier that he never enabled the NFS tests as part of his
> automated testing because they still weren't working fully last he
> tried. Meanwhile, we've had two separate regressions in labeled NFS
> since that time, one from Neil Brown's patches and one from Ondrej's
> patches, and only just discovered the one long after it was
> introduced. Hence, to me the value of getting the tests running so we
> can turn them on in automated testing far outweighs any benefit we get
> from retaining these tests that may have never worked at all.

Also, FWIW, with these two patches applied to the testsuite, current
linus/master passes all remaining NFS tests.

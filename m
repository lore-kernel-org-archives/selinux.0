Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA61E14A4D1
	for <selinux@vger.kernel.org>; Thu, 23 May 2024 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469173; cv=none; b=SjM/TyI5dksDEY1yj+0W6wYtIzRSTxMI3+Q4VUjk+K/ivEZ4B8u1atAgKDTCem7BDnM4cTE9fkRAMJGSlQAQWnnjwLRd2VrmfNmC69XdG5ETiI6dscPI+t1nSt2170VWgHQ/Rk8AZ5xN3K09mVmPDYHLKq8DBYxbMnOJYtpA3N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469173; c=relaxed/simple;
	bh=HlH9Uov7/RKbim2C7RfU1l63LBUoOUn2zBXMiygVTko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+2R7nJOSyclRCLkjnfvQRrwjlv0at0LzCmTSVtSIrCUY/pYxTulHoUzvHEytjEascZbZ5J+4mPJPWuJjRsHFxJririKVuOKY21LwqDMty8FHR4LLAncr9GqTlmLFD7L9LrMxZX9gbIaimXwl3Ft6PsU0DtEkshV6iHRjgJfxtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjhmTPHc; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjhmTPHc"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-67af6c66159so680744a12.1
        for <selinux@vger.kernel.org>; Thu, 23 May 2024 05:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716469171; x=1717073971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvbO77ASLyR8cLOVcq6znc2C+ckXLvfooUriIysuIPc=;
        b=SjhmTPHcY2gM4vKUIGviLyJ5t3ec9RaLIYTrwuZIXj68vGKnb6WI8bwo3lYU+1guES
         t3k7UELnlB1QDK+UiASBvxzpoUrfOWRp9190M95zfdiuVrXdUy1ZUsY9pU54uZdYHuf6
         38RB7FKOhgY8CEQzslN1zMQo0lGlXeTfyx3wNbnFVs5eXLHt6Brusoti600ngcCPfkfp
         A+isVoTYQbi0PK0JL10gNKlBJosKFUwjbJqqYBsuBWd3cG6SDq43UAWIAAWlt/vn8Blb
         LKljXeU7SWlM93meDmcb6ZEmDX0WNglqS551VamVBj+9bVC7+Meo6DJC4I1DOmsTU/Lf
         HWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716469171; x=1717073971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvbO77ASLyR8cLOVcq6znc2C+ckXLvfooUriIysuIPc=;
        b=f5jEcky13/A9tpUKWgNlxBcrFqN7kFcygCMYsMi6fGz8i+7tmgyXgyyGuOZ71lh6YD
         RggU1bkLvbrpcXIgon1lfdHCcjZCvJtS9gVFJnwErH9jg2aVZiukqaycGWVkR5tSY+B8
         2ZTOBlviFxSyalaJtIxY2LvGFmE/1oF4RZ3C0Vsd8DsiNVMQe1D7gVo8sXWVg0GNQtX8
         BMPCeNTMtro65ZFBDNrYzv0C+KD/tx8z+QU/QK5AG5Mi5lNNhX1pDlsSzC5DkOaXrFer
         3ompNEQ4uoQSEM/H53Laf1NC5l884mwuFd+RnhUiZGMzH6qtOSIzIXYisL3/zSaE+ydN
         ZIBA==
X-Gm-Message-State: AOJu0Yy/EHenXVizUWBwP3TJIYjDjT2oVd9Dw7ViidszkOex78adFoGx
	msfa3eqgzArysiFezXAfOzxGLTiW8WAhuC4+/BPkU/HgGHKcm2Gr5mIj8lNJiVZsNFxSgIEkrK1
	blkN1eVnkxl/3OmwtktADLBVE6my1tw==
X-Google-Smtp-Source: AGHT+IE2cWQvOSz8P9eacrGEBnrA9LdGsPX9nseBPt4aE2Iz8jCgtR3KwwBo4myMPyqgrBmdPevo0aYzV/NLf5snUOY=
X-Received: by 2002:a17:90a:740f:b0:2a4:79ef:4973 with SMTP id
 98e67ed59e1d1-2bddce8fb0bmr3118356a91.14.1716469170628; Thu, 23 May 2024
 05:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506174948.26314-1-stephen.smalley.work@gmail.com>
 <20240506174948.26314-2-stephen.smalley.work@gmail.com> <CAEjxPJ6dsy-E98gmfGioYa8aVEZGLC230ZNVyCZL7f9=5Ev35g@mail.gmail.com>
In-Reply-To: <CAEjxPJ6dsy-E98gmfGioYa8aVEZGLC230ZNVyCZL7f9=5Ev35g@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 23 May 2024 08:59:18 -0400
Message-ID: <CAEjxPJ78Ak9Nc1Mgc=6=4bYcp48AxgCSjcHC+iaeag2ME6G75Q@mail.gmail.com>
Subject: Re: [PATCH 2/2 testsuite] tools/nfs.sh: comment out the fscontext=
 tests for now
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 10:54=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, May 6, 2024 at 1:51=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > These tests currently fail on mount(2) calls due to the directory being
> > unlabeled at the point where search access is checked. Until we can res=
olve
> > the underlying issue, comment out these tests to allow the NFS tests to
> > be run.
>
> With these two patches, I can run the nfs.sh script to completion with
> all tests passing on not only the latest kernel w/ the fix but also
> Linux v5.14 with no changes. So it is unclear to me that the tests
> being disabled by these two patches ever worked...

Last call - any objections to me applying these two patches?

>
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  tools/nfs.sh | 40 ++++++++++++++++++++--------------------
> >  1 file changed, 20 insertions(+), 20 deletions(-)
> >
> > diff --git a/tools/nfs.sh b/tools/nfs.sh
> > index cf4912c..688903e 100755
> > --- a/tools/nfs.sh
> > +++ b/tools/nfs.sh
> > @@ -77,27 +77,27 @@ POPD=3D0
> >  popd >/dev/null 2>&1
> >  umount /mnt/selinux-testsuite
> >  #
> > -echo -e "Run 'filesystem' tests with mount context option:\n\t$FS_CTX"
> > -mount -t nfs -o vers=3D4.2,$FS_CTX localhost:$TESTDIR /mnt/selinux-tes=
tsuite
> > -pushd /mnt/selinux-testsuite >/dev/null 2>&1
> > -POPD=3D1
> > -cd tests
> > -./nfsruntests.pl filesystem/test
> > -cd ../
> > -POPD=3D0
> > -popd >/dev/null 2>&1
> > -umount /mnt/selinux-testsuite
> > +#echo -e "Run 'filesystem' tests with mount context option:\n\t$FS_CTX=
"
> > +#mount -t nfs -o vers=3D4.2,$FS_CTX localhost:$TESTDIR /mnt/selinux-te=
stsuite
> > +#pushd /mnt/selinux-testsuite >/dev/null 2>&1
> > +#POPD=3D1
> > +#cd tests
> > +#./nfsruntests.pl filesystem/test
> > +#cd ../
> > +#POPD=3D0
> > +#popd >/dev/null 2>&1
> > +#umount /mnt/selinux-testsuite
> >  #
> > -echo -e "Run 'fs_filesystem' tests with mount context option:\n\t$FS_C=
TX"
> > -mount -t nfs -o vers=3D4.2,$FS_CTX localhost:$TESTDIR /mnt/selinux-tes=
tsuite
> > -pushd /mnt/selinux-testsuite >/dev/null 2>&1
> > -POPD=3D1
> > -cd tests
> > -./nfsruntests.pl fs_filesystem/test
> > -cd ../
> > -POPD=3D0
> > -popd >/dev/null 2>&1
> > -umount /mnt/selinux-testsuite
> > +#echo -e "Run 'fs_filesystem' tests with mount context option:\n\t$FS_=
CTX"
> > +#mount -t nfs -o vers=3D4.2,$FS_CTX localhost:$TESTDIR /mnt/selinux-te=
stsuite
> > +#pushd /mnt/selinux-testsuite >/dev/null 2>&1
> > +#POPD=3D1
> > +#cd tests
> > +#./nfsruntests.pl fs_filesystem/test
> > +#cd ../
> > +#POPD=3D0
> > +#popd >/dev/null 2>&1
> > +#umount /mnt/selinux-testsuite
> >  #
> >  echo "Run NFS context specific tests"
> >  cd tests
> > --

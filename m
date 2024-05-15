Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EE015573B
	for <selinux@vger.kernel.org>; Wed, 15 May 2024 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715784902; cv=none; b=JGxEL5+DCkila+xgubpPi8V5iCWogg9Qsys7cJBV6lTVAwPbZAJ0DROp/QaIYD2aNAChFn9NcOG1RDxiQ0TEhqxnEHiE0kD0Hm12SmD43Bp/xtgibI5BxvrBBPMSblQA8HuVIvYnDP4jTEA5RyvHYem1R5AaszekyCc8N4Je9GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715784902; c=relaxed/simple;
	bh=SpqZH8oLApqAkwFG0KeVMt8fgv3XUuoCN/Npf2FPpV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pqHIdGVAJ9g+BNQNyOCwqnON4/NkAC15yAitMYxKDT3kPI+y8pCZmlERWZtWlAZbB5hJ/n0i7/VBTO2TIvG3x7Favwra/riIYhSQH+6MzJNfz7fRZn3h73QRRU/eMOaoHw3L+4rUXjK1AmDhlLiUGC7f1MTKBh7CpRSZHeRi/QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMpDkrLM; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMpDkrLM"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6123726725eso5565657a12.3
        for <selinux@vger.kernel.org>; Wed, 15 May 2024 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715784900; x=1716389700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCZ+dLKJBmzrInnK2GAj0dcoB93GbxOAncGE+URNsJo=;
        b=fMpDkrLMSCBfcm5Hs3F4RWpqKvM9LW267JnivGYcZrEVo4hXVTOLRPR57nVJ4Y5FHc
         ZgSuoOWbGXDd8UeXbpNS5H+yZ9OujKfKHA6elPY0FRmb/6+eseKUA/C4ymfVgVq5q7cc
         fuA8E0hMP2RkJ9yBilg9DQ3Yrp+hkGH9BPQkqYXZnc0052KxHC2XAariv3aurNFFmHzx
         BDsWYR6fmvH+EJmGq6Gv3GMUc9t3cHxDunKAl2+V1iWk9GsBtkFWMOJQGOrYRExNo6FF
         Bg3ZoNZJxDO7stbfAilF8z4l6qniOIeAVmraJPrqccwx6ZNJWyI7z25fAbcxKX6gXhLK
         1EOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715784900; x=1716389700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCZ+dLKJBmzrInnK2GAj0dcoB93GbxOAncGE+URNsJo=;
        b=C27NihjlzK3OwFQhm+hxsDqqGU4mVpyroVd3GfLj8Sz3T3rZePekQPB9vAD54R/fvC
         XIaeBaMAwHx4WJcGUh1J16tfIyK9USK92MoG+v0GzS4IbfbgYKMNcFg01taPHgxYQ/hg
         kdO5RG3fAouEj0NEBnhm/7KBpxZzp03bi18ZWQmh5KY4rJyx5qKrihaksUWS9y+ceNdT
         uSapVSYVidZFeQIL5ExsUKYUZBtAbQuzafZ6Awrvt1b4NPaEk+5lKbVt2kiR6g6OFgFQ
         HHBhLpnrC3ZvcJe3JfaxQ5TGpbs0bjARTp8RinwiwcaFi6oN4Q2nI0E+q6tRrdSsMJml
         9FHg==
X-Gm-Message-State: AOJu0YwPs9cwjTEuSFgJb9BWrsB4/nYbiGkefwFWSHuNRjm1iByd7Cc+
	5lSJOYgTzppezFfHf8ldvCjlRgqmmJV2mVwLPAIXiKm7HkCkyyirYDoyibYZ+kCD33+iwB51FYx
	xoreBBHFUhuu4DeTlSmYgUfzNkRSKEg==
X-Google-Smtp-Source: AGHT+IEVTGRdb+9RCnVE/7PAoxWTDokYVrH6Sv3U0R1MSmKLQqf2JvVQbLznXK6++FkafyM6JrAVkFKJdEpYjFIfObE=
X-Received: by 2002:a17:90a:db0d:b0:2b2:b02d:3ffd with SMTP id
 98e67ed59e1d1-2b6cc44fa69mr13298207a91.15.1715784899934; Wed, 15 May 2024
 07:54:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506174948.26314-1-stephen.smalley.work@gmail.com> <20240506174948.26314-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20240506174948.26314-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 15 May 2024 10:54:48 -0400
Message-ID: <CAEjxPJ6dsy-E98gmfGioYa8aVEZGLC230ZNVyCZL7f9=5Ev35g@mail.gmail.com>
Subject: Re: [PATCH 2/2 testsuite] tools/nfs.sh: comment out the fscontext=
 tests for now
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 1:51=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> These tests currently fail on mount(2) calls due to the directory being
> unlabeled at the point where search access is checked. Until we can resol=
ve
> the underlying issue, comment out these tests to allow the NFS tests to
> be run.

With these two patches, I can run the nfs.sh script to completion with
all tests passing on not only the latest kernel w/ the fix but also
Linux v5.14 with no changes. So it is unclear to me that the tests
being disabled by these two patches ever worked...

>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  tools/nfs.sh | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/tools/nfs.sh b/tools/nfs.sh
> index cf4912c..688903e 100755
> --- a/tools/nfs.sh
> +++ b/tools/nfs.sh
> @@ -77,27 +77,27 @@ POPD=3D0
>  popd >/dev/null 2>&1
>  umount /mnt/selinux-testsuite
>  #
> -echo -e "Run 'filesystem' tests with mount context option:\n\t$FS_CTX"
> -mount -t nfs -o vers=3D4.2,$FS_CTX localhost:$TESTDIR /mnt/selinux-tests=
uite
> -pushd /mnt/selinux-testsuite >/dev/null 2>&1
> -POPD=3D1
> -cd tests
> -./nfsruntests.pl filesystem/test
> -cd ../
> -POPD=3D0
> -popd >/dev/null 2>&1
> -umount /mnt/selinux-testsuite
> +#echo -e "Run 'filesystem' tests with mount context option:\n\t$FS_CTX"
> +#mount -t nfs -o vers=3D4.2,$FS_CTX localhost:$TESTDIR /mnt/selinux-test=
suite
> +#pushd /mnt/selinux-testsuite >/dev/null 2>&1
> +#POPD=3D1
> +#cd tests
> +#./nfsruntests.pl filesystem/test
> +#cd ../
> +#POPD=3D0
> +#popd >/dev/null 2>&1
> +#umount /mnt/selinux-testsuite
>  #
> -echo -e "Run 'fs_filesystem' tests with mount context option:\n\t$FS_CTX=
"
> -mount -t nfs -o vers=3D4.2,$FS_CTX localhost:$TESTDIR /mnt/selinux-tests=
uite
> -pushd /mnt/selinux-testsuite >/dev/null 2>&1
> -POPD=3D1
> -cd tests
> -./nfsruntests.pl fs_filesystem/test
> -cd ../
> -POPD=3D0
> -popd >/dev/null 2>&1
> -umount /mnt/selinux-testsuite
> +#echo -e "Run 'fs_filesystem' tests with mount context option:\n\t$FS_CT=
X"
> +#mount -t nfs -o vers=3D4.2,$FS_CTX localhost:$TESTDIR /mnt/selinux-test=
suite
> +#pushd /mnt/selinux-testsuite >/dev/null 2>&1
> +#POPD=3D1
> +#cd tests
> +#./nfsruntests.pl fs_filesystem/test
> +#cd ../
> +#POPD=3D0
> +#popd >/dev/null 2>&1
> +#umount /mnt/selinux-testsuite
>  #
>  echo "Run NFS context specific tests"
>  cd tests
> --
> 2.40.1
>

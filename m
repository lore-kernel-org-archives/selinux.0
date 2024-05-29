Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E413B1802A9
	for <selinux@vger.kernel.org>; Wed, 29 May 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716996471; cv=none; b=b8UKVwsGKKfDZZRu6Sg/+F082CFpnrduJdKxavRfyO4SzyJOJXFlgys/NkKjVlt/+G3IhNep2Jjnw7R39XVgugZv+udCV5PqieqAUMH3uvp6GccHvE/6S6qX9Zdssyt/Slc/5ejMminZ/UqYj2xJGhKDqNwGXqOLovFF7gah5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716996471; c=relaxed/simple;
	bh=UUW4+0wvVB2LDR1bG15czR/5xx95FwrGhHz6dBii0VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6LS+VmVcVxGGVFaY6Af4t8heAEqb3VaO0pdpGGsKlDx14SYuPHhRVM76ou9a4iHBk4NQRlQ6ehS0UTZpS/nB1tdG8fsYiu1FIYmsv7Dq8yx5ufh2VXvqk2Sc1Yp9c/aNwMvJpqQgXY05qyuU8pxhv1Av2ckgZ94hsloiul+DW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CBgns8K6; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CBgns8K6"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-627f46fbe14so21816447b3.2
        for <selinux@vger.kernel.org>; Wed, 29 May 2024 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1716996469; x=1717601269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sa4vNqBoVU730hQix2lZU/lCroSRSoNM9vswKWGLcA4=;
        b=CBgns8K6bMJm/YILf51IqiDc3SWM8Dwvn5qUHaDIXeO0S4P9dPdJbKOZA0dxUC4WI9
         OHwl+4BgV1+JsYLmVBDSPOig4fcXoESZ1a+1OIV2DCfa/IyNKpRhNKR+sRaTr0XXwoQE
         SCoBOQsLrRXvgxgwnRPmolLxZh6MbvL/tUa2Ekc/O4TiyYQ5fNo26GvD+ft/jly5p2rJ
         ixCU1VYXrl3wHVtVo3u/SK0XlhK6jBbi49eCRTKll0DtGzXCAaPXoauwhiqBR2ouAkEV
         /ttKLJQwB/f3lOBOAkDVGrsgZdRGoXB28kx+NAOqo4W/560MsTCmJd5nPhB8Mhg8Uye6
         pmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716996469; x=1717601269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sa4vNqBoVU730hQix2lZU/lCroSRSoNM9vswKWGLcA4=;
        b=m+ufSFzI2ka+Mvkq7hHoKAwEi9C4T7R4nKup/5qrrRZHnBpe+HjscjUUoWMIg3RAoG
         rSQDw1ZGYCbfnp898vZCg0B9h3OwTVGhBkUYPrMwA6gBKRjrTUmBaH2XJ+5NLeOqaWi7
         B/5DlrTz1466LiQ6l7lwZrFuuEuikKb+QNGMkI2vN5FpwWRYQglDG7fA3KGgpcc1RtSG
         MqNOWvfBArTeb1gA6hGCOPTuKcIwDBoodQ9E6aa3FjbY+zk6ASTG5eiSHPySzG6L5OIC
         lMoygDLjybnJ+nPtPHF78oRiMXBvI10B23Dh4skt1nERMMFKiDuoJLwYBTNkxWohfLUX
         FVvQ==
X-Gm-Message-State: AOJu0YwLgYrzMfKpOz6d9sWBUTeLBMMeB8tDT2Ig/DtH/p6hc2PuzDow
	U30Kv1mtH8yQgMadm34FDaRiMegzYU1b3R5r0BwcJrWzj0kMLLknl1pVI5hoh71kt0FJaF5YFPT
	Ds3KQYH02jvYNx6lVkRIqakO7W5KOlG6B1CDb
X-Google-Smtp-Source: AGHT+IGTn4BbuBPxJ07KkSLJSgavwOD3BzhHJtve/AlbV67lQBq2ME2PC9eFEBfyNpu2V2I2cgUab/kL52/7HeBpezU=
X-Received: by 2002:a0d:eacb:0:b0:615:a86:f77b with SMTP id
 00721157ae682-62a08de0788mr146553037b3.26.1716996465951; Wed, 29 May 2024
 08:27:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529140306.6663-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20240529140306.6663-1-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 May 2024 11:27:36 -0400
Message-ID: <CAHC9VhRFSbkvpaGioW2o=FTXRDMvUbmBAoRif_R-9mX5Ns3o9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tools/nfs.sh: comment out the fscontext= tests for now
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 10:04=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> These tests currently fail on mount(2) calls due to the directory being
> unlabeled at the point where search access is checked. Until we can resol=
ve
> the underlying issue, comment out these tests to allow the NFS tests to
> be run. It is unclear that these tests ever passed and retaining them
> prevents enabling the NFS tests in automated testing.
>
> Before:
> Run 'filesystem' tests with mount context option:
>         fscontext=3Dsystem_u:object_r:test_filesystem_file_t:s0
> filesystem/test .. 1/41 Failed mount(2): Permission denied
>
> #   Failed test at filesystem/test line 709.
> Failed umount(2): Permission denied
>
> #   Failed test at filesystem/test line 720.
> Failed mount(2): Permission denied
>
> #   Failed test at filesystem/test line 744.
> Failed umount(2): Permission denied
>
> #   Failed test at filesystem/test line 756.
> Failed mount(2): Permission denied
>
> #   Failed test at filesystem/test line 780.
> Failed umount(2): No such file or directory
>
> #   Failed test at filesystem/test line 793.
> Failed mount(2): Permission denied
>
> #   Failed test at filesystem/test line 851.
> Failed umount(2): Permission denied
>
> #   Failed test at filesystem/test line 863.
> Failed mount(2): Permission denied
>
> #   Failed test at filesystem/test line 887.
> Failed umount(2): Permission denied
>
> #   Failed test at filesystem/test line 899.
> Failed mount(2): Permission denied
>
> #   Failed test at filesystem/test line 923.
> Failed umount(2): Permission denied
>
> #   Failed test at filesystem/test line 935.
>
> #   Failed test at filesystem/test line 978.
> # Looks like you failed 13 tests of 41.
> filesystem/test .. Dubious, test returned 13 (wstat 3328, 0xd00)
> Failed 13/41 subtests
>
> Test Summary Report
> -------------------
> filesystem/test (Wstat: 3328 (exited 13) Tests: 41 Failed: 13)
>   Failed tests:  23, 25-26, 28-29, 31-32, 34-35, 37-38, 40-41
>   Non-zero exit status: 13
> Files=3D1, Tests=3D41,  1 wallclock secs ( 0.02 usr  0.00 sys +  0.22 cus=
r  0.36 csys =3D  0.60 CPU)
> Result: FAIL
> Failed 1/1 test programs. 13/41 subtests failed.
> Test failed on line: 85 - Closing down NFS
> NFS Closed down
>
> $ sudo ausearch -m AVC -ts recent | grep unlabeled
> type=3DAVC msg=3Daudit(1716989714.176:42466): avc:  denied  { search } fo=
r  pid=3D170755 comm=3D"mount" name=3D"mntpoint" dev=3D"0:60" ino=3D8221098=
02 scontext=3Dunconfined_u:unconfined_r:test_filesystem_no_watch_mount_t:s0=
-s0:c0.c1023 tcontext=3Dsystem_u:object_r:unlabeled_t:s0 tclass=3Ddir permi=
ssive=3D0
>
> After:
> No failing tests.
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

Thanks for the additional info in the patch description.  I think this
change is fine, although I have a slight preference to simply removing
the dead code rather than commenting it out (a small comment can be
inserted referencing the change if that helps), but ultimately I'll
leave that decision to Ondrej as he has been really driving
maintenance of the selinux-testsuite for the past several years.
However, Ondrej hasn't been responding much on-list lately so it is
possible he is away for a bit; if that is the case I would say to go
ahead with what you have and we can always adjust as needed later.

Regardless, thanks for spending the time on getting the NFS tests
working.  I wonder if this is something we could get working in the GH
Actions CI using NFS over loopback?

>  echo "Run NFS context specific tests"
>  cd tests
> --
> 2.40.1

--=20
paul-moore.com

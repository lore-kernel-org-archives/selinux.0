Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5896217C224
	for <selinux@vger.kernel.org>; Tue, 11 Jun 2024 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110605; cv=none; b=ae3lyn8YKlpqXx39JBBkRdHCI+d5vsSWdkJd62MkolEbvDZWeZs35rFHI7zrorRQ2kfnF4iC5Pye/vLls0MnUAWQldvT/Er62nRPLC2fQrfpHVx5T9nbqbyynfi7IeLq9SjLlYbN4QODepwHMDMvUt0EO8PdZyOAOXENtpXfDz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110605; c=relaxed/simple;
	bh=ZQIBzSnmvKTtb2Sm7Xu+Z1pSLn+1Ue3SpK73A0Y+UuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C40XDkZ6rvXvn0WaA6WvvwXfzAQkHMDsh/GcWeMEZZuRvB4+9/STWgehyVhfQQk7nxtl1olzKb2m+ld7ObpeI3HKrUPaNL3jfLmi4YzQKTPCIfmS/0NTwhjzOe2CNCg8I0vspMlG5Aw6FEABfMOm/27BeuioXTXZvHgrZhqWYvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuMHcWm2; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuMHcWm2"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c2eb98a64fso2367696a91.2
        for <selinux@vger.kernel.org>; Tue, 11 Jun 2024 05:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718110603; x=1718715403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oT0Xaja7Xnb4mtum1zFweXcEoQ6YC7Xr71uqL9pGOXI=;
        b=VuMHcWm2HhxD68SaaHE5jkkCPbglsBNjgWFpAOuiIdu0hA/JmOI3cPWvU+3AncZehY
         CBxXrVQQhBJl26I2d3sI8I5/Ogx/Mh4+scyRLe6pAeYq/oHV+Y1PVZfMzMlrmV+bhehc
         unKwLfLJ/FtFObG8YWSV/gHQPBLLwNud6xg0d96b02jN2Ivku8vqlpBOLwxXyFvxHWIV
         bucUD+L1R7ObdqhR/57THyMIDPvzuz2oRazxDLdUo4vcWK9owgoW6JWsnvw9cYubPL1X
         fbcghZOZWLZsUd7pnXLP1q6K6WGc4PTLezMAxweF1PSe9bPEYO8aA+8fHM7NzLF5QvT7
         hs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718110603; x=1718715403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oT0Xaja7Xnb4mtum1zFweXcEoQ6YC7Xr71uqL9pGOXI=;
        b=Bp7pc916MQK2pk8uHKDeSeZmn7SQlV7en+Uq4z0Oh8c0SGe65LQfDHjWXX3bQuf6cf
         Uu1FFPxz/z4ou7QrItO79xIWlbYp/+okzngLpoduikWUiGVBV8ZgUsZhuHbrH2AMJibl
         UrgNU5BogTvcOuEupGmMZbTojknNEy7tAdZO6m/DKHpZoZ9JLYvvh2loJUn9bks9Pc0/
         EkW8dlLTA+cWhHB2P7oPx0hQaVLBHFUUE3m1KX3ybqA4WtNOjg3ufOjTDDZ9vhsYzqy8
         NTeZIjqu2+VmgUoRdJqIGzzvlqFzVhLhB8fk0n9zW8mvCNgF/En3Txd0BXkN1fbGIdFB
         qKYg==
X-Gm-Message-State: AOJu0Yw9+YE20A4dBvZj5+wH6Af68nrjMh6pr6wqybslSs2qFOXs8v1r
	z0+4EWl1reMEjCxqtjgG0MkNVZieT3NsNocJj53LESwJBmC3tFDnX9YBrE/15gnFJQYyHCxE6r3
	5Hkdij7Uw6Vdem9Ljgs5s66zwvUAcinq1
X-Google-Smtp-Source: AGHT+IHqIUajR6f8+cfJ/mOw8jgT5KjkzlnkBzKT6Kqn8J6PvCWuKKGq/c3fhLz+h7zdUcPG9XNdCBgMZL5p4GP1NeA=
X-Received: by 2002:a17:90a:2c48:b0:2c1:a99b:7467 with SMTP id
 98e67ed59e1d1-2c2bcafc9ccmr11390671a91.19.1718110603514; Tue, 11 Jun 2024
 05:56:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531131237.16666-1-stephen.smalley.work@gmail.com> <CAFqZXNscp9KkR9=jJHo+_JEUNgBry0=k2DW+1FcNHkomV8bLMg@mail.gmail.com>
In-Reply-To: <CAFqZXNscp9KkR9=jJHo+_JEUNgBry0=k2DW+1FcNHkomV8bLMg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 11 Jun 2024 08:56:31 -0400
Message-ID: <CAEjxPJ6qVfV6Q8pqLEv_AQTawAGgVSdL5nu_+jNT9M=3vqksLA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2 testsuite] tools/nfs.sh: comment out the fscontext=
 tests for now
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 4:44=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> On Fri, May 31, 2024 at 3:13=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > These tests currently fail on mount(2) calls due to the directory being
> > unlabeled at the point where search access is checked. Until we can res=
olve
> > the underlying issue, comment out these tests to allow the NFS tests to
> > be run. It is unclear that these tests ever passed and retaining them
> > prevents enabling the NFS tests in automated testing.
> >
> > This bug is tracked in
> > https://github.com/SELinuxProject/selinux-testsuite/issues/91
> >
> > Before:
> > Run 'filesystem' tests with mount context option:
> >         fscontext=3Dsystem_u:object_r:test_filesystem_file_t:s0
> > filesystem/test .. 1/41 Failed mount(2): Permission denied
> >
> > #   Failed test at filesystem/test line 709.
> > Failed umount(2): Permission denied
> >
> > #   Failed test at filesystem/test line 720.
> > Failed mount(2): Permission denied
> >
> > #   Failed test at filesystem/test line 744.
> > Failed umount(2): Permission denied
> >
> > #   Failed test at filesystem/test line 756.
> > Failed mount(2): Permission denied
> >
> > #   Failed test at filesystem/test line 780.
> > Failed umount(2): No such file or directory
> >
> > #   Failed test at filesystem/test line 793.
> > Failed mount(2): Permission denied
> >
> > #   Failed test at filesystem/test line 851.
> > Failed umount(2): Permission denied
> >
> > #   Failed test at filesystem/test line 863.
> > Failed mount(2): Permission denied
> >
> > #   Failed test at filesystem/test line 887.
> > Failed umount(2): Permission denied
> >
> > #   Failed test at filesystem/test line 899.
> > Failed mount(2): Permission denied
> >
> > #   Failed test at filesystem/test line 923.
> > Failed umount(2): Permission denied
> >
> > #   Failed test at filesystem/test line 935.
> >
> > #   Failed test at filesystem/test line 978.
> > # Looks like you failed 13 tests of 41.
> > filesystem/test .. Dubious, test returned 13 (wstat 3328, 0xd00)
> > Failed 13/41 subtests
> >
> > Test Summary Report
> > -------------------
> > filesystem/test (Wstat: 3328 (exited 13) Tests: 41 Failed: 13)
> >   Failed tests:  23, 25-26, 28-29, 31-32, 34-35, 37-38, 40-41
> >   Non-zero exit status: 13
> > Files=3D1, Tests=3D41,  1 wallclock secs ( 0.02 usr  0.00 sys +  0.22 c=
usr  0.36 csys =3D  0.60 CPU)
> > Result: FAIL
> > Failed 1/1 test programs. 13/41 subtests failed.
> > Test failed on line: 85 - Closing down NFS
> > NFS Closed down
> >
> > $ sudo ausearch -m AVC -ts recent | grep unlabeled
> > type=3DAVC msg=3Daudit(1716989714.176:42466): avc:  denied  { search } =
for  pid=3D170755 comm=3D"mount" name=3D"mntpoint" dev=3D"0:60" ino=3D82210=
9802 scontext=3Dunconfined_u:unconfined_r:test_filesystem_no_watch_mount_t:=
s0-s0:c0.c1023 tcontext=3Dsystem_u:object_r:unlabeled_t:s0 tclass=3Ddir per=
missive=3D0
> >
> > After:
> > No failing tests.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  tools/nfs.sh | 44 ++++++++++++++++++++++++--------------------
> >  1 file changed, 24 insertions(+), 20 deletions(-)
>
> Thanks! The two patches are now applied:
> https://github.com/SELinuxProject/selinux-testsuite/commit/7738f9f68cedfe=
36ace71a15ae49ed3d9dd85b36
> https://github.com/SELinuxProject/selinux-testsuite/commit/0815abcd70b382=
e13592264ce39bf48742421cc8

Thanks. What do we need to do to get tools/nfs.sh running as part of
the automated tests? It is passing on 6.10-rc1. Only additional
dependency required should be nfs-utils.

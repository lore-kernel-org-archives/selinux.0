Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA917C200
	for <selinux@vger.kernel.org>; Thu, 30 May 2024 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076433; cv=none; b=tNtal2fZgYb+JqZVbXxbv23rwymbN7FCP+Q8CV+nZgbgvJFHKySY0Lia9+1oe0vxVYFG8Acq/s9PIMcq1ATn45Suxi1XqTJ9WeG42w048IfA8Z9v9MEU3/l6s1BBzeFzPb4S/GzhxpsHrhWcc8q3Z5pXtYC/iRygUq/nCx5qS18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076433; c=relaxed/simple;
	bh=DhgG9je/ixsPNjX5bGFZQnhVvVBH5nfjRGcmSkMukbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uaMJV6vuIR9keWMc2svRUMVmX+Iw7luZQcvf782cOB9AwDiHhj9e2yW5mdR1AtIlGib3ZViBf7QGYMupruI539JcwFe5OORMwHwtlTSTroPNmd7K41DQ8r4EhVMvpISrTp0KQ9MJnCTl3eUhM4wKKxW8/FxRZXhkUQQUUfGhwAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K3L28BwH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3L28BwH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717076430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B7KzNx1pgAkVP8xZ9SVvuD7ui/Xdcc2FH3BYRhixnFk=;
	b=K3L28BwHsanBQaTTJmL7DsNZtj/BePjkJgTcAYrN/9ir9b2rZL399SjtIWikYmjjVf7RsN
	PyOE25aU5DqC0ZH5u4Gm7GV3hBUOFLUBHeWxjv5pavrf0W94sqUqED44HyJxF7bJThexcb
	O/YLBP3vae3Y7dulfakWVPDOuqhJBDg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-9eErqAjyMsGpJcI1Wvdmow-1; Thu, 30 May 2024 09:40:28 -0400
X-MC-Unique: 9eErqAjyMsGpJcI1Wvdmow-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-6bfa69d5729so887316a12.1
        for <selinux@vger.kernel.org>; Thu, 30 May 2024 06:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717076427; x=1717681227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7KzNx1pgAkVP8xZ9SVvuD7ui/Xdcc2FH3BYRhixnFk=;
        b=uqqCja9CbzA+LSE/TY/bIkmGNkfAKEHdJB4gSWSCxyFeluaXzVrA7ky6fcOH1WnY16
         xtsnh3msxnjR6wx3ygUNSXI3JHtAabPSrpxyaEpIRpoEkN7eHPaKUM+iberNUaEt51Aq
         U1ZElJIQUSFGrEI3K08o9yUIT7Ra1J8zhWPEigOGZEVfnf17NJqI1IinRp5e5XqsulRn
         sUAi4G5wgn9DuoHu86ZaOWN317bhG0Oz0qzLQzZtyNo6+KtfXJE4GQt/+AGdiRQKJBSs
         lRB/r+WaNKJ/y+7ZkjYml7EZ2T6rJql0Qw0u+1rclHMb4NwYuev2g5HSvd7rzQjfOBxC
         CRjA==
X-Forwarded-Encrypted: i=1; AJvYcCVVPuhZOjXwkFBBM3R6E/kb62xZ30HusGXXHrXKTHCsPE0pU1ZnlL86sCivGnRBJeniV/7uOFiqIQeIZaT2o0sXXRcMoM4SiQ==
X-Gm-Message-State: AOJu0Yy39C/eP0plgOruTQXnhKDgYr9eHSKmDb3OZGo/tVoJAye9r13m
	6XOAGbWL/s6MOlKvANS6wdkCDznrRyNhVUrkHH205Z/IqQEYcO7hyJQkhEokfouASKmT0L0LYz8
	eMjZpiYw23kh3FliCrPc00iIeABc5ECLcMr8vdEHPCBXEpWkZaNBQR6JSURPl64VgTCbbvVv6ux
	QRQ+4zaV0lOasNDbVd8m4cw0pFZgPOhFnui0uy7A==
X-Received: by 2002:a17:90a:ad93:b0:2b5:6e92:1096 with SMTP id 98e67ed59e1d1-2c1abbf9340mr2360864a91.28.1717076427443;
        Thu, 30 May 2024 06:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyM1Ip597x420EqBAn/Ywwwh/vQlM4M7rTvlff4HSOueUoW2HYgkwrncgF7GDRzrEXuDvRleIVkVFfHmV1LbE=
X-Received: by 2002:a17:90a:ad93:b0:2b5:6e92:1096 with SMTP id
 98e67ed59e1d1-2c1abbf9340mr2360839a91.28.1717076426941; Thu, 30 May 2024
 06:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529140306.6663-1-stephen.smalley.work@gmail.com> <CAHC9VhRFSbkvpaGioW2o=FTXRDMvUbmBAoRif_R-9mX5Ns3o9A@mail.gmail.com>
In-Reply-To: <CAHC9VhRFSbkvpaGioW2o=FTXRDMvUbmBAoRif_R-9mX5Ns3o9A@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 30 May 2024 15:40:15 +0200
Message-ID: <CAFqZXNsHX3H2f23Taj4RpDi9QsdYpMGbxvJUu7zpjy183_T4TA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tools/nfs.sh: comment out the fscontext= tests for now
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 5:27=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, May 29, 2024 at 10:04=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > These tests currently fail on mount(2) calls due to the directory being
> > unlabeled at the point where search access is checked. Until we can res=
olve
> > the underlying issue, comment out these tests to allow the NFS tests to
> > be run. It is unclear that these tests ever passed and retaining them
> > prevents enabling the NFS tests in automated testing.
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
>
> Thanks for the additional info in the patch description.  I think this
> change is fine, although I have a slight preference to simply removing
> the dead code rather than commenting it out (a small comment can be
> inserted referencing the change if that helps), but ultimately I'll
> leave that decision to Ondrej as he has been really driving
> maintenance of the selinux-testsuite for the past several years.
> However, Ondrej hasn't been responding much on-list lately so it is
> possible he is away for a bit; if that is the case I would say to go
> ahead with what you have and we can always adjust as needed later.

Yes, I was on a 2-week vacation ending tuesday (I should have set up
an auto-reply, but forgot, sorry...).

I'm fine with the patches, although I would prefer that a comment is
added before the commented-out code that explains why it is
commented-out (can be taken from the log message), ideally with a link
to an issue tracker or ML thread(s) so that future readers have a
chance to figure out if the issue has been already fixed or not.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


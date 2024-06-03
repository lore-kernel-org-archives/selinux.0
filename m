Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94E826AD0
	for <selinux@vger.kernel.org>; Mon,  3 Jun 2024 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717404253; cv=none; b=ip2fsBDbASUBtHc380N35jkqTtvvQ8xyyiOpp/2Nqo271WO70Bc9GvZ9N+iqrLbY6Ueyyg03Ao1KNQYSQkcnRFL8rlNWUOde31fbllg6bmajtgjmLaXRmLOmvkINoIbPfiM2Yp+Y4+d5n3ST8X+I/JCJvzWd1iTIFAQZ0MyHnFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717404253; c=relaxed/simple;
	bh=81+h5QThsgk6cEo9BSNEQmW2xlCBioJSL17ecP8UN28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TF0NeNYQWIvqzozVtvEntHsft/+7OyEBO27qnMd0KdU//8ZlglBjHI7JvgGM2r8NRB1xyGXL9tfmUIq/o7CSQFbLNRCH1BBRnnFevtrnU2lEx1N26vVa94JpKxtK9D7W8muW0jYVl3/ktMTzxPuWvfUdu7G7ayZbE6Lsb34LAnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OdU/3tmN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdU/3tmN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717404250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSEfLGzvvSg5UvPvgH4NmgJ5HKMFuEE5TLi/pubmd5o=;
	b=OdU/3tmNckzRRTQfgP4p5Wdgry7Nwm6F2OIwCZwyd4Ka0qEQ5fEjhogz54jxgULzxA64SR
	bnKMf29lqC6ZlRaEMkAh0q2XUjzUSQXHNT+ar6bRmEAkAjdFjiq806/xIKVoF5A7ODUPio
	nbu8lGd0CucdDfKCeZhxYzEYsiuBjsA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-n6rfEKrVM2W3naW0wQ84Cw-1; Mon, 03 Jun 2024 04:44:09 -0400
X-MC-Unique: n6rfEKrVM2W3naW0wQ84Cw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c1aefa2d9bso3877721a91.2
        for <selinux@vger.kernel.org>; Mon, 03 Jun 2024 01:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717404248; x=1718009048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSEfLGzvvSg5UvPvgH4NmgJ5HKMFuEE5TLi/pubmd5o=;
        b=PgLHVeMUQ7yAXR/1ktxSzLWxes8N635TfJVxQNdQXtAC0aBCz/lSWUgZNUw/96WNDH
         tM1DltoApmeU3YqHO/BgcY3kkX/HdKpSqfnsIFd9LdyIUjpo93PFuM/zB59GNIpe4J9L
         rHXzoA4+R2jL9XF2EjlWqqqNN8kAgN0IE14dRkLCJzjfi+/haVMCrAXRtjX4g+Q5zIwQ
         FHg62b57dF+lHaAhde7+vbseijHVLmoJYlZeMDJGviFbu/lMrN6MJV8rPGYc19Di/4nx
         4ydu0e6FOy8jVSdaeS5ozI/iBdIHmn2f+m2Dx3EZ+H18zDmM1vsif8JkhbNjnxmptXgE
         aTfA==
X-Gm-Message-State: AOJu0YyQVo97MDT3gn3SQ+Nkl3Syf6Mar+pyW4EVViYWtiJBb1VSEhGE
	X6Drz1LQbHMyrjrsEOOFBXx9olyFzUYP6A3sZXOJ6LrNndnvUTg5Vbm075gkq7eWMhdiQdJ7kK/
	NAa+vFbbdIh4TvpZ6Xnp2PIfMPPPjGQ14HiOEI4jx4Dq4bgF3MLEfCVNLVcEdsQ0BdbzT67FXMJ
	xpKyQzn+kKZ+As6ByzVJNGIPu01KqZNukYVXXteJs/
X-Received: by 2002:a17:90a:5984:b0:2ac:5d2d:12ac with SMTP id 98e67ed59e1d1-2c1dc5667f8mr7789910a91.5.1717404248356;
        Mon, 03 Jun 2024 01:44:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh1c8HDklXrVMjeCexhvBTW268My71yOPGZWJOVyuufHGxn0QskGZ4ncTso1gKpJ+pdmtxqOssyq5jLvMbL8w=
X-Received: by 2002:a17:90a:5984:b0:2ac:5d2d:12ac with SMTP id
 98e67ed59e1d1-2c1dc5667f8mr7789897a91.5.1717404247936; Mon, 03 Jun 2024
 01:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531131237.16666-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20240531131237.16666-1-stephen.smalley.work@gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 3 Jun 2024 10:43:57 +0200
Message-ID: <CAFqZXNscp9KkR9=jJHo+_JEUNgBry0=k2DW+1FcNHkomV8bLMg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2 testsuite] tools/nfs.sh: comment out the fscontext=
 tests for now
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 3:13=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> These tests currently fail on mount(2) calls due to the directory being
> unlabeled at the point where search access is checked. Until we can resol=
ve
> the underlying issue, comment out these tests to allow the NFS tests to
> be run. It is unclear that these tests ever passed and retaining them
> prevents enabling the NFS tests in automated testing.
>
> This bug is tracked in
> https://github.com/SELinuxProject/selinux-testsuite/issues/91
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
>  tools/nfs.sh | 44 ++++++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 20 deletions(-)

Thanks! The two patches are now applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/7738f9f68cedfe36=
ace71a15ae49ed3d9dd85b36
https://github.com/SELinuxProject/selinux-testsuite/commit/0815abcd70b382e1=
3592264ce39bf48742421cc8

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


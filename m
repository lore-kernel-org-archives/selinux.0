Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D662FF66A
	for <selinux@vger.kernel.org>; Mon, 10 Nov 2025 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768618; cv=none; b=jvSjsWQpnGgIs2FtgItq7axxCR2UKTpleAh7+fmAb23pFpGrHOlWjOShsxcMdJEW/DoMmQHpOw8DaeoJqJTmRxjT2nvCDxiZvsAMOR6/cOZFbsCruzBcF1cMCxIuxlOVOANpxephHlloT0TN+zU0sUsTpl6kn3wkZPePxC/qzyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768618; c=relaxed/simple;
	bh=o6lHjCsByqUCaIchh5pbxVN9ph+4YSgKjBffR33i2o0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msfZv1l+URPm+FakKszwyyU7t0AbPx7Qt1qn+QuwXCPHsLRbBmDj8Ia2bXxJrrINkR33S3dez8xzGoWOHK2Yf105++3AxxcMM7O6T8ZcbDzv0950eLO8Ye6Y9HRQXBJ4M5UdMv6arnBU3zMV0ugpy9/pviNJpelzoi+8PZRh+2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3pb78XQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O60wPgZN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3pb78XQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O60wPgZN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762768615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j9d4XfOrwLB1xMeipuRwCq1bDa80pNG+7B6KRQjeC1c=;
	b=a3pb78XQ8cBSlAF4dy2Ddn7ziw6ydZDhsuCnGqwFeT/BAe34zODc2HpO0X+HNU7Lh7W9aX
	UyclS4yx7junXfY5HYBu7pIBtPPqv+CXJKprIut2+MY59YOKGrln4q5fBQa7eUY5ziD5u/
	hGWwnWLC/z3WMf1aBV4SODdO+uwVZLg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-5EnbFlGNMcGLrZvo1LL2ng-1; Mon, 10 Nov 2025 04:56:54 -0500
X-MC-Unique: 5EnbFlGNMcGLrZvo1LL2ng-1
X-Mimecast-MFC-AGG-ID: 5EnbFlGNMcGLrZvo1LL2ng_1762768613
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-342701608e2so3574187a91.1
        for <selinux@vger.kernel.org>; Mon, 10 Nov 2025 01:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762768613; x=1763373413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9d4XfOrwLB1xMeipuRwCq1bDa80pNG+7B6KRQjeC1c=;
        b=O60wPgZNLuQ0iX7s4PhT9ZahREt5BOm8a2U4EJMR7GovtEJfrhOLmMRZ5thFm4UFPL
         yLQDV/0ZT7q8/T/ImUukHgGXgJVhGa5TSIbGQZKhw69EHtrGO+FTwssICfNwhG/n8Bje
         JFYDuqZOu6Q0SZwPPtrVlLWHXlAgba5UwVukBVTgM66s6KcAah+WB99cTnEwocC0LEsH
         U54xVS9gmbzbE3LX+sFXMPttNliQduRESNjr8CM4BF9TD8XGAJj/m9ItZjEn0u8tpBJ0
         wuIBkukps9HEegdsK2P/VXwMK4IsPQa4rbwUix5daC2l1niqJqZJoQCLvAkvrjLGUU4S
         NlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762768613; x=1763373413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j9d4XfOrwLB1xMeipuRwCq1bDa80pNG+7B6KRQjeC1c=;
        b=vmB0Ys1yl50kTBREW4n95jV90RbWs3cBKgDrNnLDO7cVGyVOBFajoLHdxJmKwNXBB1
         fShSu9a0i0EcC8pqmK2s2TUERakQTtQrdimIxvOpXSgDvSvwI1D6vLYaFeq1fUPSMD2/
         FT+dGlIeEhQsV19FlOdORUrLoiw6t3Tqz57HHncaRz4OX7wLMMCGaNBHNVqmA4EPVKjT
         UerTvbHQfQDub+ieitnuQ0/uqrURTzK4vyh6IfHrP+1F9Mj1VikvgB+58kh6P827biU1
         rqzWHOfR9TsJmXEI5vI0YqzIgubxwZ/DHFp5qorOgkl+8K+UprIlFWNMya7G2rYKlwmS
         Gb1g==
X-Gm-Message-State: AOJu0YxgTDHbiV8HddC4KhR1vmViEwECoGqJYNvwWgjicHD4cCNfdQjN
	Z6ZCYCEqsbwspELHMhA6s49B2ELNg6p2IhzEYPr0dBjUpU2b1JgClZqP/HTVUvhnHrfosPqfFom
	ntirkUQq7eUgFDaPErwWIGmyKn6DvYyNrJPSi2hY8XzZZNJElVwahom62KR11a2MD7FlumfEqNZ
	1ZYdElH8VDBnclDnHGm68GF4AySYrubDp8N2eGzPsNJpWr
X-Gm-Gg: ASbGncuunvlxQY4/N4QsOBTW/jurhxYQDP+8LF1o8E3wP1j5yIFLAYlgHpzCzZrYZOP
	oKDXTY+CPDqXDJpFbWGeAukI7Lo/WvhDVLH0k9EBzxr0eBUDysDHvPi7pNYwzhfROAFN3ZFXWGW
	qg47uvAP6op2P+4OyM7pzFBWFpOa+GP4FM8EOPDmQbDSIONb/bhyfLtrjYnKPC1AiONogzjqW2U
	yGD+OS7WCJyCPXh
X-Received: by 2002:a17:90a:e710:b0:341:88c9:ca62 with SMTP id 98e67ed59e1d1-3436ccfe40fmr8826105a91.31.1762768613081;
        Mon, 10 Nov 2025 01:56:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOB/gLrl5XKvW9bzkIMmgmKX4CIcN+gv9c5hUI26I8XoK9C19xUhJlB8U8XALm6vzSnQ8gHbKFdQNh+T7Zc+4=
X-Received: by 2002:a17:90a:e710:b0:341:88c9:ca62 with SMTP id
 98e67ed59e1d1-3436ccfe40fmr8826091a91.31.1762768612712; Mon, 10 Nov 2025
 01:56:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107190614.52123-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20251107190614.52123-2-stephen.smalley.work@gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 10 Nov 2025 10:56:41 +0100
X-Gm-Features: AWmQ_bmiKE1Z1cRHg_4JqPmNUzLTHamcnYrmKbe9EbWodxOOgBp6ihIghNveFqc
Message-ID: <CAFqZXNvxdN1J9GTN3N25D4pHgb-c77rxt94ZE9AQ=MhkkhCjnQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] Add tests for io_uring
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 8:09=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> iouring.c is a lightly modified copy of the one from:
>     https://github.com/linux-audit/audit-testsuite
>
> Only minimal changes were made to allow iouring.c to work within the
> selinux-testsuite; more could be done to specialize it for the
> selinux-testsuite, including using libselinux rather than hand-rolling
> its own custom functions, but not sure if it is better to keep them as
> close as possible for future joint evolution or let them diverge.
>
> The audit-testsuite only appears to exercise the "iouring t1" test
> case; for the selinux-testsuite, a test script and test policy were
> created to exercise allowed and denied cases for each of the io_uring
> { override_creds sqpoll } permissions and for each of the anon_inode
> permissions required for the io_uring anon inodes to execute:
> 1. iouring t1 without any provided exec context, i.e. child process
>    runs in same context as the parent process,
> 2. iouring t1 with a provided exec context, i.e. child process runs in
>    a different context from the parent process, and
> 3. iouring sqpoll.
>
> To avoid a tight coupling on Fedora policy, which defines a default
> type transition on io_uring anon_inodes to a single type for all
> domains, the test policy is written using the minimal testsuite domain
> type interface so that the test domains are not associated with the
> domain attribute and can therefore have their own unique type
> transitions defined for testing purposes.
>
> Since the base policy on recent Fedora includes the base set of
> io_uring permissions, the conditional guards in the policy and
> tests Makefiles simply test for the definition of the io_uring
> class in the policy support files to determine whether to enable
> the test policy and tests to run.
>
> This change does not include tests for the later additions to the
> io_uring class for cmd and allowed, which were added to subsequent
> kernel versions. The allowed permission does not yet appear to be
> defined in either Fedora policy or refpolicy, so testing that
> permission would require a modified base module. Such tests should
> be added in a future change.
>
> This change also does not explicitly test that io_uring operations on
> files, sockets, etc are subject to the usual SELinux permission checks
> for such objects in the appropriate subject context. Tests for these
> should likewise be added in a future change.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  README.md                 |   2 +
>  policy/Makefile           |   4 +
>  policy/test_io_uring.te   | 138 +++++++++
>  tests/Makefile            |   4 +
>  tests/io_uring/.gitignore |   2 +
>  tests/io_uring/Makefile   |   7 +
>  tests/io_uring/iouring.c  | 622 ++++++++++++++++++++++++++++++++++++++
>  tests/io_uring/test       |  84 +++++
>  8 files changed, 863 insertions(+)
>  create mode 100644 policy/test_io_uring.te
>  create mode 100644 tests/io_uring/.gitignore
>  create mode 100644 tests/io_uring/Makefile
>  create mode 100644 tests/io_uring/iouring.c
>  create mode 100755 tests/io_uring/test
>
> diff --git a/README.md b/README.md
> index 1a1b621..4fa71d3 100644
> --- a/README.md
> +++ b/README.md
> @@ -64,6 +64,7 @@ similar dependencies):
>  * btrfs-progs _(used by the btrfs filesystem tests)_
>  * nftables _(used by inet_socket and sctp tests if ver >=3D 9.3 for secm=
ark testing )_
>  * rdma-core-devel _(to build the `ibpkey` test program)_
> +* liburing-devel _(to build the `iouring` test program)_
>
>  On a modern Fedora system you can install these dependencies with the
>  following command (NOTE: On Fedora 32 and below you need to remove
> @@ -92,6 +93,7 @@ following command (NOTE: On Fedora 32 and below you nee=
d to remove
>                 dosfstools \
>                 btrfs-progs \
>                 rdma-core-devel \
> +               liburing-devel \

Please also add this to tmt/tests.fmf (under /run/require).

Also liburing-dev should be added to the Debian list in README.md,
though I'm not sure if the io_uring test will work there yet.

>                 kernel-devel-$(uname -r) \
>                 kernel-modules-$(uname -r)
>

[...]

> diff --git a/tests/io_uring/test b/tests/io_uring/test
> new file mode 100755
> index 0000000..12fb9fb
> --- /dev/null
> +++ b/tests/io_uring/test
> @@ -0,0 +1,84 @@
> +#!/usr/bin/perl
> +
> +use Test;
> +BEGIN { plan tests =3D> 11 }
> +
> +$basedir =3D $0;
> +$basedir =3D~ s|(.*)/[^/]*|$1|;
> +
> +# Remove any leftover test files from prior runs.
> +system("rm -f $basedir/iouring.out");
> +
> +# Verify that test_io_uring_t passes the t1 test
> +$result =3D system("runcon -t test_io_uring_t $basedir/iouring t1");
> +ok( $result, 0 );
> +
> +# Verify that test_io_uring_no_override_t fails the t1 test on io_uring =
override_creds
> +$result =3D system(
> +    "runcon -t test_io_uring_no_override_t $basedir/iouring t1 2>/dev/nu=
ll");
> +ok($result);
> +
> +# Verify that test_io_uring_no_readwrite_t fails the t1 test on anon_ino=
de read write
> +$result =3D system(
> +    "runcon -t test_io_uring_no_readwrite_t $basedir/iouring t1 2>/dev/n=
ull");
> +ok($result);
> +
> +# Verify that test_io_uring_no_map_t fails the t1 test on anon_inode map
> +$result =3D
> +  system("runcon -t test_io_uring_no_map_t $basedir/iouring t1 2>/dev/nu=
ll");
> +ok($result);
> +
> +# Verify that test_io_uring_no_create_t fails the t1 test on anon_inode =
create
> +$result =3D
> +  system("runcon -t test_io_uring_no_create_t $basedir/iouring t1 2>/dev=
/null");
> +ok($result);
> +
> +# Verify that test_io_uring_parent_t passes the t1 test with
> +# test_io_uring_child_t as the exec/child context
> +$seuser =3D `secon -u`;
> +chomp($seuser);
> +$serole =3D `secon -r`;
> +chomp($serole);
> +$serange =3D `secon -m`;
> +chomp($serange);

These commands don't work when the testsuite is run through TMT. It
looks like secon assumes that stdin is attached to a terminal.

$ secon -u </dev/null
secon:  Couldn't read security context: Inappropriate ioctl for device

Adding "--pid $$" should fix it:

$ secon -u --pid $$ </dev/null
unconfined_u

> +$childctx =3D "$seuser:$serole:test_io_uring_child_t:$serange";
> +$result =3D
> +  system("runcon -t test_io_uring_parent_t $basedir/iouring t1 $childctx=
");
> +ok( $result, 0 );
> +
> +# Verify that test_io_uring_child_no_override_t fails the t1 test on io_=
uring override_creds
> +$childctx =3D "$seuser:$serole:test_io_uring_child_no_override_t:$serang=
e";
> +$result =3D
> +  system(
> +    "runcon -t test_io_uring_parent_t $basedir/iouring t1 $childctx 2>/d=
ev/null"
> +  );
> +ok($result);
> +
> +# Verify that test_io_uring_child_no_map_t fails the t1 test on anon_ino=
de map
> +$childctx =3D "$seuser:$serole:test_io_uring_child_no_map_t:$serange";
> +$result =3D
> +  system(
> +    "runcon -t test_io_uring_parent_t $basedir/iouring t1 $childctx 2>/d=
ev/null"
> +  );
> +ok($result);
> +
> +# Verify that test_io_uring_child_no_readwrite_t fails the t1 test on an=
on_inode read write
> +$childctx =3D "$seuser:$serole:test_io_uring_child_no_readwrite_t:$seran=
ge";
> +$result =3D
> +  system(
> +    "runcon -t test_io_uring_parent_t $basedir/iouring t1 $childctx 2>/d=
ev/null"
> +  );
> +ok($result);
> +
> +# Verify that test_io_uring_sqpoll_t passes the sqpoll test
> +$result =3D system("runcon -t test_io_uring_sqpoll_t $basedir/iouring sq=
poll");
> +ok( $result, 0 );
> +
> +# Verify that test_io_uring_no_sqpoll_t fails the sqpoll test
> +$result =3D system(
> +    "runcon -t test_io_uring_no_sqpoll_t $basedir/iouring sqpoll 2>/dev/=
null");
> +ok($result);
> +
> +# Cleanup
> +system("rm -f $basedir/iouring.out");
> +
> --
> 2.51.1
>

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


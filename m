Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED04137750
	for <selinux@vger.kernel.org>; Tue, 12 Aug 2025 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001113; cv=none; b=P83AQXEHH/VXoTlbB0pL6HNZp8QxS9elmoObE30216b5o9KbErsGSccFZBhF4MA8kIhDyKZcagGC0/Rmc48G/u3L6tftNXQvjlHpnXyDd99eQzAgmTfxBnmq4PsyXDtX/lYrqbzdzzZLqxaLiyCvZqZ5rTFk+KP4vrRYG5w7ua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001113; c=relaxed/simple;
	bh=FkHDSCn9zDNm/J8hJnjP8qhsPJUsRfYFoxxjiG5dGEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRw0x6aTv7rbmT8qcsbirfpJigEi0YKrwcS/Y+gzOBFRW9PsRmokr35CPsR7tORvuoRI7Yb0azyrmqLnJD21aUsLbAeWCVjkIQa0qPV9lwW/FJ5M5RkZ890Jq1zociWRLeLRbXiio/EL8QJnq3yB6/i8eTMOVGqaLqWIRvywx4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTZ7Plq0; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTZ7Plq0"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32106b0930eso5642800a91.0
        for <selinux@vger.kernel.org>; Tue, 12 Aug 2025 05:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755001111; x=1755605911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1VDCRdzgbDUh9XQcpAhuV4z4JDM017Iq2ASJMN871w=;
        b=BTZ7Plq0+fbf6mraDicLNFT2dV7+xw/6iv0YXSmtidaxeaozQLkowthtcevK93jJs2
         vFd0U9/k1z4QJSZIEjPJw4ysY8ZSQoTedw4/5HfYWcexmZFCx2QJV6u/l3+QdsrbxSmt
         gHMCZMA+vvBLpCDz5Ma6shkUeRrVdpGWrseUueirGQNsU5uZWeq+QVYZoSe+GkuvbXa8
         KIQzy2DsU9kSS461tQI0PKEZ22f8QhRa8gXI42uLmiEBokTPXRFwQF7G8gNJLiVmTqyI
         L13S6/ZQtI8ElrsriUNbvXAKXJlTovWE5JNNkucfNdYr7yzo8US4T/sM9kwzwI+5r5GW
         pu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755001111; x=1755605911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1VDCRdzgbDUh9XQcpAhuV4z4JDM017Iq2ASJMN871w=;
        b=duA4dZo9QSTDW3vDc2fjwF+pugtAk+S59McYjZ/imr8hPWiPthl/ji/4x1ttY550aM
         8NLIeOVKM7tajGTaRryVQnAXiuzvEfJIw3oAaxOD8v4TkTdGOx1lgLF/EWj78c8u9Jtc
         uiGwoQbLU15qKA6IGCT9h+EBSVawowI0MZU6ywypKZ0p7WVYVsujOnUQ1k3QwJllGs8n
         YmgXCDnxOCwhsbwwBGcIPMcX7X6okzWq987MS43yn5aBUBoUw4sBfe+lc8OmiOUdvWmm
         L9BSIlg4qqYPRAK8MndAKMComCjZup7iyOajQcm7AnR6t/Dq78yXzuJV0Dyg+hZEuHYA
         TIYg==
X-Forwarded-Encrypted: i=1; AJvYcCX5CsYwKmd/REMW7ytawNHMFnbGvJChJUtgPy8IyanZv+yQs8nTwIOM3AwJd3/gdN9aioU6hJnv@vger.kernel.org
X-Gm-Message-State: AOJu0YwOCAjyCyI4naErDlUobM4EScBJKwDG18MVT5tvMyAKYiM2raRx
	RWnbwYxxTLUyK54Y2pAPG+4AVs9IA38I/siR4u6bX5/8iQMhPrUkZDkKgyo50QhCpVoCnPGwDoO
	xsKV8VVnUqWisq59TzyF1gU6VhSoY2rhdhA==
X-Gm-Gg: ASbGnctrP2cRiGYug1OzYiZkCA3wYCjsnU9+PcjlM48QuxeKOocQbXUwoUUSzPDaoYS
	VSKWRrQwT/Zv8QpZ0eEHnExG+TCTCqxkkBag0HgszSBj+EuD28ZDR0KMEnhfU84/3azOhsqdZ3g
	5+q2Tp7jca7KDK98xx8b00gVrl2WwQ6vkkU1vCQgxCSe2toxZNAgFVxYrzt0zbKP9IMoLLOEpuv
	yrztj0=
X-Google-Smtp-Source: AGHT+IEqHjRJC1ti2+m/T41PE24Bjjk+wcOSj4v9glAjek5+txgDMiBlPrd4VqekuFQSeC8V2uKP23l4WG/PtyVS+QI=
X-Received: by 2002:a17:90a:ec86:b0:321:c85d:dd93 with SMTP id
 98e67ed59e1d1-321c85de7a0mr1656241a91.4.1755001111271; Tue, 12 Aug 2025
 05:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808184711.291-1-ericsu@linux.microsoft.com>
 <CAEjxPJ6SBAy8yi8XhASR5pVFnYfvJhFujzGfBQuS9o2TziOSFw@mail.gmail.com> <8cd1865a-6220-471d-826d-e4908b39f229@linux.microsoft.com>
In-Reply-To: <8cd1865a-6220-471d-826d-e4908b39f229@linux.microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 12 Aug 2025 08:18:19 -0400
X-Gm-Features: Ac12FXxagvjewiX5fFmWcWUxZuz9f5MjlVKruGqRtNd0P88hNZBXMTKvXvuJzok
Message-ID: <CAEjxPJ69ee3c33jQsE39QeHk9q2ADNYtf2nyry3-8pu1F0zCkg@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/bpf: Add tests for SELinux BPF token
 access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: danieldurning.work@gmail.com, selinux@vger.kernel.org, paul@paul-moore.com, 
	omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 2:36=E2=80=AFPM Eric Suen <ericsu@linux.microsoft.c=
om> wrote:
>
> On 8/8/2025 12:59 PM, Stephen Smalley wrote:
> > On Fri, Aug 8, 2025 at 2:47=E2=80=AFPM Eric Suen <ericsu@linux.microsof=
t.com> wrote:
> >> This patch adds new tests to verify the SELinux support for BPF token
> >> access control, as introduced in the corresponding kernel patch:
> >>    https://lore.kernel.org/selinux/20250806180149.1995-1-ericsu@linux.=
microsoft.com/
> >>
> >> Four new tests are added to cover both positive and negative scenarios=
,
> >> ensuring that the SELinux policy enforcement on BPF token usage behave=
s
> >> as expected.
> >>    - Successful map_create and prog_load when SELinux permissions are
> >>      granted.
> >>    - Enforcement of SELinux policy restrictions when access is denied.
> >>
> >> These tests are located under the tests/bpf directory and can be run
> >> using the standard SELinux testsuite workflow.
> > (added Daniel to cc since he also posted a testsuite patch and thus
> > should be included)
> >
> > As I mentioned on the other thread, you should include instructions in
> > your commit message for how to temporarily define the requisite policy
> > capability and new permissions to run these tests; an example is
> > linked from the SELinux kernel wiki Getting Started page and my other
> > email.
> > That alone isn't worth re-submitting this patch but see below for more.
> Stephen - I followed instructions in this example to enable new
> permissions and capability:
> https://github.com/SELinuxProject/selinux-testsuite/commit/023b79b8319e5f=
e222fb5af892c579593e1cbc50
>
>
> I experimented with those commands, and 'sudo semodule -i
> netlink_xperm.cil' failed with following errors. I am in the process of
> figuring this out. In the meantime, if you know where the problem is,
> could you please let me know?
> Invalid policycap (netlink_xperm) at
> /var/lib/selinux/targeted/tmp/modules/400/netlink_xperm/cil:1
> Failed to verify cil database
> Failed to verify cil database
> Post process failed
> semodule:  Failed!

The above error is for the netlink_xperm policy capability, which
requires a corresponding libsepol patch to define it for the policy
compiler. For your testsuite patch, you would be instead using your
libsepol patch and policy capability name here.

> >> diff --git a/tests/bpf/test b/tests/bpf/test
> >> index a3fd856..aefc70c 100755
> >> --- a/tests/bpf/test
> >> +++ b/tests/bpf/test
> >> @@ -9,8 +9,10 @@ BEGIN {
> >>
> >>       $test_bpf_count       =3D 7;
> >>       $test_fdreceive_count =3D 4;
> >> +    $test_bpf_token_count =3D 4;
> >>
> >> -    $test_count =3D $test_bpf_count + $test_fdreceive_count;
> >> +    $test_count =3D $test_bpf_count + $test_fdreceive_count +
> >> +                  $test_bpf_token_count;
> >>
> >>       # allow info to be shown during tests
> >>       $v =3D $ARGV[0];
> >> @@ -67,6 +69,13 @@ ok( $result eq 0 );
> >>   $result =3D system "runcon -t test_bpf_t $basedir/bpf_test -p $v";
> >>   ok( $result eq 0 );
> >>
> >> +# BPF token - BPF_MAP_CREATE_AS, BPF_PROG_LOAD_AS
> >> +$result =3D system "runcon -t test_bpf_t $basedir/bpf_test -c $v";
> >> +ok ( $result eq 0 );
> >> +
> >> +$result =3D system "runcon -t test_bpf_t $basedir/bpf_test -l $v";
> >> +ok ( $result eq 0 );
> >> +
> >>   # Deny map_create permission
> >>   $result =3D
> >>     system "runcon -t test_bpf_deny_map_create_t $basedir/bpf_test -m =
$v 2>&1";
> >> @@ -92,6 +101,16 @@ $result =3D
> >>     system "runcon -t test_bpf_deny_prog_run_t $basedir/bpf_test -p $v=
 2>&1";
> >>   ok($result);
> >>
> >> +# BPF token - deny BPF_MAP_CREATE_AS
> >> +$result =3D
> >> +  system "runcon -t test_bpf_deny_map_create_as_t $basedir/bpf_test -=
c $v 2>&1";
> >> +ok($result);
> >> +
> >> +# BPF token - deny BPF_PROG_LOAD_AS
> >> +$result =3D
> >> +  system "runcon -t test_bpf_deny_prog_load_as_t $basedir/bpf_test -l=
 $v 2>&1";
> >> +ok($result);
> >> +
> >>   #
> >>   ################ BPF Tests for fdreceive #######################
> >>   #
> > At least on my system, perl tidy complained about some lines in this
> > file; be sure to re-run it and amend.
> I did run 'checkpatch.pl'. Maybe there are warnings I missed. I will
> take a look again.

For the testsuite, use ./tools/check-syntax to check for syntax
problems, and ./tools/check-syntax -f to automatically fix any. The
perl scripts are formatted via perl tidy.

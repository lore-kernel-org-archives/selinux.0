Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BEF18C332
	for <selinux@vger.kernel.org>; Tue, 12 Aug 2025 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003931; cv=none; b=LXhtFUINXLQ9S+gLjXDs+7MSBcn8YlypB5AdVfIAUqKH+R/BK+hHAUdGI7YMgXaqnCG7EjMNyTuCc7+MyeEM8L+3tGfZQsV5pZxqWzE2vI0cAnH10Bn4N74xat1mUbg4AQlbS4vzDQ5YmzRkjpy4M4YOMVP9cho3+QoKxTMtoqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003931; c=relaxed/simple;
	bh=Mw/FUIg3mNMjdearmPXFzmGdQTEpDsCbAvralp/uyRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuvDWRZVZOtp4eHprqQk5Z0oKVEoZjiijlCYf1de2xLHNCtWhR29TqtilP2Uepl0Q58jMNIfHFS89fhRcFaz+Jo21aelLZeJPWyDQL3jTJ7Y5uD3CzkkKucghDI8cecrfeJwkOqYAWLBmbAs2+a3nvuHJJWzMmf0/o/lkDgnCFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kO45KZtv; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO45KZtv"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31f02b6cd37so5686429a91.1
        for <selinux@vger.kernel.org>; Tue, 12 Aug 2025 06:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755003930; x=1755608730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sB2+Hd6W8t+bpRDy2Hx5iNZBHEIV9u8+xh8MBKPAHvc=;
        b=kO45KZtvzOufgxaozFlbj0gi3YPzj/gFXI40mOK5TQraM3htwVdIIQGeSb0Zb/aGyN
         HBYAdOYr17Cb4qH4MsR4HTlT2CMnZbDH2e3s1gkQdANnBEi7ZqQZVGtXvje6/Pq5mtGs
         /ofErdIwIgxL/jwyZDb6unz1S2KOCEP3RG8v17NxPblwnZ/L2RE7/PsykuzeKw38InjX
         kyy7/LQyZpAVDf9+nZ5qteUwwrWrA5H7BguP4VmfkX6J64ypGYPvDuJ8dSr59o2X3PcI
         QTPm+JsMo7C4hkJfp9shlDHkl4FyFzEFipM2dFk2qb3fjzbZym8p1nD9eoWOzjYPM7IQ
         DXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755003930; x=1755608730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sB2+Hd6W8t+bpRDy2Hx5iNZBHEIV9u8+xh8MBKPAHvc=;
        b=sMcKK9XPY/xfl8Uwxlk8ej4DAZouy33laWKR09NmhQskllOJOfWpaFBW4zCJFAQUxU
         oeeWVaXCgKuqrE347ieHTB0WT6//LA7bmFti5JmwbfXOIOBD3zFNBBf1zXcNbTMJtvrK
         8cAc8rG5r2kHUQJ3Q8n7hMh0vNaRlqazOCeGWrt+IMvigdQiLMm71e33552D08rSIDz9
         DBu7QA9w1RaFFeIJQ/lFhc8gEMfjb7vFboXwwxqF77hXmpyqRJVbdUgvAsJdFrAMuinH
         i3fugh9wP9SJunHmZwBmv556kC1DE33rVtikGX7yycAI+AZz9on2Yzh1FSSYrTptGu33
         PWvw==
X-Forwarded-Encrypted: i=1; AJvYcCUrhfdnXWATh7ZnMJ0irZGFz2fOYBB1ZRTdMU+B9EMMIKbl3e8uNAxIUlqezvJHbGXkeqscpjt7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy64lUxBN3U1VLsYbqHAAKJIbzffu65YkGOEybKobwFwAH+3AMD
	l3u4Mstqv8PdJG8G+RvWOyfesEJ2NYOOtm/Xqxsk8cvNlBzSOglOnaBRXIURPT0QJwPZ8wuRG6O
	XTYdDIJXlVGd5dKv6oTilI9A0l4k3AR8=
X-Gm-Gg: ASbGncteruF31yuFqjKdP9P1qWanvuDOWi+ivHqgzJrmYGIc6fY+s1TAapBhLnXBhWZ
	iL0Xow9UHikzvBmuI6xTo7Y+8dYFno3y8iNJd/BH/5LQQiq+w/UUvmoNaAl20L7LMhaChpxuTA3
	WGQCq6GQXHSda2RZVX/uU/0bhbo7C0g5RoGIbr6aGeoxkR8W0k348CWYLIK2JrBMZGWIWju8Enf
	swk/4c=
X-Google-Smtp-Source: AGHT+IE2iad8kiLZmJ20fpKPRcC5hkMwW54U37qvhTNFiUswjIxFGG2KgAdUAPQqSB6DwPlNGZ/63E42P+D0JqNRIGU=
X-Received: by 2002:a17:90b:35c8:b0:31f:3cfd:d334 with SMTP id
 98e67ed59e1d1-321839d7834mr24493796a91.4.1755003929266; Tue, 12 Aug 2025
 06:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808184711.291-1-ericsu@linux.microsoft.com>
 <CAEjxPJ6SBAy8yi8XhASR5pVFnYfvJhFujzGfBQuS9o2TziOSFw@mail.gmail.com>
 <8cd1865a-6220-471d-826d-e4908b39f229@linux.microsoft.com> <CAEjxPJ69ee3c33jQsE39QeHk9q2ADNYtf2nyry3-8pu1F0zCkg@mail.gmail.com>
In-Reply-To: <CAEjxPJ69ee3c33jQsE39QeHk9q2ADNYtf2nyry3-8pu1F0zCkg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 12 Aug 2025 09:05:17 -0400
X-Gm-Features: Ac12FXw2Cy7etVF41jzKqVSFjZqp0wA7CrhxX6P_mJQP-w5tA9PeXKREMVRFxvA
Message-ID: <CAEjxPJ4g+oCmvPxou4EyfdLMBuSMNDkoBLBM5LqpP_mSKr6_VQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/bpf: Add tests for SELinux BPF token
 access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: danieldurning.work@gmail.com, selinux@vger.kernel.org, paul@paul-moore.com, 
	omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 8:18=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 11, 2025 at 2:36=E2=80=AFPM Eric Suen <ericsu@linux.microsoft=
.com> wrote:
> >
> > On 8/8/2025 12:59 PM, Stephen Smalley wrote:
> > > On Fri, Aug 8, 2025 at 2:47=E2=80=AFPM Eric Suen <ericsu@linux.micros=
oft.com> wrote:
> > >> This patch adds new tests to verify the SELinux support for BPF toke=
n
> > >> access control, as introduced in the corresponding kernel patch:
> > >>    https://lore.kernel.org/selinux/20250806180149.1995-1-ericsu@linu=
x.microsoft.com/
> > >>
> > >> Four new tests are added to cover both positive and negative scenari=
os,
> > >> ensuring that the SELinux policy enforcement on BPF token usage beha=
ves
> > >> as expected.
> > >>    - Successful map_create and prog_load when SELinux permissions ar=
e
> > >>      granted.
> > >>    - Enforcement of SELinux policy restrictions when access is denie=
d.
> > >>
> > >> These tests are located under the tests/bpf directory and can be run
> > >> using the standard SELinux testsuite workflow.
> > > (added Daniel to cc since he also posted a testsuite patch and thus
> > > should be included)
> > >
> > > As I mentioned on the other thread, you should include instructions i=
n
> > > your commit message for how to temporarily define the requisite polic=
y
> > > capability and new permissions to run these tests; an example is
> > > linked from the SELinux kernel wiki Getting Started page and my other
> > > email.
> > > That alone isn't worth re-submitting this patch but see below for mor=
e.
> > Stephen - I followed instructions in this example to enable new
> > permissions and capability:
> > https://github.com/SELinuxProject/selinux-testsuite/commit/023b79b8319e=
5fe222fb5af892c579593e1cbc50
> >
> >
> > I experimented with those commands, and 'sudo semodule -i
> > netlink_xperm.cil' failed with following errors. I am in the process of
> > figuring this out. In the meantime, if you know where the problem is,
> > could you please let me know?
> > Invalid policycap (netlink_xperm) at
> > /var/lib/selinux/targeted/tmp/modules/400/netlink_xperm/cil:1
> > Failed to verify cil database
> > Failed to verify cil database
> > Post process failed
> > semodule:  Failed!
>
> The above error is for the netlink_xperm policy capability, which
> requires a corresponding libsepol patch to define it for the policy
> compiler. For your testsuite patch, you would be instead using your
> libsepol patch and policy capability name here.

Also, if you are using a non-Fedora-based distribution and it is just
too much work for you to provide the same style of instructions, just
explain clearly what you did prior to running your tests to enable the
capability and define the new permissions in a manner that can be
replicated by another, so that we can test it ourselves. Thank you.

>
> > >> diff --git a/tests/bpf/test b/tests/bpf/test
> > >> index a3fd856..aefc70c 100755
> > >> --- a/tests/bpf/test
> > >> +++ b/tests/bpf/test
> > >> @@ -9,8 +9,10 @@ BEGIN {
> > >>
> > >>       $test_bpf_count       =3D 7;
> > >>       $test_fdreceive_count =3D 4;
> > >> +    $test_bpf_token_count =3D 4;
> > >>
> > >> -    $test_count =3D $test_bpf_count + $test_fdreceive_count;
> > >> +    $test_count =3D $test_bpf_count + $test_fdreceive_count +
> > >> +                  $test_bpf_token_count;
> > >>
> > >>       # allow info to be shown during tests
> > >>       $v =3D $ARGV[0];
> > >> @@ -67,6 +69,13 @@ ok( $result eq 0 );
> > >>   $result =3D system "runcon -t test_bpf_t $basedir/bpf_test -p $v";
> > >>   ok( $result eq 0 );
> > >>
> > >> +# BPF token - BPF_MAP_CREATE_AS, BPF_PROG_LOAD_AS
> > >> +$result =3D system "runcon -t test_bpf_t $basedir/bpf_test -c $v";
> > >> +ok ( $result eq 0 );
> > >> +
> > >> +$result =3D system "runcon -t test_bpf_t $basedir/bpf_test -l $v";
> > >> +ok ( $result eq 0 );
> > >> +
> > >>   # Deny map_create permission
> > >>   $result =3D
> > >>     system "runcon -t test_bpf_deny_map_create_t $basedir/bpf_test -=
m $v 2>&1";
> > >> @@ -92,6 +101,16 @@ $result =3D
> > >>     system "runcon -t test_bpf_deny_prog_run_t $basedir/bpf_test -p =
$v 2>&1";
> > >>   ok($result);
> > >>
> > >> +# BPF token - deny BPF_MAP_CREATE_AS
> > >> +$result =3D
> > >> +  system "runcon -t test_bpf_deny_map_create_as_t $basedir/bpf_test=
 -c $v 2>&1";
> > >> +ok($result);
> > >> +
> > >> +# BPF token - deny BPF_PROG_LOAD_AS
> > >> +$result =3D
> > >> +  system "runcon -t test_bpf_deny_prog_load_as_t $basedir/bpf_test =
-l $v 2>&1";
> > >> +ok($result);
> > >> +
> > >>   #
> > >>   ################ BPF Tests for fdreceive #######################
> > >>   #
> > > At least on my system, perl tidy complained about some lines in this
> > > file; be sure to re-run it and amend.
> > I did run 'checkpatch.pl'. Maybe there are warnings I missed. I will
> > take a look again.
>
> For the testsuite, use ./tools/check-syntax to check for syntax
> problems, and ./tools/check-syntax -f to automatically fix any. The
> perl scripts are formatted via perl tidy.

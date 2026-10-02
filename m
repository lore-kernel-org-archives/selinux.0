Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6892D5C68
	for <selinux@vger.kernel.org>; Fri,  2 Oct 2026 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951462; cv=pass; b=ZpyO4UpEpUjJ9YZF2rU3/43KwTcLQfmUshzua83UcmRDdYd5J3umCtE1gxuwCzqab3xfeXnZ4jnDIMUCKy6+T/c8rcYVbhfAt8S4akKM9avbjIvd+murvNS5wj/wz/ltYM8DYeY8+RS61Ss0z5BbDYUIxwzcfCACF8v/U0qS+Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951462; c=relaxed/simple;
	bh=xIYcpKxuBGzRUan7Xn6WI1KDuAf6KTNeUEIpEXAj2YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUCwQyCqshxu9BwpS1nQVeuxIrXI0Lmpjhk8w/AlUayZBHQhfcAkpM5ziiqWBR9zEfs40ZswCbKhuMwl+NcwgbsbVWvUvlG0jJiI/ovUYcbKNHW8en6536TPMKulq2CW/+1EvIBx0836Xgy/b0geVvM3j5dxtKkXyEnPLUztQ7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwxTI+hE; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwxTI+hE"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8ab46253999so48809237b3.2
        for <selinux@vger.kernel.org>; Fri, 02 Oct 2026 07:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790951460; cv=none;
        d=google.com; s=arc-20260327;
        b=pE5xcq41tPkYpYKDl2yR4flZZuCh5oDc3SV16dex3ukaZB0CLg2e++H89qH1bEnDUd
         8O1hLXo2Tsl+xC6UV9CWSN7Pgw18qC5gGgP92uqISTDkfb01BO3AVuhgi1Iv2nmb0BMu
         kxA2+oBUWHczRIePHNEKufYN0Ytss+yqGv53GMQ/LKy0hebNQ85Gh8HUYqCvvljP+VyE
         8P20eDecNG09Dh4ATNM4G/UfjbZSR50lORw91RrU0jtMh8hG1DA06TCAjjO0qECmRZQl
         YMH01s07ClPCZMRMHfUgrCclwC7gXZag2YX8DwfGMTpcjWEzNb2aNDTb+6TZWwOxE1uI
         tv3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3fxmA9FZAw1uBnlr/aoukGDRiEu5GXYQDL4xf67OQtw=;
        fh=OUbBEH133zFuN6mlBCCH+gcSK5T7Z5g0RHaKVLhh0II=;
        b=ANSIw+Bw7ubisMcgFM6Xd9jlOO3gGHvmLlVcMX/vh3H3gd2Cnhk/6AMOalMw2wjnz0
         WwA/iIbRt5xbt6WSOuvl4XfmO5A4859HWCVzk5AqpfyA6KSxxmCFeKW1c3NNWSiwGseB
         reDIHlWOfhNB7Wr+TJ1td1BQObWgaHNCfqzqGJDWF1zyOaduMAP8x1I0ZDvfaZ+vsTKm
         ln/hgQ9Vf7mUy90gC8K51T5reZHNkNNaBHSFtPThB5ttiXQI61iK4exTu7XauljCOWDr
         VmN4lFeKVf0LI9M2MHhzDpEY+fzbmZW1JOpFG5Nrap7dnlmG3EZsbYecqdTeHv4HCtti
         YL2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790951460; x=1791556260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3fxmA9FZAw1uBnlr/aoukGDRiEu5GXYQDL4xf67OQtw=;
        b=EwxTI+hEKvZK5f7rHVbiSXgwuEmIEuIgPUgjyh0fWppnHiRVvSDfgNIvsjo1YJQdPj
         oLc0jeADozj9YSqK36PCGH0YQTl0T/r++I75oikCQCcwBFjdFLh8N+Hm/OD/MwaEOnji
         JycSVyrpyclPt0/1nmiThkyTWPOGeGNv/CKI/YXj3FEj7SgkKYKZVhKqapYIIWyARk2P
         yaJg/iFxlrByndr5qG9kOXrQmEad+9Z0IHHU/udOPZLWSQ1YECETA7bUNu5ofi9XWdJC
         3TnQZnniyiA+VDzqCXgVGEINnxF+DGUMaj+eDGfAcOkxAXKrsDH+EIu6zl77EDc8LYav
         t6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790951460; x=1791556260;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3fxmA9FZAw1uBnlr/aoukGDRiEu5GXYQDL4xf67OQtw=;
        b=idsg4ket8VAQo/WKY8fbY0F9jhSprVTUpV8OE/FPFN2sBK+k9hxl/ZFk1jnhmcK1IK
         artygpcGkN3t/2+390OYHulxzA3xjmhEP4jFOwgkzOCXiHGCxvF+2RWuwgN+kGCADmst
         Tlkp3cLrWo8oxVfpr2gyU5bcPDzQO0OlDDpxk6cMmVDkwtXuoDCT+wmrLdvpWmPIeZij
         DQ6Z+d5YyN2+bUXyIZenUU29n1aWriPd5TlOvR5GH91tbIGCdVV9WT5Lf0WD6bjQwAFe
         IfpT6JK9AOxqx+nnTSeg/gP1NFbysp8Ldt9OonwP0D1yK0xP8WDqIasuHtfN4eR+amWV
         wHdQ==
X-Gm-Message-State: AFuF++k8G+YPaSoDpsFMepifIfjvAYoPS/J/WyWG0zB0rB8MBLRJUOYy
	4L08741s/xes1H+Q2zdRjWpgk5aCRtbaTk85h9ewEWTS86pryw1GytPIQioCbc6jKyuq9LMaPOW
	mH34ZdgWv6IiFZqcQJdxmT0lvF5icVMU=
X-Gm-Gg: AYBFou0/YPvggws5dea0ZKLhroyfLOzp2yxg08U5qFVQuGqj8Mzmu5NjhV5Ivqrl3Ty
	GBX/HvWssc2V6ZfK1Y2V1Jlb2uXk+QOlNGWqKs4Z5y5stkK1ISSy3kVrPP6JQzyw+/p/G1jwOY9
	KZ4FLIGoZsB1wvGNSTlemteZDM31qnYQVjfQrOafT10bfLRA42ZHlMCzxPAseD4iHKfabt2WydK
	jSERWKmr+uHw/hW58uLvMkRy9LJn9/ZMYYUdO7yWCsCmMtA+U1wjq/ckz9aVxgyHEu+xWRfY9Of
	43fZhA/W25fx/MYrZPPLjtYBbc7XUr8cFBqV1qOJdVxuKE0SL1zO964=
X-Received: by 2002:a53:ec8f:0:b0:674:2df2:ef6c with SMTP id
 956f58d0204a3-677ac03eab2mr942563d50.18.1790951459999; Fri, 02 Oct 2026
 07:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001153212.102261-1-bgrech@redhat.com> <20261001153212.102261-2-bgrech@redhat.com>
 <CAEjxPJ7jsTmPNgrVd56P6tSh2akQ=vM5SMYNaG6+jEirSPruEQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7jsTmPNgrVd56P6tSh2akQ=vM5SMYNaG6+jEirSPruEQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 2 Oct 2026 10:30:48 -0400
X-Gm-Features: AclHuK-_wy28Hsbj0WPJumi_XJbadgI65gax8Rm_AbwsDfTgv4PPLjarfFniRwg
Message-ID: <CAEjxPJ6BwqhTQ-02vKWtumVEXN1jCniw9F5d7XGqHxrEzg_iig@mail.gmail.com>
Subject: Re: [PATCH 2/3] tests: skip io_uring when unsupported or disabled
To: Brian Grech <bgrech@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 10:13=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Oct 1, 2026 at 11:45=E2=80=AFAM Brian Grech <bgrech@redhat.com> w=
rote:
> >
> > Gate the io_uring SUBDIRS entry on liburing.h being available at build
> > time. Runtime kernel support is checked in the test itself instead of
> > via /lib/modules/$(uname -r)/config: that file isn't reliable for
> > hand-built/booted kernels. Since the kernel.io_uring_disabled sysctl
> > only exists when CONFIG_IO_URING is set, checking it at runtime covers
> > both the "not built in" and the "administratively disabled" cases
> > without relying on the config file.
> >
> > Also fix a latent bug from converting to Test::More: ok($result, 0)
> > treats "0" as a test label, not an expected value, so it silently
> > inverted the pass/fail logic for the "should succeed" cases. Use
> > ok($result =3D=3D 0) instead.
>
> Nit: this file was still on "use Test;" before this patch, so the
> ok($r, 0) -> ok($r=3D=3D0) rewrite is a consequence of this patch's own
> Test -> Test:More conversion, not a pre-existing bug.  Also see
> comments below.
>
> >
> > Assisted-by: Claude Code:claude-sonnet-5
> > Signed-off-by: Brian Grech <bgrech@redhat.com>
> > ---
> >  tests/Makefile      |  6 ++++++
> >  tests/io_uring/test | 35 ++++++++++++++++++++++++++++-------
> >  2 files changed, 34 insertions(+), 7 deletions(-)
> >
> > diff --git a/tests/Makefile b/tests/Makefile
> > index 084c788..d53684a 100644
> > --- a/tests/Makefile
> > +++ b/tests/Makefile
> > @@ -172,9 +172,15 @@ ifeq ($(shell [ -d /sys/fs/selinux/class/memfd_fil=
e ] && grep -q 1 $(SELINUXFS)/
> >  SUBDIRS +=3D memfd
> >  endif
> >
> > +# Skip when liburing-devel (providing liburing.h) isn't installed to b=
uild
> > +# against. Runtime kernel support (CONFIG_IO_URING, io_uring_disabled)=
 is
> > +# probed by the test itself rather than here, since kernel config file=
s
> > +# aren't reliable for hand-built/booted kernels.
> >  ifeq ($(shell grep -q io_uring $(POLDEV)/include/support/all_perms.spt=
 && echo true),true)
> > +ifeq ($(shell test -e $(INCLUDEDIR)/liburing.h && echo true),true)
> >  SUBDIRS +=3D io_uring
> >  endif
> > +endif
>
> I'm not clear why we need/want this - liburing-devel is stated as a
> build dependency in the README.md. Not strongly opposed but not sure
> we do this for other stated build dependencies?
> Not sure we want to silently skip tests because we forgot to install
> something required by the README.md file. Open to other maintainer
> feedback here.

Actually I see that we already do this for keyutils so I guess there
is precedent and this part can stay unchanged. The other comments
still apply.
>
> > diff --git a/tests/io_uring/test b/tests/io_uring/test
> > index dd97027..36e1d49 100755
> > --- a/tests/io_uring/test
> > +++ b/tests/io_uring/test
> > @@ -1,17 +1,38 @@
> >  #!/usr/bin/perl
> >
> > -use Test;
> > -BEGIN { plan tests =3D> 11 }
> > +use Test::More;
> >
> > -$basedir =3D $0;
> > -$basedir =3D~ s|(.*)/[^/]*|$1|;
> > +BEGIN {
> > +    $basedir =3D $0;
> > +    $basedir =3D~ s|(.*)/[^/]*|$1|;
> > +
> > +    # kernel.io_uring_disabled only exists when the kernel has io_urin=
g
> > +    # support built in, so a missing sysctl means CONFIG_IO_URING isn'=
t
> > +    # set. A value of 2 means io_uring is administratively disabled ev=
en
> > +    # for privileged processes. Check this at runtime rather than kern=
el
> > +    # config files, which aren't reliable for hand-built/booted kernel=
s.
> > +    my $io_uring_disabled =3D `sysctl -n kernel.io_uring_disabled 2>/d=
ev/null`;
> > +    my $sysctl_rc         =3D $?;
> > +    chomp($io_uring_disabled);
> > +
> > +    if ( $sysctl_rc !=3D 0 ) {
> > +        plan skip_all =3D> "io_uring not supported by this kernel";
> > +    }
>
> The kernel.io_uring_disabled sysctl was only added in v6.6 while the
> SELinux io_uring class/permissions this test exercises have existed
> since v5.16. On a 5.16-6.5 kernel built with CONFIG_IO_URING=3Dy the
> sysctl doesn't exist, so this will skip_all a test that currently runs
> and passes.
>
> I'd suggest treating a missing sysctl the same as 0 (run), and probing
> the "io_uring not built in at all" case directly - e.g. a tiny probe
> mode on the iouring helper that just does io_uring_queue_init() and
> exits 0/1, run unconfined like 1/3 does for netlinkcreate. Then the
> sysctl check only needs to handle the "=3D=3D 2" admin-disabled case.

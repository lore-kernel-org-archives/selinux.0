Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FD74A0EEF
	for <selinux@vger.kernel.org>; Mon,  5 Oct 2026 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209731; cv=pass; b=d3693l8GT00blY2rnnPYysrdjV7hDV4+BEXZnE+YBbawlElYl08U5rYLFQsdwa4/70NPSBZlb/j5Mb1ac2ej1e1H3Alrrx/jqNwBxeX6hXCKV5LyHWLozjsi3pstMKQKCLZt5Kvlw7lg1XEy5hcw/MYOekweH0YtxBlZ12vRzJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209731; c=relaxed/simple;
	bh=Ox95JFU+19HMdrAJWANC8CkMA9U5U2FzVnL+zl18tIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tR+Pw3l4/uEemd99oQoq9S1VeuTcIg89Ql3+2bRwVOtOeU7yMVdpkPwlTd9sWbJdNIbqTGn0ZmVD/+COXaphZAXxDOVEcb9ecmTV3PhyncczmaUnprHZSLA9bb8lm5ip0ejD+XWv0/3tAMeX3EpNONlGR5e/E6a/Ou/+83TfIho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQrPZTCM; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQrPZTCM"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-677c9e8ddb2so1489927d50.2
        for <selinux@vger.kernel.org>; Mon, 05 Oct 2026 07:15:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791209718; cv=none;
        d=google.com; s=arc-20260327;
        b=qpO9eBeb9LgKgsvjmWA+VTIMraXTzAeWv3kOsGcsFVBkNVHkZzRKIk/NslaFp/u2M+
         qebmq+l0cEzCW0W6Ddfp3sbX9MompvCAgcPfENBn41pQpxni1EOQzr7Z/ZP+FA7hYplw
         MSFEq4471mDRwRWsO5VykySeOOY5TV7JAOYc5Es8NjJWXhqVscahep6Tnjc4SSQqKayi
         oq5KUp4n/OEFLoL43wTuqAcKqwV7z6PeJORrN3tIifB3FPRD58n4VNAEnKSs+dNnphnu
         Jz/0DdqUF1m9GW/54sR6JGSUQlIZaq50P3e+EbbgoffYenWx+S91LjDuNSN3raa7us3/
         XJDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a8GpNInp4A9Zc2R+iqTaR1beU12XBFnpDppDF+qXi9o=;
        fh=E95boLTiTkq8XsjKw8GK1wyz25DmW0RgNCvDUxEAbME=;
        b=XeB600oFCBnGlm8X1RLFAk1we875NIzu7G5xOc0ti/q+6+Tx90opa++K0bBsB7HXym
         +vEB0B2vxLVkNgFmse8jgBqLerALY356BzlEGpQu0tgsV1usfsZlnsIG9JTfvj0HFkz3
         pdlJ1vX7H/yuI1Sk3kwZD+lsXMjkaOfbU4k0vHeTpUp4+dg/36a6X8sdB58ag5EBIg5p
         VzVJh8lva+iJDa776B7J/fL4ORXMDkyrQn8RS5EpYsPEuK74WUT/Pbt8bjsDsvCHWQQm
         fS+IQhYSQ/29xhRwwxSvlbpfimMPbbq2y1VUbiqL16QvWt4Wh2ueOfO59RpBD/kwzYlz
         zUBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791209718; x=1791814518; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a8GpNInp4A9Zc2R+iqTaR1beU12XBFnpDppDF+qXi9o=;
        b=TQrPZTCMFd7m4vHbZc6CB0yHfnTIVim+LXp1HD+NSEjLWMBBzkTamqp8SjRX6SbnSa
         1ofjJuNTYaTsc0GgceS/1ddgz05brVKBA7qJfDnL3x7exZcDh21725u0YM2Gy/K7YmSG
         H1ZXl9XfaB2ygdwWZHlKFjCD0qC+jIW2QmFCg9ONSGUpgh0T3aId/oH1hyBiwfW9WQym
         eWvEVDa8o1qR7kbsJ1MGDo7Fkx81xqIgcKfOWOMChzMlzWYFxbpGmayrAEcbkIsruRg/
         QsJys1VtrGDbU1APyJRc6QL14YJ2tsGFiYydI6Ajf8QCcTge4vXD7+ERa8fK+z547iWH
         ltqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791209718; x=1791814518;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a8GpNInp4A9Zc2R+iqTaR1beU12XBFnpDppDF+qXi9o=;
        b=Zw6OlYjqpK5YDJ4nIgQAV+g5SNwACOt2SImynBBqC/XBchCkGEegxbxD19qmC5CYne
         VNs2GvUf5EPnLpO8nbg97nrJSEVJnx2uU1WyNvDvLKxmMklo2pC6FtF32MaPmJ4jNTti
         GStPvefiUUsgOB3HFduQoJRfl2NS5GNf8Ynev+RJGqiUs6hy1WWZEFbTJu5fl2Oa2Nj1
         T4jDAgWc2lIvnmmWO/5whRNGEbGlcWa1qjIo35OPx/mrTsi6l4wzIfc9iKXrBMgloryP
         KqHCt3PHwvpHdofMjffBpobM+P0EgUjCyd3TuVufbVkuEkQ8RnkYPq5wtuxKY+i8Xd0D
         K3Hw==
X-Gm-Message-State: AFq9FYL87O+H9ip26cQTEgh12lN22QcmpCuzpK1hfjPHcd/OEy6ODHWG
	NVZ2LVDAKDJU8WHMvpXdvKzA8jkT/VCXU5jWe9yv1DyuF7HZQhNrxlccfdB4gobB8NhIO0iebs/
	YIQps6FQBq38RJIAxbG5PpVtGUOeCZr2tnw==
X-Gm-Gg: AYBFou2HqRzbBqrsKOk1w+yelFY9X0C/uIxKudC/KUoIoJBuukEXc5QcFgi1PQOCtqX
	/wycatxMMe17Z6PXVAKoJT5eX3J4N8j3NeHj3+VXh9Zda/669jAdN5kqvMr2sxyhszehPZ9zBiP
	bAebnsQrqeCBvqFU/ZFWWuPsUmwV8y/F+URoTJdE4Q5MUhCogB0qfvXLcNIgGgKaS6dLqj8Zrv/
	GLDOa1vF5AA1opyhqtgNa5G2JwH6s5G4dBof9n32kvnPrK2GIV1Kmoupzuy9PzDBwFB+EfAV5wu
	1MbwIdKGyiQNfRX7YWRsI+wIap50pFa8QhuNZcU1C/prZEe2KvGrmbSE
X-Received: by 2002:a05:690e:488e:20b0:676:97f0:b9ee with SMTP id
 956f58d0204a3-677bd1872e9mr1840837d50.7.1791209718325; Mon, 05 Oct 2026
 07:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001153212.102261-2-bgrech@redhat.com> <20261002154617.751470-1-bgrech@redhat.com>
 <CAEjxPJ4iGzxjwKZ+eBBeo_CfLFy1XNj8t3YMg3Fo0V_uRMz4Tw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4iGzxjwKZ+eBBeo_CfLFy1XNj8t3YMg3Fo0V_uRMz4Tw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 5 Oct 2026 10:15:06 -0400
X-Gm-Features: AclHuK_apDhiiI_jcq1djusAX-fYnK-woJBfKS1CtRWZzuufCCi3Aq8-1CzrEkM
Message-ID: <CAEjxPJ67EOYfbx=zthTM92y6mrZRZv+hb123chpu7kKJzYv8WQ@mail.gmail.com>
Subject: Re: [PATCH v2] tests: skip io_uring when unsupported or disabled
To: Brian Grech <bgrech@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 3:14=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Oct 2, 2026 at 11:46=E2=80=AFAM Brian Grech <bgrech@redhat.com> w=
rote:
> >
> > Gate io_uring on liburing.h at build time (documented dependency,
> > same pattern as key_socket/keyutils.h).
> >
> > At runtime, probe unconfined via a new iouring "probe" mode
> > (io_uring_queue_init()/exit()) rather than kernel config files or the
> > io_uring_disabled sysctl alone: that sysctl (v6.6+) postdates the
> > io_uring permission being tested (v5.16), so its absence does not mean
> > unsupported. Use it only for the "=3D=3D 2" admin-disabled case.
> >
> > Converting to Test::More also requires ok($result, 0) -> ok($result =3D=
=3D
> > 0): the two-arg form silently inverts the "should succeed" checks
> > under Test::More.
> >
> > Assisted-by: Claude Code:claude-sonnet-5
> > Signed-off-by: Brian Grech <bgrech@redhat.com>
> > ---
> >  tests/Makefile           |  6 ++++++
> >  tests/io_uring/iouring.c | 20 +++++++++++++++++++-
> >  tests/io_uring/test      | 38 +++++++++++++++++++++++++++++++-------
> >  3 files changed, 56 insertions(+), 8 deletions(-)
> >
> >
> > diff --git a/tests/io_uring/test b/tests/io_uring/test
> > index dd97027..fb6528e 100755
> > --- a/tests/io_uring/test
> > +++ b/tests/io_uring/test
> > @@ -1,17 +1,41 @@
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
> > +    # Probe unconfined so a failure here means io_uring isn't built in=
to
> > +    # the kernel at all, not that it was denied by policy.
> > +    my $io_uring_supported =3D
> > +      system("$basedir/iouring probe >/dev/null 2>&1") =3D=3D 0 ? 1 : =
0;
> > +
> > +    # kernel.io_uring_disabled was only added in v6.6, well after the
> > +    # io_uring support being tested here (v5.16), so its absence does =
not
> > +    # mean io_uring is unsupported - only a value of 2 means io_uring =
is
> > +    # administratively disabled, even for privileged processes.
> > +    chomp( my $io_uring_disabled =3D
> > +          `sysctl -n kernel.io_uring_disabled 2>/dev/null` );
> > +
> > +    if ( !$io_uring_supported ) {
> > +        plan skip_all =3D> "io_uring not supported by this kernel";
> > +    }
> > +    elsif ( $io_uring_disabled eq "2" ) {
> > +        plan skip_all =3D>
> > +          "io_uring is disabled via the kernel.io_uring_disabled sysct=
l";
> > +    }
>
> One non-blocking observation: with io_uring_disabled=3D2 the unconfined
> probe itself fails (io_uring_setup() -> -EPERM) so the first skip_all
> fires with "not supported by this kernel" and the sysctl elsif is
> never reached. Harmless - the test skips either way - just the message
> is less specific than it could be if the sysctl check came first.
>
> Otherwise,
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This patch has been merged but if you want to post a follow-up to
improve the issue noted above, feel free.

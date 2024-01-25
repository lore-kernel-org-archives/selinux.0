Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FDD1353F3
	for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212654; cv=none; b=T7iAk2k1O4jdvUtk0msrLPx02zc0ti7AQKYvcOhs+DRcyIpcLHP4Lu8eB082T61iDRtkZW8DXcRudcju5cKGePfSqh3HMMDGIcOfy6s1HtBmQoHBvZYVWwfvkgvQgeRL4namfhTSS1Mws5q3BUASndlXeN1Goh67cDfHPQ72oYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212654; c=relaxed/simple;
	bh=FxJb54iQxB7PN4ve38b/JVcO83mexZB3naeALWn8Bn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+NZ8AlEkFGg9DP69GQEyGbCOsZT/5k1Q2rDc3MMZ8CQ0x5uB9ROmVMnMe9BR8w4OMMdPJws9fjuIcWngkV6gExmJhZodByfWAew55A67yriVNFTL9kKCoWTj5/iZNBgjHEwduMVaVbgXKw31aQFfq3tpQKJiqCcAJAUgq1aJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH+wk9Mr; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH+wk9Mr"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-510221ab3ebso660726e87.1
        for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 11:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706212651; x=1706817451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8lzCDlRia3Nqxze0QO6R7I3lsbeZy8VQVSPPoHSxNI=;
        b=mH+wk9MrfLIXqpX/1kaI3yBZkwuH8+NlvM3blvrC3EGMUi1MFwoM3ouUhoexBwbV1H
         KJNSQhQ/uUzZpw8rV0RrYLVOod+4BNWjAdcW7WfG6ihIfpxN89SJSr3Qml+nEZttjH5S
         6eIU6cVq94mbUMhji8FeWkVB34CyVYfh/qEaucHEi2hBIwHb/XvTRSQ7CUnWZtdx5ncY
         PeIvP9APz0Zq+aMxB2eT/lmgmfqVTDelJsetxWtO971EEXmr9QReYEaWlgzc36oqAv2Z
         2Q2FrMLvRZ9XYYaraybhyNiXVd6ldf2ZPxopklrbEyN5XwhLPRSB+xy1t+Mfpp7Eb2m1
         ve1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212651; x=1706817451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8lzCDlRia3Nqxze0QO6R7I3lsbeZy8VQVSPPoHSxNI=;
        b=eXU7k94Ezvq5bq4F2EtPXOk2ZbL5VWiMSNCXPp79YseZVUaVMZSNf/qLod2YsDcj5A
         +1Q8E+rEOAvTO5nQbf5oGnTZKrZUJ9Q0cW1LNNT9VaVFtLBmvqrS2QDbsVbi7N35pu6L
         oSbK5asjIjhemqgxnnXhMpBwCpvX2ZkaYZi+yBVNg/Nub/YGgqMbl/y85w33dfazqnyP
         ZyKaFEDhkoKn4sdB9fvp+JWzL8d89fYJ56ntcV/aHZhLfckmhMNOagjLWsLHsWjA7YFz
         jtpCDDZQiMYckC77ghDTPYiRxWa4jOrSGBCI6KN5/BltsQmZycwFZtrz015+R8V4iIkG
         K66A==
X-Gm-Message-State: AOJu0Yzmt3nVXl36E5grd9498qdkYZepzqVbS82hVnI6fJdS+gMnUBRD
	NHBn3IvdFT0BU+UTeRh+ZFlQel2kFIdh7yAU1VRSTIqG+b5PDQkFND5I5xNuZk6Eabqmaet1y5P
	jY2jLSRt19YZHEgfli3oMZV6gpew=
X-Google-Smtp-Source: AGHT+IFnTAyURirZdUOKv9GhgSe6uhYVQdQ0kk4vBJRSSKv7mIBhJbKYJaMv+ghtzRCH18Im6dIx2WauGhCg7+RaK8U=
X-Received: by 2002:ac2:42c7:0:b0:50e:b1b1:430c with SMTP id
 n7-20020ac242c7000000b0050eb1b1430cmr190616lfl.116.1706212650666; Thu, 25 Jan
 2024 11:57:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108210314.339682-1-fontaine.fabrice@gmail.com> <CAP+JOzQ_UgiN=jxrMM+7wpprn+GrY=6yq_=6oN=KbVOX2-P9+A@mail.gmail.com>
In-Reply-To: <CAP+JOzQ_UgiN=jxrMM+7wpprn+GrY=6yq_=6oN=KbVOX2-P9+A@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 25 Jan 2024 14:57:18 -0500
Message-ID: <CAP+JOzSwqBjWtw2+oFSZ-ywun+Ka7KkBf6xsOx4rtubzSuadKA@mail.gmail.com>
Subject: Re: [PATCH] libsepol/src/Makefile: fix reallocarray detection
To: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:34=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jan 8, 2024 at 4:03=E2=80=AFPM Fabrice Fontaine
> <fontaine.fabrice@gmail.com> wrote:
> >
> > Pass LDFLAGS when checking for reallocarray to avoid the following
> > static build failure with musl raised since version 3.4 and
> > https://github.com/SELinuxProject/selinux/commit/f0a5f6e33084bd83d409bb=
7c932256139f471e71
> > because -static is not passed when checking for reallocarray:
> >
> > /home/autobuild/autobuild/instance-9/output-1/host/bin/armeb-buildroot-=
linux-musleabi-gcc -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET=
_BITS=3D64  -O0 -g0  -static -I. -I../include -D_GNU_SOURCE -I../cil/includ=
e -fPIC -c -o assertion.o assertion.c
> > In file included from assertion.c:28:
> > private.h:88:21: error: static declaration of 'reallocarray' follows no=
n-static declaration
> >    88 | static inline void* reallocarray(void *ptr, size_t nmemb, size_=
t size) {
> >       |                     ^~~~~~~~~~~~
> > In file included from ../include/sepol/policydb/mls_types.h:35,
> >                  from ../include/sepol/policydb/context.h:23,
> >                  from ../include/sepol/policydb/policydb.h:62,
> >                  from assertion.c:24:
> > /home/autobuild/autobuild/instance-9/output-1/host/armeb-buildroot-linu=
x-musleabi/sysroot/usr/include/stdlib.h:150:7: note: previous declaration o=
f 'reallocarray' with type 'void *(void *, size_t,  size_t)' {aka 'void *(v=
oid *, unsigned int,  unsigned int)'}
> >   150 | void *reallocarray (void *, size_t, size_t);
> >       |       ^~~~~~~~~~~~
> >
> > Fixes:
> >  - http://autobuild.buildroot.org/results/0170032548a38e2c991d62dc58238=
08458ad03b3
> >
> > Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> > index d80a941f..16b9bd5e 100644
> > --- a/libsepol/src/Makefile
> > +++ b/libsepol/src/Makefile
> > @@ -31,7 +31,7 @@ endif
> >
> >  # check for reallocarray(3) availability
> >  H :=3D \#
> > -ifeq (yes,$(shell printf '${H}define _GNU_SOURCE\n${H}include <stdlib.=
h>\nint main(void){void*p=3Dreallocarray(NULL, 1, sizeof(char));return 0;}'=
 | $(CC) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
> > +ifeq (yes,$(shell printf '${H}define _GNU_SOURCE\n${H}include <stdlib.=
h>\nint main(void){void*p=3Dreallocarray(NULL, 1, sizeof(char));return 0;}'=
 | $(CC) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
> >  override CFLAGS +=3D -DHAVE_REALLOCARRAY
> >  endif
> >
> > --
> > 2.43.0
> >
> >

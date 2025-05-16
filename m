Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C136282EE
	for <selinux@vger.kernel.org>; Fri, 16 May 2025 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747411679; cv=none; b=oMD6rgSIbNnSVYonj9At8zA/iqDM1n7XRdrjmnefUYu2vi4MfvVKp8cnMPZInIdA+7KblgyIW9c8IeZ7O/QEk6+EipkzbdjjOOfHbfKU6hOQCP4IJRF8rJ5xtVgJxZKW9wF36xycuX4PeFVPo/XQsooi9aTA8BUrl05LtX/WGUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747411679; c=relaxed/simple;
	bh=1fVxr2OLfHTu8aCgvtFqTJCn6V6t2GG4RDNO0EP0YXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=cF1VynCVC3Wxz02U7HC9obgwwmrUcCXYhOb3NwJE6E8nSMTmJFdGjxY+mj1xv+YoAtbHATGwAeR+kB8hlXotOMKiRNwpYJu9Nr7H58qlKkuOPMu0MMQTQ35HTTreLpmr2UvHDdZYBs/W0WMhEMs1qUH5cDdIRNdNpdQUzr1jmYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PZ7Wh3vB; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PZ7Wh3vB"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e72a786b1b8so2135996276.1
        for <selinux@vger.kernel.org>; Fri, 16 May 2025 09:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747411676; x=1748016476; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DAx/saqC7KRRRul9oldkicU1FqMFsiBHwkR68hnfyc=;
        b=PZ7Wh3vBVVJpzJrh7kUioBLKF5Lh0NQFPOZaLhSzR7piArYFDKr0DsoVSFqbOoCLjC
         ghl4RXmGKdl6tjeaRYjO2W60ccCRmijNi8jdTIxkM9efd7iMLysTSeRAvDSydymNnsx0
         DjELdHStohrBtYHdTReqh87zp3rwDXhCHQTGp6Y3dpwvO6Xgkn9etEBa7Pd5miVIj+4c
         rdWpeRTc6VOu/xZsWMJpJtN5xWvD3kKHs3Ro1RG2iINxfiVUVsH+WuCpdzkbV3aL/IX/
         gfV40siC598ddUyag/PZqO9JPjL+CUSAGw0JJuMtZIHvwF0cmP0djIxL1TtPTzDbSzXx
         avfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747411676; x=1748016476;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DAx/saqC7KRRRul9oldkicU1FqMFsiBHwkR68hnfyc=;
        b=JpXMEGZNn6JU/MMfQc1ETvEwlIeoAlYwecUAvNNrKnNm+198+fIzR4kyL2ASgtcagr
         7gUKuIAMkkYud942btKs0LBJw/9N+LRm63VrJjF5mPWICCii8EsKLuFoA2PCOW9+zF2C
         9l1zZg1JtlPVTduTFvuFYcsbI2Bcd6hw/TEDq957xbKC0AeGN3MSNFSr6wZ1FYsy3tzh
         v+tncjUX5MFq2MhMzuhxZIoNXqCBxiK9OIgCsU7svWvhHr0WqqXuCaN8HNKXTn8DcPx2
         v14WYM1E2U+8eysGoZCM2hFIrwwi/2NuTHbgJyG/+1lHgmPpwzESs9LcR4ACz2lpQeiC
         VbEg==
X-Gm-Message-State: AOJu0YxOBc3elH/xSn8dJys7N3Oc59J0Xk0fTWAou5wu/1ynvYlJXTib
	BxP34nhXvZkJWVrvqDDAhubu0jc6QNF0cDL3AUn0Q+j3MY23zgAprxotnB2ixcw6fZPHjMe+jLw
	xTnhgvJX+t95Ubs24/6T2mVz/V91ri84jJwFsapdCFOaxgB6GJEuqgA==
X-Gm-Gg: ASbGncvZXpkajf8CnPFh89T7rJ/Dsoe4/ImJK0ocVwWFqwSZqIKPms4bejRyq9zCIYM
	mJD7nHdRWKXvZbmeIowiB+gBOTZb1UjeVWBRAdnhKtaaFFwHLVykZAV2DyLLxkSR4TVYewm3vbK
	GOnv3hprss+JTO+D1BjXu+VaDxxQmYrAip
X-Google-Smtp-Source: AGHT+IH8XD9/OV++1/0mwc0zfReAZ8gEe7nK4Jfvn8R4osSwvBAUtkxhz5vfjeoxdz8StynxK63U0d7LIRwMJ94k6zo=
X-Received: by 2002:a05:6902:1142:b0:e7b:687d:4e24 with SMTP id
 3f1490d57ef6-e7b6b1bade2mr4974030276.15.1747411676010; Fri, 16 May 2025
 09:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhT4wrN6ProQmhv1pgF_TSPWOhbSf1WRi3Cm0_M0nu6x+Q@mail.gmail.com>
 <CAHC9VhQfEMo-8Mtugqy5=k=9QdBKrY-MQyqv3Mr2xuNd9F_3nQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQfEMo-8Mtugqy5=k=9QdBKrY-MQyqv3Mr2xuNd9F_3nQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 16 May 2025 12:07:45 -0400
X-Gm-Features: AX0GCFssLGzKTCbASrmp2D_cbSK81TKlcJDBCz_860jKLgiI2RdsdyKYRtjvM3E
Message-ID: <CAHC9VhSysh-p8-H=QWFj3mgqCvdw61Whu5Y5DDXZ7vE+atA-1A@mail.gmail.com>
Subject: Re: Recent selinux-testsuite failures in tests/mmap:109 (execheap/execmem)
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 11:44=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Fri, May 16, 2025 at 11:42=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > Hi all,
> >
> > Between Wednesday and Thursday this week I've started to see mmap test
> > failures in the selinux-testsuite, specifically in the
> > execheap/execmem tests, tests/mmap line 109.  From a kernel
> > perspective, their were only 42 non-merge commits between those two
> > builds (via 'git log --oneline --no-merges 9f35e33144ae..088d
> > 13246a46') and only one that looks like it might be somewhat relevant:
> > 11854fe263eb (" binfmt_elf: Move brk for static PIE even if ASLR
> > disabled").  However, going back to re-test Wednesday's working kernel
> > on the current Rawhide userspace, it appears that Wednesday's kernel
> > build is now failing, making me believe there was some userspace or
> > policy change in Rawhide which is causing this issue.
> >
> > Are the Fedora folks aware of any Rawhide changes which might have caus=
ed this?
>
> For reference, here is the clean test run from Wednesday, May 14th:
>
> https://groups.google.com/g/kernel-secnext/c/X2HxKsp7uR4
>
> ... and the failed run from Thursday, May 15th:
>
> https://groups.google.com/g/kernel-secnext/c/cU4zkQ_gwpM

Looking a bit closer at the RPM package updates between the two runs,
other than the kernel, the following packages were updated:

 cups-filesystem                   noarch 1:2.4.12-3.fc43
 cups-libs                         x86_64 1:2.4.12-3.fc43
 glibc                             i686   2.41.9000-13.fc43
 glibc                             x86_64 2.41.9000-13.fc43
 glibc-all-langpacks               x86_64 2.41.9000-13.fc43
 glibc-common                      x86_64 2.41.9000-13.fc43
 glibc-devel                       i686   2.41.9000-13.fc43
 glibc-devel                       x86_64 2.41.9000-13.fc43
 glibc-doc                         noarch 2.41.9000-13.fc43
 glibc-gconv-extra                 i686   2.41.9000-13.fc43
 glibc-gconv-extra                 x86_64 2.41.9000-13.fc43
 grub2-common                      noarch 1:2.12-32.fc43
 grub2-pc                          x86_64 1:2.12-32.fc43
 grub2-pc-modules                  noarch 1:2.12-32.fc43
 grub2-tools                       x86_64 1:2.12-32.fc43
 grub2-tools-efi                   x86_64 1:2.12-32.fc43
 grub2-tools-extra                 x86_64 1:2.12-32.fc43
 grub2-tools-minimal               x86_64 1:2.12-32.fc43
 mpdecimal                         x86_64 4.0.1-1.fc43
 setup                             noarch 2.15.0-25.fc43
 smartmontools                     x86_64 1:7.5-2.fc43
 smartmontools-selinux             noarch 1:7.5-2.fc43

... of these, glibc-1.41.9000-13 seems like the most obvious culprit.
Looking at the changes between r12 and r13 there are a few malloc
related changes, maybe those are the source of the regression?

https://src.fedoraproject.org/rpms/glibc/c/f8045b0b4178a0f1ccb8c275e83beb6c=
d9b3409e?branch=3Drawhide

Unfortunately, that's probably all the digging I'll be able to do
today as I need to finish up a handful of other things before the end
of the day.

--=20
paul-moore.com

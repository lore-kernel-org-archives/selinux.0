Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CE819006B
	for <selinux@vger.kernel.org>; Fri, 16 May 2025 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747425271; cv=none; b=BeN/8eSc+23OEvBMiO090ilkqpInb2p7NGM/kTYpZx+KMMNSCQ/bpaN6DQazSrWe9slna0hl0gvjBxNtkzVt67pMBwomTwCR/JIjL4aBlZqdjjoVsjYSbJI6de9Yfeif9uw+iJ8KU5xvyYOeoq5Ryz9U35vP0xJjGVS6NASvVKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747425271; c=relaxed/simple;
	bh=Sgv/itTEAdjcImKKBVlFSfNj7oElyLJpPlMPgLhcCgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJkifktFtu1mCL4oDIgkUHLuPfQOteyP9x/B2iBMc70D5vA33duBW6N5GLO5RyNMtiXGZlyeZNSWX8xQ2KvhwC4LIOmkvuC6ubUjQkOUJHZq6hI/98nyid32MHw5rhILC34LmTrdYUTP489czN0Du3o3MkYKH4cnZUKCqwlJkLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeVfulZJ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeVfulZJ"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-879d2e419b9so2333214a12.2
        for <selinux@vger.kernel.org>; Fri, 16 May 2025 12:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747425269; x=1748030069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OvoYsjDS0H/XcOCmeYPgrpHijRE6G6edaaFAuTsgyQ=;
        b=ZeVfulZJ5ovx+NZE7Q4cCW6XnBjo+UFV39mModmllhTb9IV8Lt0jPMMV6v7XeJFXja
         WL88W5H9MAjLwCXtHFNwmC955bh3qNyCjfHJC+TAc5I4zEX4wJwLncwdiQy7ocgFwkQ2
         IdJVnXbR8o5lGPNycpBOPQENOlsDNdHj7RUXKDSb3y8fIrYyGMfPW9N5tc+lKdDF+tCu
         5DxlwUU/hav7OC15WWf+lY+3zJyc1FPU9VDHpDM6HpMcxp8/NcEJesuun0JuRV0cpRB2
         UZiL5rdjADHE9tLeQIj94nO/ZddZMFkVeqVn5vCXp3+0eS8rmqLOMOwDWHlrAyDEtcwX
         hkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747425269; x=1748030069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OvoYsjDS0H/XcOCmeYPgrpHijRE6G6edaaFAuTsgyQ=;
        b=cxItpRc2vvi7cedBpbL4+zIXFCA6ZpLzGY9OSU2SnUW9opr6sumxX51KVvBI/zjsE1
         HiG90TByLkTF+0sCBn6HKsiBdtK1MdSTeab/L8aroHT+LScl+1gPCRMmeRNx2mmWsV5D
         1CI5hh9GDs3sUpFc2zN0Tzo2vM5+rGCLOI8GQ6xy0kcDK0arKiPql2SaF/SrTfaq6RVU
         t419O+QKGVnmHDwHkea5vufrMz5coPpaYe1a0msSFJrSYM+thme+A41vfA6mlZIPr6Wa
         QgSymBCTP0IWX7KA/f/6dsd7Fg/yfAkGk8Nl9SSqmuD9Ltm/ySeYc5mRZ+H2CXIyCfBl
         mt0A==
X-Gm-Message-State: AOJu0YzlFcjfEu0Nmx14NP/Az5wEX2dEO3xtYR7X3UtG1MKD00dTHQn0
	+EthpOpyoA9zY17YsMAA/uBQOhjLBdwXMxTJvNtHZglOx10ozpe0cLIyo1RVtGI64BUZUdRzqju
	DZV6EYH24d4CGSrc5h6b5G7d3vby6BlhlJA==
X-Gm-Gg: ASbGnctASbxFH33/3UjiQ2keyv0T4OVhhT4Epg5IG8ql3R0oKnZY2Sod7+6jge8DTBu
	xUnN/lpLPRXRrWBsVjbEG9Y/8fSNBSHXi7EBDW8v2OD5xhE+vucCQf4Y15azPpVB4SNzRM7N9o5
	HRPoK9qoJLP2vugsPUEjPrZ/pwz8BktfEf
X-Google-Smtp-Source: AGHT+IGWvkkbPO6SVT5eHZQlUNCqQVIvynxInLVSZEAaChxADN9MOPBsu5/ESfgYYhl2ta2zffi2mGx7LTscwOGS3mw=
X-Received: by 2002:a17:90b:38c5:b0:30e:9aa2:6d35 with SMTP id
 98e67ed59e1d1-30e9aa26ef5mr2669419a91.0.1747425269397; Fri, 16 May 2025
 12:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhT4wrN6ProQmhv1pgF_TSPWOhbSf1WRi3Cm0_M0nu6x+Q@mail.gmail.com>
 <CAHC9VhQfEMo-8Mtugqy5=k=9QdBKrY-MQyqv3Mr2xuNd9F_3nQ@mail.gmail.com> <CAHC9VhSysh-p8-H=QWFj3mgqCvdw61Whu5Y5DDXZ7vE+atA-1A@mail.gmail.com>
In-Reply-To: <CAHC9VhSysh-p8-H=QWFj3mgqCvdw61Whu5Y5DDXZ7vE+atA-1A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 16 May 2025 15:54:18 -0400
X-Gm-Features: AX0GCFufLP5MaM1n7tZoGLzdgSkkT3y74mhIT_M2I8cqqS-VSAxKMoR6ZZHrcBM
Message-ID: <CAEjxPJ7k8TjAp=Pmvb7EZ3of32DPyBLqJkSgWhN-wgS2v1-EZg@mail.gmail.com>
Subject: Re: Recent selinux-testsuite failures in tests/mmap:109 (execheap/execmem)
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 12:08=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Fri, May 16, 2025 at 11:44=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > On Fri, May 16, 2025 at 11:42=E2=80=AFAM Paul Moore <paul@paul-moore.co=
m> wrote:
> > >
> > > Hi all,
> > >
> > > Between Wednesday and Thursday this week I've started to see mmap tes=
t
> > > failures in the selinux-testsuite, specifically in the
> > > execheap/execmem tests, tests/mmap line 109.  From a kernel
> > > perspective, their were only 42 non-merge commits between those two
> > > builds (via 'git log --oneline --no-merges 9f35e33144ae..088d
> > > 13246a46') and only one that looks like it might be somewhat relevant=
:
> > > 11854fe263eb (" binfmt_elf: Move brk for static PIE even if ASLR
> > > disabled").  However, going back to re-test Wednesday's working kerne=
l
> > > on the current Rawhide userspace, it appears that Wednesday's kernel
> > > build is now failing, making me believe there was some userspace or
> > > policy change in Rawhide which is causing this issue.
> > >
> > > Are the Fedora folks aware of any Rawhide changes which might have ca=
used this?
> >
> > For reference, here is the clean test run from Wednesday, May 14th:
> >
> > https://groups.google.com/g/kernel-secnext/c/X2HxKsp7uR4
> >
> > ... and the failed run from Thursday, May 15th:
> >
> > https://groups.google.com/g/kernel-secnext/c/cU4zkQ_gwpM
>
> Looking a bit closer at the RPM package updates between the two runs,
> other than the kernel, the following packages were updated:
>
>  cups-filesystem                   noarch 1:2.4.12-3.fc43
>  cups-libs                         x86_64 1:2.4.12-3.fc43
>  glibc                             i686   2.41.9000-13.fc43
>  glibc                             x86_64 2.41.9000-13.fc43
>  glibc-all-langpacks               x86_64 2.41.9000-13.fc43
>  glibc-common                      x86_64 2.41.9000-13.fc43
>  glibc-devel                       i686   2.41.9000-13.fc43
>  glibc-devel                       x86_64 2.41.9000-13.fc43
>  glibc-doc                         noarch 2.41.9000-13.fc43
>  glibc-gconv-extra                 i686   2.41.9000-13.fc43
>  glibc-gconv-extra                 x86_64 2.41.9000-13.fc43
>  grub2-common                      noarch 1:2.12-32.fc43
>  grub2-pc                          x86_64 1:2.12-32.fc43
>  grub2-pc-modules                  noarch 1:2.12-32.fc43
>  grub2-tools                       x86_64 1:2.12-32.fc43
>  grub2-tools-efi                   x86_64 1:2.12-32.fc43
>  grub2-tools-extra                 x86_64 1:2.12-32.fc43
>  grub2-tools-minimal               x86_64 1:2.12-32.fc43
>  mpdecimal                         x86_64 4.0.1-1.fc43
>  setup                             noarch 2.15.0-25.fc43
>  smartmontools                     x86_64 1:7.5-2.fc43
>  smartmontools-selinux             noarch 1:7.5-2.fc43
>
> ... of these, glibc-1.41.9000-13 seems like the most obvious culprit.
> Looking at the changes between r12 and r13 there are a few malloc
> related changes, maybe those are the source of the regression?
>
> https://src.fedoraproject.org/rpms/glibc/c/f8045b0b4178a0f1ccb8c275e83beb=
6cd9b3409e?branch=3Drawhide
>
> Unfortunately, that's probably all the digging I'll be able to do
> today as I need to finish up a handful of other things before the end
> of the day.

The failing test exercises the execheap permission check independent
of the execmem permission check by allowing the latter. The fact that
it is failing indicates that the memory is being allocated via mmap()
rather than brk/sbrk(). The test code (tests/mmap/mprotect_heap.c)
explicitly calls mallopt(3) to ensure that the subsequent
posix_memalign(3) is allocated from the heap rather than via mmap().
This does sound like a bug in glibc.

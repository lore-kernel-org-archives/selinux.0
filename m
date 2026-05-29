Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA63F6606
	for <selinux@vger.kernel.org>; Fri, 29 May 2026 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066991; cv=pass; b=rLHxS4NJU6G0CiKcbSQXsKPEzgVG5Zueztvicm+TnUkn7vWfyZadm25u17hBCvMJUUruk3ymjTBl/QBkl5vhwYqDUis59jHGwTd8Ael6n8NoScA6Y2i6TBz53xF6mFIwr7Zqyom5KKPRWDM84osYPvGECiqULf9W6knTbBVygJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066991; c=relaxed/simple;
	bh=sD2sp5Fd/m3aMcscMqgGQ/6a4SBzjMWf4EFsAoqhvTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNrbj9HTWq3rrl9leVCwOLNYMJgkkelTIwvRSZgjIImjAhPn7kkvcUa8U6k5qBKblA6D6O/C6LCN6/ip+azG6GKNMjHY7MxVczQcQhFdmLCR6S2ReRDcObBaAtraBPJrXxAirpOJI/13OVT550Y2BBFFtMYn07YXmr+6MOWGITQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pcbd7eGf; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcbd7eGf"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bc7b311e77so65199115ad.0
        for <selinux@vger.kernel.org>; Fri, 29 May 2026 08:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780066989; cv=none;
        d=google.com; s=arc-20240605;
        b=SvZmwQaG4DjM1THEE5YDl5aYQ4vLdQ2r3OkjrEvolUOxw53xU//Cf7WBBFIc3/yIQx
         XmSw0mH5SksGBqEo3Whz2S5WrD1jxvSMuKr8kMSH8M/KvjnSxD2SAvIJ4cvnKow6PzRP
         8ujvx5y2UMSPJH2AOo2cl4A1BekKzX+1aKGKAl8V+okU2u0GlHs3fhelDob8J/85xZjC
         m5bL2hi61P1ushGKucmy/feeGHwKEJyaG+fr8yeSwX5g24Mx9iM+M1wxmSsxKFYP3YNf
         WSw0HV/3FZuBogIirG3R3xpnpgYczJJq9VCrSBbsHJOA/Bv09ek9Agv/x5rGKDxd1yIL
         w5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rkloP8gyiqjPfJtfZgrVZcCrdjQVQeCR6SSeI06FVbw=;
        fh=48Y2GVq+bwnFTZcWy3xq/EfpzmCmZMwsHYSsGVhKLdA=;
        b=Y9et0UeHiEa86ZuO2Mr+aDTooL3MCDVth2/Dx9Fx2fgbtCmJL5P/32xItlmFEtNOYo
         2+stPN9Ceuep4GTPKs91Q49QTJIZtV/ZNJRxe+KwFK+E27vFAk8mTTSLD16vL7E6qn3P
         D2sQsKEJy2dY9YhSrE6vEZpdv+LOX43SDFcrD9/JseOw8ad/UERpG9E8JIo4MDfRWcSG
         GreR/C3Pc2zT3Etk4pF/7i9KzZvsXhTMVHzAaRw0U9cMfX8dHxepjzZjkZiqyEgUOjbw
         RZiXgOEDzs/whOc265DgtyKGyQqT1UEP/OM8qc9zsvu/AUnp1vfgZTq1Qp+0mQ1/hoMC
         jhUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780066989; x=1780671789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkloP8gyiqjPfJtfZgrVZcCrdjQVQeCR6SSeI06FVbw=;
        b=pcbd7eGfnh2HaOrIvRh11+TuI/cZCeMdZhaTEPe2RsBCxspKH7K/qSHd2OKE1JFGu1
         4Gi2phGdR9dqWkhM5xuYzIFVR/Tx6dLYCJYQ4UfWTAad3A0LvniIS4Uc9E0vmsO2nLKJ
         g8SrDhyZCitQACJj2aAzmaMgpZG1EoVyRi60iWgJThWta/9L16QQj1EtWYAScHlmNVHR
         LEvH5HyrGqSmtHMKeuashgGfhZSMqoT5CQu1J6cD1wtHp7jqNrX9+56E+zWpfvr/DHBL
         Kppp9vKo2hoY2+mP/5GNzvtCD6bsDZvjP92qIeLBeCkr25NpmY8Bb1itOCFgyDfofTmB
         4Xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066989; x=1780671789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rkloP8gyiqjPfJtfZgrVZcCrdjQVQeCR6SSeI06FVbw=;
        b=bwXFIwJvnnxdEbjM3VTfHNWtO+qFfMTGbGVtbDcDoytBy9K7c/6qtKTd8iHFku8BdJ
         2yay7SJP9ld+uBNiSXWS7RxFrc8TL8sS1t6wotHTH5cVqSd3LoqtKVeKyRjR4pqUfDXa
         ZH9j84vjEC+PreHaCHYM0Mzl+KnpFIMoCTRyPWlN8QDlkp8sMDHd8TODcp9LoHvmt178
         A3GnTLqziIurTMFZNFiVsLuTuW2ZwTIqvi8Ca5a1rZWmaot9XWXTkCkOUvc+lhha/dgm
         kEe6PIYHPIUkW8cRg1IPX7euuv4vzxvVAvjoXPGu/rmHFp23K7fRqPWggHBSX0yIlGIC
         bCjw==
X-Forwarded-Encrypted: i=1; AFNElJ88JWOqFKysVf9hxa3/QMda8Me58QqNw6Wto0CSs5BxR3BEjNJ9TcNnqBzgddMIEAylWuam2Hqr@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx4g6i8LVUhUN5hIrMAn58Kh1XDQ2wJGczVdl07qUO3D4lLOuC
	Cg13f0m0sPmgO62gvsHryDcEmD9wRlyu0K7qe3VlJPy76O65byDlvbQhpx5nPMniNh448OI3Bwp
	LKINwwb6zPfNVd21e9D0EBOs1ErJc3IMPcQ==
X-Gm-Gg: Acq92OGVoRw7a+uNwd83fRD875KjNELDORqEhWBm/OczbzJevxHjL7ZiZF/Vb2fyrhI
	wjP74qD6vEJRWKoJB4JYe4Y1LXvuy49pavu/IwRsQ/abmd1KDW10nte1k4JLBWNC25AgnX9zdLi
	EwtMGoaayVTiUpzlNdo0gF4RDRvoX54ahAWNXGZQXYaD9QTxE25inuvIkXsvoUuqyPQKL5cq/Ua
	EuFKF8hAA6Z5gyC0Sv+ZgOXBXsTVkYACOgx68YMWH0tFwhOrfVX22hRiRiOwaARyBei2HggGw+A
	hxuc0ePijQm7vV3mKg==
X-Received: by 2002:a17:902:d4d1:b0:2be:1eb1:eaf3 with SMTP id
 d9443c01a7336-2bf20d9b4d8mr29381365ad.11.1780066988467; Fri, 29 May 2026
 08:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <03e5151a-f420-46f9-ad5e-109420132021@linux.ibm.com> <8f0c86f7-eab4-4e82-97c1-5d190c390770@linux.ibm.com>
In-Reply-To: <8f0c86f7-eab4-4e82-97c1-5d190c390770@linux.ibm.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 29 May 2026 11:02:57 -0400
X-Gm-Features: AVHnY4KKhuwSMumEj0Bb_Upfm-68zeF3D23iMS5HaXZrsLOyeIcIpCVE26AqncE
Message-ID: <CAEjxPJ7Y+9AqEVTJswUsan4OOP+DVkFG3vXukQVtcJZbVaoZnA@mail.gmail.com>
Subject: Re: PowerPC: Random memory corruption causing kernel oops on Power11
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, selinux@vger.kernel.org, rppt@kernel.org, 
	paul@paul-moore.com, LKML <linux-kernel@vger.kernel.org>, 
	Ritesh Harjani <riteshh@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 9:40=E2=80=AFAM Venkat Rao Bagalkote
<venkat88@linux.ibm.com> wrote:
>
>
> On 29/05/26 12:20 pm, Venkat Rao Bagalkote wrote:
> > Greetings!!!
> >
> > Kernel 7.1.0-rc5-next-20260528 crashes randomly on IBM Power11
> > hardware. Attached is the config file.
> >
> > **System:**
> > - Hardware: IBM 9080-HEX Power11, pSeries
> > - Broken: 7.1.0-rc5-next-20260528
> > - Config: 64K pages, Radix MMU
> >
> >
> > **Problem:**
> > Different crash at each reboot.
> >
> >
> > **Example Crash 1:**
> >
> > [    4.678016] BUG: Unable to handle kernel data access at
> > 0xbffffffefec10628
> > [    4.678112] NIP [c008000004e3c74c]
> > xfs_dir2_block_lookup_int+0xd4/0x300 [xfs]
> > [    4.678281] [c000000005eaf7d0] [c008000004e3c6d4]
> > xfs_dir2_block_lookup_int+0x5c/0x300 [xfs]
> > [    4.678363] [c000000005eaf850] [c008000004e3d56c]
> > xfs_dir2_block_lookup+0x44/0x1e0 [xfs]
> >
> >
> > **Example Crash 2:**
> >
> > [    6.327116] BUG: Unable to handle kernel data access at
> > 0x762f736563697695
> > [    6.327242] NIP [c00000000073cf34] __refill_obj_stock+0x74/0x2c0
> > [    6.327261] [c0000013ffdbfd10] [c0000000007418b8]
> > obj_cgroup_uncharge+0x48/0x70
> > [    6.327271] [c0000013ffdbfd50] [c00000000062fffc]
> > free_percpu.part.0+0x12c/0x630
> >
> >
>
> Git bisect is pointing to 54067bacb49c selinux: hooks: use __getname()
> to allocate path buffer as the first bad commit.
>
>
> # git bisect good
> 54067bacb49caeada82b20b6bd706dca0cb99ffc is the first bad commit
> commit 54067bacb49caeada82b20b6bd706dca0cb99ffc
> Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Date:   Wed May 20 11:18:56 2026 +0300
>
>      selinux: hooks: use __getname() to allocate path buffer
>
>      selinux_genfs_get_sid() allocates memory for a path with
> __get_free_page()
>      although there is a dedicated helper for allocation of file paths:
>      __getname().
>
>      Replace __get_free_page() for allocation of a path buffer with
> __getname().
>
>      Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>      Signed-off-by: Paul Moore <paul@paul-moore.com>
>
>   security/selinux/hooks.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> # git bisect log
> git bisect start
> # status: waiting for both good and bad commits
> # good: [e7ae89a0c97ce2b68b0983cd01eda67cf373517d] Linux 7.1-rc5
> git bisect good e7ae89a0c97ce2b68b0983cd01eda67cf373517d
> # status: waiting for bad commit, 1 good commit known
> # bad: [f7af91adc230aa99e23330ecf85bc9badd9780ad] Add linux-next
> specific files for 20260528
> git bisect bad f7af91adc230aa99e23330ecf85bc9badd9780ad
> # good: [7189ebc81d5e4cb4e03dc4040b07c582b95b09d5] Merge branch
> 'nand/next' of https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.=
git
> git bisect good 7189ebc81d5e4cb4e03dc4040b07c582b95b09d5
> # skip: [d22aa6f023f3fc275e1f994045a6b347288b2e5a] Merge branch
> 'watchdog-next' of
> https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
> git bisect skip d22aa6f023f3fc275e1f994045a6b347288b2e5a
> # good: [40d5349aaaae55ec62451bfacc6189cf44ce02cb] iio: adc: ti-ads1298:
> Add parentheses around macro parameter
> git bisect good 40d5349aaaae55ec62451bfacc6189cf44ce02cb
> # good: [6665ab5cf8e74edba571d3d2f31e575f89373dfd] Merge branch
> 'next-integrity' of
> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity
> git bisect good 6665ab5cf8e74edba571d3d2f31e575f89373dfd
> # bad: [4cc60db652df7ae5d659ec23325c341a52d065e0] Merge branch
> 'driver-core-next' of
> https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.g=
it
> git bisect bad 4cc60db652df7ae5d659ec23325c341a52d065e0
> # bad: [e1d469c38defe7fcb8c6f62a2b7dbf4a103da300] Merge branch 'master'
> of https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> git bisect bad e1d469c38defe7fcb8c6f62a2b7dbf4a103da300
> # good: [4678d11f294de0fd295a265e02955b5d1a4a2684] Merge branch into
> tip/master: 'x86/tdx'
> git bisect good 4678d11f294de0fd295a265e02955b5d1a4a2684
> # bad: [9397e02d718fc52703d753f489042293cd807dd3] Merge branch 'next' of
> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
> git bisect bad 9397e02d718fc52703d753f489042293cd807dd3
> # good: [c574bdb524095d24169e229b2e3b9318c72e733a] watchdog:
> ziirave_wdt: Use named initializers for struct i2c_device_id
> git bisect good c574bdb524095d24169e229b2e3b9318c72e733a
> # bad: [5568ff6b5e30c7736c24e2096e968c8785c2c245] Merge branch
> 'for-next-tpm' of
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> git bisect bad 5568ff6b5e30c7736c24e2096e968c8785c2c245
> # bad: [23f6b2756d28e76464c7e87850d3d4f6d8c8b365] Merge branch 'next' of
> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
> git bisect bad 23f6b2756d28e76464c7e87850d3d4f6d8c8b365
> # good: [ecf41f6218b58c72f1511e395e480f70a9f44889] selinux: reorder
> policydb_index()
> git bisect good ecf41f6218b58c72f1511e395e480f70a9f44889
> # bad: [54067bacb49caeada82b20b6bd706dca0cb99ffc] selinux: hooks: use
> __getname() to allocate path buffer
> git bisect bad 54067bacb49caeada82b20b6bd706dca0cb99ffc
> # good: [2f0af91353cb64b54cfee5423820d2149039338d] selinux: check for
> simple types
> git bisect good 2f0af91353cb64b54cfee5423820d2149039338d
> # good: [bc3f08d1ef15ebbd32faf0b10cd9699b90b9d30c] selinux: use
> k[mz]alloc() to allocate temporary buffers
> git bisect good bc3f08d1ef15ebbd32faf0b10cd9699b90b9d30c
> # first bad commit: [54067bacb49caeada82b20b6bd706dca0cb99ffc] selinux:
> hooks: use __getname() to allocate path buffer
>
>
> > If you happen to fix this, please add below tag.
> >
> > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

IMHO that commit should be reverted:
__getname()/__putname() exist for a different purpose IIUC.
__getname() does a kmalloc(PATH_MAX...), whereas we are then calling
dentry_path_raw(..., PAGE_SIZE) immediately afterward.
This assumes that PATH_MAX =3D=3D PAGE_SIZE.

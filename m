Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885F933B6D3
	for <selinux@vger.kernel.org>; Fri, 29 May 2026 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067962; cv=pass; b=ipsdWJV0cxX0VZtJ9OzKehUKn1RridaDe34yFwAHKLFMubFOTWB6oAtk0t1Ui8tGtDYP5eb22+Z4iYRf/QNFNDRW09HL56+CM4rtRM6tKbvUbfer6apZxFBDum2vGxW/X/bIQD3zvH8rkhS945PD5FXiX5cPHByVonWn3g0MkVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067962; c=relaxed/simple;
	bh=O0dQrRfKu7DZ0wLoz3IfBJ5KWgZhtg27pwJcoXJw7GU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oe5pTD7xfDtJssu+Qqd2xAuHOn2sc2j69q727+nAfN4TTfU6+z9ZBhDSbVG42Msq4mZID1lvAg8ep+8upZaO1p1/eTV/e13QzPawGShwUsP5voJATwjXthLyFuv2OIeDNPSNNfoQ6K4N5OW0Ii+S/HSg8T801DJZFuNfFskDGO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrzUZeil; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrzUZeil"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b9d265355so982014a91.2
        for <selinux@vger.kernel.org>; Fri, 29 May 2026 08:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780067959; cv=none;
        d=google.com; s=arc-20240605;
        b=l2XkyC/YXwC0ztkdK9xDeHK8DLcV/S1DATHLC75MvpjUySCnFldbyGfM8M0cXmUoD3
         L+4pZ0Xh9amiafux/fsRxzc7A2BLkOWhi1AHasWCiIMk9oiCteow8x2zgLQEQzyhuKGI
         tW9OLyKaWcQ1kKSd5x+3n40k/QJz+tcWSvqj7N2KhFRGWmVVHE3J63+cCcUe/MaM9ohA
         hJhJ0rUZY4C55EsZkw9pYezJqOos5WykUAbvUh5ojKBrrhnY2bk+iE9YN3GnEae3zNG9
         hOo5rOwDL9vPhwEjWb6GE9y64jYn1lSmBwiBqI0wozGnD2h50TQOFGCGP6mEGwGDQwtb
         6cCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2owhYFzqEdnmJRzJHqL7bcogL5Wx2hBSfTuEFRaXkiw=;
        fh=5rvIC4HuAhtIDvZUHFcdTrvP3nMxXoZREjC8ojJ1uIw=;
        b=Fe6YJNEfk9I0Kdd8VZxk94XNsMhseNhi5ZofT9m/dVce4QCCZg9qQMM9zAfrU6Eo+l
         xHRNJoZX2ikBb6qxfHk85avnBqE5HKMKH77IvVoxN1M+cB7VvBZ8bUZlCILPTPW1Oa0Y
         08L4u0zFM4++2ualU0AnvvMabEqWjt4d9vNCF0/++JXMRsGoJ64+Rtj3f5w6M3B+6Wfi
         bIGtRiIXMB9TJ/OLR97ElcZ2bUZFY1CMcB+Cqbi16qjMgNTsR7DhrmUQPqC0mU5Bo6l+
         ZYECAzqtzd9hEXmUzeiSTv4XoJilxG+KRqA0bv4YKbLDScRa1UDyTossJt8Buo7tU/On
         4CGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780067959; x=1780672759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2owhYFzqEdnmJRzJHqL7bcogL5Wx2hBSfTuEFRaXkiw=;
        b=GrzUZeilFzMNUMaTAQVhpUZb1wABaKzbHPUUOlsaHg+BEGfJuOVZ6eUojbBdGc+avo
         KmDx4ZsEbGOFN3Qqxoa57X7VCwI/d4d9KPrDrez5swS0pj4sl2dhRofYAI8X20VuH37L
         493xqoHyZmhcNhgfAbAurBKGl2lCtSVdXn6eYUjY3ssCFhd12oYfSltClBb6+5QdaTXt
         Lb7JP10217atZhHuUn4k/aBO3q7MH5lSXMiluVecjasgH8GaKmYcuQCpFl00cPGzTSY1
         56+RrmPnD+TwslZiRV3mqDbhlzbd2j8WsOI8XtcKdi7RMUuBhvBHwLFiFjpHw4ukkR0D
         6B4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067959; x=1780672759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2owhYFzqEdnmJRzJHqL7bcogL5Wx2hBSfTuEFRaXkiw=;
        b=HppAGlIkYp1cfid5iJwgefpb1JDUk+VMgTUv3OzmjHrn0zMkNjuPrxj0O0JQ4TLVcM
         53t9QqLa4a21VXTegO2pQ3T9uCTdV9BqyHsK80TOo1RXEdNdF8zMjISOp1Q1K62dOl2o
         XFx/lBbhd2MoT7ZEpeVYSzMEiuquW3bfJwSGV1mZPiiAiJT5fi50+7qXDIsg0GVRIBZO
         8fRZ+2lGGXGFdPSzkBdnt+qC+ilJ+EByjft2upogqvkrDXnOxZlS9A1QXWj2fltMEkv6
         Y7sMoY6f9muuoxN6Ig0z30rNjFDvyTQR3+PJV/lHSMfIa7ziYtNEwiHJglyDtzKzIvdW
         r4eQ==
X-Forwarded-Encrypted: i=1; AFNElJ86Ckb5q8x+w1nrmEznNeYffUsC5Nx991lb1e8roqM96Iy0AKHRBJHNg/A0RIGlMmT38pYLlqLz@vger.kernel.org
X-Gm-Message-State: AOJu0YztOtat0PBMtJYN6Fjnxse2A3M72MBLkgcwmtZJhiS0nlgSheI2
	J7bNa64gBPHz+lhzxSpeE97qNHZ9R2M/wTRaoUT+ZkWOn5KkIbufOmEkRzCNWoR2ym4o1K8sOzX
	9zopIeD2P+GeicT7TOxc1dWMBaZ0oMTw=
X-Gm-Gg: Acq92OHBkLjY8kWpQWX+eYgBRc5pPb206C9VSUChdSDTft90wNsYGq7N5BQIYmMkZ4G
	5pW/fIwq6VxJ8yO1Vqev0k6U9unFmsSy/MAMRYb+hMkcLcen4UUK7F9tbyFbWPnjOGWqr+h7TwC
	ONpRR+1Dbjf6YOTfnyRUO6HXRgC9BJwqiT+O+bp0QGdLmtYuLKKyjx6vFSxo+ychnGA2R0/UgCK
	us4D9052EjTFtkGkHBIjRlvZ3A/1Qz6QV6noEsG3VPJNi4TuyNI2B3nyoAwzcxyG26okTEvnmFI
	J9sN3/iNMI832UZbvw==
X-Received: by 2002:a17:90b:3c8c:b0:36a:aeaf:ab2f with SMTP id
 98e67ed59e1d1-36bbcd8d10bmr4058853a91.17.1780067958690; Fri, 29 May 2026
 08:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <03e5151a-f420-46f9-ad5e-109420132021@linux.ibm.com>
 <8f0c86f7-eab4-4e82-97c1-5d190c390770@linux.ibm.com> <CAEjxPJ7Y+9AqEVTJswUsan4OOP+DVkFG3vXukQVtcJZbVaoZnA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7Y+9AqEVTJswUsan4OOP+DVkFG3vXukQVtcJZbVaoZnA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 29 May 2026 11:19:07 -0400
X-Gm-Features: AVHnY4J6nOssXw6WTCpePKiW6ZYhuQX4NXL74uANAzOPBXePIgJ2MHkIEU-kwQQ
Message-ID: <CAEjxPJ6DqhHKdjwC3ddZfUK4HVPwOTzb1Kkuabi5WmwmF8Lu_A@mail.gmail.com>
Subject: Re: PowerPC: Random memory corruption causing kernel oops on Power11
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, selinux@vger.kernel.org, rppt@kernel.org, 
	paul@paul-moore.com, LKML <linux-kernel@vger.kernel.org>, 
	Ritesh Harjani <riteshh@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 11:02=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, May 29, 2026 at 9:40=E2=80=AFAM Venkat Rao Bagalkote
> <venkat88@linux.ibm.com> wrote:
> >
> >
> > On 29/05/26 12:20 pm, Venkat Rao Bagalkote wrote:
> > > Greetings!!!
> > >
> > > Kernel 7.1.0-rc5-next-20260528 crashes randomly on IBM Power11
> > > hardware. Attached is the config file.
> > >
> > > **System:**
> > > - Hardware: IBM 9080-HEX Power11, pSeries
> > > - Broken: 7.1.0-rc5-next-20260528
> > > - Config: 64K pages, Radix MMU
> > >
> > >
> > > **Problem:**
> > > Different crash at each reboot.
> > >
> > >
> > > **Example Crash 1:**
> > >
> > > [    4.678016] BUG: Unable to handle kernel data access at
> > > 0xbffffffefec10628
> > > [    4.678112] NIP [c008000004e3c74c]
> > > xfs_dir2_block_lookup_int+0xd4/0x300 [xfs]
> > > [    4.678281] [c000000005eaf7d0] [c008000004e3c6d4]
> > > xfs_dir2_block_lookup_int+0x5c/0x300 [xfs]
> > > [    4.678363] [c000000005eaf850] [c008000004e3d56c]
> > > xfs_dir2_block_lookup+0x44/0x1e0 [xfs]
> > >
> > >
> > > **Example Crash 2:**
> > >
> > > [    6.327116] BUG: Unable to handle kernel data access at
> > > 0x762f736563697695
> > > [    6.327242] NIP [c00000000073cf34] __refill_obj_stock+0x74/0x2c0
> > > [    6.327261] [c0000013ffdbfd10] [c0000000007418b8]
> > > obj_cgroup_uncharge+0x48/0x70
> > > [    6.327271] [c0000013ffdbfd50] [c00000000062fffc]
> > > free_percpu.part.0+0x12c/0x630
> > >
> > >
> >
> > Git bisect is pointing to 54067bacb49c selinux: hooks: use __getname()
> > to allocate path buffer as the first bad commit.
> >
> >
> > # git bisect good
> > 54067bacb49caeada82b20b6bd706dca0cb99ffc is the first bad commit
> > commit 54067bacb49caeada82b20b6bd706dca0cb99ffc
> > Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Date:   Wed May 20 11:18:56 2026 +0300
> >
> >      selinux: hooks: use __getname() to allocate path buffer
> >
> >      selinux_genfs_get_sid() allocates memory for a path with
> > __get_free_page()
> >      although there is a dedicated helper for allocation of file paths:
> >      __getname().
> >
> >      Replace __get_free_page() for allocation of a path buffer with
> > __getname().
> >
> >      Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >      Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> >   security/selinux/hooks.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > # git bisect log
> > git bisect start
> > # status: waiting for both good and bad commits
> > # good: [e7ae89a0c97ce2b68b0983cd01eda67cf373517d] Linux 7.1-rc5
> > git bisect good e7ae89a0c97ce2b68b0983cd01eda67cf373517d
> > # status: waiting for bad commit, 1 good commit known
> > # bad: [f7af91adc230aa99e23330ecf85bc9badd9780ad] Add linux-next
> > specific files for 20260528
> > git bisect bad f7af91adc230aa99e23330ecf85bc9badd9780ad
> > # good: [7189ebc81d5e4cb4e03dc4040b07c582b95b09d5] Merge branch
> > 'nand/next' of https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linu=
x.git
> > git bisect good 7189ebc81d5e4cb4e03dc4040b07c582b95b09d5
> > # skip: [d22aa6f023f3fc275e1f994045a6b347288b2e5a] Merge branch
> > 'watchdog-next' of
> > https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.gi=
t
> > git bisect skip d22aa6f023f3fc275e1f994045a6b347288b2e5a
> > # good: [40d5349aaaae55ec62451bfacc6189cf44ce02cb] iio: adc: ti-ads1298=
:
> > Add parentheses around macro parameter
> > git bisect good 40d5349aaaae55ec62451bfacc6189cf44ce02cb
> > # good: [6665ab5cf8e74edba571d3d2f31e575f89373dfd] Merge branch
> > 'next-integrity' of
> > https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity
> > git bisect good 6665ab5cf8e74edba571d3d2f31e575f89373dfd
> > # bad: [4cc60db652df7ae5d659ec23325c341a52d065e0] Merge branch
> > 'driver-core-next' of
> > https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core=
.git
> > git bisect bad 4cc60db652df7ae5d659ec23325c341a52d065e0
> > # bad: [e1d469c38defe7fcb8c6f62a2b7dbf4a103da300] Merge branch 'master'
> > of https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> > git bisect bad e1d469c38defe7fcb8c6f62a2b7dbf4a103da300
> > # good: [4678d11f294de0fd295a265e02955b5d1a4a2684] Merge branch into
> > tip/master: 'x86/tdx'
> > git bisect good 4678d11f294de0fd295a265e02955b5d1a4a2684
> > # bad: [9397e02d718fc52703d753f489042293cd807dd3] Merge branch 'next' o=
f
> > https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
> > git bisect bad 9397e02d718fc52703d753f489042293cd807dd3
> > # good: [c574bdb524095d24169e229b2e3b9318c72e733a] watchdog:
> > ziirave_wdt: Use named initializers for struct i2c_device_id
> > git bisect good c574bdb524095d24169e229b2e3b9318c72e733a
> > # bad: [5568ff6b5e30c7736c24e2096e968c8785c2c245] Merge branch
> > 'for-next-tpm' of
> > https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> > git bisect bad 5568ff6b5e30c7736c24e2096e968c8785c2c245
> > # bad: [23f6b2756d28e76464c7e87850d3d4f6d8c8b365] Merge branch 'next' o=
f
> > https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
> > git bisect bad 23f6b2756d28e76464c7e87850d3d4f6d8c8b365
> > # good: [ecf41f6218b58c72f1511e395e480f70a9f44889] selinux: reorder
> > policydb_index()
> > git bisect good ecf41f6218b58c72f1511e395e480f70a9f44889
> > # bad: [54067bacb49caeada82b20b6bd706dca0cb99ffc] selinux: hooks: use
> > __getname() to allocate path buffer
> > git bisect bad 54067bacb49caeada82b20b6bd706dca0cb99ffc
> > # good: [2f0af91353cb64b54cfee5423820d2149039338d] selinux: check for
> > simple types
> > git bisect good 2f0af91353cb64b54cfee5423820d2149039338d
> > # good: [bc3f08d1ef15ebbd32faf0b10cd9699b90b9d30c] selinux: use
> > k[mz]alloc() to allocate temporary buffers
> > git bisect good bc3f08d1ef15ebbd32faf0b10cd9699b90b9d30c
> > # first bad commit: [54067bacb49caeada82b20b6bd706dca0cb99ffc] selinux:
> > hooks: use __getname() to allocate path buffer
> >
> >
> > > If you happen to fix this, please add below tag.
> > >
> > > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>
> IMHO that commit should be reverted:
> __getname()/__putname() exist for a different purpose IIUC.
> __getname() does a kmalloc(PATH_MAX...), whereas we are then calling
> dentry_path_raw(..., PAGE_SIZE) immediately afterward.
> This assumes that PATH_MAX =3D=3D PAGE_SIZE.

Alternatively, I suppose we could just update the dentry_path_raw()
call to also pass PATH_MAX, but
I don't see why we want to use __getname/__putname() instead of just
direct kmalloc/kfree here so
the size of the buffer is immediately evident to the reader.

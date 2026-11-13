Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564237;
	b=wXAG+xavaGVGpRP+BzUKzjCKQD6DnVz4pdY99Ws/JuA292XwLVFTIihNVPthWgPUQ0xV
	 K7jhIxBZlpM4CtP/vZmR0s7u2dc3TXvqTG6g9ifPGE0Miw4lm78pewJaktmwm5xDrcm6N
	 uOXVyNTueSoi0vbGyXnW+nTSib6dWOrRqbLMG8FpRKItX0Re1xswJzV1pQ1eDwa+fY69f
	 HAiOkZ0zfs2JqfCnFUoN8MQszO4M1+5EhSTdcJERecRgo4U19108VxajnaVfwapKQJXO+
	 V+jOpAtjx0BTDPrsm8ZMB2qes9ENzjPyu1WbPt8eNbOLpXl/TV6pgbYC6qcs2oILuxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=isfwHOSFEU1THdAtyjNR/BymwB+TGu4CpGjFt5oul8o=;
	b=0aBQxRg5M8JB4/Zp+Q7gAzcyYqXzEY5B8MdJV8TctRuAgMSLj85PLIVM1NaQrfiqXD3I
	 4fSd7bu4txmkrFNmcJNmGcl/KL+3S3c/FaNkUaIbDOLhV7jz8ccjUHKu7UD1z/SnkElYp
	 65hr84Adls2BYV7krAp7f9B8XiQsS3+MlllVHc9RZ/pxOnQf9lK19WtVqg8BSRUJa1jaD
	 v4YDRuvtt8qkzM43E/6nkXOiQiMMs8N+bBJV9fa6nMcEwYPNaF2CdCcU3ufTlUyst+i3u
	 ezgwGr3DSFBl8i6/CilsBgnR77XzUbjNv7QA8t6OJAbs0Uqu/i3JkmPt8G4dCinOb9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HmOhZp1a;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C84606A88D
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 10:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2C84606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HmOhZp1a
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b6f42095bcso1441624a12.3
        for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 02:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564235; x=1795169035; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=isfwHOSFEU1THdAtyjNR/BymwB+TGu4CpGjFt5oul8o=;
        b=HmOhZp1aysVRSGcApaAZDLI81xyeSldeu7ePLUPKkH54FsFfnK+QDVFY4+VQQZDD5I
         H2HloBZm5LZmO+0yz1W9rfEhaL+YICMUwpLNmuFaGXNfAv5LYB2fsAN36refSeHGX9fO
         cryYVQ+kM2KCw8u+OcP3112ltvgpCHGvfl9d9GfdLtqmNcwNDmKz3KTPAT46qO03zj8M
         uuWZNkUaGTWe7Ooua9eiEAKQiiHx3qf0rn/l3lNWMOa2sfege5hzg+R5XNTSj8AN0bpY
         dCBAZCrR4vjcQdomnF2hzC3FA98LaruL1WYTiCQ1DC9kzlEXZqoLyeQdM7U6VrMRD1VV
         Lr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564235; x=1795169035;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=isfwHOSFEU1THdAtyjNR/BymwB+TGu4CpGjFt5oul8o=;
        b=kfbkQ1tbwDThKXCZ9PjV6FnuPicD7zA7KpN3x0vdpomg+8StJX++zr4TZFcF0EP+9n
         B0O+Qxdseimd8vjPYCa5cOyjp9egF4RG0XgovqSFIm3nZJqvwNjN0UjodQzrYqhP8GRx
         upgymeWyw6ys39mGH2ANQvDzn4A00Y1XtsbFnSLdcmaEmkBb35MTrSGa4H7D7/kPkfX4
         7hlXhKlcW2GiihE3Y4YYCc92Ny5+vwXg+xv0IdLmprAVf94ZFMyUQIJ+KONMFQiSA+Ow
         h+AC3hk7NETBYkp8lBU7w/kHbMseKdBgVWuVi+Mm3BOrXlFzR4XT4EGzQqhS5CCf/pZ3
         pyog==
X-Forwarded-Encrypted: i=1; AL+hErHST91Aks2n0/cE53mMkBDhPkuR/htaFLcc/ukTxp7JIOY+zZUmEba7oBeGi8yIMZE7EpwIpnud@vger.kernel.org
X-Gm-Message-State: APuU4Z9FdjuXyrZ4Fg0+1W4E0emZOxjQss3hTH+wqge5aJDolOvUwtbt
	N+RXrUFennw72ODP9WStPeRg5dsAXSNLodFqNdbUyjvSsheEgzt+1Wev5LX4okVLr6dB
X-Gm-Gg: AYBFou3EtFh/5w2uTHBw06ZEKWFvjEhbtZftVFFLszJBTQLX4TIapNREYLZhVhOtdIo
	mGzVUxzFiSDDWp2nCtGYSgO2rvtBlb3knQr9+LQ0n6peBtdv6BW7S5ijN/CPz4IjQNbJGEnURii
	YKcZuHtzkPrca/RTqJDVQVhXDqQGR305bmiLrbEyRYXBnUMwqnKayjk5Ju+hQJtRKMd7z/P1/Wd
	I5oF+n+Nx2EJqCVU/6UUoeMFSt52+aeoLwPQ4Ox9938Sa6JW6FsLCU+nBpsPS4LXOj/Ev2l/JGr
	nN3A5LKBigB7gI24jrDG8fLMVFo65Z7Ya4pLtvNCG6HsrbiTg97+MV796On+0uMoYZtDbYQpjom
	Gav1sDouOLDSyryLB7M7o7XFGVhEBiFK1qoRvxAe9gjomlnwAj+chHEDPU94yQ/hvNWK58Vftxq
	2EYBiHPWVz2CAI4XUjFXFxYA4s9UWLO3NlUMIri4tBBYRo9udJsNFWHxjmfQW08+YGgtGY02Xmc
	xdp4QHUXahsa4wUEBDQeP26iSam1jEEqFQkUZIuTc3Qt9uAo3dcaeDcDZBR8BBb68MmpgHRMmnB
	YBVneBlRhIx9QBYmjAL/08vxPVwv8jO/o8QQoIQlUnxDZugcL2o5sBtZFAMtV2w=
X-Received: by 2002:aa7:d556:0:b0:6b5:96e9:ae97 with SMTP id 4fb4d7f45d1cf-6b7c0ccaafdmr1234919a12.34.1794564235160;
        Fri, 13 Nov 2026 02:03:55 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23611casm766458a12.9.2026.11.13.02.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:03:54 -0800 (PST)
Message-ID: <16dbddeb5cbb9613dc806b43fc681eb26aa3b0dd.camel@amutable.com>
Subject: Re: [PATCH RFC 10/41] nullfs: use fc_init_pseudo()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:03:52 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-10-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-10-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Initialize nullfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/nullfs.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nullfs.c b/fs/nullfs.c
> index 319c2f5c5a67..2fe24cb97160 100644
> --- a/fs/nullfs.c
> +++ b/fs/nullfs.c
> @@ -2,6 +2,7 @@
> =C2=A0/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
> =C2=A0#include <linux/fs/super_types.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/splice.h>
> =C2=A0#include <linux/uio.h>
> @@ -174,7 +175,7 @@ static int nullfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0{
> =C2=A0	fc->ops		=3D &nullfs_fs_context_ops;
> =C2=A0	fc->sb_flags	|=3D SB_NOUSER;
> -	fc->s_iflags	|=3D SB_I_NOEXEC | SB_I_NODEV;
> +	fc_init_pseudo(fc);
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0

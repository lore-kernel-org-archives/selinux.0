Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564206;
	b=mEmSbNoXcy6CgorxzO6JWRSL5tp9Kt9qRJRsu78mNbD9jyqhJv3G63vhq9Q+WeVUS6Mu
	 9k5OvFiy73olSyCMSK6pFdSYWvrt/F8wQ5vsRZA1z/xXFqkWrx2rh89PjoIjHBFK9Otj3
	 ZDRofL32IBJXeFjEnOqreyORk2sAxBwbdtJy1nQDUFulz+luR1TbdSoZ+fXofusUzfKVM
	 m+qK4P3nIvTlBvmLsTGpD2LX+3i96UGvcEXVkA1xhGRTtdUMNsOk00/YEqUDQhGAy3wd4
	 d3Wnm0h1EOVeuBwdEj53AhOZKGTg8d1UKfUngSfrOGl+skk2xaRx78wQS4ys41f6lnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=yP9dZgkD4P/bNBFnmHOgKVBIpz9VJZUP73dl9853V04=;
	b=TNie/vdVR2aT8rpi72xCNXcGI6MiYS4bEdaMEUyz7qJyV+FzTME6WXxQQ5YBVACtgSoV
	 wpr1zlcLflxWmr0VAz6dlpeenMQO6YKdomF0y1ly+Oa/DdvpflrF8OxZsSoL8hI4yLH8/
	 s7LDhDj6UdycQJOTccAgFSAX7mwymzSVku6rK7s8cb4yAPgxc5Esx8ORWmulSBwmnVPOz
	 kUG9tjPreXsFecCrJauTVeWFFcvlrs+VM/Q3d4iRz3VOpBJbFYivN6RMDdOrcnq4liZ21
	 dniq9sDwKrOCq1HNte5qiZM7KyX8geTO2DpuhxcljzzZUPVynlS+fP0eVbrMP845nkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gwzE4vcd;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE48060A260C
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 10:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE48060A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gwzE4vcd
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b75712fb57so1193802a12.2
        for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 02:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564204; x=1795169004; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yP9dZgkD4P/bNBFnmHOgKVBIpz9VJZUP73dl9853V04=;
        b=gwzE4vcdu75novdCBouGsk6add5G1MbU4rjoUAUKLfhHjN16JXpL3TW62te0KeNQ4h
         CFkYIh/ZmfunLC+OqOwxPpTEErLMClrM1fcYGPQemfzJ8eoNcG0IRaMTNTZVl4uFMmTY
         NY1KgETdjv8quXYbE0ixE9wDZSzgcrDYvO5KUD1dPMwQkdJqOZ2wE5l6rVs/yjm1Qi5n
         44DBR0sdjAGKBFCF4ajO9UcYXSr02RfqiQv/3Y8VdogG9ka76OpTkDSlKx1J0txrvJw5
         RvPlb1UdQfd5RzPQ+F4LJqddQeogWrPEdkR1aa5XunF4ZwrUyeTcEOKG0iN98ugSQ46P
         5SDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564204; x=1795169004;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yP9dZgkD4P/bNBFnmHOgKVBIpz9VJZUP73dl9853V04=;
        b=1Q6/YcDKrCz3cv3u4Ws6yz155RBpgH1fSm32idhAc3w3oisPCB534ZpwsgdNG6Ewod
         UcH2xTSzhU9OEz6R3WxvOaexVvX24S0sk23veekV0ltegGTHgODV5vHg+lMOdzq+pekN
         eMayPmoh8he7wO7OdQhzA+VgW+8b4sxe0eJWSEbc5AvTFJTwMBhDi9OWjjphI+AOLRvL
         qPtM18s3cvH++Cd7s+TPhH1t0PUQP0wbEAD2Acw8zuiY/b6gBLxpH3iljFscduH2PBMT
         ZCE1ssoW2+LclntiWAPJlD8hp3NrDxFTUiSdOHCz+m/fQaHwNYGRyXG5iZGu4SuC3LMx
         c59A==
X-Forwarded-Encrypted: i=1; AL+hErGzWYdNMHDAK048oHEG8Q5LoB1eJ/bbm2MEPF5FH4qyvqFMG3dcoN8gf2Up55qbZEIRw/pqT9jF@vger.kernel.org
X-Gm-Message-State: APuU4Z8TNcQmi2B46rGn3c/8I2Ay3kJugmHAJFOZWETcDJ3BYXZgwM8d
	PFNHuXCKPu9yXNpkiYbachaVhlaO9NXM7fSKOvBmgs+l7HSAL+1UPRrcbuVbC4CKNguP
X-Gm-Gg: AYBFou2GVzQTbv7yM3WD5ZselR67zwliT3472lHWUUXNvqtUVmWYCHYEqhijZWB+/fp
	tuubqnb/y2n7wrHEAEWai6tsYzqkQONaJJYlya+IjJ17Z3xMe6Fb1avvhs5+Tc7QvM5paxuKxg8
	Yq0xgc2Aw9C7VeMrMtdblkiLwv7GeONE0MnfA9XJrJ3abuZROaLCEl+cbVQFGoVWv3CGT9JIUxs
	jawWQDscaRh8iguA54FAyP8ueabFSEroYmcERicEhnW00xlGP+QcvacXcfl35JVru0v6ZZ6bG/o
	7B5ORYTrBPl32hq170FfcswNSAYNC0o+yqj5Hy4tuB4VjhrhsAp/uqA7grI7CRhtLoZ48gManD4
	bVimg3KCd0lNI+0jTT+HdFjDrZfiLujvuWa1ENHbO14dAIRjofKbl0uCqo51jXQ8RdSoHmkwcDZ
	zHNnTaAdx1Nx+3bXpVSo4mRyG/dFtgpbsTXZ8mZXPtJzo9FhGoGG0ferng/ludbzvY+HsIhDtiV
	DeQ2L3iSvRkfMSN55uPMD8bBnH85k24EyH+ItKBgNHMz3nkseP3mDIXWJ0fRG25nL7MNxiUZx81
	Tlr4qd0m1MI+isdDtzaDbW5gWqwxgk0jrMVbV/p93ubf+XHvjiZyYolJqfM5V3M=
X-Received: by 2002:a05:6402:270d:b0:6b7:d479:654a with SMTP id 4fb4d7f45d1cf-6b7d47965e6mr298323a12.36.1794564203570;
        Fri, 13 Nov 2026 02:03:23 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c236124esm752333a12.6.2026.11.13.02.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:03:22 -0800 (PST)
Message-ID: <e5f36cc53b733383ac1d1f1e8c03f73091595edf.camel@amutable.com>
Subject: Re: [PATCH RFC 08/41] mqueue: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:03:20 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-8-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-8-4c998976c6c7@kernel.org>
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
> Initialize mqueue as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0ipc/mqueue.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 322c3dd98c44..8bbe32d0881f 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -18,6 +18,7 @@
> =C2=A0#include <linux/file.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/sysctl.h>
> =C2=A0#include <linux/poll.h>
> @@ -405,7 +406,6 @@ static int mqueue_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	struct inode *inode;
> =C2=A0	struct ipc_namespace *ns =3D sb->s_fs_info;
> =C2=A0
> -	sb->s_iflags |=3D SB_I_NOEXEC | SB_I_NODEV;
> =C2=A0	sb->s_blocksize =3D PAGE_SIZE;
> =C2=A0	sb->s_blocksize_bits =3D PAGE_SHIFT;
> =C2=A0	sb->s_magic =3D MQUEUE_MAGIC;
> @@ -457,6 +457,7 @@ static int mqueue_init_fs_context(struct
> fs_context *fc)
> =C2=A0	put_user_ns(fc->user_ns);
> =C2=A0	fc->user_ns =3D get_user_ns(ctx->ipc_ns->user_ns);
> =C2=A0	fc->fs_private =3D ctx;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &mqueue_fs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

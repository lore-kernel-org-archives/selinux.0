Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564338;
	b=FWZHX46jjSr4WCHU9tYz0ygli2wN9mt4UEcbdajGd0IX4h7iHa6Vw7Wgqsjdt1UjS3wK
	 r1qP/DrKFfJR8R/ZjpGptj10NdAWJt1ALr3i0bKDNh80MlQKEZlvmOVpetG0l4xHNB/cb
	 /CVudfZS9WxELJadS2JWqdRFzyOAOkfkW2sfMG3e652ikyZ3SndWD0BGmQ3gzKfznbyjL
	 8j4kW8iutc/voawOFZh9XX2KD2PrRFbTEBxBW89pi53zRu5dPGA/CMpG2qWCTIw8PQZSn
	 z4Fo5XxZ+xdyNjJOe370YqNoq7IgfZ58ogc86KR+4EaiyusgYXziB8s598XC3YTzd3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=/ZNAGjGCHSUHK/hbpNrctHFuArQcFUaSPHFuYTd8W2k=;
	b=x8msOV3LGE9FjLZ4LmxsRJ5b1XhAeGjmIDlK8uTddZNaQrb/eWNNd2Q1aeTPhDT9FfPm
	 S5ls2x+NYEBnxZghB11q7NOmojvBB8+uNcl/CGUlnztPTLcfUppOTxTyMLpZh+XpkXQ3K
	 ORTNr9Myjr+TYY5VYcq3ow2SEbsm+HKhUO7NHSrJD21tGDKTOz8VzmGT2D8OztA+8d9RV
	 Pn02OyyRjVlrYEo20VAz25JQ94OxpKcQZIo9aUjxEihR81qkj2yEWerpgU49i4TrfAPnI
	 pbPmqifmQGBCZbJCeNGy2pnS2RcQ+8oXuAwHvNhnRREk89k/zSFme4emF78dM0ji48Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="BcN8/JZ3";
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080E460A2602
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 10:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 080E460A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BcN8/JZ3
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c5075fa7ed0so161294866b.2
        for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 02:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564336; x=1795169136; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/ZNAGjGCHSUHK/hbpNrctHFuArQcFUaSPHFuYTd8W2k=;
        b=BcN8/JZ3o8G8RngOszXG3JTNOcmRF7Y5HhcgHfEFuj8bd59D6/ZB+k5Qh/rpeFRCcR
         ddACGgLLZgU5b3f6uROOjMlLzNHxLpnDWTvmFTIG7dNNkaJHDW07G6TO1gom3Rvc3G6a
         phj31A4a6/nEoCYWD8i1KXLteYhy5qLcfDwMY03tf9yOOPsaa+sC0St/LDVgowIEHsk0
         tZO/CMI2RrlSiK2F32OSWBbCdipxonxIIN0DBtho56nDsRF+fFDKa92VHmnJVt2oHACg
         qH7hz+1dQBsoiVIgFoQGohYiLAIIKP/PCGAm0hHsixZQutOWB167lk9DbkeNw+vQ2Hrh
         L2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564336; x=1795169136;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ZNAGjGCHSUHK/hbpNrctHFuArQcFUaSPHFuYTd8W2k=;
        b=bB5XCR5T37rQeu8sNqux2YjHp0XKOIMGs5Py6oYh+nOF/+alFExhbXC0WdsKL0jcNW
         JbmCe43XAbtRK+nqT59v3sAYAmMaGYz2lYz/ton1dM0+2DLhUoRVvhStm0lDEBfs/4PF
         x/j1rEWxCvfzEDagzPhkqRe3vb3fEC7L1zVnxxUCj/PpqiH67EcM7xt/nt/VEyu42Z11
         ITyubTiSFely9P+/wXu8vpuLD1J/boSYYK7s8l2t8hrOGUXPiBeLJsT4Yud5QEIObh9e
         eNPWX35qS7+VPho2ge8MRqQm16jSHNdJSPZZZMEIgCFFE1ET3BbbLtWNRtLQQjfOJxEY
         csZA==
X-Forwarded-Encrypted: i=1; AL+hErFc1G8zJ9b0s/g+lM531De4QNx6WoTKoNezDjrXlSrrEIC5D6KcpH2/zuhxFklhJA+KnzTyrL8Z@vger.kernel.org
X-Gm-Message-State: APuU4Z/l8ttN/bng4PXZHgr0CAJ7R90rioSqTA0EZQf9Pca8FzBBcUeW
	BcdY8+DOafC8J6TwSfBNvpgT7lxqhV4sQQWC2awj3N5usr4PCs0AVLerzp1RrVz2oSpC
X-Gm-Gg: AYBFou3H+BvaXj2WnAfgINguU6+y/fzjPMxf+J0ktL1feqzzfrk9td5cq/1Ahfda9RG
	dDww1jgYfBWDcir+H2AJwUZPyF048pc5giiZpCzMaxm/qtudPj28fgw3aFQSXDbDeF89xCDVwM+
	IU/fHdUXvp9IrM97qVq+i65oM9j9CSP+zXZJcvuK14Em3bZsbrZqtI5edp9ZMzIIbru5NInaYGi
	pIEKQmHYQTgopXA3tauljsrXFSaIo+d/khag9/9fwZXoJ5Cq1DGMoY0+gVU4JAavkxAtZL1p+eW
	YT4J+LWyCfHaWGqrTV2vSZFei9XteAphp5O3wpBLiTcXTUQcG1G4jdc1MVtR2+JNJbGH2RwP9U3
	AAD0dkHtgh5tiN6Xwy/wbeWvDgxe81GdQyzu85ZuNB/FhajPo4aPlXbsNHJmiYSvA8AlRqVwM8V
	fPaEfPM+OLez5pkwRMy7adystM0KbCXDY80sqMAvkOOA2YSH/3aPxkf7+r8HI3pWk4/+vZ/Yp3j
	4dKub38Fbexp/cCAlraa00Sw/EuP7ijDQTIQh92Oj+oGB7XJLIlCIdBOg+3FzOsirM5shZHcLxp
	UK6NqXq+hk6wPxu4VJNGb5iojnvAh5+GTgqGJvRRY+flYEgf7eYxgbdTvYjYEHY=
X-Received: by 2002:a17:907:94cb:b0:c2e:3a72:ffbd with SMTP id a640c23a62f3a-c5096389759mr162937766b.41.1794564336347;
        Fri, 13 Nov 2026 02:05:36 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095a5b93csm75365566b.5.2026.11.13.02.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:05:35 -0800 (PST)
Message-ID: <8f532a01f6cc2eb73582864343e25be4ec990919.camel@amutable.com>
Subject: Re: [PATCH RFC 14/41] debugfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:05:34 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-14-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-14-4c998976c6c7@kernel.org>
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
> Initialize debugfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. debugfs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The debugfs files that
> can be mapped, kcov, relay channels and powernv's memtrace, map data.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/debugfs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index b4915551ad31..f163f0bc5703 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/init.h>
> @@ -317,6 +318,7 @@ static int debugfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	fsi->mode =3D DEBUGFS_DEFAULT_MODE;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D fsi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &debugfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564190;
	b=ktyIJgkf/dqOSsTiZSV9zG5RrceYvpp2qXR8JpgCgK9Zfr9X3LiePWC4GoRN8jORrOqp
	 lfyembU5S5ZSacgKRh0ABiOUc0vzmZvXH8djPJI7M6C3aHP/MOb7408WFe8IPUcizcSqg
	 nWEQS72x5kobGUOoRgn4l9ytlTb0RYZOgrwi47plGXcdIKGuCYIjSmJed3Y2MX7klq2Ze
	 SgBkJzjtnZ2DXSaypgjvvaaRhDpsEn+nPbUkKAOe2Hcj+70JOPOF8+MFNdcE0fktW6WJO
	 8NM1P+JcmN3M9u4Bqd36VVAP0B3eP0l6EuMB9UJ/VOGUUtpe8BCH9zQMzLBsy7pRfgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=SoW/gPie2WRRtXdhiV6ow6HDYwH4jtR4w1oiMzBwW74=;
	b=SDmpXoDkmWSHRE6/m24FvKg5AuEFsybL9dPWuB29G7O0HqgyR6nejTFlwSCKZ0tHwu7I
	 EJaLcqZnJtzZeWYAWW3t6kteuB8ZHso0oGLvNtEP08Uc2Cdgwsj+b4chwu7rzZa14fQc+
	 zO0tWVLowLkLV+kudBYF7S9xAoM8Gv4B2gB4UlijShq3dxQO5pLTXH9CcubLeAiokTmR2
	 aKXcKQW1hax5L06vTRn+pGFYCoILPc5rdbZ7+buQSyUvnbs2JphmdcVXBEsQHr2K7B5KA
	 Fw9aWFJA06eTERUGpgRHQHlMH+9d4bJ2+2P/E2E82zDGfQMPXCDRWkbO98lHKioSfzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=PwLaWWEZ;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE02606A894
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 10:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AE02606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=PwLaWWEZ
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4d427836e9so121394066b.1
        for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 02:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564188; x=1795168988; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SoW/gPie2WRRtXdhiV6ow6HDYwH4jtR4w1oiMzBwW74=;
        b=PwLaWWEZlovk3BcnO0ZG64105bcHT1OuSddm6BbnvIqxbrPzt9auj7esmk6BNbh6fX
         VcVz0Fb5EO25ZFbwJkkdsGMVKdakOQPzqU2f6LPhtUiDBhEZmXH+cAuxyn5j0/PSwsaT
         RO2aU2TU8aCmd84MLoXz7vnHjZWZq5qT0/Sc6gtTAg3UhyfQddRWFsH5ep7YUVPW4oOS
         ZJYdPFjeA/srAxsT7bXr7CLtpXwYO3HrhRePJ9C+1IlKmxOGPfhyvFsMUb4DHUYdYyHA
         n68GAxpj0xAii+OfqqKyb+8UpP8WFZF+WeKZ9rpWrZ/4EfgHnKqz0J1mnDjnDglQmq1u
         ISGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564188; x=1795168988;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SoW/gPie2WRRtXdhiV6ow6HDYwH4jtR4w1oiMzBwW74=;
        b=OmOnpmzhUiv4MdC5pXZjp7UP6HLzxetPn7XDEcGpIz0vpf/hJxP7PG/9XMc1FZ2deU
         SAdH8ntXDdLsnbF94M7ktSxLctaB+jE7onIG3RlNgvjpdeq0ByNzb+X04D8/WUb9WtGR
         XkQt4dRgfUF/4javS0KOksChhsywe5dGOMam9O84CFdLRJoW7UpJTilJU24qNEuAOf4X
         5ilOb12tuAx8fmjpaXAE6jJsGrrdThfiabEURZmRRdM47h5HCHjN8L+sU2GzzYepFsFT
         jF9JcOT9CsHV3c7uDeuSprc8DIhBvt93mWR2NAdyIYj6nXYlST3szKkTnqpctlBJv+MG
         1mbA==
X-Forwarded-Encrypted: i=1; AL+hErGs1DyAjwjKwdFd3x29scR3IkUhWbzqKGOsBD4+qsjXjF7RWpNanu1/5612o5O855GnGvhpTVlX@vger.kernel.org
X-Gm-Message-State: APuU4Z+4lt0q3ZSLMHHg1gCUNPq7u6WzEADi6bLJJaB94K0nmfMMw1UA
	CvHnrRQuXVVXprV+vo9PNPMU6+Tm9SGLD9P5tEnXCXujE5kLXfbYtyv7OYiSy1ow3Bax
X-Gm-Gg: AYBFou0/SdneFthjV1kLK0S/2wRsTYmhOCKoZC2cqH1osLHvFA5kGDC2RMyKg8gF3TL
	2nOph7pPcZg3+GUAUUJfdjqQlJNga6DPR5JOjX6Fz+oHoDUATqKsn+GpivpDMFeNMsREl7iKibT
	1JjOFEEsgaXRlLsFH1mOvLFysA9acdjYx1/qZjusT/PzeJZClHmPqSikkFCAazVPI17zwWF0Qrm
	LrVJqwvpLQ4VHuV11wsPcAHQWQ1gphUtkH8i41ff3t9JkHEYB1+p2d1h5zzLVcR1yz4JiqDJyO8
	HJbkgfojwWm/FM7EPtIF2I3FfB79H0YIaW2+759XReHm5SRskM0O65TBXjN+SaItFSp22uwu6kB
	bjw5UTHRfgl2dLnlnb96lLkQEdTloRlhgNXHcQdl256AIbB0LrG6jqcFAVJ5LF0yL0JPboxUhHM
	NDm0K3AAQ6o8GNX83/NYv094YEKXF2ckx8bIHSKCW1A2nAMA9vysJs+jqdp2BIEH6W5vXfKFoGO
	fUe/DQKOTCpNaoWczqRky8RrrH/CaP3w3w/ziXJsgStS3U44CKc1EdAQnRDQcrK18kN8wEcZx4H
	TFfgZMruZyjl9ox4ABXCbVvR7UElOY9jZ33r67DZCJoNqoju
X-Received: by 2002:a17:907:d12:b0:c4c:b4fe:c9e8 with SMTP id a640c23a62f3a-c50963dbee5mr161853166b.38.1794564187801;
        Fri, 13 Nov 2026 02:03:07 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b3dbaesm74933966b.32.2026.11.13.02.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:03:07 -0800 (PST)
Message-ID: <fffc4f7f87fd5f03d1ef409df76f71ddad552213.camel@amutable.com>
Subject: Re: [PATCH RFC 07/41] binfmt_misc: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:03:05 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-7-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-7-4c998976c6c7@kernel.org>
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
> Initialize binfmt_misc as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/binfmt_misc.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index d945b4f6e158..7dc233becd98 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -22,6 +22,7 @@
> =C2=A0#include <linux/file.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/kstrtox.h>
> =C2=A0#include <linux/limits.h>
> @@ -1575,8 +1576,7 @@ static int bm_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	if (user_ns !=3D current_user_ns())
> =C2=A0		return -EINVAL;
> =C2=A0
> -	/* Never exec off this instance and never let anything stack
> on it. */
> -	sb->s_iflags |=3D SB_I_NOEXEC | SB_I_NODEV;
> +	/* Never let anything stack on this instance. */
> =C2=A0	sb->s_stack_depth =3D FILESYSTEM_MAX_STACK_DEPTH;
> =C2=A0
> =C2=A0	/*
> @@ -1660,6 +1660,7 @@ static void bm_kill_sb(struct super_block *sb)
> =C2=A0
> =C2=A0static int bm_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &bm_context_ops;
> =C2=A0	return 0;
> =C2=A0}

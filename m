Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904345;
	b=YPfz+pBjih1I5gAiFA2O4x7g3+ZxK8XH63lrbrNiN42d0G52JyKQHNcFLh6nP2Wcu73F
	 BpshM9hoHIQJSKqFd2F6c968DmjDdMWoDCy8oTMZ/TH9qgKuLCge4SPCtpdKtOmOad0ZU
	 flnYzFTkIz+aqZDbn0kLYcG4zu3pDOhQ1+3gMGE1Df7Aw7TW6y29mNwt4mgWwJO0dcSa3
	 eCmdnm1PKmiXH1PitAqSIzAt/xp8D4wK3wa8Ak6xENWkIqncTEG7/5g3y01OKynP+MMgx
	 tyeA+1AkcXdUy0acPxgtdAD7UHo8/QZstIwlGjooO2Vjot4GHuem7zO4Kb/zA42xj3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
	b=OmWFLBJn7XqotHKN3Ge2vS332sYIOwL7VJoQ4HvQIX2qCqL+OFwSCDy8NpqJzgQ+Tljv
	 fJvCj38JxtSHgqHGgvcICWKoh2DtkSy+Hord3LdBlAKKk8PCXbu0xmNLrH7PBipi0UUZq
	 J7djEi4PJQBNdx40HJ+WuY6GLWkYhV6HCfz7W1wc+0CsC1WiBOoQe3DE5r7N1JfU7F3wb
	 IYyn5YSc8i3fhlWPGRuxMHsGg9U7TQDFpVOmAw4U495xf68GZvwm8+bB0rnqKAnRjCx8f
	 c4KgelmE4C682DBwa9jSfgIN21b1YSgx5jvxKVZjosr5Xjrjbrkk7JB7WAMTGiQ2pCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EFPX8Vuf;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4343606A89D
	for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 08:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4343606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EFPX8Vuf
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4a358881793so377434f8f.0
        for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 00:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904343; x=1795509143; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
        b=EFPX8Vuf7iz+NzEUQG+pPgjK/MbrESqv3n9ATmra3Zopp4tpstszPHFfE2sR6EI1XH
         /MuIqTxoWkMXSLrvcYnqUGQvNVGY6YndEf7Smwels/t/G0PiJAqa5YTB3/XSR2c5vF/4
         5S685rADCuM7kD+KTHsn5xD0Bbvj+kfNJN7h3Eeu6Tgpz77cxc6E5ixV5T0A3r/KAOuP
         +pclbSVYUTOzYQ2RRiRVVs4C5Z7y/NhXCRc6Of4Q0fL8jD/Em4FfidsaQN0h6TdkChBo
         DufH5bn8tmF4fp27j4WWCE7M7sjar8yCORXmuz1wFPQxfWworU2xHCWyEC/YN83R4E+t
         3i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904343; x=1795509143;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
        b=jtOnooNzidPY84CjVWhlIn3p5eOoZE/4aheNy+vtRkCzscWI0gyR51LUDXMOaKi0WF
         G2guSDsfAvm6yCxY1+vpSfTzZEi6AxEuKAr7iHy+vj/utw8eiqs+/PrB/RBZVV6vs2/z
         p0jktG4ySgmiI8w4Ek77pry+tnHQu64dacQy9AeyAHCfFG9AgPGogEJaRrDHsm/9Ue41
         xPJGJLMtK56Lj5ZPNsHgOSIYaCfcxtw9Xj3A28EUxIBZ0zLlV2n1SmD8yGDh0GgI5MTb
         dKeJ8C8gXeGkLzUV6x3BFRyna2dY9d5yAOB7AXWyrf36O0/zpbffsujKmmye4Vsb62Ot
         RNOg==
X-Forwarded-Encrypted: i=1; AL+hErE8ZIE6VGK+EjjlcYwlBDG5carS/jk6nKIIOWtZg+0orgoJFkjxXuIrBCGORSTX6RHNRwYTV55y@vger.kernel.org
X-Gm-Message-State: APuU4Z8jlfAuAr35uRB7bIiL4to3XFjt0Cq4VBLUrM9YwmSZ/FKNjCCf
	RFEpa4rOBtFtK+OeXu//24gJRPMffdMohABwVtmzl9kLqaCP0JzAA7pU6ghZhNJlGeZl
X-Gm-Gg: AZFdTZf0mZ99mt1MrVwPnraPjbJpv0lWKGVzU1+RYTC/jXoxyaZdCCTuUgKvhgRvy06
	49KZXLlDq39UpQZAMWfGWSwSuljSddGJnI9hMVvgc0LJ4w7jCX9EDY0dooXopEEoRWn8VLh8m/u
	5tjJy4AiGc5v03TqgYvDorwBcWETw2T97cb6PvB/hCUwY9hoNfzUoiaEleBMHaVrRseieHGzEjA
	aASz2kBBdRKtdaEbnu7rhjx1vfS3/kAdFtpGNvivYHNIRQlm16On4t/qIOlaYWdSOQdIAn5nyRt
	OPkykMoyBbjDLmzZ3+Uz6KR67wmn5i82bigqVkyyi0+6icqBwqBtOD+vBMpH9yEmY2hs3RMih7c
	v8c7afogGSbOzrlAgjeuMtlHQ1QcTNMdEccfUpfN+ghjByv4d0RFsak5Dk/p3bQHWneVfrRvK1e
	JdpBBrNzYu95oEPob7xKykZ1XxsD0XBNP+XH1pcZtuy3C6lmOQqi08+vm/mXhtxPCzvl9ZC5x8b
	Ni8DNkWgmjrLHrzsFu75A78EQBMFEW0Nr+0/TJf4zqe4MSqTwwjFc50DlKYR39BnUx/vZ2UyXx6
	AIiVE5v92UtqMciz4iNdHQalQRISmE+F/7qXzBWKgqRYGMjIQ6c40ZCTxBD1shD3pHRjmAbSMbL
	M31eESm7FP1yIW++dZ4+M3PwkKsrI8nNN+O9PprYpiKzY7T+aziBLAVHK
X-Received: by 2002:a05:6000:3108:b0:48d:f9dd:e3de with SMTP id ffacd0b85a97d-49c7353c415mr27089117f8f.45.1794904343236;
        Tue, 17 Nov 2026 00:32:23 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608d10b2sm43646659f8f.44.2026.11.17.00.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:32:22 -0800 (PST)
Message-ID: <fd39200976086130cc82d59699a988fc3e0689cf.camel@amutable.com>
Subject: Re: [PATCH RFC v3 27/44] openpromfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:32:20 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-27-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-27-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:05 +0100, Christian Brauner wrote:
> Initialize openpromfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. openpromfs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/openpromfs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
> index fb8d84bdedfb2..6cd02d456bac9 100644
> --- a/fs/openpromfs/inode.c
> +++ b/fs/openpromfs/inode.c
> @@ -10,6 +10,7 @@
> =C2=A0#include <linux/string.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/seq_file.h>
> @@ -419,6 +420,7 @@ static const struct fs_context_operations
> openpromfs_context_ops =3D {
> =C2=A0
> =C2=A0static int openpromfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &openpromfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

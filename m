Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564363;
	b=cjtd+hvtATY1KtAgwfmZaQYiFDgAR4ANVdZ1hB3W3qa8M6TYa3Hhnycw3iuqGuuI4PxT
	 OvDoIyQp8ppXrvGv2CcBqJCP1eLXUXsbbdxnahFpdr0tyWyYgfid2g0qtkg6mYG+Gid6Y
	 A0BeUxzUQV0dTouYFDIo+aRbJ4lrjSVUleJIV/FxSH8FtStx3f2GM+ZVUyZI3RJpc4EWd
	 2aLiF03GqcyudiNZ4Qh04wduVjSEQozVOXphXkcXwOcTfA3lNCYThxr5ghK/3mny5UbY0
	 X/nP9QzeWR1f4K72vbakQg7vQ2KBkK7rK/iC8q+jrvbuIFZpSPx509u6B131dOlwn5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
	b=HFBtrdYNgD9eGGOlFNXjokfCqZysB2PzyJE93wHYT9zfSh5ik5cwU+wbqyuZDqxB0Kf/
	 dEM+lHxPiX3a57+wBkfAapow/8lvTo/jGgHk0PRJxo70diUx/bHmXcC06PAA7VQad1OMD
	 0kUVN1uimRzn6tEr7oO0W49pSTn5fWCyln3KUkYNRDxY2HzxBOM0p82HmCfIvsWNN4nab
	 1LH48m17kbEKVk6jHP1/2qTEgz+DF5vkdQn25hy+twxola8AAG5AmzCPDwy4JV6EimTTR
	 tetf4UdnKNNcErGrIYtwsFzdHtAPGjVWUfA5gAF0nDkI71qIClBeEC8SlMpRf/lyyXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cjEYfKb2;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD3960A380D
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 10:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DD3960A380D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cjEYfKb2
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4d427836e9so121960366b.1
        for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 02:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564361; x=1795169161; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
        b=cjEYfKb2ti/xguKoQF5XePY0eNOezud7K33Duf47S0g3JkHBuObkd06WZKSsE2j4TE
         DEwnxkXlTao4933EWT51qAqcKFQZzBDYUWq7IdS+RrJUrXD2u7QTXDm9Wr29l+nlsY2h
         ba2aoEFnt/fnBZ4TqG8AlHBTx7MlaAOM8MSBIpLqFecTqJgM42mukp171NeFhmx0Zx4N
         EfXY8c4e2NVT5eQpV/Fv1f87MHIzBgzN889RZpIYFKMs83t0n9Q8bpafRw7OfeQ9pMp+
         KOGhNvmnj7I3xZktgYLxquasfZAW0tMnNpo/9hpnK424qA58Vs+J+ftPxNsRzOLYAEav
         G1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564361; x=1795169161;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
        b=KC4zKz+fO6jcDcSlmXM2pJc4CAcwk/kvdx5D7yShFXH950BA64NVFw9HqAzuhpWb0T
         /BUU6fJkKFrteFpUeebcUz5DbNFAlqzo7DmKPdGd/CEK/bqiIS72/RsOmYOD1r6qBXOv
         SFwZe17OCvPP78m4BKFBAI1KLh+/HXujHwGvWHIHS7hMJdu1KRKRQoaw03ulL7XbJKMQ
         X2uXsMjevX/c0fAn8Qw3plbhGggxy1VCmecL3zpzz/eMAt89YFNYFtBm39AAAPPv5Hdg
         Fy1Q/AfzPC5VRtBg+QSSM3aSXEmu3lx+6czbGeGpjaxBIoyo0Ad4oUFRlhiEnbWn+TP/
         Sx+Q==
X-Forwarded-Encrypted: i=1; AL+hErEASjigXLrJlJrZcsjNDVjD+C82Yo4dF7xISXUiO3aFT5mdnChICn3G2j27MihbBk9/ucLIS7+A@vger.kernel.org
X-Gm-Message-State: APuU4Z84MNTf1Xg7BBjohJD/BEqscehPFaMQsEXGJ2YM4P880U4gOTus
	BO3XUPO1HSFozKdSzxaPcFGz/2QB1zuzBvisXnKkY9SG1ouT5Mrl/lYojFBuJZmYZ3fh
X-Gm-Gg: AYBFou1xnhH81gIjPGQXZnhHz8hEb4BZWJ3U9CDi/Xr8RI6zd+jXnGZL6OgYd3nbdmO
	iPsjoUPzbiFEICjbLwOQqjEyZ4/MvbiwG0gJBp8xdqqRzKJIjVPEeiWEXDVHstw1Wd2+snW+Jev
	+1kkU3Ic9kn3CmSkgRGnwFxbd+KzWOEyShWVCetiHv/GeshlzS5QrcNiQLY370f+S8UZujg3mhR
	o1Fw7oh4eJvn4xIyIYvvsp3jcvSGQ51P7YjR/kJdnkZum0cqC4hZsWaPC2aqHpS1/0azk0GVQpg
	d4lSrdzXMHSF8G437snSTI4+DetjaUClkCutlVcvSVUnl+xa/fXYJkvEUMHFKvxajZm5IsKMUjS
	5z5r4tsu0Zc4kmuCnBaIzo1FUjsjkZsDyij+8SyF155Bo6t+6E/wY0+FyhpBAouvLjASfOPuh+1
	Yzf0Kef00L9D8H+oHT4zJEU7FnABdrNcNLCQtFOXnwjtYmSvt3P5reo4dZQwMvpJkriWymVrJJ7
	HrEpXX3YLR2d24nDUsbd0MnXwWA7+wcxc/k2RjsN7RUM6+qxbI4scKqpiCq6T4r2lUoOP4w/xQK
	IZfeHMceeO/cax48tT/ChCLNCyvqFxUUTwHH/e3tpdXI0z83FjISx0HFNhcnzoM=
X-Received: by 2002:a17:906:ef07:b0:c4d:5820:325a with SMTP id a640c23a62f3a-c50963dc627mr169588066b.39.1794564361325;
        Fri, 13 Nov 2026 02:06:01 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b8651bsm73693366b.78.2026.11.13.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:06:01 -0800 (PST)
Message-ID: <e8b71a2778d7d7797d433e7bac1a37ee64aaa30c.camel@amutable.com>
Subject: Re: [PATCH RFC 15/41] tracefs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:05:59 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-15-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-15-4c998976c6c7@kernel.org>
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
> Initialize tracefs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. tracefs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The only tracefs files
> that can be mapped are the ring buffers and __rb_map_vma() refuses
> VM_EXEC already.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/tracefs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 5020365ca704..e04febd868eb 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/kobject.h>
> =C2=A0#include <linux/namei.h>
> @@ -510,6 +511,7 @@ static int tracefs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	fsi->mode =3D TRACEFS_DEFAULT_MODE;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D fsi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &tracefs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904088;
	b=vhhcNcZuYFO4K0BImgYA53CrQGEMVtYcdBc92iQiGXtk2H+o7DZTFFQ3aUYuoTDq5mki
	 9oUOXFzcesYbvfIok/NEDnD1/ClYtrmp4koof3Yb8gM9x+6T52Rh6HZr9pH48LOh8mL1B
	 IBxMisUFm3K7GjR74KycHXwUhtVXm5BWqbJFMM+hXXGUjWQg+n7yaDs3e1bSN8QZ9sYTX
	 dCy3U79sW7DG9eSehs1W7kgxfSWj7zImYlc6rdbix1cpFS9la9sEz94xZZ0rGTJVYQIgN
	 aJKiHl53Ad7y95SAJZysr32XFcLPJgjjuZyaAvWAKymrPaKVp0vOK7VjPV6tuPP1ULQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=AET1JHslkSzLNTOs00e5qdhXA33kuZnL+yhN5Q6hFHY=;
	b=HPNYTkBQ4lRiw/Z+NTsGMNcnUMIjpyr3if9DCDSLGgk/xrQbXCwOZf18Z4hTpIzmTh9U
	 8E60+Q4LbyPVjcGLuf2lPcQRyXeAHFcjBuADgPCch7/ECOABfMbgYi0RuhkYcLcVfJaRP
	 fINIJfSt9TT9vOC8fkzBF/oz2kiT6ZxWJgUNXqzq6ERFSnqMwKbwZ8QY3we066kFJrW27
	 FWdmdnFKKHLEBB2MuTfMDZFwq4hOxI3lMMVvmcO12PR3gfyAtPB63Zmo4bvf5DW850sQX
	 uae09pMgGwlxJpfFWE0AT2Zs/3SSkhW9/MUWvEaKZDLVjVup25rATQh8tbp+3KZkMRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=G5kPAzk6;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE30606A897
	for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 08:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CE30606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=G5kPAzk6
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso26232775e9.0
        for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 00:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904086; x=1795508886; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AET1JHslkSzLNTOs00e5qdhXA33kuZnL+yhN5Q6hFHY=;
        b=G5kPAzk6YKyHaocuCdT5IFslrUJH5/ldhNVhV6xYWUthrOIppv7Y8kBtZdevqAkpzI
         BDRFsu2jrF+YCozPia7EV1j3KLeZC6Lnc8BgBdPYFaePytvbOESC0m4eRkryqhoEbPxE
         WM5n2Fa2IGRg+WkSIkgfyoTemIrDdEbfzZV+2Eacmamzzj+t+HuCPRqV+GPswkKxuMa/
         2fm9UdrHUV6v7jtlgmqycAcrxGUcSbURHcUFMMj9LS/XjgTFJtp8hDDDARovdS596Fjm
         xwkar34XXNuYsLWY+RNo1AZ45FE/L69efZRvwjPbSAF3CGRgr3AaMHZz6Kf/cz8pCVs/
         RhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904086; x=1795508886;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AET1JHslkSzLNTOs00e5qdhXA33kuZnL+yhN5Q6hFHY=;
        b=ybHbdqUhEsySaKlTznXjzFVytcnxhXqZpiXDUwakJTfOo5clM1Zg5PS3d65kzNRctC
         5B1uVzsaj77qNsYmNC5lVpj2dD59OqwxUf8Od5ynqYvGd4D2aE69vsXtQ9GfABU/gY/e
         +D5wssO1XgD6/4TOq/QLJSJsoBNMgcxeQRsK+3pOvADoleqoX24a/9qZKmt0rtPAUK7A
         dmMj6IGfvkE3xW7WO6vtju2jDWqdX0rLpOarIhmvQdDsDmkcamH7gAwf/DjUDgraiLvm
         9dHRjrVDoJU/iZDAepe3d9da6hOJdl6L+4mjhPgS7MKxNGcaqrQ0/jroe0FfjkhA+Tue
         w8jw==
X-Forwarded-Encrypted: i=1; AL+hErEFMChyYmy0ylBc3/JhwyDX6fyY94RZu1MUiL2q4y6SjdK/ZEGbRAJ/Up8bste42zdIkNtNNYVP@vger.kernel.org
X-Gm-Message-State: APuU4Z+kmqPvmKRcbInGLXhsCImYvmg3wY07oLMXC5SAb0CANTuP4SL/
	EG9GcD5FeIUQA1jIeTyuGtFOxMNZjOhh0FZQYZJAJH1ucQUmrx+Fg0hk9RbJTZz+RnZ6
X-Gm-Gg: AYBFou20tIsYHXKIJ8udcGIltLRr6ZJ8b/AX+Bf0RNya30f5tI5jywnmEOK4cdwPc5Y
	Tk3molXbBMYDUgKe+DYyRlnYihuu/vlhz0PCiybqXBX2nuEUMnLb5I+Pg6WltMMCBw/FgoOk5Fh
	n/J0E5qLWe1Vx6pa8I2/eONWekui0+w6GKVoh7a+TNXppav+jNkgv5yM2ntiDC+IQ4nzGFOkD6s
	PtRLJu2ZBmXmtCYy6n62PyZ0TcHa7wShDuudjy8Sd3LswpQkxTn7QNZy9wMoRDYUbRFTkwPXvvg
	EdrXYmdIxxFxf6ZTgE8+pFXw43OUBSDvT+TaVoS0YE/IJ9qUB/tjrU7Zote6Nj6EOtmJdAv3vTI
	UVrCdblFuRM5X08OF9C1X+L2jJIt2yiv9XXlpKab0MovNCo96mTcFpf9vtEQCQkDAyY/iFxU1rO
	MvJEx6+Yync9bR9Spqj+vYxn1Dpy1EyOdbvlatoY8VGM3lE/BM7iOh+pgE2UiZlJ4bxZWM+gZhv
	g+iJKttP3tKZsO87tMqSvcG7KNIdOe53P3BfonipHjqO+TGDXbFJTONYb9Rja9GPCLnAp/PJltA
	61pAq1zEoHVRNBDKfhWlVnavteyGy0NNVe2dDuooIcipCaFNJcNh75d8bt+LVfst1rxSNMEaQCc
	ZqwyZ+ld4e862fjaLDi18cJ0H3C12nNDpaiUBD9fFlAQ1Bhg5pEV23dER
X-Received: by 2002:a05:600c:512:b0:4a2:a9:ed87 with SMTP id 5b1f17b1804b1-4bb55a5aa47mr209766355e9.19.1794904086313;
        Tue, 17 Nov 2026 00:28:06 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78418853sm74782845e9.8.2026.11.17.00.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:28:05 -0800 (PST)
Message-ID: <fa0ce0f7ecdbe91cc6773bcbe86be137d2129944.camel@amutable.com>
Subject: Re: [PATCH RFC v3 21/44] nfsd: use fc_init_pseudo()
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
 linux-kselftest@vger.kernel.org, Chuck Lever	 <cel@kernel.org>, Chris Down
 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:28:04 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-21-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-21-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:04 +0100, Christian Brauner wrote:
> Initialize the nfsd filesystem as a pseudo filesystem. This raises
> SB_I_PSEUDO and also SB_I_NOEXEC and SB_I_NODEV. It never holds
> executables or device nodes.
>=20
> Acked-by: Chuck Lever <cel@kernel.org>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/nfsd/nfsctl.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index f32311f2d7cf9..ce2666deddbd9 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -9,6 +9,7 @@
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/ctype.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0
> =C2=A0#include <linux/sunrpc/cache.h>
> =C2=A0#include <linux/sunrpc/svcsock.h>
> @@ -1375,6 +1376,7 @@ static int nfsd_init_fs_context(struct
> fs_context *fc)
> =C2=A0{
> =C2=A0	put_user_ns(fc->user_ns);
> =C2=A0	fc->user_ns =3D get_user_ns(fc->net_ns->user_ns);
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &nfsd_fs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

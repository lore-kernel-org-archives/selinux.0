Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563701;
	b=0w/e0JNGpQoBWD9HMwbvo2BmDmpjbCCkhUI09EEHQ0ygEBHexSRdOW8njKJELtwx8xoy
	 yIeTVJxsNdshgYr1BesRkykIZLS2adWhXoWhs6BVN4IOe5NQ8e9LFAg2VmCMGmVdn+Sle
	 UIAhQzncmCkQjFbe7hyB6Uy2b43NT7NF2HpNbEGsbmx77twSgIur3//L4vti6qGiQ+YlY
	 074HK/Rc3O5Wgd15/cY5209qRaA1I2cIoTVxPf8wldI9idUB1JwOQNJGL19yfO/glCcf3
	 14xXhf7p1sagX/Anbgwn0FNvGhZrwZ6bv/mLQJhMmLQO+kcKTBrG7G+UBBVBivGvxbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
	b=3rHABl83KoNlBIbIkLEGfSIUcxx1rMdTP9gju63p1Cy4fB4M2zy8Ugz3VBp97ddMBqGq
	 D6Hw9Bqos9kVCTYBEaZT2wUdOVDdadfqirDKykuA37tiZlgFBurrF5kTEOqME54xMpRMW
	 cX/axWJfwsMNUidgqUcGbwzZHlA/Ua7RYCtaX6gw8bmLCgvMRwYNm7sDuz8M+rXwv9GkI
	 w8GrqDh5RFHtfj89ol7EN+dgfFiUnrJhucFbhKeh80o/GKST3UhOxfTJJ4rey9pMgzx0u
	 LpDysCGeWzJymt63OVrdJBxe22o3taAbWHCHx/pQvkr4y9GlL1DG4KuR+MZz6S2QAmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sk58W6sW;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4902060A260C
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 09:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4902060A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sk58W6sW
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c4395d31228so145414266b.1
        for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 01:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794563698; x=1795168498; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
        b=sk58W6sWmN4ERo+6S+koVh/BM/TVuc998Smvb7+dAHAHasLoIxA1PyH7SpTb2sphTs
         qaL8BceJIK/C5zTluK59TXAg0t7i18MIhSXKzAc74GDtFkVBtJ5XexxofTn2ErTCpEyw
         wBL0ZIwSoD+QdFLNUYuAtp3uhttIIU+8CcgeY50Q9BuPcdVkRSxffNnvhBi5q+TOT3Z0
         N0fPVcnw8avDa7R0wdKzwUNoVC/3vPRCD1SmgKjZfrkNv7BBIugYP8aqCryl3mRTzhIm
         nyzLSOhSkS/Bye+QA00IM2MsjhnUA408QIyungJaHYxvuyXbuTeC6K0dJcKnUnQNsCLo
         BJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563698; x=1795168498;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
        b=ScMpny4Gp4uhkaEdGFfgLg/6AVLzl7heBUATKvspReK/2wKT9vP4+D2f/5xJqoHNNm
         p3/AmR2h42E3ZN36UcxYq0lhpWkgoZruP4YOOD/cCphanxSmgQLfGCvE25UVjknNZGyp
         NyZKLWALKtq8bY0rQeYrfGpG+FHdN+UvWzVIp41paQj0+x3dB6jnMe+A2Jt8SjrAUOUd
         569YpeH/xSPqu+83fnsrXUC33Zsy1f/nD4BjEGxRdbHc22At/ABlXSSaDouVxPjafc3t
         AYvvzRmSUnv9wZ2oLU7DOCsKoCJtsgzSWDEYHbZZ4t768nHvYBFIJAZil2A+/V3coJyb
         L+XQ==
X-Forwarded-Encrypted: i=1; AL+hErEjdU1PMA1Rja4Kql52Fxjtw4OM53nXj6FONzOYdFOFQEOJeObUO37E+oq21WcJOFqVXTHmguU8@vger.kernel.org
X-Gm-Message-State: APuU4Z9xhIPWZfZE/yIlJYvu0o6pAkOAapGE+nRqt9FuoNxs4iHAzlpY
	93vk69npwj4e2wRibQ+qdFqkhbkNo0anAygf9dOG2c4bYXepCp8WOtNebq0VC6RGvVMD
X-Gm-Gg: AYBFou3hiZhhU4HakgOnAoeVlKdacfQyzaFttJP/zj5jIzoHcFRFN7WFIZpTIbgaH/4
	QJhLy7V9KYRQrVfrLzLEswayvE8x1dWQct03wY3Y4HbSqtO9s3kuDTXgbo021olkIfQhUhXvd3e
	nOxfJPMtzP197OZAQ3o0AXealxYecfT/O2PgmZUvwQdYkyrsOnnpr5CMbkfhwMPr+2X9GseaJUA
	dox1Pz+n7wUHcPhwflYuHHenKPgWFmCrZrfg/9Bsyst1EqgjH2C/KbN2HmMAoziDpdc6fMGp+0F
	rgBJc7U0pYf27N2j8BQaf6j1uVc3xr5WfmTtICjvntW46u0R3S4QEEXthjhG1wYfJYc3hsdQTc2
	+sKjiV1iHV1MOQQuYvjH9cM1p88kybpqJ3cZCF8qPftNJVxEhXcCKaQLRcHd2aq2Op3gycq6WnP
	G0n2ZKQ2/72Ni6iJshoX0Ql7iH8p+wWrY7pHV59mbBLOdF9Ao6F1xOW1v9uY7Fhty1eSCPOEzyk
	4VMzDHtvTfiPGy9l21E51m9CB8xGz0aWLNDbF388D2r9iH0Lfum0On5PiE6c8msvTthMDBTJe4b
	IztasbJioC7T6Pq6N8xfHlpPau1VPGAtn8QrFweNwg9kw8bs6UXvjp3ZjSR0Xfg=
X-Received: by 2002:a17:907:ea93:b0:c41:4c20:5a80 with SMTP id a640c23a62f3a-c50963bdb9bmr198299566b.44.1794563698514;
        Fri, 13 Nov 2026 01:54:58 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50957c6c1fsm75151566b.0.2026.11.13.01.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:54:58 -0800 (PST)
Message-ID: <b42c9f4d29a9cbea66929c95cc8f736f12703c72.camel@amutable.com>
Subject: Re: [PATCH RFC 01/41] loop: refuse backing files that aren't open
 for reading
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
 linux-kselftest@vger.kernel.org, 	stable@vger.kernel.org
Date: Fri, 13 Nov 2026 10:54:56 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-1-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-1-4c998976c6c7@kernel.org>
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
> loop_configure() takes any file as long as it implements -
> >read_iter().
> Loop itself never checked whether the file was actually opened for
> reading. Buffered I/O went through vfs_iter_read() which refuses
> files
> without FMODE_READ. Direct I/O has called ->read_iter() of the
> backing
> file directly ever since loop grew support for it.
>=20
> Since commit f2fed441c69b ("loop: stop using vfs_iter_{read,write}
> for
> buffered I/O") buffered I/O calls ->read_iter() directly as well.
> That
> commit was about O_DIRECT handling and the FMODE_READ check went away
> as a side effect.
>=20
> So whoever can set up a loop device can read a file it was only
> allowed
> to open for writing. Open the file O_WRONLY, configure a loop device
> with it and read the contents through the loop device.
>=20
> Refuse backing files that aren't open for reading. Loop always reads
> from its backing file so a write-only backing file never made sense
> in
> the first place.
>=20
> Fixes: bc07c10a3603 ("block: loop: support DIO & AIO")
> Fixes: f2fed441c69b ("loop: stop using vfs_iter_{read,write} for
> buffered I/O")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/block/loop.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index a3325ceab484..c96e35c3ef42 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -528,6 +528,9 @@ static void loop_assign_backing_file(struct
> loop_device *lo, struct file *file)
> =C2=A0
> =C2=A0static int loop_check_backing_file(struct file *file)
> =C2=A0{
> +	if (!(file->f_mode & FMODE_READ))
> +		return -EBADF;
> +
> =C2=A0	if (!file->f_op->read_iter)
> =C2=A0		return -EINVAL;
> =C2=A0

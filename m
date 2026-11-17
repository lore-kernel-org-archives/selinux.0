Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903968;
	b=m35dgqnR0M0j5ncdNtKxxiMncIJaE+O1HbKaOxYWxvckr276Bqdbdp3/DHTUS9sJjLlE
	 aZPfoz5kvLaMUNhUkoRl2w0Omp4qn7UoVleWdKRCW5WB5f/Kzv7Pt5+AC9FGPu50Zceq+
	 mvQhnWufnwC2i7RUjg12FgQG7yJeD4IHbmPO/wZqmQ4UH/Kg7S2NiPfrcADrqd8XKG1Fa
	 SM77SIhWcZUpaHthUlJX2Tyrz76lKmZKqt8yufKAHXq+xIXHok4WoZFqZtlK/IJpfB2Mw
	 63X4JOp6GV4SwvACYo3Yhr63LUR94HHB3siEKnHnuPm6wjU+1bFI4fMID84MsHCBmxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903968;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=z/NZRmC5bENRF/WsK1hUt6gARTy1xozW3x04wBCWbAk=;
	b=dtLG1ptyB71d2WB0yTZnJNK2/uA968mlpvDTPLw38WuTD7ufQTWvquEjncJobLrpSYd3
	 5HHLxcXs9i9MnjpnnkqhX92YMCHNiET+ddht4hxyjMTj5hPLui3Gc7eQjYpcxfdHt+jC/
	 XbvV6gwGMhSL3CzfdivuQyeW1g6dfI3CceWC+EqPj/0dyP+YX+3w6cTJvnp7u+DDemNav
	 eABWTt1y5KflFKI3/HHYUrCM1+gdV9NcTJdFgWIITzjD9svMPgmqgUMs3wG963uV2KDE/
	 owLTA+LEC8TuVJ/swA+3oIdpAdhZOY26Y6YvhSZWstRHD0J5bdNxQvDpSoRfuPOeaZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cds43TFp;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22901606A338
	for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 08:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22901606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cds43TFp
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so4353925e9.0
        for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 00:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794903965; x=1795508765; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=z/NZRmC5bENRF/WsK1hUt6gARTy1xozW3x04wBCWbAk=;
        b=cds43TFp7I9j7WPcDQvYfHpQ9LovbzzVif9J1GAb84gdrUsjaaD/ks8/CxWEGRZF0/
         68hyeBKuGnu6JbonI+DUrAk+S9ERoS7tOFFA4H5eAQDr7L4jclXV2ELfZ8mKm2Ufg0Vf
         wmDFKHpSFXtb9q6HdOEKHOgWOeHJI7n45fohFUmuSejGQMSPwWlozLhppiRP7NP6/RTN
         Xh3C0JkZ12tnXvLGCknth+xcOYp3m/oSfXqUlVI9cwzFe0Rue3P0S85bM03sQyFUoXwh
         8JJkMFcg0oB6zhSAQwaixAlqp7dYBZf2pow5RK/cSK97CWugz7jqMDtCMqYWg5eRSPcE
         y3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903965; x=1795508765;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z/NZRmC5bENRF/WsK1hUt6gARTy1xozW3x04wBCWbAk=;
        b=HMJJ9+lCC96UBGy9Fz2THT2pisZ/TJPhtnHyGtXlPsdIx7uEbqk/6eNo4oNpP/GqW5
         38OONdKa3qmAPuUNxBRzleMwaUNV+2Man+1Bf+Tt70Gsi/12LuryHBWSPrJDEZZyf/Jp
         /GLPBekDxCQFcswmL/aph9XRP5m+DOYYppIp+bjjOZwGbrYlR6E1bfKHv+AVo0KVOD/Q
         lShfOkFXytuLRjVMsLAwVG6TtSF2VSQTIDQ1wso8jNz3FOFxBvbSpD6HWvS2GFZZ4N0f
         KZqF86IOUYpO8FCsA+m6soBcrfOpcM4WVou//DScZyrY02Ag951jgORnD9XP/tSQMMre
         RGAQ==
X-Forwarded-Encrypted: i=1; AL+hErE/UsTshmEwJFDzkENG7peYFdL/JZwIkznK2LBXuEISwpsULEFLoRY+sxjPstGya5zmr9bMwu49@vger.kernel.org
X-Gm-Message-State: APuU4Z8cXRR/gWrNCdUD7CZgXkrqtZ8FJIWb3wAzrEwHSf8FRIFYSudh
	oZpTFEDbC8qEFx0c3JfhNOOhLK3nyBSQFFJhGZKLDOraXMs7Yttw36mPGupy6RxB9vxI
X-Gm-Gg: AYBFou19C21YqFFyyPI2BTvhqxYXbPzX9HxdEcnsvxmBpErSfoNW8UojhXPRJdcGGEm
	XdMk7Our1AAHH9lisILro4OZfsSSzWDDPQaflCGaZvKbWwSIFiMj58+Jg36LkHs90cPQeiTX9je
	Vw2hJVWNKKaHniqq1mMGwzJL7FF8Pf5BSI1O7UfJAHJ7kYkiWfYXtZUoTEu/8YXfYyLBqIgXy6D
	ea7lc/P4iXpiySgDIl5IndlyNsiwoEXOK5DE3Y2Vug2HCb3Ts46dmCivZfror5/bw2Hp4nfcAl3
	QE3uaLYOWBAXPVG9tlkEPzduSYNvz9gRizYltTHfX4/rdbxRVQjwgDBNFMY+oyc/HX2+QY+NOkN
	lkk/kHRxUPgSmXhoke8KgJsWitvszgYUzWd41qZ78fZ5rNSE6W7fyzc8EsojG/pQWUcDudGEvjj
	HqbPZOw414lP/i212sXSfncZnwSH71Qn6X9MdCeVz+RD3VrppLjy6oJqxK4zlFTiZF2fghWcvxV
	Grd3VScQqTICbGqYQdP+O/XnCuyCWKa5YnM1ctnkiifr4Ne0J1ZnLkq36T+zIqza4gOhrq42ynb
	p9PsS3f8zC1KBfD2RycPIi+rj+10AyCuySZSAzXzuILtwihNcRwU7tO+3ibt6Ti5HaPGF3nHkO0
	GXn6Jn72PigfjVCfH+f14gYMLYZ8uJyD9W76YATFJqh/sKseo8fH5Rf5v
X-Received: by 2002:a05:600c:5493:b0:4a1:c27d:e1a8 with SMTP id 5b1f17b1804b1-4bb783813a7mr42606245e9.10.1794903965400;
        Tue, 17 Nov 2026 00:26:05 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7ad9430asm12629125e9.15.2026.11.17.00.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:26:05 -0800 (PST)
Message-ID: <88041240268f70b218de7dfd58c41977d03a60d3.camel@amutable.com>
Subject: Re: [PATCH RFC v3 03/44] target: fileio: check that the backing
 file supports ->{read,write}_iter
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
 linux-kselftest@vger.kernel.org, Chris Down	 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:26:03 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-3-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-3-8cbbea1cf34f@kernel.org>
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
> With fd_async_io=3D1 the fileio backend calls ->read_iter() and
> ->write_iter() of the backing file directly. The synchronous path
> goes
> through vfs_iter_read() and vfs_iter_write() which check for them but
> the aio path doesn't. So a backing file without them calls a NULL
> pointer on its first I/O.
>=20
> Refuse such files when configuring the device. On the synchronous
> path
> every read or write that needed the missing method failed with EINVAL
> anyway.
>=20
> Fixes: 769031c92c8b ("scsi: target: target/file: Add support of
> direct and async I/O")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0drivers/target/target_core_file.c | 8 ++++++++
> =C2=A01 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/target/target_core_file.c
> b/drivers/target/target_core_file.c
> index ab9824a4852f1..a5391e57e9aa5 100644
> --- a/drivers/target/target_core_file.c
> +++ b/drivers/target/target_core_file.c
> @@ -144,6 +144,14 @@ static int fd_configure_device(struct se_device
> *dev)
> =C2=A0		goto fail;
> =C2=A0	}
> =C2=A0	fd_dev->fd_file =3D file;
> +
> +	if (!file->f_op->read_iter || !file->f_op->write_iter) {
> +		pr_err("FILEIO: %s lacks ->read_iter or -
> >write_iter\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd_dev->fd_dev_name);
> +		ret =3D -EINVAL;
> +		goto fail;
> +	}
> +
> =C2=A0	/*
> =C2=A0	 * If using a block backend with this struct file, we
> extract
> =C2=A0	 * fd_dev->fd_[block,dev]_size from struct block_device.

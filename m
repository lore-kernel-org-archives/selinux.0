Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903942;
	b=kfo/xhe96zzHfhfIbU9SdZonvP2EoRqtd/A32wxba5aNGNJZWAmX/ng8CSxnKfVKYAmW
	 R8fQlWabu2z63HBIwgmWx9KJfYnrmKYgMz0XZD0COKv+ptLDDkrgAn/KTAn5KnnYPrGu9
	 oEqgRbLfTFpauYj7nLI1Jkz6cUUa39Dix4RWo0fNAxjZyDXDrILGTXekSx2V1zP4oww4C
	 eKf6Puw3zTmg28/C4O08JTUzM/zpEef5oPTRKyTa/XdiHfqQoYzvLFQ0zjj61+RisG0bn
	 7BZUFM4j0YzzwxwsMANgrq5WX34pTd/J/XGIeztWhwS6r7S6J39ZoYXVdq96vhdrKuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
	b=BmTRIjcRaofNQ6o6BnPWTtyHUCPFb8FrkC3J9CdM9ZcN2l4WLGEUhZ7YtxLjsc+uEm8v
	 yClsy+E2nMB0FKh7Go7TO2sxW+Mqg3jTUaXbHH6mztcqYVmAb1ZEVPJmr16RuMgJF6xEn
	 1EY9EM+/gx/2wMGYoRY+ySD94TRqTA4sjepv8/ZDWExJ/Hgyt76+NAKQNqQGeLIHVXf5+
	 ofU22ox4qh896Sa11xAPlV83kE97U9wiW1/HbAm7yy2vobpBaUVsJ2tYvCWM7Xwz8xMAu
	 Ij+WWWv7a199E3GymlfZEOM6CHbxpkUPtaGEDd8kmlYv3GX8AlmAaAEoQqyop8mjzUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="QoCmkI1/";
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BD7606A338
	for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 08:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20BD7606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QoCmkI1/
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48b001cd92bso2841207f8f.2
        for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 00:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794903939; x=1795508739; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
        b=QoCmkI1/XbLLMuB5pWQjj6w7lhYbbqiM96jQW+pj9RZ000aRRl9S7H2qSmbtORMNOo
         ePt1TXAWzVIR/TrMeI58Zu3n81XgIdPHavzyhyljr/3uEJYZwsW6Sg14gd450d308jE0
         RrvE2vSlthe4MhW9V05IsJzW8g0CM3u+nfQ1hkfntpYQW6a4z4zmXmxD0w/TiuzDbd7U
         U8xZ2FexNWbZhSQ3d3pA0tlH/f0MOfn4O69UeuIyRM8vQ/YXTKpGPDyGoQczoxEfoynP
         BDcwZppUf46pJGXZ+RH52kug0iZSl25eld2NGIqCa+XVs4XFwFr0CZI1pzljVyhbNHw0
         NmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903939; x=1795508739;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
        b=fhcLWfxYGy3HiFnVmNh/XRv4R7fmFMciXtldWmwdXqDqN6h+g79h97RVOQNHGRiAPn
         EdW/avBrqa1PfnV0kie+D8qaAL7XfoY375x2tCggI9KeTmQgdZnITGfGqXxs1UNl7mZI
         ViaiajCwb8fkrP8N6a2UCOc+ZyE/v/Dhg7oWYUfe6NTfVuHIpeaTUxxHx3GhG/7Z9vmt
         6SdE/yaOS7VOLq7/kpQNIG6+I3NIQ7VCjojzw+ihDFE++YPr8YMxtgKHuwiCDmdG/HxE
         wsrKakB/BVQ6dh1WJJ1CkD3rNM8jv0yA3en5UleQ1rC8/7eRKPbx1dITfYhXzZJjTHt/
         UySw==
X-Forwarded-Encrypted: i=1; AL+hErGXLfyHTfAWE1Tlvwxd27Di9/YRBjE5+7bo68dmiTIjy+eyih/3qB1ZIcCH+AyNTA6oPgE2TcY7@vger.kernel.org
X-Gm-Message-State: APuU4Z/5xciKC9mhIbm6leR6TEcFl7KP6zwI4EnUc2NDGmJa7srbVJfJ
	fmSzfynSpnOMplCjnuEFEobOQKkDanzRB0/j+TSULDGYJdYFfzGQYJ833L0+oUpq96sH
X-Gm-Gg: AZFdTZf57pIpPbqifcx+D59iZ6/6wIKOaVpwFXPhJU4JCoA7DATeivHkDsX4jeX2j3q
	ic1JQo1fkm5hOSVD+/gazHg0yMfHwL4y0b//OdwFjuySKkyS5daIufuiOLFnSEPkEMe9nwYlgZk
	MdGf2fqdhz48Nao4JKUJCsTH/s7bqZdKrt6NCcG94ZzTmyDEeGeBaxq8et99sB7Y7Sp0u71va/y
	GN7U10IAVL98SkwqHcfmyLaLl2ogAiFOF89b/nnZTSEiyZQqYFrpN1GtHSP+51hhD3dHElmhXuT
	9tYgkWPyOPURIzX3BovXBNJCcCGqkp4MMDmSMf1PzwuEgSmiUdsDFdJF2+J8piE5SvTGvMM9sgj
	edshC8ELGRUJMUjQarkjcMoMDc/YPwY+XxzB/nE/H88qnKJ7UTW9yqaAEFfGJGKZjbv+eTOKizs
	gN4hEAOUmmmOjyIvx6lwTlOxLMc0FArGRq5F5NRxMDR1Jyb0ZyMgC1bIhVPCU+vx+TEMKjZ0pcq
	DdbA3d9Dv0rf1bfW/BJJylbfg+K5Tp9l+Q9v24Lq/2R0EChv0HOq5AqqTx0K+HBBiizS8D2XdtH
	IAJhV4gaC+JLhSp2cxNHhAOuk/WR2ER2vWzcmqffRiCw8w+FIg6wNpADIJOyOe2EWVZuGDfzZ3l
	W0t85K7PCyB/PRuT58CDRD8SD0GE9fUNJXbVOa4FXxPQigreaD22CqC6fFRwN+xTITFHh+UbQjq
	ocgA==
X-Received: by 2002:a05:6000:2084:b0:492:46e:d4ce with SMTP id ffacd0b85a97d-49c6fd932c8mr25238543f8f.13.1794903938925;
        Tue, 17 Nov 2026 00:25:38 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5ff2be55sm26907832f8f.28.2026.11.17.00.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:25:38 -0800 (PST)
Message-ID: <a9124bf1c858cef3e8ac06b1b2396dcb0e19e2a5.camel@amutable.com>
Subject: Re: [PATCH RFC v3 02/44] nvmet: check that the file backend
 supports ->{read,write}_iter
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
Date: Tue, 17 Nov 2026 09:25:36 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-2-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-2-8cbbea1cf34f@kernel.org>
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
> The file backend calls ->read_iter() and ->write_iter() of the
> backing
> file directly but never checks that they exist. Everything that isn't
> a
> block device ends up in the file backend. So a namespace pointing to
> a
> file without them calls a NULL pointer on its first I/O. Only
> buffered_io=3D1 gets that far as the O_DIRECT open fails for such
> files.
>=20
> Refuse them when the namespace is enabled the same way zloop does
> since
> commit 0c10f8a1a7ae ("zloop: check that the zone backing file support
> ->{read,write}_iter").
>=20
> Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0drivers/nvme/target/io-cmd-file.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/nvme/target/io-cmd-file.c
> b/drivers/nvme/target/io-cmd-file.c
> index 695963dd932ee..dfa8aa46188c8 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -47,6 +47,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> +	if (!ns->file->f_op->read_iter || !ns->file->f_op-
> >write_iter) {
> +		ret =3D -EINVAL;
> +		goto err;
> +	}
> +
> =C2=A0	nvmet_file_ns_revalidate(ns);
> =C2=A0
> =C2=A0	/*

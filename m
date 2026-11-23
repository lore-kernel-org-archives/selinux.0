Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795457510;
	b=HUARDwiplS1CUimTGJcv5AE/TvddhmnYbvFrpKKGKubKV/I9qf69Je/3XvpAVqAeMvxV
	 wyoMcdMzSx+erBWbMT7Cdpw4dwtI9k4xQyRRSS/XVtomRKUMRplLSJ01Vn9SvoGq3IrLl
	 qLxz40mvm4aY/+nEuS95BIbCDm5PkL77geZMKpAapZmSJ2rwtQYgY5B8PLYch7cd13hRy
	 vj5Sq6NmxgYQc/Oyn5OqSmQuBGe86pHh5yxK593Bqzkzv9nu+hMtVcEac4YuVTW8tnGlF
	 zRzisYds2HRO1J3esKdL1/yTUTFMG5+RSh/BcN5aAZ6NEiPnA3hEjy1z/WzhWfnQDzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ReSEyBcuc2xxSrV/BvNbLIC0nX5SdFwTnP+2/s3NLGE=;
	b=kTG9UOyCGgC/PlfqR50T0fqHx4ONi74JxY4A+pj8VGQA/+GdjS/ekruY4Dvf9HJZOkyE
	 RhCWPTgiq+dF7Q4dPinzjVWtgKhf9wmSSbKP9HA9jyIYj5rK6vQ0+QDVZjYNdvI+zzQDk
	 jcA8VDqnCqUUq6A4OtahPAmY+mk9L5jIDD/hopkgaQK+EJA7P1MmGULElBXcX4b3LpcT0
	 eqIU5p2i00YWgMnnEO6WGlfANLNa9KsZqegHEOCMKzRq0HEfg2KMza0Vsso3tWwUvEEvU
	 yCW5yd2c/JIp1oBdDz2yimIfhggNDHgdz3nLHPC4kzxj2pXtANiWYT7CHoX8GtIB87Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jklDZGWr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D09606A31E
	for <selinux@vger.kernel.org>; Mon, 23 Nov 2026 18:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96D09606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jklDZGWr
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67be4f2f4d4so4099877d50.2
        for <selinux@vger.kernel.org>; Mon, 23 Nov 2026 10:11:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795457508; cv=none;
        d=google.com; s=arc-20260327;
        b=m1Yqn78JJYAC2mvRtVMVYOtUR+z5Vr3DkHQBJTXpkrDqOR9EG6j5o9FrW6VnwE/Vlk
         qnNpwXhSX9jeWTqGoF2E+tT5cZsRa0kZsqu3PXmXv2/kAFvdxOyjfXtzZ67neJLwRJdF
         jfQi00qIxbyspW93Zwh2WBOgf+4qFSv5eee3D03ibsGBE60f4ndqA5voJPxf40gLANrV
         tBpULTbw1inkVc3ybqcUQckoVi+utM0016Zsu67udhl0Lql1C1JJhhde8U2mI3G719UB
         p98mKyD9KZSU224Bi4JOOPbnBRT6Tb3sJs4wmOqwTTPadfaAyXwe1jtHdNPYTxIHYB/K
         e+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ReSEyBcuc2xxSrV/BvNbLIC0nX5SdFwTnP+2/s3NLGE=;
        fh=QFKa48eN4AZKFIyrSiZk3FCE4nUKAEfyzhRYxfFXB60=;
        b=RtAWlsSvu+kME+mdl0wZpVjqvO4+aMTpuBBjSOXgb50gJVfu5ADfp69f03L/1W8NI/
         esiMVjrxLl+VYllXwBMMHMSeyXAdpuDKdkhr9pGdk9zNd0AETb9uwHiqvV2b0dq80yag
         3h28Eqy/pL7HzxTg0R60IWQ7LsQd00arC+/z2sHNx1ylCKb3LGRAXPghoQl4fvpT84jD
         5SjVb0TsqOKNNRsQSkQ63MPTTc84pBUMwoki4vmLJ6eFCCRMFtHZ84ave6kIhzmO0CWP
         ot6EmCD+99pUA80+0MA6EGEfQkwFr2+Unvak8CxT1i11LQSLAyvP+ZVvQrxDKYLQhIdA
         jTEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795457508; x=1796062308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ReSEyBcuc2xxSrV/BvNbLIC0nX5SdFwTnP+2/s3NLGE=;
        b=jklDZGWrN0PbTnRQnDnekB/c92jl5tubUQ2SxEDcsc50F7oov4qBq28YaCsCs38kLK
         FHOd2ek0xGbAqPbDoNPrdh2oQWh6qZb+K6LkKXE6QFzSsmHgLl1IapguztCF91KWIp5/
         rqEQRSpM92xxclehGrAHbSaEaUl8DA1ihuhMNUAIuezGKizxDMOXmmrGRy/bIhZUfBec
         UsnXl0NPR9hGboXdu7JP3bV/ybbFllUcDi97u/fyCcuSvUrRXT8O+kifEttx+wjYxMA6
         gmkOiVaV99Gfggoyhn4/nizksFvr2l1pAV9lT7fOmHoa7K2WrtmGKoweKJi9hKdFNNoZ
         ohfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795457508; x=1796062308;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ReSEyBcuc2xxSrV/BvNbLIC0nX5SdFwTnP+2/s3NLGE=;
        b=nVmAwD2L1xp1vrEVmKx7k+5d9t/erhuuZCzA8gmJvSGB/jAqrbsSm0SGvd5YUWxrsD
         1xJR+FP6YNjjfMEMvBgqbnZYdoVn61NLEgQGfRSwKs4sh0S3JcTYd3dKJJJpKpr4V+n5
         NWifoMoi0Ptxo+yBVu5LaJ6e4dAcXursU6Qwai1z8WvMmzeH2g5qdI/OagWQTiYlkcZm
         dpnYRI6STVDbLMWP8hY5u6De2UobovroYlYSjizM+vCNpQTia/cVSD90WD4pXkKA9Qdi
         WVYeuDcN6qHIZceDP11O+frQ2ysSue0sPhMDFHMlCGmf57PpHa3BcH+oKpDlAi9gqXQt
         f6Bg==
X-Gm-Message-State: APuU4Z9t7eRIYPIZS6fP9As7EcKHrGDfZWBI1awDPQxqbCNuucVuI54l
	7Xs98jEwitZWnh4lV4YTxuEvePh4uReLrMLVPdDguo4D7ELa1YypCUj2EdDP8zCZJl2tbLIQaUe
	tw0rrSUUIeNeYevuvwqkun3ueRq7ZOLrKqBsD
X-Gm-Gg: AZFdTZdA9y+ROypWSjVKRE8XFaquE6yPHPRiU41F4+3idEryaPDZf8Yu6QrJx8M3Nkz
	49gVZxFT1XMNg9afJ8EscPq/PRTPU4MID2/t/3HlwkoIQWA8UELC7fd5elfwkn+3G51SO4+3Xlu
	3z+4kNCgl99BLJLF25H+fivZRBRNKDa6fxhLAUsL4sKhwinf0VQSZaZ28o4vQVLJcuT1MmbiT/T
	BZ8WAyV2C3Ud5GRdlJNgF3oAI3/wD6AaTSuJj1ZCa+yJVflhMXDGB0BW/G2uJZXMhVWQrUT7RwJ
	Uo00/EVoq2o569Zpb1otAX0x7Q4I+Mgkqa5b0NPdSF5kdk4HYcLAWn7ZZAo82xrvZHwjo8qBBzN
	lg0Zpst09xEUqzHrfwSAdLZBwpPMmBlzBg/15hRDLwDdKerqK0Bl4JyQDianqsWcE86pwzrk8ZO
	15Ml6h/i54l7BOE/3sQJvPnGU9UTJYCBVRKkbJ47ZDjwIYLTMN5qZSwEvQJg==
X-Received: by 2002:a05:690e:4106:b0:679:c916:46eb with SMTP id
 956f58d0204a3-67df440e71amr3514124d50.20.1795457508329; Mon, 23 Nov 2026
 10:11:48 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123165102.56120-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261123165102.56120-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 23 Nov 2026 13:11:36 -0500
X-Gm-Features: Aa3M54qUz16gsActktufaj4q0zY7kxpq7v3uKitU4Wc6OCpgizRZT-8amSY4NRI
Message-ID: <CAEjxPJ4A+UdtJBZXbBhad-be6qnOac5-w9bPJH3_aV6hUbuFHg@mail.gmail.com>
Subject: Re: [PATCH] .github/workflows: exercise the Python bindings with PyPy 3.11
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 11:51=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Add one GCC job with PyPy 3.11 to build, install, and import the
> native Python bindings. Keep the CPython and Ruby combinations
> unchanged.
>
> Ask the selected interpreter for its include directory instead of
> assuming the old PyPy layout. The Linux extension does not need to
> link against a hard-coded libpypy3-c in the intepreter bin directory.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.

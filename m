Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793995541;
	b=rXdIPz0A43QoWaCKuzW0nBk4c77NSTgFVo/AxbTTi+K32AeGGEPqt4Hr1Bir5FL/dBo9
	 C+kFcMcaleHnS2EIVaNrcfDAt/vNaankBrLc5wqDHjJQs9T3z6N9KXfvj46k0Z7REbK7N
	 bKDY1FMJcMyRIQDimrKm71ZD5QF51Rc93N1FJd29Gnkbnk2r7SbxxqdIcZtImRN7ZSaT2
	 hsqyHMx68PQRNecmR8bn0rcvicfj2zxVD/L1b4S6TbJrRGlY1wuf7KqnGLfXHJyBBApwS
	 s73mRG1PLarSGB07yHId/KojCIC3aoGu4KPypluncTjEdnSJFnHJQVoYApIB3sCAgKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995541;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=XfSDKTkd7zWGZO4akmOnFPYAgmCn4XgAWSzWDbR3S7k=;
	b=F8JpvVFUovGuBKN0UAESv7MQk7qhZtoRQXBRSZA1I3UMqvfCNtLpLGT62YNRbPWTQ+p5
	 Vu5TdnPqIS34uSNXVafU9ugILKJSXCpiqZp88a1Jd0tiIW2dJL5wnheVu95qDnZEg8U7q
	 6uE+HMdbihrdp+WwsTz0wjxSBa9OZIwGbtHQZ/sHlNL9oFwZCbJsrOK2HI9q7/98LRGTp
	 AqnpvwOxzydv+nLF64xoVIaClFJqggXvVmFqegVlRMnHuBnq+++eT3Q9fh4BrzQ1N9Jru
	 srf4Ij96LB0k1dysH42D4G/T8iCBTiVk+N331YXbIcBSkjMm6QJPOLEKcElHzA961dQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oyev7ZVC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43C3606A33A
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 20:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A43C3606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oyev7ZVC
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-677d35fd1d2so1219698d50.1
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 12:05:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793995540; cv=none;
        d=google.com; s=arc-20260327;
        b=j1vLk1vE9YbWkmbCv4PLgFWSQdNGJpnDTDQu+r86t2GpFl+EY0txwgiFFOCVSn31Zp
         d/L1IeAgkcFiZBzK5pZVrypzpbFTV4I1KDR9pv/TX8zNU4MRSBuhzs9yNmFsJ+fP1eCd
         Sj7MEKiHhMH88Og/dhml5q1Oe95DeA1EMoqIGQAO7arLY2WbbDKVTmbtkcQQ0SRpHg37
         699FeK1Kqx/VAx79ibeYKKxJEIBH5YlNsdRGnHG9cxuHSGFqa46XLMjFepowszP1vwhM
         mYPXv1JWew/OmPC33iSsMqallYDchEbn/jubEhXIdTs5TTcWbIo2gX3QnkYyipHALj+9
         ZrNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XfSDKTkd7zWGZO4akmOnFPYAgmCn4XgAWSzWDbR3S7k=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=Tu+Zpld4w8fTQAGLV+AFvnoA9BdiJqBnfmt4hrvrKwWlR/RiIIufW/Bx9kzZBPJLMw
         R7W3CRI9Vqb8pPNOBpS+NilMsH0Hp2y8vw86BnsMxxO0Sng05PGzYFzWTUm7rjUzr5jx
         iJZY9GaJvlCB5ugPQXKzdnaJ4xgmkLjye4T2Gq5jYHiJHauu/XOrIPMFKWR8l8eg+Syl
         fjoXtOqRlNtVnej1plPHLneUA32nJgE0LaF/d8vWrLzHoKc9QLGrZ1I3nfwESIUmds98
         vQzqPawCyxsDOS0c2eyMlFIUJVFAQu9MtbfvFE4HkaGfy2Rltc4u+m5sPNXafHF4TdEm
         b8uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793995540; x=1794600340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XfSDKTkd7zWGZO4akmOnFPYAgmCn4XgAWSzWDbR3S7k=;
        b=oyev7ZVCUJ1wK7Ynl7SuZlWvqYJcGZgB9DfQvvifIGmhP5+lutM59FMXpTtWVMHuPh
         F+Oin+19sP9zYeNocDxGPcnRIkXL2Oq5Z6Za1H0UL3L6w4i9t6XcJmEr2tBiGX4by8K7
         +KqVzAW6e4ROXppowZkVGCp6nzIC5OrddPZS+9xctRo5TzEFvHM7JJ2yN+1eLbGye51E
         Hv74QW82ep+1iLEyCLU29NLoCcreDWc1JEqB5shXNR7SiKTN/HHEMMPoDNESxvUnRfSV
         qRTuyEdiqhlQowpgH6Zfurmjw39vIwTZDf08pdofjlDVoopgS3NeUT61BWCpWhJMfnJw
         ZVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793995540; x=1794600340;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XfSDKTkd7zWGZO4akmOnFPYAgmCn4XgAWSzWDbR3S7k=;
        b=RLfzTbgQxDrK+xJVR/GblK2k/DGkuI+ZEe6DBKIHpZDFvTMCiVvXogBeCI6lbX6C5j
         /6sd2pDdVaEoLPkA7LsTy8BMbOJvp3hrDAZhCc4I1GGQQ4UzVLy8YIL7B9NTbUZhobtW
         AQZBNeygajgDqqaOnjXgZVIU/xU2ZPefGYjNd0p5ytCkbr/+OKrZzMnThYQmtal/obLi
         ZGXpr5So5TzYeGwprlW69CdtfO4EF/rGiW88v8tyg9eOXAPcQ5RUrmlgnV5lPnXlIZEX
         ZIM2F44I2FfNKdTvv2tx9oWmM2kLLIGo4ynAZwytm0z97V9qX8iY9HpCxTQy3FSj7su+
         Hi5g==
X-Gm-Message-State: APuU4Z9W4/GiKJnb1VLplTJVMqk1L7doZgPA6zvKl/PBxvJLEc0RAmgC
	1iIR+ScK5AIgkUFeFJ84Z6YszK9Q37D+rbq5rPI4cRjQhCPtGs0kKOGaCqtzDNjpSRHR3ztaS3e
	QtRFAcFc156Y/5gJK2dwbl1f1jI5izes1dIlXvOE=
X-Gm-Gg: AYBFou2k1ONk/gKIQEE2UKuivWynJay5Dpfm+9UlBwMrIKKtjcGI4y4DEtbxWnYiz8P
	KCPu6ZXaand1BCuuQgZ53okcQ5RE9wSbwFt+DXMwhdFIkod0+g2pMgtXtJeg0qEFGWa+4L3n5cN
	lf7v7tlK1UDSlpAYtI9nqiHX/GdJ+BjINzVju0XzR8scsLMvQxKtmMm2GI2CxMXLpfqmq/ZVrL4
	HUExOSf5VEnA5DoKZ1mDP5lp4VqyF9SisMaj7JxYi7+10P9ImmYeSAOHWl8kYS9L5hjdhnLsQew
	/ZS8jyJF/cfauNSjmpkDC3jGjvQzB3tsJLKpRJvQl5diDqYkXcBAmWRHl99F/xNasmg9SBXykwl
	Qh+8wM1qxWffDCLy9tAmbj/08BDJKmKA6LadkB5R+HP9VpH24f57ORDsY/IwyXpJrvHS1nc3oPP
	ZoagvGTlpB6SiqiSwi6xojgDb0wGR87109/v8CJyWx+q7bgvIYzpeyXpup3g==
X-Received: by 2002:a05:690c:c507:b0:8a9:693a:324 with SMTP id
 00721157ae682-8b341b2dd27mr16206227b3.109.1793995539717; Fri, 06 Nov 2026
 12:05:39 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106123510.76727-1-cgoettsche@seltendoof.de> <20261106123510.76727-14-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-14-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 15:05:28 -0500
X-Gm-Features: AclHuK8PC2FN62Y89pAbWcKDYvztEQNEG4Py1A91q-oYIrx2g0Wml5xfkVhRnnE
Message-ID: <CAEjxPJ5kPKxiBGp-WfJQR9M786Bn1jJJD1sKxSNKCuP35=no-g@mail.gmail.com>
Subject: Re: [PATCH 15/16] libsepol: convert user statements in optional
 blocks with their roles
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:41=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> checkmodule keeps the roles and MLS attributes of a user statement on
> the user datum of the declaring avrule_decl, and copies only the MLS
> attributes into the module's global user datum. declared_scopes_to_cil()
> however converts every declared symbol from the global datum, so a user
> declared in an optional block loses its roles:
>
>     optional {
>         require { type opt_gate_t; }
>         user opt_u roles { base_r } level s0 range s0 - s1:c0.c1;
>     }
>
> becomes "(user opt_u) (userrole opt_u object_r)" without
> "(userrole opt_u base_r)", although the expanded module grants base_r.
> A user declared in two optional blocks also gets the categories of both
> statements merged into one range, e.g. "(s1 (range c0 c1 range c0 c1))",
> in both blocks.
>
> Convert declared users from the declaring decl's datum, falling back to
> the global datum.
>
> Assisted-by: Claude:claude-5.5-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Received: from mail-yx2-f24.google.com (mail-yx2-f24.google.com [74.125.224.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DF8381E92
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 19:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.152
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363130; cv=pass; b=PWtn7Gi7JDl+gYHMmIsSt03BysSNYVMsTJMO7X9JVIZAm5cpfKeovNv9LFBeoS1h/Lt6Vu//ShL1NAicPyjhG5LUmEvFqhB/6MZSx5r/r97K1C4RPYGMdjbVi2+kvs1LvoOKEt8WEmn0eq07slJjVTWxnnjiTMbf6aDZcedsKwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363130; c=relaxed/simple;
	bh=ZD8syd4TCMclD83SCleqU1uAIs4rxf8AT4HGPC6a7qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbO0/v2BqO0I2D5T1SY+lWyAbxA+jxJj69BLse0/9Xt7iwHPqaRSXdE3O6vy4CMpxuXROxo2EMOX9JOajVMQ21HCsEM9/UGcPu/MYioI9zrZE5E6PEYXO5QS/5gg+2ay8Nj7LJMxog7weCEJp6Uv+V3rkYdtF7uJc6d2nLbg7t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sbm1P6KR; arc=pass smtp.client-ip=74.125.224.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sbm1P6KR"
Received: by mail-yx2-f24.google.com with SMTP id 00721157ae682-8a88d23a5a4so7895547b3.1
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 12:05:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790363128; cv=none;
        d=google.com; s=arc-20260327;
        b=CFbuyNoGWn1An0zQCM8dA4J0ImCvQ9/aM2VTM7RstpzjuH68hDRCcdP9W1w/pJ7+Gl
         /JRNf7SaiShjP1L+RofULcPBVn3qzrj6ykJcUltoU5e1b99ny/HuiCNBoS82swRx+Ks8
         +6NEfKLiMLiQBgys5uNC02TfMKw1ZEPKlDMCU10JPTUE5UjcWzncae/lHru7442BSW33
         q/rKzR5XG5zjZa7nvH20SICNNndoOxl82bzf1s/rszE95NDZgYimHb+EdI7JmNHg0xk0
         L/TW7FFeaV7fb4gP1IywCrBE56/T8/WVCsQDBJuhrw92xF8WWQ+y7GAqqqFhByrMn0/L
         0HQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZD8syd4TCMclD83SCleqU1uAIs4rxf8AT4HGPC6a7qI=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=qysXJQ3B5ETyVQubzHkKnPCd6UVafbS5PWrHqeNNBX3lzSr3/QvhGQzthafsFjrt0v
         M3HOJR5hqRJ2S64r16wzLMllRxFUGdw/4bHZOUmnYXNVPVRjnEXxJVAOPDuIr6E+hskw
         dYwonU7ZwpQvMuw8dHvckaW5upZyJbYS3hvaarV6/VGk6s5d1TY8egBQRAvve+b8mghA
         mQgxXuroj1netkKqxNhJck+GpEcpyNi7mJkj8LAFJ/cSnAx5wzcY31uBhnCJfaydViUt
         mW7oJe6buSNPBtEE61AeAMrA0WQPYJwpKrIQr2hESlBEN7eP512r5qenVz650yIuH+bY
         4I/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790363128; x=1790967928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZD8syd4TCMclD83SCleqU1uAIs4rxf8AT4HGPC6a7qI=;
        b=Sbm1P6KRETZ7gdkm/1meKbCAOQaUKO4iCkV9qsWTSk/HL7P8N8F08e2wuq/nl0gjPy
         ZttkFrEUpaW7dUUJ305QcMo4VAVutMG+Mw82w/9DWnQvuKKPTwo8vec7rDaaL9hh7h7i
         AqbXwngOW6FIDSCvSKI+oYuIOI7KQhl3/TuHfeHRLuSSRgLlzlJFdyW/gj37ZWJJW1ij
         COCEnmccHayvq43odTvR24oHMcogt3ADBVOSM55/ss+ctxnn02FNWtvV5OH4KeOArER7
         4cDwy283SL8hLNIA0jrufyOg31PNBPNQOGlcXdYXGK3BxZ8FN9+m3AFj+w0AeZG1xdN4
         FJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790363128; x=1790967928;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZD8syd4TCMclD83SCleqU1uAIs4rxf8AT4HGPC6a7qI=;
        b=bTWSKCWo6Dve+nwP1S3VeHG3KLL5aHWDO08cGxC4cFjz6ddi7QZxpG5icpAHE90vXT
         J8ZEoODRkbymm1dx62+3gjpCtoIhs2ljN2QYiQy8dJgaO95aV3gnAcvvhl1DNuVcGYGU
         A/RaC8CvorjQ6YtUnGghFqlnih5HIKTyinu7vz2TfLYKXhPrU1u1/ZN6wmmDC/3lEI5T
         4W8wF1crCBEsgIAlpkVn6Zdh9/rrh+rw09b9j30b//wP+VdcohXVPFEs4ud/G1r/J3s0
         Jh9ZUFKUEDANB9R+5V1kpxqe1q8Cv4XLrkUXPyknYH/8tmv4wHSEcDXSpFTV8EzNR8ro
         y3gA==
X-Gm-Message-State: AFuF++nLORX3vsppcbw26aSsPllc96wX9FIQnzLGcw733zWfvrwEpTAY
	xR3HAaKyWYsQVUqrqEeojiZi5WqvfjiM2l6jW4sCiXENtQGZMAUpwQSz9rvhtR7D4Bh4wly820X
	jE/D70LbeWqXV2AImwKecT0CnoJmmDHY2Dx32
X-Gm-Gg: AYBFou0WyHqxOo9GTiNlM6L3BWfsgnuignS9ndIzyaihatjrJ8FcHqYlJ6kV2VGDmGt
	u2img36vQOQ7n0daafT2i03Yq1yVYo1m1dGfE3OatrRtZlKOq2UEnWzgC1NDWLq30OfU0oLGh0a
	gfG+OXess+GpqogEuzV7cQbgYRRXqs7yhlnQGob4JD6P0j8EeZs/mwpcQNfgQ6FwHVcRpuXMI79
	uwJGVepbThoQsiJA4flchRrrRdpjYL/0HMxmNsILmQ611NcbMH84a8+draCBZPIKQlNDp26b/6b
	1OtShlusGzs8Ci8a6lQPxPmnecgCZEdU+HtzwYi8Si+Nf+bn42Zfxz9VXIf7fdwVHw==
X-Received: by 2002:a05:690c:39b:b0:8a1:1af3:7e98 with SMTP id
 00721157ae682-8a649d6e915mr32597117b3.102.1790363127708; Fri, 25 Sep 2026
 12:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de> <20260925171755.2029271-7-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-7-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 15:05:16 -0400
X-Gm-Features: AclHuK_zHyR7cFo_Yi13nfAq8K_pFOJJfPrq8GRW0Qh80Ug6Wp8htwX5J7Q7OEU
Message-ID: <CAEjxPJ7PF5RUpnxApJHUEeOty2ZeQX4XnGcmadk66Ou7eyja_w@mail.gmail.com>
Subject: Re: [PATCH 08/21] Makefile: use $(MAKE) to pass options
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:19=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Pass make options, e.g. number of jobs, which allows to build multiple
> test executables in a single sub-directory in parallel.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

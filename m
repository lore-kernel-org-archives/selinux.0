Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E5E27726
	for <selinux@vger.kernel.org>; Mon, 16 Jun 2025 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750114944; cv=none; b=ZF4fOvr8krywlyeQWI06kwh9vn0XMZHEsjfFoqCm1zS529HlNnXGy/zLVvJ/apDfR4x9EZYC01MA10H51LrnnNvtHCm7MgpJOrKXbQyUsjxNjAJ8Qz8NsLGnEy+W5U7Zqe2TnLAFquDUepsQQSnMKmDg2eAmATDkFDkPYvu5Gf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750114944; c=relaxed/simple;
	bh=Qzvn4Vfs7TwjMPkfPUXQuGjuHe60zhhpF84kJ2MNtFI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=sedOswtFUcMlfK/QVGJIdzhHhzzhW/Q+crOpummJBHiTchH7ADNxF2wlplYw0pJjDSyGHn8wtncrxeygt1bQhflWqWe6ROO/o3fwtQKqhsr56Tf6W+hPLF0Su0fqXsmTonXPAer0Nrw61Ow48UI/uwHsU9jzMravHxfEI6pH5LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MzTrpcZV; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MzTrpcZV"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d09a032914so450081985a.3
        for <selinux@vger.kernel.org>; Mon, 16 Jun 2025 16:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750114941; x=1750719741; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1NE6bnFDWsI++CmNZvaQThHetec4OHkqOKHCLSgsQM=;
        b=MzTrpcZVaBWnpTcjGGSjedYi7zJYnXEz+wf1HdFKHhsbytYHRSqlUN0WYoU+Enjs3B
         2JLbP0q5JSRjMfjAJgbzcFLf8PwO4BrNTyz07HNR6nzZk0Ou/aI9CJUTI2GTRkgXd8pK
         TI/HO12j9qfznWlPTDfZOiXFbEFJoRqbGq4sLkiff/y3ZW2eI8wmF2NMUj4b7hwhV/rH
         62F4454pSdXE9v4HI7cOX06yXEiBjWBRaednX27HgffycP7SS14EnfItw+7jTls6BW1l
         dMM9gSlp1ukH4u2FS2hb9dPh4yc7fu5OIp8TwlSAmVVLQRO6MJYVFFm4CuEI2pMwpqsx
         BRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750114941; x=1750719741;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e1NE6bnFDWsI++CmNZvaQThHetec4OHkqOKHCLSgsQM=;
        b=fF4S58Z6cjKhf4Sp1TeG44wyBkqx77Bdk+I5EHCbR1QDLxugfmTZyGRJSdJuXnPq8J
         TtmYI5smDnY3Phbg9/0vI25OPaWie1aQCk+k6eLEoLPeRcCmSqlHntKzP46SU0sFso7L
         B7nSBXUcSUq5JzNowmSkfAKSMEmd7ON4NnC7ewA1qh8aHDapM26o7ho/Wi1rV1D0VCiu
         ovdotdOKyk7bKqxxnRIOe7/7gdU5w8m2JBtEfHSiCo+ugR/dwURZJ0j0FqpBz1ueGK39
         ozwcVZHSGzcAKf7K6yvgr1lByuYTc7eYlktmsqB9c7cElspGbR9sZz79+r9meFDVTFAz
         fRcg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ640xZcpGevZr9W3Wtx1OWF9QlKcR14SfVygJO+fHZou1tRKbGpnS4TZ1Dr9/UF6wy1j8udnn@vger.kernel.org
X-Gm-Message-State: AOJu0YwA1T4SrrwoZm82YC3ol110WAmsGkwRjac9YTNiLrKkCvCooTlH
	0zWaQn9ZCPLetaNfWJOsaCubkYOzpUylCbO2s6kWybj42TeM5I9f50cACZrEDf64BA==
X-Gm-Gg: ASbGncvmk+WbYYaDtIFD+uddLPLla/H64wv7QGGsOyJn86b7OMFWjy8dte2Yt8r7X4d
	i0QbZabKRYSEW8H3UBIbi9GA2FUvaMjRF61eD3fOh866Reqh3F2b+Lxt5BdByuCwh+jqHut7UBg
	CjZQ58lUajUUSDM6Z/vpLOzo7ZdSD/qFhaCFzpxdAOJII50WNOSDDbYTZ4ybWgrc7kZxQ2pHbsw
	wuz19PIJ9KMNehRMDdqN9+lCdINF8S/RU6RksXMSfbZcO4ikuEf4uOWziwG8HWWxBIsUlNOs0SX
	IrhFKQaJDdRhGoLuoFSeuFSG27vOidHodnpoX4daLGOsKKn1aow90h2Kzcq/ObuHzVnyatcRFZs
	uOKaTZyVgV9FTP8VQjLOqwYcSkIdrRQI=
X-Google-Smtp-Source: AGHT+IHHBGz4f+NDlwwifYdhDKwwsmTZj7AK12wwvI2KVitbObJEw6pTtPFn6LbQcWNXWAmZcHrWCw==
X-Received: by 2002:a05:620a:4050:b0:7d0:9782:9b05 with SMTP id af79cd13be357-7d3c6c2c724mr1806306885a.25.1750114941383;
        Mon, 16 Jun 2025 16:02:21 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7d3b8dfec10sm581438785a.33.2025.06.16.16.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:02:21 -0700 (PDT)
Date: Mon, 16 Jun 2025 19:02:20 -0400
Message-ID: <e8c820874cfc83b7e3cd1bc0a6e77ea9@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250616_1212/pstg-lib:20250616_1001/pstg-pwork:20250616_1212
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH] selinux: fix selinux_xfrm_alloc_user() to set correct  ctx_len
References: <20250613193704.12261-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250613193704.12261-2-stephen.smalley.work@gmail.com>

On Jun 13, 2025 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> We should count the terminating NUL byte as part of the ctx_len.
> Otherwise, UBSAN logs a warning:
>   UBSAN: array-index-out-of-bounds in security/selinux/xfrm.c:99:14
>   index 60 is out of range for type 'char [*]'
> 
> The allocation itself is correct so there is no actual out of bounds
> indexing, just a warning.
> 
> Suggested-by: Christian Göttsche <cgzones@googlemail.com>
> Link: https://lore.kernel.org/selinux/CAEjxPJ6tA5+LxsGfOJokzdPeRomBHjKLBVR6zbrg+_w3ZZbM3A@mail.gmail.com/
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/xfrm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This looks good to me, thanks everyone.

I'm going to mark this for stable and merge it into selinux/stable-6.16,
simply to help squash any UBSAN testing done on older kernels.  If
anyone has any concerns over that and would rather see it merged into
selinux/dev, please send a comment to the list.

--
paul-moore.com

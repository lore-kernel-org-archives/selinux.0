Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304E439934C
	for <selinux@vger.kernel.org>; Wed,  1 Jul 2026 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942141; cv=none; b=Whe1xoNaOaNEyvcqFD19i96r/35VbCAgfD4MOpKaop582wAP5wT7lLhVedGX0C5TrL3uqOCQu9UD8eEjILuhrkWlX2PxKhISN0Wwh+14GbJz0i0f3zFnT6rlj7G9H+njquJpnsCrQnanWs72EQfuFWS23kR7KStgjIptt71RYyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942141; c=relaxed/simple;
	bh=oufARKgcF7iUQueJlAQftL5SQ8pl7eRxDIQiAQB7fAM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=N43TRycFPC+FKjEb+PctLfZDH0Waigy75lBBzctT5M5tkFi5HQRGwkDOT9WZ0etUMZgiLVsN94kwgzzWHumMmFoMubRlaNxNZhtkVvJDJIkGHekfDut8bPI5dLj0sFDEoRz81yFa3U03O86STxmvYqF9qDtmr6khw96daHOtOCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JPZz4r4H; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JPZz4r4H"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8ea93125ad1so8334666d6.2
        for <selinux@vger.kernel.org>; Wed, 01 Jul 2026 14:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782942139; x=1783546939; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUyo01ZdXh5/6WC3z8Hnu38Kmwkugh9lUKtPQkGvWxs=;
        b=JPZz4r4H+v2D53LL8UYnJioA0gSVpPw0KiQLbtgNow6D1N+u649GzUDY6F/H9521+o
         TA4vPvncdg0Zct+NfZw7gFwlrLHk6Vti4QCFCg4Stiw+qy+kmOwmeQsZX5N6OP52VHXN
         MfvyD/syLi9PGdvwe8vg1cQJL3r1JwtiIJnpHpptHw9u5aH9flpdkJcLgusx7NsNHRNG
         aKz+qSSvtNWs8xida50MnVkXdo5e5xYdaeCz8zY/X6F4VS8PoMi3cZKyhTQyzxiM20UV
         xwpe0uKojLUaxNRc2W7Qpr+2PYCgibmBFOT8JE2YFGyUwlXr/x7VZp8c5j6+7O9U+j3h
         TNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942139; x=1783546939;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUyo01ZdXh5/6WC3z8Hnu38Kmwkugh9lUKtPQkGvWxs=;
        b=Y3RQmRrQ0YUlSaa3rgbG5lSiqCqL9BrtIfeA1/o4Pkxj4/7wAxZid5YF4M/L2TmCOM
         5aIMHGwKq9ThzJ85bHrJ1crQjxSgW8Z2Y4sS91ziPX51OHcf42jEgHBByyFoP1BL5g71
         48AnogZM04zc+IG7Dv/dysZcT6Bze7Q6Geap93HMzKm8l7FWWfg+/3DyHEo20MPhU+e8
         WjWjnHscmvRZW1tsk2CTRpD94UYZkCdE9c+f3VyMhf9Qs2WHJOxfNgx0+0IQkAIXVHVs
         ggNJ/ZYR4I4xv3ql/xZyiTqgJl/Vtij6kvJlpBHwrkL7qbF2q+uT1ZDsbf0V1Nb0+HwX
         nG0A==
X-Forwarded-Encrypted: i=1; AHgh+Rqiv+PlLCsEHC/0TLwsNOnBS+balNl/VgZT4XY9gjz8s6D2GC4ir+qngCn5hMZ1kcGm0N7D7S21@vger.kernel.org
X-Gm-Message-State: AOJu0YxWzn5DMLbm74B5hDqJ7HbHpK/oF9i5LyrzdqWhCvc646ihh/QT
	ca56TYK6pBr546TFfTIdmplXj1UZalBxpO46xDYWBKIMR7GqnzSp7Fu3TWQVkl7EZ5fhCZS3eBV
	M5qfqkQ==
X-Gm-Gg: AfdE7cn2MHpQ/1lskAqvepKB1tk42O97jNO3sNNdFd1movTQzLs23JpvWtidsE/+RaA
	aXhVH9mPMkeXT8BMSMfDv7sv468CmMefgkMU1xznCjrPf+xfehoi/9bZGHxsPr1QdstcWtnWJZl
	TZVcQAA5jNMZhQzuAq8THyphRwcTwtLz4AVshb7RKVO7oTlLhvvvdbwVS21oT6rifPKTSANDXDY
	AAXt6/GgUwVtVpJOT6EiUcgP7eYDKFsbiLyMlJIQiJ+nM47kjoruZ0OYnzWp5dBeNieEmv+KvmE
	HG3g5BHsujd8oI1FxAwHfRi93mG9DP4L/fZTG+2Ucv6odBTxkDyHTTWnXkGAwH54/u1QYYlNUkf
	hpFrl7AdvpVxQe1f8ortX481zb/ituHbyYgOhmeuQO+9PAlXmWyKqvofzHncZRtXfDPXoFbC9Jb
	VJ+lSuFOv699tgaYc6v/gTGkghh1FmB4qCXjXtR7PkA+zZ7qkjxH6R9tar9w==
X-Received: by 2002:a0c:f141:0:20b0:8f2:fbb1:cec4 with SMTP id 6a1803df08f44-8f3c6fc1521mr39748966d6.19.1782942139231;
        Wed, 01 Jul 2026 14:42:19 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46aecc908sm9710656d6.0.2026.07.01.14.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 14:42:18 -0700 (PDT)
Date: Wed, 01 Jul 2026 17:42:18 -0400
Message-ID: <ce91e39ad10772be9017e04622768aac@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260701_1640/pstg-lib:20260701_1540/pstg-pwork:20260701_1640
From: Paul Moore <paul@paul-moore.com>
To: Kalevi Kolttonen <kalevi@kolttonen.fi>, selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: Re: [PATCH v2] selinux: drop unnecessary goto and label from  avc_alloc_node()
References: <20260622203912.80430-1-kalevi@kolttonen.fi>
In-Reply-To: <20260622203912.80430-1-kalevi@kolttonen.fi>

On Jun 22, 2026 Kalevi Kolttonen <kalevi@kolttonen.fi> wrote:
> 
> Since avc_alloc_node() doesn't need to perform any cleanup on
> its exit paths, there is no benefit to keeping the out
> label and goto statement. Drop it.
> 
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/avc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Merged into selinux/dev, thanks.

--
paul-moore.com

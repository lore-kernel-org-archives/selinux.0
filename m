Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9650864
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 00:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779927049; cv=none; b=LXo4bQi0ywa4eAZu/Wa6Rk8kbuRu668KKjq0iNh2n7SRQImtXuCiJmHISIipTqycPXiiyLm6D5ACLG6WLVr69ucC/blwfK0iiuACvkZkPqW8O1n1deWbosYwVHvqRj5DXgaYZ+ZPEUwJTsiM7mK5kKn9O4pRHoyv/UeIrKijUjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779927049; c=relaxed/simple;
	bh=SK0VI07K7bI69Hg5aTXXoqLMAPidqC+eCWMDGqNOa3c=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=FGDbF84zy49W3akI82sAxrc+M9euHl50O9W3iirKqQBEqByy2HOCXGkh9DNGnY6op05kr2+6g4KtrHLkukWS7U4Xgt+T92CdRpnZGsK5mTI4OwFUf7f2puIIwJQKQxHU1GFoR193lmE6CTIcKWfObbinb1YkTchP07wfvtF8XRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Xqjl0K8p; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Xqjl0K8p"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-914ae4101b4so816484685a.2
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 17:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779927047; x=1780531847; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zrc3j1PSSBkcb10BmDcSftUQTaBVAgAVPCLLaZFEU7s=;
        b=Xqjl0K8ptupT0YzKf7OjDEQiGjRkJtO4rUfIv9Za61sn63k7F+N7qlwceBn40vEktn
         M8mPTGZ1A3ys+UkhJCTukMtEdKTcW7MHlBM3A9K8Zou4xgHvWtCgktizg7z3SvHfGrxG
         qn599cyELSu0R4e2Hzm3/e5GTMzobgNb7W4/C2S+VI0tcOeksE1Q6E9sx7OhxGAnny91
         ++kML0SoXINO0rLj1mVRN++o/RPb0uc9vvZiKR3LPN43RWzQ8OaGvk3jUu+H2mslrA3S
         tb3mD+K9wUk20gjiROhoPR67ZZjBTe5RAPTtQIyvSE60A7Hga9gzQqtk+2vEtJSdVAaN
         SUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779927047; x=1780531847;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrc3j1PSSBkcb10BmDcSftUQTaBVAgAVPCLLaZFEU7s=;
        b=hmLwqvpsZYaFO0bHrQqaO9kqhIyUQ6xnkR2oq0/i0wTGu/0REyy7Qtv/Wjib4KV8qg
         93CS6D825hWKQ2C8Re4uCuTOvG/qPGkzvN8bN9rpYhynAsVYhfuHrVgFq/FELMLEB815
         tdA60nkVM8mcAgeWVwY5D1QimhUmUIc2YHv0R35ubrS6cSt8eh5R9solzvvWtK/9Hgm9
         LSn6EN5BsBT7evZeJzetNKZkc8bJYGQgMacwrfUO2zlTJtTnTkKO+q5PjJ5QNTTMKOwJ
         RARaTGfhkB6VpRvipUD8UvkEsIt4GCDJc0XYw8cHmF0HZ+sifuuJchGFGB80497ALasY
         gUBw==
X-Forwarded-Encrypted: i=1; AFNElJ9v8ZRBDxB8XPSUzjm2aer14VXxT8P6W3rCs0a5AIjuqF7D1kCl/roqM/rgSUYOytK9Y6szc9UJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4G4YrScAHUL+BDKYkWuE9hGG5hZABTQ/a7CJAfuNRXeN/klgF
	lZ1iEo2433xp+RSObWtNQOEB//FCqhHSEuGUblUEwzRgzfNBa3tJSEy73NBIfhpV3vhutpNfhfm
	59e/VXjpboc4=
X-Gm-Gg: Acq92OH3aMtpJe02xuUJLisYpbEbGSwFjjLMRZLYYUbXCDHElpKQgfqFT96P3ky6tnA
	yZnwKomIPODkcWW4aFcOGBLGJ/k82s4WLSgUoLHxQEeAQzoJOLu3oYA7jionoH92XgQitjgrS7q
	HEKGDayWaTrNsCVpVZuuqEljzNPycGSNuLRYVMbYK0NOlcqVF9yniHP+rrm7Y2+YbjdUqrPlW8Z
	k6kpTsAr1pPQK1i2OW0KF7iObydIR/1HIEKIvQO4I+XVa6jbgyxw+tJnQQ8H0vfBYmDCgFA4Dx+
	3ORLNFoQGMnvh5oeiYcng1dNX3vuUZMom2o7J4SUDTyqqd8lfBdnklAbUj9Sl7HGoICKeLOi30C
	8oFPM56Kvm07QNAhAcgI0K0qXnVbFKGGmZd+xthtYrkEFDCw1XpX/4zuyGtGYCC2SVPKnV5ymSy
	N7aP94N9qPe2xShtZSeLcLF/b4IYdxqYrSRx36QYdD5QJqx/c1ewpnT2ZNIR9Uhh8D+N74LvfWn
	ShuTlN313h6kBZdhA==
X-Received: by 2002:a05:620a:280f:b0:914:c82c:7a0b with SMTP id af79cd13be357-914c82c8638mr2699038585a.49.1779927047571;
        Wed, 27 May 2026 17:10:47 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f86e9ba7sm627985685a.6.2026.05.27.17.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 17:10:46 -0700 (PDT)
Date: Wed, 27 May 2026 20:10:46 -0400
Message-ID: <b20c2f2eb5c5df26e93297b4fcb5a2a0@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260527_1931/pstg-lib:20260527_1608/pstg-pwork:20260527_1931
From: Paul Moore <paul@paul-moore.com>
To: Kalevi Kolttonen <kalevi@kolttonen.fi>, selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: Re: [PATCH] selinux: trivial typo fix
References: <20260501191420.95344-1-kalevi@kolttonen.fi>
In-Reply-To: <20260501191420.95344-1-kalevi@kolttonen.fi>

On May  1, 2026 Kalevi Kolttonen <kalevi@kolttonen.fi> wrote:
> 
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
> ---
>  security/selinux/ibpkey.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/dev.

--
paul-moore.com

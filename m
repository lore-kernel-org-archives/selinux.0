Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA676347C7
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403529; cv=none; b=bin0kglTLYXBBcATWfvD5y7iHhv7ORT3GQmaTya2jL/ClAscbMSaBY0O9Rn0C6HfOMoKV/CBYM1eg2QSAY8LgBTjKub5kCw5UOh5VwiVvs7g0y+07LxhhZ9GDewgl9mBFnGZeRtWatJFS4g3lXElnxYnw1SGPpSLX4gLTBtAerU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403529; c=relaxed/simple;
	bh=UdJPUpFOhFmZehvcIj4QKIpjlRdKgiNGo1ctD46ym0Y=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=W70hvTdilYnjUnVOHPZm9Bh6UT0Tmu/RIhLUMoDY35R2h/wBhlPOa+haeRYSrODxlY2hlKUNXkV7x41+KUKB5gas0j9qB0tQlKkn58CAnroUXlgwdSRq7h8TUEsMjHSYJGLKwmgyyzrbAbpVZeAo3Z36+JIUhCWnmwKXnUft7dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aL7fvzRe; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aL7fvzRe"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47688ae873fso23982061cf.0
        for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 13:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744403526; x=1745008326; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5AUpP2ewstMsdx08N94btW4XH2iG1cBkF2eLDNOu8w=;
        b=aL7fvzResm7kKXPAIApOR4Ui9C4P8fpUgk0AjeptcdGJxNUpBceVnmROxJBr/HklsF
         x+4Za3e69acJhKyL7uBQWMahQtUAvP9tVLgmnGwnbWYCViY3m8NHKPHzgcvBOp/knjWE
         t/Rmi+W/QHoXzLyJQ7y3wLp0az/ImKfKgr+nlF/PJwq3n+au9pXg9Ac7WYBOW3V60HtK
         bYZfEltpf+oeiwHdWW1rRPi/sa7sPpVn7CJZpSv0hwAw9dj/zjiBWHvNGC18wkGzsB/d
         1/DAd6AUwz3SKyYMICvIEBEpiKoTPkleatqJX/o4ozmobBrH9xCu/2k0p1IA64Fdz9+V
         qClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744403526; x=1745008326;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z5AUpP2ewstMsdx08N94btW4XH2iG1cBkF2eLDNOu8w=;
        b=apUxCIWpnFrsZecJgjmaJuqb8p8yE9iKpDArp6MbS382fs7UzfqqDmkTZTapaQSnw4
         ugJk2C4uPZArIJXM+2UjKO8SWp2VmhDhcZ7z0Qxi2zs8kQnPprd24YMS72NfIqORpPa6
         FWdNt2Bb2dkGy8jKtIkfIn79/4V2TR+T7pJQlhkI5xSL9ewd1GyEcOrqgutkcVJMHVf8
         jxW8IM02dyYxiPgh8DBkZ1iH638yahLwTHn2RPw/2jyrpdQwbhjTG8V4AxOTGUhm/m17
         0gDAk/dvjGT8A6J4R/fqcN7dH492txWv5SyhLMaGtty0Kj7rOJt8BpyV4Mu5NobTMjl4
         GNQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfhsfaFPJqvJiWa2PTx8XHKnmFL1jDFV4YUVwWsBEHWS5DsQ9IgMQvb0UqF0JiOk11oLc2UJYP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5r0ayNq4/XuHNLD5Ht0jXm/9bOd3vlJVwzk7o0BeE6i7Ay8rV
	Rz73h4Z2508Bc9VODKE3Rn4QUIvSnJcod6IT1I4HlxsMD6P7Sr0bVYhYRn7mEA==
X-Gm-Gg: ASbGncuxfIyFNW9+FHzZ8iam1x5/qTwd03QXVYeTNtNBghyb6DgVYN2TXoR5zZ3UKPn
	pR7x8CSDRpUBLv9GXRhMpt++WT4pndmeoOWLrqeLVOY3zwrYhzKykqCCQnIBB3t0T852QFoMnYb
	ueqDSImdYxzPEdSsp/WLzJdyOW3c8XbMMhRUznsAd/lJRmB3+JLQ7lZJ11eCIi1IKwumi0Al6n/
	41iFI+35sETkjE0GE/CgTRzl+NcKmSa8pia9LYf/+Fa5gMmAmDWeIpS5yR7SDL2ELlAAStJXlSW
	2csGQmUa8bt+h0P1jl7UdwEzmQNiuMs5ho10rhDA88fSHUZ14rc9nBEjicEvrUt3uJOaMsmTk9O
	SOMNRnFn8o0OapEHdTy18
X-Google-Smtp-Source: AGHT+IFNwfgGv3eVIqQuena8N3I2vf2x1WsnXFEVM0ogggdyLD2Mfca2fFyeXfX9owTZW9/7GBq3rA==
X-Received: by 2002:ac8:5716:0:b0:476:aa7a:2f78 with SMTP id d75a77b69052e-479775ee27amr56112531cf.49.1744403526719;
        Fri, 11 Apr 2025 13:32:06 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4796eb15e9asm30802061cf.30.2025.04.11.13.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 13:32:06 -0700 (PDT)
Date: Fri, 11 Apr 2025 16:32:06 -0400
Message-ID: <2305ee0ba7f012dfee98a5d5c56a26ff@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250411_1406/pstg-lib:20250411_1552/pstg-pwork:20250411_1406
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 7/7] selinux: drop copy-paste comment
References: <20250318085007.26887-1-cgoettsche@seltendoof.de>
In-Reply-To: <20250318085007.26887-1-cgoettsche@seltendoof.de>

On Mar 18, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Port labeling is based on port number and protocol (TCP/UDP/...) but not
> based on network family (IPv4/IPv6).
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/netport.c | 6 ------
>  1 file changed, 6 deletions(-)

Merged into selinux/dev, thanks!

--
paul-moore.com

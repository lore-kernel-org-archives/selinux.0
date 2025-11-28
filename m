Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1367E1391
	for <selinux@vger.kernel.org>; Fri, 28 Nov 2025 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764356791; cv=none; b=DfYSU1AY/oCc79+w0luG4B3HI7CQ2AYgEuXGn47AshNgc1xMtrdG8mA0wQ12UU6Kh3hN0f06XBEPM7Z/H1V2V5/4TUGEVJuWKCKMl6O8BaCqJDYomv/eK0/a3fUxGDd/0rsLeu5fwsY26WLGePrkt/eSo8RfNvK58nHD1GXoxNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764356791; c=relaxed/simple;
	bh=lu52N/2VGNuNTTK3803qHK8MwtTQZ8QRDSD6H516Txc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FpptLX8gpG4YfFyAiw7b9Uh08mdoTtSWqPGNPWuu8oc4qzWVuekFnp+qlu8fNuF2waZZOQBOX+UhRR33oR8LU7jJfxcUrje/dtHfDI+iQrseBJ/BwhdLtpK5r/HqM0itUttoRtjMJ3N2cx5jbcgS2tP9shCgd/XKWJ8zKOBerN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com; spf=none smtp.mailfrom=perfinion.com; dkim=pass (2048-bit key) header.d=perfinion-com.20230601.gappssmtp.com header.i=@perfinion-com.20230601.gappssmtp.com header.b=hqzx7dkw; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=perfinion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=perfinion-com.20230601.gappssmtp.com header.i=@perfinion-com.20230601.gappssmtp.com header.b="hqzx7dkw"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2a45877bd5eso4331524eec.0
        for <selinux@vger.kernel.org>; Fri, 28 Nov 2025 11:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20230601.gappssmtp.com; s=20230601; t=1764356781; x=1764961581; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lu52N/2VGNuNTTK3803qHK8MwtTQZ8QRDSD6H516Txc=;
        b=hqzx7dkweMkVODh7W5yIPajSdnmL/fIUDD8vts6BDEfJ+tM5w/EVYOkrV1qJmKZ13J
         L5HGylNE/gJ1+RLKx2YWS36pPgf22d6zZgFLODO9T+3/T4WnKXJNkU6LASmshJZOq4zG
         pGJP9OaqQoqN65V9fwxdUBAVw3AwKvQCEeB2yB3iQ1HXMMu/xvdYsYvCFrNmROHWVIe6
         suQezkAlFGZDnwLRs8vmYsseM4IWbmXV8f6sBE+SIN/o5CorP71gnx68Zy2LcRWzql64
         5BMIsPTwiAwktsyZwOpFu/wHF6T4ILfpxgXkD4KsXIJBdGdQRkOXmQbgoVGQp6znTvV8
         2c1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764356781; x=1764961581;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lu52N/2VGNuNTTK3803qHK8MwtTQZ8QRDSD6H516Txc=;
        b=qsZsymG8VEnOw7Hdpiy86Z0rC+04W4h8NLipdrHVAXl55aa50Om3VdebyQzlSRY7nJ
         YTvwa/NrmX2iIk+yNTbhFtrIhCSlK+l4cpbVcJhlY3p0e7/D89ZyCTbxSwipn1BMd3wo
         tPw5naEF3Vodv/Ck7oVZlVl53suj/BPZ+tWhFKC1QKmZRXs7brD0RoKGj18uCMH+Z1If
         YLsGbaA4RttR2Zrv4eKVibS2SIdDwbYlpqjx0fS7ROuZ67TJj6brWz+bJo4Ig1w7us++
         Sst4iyT1/XO98A6D/eBKzCncqtZUlF3MKViLEyytjhizd/q6lOX2azXp3vTP1mnk75do
         7Ycw==
X-Gm-Message-State: AOJu0YxiSiOQY1tElBa/iA0Nse8e3WoRChfR8zWnv6a0IRlrcBVSHbfo
	pxMXHLZYOJcCVymle1te68QHGNnJaviGOoe7LpToR0RFe8Nt4Aykk5hMg1H/DBAImduNA3hmOKB
	aKVwI
X-Gm-Gg: ASbGnctTyFOeqi03E972j9YUyM9tEUnabkPYk8yzfKVEprXdbpJpRGeIacW6ldSETjc
	drz3QcPSPwvHlXZPvE+NBqDDUJGkNQbSstBpYZlYkXEKP4ih13AY4EYQoCp9+IJbvQGVCJTJDu4
	1W3uzhXN7USFmXwmafMB5idwVqKChCbN2e4IT4daHaQgG80CiP23cICyGSWdAeUEg/nUOF8Fm+Q
	6VLkIG2gQ4XVb0b4hAu8ue4WFhoZfnRXvPHLyviQh5pLQ0yUoJmufvUOnLFzlC8lo92tWCdECwQ
	EuBstXtc3qULOTRhWplBvKKjOKX6tXaKGq1vr+y1kfcYFotJNOvW3GO5wF2LifbVWL3s+o/NjRX
	paFLkabAPt8BKWBaI+5FOrkmIKQpPlEoX38zTDiE5Wkkf2b7f97GpSlV9VDev06yUvLviL4maXo
	STRuAOiAYLUQ==
X-Google-Smtp-Source: AGHT+IHZIVhEjS8nWXmfoA2NufHaqCqCn3ieJYVdiD9895z/ayyjZQqgMgmosANxi0cfOdXNkZHkoA==
X-Received: by 2002:a05:7300:de05:b0:2a4:7337:e9ad with SMTP id 5a478bee46e88-2a6ff52f777mr14722144eec.3.1764356780695;
        Fri, 28 Nov 2025 11:06:20 -0800 (PST)
Received: from localhost ([2001:5a8:4c64:f300:f1a4:fa58:d2e6:f0b9])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2a9655ceb04sm17776451eec.1.2025.11.28.11.06.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 11:06:18 -0800 (PST)
Date: Fri, 28 Nov 2025 11:06:17 -0800
From: Jason Zaman <jason@perfinion.com>
To: selinux@vger.kernel.org
Subject: Intent to release SELinux Userspace 3.10-rc1
Message-ID: <aSnyqWpGJfhn9RYS@anduin.perfinion.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi All,

Just a quick note that we'll be working towards the next SELinux
userspace release. This one will be 3.10. I'll make the RC1 release in
about 2 weeks then there will be a bit of a break over the winter
holidays and in the new year will hopefully make more RC's every 2
weeks. If things go similarly to prior releases, that should hopefully
put the final 3.10 release around early Feb.

With Kind Regards,
Jason

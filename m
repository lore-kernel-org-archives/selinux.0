Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519455;
	b=u1rbEo+AkOYbza7Z+FycDK0Proh90Vbru7b1II2xYcVGUune/+oqImOmeAbKXXW6LaFV
	 jA88afdUK8KAcIQQ+I4m9BaD4UMYaZq9LnfDDNJhN9lCtamxQHi9N3t1XCGvWaCBk27rE
	 WNSphaLzddLNzFakv1HOLlqZF6pQe55K7Z6rWv8eViSJ2hRpWREKA9pcB3O75MthlRGJR
	 pyjYRhZ58jbdysWQQ9PZcsjc5avdrfCj5FLpiYJ3Z9b8H2kbhzr9jZbVdZ1QRzEyi+t3s
	 2w2FxbHCS1CMXipDzpQFvn2n+31NqokHfvU60qnksdYexLA9hY/Brd6VlQHDk7tBfiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519455;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To;
	bh=2z8e9lR2Oq6NZc6gS45G1a0LQ9Omua0ha1vlJWVb2Go=;
	b=5YCz/0TPUNu31AVSMkNd/VhFAn8amn/cEockGXDhfsPiGLHNRV5vsVRV9V+mv8YSpS6c
	 i67UWh1L5Oqn2xKysKSk9BFiZV0NMiv9OPz5j7MuJrCmDp3HDDh0aj4zBEbo90nDuL17u
	 ZtG5fd3723hug41CZZTL4xk0fJrTuCpa0s3dtdWQPLNhmRlrfo6h7+slmm9z9JDQIULvT
	 c0vW5b1Ggwm3BWCoxfKrVO15qP5Q8xyFJUvH4B0LljxLmV+9sNQ1IsiAYzMFAWB3yoev/
	 qicf+cBKfo9KTno2eA8/xVk0Erk/DZLHvJrDvZNraddRBYbMkPo8HcPVd0zdPTq3yfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GmIhx+cg;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mtbuUpy7;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C985606A319
	for <selinux@vger.kernel.org>; Tue, 20 Oct 2026 18:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C985606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GmIhx+cg;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mtbuUpy7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792519453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2z8e9lR2Oq6NZc6gS45G1a0LQ9Omua0ha1vlJWVb2Go=;
	b=GmIhx+cgQTNA8cO4TYTgyaw+HOy8HY/peu7ORJEhhYbMM0zzDaPczNd9aoExVKeVm/NFW7
	DohLamoHya5HPSs1+eEY0FizirmbCxgKiNd1PnEPlfDffUr2uHg4BnROQJKSPt3sgleh3q
	GmjMNvJoCHCKa1Tf7jgVhfwa94UBje8=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-RBdxIOazO8aWygF4LiNHpQ-1; Tue, 20 Oct 2026 18:04:05 +0000
X-MC-Unique: RBdxIOazO8aWygF4LiNHpQ-1
X-Mimecast-MFC-AGG-ID: RBdxIOazO8aWygF4LiNHpQ_1792519445
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7b206156cc6so2926560137.1
        for <selinux@vger.kernel.org>; Tue, 20 Oct 2026 11:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792519445; x=1793124245; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2z8e9lR2Oq6NZc6gS45G1a0LQ9Omua0ha1vlJWVb2Go=;
        b=mtbuUpy7/u7hgmobbOjEa646Z8hHHW3J+lw3jp5R+rqrxm7mGUIYDwO/vEvhFgj4J6
         YGQpchd/5IFoH2GPwkgkadNcp3fTAXnNPqzVymfWaOmxoqj2C9VpkAXw0fb4fjzr9Kq9
         6qWIF3w5FsaBbABiNcPg1JY9eCjbGmCcCKURffOnCFz3vCZQYpK7mMmYW/D0H8j3xoF3
         Uobnuc7BwhyKcnq11kvL6kDXQpSQO1ALK2ZJrTXn/ArPsELdApzhz6eftbokX4cUS3mB
         og1DRjFYCiRNG++RmzRFGX/6MwMYMa5EqSnTH/UfdVqetvlRjnvjwoAj650T/I4XHNhS
         YUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519445; x=1793124245;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2z8e9lR2Oq6NZc6gS45G1a0LQ9Omua0ha1vlJWVb2Go=;
        b=jK6W88B97hbn1OdTzF2szqUAMi1IdZ1ykoultgktsHdMQy9oRcWrY8OJjK5gm52utA
         GdIm7mv9cjfR8Le1+JVT8MiUeGRIL93nTwDLwLS3auXAvtwudabpF/Mc5s1z7JcdLnrx
         audkX7xtbUxplge7NZRjGMsp0i+Vzh+HY2pmx6qB/w4smzIEacQQS2D7JQYe9l5ead8W
         SisUOyt/ipkP/86CaN5jFH4YmUodYqRSbDUNs8A2ofzkkTKSqNbTv1RoAzh5Y8GNDf6L
         3JPzH5jHJyiUZaMUy0Pl8/Jt1nugwb2cd2IlKjwbOhJBS5SZhGfftReteZNAGEdfXNJ3
         PVqg==
X-Gm-Message-State: AFq9FYJoSokQwWlsIyG3hpSrsI/ZYZP1BI71loY/ARqteRZjhCT6Kk4d
	+fXYAnboMbzBvFxD3oGnNr4JBuSo+GRr0Fiy5F99vNNQY+9ljinru5PyrHV4ksgobcv0DNwaL3p
	1AP8py13UrqYqMQDFnBvQEktIUw3iwYtF35LcLkP37JW18X5SwQ6BWzeeqj4=
X-Gm-Gg: AYBFou09ZB9P5m6bQJQbmq/QuXuWCOoMT3ZmUjjjXQu5FTa2ZU0dVz9mWWJ4hPYtTGF
	YmFs4QE0W9bFqUB6zcHeyw6pXnDWFF1kGtg8YxM+PeqDmHEiMslTsh0ObN4MMTVzilL8V+iHotz
	7cM3cwVKQa2J24231aEm6Qa0WrtHg3io/sNgXOU9ubmTK0aiw5O3FquUcS1pQW35+YqOV0wjUkQ
	5rCuVIM2ziSmLd9mCSCCW46mU3JIMyCXoUKGYb+Ym62alDxa6NGmXg06xzX8nEX97qHpl6PVyDy
	pDdZdghtXKPg6wFE2XL2gxTmcz1/ygslNTQBkKlGMDxZQyofRZWyHhb+qLelEZ/bQq2L
X-Received: by 2002:a05:6102:5111:b0:7c3:a1c6:7a13 with SMTP id ada2fe7eead31-7cc92669451mr753137.16.1792519445090;
        Tue, 20 Oct 2026 11:04:05 -0700 (PDT)
X-Received: by 2002:a05:6102:5111:b0:7c3:a1c6:7a13 with SMTP id ada2fe7eead31-7cc92669451mr743137.16.1792519444616;
        Tue, 20 Oct 2026 11:04:04 -0700 (PDT)
Received: from localhost ([143.54.53.81])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc923f5762sm27202137.9.2026.10.20.11.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 11:04:03 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=9f40ddd17479d59e7bc0d9bb57c48e3d61bd6f5bd39d90492f96a988cbb1;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 20 Oct 2026 15:03:59 -0300
Message-Id: <DM9V3Y4E8LS1.2FZ6OJ7LQSJFA@redhat.com>
To: "Stephen Smalley" <stephen.smalley.work@gmail.com>, "Pablo Alessandro
 Santos Hugen" <phugen@redhat.com>, =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?=
 <omosnacek@gmail.com>
Cc: <selinux@vger.kernel.org>, =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?=
 <omosnacek@gmail.com>
Subject: Re: [PATCH] tests/keys: skip KEYCTL_DH_COMPUTE when unavailable
From: "Pablo Hugen" <phugen@redhat.com>
References: <20261018012855.1795025-1-phugen@redhat.com>
 <CAEjxPJ7yrA2Ua-t4VaXBfxUXZzg1BijZhv=FScW+-gC=BkZ8-g@mail.gmail.com>
In-Reply-To: <CAEjxPJ7yrA2Ua-t4VaXBfxUXZzg1BijZhv=FScW+-gC=BkZ8-g@mail.gmail.com>

--9f40ddd17479d59e7bc0d9bb57c48e3d61bd6f5bd39d90492f96a988cbb1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Thanks for the review Stephen. Both fixed in v2.=20

I've validated the v2 patch against the RHEL kernel (which I also did in
the v1), and it seems solid:=20

https://artifacts.osci.redhat.com/testing-farm/753a7e84-6b69-4c83-b39b-e781=
9005fbb6/

Best,
Pablo

--9f40ddd17479d59e7bc0d9bb57c48e3d61bd6f5bd39d90492f96a988cbb1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQMP+tqh8XWgfhXItgg/MNYDx+9egUCatetDwAKCRAg/MNYDx+9
erTdAQC48I8f1c8PWGabo2WWR26KP6geTL79rZKgPp0FTLwYsgEAlGs3+O8f47hW
P86uQh1LblAvTaHRhA0PivG7m5hzCgo=
=VBSm
-----END PGP SIGNATURE-----

--9f40ddd17479d59e7bc0d9bb57c48e3d61bd6f5bd39d90492f96a988cbb1--


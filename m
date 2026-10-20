Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514629;
	b=ohQYXSG0QsRmuDeiYfrlj99hZQmB95nsamWbQoV44EM8CLwPRRUdAkxSKHcDAZ6JhFwr
	 FoXnOh4pAGEjqA/sISP7N9lJkJ2q6PDFnSRevmdBjo6Ea5LwscqRsSnTTRIO0ZEuWnBVs
	 iFBikVR19OSMbemb005sVcdgLDklcwFTmoWcK4tCamO9pEAWb9CYAXJoz7bKXGoSUBs/I
	 PpPo39/7qjv1mQukW8rF4udShk9Acj6jNO3R7fTJiIMgQQ0JhV6ji794xYI8lJhuSpBNg
	 hA/XHxZF1VNgdA4FGoBI6j6WJsvuTBAJAlAHIEG1Cu8xQWLQ9x6fX9ay1NgmzweAHzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514629;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Mime-Version:Content-Type:Date:Message-Id:To:Cc:
	 Subject:From:References:In-Reply-To;
	bh=WWeGn2ZSI/1flzWsAWvvmGijnSfKLcNJIVo/3C+C3UE=;
	b=F4sNPvH6P9CRmLP93F6y9Ynukpju962EW3jnzvGrOHr3jaia9EIjHKxDkxTILbJUq3kE
	 WzBqQw0RnKE60+fXp+T54dr9Zm7tHd9ImY8zBWlRPPQZeavt1IVue0wV25V3e5lBtrdve
	 FKzQowsHiIoIPRkvGh4dK+L5WghTvnEY2brZLfDV6l/9cBBdlZiwW3AYba0sI4F6CcrpP
	 XiJpW4Cj7NwsxGK5Dm0FNbb1fBLNi0er9aSglSihkVAAN/eJLJlEjIviajQOuzbZN+L6R
	 9pdbNFH5iZHUjEcgwNCgNJEizzcmBj84Qruyy/9JY/3GxFDLqlQV6Vb+jRjMhgdzvSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xw7INih2;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="HeMYj/dh";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8261A606A319
	for <selinux@vger.kernel.org>; Tue, 20 Oct 2026 16:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8261A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xw7INih2;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HeMYj/dh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792514627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WWeGn2ZSI/1flzWsAWvvmGijnSfKLcNJIVo/3C+C3UE=;
	b=Xw7INih2AmWdQI6D3PY4K83FcWOZedR+ptMsPTuwsKzjCvkJChUsvDY2diMGpatpPMSlta
	Yev+up5B+YRXFewNUvz5jim2kUEfidPepqEEuQzSgQH0ohhR74swaRnlkzqdQ1wl8xbe7z
	j3CiSIz9CUhQ4m7WVh1T4Dw7QWLc1v8=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-jbjCSBe5NF2g1ss3Vjf9EA-1; Tue, 20 Oct 2026 16:43:45 +0000
X-MC-Unique: jbjCSBe5NF2g1ss3Vjf9EA-1
X-Mimecast-MFC-AGG-ID: jbjCSBe5NF2g1ss3Vjf9EA_1792514625
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5eac6157868so712779e0c.0
        for <selinux@vger.kernel.org>; Tue, 20 Oct 2026 09:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792514625; x=1793119425; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WWeGn2ZSI/1flzWsAWvvmGijnSfKLcNJIVo/3C+C3UE=;
        b=HeMYj/dhNiKYwoPmtM8e14du55Fp6fBZP00FS0WzZnBaO4+HGHNRqboLqTupUD22s5
         yzwXmDiWZ74k90exFEz/ofCLyCiRegHqSDhirJYmfkqnTnl/js3A/lP2RV6BGnttlpEg
         diZhL9dJP+cG5TDmV5+/PalYIGAw4boQ/u3Hix4D945w95g3CYjLH1vPbwkldYLyP08e
         CN8qm1qMUcDISbhBxxMP5DGKAp147izw3AEu4kqWBPR4faxIWeRfhHlh0/07SjAl6UJO
         ON0CBOsDHRdA0CBCdLU/AMPmzfSQiRyjwrWqO4Z0xjf8jixWlQ7PCTd4MpyP66ehH1zF
         Ib6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514625; x=1793119425;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WWeGn2ZSI/1flzWsAWvvmGijnSfKLcNJIVo/3C+C3UE=;
        b=or7HfG97u23b78W+g/ZNiU5aSQvRkV8gNTje3YhQoGk6gTqxH8O5/VjBfaL79IxLJ1
         gHCQVRH6NhS+k8vZBbhq2w81w3v7d6lyVWyagk9VkC7ttZhU3b9xQHI3WdxbInPLHEOy
         fNMg+BjpOLf/wXS6oQMOb8XxSl9Yg93hF8wSCW1LDdnDlpqoIaCk+qy8MkO+9tpf5oE7
         Os9cOL/QhwxI+k8r6VHehL5PmP1LGohv0ud8BepE1t3E4G539llQup1dypHdKrJCRxNl
         9MNSDE1V2zMrlL8ZTJSrFJm1E8ecWmljXxIdgJUnwleRtQDs9TpDgnDnJIjgSkGCbIQT
         t5Xg==
X-Forwarded-Encrypted: i=1; AKwUvByyAgDeix6DMpl45NdFiDGQzKzX3u/0GXcCuSH2wobSnmXKUTuw3wLP6CsWQs18PPst8Xop43WG@vger.kernel.org
X-Gm-Message-State: AFq9FYLQNVQwL3qL0Aj73lYuHYgCsD8qttGtIWAzPKaxIv30S5Gn4V3S
	cafMqmOJb3c94s2MMmOcSuaBemJ8zRGIJ6GiCp83DjmUQwOj07dPTOOXVhOENpbBJGJl5tHbWwG
	SW1dM+VvoPsbB127zQJX26a2sIMEMLvf2iYYVKz8YMW0mGcXjDKMVX6Jr3wY=
X-Gm-Gg: AYBFou2umPatrxYMcBEZo4jyBjy8dQOrrr1TQLKy6gsAKvsa8ZnVCvI8EO59SWd8yvq
	16PGDzXwKxr0YPLW8JyXcwmi7QqK7iTw0Q36lDNpSkj7uKnrP66x/7i0/mP4G8SSqcJpoxEpWkg
	UjacEKhAwhCBUJKIUG1FnhxP0DN7U9FWV8dPJcTPAFplPu/fHySR5dyr0PQHR2XD1UfS9k440Lr
	RVckjDf1Awu49UEZxq7J5lBo3+hn+TQtzgvpAvROxzJOrkT1iJYrxqLQdvtX2gjCaxyGE5Lp5uT
	R8lgH3ctV4FYmKCOgCVck40yBYz1GLTugTGKzwTHd1JXqtDfhkh9V3N4bMENeLnFv16W
X-Received: by 2002:a67:e917:0:b0:7c3:881f:b76c with SMTP id ada2fe7eead31-7cc7bb887c9mr507234137.11.1792514625001;
        Tue, 20 Oct 2026 09:43:45 -0700 (PDT)
X-Received: by 2002:a67:e917:0:b0:7c3:881f:b76c with SMTP id ada2fe7eead31-7cc7bb887c9mr507229137.11.1792514624513;
        Tue, 20 Oct 2026 09:43:44 -0700 (PDT)
Received: from localhost ([143.54.53.81])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990d104017bsm297266241.4.2026.10.20.09.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 09:43:44 -0700 (PDT)
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
 boundary=e7bee32d15cd79ece9c90636152d6c34e5808e9741bb0273f0d8ff12ed1e;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 20 Oct 2026 13:43:39 -0300
Message-Id: <DM9TEFX3WT9D.1JFP9NMM37XVH@redhat.com>
To: =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>, "Stephen
 Smalley" <stephen.smalley.work@gmail.com>
Cc: "Pablo Alessandro Santos Hugen" <phugen@redhat.com>,
 <selinux@vger.kernel.org>
Subject: Re: [PATCH] tests: fix format string mismatches on s390x/ppc64le
From: "Pablo Hugen" <phugen@redhat.com>
References: <20261018012909.1795176-1-phugen@redhat.com>
 <CAEjxPJ4t=_CDnXYqSf2atEG7WODadR1zKMJVvwXWG5g+zBb0bA@mail.gmail.com>
 <CAAUqJDsKaSpS=rzNA7dTgs9rLg5vNdTot+eu3p-rOykVkCBCGg@mail.gmail.com>
In-Reply-To: <CAAUqJDsKaSpS=rzNA7dTgs9rLg5vNdTot+eu3p-rOykVkCBCGg@mail.gmail.com>

--e7bee32d15cd79ece9c90636152d6c34e5808e9741bb0273f0d8ff12ed1e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Yes that was the case. I've created the patches from an mirror which I
thought was updated.

Anyways, thanks for the reviews!!!

Best,
Pablo

--e7bee32d15cd79ece9c90636152d6c34e5808e9741bb0273f0d8ff12ed1e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQMP+tqh8XWgfhXItgg/MNYDx+9egUCateaOwAKCRAg/MNYDx+9
eoW6AP91JYrxcCMAYFkA5Mn/FOzAH9hcLYJBfsIW87TVsTAGcQEA3n46nrT4P+fZ
QDwQlcQv0h83SYxodNWa5iJ/PWYxxQE=
=eHwh
-----END PGP SIGNATURE-----

--e7bee32d15cd79ece9c90636152d6c34e5808e9741bb0273f0d8ff12ed1e--


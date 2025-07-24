Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920B4FC0A
	for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360438; cv=none; b=ElPrvWLAYikFV5nDJrwDNO2vonvjuKEomuKK8ZzGUgb+VTOzzVJKj+9ZYwxw28QWAtvAMqHPBIv6tUCu9SuXcp7qeQtxjm38JVYDCCyVuV/54zTu8VVJ1K9Ky6LdkaUEnBGTYfSbt5R/mRKZFfA0u8ev6OM/y/guKbvfd4L5Mx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360438; c=relaxed/simple;
	bh=QtHKUw1+6xnhP8biWz5acdNk1tF7EYJrINhzVry9Y94=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 In-Reply-To; b=J1RAX+OaD/MrGSurPN4TtJiDv/9dzSjzaqCKQda2pjFr9uWqaNTalkgvxohqoa0zzkg3VVrTPtI5D0PV97Xxb3Ta1G4WqvtMBG6drPoTaeP9KOXu36dy2Q6rrT7QGMJ5eMaVa/cBpZjFcQkm1PCq0eiWdL6dx42LX0GiYs7x6LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzLcgxri; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzLcgxri"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso718450f8f.1
        for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 05:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753360435; x=1753965235; darn=vger.kernel.org;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtHKUw1+6xnhP8biWz5acdNk1tF7EYJrINhzVry9Y94=;
        b=SzLcgxriyiHP9P7N3v7vtJRY5LWD06+wAMg9QoPy2+TkRYc5FDiNbB2GoBJ5XZe1wo
         Hc6qS+6DhOv0WZU/ziCsKeeOxruR71XrM68vXsLNek3eEdynKXCY4GE2AlEtMP7U4BpZ
         n0O75xBgFwjdJUbLY0QHaNKTaDrByTaljkRovIOMtxkEj3JwJgWyaKTOuo3r5aHsgLiD
         exvJNdv63Ij7QOPCiClIMC5rhh+o7qCd3aRGPcnjlGlz0v8c39o+iunz8DXbN9IyjENB
         MGhvd1jdKQgGSymd2HR8jz95HDUU0UfSXMHv/HC7UekTea4MGGsiF5XG2DQGxMkvmx97
         B1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753360435; x=1753965235;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QtHKUw1+6xnhP8biWz5acdNk1tF7EYJrINhzVry9Y94=;
        b=Sb0VQINmfqda3lkIveHTmZe0ZCXLui3ZSo+i3WkSVay3flRu+FHkgmJWAJyR/kdAsm
         UP6PB9ahCIBECnDzcm+hUWOuPpX7vD8Z+3BhXRylQnjWejpP14tYHhPmrV1ou8m+Pfk9
         ugl7yTTh5BpYGkY2ttNkcMO9DfNFqjrStHZAtNKqDN+CgsmwUOl8jxQ/F0cHq6Lchm37
         m3qOLFXYY2FluGjZIhlZi8iIVwrkkTCSLj5JnOspzFLF0H5SpabYM/f7lO1jBVqwrrzC
         LRODNjkX4MRhFc8G05F38aC7i8M8Afn9ooxxRGmgMooyXkuHV0QTpqOo44LMTKbuxUXN
         15Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUVeFp+9FvAOaPSe95o/3e+jT4t/jYMgF8PEuQAHG4x8bPlTf41B3jswnXWp9kEUza49MBaXBGJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwrzdT5hC//qvPRUmUWYHxksTR0bPUTlYIxQX84tWlhFXH/nX9d
	10Qwt6Tj9qNJH6WVVtgYtbCiCYxBJbMMQOnA3kZLbkq8DTVhscIyMIP6
X-Gm-Gg: ASbGnct5KAe6ZNjNzkiyIyf7V7fowsPNaYW1QNVkE/qID/yK0aS3RbtZknfQCh5+lwP
	mw8Sxkb/lwwi6XEdGhCsxQ9sG9nL+C8Rb4mEmEbHdawVWFr1sGECCIItKGgyh0B/P6tPyySdQSZ
	C/Uh6KfDR/j8Dznkec26CI0xklf4ecrTCZFNpQQb8lprWBmKtQxQgTiv+DXyI/UkkHu/RpqzaFV
	peTlEfbRkRtnInJwtQ++eCPBanliJvRNbNLfuv2xBv8Me49eWTa51e7pGXSfTZfOavS53R9OQxU
	+uZDWZQeZU/LqEnlHGgxFqW342WJmrLvp6ku0mM9XiY+WbW34n8V8+sLtwChS4sMOUdSaXhW+v9
	RRM6FWYhxaSS8+oIe
X-Google-Smtp-Source: AGHT+IENJ4A6fPLuBT74Dr/5PnnaEbfgZ5zH4EsIqp9ThemJkNZlfzF5iLxzf1LK2FLyo+Y9CtC0MQ==
X-Received: by 2002:a05:6000:2dc2:b0:3a4:e7b7:3851 with SMTP id ffacd0b85a97d-3b768f118cfmr4957723f8f.58.1753360434554;
        Thu, 24 Jul 2025 05:33:54 -0700 (PDT)
Received: from localhost ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705545bcsm19122675e9.20.2025.07.24.05.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 05:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Jul 2025 13:33:50 +0100
Message-Id: <DBKAEDVVNGON.3RDPQ880OONBJ@gmail.com>
Cc: <nvraxn@gmail.com>, <omosnace@redhat.com>, <paul@paul-moore.com>,
 <selinux@vger.kernel.org>
Subject: Re: [PATCH v2] libselinux: fix parsing of the enforcing kernel
 cmdline parameter
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <stephen.smalley.work@gmail.com>
X-Mailer: aerc 0.20.1
In-Reply-To: <CAEjxPJ6AuwTX9soXmHSiJbE2r69mRt8qFTTOQj-FhWUjnnYdQg@mail.gmail.com>

> Sorry if I was unclear, but the kernel leaves selinux_enforcing_boot
> initialized as zero if kstrtoul() returns an error. So it accepts
> enforcing=3D2 as equivalent to enforcing=3D1 but it does not accept
> enforcing=3Don or similar.

Oops that's on me, I misread the manual page on kstrtoul before my
coffee this morning, apologies! I'll send a v3 shortly.

Regards,
Rahul

Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77B628BA81
	for <selinux@vger.kernel.org>; Wed, 15 Oct 2025 20:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558634; cv=none; b=Koz+wpPjUr6fbmZVvr46CUITPQ7xPq7Bei7u7dytlYJoUjdTZzcKj7REP2svkd8klkx8am0NPO4RHhqXcNG0MmoUZHWrF+KzVl8PGzLnn0FhheclkjQ/7WGR+C8E6kQSIR3xAf1rCC8yqov+oFEnCrkKnf3VSs+sGh6AnZuqvtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558634; c=relaxed/simple;
	bh=hbr9CVtc2cTAVZie29aoHezqU255mnvAoejybZd63CY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=r7Z+qBgzp9y/aVCGQL60t4LSWTWl7AsjeYlJMh+vUm7eKT8pHbEIv11/jj4HnLzBviNbguAjdCxMQD7bWGf4ZglENeB8pT77Wsjbqj4AEyokdOpqKkG3YeY+rMXXQgOum+m2xjLoYHRNhBVT4jDg0NRTeGtadEn7j0GEILywRK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mo4JNjdw; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo4JNjdw"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3383ac4d130so9893a91.2
        for <selinux@vger.kernel.org>; Wed, 15 Oct 2025 13:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760558632; x=1761163432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hbr9CVtc2cTAVZie29aoHezqU255mnvAoejybZd63CY=;
        b=Mo4JNjdw/ltyjpfYXvs1BJdMtszhma8/INV726Fn2bG7S9Q5RKLZMRtqv3Te9U75IF
         YtDXeJD3GvYE5wIywJe+OtiJ/EdqBz+B6g4rmzhQ345sP4c4YeoouX73ShDGrk0jBhLO
         +1tctevQv2hmt3uYU/EGVnLHb0qvtnQqaarMt+QqeJAQAEgdGbbvERX2+m+W51ePyUcq
         4rfS+xZ7mO2QYBtSN9z5YRZ6bVrkdbE8buODuoPxryi0UaqhgEwN3oDVeNn8nEaD+ZWc
         PdxrTYDBoddxExhONFCQcJDDAgJ/jzSqSvGBQukcoS8u9rsRJYOQEBZhKjqyyhRQuKeP
         ljnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760558632; x=1761163432;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hbr9CVtc2cTAVZie29aoHezqU255mnvAoejybZd63CY=;
        b=LVjwv2lx3tStan3JyyCOXOxcEij0nWUkX51YXFKtQ2hGI/GKJGBvsQWxq441pHGZwg
         9TmwYCo7xlg9o0LXnmOErMWARFeNf3ovEmIyHqrY/uvX29PASVm/DvabBIxzhQOENwZR
         RQzDCyapeZeymwpLFLyVTh+8c9F/Gz/NW/VTL1VQ8igZKjr0b0lyAjlwpkpVt3BiJGv8
         lcYyf/ovshiO1g3AVdRgQALgdKEsp2VirxR6JxtUBksPnweduci/Y4rIeBKPHFPkvDMB
         2DWk+T5UaY/5Oz1jpQxfTcmZ1OhrVkpWR7l3OoUpwHZ8AFJsfAionFRppkCNvPo+EJUz
         sWmQ==
X-Gm-Message-State: AOJu0YzHAdIjSu7/ns8sFRV6IgGM70xmz1ONdEcQfzTmCufI00rPZJif
	IZvp4cLFvsiXtiA6dTB4swY6CBMaJhaGrKGogZkXgIdfib1aAdd75lH6rOUoVkHiyoKDBsq8Dok
	QRZuTp7U6XHaKoeFhULl2vg4wAsIciec=
X-Gm-Gg: ASbGncunwooa6XZ17aj4qp39XiYVr40DrYOyjnu1NpaA+UUV6sXWDQr120S4Mp6Lslo
	+2LKDPx5Z54i/CRZwQBngoBtch09UF3H1Hw8JIxoEx3htBesoN8FLxaiSgDX+ib0XML1SuVcZZ+
	CqTkbbHKfrMh7yOW3YJSnPp6SlpBuY80z7BfOX6S8cL1P874pmejEdlLmVnY8czao0cJDBlbAwm
	0hBvTWPDT2JYHaVU/wBFtymlMW3KhqFgjmWS3YyvEuBPCV2jpyhKJBZqRpn
X-Google-Smtp-Source: AGHT+IEB84+VbnmR4ezlCMKD/MBOf4MQXjdD9iiN65Pyq5t+UDYSyG3aW0qQ1EqgtHNzv00V3Qy0nR2XYgh/e6HL08I=
X-Received: by 2002:a17:90a:e7c7:b0:32d:601d:f718 with SMTP id
 98e67ed59e1d1-33b51393502mr38177444a91.31.1760558632020; Wed, 15 Oct 2025
 13:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 15 Oct 2025 16:03:41 -0400
X-Gm-Features: AS18NWAtaBt_yBJXGrVJbYn2FzcgaVKaZasJEt9mcSeXaPQ111P9UIEzJDiBHfI
Message-ID: <CAEjxPJ4CNH91Vh-5dF=43Xwg7WpSq8obKn+iAyg0HhqWqBzAUw@mail.gmail.com>
Subject: Fix for v6.18-rc1 udp test bug
To: Paul Moore <paul@paul-moore.com>
Cc: SElinux list <selinux@vger.kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"

For anyone else encountering problems with v6.18-rc1 triggered by the
udp tests in selinux-testsuite, this appears to fix it:

https://lore.kernel.org/netdev/20251015052715.4140493-1-edumazet@google.com/

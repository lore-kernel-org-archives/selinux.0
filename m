Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8315696E
	for <selinux@vger.kernel.org>; Mon, 27 Jan 2025 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737969041; cv=none; b=WbshOyTw4Vyv74W/VNRiPlupmsVFUwYpEDmIAmpBOdAWQjpOjKpEcXkfRh7zAB9rjCeuEkJCfNTf64shY3cgyiH03VXFR1oSXfNc77UAwy70s/4Yb8lJ5TrsKCblbqcvSuM9ZY9r4a/LKRD9ylDqI5m11hWvKk8TjfqKOuqvYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737969041; c=relaxed/simple;
	bh=Fx0hftQxjQH+OA4pUAaTnpVQy7FufPHEfu2+Ds3/DF8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=egLC1YNudJ7OEAW7BJnt/3bDiWLHVB4SPgAnfE8V/YbG5J7f9Hokeeg45jaxcekeuWawlv04h/CUOXjAfG0NsP6znBzU1lXzTo8D6nnJ+NG4l//ffJMyqCW9x0zusJNcUmOqvDGFZxU9U1njTQbgaHdF1al89+TpptanrTcvP84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XQBzi6In; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQBzi6In"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737969038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Gwp2ErRHN25QzHUBSfC6o9tk+AkL5iClS16luN1kxLM=;
	b=XQBzi6IneqRGf3CC151oBfosKoqqgjSgpBNycTrU1ruDPC/5LGsjqZDfxsPZTK/J+JVHUm
	73pS6px+Xe1obFmTFNorDv2xtzFJL78+LEt8zNZJbdILszMJyCUbwX6XP6OWi27B+YPBUQ
	hV6lZzIr0q8s0VGHxZQ+Rzr4GwwfMwk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-Y23eGEByOrao4B6xL495IQ-1; Mon, 27 Jan 2025 04:10:33 -0500
X-MC-Unique: Y23eGEByOrao4B6xL495IQ-1
X-Mimecast-MFC-AGG-ID: Y23eGEByOrao4B6xL495IQ
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2efa0eb9cfeso8438737a91.0
        for <selinux@vger.kernel.org>; Mon, 27 Jan 2025 01:10:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737969031; x=1738573831;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gwp2ErRHN25QzHUBSfC6o9tk+AkL5iClS16luN1kxLM=;
        b=JNFB5zAcbmv6CwNrweISXsGiXLt1Xa2kYo2bCqJEbNVX1ZIXWMvBHntjSHSn+3Ndtp
         aLeUyhthjb4+cc9MzcHFUI7AtzJ/0tra1V92CpI52AUR4l+/X+J/kx5Icyg45YTvHbri
         C7eDTV7BhMiDNwwtV5msqdJiErLkQVUnW3QV13mZwEHu0zy8ixrIzJfNqn13tD8UOv3h
         BGj4tD7yUbS8QukZ7CEyQXMjrZcOv+5AA90ywBjuYWRh8MjuIGLZGxJ+NsjKeVN+V9qJ
         v3HdgvZGX1iudZy/vYYfzzuJppA2w6hMY20Kmf1EfoaDceNMj6RLMPp4p/vIdVOOjozi
         w9Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVwx9ol/pjyNfZ2OWiiNXsHCFhKVdaPCYkjZhV5bNSI0xwrMK0KKY47D/zvCfDt8K2kYW5Gr15G@vger.kernel.org
X-Gm-Message-State: AOJu0YxzkmVHRrwzTFkrwLcF3fzH2io03QMhTPvqxrElwjMXbCDAADz0
	qQvPS1e7tBrBmMtGNymSgPzMFYQ8AoKt617bthA4Sd6A14GCGcz0YEm7sOxkxOnnRVbixhqHgkZ
	7exVIgatBzItghQKAp4OE6Z2BeI+rnbMJ9tjnddymZxnUn1OIcYzVeU/jxS6HF3rK6IWAOqC8wp
	B3bFpW+Bt265+DpyxMODg75sT8xsn/29bboRC6uOI1
X-Gm-Gg: ASbGncuYkEO4KlFqGqJV74gHO7L+bBBa0xi2ibHl7RRxj6GU95hlLlNnxZmiX+f7F9h
	y+WsETIL314y94JQwfQYA0sdBQDf57AOaAG9ckS8vZvJM3DDw5P8CUZjF1cfcWA==
X-Received: by 2002:a17:90b:280e:b0:2f7:4c7a:b5f with SMTP id 98e67ed59e1d1-2f7ff2574e6mr19936681a91.2.1737969031486;
        Mon, 27 Jan 2025 01:10:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2AUO22esWP/nMztcVYFDxN/JjQ3c/z9eP3DGIjhv6kh/a7NKlgjY9QDegkDnWn0ZTMiw3QZuE5pSKHaz0i/0=
X-Received: by 2002:a17:90b:280e:b0:2f7:4c7a:b5f with SMTP id
 98e67ed59e1d1-2f7ff2574e6mr19936653a91.2.1737969031212; Mon, 27 Jan 2025
 01:10:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 27 Jan 2025 10:10:20 +0100
X-Gm-Features: AWEUYZn-ZxFRojTIs7YgjthZOQiPBt-34IlHaFiIPdvHK4hhLsus_0rIAMhWgeo
Message-ID: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
Subject: Possible mistake in commit 3ca459eaba1b ("tun: fix group permission check")
To: Stas Sergeev <stsp2@yandex.ru>, Willem de Bruijn <willemb@google.com>, 
	Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, network dev <netdev@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

It looks like the commit in $SUBJ may have introduced an unintended
change in behavior. According to the commit message, the intent was to
require just one of {user, group} to match instead of both, which
sounds reasonable, but the commit also changes the behavior for when
neither of tun->owner and tun->group is set. Before the commit the
access was always allowed, while after the commit CAP_NET_ADMIN is
required in this case.

I'm asking because the tun_tap subtest of selinux-testuite [1] started
to fail after this commit (it assumed CAP_NET_ADMIN was not needed),
so I'm trying to figure out if we need to change the test or if it
needs to be fixed in the kernel.

Thanks,

[1] https://github.com/SELinuxProject/selinux-testsuite/

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


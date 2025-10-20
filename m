Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEAA2FBE02
	for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978321; cv=none; b=msNxKVD6uH7UvczXiPC9HdWvrBJx9pIX5oVJKhIem8FZwnwtWqGQ+Y9xjLwfXadr8/KNXMVZ9ZGfFrUl11yd+tj9eUk2rCkFppZip7GXpjt+IfeGbp6bPOOCfYPn7Stq0MSsg0zEcIXqY0H6KRGINgehMU16TBohJzLSHhPVO0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978321; c=relaxed/simple;
	bh=bLir0TNzzLo0e9EKWvnHMo4rDRPT9YFUyDhBXMGTO3s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dPCifpctUAskkdD3oIg1jVXn6MPCN/4nt8H9FV6o2DpfMVEKYrcp15SJj7rIETFy8wBMvF8+7t4yO/DypsCHETSZ2qBbNlRoR9yyqCY+NEYjCgsWZIpRcMTJ/dtnnD7q+dXUoUKkmb9L+/wvsVADyD5rn4g8VApSq4n2QgAP7as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QPNQZUDI; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QPNQZUDI"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-42e2c336adcso20289935ab.1
        for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 09:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1760978316; x=1761583116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61GIboXxOs25s0evX1OKzmkcFyOeZT63Qc8gi5u7/jM=;
        b=QPNQZUDIZr5JFz7+OXN8sGezUaRXy/eFtW3lhRKsnc5h3eyuWkJR0PHISnZ7d1mSRs
         IJDnN06aYk7BORA0lxF692EWKD2MfU8F0vpBRetTQfAmlBW2r24w5vlXVlPEVjq4S2Cf
         orujHsTak8AaHV3ZHcP1p3S/qtdhmKtcrRAOzLPAMgDEZYjgwz+oBEMIsM8l/w/MA7kO
         kc8bjogUgp1EsBgDGizKaPg3XTXtuEP/37EPJX3e+bsSKIUHeCo+ip01GF6druDtuya2
         vZ9dJyUylxO7GbnNeR7t8zMfWe6RFOD8LeAtVN5P2GBDFDPy5plNE1qJ2c3sMVi+ocot
         ow5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760978316; x=1761583116;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61GIboXxOs25s0evX1OKzmkcFyOeZT63Qc8gi5u7/jM=;
        b=f24UKv3/kGDfLj0tREPcxjzzAOjGSpNeHceFajjEJJq4tvCZPcN6ZloAC7Nk3U+UYl
         nWRURzF6XRxaU/SRNWuqXKYRzR80Rwxl6r3PI1bAU7qVgBqj+5yCOJQTbFrSMAKVtJoq
         2X8dvLm5cBBdyQwHYurOuHQ3Zi9MmJxWcwmKLVJW7vfAzCpio8AFMa6fN9fMp9v+R6CE
         FeAnfmwKjCLXr9Htm7FVNxaSjzE5qei6mdaXeE4lpXZpp6OMZp19kNsd/52cck2rpPGW
         mevwhcrApD8cXL8D5heXBMMSzb2bLLKfR1/QKlwQw8dmjIdW0HYg51vyAElyr4DT9eSA
         QDyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVidoFiPHVPgiRtfjUIXw5ulJcpzr+LdyUgdEguNgl7HPXQdr5ebakN/eCRsgRwYBj3bXWvSzAT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6kUas7R2Q7aIq2JcoHcHH18e3Fti9htcYO0hgOEfRi8yRcaPl
	12dlQPqbFJwkPft61xJ7cwc+0/TafTncGn8Sf4u7O1UbZARYW9ChO4KW6iGptq6UAyo=
X-Gm-Gg: ASbGnctxs8VHyDH3gabayfRlUUJlpcSxkvAxQ97H2aGlC+ODlMkRwGtWvNvFmxzDfKc
	r21mc7CBGSkQ6B/a1vlecnLLsGmEzCUEI1cmeWMWbX6ECZWNsva6UJMiEZSX3p3vBy4WNg3rT3x
	CZ4HQtOI/NCCyeYupCNVqgzVb1+kg4wSSUkrt26y2Mi6Y+SH55Yu0r7AQz0+MO+XFFM/9jNd5Wx
	59kGAlPYQBg/AAVGcPEzJQ0RuTg4w6YXe7TPxkAV93VZ/LmweduDa5lM1t+9z/+E9hddsxqWvDc
	kDL12csu+5+O9gTCWG+aOkR9sUYKjdzSHTk8TSUPnx54AEw0YRjxp/c4QRG86ssonn1OyTProYD
	gGIEZ5UEWLIT1ENuw/Zz6XZHg+GN8f7aTgePR/87oPuvdYImq65fW7ZVmWq/1A2TiU69Vuq2FYQ
	9PYw==
X-Google-Smtp-Source: AGHT+IEgP9MoSmwcT4IXjkDNqCrTHBFr78jjo89iNv/AbCf70/y5g8JWKMQdHYEnP0MCwavgamCqEQ==
X-Received: by 2002:a05:6e02:1689:b0:42d:876e:61bd with SMTP id e9e14a558f8ab-430c527fb41mr203189835ab.28.1760978316183;
        Mon, 20 Oct 2025 09:38:36 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a97909edsm3088855173.57.2025.10.20.09.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:38:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Josef Bacik <josef@toxicpanda.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org, 
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
 Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20251010080900.1680512-1-omosnace@redhat.com>
References: <20251010080900.1680512-1-omosnace@redhat.com>
Subject: Re: [PATCH v2] nbd: override creds to kernel when calling
 sock_{send,recv}msg()
Message-Id: <176097831454.27956.10406749282595384592.b4-ty@kernel.dk>
Date: Mon, 20 Oct 2025 10:38:34 -0600
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 10 Oct 2025 10:09:00 +0200, Ondrej Mosnacek wrote:
> sock_{send,recv}msg() internally calls security_socket_{send,recv}msg(),
> which does security checks (e.g. SELinux) for socket access against the
> current task. However, _sock_xmit() in drivers/block/nbd.c may be called
> indirectly from a userspace syscall, where the NBD socket access would
> be incorrectly checked against the calling userspace task (which simply
> tries to read/write a file that happens to reside on an NBD device).
> 
> [...]

Applied, thanks!

[1/1] nbd: override creds to kernel when calling sock_{send,recv}msg()
      commit: 81ccca31214e11ea2b537fd35d4f66d7cf46268e

Best regards,
-- 
Jens Axboe




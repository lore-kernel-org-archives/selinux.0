Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3851615B12F
	for <selinux@vger.kernel.org>; Wed, 28 Aug 2024 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860090; cv=none; b=m7nL2Zg5n7sw/evavv4amKXnUEdTBwj1HHYW5PQN25wc+iiMqe6q/B9AXVh+VSStnTrLfkY2i3PqyIa+ntBq9gigX4kS+acQubX9hh0OSNDAmJNDjDdmNoqTXQvufBvwYmn24H+DiBlcV8N4h58vjSbzmcBhuixJstqTsSqAmw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860090; c=relaxed/simple;
	bh=5aKtcj5aL7wIUwVBenqfQbWteV7OaUZ3Jq64JTFjNuA=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=B4xGQhAEO8Y3CgL+evKbjdD1hDCE70oLGUheGHhjQ+sq/QsV82U2PZ1ssXnVwwTgvKwW8m7FFcjGXdYH8mDavpugws2Lo/cql7pjLueW5t0Zjju/kzgmucUrogXt57sjCadkrAU6GnLW8VjSn+YtbezeuNfE7G089tp44bHBpz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Qc9jHF1v; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Qc9jHF1v"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70b3b62025dso5603187a34.0
        for <selinux@vger.kernel.org>; Wed, 28 Aug 2024 08:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724860087; x=1725464887; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tIhnPtZtDgzVsjXXL3AlKEEvNlZGLgelF/rd9ZuavBM=;
        b=Qc9jHF1vkC++t37NSzNWX/NJWrpcCcdDJvq0W+FCgyrb0loutXTK8zeq3XA7j3ayi7
         ntbdxMqQ4tHQ+71O0O7ALad5nO/k4BEDQELUFpHssO1K0kAKOvIlkVUBZvBHiygX+YH0
         d48yAeTAb8GiUhTkEJwSpMqF3yufI58FCAEgDIz3kdHAuUrQWccRgrV1j9uJPPRgpUGb
         oTINm0NjYPWRe1nSbkTS9BlPdOHaFTQrqfEs2azVd/XghFF5c0tbjQQtyUxIxqp3UAUa
         72AePoNzG2Q0MsncoW64Kk0uOv7GgfEh1zSb0k4ake2R2WPNTCSvAjLHTOAu2GN20viZ
         QFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724860087; x=1725464887;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tIhnPtZtDgzVsjXXL3AlKEEvNlZGLgelF/rd9ZuavBM=;
        b=FOtYV4K3r1my2QdfHoyOIGiYEpUHp0t75R41/kB6t/BBVQPz+awqMZVT7FnqLO1LCp
         DkRg1EYDmLVgZ8GnTmMwHWYxsOv7XufhwT+Fk/saVCjtFV2Jl1r/nzqk1lM8gBZEnemL
         buXA5xmeaUf3JsoWy06ub/M3/IuDTEotRjv3C/gHof0os0DY08emkQQ1QFhLXuK1rDYr
         2iTqamb3XJygnF+uJkhj+8HqWvDPCKVgGyqxaJsO4Rl4eydyhrIYsj3c+Uz3xUpWKSLs
         J3KUUypg/k1NU8fvdV15xB7oXoKlmplx/dF00GNLnJMbDUnLZ7reLTl55+s2l4ZoFB3D
         tMNg==
X-Forwarded-Encrypted: i=1; AJvYcCXhw/YE9cDGjm9kt8nE9RaYTJs8rPQ1f0qnqvh1LcI8aVfYEX9uEVQEFQhVF5IkcyNPEgtqJkOr@vger.kernel.org
X-Gm-Message-State: AOJu0YxiD23R4kLfkCx1PTNsBtv+eiuKwZZNs3jnmyARYBi5O+yCz6WS
	fNaUONCfvkAe73VllUHhx0Ye/qPEiNB5UbtmblFagBVkAIPy40GYvcrr0x5KdPS2LmOPzlyZQTs
	=
X-Google-Smtp-Source: AGHT+IFgsiB49Hz6L/04GdqJi2W5uMiR+B3r/9BchMQtMgraMWY7DjMRz8TeFkhT+8dgUNwQTlbMuQ==
X-Received: by 2002:a05:6830:2112:b0:703:77a2:2854 with SMTP id 46e09a7af769-70f53ae980dmr2643796a34.28.1724860087113;
        Wed, 28 Aug 2024 08:48:07 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe19a4fesm62669251cf.67.2024.08.28.08.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 08:48:06 -0700 (PDT)
Date: Wed, 28 Aug 2024 11:48:06 -0400
Message-ID: <40b197ad7fa3c667cd533c86d87b1e7a@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Guido Trentalancia <guido@trentalancia.com>, selinux@vger.kernel.org
Cc: Guido Trentalancia <guido@trentalancia.com>
Subject: Re: [PATCH] selinux: mark all newly created Internet domain sockets as  labeled sockets
References: <20240828093518.27340-1-guido@trentalancia.com>
In-Reply-To: <20240828093518.27340-1-guido@trentalancia.com>

On Aug 28, 2024 Guido Trentalancia <guido@trentalancia.com> wrote:
> 
> The current partial labeling was introduced in
> commit 389fb800ac8be2832efedd19978a2b8ced37eb61
> due to the fact that IPv6 labeling was not
> supported yet at the time.
> 
> Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
> ---
>  security/selinux/netlabel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Much better, merged into selinux/dev, thanks Guido.

--
paul-moore.com

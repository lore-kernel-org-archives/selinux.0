Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7133064
	for <selinux@vger.kernel.org>; Fri, 22 Dec 2023 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MuIuKlcm"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-781045f1d23so164777685a.1
        for <selinux@vger.kernel.org>; Fri, 22 Dec 2023 15:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703286328; x=1703891128; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnveriAFIn8bmPk4N3nZaxVfmoS5oFPMABUUgH9ai6c=;
        b=MuIuKlcmI3lGIFKUt8j0PPxbERz5+piin/lTR0kzGUAl+EVX4L/0z06FTbOqFNTpFa
         iI5hkGIobcy4UKxM1tnX57J3yRWHIWwNP36zSg2S2Pg0osfNzdLj4CyEN/YbXndNKp0d
         ox3kv5EXg77cpUrEzLSdm824GoacEs7kK0H3sqn4tpWW3UbJmkN4HHZQtpBQoD+EimaK
         kYEcoe7NCarebhAx5XByqsqcSQiBXeEJUUBlPwB1r1Xus6KelIPsJrhXWpj99DBqzlYr
         N9vNdYP3nIR/h+bTP4wRS+2s9YHmox3CY6NuQKnsb7rJEOXsnJ4zsrcRwt2py6V+jLxT
         4LZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703286328; x=1703891128;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OnveriAFIn8bmPk4N3nZaxVfmoS5oFPMABUUgH9ai6c=;
        b=skGa2816Yl0CYMzAQv0CqMQKCfysJThYbs0HzRAJpMAGdVUiXUh33fvyjyraoddXYz
         Buy1841j1orBLKNIcjWjxfy7BGX082rq4Z4Y4vHQ6frWvJdYHGBqIJz93jk0UcOUKE3P
         CZbCnLb4b8rZKDSJGqRuxWkeDgcjX9Bm6b1qRczLmRdnyNWStBdCna3cLifB4YpIid9g
         C0OAh2ZHS+PjW5tEYC5k8tyaCV+ND5i2Ar+vX5JiPcG7NAxITSoCJDwwxhT5bGsPYgwq
         67x83z8LR5jai/FeLJjCRGKb5iUSGGPuK4VBkGCPwJ/uyz3kZchc+W4/nYzsi/q9+sBm
         Qi/g==
X-Gm-Message-State: AOJu0Yw7MjbxCxVnNqNLtElcqpFQD1kTxHudaeJQqZFv+bsSJiS8N0Qt
	sFyQxcWoBKQ1uMNLQ8smX9VG1WUrj/3C9+QL9NAr/YgHhg==
X-Google-Smtp-Source: AGHT+IF1gwfBl7nw2gfY7ysQNVTrY/CNohl5eBhLQRjdp1HSBtaEAwEDbG9QkssHDIXr0QtWRayNww==
X-Received: by 2002:a05:620a:394d:b0:781:274e:94d7 with SMTP id qs13-20020a05620a394d00b00781274e94d7mr3072133qkn.147.1703286328598;
        Fri, 22 Dec 2023 15:05:28 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id vv6-20020a05620a562600b0077da7a46b0fsm1660261qkn.69.2023.12.22.15.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 15:05:28 -0800 (PST)
Date: Fri, 22 Dec 2023 18:05:27 -0500
Message-ID: <746707bdaade7943ea4a7a9208504340@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org, Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH] MAINTAINERS: drop Eric Paris from his SELinux role
References: <20231220165348.127587-2-paul@paul-moore.com>
In-Reply-To: <20231220165348.127587-2-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

On Dec 20, 2023 Paul Moore <paul@paul-moore.com> wrote:
> 
> Eric Paris is an important part of SELinux history and we are all
> thankful not only for his stint as maintainer, but his numerous
> contributions over the years.  Unfortunately for us, Eric has moved
> on to other things and hasn't contributed to the SELinux community in
> several years (his last SELinux kernel commit was in 2013) so it's
> time to officially drop Eric as a maintainer.
> 
> I also want to get ahead of any claims of impropriety and state that
> this change has absolutely nothing to do with commit 2be4d74f2fd4 ;)
> 
> Thanks for all you've done Eric, you'll always be welcome back.
> 
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Merged into selinux/dev.

--
paul-moore.com

Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E3F35CB76
	for <selinux@vger.kernel.org>; Tue,  5 May 2026 02:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777948562; cv=none; b=RDXxy6Gy/zK5VLdWC5wHrwFLfyA230zPCs9yqaXrBN7FFU3aWbAuvIokhEoRGr//BMBXHGWgSX/nR+gvZaSS6HX0NGGZ4SJfo3ihukLFe6glk5szlppGbVi4rbBNhPV6QAkmW2+p87nHiy5bD658NgvHv8y1HVJtckXW6LQyKYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777948562; c=relaxed/simple;
	bh=oMQkrJVzjvGDzRf1TBvQnxsy7RIYnIH9CMiQBh6tMxE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ITLSJmJ/tD+5xoALaKoWAHAbKWJdrj2JO+HCswvCx3tlHY0BDcIpezmc1GUrye+s5bTK/9L/fb2EEtTjs5V/UiC0pHT+UydxLjNpt02YumNZH91zp/iST+0xophEmwYWrJPOXUdXQjHwih6uRaDVS7cR29JqVYEvUvdI/o7LXBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=T68EB+2w; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="T68EB+2w"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d7c12e48eso39916141cf.1
        for <selinux@vger.kernel.org>; Mon, 04 May 2026 19:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777948560; x=1778553360; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxv5WBJCMVGAsJWOha+l6tyIZFQRuwjg7MIsnEx1ulY=;
        b=T68EB+2wcBgYA878D2BwQABRowWoPnhahLX2DY6iT+RPE0ZafCPZhaHK2ypstACTtv
         LOr76OEQrkxFu1qMGch+jN5xAG4oBqpLPpzqCxehglWFIVr4bvkgXdxX9bcffsJOE/U4
         WN3u2VwXaWiFD7GTI4oe4xKzyEC5+IfgOHNXmwLvBfogaUhcTd72iI0dx52oC00JyE3S
         cvi1tCGYKJwW0jGXy0hLOBiwWmS5HJrlVcP4WB+VQHc0Inku7asQX9FTJOysnlfmZbsB
         jeyytertFIuevS49sFdEsEY6bYFK8coD/ARitcXxklDieAaqjmjzx/sXpOw2ivlBuIFw
         BDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777948560; x=1778553360;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxv5WBJCMVGAsJWOha+l6tyIZFQRuwjg7MIsnEx1ulY=;
        b=nouj9Q0lluiQCKsxH6gOOI90qfQmIeroTV/ENiljGhEYLGmF56MreDRBbHyKXj+3GW
         PozDDdP+b/MAt0+y8J0yvfo1BwgNXyEMX0MSzOsutbWduTRT4HhqK1dtpEaKPkRr0ErY
         tWtLvo+pw4gL6lfqltVjwAPDUPuSGhBRMsCDxdPmLPua0iDu337h68f2SYAgMvM7S0hS
         3KafGwPyQ+suFhYag8YgkfatxLAA6bv86OS67MzVwKyGuJdDCLdvvpzCmL7gt0zy9Mvi
         BongWvhknvnY58xfuqF/+1tZ5DRPoc6XYO5qAeKXBP+WBJV4jvbPo+3qx6jxgPl8NTA9
         lyvA==
X-Forwarded-Encrypted: i=1; AFNElJ9PTwY9Z4NLI2n/EFLN7QAyyilB0QPGCcEKssiY0c5enNr/Yx7P/UGdKQNxcspXRcsc3jsro10L@vger.kernel.org
X-Gm-Message-State: AOJu0YwUa9uvfNnXNQokuWGKElTA6a+Q+jqdhryE0gS9tdQKZbVrUUDW
	chXuO8sWo+uRRxXNFd1FozpXNrHUD9d7y7fA/e/q4TXgrTFkHjztx5IIebOSdfUzyQ==
X-Gm-Gg: AeBDieshAMLvkkFaq5psxZ+LcKpBIsCmpomej4ZlPGyJjHRaVh3BfKgsQvnGWCEgjeT
	u/0Syccf1xrptJW0qqHUOlnCSSL8FXD8zplE1lJNHFl+Nx5YRmvi0nPTckaHmQ0cSQD0NQnEQad
	pcm21IIdYdGMG1ITugz2Q6aHQxXh8et8jEDVMu3uMkQGWdbyHdwssqjYmejEvB77qUUAoQHs6CU
	oteOskOeJ35iH9NOvHkYcl7RZIizfQevLErWY6AW56ssT94TfClkJg0TyOOq87qFB3AmgLvptX2
	GSwPT5dlGh4ymjT3cfuF8LFZvKQ4vcuZeUx/JOchk1wOwCskYDrchvNfgIXi12TT5Pci9MDJddT
	c4g1Gx2iO+NYaV+XjYV6KV3eZdFxxGLvNBi41h80XbZA1ScgnVLEjfZs52Se9Ph4USLRRss/KpT
	DUSc4tBJSUvhrHwCcwDNlb74XZ6o+Z+s61I7TBjaqQIR2GESzCUz0C0tOBJiVQX7qR3FPIRxF1j
	g/9Hyk=
X-Received: by 2002:a05:622a:408e:b0:50f:a53b:9d3 with SMTP id d75a77b69052e-5130535deb0mr29676211cf.27.1777948559759;
        Mon, 04 May 2026 19:35:59 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040b8550esm113244871cf.26.2026.05.04.19.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 19:35:57 -0700 (PDT)
Date: Mon, 04 May 2026 22:35:56 -0400
Message-ID: <366b06e622a590399fc41298bc291c21@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260504_2038/pstg-lib:20260504_1547/pstg-pwork:20260504_2038
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v2 3/3] selinux: prune /sys/fs/selinux/user
References: <20260429211229.3750-4-stephen.smalley.work@gmail.com>
In-Reply-To: <20260429211229.3750-4-stephen.smalley.work@gmail.com>

On Apr 29, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Finish removal of the /sys/fs/selinux/user interface aside from a
> residual stub for userspace compatibility.
> 
> Commit d7b6918e22c7 ("selinux: Deprecate /sys/fs/selinux/user") started
> the deprecation process for /sys/fs/selinux/user:
> 
>     The selinuxfs "user" node allows userspace to request a list
>     of security contexts that can be reached for a given SELinux
>     user from a given starting context. This was used by libselinux
>     when various login-style programs requested contexts for
>     users, but libselinux stopped using it in 2020.
>     Kernel support will be removed no sooner than Dec 2025.
> 
> A pr_warn() message has been in place since Linux v6.13, and a 5
> second sleep was introduced since Linux v6.17 to help make it more
> noticeable.
> 
> We are now past the stated deadline of Dec 2025, so remove the
> underlying functionality and replace it with a stub that returns a
> '0\0' buffer to avoid breaking userspace. This also avoids a local DoS
> from logspam.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  .../{obsolete => removed}/sysfs-selinux-user  |   0
>  security/selinux/include/security.h           |   2 -
>  security/selinux/selinuxfs.c                  |  66 +--------
>  security/selinux/ss/services.c                | 125 ------------------
>  4 files changed, 3 insertions(+), 190 deletions(-)
>  rename Documentation/ABI/{obsolete => removed}/sysfs-selinux-user (100%)

Again, please do the same thing here that was suggested in patch 1/3.

--
paul-moore.com

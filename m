Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F98534F279
	for <selinux@vger.kernel.org>; Mon, 29 Jun 2026 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754283; cv=pass; b=N3C7dZIqxh/ujqztzDHBtSkDA2noWTgX2KfwesvyfKgdhIreMQ4aB/Sj8vkJ/G1Cu4zLGwQGiG+b5y+KEJRfnh0qVlG7yDfwGxWxZAASK8pO3+15rHg6uOyAb0u1d4X8Q6J1Y2c9NUgxzfJQgn+su7p0F9FKwQvwgaGWvQfpGKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754283; c=relaxed/simple;
	bh=eOClBfv6lfdCI5t+K8NOrbjIYwBgmecurDoITjBEbHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRfUegwvW/USS2VWOwqlTkbVx7mmOEzDY9k7CTLGpZC4f4NJWae6KchMvsVHuxRpPC8FCzG5N8Ug6DXF5hRyMlw3YQnA0ItLaerHpD8xbrq11kW/mUjvYhltGL6oUdrchlJi8m+JIXnJUEJmmUwwT7ZjXmARCSUEXUv3LRM/Q+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOB0tbQz; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOB0tbQz"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-693c69b97e7so6905810a12.2
        for <selinux@vger.kernel.org>; Mon, 29 Jun 2026 10:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782754281; cv=none;
        d=google.com; s=arc-20260327;
        b=XI/j4uxslppro6+yaHbaTUPCDhDmeho+7BZYnSC3QkEdSoPIg42NxKWKZw22mYGxqb
         pE/QR/GJ6Wn+RpLtlfjbFT63r6DmUT23sr2GLzxUPMgdQsZhMQ5oUfCUd8X2FoV1/9Cd
         LyJKZPYEC2undsUwYyLUHwkTg7D5vrK3n/LBwop+FvQkrcwU2uxOeOlCvVju2YOub496
         /6JEPKTI8VV7ovy1gZMeGHL0aIY3bSjknQN4dOwbFnLhPwE75MfwAkES12he3VQvolFS
         csL/2XmTdyedOADKpWAsPgOufUXDy+vGZOv68WB2SYf1XG2zHy9lT2sOg2Lp1dx296ne
         EUTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eOClBfv6lfdCI5t+K8NOrbjIYwBgmecurDoITjBEbHY=;
        fh=RahKRce9Ku7dHh0lkt84uwcZAcoOZgr/bPBnJ1pL7IM=;
        b=GonOCwEfQ2fG0C2oEP6ekuJHIzBiQk5PI1qyc8ehb7LerDbMq+EWbcOqo24zA+u3uf
         kslUhhiEZT5kgMkxkeYDY0RNgFXsrCBxK7d7DDTTvrkwxmay/yhV6yEDUry9rEL0Ygj0
         CkxKCpp6coXwvvA1qf8CMaW/aAAWidpt7FIgNHPKofLtCORbki6GlkvAeHDZjLnB6BDV
         N8PrS6DxmfwiHDdvnU8c1Q1UWfoQnPgr1cUtML9oXPtNx6xDyAz8RAt6HC8KN9yOFEtI
         kIvogsSJ+4X7X/duEcAUmqeVTStMz7M3YgiJXpswYfbDxEr+4elEKqeQBwil6gETCx5+
         K7Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782754281; x=1783359081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eOClBfv6lfdCI5t+K8NOrbjIYwBgmecurDoITjBEbHY=;
        b=VOB0tbQzXHx225/eBRLGEzWz6vX02N24U92aDSCNpfdq7DZv9iI6NGkOHF5VJSXBf0
         iZEHeZ0V5mC0F3hIMX5sla7sCwE6QUNe99CfMZz+3kF02NmreX29GtPeIhhn9/tvERdq
         6rIHJEfwGNs7g3Qtc2MU325nY7nvEWm2h/9qTqpSpa6S67zweReqCilX7ZHuwu06Afw2
         Tp0haJ2b/3LKr4BGQqiyRCz5NDX62Jd6SCIPaTHgyHwtVcs9J/8SW3WLPHp/mOLeDDnB
         HbauBnc7gNry89jY+RZ4nsQ9ECd+RxPZvUBef39i/RgCTiFo8PTy4LyUjrjbVd51dDKN
         dcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782754281; x=1783359081;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eOClBfv6lfdCI5t+K8NOrbjIYwBgmecurDoITjBEbHY=;
        b=Qo0SJcAyd3yQa4zKRJD50ZJOT1zJTskizRHPcuD7lGIRsbpXcdr6m/HmQ7SjOSPBjI
         VXVGg0qBU2AKA3SdHpEUz911+yaM1DnxoPBBp1XGxsehRFWaTpYmWXTwc0Nm1xfYBF9I
         vqpUrYomzb63DnKNN0LuM9Oxfrqmsr605ASWgf5tccWnLCQVBvuAPqbldBJftsroF4kR
         jnYDumxHVW8yhb2gCQq726jC9Q649xYszViwQWibnf+QwK+Vevi70vE/B5C3ILiXsVFY
         4dlgqulNFI+3IZUx7igQlfkVx4mNruoW/7wMW8+FP7WxtkoFriNFhXb/GTZxZIPlLxUd
         YSfw==
X-Forwarded-Encrypted: i=1; AHgh+RoZL4qC6UK+Z91qzIjDp5SNHL3uOnV0szy9iYzGIch48vHEHbgrJluSpJaQMRLsgVxpz1na6i5r@vger.kernel.org
X-Gm-Message-State: AOJu0YxNyxHBfjeJt6iisXpSudTeA+h7GVH0s7M3jhGrCTvo1XXogFU1
	D8cxv/NoH1Yrlzt/AJBiGdRNqsrhGHPFlp67M5yeqYwwMl5ibP838WP4VM8jDBzyZ5QLbsplaFJ
	SiuZDmav9Tcq07uojOywxBN0FspMhyaQ=
X-Gm-Gg: AfdE7cnQZlKe+Jn0svYF/DL9DnHhVf2zFF8YsHL1f/bBd/jwfHjVZ6qW2mlS4zo0aMi
	+wRyzW6EGGvMQYkqWc90ZA5Y7x8i+7NGdFBww9cNP3KCrBuPKtBk5YfvgDhD12Yco5pNPYl4oLy
	wo608K3ZyXxEtj0xkyJvDWPWkT+S+W6CkBaIXkLOKJ/HaWLu9OrCarYplH/A8AgnjkJk/yeIgdR
	CXxOXiZbNU4mqfy6PkrG7bDhZ+F53z4Ljdu6Yu1VA8c8xpkNB/EZuZ1i+rskFvRGCd4+9/EX+cM
	vvdianR6FXgAfLVeNOQlsKonUN9u9Ys=
X-Received: by 2002:a05:6402:390a:b0:68f:cc95:8c10 with SMTP id
 4fb4d7f45d1cf-69879e4b974mr46982a12.27.1782754280332; Mon, 29 Jun 2026
 10:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629070653.580879-1-caixinchen1@huawei.com>
In-Reply-To: <20260629070653.580879-1-caixinchen1@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 29 Jun 2026 19:31:09 +0200
X-Gm-Features: AVVi8CfvDZzdzYVHdraWAewZEFEyCZ6yZ4zu-tcKsdp7diMSLlszm49WqjY_Vvs
Message-ID: <CAOQ4uxjcD0-PHqqmrpEvkLRgtKJGe8-n+6DQyBngjN2TorwU+g@mail.gmail.com>
Subject: Re: [PATCH stable/linux-5.10.y 0/7] Backport Fix incorrect overlayfs
 mmap() and mprotect() LSM access controls
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	miklos@szeredi.hu, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	gregkh@linuxfoundation.org, sashal@kernel.org, bboscaccy@linux.microsoft.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
	lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 8:38=E2=80=AFAM Cai Xinchen <caixinchen1@huawei.com=
> wrote:
>
> ackport the patch series
> "Fix incorrect overlayfs mmap() and mprotect() LSM access controls" [1]
> to 5.10 lts

Chai,

First of all, I don't think that stable maintainers are picking backports
to 5.10 that were not backported to 6.1 and 5.15.

Second, backporting backing_file as a dependency to LTS kernels is a pretty
intrusive change, so your description above is very much lacking.

Please do not backport backing_file to any of the LTS kernels without provi=
ding
detailed explanation to try and convince the vfs maintainers that you
verified this
bacport is safe for the LTS kernel, because honestly, this looks a bit
risky for me.

Thanks,
Amir.

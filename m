Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262D8227E9E
	for <selinux@vger.kernel.org>; Wed, 16 Apr 2025 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744800120; cv=none; b=hMpTl8vKfVLrBWaSRDTQ4MNYZJpbHIVay/gfSwBP4P0jMBMjqwRuaHrtLZSlI3ZjkFSFO94W8cISYAgLkRNUd2jPJq2OmcknKiIEbebW0gRj5SOGIOlgKbYMkef/BWfK13FrF/9m9KZRVyOKbqJMxJociXPgx5OcuUc6cbKClfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744800120; c=relaxed/simple;
	bh=h68xXKINGGyp2Zd1XCK0EQjYEAkncB1gRD1F116+4l8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=StSEfYmc+dMbgLGk4QzSvSHG1P/oAUDSiKH1gBg0IXJSWp+tF5vkU8BoeBvl/vxIYUKYLoLWFK2t0BzqnCYN5Aa7gIRx9zEoCdevlAumT90PugdLat4icp0WEm4//OqoNBJlHhDz4BrotaPgAM8ZBmXDnh6cqpvGif3CFqAOHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jt9td+Y+; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jt9td+Y+"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d5ca7c86aso39306835e9.0
        for <selinux@vger.kernel.org>; Wed, 16 Apr 2025 03:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744800116; x=1745404916; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6A0OYhXVyrvwG53WhJNazsiQLTbwvjRH95oKmIwbVlI=;
        b=jt9td+Y+apu6TXIz01nW6c96+L5WUIovnfFfBwtgml8TdpjVyfVQS4uOHDXUFKvvC6
         iDKzj1NiX1+ij31K4llByHishKFt3azDHSUYscVRthZD5wrVziPyZXdxcHDl0+8rBCw2
         Md7jVRvyVXgw95U1Jc8inUwYwR/h+GVQvwSXy+x4ZU8gTsSMo8O9H/vRqlRzXiwPCicz
         eWInKGNTTsi3pjUU0xiT7ae82eRbbqGMgcGsCf4uVHn7rEZJ7vwfcVU6QSSOnBfa1W27
         aHsXyg4W0XQqcsKQHfsfhKiv9UCsklOUidjzlXXRZOz9H3EN3x8sME7TNLA/QmnZlyRX
         HHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744800116; x=1745404916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6A0OYhXVyrvwG53WhJNazsiQLTbwvjRH95oKmIwbVlI=;
        b=SrTRwTJruM+YCcY19AwQUHWlDm0GD44zIXVDI1IRx5n8NGqlGlDGcnGdwKQr6PkGpg
         IK4xts4VJSoLr/FFGe2pLzJVHPvCZPH4RTzKlNMra/II+EsSuHUthDrC13+4clGI/7dT
         XLJoFdkcnXGoERq3n6FkOVckJDigpM3D5ME8YcZT0b9T2tGrdOQJupFkP/PSLF36E0Ja
         UCaxUQaVJtUD/ugZ8qk2NhzoQoS43L6CXU4t7wSQoiRIJ+rq18nUD19OY7AyXxAtkbvc
         JisVx4tulZY9i6HRmy8VW+tw97lS8JYHINLA3BSuNYhbtgQA0OHm0X80vTyqqfGMPZl4
         R3QA==
X-Forwarded-Encrypted: i=1; AJvYcCXeph9bV1+y6NVzhJfeKF1tAziV4gAnxdvodHqAMFsusMzDA0UHrAx46ZaX360pb1hJwAeciJne@vger.kernel.org
X-Gm-Message-State: AOJu0YxoSrk5AbU5WUt9Ck8BkV/LDxhIhZ5MiMalWXUw08VLEp1sbwHI
	dwvLBCo/6wtZse8MQ1KMot+jeHn1YDbL04Id0Rrzn6+TzNEN3n6NURajbkhMTyuNUCs6y79IhMi
	FT1HDqeFT4yoC7Q==
X-Google-Smtp-Source: AGHT+IHbOUuiD9l/lD/r2xNmdxsnmZyj3rRN9YGE8HEdjxjnJL08f4wrTj4agiOUIECbnHkcWVNjdQwPnigBcfM=
X-Received: from wmql6.prod.google.com ([2002:a05:600c:4f06:b0:440:5d62:5112])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e0f:b0:43c:fa24:8721 with SMTP id 5b1f17b1804b1-4405d6372e0mr14227725e9.17.1744800116579;
 Wed, 16 Apr 2025 03:41:56 -0700 (PDT)
Date: Wed, 16 Apr 2025 10:41:54 +0000
In-Reply-To: <20250415071017.3261009-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250415071017.3261009-1-dualli@chromium.org>
Message-ID: <Z_-Jcv-GN68zILvH@google.com>
Subject: Re: [PATCH v17 0/3] binder: report txn errors via generic netlink
From: Alice Ryhl <aliceryhl@google.com>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com, 
	tkjos@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, cmllamas@google.com, surenb@google.com, 
	omosnace@redhat.com, shuah@kernel.org, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, horms@kernel.org, tweek@google.com, paul@paul-moore.com, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, selinux@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, ynaffit@google.com, kernel-team@android.com
Content-Type: text/plain; charset="utf-8"

On Tue, Apr 15, 2025 at 12:10:14AM -0700, Li Li wrote:
> From: Li Li <dualli@google.com>
> 
> It's a known issue that neither the frozen processes nor the system
> administration process of the OS can correctly deal with failed binder
> transactions. The reason is that there's no reliable way for the user
> space administration process to fetch the binder errors from the kernel
> binder driver.
> 
> Android is such an OS suffering from this issue. Since cgroup freezer
> was used to freeze user applications to save battery, innocent frozen
> apps have to be killed when they receive sync binder transactions or
> when their async binder buffer is running out.
> 
> This patch introduces the Linux generic netlink messages into the binder
> driver so that the Linux/Android system administration process can
> listen to important events and take corresponding actions, like stopping
> a broken app from attacking the OS by sending huge amount of spamming
> binder transactiions.

I'm a bit confused about this series. Why is [PATCH] binder: add
setup_report permission a reply to [PATCH v17 1/3] lsm, selinux: Add
setup_report permission to binder? Which patches are supposed to be
included and in which order?

Alice

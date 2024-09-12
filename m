Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E058489
	for <selinux@vger.kernel.org>; Thu, 12 Sep 2024 01:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726104803; cv=none; b=tpgzOuwx+YQrjhaCMuOxZO8cSkIgxZ65J8MwiW3bMS+OqaanbRazFdX0/D6jSlZsYB9oseVFZ1EHI9EUdtADOT72gOF8cEj5YZXjY7Cm3HS0FIfLAIvMWfYib+8n7qI8cq59zZiTXAv7ad7NpIwlNVDDYuINwUeVzFGveBPtkRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726104803; c=relaxed/simple;
	bh=lY66ZGnQG8uci1/BSWm7lxM7y7HKvSelyK08hw6oSCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSaLxNpSjxNU2WVIpP6/aj8Bwa7xFzpDiQxK+EsdZusGo9qXvMCwf/aTdEwvXa1HaUL65Kd0R0gJzRk0iXw7iI65RCJbohu78IgJOPrYwbSq10S9LiAzFQbV+6gZtdHfimFuF54RkfxpbYH+KtrypBUOeZo0tfWFd/j/l5DU2mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dSowgFTl; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dSowgFTl"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c2460e885dso15454a12.0
        for <selinux@vger.kernel.org>; Wed, 11 Sep 2024 18:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726104800; x=1726709600; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cSpCWep01yY0Lc5qOF7RhVVOCwdRMOkjtaNDmmK7arI=;
        b=dSowgFTlXKe7sk69uGEnx4Ll4pm4uWWSlabEociSQEnHVpH9Nzf18AWNhLHpUIDGk0
         8SW4yA3eypM32d4RMNVGRAL9rcucQ0a6RaZ5HMxyPQTIKqx3daklvCH7+OeLF2DJ4U3a
         N/2n6ft7lQfO5i+Xji2ZoLl3AbbiYZ34bE4irKp4BaUwkNtnzz1QAQuXvL19LyKZCALa
         DR/5T+r+ews2byuxlQLsE+wUNzkIPnfwjIwt0z5Sjhk3xU4kiRIoaju1iVP9CqfFkPXp
         yjev6p6jTXrxvZenol9jnDCKCU8/9Wu99onEQQUfdKgrl8Ow1tYrzdHgZQ2NPQt/1fT/
         x0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726104800; x=1726709600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSpCWep01yY0Lc5qOF7RhVVOCwdRMOkjtaNDmmK7arI=;
        b=WeMy1/k3RTXk9YoAQPJn/4yDEr8GZ8Tqm8SX8UPVoMHNpdaZFMEND37yJNczlaajwm
         DEswihFyzLnq1iSzwQyfhMm+UHwmflcMiSb4c3P2u7We0cIC+9FWHmLEmlc72Da50IFy
         qMLICdTtBhO/pGXeXQsuI0oi5IfgdH1p5Mo45SHY4ieM5fwMnS8fgmmEMRFYehCBN4QC
         JED8eWJ7wcJErNTyVn+/PwprARW2X69N2ASKc4+oV5qrorxyUmYLbd2VSpDPDGT5VtM/
         PhxgaFAuyprbKHx/Jfv6WJVgoiiafnJsFgqinDpcT5fD+O++uUb+17imbsg90ToYFEUm
         hpRw==
X-Forwarded-Encrypted: i=1; AJvYcCUIB97oXb8xwIUQJeze23Nj854lcE2oJZaXKxkPswY6Qb9bw9EkEKZ4HCBavnHYUlbiS8P/3S/Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzIxntkD/5HH2ky21754FjjEoOQ/LHjK8RS0Hc3qmhIGD5ZK5yH
	oP15ZVEPzvLf51Imua39kOA4GyoATS00tUlflxrGtGNOWdf/5yJ+j7oNva+8iR0efHduAbFN8Zs
	BBBDxzB/V7LSFukcusrbagvzDrS1lmKPoUTKd
X-Google-Smtp-Source: AGHT+IHAizFfyxwNfQ2hkNhry9P0JihuBcS7K6tAMJCHk8CH7rJ980f12ViRq8zNLegDiq1h8iXU8XX2QeU/UiUVdUw=
X-Received: by 2002:a05:6402:518d:b0:5be:9bb0:1189 with SMTP id
 4fb4d7f45d1cf-5c4144e10fdmr211271a12.2.1726104799151; Wed, 11 Sep 2024
 18:33:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910013535.3680953-1-tweek@google.com> <abd932461647a78bd20694855fe2e60d@paul-moore.com>
In-Reply-To: <abd932461647a78bd20694855fe2e60d@paul-moore.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Thu, 12 Sep 2024 11:33:01 +1000
Message-ID: <CA+zpnLfv5BiOytRqoCEHiJYv-i=usL9B9-0CxGEkg3vgTEXZfg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: Add netlink xperm support
To: Paul Moore <paul@paul-moore.com>
Cc: brambonne@google.com, jeffv@google.com, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"

> I agree with your approach of ignoring xperms on generic netlink sockets,
> it seems like the only sane thing we can do, but aren't we always going
> to fail a SECCLASS_NETLINK_GENERIC_SOCKET check here?  It looks like
> selinux_nlmsg_lookup() is going to return -ENOENT in the case of
> SECCLASS_NETLINK_GENERIC_SOCKET which means we never hit this chunk of
> code if we are checking a genetlink socket.  If selinux_nlmsg_lookup()
> returns zero, I believe we only need to check if the policy capability
> is enabled before doing the xperm processing.
>
> ... or am I missing something?

No, you are absolutely right. Let me send an updated version with that
part removed. I'll also remove the comment but add a new comment
within selinux_nlmsg_lookup. Thanks.

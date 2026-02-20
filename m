Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CA02BD030
	for <selinux@vger.kernel.org>; Fri, 20 Feb 2026 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771625787; cv=pass; b=tvxu2aVLX4jVd8zmsBcCX5wgKKwzlQoAkecoxukuQSp4RTt3yhJMgbfG3YYMxRwCcU5s+gB6J9tuK6iWP+NPlJMA1UvkJoSd6zN+UXkEi8UPRPQhjzqAp15+hUx4fnZwKkelaCUDG2weBOHKTBcI7xV+vE0R7LCbYKU3huyh16E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771625787; c=relaxed/simple;
	bh=I2pkF5QAewPTXXJtz0yw3qpr9uypN+JI71t0BKuPbOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYYFpOGOFtkPUDbIT784oXAV2Q8ZCl5HqHFAIyQldS4/YbiPji9DhFiBQ3IwHNAwN0LiHUGI7nI0wBWfx0S3azL/Qwr+BmWHamZZLfkrIYvDVQqPRExZUvCWSPD8A1de+g7gODD0iBMGHwBYoRGK2gMlvXELca+0m24xdnW0hNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Bme1k1jC; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Bme1k1jC"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so1697395a91.0
        for <selinux@vger.kernel.org>; Fri, 20 Feb 2026 14:16:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771625786; cv=none;
        d=google.com; s=arc-20240605;
        b=jvyT9MFtoxzsGGz5vH7pCw/5noI4aUxn0f4J9aqe5Z5XVBY5GsV8exqb4hITfbreKI
         ZxmAR69JXHunfAb13buy3Wwu23Wr++3xGRsTXuk7f12qAf/pjo9SmmGMXKdAoqDrflly
         bCAHkvKa6N7iDRdu2sfYHS7dTSzSgZ62La+yWANB1PjuWV3QqunN//TxQkCSSjzkCQuf
         s9XyYVUwfABSCQNk1xZipozCShLQlx8yLlYgeLJ1YwZ5ujQHIy3CdyN9S0x0PtBPjrLH
         /tjVtgrMxRVymFRtSqOnD3mPLXkAWzitVB8WRmvubT8gX1tA7mnr6fguzXbdHi6VM4Ln
         4eug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6FTdyxXDyRNWNKUIC2l8l3tftf8jJbcicbeOU9cdsjQ=;
        fh=8flLdicEROyWKwUyQTFUJC0zGQot6CuPWOp8aPuasg8=;
        b=lZGsXWKGWQZMzgk3ri++xjWt7+6DSWQDzqn+4+GQHSDHPfXOe0+BhWK6VSLJDycv3f
         N8Uy4fAn7aTCdxw8F04soutM1PfVnRMKPiHtNm4C+S19rPZp0FHDFnpK2nx/Ljqr/tv6
         aYl9QUfY7po6qmd1d2EsO9wfjbNa/c303XO7ah8M+Qbnci7c9wKQ7SDOntttMtMgjGjH
         I5HA2L0dVmLphkZUVO6nkJwc4+/Mkrbzn8vUZh58RlKYKWUATVNlA1QBu4KAqgtw7iCr
         hPqB6kojyW+leLSFpbLZL3CN7gOFjI0I+BUyV5+YWwyJenp6pCecEz7G603A+rbW1MI9
         Htnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771625786; x=1772230586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FTdyxXDyRNWNKUIC2l8l3tftf8jJbcicbeOU9cdsjQ=;
        b=Bme1k1jC2cFEcSNQxgaL9wQHB7SvEZ/gabSWPoX6xzBCzNnNAoDHxMFzNkqxoGd5xg
         IC7cXkvJYE5GUrxifnj712uMQk7EhVg+Gvc+dEDpdX1i2+c4ZSvCzN8yD+CyU/qY5kKG
         XuCGmKshY1ecwBV+TSr97U/Y93qorzP5MXpN0dlePVzLcwx1Wi+4biRnnnhg4r9rKAV5
         5MEMf+bHYwZbltfFcC+HL4u2JjoeVGTv1TYuUBN5TsXjxy/VkSQ/tDKWE4E826dtMeaI
         vUINoNH5r0MoTSDxJOinvodgbGlyehDpU4q/1S5wfwlC7m4m5jnOrGhycBNTXFyQGB52
         XeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771625786; x=1772230586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6FTdyxXDyRNWNKUIC2l8l3tftf8jJbcicbeOU9cdsjQ=;
        b=d1OJ5gdduMBrYA2431KCCxvfb/NKli2dlcrjOLjkkvWJKKEG6qhrsI5BhBniDgeaoH
         qbGY+/tHGHqJTfDZ8J48Ds1RvIm7Lg5fpbRfLvkx/WbYyf1pA1R24djz7pQ+zZXjxIuS
         fcWnBHja5ldh4CcBZNlIue2ug9qyfF2GggoPhYpcLhynBMKQQMwb2OzTjEYBm7QXoMUY
         Qltu09EDWOljVth+NJSMDr0OeuMSurIOyBCGNUDTmmF/UEVDnfxXVyDPagkl8m3e+5vw
         JmHNQP14v9XqwYDCmOqCBHw5+axX/nZ693UttKYDfKAlmVlt6a58ryXyAM7RbuA7TjA0
         8Z4g==
X-Forwarded-Encrypted: i=1; AJvYcCVv1xlhJcoI0TM5aFY40/yWJS6avxqwJ/Hr+rR8WkAVgMqgK7r5PJFpvs3R3F6Lm7GaYHVf/rN5@vger.kernel.org
X-Gm-Message-State: AOJu0YzatpcM6KjVcKdyDJnx9oKe2Nuey6JI6MoU5sCwf5pZutqszWpg
	WU06pjjHQ/F+n/Adr1KT0z2cqELvG7S5dNz36KE2liNvT7aqT84yLhTTZQYP8yuegEGBIouuYeF
	hJ2BkCJm8Zw8gtsB2k2V4RXnfpkI7E4mhFUC1Edsc
X-Gm-Gg: AZuq6aIwqvOB9Ia9aplycAOs02kBgDsIt9V/ibxY9LGyAG2S3dleiAL9uPA39mrpJG4
	3FvmZwBn4o+r28u8Tr7GKlogObOxQ4gTyMELfa0KZF/Y+Xb0zf1w9TO2uCn1qQ9k/J4O18vLAmX
	p886IQe/DlwAcSgVnSTdt+PjSjYFkZXH4Txxtz3ZJFeB0KZOUaaaQb+0hrDp+3eQgCz5Mmj7AOE
	Cl0d6ojkEDgRcZ4gg2sES5TCmYDMBMROvWlg3yTW2AxuglVzFU6YyG6ERmIVEFGsoGPh7NRGjbH
	3fuK1Tw=
X-Received: by 2002:a17:90b:3809:b0:356:1edc:b38 with SMTP id
 98e67ed59e1d1-358ae8c0f04mr1044426a91.24.1771625785809; Fri, 20 Feb 2026
 14:16:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216150625.793013-1-omosnace@redhat.com> <20260216150625.793013-3-omosnace@redhat.com>
In-Reply-To: <20260216150625.793013-3-omosnace@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Feb 2026 17:16:14 -0500
X-Gm-Features: AaiRm50rzPOdaKhOCRDQhwiojB-mAL3ILUNVZIdIhAPsr9Z69VQz2AhP1HaIvAk
Message-ID: <CAHC9VhQU3aMHYdvp_Af88iBVdiOzZv2gWjFABUpvCxF37YJBPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fanotify: call fanotify_events_supported() before
 path_permission() and security_path_notify()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 10:14=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
>
> The latter trigger LSM (e.g. SELinux) checks, which will log a denial
> when permission is denied, so it's better to do them after validity
> checks to avoid logging a denial when the operation would fail anyway.
>
> Fixes: 0b3b094ac9a7 ("fanotify: Disallow permission events for proc files=
ystem")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

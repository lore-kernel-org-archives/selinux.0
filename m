Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FE73D47C8
	for <selinux@vger.kernel.org>; Tue,  5 May 2026 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778011351; cv=none; b=remWba1hq0s7QXrdfGjLdtCzgBYtvhNmXEHCjzNpXf/KHoiTGGhDKzCtV9HxqcPc7hcolqhEBSv4LjpccDgk6eb6eYvntjJPWe5nLBzwfBAcrblDkheFLAQwXefxSb2c0kQBitSd7JYIXmfBvXkMYoK4mHJadY4zPpa4ObHKzK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778011351; c=relaxed/simple;
	bh=itSFj15oMxLJEelBV8BVlSD4q+F9kROe9tB9SVFeed0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=bJw9ilpyEbRXJ2qQywm+Uw8HUPZb87jLBpEykJ2bhSyWNwAUQc+ynIUBysztHaNX8viUey1RMH9kHD36pRIIo2k/aKvOk9zSjChTQX8H8uFidkqxhQSudr6/j42GzNaZJ9pGaFgUiTHeBEi7Qpi1P+/iK5Jz4BYh3eOmLxQuVas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d/MxL+f0; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d/MxL+f0"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8eb5ad01402so607120385a.2
        for <selinux@vger.kernel.org>; Tue, 05 May 2026 13:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778011348; x=1778616148; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y0G46z5blipYxWXvaQYHh0vaEQ9A1szOWSaItumFLC8=;
        b=d/MxL+f0X3Q20RawlZuTo8ryrK86xi6vfI5PusMN6tyZk8h9LWCh1UHdVgBvgOGJO2
         BTf9Z9L+ZR7gripfa6sdIb+KA0sYU/X/cFlZ4xh6mzBESOa8SV2mcrwcLDKZDR/9zku9
         BbcEMGnNcuAF0fJuOmRe0+6c7fMUn8PkEiMhkTXiVksC/ofVk3muG2+zx8Y3WqmtUsSd
         lINIUQ0zDzoc+qLlbJonm/yZ48np0f1P7d3i5AOsl/nSKdFNQcu3n+7rDftI+BaVHQN/
         KuE3xmpfjzb/mQVLuCxWkhUpPHwp3YFDzmpGmDKkjvGDzb3cYTzmVcJyaRV5W1rcaY8/
         furw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778011348; x=1778616148;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0G46z5blipYxWXvaQYHh0vaEQ9A1szOWSaItumFLC8=;
        b=nUlBHNsTiCAH6YuIee8Zahr5JFFLcZb7kCkdYeTVErP001w/syXlKoFtW5w6L847PN
         /hg2jiEu1zkfXduZzpCE42lQQ2trzU6QJUmFmqR0DPzmwM1tUpABXUE3WAe3PzuJp51v
         BeGgMj6PO0yptZG8fOE8BJuZlUlTslo4cca1qwLkx+nc0bglxtpnFzU+LAh7RBu4sIUx
         2ArIUkMYrgJFJMMPZHi+xHrGOHYIBDrDToq8qG/m6wMGbuaHeUpx+Yi0DXkAsV5092kv
         c3oGZh9sNwMi5Tu4/f2BAE4UcX24ySu1p4usd8caiTlNxGjCMGijQRgVpTVPDBh3OBX8
         7T/A==
X-Forwarded-Encrypted: i=1; AFNElJ8TgebWEw8du6GxrMYZU3lHdNwfx6MHE9BoWifEFDmX279LOVcaKw5oQ9kk5KWG0dKCrEWb75yQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwYUt9q1P05V7TgoVqvw/4YbhY8uzliHBXBwls5QjG+Ehg424mX
	q8Ao6mZEJndQQKcgrSPqMGq2Xka3i2SwIgFpzUxytB2XhqFPTRYlC+pLLTWIi1Gn8w==
X-Gm-Gg: AeBDietPPutf8FZmUWFEfbHAmY6ybj83xZnGYOYWkOMz3r9klT4UW3eUPJ4O+J5UeyN
	lUuXtaOcJzy7YFFWrvVYCYoPKjrgfNTjor+KQAj9IDIJEoBZWj4jhFI0IYBwaWLSECY4/u0WL6Z
	iGz+TpNYUxGmweLixFnJLxS0Waq2krzj4Nulpk2dzzxSnNcQUA9xSkQCh+46bV1ZoZSDiUX35Nv
	8xF+GlSv/EeS6uC+VniKVVnlod7yAD830kSoNqZUMdKYoVjgEbj0CC7Y+VdOTNBA59bHbbGmqlL
	YuxZOcQEYPNEV2Zn8B2qrQEUxtRiPlRQ2PCsjlkj8onC5QeQPBYqAoRt0E+IQIE2/riIIXkiIxE
	QlxDgUlJL8v6xgXZBiPMBax7GzDQfVJJxmJfC0v3FcZ0w0vxBQmTZUv9XPyhBixJUzo3yxMYdvc
	wGfvMih6ocBem9VIQVsYZJm4MiAdpIkCN7YOHhIop8l/UUkoT9yRFmyUVX+NYj332tlQKAYnIsh
	MgxA64=
X-Received: by 2002:a05:620a:448e:b0:8cd:871c:909d with SMTP id af79cd13be357-904d69e05d9mr71371285a.53.1778011348297;
        Tue, 05 May 2026 13:02:28 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91b976sm1467299785a.39.2026.05.05.13.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 13:02:27 -0700 (PDT)
Date: Tue, 05 May 2026 16:02:26 -0400
Message-ID: <2672ea044ccf55dd8b16e8886065d8c4@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260504_2038/pstg-lib:20260505_1547/pstg-pwork:20260504_2038
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v2] selinux: shrink critical section in sel_write_load()
References: <20260430183651.1707-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260430183651.1707-2-stephen.smalley.work@gmail.com>

On Apr 30, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Currently sel_write_load() takes the policy mutex earlier than
> necessary. Move the taking of the mutex later. This avoids
> holding it unnecessarily across the vmalloc() and copy_from_user()
> of the policy data.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 moves the taking of the policy mutex just before
> security_load_policy() is called. This is required by
> security_load_policy() to protect the old policy during
> its own operation and until the new policy is committed.
> There is already a lockdep_is_held() check for this 
> inside of security_load_policy(). v2 also simplifies and
> unifies the error paths, at a cost of not releasing the
> policy mutex until after the audit message is logged.
> 
>  security/selinux/selinuxfs.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)

Merged into selinux/stable-7.1, thanks.

--
paul-moore.com

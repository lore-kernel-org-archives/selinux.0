Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A2C3C061E
	for <selinux@vger.kernel.org>; Wed, 27 May 2026 23:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925358; cv=none; b=DAiu6p1bbXY1s1Js88qYU4Bw8rzjk7RRJxEUKhSvHJuHoaBBa2QrdC8Ykgd+4XUOt+TqBxcvU8l8e9uBWbnhA+id86r7GDIlUgdNywfrPbTmPWW5Eg4gHYr2BMaWVUVZj41TpwmPQiBLyJTfFPbFc8ThQW/5Iy4K4qrSeP9n48g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925358; c=relaxed/simple;
	bh=+5VIL+Lx+4gWaHoEtMRjLIDQqQ755A0ekMnhYaccrBw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Hp9WAs5jPxhPOqlTvpSoLBsQyw+L+nJNLU8C3ShsaAoQsM1S8cMhROrqEx/a1XOv/eO6QKmfdVbBpmhJ/yhKxwUYuvPD34rRUiXIFw2Go7ESWkIjKDhaoTUTuJ7lgvdMHMm64wHihkjVpG4lWohYjIWUAsJZpeYcJoK7YOpgIQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TjIdmBUU; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TjIdmBUU"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-8bb4e8a5240so155698366d6.1
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 16:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779925356; x=1780530156; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HU5mpIp08+v7UC4VxJJIUTVB47HlzTm6rBp+W/xs8cI=;
        b=TjIdmBUUR/kAmZij2ZUYDg+zXYadCf+EXj8LEjiiCFnAXXNgk1x0rFvrtVNZqEiQDg
         BoAgYEUB2MsFzam5uOpYwlBEJ4+GhN09t7aJKrvYWnFdasdzrWIV3wmaQ7HbwhX2Wn3h
         CITwBj2foOwxKhItnLqydT3qQIMMMI0PNpK2NQgEdbD7cz25lHB57yDV1uHwK4DYeY1M
         c6uRNb61qjne6opSn4+LhNvm3n9SeUkvHmwknMtuBcbFnDaWANh3xYg7yYknBkQlXWeF
         k2odnW6JC1gXDjY8hMK8FXmNU7XpIT/7gnPM2ZLRMhehCKd41P2hKl7UaGDK+BGjY3Oh
         hVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779925356; x=1780530156;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HU5mpIp08+v7UC4VxJJIUTVB47HlzTm6rBp+W/xs8cI=;
        b=HuihykzyDNrEotSIX5ueEsRNBF9mQapuMlS818vcz7VHqiGmidp9k+7gnz2so3sWVl
         05wBnrgHNsqJ3gEC2a9h1MkV3PhYcyAP0rP3SaFCbBGpbaj16WPLUf6vFbxVuDyRiosj
         H3+26oeSezdUUGp7IzoO/QUu1/3E5I6XCsNmKZubxmTtbgb/zPM/C9mxgg5FQs/2F2oZ
         MS+O6nnkhUhpIwTwy8CIwXVdBdkeohqdxsTa2O9t01mak4xKbsMgwbchCMad55S8cdpl
         HTnIx/4gKKiuVtInyh7X8YGGrxXXmNxSrGgvZKjKK30dc2NCO69JS+E1NVPJF6/EGpq4
         Gw2A==
X-Forwarded-Encrypted: i=1; AFNElJ+zYmbjpCwgYs32WfwPRiod7uwLnW0JqHxDGImpqQUgjLaIvpTWHR7TRkB8GWS3HfiHNPCPu+2g@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0LGPmnf2Emin42+tUvpZ8q7xNTPz5mD+nZlUEsJPcXnWelgRN
	bNtm4/9vxrTxSfec84Ji8bBSPEAV+G/JIvTrQ0tIPAgYVFTJLuRv7m3Gdy5f5AEWXA==
X-Gm-Gg: Acq92OEa4X50BL59HadcKpzunSWmjbxkbyC2OI0lb1vxVMnfc4Tm8HMNmXS+YaJSu8j
	azW/AVwPFZpxRiFGnNHNGzCXTKw5y5gIiirCi6ZV9eVQstHpot3FdNkcjfZgYErM5dZCcNQP8V1
	B9GfipASU/noFsC5TfyN3ctmafCIWw7BG7zxOaWy4+Ep0LfovERh4uuC0NHDTypES1wRxIpN+s9
	wryN1fyDirBuHB6GjUnwJV9S99Z3/dQnWZVTkTlQvV9CYGiswclndw9FJqTnm2/dzmmh+tfOc5o
	NK06K8CRdSxXuce6otBqvJirjYcR3Q1enXzPhqanJMdVOD7SuWXp+k5mI/zFEWBmQa6Lm4JdO5I
	TTAkNupJjstUQf2kd1s8cpKSMTKq59dXTlco61OMw3hJT7sFztBMc22OC6EvnD45lSjFJGwCMkf
	LNf8F45U6f+79evG4Y5srQMyZvh6RhBLBlWdufP4nOys86hIBfE7XySczp2PV0ZIG3jpurLKdIl
	TnBtZo=
X-Received: by 2002:a05:6214:3bc7:b0:8cc:15e4:1208 with SMTP id 6a1803df08f44-8cc7b65aa0dmr409956706d6.32.1779925356424;
        Wed, 27 May 2026 16:42:36 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80ffca70sm181789696d6.22.2026.05.27.16.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 16:42:35 -0700 (PDT)
Date: Wed, 27 May 2026 19:42:35 -0400
Message-ID: <4aac8924f51f66daa69acd50d8b89f3a@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260527_1931/pstg-lib:20260527_1608/pstg-pwork:20260527_1931
From: Paul Moore <paul@paul-moore.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, James Morris <jmorris@namei.org>, John Johansen <john.johansen@canonical.com>, Ondrej Mosnacek <omosnace@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>, apparmor@lists.ubuntu.com, selinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/3] selinux: hooks: use __getname() to allocate path  buffer
References: <20260520-security-v1-2-831bd8e21dd0@kernel.org>
In-Reply-To: <20260520-security-v1-2-831bd8e21dd0@kernel.org>

On May 20, 2026 "Mike Rapoport (Microsoft)" <rppt@kernel.org> wrote:
> 
> selinux_genfs_get_sid() allocates memory for a path with __get_free_page()
> although there is a dedicated helper for allocation of file paths:
> __getname().
> 
> Replace __get_free_page() for allocation of a path buffer with __getname().
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  security/selinux/hooks.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/dev, thanks.

--
paul-moore.com

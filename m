Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575912206B7
	for <selinux@vger.kernel.org>; Thu, 19 Jun 2025 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750368186; cv=none; b=tsVXYQ274Wh4H6ybvW2BgApJyU0XP51b0fib+xaVdrQnfilwG8tAFWeXNSPePGPB30JHdBrLTTJny63paMJimoVxWUrSOH4kMGL9iwyhsyXv0+0nawAhnPPX+Rg+1E/5Km3rRBcydTMWjsG8XpewGOyYRIe6btzunDUfW1GqENA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750368186; c=relaxed/simple;
	bh=yD6bAV8aFY7IcqMfUqlGW5p97MpW2tF44tmreXCONn8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Fn8pt2mMtxEDWzmy2QFcd2T/TFHGuho0E4EYJDesfvjpzW91jBwoh/+dN2zgHSklc5NvsINvUDShJXph/r9QaqpUkRM8oAB9/0Si3ku1GUzocha7PRU4QbMNz25qxjSZXJTa45+VhLX7Gu1VmQLglssxLgY8E8AuculZiaXX9Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E03QV7ul; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E03QV7ul"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6facf4d8e9eso13707396d6.1
        for <selinux@vger.kernel.org>; Thu, 19 Jun 2025 14:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750368184; x=1750972984; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7vxAjpjJMuKiLo+dSQ/1t+nkICZiy96IvMV7PxyXD0=;
        b=E03QV7ul/QhOH1eH2ljKhnrGjMgnbCaRPM1Yk7p4J9+G6C9MC4e7iYSfw3FXK70xle
         QR0tal8yK1iObOmET1OgOJ8sx8pwCYKKrl/bjPZhLV97EbRi9fL3hTsHPFWldbweBzB6
         NEGAEytTYr1pbzKFmqz6D00hPmuQS3bRGCIV+OD8IUQs+eo7HmWxezv537Ldg9Anb+Z9
         PwX9d3IpdWFHa9T+VfYTzjA5XW9kKN5pqDgHCjBAXyaU85vac/jbJOINoOEaSC30U31K
         GfAEzz4ES+3hpXR7wZLFGK/XgBEGFgB63T02ZgxTK8JKgrnIN8eeWGuIr2NXhhBmImSf
         qAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750368184; x=1750972984;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m7vxAjpjJMuKiLo+dSQ/1t+nkICZiy96IvMV7PxyXD0=;
        b=dIuXI2xIcojAJWd8h6ebgG3+DVjDk2dlRITJVeJXR/npGQW9CTLSyIEgZXwzAeey2x
         NCwXHGM5pg3zkVrQ97KWw9IXl2mRunzVWTbcxJFexYN7789yQLS5wzMYRbMce1ddtCUb
         URDjfMdbqzdpeyTLw6kYLpvd2M6YqhfOglXrxM0EdIH4llHiZf0122BPFSzf7sciGaQX
         FUrOkVssF2li9r6B6PZp0tCY1UvD62mJAJyXS5i3VFJbqsHOR0mFOujzfj/i1issxnF7
         O05eOfkCg7bAijt1vHTbORcy+u5FEXxDMWywFHvK4q/oQiDyqHtwT4futtlFyYOJXuYj
         Uz3g==
X-Forwarded-Encrypted: i=1; AJvYcCWe60ajUJiGUjvsuZ8d0QXwqgmCjsBjtN1QGQ+a0Je3YCqjApXsNpfhRnTxkX5XcFDi+v0v4E+x@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/T9gLQgMIW0RRcUGbR8CpZJ1hz+0J7NA8ZH0bVnyuhfbNzbrV
	WGvADcpKWcIc/LZNiKCtDtz8Vxf1+/fAHzEEFdkZ9edg3491SbVjLxY+ml2ud4DNsg==
X-Gm-Gg: ASbGnctKdpUjWAah93wKGjoNZiX4B9Q0JvSbstLqFOYIfIOJ0vb3YHEOUxwLmoVDw90
	NRr1GAHgocUCTjbVXUuY3jKcIdS44g2gIHJtbzldSXaaUuF8APw66fRa7XP2dptmdynzzrAfxSG
	sMeuTFrPrV8bLY/cOdu3WpMzA5t3x83Kmv3NVjwZj8mge67/DvUf4OSwEYniJc6gpXIqjhm0DAu
	DnHH++yd+xWMvkQy9i8k6Wgyvo4mt3LsvC3Kc8aymZpuI6mS/f0Nv6M5PyntD8QmHTwzY+GDsCz
	DepcX0v3WyOdtafMIr5QCM7nLeO7L0FrCRRDEwXDbt31LUrf17BP6HWL/ZGwcE2BroxQozKUbrW
	ahu1humK/MF0vek8kpIAJ1BPegoyk+X0=
X-Google-Smtp-Source: AGHT+IECcjQI1aOIsoDV6g0dcIRIq+l45Xwd/mi9/iNQcu8DO4crJUSQf4F7yztxPHwFNX63JmM1Sw==
X-Received: by 2002:a05:6214:328e:b0:6fa:fc22:52eb with SMTP id 6a1803df08f44-6fd0a5e3476mr11211386d6.37.1750368184167;
        Thu, 19 Jun 2025 14:23:04 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fd095c7fe4sm4314486d6.121.2025.06.19.14.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 14:23:03 -0700 (PDT)
Date: Thu, 19 Jun 2025 17:23:03 -0400
Message-ID: <b670321e362092044b87d8899dc9e9de@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250619_1608/pstg-lib:20250618_2237/pstg-pwork:20250619_1608
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: optimize  selinux_inode_getattr/permission() based on neveraudit|permissive
References: <20250521144123.199370-4-stephen.smalley.work@gmail.com>
In-Reply-To: <20250521144123.199370-4-stephen.smalley.work@gmail.com>

On May 21, 2025 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Extend the task avdcache to also cache whether the task SID is both
> permissive and neveraudit, and return immediately if so in both
> selinux_inode_getattr() and selinux_inode_permission().
> 
> The same approach could be applied to many of the hook functions
> although the avdcache would need to be updated for more than directory
> search checks in order for this optimization to be beneficial for checks
> on objects other than directories.
> 
> To test, apply https://github.com/SELinuxProject/selinux/pull/473 to
> your selinux userspace, build and install libsepol, and use the following
> CIL policy module:
> $ cat neverauditpermissive.cil
> (typeneveraudit unconfined_t)
> (typepermissive unconfined_t)
> 
> Without this module inserted, running the following commands:
>    perf record make -jN # on an already built allmodconfig tree
>    perf report --sort=symbol,dso
> yields the following percentages (only showing __d_lookup_rcu for
> reference and only showing relevant SELinux functions):
>    1.65%  [k] __d_lookup_rcu
>    0.53%  [k] selinux_inode_permission
>    0.40%  [k] selinux_inode_getattr
>    0.15%  [k] avc_lookup
>    0.05%  [k] avc_has_perm
>    0.05%  [k] avc_has_perm_noaudit
>    0.02%  [k] avc_policy_seqno
>    0.02%  [k] selinux_file_permission
>    0.01%  [k] selinux_inode_alloc_security
>    0.01%  [k] selinux_file_alloc_security
> for a total of 1.24% for SELinux compared to 1.65% for
> __d_lookup_rcu().
> 
> After running the following command to insert this module:
>    semodule -i neverauditpermissive.cil
> and then re-running the same perf commands from above yields
> the following non-zero percentages:
>    1.74%  [k] __d_lookup_rcu
>    0.31%  [k] selinux_inode_permission
>    0.03%  [k] selinux_inode_getattr
>    0.03%  [k] avc_policy_seqno
>    0.01%  [k] avc_lookup
>    0.01%  [k] selinux_file_permission
>    0.01%  [k] selinux_file_open
> for a total of 0.40% for SELinux compared to 1.74% for
> __d_lookup_rcu().
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 introduces a task_avdcache_permnoaudit() static inline function.
> 
>  security/selinux/hooks.c          | 14 +++++++++++++-
>  security/selinux/include/objsec.h |  8 ++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)

Merged into selinux/dev, thanks.

--
paul-moore.com
